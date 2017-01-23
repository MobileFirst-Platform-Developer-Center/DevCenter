---
layout: tutorial
title: 在 Windows 8.1 Universal 和 Windows 10 UWP 中处理推送通知
breadcrumb_title: Windows
relevantTo: [windows]
weight: 7
downloads:
  - name: 下载 Windows 8.1 Universal 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80
  - name: 下载 Windows 10 UWP 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin10/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以使用 {{ site.data.keys.product_adj }} 提供的通知 API 来注册和注销设备以及预订和取消预订标记。在本教程中，您将学会如何在使用 C# 的本机 Windows 8.1 Universal 和 Windows 10 UWP 应用程序中处理推送通知。

**先决条件：**

* 确保您已阅读过下列教程：
	* [推送通知概述](../../)
    * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
    * [将 {{ site.data.keys.product_adj }} SDK 添加到 Windows 应用程序](../../../application-development/sdk/windows-8-10)
* 本地运行的 {{ site.data.keys.mf_server }} 或远程运行的 {{ site.data.keys.mf_server }}。
* 安装在开发人员工作站上的 {{ site.data.keys.mf_cli }}

#### 跳转至：
{: #jump-to }
* [通知配置](#notifications-configuration)
* [通知 API](#notifications-api)
* [处理推送通知](#handling-a-push-notification)

## 通知配置
{: #notifications-configuration }
创建新的 Visual Studio 项目或使用现有项目。  
如果该项目中还没有 {{ site.data.keys.product_adj }} 本机 Windows SDK，请遵循[将 {{ site.data.keys.product_adj }} SDK 添加到 Windows 应用程序](../../../application-development/sdk/windows-8-10)教程中的指示信息。

### 添加推送 SDK
{: #adding-the-push-sdk }
1. 选择“工具 → NuGet Package Manager → Package Manager Console”。
2. 选择要安装 {{ site.data.keys.product_adj }} 推送组件的项目。
3. 运行 **Install-Package IBM.MobileFirstPlatformFoundationPush** 命令来添加 {{ site.data.keys.product_adj }} 推送 SDK。

## 必备的 WNS 配置
{: pre-requisite-wns-configuration }
1. 确保应用程序具备 Toast 通知功能。可在 Package.appxmanifest 中启用此功能。
2. 确保使用向 WNS 注册的值来更新 `Package Identity Name` 和 `Publisher`。
3. （可选）删除 TemporaryKey.pfx 文件。

## 通知 API
{: #notifications-api }
### MFPPush 实例
{: #mfppush-instance }
必须在 `MFPPush` 实例上发出所有 API 调用。要实现这一点，可创建一个变量（例如，`private MFPPush PushClient = MFPPush.GetInstance();`），然后在该类中调用 `PushClient.methodName()`。

也可以针对要访问推送 API 方法的每个实例都调用 `MFPPush.GetInstance().methodName()`。

### 验证问题处理程序
{: #challenge-handlers }
如果 `push.mobileclient` 作用域映射到**安全性检查**，那么需要确保在使用任何推送 API 之前，存在已注册的匹配**验证问题处理程序**。

> 在[凭证验证](../../../authentication-and-security/credentials-validation/ios)教程中了解有关验证问题处理程序的更多信息。
### 客户端
{: #client-side }
| C Sharp 方法                                                                                                | 描述                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`Initialize()`](#initialization)                                                                            | 针对提供的上下文，初始化 MFPPush。                               |
| [`IsPushSupported()`](#is-push-supported)                                                                    | 设备是否支持推送通知。                             |
| [`RegisterDevice(JObject options)`](#register-device--send-device-token)                  | 向推送通知服务注册设备。               |
| [`GetTags()`](#get-tags)                                | 在推送通知服务实例中检索可用的标记。 |
| [`Subscribe(String[] Tags)`](#subscribe)     | 使设备预订指定的标记。                          |
| [`GetSubscriptions()`](#get-subscriptions)              | 检索设备当前预订的所有标记。               |
| [`Unsubscribe(String[] Tags)`](#unsubscribe) | 取消对特定标记的预订。                                  |
| [`UnregisterDevice()`](#unregister)                     | 从推送通知服务注销设备。              |

#### 初始化
{: #initialization }
客户机应用程序连接到 MFPPush 服务时，需要执行初始化。

* 应先调用 `Initialize` 方法，然后再使用任何其他 MFPPush API。
* 它会注册回调函数以处理已收到的推送通知。

```csharp
MFPPush.GetInstance().Initialize();
```

#### 是否支持推送
{: #is-push-supported }
检查设备是否支持推送通知。

```csharp
Boolean isSupported = MFPPush.GetInstance().IsPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 注册设备并发送设备标记
{: #register-device--send-device-token }
向推送通知服务注册设备。

```csharp
JObject Options = new JObject();
MFPPushMessageResponse Response = await MFPPush.GetInstance().RegisterDevice(Options);         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

#### 获取标记
{: #get-tags }
从推送通知服务检索所有可用标记。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetTags();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
} else{
    Message = new MessageDialog("Failed to get Tags list");
}
```

#### 预订
{: #subscribe }
预订所需的标记。

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Get subscription tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Subscribe(Tags);
if (Response.Success == true)
{
    //successfully subscribed to push tag
}
else
{
    //failed to subscribe to push tags
}
```

#### 获取预订
{: #get-subscriptions }
检索设备当前预订的标记。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetSubscriptions();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
}
else
{
    Message = new MessageDialog("Failed to get subcription list...");
}
```

#### 取消预订
{: #unsubscribe }
取消对标记的预订。

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// unsubscribe tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Unsubscribe(Tags);
if (Response.Success == true)
{
    //succes
}
else
{
    //failed to subscribe to tags
}
```

#### 注销
{: #unregister }
从推送通知服务实例注销设备。

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().UnregisterDevice();         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

## 处理推送通知
{: #handling-a-push-notification }
要处理推送通知，需要设置 `MFPPushNotificationListener`。可实现以下方法来执行此操作。

1. 使用 MFPPushNotificationListener 类型的接口创建类

   ```csharp
   internal class NotificationListner : MFPPushNotificationListener
   {
        public async void onReceive(String properties, String payload)
   {
        // Handle push notification here      
   }
   }
   ```

2. 通过调用 `MFPPush.GetInstance().listen(new NotificationListner())` 将该类设置为侦听器
3. 在 onReceive 方法中，您将收到推送通知，并可以处理关于期望行为的通知。


<img alt="样本应用程序图像" src="sample-app.png" style="float:right"/>

## Windows Universal 推送通知服务
{: #windows-universal-push-notifications-service }
无需在服务器配置中打开特定端口。

WNS 使用普通的 http 或 https 请求。


## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) Windows 8.1 Universal 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) Windows10 UWP 项目。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。
