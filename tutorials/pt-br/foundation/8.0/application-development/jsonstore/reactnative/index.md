---
layout: tutorial
title: JSONStore in React Native applications
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## Prerequisites
{: #prerequisites }
* Read the [JSONStore parent tutorial](../)
* Make sure the {{ site.data.keys.product_adj }} React Native Core SDK was added to the project. Follow the [Adding the Mobile Foundation SDK to React-Native applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/) tutorial.

#### Jump to:
{: #jump-to}
* [Adding JSONStore](#adding-jsonstore)
* [Basic Usage](#basic-usage)
* [Sample application](#sample_app_for_jsonstore)

## Adding JSONStore
{: #adding-jsonstore }
To add JSONStore plug-in to your React Native application:

1. Open a **Command-line** window and navigate to your React Native project folder.
2. Run the command:
    ```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## Basic Usage
{: #basic-usage }
### Creating a new JSONStore Collection
{: #create_new_jsonstore_collection}
1.  We use `JSONStoreCollection` class to create instances of JSONStore. We can also set additional configuration to this newly created JSONStore Collection (eg. setting search fields).
2.  To start interacting with an existing JSONStore collection (eg:  adding or removing data) we need to *Open* the collection. We use `openCollections()` API to do this.
    ```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// handle success
    }).catch(err => {
    	// handle failure
    });
    ```

### Add
{: #add}
Use `addData()` API to store JSON Data in a collection.

```javascript
var data = { "name": "John", age: 28 };
var collection = new JSONStoreCollection('people');
collection.addData(data)
.then(res => {
  // handle success
}).catch(err => {
  // handle failure
});
```

> You can add a single JSON object or an Array of JSON objects using this API.

### Find
{: #find}
1.  Use `find` to locate a document inside a collection by using a query.
2.  Use `findAllDocuments()` API for retrieving all the documents inside a collection.
3.  Use `findDocumentById()` and `findDocumentsById()` API to search using the document unique identifier.
4.  Use `findDocuments()` API to query the collection. For querying, you can use `JSONStoreQueryPart` class objects to filter the data.

> Pass an array of `JSONStoreQueryPart` objects as a parameter to `findDocuments` API.

```javascript
var collection = new JSONStoreCollection('people');
var query = new JSONStoreQueryPart();
query.addEqual("name", "John");
collection.findDocuments([query])
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

### Remove
{: #remove}
Use `remove` to delete a document from a collection.

```javascript
var id = 1; // for example
var collection = new JSONStoreCollection('people');
collection.removeDocumentById(id)
.then(res => {
	// handle success
}).catch(err => {
	// handle failure     
});
```

### Remove Collection
{: #removecollection}
Use `removeCollection` to delete all the documents that are stored inside a collection. This operation is similar to dropping a table in database terms.

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

## Sample app for IBM MobileFirst JSONStore
{: #sample_app_for_jsonstore}
Download the sample [here](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative).

### Running the Sample
{: #running_sample}
Within the sample's root directory, run the following command, which installs all the project dependencies:

```bash
npm install
```

>**Note:**   Make sure your *mfpclient.properties* and *mfpclient.plist* are pointing to correct MobileFirst Server.

1. Register the app. Go to the `android` directory and run the following command:
    ```bash
    mfpdev app register
    ```

2. Configuring the app.
    (For Android only)
   *  Open `android/app/src/main/AndroidManifest.xml` file from React Native project root directory.<br/>
    	 Add the following line to the `<manifest>` tag:<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 Add the following line to the `<application>` tag:<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 This step is required by *react-native-ibm-mobilefirst* library.<br/>

	 *  Open `android/app/build.gradle` file from the React Native project root directory.<br/>
      Add the following code inside the *android {}* :<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      This step is required by the *react-native-ibm-mobilefirst-jsonstore* library.

3. Running the app. Return to the root directory and navigate to `iOS` directory and run the command:
    `mfpdev app register`

We're now ready to run the app.
To run on android, execute the following command:
```bash
react-native run-android
```
