---
layout: tutorial
title: React Native 应用程序中的 JSONStore
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## 先决条件
{: #prerequisites }
* 阅读 [JSONStore 父教程](../)
* 确保已将 {{ site.data.keys.product_adj }} React Native 核心 SDK 添加到项目。遵循[向 React-Native 应用程序添加 Mobile Foundation SDK](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/) 教程。

#### 跳转至：
{: #jump-to}
* [添加 JSONStore](#adding-jsonstore)
* [基本用法](#basic-usage)
* [样本应用程序](#sample_app_for_jsonstore)

## 添加 JSONStore
{: #adding-jsonstore }
要向 React Native 应用程序添加 JSONStore 插件：

1. 打开**命令行**窗口并浏览至 React Native 项目文件夹。
2. 运行以下命令：
```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## 基本用法
{: #basic-usage }
### 创建新 JSONStore 集合
{: #create_new_jsonstore_collection}
1.  我们使用 `JSONStoreCollection` 类创建 JSONStore 的实例。我们还可以将其他配置设置为此新创建的 JSONStore 集合（例如，设置搜索字段）。
2.  要开始与现有的 JSONStore 集合交互（例如：添加或移除数据），我们需要*打开*集合。我们使用 `openCollections()` API 来执行此操作。
```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// handle success
    }).catch(err => {
    	// handle failure
    });
    ```

### 添加
{: #add}
使用 `addData()` API 将 JSON 数据存储在集合中。

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

> 您可以使用该 API 添加单个 JSON 对象或 JSON 对象数组。

### 查找
{: #find}
1.  使用 `find` 来通过查询查找集合中的文档。
2.  使用 `findAllDocuments()` API 来检索集合中的所有文档。
3.  使用 `findDocumentById()` 和 `findDocumentsById()` API 来根据文档唯一标识进行搜索。
4.  使用 `findDocuments()` API 来查询集合。对于查询，您可以使用 `JSONStoreQueryPart` 类对象来过滤数据。

> 将 `JSONStoreQueryPart` 对象数组作为参数传递至 `findDocuments` API。

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

### 除去
{: #remove}
使用 `remove` 以删除集合中的文档。

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

### 除去集合
{: #removecollection}
使用 `removeCollection` 来删除集合中存储的所有文档。 此操作类似于数据库术语中的删除表。

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

## IBM MobileFirst JSONStore 的样本应用程序
{: #sample_app_for_jsonstore}
在[此处](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative)下载样本。

### 运行样本
{: #running_sample}
在样本的根目录中，运行以下命令，这将安装所有项目依赖关系：

```bash
npm install
```

>**注：**确保您的 *mfpclient.properties* 和 *mfpclient.plist* 指向正确的 MobileFirst Server。

1. 注册应用程序。转至 `android` 目录并运行以下命令：
```bash
    mfpdev app register
    ```

2. 配置应用程序。（仅针对 Android）
   *  从 React Native 项目根目录打开 `android/app/src/main/AndroidManifest.xml` 文件。<br/>
    	 向 `<manifest>` 标记添加以下行：<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 向 `<application>` 标记添加以下行：<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 *react-native-ibm-mobilefirst* 库需要执行此步骤。<br/>

	 *  从 React Native 项目根目录打开 `android/app/build.gradle` 文件。<br/>
      在 *android {}* 内添加以下代码：<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      *react-native-ibm-mobilefirst-jsonstore* 库需要执行此步骤。

3. 运行应用程序。返回至根目录并浏览至 `iOS` 目录，然后运行以下命令：`mfpdev app register`

我们现在可运行应用程序。
要在 Android 上运行，请执行以下命令：
```bash
react-native run-android
```
