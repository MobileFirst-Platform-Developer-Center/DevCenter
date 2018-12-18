---
layout: tutorial
title: JSONStore コレクションへのデータの追加
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## JSONStore コレクションへのデータの追加

`App.js` 内で以下のパッケージをインポートする必要があります。

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

JSONStore コレクションにデータを追加するためのステップは以下の 3 つです。

1. 新規コレクションの作成。以下に示すように、`JSONStoreCollection` コンストラクターを呼び出すことで新規コレクションを作成できます。
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  コレクションのオープン。新規作成したコレクションで何かを行うには、そのコレクションを開く必要があります。コレクションを開くには、WLJSONStore の `openCollections` API を呼び出します。以下のサンプル・コードを参照してください。
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. コレクションへのデータの追加。コレクションを開いた後で、内側または外側からデータ・トランザクションを開始します。以下の API を使用して、開いたコレクションにデータを追加できます。
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
