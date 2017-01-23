---
layout: tutorial
title: 在 iOS 中处理推送通知
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: 下载 Xcode 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以使用 {{ site.data.keys.product_adj }} 提供的通知 API 来注册和注销设备以及预订和取消预订标记。在本教程中，您将学会如何在使用 Swift 的 iOS 应用程序中处理推送通知。

有关静默通知或交互式通知的信息，请参阅：

* [静默通知](../silent)
* [交互式通知](../interactive)

**先决条件：**

* 确保您已阅读过下列教程：
	* [推送通知概述](../../)
    * [设置 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/#installing-a-development-environment)
    * [将 {{ site.data.keys.product }} SDK 添加到 iOS 应用程序](../../../application-development/sdk/ios)
* 本地运行的 {{ site.data.keys.mf_server }} 或远程运行的 {{ site.data.keys.mf_server }}。
* 安装在开发人员工作站上的 {{ site.data.keys.mf_cli }}


### 跳转至：
{: #jump-to }
* [通知配置](#notifications-configuration)
* [通知 API](#notifications-api)
* [处理推送通知](#handling-a-push-notification)


### 通知配置
{: #notifications-configuration }
创建新的 Xcode 项目或使用现有项目。
如果该项目中还没有 {{ site.data.keys.product_adj }} 本机 iOS SDK，请遵循[将 {{ site.data.keys.product }} SDK 添加到 iOS 应用程序](../../../application-development/sdk/ios)教程中的指示信息。


### 添加推送 SDK
{: #adding-the-push-sdk }
1. 打开该项目的现有 **podfile**，然后添加以下行：

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - 将 **Xcode-project-target** 替换为您的 Xcode 项目目标的名称。

2. 保存并关闭该 **podfile**。
3. 从**命令行**窗口中，浏览至该项目的根文件夹。
4. 运行 `pod install` 命令。
5. 通过 **.xcworkspace** 文件打开项目。

## 通知 API
{: #notifications-api }
### MFPPush 实例
{: #mfppush-instance }
必须在 `MFPPush` 实例上发出所有 API 调用。要实现这一点，可在视图控制器中创建一个 `var`（例如，`var push = MFPPush.sharedInstance();`），然后在视图控制器中调用 `push.methodName()`。

也可以针对要访问推送 API 方法的每个实例都调用 `MFPPush.sharedInstance().methodName()`。

### 验证问题处理程序
{: #challenge-handlers }
如果 `push.mobileclient` 作用域映射到**安全性检查**，那么需要确保在使用任何推送 API 之前，存在已注册的匹配**验证问题处理程序**。

> 在[凭证验证](../../../authentication-and-security/credentials-validation/ios)教程中了解有关验证问题处理程序的更多信息。
### 客户端
{: #client-side }
| Swift 方法                                                                                                | 描述                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize()`](#initialization)                                                                            | 针对提供的上下文，初始化 MFPPush。                               |
| [`isPushSupported()`](#is-push-supported)                                                                    | 设备是否支持推送通知。                             |
| [`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token)                  | 向推送通知服务注册设备。               |
| [`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token)                                                | 将设备标记发送到服务器。                                    |
| [`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags)                                | 在推送通知服务实例中检索可用的标记。 |
| [`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe)     | 使设备预订指定的标记。                          |
| [`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)              | 检索设备当前预订的所有标记。               |
| [`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) | 取消对特定标记的预订。                                  |
| [`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister)                     | 从推送通知服务注销设备。              |

#### 初始化
{: #initialization }
客户机应用程序连接到 MFPPush 服务时，需要执行初始化。

* 应先调用 `initialize` 方法，然后再使用任何其他 MFPPush API。
* 它会注册回调函数以处理已收到的推送通知。

```swift
MFPPush.sharedInstance().initialize();
```

#### 是否支持推送
{: #is-push-supported }
检查设备是否支持推送通知。

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 注册设备并发送设备标记
{: #register-device--send-device-token }
向推送通知服务注册设备。

```swift
MFPPush.sharedInstance().registerDevice({(options, response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Successfully registered
    } else {
        // Registration failed with error
    }
})
```

`options` 是 `[NSObject : AnyObject]`，这是一个可选参数，用于指定随注册请求（向服务器发送设备标记以使用唯一标识注册设备）一起传递的选项字典。

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **注：**通常在 `didRegisterForRemoteNotificationsWithDeviceToken` 方法的 **AppDelegate** 中调用此项。

#### 获取标记
{: #get-tags }
从推送通知服务检索所有可用标记。

```swift
MFPPush.sharedInstance().getTags({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response.responseText)")
        if response.availableTags().isEmpty == true {
            // Successfully retrieved tags as list of strings
        } else {
            // Successfully retrieved response from server but there where no available tags
        }
    } else {
// Failed to receive tags with error
    }
})
```


#### 预订
{: #subscribe }
预订所需的标记。

```swift
var tagsArray: [AnyObject] = ["Tag 1" as AnyObject, "Tag 2" as AnyObject]

MFPPush.sharedInstance().subscribe(self.tagsArray, completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Subscribed successfully
    } else {
        // Failed to subscribe with error
    }
})
```


#### 获取预订
{: #get-subscriptions }
检索设备当前预订的标记。

```swift
MFPPush.sharedInstance().getSubscriptions({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Successfully received subscriptions as list of strings
    } else {
        // Failed to retrieve subscriptions with error
    }
})
```


#### 取消预订
{: #unsubscribe }
取消对标记的预订。

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Unsubscribe from tags
MFPPush.sharedInstance().unsubscribe(tags, completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Unsubscribed successfully
    } else {
        // Failed to unsubscribe
    }
})
```

#### 注销
{: #unregister }
从推送通知服务实例注销设备。

```swift
MFPPush.sharedInstance().unregisterDevice({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Unregistered successfully
    } else {
        self.showAlert("Error \(error.description)")
        // Failed to unregister with error
    }
})
```

## 处理推送通知
{: #handling-a-push-notification }

由本机 iOS 框架直接处理推送通知。根据您的应用程序生命周期，iOS 框架将调用不同的方法。

例如，如果在运行应用程序时收到简单通知，那么将触发 **AppDelegate** 的 `didReceiveRemoteNotification`：

```swift
func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")

    // display the alert body
    if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
            showAlert(body)
    }
}
```

> 从以下 Apple 文档中了解有关在 iOS 中处理通知的更多信息：http://bit.ly/1ESSGdQ

<img alt="样本应用程序图像" src="notifications-app.png" style="float:right"/>

## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80) Xcode 项目。

### 用法样例
{: #sample-usage }
请查看样本的 README.md 文件以获取指示信息。
