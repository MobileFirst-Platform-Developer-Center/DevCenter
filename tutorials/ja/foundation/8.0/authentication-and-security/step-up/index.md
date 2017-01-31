---
layout: tutorial
title: ステップアップ認証
breadcrumb_title: ステップアップ認証
relevantTo: [android,ios,windows,javascript]
weight: 5
downloads:
  - name: Cordova プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80
  - name: iOS Swift プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80
  - name: Android プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80
  - name: Win8 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80
  - name: Win10 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80
  - name: Web プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80
  - name: SecurityCheck Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
リソースは、いくつかのセキュリティー検査によって保護されている場合があります。そのようなシナリオでは、{{site.data.keys.mf_server }} は必要なチャレンジをすべて同時にアプリケーションに送信します。  

あるセキュリティー検査が別のセキュリティー検査に依存している場合もあります。したがって、チャレンジが送信されるタイミングを制御できることが重要になります。  
例えば、このチュートリアルで説明するアプリケーションは 2 つのリソースを使用します。リソースはいずれもユーザー名とパスワードによって保護されますが、2 番目のリソースは PIN コードも追加で必要とします。

**前提条件:** 続ける前に、[CredentialsValidationSecurityCheck](../credentials-validation) および [UserAuthenticationSecurityCheck](../user-authentication) のチュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [セキュリティー検査の参照](#referencing-a-security-check)
* [状態マシン](#state-machine)
* [Authorize メソッド](#the-authorize-method)
* [チャレンジ・ハンドラー](#challenge-handlers)
* [サンプル・アプリケーション](#sample-applications)

## セキュリティー検査の参照
{: #referencing-a-security-check }
2 つのセキュリティー検査、`StepUpPinCode` と `StepUpUserLogin` を作成します。これらの初期の実装は、[資格情報の検証](../credentials-validation/security-check/)および[ユーザー認証](../user-authentication/security-check/)のチュートリアルで説明している実装と同じものです。

この例の場合、`StepUpPinCode` は、`StepUpUserLogin` に**依存**します。ユーザーは、`StepUpUserLogin` に正常ログインできた場合に限り、PIN コードの入力を求められます。このような目的のため、`StepUpPinCode` は、`StepUpUserLogin` クラスを**参照**できなければなりません。  

{{site.data.keys.product_adj }} フレームワークは、参照を注入するためのアノテーションを提供しています。  
`StepUpPinCode` クラス内に、クラス・レベルで以下を追加します。

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **重要:** 両方のセキュリティー検査の実装が、同じアダプター内にバンドルされている必要があります。

この参照を解決するために、フレームワークは該当クラスのセキュリティー検査を検索し、その参照を従属セキュリティー検査に注入します。  
同じクラスのセキュリティー検査が複数存在する場合、アノテーションにはオプションの `name` パラメーターが付きます。このパラメーターを使用して、参照する検査の固有の名前を指定できます。

## 状態マシン
{: #state-machine }
`CredentialsValidationSecurityCheck` を継承するクラスはすべて (これには、`StepUpPinCode` と `StepUpUserLogin` の両方が含まれます)、シンプルな状態マシンを継承します。任意の一時点において、セキュリティー検査は以下のいずれかの状態になります。

- `STATE_ATTEMPTING`: チャレンジが送信され、セキュリティー検査はクライアント応答を待っています。この状態の間は、試行カウントが維持されます。
- `STATE_SUCCESS`: 資格情報が正常に検証されました。
- `STATE_BLOCKED`: 最大試行回数に達したため、検査はロック状態です。

現在の状態は、継承した `getState()` メソッドを使用して取得できます。

`StepUpUserLogin` 内に、ユーザーが現在ログイン状態であるかどうかをチェックする便利メソッドを追加します。
このメソッドは、後からチュートリアル内で使用します。

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## Authorize メソッド
{: #the-authorize-method }
`SecurityCheck` インターフェースによって、`authorize` というメソッドが定義されます。このメソッドが、チャレンジの送信や要求の検証など、セキュリティー検査のメイン・ロジックを実装する責任を負います。  
`StepUpPinCode` が継承するクラス `CredentialsValidationSecurityCheck` には、このメソッドの実装が既に組み込まれています。しかし、このケースでは、`authorize` メソッドのデフォルトの振る舞いを開始する前に、`StepUpUserLogin` の状態をチェックするという目標があります。

そのために、`authorize` メソッドを以下のように**オーバーライド**します。

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

この実装は、`StepUpUserLogin` 参照の現在の状態をチェックします。

* 状態が `STATE_SUCCESS` の場合は (ユーザーがログイン状態)、セキュリティー検査の通常フローが続きます。
* `StepUpUserLogin` がそれ以外の状態の場合は、何も行われません。すなわち、チャレンジは送信されず、成功も失敗もありません。

リソースが `StepUpPinCode` と `StepUpUserLogin` の**両方**によって保護されているという前提で、このフローは、ユーザーに 2 番目の資格情報 (PIN コード) を求めるプロンプトを出す前に、ユーザーがログイン状態であることを確認します。両方のセキュリティー検査がアクティブになっても、クライアントが両方のチャレンジを同時に受け取ることはありません。

代わりに、リソースが `StepUpPinCode` **のみ**によって保護される (フレームワークがこのセキュリティー検査のみをアクティブにする) 場合には、`authorize` 実装を変更して、手動で `StepUpUserLogin` をトリガーできます。

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        //If StepUpUserLogin is successful, continue the normal processing of StepUpPinCode
        super.authorize(scope, credentials, request, response);
    } else {
        //In any other case, process StepUpUserLogin instead.
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## 現行ユーザーの取得
{: #retrieve-current-user }
`StepUpPinCode` セキュリティー検査では、現行ユーザーの PIN コードを所定のデータベース内でルックアップできるように、現行ユーザーの ID を知る必要があります。

`StepUpUserLogin` セキュリティー検査内に、以下のメソッドを追加して、**許可コンテキスト**から現行ユーザーを取得します。

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

これで、`StepUpPinCode` 内で `userLogin.getUser()` メソッドを使用して、`StepUpUserLogin` セキュリティー検査から現行ユーザーを取得し、この特定のユーザーの有効な PIN コードをチェックできます。

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    //Get the correct PIN code from the database
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## チャレンジ・ハンドラー
{: #challenge-handlers }
クライアント・サイドには、複数のステップを処理する特別な API はありません。代わりに、各チャレンジ・ハンドラーがそれぞれのチャレンジを処理します。この例の場合、2 つのチャレンジ・ハンドラーを個別に登録する必要があります。1 つは、`StepUpUserLogin` からのチャレンジを処理するもの、もう 1 つは、`StepUpPincode` からのチャレンジを処理するものです。

<img alt="ステップアップ・サンプル・アプリケーション" src="sample_application.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-applications }
### セキュリティー検査
{: #security-check }
`StepUpUserLogin` および `StepUpPinCode` セキュリティー検査は、StepUp Maven プロジェクトの下にある SecurityChecks プロジェクトで入手できます。
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) してセキュリティー検査 Maven プロジェクトをダウンロードします。

### アプリケーション
{: #applications }
iOS (Swift)、Android、Windows 8.1/10、Cordova、および Web 用のサンプル・アプリケーションを使用できます。

* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80) して Cordova プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80) iOS Swift プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80) して Android プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80) して Windows 8.1 プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80) して Windows 10 プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80) して Web アプリケーション・プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
