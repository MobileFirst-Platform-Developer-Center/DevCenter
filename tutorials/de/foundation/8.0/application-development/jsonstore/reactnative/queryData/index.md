---
layout: tutorial
title: Daten einer JSONStore-Sammlung abfragen
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  React-Native-Entwicklungsumgebung einrichten
Führen Sie die Anweisungen von der React-Native-Seite [Gettings Started](https://facebook.github.io/react-native/docs/getting-started.html) aus, um Ihre Maschine für die React-Native-Entwicklung einzurichten.

##  JSONStore-SDK zu Ihrer React-Native-App hinzufügen
Das JSONStore-SDK für React Native ist als React-Native-Module von [npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore) verfügbar.

### Erste Schritte mit einem neuen React-Native-Projekt
1. Erstellen Sie ein neues React-Native-Projekt.
    ```bash
    react-native init MyReactApp
    ```

2. Fügen Sie das MobileFirst-SDK zu Ihrer App hinzu.
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  Verlinken Sie alle nativen Abhängigkeiten mit Ihrer App.
    ```bash
    react-native link
    ```

## Daten einer JSONStore-Sammlung abfragen
Sicherlich werden Sie nur selten alle Dokumente einer Sammlung gleichzeitig abrufen wollen. Generell müssen Sie in der Lage sein, die vorhandenen Daten Ihrer Sammlung abzufragen. 

In Ihrer Datei `App.js` müssen Sie die folgenden Pakete importieren: 

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Das Abfragen von Daten einer JSONStore-Sammlung erfolgt in zwei Schritten:

1. Sie müssen eine Sammlung öffnen, um mit ihr interagieren zu können.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Nachdem Sie eine Sammlung geöffnet haben, können Sie ausgehend von einer gegebenen Abfrage Dokumente mit Daten der Sammlung abrufen. Für JSONStore-Abfragen stehen die beiden Klassen `JSONStoreQuery` und `JSONStoreQueryPart` zur Verfügung.<br/>
    Sie können mehrere JSONStoreQueryPart-Objekte für einen Aufruf verwenden. Übergeben Sie dazu die JSONStoreQueryPart-Objekte in einem Array.
    Mehrere JSONStoreQueryPart-Objekte werden mit einer OR-Anweisung (logisches ODER) verknüpft.
    Mehrere Bedingungen für ein JSONStoreQueryPart-Objekt werden mit einer AND-Anweisung (logisches UND) verknüpft. 

    Sehen Sie sich dazu den folgenden Code an:

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    // Sie sehen, wie mehrere JSONStoreQueryPart-Objekte in einem Array übergeben werden, um eine komplexe Abfrage zu erstellen.
    // Der folgende Aufruf gibt alle Sokumente zurück, in denen "gender" auf "female" gesetzt ist
    // ODER in denen "age" im Bereich von 21 bis 50 liegt.

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
