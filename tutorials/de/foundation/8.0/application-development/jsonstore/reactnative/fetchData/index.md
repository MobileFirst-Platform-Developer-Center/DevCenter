---
layout: tutorial
title: Daten einer JSONStore-Sammlung abrufen
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
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

## Daten einer JSONStore-Sammlung abrufen
In Ihrer Datei `App.js` müssen Sie die folgenden Pakete importieren: 

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Das Abrufen von Daten einer JSONStore-Sammlung erfolgt in zwei Schritten:

1. Sie müssen eine Sammlung öffnen, um mit ihr interagieren zu können.
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Nachdem Sie eine Sammlung geöffnet haben, können Sie mit der folgenden API alle Dokumente der Sammlung abrufen.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.findAllDocuments()
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
