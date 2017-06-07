---
layout: tutorial
title: Cordova 应用程序中的 JSONStore
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
downloads:
  - 名称：下载 Cordova 项目
    url：https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80
  - 名称：下载适配器 Maven 项目
    url：https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 先决条件
{: #prerequisites }
* 阅读 [JSONStore 父教程](../)
* 确保已将 {{ site.data.keys.product_adj }} Cordova SDK 添加到项目。遵循[向 Cordova 应用程序添加 {{ site.data.keys.product }} SDK](../../../application-development/sdk/cordova/) 教程。 

#### 跳转至：
{: #jump-to}
* [添加 JSONStore](#adding-jsonstore)
* [基本用法](#basic-usage)
* [高级用法](#advanced-usage)
* [样本应用程序](#sample-application)

## 添加 JSONStore
{: #adding-jsonstore }
要向 Cordova 应用程序添加 JSONStore 插件：

1. 打开**命令行**窗口并浏览至 Cordova 项目文件夹。
2. 运行命令：`cordova plugin add cordova-plugin-mfp-jsonstore`。

![添加 JSONStore 功能](jsonstore-add-plugin.png)

## 基本用法
{: #basic-usage }
### 初始化
{: #initialize }
使用 `init` 以启动一个或多个 JSONStore 集合。  

启动或供应集合意味着创建包含集合和文档的持久存储（如果不存在）。如果持久存储已加密且传递了正确密码，那么将运行必需的安全过程才能访问数据。

```javascript
var collections = {
    people : {
        searchFields: {name: 'string', age: 'integer'}
    }
};

WL.JSONStore.init(collections).then(function (collections) {
    // handle success - collection.people (people's collection)
}).fail(function (error) {
    // handle failure
});
```

> 有关可在初始化时启用的可选功能，请参阅本教程第二部分中的**安全性**、**多用户支持**和 **{{ site.data.keys.product_adj }} 适配器集成**。
### 获取
{: #get }
使用 `get` 来创建集合存取器。必须在调用 get 前调用 `init`，否则 `get` 的结果将不确定。

```javascript
var collectionName = 'people';
var people = WL.JSONStore.get(collectionName);
```

变量 `people` 现在可用于在 `people` 集合上执行操作，例如，`add`、`find` 和 `replace`。

### 添加
{: #add }
使用 `add` 将数据存储为集合中的文档

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

### 查找
{: #find }
* 使用 `find` 来通过查询查找集合中的文档。  
* 使用 `findAll` 来检索集合中的所有文档。  
* 使用 `findById` 来按文档唯一标识进行搜索。  

查找的缺省行为是执行“模糊”搜索。

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

### 替换
{: #replace }
使用 `replace` 来修改集合中的文档。用于执行替换的字段是文档唯一标识 `_id`。

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

此示例假定文档 `{_id: 1, json: {name: 'yoel', age: 23} }` 位于集合中。

### 除去
{: #remove }
使用 `remove` 以删除集合中的文档。  
在调用 push 之前，不会从集合中擦除文档。  

> 有关更多信息，请参阅本教程后面的 **{{ site.data.keys.product_adj }} 适配器集成**部分

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

### 除去集合
{: #remove-collection }
使用 `removeCollection` 以删除集合中存储的所有文档。此操作类似于数据库术语中的删除表。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).removeCollection().then(function (removeCollectionReturnCode) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

## 高级用法
{: #advanced-usage }
### 销毁
{: #destory }
使用 `destroy` 以除去以下数据：

* 所有文档
* 所有集合
* 所有存储区（请参阅本教程后面的“**多用户支持**”）
* 所有 JSONStore 元数据和安全工件（请参阅本教程后面的“**安全性**”）

```javascript
var collectionName = 'people';
WL.JSONStore.destroy().then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### 安全性
{: #security }
您可以通过将密码传递到 `init` 函数来保护存储区中的所有集合。如果未传递密码，那么将不会加密存储区中所有集合的文档。

数据加密仅适用于 Android、iOS、Windows 8.1 Universal 和 Windows 10 UWP 环境。  
某些安全元数据存储在*密钥链* (iOS)、*共享首选项* (Android) 或*凭据保险箱* (Windows8.1) 中。  
此存储区利用 256 位高级加密标准 (AES) 密钥进行加密。所有密钥通过基于密码的密钥派生功能 2 (PBKDF2) 进行增强。

使用 `closeAll` 以锁定对所有集合的访问，直至再次调用 `init`。如果将 `init` 当作登录函数，那么可将 `closeAll` 当作对应的注销函数。使用 `changePassword` 来更改密码。

```javascript
var collections = {
  people: {
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

#### 加密
{: #encryption }
*仅限 iOS*。缺省情况下，{{ site.data.keys.product_adj }} Cordova SDK for iOS 依赖 iOS 提供的 API 进行加密。如果想要将此替换为 OpenSSL：

1. 添加 cordova-plugin-mfp-encrypt-utils 插件：`cordova plugin add cordova-plugin-mfp-encrypt-utils`。
2. 在适用逻辑中，使用：`WL.SecurityUtils.enableNativeEncryption(false)` 以启用 OpenSSL 选项。

### 多用户支持
{: #multiple-user-support }
您可以在单个 {{ site.data.keys.product_adj }} 应用程序中创建包含不同集合的多个存储区。`init` 函数可使用包含用户名的选项对象。如果未指定用户名，那么缺省用户名为 **jsonstore**。

```javascript
var collections = {
  people: {
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

### {{ site.data.keys.product_adj }} 适配器集成
{: #mobilefirst-adapter-integration }
此部分假定您熟悉适配器。  

适配器集成为可选，其支持将数据从集合发送到适配器以及从适配器将数据获取到集合。
  
如果需要提高灵活性，可以使用 `WLResourceRequest` 或 `jQuery.ajax` 来实现这些目标。

### 适配器实现
{: #adapter-implementation }
创建一个适配器并将其命名为“**People**”。  
将其过程定义为 `addPerson`、`getPeople`、`pushPeople`、`removePerson` 和 `replacePerson`。

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

#### 初始化链接到 {{ site.data.keys.product_adj }} 适配器的集合
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

#### 从适配器装入数据
{: #load-data-from-an-adapter }
在调用 `load` 时，JSONStore 使用预先传递到 `init` 的一些有关适配器的元数据（**名称**和**过程**），从而确定要从适配器获取的数据，并最终进行存储。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).load().then(function (loadedDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### 获取所需推送（脏文档）
{: #get-push-required-dirty-documents }
调用 `getPushRequired` 将返回名为*“脏文档”*的数组，这些是包含后端系统上不存在的本地修订的文档。在调用 `push` 时，会将这些文档发送到适配器。

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).getPushRequired().then(function (dirtyDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

为阻止 JSONStore 将文档标记为“脏”，请将选项 `{markDirty:false}` 传递到 `add`、`replace` 和 `remove`

您还可以使用 `getAllDirty` API 来检索脏文档：

```javascript
WL.JSONStore.get(collectionName).getAllDirty()
.then(function (dirtyDocuments) {
    // handle success
}).fail(function (errorObject) {
    // handle failure
});
```

#### 推送
{: #push }
`push` 将更改的文档发送到正确的适配器程序（例如，通过本地添加的文档调用 `addPerson`）。此机制基于与更改的文档相关联的最新操作以及传递到 `init` 的适配器元数据。

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

### 增强
{: #enhance }
通过向集合原型添加函数，使用 `enhance` 以扩展核心 API 来适合您的需求。
此示例（以下代码片段）显示如何使用 `enhance` 来添加处理 `keyvalue` 集合的函数 `getValue`。其使用 `key`（字符串）作为其唯一参数并返回单个结果。

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

> 有关 JSONStore 的更多信息，请参阅用户文档。

<img alt="JSONStore 样本应用程序" src="jsonstore-cordova.png" style="float:right"/>
## 示例应用程序
{: #sample-application }
JSONStoreSwift 项目包含利用 JSONStore API 集合的 Cordova 应用程序。  
随附一个 JavaScript 适配器 Maven 项目。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80) Cordova 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80)适配器 Maven 项目。  

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件以获取指示信息。
