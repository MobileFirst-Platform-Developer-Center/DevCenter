---
layout: tutorial
title: 从 JSONStore 集合中查询数据
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
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

## 从 JSONStore 集合中查询数据
您很少需要同时获取集合中的所有文档。通常，您需要能够查询集合中的现有数据。

在您的 `App.js` 内，必须导入以下包：

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

从 JSONStore 集合中查询数据时需要执行两个步骤：

1. 打开集合，打开集合使我们能够与之交互。
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. 从集合中访存数据：在您打开集合之后，可以基于给定的查询访存文档。为查询 JSONStore，提供两个类以使用 `JSONStoreQuery` 和 `JSONStoreQueryPart`。<br/>
通过在数组中传递每个 JSONStoreQueryPart 对象，可以对同一个调用使用多个 JSONStoreQueryPart 对象。使用 OR 语句连接多个 JSONStoreQueryPart 对象。使用 AND 语句连接一个 JSONStoreQueryPart 的多个条件。

    请参阅以下代码：

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    // Notice how multiple JSONStoreQueryPart objects are passed in an array to build a complex query
    // The following call will return - all the Documents that has either
    // "gender" set to "female" OR has "age" between range 21 - 50

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
