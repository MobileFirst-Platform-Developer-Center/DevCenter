---
layout: tutorial
title: 将 JSONStore 集合的数据同步到 Cloudant DB
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  设置 React Native 开发环境
遵循 React Native [入门页面](https://facebook.github.io/react-native/docs/getting-started.html)中提供的指示信息来设置您的机器进行 React Native 开发。

##  将 JSONStore SDK 添加到 React Native 应用程序
在 [npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore) 中，JSONStore SDK for React Native 作为 React Native 模块提供。

### 开始使用新 React Native 项目
1. 创建新 React Native 项目。
    ```bash
    react-native init MyReactApp
    ```

2. 将 MobileFirst SDK 添加到您的应用程序。
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  将所有本机依赖关系添加到您的应用程序。
    ```bash
    react-native link
    ```

## 将 JSONStore 集合的数据同步到 Cloudant DB
将所有应用程序数据保存到本地的弊端是卸载应用程序后您将丢失数据。为解决此问题，IBM JSONStore 随 Cloudant DB 提供同步功能。

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

从 JSONStore 集合同步数据时需要执行两个步骤：

1. 打开集合，常规 `JSONStoreCollection` 与同步的 `JSONStoreCollection` 之间的唯一差异是打开方式不同。使用对应的 `JSONStoreInitOptions` 打开同步的 JSONStoreCollections。您可以在 JSONStoreInitOptions 中确定同步策略以及要将数据与之同步的适配器。该适配器基本上是 Cloudant Sync Adapter，在[此处](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/)了解更多信息。JSONStoreInitOptions 提供 API `setSyncOptions(syncPolicy, adapterName)`。JSONStoreSyncPolicy 需要为以下值之一：[‘SYNC_NONE’, ‘SYNC_DOWNSTREAM’, ‘SYNC_UPSTREAM’]。**adapterName** 是部署在使用 Cloudant DB 的 MobileFirst Server 上的适配器的名称。请确保正确输入 Cloudant DB 详细信息以实现同步。

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. 调用同步 API，通过“同步”打开的所有 JSONStoreCollections 将在 `openCollection()` API 成功运行时自动触发同步。<br/>
如果通过 **JSONStoreSyncPolicy.SYNC_DOWNSTREAM** 策略打开 JSONStoreCollection，那么可以显式调用 `sync()` API 以访存最新的提取。<br/>
如果通过 **JSONStoreSyncPolicy.SYNC_UPSTREAM** 策略打开 JSONStoreCollection，那么在通过集合添加、更新或移除文档时将自动触发同步过程。您仍可以调用 `sync()` API 以显式触发同步。<br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
