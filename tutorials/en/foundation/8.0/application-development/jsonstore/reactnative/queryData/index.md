---
layout: tutorial
title: Querying data from JSONStore collection
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
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

## Querying data from JSONStore collection
Rarely would you want to get all the documents in a collection at the same time. In general, you need the ability to query the existing data in your collection.

Inside your `App.js` you need to import the following packages:

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

There are two steps for querying data from a JSONStore collection:

1. Opening a Collection, opening a collection allows us to interact with it.
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Fetching data from a Collection: After you have opened a collection, you can fetch the documents based on given query. For querying JSONStore two classes are provided to work with `JSONStoreQuery` and `JSONStoreQueryPart`.<br/>
    A `JSONStoreQuery` contains one or more `JSONStoreQueryPart`.<br/>
    Multiple `JSONStoreQueryPart` objects for the same `JSONStoreQuery` are joined using **OR** statement.<br/>
    Multiple conditions for one `JSONStoreQueryPart` are joined using an **AND** statement.

    Refer to the following code:

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
