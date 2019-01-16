---
layout: tutorial
title: JSONStore コレクションからのデータの取り出し
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  React Native 開発環境のセットアップ
React Native 開発用にご使用のマシンをセットアップするには、React Native の[『Gettings Started』ページ](https://facebook.github.io/react-native/docs/getting-started.html)に記載されている手順に従います。

##  React Native アプリケーションへの JSONStore SDK の追加
React Native 用の JSONStore SDK は、[npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore) から React Native モジュールとして入手可能です。

### 新規 React Native プロジェクトの開始
1. 新規 React Native プロジェクトを作成します。
    ```bash
    react-native init MyReactApp
    ```

2. MobileFirst SDK をアプリケーションに追加します。
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  すべてのネイティブ依存関係をアプリケーションにリンクします。
    ```bash
    react-native link
    ```

## JSONStore コレクションからのデータの取り出し
`App.js` 内で以下のパッケージをインポートする必要があります。

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

JSONStore コレクションからデータを取り出すためのステップは以下の 2 つです。

1. コレクションのオープン。コレクションを開くと、そのコレクションと対話できます。
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. コレクションからのデータの取り出し。コレクションを開いた後で、以下の API を使用してすべてのドキュメントを取り出すことができます。
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
