---
layout: tutorial
title: iOS アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: iOS
relevantTo: [ios]
weight: 3
downloads:
  - name: Download PreemptiveLogin project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginSwift/tree/release80
  - name: Download RememberMe project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeSwift/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**前提条件:** **CredentialsValidationSecurityCheck** [チャレンジ・ハンドラー実装](../../credentials-validation/ios/)のチュートリアルをお読みください。

このチャレンジ・ハンドラーのチュートリアルでは、プリエンプティブ `login`、`logout`、および `obtainAccessTokenForScope` など、いくつかの追加機能 (API) を例示します。

## ログイン
{: #login }
この例では、`UserLogin` は `username` と `password` という *key:value* を必要とします。 オプションで、ブール型の `rememberMe` キーも受け入れます。これは、このユーザーを長期間記憶しておくようにセキュリティー検査に指示するためのものです。サンプル・アプリケーションの場合、この情報はログイン・フォームのチェック・ボックスからブール値を使用して収集されます。

`credentials` 引数は、`username`、`password`、および `rememberMe` を含んでいる `JSONObject` です。

```swift
self.submitChallengeAnswer(credentials);
```

チャレンジを何も受け取っていない場合でもユーザーのログインを可能にする必要がある場合があります。 例えば、アプリケーションの最初の画面としてログイン画面を表示したり、ログアウト後やログイン失敗後にログイン画面を表示したりできます。 このようなシナリオを**プリエンプティブ・ログイン**と呼びます。

応答すべきチャレンジがない場合、`submitChallengeAnswer` API を呼び出すことはできません。 そのようなシナリオ用に、{{ site.data.keys.product }} SDK には `login` API が組み込まれています。

```swift
WLAuthorizationManager.sharedInstance().login(self.securityCheckName, withCredentials: credentials) { (error) -> Void in
  if(error != nil){
    NSLog("Login Preemptive Failure: " + String(error))
  }
  else {
    NSLog("Login Preemptive Success")
  }
}
```

資格情報に問題がある場合、セキュリティー検査は**チャレンジ**を返信します。

アプリケーションのニーズに応じて、どのような場合に `submitChallengeAnswer` でなく `login` を使用するかを判断することは開発者の責任です。 これを実現する方法の 1 つとして、ブール値のフラグ (例えば、`isChallenged`) を定義し、`handleChallenge` に到達したときにフラグを `true` に設定し、それ以外のケース (失敗、成功、初期設定時など) では `false` に設定する方法があります。

ユーザーが**「ログイン」**ボタンをクリックした時点で、使用すべき API が動的に選択されます。

```swift
if(!self.isChallenged){
  WLAuthorizationManager.sharedInstance().login(self.securityCheckName, withCredentials: credentials) { (error) -> Void in}
}
else{
  self.submitChallengeAnswer(credentials)
}
```

> **注:**
> `WLAuthorizationManager` `login()` API には、独自の完了ハンドラーがあり、関連するチャレンジ・ハンドラーの `handleSuccess` メソッドまたは `handleFailure` メソッド**も**呼び出されます。

## アクセス・トークンの取得
{: #obtaining-an-access-token }
このセキュリティー検査は **RememberMe** 機能 (`rememberMe` ブール・キー) をサポートしているため、アプリケーションの開始時に、クライアントがログインしているかどうかをチェックすると役立ちます。

{{ site.data.keys.product }} SDK は、サーバーに有効なトークンを尋ねるための `obtainAccessTokenForScope` API を提供しています。

```swift
WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(scope) { (token, error) -> Void in
  if(error != nil){
    NSLog("obtainAccessTokenForScope failed: " + String(error))
  }
  else{
    NSLog("obtainAccessTokenForScope success")
  }
}
```

> **注:**
> `WLAuthorizationManager` `obtainAccessTokenForScope()` API には、独自の完了ハンドラーがあり、関連するチャレンジ・ハンドラーの `handleSuccess` または `handleFailure` **も**呼び出されます。

クライアントが既にログインしているか、*記憶されている* 状態である場合、API は成功をトリガーします。 クライアントがログインしていない場合、セキュリティー検査はチャレンジを返信します。

`obtainAccessTokenForScope` API は、**スコープ**を受け入れます。 スコープは、**セキュリティー検査**の名前にできます。

> **スコープ**について詳しくは、[許可の概念](../../)チュートリアルを参照してください。

## 認証済みユーザーの取得
{: #retrieving-the-authenticated-user }
チャレンジ・ハンドラー `handleSuccess` メソッドは、ディクショナリー `success` をパラメーターとして受け取ります。
セキュリティー検査が `AuthenticatedUser` を設定した場合、このオブジェクトにはユーザーのプロパティーが含まれます。 現行ユーザーを保存するには、`handleSuccess` を使用できます。

```swift
override func handleSuccess(success: [NSObject : AnyObject]!) {
  self.isChallenged = false
  self.defaults.setObject(success["user"]!["displayName"]! as! String, forKey: "displayName")
}
```

ここで、`success` には `user` というキーがあり、これ自身も `AuthenticatedUser` を表すディクショナリーを含んでいます。

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
{{ site.data.keys.product }} SDK は、特定のセキュリティー検査からログアウトするための `logout` API も提供しています。

```swift
WLAuthorizationManager.sharedInstance().logout(self.securityCheckName){ (error) -> Void in
  if(error != nil){
    NSLog("Logout Failure: " + String(error))
  }
}
```

## サンプル・アプリケーション
{: #sample-applications }
このチュートリアルには、以下の 2 つのサンプルが関連付けられています。

- **PreemptiveLoginSwift**: プリエンプティブ `login` API を使用して、常にログイン画面から開始するアプリケーション。
- **RememberMeSwift**: *「ユーザーを記憶する (Remember Me)」*チェック・ボックスがあるアプリケーション。 ユーザーは、次にアプリケーションを開くとき、ログイン画面をバイパスできます。

両方のサンプルが、**SecurityCheckAdapters** アダプター Maven プロジェクトに含まれる同じ `UserLogin` セキュリティー検査を使用します。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityCheckAdapters Maven プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeSwift/tree/release80) して Remember Me プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginSwift/tree/release80) して Preemptive Login プロジェクトをダウンロードします。  

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。  
アプリケーションのユーザー名/パスワードは一致しなければなりません (すなわち、"john"/"john")。

![サンプル・アプリケーション](sample-application.png)

