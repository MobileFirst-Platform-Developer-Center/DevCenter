---
layout: tutorial
title: Cordova アプリケーションでの JSONStore
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
downloads:
  - name: Cordova プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80
  - name: アダプター Maven プロジェクトのダウンロード
    URL: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 前提条件

{: #prerequisites }
* [JSONStore 親チュートリアル](../)を読む。
* {{site.data.keys.product_adj }} Cordova SDK が プロジェクトに追加されていることを確認する。[『Cordova アプリケーションへの {{site.data.keys.product }} SDK の追加』](../../../application-development/sdk/cordova/)チュートリアルに従ってください。 

#### ジャンプ先:
{: #jump-to}
* [JSONStore の追加](#adding-jsonstore)
* [基本的な使用法
](#basic-usage)
* [高度な使用法
](#advanced-usage)
* [サンプル・アプリケーション](#sample-application)

## JSONStore の追加
{: #adding-jsonstore }
Cordova アプリケーションに JSONStore プラグインを追加するには、以下のようにします。

1. **コマンド・ライン**・ウィンドウを開き、Cordova プロジェクト・フォルダーにナビゲートします。
2. 次のコマンドを実行します。`cordova plugin add cordova-plugin-mfp-jsonstore`。

![JSONStore フィーチャーの追加](jsonstore-add-plugin.png)

## 基本的な使用法

{: #basic-usage }
### 初期化
{: #initialize }
1 つ以上の JSONStore コレクションを開始するには `init` を使用します。  

コレクションの開始またはプロビジョニングは、コレクションとドキュメントが含まれる永続ストレージを作成することを意味します (永続ストレージが存在しない場合)。永続ストレージが暗号化され、正しいパスワードが渡されると、そのデータにアクセスできるようにするための、セキュリティー上必要な手順が実行されます。


```javascript
var collections = {
    people : {

    searchFields : {name: 'string', age: 'integer'}
  }
};

WL.JSONStore.init(collections).then(function (collections) {
    // handle success - collection.people (people's collection)
}).fail(function (error) {
    // handle failure
});
```

> 初期化時に有効にできるオプション・フィーチャーについては、このチュートリアルの後半にある**『セキュリティー』**、**『複数ユーザー・サポート』**、および**『{{site.data.keys.product_adj }} アダプターの統合』**を参照してください。

### 取得

{: #get }
コレクションへのアクセス機能を作成するには、`get` を使用します。get を呼び出す前に `init` を呼び出す必要があります。このようにしないと、`get` の結果は不明確なものになります。

```javascript
var collectionName = 'people';
var people = WL.JSONStore.get(collectionName);
```

これで、変数 `people` を使用して、`people` コレクションに対して `add`、`find`、`replace` などの操作を実行できます。

### 追加
{: #add }
コレクション内にデータをドキュメントとして保管するには、`add` を使用します。

```javascript
var collectionName = 'people';
var options = {};
var data = {name: 'yoel', age: 23};

WL.JSONStore.get(collectionName).add(data, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### 検索

{: #find }
* 照会を使用してコレクション内のドキュメントを見つけるには、`find` を使用します。   
* コレクション内のすべてのドキュメントを取り出すには、`findAll` を使用します。  
* ドキュメントの固有 ID で検索するには、`findById` を使用します。  

find のデフォルトの動作では、「ファジー」検索を実行します。

```javascript
var query = {name: 'yoel'};
var collectionName = 'people';
var options = {
  exact: false, //default
  limit: 10 // returns a maximum of 10 documents, default: return every document
};

WL.JSONStore.get(collectionName).find(query, options).then(function (results) {
    // handle success - results (array of documents found)
}).fail(function (error) {
    // handle failure
});
```

```javascript
var age = document.getElementById("findByAge").value || '';

if(age == "" || isNaN(age)){
  alert("Please enter a valid age to find");
}
else {
  query = {age: parseInt(age, 10)};
  var options = {
    exact: true,
    limit: 10 //returns a maximum of 10 documents
  };
  WL.JSONStore.get(collectionName).find(query, options).then(function (res) {
    // handle success - results (array of documents found)
}).fail(function (errorObject) {
    // handle failure
  });
}
```

### 置換

{: #replace }
コレクション内のドキュメントを変更するには、`replace` を使用します。置換の実行に使用するフィールドは `_id` で、これはドキュメントの固有 ID です。

```javascript
var document = {
  _id: 1, json: {name: 'chevy', age: 23}
};
var collectionName = 'people';
var options = {};

WL.JSONStore.get(collectionName).replace(document, options).then(function (numberOfDocsReplaced) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

この例では、ドキュメント `{_id: 1, json: {name: 'yoel', age: 23} }` がコレクションにあることを前提としています。

### 削除

{: #remove }
ドキュメントをコレクションから削除するには、`remove` を使用します。  
push が呼び出されるまで、ドキュメントはコレクションから消去 されません。  

> 詳しくは、このチュートリアルの後半にある**{{site.data.keys.product_adj }}『アダプターの統合』**セクションを参照してください。

```javascript
var query = {_id: 1};
var collectionName = 'people';
var options = {exact: true};
WL.JSONStore.get(collectionName).remove(query, options).then(function (numberOfDocsRemoved) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### コレクションの削除
{: #remove-collection }
コレクション内に保管されているすべてのドキュメントを削除するには、 `removeCollection` を使用します。 この操作は、データベース用語における、表のドロップと似ています。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).removeCollection().then(function (removeCollectionReturnCode) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

## 高度な使用法
{: #advanced-usage }
### 破棄
{: #destory }
以下のデータを削除するには、`destroy` を使用します。

* すべてのドキュメント

* すべてのコレクション

* すべてのストア (このチュートリアル後半の**『複数ユーザー・サポート』**を参照)
* すべての JSONStore メタデータおよびセキュリティー成果物 (このチュートリアル後半の**『セキュリティー』**を参照)

```javascript
var collectionName = 'people';
WL.JSONStore.destroy().then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### セキュリティー
{: #security }
パスワードを `init` 関数に渡すことにより、ストア内のすべてのコレクションを保護することができます。
パスワードを渡さないと、ストア内のすべてのコレクションにあるドキュメントが暗号化されません。

データ暗号化は、Android、iOS、Windows 8.1 Universal および Windows 10 UWP の各環境でのみ使用可能です。  
一部のセキュリティー・メタデータは、*キーチェーン* (iOS)、*共有設定* (Android) または*資格情報保管ボックス* (Windows 8.1) に保管されます。  
ストアは 256 ビットの Advanced Encryption Standard
(AES) 鍵で暗号化されます。すべての鍵は Password-Based Key Derivation
Function 2 (PBKDF2) により強化されています。

`closeAll` を使用して、`init` を再度呼び出すまですべてのコレクションへのアクセスをロックします。`init` をログイン関数と考えると、`closeAll` はそれに対応するログアウト関数と考えることができます。`changePassword` を使用して、パスワードを変更します。

```javascript
var collections = {
    people : {

    searchFields: {name: 'string'}
  }
};
var options = {password: '123'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### 暗号化
{: #encryption }
*iOS のみ*。デフォルトでは、{{site.data.keys.product_adj }} Cordova SDK for iOS は、iOS 提供の API に暗号化を依存しています。これを OpenSSL に置換したい場合は、以下のようにします。

1. cordova-plugin-mfp-encrypt-utils プラグイン `cordova plugin add cordova-plugin-mfp-encrypt-utils` を追加します。
2. アプリケーション・ロジックで、`WL.SecurityUtils.enableNativeEncryption(false)` を使用して OpenSSL オプションを有効にします。

### 複数ユーザー・サポート
{: #multiple-user-support }
単一の {{site.data.keys.product_adj }} アプリケーションに、異なるコレクションを含む複数のストアを作成できます。`init` 関数はオプション・オブジェクトとユーザー名を受け取ります。ユーザー名が指定されていない場合、デフォルトのユーザー名 **jsonstore** が使用されます。

```javascript
var collections = {
    people : {

    searchFields: {name: 'string'}
  }
};
var options = {username: 'yoel'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### {{site.data.keys.product_adj }} アダプターの統合
{: #mobilefirst-adapter-integration }
このセクションは、ユーザーがアダプターについて理解していることを前提とします。  

アダプターの統合はオプションであり、コレクションからアダプターにデータを送信する方法、およびアダプターからコレクションにデータを取得する方法を提供します。  
これらの目的を実現するために、`WLResourceRequest` や、より高い柔軟性が必要な場合は `jQuery.ajax` を使用することができます。

### アダプターの実装
{: #adapter-implementation }
アダプターを作成し、"**People**" という名前を付けます。  
このアダプターのプロシージャー `addPerson`、`getPeople`、`pushPeople`、 `removePerson`、および `replacePerson` を定義します。

```javascript
function getPeople() {
	var data = { peopleList : [{name: 'chevy', age: 23}, {name: 'yoel', age: 23}] };
	WL.Logger.debug('Adapter: people, procedure: getPeople called.');
	WL.Logger.debug('Sending data: ' + JSON.stringify(data));
	return data;
}
function pushPeople(data) {
	WL.Logger.debug('Adapter: people, procedure: pushPeople called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function addPerson(data) {
	WL.Logger.debug('Adapter: people, procedure: addPerson called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function removePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: removePerson called.');
	WL.Logger.debug('Got data from JSONStore to REMOVE: ' + data);
	return;
}
function replacePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: replacePerson called.');
	WL.Logger.debug('Got data from JSONStore to REPLACE: ' + data);
	return;
}
```

#### {{site.data.keys.product_adj }} アダプターにリンクされているコレクションの初期化
{: #initialize-a-collection-linked-to-a-mobilefirst-adapter }
```javascript
var collections = {
    people : {

    searchFields : {name: 'string', age: 'integer'},
    adapter : {
      name: 'People',
      add: 'addPerson',
      remove: 'removePerson',
      replace: 'replacePerson',
      load: {
        procedure: 'getPeople',
        params: [],
        key: 'peopleList'
      }     
    }   
  }
}

var options = {};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### データをアダプターからロード
{: #load-data-from-an-adapter }
`load` が呼び出されると、JSONStore では、前に `init` に渡したアダプターに関するメタデータ (**name** および **procedure**) を使用して、アダプターから取得するデータが決定され、最終的にそのデータが保管されます。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).load().then(function (loadedDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### プッシュが必要な対象 (ダーティーなドキュメント) の取得
{: #get-push-required-dirty-documents }
`getPushRequired` を呼び出すと、*「ダーティーなドキュメント」*と呼ばれる配列が返されます。これは、バックエンド・システムには存在しないローカル変更が含まれるドキュメントです。これらのドキュメントは、`push` が呼び出されたときに、アダプターに送信されます。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).getPushRequired().then(function (dirtyDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

JSONStore でドキュメントが「ダーティー」とマーキングされないようにするには、オプション `{markDirty:false}` を `add`、`replace`、および`remove` に渡します。

以下のようにして、`getAllDirty` API を使用してダーティー・ドキュメントを取得することもできます。

```javascript
WL.JSONStore.get(collectionName).getAllDirty()
.then(function (dirtyDocuments) {
    // handle success
}).fail(function (errorObject) {
    // handle failure
});
```

#### プッシュ
{: #push }
`push` は、変更されたドキュメントを正しいアダプター・プロシージャーに送信します (例えば、ローカルで追加されたドキュメントの場合は `addPerson` が呼び出されます)。このメカニズムは、変更されたドキュメント、および `init` に渡されるアダプター・メタデータに関連する、最後のオペレーションに基づきます。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).push().then(function (response) {
    // handle success
    // response is an empty array if all documents reached the server
    // response is an array of error responses if some documents failed to reach the server
}).fail(function (error) {
    // handle failure
});
```

### 拡張

{: #enhance }
コア API をニーズに合うように拡張するには、`enhance` を使用します。それには、関数をコレクションのプロトタイプに追加します。この例 (下記のコード・スニペット) は、`enhance` を使用して、`keyvalue` コレクションで動作する関数 `getValue` を追加する方法を示しています。この関数は、唯一のパラメーターとして `key` (ストリング) を受け取り、単一の結果を返します。

```javascript
var collectionName = 'keyvalue';
WL.JSONStore.get(collectionName).enhance('getValue', function (key) {
    var deferred = $.Deferred();
    var collection = this;
    //Do an exact search for the key
    collection.find({key: key}, {exact:true, limit: 1}).then(deferred.resolve, deferred.reject);
    return deferred.promise();
});

//Usage:
var key = 'myKey';
WL.JSONStore.get(collectionName).getValue(key).then(function (result) {
    // handle success
    // result contains an array of documents with the results from the find
}).fail(function () {
    // handle failure
});
```

> JSONStore について詳しくは、ユーザー文書を参照してください。

<img alt="JSONStore サンプル・アプリケーション" src="jsonstore-cordova.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-application }
JSONStoreSwift プロジェクトには、JSONStore API セットを使用する Cordova アプリケーションが含まれています。  
JavaScript アダプター Maven プロジェクトも使用可能です。

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80) して Cordova プロジェクトをダウンロードします。  
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80) してアダプター Maven プロジェクトをダウンロードします。  

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
