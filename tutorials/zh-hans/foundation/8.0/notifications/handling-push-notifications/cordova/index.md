---
layout: tutorial
title: 在 Cordova 中处理推送通知
breadcrumb_title: Cordova
relevantTo: [cordova]
downloads:
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在 iOS、Android 和 Windows Cordova 应用程序可以接收和显示推送通知之前，需要将 **cordova-plugin-mfp-push** Cordova 插件添加到 Cordova 项目中。在配置应用程序后，可以使用 {{ site.data.keys.product_adj }} 提供的通知 API 来注册和注销设备、预订和取消预订标记以及处理通知。在本教程中，您将学会如何在 Cordova 应用程序中处理推送通知。

> **注：**在此发行版中，Cordova 应用程序因为某个缺陷而**不支持**已认证的通知。但是，提供了以下变通方法：可通过 `WLAuthorizationManager.obtainAccessToken("push.mobileclient").then( ... );` 来包装每个 `MFPPush` API 调用。提供的样本应用程序中使用了此变通方法。

有关 iOS 中的静默通知或交互式通知的信息，请参阅：

* [静默通知](../silent)
* [交互式通知](../interactive)

**先决条件：**

* 确保您已阅读过下列教程：
    * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
    * [将 {{site.data.keys.product }} SDK 添加到 Cordova 应用程序](../../../application-development/sdk/cordova)
    * [推送通知概述](../../)
* 本地运行的 {{ site.data.keys.mf_server }} 或远程运行的 {{ site.data.keys.mf_server }}
* 安装在开发人员工作站上的 {{ site.data.keys.mf_cli }}
* 安装在开发人员工作站上的 Cordova CLI

#### 跳转至
{: #jump-to }
* [通知配置](#notifications-configuration)
* [通知 API](#notifications-api)
* [处理推送通知](#handling-a-push-notification)
* [样本应用程序](#sample-application)

## 通知配置
{: #notifications-configuration }
创建新的 Cordova 项目或使用现有项目，并添加一个或多个受支持的平台：iOS、Android 或 Windows。

> 如果该项目中还没有 {{ site.data.keys.product_adj }} Cordova SDK，请遵循[将 {{site.data.keys.product }} SDK 添加到 Cordova 应用程序](../../../application-development/sdk/cordova)教程中的指示信息。

### 添加“推送”插件
{: #adding-the-push-plug-in }
1. 从**命令行**窗口中，浏览至 Cordova 项目的根目录。  

2. 运行以下命令以添加“推送”插件：

   ```bash
   cordova plugin add cordova-plugin-mfp-push
   ```

3. 运行以下命令以构建 Cordova 项目：

   ```bash
   cordova build
   ```

### iOS 平台
{ #ios-platform } 
iOS 平台需要完成一个额外的步骤。  
在 Xcode 的**功能**屏幕中，为您的应用程序启用推送通知。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **要点：**为应用程序选择的 bundleId 必须与 Apple Developer 站点中先前创建的 AppId 相匹配。请参阅[推送通知概述]教程。

![该功能在 Xcode 中的位置的图像](push-capability.png)

## 通知 API
{: #notifications-api }
### 客户端
{: #client-side }

| Javascript 函数 | 描述 |
| --- | --- |
| [`MFPPush.initialize(success, failure)`](#initialization) | 初始化 MFPPush 实例。 | 
| [`MFPPush.isPushSupported(success, failure)`](#is-push-supported) | 设备是否支持推送通知。 | 
| [`MFPPush.registerDevice(options, success, failure)`](#register-device) | 向推送通知服务注册设备。 | 
| [`MFPPush.getTags(success, failure)`](#get-tags) | 在推送通知服务实例中检索所有可用标记。 | 
| [`MFPPush.subscribe(tag, success, failure)`](#subscribe) | 预订特定标记。 | 
| [`MFPPush.getSubsciptions(success, failure)`](#get-subscriptions) | 检索设备当前预订的标记。 | 
| [`MFPPush.unsubscribe(tag, success, failure)`](#unsubscribe) | 取消对特定标记的预订。 | 
| [`MFPPush.unregisterDevice(success, failure)`](#unregister) | 从推送通知服务注销设备。 | 

### API 实现
{: #api-implementation }
#### 初始化
{: #initialization }
初始化 **MFPPush** 实例。

- 在客户机应用程序使用适当的应用程序上下文连接到 MFPPush 服务时为必需项。  
- 应先调用此 API 方法，然后再使用任何其他 MFPPush API。
- 注册回调函数以处理已收到的推送通知。

```javascript
MFPPush.initialize (
    function(successResponse) {
        alert("Successfully intialized");
        MFPPush.registerNotificationsCallback(notificationReceived);
    },
    function(failureResponse) {
        alert("Failed to initialize");
    }
);
```

#### 是否支持推送
{: #is-push-supported }
检查设备是否支持推送通知。

```javascript
MFPPush.isPushSupported (
    function(successResponse) {
        alert("Push Supported: " + successResponse);
    },
    function(failureResponse) {
        alert("Failed to get push support status");
    }
);
```

#### 注册设备
{: #register-device }
向推送通知服务注册设备。如果不需要任何选项，可将 options 设置为 `null`。


```javascript
var options = { };
MFPPush.registerDevice(
    options,
    function(successResponse) {
        alert("Successfully registered");
    },
    function(failureResponse) {
        alert("Failed to register");
    }
);
```

#### 获取标记
{: #get-tags }
从推送通知服务检索所有可用标记。

```javascript
MFPPush.getTags (
    function(tags) {
        alert(JSON.stringify(tags));
},
    function() {
        alert("Failed to get tags");
    }
);
```

#### 预订
{: #subscribe }
预订所需的标记。

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.subscribe(
    tags,
    function(tags) {
        alert("Subscribed successfully");
    },
    function() {
        alert("Failed to subscribe");
    }
);
```

#### 获取预订
{: #get-subscriptions }
检索设备当前预订的标记。

```javascript
MFPPush.getSubscriptions (
    function(subscriptions) {
        alert(JSON.stringify(subscriptions));
    },
    function() {
        alert("Failed to get subscriptions");
    }
);
```

#### 取消预订
{: #unsubscribe }
取消对标记的预订。

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.unsubscribe(
    tags,
    function(tags) {
        alert("Unsubscribed successfully");
    },
    function() {
        alert("Failed to unsubscribe");
    }
);
```

#### 注销
{: #unregister }
从推送通知服务实例注销设备。

```javascript
MFPPush.unregisterDevice(
    function(successResponse) {
        alert("Unregistered successfully");
    },
    function() {
        alert("Failed to unregister");
    }
);
```

## 处理推送通知
{: #handling-a-push-notification }
通过在已注册的回调函数中对响应对象执行操作，可以处理已收到的推送通知。

```javascript
var notificationReceived = function(message) {
    alert(JSON.stringify(message));
};
```

<img alt="样本应用程序图像" src="notifications-app.png" style="float:right"/>
## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80) Cordova 项目。

**注：**要运行此样本，需要在任何 Android 设备上安装最新版本的 Google Play Services。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。
