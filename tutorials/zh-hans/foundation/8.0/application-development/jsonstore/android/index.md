---
layout: tutorial
title: Android 应用程序中的 JSONStore
breadcrumb_title: Android
relevantTo: [android]
weight: 3
downloads:
  - name: 下载 Android Studio 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid/tree/release80
  - name: 下载适配器 Maven 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 先决条件
{: #prerequisites }

* 阅读 [JSONStore 父教程](../)
* 确保已将 {{ site.data.keys.product_adj }} 本机 SDK 添加到 Android Studio 项目。 遵循[向 Android 应用程序添加 {{ site.data.keys.product }} SDK](../../../application-development/sdk/android/) 教程。

#### 跳转至：
{: #jump-to }
* [添加 JSONStore](#adding-jsonstore)
* [基本用法](#basic-usage)
* [高级用法](#advanced-usage)
* [样本应用程序](#sample-application)

## 添加 JSONStore
{: #adding-jsonstore }
1. 在 **Android → Gradle 脚本**中，选择 **build.gradle（模块：应用程序）**文件。

2. 将以下代码添加到现有 `dependencies` 部分：

```
compile 'com.ibm.mobile.foundation:ibmobilefirstplatformfoundationjsonstore:8.0.+
```

## 基本用法
{: #basic-usage }
### 打开
{: #open }
使用 `openCollections` 打开一个或多个 JSONStore 集合。

启动或供应集合意味着创建包含集合和文档的持久存储（如果不存在）。 如果持久存储已加密且传递了正确密码，那么将运行必需的安全过程才能访问数据。

有关可在初始化时启用的可选功能，请参阅本教程第二部分中的**安全性、多用户支持**和 **{{ site.data.keys.product_adj }} 适配器集成**。

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  WLJSONStore.getInstance(context).openCollections(collections);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 获取
{: #get }
使用 `getCollectionByName` 来创建集合存取器。 必须先调用 `openCollections`，然后才能调用 `getCollectionByName`。

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

变量 `collection` 现在可用于在 `people` 集合上执行操作，例如，`add`、`find` 和 `replace`

### 添加
{: #add }
使用 `addData` 将数据存储为集合中的文档

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  //Add options.
  JSONStoreAddOptions options = new JSONStoreAddOptions();
  options.setMarkDirty(true);
  JSONObject data = new JSONObject("{age: 23, name: 'yoel'}")
  collection.addData(data, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 查找
{: #find }
使用 `findDocuments` 来通过查询查找集合中的文档。 使用 `findAllDocuments` 来检索集合中的所有文档。 使用 `findDocumentById` 来按文档唯一标识进行搜索。

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreQueryPart queryPart = new JSONStoreQueryPart();
  // fuzzy search LIKE
  queryPart.addLike("name", name);
  JSONStoreQueryParts query = new JSONStoreQueryParts();
  query.addQueryPart(queryPart);
  JSONStoreFindOptions options = new JSONStoreFindOptions();
  // returns a maximum of 10 documents, default: returns every document
  options.setLimit(10);
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> results = collection.findDocuments(query, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 替换
{: #replace }
使用 `replaceDocument` 来修改集合中的文档。 用于执行替换的字段是文档唯一标识 `_id`。

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreReplaceOptions options = new JSONStoreReplaceOptions();
  // mark data as dirty
  options.setMarkDirty(true);
  JSONStore replacement = new JSONObject("{_id: 1, json: {age: 23, name: 'chevy'}}");
  collection.replaceDocument(replacement, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

此示例假定文档 `{_id: 1, json: {name: 'yoel', age: 23} }` 位于集合中。

### 除去
{: #remove }
使用 `removeDocumentById` 以删除集合中的文档。
在调用 `markDocumentClean` 之前，不会从集合中擦除文档。 有关更多信息，请参阅本教程后面的 **{{ site.data.keys.product_adj }} 适配器集成**部分。

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreRemoveOptions options = new JSONStoreRemoveOptions();
  // Mark data as dirty
  options.setMarkDirty(true);
  collection.removeDocumentById(1, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 除去集合
{: #remove-collection }
使用 `removeCollection` 以删除集合中存储的所有文档。 此操作类似于数据库术语中的删除表。

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  collection.removeCollection();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 销毁
{: #destroy }
使用 `destroy` 以除去以下数据：

* 所有文档
* 所有集合
* 所有存储区 - 请参阅本教程后面的**多用户支持**。
* 所有 JSONStore 元数据和安全工件 - 请参阅本教程后面的**安全性**

```java
Context context = getContext();
try {
  WLJSONStore.getInstance(context).destroy();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

## 高级用法
{: #advanced-usage }
### 安全性
{: #security }
您可以通过将包含密码的 `JSONStoreInitOptions` 对象传递到 `openCollections` 函数来保护存储区中的所有集合。 如果未传递密码，那么将不会加密存储区中所有集合的文档。

某些安全元数据存储在共享首选项中 (Android)。  
此存储利用 256 位高级加密标准 (AES) 密钥进行加密。 所有密钥通过基于密码的密钥派生功能 2 (PBKDF2) 进行增强。

使用 `closeAll` 以锁定对所有集合的访问，直至再次调用 `openCollections`。 如果将 `openCollections` 当作登录函数，那么可将 `closeAll` 当作对应的注销函数。

使用 `changePassword` 来更改密码。

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setPassword("123");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### 多用户支持
{: #multiple-user-support }
您可以在单个 {{ site.data.keys.product_adj }} 应用程序中创建包含不同集合的多个存储。 `openCollections` 函数可使用包含用户名的选项对象。 如果未指定用户名，那么缺省用户名为“**jsonstore**”。

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setUsername("yoel");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### {{ site.data.keys.product_adj }} 适配器集成
{: #mobilefirst-adapter-integration }
此部分假定您熟悉适配器。 适配器集成为可选，其支持将数据从集合发送到适配器以及从适配器将数据获取到集合。
如果需要提高灵活性，可以使用 `WLResourceRequest` 之类的函数或者自己的 `HttpClient` 实例来实现这些目标。

#### 适配器实现
{: #adapter-implementation }
创建一个适配器并将其命名为“**JSONStoreAdapter**”。 将其过程定义为 `addPerson`、`getPeople`、`pushPeople`、`removePerson` 和 `replacePerson`。

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

#### 从 {{ site.data.keys.product_adj }} 适配器装入数据
{: #load-data-from-mobilefirst-adapter }
要从适配器装入数据，请使用 `WLResourceRequest`。

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    try {
      JSONArray loadedDocuments = response.getResponseJSON().getJSONArray("peopleList");
    } catch(Exception e) {
      // error decoding JSON data
    }
  }
};

try {
  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/getPeople"), WLResourceRequest.GET);
  request.send(responseListener);
} catch (URISyntaxException e) {
  // handle error
}
```

#### 需要推送（脏文档）
{: #get-push-required-dirty-documents }
调用 `findAllDirtyDocuments` 将返回名为“脏文档”的数组，这些是包含后端系统上不存在的本地修订的文档。

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocs = collection.findAllDirtyDocuments();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

要阻止 JSONStore 将文档标记为“脏”，请将选项 `options.setMarkDirty(false)` 传递到 `add`、`replace` 和 `remove`。

#### 推送更改
{: #push-changes }
要将更改推送到适配器，请调用 `findAllDirtyDocuments` 以获取包含修订的文档列表，然后使用 `WLResourceRequest`。 在发送数据并且收到成功响应后，确保调用 `markDocumentsClean`。

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    // handle success
  }
};
Context context = getContext();

try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocuments = people.findAllDirtyDocuments();

  JSONObject payload = new JSONObject();
  payload.put("people", dirtyDocuments);

  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/pushPeople"), WLResourceRequest.POST);
  request.send(payload, responseListener);
} catch(JSONStoreException e) {
  // handle failure
} catch (URISyntaxException e) {
  // handle error
}
```

<img alt="样本应用程序的图像" src="android-native-screen.jpg" style="float:right; width:240px;"/>
## 示例应用程序
{: #sample-application }
JSONStoreAndroid 项目包含利用 JSONStore API 集合的本机 Android 应用程序。  
随附一个 JavaScript 适配器 Maven 项目。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid)本机 Android 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80)适配器 Maven 项目。  

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件以获取指示信息。
