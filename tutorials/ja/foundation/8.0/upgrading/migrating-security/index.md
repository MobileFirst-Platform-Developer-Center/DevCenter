---
layout: tutorial
title: 認証およびセキュリティーのマイグレーションの概念
breadcrumb_title: 認証のマイグレーションの概念
downloads:
  - name: マイグレーション・サンプルのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
weight: 3
---
## 概説
{: #overview }
セキュリティー開発およびセキュリティー管理のタスクを改善し簡素化するため、バージョン 8.0 では {{ site.data.keys.product_full }} のセキュリティー・フレームワークに大きな変更がいくつか加えられました。特に、セキュリティー・ビルディング・ブロックが変更されていて、8.0 では、OAuth のセキュリティー・スコープとセキュリティー検査が、以前のバージョンのセキュリティー・テスト、セキュリティー・レルム、およびセキュリティー・ログイン・モジュールに取って代わっています。

このチュートリアルには、アプリケーションのセキュリティー・コードをマイグレーションするのに必要な手順が示されています。開始点として 7.1 のサンプル・アプリケーションを使用し、この 7.1 のサンプル・アプリケーションを、同じセキュリティー保護が適用された 8.0 アプリケーションとするまでの完全なプロセスを説明します。7.1 サンプル・アプリケーションと、マイグレーション後のアプリケーションの両方が添付されています。

以降で説明するマイグレーション手順は、次のとおりです。
*	8.0 へのリソース・アダプターのマイグレーションと、リソース保護の維持
*	クライアント・アプリケーションのマイグレーション
*	7.1 アプリケーションの認証レルムに代わるセキュリティー検査の作成
*	新しいチャレンジ・ハンドラー API が使用されるようにするためのクライアント・サイドのチャレンジ・ハンドラーの変更

このチュートリアルの [2 番目のパート](#migrating-other-types-of-authentication-realms)では、サンプル・アプリケーションのマイグレーションには示されていない、次のようなマイグレーション関連のその他の問題への対処を行います。
*	サンプルに示されているフォーム・ベースの認証とアダプター・ベースの認証以外の、他のタイプの許可レルムのマイグレーション
*	アクセス・トークンの有効期限
*	アプリケーション・レベルの保護 (アプリケーション・セキュリティー・テスト)
*	8.0 の簡素化されたセキュリティー・モデルで不要となった、7.1 のセキュリティー構成設定 (ユーザー ID レルムや、デバイス ID レルムなど)

> マイグレーションを開始する前に、[マイグレーションの手引き](../migration-cookbook)をひととおり検討することを推奨します。また、[認証とセキュリティーのチュートリアル](../../authentication-and-security)を参照して、新しいセキュリティー・フレームワークの基本概念についても学んでください。

## サンプル・アプリケーション
{: #the-sample-application }
サンプルの 7.1 ハイブリッド・アプリケーションを開始点とします。このアプリケーションは、OAuth で保護された Java アダプターにアクセスします。このアダプターには 2 つのメソッドが使用されています。1 つは、`getBalance` メソッドで、これはフォーム・ベースの認証レルム (ユーザー名とパスワードによるログイン) で保護されています。もう 1 つは、`transferMoney` メソッドで、これはアダプター・ベースの認証レルムで保護されており、ユーザーに PIN コードの入力を要求します。7.1 サンプル・アプリケーションのソース・コードと、8.0 にマイグレーションした後の同アプリケーションのソース・コードを、[ダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample)できます。

## リソース・アダプターのマイグレーション
{: #migrating-the-resource-adapter }
まずはリソース・アダプターから、マイグレーション・プロセスを開始します。アダプターがプロジェクトの一部であった 7.1 とは異なり、{{ site.data.keys.product }} 8.0 では、アダプターを個別の Maven プロジェクトとして開発します。つまり、クライアント・アプリケーションとは独立して、リソース・アダプターをマイグレーションしたり、ビルドしてデプロイしたりすることができます。同じことが、クライアント・アプリケーションそのものと、セキュリティー検査 (これも実際にはアダプターとしてデプロイされる) についても当てはまります。これにより、ユーザーは任意の順序でこれらの部品をマイグレーションできます。このチュートリアルでは、リソースを保護する OAuth セキュリティー・スコープ・エレメントを導入できるように、まず最初にリソース・アダプターをマイグレーションします。

これからリソース・アダプター `AccountAdapter` をマイグレーションしますが、もう 1 つのアダプターである、アダプター・ベースの認証に使用される `PinCodeAdapter` はマイグレーションの必要がないことに注意してください。これは、8.0 でアダプター・ベースの認証がサポートされなくなったためです。以降の手順の 1 つで、このアダプターを {{ site.data.keys.product }} 8.0 セキュリティー検査に置き換えます。

> 8.0 へのアダプターのマイグレーション手順については、[マイグレーションの手引き](../migration-cookbook)を参照してください。

7.1 サンプル内の `AccountAdpter` のメソッドは、既に`@OAuthSecurity` アノテーションによって保護されています。8.0 でも同じアノテーションを使用します。唯一の違いは、7.1 ではスコープ・エレメント `UserLoginRealm` および `PinCodeRealm` は、authenticationConfig.xml ファイルに定義されているセキュリティー・レルムを参照します。これに対し 8.0 では、スコープ・エレメントはサーバーにデプロイされたセキュリティー検査にマップされます。同じスコープ・エレメント名を使用して、コードを変更せずにそのままにすることもできますが、MFP 8.0で「レルム」という用語はもう使用されないため、ここでは次のようにスコープ・エレメントを `UserLogin` および `PinCode` に名前変更しましょう 。

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

### ユーザー IDを取得するための新規 API の使用
{: #use-the-new-api-for-getting-the-user-identity }
サンプルのリソース・アダプターは、サーバー・サイド・セキュリティー API を使用して認証ユーザーの ID を取得します。この API は 8.0 で変更されています。そのため、修正が必要です。7.1 の以下のコードを置き換えます。

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

上記を、以下の、8.0 の新規 API に置き換えます。

```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```

Maven か {{ site.data.keys.mf_cli }} のいずれかを使用して、[アダプターをビルドし、これをサーバーにデプロイします](../../adapters/creating-adapters/#build-and-deploy-adapters)。

## クライアント・アプリケーションのマイグレーション
{: #migrating-the-client-application }
次は、クライアント・アプリケーションのマイグレーションです。クライアント・アプリケーションのマイグレーション手順については、マイグレーションの手引きを参照してください。
現時点では、チャレンジ・ハンドラーのコードをコメント化しておきます。これらのチャレンジ・ハンドラーは、後で修正します。アプリケーションのメイン HTML ファイルである index.html の、チャレンジ・ハンドラー・コードのインポートを実行するための行の周囲に、コメント行を置きます。

```html
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

### ログアウト用の新規クライアント API への変更
{: #change-to-the-new-client-api-for-logout }
クライアント・マイグレーションの一部として、MobileFirst 8.0 のクライアント・サイド API の変更に対処する必要があります。クライアント API の変更のリストについては、[WebView のアップグレード](../migrating-client-applications/cordova/#upgrading-the-webview)を参照してください。
サンプル・アプリケーションには、セキュリティーに関連したクライアント API の変更が 1 つ含まれています。それはログアウト用の API です。7.1 のメソッド `WL.Client.logout` は、8.0 ではサポートされていません。代わりに、`WLAuthorizationManager.logout` を使用して、7.1 の認証レルムに代わるセキュリティー検査の名前を渡します。
サンプル・アプリケーションの「ログアウト」ボタンは、次のように、`UserLogin` セキュリティー検査および `PinCode` セキュリティー検査の両方からユーザーをログアウトさせます。

```javascript
function logout() {
    WLAuthorizationManager.logout('UserLogin').then(
        function () {
            WLAuthorizationManager.logout('PinCode').then(function () {
                $("#ResponseDiv").html("Logged out");
            }, function (error) {
                WL.Logger.debug("failure on logout from PinCode check: " +
                    JSON.stringify(error));
            });
      },
      function (error) {
          WL.Logger.debug("failure on logout from UserLogin check: " +
              JSON.stringify(error));
      });
}
```

アプリケーションのマイグレーション手順が終わったら、アプリケーションをビルドし、コマンド `mfpdev app register` を使用してアプリケーションを {{ site.data.keys.mf_server }} に登録します。これで、{{ site.data.keys.mf_console }} にアプリケーションがリストされるはずです。

## フォーム・ベースの認証レルムのマイグレーション
{: #migrating-the-form-based-authentication-realm }
この段階では、既にクライアント・アプリケーションとリソース・アダプターのマイグレーションとデプロイが済んでいます。ただし、この時点でアプリケーションの実行を試行しても、アプリケーションがリソースにアクセスできません。これは、リソース・アダプター・メソッド (「UserLogin」または「PinCode」) が要求するスコープ・エレメントを含んだアクセス・トークンをアプリケーションが提示することが予期されているが、ユーザーがまだセキュリティー検査を作成していないため、アプリケーションがアクセス・トークンを取得できず、アプリケーションが保護リソースへのアクセスを許可されていないためです。

それではここで、7.1 のフォーム・ベースの認証レルム「UserLoginRealm」に代わる、8.0 の「UserLogin」という名前のセキュリティー検査を作成します。このセキュリティー検査が実行する認証手順は、以前にフォーム・ベースのオーセンティケーターとカスタム・ログイン・モジュールによって実装されていたものと同じです。つまり、チャレンジをクライアントに送信し、チャレンジ応答から資格情報を収集し、資格情報を検証して、ユーザー ID を作成します。以下に示すように、セキュリティー検査の作成は極めて簡単であり、ユーザーが行うのは、資格情報を検証するためのコードを 7.1 のカスタム・ログイン・モジュールから新しいセキュリティー検査にコピーすることのみです。

セキュリティー検査はアダプターとして実装します。したがって、`UserLogin` という [新しい Java アダプターを作成する](../../adapters/creating-adapters)ところから始めます。

Java アダプターの作成時、デフォルト・テンプレートは、そのアダプターがリソースを提供すると想定します。同じアダプターをリソースの提供用とセキュリティー・テストのパッケージ化用の両方に使用できますが、この事例では、新規アダプターを単にセキュリティー検査用として使用します。そのため、デフォルトのリソース実装を除去するため、ファイル UserLoginApplication.java および UserLoginResource.java を削除します。また、adapter.xml から <JAXRSApplicationClass> エレメントも削除します。
Java アダプターの adapter.xml ファイルに、`securityCheckDefinition` という XML エレメントを追加します。以下に例を示します。

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* name 属性は、セキュリティー検査の名前です。
* class 属性は、セキュリティー検査の実装 Java クラスを指定します。次のステップでこのクラスを作成します。
* successStateExpirationSec プロパティーは、7.1 ログイン・モジュールの expirationInSeconds プロパティーと等価です。これは、このセキュリティー検査への正常なログインが保持される時間間隔 (秒) です。これらのプロパティーのデフォルト値は、7.1 と 8.0 のどちらも 3600 秒です。7.1 ログイン・モジュールが別の値で構成されていた場合は、ここに同じ値を入力しなければなりません。

このチュートリアルの目的上、ここでは `successStateExpirationSec` プロパティーだけを定義します。実際には、[セキュリティー検査構成](../../authentication-and-security/creating-a-security-check/#security-check-configuration)で行えることは、もっとたくさんあります。特に、セキュリティー検査を構成することで、ブロック状態の有効期限、複数回試行、「記憶する」といった拡張機能を使用できます。カスタム構成プロパティーを追加し、その構成プロパティーを MFP コンソールからランタイムで変更できます。

### セキュリティー検査 Java クラスの作成
{: #creating-the-security-check-java-class }
`UserAuthenticationSecurityCheck` を拡張した `UserLogin` という名前の Java クラスを作成し、これをアダプターに追加します。次に、`createChallenge`、`validateCredentials`、および `createUser` という 3 つのメソッドのデフォルト実装をオーバーライドします。

* メソッド `validateCredentials` には、認証ロジックを記述します。認証ロジック・コード (ユーザー名とパスワードを検証するコード) を 7.1 ログイン・モジュールからコピーして、ここに入れます。この事例では、非常にシンプルなロジックであり、パスワードがユーザー名と同じであることをテストするだけです。
* メソッド `createChallenge` では、クライアントに送信されるチャレンジ・メッセージ (ハッシュ・マップ) を作成します。一般に、セキュリティー検査では、ここにチャレンジ・フレーズまたはその他の種類の、クライアントからの応答の検証に使用されるチャレンジ・オブジェクトを入れることができます。このセキュリティー検査ではチャレンジ・フレーズは必要ないため、チャレンジ・メッセージに入れる必要があるのはエラー・メッセージだけです (エラーが検出された場合)。
* `createUser` メソッドは、7.1 ログイン・モジュールの `createIdentity` メソッドと等価です。

クラス全体を以下に示します。

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null && credentials.containsKey("username") &&
		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the 7.1 login module
            if (!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;

                errorMsg = null;
                return true;
            } else {
                errorMsg = "Wrong Credentials";
            }
        } else {             
errorMsg = "Credentials not set properly";
        }
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg", errorMsg);
        return challenge;
    }

    @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
    }
}
```

Maven か {{ site.data.keys.mf_cli }} のいずれかを使用して、[アダプターをビルドし、これをサーバーにデプロイします](../../adapters/creating-adapters/#build-and-deploy-adapters)。{{ site.data.keys.mf_console }} のアダプター・リストに、新規アダプター UserLogin が表示されるはずです。

## PIN コード・レルムのマイグレーション
{: #migrating-the-pin-code-realm }
このサンプルの PIN コード・レルムは、8.0 ではサポートされなくなったアダプター・ベースの認証を使用して実装されています。このレルムを、新しいセキュリティー検査で置き換えます。

`PinCode` という名前の新しい Java アダプターを作成します。`CredentialsValidationSecurityCheck` を拡張した `PinCode` という名前の Java クラスを作成し、これをアダプターに追加します。ここでは、基本クラスとして `CredentialsValidationSecurityCheck` を使用することに注意してください。UserLogin セキュリティー検査の場合に使用した `UserAuthenticationSecurityCheck` ではありません。これは、PIN コード・セキュリティー検査で必要なのは資格情報 (PIN コード) の検証だけですが、ユーザー ID の割り当ては行わないからです。

`CredentialsValidationSecurityCheck` を拡張したセキュリティー検査を作成するには、`createChallenge` および `validateCredentials` という 2 つのメソッドを実装する必要があります。

`UserLogin` セキュリティー検査と同様、`PinCode` セキュリティー検査には、チャレンジの一部としてクライアントに送信する特殊情報は何もありません。`createChallenge` メソッドは、チャレンジ・メッセージ内にエラー・メッセージを入れるだけです (エラー・メッセージが存在する場合)。

```java
    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
```

`validateCredentials` メソッドは、PIN コードを検証します。この事例では、検証コードは 1 行のコードで構成されていますが、一般には、7.1 の認証アダプターから `validateCredentials` メソッドに検証コードをコピーできます。

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if (credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();
        if (pinCode.equals("1234")) {
            return true;
        } else {
            errorMsg = "Pin code is not valid.";
        }
    } else {             
errorMsg = "Pin code was not provided";
    }
    return false;
}
```

[アダプターをビルドし、これをサーバーにデプロイします。](../../adapters/creating-adapters/#build-and-deploy-adapters)

## チャレンジ・ハンドラーのマイグレーション
{: #migrating-the-challenge-handlers }
ゴールまであと少しです。クライアント・アプリケーションをマイグレーションし、リソース・アダプターと、リソースを保護するためのセキュリティー検査を準備しました。唯一欠落している部分は、クライアントがチャレンジに応答し、資格情報をセキュリティー検査に送信できるようにする、クライアント・サイドのチャレンジ・ハンドラーです。クライアント・アプリケーションをマイグレーションしたときに、チャレンジ・ハンドラーが含まれている行をコメント化したことを思い出してください。ようやくここで、それらの行のコメントを外し、チャレンジ・ハンドラーを 8.0 にマイグレーションします。

ユーザー・ログインのチャレンジ・ハンドラーから開始します。チャレンジ・ハンドラーは、7.1 の場合と同じ機能を 8.0 でも実行します。チャレンジ・ハンドラーの役割は、チャレンジを受信した時点でログイン・フォームをユーザーに提示し、ユーザー名とパスワードをサーバーに送信することです。ただし、チャレンジ・ハンドラー用のクライアント API が変更され簡素化されました。そのため、以下の変更を行う必要があります。

* チャレンジ・ハンドラーを作成するための呼び出しを、次のコードで置き換えます。

```javascript
var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
```

メソッド `createSecurityCheckChallengeHandler` は、{{ site.data.keys.product_adj }} セキュリティー検査によって送信されたチャレンジを処理するチャレンジ・ハンドラーを作成します。ほとんどの場合、7.1 クライアント API のメソッド `createWLChallengeHandler` またはメソッド`createChallengeHandler` のどちらの代替としても、このメソッドを使用すべきです。唯一の例外は、サード・パーティーのゲートウェイによって送信されたチャレンジを処理するように設計されたチャレンジ・ハンドラーです。このタイプのチャレンジ・ハンドラー (8.0 ではゲートウェイ・チャレンジ・ハンドラーと呼ばれる) は、メソッド  `WL.Client.createGatewayChallengeHandler() によって作成されます。例えば、カスタム・ログイン・フォームをクライアントに送信する DataPower のようなリバース・プロキシーによってリソースが保護されている場合は、ゲートウェイ・チャレンジ・ハンドラーを使用してチャレンジを処理する必要があります。ゲートウェイ・チャレンジ・ハンドラーについて詳しくは、記事[チャレンジ・ハンドラーのクイック・レビュー](https://mobilefirstplatform.ibmcloud.com/blog/2016/06/22/challenge-handlers/)を参照してください。

* メソッド `isCustomResponse` を削除します。これはもう、セキュリティー検査のチャレンジ・ハンドラー用として必要ありません。
* メソッド `handleChallenge` を、チャレンジ・ハンドラーが実装する必要のある 3 つのメソッド `handleChallenge()`、`handleSuccess()`、および `handleFailure` で置き換えます. 8.0 では、チャレンジに対する応答であるかどうかや、成功かエラーかを知るためにチャレンジ・ハンドラーが応答を検査する必要はなくなりました。フレームワークがそうしたことを担当し、適切なメソッドを呼び出します。
* `submitSuccess` の呼び出しを削除します。フレームワークが正常応答を自動的に処理します。
* `submitFailure` の呼び出しを、`userLoginChallengeHandler.cancel` で置き換えます。
* `submitLoginForm` の呼び出しを、次のコードで置き換えます。

```javascript
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
```

上記の変更を適用した後、チャレンジ・ハンドラーのコード全体は以下のようになります。

```javascript
function createUserLoginChallengeHandler() {
    var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    userLoginChallengeHandler.handleChallenge = function(challenge) {
        showLoginDiv();
        var statusMsg = (challenge.errorMsg !== null) ? challenge.errorMsg : "";
        $("#loginErrorMessage").html(statusMsg);
    };

    userLoginChallengeHandler.handleSuccess = function(data) {
        hideLoginDiv();
    };

    userLoginChallengeHandler.handleFailure = function(error) {
        if (error.failure !== null) {
            alert(error.failure);
        } else {
            alert("Failed to login.");
        }
    };

    $('#AuthSubmitButton').bind('click', function () {
        var username = $('#AuthUsername').val();
        var password = $('#AuthPassword').val();
        if (username === "" || password === "") {
            alert("Username and password are required");
            return;
        }

        userLoginChallengeHandler.submitChallengeAnswer(
            {'username':username, 'password':password});});

    $('#AuthCancelButton').bind('click', function () {
userLoginChallengeHandler.cancel();
        hideLoginDiv();
    });

    return userLoginChallengeHandler;
 }
```

PIN コードのチャレンジ・ハンドラーのマイグレーションは、ユーザー・ログインのチャレンジ・ハンドラーのマイグレーションと非常によく似ています。そのため、ここでは詳細を示しません。添付の 8.0 サンプル内にある、マイグレーション後のチャレンジ・ハンドラーのコードを参照してください。
これで、アプリケーションのマイグレーションは完了です。アプリケーションを再ビルドしてサーバーにデプロイし、正常に機能することをテストし、リソースへのアクセスが予期したとおりに保護されていることをテストできるようになりました。

## その他のタイプの認証レルムのマイグレーション
{: #migrating-other-types-of-authentication-realms }
ここまでのセクションでは、フォーム・ベースの認証レルムとアダプター・ベースの認証レルムをマイグレーションするためのプロセスを説明してきました。7.1 アプリケーションには、例えばアプリケーション・セキュリティー・テストに明示的に追加されたレルムや、`mobileSecurityTest` または `webSecurityTest` にデフォルトで組み込まれているレルムなど、ほかのタイプのレルムが組み込まれている可能性があります。 ほかのタイプのレルムを 8.0 にマイグレーションする際の以下のガイドラインを参照してください。

### アプリケーションの認証性
{: #application-authenticity }
アプリケーションの認証性は、8.0 では事前定義されたセキュリティー検査として提供されています。デフォルトでは、このセキュリティー検査は、{{ site.data.keys.mf_server }} へのアプリケーションのランタイムの登録時に実行されます。これは、アプリケーションのインスタンスが初めてサーバーに接続しようとしたときに行われます。ただし、すべての {{ site.data.keys.product_adj }} セキュリティー検査と同様に、この事前定義された検査をカスタム・セキュリティー・スコープに含めることもできます。

### LTPA レルム
{: #ltpa-realm }
事前定義された 8.0 のセキュリティー検査 `LtpaBasedSSO` を使用します。詳しくは、チュートリアル [IBM DataPower を使用した {{ site.data.keys.product_adj }} 8.0 アプリケーション・トラフィックの保護]({{ site.baseurl }}/blog/2016/06/17/datapower-integration/)を参照してください。

### デバイスのプロビジョニング
{: #device-provisioning }
7.1 のデバイス・プロビジョニングは、8.0 のクライアント登録プロセスに置き換えられています。{{ site.data.keys.product_adj }} 8.0 では、クライアント (アプリケーションのインスタンス) はサーバーへの初回アクセス試行時に自身を {{ site.data.keys.mf_server }} に登録します。登録の一部として、クライアントはその ID の認証に使用される公開鍵を提供します。この保護メカニズムは常に有効になっているため、ユーザーがデバイス・プロビジョニングのレルムを 8.0 にマイグレーションする必要はありません。

### クロスサイト・リクエスト・フォージェリー対策 (anti-XSRF) レルム
{: #anti-cross-site-request-forgery-anti-xsrf-realm }
anti-XSRF は、8.0 の OAuth ベースのセキュリティー・フレームワークにおいては、もう関連がありません。

### ダイレクト・アップデート・レルム
{: #direct-update-realm }
ダイレクト・アップデート・レルムを 8.0 にマイグレーションする必要はありません。ダイレクト・アップデート・フィーチャーは {{ site.data.keys.product_adj }} 8.0 でサポートされていますが、以前のバージョンで必要だったダイレクト・アップデート・レルムのようなセキュリティー検査は必要ありません。ただし、ダイレクト・アップデート・フィーチャーを使用した更新の配信手順が変更になっていることに注意してください。詳しくは、資料トピック[ダイレクト・アップデートのマイグレーション](../migrating-client-applications/cordova/#migrating-direct-update)を参照してください。

### リモート無効化レルム
{: #remote-disable-realm }
リモート無効化レルムを 8.0 にマイグレーションする必要はありません。{{ site.data.keys.product_adj }} 8.0 リモート無効化フィーチャーには、セキュリティー検査は必要ありません。

### カスタム・オーセンティケーターおよびログイン・モジュール
{: #custom-authenticators-and-login-modules }
上述の手順に従って新しいセキュリティー検査を作成します。基本クラスである `UserAuthenticationSecurityCheck` または `CredentialsValidationSecurityCheck` のいずれかを使用します。 オーセンティケーター・クラスやログイン・モジュール・クラスを直接マイグレーションすることはできませんが、チャレンジを生成するためのコード、応答から資格情報を抽出するためのコード、資格情報を検証するためのコードなど、該当するコードをセキュリティー検査にコピーすることができます。

## 7.1 のその他のセキュリティー構成のマイグレーション
{: #migrating-additional-security-configurations-of-71 }
### アプリケーション・セキュリティー・テスト
{: #the-application-security-test }
リソース・アダプターを保護するために使用されている OAuth スコープに加えて、ここで使用した 7.1 サンプル・アプリケーションはアプリケーション・レベルのセキュリティー・テストによっても保護されています。このサンプルには、application-descriptor.xml ファイルに定義されたアプリケーション・セキュリティー・テストはありません。したがって、デフォルトのセキュリティー・テストで保護されています。7.1 のモバイル・アプリケーション用のデフォルト・セキュリティー・テストを構成しているレルムは、8.0 では無関係 (anti-XSRF) であるか、または明示的なマイグレーション (ダイレクト・アップデート、リモート無効化) を必要としません。そのため、この事例では、アプリケーション・セキュリティー・テストに関連したマイグレーションは必要ありません。

アプリケーションを 8.0 にマイグレーションした後も、そのアプリケーションのアプリケーション・セキュリティー・テストに組み込まれている検査 (レルム) をアプリケーション・レベルのまま保持しておきたい場合は、そのアプリケーション用の必須スコープを構成できます。保護リソースへのアクセスを試行したアプリケーションは、リソースを保護しているスコープにマップされている検査に加え、必須スコープにマップされているセキュリティー検査にも合格する必要があります。

アプリケーション用の必須スコープを定義するには、{{ site.data.keys.mf_console }} でアプリケーションのバージョンを選択し、「セキュリティー」タブを選択して、「スコープに追加」ボタンをクリックします。定義済みセキュリティー検査やカスタム・セキュリティー検査、またはマップされたスコープ・エレメントをこのスコープに含めることができます。

### アクセス・トークンの有効期限
{: #access-token-expiration }
application-descriptor.xml ファイル内の Access Token Expiration プロパティーの値を確認します。デフォルト値は、バージョン 7.1 とバージョン 8.0 のどちらも 3600 秒です。そのため、アプリケーション記述子ファイル内で別の値が定義されている場合を除き、何も変更する必要はありません。8.0 で有効期限の値を設定するには、 {{ site.data.keys.mf_console }} でアプリケーション・バージョンのページに移動し、「セキュリティー」タブを選択して、「トークンの最大有効期間」フィールドに値を入力します。

### ユーザー ID レルム
{: #user-identity-realm }
MobileFirst 7.1 では、認証レルムを ユーザー ID レルムとして構成できます。OAuth の認証フローを使用するアプリケーションは、アプリケーション記述子ファイル内の `userIdentityRealms` プロパティーを使用して、ユーザー ID レルムの番号付きリストを定義します。クラシック Worklight 認証フロー (OAuth ではない) を使用するアプリケーションでは、属性 `isInternalUserId` が、レルムがユーザー ID レルムであるかどうかを示します。これらの構成は {{ site.data.keys.product_adj }} 8.0 ではもう必要ありません。{{ site.data.keys.product_adj }} 8.0 では、`setActiveUser` メソッドを呼び出した直前のセキュリティー検査によって、アクティブ・ユーザー ID が設定されます。サンプル・アプリケーションの UserLogin セキュリティー検査のように、抽象基底クラス `UserAuthenticationSecurityCheck` を拡張したセキュリティー検査の場合は、この基底クラスが、アクティブ・ユーザーの設定を担当します。

### デバイス ID レルム
{: #device-identity-realm }
7.1 アプリケーションでは、デバイス ID レルムとして定義されたレルムが存在している必要があります。8.0 では、この構成のためのマイグレーションは必要ありません。{{ site.data.keys.product_adj }} 8.0 では、デバイス ID にセキュリティー検査は関連付けられていません。デバイス情報は、クライアント登録フローの一部として登録されます。これは、クライアントが初めて保護リソースにアクセスしようとしたときに行われます。

## 要約
{: #summary }
このチュートリアルでは、既存のアプリケーションのセキュリティー成果物を以前のバージョンからマイグレーションするために必要な、基本的な手順のみを説明しました。[新しいセキュリティー・フレームワークについてより詳しく学ぶ](../../authentication-and-security/)ことで、ここには記載されていないフィーチャーも是非活用してください。
