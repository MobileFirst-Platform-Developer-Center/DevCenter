---
layout: tutorial
title: Using JSONStore in Native iOS applications
relevantTo: [ios]
weight: 2
downloads:
  - name: Download Native Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid
---
## Overview
This tutorial is a continuation of the JSONStore Overview tutorial.    

#### Jump to:

* [Adding JSONStore](#adding-jsonstore)
* [Basic Usage](#basic-usage)
* [Advanced Usage](#advanced-usage)
* [Sample application](#sample-application)

## Basic Usage
### Open
Use <code>openCollections</code> to open one or more JSONStore collections.

Starting or provisioning a collections means creating the persistent storage that contains the collection and documents, if it does not exists. If the persistent storage is encrypted and a correct password is passed, the necessary security procedures to make the data accessible are run.

For optional features that you can enable at initialization time, see **Security, Multiple User Support** and **MobileFirst Adapter Integration** in the second part of this tutorial.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  WLJSONStore.getInstance(context).openCollections(collections);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Get
Use <code>getCollectionByName</code> to create an accessor to the collection. You must call <code>openCollections</code> before you call <code>getCollectionByName</code>.
```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

The variable <code>collection</code> can now be used to perform operations on the <code>people</code> collection such as <code>add</code>, <code>find</code>, and <code>replace</code>

### Add
Use <code>addData</code> to store data as documents inside a collection
```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  //Add options.
  JSONStoreAddOptions options = new JSONStoreAddOptions();
  options.setMarkDirty(true);
  JSONObject data = new JSONObject("{age: 23, name: 'yoel'}")
  collection.addData(data, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Find
Use <code>findDocuments</code> to locate a document inside a collection by using a query. Use <code>findAllDocuments</code> to retrieve all the documents inside a collection. Use <code>findDocumentById</code> to search by the document unique identifier.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreQueryPart queryPart = new JSONStoreQueryPart();
  // fuzzy search LIKE
  queryPart.addLike("name", name);
  JSONStoreQueryParts query = new JSONStoreQueryParts();
  query.addQueryPart(queryPart);
  JSONStoreFindOptions options = new JSONStoreFindOptions();
  // returns a maximum of 10 documents, default: returns every document
  options.setLimit(10);
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> results = collection.findDocuments(query, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Replace
Use <code>replaceDocument</code> to modify documents inside a collection. The field that you use to perform the replacement is <code>_id,</code> the document unique identifier.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreReplaceOptions options = new JSONStoreReplaceOptions();
  // mark data as dirty
  options.setMarkDirty(true);
  JSONStore replacement = new JSONObject("{_id: 1, json: {age: 23, name: 'chevy'}}");
  collection.replaceDocument(replacement, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

This examples assumes that the document <code>{_id: 1, json: {name: 'yoel', age: 23} }</code> is in the collection.

### Remove
Use <code>removeDocumentById</code> to delete a document from a collection.
Documents are not erased from the collection until you call <code>markDocumentClean</code>. For more information, see the **MobileFirst Adapter Integration** section later in this tutorial.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreRemoveOptions options = new JSONStoreRemoveOptions();
  // Mark data as dirty
  options.setMarkDirty(true);
  collection.removeDocumentById(1, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Remove Collection
Use <code>removeCollection</code> to delete all the documents that are stored inside a collection. This operation is similar to dropping a table in database terms.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  collection.removeCollection();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Destroy
Use <code>destroy</code> to remove the following data:

* All documents
* All collections
* All Stores - See **Multiple User Support** later in this tutorial
* All JSONStore metadata and security artifacts - See **Security** later in this tutorial

```java
Context context = getContext();
try {
  WLJSONStore.getInstance(context).destroy();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

## Advanced Usage
### Security
You can secure all the collections in a store by passing a <code>JSONStoreInitOptions</code> object with a password to the <code>openCollections</code> function. If no password is passed, the documents of all the collections in the store are not encrypted.

Some security metadata is stored in the shared preferences (Android).  
The store is encrypted with a 256-bit Advanced Encryption Standard (AES) key. All keys are strengthened with Password-Based Key Derivation Function 2 (PBKDF2).

Use <code>closeAll</code> to lock access to all the collections until you call <code>openCollections</code> again. If you think of <code>openCollections</code> as a login function you can think of <code>closeAll</code> as the corresponding logout function.

Use <code>changePassword</code> to change the password.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setPassword("123");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### Multiple User Support
You can create multiple stores that contain different collections in a single MobileFirst application. The <code>openCollections</code> function can take an options object with a username. If no username is given, the default username is ""**jsonstore**"".

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setUsername("yoel");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### MobileFirst Adapter Integration
This section assumes that you are familiar with MobileFirst adapters. MobileFirst Adapter Integration is optional and provides ways to send data from a collection to an adapter and get data from an adapter into a collection.
You can achieve these goals by using functions such as <code>WLClient.invokeProcedure</code> or your own instance of an <code>HttpClient</code> if you need more flexibility.

#### Adapter Implementation
Create a MobileFirst adapter and name it "**People**". Define it's procedures <code>addPerson</code>, <code>getPeople</code>, <code>pushPeople</code>, <code>removePerson</code>, and <code>replacePerson</code>.

```javascript
function getPeople() {
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

#### Load data from MobileFirst Adapter
To load data from a MobileFirst Adapter use <code>WLClient.invokeProcedure</code>.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    try {
      JSONArray loadedDocuments = response.getResponseJSON().getJSONArray("peopleList");
    } catch(Exception e) {
      // error decoding JSON data
    }
  }
};

WLProcedureInvocationData invocationData = new WLProcedureInvocationData("People", "getPeople");
Context context = getContext();
WLClient client = WLClient.createInstance(context);
client.invokeProcedure(invocationData, responseListener);
```

#### Get Push Required (Dirty Documents)
Calling <code>findAllDirtyDocuments</code> returns and array of so called "dirty documents", which are documents that have local modifications that do not exist on the back-end system.

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocs = collection.findAllDirtyDocuments();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

To prevent JSONStore from marking the documents as "dirty", pass the option <code>options.setMarkDirty(false)</code> to <code>add</code>, <code>replace</code>, and <code>remove</code>.

#### Push changes
To push changes to a MobileFirst adapter, call the <code>findAllDirtyDocuments</code> to get a list of documents with modifications and then use <code>WLClient.invokeProcedure</code>. After the data is sent and a successful response is received make sure you call <code>markDocumentsClean</code>.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    // handle success
  }
};
Context context = getContext();
WLClient client = WLClient.createInstance(context);
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocuments = people.findAllDirtyDocuments();
  WLProcedureInvocationData invocationData = new WLProcedureInvocationData("People", "pushPeople");
  invocationData.setParameters(new Object[]{dirtyDocuments});
  client.invokeProcedure(invocationData, responseListener);
} catch(JSONStoreException e) {
  // handle failure
}
```

## Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid) the Native Android project.  

![sample JSONStore sample for native iOS](android-native-screen.png)
