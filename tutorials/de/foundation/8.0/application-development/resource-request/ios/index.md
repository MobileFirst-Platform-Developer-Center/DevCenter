---
layout: tutorial
title: Ressourcenanforderung von iOS-Anwendungen
breadcrumb_title: iOS
relevantTo: [ios]
downloads:
  - name: Xcode-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mit der {{ site.data.keys.product_adj }} erstellte Anwendungen können mit der REST-API `WLResourceRequest` auf Ressourcen zugreifen.   
Die REST-API funktioniert mit allen Adaptern und externen Ressourcen. 

**Voraussetzungen:**

- Stellen Sie sicher, dass das [SDK der {{ site.data.keys.product }}](../../../application-development/sdk/ios) zu Ihrem nativen
iOS-Projekt hinzugefügt wurde. 
- Informieren Sie sich über das [Erstellen von Adaptern](../../../adapters/creating-adapters/).

## WLResourceRequest
{: #wlresourcerequest }
Die Klasse `WLResourceRequest` handhabt an Adapter oder externe Ressourcen gerichtete Ressourcenanforderungen. 

Erstellen Sie ein `WLResourceRequest`-Objekt und geben Sie den Pfad zu der Ressource und die HTTP-Methode an.   
Verfügbare Methoden sind `WLHttpMethodGet`, `WLHttpMethodPost`, `WLHttpMethodPut` und `WLHttpMethodDelete`.

Objective-C

```objc
WLResourceRequest *request = [WLResourceRequest requestWithURL:[NSURL URLWithString:@"/adapters/JavaAdapter/users/"] method:WLHttpMethodGet];
```
Swift

```swift
let request = WLResourceRequest(
    URL: NSURL(string: "/adapters/JavaAdapter/users"),
    method: WLHttpMethodGet
)
```

* Verwenden Sie für **JavaScript-Adapter** `/adapters/{AdapterName}/{procedureName}`. 
* Verwenden Sie für **Java-Adapter** `/adapters/{AdapterName}/{path}`. Die Angabe für `path` hängt davon ab, wie Sie Ihre
`@Path`-Annotationen im Java-Code definiert haben. Eingeschlossen sind auch alle verwendeten `@PathParam`-Annotationen. 
* Wenn Sie auf Ressourcen außerhalb des Projekts zugreifen möchten, verwenden Sie die vollständige URL nach Maßgabe des externen Servers. 
* **timeout**: Anforderungszeitlimit in Millisekunden (optional)

## Anforderung senden
{: #sending-the-request }
Fordern Sie die Ressource mit der Methode `sendWithCompletionHandler` an.   
Geben Sie einen Completion-Handler für die abgerufenen Daten an: 

Objective-C

```objc
[request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
request.sendWithCompletionHandler { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

Alternativ können Sie `sendWithDelegate` verwenden und einen mit den Protokollen `NSURLConnectionDataDelegate` und `NSURLConnectionDelegate` konformen Delegaten angeben. So können Sie die Antwort differenzierter bearbeiten, wie es beispielsweise bei binären Antworten der Fall ist.    

## Parameter
{: #parameters }
Bevor Sie Ihre Anforderung senden, können Sie nach Bedarf Parameter hinzufügen. 

### Pfadparameter
{: #path-parameters }
Pfadparameter (`/path/value1/value2`) werden - wie bereits erläutert - während der Erstellung des `WLResourceRequest`-Objekts festgelegt. 

### Abfrageparameter
{: #query-parameters }
Wenn Sie Abfrageparameter (`/path?param1=value1...`) senden möchten, verwenden Sie für die einzelnen Parameter die Methode `setQueryParameter`: 

Objective-C

```objc
[request setQueryParameterValue:@"value1" forName:@"param1"];
[request setQueryParameterValue:@"value2" forName:@"param2"];
```
Swift

```swift
request.setQueryParameterValue("value1", forName: "param1")
request.setQueryParameterValue("value2", forName: "param2")
```

#### JavaScript-Adapter
{: #javascript-adapters-query }
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

Objective-C

```objc
[request setQueryParameterValue:@"['value1', 'value2']" forName:@"params"];
```

Swift

```swift
request.setQueryParameterValue("['value1', 'value2']", forName: "params")
```

Dieses Array sollte mit `WLHttpMethodGet` verwendet werden.

### Formularparameter
{: #form-parameters }
Wenn Sie im Hauptteil Formularparameter senden möchten, verwenden Sie `sendWithFormParameters` anstelle von `sendWithCompletionHandler`:

Objective-C

```objc
//@FormParam("height")
NSDictionary *formParams = @{@"height":@"175"};

// Anforderung mit Formularparametern senden
[request sendWithFormParameters:formParams completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
Swift

```swift
//@FormParam("height")
let formParams = ["height":"175"]

// Anforderung mit Formularparametern senden
request.sendWithFormParameters(formParams) { (response, error) -> Void in
    if(error == nil){
        NSLog(response.responseText)
    }
    else{
        NSLog(error.description)
    }
}
```

#### JavaScript-Adapter
{: #javascript-adapters-form }
JavaScript-Adapter verwenden sortierte unbenannte Parameter. Wenn Sie Parameter an einen JavaScript-Adapter übergeben möchten, definieren Sie ein Parameter-Array mit dem Namen `params`:

Objective-C

```objc
NSDictionary *formParams = @{@"params":@"['value1', 'value2']"};
```
Swift

```swift
let formParams = ["params":"['value1', 'value2']"]
```

Dieses Array sollte mit `WLHttpMethodPost` verwendet werden.

### Headerparameter
{: #header-parameters }
Wenn Sie einen Parameter als HTTP-Header senden möchten, verwenden Sie die API `setHeaderValue`: 

Objective-C

```objc
//@HeaderParam("Date")
[request setHeaderValue:@"2015-06-06" forName:@"birthdate"];
```
Swift

```swift
//@HeaderParam("Date")
request.setHeaderValue("2015-06-06", forName: "birthdate")
```

### Weitere angepasste Hauptteilparameter
{: #other-custom-body-parameters }

- Mit `sendWithBody` können Sie im Hauptteil eine beliebige Zeichenfolge festlegen. 
- Mit `sendWithJSON` können Sie im Hauptteil ein beliebiges Verzeichnis festlegen. 
- Mit `sendWithData` können Sie im Hauptteil beliebige `NSData` festlegen. 

### Callback-Warteschlange für Completion-Handler und Delegaten
Wenn Sie verhindern möchten, dass die Benutzerschnittstelle während des Empfangs von Antworten blockiert wird,
können Sie eine private Callback-Warteschlange für den Completion-Handler-Block der `sendWithCompletionHandler`- und `sendWithDelegate`-APIs angeben. 

#### Objective-C

```objc
// Callback-Warteschlange erstellen
dispatch_queue_t completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL);

// Anforderung mit Callback-Warteschlange senden
[request sendWithCompletionHandler:completionQueue completionHandler:^(WLResponse *response, NSError *error) {
    if (error == nil){
        NSLog(@"%@", response.responseText);
    } else {
        NSLog(@"%@", error.description);
    }
}];
```
#### Swift

```swift
// Callback-Warteschlange erstellen
var completionQueue = dispatch_queue_create("com.ibm.mfp.app.callbackQueue", DISPATCH_QUEUE_SERIAL)

// Anforderung mit Callback-Warteschlange senden
request.sendWithCompletionHandler(completionQueue) { (response, error) -> Void in
  if (error == nil){
      NSLog(@"%@", response.responseText);
  } else {
      NSLog(@"%@", error.description);
    }
}
```

## Antwort
{: #the response }
Das Objekt `response` enthält die Antwortdaten. Über die Methoden und Eigenschaften dieses Objekts können Sie die erforderlichen Informationen abrufen. Gängige Eigenschaften sind
`responseText` (String), `responseJSON` (JSON Object) (wenn die Antwort im JSON-Format vorliegt)
und `status` (Int) (HTTP-Status der Antwort). 

Verwenden Sie die Objekte `response` und `error`, um die vom Adapter abgerufenen Daten zu erhalten. 

## Weitere Informationen
{: #for-more-information }
> Weitere Hinweise zu WLResourceRequest finden Sie in den [API-Referenzinformationen](../../../api/client-side-api/objc/client/).

<img alt="Beispielanwendung" src="resource-request-success-ios.png" style="margin-left: 15px; float:right"/>
## Beispielanwendung
{: #sample-application }
Das Projekt ResourceRequestSwift enthält eine in Swift implementierte iOS-Anwendung, die mit einem Java-Adapter eine Ressourcenanforderung absetzt.   
Das Adapter-Maven-Projekt enthält den beim Aufrufen der Ressourcenanforderung verwendeten Java-Adapter. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestSwift/tree/release80), um das iOS-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80), um das Adapter-Maven-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

#### Hinweis zu iOS 9:
{: #note-about-ios-9 }

> Xcode 7 aktiviert standardmäßig [Application Transport Security (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14). Für das Lernprogramm müssen Sie ATS inaktivieren. ([Lesen Sie hier mehr](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error).)
>   1. Klicken Sie in Xcode mit der rechten Maustaste auf **[Projekt]/info.plist → Open As → Source Code**. 
>   2. Fügen Sie Folgendes ein: 
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```
