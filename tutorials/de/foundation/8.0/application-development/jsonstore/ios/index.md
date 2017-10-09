---
layout: tutorial
title: JSONStore in iOS-Anwendungen
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
downloads:
  - name: Xcode-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80
  - name: Adapter-Maven-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Voraussetzungen
{: #prerequisites }
* Gehen Sie das übergeordnete Lernprogramm zu [JSONStore](../) durch.
* Stellen Sie sicher, dass das native {{ site.data.keys.product_adj }}-SDK zum Xcode-Projekt hinzugefügt wurde. Folgen Sie dabei dem Lernprogramm [SDK der {{ site.data.keys.product }} zu iOS-Anwendungen hinzufügen](../../../application-development/sdk/ios/). 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [JSONStore hinzufügen](#adding-jsonstore)
* [Grundlegende Verwendung](#basic-usage)
* [Erweiterte Verwendung](#advanced-usage)
* [Beispielanwendung](#sample-application)

## JSONStore hinzufügen
{: #adding-jsonstore }
1. Fügen Sie zu der vorhandenen `Podfile` im Stammverzeichnis des Xcode-Projekts Folgendes hinzu:

   ```xml
   pod 'IBMMobileFirstPlatformFoundationJSONStore'
   ```

2. Navigieren Sie in einem **Befehlszeilenfenster** zum Stammverzeichnis des Xcode-Projekts und führen Sie den Befehl `pod install` aus. Diese Aktion kann eine Weile dauern. 

Wenn Sie JSONStore verwenden möchten, müssen Sie den JSONStore-Header importieren:  
Objective-C:

```objc
   #import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
   ```

Swift:

```swift
import IBMMobileFirstPlatformFoundationJSONStore    
```

## Grundlegende Verwendung
{: #basic-usage }
### Open
{: #open }
Öffnen Sie mit `openCollections` mindestens ene JSONStore-Sammlung. 

Sammlungen zu starten oder bereitzustellen bedeutet, dass der persistente Speicher für die Sammlung und für Dokumente erstellt wird, wenn er nicht vorhanden ist.   
Wenn der Speicher verschlüsselt ist und das richtige
Kennwort übergeben wird, werden die erforderlichen Sicherheitsprozeduren ausgeführt, um die Daten zugänglich zu machen. 

Informationen zu optionalen Features, die Sie während der Initialisierung aktivieren können, finden Sie im zweiten Teil dieses Lernprogramms unter
**Sicherheit**, **Unterstützung für mehrere Benutzer**
und **{{ site.data.keys.product_adj }}-Adapter integrieren**.



```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")

collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: nil)
} catch let error as NSError {
  // Fehler behandeln
}
```

### Get
{: #get }
Mit `getCollectionWithName` können Sie einen Mechanismus für den Zugriff auf die Sammlung erstellen. Sie müssen `openCollections` vor `getCollectionWithName` aufrufen.

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

```

Die Variable `collection` kann jetzt verwendet werden, um Operationen für die Sammlung `people` auszuführen (z. B.
`add`, `find` und `replace`).

### Add
{: #add }
Verwenden Sie `addData`, um Daten als Dokumente innerhalb einer Sammlung zu speichern. 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let data = ["name" : "yoel", "age" : 23]

do  {
  try collection.addData([data], andMarkDirty: true, withOptions: nil)
} catch let error as NSError {
  // Fehler behandeln
}
```

### Find
{: #find }
Verwenden Sie `findWithQueryParts`, um mit einer Abfrage ein Dokument in einer Sammlung zu finden. Verwenden Sie `findAllWithOptions`, um alle Dokumente aus einer Sammlung abzurufen. Verwenden Sie `findWithIds`, um mit der eindeutigen Dokument-ID nach einem Dokument zu suchen. 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let options:JSONStoreQueryOptions = JSONStoreQueryOptions()
// Rückgabe von maximal 10 Dokumenten. Standardeinstellung: Rückgabe aller Dokumente
options.limit = 10

let query:JSONStoreQueryPart = JSONStoreQueryPart()
query.searchField("name", like: "yoel")

do  {
  let results:NSArray = try collection.findWithQueryParts([query], andOptions: options)
} catch let error as NSError {
  // Fehler behandeln
}
```

### Ersetzen Sie die folgenden Zeilen:

{: #replace }
Verwenden Sie `replaceDocuments`, um Dokumente in einer Sammlung zu modifizieren. Das Feld für die Ersetzung ist die eindeutige ID des Dokuments (`_id`). 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

var document:Dictionary<String,AnyObject> = Dictionary()
document["name"] = "chevy"
document["age"] = 23

var replacement:Dictionary<String, AnyObject> = Dictionary()
replacement["_id"] = 1
replacement["json"] = document

do {
  try collection.replaceDocuments([replacement], andMarkDirty: true)
} catch let error as NSError {
  // Fehler behandeln
}
```

In den vorliegenden Beispielen wird davon ausgegangen, dass das Dokument (`{_id: 1, json: {name: 'yoel', age: 23} }`) in der Sammlung enthalten ist. 

### Remove
{: #remove }
Verwenden Sie `removeWithIds`, um ein Dokument aus einer Sammlung zu löschen. Dokumente werden erst aus der Sammlung entfernt, wenn Sie `markDocumentClean` aufgerufen haben. Weitere Informationen finden Sie im Abschnitt **{{ site.data.keys.product_adj }}-Adapter integrieren** weiter unten in diesem Lernprogramm. 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  try collection.removeWithIds([1], andMarkDirty: true)
} catch let error as NSError {
  // Fehler behandeln
}
```

### removeCollection
{: #remove-collection }
Verwenden Sie `removeCollection`, um alle Dokumente aus einer Sammlung zu löschen. Diese Operation ist mit dem Löschen einer Datenbanktabelle vergleichbar. 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  try collection.removeCollection()
} catch let error as NSError {
  // Fehler behandeln
}
```

### Destroy
{: #destroy }
Mit `destroyData` können Sie die folgenden Daten entfernen: 

* Alle Dokumente
* Alle Sammlungen
* Alle Stores (siehe **Unterstützung für mehrere Benutzer** weiter unten in diesem Lernprogramm)
* Alle JSONStore-Metadaten und -Sicherheitsartefakte (siehe **Sicherheit** weiter unten in diesem Lernprogramm)

```swift
do {
  try JSONStore.sharedInstance().destroyData()
} catch let error as NSError {
  // Fehler behandeln
}
```

## Erweiterte Verwendung
{: #advanced-usage }
### Sicherheit
{: #security }
Sie können alle Sammlungen in einem Store schützen, indem Sie an die Funktion `openCollections` ein Objekt `JSONStoreOpenOptions` mit einem Kennwort übergeben. Wenn kein Kennwort übergeben wird, wird keines
der Dokumente in den Sammlungen des Store verschlüsselt. 

Einige Sicherheitsmetadaten werden in der *Keychain* (iOS)
gespeichert.  
Der Store wird mit einem
256-Bit-Schlüssel gemäß Advanced Encryption Standard (AES) verschlüsselt. Alle Schlüssel werden durch
die Funktion
PBKDF2 (Password-Based Key Derivation Function 2) verstärkt.

Verwenden Sie `closeAllCollections`, um den Zugriff auf alle Sammlungen bis zum erneuten Aufruf von `openCollections` zu sperren. Wenn Sie sich
`openCollections` als eine Art Anmeldefunktion vorstellen, wäre `closeAllCollections` die entsprechende Abmeldefunktion. 

Verwenden Sie `changeCurrentPassword`, um das Kennwort zu ändern. 

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.password = "123"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
  // Fehler behandeln
}
```

### Unterstützung für mehrere Benutzer
{: #multiple-user-support }
Sie können mehrere Stores erstellen, die verschiedene Sammlungen in nur einer
{{ site.data.keys.product_adj }}-Anwendung enthalten. Die Funktion `openCollections` kann mit einem Optionsobjekt mit einem Benutzernamen verwendet werden. Wenn kein Benutzername angegeben wird, wird der Standardbenutzername **jsonstore** verwendet.

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.username = "yoel"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
  // Fehler behandeln
}
```

### {{ site.data.keys.product_adj }}-Adapter integrieren
{: #mobilefirst-adapter-integration }
In diesem Abschnitt wird vorausgesetzt, dass Sie sich mit Adaptern auskennen. Die Adapterintegration ist optional. Sie ermöglicht das Senden von Daten einer Sammlung an einen Adapter und das Abrufen von Daten eines Adapters in eine Sammlung. 

Sie können diese Ziele mit Funktionen wie `WLResourceRequest` erreichen. 

#### Adapterimplementierung
{: #adapter-implementation }
Erstellen Sie einen Adapter mit dem Namen **People**.Definieren Sie für den Adapter die Prozeduren
`addPerson`, `getPeople`, `pushPeople`, `removePerson` und `replacePerson`.

```javascript
function getPeople () {
var data = { peopleList : [{name: 'chevy', age: 23}, {name: 'yoel', age: 23}] };
	WL.Logger.debug('Adapter: people, procedure: getPeople called.');
	WL.Logger.debug('Sending data: ' + JSON.stringify(data));
	return data;
}
function pushPeople(data) {
	WL.Logger.debug('Adapter: people, procedure: pushPeople called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function addPerson(data) {
	WL.Logger.debug('Adapter: people, procedure: addPerson called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function removePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: removePerson called.');
	WL.Logger.debug('Got data from JSONStore to REMOVE: ' + data);
	return;
}
function replacePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: replacePerson called.');
	WL.Logger.debug('Got data from JSONStore to REPLACE: ' + data);
	return;
}
```

#### Daten von einem {{ site.data.keys.product_adj }}-Adapter laden
{: #load-data-from-mobilefirst-adapter }
Verwenden Sie `WLResourceRequest`, um Daten von einem MobileFirst-Adapter zu laden. 

```swift
// LoadFromAdapter - Beginn
class LoadFromAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    let responsePayload:NSDictionary = response.getResponseJson()
    let people:NSArray = responsePayload.objectForKey("peopleList") as! NSArray
    // Erfolg behandeln
  }

  func onFailure(response: WLFailResponse!) {
    // Fehler behandeln
  }
}
// LoadFromAdapter - Ende

let pull = WLResourceRequest(URL: NSURL(string: "/adapters/People/getPeople"), method: "GET")

let loadDelegate:LoadFromAdapter = LoadFromAdapter()
pull.sendWithDelegate(loadDelegate)
```

#### getPushRequired (vorläufige Dokumente)
{: #get-push-required-dirty-documents }
Wenn Sie `allDirty` aufrufen, wird ein Array mit vorläufigen Dokumenten (dirty documents)
zurückgegeben. Diese Dokumente enthalten lokale Modifikationen, die es auf dem Back-End-System noch nicht gibt. 

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  let dirtyDocs:NSArray = try collection.allDirty()
} catch let error as NSError {
  // Fehler behandeln
}
```

Wenn Sie JSONStore daran hindern möchten, Dokumente als vorläufig zu markieren, übergeben Sie die Option `andMarkDirty:false`
an `add`, `replace` und `remove`. 

#### Änderungen mit Push übertragen
{: #push-changes }
Wenn Sie Änderungen mit Push an einen Adapter senden möchten, rufen Sie `allDirty` auf, um eine Liste
der Dokumente mit Modifikationen abzurufen. Verwnden Sie dann `WLResourceRequest`. Nach dem Senden der Daten und einer Bestätung des erfolgreichen Sendens müssen Sie
`markDocumentsClean` aufrufen.

```swift
// PushToAdapter - Beginn
class PushToAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    // Erfolg behandeln
  }

  func onFailure(response: WLFailResponse!) {
    // Fehler behandeln
  }
}
// PushToAdapter - Ende

let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  let dirtyDocs:NSArray = try collection.allDirty()
  let pushData:NSData = NSKeyedArchiver.archivedDataWithRootObject(dirtyDocs)

  let push = WLResourceRequest(URL: NSURL(string: "/adapters/People/pushPeople"), method: "POST")

  let pushDelegate:PushToAdapter = PushToAdapter()
  push.sendWithData(pushData, delegate: pushDelegate)

} catch let error as NSError {
  // Fehler behandeln
}
```

<img alt="Beispielanwendung" src="jsonstore-ios-screen.png" style="float:right; width:240px;"/>
## Beispielanwendung
{: #sample-application }
Das JSONStoreSwift-Projekt enthält eine native iOS-Swift-Anwendung, die die JSONStore-APIs verwendet.   
Darüber hinaus ist ein JavaScript-Adapter-Maven-Projekt verfügbar. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80), um das native iOS-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80), um das Adapter-Maven-Projekt herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
