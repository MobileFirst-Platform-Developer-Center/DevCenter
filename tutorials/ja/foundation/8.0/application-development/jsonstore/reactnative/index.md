---
layout: tutorial
title: React Native アプリケーションでの JSONStore
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## 前提条件
{: #prerequisites }
* [JSONStore 親チュートリアル](../)を読む。
* {{ site.data.keys.product_adj }} React Native コア SDK がプロジェクトに追加されていることを確認する。 [『React-Native アプリケーションへの Mobile Foundation SDK の追加 (Adding the Mobile Foundation SDK to React-Native applications)』](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/)チュートリアルに従ってください。

#### ジャンプ先:
{: #jump-to}
* [JSONStore の追加](#adding-jsonstore)
* [基本的な使用法](#basic-usage)
* [サンプル・アプリケーション](#sample_app_for_jsonstore)

## JSONStore の追加
{: #adding-jsonstore }
React Native アプリケーションに JSONStore プラグインを追加するには、以下のようにします。

1. **コマンド・ライン**・ウィンドウを開き、React Native プロジェクト・フォルダーにナビゲートします。
2. 次のコマンドを実行します。
    ```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## 基本的な使用法
{: #basic-usage }
### 新規 JSONStore コレクションの作成
{: #create_new_jsonstore_collection}
1.  `JSONStoreCollection` クラスを使用して、JSONStore のインスタンスを作成します。 また、新規作成されたこの JSONStore コレクションに追加構成を設定することもできます (例: 検索フィールドの設定)。
2.  既存の JSONStore コレクションとの対話 (例: データの追加や削除) を開始するには、コレクションを*開く* 必要があります。 これを行うには、`openCollections()` API を使用します。
    ```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// handle success
    }).catch(err => {
    	// handle failure
    });
    ```

### 追加
{: #add}
`addData()` API を使用して、コレクションに JSON データを格納します。

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

> この API を使用して、単一の JSON オブジェクトまたは JSON オブジェクトの配列を追加できます。

### 検索
{: #find}
1.  照会を使用してコレクション内のドキュメントを見つけるには、`find` を使用します。
2.  コレクション内のすべてのドキュメントを取り出すには、`findAllDocuments()` API を使用します。
3.  ドキュメントの固有 ID を使用して検索するには、`findDocumentById()` API および `findDocumentsById()` API を使用します。
4.  コレクションを照会するには、`findDocuments()` API を使用します。 照会では、`JSONStoreQueryPart` クラス・オブジェクトを使用してデータをフィルターに掛けることができます。

> `JSONStoreQueryPart` オブジェクトの配列をパラメーターとして `findDocuments` API に渡します。

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

### 削除
{: #remove}
ドキュメントをコレクションから削除するには、`remove` を使用します。

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

### コレクションの削除
{: #removecollection}
コレクション内に保管されているすべてのドキュメントを削除するには、 `removeCollection` を使用します。 この操作は、データベース用語における、表のドロップと似ています。

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

## IBM MobileFirst JSONStore のサンプル・アプリケーション
{: #sample_app_for_jsonstore}
サンプルは[ここ](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative)からダウンロードします。

### サンプルの実行
{: #running_sample}
サンプルのルート・ディレクトリー内で、すべてのプロジェクト依存関係をインストールする次のコマンドを実行します。

```bash
npm install
```

>**注:**  *mfpclient.properties* と *mfpclient.plist* が正しい MobileFirst Server を指していることを確認します。

1. アプリケーションの登録。 `android` ディレクトリーに移動して、次のコマンドを実行します。
    ```bash
    mfpdev app register
    ```

2. アプリケーションの構成。
    (Android の場合のみ)
   *  React Native プロジェクトのルート・ディレクトリーから `android/app/src/main/AndroidManifest.xml` ファイルを開きます。<br/>
    	 次の行を `<manifest>` タグに追加します。<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 次の行を `<application>` タグに追加します。<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 このステップは *react-native-ibm-mobilefirst* ライブラリーで必要です。<br/>

	 *  React Native プロジェクトのルート・ディレクトリーから `android/app/build.gradle` ファイルを開きます。<br/>
      次のコードを *android {}* 内に追加します。<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      このステップは *react-native-ibm-mobilefirst-jsonstore* ライブラリーで必要です。

3. アプリケーションの実行。 ルート・ディレクトリーに戻って、`iOS` ディレクトリーにナビゲートし、`mfpdev app register` コマンドを実行します。

これで、アプリケーションを実行する準備ができました。
Android で実行するには、次のコマンドを実行します。
```bash
react-native run-android
```
