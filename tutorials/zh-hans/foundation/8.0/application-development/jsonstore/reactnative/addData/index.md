---
layout: tutorial
title: 将数据添加到 JSONStore 集合
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## 将数据添加到 JSONStore 集合

在您的 `App.js` 内，必须导入以下包：

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

将数据添加到 JSONStore 集合时需要执行三个步骤：

1. 创建新集合，您可以通过调用 `JSONStoreCollection` 构造函数来创建新集合，如下所示：
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  打开集合，如果不打开新创建的集合，则无法使用该集合执行任何操作。要打开集合，请调用 WLJSONStore 的 `openCollections` API。请参阅下面的样本代码。
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. 将数据添加到集合，在您打开集合之后，向内或向外启动数据事务。您可以使用以下 API 将数据添加到打开的集合。
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
