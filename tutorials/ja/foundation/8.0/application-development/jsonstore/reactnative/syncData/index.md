---
layout: tutorial
title: JSONStore コレクションのデータの Cloudant DB への同期
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
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

## JSONStore コレクションのデータの Cloudant DB への同期
すべてのアプリケーション・データをローカルに配置することの欠点は、アプリケーションをアンインストールするとデータが失われることです。この問題に対処するために、IBM JSONStore は Cloudant DB との同期機能を提供しています。

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

JSONStore コレクションからデータを同期するためのステップは以下の 2 つです。

1. コレクションのオープン。通常の `JSONStoreCollection` と同期された `JSONStoreCollection` との唯一の違いはオープンの方法です。同期された JSONStoreCollections は対応する `JSONStoreInitOptions` を使用してオープンします。JSONStoreInitOptions では、同期ポリシーと、データを同期するアダプターを決定します。このアダプターは、基本的には Cloudant Sync アダプターです。詳しくは、[ここ](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/)を参照してください。JSONStoreInitOptions は API `setSyncOptions(syncPolicy, adapterName)` を提供します。JSONStoreSyncPolicy は、「SYNC_NONE」、「SYNC_DOWNSTREAM」、「SYNC_UPSTREAM」のいずれかの値にする必要があります。**adapterName** は、Cloudant DB で機能する、MobileFirst Server にデプロイされているアダプターの名前です。Sync を機能させるには、Cloudant DB の詳細を正しく入力するようにしてください。

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. Sync API の呼び出し。`openCollection()` API が成功すると、Sync を使用してオープンしたすべての JSONStoreCollections が同期を自動的にトリガーします。<br/>
    **JSONStoreSyncPolicy.SYNC_DOWNSTREAM** ポリシーを使用して JSONStoreCollection をオープンした場合は、最新のプルを取り出すために `sync()` API を明示的に呼び出すことができます。<br/>
    **JSONStoreSyncPolicy.SYNC_UPSTREAM** ポリシーを使用して JSONStoreCollection をオープンした場合は、コレクションからのドキュメントの追加、更新、または削除時に同期プロセスが自動的にトリガーされます。同期を明示的にトリガーするために、引き続き `sync()` API を呼び出すことができます。<br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
