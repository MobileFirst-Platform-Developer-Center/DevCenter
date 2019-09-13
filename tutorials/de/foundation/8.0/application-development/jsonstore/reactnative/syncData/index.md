---
layout: tutorial
title: Daten einer JSONStore-Sammlung mit einer Cloudant-Datenbank synchronisieren
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
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

## Daten einer JSONStore-Sammlung mit einer Cloudant-Datenbank synchronisieren
Wenn alle App-Daten lokal vorhanden sind, hat dies den Nachteil, dass die Daten bei einer Deinstallation der App verlorengehen. Angesichts dieses Problems bietet IBM JSONStore eine Funktion für die Synchronisation mit einer Cloudant-Datenbank. 

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

Die Synchronisation der Daten einer JSONStore-Sammlung erfolgt in zwei Schritten:

1. Der einzige Unterschied zwischen einer normalen `JSONStoreCollection` und einer synchronisierten `JSONStoreCollection` besteht in der Art, die Sammlung zu öffnen. Synchrinisierte JSONStoreCollections werden mit entsprechenden `JSONStoreInitOptions` geöffnet. Mithilfe der JSONStoreInitOptions entscheiden Sie über die Synchronisationsrichtlinie und den Adapter für die Datensynchronisation. Dieser Adapter ist im Wewentlichen der Cloudant Sync Adapter. Weitere Informationen finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/). Die JSONStoreInitOptions stellen eine API `setSyncOptions(syncPolicy, adapterName)` bereit. JSONStoreSyncPolicy (für die Richtlinie) muss einen der folgenden Werte annehmen: ‘SYNC_NONE’, ‘SYNC_DOWNSTREAM’, ‘SYNC_UPSTREAM’. **adapterName** (für den Adapter) ist der Name des Adapters, der in Ihrem mit der Cloudant-Datenbank interagierenden MobileFirst Server implementiert ist. Stellen Sie für eine ordnungsgemäße Synchronisatin sicher, dass die Cloudant-DB-Details korrekt eingegeben sind. 

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. Wenn die Synchronisations-API aufgerufen wird, werden alle JSONStoreCollections, die wie synchronisierte Sammlungen geöffnet wurden, bei erfolgreicher Ausführung der API `openCollection()` automatisch die Synchronisation auslösen. <br/>
    Wenn eine JSONStoreCollection mit der Richtlinie **JSONStoreSyncPolicy.SYNC_DOWNSTREAM** geöffnet wird, können Sie die API `sync()` explizit aufrufen, um die zuletzt per Pull-Operation übertragenen Daten abzurufen. <br/>
    Wenn eine a JSONStoreCollection mit der Richtlinie **JSONStoreSyncPolicy.SYNC_UPSTREAM** geöffnet wird, wird der Synchronisationsprozess automatisch ausgelöst, sobald ein Dokument der Sammlung hinzugefügt, aktualisiert oder entfernt wird. Unbhängig davon können Sie die API `sync()` aufrufen, um die Synchronisation explizit auszulösen. <br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
