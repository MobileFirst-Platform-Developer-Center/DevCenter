---
layout: tutorial
title: 고급 어댑터 사용법 및 매시업
breadcrumb_title: 어댑터 매시업
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Cordova 프로젝트 다운로드
    url: https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
여러 유형 어댑터의 기본 사용법을 다루었고, 이제 하나의 처리된 결과를 생성하기 위해 다양한 어댑터를 사용하는 프로시저를 작성하도록 어댑터를 결합할 수 있음을 기억하는 것이 중요합니다. 여러 소스(서로 다른 HTTP 서버, SQL 등)를 결합할 수 있습니다. 

이론적으로는 클라이언트 측에서 한 요청이 다른 요청에 종속된 여러 개의 요청을 연속으로 작성할 수 있습니다. 그러나 서버 측에서 이 논리를 작성하는 것이 더 빠르고 명확할 수 있습니다. 

#### 다음으로 이동
{: #jump-to}
* [JavaScript 어댑터 API](#javascript-adapter-api)
* [Java 어댑터 API](#java-adapter-api)
* [데이터 매시업 예제](#data-mashup-example)
* [샘플 애플리케이션](#sample-application)

## JavaScript 어댑터 API
{: #javascript-adapter-api }

### JavaScript 어댑터에서 JavaScript 어댑터 프로시저 호출
{: #calling-a-javascript-adapter-procedure-from-a-javascript-adapter }

다른 JavaScript 어댑터에서 JavaScript 어댑터 프로시저를 호출할 때 `MFP.Server.invokeProcedure(invocationData)`
API를 사용하십시오. 이 API를 사용하면 사용자의 어떤 JavaScript 어댑터에서도 프로시저를 호출할 수 있습니다. `MFP.Server.invokeProcedure(invocationData)`는 호출된 프로시저에서 검색된 결과 오브젝트를 리턴합니다. 

`invocationData` 함수 시그니처는 다음과 같습니다.  
`MFP.Server.invokeProcedure({adapter: [Adapter Name], procedure: [Procedure Name], parameters: [Parameters seperated by a comma]})`

예: 

```javascript
MFP.Server.invokeProcedure({ adapter : "AcmeBank", procedure : " getTransactions", parameters : [accountId, fromDate, toDate]});
```

> JavaScript 어댑터에서 Java 어댑터 호출은 지원되지 않습니다. 

## Java 어댑터 API
{: #java-adapter-api }

다른 어댑터를 호출하기 전에 AdaptersAPI를 변수에 지정해야 합니다.

```java
@Context
AdaptersAPI adaptersAPI;
```

### Java 어댑터에서 Java 어댑터 호출
{: #calling-a-java-adapter-from-a-java-adapter }

Java 어댑터에서 어댑터 프로시저를 호출할 때 `executeAdapterRequest` API를
사용하십시오. 이 호출은 `HttpResponse` 오브젝트를 리턴합니다. 

```java
HttpUriRequest req = new HttpGet(JavaAdapterProcedureURL);
HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

### Java 어댑터에서 JavaScript 어댑터 프로시저 호출
{: calling-a-javascript-adapter-procedure-from-a-java-adapter }
 
Java 어댑터에서 JavaScript 어댑터 프로시저를 호출할 때 `executeAdapterRequest` API 및 `executeAdapterRequest` 호출에 매개변수를 전달하기 위해 `HttpUriRequest`를 작성하는 `createJavascriptAdapterRequest` API를 둘 다 사용하십시오.  

```java
HttpUriRequest req = adaptersAPI.createJavascriptAdapterRequest(AdapterName, ProcedureName, [parameters]);
org.apache.http.HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

## 데이터 매시업 예제
{: #data-mashup-example }

다음 예제에서는 2개 데이터 소스 즉, *database table*과 *Fixer.io(환율 및 통화 변환 서비스)*에서 데이터를 매시업하는 방법과 단일오브젝트로 애플리케이션에 데이터 스트림을 리턴하는 방법을 보여줍니다. 

이 예제에서는 2개의 어댑터를 사용합니다. 

* SQL 어댑터:
  * 통화 데이터베이스 테이블에서 통화 목록을 추출하십시오. 
  * 결과 테이블에 통화 목록이 포함됩니다. 각 통화는 ID, 기호, 이름이 있습니다. 예: {3, EUR, Euro}
  * 이 어댑터는 또한 업데이트된 환율을 검색하기 위해 두 매개변수 - 기준 환율 및 대상 통화를 전달하는 HTTP 어댑터를 호출하는 프로시저를 가지게 됩니다. 
* HTTP 어댑터:
  * Fixer.io 서비스에 연결하십시오.
  * SQL 어댑터를 통해 매개변수로 검색되는 요청된 통화에 대한 업데이트된 환율을 추출하십시오. 

나중에 매시업 데이터가 표시를 위해 애플리케이션에 리턴됩니다. 

![어댑터 매시업 다이어그램](AdaptersMashupDiagram.jpg)

이 학습서에서 제공된 샘플은 세 개의 서로 다른 매시업 유형을 사용하여 이 시나리오의 구현을 보여줍니다.   
각 매시업 유형에서 어댑터의 이름은 약간 다릅니다.   
다음은 매시업 유형 및 해당 어댑터 이름의 목록 입니다. 

| 시나리오                                         |      SQL 어댑터 이름        |  HTTP 어댑터 이름    |  
|--------------------------------------------------|------------------------------|-----------------------|
| **JavaScript** 어댑터 → **JavaScript** 어댑터  | SQLAdapterJS                 | HTTPAdapterJS         |  
| **Java** 어댑터 → **JavaScript** 어댑터        | SQLAdapterJava               | HTTPAdapterJS         |  
| **Java** 어댑터 → **Java** 어댑터              | SQLAdapterJava               | HTTPAdapterJava       |


### 매시업 샘플 플로우
{: #mashup sample flow }

**요청된 통화에 대해 백엔드 엔드포인트로 요청을 작성하고 해당 데이터를 검색하는 프로시저/어댑터 호출을 작성하십시오. **  

(HTTPAdapterJS 어댑터) XML:

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

(HTTPAdapterJS 어댑터) JavaScript:

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

(HTTPAdapterJava 어댑터)

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

**2. 데이터베이스에서 통화 레코드를 페치하고 resultSet/JSONArray를 애플리케이션으로 리턴하는 프로시저를 작성하십시오. **

(SQLAdapterJS 어댑터)

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

(SQLAdapterJava 어댑터)

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

**3. 기준 환율 및 대상 환율로 HTTPAdapter 프로시저(1단계에서 작성한)를 호출하는 프로시저를 작성하십시오. **

(SQLAdapterJS 어댑터)

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

(SQLAdapterJava 어댑터 - 다른 Java 어댑터와 매시업)

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

(SQLAdapterJava 어댑터 - JavaScript 어댑터와 매시업)

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

<img alt="샘플 애플리케이션" src="AdaptersMashupSample.png" style="float:right"/>

## 샘플 애플리케이션
{: #sample-application }
Cordova 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80)하십시오.

**참고:** 샘플 애플리케이션의 클라이언트 측은 Cordova 애플리케이션용이지만 어댑터의 서버 측 코드는 모든 플랫폼에 적용됩니다. 

### 샘플 사용법
{: #sample-usage }

#### 어댑터 설정
{: #adapter-setup }

SQL에서 통화 목록 예제는 `Utils/mobilefirstTraining.sql` 아래에 있는 제공된 어댑터 maven 프로젝트(Cordova 프로젝트 내에 위치)에서 사용 가능합니다. 

1. SQL 데이터베이스에서.sql 스크립트를 실행하십시오. 
2. [어댑터를 빌드 및 배치](../../adapters/creating-adapters/)하기 위해 Maven, {{ site.data.keys.mf_cli }} 또는 선택한 IDE를 사용하십시오. 
3. {{ site.data.keys.mf_console }}을 여십시오. 
    - **SQLAdapterJS** 어댑터를 클릭하고 데이터베이스 연결 특성을 업데이트하십시오. 
    - **SQLAdapterJava** 어댑터를 클릭하고 데이터베이스 연결 특성을 업데이트하십시오. 

#### 애플리케이션 설정
{: #application-setup }

1. 명령행에서 **CordovaApp** 프로젝트의 루트 폴더로 이동하십시오. 
2. `cordova platform add` 명령을 실행하여 플랫폼을 추가하십시오. 
3. `mfpdev app register` 명령을 실행하여 애플리케이션을 등록하십시오.
4. `cordova run` 명령을 실행하여 Cordova 애플리케이션을 실행하십시오. 
