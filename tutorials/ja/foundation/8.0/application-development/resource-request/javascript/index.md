---
layout: tutorial
title: JavaScript (Cordova、Web) アプリケーションからのリソース要求
breadcrumb_title: JavaScript
relevantTo: [javascript]
downloads:
  - name: Web プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80
  - name: Cordova プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80
  - name: アダプター Maven プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{site.data.keys.product_adj }} アプリケーションは `WLResourceRequest` REST API を使用してリソースにアクセスできます。  
REST API は、すべてのアダプターおよび外部リソースで機能します。

**前提条件**:

- Cordova アプリケーションを実装する場合は、必ずご使用の Cordova アプリケーションに [{{site.data.keys.product }} SDK](../../../application-development/sdk/cordova) を追加しておいてください。
- Web アプリケーションを実装する場合は、必ずご使用の Web アプリケーションに [{{site.data.keys.product }} SDK](../../../application-development/sdk/web) を追加しておいてください。
- [アダプターの作成](../../../adapters/creating-adapters/)方法を参照してください。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` クラスは、アダプターまたは外部リソースに対するリソース要求を処理します。

 `WLResourceRequest` オブジェクトを作成し、リソースへのパスと HTTP メソッドを指定します。  
使用可能なメソッドは、`WLResourceRequest.GET`、`WLResourceRequest.POST`、`WLResourceRequest.PUT`、および `WLResourceRequest.DELETE` です。

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaAdapter/users",
    WLResourceRequest.GET
);
```

* **JavaScript アダプター** の場合は、`/adapters/{AdapterName}/{procedureName}` を使用します。
* **Java アダプター**の場合は、`/adapters/{AdapterName}/{path}` を使用します。`path` は、Java コードで `@Path` アノテーションをどのように定義したかによって決まります。これには、使用した `@PathParam` も含まれます。
* プロジェクトの外部にあるリソースにアクセスするには、外部サーバーの要件のとおりに完全な URL を使用してください。
* **タイムアウト**: オプション。ミリ秒単位の要求タイムアウトです。

## 要求の送信
{: #sending-the-request }
`send()` メソッドを使用してリソースを要求します。  
`send()` メソッドは、HTTP 要求に本体を設定するためのオプション・パラメーターを使用します。この本体は、JSON オブジェクトまたは単純なストリングの場合があります。

JavaScript の **promises** を使用して、`onSuccess` および `onFailure` のコールバック関数を定義できます。

```js
resourceRequest.send().then(
    onSuccess,
    onFailure
)
```

### setQueryParameter
{: #setqueryparameter }
`setQueryParameter` メソッドを使用すると、照会 (URL) パラメーターを REST 要求に含めることができます。

```js
resourceRequest.setQueryParameter("param1", "value1");
resourceRequest.setQueryParameter("param2", "value2");
```

#### JavaScript アダプター
{: #javascript-adapters-setquery}
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

> **注:** `params` 値は、配列の*ストリング表現*でなければなりません。

```js
resourceRequest.setQueryParameter("params", "['value1', 'value2']");
```

これは、`WLResourceRequest.GET` と一緒に使用してください。

### setHeader
{: #setheader }
`setHeader` メソッドを使用して、REST 要求で新規 HTTP ヘッダーを設定したり、既存のヘッダーを同じ名前で置換したりすることができます。

```js
resourceRequest.setHeader("Header-Name","value");
```

### sendFormParameters(json)
{: #sendformparamtersjson }
URL エンコード形式のパラメーターを送信するには、代わりに `sendFormParameters(json)`メソッドを使用します。このメソッドは、JSON を URL エンコードのストリングに変換し、`content-type` を `application/x-www-form-urlencoded` に設定して、それを HTTP 本体として設定します。

```js
var formParams = {"param1": "value1", "param2": "value2"};
resourceRequest.sendFormParameters(formParams);
```

#### JavaScript アダプター
{: #javascript-adapters-sendform }
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

```js
var formParams = {"params":"['value1', 'value2']"};
```

これは、`WLResourceRequest.POST` と一緒に使用してください。


> `WLResourceRequest` について詳しくは、ユーザー文書の API リファレンスを参照してください。

## 応答
{: #the-response }
`onSuccess` と `onFailure` の両方のコールバックは、`response` オブジェクトを受け取ります。`response` オブジェクトには応答データが含まれており、そのプロパティーを使用して必要な情報を取得することができます。よく使用されるプロパティーは、`responseText`、`responseJSON`(応答が JSON の場合は JSON オブジェクト)、および `status` (応答の HTTP 状況) です。

要求が失敗した場合、`response` オブジェクトには `errorMsg` プロパティーも含まれます。  
Java アダプターを使用しているか、JavaScript アダプターを使用しているかに応じて、応答には、`responseHeaders`、`responseTime`、`statusCode`、`statusReason`、`totalTime` などの他のプロパティーが含まれる場合があります。

```json
{
  "responseHeaders": {
    "Content-Type": "application/json",
    "X-Powered-By": "Servlet/3.1",
    "Content-Length": "86",
    "Date": "Mon, 15 Feb 2016 21:12:08 GMT"
  },
  "status": 200,
  "responseText": "{\"height\":\"184\",\"last\":\"Doe\",\"Date\":\"1984-12-12\",\"age\":31,\"middle\":\"C\",\"first\":\"John\"}",
  "responseJSON": {
    "height": "184",
    "last": "Doe",
    "Date": "1984-12-12",
    "age": 31,
    "middle": "C",
    "first": "John"
  },
  "invocationContext": null
}
```

### 応答の処理
{: #handling-the-response }
応答オブジェクトは、`onSuccess` および `onFailure` のコールバック関数によって受信されます。  
例えば、次のとおりです。


```js
onSuccess: function(response) {
    resultText = "Successfully called the resource: " + response.responseText;
},

onFailure: function(response) {
    resultText = "Failed to call the resource:" + response.errorMsg;
}
```

## 詳細情報
{: #for-more-information }
> WLResourceRequest について詳しくは、[API リファレンスを参照してください](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html)。

<img alt="サンプル・アプリケーションのイメージ" src="resource-request-success-cordova.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-applications }
**ResourceRequestWeb** プロジェクトおよび **ResourceRequestCordova** プロジェクトは、Java アダプターを使用したリソース要求を例示します。  
アダプター Maven プロジェクトには、リソース要求呼び出し中に使用される Java アダプターが含まれています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestCordova/tree/release80) して Cordova プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWeb/tree/release80) して Web プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
