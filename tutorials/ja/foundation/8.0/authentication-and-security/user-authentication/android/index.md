---
layout: tutorial
title: Android アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: PreemptiveLogin プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80
  - name: RememberMe プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80
  - name: SecurityCheck Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**前提条件:** **CredentialsValidationSecurityCheck** [チャレンジ・ハンドラー実装](../../credentials-validation/android)のチュートリアルをお読みください。

このチャレンジ・ハンドラーのチュートリアルでは、プリエンプティブ `login`、`logout`、および `obtainAccessToken` など、いくつかの追加機能 (API) を例示します。

## ログイン
{: #login }
この例では、`UserLogin` は `username` と `password` という *key:value* を必要とします。オプションで、ブール型の `rememberMe` キーも受け入れます。これは、このユーザーを長期間記憶しておくようにセキュリティー検査に指示するためのものです。サンプル・アプリケーションの場合、この情報はログイン・フォームのチェック・ボックスからブール値を使用して収集されます。

`credentials` 引数は、`username`、`password`、および `rememberMe` を含んでいる `JSONObject` です。

```java
submitChallengeAnswer(credentials);
```

チャレンジを何も受け取っていない場合でもユーザーのログインを可能にする必要がある場合があります。例えば、アプリケーションの最初の画面としてログイン画面を表示したり、ログアウト後やログイン失敗後にログイン画面を表示したりできます。このようなシナリオを**プリエンプティブ・ログイン**と呼びます。

応答すべきチャレンジが存在しない場合、`submitChallengeAnswer` API を呼び出すことはできません。そのようなシナリオ用に、{{site.data.keys.product }} SDK には `login` API が組み込まれています。

```java
WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Login Preemptive Success");

    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Login Preemptive Failure");
    }
});
```

資格情報に問題がある場合、セキュリティー検査は**チャレンジ**を返信します。

アプリケーションのニーズに応じて、どのような場合に `submitChallengeAnswer` でなく `login` を使用するかを判断することは開発者の責任です。これを実現する方法の 1 つとして、ブール値のフラグ (例えば、`isChallenged`) を定義し、`handleChallenge` に到達したときにフラグを `true` に設定し、それ以外のケース (失敗、成功、初期設定時など) では `false` に設定する方法があります。

ユーザーが**「ログイン」**ボタンをクリックした時点で、使用すべき API が動的に選択されます。

```java
public void login(JSONObject credentials){
    if(isChallenged){
        submitChallengeAnswer(credentials);
    }
    else{
        WLAuthorizationManager.getInstance().login(securityCheckName, credentials, new WLLoginResponseListener() {
//...
        });
    }
}
```

> **注:
**
>`WLAuthorizationManager` `login()` API には、独自の `onSuccess` メソッドと `onFailure` メソッドがあり、関連するチャレンジ・ハンドラーの `handleSuccess` メソッドまたは `handleFailure` メソッド**も**呼び出されます。

## アクセス・トークンの取得
{: #obtaining-an-access-token }
このセキュリティー検査は **RememberMe** 機能 (`rememberMe` ブール・キー) をサポートしているため、アプリケーションの開始時に、クライアントがログインしているかどうかをチェックすると役立ちます。

{{site.data.keys.product }} SDK は、サーバーに有効なトークンを尋ねるための `obtainAccessToken` API を提供しています。

```java
WLAuthorizationManager.getInstance().obtainAccessToken(scope, new WLAccessTokenListener() {
    @Override
    public void onSuccess(AccessToken accessToken) {
        Log.d(securityCheckName, "auto login success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "auto login failure");
    }
});
```

> **注:**
> `WLAuthorizationManager` `obtainAccessToken()` API には、独自の `onSuccess` メソッドと `onFailure` メソッドがあり、関連するチャレンジ・ハンドラーの `handleSuccess` メソッドまたは `handleFailure` メソッド**も**呼び出されます。

クライアントが既にログインしているか、*記憶されている* 状態である場合、API は成功をトリガーします。クライアントがログインしていない場合、セキュリティー検査はチャレンジを返信します。

`obtainAccessToken` API は、**スコープ**を受け入れます。スコープは、**セキュリティー検査**の名前にできます。

> **スコープ**について詳しくは、[許可の概念](../../)チュートリアルを参照してください。

## 認証済みユーザーの取得
{: #retrieving-the-authenticated-user }
チャレンジ・ハンドラー `handleSuccess` メソッドは `JSONObject identity` をパラメーターとして受け入れます。
セキュリティー検査が `AuthenticatedUser` を設定した場合、このオブジェクトにはユーザーのプロパティーが含まれます。現行ユーザーを保存するには、`handleSuccess` を使用できます。

```java
@Override
public void handleSuccess(JSONObject identity) {
    super.handleSuccess(identity);
    isChallenged = false;
    try {
        //Save the current user
        SharedPreferences preferences = context.getSharedPreferences(Constants.PREFERENCES_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(Constants.PREFERENCES_KEY_USER, identity.getJSONObject("user").toString());
        editor.commit();
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

ここで、`identity` には `user` というキーがあり、これ自身も `AuthenticatedUser` を表す `JSONObject` を含んでいます。

```json
{
  "user": {
    "id": "john",
    "displayName": "john",
    "authenticatedAt": 1455803338008,
    "authenticatedBy": "UserLogin"
  }
}
```

## ログアウト
{: #logout }
{{site.data.keys.product }} SDK は、特定のセキュリティー検査からログアウトするための `logout` API も提供しています。

```java
WLAuthorizationManager.getInstance().logout(securityCheckName, new WLLogoutResponseListener() {
    @Override
    public void onSuccess() {
        Log.d(securityCheckName, "Logout Success");
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.d(securityCheckName, "Logout Failure");
    }
});
```

## サンプル・アプリケーション
{: #sample-applications }
このチュートリアルには、以下の 2 つのサンプルが関連付けられています。

- **PreemptiveLoginAndroid**: プリエンプティブ `login` API を使用して、常にログイン画面から開始するアプリケーション。
- **RememberMeAndroid**: *「ユーザーを記憶する (Remember Me)」*チェック・ボックスがあるアプリケーション。ユーザーは、次にアプリケーションを開くとき、ログイン画面をバイパスできます。

両方のサンプルが、**SecurityCheckAdapters** アダプター Maven プロジェクトに含まれる同じ `UserLogin` セキュリティー検査を使用します。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityCheckAdapters Maven プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeAndroid/tree/release80) して Remember Me プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginAndroid/tree/release80) して Preemptive Login プロジェクトをダウンロードします。

### サンプルの使用法
{: sample-usage }
サンプルの README.md ファイルの指示に従ってください。  
アプリケーションのユーザー名/パスワードは一致しなければなりません (すなわち、"john"/"john")。

![サンプル・アプリケーション](sample-application.png)
