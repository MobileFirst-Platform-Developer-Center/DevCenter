---
layout: tutorial
title: 通知
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
通知是移动设备的一项功能，用于接收从服务器“推送”的消息。  
不管应用程序当前是在前台还是在后台运行，都会收到通知。  

{{ site.data.keys.product_full }} 提供了一整套 API 方法，可用于将推送通知或 SMS 通知发送到 iOS、Android、Windows 8.1 Universal、Windows 10 UWP 和 Cordova（iOS 或 Android）应用程序。通知从 {{ site.data.keys.mf_server }} 发送到供应商（Apple、Google、Microsoft 或 SMS Gateways）基础结构，然后从该处发送到相关设备。统一通知机制使与用户和设备通信的整个过程对开发人员完全透明。

#### 设备支持
{: #device-support }
以下平台上的 {{ site.data.keys.product }} 中支持推送通知和 SMS 通知：

* iOS 8.x 及更高版本
* Android 4.x 及更高版本
* Windows 8.1 或 Windows 10

#### 跳转至：
{: #jump-to }
* [推送通知](#push-notifications)
* [SMS 通知](#sms-notifications)
* [代理设置](#proxy-settings)
* [后续教程](#tutorials-to-follow-next)

## 推送通知
{: #push-notifications }
通知可以采取多种形式：

* **警报（iOS、Android 或 Windows）** - 弹出式文本消息
* **声音（iOS、Android 或 Windows）** - 收到通知时播放的声音文件
* **角标 (iOS) 或磁贴 (Windows)** - 允许短文本或图像的图形表示
* **条幅 (iOS) 或 Toast (Windows)** - 隐藏在设备显示屏顶部的弹出式文本消息
* **交互式（iOS 8 及更高版本）** - 位于已接收通知的条幅内的操作按钮
* **静默（iOS 8 及更高版本）** - 在不打扰用户的情况下发送通知

### 推送通知类型 
{: #push-notification-types }
#### 标记通知
{: #tag-notifications }
标记通知是只将预订了特定标记的所有设备作为目标的通知消息。  

基于标记的通知允许根据主题区域或主题对通知进行细分。通知接收方可以选择仅接收关于所关注主题的通知。因此，基于标记的通知提供了一种对接收方进行细分的方法。通过此功能，您可以定义标记并按标记发送或接收消息。消息的目标对象只包括已预订某标记的设备。

#### 广播通知
{: #broadcast-notifications }
广播通知是标记推送通知的一种形式，其将所有预订设备作为目标，任何支持推送的 {{ site.data.keys.product_adj }} 应用程序在缺省情况下都可通过预订保留的 `Push.all` 标记（为每个设备自动创建）来启用此类通知。可通过取消对保留的 `Push.all` 标记的预订来禁用广播通知。

#### 单点广播通知
{:# unicast-notifications }
单点广播通知或用户认证的通知都由 OAuth 提供保护。这些通知消息将特定设备或用户标识作为目标。用户预订中的用户标识可以来自底层安全上下文。

#### 交互式通知
{: #interactive-notifications }
通过使用交互式通知，在通知到达时，用户可以在不打开应用程序的情况下执行相应操作。在交互式通知到达时，设备会显示操作按钮以及通知消息。目前，在装有 iOS V8 及更高版本的设备上支持交互式通知。如果将交互式通知发送到装有 iOS V8 之前版本的 iOS 设备，那么将不会显示通知操作。

> 了解如何处理[交互式通知](handling-push-notifications/interactive)。

#### 静默通知
{: #silent-notifications }
静默通知是既不显示警报也不打扰用户的通知。当静默通知到达时，应用程序处理代码将在后台运行，而不是将应用程序转到前台。目前，在装有 iOS V7 及更高版本的设备上支持静默通知。如果将静默通知发送到装有 iOS V7 之前版本的设备，那么当应用程序在后台运行时，将忽略该通知。如果应用程序在前台运行，那么将调用通知回调方法。

> 了解如何处理[静默通知](handling-push-notifications/silent)。

**注：**单点广播通知的有效内容中不包含任何标记。通过在 POST 消息 API 的目标块中分别指定多个设备标识或用户标识，通知消息可以将多个设备或用户作为目标。

## SMS 通知
{: #sms-notifications }
要开始接收 SMS 通知，应用程序必须先注册 SMS 通知预订。要预订 SMS 通知，用户需要提供一个移动电话号码并批准通知预订。在收到用户批准时，会向 {{ site.data.keys.mf_server }}发送一个预订请求。从 {{ site.data.keys.mf_console }} 中检索通知时，将通过预配置的 SMS 网关来处理和发送该通知。

要配置网关，请参阅[发送通知](sending-notifications)教程。

## 代理设置
{: #proxy-settings }
可使用代理设置来设置用于将通知发送到 APNS 和 GCM 的可选代理。可以使用 **push.apns.proxy.*** 和 **push.gcm.proxy.*** 配置属性来设置代理。有关更多信息，请参阅 [{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)。

> **注：**WNS 不支持任何代理。

## 后续教程
{: #tutorials-to-follow-next }
对服务器端和客户端进行下列必要设置，以便能够发送和接收推送通知：
