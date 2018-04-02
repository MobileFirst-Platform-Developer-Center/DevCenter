---
layout: tutorial
title: JSONStore in Android-Anwendungen
breadcrumb_title: Android
relevantTo: [android]
weight: 3
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Voraussetzungen
{: #prerequisites }

* Gehen Sie das übergeordnete Lernprogramm zu [JSONStore](../) durch.
* Stellen Sie sicher, dass das native {{ site.data.keys.product_adj }}-SDK zum Android-Studio-Projekt hinzugefügt wurde. Folgen Sie dabei dem Lernprogramm [SDK der {{ site.data.keys.product }} zu Android-Anwendungen hinzufügen](../../../application-development/sdk/android/). 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [JSONStore hinzufügen](#adding-jsonstore)
* [Grundlegende Verwendung](#basic-usage)
* [Erweiterte Verwendung](#advanced-usage)
* [Beispielanwendung](#sample-application)

## JSONStore hinzufügen
{: #adding-jsonstore }
1. Wählen Sie unter **Android → Gradle Scripts** die Datei
**build.gradle (Module: app)** aus. 

2. Fügen Sie zum vorhandenen Abschnitt `dependencies` die folgenden Zeilen hinzu: 

```
compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0.+'
```
3. Fügen Sie Folgendes zum Abschnitt "DefaultConfig" Ihrer Datei build.gradle hinzu.
```
  ndk {
        abiFilters "armeabi", "armeabi-v7a", "x86", "mips"
      }
 ```     
 > **Hinweis** : Die abiFilters werden hinzugefügt, um sicherzustellen, dass die Apps mit JSONStore in jeder der oben angegebenen Architekturen ausgeführt werden können. Dies ist erforderlich, weil JSONStore von einer Bibliothek eines anderen Anbieters abhängig ist, die nur diese Architekturen unterstützt. 

## Grundlegende Verwendung
{: #basic-usage }
### Open
{: #open }
Öffnen Sie mit `openCollections` mindestens ene JSONStore-Sammlung. 

Sammlungen zu starten oder bereitzustellen bedeutet, dass der persistente Speicher für die Sammlung und für Dokumente erstellt wird, wenn er nicht vorhanden ist. Wenn der Speicher verschlüsselt ist und das richtige
Kennwort übergeben wird, werden die erforderlichen Sicherheitsprozeduren ausgeführt, um die Daten zugänglich zu machen. 

Informationen zu optionalen Features, die Sie während der Initialisierung aktivieren können, finden Sie im zweiten Teil dieses Lernprogramms unter
**Sicherheit**, **Unterstützung für mehrere Benutzer**
und **{{ site.data.keys.product_adj }}-Adapter integrieren**.



```java
Context  context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  WLJSONStore.getInstance(context).openCollections(collections);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

### Get
{: #get }
Mit `getCollectionByName` können Sie einen Mechanismus für den Zugriff auf die Sammlung erstellen. Sie müssen `openCollections` vor `getCollectionByName` aufrufen.

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

Die Variable `collection` kann jetzt verwendet werden, um Operationen für die Sammlung `people` auszuführen (z. B.
`add`, `find` und `replace`).

### Add
{: #add }
Verwenden Sie `addData`, um Daten als Dokumente innerhalb einer Sammlung zu speichern. 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // Optionen hinzufügen
  JSONStoreAddOptions options = new JSONStoreAddOptions();
  options.setMarkDirty(true);
  JSONObject data = new JSONObject("{age: 23, name: 'yoel'}")
  collection.addData(data, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

### Find
{: #find }
Verwenden Sie `findDocuments`, um mit einer Abfrage ein Dokument in einer Sammlung zu finden. Verwenden Sie `findAllDocuments`, um alle Dokumente aus einer Sammlung abzurufen. Verwenden Sie `findDocumentById`, um mit der eindeutigen Dokument-ID nach einem Dokument zu suchen. 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreQueryPart queryPart = new JSONStoreQueryPart();
  // Suche nach grober Übereinstimmung - LIKE
  queryPart.addLike("name", name);
  JSONStoreQueryParts query = new JSONStoreQueryParts();
  query.addQueryPart(queryPart);
  JSONStoreFindOptions options = new JSONStoreFindOptions();
  // Rückgabe von maximal 10 Dokumenten; Standard: Rückgabe aller Dokumente
  options.setLimit(10);
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> results = collection.findDocuments(query, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

### Replace
{: #replace }
Verwenden Sie `replaceDocument`, um Dokumente in einer Sammlung zu modifizieren. Das Feld für die Ersetzung ist die eindeutige ID des Dokuments (`_id`). 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreReplaceOptions options = new JSONStoreReplaceOptions();
  // Daten als vorläufig markieren
  options.setMarkDirty(true);
  JSONStore replacement = new JSONObject("{_id: 1, json: {age: 23, name: 'chevy'}}");
  collection.replaceDocument(replacement, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

In den vorliegenden Beispielen wird davon ausgegangen, dass das Dokument (`{_id: 1, json: {name: 'yoel', age: 23} }`) in der Sammlung enthalten ist. 

### Remove
{: #remove }
Verwenden Sie `removeDocumentById`, um ein Dokument aus einer Sammlung zu löschen. Dokumente werden erst aus der Sammlung entfernt, wenn Sie `markDocumentClean` aufgerufen haben. Weitere Informationen finden Sie im Abschnitt **{{ site.data.keys.product_adj }}-Adapter integrieren** weiter unten in diesem Lernprogramm. 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreRemoveOptions options = new JSONStoreRemoveOptions();
  // Daten als vorläufig markieren
  options.setMarkDirty(true);
  collection.removeDocumentById(1, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

### removeCollection
{: #remove-collection }
Verwenden Sie `removeCollection`, um alle Dokumente aus einer Sammlung zu löschen. Diese Operation ist mit dem Löschen einer Datenbanktabelle vergleichbar. 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  collection.removeCollection();
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

### Destroy
{: #destroy }
Mit `destroy` können Sie die folgenden Daten entfernen: 

* Alle Dokumente
* Alle Sammlungen
* Alle Stores (siehe **Unterstützung für mehrere Benutzer** weiter unten in diesem Lernprogramm)
* Alle JSONStore-Metadaten und -Sicherheitsartefakte (siehe **Sicherheit** weiter unten in diesem Lernprogramm)

```java
Context  context = getContext();
try {
  WLJSONStore.getInstance(context).destroy();
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

## Erweiterte Verwendung
{: #advanced-usage }
### Sicherheit
{: #security }
Sie können alle Sammlungen in einem Store schützen, indem Sie an die Funktion `openCollections` ein Objekt `JSONStoreInitOptions` mit einem Kennwort übergeben. Wenn kein Kennwort übergeben wird, wird keines
der Dokumente in den Sammlungen des Store verschlüsselt. 

Einige Sicherheitsmetadaten werden in den gemeinsamen Vorgaben (Android)
gespeichert.  
Der Store wird mit einem
256-Bit-Schlüssel gemäß Advanced Encryption Standard (AES) verschlüsselt. Alle Schlüssel werden durch
die Funktion
PBKDF2 (Password-Based Key Derivation Function 2) verstärkt.

Verwenden Sie `closeAll`, um den Zugriff auf alle Sammlungen bis zum erneuten Aufruf von `openCollections` zu sperren. Wenn Sie sich
`openCollections` als eine Art Anmeldefunktion vorstellen, wäre `closeAll` die entsprechende Abmeldefunktion. 

Verwenden Sie `changePassword`, um das Kennwort zu ändern. 

```java
Context  context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setPassword("123");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

#### Unterstützung für mehrere Benutzer
{: #multiple-user-support }
Sie können mehrere Stores erstellen, die verschiedene Sammlungen in nur einer
{{ site.data.keys.product_adj }}-Anwendung enthalten. Die Funktion `openCollections` kann mit einem Optionsobjekt mit einem Benutzernamen verwendet werden. Wenn kein Benutzername angegeben wird, wird der Standardbenutzername **jsonstore** verwendet.

```java
Context  context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setUsername("yoel");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

#### {{ site.data.keys.product_adj }}-Adapter integrieren
{: #mobilefirst-adapter-integration }
In diesem Abschnitt wird vorausgesetzt, dass Sie sich mit Adaptern auskennen. Die Adapterintegration ist optional. Sie ermöglicht das Senden von Daten einer Sammlung an einen Adapter und das Abrufen von Daten eines Adapters in eine Sammlung. Sie können diese Ziele mit Funktionen wie `WLResourceRequest` erreichen oder mit einer eigenen Instanz von `HttpClient`, falls Sie mehr Flexibilität benötigen. 

#### Adapterimplementierung
{: #adapter-implementation }
Erstellen Sie einen Adapter mit dem Namen **JSONStoreAdapter**. Definieren Sie für den Adapter die Prozeduren
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
Verwenden Sie `WLResourceRequest`, um Daten von einem Adapter zu laden. 

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // Fehler behandeln
  }
  @Override
  public void onSuccess(WLResponse response) {
    try {
      JSONArray loadedDocuments = response.getResponseJSON().getJSONArray("peopleList");
    } catch(Exception e) {
      // Fehler bei der Entschlüsselung von JSON-Daten
    }
  }
};

try {
  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/getPeople"), WLResourceRequest.GET);
  request.send(responseListener);
} catch (URISyntaxException e) {
  // Fehler behandeln
}
```

#### getPushRequired (vorläufige Dokumente)
{: #get-push-required-dirty-documents }
Wenn Sie `findAllDirtyDocuments` aufrufen, wird ein Array mit vorläufigen Dokumenten (dirty documents)
zurückgegeben. Diese Dokumente enthalten lokale Modifikationen, die es auf dem Back-End-System noch nicht gibt. 

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocs = collection.findAllDirtyDocuments();
  // Erfolg behandeln
} catch(JSONStoreException e) {
  // Fehler behandeln
}
```

Wenn Sie JSONStore daran hindern möchten, Dokumente als vorläufig zu markieren, übergeben Sie die Option `options.setMarkDirty(false)`
an `add`, `replace` und `remove`. 

#### Änderungen mit Push übertragen
{: #push-changes }
Wenn Sie Änderungen mit Push an einen Adapter senden möchten, rufen Sie `findAllDirtyDocuments` auf, um eine Liste
der Dokumente mit Modifikationen abzurufen. Verwnden Sie dann `WLResourceRequest`. Nach dem Senden der Daten und einer Bestätung des erfolgreichen Sendens müssen Sie
`markDocumentsClean` aufrufen.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // Fehler behandeln
  }
  @Override
  public void onSuccess(WLResponse response) {
    // Erfolg behandeln
  }
};
Context context = getContext();

try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocuments = people.findAllDirtyDocuments();

  JSONObject payload = new JSONObject();
  payload.put("people", dirtyDocuments);

  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/pushPeople"), WLResourceRequest.POST);
  request.send(payload, responseListener);
} catch(JSONStoreException e) {
  // Fehlschlag behandeln
} catch (URISyntaxException e) {
  // Fehler behandeln
}
```

<img alt="Beispielanwendung" src="android-native-screen.jpg" style="float:right; width:240px;"/>
## Beispielanwendung
{: #sample-application }
Das Projekt JSONStoreAndroid enthält eine native Android-Anwendung, die die JSONStore-APIs verwendet.   
Eingeschlossen ist ein JavaScript-Adapter-Maven-Projekt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid), um das native Android-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80), um das Adapter-Maven-Projekt herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
