---
layout: tutorial
title: Daten zu einer JSONStore-Sammlung hinzufügen
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## Daten zu einer JSONStore-Sammlung hinzufügen

In Ihrer Datei `App.js` müssen Sie die folgenden Pakete importieren: 

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Das Hinzufügen von Daten zu einer JSONStore-Sammlung erfolgt in drei Schritten:

1. Sie können eine neue Sammlung erstellen. Rufen Sie dazu den Konstruktor `JSONStoreCollection` wie nachfolgend gezeigt auf:
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  Öffnen Sie die neu erstellte Sammlung, da Sie andernfalls nicht mit ihr interagieren können. Rufen Sie zum Öffnen der Sammlung die WLJSONStore-API `openCollections` auf. Sehen Sie sich dazu den folgenden Beispielcode an.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. Nachdem Sie die Sammlung geöffnet haben, können Sie Daten hinzufügen. Starten Sie dazu Datentransaktionen für eingehende oder abgehende Daten. Sie können die folgende API verwenden, um Daten zu einer offenen Sammlung hinzuzufügen.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
