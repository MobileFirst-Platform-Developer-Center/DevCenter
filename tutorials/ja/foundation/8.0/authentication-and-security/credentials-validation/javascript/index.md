---
layout: tutorial
title: JavaScript (Cordova、Web) アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Web プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80
  - name: Cordova プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80
  - name: SecurityCheck Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
保護リソースへのアクセスを試みると、クライアントにはサーバー (セキュリティー検査) から、クライアントが対処する必要がある 1 つ以上の**チャレンジ**を含んだリストが返信されます。  
このリストは、`JSON object` として届けられ、セキュリティー検査名とともにオプションで追加データの `JSON` がリストされています。

```json
{
  "challenges": {
"SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

その後、クライアントは、セキュリティー検査ごとに**チャレンジ・ハンドラー**を登録する必要があります。  
チャレンジ・ハンドラーによって、そのセキュリティー検査特定のクライアント・サイドの動作が定義されます。

## チャレンジ・ハンドラーの作成
{: creating-the-challenge-handler }
チャレンジ・ハンドラーは、{{ site.data.keys.mf_server }} によって送信されるチャレンジを処理します。例えば、ログイン画面を表示したり、資格情報を収集したり、それらを元のセキュリティー検査に送信したりします。

この例の場合、セキュリティー検査は `PinCodeAttempts` であり、これは [CredentialsValidationSecurityCheck の実装](../security-check)で定義したものです。このセキュリティー検査によって送信されるチャレンジには、ログインを試行できる残りの回数 (`remainingAttempts`) と、オプションで `errorMsg` が含まれます。


`WL.Client.createSecurityCheckChallengeHandler()` API メソッドを使用して、チャレンジ・ハンドラーを作成し、登録します。

```javascript
PinCodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## チャレンジの処理
{: #handling-the-challenge }
`createSecurityCheckChallengeHandler` プロトコルが求める最小要件は、`handleChallenge()` メソッドを実装することです。このメソッドは、ユーザーに資格情報の提示を求める責任があります。`handleChallenge` メソッドは、`JSON` オブジェクトとしてチャレンジを受け取ります。

この例では、PIN コードの入力をユーザーに要求するアラートが出されます。

```javascript
PinCodeChallengeHandler.handleChallenge = function(challenge) {
    var msg = "";

    // Create the title string for the prompt
    if(challenge.errorMsg != null) {
        msg =  challenge.errorMsg + "\n";
    } else {
        msg = "This data requires a PIN code.\n";
    }

    msg += "Remaining attempts: " + challenge.remainingAttempts;

    // Display a prompt for user to enter the pin code     
    var pinCode = prompt(msg, "");

    if(pinCode){ // calling submitChallengeAnswer with the entered value
        PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
    } else { // calling cancel in case user pressed the cancel button
        PinCodeChallengeHandler.cancel();   
    }                            
};
```

資格情報が正しくない場合、フレームワークによって再度 `handleChallenge` が呼び出されます。

## チャレンジ応答の送信
{: #submitting-the-challenges-answer }
UI から資格情報が収集された後は、`createSecurityCheckChallengeHandler` の `submitChallengeAnswer()` を使用して、セキュリティー検査に応答を返信します。この例の場合、`PinCodeAttempts` は、提供された PIN コードを含んでいる `pin` というプロパティーを必要とします。

```javascript
PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
```

## チャレンジのキャンセル
{: #cancelling-the-challenge }
UI で**「キャンセル」**ボタンがクリックされたときなど、フレームワークに対して、このチャレンジを完全に破棄するように指示する必要が生じる場合があります。  
これを実現するには、以下を呼び出します。

```javascript
PinCodeChallengeHandler.cancel();
```

## 失敗の処理
{: #handling-failures }
一部のシナリオでは、失敗がトリガーされる可能性があります (例えば、最大試行回数に達したときなど)。これらを処理するには、`createSecurityCheckChallengeHandler` の `handleFailure()` を実装します。  
パラメーターとして渡される JSON オブジェクトの構造は、失敗の性質に大きく依存します。

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure && error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
alert("Error! " + JSON.stringify(error));
    }
};
```

## 成功の処理
{: #handling-successes }
一般的に、成功の場合は、アプリケーションの残りの処理を続行できるように、フレームワークによって自動的に処理されます。

オプションで、`createSecurityCheckChallengeHandler` の `handleSuccess()` を実装すると、フレームワークがチャレンジ・ハンドラー・フローを閉じる前に、何かの処理を行うようにできます。この場合も、`success` JSON オブジェクトのコンテンツおよび構造は、セキュリティー検査が送信する内容に依存します。

`PinCodeAttemptsCordova` サンプル・アプリケーションの場合、success には追加のデータは含まれていません。

## チャレンジ・ハンドラーの登録
{: #registering-the-challenge-handler }
チャレンジ・ハンドラーが正しいチャレンジを listen するためには、フレームワークに対して、チャレンジ・ハンドラーと特定のセキュリティー検査名を関連付けるように指示する必要があります。  
そのためには、以下のようにセキュリティー検査を指定したチャレンジ・ハンドラーを作成します。

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## サンプル・アプリケーション
{: #sample-applications }
**PinCodeWeb** プロジェクトと **PinCodeCordova** プロジェクトは、`WLResourceRequest` を使用して銀行の残高を照会します。  
このメソッドは、PIN コードと、最大 3 回までの試行によって保護されています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80) して Web プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80) して Cordova プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityAdapters Maven プロジェクトをダウンロードします。  

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。

![サンプル・アプリケーション](pincode-attempts-cordova.png)
