---
layout: tutorial
title: 静默通知
relevantTo: [ios,cordova]
show_in_nav: false
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
静默通知是既不显示警报也不打扰用户的通知。 当静默通知到达时，应用程序处理代码将在后台运行，而不是将应用程序转到前台。 目前，在装有 iOS V7 及更高版本的设备上支持静默通知。 如果将静默通知发送到装有 iOS V7 之前版本的设备，那么当应用程序在后台运行时，将忽略该通知。 如果应用程序在前台运行，那么将调用通知回调方法。

## 发送静默推送通知
{: #sending-silent-push-notifications }
准备通知并发送通知。 有关更多信息，请参阅[发送推送通知](../../sending-notifications)。

iOS 支持的三类通知分别由常量 `DEFAULT`、`SILENT` 和 `MIXED` 表示。 如果未显式指定类型，那么将使用 `DEFAULT` 类型。

对于 `MIXED` 类型的通知，在设备上显示消息的同时，在后台会唤醒应用程序并让其处理静默通知。 `MIXED` 类型通知的回调方法会调用两次：一次是在静默通知到达设备时，另一次是在通过点击通知来打开应用程序时。

根据具体的需求，在 **{{ site.data.keys.mf_console }} → [您的应用程序] → 推送 → 发送通知 → iOS 定制设置**下选择相应的类型。 

> **注：**如果通知为 silent，那么将忽略**警报**、**声音**和**角标**属性。

![在 {{ site.data.keys.mf_console }} 中为 iOS 静默通知设置通知类型](notification-type-for-silent-notifications.png)

## 在 Cordova 应用程序中处理静默推送通知
{: #handling-silent-push-notifications-in-cordova-applications }
在 JavaScript 推送通知回调方法中，必须执行以下步骤：

1. 检查通知类型。 例如：

   ```javascript
   if(props['content-available'] == 1) {
        //Silent Notification or Mixed Notification. Perform non-GUI tasks here.
   } else {
        //Normal notification
   }
   ```

2. 如果通知为 silent 或 mixed，那么在完成后台作业后，将调用 `WL.Client.Push.backgroundJobDone` API。

## 在本机 iOS 应用程序中处理静默推送通知
{: #handling-silent-push-notifications-in-native-ios-applications }
必须执行以下步骤以接收静默通知：

1. 为应用程序启用在后台接收远程通知的功能。
2. 通过检查 `content-available` 键是否设置为 **1**，以检查通知是否为 silent。
3. 在处理完通知后，必须在 handler 参数中立即调用该块，否则将终止您的应用程序。 您的应用程序最多有 30 秒时间来处理通知并调用指定的完成处理程序块。
