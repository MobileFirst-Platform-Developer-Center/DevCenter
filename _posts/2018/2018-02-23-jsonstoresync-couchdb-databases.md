---
title: Automated synchronization of JSONStore collections with CouchDB databases
date: 2018-02-23
tags:
- Mobile_Foundation
- JSONStore
- Android_SDK
version:
- 8.0
author:
  name: Srutha Keerthi K
additional_authors :
  - Srihari Kulkarni  
---
MobileFirst JSONStore already allows you to write code to be able to pull and push data from/to an external data source, [see here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/jsonstore/#working-with-external-data).

Starting with *iFix 8.0.0.0-MFPF-IF201802201451*, MobileFirst Android SDK can be used to automate the synchronization of data between a JSONStore collection on a device with any CouchDB database including [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). 

If you are an on-premise 8.0 customer or <a href="https://console.bluemix.net/catalog/services/mobile-foundation">Mobile Foundation Service</a> customer, then read further to learn about the JSONStore <a href="https://www.ibm.com/support/knowledgecenter/en/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_jsonstore_overview.html">here</a>.

> **Note:** <br/>
  This feature is available in Android environment only. Support for iOS and Cordova will be available shortly.<br/>
> The use of this feature can be extended to any CouchDB instance.

## Setting up the synchronization between JSONStore and Cloudant
{: #setup-sync}
To setup automatic synchronization between JSONStore and Cloudant complete the following steps:

1. Define the Sync Policy on your mobile app.
2. Deploy the Sync Adapter on IBM Mobile Foundation.

### Defining the Sync Policy
{: #define-syncpolicy}
The method of synchronization between a JSONStore collection and a Cloudant database is defined by the Sync Policy. You can specify the Sync Policy in your app for each collection.

A JSONStore collection can be initialized with a Sync Policy using the `JSONStoreInitOptions.syncPolicy` field. Sync Policy can be one of the following three policies.

1.  `SYNC_DOWNSTREAM`<br/>
    Use this policy when you want to download data from Cloudant on to the JSONStore collection. This is typically used for static data that is required for offline storage. For example, price list of items in a catalog. Each time the collection is initialized on the device, data is refreshed from the remote Cloudant database. While the entire database is downloaded for the first time, subsequent refreshes will download only delta, comprising of the changes made on the remote database.

    **Usage:**

    _**Android:**_
    ```
    initOptions.setSyncPolicy(JSONStoreSyncPolicy.SYNC_DOWNSTREAM);
    ```


2.  `SYNC_UPSTREAM`<br/>
    Use this policy when you want to push local data to a Cloudant database. For example, uploading of sales data captured offline to a Cloudant database. When a collection is defined with the `SYNC_UPSTREAM` policy, any new records added to the collection creates a new record in Cloudant. Similarly, any document modified in the collection on the device will modify the document on Cloudant and documents deleted in the collection will also be deleted from the Cloudant database.

    **Usage:**

    _**Android:**_
    ```
    initOptions.setSyncPolicy(JSONStoreSyncPolicy.SYNC_UPSTREAM);
    ```


3.  `SYNC_NONE`<br/>
    This is the default policy. Choose this policy for synchronization to not take place.


> **Important:** The Sync Policy is attributed to a JSONStore Collection. Once a collection is initialized with a particular Sync Policy, it should not be changed. Modifying the Sync Policy can lead to undesirable results.

  
`syncAdapterPath`<br/>

This is the adapter name that is deployed.


**Usage:**

_**Android**_
  ```
   initOptions.syncAdapterPath = "JSONStoreCloudantSync"; //Here "JSONStoreCloudantSync" is the name of the adapter.
   ```

### Deploying the sync adapter
{: #deploy-syncadapter}

* Download the JSONStoreSync adapter from <a href="https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCloudantSync/">here</a>, configure cloudant credentials in path 'src/main/adapter-resources/adapter.xml' and deploy it in your MobileFirst server.
* Configure the credentials to the backend Cloudant database also through the mfpconsole like below :

|---------------------------|-------------------------|
|![Configure Cloudant]({{site.baseurl}}/assets/blog/2018-02-23-jsonstoresync-couchdb-databases/configure-cloudant.png)    |   ![Cloudant credentials]({{site.baseurl}}/assets/blog/2018-02-23-jsonstoresync-couchdb-databases/CloudantCreds.jpg)|


### Few points to consider before using this feature
{: #take-note}

At the time of publishing this post, this feature is available for the Android native environment.  

The name of the JSONStore collection and CouchDB database name must be the same.
Carefully refer to your CouchDB's database naming syntax before naming your JSONStore collection.

A JSONStoreCollection can be defined with only one of the allowed Sync Policies, i.e., `SYNC_DOWNSTREAM`, `SYNC_UPSTREAM` or `SYNC_NONE`.

If an upstream or downstream sync has to be performed at any time after the initialization explicitly, the following API can be used :

`sync()`<br/>

This performs a downstream sync if the calling collection has a sync policy set to 'SYNC_DOWNSTREAM'. Else, if the sync policy is set to 'SYNC_UPSTREAM', an upstream sync for added, deleted and replaced documents from jsonstore to Cloudant database is performed.

**Usage:**

_**Android**_
  ```
   WLJSONStore.getInstance(context).getCollectionByName(collection_name).sync();
   ```
  
