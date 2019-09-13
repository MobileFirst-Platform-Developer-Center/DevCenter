---
layout: tutorial
title: Android アプリケーションからのリソース要求
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_adj }} アプリケーションは `WLResourceRequest` REST API を使用してリソースにアクセスできます。  
REST API は、すべてのアダプターおよび外部リソースで機能します。

**前提条件**:

- 必ずご使用のネイティブ Android プロジェクトに [{{ site.data.keys.product }} SDK を追加](../../../application-development/sdk/android)しておいてください。
- [アダプターの作成](../../../adapters/creating-adapters)方法を参照してください。

## WLResourceRequest
{: #wlresourcerequest }
`WLResourceRequest` クラスは、アダプターまたは外部リソースに対するリソース要求を処理します。

`WLResourceRequest` オブジェクトを作成し、リソースへのパスと HTTP メソッドを指定します。  
使用可能なメソッドは、`WLResourceRequest.GET`、`WLResourceRequest.POST`、`WLResourceRequest.PUT`、`WLResourceRequest.HEAD`、および `WLResourceRequest.DELETE` です。

```java
URI adapterPath = URI.create("/adapters/JavaAdapter/users");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

* **JavaScript アダプター** の場合は、`/adapters/{AdapterName}/{procedureName}` を使用します。
* **Java アダプター**の場合は、`/adapters/{AdapterName}/{path}` を使用します。 `path` は、Java コードで `@Path` アノテーションをどのように定義したかによって決まります。 これには、使用した `@PathParam` も含まれます。
* プロジェクトの外部にあるリソースにアクセスするには、外部サーバーの要件のとおりに完全な URL を使用してください。
* **タイムアウト**: オプション。ミリ秒単位の要求タイムアウトです。
* **スコープ**: オプションです。どのスコープがリソースを保護しているのか分かっている場合は、このスコープを指定することで要求をより効率的にすることができます。

## 要求の送信
{: #sending-the-request }
`.send()` メソッドを使用してリソースを要求します。 WLResponseListener クラス・インスタンスを指定します。

```java
request.send(new WLResponseListener(){
  public void onSuccess(WLResponse response) {
    Log.d("Success", response.getResponseText());
  }
  public void onFailure(WLFailResponse response) {
    Log.d("Failure", response.getResponseText());
  }
});
```

## パラメーター
{: #parameters }
要求を送信する前に、必要に応じてパラメーターを追加したい場合があります。

### パス・パラメーター
{: #path-parameters }
上記の説明のとおり、**path** パラメーター (`/path/value1/value2`) は、`WLResourceRequest` オブジェクトの作成中に設定されます。

```java
URI adapterPath = new URI("/adapters/JavaAdapter/users/value1/value2");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

### 照会パラメーター
{: #query-parameters }
**query** パラメーター (`/path?param1=value1...`) を送信するには、パラメーターごとに `setQueryParameter` メソッドを使用します。

```java
request.setQueryParameter("param1","value1");
request.setQueryParameter("param2","value2");
```

#### JavaScript アダプター
{: #javascript-adapters }
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。 パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

```java
request.setQueryParameter("params","['value1', 'value2']");
```

これは、`WLResourceRequest.GET` と一緒に使用してください。

### フォーム・パラメーター
{: #form-parameters }
本体内のフォーム・パラメーターを送信するには、`.send(WLResponseListener)` ではなく `.send(HashMap<String, String> formParameters, WLResponseListener)` を使用します。  

```java
HashMap formParams = new HashMap();
formParams.put("height", height.getText().toString());
request.send(formParams, new MyInvokeListener());
```    

#### パラメーター - JavaScript アダプター
{: #parameters-javascript-adapters}
JavaScript アダプターは、名前のない順序付きのパラメーターを使用します。 パラメーターを JavaScript アダプターに渡すには、以下のように名前 `params` を使用してパラメーターの配列を設定します。

```java
formParams.put("params", "['value1', 'value2']");
```

これは、`WLResourceRequest.POST` と一緒に使用してください。

### ヘッダー・パラメーター
{: #header-parameters }
HTTP ヘッダーとしてパラメーターを送信するには、`.addHeader()` API を使用します。

```java
request.addHeader("date", date.getText().toString());
```

### その他のカスタム本体パラメーター
{: #other-custom-body-parameters }
- `.send(requestBody, WLResponseListener listener)` を使用して、本体に任意のストリングを設定できます。
- `.send(JSONStore json, WLResponseListener listener)` を使用して、本体に任意のディクショナリーを設定できます。
- `.send(byte[] data, WLResponseListener listener)` を使用して、本体に任意のバイト配列を設定できます。

## 応答
{: #the-response }
`response` オブジェクトには応答データが含まれており、そのメソッドとプロパティーを使用して必要な情報を取得することができます。 よく使用されるプロパティーは、`responseText` (ストリング)、`responseJSON` (JSON オブジェクト) (応答が JSON の場合)、および `status` (整数) (応答の HTTP 状況) です。

`WLResponse response` オブジェクトおよび `WLFailResponse response` オブジェクトを使用して、アダプターから取り出されたデータを取得します。

## 詳細情報
{: #for-more-information }
> WLResourceRequest について詳しくは、[API リファレンスを参照してください](../../../api/client-side-api/java/client/)。

<img alt="サンプル・アプリケーションのイメージ" src="resource-request-success-android.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
ResourceRequestAndroid プロジェクトには、Java アダプターを使用してリソース要求を行うネイティブ Android アプリケーションが含まれています。  
アダプター Maven プロジェクトには、リソース要求呼び出し中に使用される Java アダプターが含まれています。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80) して Android プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80) してアダプター Maven プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
