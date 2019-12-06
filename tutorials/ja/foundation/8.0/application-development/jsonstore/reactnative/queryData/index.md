---
layout: tutorial
title: JSONStore コレクションからのデータの照会
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
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

## JSONStore コレクションからのデータの照会
1 つのコレクション内のすべてのドキュメントを同時に取得する必要が生じることはほとんどありません。 通常、コレクション内の既存のデータを照会できる必要があります。

`App.js` 内で以下のパッケージをインポートする必要があります。

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

JSONStore コレクションからデータを照会するためのステップは以下の 2 つです。

1. コレクションのオープン。コレクションを開くと、そのコレクションと対話できます。
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. コレクションからのデータの取り出し。コレクションを開いた後で、特定の照会に基づいてドキュメントを取り出すことができます。 JSONStore を照会するために、`JSONStoreQuery` および `JSONStoreQueryPart` とともに機能する 2 つのクラスが用意されています。<br/>
    配列内の各 JSONStoreQueryPart オブジェクトを渡すことで、同じ呼び出しに複数の JSONStoreQueryPart オブジェクトを使用できます。
    複数の JSONStoreQueryPart オブジェクトは OR ステートメントを使用して結合されます。
    1 つの JSONStoreQueryPart の複数の条件は AND ステートメントを使用して結合されます。

    次のコードを参照してください。

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    // 複数の JSONStoreQueryPart オブジェクトが、複雑な照会を構成するために 1 つの配列でどのように渡されているかに注目してください
    // 以下の呼び出しは、"gender" が "female" に設定されているか、
    // "age" が 21 から 50 であるすべての文書を返します

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
