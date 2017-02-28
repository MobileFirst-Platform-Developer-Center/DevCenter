---
layout: tutorial
title: iOS 应用程序中的 JSONStore
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
downloads:
  - 名称：下载 Xcode 项目
    url：https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80
  - 名称：下载适配器 Maven 项目
    url：https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 先决条件
{: #prerequisites }
* 阅读 [JSONStore 父教程](../)
* 确保已将 {{ site.data.keys.product_adj }} 本机 SDK 添加到 Xcode 项目。遵循[向 iOS 应用程序添加 {{ site.data.keys.product }} SDK](../../../application-development/sdk/ios/) 教程。

#### 跳转至：
{: #jump-to }
* [添加 JSONStore](#adding-jsonstore)
* [基本用法](#basic-usage)
* [高级用法](#advanced-usage)
* [样本应用程序](#sample-application)

## 添加 JSONStore
{: #adding-jsonstore }
1. 将以下代码添加到 Xcode 项目根目录中的现有 `podfile`：

   ```xml
   pod 'IBMMobileFirstPlatformFoundationJSONStore'
   ```

2. 从**命令行**窗口，浏览至 Xcode 项目的根目录并运行命令：`pod install` - 请注意，此操作可能需要一些时间。

在要使用 JSONStore 时，确保导入 JSONStore 头：  
Objective-C：

```objc
#import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
```

Swift：

```swift
import IBMMobileFirstPlatformFoundationJSONStore    
```

## 基本用法
{: #basic-usage }
### 打开
{: #open }
使用 `openCollections` 打开一个或多个 JSONStore 集合。

启动或供应集合意味着创建包含集合和文档的持久存储（如果不存在）。  
如果持久存储已加密且传递了正确密码，那么将运行必需的安全过程才能访问数据。

有关可在初始化时启用的可选功能，请参阅本教程第二部分中的**安全性、多用户支持**和 **{{ site.data.keys.product_adj }} 适配器集成**。

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")

collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

do {
try JSONStore.sharedInstance().openCollections([collection], withOptions: nil)
} catch let error as NSError {
// handle error
}
```

### 获取
{: #get }
使用 `getCollectionWithName` 来创建集合存取器。必须先调用 `openCollections`，然后才能调用 `getCollectionWithName`。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)
```

变量 `collection` 现在可用于在 `people` 集合上执行操作，例如，`add`、`find` 和 `replace`。

### 添加
{: #add }
使用 `addData` 以将数据存储为集合中的文档。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let data = ["name" : "yoel", "age" : 23]

do {
try collection.addData([data], andMarkDirty: true, withOptions: nil)
} catch let error as NSError {
// handle error
}
```

### 查找
{: #find }
使用 `findWithQueryParts` 以通过查询查找集合中的文档。使用 `findAllWithOptions` 以检索集合中的所有文档。使用 `findWithIds` 以按文档唯一标识进行搜索。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let options:JSONStoreQueryOptions = JSONStoreQueryOptions()
// returns a maximum of 10 documents, default: returns every document
options.limit = 10

let query:JSONStoreQueryPart = JSONStoreQueryPart()
query.searchField("name", like: "yoel")

do {
let results:NSArray = try collection.findWithQueryParts([query], andOptions: options)
} catch let error as NSError {
// handle error
}
```

### 将


{: #replace }
使用 `replaceDocuments` 以修改集合中的文档。用于执行替换的字段是文档唯一标识 `_id`。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

var document:Dictionary<String,AnyObject> = Dictionary()
document["name"] = "chevy"
document["age"] = 23

var replacement:Dictionary<String, AnyObject> = Dictionary()
replacement["_id"] = 1
replacement["json"] = document

do {
try collection.replaceDocuments([replacement], andMarkDirty: true)
} catch let error as NSError {
// handle error
}
```

此示例假定文档 `{_id: 1, json: {name: 'yoel', age: 23} }` 位于集合中。

### 除去
{: #remove }
使用 `removeWithIds` 以删除集合中的文档。
在调用 `markDocumentClean` 之前，不会从集合中擦除文档。有关更多信息，请参阅本教程后面的 **{{ site.data.keys.product_adj }} 适配器集成**部分。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
try collection.removeWithIds([1], andMarkDirty: true)
} catch let error as NSError {
// handle error
}
```

### 除去集合
{: #remove-collection }
使用 `removeCollection` 来删除集合中存储的所有文档。此操作类似于数据库术语中的删除表。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
try collection.removeCollection()
} catch let error as NSError {
// handle error
}
```

### 销毁
{: #destroy }
使用 `destroyData` 以除去以下数据：

* 所有文档
* 所有集合
* 所有存储区 - 请参阅本教程后面的**多用户支持**。
* 所有 JSONStore 元数据和安全工件 - 请参阅本教程后面的**安全性**

```swift
do {
  try JSONStore.sharedInstance().destroyData()
} catch let error as NSError {
// handle error
}
```

## 高级用法
{: #advanced-usage }
### 安全性
{: #security }
您可以通过将包含密码的 `JSONStoreInitOptions` 对象传递到 `openCollections` 函数来保护存储区中的所有集合。如果未传递密码，那么将不会加密存储区中所有集合的文档。

某些安全元数据存储在密钥链 (iOS) 中。  
此存储区利用 256 位高级加密标准 (AES) 密钥进行加密。所有密钥通过基于密码的密钥派生功能 2 (PBKDF2) 进行增强。

使用 `closeAllCollections` 以锁定对所有集合的访问，直至再次调用 `openCollections`。如果将 `openCollections` 当作登录函数，那么可将 `closeAllCollections` 当作对应的注销函数。

使用 `changeCurrentPassword` 来更改密码。

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.password = "123"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
// handle error
}
```

### 多用户支持
{: #multiple-user-support }
您可以在单个 {{ site.data.keys.product_adj }} 应用程序中创建包含不同集合的多个存储区。`openCollections` 函数可使用包含用户名的选项对象。如果未指定用户名，那么缺省用户名为 jsonstore。

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.username = "yoel"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
// handle error
}
```

### {{ site.data.keys.product_adj }} 适配器集成
{: #mobilefirst-adapter-integration }
此部分假定您熟悉适配器。适配器集成为可选，其支持将数据从集合发送到适配器以及从适配器将数据获取到集合。


您可以使用诸如 `WLResourceRequest` 的函数实现这些目标。

#### 适配器实现
{: #adapter-implementation }
创建一个适配器并将其命名为“**People**”。将其过程定义为 `addPerson`、`getPeople`、`pushPeople`、`removePerson` 和 `replacePerson`。

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
要从 MobileFirst 适配器装入数据，请使用 `WLResourceRequest`。

```swift
// Start - LoadFromAdapter
class LoadFromAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    let responsePayload:NSDictionary = response.getResponseJson()
    let people:NSArray = responsePayload.objectForKey("peopleList") as! NSArray
    // handle success
  }

  func onFailure(response: WLFailResponse!) {
    // handle failure
  }
}
// End - LoadFromAdapter

let pull = WLResourceRequest(URL: NSURL(string: "/adapters/People/getPeople"), method: "GET")

let loadDelegate:LoadFromAdapter = LoadFromAdapter()
pull.sendWithDelegate(loadDelegate)
```

#### 获取所需推送（脏文档）
{: #get-push-required-dirty-documents }
调用 `allDirty` 将返回名为“脏文档”的数组，这些是包含后端系统上不存在的本地修订的文档。

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
let dirtyDocs:NSArray = try collection.allDirty()
} catch let error as NSError {
// handle error
}
```

要阻止 JSONStore 将文档标记为“脏”，请将选项 `andMarkDirty:false` 传递到 `add`、`replace` 和 `remove`。

#### 推送更改
{: #push-changes }
要将更改推送到适配器，请调用 `allDirty` 以获取包含修订的文档列表，然后使用 `WLResourceRequest`。在发送数据并且收到成功响应后，确保调用 `markDocumentsClean`。

```swift
// Start - PushToAdapter
class PushToAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    // handle success
  }

  func onFailure(response: WLFailResponse!) {
    // handle failure
  }
}
// End - PushToAdapter

let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
let dirtyDocs:NSArray = try collection.allDirty()
  let pushData:NSData = NSKeyedArchiver.archivedDataWithRootObject(dirtyDocs)

  let push = WLResourceRequest(URL: NSURL(string: "/adapters/People/pushPeople"), method: "POST")

  let pushDelegate:PushToAdapter = PushToAdapter()
  push.sendWithData(pushData, delegate: pushDelegate)

} catch let error as NSError {
// handle error
}
```

<img alt="样本应用程序的图像" src="jsonstore-ios-screen.png" style="float:right; width:240px;"/>
## 示例应用程序
{: #sample-application }
JSONStoreSwift 项目包含利用 JSONStore API 集合的本机 iOS Swift 应用程序。  
随附一个 JavaScript 适配器 Maven 项目。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80)本机 iOS 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80)适配器 Maven 项目。  

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件以获取指示信息。
