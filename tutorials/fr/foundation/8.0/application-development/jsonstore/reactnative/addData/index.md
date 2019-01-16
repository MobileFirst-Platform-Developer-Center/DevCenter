---
layout: tutorial
title: Adding data to JSONStore collection
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## Adding data to a JSONStore collection

Inside your `App.js` you need to import the following packages:

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

There are three steps for adding data to a JSONStore collection:

1. Creating a new collection, you can create a new collection by calling the `JSONStoreCollection` constructor as shown below:.
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  Opening a collection, you won’t be able to do anything with a newly created collection unless you open it. To open the collection, call WLJSONStore’s `openCollections` API. See the sample code below.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. Adding data to collection, after you have opened a collection, start data transactions inwards or outwards. You can add data to a open collection using the following API.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
