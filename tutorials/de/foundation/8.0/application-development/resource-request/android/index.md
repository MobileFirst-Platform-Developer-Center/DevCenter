---
layout: tutorial
title: Ressourcenanforderung von Android-Anwendungen
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Android-Studio-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mit der {{ site.data.keys.product_adj }} erstellte Anwendungen können mit der REST-API `WLResourceRequest` auf Ressourcen zugreifen.   
Die REST-API funktioniert mit allen Adaptern und externen Ressourcen. 

**Voraussetzungen:**

- Stellen Sie sicher, dass Sie das [SDK der {{ site.data.keys.product }}](../../../application-development/sdk/android) zu Ihrem nativen Android-Projekt hinzugefügt haben. 
- Informieren Sie sich über das [Erstellen von Adaptern](../../../adapters/creating-adapters).

## WLResourceRequest
{: #wlresourcerequest }
Die Klasse `WLResourceRequest` handhabt an Adapter oder externe Ressourcen gerichtete Ressourcenanforderungen. 

Erstellen Sie ein `WLResourceRequest`-Objekt und geben Sie den Pfad zu der Ressource und die HTTP-Methode an.   
Verfügbare Methoden sind `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT`, `WLResourceRequest.HEAD` und `WLResourceRequest.DELETE`.

```java
URI adapterPath = URI.create("/adapters/JavaAdapter/users");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

* Verwenden Sie für **JavaScript-Adapter** `/adapters/{AdapterName}/{procedureName}`. 
* Verwenden Sie für **Java-Adapter** `/adapters/{AdapterName}/{path}`. Die Angabe für `path` hängt davon ab, wie Sie Ihre
`@Path`-Annotationen im Java-Code definiert haben. Eingeschlossen sind auch alle verwendeten `@PathParam`-Annotationen. 
* Wenn Sie auf Ressourcen außerhalb des Projekts zugreifen möchten, verwenden Sie die vollständige URL nach Maßgabe des externen Servers. 
* **timeout**: Anforderungszeitlimit in Millisekunden (optional)
* **scope**: Optional, wenn Sie wissen, mit welchem Bereich die Ressource geschützt wird. Durch Angabe dieses Bereichs kann die Abfrage effizienter werden. 

## Anforderung senden
{: #sending-the-request }
Fordern Sie die Ressource mit der Methode `.send()` an. Geben Sie eine WLResponseListener-Klasseninstanz an: 

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

## Parameter
{: #parameters }
Bevor Sie Ihre Anforderung senden, können Sie nach Bedarf Parameter hinzufügen. 

### Pfadparameter
{: #path-parameters }
Pfadparameter (`/path/value1/value2`) werden - wie bereits erläutert - während der Erstellung des `WLResourceRequest`-Objekts festgelegt: 

```java
URI adapterPath = new URI("/adapters/JavaAdapter/users/value1/value2");
WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
```

### Abfrageparameter
{: #query-parameters }
Wenn Sie Abfrageparameter (`/path?param1=value1...`) senden möchten, verwenden Sie für die einzelnen Parameter die Methode `setQueryParameter`: 

```java
request.setQueryParameter("param1","value1");
request.setQueryParameter("param2","value2");
```

#### JavaScript-Adapter
{: #javascript-adapters }
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

```java
request.setQueryParameter("params","['value1', 'value2']");
```

Dieses Array sollte mit `WLResourceRequest.GET` verwendet werden.

### Formularparameter
{: #form-parameters }
Wenn Sie im Hauptteil Formularparameter senden möchten, verwenden Sie
`.send(HashMap<String, String> formParameters, WLResponseListener)` anstelle von `.send(WLResponseListener)`:  

```java
HashMap formParams = new HashMap();
formParams.put("height", height.getText().toString());
request.send(formParams, new MyInvokeListener());
```    

#### JavaScript-Adapter
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

```java
formParams.put("params", "['value1', 'value2']");
```

Dieses Array sollte mit `WLResourceRequest.POST` verwendet werden.

### Headerparameter
{: #header-parameters }
Wenn Sie einen Parameter als HTTP-Header senden möchten, verwenden Sie die API `.addHeader()`: 

```java
request.addHeader("date", date.getText().toString());
```

### Weitere angepasste Hauptteilparameter
{: #other-custom-body-parameters }
- Mit `.send(requestBody, WLResponseListener listener)` können Sie im Hauptteil eine beliebige Zeichenfolge festlegen. 
- Mit `.send(JSONStore json, WLResponseListener listener)` können Sie im Hauptteil ein beliebiges Verzeichnis festlegen. 
- Mit `.send(byte[] data, WLResponseListener listener)` können Sie im Hauptteil ein beliebiges Byte-Array festlegen. 

## Antwort
{: #the-response }
Das Objekt `response` enthält die Antwortdaten. Über die Methoden und Eigenschaften dieses Objekts können Sie die erforderlichen Informationen abrufen. Gängige Eigenschaften sind
`responseText` (String), `responseJSON` (JSON Object) (wenn die Antwort im JSON-Format vorliegt)
und `status` (Int) (HTTP-Status der Antwort). 

Verwenden Sie die Objekte `WLResponse response` und `WLFailResponse response`, um die vom Adapter abgerufenen Daten zu erhalten. 

## Weitere Informationen
{: #for-more-information }
> Weitere Hinweise zu WLResourceRequest finden Sie in den [API-Referenzinformationen](../../../api/client-side-api/java/client/).

<img alt="Beispielanwendung" src="resource-request-success-android.png" style="float:right"/>
## Beispielanwendung
{: #sample-application }
Das Projekt ResourceRequestAndroid enthält eine native Android-Anwendung, die mit einem Java-Adapter eine Ressourcenanforderung absetzt.   
Das Adapter-Maven-Projekt enthält den beim Aufrufen der Ressourcenanforderung verwendeten Java-Adapter. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid/tree/release80), um das Android-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Adapter-Maven-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
