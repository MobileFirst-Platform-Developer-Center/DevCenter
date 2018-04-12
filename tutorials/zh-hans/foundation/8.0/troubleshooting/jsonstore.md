---
layout: tutorial
title: 对 JSONtore 进行故障诊断
breadcrumb_title: JSONStore
relevantTo: [ios,android,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
请查找相关信息来帮助解决在使用 JSONStore API 时可能遇到的问题。

## 在寻求帮助时提供信息
{: #provide-information-when-you-ask-for-help }
请尽量提供足够的信息，避免承受因未提供足够信息而产生的风险。为获取解决 JSONStore 问题所需的信息，以下列表是不错的起点。

* 操作系统和版本。例如，Windows XP SP3 Virtual Machine 或 Mac OSX 10.8.3。
* Eclipse 版本。例如，Eclipse Indigo 3.7 Java EE。
* JDK 版本。例如，Java SE Runtime Environment 1.7 版本。
* {{ site.data.keys.product }} 版本。例如，IBM Worklight V5.0.6 Developer Edition。
* iOS 版本。例如，iOS Simulator 6.1 或 iPhone 4S iOS 6.0（不推荐，请参阅“不推荐使用的功能和 API 元素”）。
* Android 版本。例如，Android Emulator 4.1.1 或 Samsung
Galaxy Android 4.0 API Level 14。
* Windows 版本。例如，Windows 8、Windows 8.1 或 Windows Phone 8.1。
* adb 版本。例如，Android Debug Bridge V1.0.31。
* 日志，例如，iOS 上的 Xcode 输出或 Android 上的 logcat 输出。

## 尝试隔离问题
{: #try-to-isolate-the-issue }
请遵循以下步骤来隔离问题以便更准确地报告问题。

1. 重置仿真器 (Android) 或模拟器 (iOS) 并调用 destroy API 以从干净的系统开始。
2. 确保在受支持的生产环境中运行。
    * Android >= 2.3 ARM v7/ARM v8/x86 仿真器或设备
    * iOS >= 6.0 模拟器或设备（不推荐）
    * Windows 8.1/10 ARM/x86/x64 模拟器或设备
3. 通过不向 init 或 open API 传递密码来尝试关闭加密。
4. 查看 JSONStore 生成的 SQLite 数据库文件。必须关闭加密。

   * Android 仿真器：

   ```bash
   $ adb shell
   $ cd /data/data/com.<app-name>/databases/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * iOS 模拟器：

   ```bash
   $ cd ~/Library/Application Support/iPhone Simulator/7.1/Applications/<id>/Documents/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```  

   * Windows 8.1 Universal / Windows 10 UWP 模拟器

   ```bash
   $ cd C:\Users\<username>\AppData\Local\Packages\<id>\LocalState\wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * **注：**在 Web 浏览器（Firefox、Chrome、Safari、Internet Explorer）上运行的“仅 JavaScript”实现不使用 SQLite 数据库。该文件存储在 HTML5 LocalStorage 中。
   * 查看带有 `.schema` 的 `searchFields`，并通过 `SELECT * FROM <collection-name>;` 来选择数据。要退出 sqlite3，请输入 `.exit`。如果将用户名传递至 init 方法，那么该文件名为 **the-username.sqlite**。如果不传递用户名，那么缺省情况下该文件名为 **jsonstore.sqlite**。
5. （仅限 Android）启用详细 JSONStore。

   ```bash
   adb shell setprop log.tag.jsonstore-core VERBOSE
   adb shell getprop log.tag.jsonstore-core
   ```

6. 使用调试器。

## 常见问题
{: #common-issues }
了解以下 JSONStore 特征可帮助解决一些可能遇到的常见问题。  

* 在 JSONStore 中存储二进制数据的唯一方法是首先以 base64 格式对该数据进行编码。将文件名或路径（而不是实际文件）存储在 JSONStore 中。
* 只能在 {{ site.data.keys.v62_product_full }}
V6.2.0 中从本机代码访问 JSONStore 数据。
* 除了移动操作系统施加的限制之外，不会限制 JSONStore 可存储的数据量。
* JSONStore 提供持久数据存储。这不只是存储在内存中。
* 如果集合名称以数字或符号开头，那么 init API 将失败。IBM Worklight V5.0.6.1 和更高版本会返回相应的错误：`4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING`
* 在搜索字段中，数字与整数是有区别的。如果类型为 `number`，那么数字值 `1` 和 `2` 将存储为 `1.0` 和
`2.0`。如果类型为 `integer`，它们将存储为 `1` 和 `2`。
* 如果应用程序被强制停止或崩溃，那么在该应用程序重新启动并调用 `init` 或 `open` API 时，该应用程序总是失败，并返回错误代码 -1。如果发生此问题，请首先调用
`closeAll` API。
* JSONStore 的 JavaScript 实现期望串行调用代码。等待操作完成，然后再调用下一个操作。
* 在 Android 2.3.x 中，Cordova 应用程序不支持事务。
* 在 64 位设备上使用 JSONStore 时，您可能会看到以下错误：`java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit`
* 此错误意味着您的 Android 项目中有 64 位本机库，而在使用这些库时，JSONStore 当前无法运行。要进行确认，请转至 Android 项目下的 **src/main/libs** 或 **src/main/jniLibs**，并检查是否存在 x86_64 或 arm64-v8a 文件夹。如果存在，请删除这些文件夹，这样 JSONStore 便可以恢复运行。
* 在某些情况（或环境）下，在初始化 JSONStore 插件前，此流程会进入 `wlCommonInit()`。这会导致 JSONStore 相关 API 调用失败。`cordova-plugin-mfp` 引导程序会自动调用 `WL.Client.init`，这样会在调用完成时触发 `wlCommonInit` 函数。对于 JSONStore 插件，此初始化过程会有所不同。JSONStore 插件无法_停止_ `WL.Client.init` 调用。根据环境不同，此流程可能在 `mfpjsonjslloaded` 完成之前进入 `wlCommonInit()`。
为确保 `mfpjsonjsloaded` 和 `mfpjsloaded` 事件的顺序正确，开发人员可以选择手动调用 `WL.CLient.init`。这样可避免使用特定于平台的代码。

  请遵循以下步骤以配置为手动调用 `WL.CLient.init`：                             

  1. 在 `config.xml` 中，将 `clientCustomInit` 属性更改为 **true**。

  + 在 `index.js` 文件中：                                   
    * 在该文件开头添加以下行：                
      ```javascript
      document.addEventListener('mfpjsonjsloaded', initWL, false);
      ```           
    * 将 `WL.JSONStore.init` 调用保留在 `wlCommonInit()` 中                    

    * 添加以下函数：  
    ```javascript                                         
function initWL(){                                                     
        var options = typeof wlInitOptions !== 'undefined' ? wlInitOptions
        : {};                                                                
        WL.Client.init(options);                                           
}                                                                      
```                                                                       

  这会等待 `mfpjsonjsloaded` 事件（在 `wlCommonInit` 外部）以确保已装入脚本，随后调用 `WL.Client.init` 以触发 `wlCommonInit`，然后调用 `WL.JSONStore.init`。

## Store internals
{: #store-internals }
请参阅有关如何存储 JSONStore 数据的示例。

此简化示例中包含以下关键元素：

* `_id` 是唯一标识（例如，AUTO INCREMENT PRIMARY KEY）。
* `json` 包含已存储的 JSON 对象的确切说明。
* `name` 和 age 是搜索字段。
* `key` 是额外的搜索字段。

| _id | key | name | age | JSON |
|-----|-----|------|-----|------|
| 1   | c   | carlos | 99 | {name: 'carlos', age: 99} |
| 2   | t   | tim   | 100 | {name: 'tim', age: 100} |

使用 `{_id : 1}、{name: 'carlos'}`、`{age: 99}、{key: 'c'}` 查询或者这些查询的组合进行搜索时，返回的文档为 `{_id: 1,json: {name: 'carlos', age: 99} }`。

其他内部 JSONStore 字段包括：

* `_dirty`：确定文档是否标记为脏文档。此字段用于跟踪文档更改。
* `_deleted`：是否将文档标记为已删除。此字段用于从集合中移除对象，其稍后用于跟踪后端更改以及确定是否移除这些对象。
* `_operation`：用于反映要对文档执行的最后一项操作（例如，replace）的字符串。
## JSONStore errors
{: #jsonstore-errors }
### JavaScript
{: #javascript }
JSONStore 使用 error 对象返回有关故障原因的消息。

在执行 JSONStore 操作（例如，`JSONStoreInstance` 类中的 `find` 和 `add` 方法）期间发生错误时，会返回一个 error 对象。该对象提供与故障原因有关的信息。

```javascript
var errorObject = {
  src: 'find', // Operation that failed.
  err: -50, // Error code.
  msg: 'PERSISTENT\_STORE\_FAILURE', // Error message.
  col: 'people', // Collection name.
  usr: 'jsonstore', // User name.
  doc: {_id: 1, {name: 'carlos', age: 99}}, // Document that is related to the failure.
  res: {...} // Response from the server.
}
```

并非每个 error 对象都包含所有键/值对。例如，仅当操作因未能移除某个文档而失败时（例如，`JSONStoreInstance` 类中的 `remove` 方法），doc 值才可用。
### Objective-C
{: #objective-c }
所有可能失败的 API 都会接受 error 参数，此参数用于向 NSError 对象传递地址。如果您不想收到错误通知，可以在 `nil` 中传递。操作失败时，使用 NSError（包含一个错误和一些可能的 `userInfo`）填充此地址。`userInfo` 可能包含其他详细信息（例如，引起这次失败的文档）。
```objc
// This NSError points to an error if one occurs.
NSError* error = nil;

// Perform the destroy.
[JSONStore destroyDataAndReturnError:&error];
```

### Java
{: #java }
根据发生的错误，所有 Java API 调用都会抛出某个特定异常。您可以单独处理每个异常，也可以捕获 `JSONStoreException` 作为所有 JSONStore 异常的保护伞。

```java
try {
  WL.JSONStore.closeAll();
}

catch(JSONStoreException e) {
  // Handle error condition.
}
```

### List of error codes
{: #list-of-error-codes }
常见错误代码及其描述的列表：

|错误代码        | 描述        |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | 无法识别的错误。   |
| -75 OS\_SECURITY\_FAILURE | 此错误代码与 requireOperatingSystemSecurity 标志相关。如果 destroy API 未能移除受操作系统安全性保护的安全性元数据（含密码回退的 Touch ID），或者如果 init 或 open API 找不到安全性元数据，那么可能发生此错误。如果设备不支持操作系统安全性，但请求使用操作系统安全性，那么也可能发生此错误。 |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore 已关闭。尝试首先调用 JSONStore 类中的 open 方法以启用对该存储区的访问。 |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | 回滚事务时出现问题。 |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION |当正在执行事务时无法调用 removeCollection。 |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | 当正在执行事务时无法调用 destroy。 |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | 当存在事务时无法调用 closeAll。 |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | 当正在执行事务时无法初始化该存储区。 |
| -43 TRANSACTION_FAILURE | 事务出现问题。 |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | 当未在执行事务时无法落实回滚的事务。 |
| -41 TRANSACTION\_IN\_POGRESS | 当正在执行其他事务时无法启动新事务。 |
| -40 FIPS\_ENABLEMENT\_FAILURE |FIPS 出现问题。 |
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | 从文件系统获取文件信息时出现问题。 |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | 替换来自集合的文档时出现问题。 |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | 从集合移除文档时出现问题。 |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | 存储数据保护密钥 (DPK) 时出现问题。 |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | 建立输入数据的索引时出现问题。 |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | 检查要传递到 searchFields 的类型是 string、integer、number 还是 boolean。 |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | 对文档数组执行的操作（例如，replace 方法）在处理特定文档时可能失败。将返回失败的文档并回滚该事务。在 Android 上，尝试在不受支持的架构上使用 JSONStore 时也会发生此错误。 |
| -10 ACCEPT\_CONDITION\_FAILED | 用户提供的 accept 函数返回了 false。 |
| -9 OFFSET\_WITHOUT\_LIMIT | 要使用偏移量，还必须指定限制。 |
| -8 INVALID\_LIMIT\_OR\_OFFSET | 验证错误，必须是正整数。 |
| -7 INVALID_USERNAME | 验证错误（只能是 [A-Z]、[a-z] 或 [0-9]）。|
| -6 USERNAME\_MISMATCH\_DETECTED | 要注销，JSONStore 用户必须首先调用 closeAll 方法。每次只能有一个用户。 |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED |当 destroy 方法尝试删除用于保存存储区内容的文件时出现问题。 |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | 当 destroy 方法尝试清除密钥链 (iOS) 或共享用户首选项 (Android) 时出现问题。 |
| -3 INVALID\_KEY\_ON\_PROVISION | 向加密存储区传递的密码错误。 |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | 搜索字段不是动态字段。对新搜索字段调用 init 或 open 方法之前，如果不调用 destroy 方法或 removeCollection 方法，那么无法更改搜索字段。如果更改搜索字段的名称或类型，可能会发生此错误。例如，将 {key: 'string'} 更改为 {key: 'number'}，或者将 {myKey: 'string'} 更改为 {theKey: 'string'}。 |
| -1 PERSISTENT\_STORE\_FAILURE | 一般错误。本机代码出现错误，很可能是在调用 init 方法时。 |
| 0 SUCCESS | 在某些情况下，JSONStore 本机代码返回 0 以指示成功。 |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | 验证错误。 |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | 验证错误。 |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | 验证错误。 |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | 验证错误。 |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | 验证错误。 |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | 验证错误。 |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | 验证错误。 |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB |用于选择已标记为脏文档的所有文档的查询失败。在 SQL 中，此查询的示例如下：SELECT * FROM [collection] WHERE _dirty > 0。 |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | 要使用诸如 JSONStoreCollection 类中 push 和 load 方法之类的函数，必须向 init 方法传递适配器。 |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | 验证错误 |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | 验证错误 |
| 12 ADAPTER_FAILURE | 调用 WL.Client.invokeProcedure 时出现问题，尤其是连接到适配器时出现问题。此错误与尝试调用后端的适配器所发生的故障不同。 |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | 验证错误 |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | 不允许调用 JSONStoreCollection 类中的 enhance 方法来替代现有函数（find 和 add）。 |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | 推送向适配器发送文档，但 JSONStore 未能将此文档标记为非脏文档。 |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | 要启动含密码的集合，必须存在到 {{ site.data.keys.mf_server }} 的连接，因为它会返回“安全的随机令牌”。IBM Worklight V5.0.6 和更高版本允许开发人员在本地生成安全的随机令牌，以通过 options 对象将 {localKeyGen: true} 传递到 init 方法。 |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | 无法装入数据，因为 WL.Client.invokeProcedure 已调用失败回调。 |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | 传递到 init 方法的 load 对象未通过验证。 |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | 调用 add 方法时 load 对象中使用的密钥存在问题。 |
| 20 UNDEFINED\_PUSH\_OPERATION | 未定义将脏文档推送至服务器的过程。例如，调用了 init 方法（新文档为脏文档，操作为“add”）和 push 方法（发现了新文档，操作为“add”），并且未在链接到集合的适配器中找到添加密钥（含添加过程）。在 init 方法内链接适配器。 |
| 21 INVALID\_ADD\_INDEX\_KEY | 额外的搜索字段出现问题。 |
| 22 INVALID\_SEARCH\_FIELD | 某一个搜索字段无效。请确保传入的搜索字段中不包括 _id、json、_deleted 或 _operation。 |
| 23 ERROR\_CLOSING\_ALL | 一般错误。本机代码调用 closeAll 方法时发生错误。 |
| 24 ERROR\_CHANGING\_PASSWORD | 无法更改密码。例如，传递的旧密码错误。 |
| 25 ERROR\_DURING\_DESTROY | 一般错误。本机代码调用 destroy 方法时发生错误。 |
| 26 ERROR\_CLEARING\_COLLECTION | 一般错误。当本机代码调用 removeCollection 方法时发生错误。 |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | 验证错误。 |
| 28 INVALID\_SORT\_OBJECT | 提供的用于排序的数组无效，因为其中一个 JSON 对象无效。正确的语法是 JSON 对象数组，其中每个对象仅包含单个属性。此属性将搜索作为排序依据的字段，并指定是升序还是降序。例如：{searchField1 : "ASC"}。 |
| 29 INVALID\_FILTER\_ARRAY | 提供的用于过滤结果的数组无效。此数组的正确语法是字符串数组，其中每个字符串是搜索字段或者是内部 JSONStore 字段。有关更多信息，请参阅“Store internals”。| | 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | 当数组不是仅含 JSON 对象的数组时发生验证错误。 |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | 验证错误。 |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | 验证错误。 |
