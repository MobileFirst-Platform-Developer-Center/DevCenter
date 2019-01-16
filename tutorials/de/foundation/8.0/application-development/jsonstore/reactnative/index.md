---
layout: tutorial
title: JSONStore in React-Native-Anwendungen
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## Voraussetzungen
{: #prerequisites }
* Gehen Sie das übergeordnete Lernprogramm zu [JSONStore](../) durch.
* Stellen Sie sicher, dass das zentrale {{ site.data.keys.product_adj }}-SDK für React Native zum Projekt hinzugefügt wurde. Folgen Sie dabei dem Lernprogramm [Mobile-Foundation-SDK zu React-Native-Anwendungen hinzufügen](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [JSONStore hinzufügen](#adding-jsonstore)
* [Grundlegende Verwendung](#basic-usage)
* [Beispielanwendung](#sample_app_for_jsonstore)

## JSONStore hinzufügen
{: #adding-jsonstore }
Gehen Sie wie folgt vor, um das JSONStore-Plug-in zu Ihrer React-Native-Anwendung hinzuzufügen:

1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zu Ihrem React-Native-Projektordner.
2. Führen Sie den folgenden Befehl aus:
    ```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## Grundlegende Verwendung
{: #basic-usage }
### Neue JSONStore-Sammlung erstellen
{: #create_new_jsonstore_collection}
1.  Mit der Klasse `JSONStoreCollection` werden Sie JSONStore-Instanzen erstellen. Für die neue erstellte JSONStore-Sammlung können Sie auch zusätzliche Konfigurationseinstellungen festlegen (z. B. für Suchfelder).
2.  Für die Interaktion mit einer vorhandenen JSONStore-Sammlung (z. B. zum Hinzufügen oder Entfernen von Daten), müssen Sie die Sammlung *öffnen*. Verwenden Sie dafür die API `openCollections()`.
    ```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// Erfolg behandeln
    }).catch(err => {
    	// Feler behandeln
});
```

### Add
{: #add}
Verwenden Sie die API `addData()`, um JSON-Daten in einer Sammlung zu speichern. 

```javascript
var data = { "name": "John", age: 28 };
var collection = new JSONStoreCollection('people');
collection.addData(data)
.then(res => {
  // Erfolg behandeln
    }).catch(err => {
    	// Feler behandeln
});
```

> Mit dieser API können Sie ein einzelnes JSON-Objekt oder ein Array mit JSON-Objekten hinzufügen. 

### Find
{: #find}
1.  Verwenden Sie `find`, um mit einer Abfrage ein Dokument in einer Sammlung zu finden.
2.  Verwenden Sie die API `findAllDocuments()`, um alle Dokumente aus einer Sammlung abzurufen.
3.  Nutzen Sie die APIs `findDocumentById()` und `findDocumentsById()` für eine Suche unter Verwendung der eindeutigen Dokument-ID.
4.  Verwenden Sie die API `findDocuments()` zum Abfragen der Sammlung. Die Daten für Abfragen können Sie mithilfe von `JSONStoreQueryPart`-Klassenobjekten filtern.

> Übergeben Sie ein Array mit `JSONStoreQueryPart`-Objekten als Parameter der API `findDocuments`. 

```javascript
var collection = new JSONStoreCollection('people');
var query = new JSONStoreQueryPart();
query.addEqual("name", "John");
collection.findDocuments([query])
.then(res => {
	// Erfolg behandeln
    }).catch(err => {
    	// Feler behandeln
});
```

### Remove
{: #remove}
Verwenden Sie `remove`, um ein Dokument aus einer Sammlung zu löschen. 

```javascript
var id = 1; // for example
var collection = new JSONStoreCollection('people');
collection.removeDocumentById(id)
.then(res => {
	// Erfolg behandeln
    }).catch(err => {
    	// Feler behandeln
});
```

### removeCollection
{: #removecollection}
Verwenden Sie `removeCollection`, um alle Dokumente aus einer Sammlung zu löschen. Diese Operation ist mit dem Löschen einer Datenbanktabelle vergleichbar. 

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// Erfolg behandeln
    }).catch(err => {
    	// Feler behandeln
});
```

## Beispiel-App für IBM MobileFirst JSONStore
{: #sample_app_for_jsonstore}
Laden Sie das Beispiel [hier](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative) herunter.

### Beispiel ausführen
{: #running_sample}
Führen Sie im Stammverzeichnis des Beispiels den folgenden Befehl aus, um alle Projektabhängigkeiten zu installieren:

```bash
npm install
```

>**Hinweis:** Vergewissern Sie sich, dass Ihre Dateien *mfpclient.properties* und *mfpclient.plist* auf den richtigen MobileFirst Server zeigen.

1. Registrieren Sie die App. Führen Sie dazu im Verzeichnis `android` den folgenden Befehl aus:
    ```bash
    mfpdev app register
    ```

2. Konfigurieren Sie die App
    (nur Android).
   *  Öffnen Sie die Datei `android/app/src/main/AndroidManifest.xml` im React-Native-Projektstammverzeichnis.<br/>
    	 Fügen Sie zum Tag `<manifest>` die folgende Zeile hinzu:<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 Fügen Sie zum Tag `<application>` die folgende Zeile hinzu:<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 Dieser Schritt ist für die Bibliothek *react-native-ibm-mobilefirst* erforderlich.<br/>

	 *  Öffnen Sie die Datei `android/app/build.gradle` im React-Native-Projektstammverzeichnis.<br/>
      Fügen Sie innerhalb von *android {}* den folgenden Code hinzu:<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      Dieser Schritt ist für die Bibliothek *react-native-ibm-mobilefirst-jsonstore* erforderlich.

3. Kehren Sie für die Ausführung der App zum Stammverzeichnis zurück, navigieren Sie zum Verzeichnis `iOS` und führen Sie den folgenden Befehl aus:
    `mfpdev app register`

Jetzt kann die App ausgeführt werden.
Führen Sie für eine Ausführung unter Android den folgen Befehl aus:
```bash
react-native run-android
```
