---
layout: tutorial
title: Fetching data from JSONStore collection
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
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

## Fetching data from JSONStore collection
Inside your `App.js` you need to import the following packages:

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

There are two steps for fetching data from a JSONStore collection:

1. Opening a Collection, opening a collection allows us to interact with it.
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Fetching data from a Collection: After you have opened a collection, you can fetch all the documents using the following API.
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
