---
layout: tutorial
title: Syncing data of JSONStore collection to a Cloudant DB
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  Setting up the React Native development environment
Follow the instructions provided in the React Native [Gettings Started Page](https://facebook.github.io/react-native/docs/getting-started.html) to set up your machine for React Native development.

##  Adding the JSONStore SDK to your React Native app
The JSONStore SDK for React Native is available as a React Native module from [npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore).

### Getting started with a new React Native project
1. Create a new React Native project.
    ```bash
    react-native init MyReactApp
    ```

2. Add the MobileFirst SDK to your app.
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  Link all native dependencies to your app.
    ```bash
    react-native link
    ```

## Syncing data of JSONStore collection to a Cloudant DB
The disadvantage of having all the app data locally is that when the app is uninstalled you will lose the data. To counter this problem, IBM JSONStore provides SYNC functionality with Cloudant DB.

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

There are two steps for syncing data from a JSONStore collection:

1. Opening a Collection, the only difference between a normal `JSONStoreCollection` and a synced `JSONStoreCollection` is in the way they are opened. Synced JSONStoreCollections are opened with corresponding `JSONStoreInitOptions`. JSONStoreInitOptions is where you will decide the Synchronisation Policy and the adapter to sync data with. This adapter is basically Cloudant Sync Adapter, find more info [here](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/). JSONStoreInitOptions provides an API `setSyncOptions(syncPolicy, adapterName)`. JSONStoreSyncPolicy needs to be one of the following values [‘SYNC_NONE’, ‘SYNC_DOWNSTREAM’, ‘SYNC_UPSTREAM’]. **adapterName** is the name of the adapter deployed on your MobileFirst Server that works with Cloudant DB. Make sure the Cloudant DB details are entered correctly for Sync to work.

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. Calling the Sync API, all the JSONStoreCollections opened with Sync will automatically trigger synchronisation on success of `openCollection()` API.<br/>
    If a JSONStoreCollection is opened with **JSONStoreSyncPolicy.SYNC_DOWNSTREAM** policy, you can explicitly call the `sync()` API to fetch the latest pull.<br/>
    If a JSONStoreCollection is opened with **JSONStoreSyncPolicy.SYNC_UPSTREAM** policy, the sync process is automatically triggered upon adding, updating or removing a document from the collection. You can still call `sync()` API to explicitly trigger synchronisation.<br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
