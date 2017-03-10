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

セキュリティー開発およびセキュリティー管理のタスクを改善し簡素化するため、V8.0 では {{ site.data.keys.product_full }} セキュリティー・フレームワークが大幅に変更されました。これらの変更では、V7.1 のセキュリティー・ビルディング・ブロックが差し替えられています。V8.0 では、OAuth のセキュリティー・スコープとセキュリティー検査が、以前のバージョンのセキュリティー・テスト、セキュリティー・レルム、およびセキュリティー・ログイン・モジュールに取って代わっています。

このチュートリアルには、アプリケーションのセキュリティー・コードを V8.0 にマイグレーションするために必要なステップが示されています。チュートリアルでは、{{ site.data.keys.product_adj }} V7.1 のサンプル・アプリケーションを、同じセキュリティー保護が使用される V8.0 アプリケーションに変換するための完全なプロセスについて概説します。V7.1 のサンプル・アプリケーションとマイグレーションされる V8.0 アプリケーションの両方がダウンロード可能です。このチュートリアルの先頭にある**「マイグレーション・サンプルのダウンロード」**リンクを参照してください。

チュートリアルの[最初の部分](#migrating-the-sample-application)では、V7.1 のサンプル・アプリケーションを V8.0 にマイグレーションする方法について説明します。これには、リソース・アダプターをマイグレーションして、フォーム・ベースの認証レルムとアダプター・ベースの認証レルムをセキュリティー検査に置き換えて、クライアント・アプリケーションとそのチャレンジ・ハンドラーをマイグレーションする作業が含まれます。<br />
[2 番目の部分](#migrating-other-types-of-authentication-realms)では、サンプル・アプリケーションでは示されていない、V7.1 のその他のタイプの認証レルムを V8.0 にマイグレーションする方法について説明します。<br />
[3 番目の部分](#migrating-other-v71-security-configurations)では、V7.1 の追加のセキュリティー構成を V8.0 にマイグレーションする方法について説明します。これには、アプリケーション・レベルの保護の構成、アクセス・トークンの有効期限の構成、およびユーザー ID とデバイス ID の構成が含まれます。
{% comment %} I edited and reordered, including splitting part two into two and three - which matches the header levels in the original doc. I moved the links (which I also edited) to each second-level header ("part").
{% endcomment %}

> **注:** マイグレーションを開始する前に、[V8.0 マイグレーションの手引き](../migration-cookbook)を確認することをお勧めします。  
> 新しいセキュリティー・フレームワークの基本概念については、[認証およびセキュリティー](../../authentication-and-security)を参照してください。

## サンプル・アプリケーションのマイグレーション
{: #migrating-the-sample-application }

このマイグレーション手順の開始点は、V7.1 のサンプル・ハイブリッド・アプリケーションです。このアプリケーションは、V7.1 OAuth セキュリティー・モデルで保護された Java アダプターにアクセスします。アダプターには以下の 2 つのメソッドがあります。
*  `getBalance`。ユーザー名とパスワードのログインを実装するフォーム・ベースの認証レルムで保護されています。
*  `transferMoney`。PIN コード・ベースのユーザー許可を実装するアダプター・ベースの認証レルムで保護されています。

V7.1 サンプル・アプリケーションとマイグレーション済みの V8.0 サンプル・アプリケーションのソース・コードをダウンロードするには、このチュートリアルの先頭にある**「マイグレーション・サンプルのダウンロード」**リンクを使用してください。

V7.1 のサンプル・アプリケーションを V8.0 にマイグレーションするには、以下のステップに従います。
*  リソース保護ロジックを含め、[リソース・アダプターをマイグレーションします](#migrating-the-resource-adapter)。
*  [クライアント・アプリケーションをマイグレーションします](#migrating-the-client-application)。
*  V7.1 のサンプル・アプリケーションの[認証レルムをマイグレーションします](#migrating-rm-and-adapter-based-auth-realms)。これを行うには、これらの認証レルムを V8.0 のセキュリティー検査に置き換えます。
*  新しいチャレンジ・ハンドラー API が使用されるように、クライアント・サイドで[チャレンジ・ハンドラーをマイグレーションします](#migrating-the-challenge-handlers)。

### リソース・アダプターのマイグレーション
{: #migrating-the-resource-adapter }
リソース・アダプターのマイグレーションから始めます。アダプターがアプリケーション・プロジェクトの一部であった V7.1 とは異なり、{{ site.data.keys.product }} V8.0 では、アダプターを別個の Maven プロジェクトとして開発します。そのため、クライアント・アプリケーションとは独立して、リソース・アダプターをマイグレーションして、マイグレーション済みのアダプターをビルドしてデプロイすることができます。同じことが、V8.0 のクライアント・アプリケーションと V8.0 のセキュリティー検査 (アダプター内に実装されます) についても当てはまります。そのため、これらの成果物は任意の順序でマイグレーションできます。このチュートリアルでは、V8.0 のリソース保護に使用される OAuth セキュリティー・スコープ・エレメントの概要を含む、リソース・アダプターのマイグレーション手順から始めます。

> **注:
** 
> *  以下の手順は、サンプルの `AccountAdapter` リソース・アダプターのマイグレーション手順です。サンプルの `PinCodeAdapter` をマイグレーションする必要はありません。これによって実装されるアダプター・ベースの認証は V8.0 ではサポートされなくなったためです。[PIN コード・アダプター・ベースの認証レルムを置き換える](#replacing-the-pin-code-adapter-based-authentication-realm)手順では、V7.1 の PIN コード・アダプターを、類似した保護を行う V8.0 のセキュリティー検査で置き換える方法について説明します。
> *  アダプターを V8.0 にマイグレーションする方法については、[V8.0 マイグレーションの手引き](../migration-cookbook)を参照してください。

V7.1 のサンプルの `AccountAdpter` メソッドは、メソッドの保護スコープ (`UserLoginRealm` および `PinCodeRealm`) を定義する `@OAuthSecurity` アノテーションで保護されています。同じアノテーションが V8.0 で使用されますが、スコープ・エレメントは別の意味を持ちます。V7.1 では、スコープ・エレメントは、**authenticationConfig.xml** ファイルに定義されているセキュリティー・レルムのことを指します。V8.0 では、スコープ・エレメントは、{{ site.data.keys.mf_server }} にデプロイされたアダプターに定義されたセキュリティー検査にマップされます。スコープ・エレメント名を含め、リソース保護コードを変更せずにそのままにすることを選択できます。ただし、「レルム」という用語は {{ site.data.keys.product }} V8.0 では使用されなくなったため、V8.0 アプリケーションのスコープ・エレメントの名前は `UserLogin` および `PinCode` に変更されます。

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

#### ユーザー ID 取得コードの更新
{: #updating-the-user-identity-retrieval-code }

サンプルのリソース・アダプターは、サーバー・サイド・セキュリティー API を使用して認証ユーザーの ID を取得します。この API は V8.0 で変更されたため、更新された API を使用するようにアダプター・コードを変更する必要があります。マイグレーション済みの V8.0 アプリケーションでは、以下の V7.1 コードを削除してください。

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

これを、新規の V8.0 API を使用する以下のコードで置き換えます。

```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```
アダプター・コードの編集後に、Maven または {{ site.data.keys.mf_cli }} のいずれかを使用して、アダプターをビルドしてこれをサーバーにデプロイします。詳しくは、[アダプターのビルドとデプロイ](../../adapters/creating-adapters/#build-and-deploy-adapters)を参照してください。
### クライアント・アプリケーションのマイグレーション
{: #migrating-the-client-application }

次に、クライアント・アプリケーションをマイグレーションします。クライアント・アプリケーションの詳細なマイグレーション手順については、[V8.0 マイグレーションの手引き](../migration-cookbook)を参照してください。このチュートリアルでは、セキュリティー・コードのマイグレーションを重点的に扱います。この段階では、アプリケーションのメイン HTML ファイルである **index.html** を編集して、チャレンジ・ハンドラー・コードをインポートするための行の周囲にコメントを追加する (コメント化する) ことで、チャレンジ・ハンドラー・コードを除外します。

```html
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

サンプル・アプリケーションのチャレンジ・ハンドラー・コードは、後から[チャレンジ・ハンドラーのマイグレーション](#migrating-the-challenge-handlers)の手順で変更します。

#### クライアント・サイド API 呼び出しの更新
{: #updating-the-client-side-api-calls }

クライアント・マイグレーションの一部として、V8.0 のクライアント・サイド API の変更に対応する必要があります。{{ site.data.keys.product }} V8.0 クライアント API の変更のリストについては、[WebView のアップグレード](../migrating-client-applications/cordova/#upgrading-the-webview)を参照してください。
サンプル・アプリケーションには、セキュリティーに関連する 1 つのクライアント API であるログアウト API の変更があります。V7.1 の `WL.Client.logout` メソッドは V8.0 ではサポートされていません。代わりに、V8.0 の `WLAuthorizationManager.logout` メソッドを使用して、V7.1 の認証レルムに代わるセキュリティー検査の名前をこれに渡します。サンプル・アプリケーションの**「ログアウト」** ボタンは、`UserLogin` と `PinCode` の両方のセキュリティー検査からユーザーをログアウトさせます。

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

クライアント・アプリケーションのマイグレーション・ステップが完了したら、アプリケーションをビルドしてから、`mfpdev app register` コマンドを使用してこのアプリケーションを {{ site.data.keys.mf_server }} に登録します。アプリケーションを正常に登録したら、これが {{ site.data.keys.mf_console }} ナビゲーション・サイドバーの**「アプリケーション」**セクションにリストされているのを確認できます。

### サンプル・アプリケーションの認証レルムのマイグレーション
{: #migrating-rm-and-adapter-based-auth-realms }

この段階では、マイグレーション済みの V8.0 クライアント・アプリケーションとデプロイ済みのリソース・アダプターが既に存在します。ただし、マイグレーション済みのアプリケーションは、保護されたアダプター・リソースにアクセスできません。これは、リソース・アダプターのメソッドが、まだセキュリティー検査にマップされていない `UserLogin` スコープ・エレメントと `PinCode` スコープ・エレメントによって保護されているためです。従って、アプリケーションは、protected メソッドにアクセスするために必要なアクセス・トークンを取得できません。これを解決するには、V7.1 認証レルムを、アダプターのメソッドの保護スコープ・エレメントにマップされる V8.0 のセキュリティー検査で置き換える必要があります。

#### ユーザー・ログイン・フォーム・ベースの認証レルムの置き換え
{: #replacing-the-user-login-form-based-authentication-realm }

V7.1 の `UserLoginRealm` フォーム・ベースの認証レルムを置き換えるには、V7.1 のフォーム・ベースのオーセンティケーターとカスタム・ログイン・モジュールと同じ認証ステップを実行する、V8.0 の `UserLogin` セキュリティー検査を作成します。セキュリティー検査では、チャレンジをクライアントに送信して、チャレンジ応答からログイン資格情報を収集し、その資格情報を検証して、ユーザー ID を作成する必要があります。以下の説明に示されているように、セキュリティー検査の作成は複雑ではありません。セキュリティー検査の作成後に、ログイン資格情報を検証するためのコードを V7.1 のカスタム・ログイン・モジュールから新しいセキュリティー検査にコピーできます。

V8.0 では、セキュリティー検査はアダプターとして実装されます。{{ site.data.keys.product }} V8.0 では、Java アダプターはリソースとパッケージ・セキュリティー・テストの両方としての機能を果たすことができます。ただし、このマイグレーション手順では、マイグレーション済みの `AccountAdpter` リソース・アダプターを維持して、新しいセキュリティー検査をパッケージするための別個のアダプターを作成します。そのため、`UserLogin` という名前の新しい Java アダプターの作成から始めます。詳細な手順については、[新しい Java アダプターの作成](../../adapters/creating-adapters)を参照してください。

新しい `UserLogin` アダプターに `UserLogin` セキュリティー検査を定義するには、以下のコードに示されているように、&lt;securityCheckDefinition&gt; XML エレメントをアダプターの **adapter.xml** ファイルに追加します。

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* `name` 属性は、セキュリティー検査の名前 (「UserLogin」) を指定します。
* `class` 属性は、セキュリティー検査実装の Java クラス (「com.sample.UserLogin」) を指定します。このクラスは[次のステップ](#creating-the-user-login-security-check-java-class)で作成します。
* `successStateExpirationSec` プロパティーは、V7.1 ログイン・モジュールの `expirationInSeconds` プロパティーと同等です。これは、セキュリティー検査の成功状態の有効期間 (成功したセキュリティー検査のログインが有効なままになる秒単位の間隔) を示します。V7.1 と V8.0 のこれらのプロパティーのデフォルト値は両方とも 3600 秒です。V7.1 のログイン・モジュールで別の有効期間を構成した場合、V8.0 の `successStateExpirationSec` プロパティーの値を編集して、同じ値を設定します。

このチュートリアルでは、`successStateExpirationSec` プロパティーのみを定義する方法について説明しますが、セキュリティー検査ではより多くのことを行うことができます。例えば、ブロック状態の有効期限、複数のログイン試行、「記憶する」ログインなどの拡張機能を実装できます。{{ site.data.keys.mf_console }} から、または {{ site.data.keys.mf_cli }} (**mfpdev**) を使用して、実行時に構成プロパティーのデフォルト値の変更、カスタム・プロパティーの追加、およびプロパティー値の変更を行うことができます。詳しくは、[V8.0 セキュリティー検査の資料](../../authentication-and-security/creating-a-security-check/)と、特に[セキュリティー検査の構成](../../authentication-and-security/creating-a-security-check/#security-check-configuration)を参照してください。

##### ユーザー・ログインのセキュリティー検査 Java クラスの作成
{: #creating-the-user-login-security-check-java-class }

`UserLogin` アダプターで、({{ site.data.keys.product_adj }}  `CredentialsValidationSecurityCheck` 抽象基本クラスを拡張する) {{ site.data.keys.product_adj }} `UserAuthenticationSecurityCheck` 抽象基本クラスを拡張する `UserLogin` Java クラスを作成します。次に、`createChallenge`、`validateCredentials`、および `createUser` の各基本クラス・メソッドのデフォルト実装をオーバーライドします。

*  `createChallenge` メソッドは、クライアントに送信されるチャレンジ・オブジェクト (ハッシュ・マップ) を作成します。このメソッドの実装は、クライアントの応答を検証するために使用されるチャレンジの句またはその他のタイプのチャレンジ・オブジェクトを含めるために変更できます。ただし、サンプル・アプリケーションのためには、エラーが発生した場合に表示するエラー・メッセージのみをチャレンジ・オブジェクトに追加する必要があります。
*  `validateCredentials` メソッドには認証ロジックが含まれています。ユーザー名とパスワードを検証する認証コードを V7.1 のログイン・モジュールから V8.0 のこのメソッドにコピーします。このサンプルは、パスワードがユーザー名と一致することを確認する基本的な検証ロジックを実装します。
*  `createUser` メソッドは、V7.1 のログイン・モジュールの `createIdentity` メソッドと同等です。

以下に、完全なクラス実装コードを示します。

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

            // the authentication logic, copied from the V7.1 login module
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

`UserAuthenticationSecurityCheck` クラスとその実装について詳しくは、[UserAuthenticationSecurityCheck クラスの実装](../../authentication-and-security/user-authentication/security-check/)を参照してください。


変更を実行するには、Maven または {{ site.data.keys.mf_cli }} のいずれかを使用して、`UserLogin` アダプターをビルドしてこれをサーバーにデプロイします。詳しくは、[アダプターのビルドとデプロイ](../../adapters/creating-adapters/#build-and-deploy-adapters)を参照してください。アダプターを正常にデプロイしたら、これが {{ site.data.keys.mf_console }} ナビゲーション・サイドバーの**「アダプター」**セクションにリストされているのを確認できます。

#### PIN コード・アダプター・ベースの認証レルムの置き換え
{: #replacing-the-pin-code-adapter-based-authentication-realm }

V7.1 のサンプル・アプリケーションの `PinCodeRealm` レルムは、V8.0 ではサポートされなくなったアダプター・ベースの認証を使用して実装されています。このレルムの代わりに、新しい `PinCode` Java アダプターを作成して、{{ site.data.keys.product_adj }} `CredentialsValidationSecurityCheck` 抽象基本クラスを拡張する `PinCode` Java クラスをこのアダプターに追加します。

**注:
**
*  `PinCode` アダプターを作成するためのステップは、[ユーザー・ログイン・フォーム・ベースの認証レルムの置き換え](#replacing-the-user-login-form-based-authentication-realm)のステップで概説されているように、`UserLogin` アダプターを作成するためのステップと似ています。
*  `PinCode` セキュリティー検査で必要なのはログイン資格情報 (PIN コード) の検証だけで、ユーザー ID の割り当ては必要ありません。そのため、このセキュリティー検査クラスは `CredentialsValidationSecurityCheck` 基本クラスを拡張しますが、`UserLogin` セキュリティー検査に使用される `UserAuthenticationSecurityCheck` クラスは拡張しません。

`CredentialsValidationSecurityCheck` 基本クラスを拡張するセキュリティー検査を作成するには、`createChallenge` メソッドと `validateCredentials` メソッドを実装する必要があります。

*  `createChallenge` 実装は、`UserLogin` セキュリティー検査の実装と似ています。`PinCode` セキュリティー検査には、チャレンジの一部としてクライアントに送信される特殊情報は何もありません。そのため、エラーが発生した場合に表示するエラー・メッセージのみをチャレンジ・オブジェクトに追加する必要があります。

   ```java
    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg",errorMsg);
        return challenge;
    }
```

*  `validateCredentials` メソッドは、PIN コードを検証します。以下の例では検証コードは 1 行で構成されていますが、この検証コードを V7.1 の認証アダプターからこの `validateCredentials` メソッドにコピーすることもできます。

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

V7.1 の認証レルムのセキュリティー検査へのマイグレーションが完了したら、アダプターをビルドして、このアダプターを {{ site.data.keys.mf_server }} にデプロイします。詳しくは、[アダプターのビルドとデプロイ](../../adapters/creating-adapters/#build-and-deploy-adapters)を参照してください。

### チャレンジ・ハンドラーのマイグレーション
{: #migrating-the-challenge-handlers }

この段階では、サンプルのリソース・アダプターとクライアント・アプリケーションを既にマイグレーションして、V7.1 の認証レルムを V8.0 のセキュリティー検査で置き換えました。サンプル・アプリケーションのセキュリティー・マイグレーションを完了するためには、後はクライアント・アプリケーションのチャレンジ・ハンドラーをマイグレーションするだけです。クライアント・アプリケーションは、チャレンジ・ハンドラーを使用して、セキュリティー・チャレンジに応答して、ユーザーから受信した資格情報をセキュリティー検査に送信します。

[クライアント・アプリケーションのマイグレーション](#migrating-the-client-application)時に、アプリケーションのメイン HTML ファイルである **index.html** で該当する行をコメント化して、チャレンジ・ハンドラー・コードを除外しました。次に、これらの行の周囲に以前に追加したコメントを削除して、アプリケーションのチャレンジ・ハンドラー・コードを追加し直します。

```html
<script src="js/UserLoginChallengeHandler.js"></script>
<script src="js/PinCodeChallengeHandler.js"></script>
```

その後、以下の手順で概説されているように、チャレンジ・ハンドラー・コードの V8.0 へのマイグレーションに進みます。V8.0 のチャレンジ・ハンドラー API について詳しくは、[「Quick Review of Challenge Handlers in {{ site.data.keys.product }} 8.0」]({{ site.baseurl }}/blog/2016/06/22/challenge-handlers/)と、V8.0 の[「JavaScript Client-side API Reference」](../../api/client-side-api/javascript/client/)の `WL.Client` と `WL.Client.AbstractChallengeHandler` の資料を参照してください。

V7.1 の場合と同じ機能を V8.0 で実行するユーザー・ログインのチャレンジ・ハンドラー (`userLoginChallengeHandler`) から開始します。このチャレンジ・ハンドラーの役割は、チャレンジの到着時にログイン・フォームをユーザーに提示し、ユーザー名とパスワードを {{ site.data.keys.mf_server }} に送信することです。ただし、V8.0 でのクライアントのチャレンジ・ハンドラー API は V7.1 のチャレンジ・ハンドラーとは異なり、より単純なため、以下の変更を行う必要があります。

*  V8.0 の `WL.Client.createSecurityCheckChallengeHandler` メソッドを呼び出す以下のコードを使用して、チャレンジ・ハンドラーを作成するためのコードを置き換えます。

   ```javascript
var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
```
   
   `WL.Client.createSecurityCheckChallengeHandler` は、{{ site.data.keys.product_adj }} セキュリティー検査からのチャレンジを処理するチャレンジ・ハンドラーを作成します。V8.0 では、サード・パーティーのゲートウェイからのチャレンジを処理するための `WL.Client.createGatewayChallengeHandler` メソッドも導入されています。これは、V8.0 ではゲートウェイ・チャレンジ・ハンドラーと呼ばれています。V7.1 アプリケーションを V8.0 にマイグレーションする際に、`WL.Client` `createWLChallengeHandler` メソッドまたは `createChallengeHandler` メソッドの呼び出しを、予期したチャレンジ・ソースと一致する V8.0 の `WL.Client` チャレンジ・ハンドラー作成メソッドの呼び出しで置き換えます。例えば、カスタム・ログイン・フォームをクライアントに送信する DataPower リバース・プロキシーによってリソースが保護されている場合は、`createGatewayChallengeHandler` を使用して、ゲートウェイ・チャレンジを処理するためのゲートウェイ・チャレンジ・ハンドラーを作成します。

*  チャレンジ・ハンドラー `isCustomResponse` メソッドの呼び出しを削除します。V8.0 では、セキュリティー・チャレンジを処理するためにこのメソッドは不要になりました。
*  `userLoginChallengeHandler.handleChallenge` メソッドの実装を、V8.0 のチャレンジ・ハンドラー `handleChallenge`、`handleSuccess`、および `handleFailure` の各メソッドの実装で置き換えます。V7.1 には、応答にチャレンジが含まれているかどうかを判別するためにこの応答を検査して、成功またはエラーを返す単一のチャレンジ・ハンドラー・メソッドがあります。V8.0 には、チャレンジ・ハンドラー応答のタイプごとに別個のメソッドがあり、セキュリティー・フレームワークが応答タイプを判別して、適切なメソッドを呼び出します。
*  `submitSuccess` メソッドの呼び出しを削除します。V8.0 のセキュリティー・フレームワークが、正常応答を暗黙的に処理します。
*  `submitFailure` メソッドの呼び出しを、V8.0 の `cancel` チャレンジ・ハンドラー・メソッドの呼び出しで置き換えます。
*  `submitLoginForm` メソッドの呼び出しを、V8.0 の `submitChallengeAnswer` チャレンジ・ハンドラー・メソッドの呼び出しで置き換えます。

   ```javascript
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
```
   
以下に、これらの変更を適用した後のチャレンジ・ハンドラーの完全なコードを示します。
   
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

PIN コードのチャレンジ・ハンドラー (`pinCodeChallengeHandler`) のマイグレーションは、ユーザー・ログインのチャレンジ・ハンドラーのマイグレーションと似ています。そのため、`userLoginChallengeHandler` のマイグレーション手順に従って、PIN コードのチャレンジ・ハンドラーに必要な調整を行います。V8.0 のサンプル・アプリケーション内にある、マイグレーション済みの PIN コードのチャレンジ・ハンドラーの完全なコードを参照してください。

これで、サンプルの V7.0 アプリケーションの V8.0 へのマイグレーションが完了しました。アプリケーションを再ビルドして {{ site.data.keys.mf_server }} にデプロイし、テストして、アダプター・メソッド・リソースへのアクセスが予期したとおりに保護されていることを検証します。

## その他のタイプの認証レルムのマイグレーション
{: #migrating-other-types-of-authentication-realms }

これまでに、V7.1 のサンプル・アプリケーションの一部であるフォーム・ベースのレルムとアダプター・ベースのレルムをマイグレーションする方法について確認しました。ただし、V7.1 アプリケーションには、アプリケーション・セキュリティー・テスト (`mobileSecurityTest`、`webSecurityTest`、または `customSecurityTest`) の一部であるレルムなど、他のタイプの認証レルムが含まれていることがあります。以下のセクションでは、これらの追加のタイプの認証レルムを V8.0 にマイグレーションする方法について概説します。

*  [アプリケーションの認証性](#application-authenticity)
*  [LTPA レルム](#ltpa-realm)
*  [デバイスのプロビジョニング](#device-provisioning)
*  [クロスサイト・リクエスト・フォージェリー対策 (anti-XSRF) レルム](#anti-cross-site-request-forgery-anti-xsrf-realm)
*  [ダイレクト・アップデート・レルム](#direct-update-realm)
*  [リモート無効化レルム](#remote-disable-realm)
*  [カスタム・オーセンティケーターおよびログイン・モジュール](#custom-authenticators-and-login-modules)

### アプリケーションの認証性
{: #application-authenticity }

{{ site.data.keys.product }} V8.0 では、アプリケーションの認証性検証は、事前定義されたセキュリティー検査 `appAuthenticity` として提供されています。デフォルトでは、このセキュリティー検査は、{{ site.data.keys.mf_server }} へのアプリケーションのランタイムの登録時に実行されます。これは、アプリケーションのインスタンスが初めてサーバーに接続しようとしたときに行われます。ただし、すべての {{ site.data.keys.product_adj }} セキュリティー検査と同様に、この事前定義された検査をカスタム・セキュリティー・スコープに含めることもできます。詳しくは、[アプリケーション認証性](../../authentication-and-security/application-authenticity/)を参照してください。

### LTPA レルム
{: #ltpa-realm }

V7.1 の LTPA レルムを置き換えるには、{{ site.data.keys.product }} V8.0 の事前定義された LTPA ベースの SSO セキュリティー検査である `LtpaBasedSSO` を使用します。このセキュリティー検査について詳しくは、[LTPA ベースのシングル・サインオン (SSO) セキュリティー検査](../../authentication-and-security/ltpa-security-check/)を参照してください。

### デバイスのプロビジョニング
{: #device-provisioning }

V7.1 のデバイス・プロビジョニング・レルム (`wl_deviceAutoProvisioningRealm`) を V8.0 にマイグレーションする必要はありません。{{ site.data.keys.product }} V8.0 のクライアント登録プロセスでは、V7.1 のデバイス・プロビジョニングを置き換えます。V8.0 では、クライアント (アプリケーションのインスタンス) は、サーバーへの初回アクセス時にそれ自体を {{ site.data.keys.mf_server }} に登録します。登録の一部として、クライアントはその ID を認証するために使用される公開鍵を提供します。この保護メカニズムは常に有効になっているため、V7.1 のデバイス・プロビジョニング・レルムを置き換えるためのセキュリティー検査は必要ありません。

### クロスサイト・リクエスト・フォージェリー対策 (anti-XSRF) レルム
{: #anti-cross-site-request-forgery-anti-xsrf-realm }

V7.1 のクロスサイト・リクエスト・フォージェリー対策 (anti-XSRF) レルム (`wl_antiXSRFRealm`) を V8.0 にマイグレーションする必要はありません。V7.1.0 では、認証コンテキストは HTTP セッションに保管され、ブラウザーによってクロスサイト・リクエストで送信されるセッション Cookie によって識別されます。このバージョンでの anti-XSRF レルムは、クライアントからサーバーに送信される追加のヘッダーを使用して、XSRF 攻撃に対して Cookie の伝送を保護するために使用されます。{{ site.data.keys.product }} V8.0 では、セキュリティー・コンテキストは HTTP セッションに関連付けられなくなり、セッション Cookie によって識別されません。代わりに、許可ヘッダーで渡される OAuth 2.0 アクセス・トークンを使用して許可されます。許可ヘッダーはブラウザーによってクロスサイト・リクエストで送信されないため、XSRF 攻撃から保護する必要はありません。

### ダイレクト・アップデート・レルム
{: #direct-update-realm }

V7.1 のリモート無効化レルム (`wl_directUpdateRealm`) を V8.0 にマイグレーションする必要はありません。V7.1 のレルム要件とは異なり、ダイレクト・アップデート・フィーチャーの {{ site.data.keys.product }} V8.0 実装では関連するセキュリティー検査は必要ありません。 

**注:** ダイレクト・アップデートを使用して更新を配信するための V8.0 の手順は、V7.1 の手順とは異なります。詳しくは、[ダイレクト・アップデートのマイグレーション](../migrating-client-applications/cordova/#migrating-direct-update)を参照してください。

### リモート無効化レルム
{: #remote-disable-realm }

V7.1 のリモート無効化レルム (`wl_remoteDisableRealm`) を V8.0 にマイグレーションする必要はありません。V7.1 のレルム要件とは異なり、リモート無効化フィーチャーの {{ site.data.keys.product }} V8.0 実装では関連するセキュリティー検査は必要ありません。V8.0 のリモート無効化フィーチャーについては、[保護リソースへのアプリケーション・アクセスのリモート側での無効化](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources)を参照してください。

### カスタム・オーセンティケーターおよびログイン・モジュール
{: #custom-authenticators-and-login-modules }

カスタムの V7.1 オーセンティケーターとログイン・モジュールを置き換えるには、[ユーザー・ログインのセキュリティー検査 Java クラスの作成](#creating-the-user-login-security-check-java-class)のサンプル・アプリケーションのマイグレーション・ステップの指示に従って新しいセキュリティー検査を作成します。セキュリティー検査は、`UserAuthenticationSecurityCheck` または `CredentialsValidationSecurityCheck` のいずれかの {{ site.data.keys.product }} V8.0 基本クラスを拡張できます。V7.1 のオーセンティケーター・クラスやログイン・モジュール・クラスを直接マイグレーションすることはできませんが、該当するコード部分をセキュリティー検査にコピーすることができます。これには、セキュリティー・チャレンジの生成、チャレンジ応答からのログイン資格情報の抽出、資格情報の検証を行うためのコードが含まれます。

## その他の V7.1 のセキュリティー構成のマイグレーション
{: #migrating-other-v71-security-configurations }

*  [アプリケーション・セキュリティー・テスト](#the-application-security-test)
*  [アクセス・トークンの有効期限](#access-token-expiration)
*  [ユーザー ID レルム](#user-identity-realm)
*  [デバイス ID レルム](#device-identity-realm)

### アプリケーション・セキュリティー・テスト
{: #the-application-security-test }

V7.1 では、アプリケーション記述子 (**application-descriptor.xml**) は、特定のアプリケーション・リソースに適用される保護に加えて、アプリケーション環境全体に適用されるアプリケーション・セキュリティー・テストを定義できます。(V7.1 のサンプル・アプリケーション内など) アプリケーション記述子がセキュリティー・テストを明示的に定義していない場合に適用されるデフォルトの V7.1 のモバイル・アプリケーション・セキュリティー・テストは `mobileSecurityTest` です。このセキュリティー・テストは、V8.0 では無関係なレルム (anti-XSRF) か、明示的なマイグレーションを必要としないレルム (ダイレクト・アップデートおよびリモート無効化) のいずれかで構成されます。そのため、サンプル・アプリケーションのアプリケーション環境保護のためには、特定のマイグレーションは必要ありません。

V7.1 アプリケーションに、V8.0 へのマイグレーション後にアプリケーション・レベルで保持しておきたい検査 (レルム) を含むアプリケーション・セキュリティー・テストがある場合、必須アプリケーション・スコープを構成できます。V8.0 では、保護リソースにアクセスするには、必須アプリケーション・スコープにマップされているセキュリティー検査と、リソースの保護スコープにマップされている検査の両方に合格する必要があります。必須アプリケーション・スコープを定義するには、V8.0 {{ site.data.keys.mf_console }} では、ナビゲーション・サイドバーの**「アプリケーション」**セクションからアプリケーションを選択した後、**「セキュリティー」**タブを選択します。**「必須アプリケーション・スコープ」**で、**「スコープに追加」**を選択します。定義済みセキュリティー検査やカスタム・セキュリティー検査とマップされたスコープ・エレメントをアプリケーション・スコープに含めることができます。V8.0 での必須アプリケーション・スコープの構成について詳しくは、[必須アプリケーション・スコープ](../..//authentication-and-security/#mandatory-application-scope)を参照してください。

### アクセス・トークンの有効期間
{: #access-token-expiration }

アクセス・トークンの最大有効期間のデフォルト値は、V7.1 と V8.0 の両方で 3600 秒です。そのため、V7.1 アプリケーションがこのデフォルト値に依存している場合でも、V8.0 でこの値を適用するためにマイグレーション作業を行う必要はありません。ただし、V7.1 のアプリケーション記述子ファイル (**application-descriptor.xml**) で `accessTokenExpiration` プロパティーに異なる値が設定されている場合、V8.0 の同等のプロパティー (`maxTokenExpiration`) に同じ値を構成できます。これは、アプリケーションの**「セキュリティー」**タブに移動して、**「トークン構成」**セクションの**「トークンの最大有効期間 (秒)」**フィールドのデフォルト値を編集することで、{{ site.data.keys.mf_console }} から行うことができます。アプリケーションの**「構成ファイル」**コンソール・タブを選択した場合、`maxTokenExpiration` プロパティーの値が構成済みの値に設定されていることを確認できます。

### ユーザー ID レルム
{: #user-identity-realm }

V7.1 では、認証レルムはユーザー ID レルムとして構成できます。{{ site.data.keys.product_adj }} OAuth セキュリティー・モデルの認証フローを使用するアプリケーションは、アプリケーション記述子ファイル内の `userIdentityRealms` プロパティーを使用して、ユーザー ID レルムの番号付きリストを定義します。{{ site.data.keys.product_adj }} クラシック (OAuth ではない) セキュリティー・モデルの認証フローを使用するアプリケーションでは、属性 `isInternalUserId` が、レルムがユーザー ID レルムかどうかを示します。V8.0 では、これらのユーザー ID 構成は不要になりました。V8.0 では、アクティブ・ユーザーの ID は、`setActiveUser` メソッドを呼び出した最後のセキュリティー検査によって設定されます。V8.0 のサンプルの `UserLogin` 検査など、セキュリティー検査が抽象基本クラス `UserAuthenticationSecurityCheck` を拡張する場合、この基本クラスを使用して、アクティブ・ユーザーの ID を設定できます。


### デバイス ID レルム
{: #device-identity-realm }

V7.1 アプリケーションは、デバイス ID レルムを定義する必要があります。V8.0 では、このレルムは不要になりました。V8.0 では、デバイス ID はセキュリティー検査に関連付けられません。代わりに、デバイス情報は、クライアントが初めて保護リソースにアクセスしようとしたときに行われるクライアント登録フローの一部として登録されます。

## 次の作業
{: #whats-next }

このチュートリアルでは、以前のバージョンの {{ site.data.keys.product }} で開発された既存のアプリケーションのセキュリティー成果物を V8.0 にマイグレーションするために必要な基本ステップについてのみ扱っています。V8.0 のセキュリティー機能を十分に活用するには、[V8.0 セキュリティー・フレームワークの資料](../../authentication-and-security/)を参照してください。

