---
layout: tutorial
title: Mashup y utilización de adaptador avanzada
breadcrumb_title: Mashup de adaptadores
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }
Ahora que se ha tratado la utilización básica de distintos tipos de adaptadores, es importante recordar que los adaptadores se pueden combinar para crear un procedimiento que utiliza distintos adaptadores para generar un resultado procesado (mashup). Existe la posibilidad de combinar distintos orígenes (distintos servidores HTTP, SQL, etc). 

En teoría, desde el lado del cliente, puede realizar varias solicitudes de forma sucesiva, cada una dependiendo de la otra. También tenga en cuenta que crear esta lógica en el lado del servidor podría ser más fácil y claro. 

#### Ir a
{: #jump-to}
* [API de adaptador JavaScript](#javascript-adapter-api)
* [API de adaptador Java](#java-adapter-api)
* [Ejemplo de mashup de datos](#data-mashup-example)
* [Aplicación de ejemplo](#sample-application)

## API de adaptador JavaScript
{: #javascript-adapter-api }

### Llamada a un procedimiento de adaptador JavaScript desde otro adaptador JavaScript
{: #calling-a-javascript-adapter-procedure-from-a-javascript-adapter }

Cuando se llama a un procedimiento de adaptador de JavaScript desde otro adaptador JavaScript utilice la API `MFP.Server.invokeProcedure(invocationData)`. Esta API permite invocar a un procedimiento en cualquiera de sus adaptadores JavaScript. `MFP.Server.invokeProcedure(invocationData)` devuelve el objeto resultado recuperado del procedimiento al que se llama. 

La firma de la función `invocationData` es:   
`MFP.Server.invokeProcedure({adapter: [Adapter Name], procedure: [Procedure Name], parameters: [Parameters seperated by a comma]})`

Por ejemplo:

```javascript
MFP.Server.invokeProcedure({ adapter : "AcmeBank", procedure : " getTransactions", parameters : [accountId, fromDate, toDate]});
```

> No se da soporte a la llamada a un adaptador Java desde un adaptador JavaScript

## API de adaptador Java
{: #java-adapter-api }

Antes de poder llamar a otro adaptador, se debe asignar AdaptersAPI a una variable: 

```java
@Context
AdaptersAPI adaptersAPI;
```

### Llamada a un adaptador Java desde otro adaptador Java
{: #calling-a-java-adapter-from-a-java-adapter }

Utilice la API `executeAdapterRequest` para llamar a un procedimiento de adaptador desde un adaptador Java. Esta llamada devuelve un objeto `HttpResponse`. 

```java
HttpUriRequest req = new HttpGet(JavaAdapterProcedureURL);
HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

### Llamada a un procedimiento de adaptador JavaScript desde un adaptador Java
{: calling-a-javascript-adapter-procedure-from-a-java-adapter }
 
Al llamar a un procedimiento de adaptador JavaScript desde un adaptador Java utilice tanto la API `executeAdapterRequest` como la API `createJavascriptAdapterRequest` que crea un `HttpUriRequest` para pasar como un parámetro a la llamada `executeAdapterRequest`. 

```java
HttpUriRequest req = adaptersAPI.createJavascriptAdapterRequest(AdapterName, ProcedureName, [parameters]);
org.apache.http.HttpResponse response = adaptersAPI.executeAdapterRequest(req);
JSONObject jsonObj = adaptersAPI.getResponseAsJSON(response);
```

## Ejemplo de mashup de datos
{: #data-mashup-example }

El siguiente ejemplo muestra como realizar un mashup de datos desde dos orígenes de datos, una *tabla de base de datos* y desde *Fixer.io (un servicio de conversión de monedas y tipos de cambio)* para devolver la secuencia de datos a la aplicación como un objeto individual. 

En este ejemplo utilizaremos dos adaptadores:

* Adaptador SQL: 
  * Extrae una lista de monedas de una tabla de base de datos de monedas. 
  * El resultado contiene la lista de monedas. Cada moneda tendrá un identificador, un símbolo y un nombre. Por ejemplo: {3, EUR, Euro}
  * Este adaptador también tendrá un procedimiento que llamará al adaptador HTTP pasando 2 parámetros, una moneda base y una moneda de destino para recuperar el tipo de cambio actualizado. 
* Adaptador HTTP: 
  * Conectar al servicio Fixer.io. 
  * Extraer y actualizar la tasa de cambio de las monedas solicitadas que se recuperan como parámetros a través del adaptador SQL. 

Con posterioridad, los datos combinados se devuelven a la aplicación para que esta los visualice. 

![Diagrama de mashup de adaptadores](AdaptersMashupDiagram.jpg)

El ejemplo que se proporciona en esta guía de aprendizaje muestra la implementación de este escenario utilizando 3 tipos de mashup diferentes.   
En cada uno de ellos los nombres de los adaptadores son ligeramente diferentes.   
A continuación se muestra una lista de tipos de mashup y los correspondientes nombres de adaptador: 

| Escenario |      Nombre de adaptador SQL|  Nombre de adaptador HTTP |  
|--------------------------------------------------|------------------------------|-----------------------|
| Adaptador **JavaScript** → Adaptador **JavaScript** | SQLAdapterJS                 | HTTPAdapterJS         |  
| Adaptador **Java** → Adaptador **JavaScript** | SQLAdapterJava               | HTTPAdapterJS         |  
| Adaptador **Java** → Adaptador **Java** | SQLAdapterJava               | HTTPAdapterJava       |


### Flujo de ejemplo de mashup 
{: #mashup sample flow }

**1. Crear un procedimiento / llamada de adaptador que crea una solicitud a un punto final de fondo para las monedas solicitadas y recupera los correspondientes datos: **  

XML (Adaptador HTTPAdapterJS): 

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

JavaScript (Adaptador HTTPAdapterJS): 

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

(Adaptador HTTPAdapterJava) 

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

**2. Crear un procedimiento que recupera los registros de monedas de la base de datos y devuelve un resultSet / JSONArray a la aplicación: **  

(Adaptador SQLAdapterJS) 

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

(Adaptador SQLAdapterJava)

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

**3. Crear un procedimiento que llama al procedimiento HTTPAdapter (que se crea en el paso 1) con la moneda base y la moneda de destino: **

(Adaptador SQLAdapterJS) 

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

(Adaptador SQLAdapterJava - mashup con otro adaptador Java)

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

(Adaptador SQLAdapterJava - mashup con un adaptador JavaScript)

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

<img alt="aplicación de ejemplo" src="AdaptersMashupSample.png" style="float:right"/>

## Aplicación de ejemplo
{: #sample-application }
[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/AdaptersMashup/tree/release80) el proyecto Cordova.


**Nota:** el lado del cliente de la aplicación de ejemplo es para aplicaciones Cordova, sin embargo el código del lado del servidor en los adaptadores se aplica a todas las plataformas. 

### Uso de ejemplo 
{: #sample-usage }

#### Configuración de adaptador 
{: #adapter-setup }

Encontrará un ejemplo de lista de monedas en SQL en el proyecto Maven del adaptador proporcionado (ubicado dentro del proyecto Cordova), bajo `Utils/mobilefirstTraining.sql`.

1. Ejecute el script .sql script en su base de datos SQL. 
2. Utilice Maven, {{ site.data.keys.mf_cli }} o el IDE de su elección para [compilar y desplegar los adaptadores](../../adapters/creating-adapters/).

3. Abra {{ site.data.keys.mf_console }}
    - Pulse en el adaptador **SQLAdapterJS** y actualice las propiedades de conectividad de la base de datos.  
    - Pulse en el adaptador **SQLAdapterJava** y actualice las propiedades de conectividad de la base de datos.  

#### Configuración de la aplicación 
{: #application-setup }

1. Desde la línea de mandatos, vaya a la carpeta raíz del proyecto **CordovaApp**.  
2. Añada una plataforma ejecutando el mandato `cordova platform add`. 
3. Registre la aplicación ejecutando el mandato: `mfpdev app register`.
4. Ejecute la aplicación Cordova con el mandato `cordova run`. 
