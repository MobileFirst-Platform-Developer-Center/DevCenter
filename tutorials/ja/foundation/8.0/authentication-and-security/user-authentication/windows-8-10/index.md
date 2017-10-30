---
layout: tutorial
title: Windows 8.1 Universal アプリケーションおよび Windows 10 UWP アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: RememberMe Win8 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80
  - name: RememberMe Win10 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80
  - name: PreemptiveLogin Win8 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80
  - name: PreemptiveLogin Win10 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80
  - name: SecurityCheck Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**前提条件:** **CredentialsValidationSecurityCheck** [チャレンジ・ハンドラー実装](../../credentials-validation/windows-8-10)のチュートリアルをお読みください。

このチャレンジ・ハンドラーのチュートリアルでは、プリエンプティブ `Login`、`Logout`、および `ObtainAccessToken` など、いくつかの追加機能 (API) を例示します。

## ログイン
{: #login }
この例では、`UserLoginSecurityCheck` は `username` と `password` という *key:value* を必要とします。オプションで、ブール型の `rememberMe` キーも受け入れます。これは、このユーザーを長期間記憶しておくようにセキュリティー検査に指示するためのものです。サンプル・アプリケーションの場合、この情報はログイン・フォームのチェック・ボックスからブール値を使用して収集されます。

`credentials` 引数は、`username`、`password`、および `rememberMe` を含んでいる `JSONObject` です。

```csharp
public override void SubmitChallengeAnswer(object answer)
{
    challengeAnswer = (JObject)answer;
}
```

チャレンジを何も受け取っていない場合でもユーザーのログインを可能にする必要がある場合があります。例えば、アプリケーションの最初の画面としてログイン画面を表示したり、ログアウト後やログイン失敗後にログイン画面を表示したりできます。このようなシナリオを**プリエンプティブ・ログイン**と呼びます。

応答すべきチャレンジが存在しない場合、`challengeAnswer` API を呼び出すことはできません。そのようなシナリオ用に、{{ site.data.keys.product }} SDK には `Login` API が組み込まれています。

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(String securityCheckName, JObject credentials);
```

資格情報に問題がある場合、セキュリティー検査は**チャレンジ**を返信します。

アプリケーションのニーズに応じて、どのような場合に `challengeAnswer` でなく `Login` を使用するかを判断することは開発者の責任です。これを実現する方法の 1 つとして、ブール値のフラグ (例えば、`isChallenged`) を定義し、`HandleChallenge` に到達したときにフラグを `true` に設定し、それ以外のケース (失敗、成功、初期設定時など) では `false` に設定する方法があります。

ユーザーが**「ログイン」**ボタンをクリックした時点で、使用すべき API が動的に選択されます。

```csharp
public async void login(JSONObject credentials)
{
    if(isChallenged)
    {
        challengeAnswer= credentials;
    }
    else
    {
        WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(securityCheckName, credentials);
    }
}
```
## アクセス・トークンの取得
{: #obtaining-an-access-token }
このセキュリティー検査は **RememberMe** 機能 (`rememberMe` ブール・キー) をサポートしているため、アプリケーションの開始時に、クライアントがログインしているかどうかをチェックすると役立ちます。

{{ site.data.keys.product }} SDK は、サーバーに有効なトークンを尋ねるための `ObtainAccessToken` API を提供しています。

```csharp
WorklightAccessToken accessToken = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.ObtainAccessToken(String scope);

if(accessToken.IsValidToken &&  accessToken.Value != null &&  accessToken.Value != "")
{
  Debug.WriteLine("Auto login success");
}
else
{
  Debug.WriteLine("Auto login failed");
}

```

クライアントが既にログインしているか、*記憶されている* 状態である場合、API は成功をトリガーします。クライアントがログインしていない場合、セキュリティー検査はチャレンジを返信します。

`ObtainAccessToken` API は、**スコープ**を受け入れます。スコープは、**セキュリティー検査**の名前にできます。

> **スコープ**について詳しくは、[許可の概念](../../)チュートリアルを参照してください。

## 認証済みユーザーの取得
{: #retrieving-the-authenticated-user }
チャレンジ・ハンドラー `HandleSuccess` メソッドは、`JObject identity` をパラメーターとして受け取ります。
セキュリティー検査が `AuthenticatedUser` を設定した場合、このオブジェクトにはユーザーのプロパティーが含まれます。現行ユーザーを保存するには、`HandleSuccess` を使用できます。

```csharp
public override void HandleSuccess(JObject identity)
{
    isChallenged = false;
    try
    {
        //Save the current user
        var localSettings = Windows.Storage.ApplicationData.Current.LocalSettings;
        localSettings.Values["useridentity"] = identity.GetValue("user");

    } catch (Exception e) {
Debug.WriteLine(e.StackTrace);
    }
}
```

ここで、`identity` には `user` というキーがあり、これ自身も `AuthenticatedUser` を表す `JObject` を含んでいます。

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
{{ site.data.keys.product }} SDK は、特定のセキュリティー検査からログアウトするための `Logout` API も提供しています。

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Logout(securityCheckName);
```

## サンプル・アプリケーション
{: #sample-applications }
このチュートリアルには、以下の 2 つのサンプルが関連付けられています。

- **PreemptiveLoginWin**: プリエンプティブ `Login` API を使用して、常にログイン画面から開始するアプリケーション。
- **RememberMeWin**: *「ユーザーを記憶する (Remember Me)」*チェック・ボックスがあるアプリケーション。ユーザーは、次にアプリケーションを開くとき、ログイン画面をバイパスできます。

両方のサンプルが、**SecurityCheckAdapters** アダプター Maven プロジェクトに含まれる同じ `UserLoginSecurityCheck` を使用します。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityCheckAdapters Maven プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80) して Remember Me Win8 プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80) して Remember Me Win10 プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80) して PreemptiveLogin Win8 プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80) して PreemptiveLoginWin10 プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
アプリケーションのユーザー名/パスワードは一致しなければなりません (すなわち、"john"/"john")。

![サンプル・アプリケーション](RememberMe.png)
