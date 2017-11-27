---
layout: tutorial
title: UserAuthenticationSecurityCheck クラスの実装
breadcrumb_title: セキュリティー検査
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: セキュリティー検査のダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
この抽象クラスは、`CredentialsValidationSecurityCheck` を継承し、それを元にして、単純なユーザー認証の一般的なユース・ケースに適合するように構成されます。資格情報を検証することに加えて、フレームワークのさまざまな部分からアクセス可能な**ユーザー ID** の作成も行います。それによって、現行ユーザーの識別が可能になります。オプションで、`UserAuthenticationSecurityCheck` は**ユーザー記憶 (Remember Me)** 機能も提供します。

このチュートリアルでは、ユーザー名とパスワードを要求し、そのユーザー名を使用して認証済みユーザーを表すセキュリティー検査の例を使用します。

**前提条件:** [CredentialsValidationSecurityCheck](../../credentials-validation/) のチュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [セキュリティー検査の作成](#creating-the-security-check)
* [チャレンジの作成](#creating-the-challenge)
* [ユーザー資格情報の検証](#validating-the-user-credentials)
* [AuthenticatedUser オブジェクトの作成](#creating-the-authenticateduser-object)
* [RememberMe 機能の追加](#adding-rememberme-functionality)
* [セキュリティー検査の構成](#configuring-the-security-check)
* [サンプルのセキュリティー検査](#sample-security-check)

## セキュリティー検査の作成
{: #creating-the-security-check }
[Java アダプターを作成](../../../adapters/creating-adapters)し、`UserAuthenticationSecurityCheck` を継承する `UserLogin` という名前の Java クラスを追加します。

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

       @Override
   protected AuthenticatedUser createUser() {
        return null;
    }

    @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }
}
```

## チャレンジの作成
{: #creating-the-challenge }
チャレンジは、[CredentialsValidationSecurityCheck の実装](../../credentials-validation/security-check/)で説明しているのとまったく同じものです。

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

## ユーザー資格情報の検証
{: #validating-the-user-credentials }
クライアントがチャレンジ応答を送信すると、応答は `Map` として `validateCredentials` に渡されます。このメソッドを使用して、ロジックを実装してください。このメソッドは、資格情報が有効な場合に `true` を返します。

この例では、`username` と `password` が同じ場合、資格情報を「有効」と見なします。

```java
@Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                return true;
        }
        else {
            errorMsg = "Wrong Credentials";
        }
    }
    else{
        errorMsg = "Credentials not set properly";
    }
    return false;
}
```

## AuthenticatedUser オブジェクトの作成
{: #creating-the-authenticateduser-object }
`UserAuthenticationSecurityCheck` クラスは、現行クライアント (ユーザー、デバイス、アプリケーション) を表現するものを永続データに保管し、コードのさまざまな部分 (チャレンジ・ハンドラー、アダプターなど) で現行ユーザーを取得できるようにします。
ユーザーは、クラス `AuthenticatedUser` のインスタンスとして表現されます。そのコンストラクターは、`id`、`displayName`、および `securityCheckName` の各パラメーターを受け入れます。

この例では、`id` パラメーターと `displayName` パラメーターの両方に `username` を使用します。

1. まず、`validateCredentials` メソッドを変更して、`username` 引数を保存します。

   ```java
   private String userId, displayName;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;
                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "The credentials are not set properly.";
        }
        return false;
   }
   ```

2. 次に、`createUser` メソッドをオーバーライドして、`AuthenticatedUser` の新規インスタンスを返すようにします。

   ```java
   @Override
   protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
   }
   ```

`this.getName()` を使用して、現在のセキュリティー検査名を取得できます。

`UserAuthenticationSecurityCheck` は、`validateCredentials` が成功した後、`createUser()` 実装を呼び出します。

### AuthenticatedUser への属性の保管
{: #storing-attributes-in-the-authenticateduser }
`AuthenticatedUser` には代替のコンストラクターがあります。

```java
AuthenticatedUser(String id, String displayName, String securityCheckName, Map<String, Object> attributes);
```

このコンストラクターは、ユーザー表現と一緒に保管されるカスタム属性の `Map` を追加します。Map を使用して、プロファイル・ピクチャー、Web サイトなどの追加情報を保管できます。この情報は、クライアント・サイド (チャレンジ・ハンドラー) からも、リソースからも (イントロスペクション・データを使用して) アクセス可能です。

> **注:**
> 属性 `Map` に含めることができるのは、Java ライブラリーにバンドルされている型/クラスのオブジェクト (例えば、`String`、`int`、`Map` など) に限定され、カスタム・クラスを含めることは**できません**。

## RememberMe 機能の追加
{: #adding-rememberme-functionality }
デフォルトで、`UserAuthenticationSecurityCheck` は `successStateExpirationSec` プロパティーを使用して、成功状態が持続する期間を判定します。このプロパティーは、`CredentialsValidationSecurityCheck` から継承されます。

`successStateExpirationSec` の値を過ぎた後もユーザーのログイン状態を許可する必要がある場合、`UserAuthenticationSecurityCheck` でこの機能を追加します。

`UserAuthenticationSecurityCheck` は、`rememberMeDurationSec` というプロパティーを追加します。このデフォルト値は `0` です。すなわち、ユーザーが記憶される期間は **0 秒**であり、デフォルトでは、この機能は無効であることを意味します。この値をアプリケーションにとって妥当な数値 (1 日、1 週間、1 カ月など) に変更してください。

また、`rememberCreatedUser()` メソッドをオーバーライドすることでこの機能を管理することもできます。このメソッドは、(期間プロパティーが変更されている場合) 機能がアクティブであることを意味する `true` をデフォルトで返します。

この例の場合、クライアントは、送信する資格情報の一部として `boolean` 値を送信することで **RememberMe** 機能を有効/無効にします。

1. まず、`validateCredentials` メソッドを変更して、`rememberMe` の選択を保存します。

   ```java
   private String userId, displayName;
   private boolean rememberMe = false;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();
            if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
                userId = username;
                displayName = username;

                //Optional RememberMe
                if(credentials.containsKey("rememberMe") ){
                    rememberMe = Boolean.valueOf(credentials.get("rememberMe").toString());
                }

                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "Credentials not set properly";
        }
        return false;
   }
   ```

2. 次に、`rememberCreatedUser()` メソッドをオーバーライドします。

   ```java
   @Override
   protected boolean rememberCreatedUser() {
        return rememberMe;
   }
   ```

## セキュリティー検査の構成
{: #configuring-the-security-check }
**adapter.xml** ファイル内に、`<securityCheckDefinition>` エレメントを追加します。

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed."/>
  <property name="blockedStateExpirationSec" defaultValue="10" description="How long before the client can try again (seconds)."/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)."/>
  <property name="rememberMeDurationSec" defaultValue="120" description="How long is the user remembered by the RememberMe feature (seconds)."/>
</securityCheckDefinition>
```
前述したとおり、`UserAuthenticationSecurityCheck` は、`blockedStateExpirationSec`、`successStateExpirationSec` など、`CredentialsValidationSecurityCheck` のすべてのプロパティーを継承します。

それらに加えて、`rememberMeDurationSec` プロパティーを構成することもできます。

## サンプルのセキュリティー検査
{: #sample-security-check }
セキュリティー検査 Maven プロジェクトを[ダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)します。

Maven プロジェクトには、`UserAuthenticationSecurityCheck` の実装が含まれます。
