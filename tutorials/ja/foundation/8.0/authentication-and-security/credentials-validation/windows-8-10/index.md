---
layout: tutorial
title: Windows 8.1 Universal アプリケーションおよび Windows 10 UWP アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Win8 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80
  - name: Win10 プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80
  - name: SecurityCheck Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
保護リソースへのアクセスを試みると、クライアントにはサーバー (セキュリティー検査) から、クライアントが対処する必要がある 1 つ以上の**チャレンジ**を含んだリストが返信されます。  
このリストは、`JSON` オブジェクトとして届けられ、セキュリティー検査名とともにオプションで追加データの `JSON` がリストされています。

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
{: #creating-the-challenge-handler }
チャレンジ・ハンドラーは、{{ site.data.keys.mf_server }} によって送信されるチャレンジを処理するクラスです。例えば、ログイン画面を表示したり、資格情報を収集したり、それらを元のセキュリティー検査に送信したりします。

この例の場合、セキュリティー検査は `PinCodeAttempts` であり、これは [CredentialsValidationSecurityCheck の実装](../security-check)で定義したものです。このセキュリティー検査によって送信されるチャレンジには、ログインを試行できる残りの回数 (`remainingAttempts`) と、オプションで `errorMsg` が含まれます。

`Worklight.SecurityCheckChallengeHandler` を継承する C# クラスを作成します。

```csharp
public class PinCodeChallengeHandler : Worklight.SecurityCheckChallengeHandler
{
}
```

## チャレンジの処理
{: #handling-the-challenge }
`SecurityCheckChallengeHandler` クラスが求める最小要件は、コンストラクターおよび `HandleChallenge` メソッドを実装することです。このメソッドは、ユーザーに資格情報の提出を求める責任があります。`HandleChallenge` メソッドは、`Object` としてチャレンジを受け取ります。

コンストラクター・メソッドを追加します。

```csharp
public PinCodeChallengeHandler(String securityCheck) {
    this.securityCheck = securityCheck;
}
```

この `HandleChallenge` の例では、PIN コードの入力をユーザーに要求するアラートが出されます。

```csharp
public override void HandleChallenge(Object challenge)
{
    try
    {
      JObject challengeJSON = (JObject)challenge;

      if (challengeJSON.GetValue("errorMsg") != null)
      {
          if (challengeJSON.GetValue("errorMsg").Type == JTokenType.Null)
              errorMsg = "This data requires a PIN Code.\n";
      }

      await CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
           async () =>
           {
               _this.HintText.Text = "";
               _this.LoginGrid.Visibility = Visibility.Visible;
               if (errorMsg != "")
               {
                   _this.HintText.Text = errorMsg + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }
               else
               {
                   _this.HintText.Text = challengeJSON.GetValue("errorMsg") + "\n" + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }

               _this.GetBalance.IsEnabled = false;
           });
    } catch (Exception e)
    {
        Debug.WriteLine(e.StackTrace);
    }
}
```

> `showChallenge` の実装がサンプル・アプリケーションに組み込まれています。

資格情報が正しくない場合、フレームワークによって再度 `HandleChallenge` が呼び出されます。

## チャレンジ応答の送信
{: #submitting-the-challenges-answer }
UI から資格情報が収集された後は、`SecurityCheckChallengeHandler` の `ShouldSubmitChallengeAnswer()` メソッドと `GetChallengeAnswer()` メソッドを使用して、セキュリティー検査に応答を返信します。`ShouldSubmitChallengeAnswer()` は、セキュリティー検査にチャレンジ応答を返信する必要があるかどうかを示すブール値を返します。この例の場合、`PinCodeAttempts` は、提供された PIN コードを含んでいる `pin` というプロパティーを必要とします。

```csharp
public override bool ShouldSubmitChallengeAnswer()
{
  JObject pinJSON = new JObject();
  pinJSON.Add("pin", pinCodeTxt.Text);
  this.challengeAnswer = pinJSON;
  return this.shouldsubmitchallenge;
}

public override JObject GetChallengeAnswer()
{
  return this.challengeAnswer;
}

```

## チャレンジのキャンセル
{: #cancelling-the-challenge }
UI で**「キャンセル」**ボタンがクリックされたときなど、フレームワークに対して、このチャレンジを完全に破棄するように指示する必要が生じる場合があります。

これを実現するには、`ShouldCancel` メソッドをオーバーライドします。


```csharp
public override bool ShouldCancel()
{
  return shouldsubmitcancel;
}
```

## チャレンジ・ハンドラーの登録
{: #registering-the-challenge-handler }
チャレンジ・ハンドラーが正しいチャレンジを listen するためには、フレームワークに対して、チャレンジ・ハンドラーと特定のセキュリティー検査名を関連付けるように指示する必要があります。

そのためには、以下のようにセキュリティー検査を指定してチャレンジ・ハンドラーを初期設定します。

```csharp
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts");
```

次に、チャレンジ・ハンドラー・インスタンスを**登録**する必要があります。

```csharp
IWorklightClient client = WorklightClient.createInstance();
client.RegisterChallengeHandler(pinCodeChallengeHandler);
```

## サンプル・アプリケーション
{: #sample-application }
**PinCodeWin8** および **PinCodeWin10** のサンプルは、`ResourceRequest` を使用して銀行の残高を照会する C# アプリケーションです。  
このメソッドは、PIN コードと、最大 3 回までの試行によって保護されています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityCheckAdapters Maven プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80) して Windows 8 プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80) して Windows 10 UWP プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。

![サンプル・アプリケーション](sample-application.png)   
