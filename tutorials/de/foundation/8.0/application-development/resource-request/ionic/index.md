---
layout: tutorial
title: Ressourcenanforderung von Ionic-Anwendungen
breadcrumb_title: Ionic
relevantTo: [ionic]
downloads:
  - name: Download Ionic project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestIonic
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mit der {{ site.data.keys.product_adj }} erstellte Anwendungen können mit der REST-API `WLResourceRequest` auf Ressourcen zugreifen.   
Die REST-API funktioniert mit allen Adaptern und externen Ressourcen. 

**Voraussetzungen:**

- Wenn Sie eine Ionic-Anwendung implementieren, müssen Sie das [SDK der {{ site.data.keys.product }} zu Ihrer Ionic-Anwendung hinzugefügt](../../../application-development/sdk/ionic) haben. 
- Informieren Sie sich über das [Erstellen von Adaptern](../../../adapters/creating-adapters/).

## WLResourceRequest
{: #wlresourcerequest }
Die Klasse `WLResourceRequest` handhabt an Adapter oder externe Ressourcen gerichtete Ressourcenanforderungen. 

Erstellen Sie ein `WLResourceRequest`-Objekt und geben Sie den Pfad zu der Ressource und die HTTP-Methode an.   
Verfügbare Methoden sind `WLResourceRequest.GET`, `WLResourceRequest.POST`, `WLResourceRequest.PUT` und `WLResourceRequest.DELETE`.

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaAdapter/users",
    WLResourceRequest.GET
);
```

* Verwenden Sie für **JavaScript-Adapter** `/adapters/{AdapterName}/{procedureName}`. 
* Verwenden Sie für **Java-Adapter** `/adapters/{AdapterName}/{path}`. Die Angabe für `path` hängt davon ab, wie Sie Ihre
`@Path`-Annotationen im Java-Code definiert haben. Eingeschlossen sind auch alle verwendeten `@PathParam`-Annotationen. 
* Wenn Sie auf Ressourcen außerhalb des Projekts zugreifen möchten, verwenden Sie die vollständige URL nach Maßgabe des externen Servers. 
* **timeout**: Anforderungszeitlimit in Millisekunden (optional)

## Anforderung senden
{: #sending-the-request }
Fordern Sie die Ressource mit der Methode `send()` an.   
Die Methode `send()` kann optional mit einem Parameter verwendet werden, um einen Hauptteil für die HTTP-Anforderung festzulegen. Dabei kann es sich um ein JSON-Objekt oder um eine einfache Zeichenfolge handeln. 

Mit TypeScript-Zusicherungen (**Promises**) können Sie die Callback-Funktionen für Erfolg (`Success`) und Fehler (`Failure`) definieren. 

```js
resourceRequest.send().then(
    (response) => {
      // Erfolg
    },
    (error) => {
      // Fehler
    }
)
```

### setQueryParameter
{: #setqueryparameter }
Mit der Methode `setQueryParameter` können Sie Abfrageparameter (URL-Parameter) in die REST-Anforderung aufnehmen. 

```js
resourceRequest.setQueryParameter("param1", "value1");
resourceRequest.setQueryParameter("param2", "value2");
```

#### JavaScript-Adapter
{: #javascript-adapters-setquery}
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

> **Hinweis:** Der Wert von `params` muss eine *Zeichenfolgedarstellung* eines Arrays sein. 

```js
resourceRequest.setQueryParameter("params", "['value1', 'value2']");
```

Dieses Array sollte mit `WLResourceRequest.GET` verwendet werden.

### setHeader
{: #setheader }
Mit der Methode `setHeader` können Sie einen neuen HTTP-Header festlegen oder einen vorhandenen Header desselben Namens in der HTTP-Anforderung ersetzen. 

```js
resourceRequest.setHeader("Header-Name","value");
```

### sendFormParameters(json)
{: #sendformparamtersjson }
Wenn Sie URL-Formularparameter senden möchten, verwenden Sie stattdessen die Methode `sendFormParameters(json)`. Diese Methode konvertiert JSON in eine URL-codierte Zeichenfolge,
legt `application/x-www-form-urlencoded` als Inhaltstyp (`content-type`) fest und definiert dies als HTTP-Hauptteil: 

```js
var formParams = {"param1": "value1", "param2": "value2"};
resourceRequest.sendFormParameters(formParams);
```

#### JavaScript-Adapter
{: #javascript-adapters-sendform }
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

```js
var formParams = {"params":"['value1', 'value2']"};
```

Dieses Array sollte mit `WLResourceRequest.POST` verwendet werden.


> Weitere Hinweise zu `WLResourceRequest` finden Sie in der Benutzerdokumentation im Abschnitt mit den API-Referenzinformationen. 

## Antwort
{: #the-response }
Die Callback-Funktionen `onSuccess` und `onFailure` empfangen ein Antwortobjekt (`response`). Dieses Objekt `response` enthält die Antwortdaten. Über die Eigenschaften dieses Objekts können Sie die erforderlichen Informationen abrufen. Gängige Eigenschaften sind
`responseText`, `responseJSON` (JSON Object) (wenn die Antwort im JSON-Format vorliegt)
und `status` (HTTP-Status der Antwort). 

Falls eine Anforderung fehlschlägt, enthält das Objekt `response` auch eine Eigenschaft `errorMsg`.   
Die Antwort kann je nachdem, ob ein Java- oder JavaScript-Adapter verwendet wird, weitere Eigenschaften enthalten, z. B. `responseHeaders`, `responseTime`, `statusCode`, `statusReason` und `totalTime`.

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

### Antwort bearbeiten
{: #handling-the-response }
Das Antwortobjekt wird von den Callback-Funktionen für Erfolg (`Success`) und Fehler (`Failure`) empfangen.   
Beispiel:

```js
resourceRequest.send().then(
    (response) => {
      resultText = "Successfully called the resource: " + response.responseText;
    },
    (error) => {
      resultText = "Failed to call the resource:" + response.errorMsg;
}
)
```

## Weitere Informationen
{: #for-more-information }
> Weitere Hinweise zu WLResourceRequest finden Sie in den [API-Referenzinformationen](../../../api/client-side-api/javascript/client/).



<img alt="Beispielanwendung" src="resource-request-success-cordova.png" style="float:right"/>
## Beispielanwendungen
{: #sample-applications }
Das Projekt **ResourceRequestIonic** demonstriert eine Ressourcenanforderung unter Verwendung eines Java-Adapters.   
Das Adapter-Maven-Projekt enthält den beim Aufrufen der Ressourcenanforderung verwendeten Java-Adapter.

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestIonic/), um das Ionic-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Adapter-Maven-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
