---
layout: tutorial
title: Android アプリケーションでのチャレンジ・ハンドラーの実装
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80
  - name: Download SecurityCheck Maven project
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

その後、クライアントは、セキュリティー検査ごとに**チャレンジ・ハンドラー**を登録しなければなりません。  
チャレンジ・ハンドラーによって、そのセキュリティー検査特定のクライアント・サイドの動作が定義されます。

## チャレンジ・ハンドラーの作成
{: #creating-the-challenge-handler }
チャレンジ・ハンドラーは、{{ site.data.keys.mf_server }} によって送信されるチャレンジを処理するクラスです。例えば、ログイン画面を表示したり、資格情報を収集したり、それらを元のセキュリティー検査に送信したりします。

この例の場合、セキュリティー検査は `PinCodeAttempts` であり、これは [CredentialsValidationSecurityCheck の実装](../security-check)で定義したものです。 このセキュリティー検査によって送信されるチャレンジには、ログインを試行できる残りの回数 (`remainingAttempts`) と、オプションで `errorMsg` が含まれます。

`SecurityCheckChallengeHandler` を継承する Java クラスを作成します。

```java
public class PinCodeChallengeHandler extends SecurityCheckChallengeHandler {

}
```

## チャレンジの処理
{: #handling-the-challenge }
`SecurityCheckChallengeHandler` プロトコルが求める最小要件は、コンストラクターおよび `handleChallenge` メソッドを実装することです。このメソッドは、ユーザーに対して資格情報を求めるプロンプトを出します。 `handleChallenge` メソッドは、`JSONObject` としてチャレンジを受け取ります。

コンストラクター・メソッドを追加します。

```java
public PinCodeChallengeHandler(String securityCheck) {
    super(securityCheck);
}
```

この `handleChallenge` の例では、PIN コードの入力をユーザーに要求するアラートが出されます。

```java
@Override
public void handleChallenge(JSONObject jsonObject) {
    Log.d("Handle Challenge", jsonObject.toString());
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_MSG);
    try{
        if (jsonObject.isNull("errorMsg")){
            intent.putExtra("msg", "This data requires a PIN code.\n Remaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("msg", jsonObject.getString("errorMsg") + "\nRemaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e){
        e.printStackTrace();
    }
}

```

> `alertMsg` の実装がサンプル・アプリケーションに組み込まれています。

資格情報が正しくない場合、フレームワークによって再度 `handleChallenge` が呼び出されます。

## チャレンジ応答の送信
{: #submitting-the-challenges-answer }
UI から資格情報が収集されたら、`SecurityCheckChallengeHandler` の `submitChallengeAnswer(JSONObject answer)` メソッドを使用して、セキュリティー検査に応答を返信します。 この例の場合、`PinCodeAttempts` は、提供された PIN コードを含んでいる `pin` というプロパティーを必要とします。

```java
submitChallengeAnswer(new JSONObject().put("pin", pinCodeTxt.getText()));
```

## チャレンジのキャンセル
{: #cancelling-the-challenge }
UI で**「キャンセル」**ボタンがクリックされたときなど、フレームワークに対して、このチャレンジを完全に破棄するように指示する必要が生じる場合があります。

これを実現するには、`SecurityCheckChallengeHandler` の `cancel()` メソッドを使用します。

## 失敗の処理
{: #handling-failures }
一部のシナリオでは、失敗がトリガーされる可能性があります (例えば、最大試行回数に達したときなど)。 これらを処理するには、`SecurityCheckChallengeHandler` の `handleFailure` メソッドを実装します。  
パラメーターとして渡される `JSONObject` の構造は、失敗の性質に大きく依存します。

```java
@Override
public void handleFailure(JSONObject jsonObject) {
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_ERROR);
    try {
        if (!jsonObject.isNull("failure")) {
            intent.putExtra("errorMsg", jsonObject.getString("failure"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("errorMsg", "Unknown error");
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e){
        e.printStackTrace();
    }
}
```

> `alertError` の実装がサンプル・アプリケーションに組み込まれています。

## 成功の処理
{: #handling-successes }
一般的に、成功の場合は、アプリケーションの残りの処理を続行できるように、フレームワークによって自動的に処理されます。

オプションで、`SecurityCheckChallengeHandler` の `handleSuccess` メソッドを実装すると、フレームワークがチャレンジ・ハンドラー・フローを閉じる前に、何かの処理を行うようにできます。 この場合も、パラメーターとして渡される `JSONObject` オブジェクトのコンテンツおよび構造は、セキュリティー検査が送信する内容に依存します。

`PinCodeAttempts` サンプル・アプリケーションの場合、`JSONObject` に追加のデータは含まれていないため、`handleSuccess` は実装されていません。

## チャレンジ・ハンドラーの登録
{: #registering-the-challenge-handler }
チャレンジ・ハンドラーが正しいチャレンジを listen するためには、フレームワークに対して、チャレンジ・ハンドラーと特定のセキュリティー検査名を関連付けるように指示する必要があります。

そのためには、以下のようにセキュリティー検査を指定してチャレンジ・ハンドラーを初期設定します。

```java
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts", this);
```

次に、チャレンジ・ハンドラー・インスタンスを**登録**する必要があります。

```java
WLClient client = WLClient.createInstance(this);
client.registerChallengeHandler(pinCodeChallengeHandler);
```

**注:** `WLClient` インスタンスの作成とチャレンジ・ハンドラーの登録は、アプリケーション・ライフサイクル全体の中で 1 回のみ実行します。 Android Application クラスを使用してこれを行うことをお勧めします。

## サンプル・アプリケーション
{: #sample-application }
サンプルの **PinCodeAndroid** は、`WLResourceRequest` を使用して銀行の残高を照会する Android アプリケーションです。  
このメソッドは、PIN コードと、最大 3 回までの試行によって保護されています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) して SecurityAdapters Maven プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80) して Android プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。

![サンプル・アプリケーション](sample-application-android.png)
