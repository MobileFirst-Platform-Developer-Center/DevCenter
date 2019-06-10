---
layout: tutorial
title: Erweiterte Verwendung von Adaptern und Adapterkombinationen
breadcrumb_title: Adapterkombinationen
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Cordova-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Nachdem die grundlegende Verwendung verschiedener Adaptertypen besprochen wurde, soll nun erwähnt werden, dass Adapter zu einer Prozedur kombiniert werden können, die verschiedene Adapter verwendet, um ein verarbeitetes Ergebnis zu generieren. Sie können mehrere Quellen (verschiedene HTTP-Server, SQL usw.) miteinander kombinieren. 

Theoretisch können Sie von der Clientseite aus nacheinander mehrere Anforderungen absetzen, die voneinander abhängen.
Es geht jedoch schneller und ist ordentlicher, wenn diese Logik auf der Serverseite geschrieben wird. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [JavaScript-Adapter-API](#javascript-adapter-api)
* [Java-Adapter-API](#java-adapter-api)
* [Datenkombinationsbeispiel](#data-mashup-example)
* [Beispielanwendung](#sample-application)

## JavaScript-Adapter-API
{: #javascript-adapter-api }

### JavaScript-Adapterprozedur von einem JavaScript-Adapter aus aufrufen
{: #calling-a-javascript-adapter-procedure-from-a-javascript-adapter }

Wenn Sie eine JavaScript-Adapterprozedur von einem anderen JavaScript-Adapter aus aufrufen möchten,
verwenden Sie die API `MFP.Server.invokeProcedure(invocationData)`. Diese API ermöglicht das Aufrufen einer Prozedur in jedem Ihrer JavaScript-Adapter. `MFP.Server.invokeProcedure(invocationData)` gibt das Ergebnisobjekt zurück, das von der aufgerufenen Prozedur abgerufen wurde. 

Die Funktionssignatur für `invocationData` sieht wie folgt aus:   
`MFP.Server.invokeProcedure({adapter: [Adaptername], procedure: [Prozedurname], parameters: [durch Komma getrennte Parameter]})`

Beispiel: 

```javascript
MFP.Server.invokeProcedure({ adapter : "AcmeBank", procedure : " getTransactions", parameters : [accountId, fromDate, toDate]});
```

> Das Aufrufen eines Java-Adapters von einem JavaScript-Adapter aus wird nicht unterstützt. 

## Java-Adapter-API
{: #java-adapter-api }

Bevor Sie einen anderen Adapter aufrufen können, müssen Sie die Adapter-API (AdaptersAPI) einer Variablen zuordnen: 

```java
@Context
AdaptersAPI adaptersAPI;
```

### Java-Adapter von einem Java-Adapter aus aufrufen
{: #calling-a-java-adapter-from-a-java-adapter }

Wenn Sie eine Adapterprozedur von einem Java-Adapter aus aufrufen möchten, verwenden Sie die API `executeAdapterRequest`.
Dieser Aufruf gibt ein `HttpResponse`-Objekt zurück. 

```java
HttpUriRequest req = new HttpGet(JavaAdapterProcedureURL);
HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

### JavaScript-Adapterprozedur von einem Java-Adapter aus aufrufen
{: calling-a-javascript-adapter-procedure-from-a-java-adapter }
 
Wenn Sie eine JavaScript-Adapterprozedur von einem Java-Adapter aus aufrufen möchten, verwenden Sie die
API `executeAdapterRequest` und die API `createJavascriptAdapterRequest`, die
eine Anforderung `HttpUriRequest` erstellt, die als Parameter an den Aufruf von `executeAdapterRequest` übergeben wird. 

```java
HttpUriRequest req = adaptersAPI.createJavascriptAdapterRequest(AdapterName, ProcedureName, [parameters]);
org.apache.http.HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

## Datenkombinationsbeispiel
{: #data-mashup-example }

Das folgende Beispiel zeigt die Kombination von Daten aus zwei Datenquellen,
nämlich aus einer *Datenbanktabelle* und aus (dem Service für Wechselkurse und Währungsumrechnung) *Fixer.io*, und die
Rückgabe des Datenstroms an die Anwendung in Form eines einzelnen Objekts. 

In diesem Beispiel werden zwei Adapter verwendet:


* SQL-Adapter:
  * Der Adapter extrahiert eine Liste mit Währungen aus einer Datenbanktabelle. 
  * Das Ergebnis enthält die Liste der Währungen. Jede Währung hat eine ID, ein Symbol und einen Namen, z. B. {3, EUR, Euro}. 
  * Dieser Adapter enthält auch eine Prozedur, die den HTTP-Adapter aufruft und zwei Parameter übergibt, nämlich eine Basiswährung und eine Zielwährung,
um den aktuellen Wechselkurs abzurufen. 
* HTTP-Adapter:
  * Der Adapter stellt eine Verbindung zum Service Fixer.io her. 
  * Für die angegebenen Währungen, die mithilfe des SQL-Adapters als Parameter abgerufen wurden, wird ein aktualisierter Wechselkurs extrahiert. 

Im Anschluss werden die kombinierten Daten zur Anzeige an die Anwendung zurückgegeben. 

![Diagramm für die Kombination von Aaptern](AdaptersMashupDiagram.jpg)

Das Beispiel in diesem Lernprogramm zeigt die Implementierung dieses Szenarios anhand von drei verschiedenen Kombinationen.   
In jeder dieser Kombinationen unterscheiden sich die Adapternamen geringfügig.   
Es folgt eine Liste der Kombinationen mit den entsprechenden Adapternamen: 

|Szenario|Name des SQL-Adapters|Name des HTTP-Adapters|  
|--------------------------------------------------|------------------------------|-----------------------|
| **JavaScript**-Adapter → **JavaScript**-Adapter| SQLAdapterJS| HTTPAdapterJS|  
| **Java**-Adapter → **JavaScript**-Adapter| SQLAdapterJava| HTTPAdapterJS|  
| **Java**-Adapter → **Java**-Adapter| SQLAdapterJava| HTTPAdapterJava|


### Ablauf des Kombinationsbeispiels
{: #mashup sample flow }

**1. Erstellen Sie eine Prozedur bzw. einen Adapteraufruf, die bzw. der bei einem Back-End-Endpunkt die gewünschten Währungen anfordert und die entsprechenden Daten abruft:**  

(Adapter HTTPAdapterJS) XML:

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

(Adapter HTTPAdapterJS) JavaScript:

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

(Adapter HTTPAdapterJava)

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

**2. Erstellen Sie eine Prozedur, die die Währungsdatensätze aus der Datenbank abruft und einen Ergebnissatz oder ein JSON-Array (resultSet/JSONArray) an die Anwendung zurückgibt:**

(Adapter SQLAdapterJS)

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

(Adapter SQLAdapterJava)

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

**3. Erstellen Sie eine Prozedur, die die (in Schritt 1 erstellte) HTTP-Adapterprozedur mit der Basiswährung und der Zielwährung aufruft:**

(Adapter SQLAdapterJS)

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

(Adapter SQLAdapterJava in Kombination mit einem anderen Java-Adapter)

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

(Adapter SQLAdapterJava in Kombination mit einem JavaScript-Adapter)

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

<img alt="Beispielanwendung" src="AdaptersMashupSample.png" style="float:right"/>

## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80), um das Cordova-Projekt herunterzuladen. 

**Hinweis:** Die Clientseite der Beispielanwendung ist für Cordova-Anwendungen bestimmt. Der serverseitige Code der Adapter ist dagegen auf alle Plattformen anwendbar. 

### Verwendung des Beispiels
{: #sample-usage }

#### Adapterkonfiguration
{: #adapter-setup }

Im bereitgestellten Maven-Adapterprojekt gibt es (innerhalb des Cordova-Projekts) unter `Utils/mobilefirstTraining.sql` eine Beispielliste mit Währungen in SQL. 

1. Führen Sie in Ihrer SQL-Datenbank das SQL-Script aus. 
2. Verwenden Sie Maven, die {{ site.data.keys.mf_cli }} oder eine IDE Ihrer Wahl, um
die [Adapter zu erstellen und zu implementieren](../../adapters/creating-adapters/). 
3. Öffnen Sie die {{ site.data.keys.mf_console }}.
    - Klicken Sie auf den Adapter **SQLAdapterJS** und aktualisieren Sie die Eigenschaften für Datenbankverbindungen. 
    - Klicken Sie auf den Adapter **SQLAdapterJava** und aktualisieren Sie die Eigenschaften für Datenbankverbindungen. 

#### Anwendungskonfiguration
{: #application-setup }

1. Navigieren Sie in der Befehlszeile zum Stammverzeichnis des Projekts **CordovaApp**. 
2. Fügen Sie eine Plattform hinzu. Führen Sie dafür den Befehl `cordova platform add` aus. 
3. Registrieren Sie die Anwendung mit dem Befehl `mfpdev app register`.
4. Führen Sie die Cordova-Anwendung mit dem Befehl `cordova run` aus. 
