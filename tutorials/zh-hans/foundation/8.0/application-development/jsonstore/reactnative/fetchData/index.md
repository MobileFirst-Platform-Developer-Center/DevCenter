---
layout: tutorial
title: 从 JSONStore 集合中访存数据
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
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

## 从 JSONStore 集合中访存数据
在您的 `App.js` 内，必须导入以下包：

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

从 JSONStore 集合中访存数据时需要执行两个步骤：

1. 打开集合，打开集合使我们能够与之交互。
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. 从集合中访存数据：在您打开集合之后，可以使用以下 API 来访存所有文档。
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
