---
layout: tutorial
title: 拡張アダプターの使用法とマッシュアップ
breadcrumb_title: アダプターのマッシュアップ
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Cordova プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
さまざまなタイプのアダプターの基本的な使用法について説明してきましたが、これらのアダプターを組み合わせると、異なるアダプターを使用して 1 つの処理結果を生成するプロシージャーを作成できることを覚えておくことは重要です。複数のソース (異なる HTTP サーバー、SQL など) を組み合わせることができます。

理論上は、クライアント・サイドから複数の要求を連続的に行うことができ、一方が他方に依存した状態になります。
ただし、サーバー・サイドにこのロジックを作成することで、速度が向上し、よりクリーンになる可能性があります。

#### ジャンプ先
{: #jump-to}
* [JavaScript アダプター API](#javascript-adapter-api)
* [Java アダプター API](#java-adapter-api)
* [データ・マッシュアップの例](#data-mashup-example)
* [サンプル・アプリケーション](#sample-application)

## JavaScript アダプター API
{: #javascript-adapter-api }

### JavaScript アダプターからの JavaScript アダプター・プロシージャーの呼び出し
{: #calling-a-javascript-adapter-procedure-from-a-javascript-adapter }

JavaScript アダプター・プロシージャーを別の JavaScript アダプターから呼び出す場合、`MFP.Server.invokeProcedure(invocationData)` API を使用します。この API を使用することにより、どの JavaScript アダプター上のプロシージャーも呼び出すことができます。`MFP.Server.invokeProcedure(invocationData)` は、呼び出されたプロシージャーから取得した結果オブジェクトを返します。

`invocationData` 関数シグニチャーは次のとおりです。  
`MFP.Server.invokeProcedure({adapter: [アダプター名], procedure: [プロシージャー名], parameters: [コンマ区切りのパラメーター]})`

以下に例を示します。

```javascript
MFP.Server.invokeProcedure({ adapter : "AcmeBank", procedure : " getTransactions", parameters : [accountId, fromDate, toDate]});
```

> JavaScript アダプターからの Java アダプターの呼び出しはサポートされていません。

## Java アダプター API
{: #java-adapter-api }

別のアダプターを呼び出す前に - AdaptersAPI を変数に割り当てる必要があります。

```java
@Context AdaptersAPI adaptersAPI; 
```

### Java アダプターからの Java アダプターの呼び出し
{: #calling-a-java-adapter-from-a-java-adapter }

Java アダプターからアダプター・プロシージャーを呼び出す場合、`executeAdapterRequest` API を使用します。
この呼び出しは `HttpResponse` オブジェクトを返します。

```java
HttpUriRequest req = new HttpGet(JavaAdapterProcedureURL);
HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

### Java アダプターからの JavaScript アダプター・プロシージャーの呼び出し
{: calling-a-javascript-adapter-procedure-from-a-java-adapter }
 
Java アダプターから JavaScript アダプター・プロシージャーを呼び出す場合、`executeAdapterRequest` API と `createJavascriptAdapterRequest` API の両方を使用します。後者の API では、`HttpUriRequest` を作成し、これをパラメーターとして `executeAdapterRequest` 呼び出しに渡します。

```java
HttpUriRequest req = adaptersAPI.createJavascriptAdapterRequest(AdapterName, ProcedureName, [parameters]);
org.apache.http.HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

## データ・マッシュアップの例
{: #data-mashup-example }

次の例では、2 つのデータ・ソース、1 つの*データベース表*、および *Fixer.io (為替レートおよび通貨の変換サービス)* をマッシュアップする方法、およびデータ・ストリームを単一のオブジェクトとしてアプリケーションに返す方法を示します。

この例では、2 つのアダプターを使用します。

* SQL アダプター:
  * 通貨のリストを通貨データベース表から取り出します。
  * 結果には通貨のリストが含まれています。各通貨には、ID、シンボル、および名前があります。例: {3, EUR, Euro}
  * このアダプターには、2 つのパラメーター (更新済みの為替レートを取得するための基本通貨とターゲット通貨) を渡す HTTP アダプターを呼び出すプロシージャーも含まれています。
* HTTP アダプター:
  * Fixer.io サービスに接続します。
  * SQL アダプターを介してパラメーターとして取得される要求通貨の、更新済みの為替レートを取り出します。

その後、マッシュアップされたデータがアプリケーションに返されて表示されます。

![アダプターのマッシュアップ・ダイアグラム](AdaptersMashupDiagram.jpg)

このチュートリアルで提供されるサンプルでは、3 つの異なるマッシュアップ・タイプを使用する以下のシナリオの実装を示します。  
それぞれのタイプで、アダプターの名前がやや異なります。  
マッシュアップ・タイプとそれに該当するアダプター名のリストは次のとおりです。

| シナリオ|      SQL アダプター名|  HTTP アダプター名|  
|--------------------------------------------------|------------------------------|-----------------------|
| **JavaScript** アダプター → **JavaScript** アダプター| SQLAdapterJS| HTTPAdapterJS|  
| **Java** アダプター → **JavaScript** アダプター| SQLAdapterJava| HTTPAdapterJS|  
| **Java** アダプター → **Java** アダプター| SQLAdapterJava| HTTPAdapterJava|


### マッシュアップのサンプル・フロー
{: #mashup sample flow }

**1. 要求された通貨についてバックエンドのエンドポイントへの要求を作成し、該当するデータを取得するプロシージャー/アダプター呼び出しを作成します。**  

(HTTPAdapterJS アダプター) XML:

```xml
<connectivity>
  <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
    <protocol>http</protocol>
    <domain>api.fixer.io</domain>
    <port>80</port>
    ...
  </connectionPolicy>
</connectivity>
```

(HTTPAdapterJS アダプター) JavaScript:

```javascript
function getExchangeRate(fromCurrencySymbol, toCurrencySymbol) {
  var input = {
    method: 'get',
    returnedContentType: 'json',
    path: getPath(fromCurrencySymbol, toCurrencySymbol)
  };

  return MFP.Server.invokeHttp(input);
}

function getPath(from, to) {
  return "/latest?base=" + from + "&symbols=" + to;
}
```

(HTTPAdapterJava アダプター)

```java
@GET
@Produces("application/json")
public Response get(@QueryParam("fromCurrency") String fromCurrency, @QueryParam("toCurrency") String toCurrency) throws IOException, IllegalStateException, SAXException {
  String path = "/latest?base="+ fromCurrency +"&symbols="+ toCurrency;
  return execute(new HttpGet(path));
}

private Response execute(HttpUriRequest req) throws IOException, IllegalStateException, SAXException {
  HttpResponse RSSResponse = client.execute(host, req);

  InputStream content = RSSResponse.getEntity().getContent();
  if (RSSResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
    responseAsText = IOUtils.toString(content, "UTF-8");
    content.close();
    return Response.ok().entity(responseAsText).build();
  }else{
    content.close();
    return Response.status(RSSResponse.getStatusLine().getStatusCode()).entity(RSSResponse.getStatusLine().getReasonPhrase()).build();
  }
}
```

**2. データベースから通貨レポートをフェッチし、resultSet/JSONArray をアプリケーションに返すプロシージャーを作成します。**

(SQLAdapterJS アダプター)

```javascript
var getCurrenciesListStatement = "SELECT id, symbol, name FROM currencies;";

function getCurrenciesList() {
  var list = MFP.Server.invokeSQLStatement({
    preparedStatement: getCurrenciesListStatement,
    parameters: []
  });
  return list.resultSet;
}
```

(SQLAdapterJava アダプター)

```java
@GET
@Produces(MediaType.APPLICATION_JSON)
@Path("/getCurrenciesList")
public JSONArray getCurrenciesList() throws SQLException, IOException {
  JSONArray jsonArr = new JSONArray();

  Connection conn = getSQLConnection();
  PreparedStatement getAllCities = conn.prepareStatement("select id, symbol, name from currencies");
  ResultSet rs = getAllCities.executeQuery();
  while (rs.next()) {
    JSONObject jsonObj = new JSONObject();
    jsonObj.put("id", rs.getString("id"));
    jsonObj.put("symbol", rs.getString("symbol"));
    jsonObj.put("name", rs.getString("name"));

    jsonArr.add(jsonObj);
  }
  rs.close();
  conn.close();
  return jsonArr;
}
```

**3. 基本通貨とターゲット通貨を指定して HTTPAdapter プロシージャー (ステップ 1 で作成) を呼び出すプロシージャーを作成します。**

(SQLAdapterJS アダプター)

```javascript
function getExchangeRate(fromId, toId) {
  var base = getCurrencySymbol(fromId);
  var exchangeTo = getCurrencySymbol(toId);
  var ExchangeRate = null;

  if (base == exchangeTo) {
    ExchangeRate = 1;
  } else {
    var fixerExchangeRateJSON = MFP.Server.invokeProcedure({
      adapter: 'HTTPAdapterJS',
      procedure: 'getExchangeRate',
      parameters: [base, exchangeTo]
    });
    ExchangeRate = fixerExchangeRateJSON.rates[exchangeTo];
  }

  return {
    "base": base,
    "target": exchangeTo,
    "exchangeRate": ExchangeRate
  };
}
```

(SQLAdapterJava アダプター - 別の Java アダプターとのマッシュアップ)

```java
@GET
@Produces(MediaType.APPLICATION_JSON)
@Path("/getExchangeRate_JavaToJava")
public JSONObject getExchangeRate_JavaToJava(@QueryParam("fromCurrencyId") Integer fromCurrencyId, @QueryParam("toCurrencyId") Integer toCurrencyId) throws SQLException, IOException{
  String base = getCurrencySymbol(fromCurrencyId);
  String exchangeTo = getCurrencySymbol(toCurrencyId);
  Double ExchangeRate = null;

  if(base.equals(exchangeTo)){
    ExchangeRate = 1.0;
  }
  else{
    String getFixerIOInfoProcedureURL = "/HTTPAdapterJava?fromCurrency="+ URLEncoder.encode(base, "UTF-8") +"&toCurrency="+ URLEncoder.encode(exchangeTo, "UTF-8");
    HttpUriRequest req = new HttpGet(getFixerIOInfoProcedureURL);
    HttpResponse response = adaptersAPI.executeAdapterRequest(req);
    JSONObject jsonExchangeRate = adaptersAPI.getResponseAsJSON(response);
    JSONObject rates = (JSONObject)jsonExchangeRate.get("rates");
    ExchangeRate = (Double) rates.get(exchangeTo);
  }

  JSONObject jsonObj = new JSONObject();
  jsonObj.put("base", base);
  jsonObj.put("target", exchangeTo);
  jsonObj.put("exchangeRate", ExchangeRate);

  return jsonObj;
}
```

(SQLAdapterJava アダプター - JavaScript アダプターとのマッシュアップ)

```java
@GET
@Produces(MediaType.APPLICATION_JSON)
@Path("/getExchangeRate_JavaToJS")
public JSONObject getExchangeRate_JavaToJS(@QueryParam("fromCurrencyId") Integer fromCurrencyId, @QueryParam("toCurrencyId") Integer toCurrencyId) throws SQLException, IOException{
  String base = getCurrencySymbol(fromCurrencyId);
  String exchangeTo = getCurrencySymbol(toCurrencyId);
  Double ExchangeRate = null;

  if(base.equals(exchangeTo)){
    ExchangeRate = 1.0;
  }
  else{
    HttpUriRequest req = adaptersAPI.createJavascriptAdapterRequest("HTTPAdapterJS", "getExchangeRate", URLEncoder.encode(base, "UTF-8"), URLEncoder.encode(exchangeTo, "UTF-8"));
    org.apache.http.HttpResponse response = adaptersAPI.executeAdapterRequest(req);
    JSONObject jsonExchangeRate = adaptersAPI.getResponseAsJSON(response);
    JSONObject rates = (JSONObject)jsonExchangeRate.get("rates");
    ExchangeRate = (Double) rates.get(exchangeTo);
  }

  JSONObject jsonObj = new JSONObject();
  jsonObj.put("base", base);
  jsonObj.put("target", exchangeTo);
  jsonObj.put("exchangeRate", ExchangeRate);

  return jsonObj;
}
```

<img alt="サンプル・アプリケーション" src="AdaptersMashupSample.png" style="float:right"/>

## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80) して Cordova プロジェクトをダウンロードします。

**注:** サンプル・アプリケーションのクライアント・サイドは Cordova アプリケーション用ですが、アダプターのサーバー・サイド・コードはすべてのプラットフォームに適用されます。

### 使用例
{: #sample-usage }

#### アダプターのセットアップ
{: #adapter-setup }

SQL の通貨リストの例は、`Utils/mobilefirstTraining.sql` の提供されているアダプター Maven プロジェクト (Cordova プロジェクトの中にあります) で使用できます。

1. SQL データベースで .sql スクリプトを実行します。
2. Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[アダプターのビルドとデプロイ](../../adapters/creating-adapters/)を行います。
3. {{ site.data.keys.mf_console }}を開きます。
    - **SQLAdapterJS** アダプターをクリックし、データベース接続プロパティーを更新します。
    - **SQLAdapterJava** アダプターをクリックし、データベース接続プロパティーを更新します。

#### アプリケーションのセットアップ
{: #application-setup }

1. コマンド・ラインから、**CordovaApp** プロジェクトのルート・フォルダーにナビゲートします。
2. `cordova platform add` コマンドを実行して、プラットフォームを追加します。
3. `mfpdev app register` コマンドを実行して、アプリケーションを登録します。
4. `cordova run` コマンドを実行して、Cordova アプリケーションを実行します。
