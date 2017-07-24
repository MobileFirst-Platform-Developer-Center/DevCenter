---
layout: tutorial
title: 交互式通知
relevantTo: [ios, cordova]
show_in_nav: false
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
通过使用交互式通知，在通知到达时，用户可以在不打开应用程序的情况下执行相应操作。在交互式通知到达时，设备会显示操作按钮以及通知消息。

在装有 iOS V8 及更高版本的设备上支持交互式通知。如果将交互式通知发送到装有 iOS V8 之前版本的 iOS 设备，那么将不会显示通知操作。

## 发送交互式推送通知
{: #sending-interactive-push-notification }
准备通知并发送通知。有关更多信息，请参阅[发送推送通知](../../sending-notifications)。

在 **{{ site.data.keys.mf_console }} → [您的应用程序] → 推送 → 发送通知 → iOS 定制设置**下，可对通知对象设置一个字符串来指示通知类别。根据该类别值，将显示相应的通知操作按钮。例如：

![在 {{ site.data.keys.mf_console }} 中设置 iOS 交互式通知的类别](categories-for-interactive-notifications.png)

## 在 Cordova 应用程序中处理交互式推送通知
{: #handling-interactive-push-notifications-in-cordova-applications }
要接收交互式通知，请执行以下步骤：

1. 在主 JavaScript 中，为交互式通知定义已注册的类别，然后将其传递到设备注册调用 `MFPPush.registerDevice`。

   ```javascript
   var options = {
        ios: {
            alert: true,
            badge: true,
            sound: true,     
            categories: [{
                //Category identifier, this is used while sending the notification.
                id : "poll", 

                //Optional array of actions to show the action buttons along with the message.    
                actions: [{
                    //Action identifier
                    id: "poll_ok", 

                    //Action title to be displayed as part of the notification button.
                    title: "OK", 

                    //Optional mode to run the action in foreground or background. 1-foreground. 0-background. Default is foreground.
                    mode: 1,  

                    //Optional property to mark the action button in red color. Default is false.
                    destructive: false,

                    //Optional property to set if authentication is required or not before running the action.(Screen lock).
                    //For foreground, this property is always true.
                    authenticationRequired: true
                },
                {
                    id: "poll_nok",
                    title: "NOK",
                    mode: 1,
                    destructive: false,
                    authenticationRequired: true
                }],
                    
                //Optional list of actions that is needed to show in the case alert. 
                //If it is not specified, then the first four actions will be shown.
                defaultContextActions: ['poll_ok','poll_nok'],

                //Optional list of actions that is needed to show in the notification center, lock screen. 
                //If it is not specified, then the first two actions will be shown.
                minimalContextActions: ['poll_ok','poll_nok'] 
            }]     
        }
   }
   ```

2. 在向推送通知服务注册设备时，传递 `options` 对象。

   ```javascript
   MFPPush.registerDevice(options, function(successResponse) {
  		navigator.notification.alert("Successfully registered");
  		enableButtons();
   });  
   ```

## 在本机 iOS 应用程序中处理交互式推送通知
{: #handling-interactive-push-notifications-in-native-ios-applications }
请执行以下步骤以接收交互式通知：

1. 为应用程序启用在后台接收远程通知的功能。如果某些操作支持在后台执行，那么需要执行此步骤。
2. 为交互式通知定义已注册的类别，然后将其作为 options 对象传递到 `MFPPush.registerDevice`。

   ```swift
   //define categories for Interactive Push
   let acceptAction = UIMutableUserNotificationAction()
   acceptAction.identifier = "OK"
   acceptAction.title = "OK"
   acceptAction.activationMode = .Foreground

   let rejetAction = UIMutableUserNotificationAction()
   rejetAction.identifier = "Cancel"
   rejetAction.title = "Cancel"
   rejetAction.activationMode = .Foreground

   let category = UIMutableUserNotificationCategory()
   category.identifier = "poll"
   category.setActions([acceptAction, rejetAction], forContext: .Default)

   let categories:Set<UIUserNotificationCategory> = [category]

   let options = ["alert":true, "badge":true, "sound":true, "categories": categories]

   // Register device
    MFPPush.sharedInstance().registerDevice(options as [NSObject : AnyObject], completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
```
