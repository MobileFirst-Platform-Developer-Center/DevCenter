---
layout: tutorial
title: 在客户机应用程序中使用 Analytics API
breadcrumb_title: Analytics API
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.mf_analytics_full }} 提供客户机端 API，可帮助用户开始收集有关应用程序的分析数据。本教程提供有关如何在客户机应用程序上设置分析支持的信息，并且列出了可用的 API。

#### 跳转至
{: #jump-to }

* [在客户机端配置分析](#configuring-analytics-on-the-client-side)
* [发送分析数据](#sending-analytics-data)
* [启用/禁用客户机事件](#enablingdisabling-client-event-types)
* [定制事件](#custom-events)
* [跟踪用户](#tracking-users)

## 在客户机端配置分析
{: #configuring-analytics-on-the-client-side }

在可以开始收集 {{ site.data.keys.mf_analytics }} 提供的预定义数据之前，您必须先导入相应的库以初始化分析支持。

### JavaScript (Cordova)
{: #javascript-cordova }

在 Cordova 应用程序中，无需设置，已内置初始化。  

### JavaScript (Web)
{: #javascript-web }

在 Web 应用程序中，必须引用分析 JavaScript 文件。确保您已先添加 {{ site.data.keys.product_adj }} Web SDK。有关更多信息，请参阅[将 {{ site.data.keys.product_adj }} SDK 添加到 Web 应用程序](../../application-development/sdk/web)教程。  

根据您添加 {{ site.data.keys.product_adj }} Web SDK 的方式，以下列任一方法继续：


在 `HEAD` 元素中引用 {{ site.data.keys.mf_analytics }}：

```html
<head>
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics.js"></script>
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

或者，如果正在使用 RequireJS，可编写：

```javascript
require.config({
	'paths': {
		'ibmmfpfanalytics': 'node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics',
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['ibmmfpfanalytics','mfp'], function(ibmmfpfanalytics, WL) {
    // application logic.
});
```

请注意，您可以选择自己的名称空间以替换“ibmmfpfanalytics”。


```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

 **要点**：Cordova 与 Web SDK 之间存在一些 JavaScript API 差异。请参阅用户文档中的 [API 参考主题](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/topics/r_apiref.html)。

### iOS
{: #ios }

#### 导入 WLAnalytics 库
{: #importing-the-wlanalytics-library }

**Objective-C**

```objc
import "WLAnalytics.h"
```

**Swift**

```Swift
import IBMMobileFirstPlatformFoundation
```

#### 初始化分析
{: #initialize-analytics }

**Objective-C**  
无需设置。缺省情况下已预初始化。

**Swift**  
在调用 **WLAnalytics** 类的其他方法之前，调用 `WLAnalytics.sharedInstance()`。

### Android
#{: #android }

#### 导入 WLAnalytics
{: #import-wlanalytics }

```java
import com.worklight.common.WLAnalytics;
```

#### 初始化分析
{: #initialize-analytics }

在您的主活动的 `onCreate` 方法内包含：

```java
WLAnalytics.init(this.getApplication());
```


## 启用/禁用客户机事件类型
{: #enablingdisabling-client-event-types }

Analytics API 使开发人员能够自由地启用和禁用要在 {{ site.data.keys.mf_analytics_console }} 上显示的事件的分析收集。

{{ site.data.keys.mf_analytics }} API 允许捕获以下指标。

* **生命周期事件**：应用程序使用率、使用持续时间、应用程序崩溃率
* **网络使用情况**：API 调用频率明细、网络性能指标
* **用户**：按提供的用户标识识别的应用程序用户
* **定制分析**：由应用程序开发者定义的定制键/值对

必须使用本机代码写入分析 API 的初始化，即使在 Cordova 应用程序中也是如此。

 * 要捕获应用程序使用情况，必须在发生相关事件之前以及将数据发送至服务器之前注册应用程序生命周期事件侦听器。
 * 要使用文件系统或本机语言和设备功能，必须初始化 API。如果 API 的使用需要本机设备功能（如文件系统），但未初始化 API，那么 API 调用失败。在 Android 上尤其如此。

**注意**：要构建 Cordova 应用程序，JavaScript Analytics API 无法启用或禁用 `LIFECYCLE` 或 `NETWORK` 事件的收集。换句话说，缺省情况下 Cordova 应用程序会预先启用 `LIFECYCLE` 和 `NETWORK` 事件。如果要禁用这些事件，请参阅[客户机生命周期事件](#client-lifecycle-events)和[客户机网络事件](#client-lifecycle-events)。

### 客户机生命周期事件
{: #client-lifecycle-events }

在配置 Analytics SDK 之后，将开始在用户设备上记录应用程序会话。将应用程序从前台移至后台时将在 {{ site.data.keys.mf_analytics }} 中记录会话，这将在 {{ site.data.keys.mf_analytics_console_short }} 上创建会话。

一旦将设备设置为记录会话并发送数据，就可以看到 {{ site.data.keys.mf_analytics_console_short }} 已填充有数据，如下所示。

![会话图表](analytics-app-sessions.png)

使用 {{ site.data.keys.mf_analytics_short }} API 来启用或禁用应用程序会话收集。

#### JavaScript
{: #javascript }

**Web**  
要使用客户机生命周期事件，请对分析进行初始化：

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
要能够捕获生命周期事件，必须在 Cordova 应用程序的本机平台中对其进行初始化。

* 对于 iOS 平台：
	* 打开 **[Cordova 应用程序根文件夹] → platforms → ios → Classes** 文件夹，找到 **AppDelegate.m** (Objective-C) 或 **AppDelegate.swift** (Swift) 文件。
	* 遵循下面的 iOS 指南以启用或禁用 `LIFECYCLE` 活动。
	* 运行下列命令来构建 Cordova 项目：`cordova build`。

* 对于 Android 平台：
	* 打开 **[Cordova 应用程序根文件夹] → platforms → android → src→ com → sample → [应用程序名称] → MainActivity.java** 文件。
	* 查找 `onCreate` 方法，遵循下面的 Android 指南来启用或禁用 `LIFECYCLE` 活动。
	* 运行下列命令来构建 Cordova 项目：`cordova build`。

#### Android
{: #android }

要启用客户机生命周期事件日志记录：

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

要禁用客户机生命周期事件日志记录：

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE);
```

#### iOS
{: #ios }

要启用客户机生命周期事件日志记录：

**Objective-C：**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
```

**Swift：**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

要禁用客户机生命周期事件日志记录：

**Objective-C：**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

**Swift：**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(LIFECYCLE);
```

### 客户机网络活动
{: #client-network-activities }

在两个不同的位置进行有关适配器和网络的收集：在客户机和服务器上：

* 在您开始收集有关 `NETWORK` 设备事件的信息时，客户机收集诸如双向时间和有效内容大小之类的信息。

* 服务器收集诸如服务器处理时间、适配器使用情况和已使用过程等后端信息。

由于客户机和服务器各自收集自己的信息，图表不会显示数据，直至将客户机配置为显示数据。要配置您的客户机，必须对 `NETWORK` 设备事件启动收集并将其发送到服务器。

#### JavaScript
{: #javascript }

**Web**  
要使用客户机网络事件，请对分析进行初始化：

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
要能够捕获网络事件，必须在 Cordova 应用程序的本机平台中对其进行初始化。

* 对于 iOS 平台：
	* 打开 **[Cordova 应用程序根文件夹] → platforms → ios → Classes** 文件夹，找到 **AppDelegate.m** (Objective-C) 或 **AppDelegate.swift** 文件。
	* 遵循下面的 iOS 指南以启用或禁用 `NETWORK` 活动。
	* 运行下列命令来构建 Cordova 项目：`cordova build`。

* 对于 Android 平台：导航到要禁用的主活动的子活动。
	* 打开 **[Cordova 应用程序根文件夹] → platforms → ios → src →com → sample → [应用程序名称] → MainActivity.java** 文件。
	* 查找 `onCreate` 方法，并遵循下面的 Android 指南来启用或禁用 `NETWORK` 活动。
	* 运行下列命令来构建 Cordova 项目：`cordova build`。

#### iOS
{: #ios }

要启用客户机网络事件日志记录：

**Objective-C：**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

**Swift：**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
```

要禁用客户机网络事件日志记录：

**Objective-C：**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

**Swift：**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(NETWORK);
```

#### Android
{: #android }

要启用客户机网络事件日志记录：

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

要禁用客户机网络事件日志记录：

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

## 定制事件
{: #custom-events }

使用以下 API 方法来创建定制事件。

#### JavaScript (Cordova)
{: #javascript-cordova }

```javascript
WL.Analytics.log({"key" : 'value'});
```

#### JavaScript (Web)
{: #javascript-web }

对于 Web API，使用 `addEvent` 方法来发送定制数据。

```javascript
ibmmfpfanalytics.addEvent({'Purchases':'radio'});
ibmmfpfanalytics.addEvent({'src':'App landing page','target':'About page'});
```

#### Android
{: #android }

在设置前两个配置之后，您可以开始记录数据，如该示例中所示：

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
```

#### iOS
{: #ios }

在导入 WLAnalytics 之后，您现在可以使用 API 来收集定制数据，如下所示：

**Objective-C：**

```objc
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

**Swift：**

```swift
let metadata: [NSObject: AnyObject] = ["foo": "bar"];  
WLAnalytics.sharedInstance().log("hello", withMetadata: metadata);
```

## 跟踪用户
{: #tracking-users }

要跟踪个别用户，请使用 `setUserContext` 方法：

#### Cordova
{: #cordova }

不受支持。

#### Web 应用程序
{: #web-applications }

```javascript
ibmmfpfanalytics.setUserContext(user);
```

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] setUserContext:@"John Doe"];
```

**Swift**

```swift
WLAnalytics.sharedInstance().setUserContext("John Doe")
```

#### Android
{: #android }

```java
WLAnalytics.setUserContext("John Doe");
```

要取消跟踪个别用户，请使用 `setUserContext` 方法：

#### Cordova
{: #cordova }

不受支持。

#### Web 应用程序
{: #web-applications }

{{ site.data.keys.product_adj }} Web SDK 中没有 `unsetUserContext`。用户会话将在 30 分钟不活动后结束，除非对 `ibmmfpfanalytics.setUserContext(user)` 发出另一个调用。

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] unsetUserContext];
```

**Swift**

```swift
WLAnalytics.sharedInstance().unsetUserContext
```

#### Android
{: #android }

```java
WLAnalytics.unsetUserContext();
```

## 发送分析数据
{: #sending-analytics-data }

发送分析是在分析服务器上查看客户机端分析的至关重要的一步。针对分析收集了已配置的事件类型的数据后，分析日志将存储在客户机设备上的日志文件中。将使用 Analytics API 的 `send` 方法将来自该文件中的数据发送到 {{ site.data.keys.mf_analytics_server }}。

考虑定期将捕获的日志发送到服务器。定期发送数据可确保您在 {{ site.data.keys.mf_analytics_console }} 中看到最新分析数据。

#### JavaScript (Cordova)
{: #javascript-cordova }

在 Cordova 应用程序中，使用以下 JavaScript API 方法：

```javascript
WL.Analytics.send();
```

#### JavaScript (Web)
{: #javascript-web }

在 Web 应用程序中，使用以下 JavaScript API 方法（取决于您已选择的名称空间）：

```javascript
ibmmfpfanalytics.send();
```

#### iOS
{: #ios }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```swift
WLAnalytics.sharedInstance().send();
```

#### Android
{: #android }

在 Android 应用程序中，使用以下 Java API 方法：

```java
WLAnalytics.send();
```
