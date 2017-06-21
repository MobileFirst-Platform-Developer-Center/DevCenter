---
layout: tutorial
title: Windows アプリケーションからのリソース要求
breadcrumb_title: Windows
relevantTo: [windows]
downloads:
  - name: ネイティブ Windows 8 プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin8/tree/release80
  - name: ネイティブ Windows 10 プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin10/tree/release80
  - name: アダプター Maven プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_console }} アプリケーションは `WorklightResourceRequest` REST API を使用してリソースにアクセスできます。  
REST API は、すべてのアダプターおよび外部リソースで機能します。

**前提条件**:

- 必ずご使用のネイティブ [Windows 8.1 Universal または Windows 10 UWP](../../../application-development/sdk/windows-8-10) に {{ site.data.keys.product }} SDK を追加しておいてください。
- [アダプターの作成](../../../adapters/creating-adapters/)方法を参照してください。

## WLResourceRequest
{: #wlresourcerequest }
`WorklightResourceRequest` クラスは、アダプターまたは外部リソースに対するリソース要求を処理します。

 `WorklightResourceRequest` オブジェクトを作成し、リソースへのパスと HTTP メソッドを指定します。  
使用可能なメソッドは、`GET`、`POST`、`PUT`、および `DELETE` です。

```cs
URI adapterPath = new URI("/adapters/JavaAdapter/users",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.ResourceRequest(adapterPath,"GET");
```

* **JavaScript アダプター** の場合は、`/adapters/{AdapterName}/{procedureName}` を使用します。
* **Java アダプター**の場合は、`/adapters/{AdapterName}/{path}` を使用します。`path` は、Java コードで `@Path` アノテーションをどのように定義したかによって決まります。これには、使用した `@PathParam` も含まれます。
* プロジェクトの外部にあるリソースにアクセスするには、外部サーバーの要件のとおりに完全な URL を使用してください。
* **タイムアウト**: オプション。ミリ秒単位の要求タイムアウトです。
* **スコープ**: オプションです。どのスコープがリソースを保護しているのか分かっている場合は、このスコープを指定することで要求をより効率的にすることができます。

## 要求の送信
{: #sending-the-request }
`.send()` メソッドを使用してリソースを要求します。

```cs
WorklightResponse response = await request.send();
```

`WorklightResponse response` オブジェクトを使用して、アダプターから取り出されたデータを取得します。

`response` オブジェクトには応答データが含まれており、そのメソッドとプロパティーを使用して必要な情報を取得することができます。よく使用されるプロパティーは、`ResponseText`、`ResponseJSON` (応答が JSON の場合)、`Success` (呼び出しが成功の場合も失敗の場合も使用されます)、および `HTTPStatus` (応答の HTTP 状況) です。

## パラメーター
{: #parameters }
要求を送信する前に、必要に応じてパラメーターを追加したい場合があります。

### パス・パラメーター
{: #path-parameters }
上記の説明のとおり、**path** パラメーター (`/path/value1/value2`) は、`WorklightResourceRequest` オブジェクトの作成中に設定されます。

```cs
Uri adapterPath = new Uri("/adapters/JavaAdapter/users/value1/value2",UriKind.Relative);
WorklightResourceRequest request = WorklightClient.createInstance(adapterPath,"GET");
```

### 照会パラメーター
{: #query-parameters }
**query** パラメーター (`/path?param1=value1...`) を送信するには、パラメーターごとに `SetQueryParameter` メソッドを使用します。

```cs
request.SetQueryParameter("param1","value1");
request.SetQueryParameter("param2","value2");
```

#### JavaScript アダプター
{: #javascript-adapters-query }
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

```cs
request.SetQueryParameter("params","['value1', 'value2']");
```

これは、`GET` と一緒に使用してください。

### フォーム・パラメーター
{: #form-parameters }
本体内のフォーム・パラメーターを送信するには、`.Send()` ではなく `.Send(Dictionary<string, string> formParameters)` を使用します。  

```cs
Dictionary<string,string> formParams = new Dictionary<string,string>();
formParams.Add("height", height.getText().toString());
request.Send(formParams);
```   

#### JavaScript アダプター
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

```cs
formParams.Add("params","['value1', 'value2']");
```

これは、`POST` と一緒に使用してください。

### ヘッダー・パラメーター
{: #header-parameters }
HTTP ヘッダーとしてパラメーターを送信するには、`.SetHeader()` API を使用します。

```cs
request.SetHeader(KeyValuePair<string,string> header);
```

### その他のカスタム本体パラメーター
{: #other-custom-body-parameters }
- `.Send(requestBody)` を使用して、本体に任意のストリングを設定できます。
- `.Send(JObject json)` を使用して、本体に任意のディクショナリーを設定できます。
- `.Send(byte[] data)` を使用して、本体に任意のバイト配列を設定できます。

## 応答
{: #the-response }
`WorklightResponse` オブジェクトには応答データが含まれており、そのメソッドとプロパティーを使用して必要な情報を取得することができます。よく使用されるプロパティーは、`ResponseText` (ストリング)、`ResponseJSON` (JSONObject) (応答が JSON である場合)、`success` (ブール値) (応答の成功状況) です。

要求が失敗した場合、応答オブジェクトには `error` プロパティーも含まれます。

## 詳細情報
{: #for-more-information }
> WLResourceRequest について詳しくは、[APIリファレンス](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/mfpf_csharp_win8_native_client_api.pdf) (http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/mfpf_csharp_win8_native_client_api.pdf) を参照してください。

<img alt="サンプル・アプリケーションのイメージ" src="resource-request-success-win8-10.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
ResourceRequestWin8 プロジェクトおよび ResourceRequestWin10 プロジェクトには、Java アダプターを使用してリソース要求を行うネイティブ Windows 8 Universal/Windows 10 UWP アプリケーションが含まれています。  
アダプター Maven プロジェクトには、リソース要求呼び出し中に使用される Java アダプターが含まれています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin8/tree/release80) して Windows 8.1 Universal プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestWin10/tree/release80) して Windows 10 UWP プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
