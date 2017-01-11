---
layout: tutorial
title: Notifications
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Notifications is the ability of a mobile device to receive messages that are "pushed" from a server.  
Notifications are received regardless of whether the application is currently running in the foreground or background.  

{{ site.data.keys.product_full }} provides a unified set of API methods to send either push or SMS notifications to iOS, Android, Windows 8.1 Universal, Windows 10 UWP and Cordova (iOS, Android) applications. The notifications are sent from the {{ site.data.keys.mf_server }} to the vendor (Apple, Google, Microsoft, SMS Gateways) infrastructure, and from there to the relevant devices. The unified notification mechanism makes the entire process of communicating with the users and devices completely transparent to the developer.

#### Device support
{: #device-support }
Push and SMS notifications are supported for the following platforms in {{ site.data.keys.product }}:

* iOS 8.x and above
* Android 4.x and above
* Windows 8.1, Windows 10

#### Jump to:
{: #jump-to }
* [Push notifications](#push-notifications)
* [SMS notifications](#sms-notifications)
* [Proxy settings](#proxy-settings)
* [Tutorials to follow next](#tutorials-to-follow-next)

## Push notifications
{: #push-notifications }
Notifications can take several forms:

* **Alert (iOS, Android, Windows)** -  a pop-up text message
* **Sound (iOS, Android, Windows)** - a sound file playing when a notification is received
* **Badge (iOS), Tile (Windows)** - a graphical representation that allows a short text or image
* **Banner (iOS), Toast (Windows)** - a disappearing pop-up text message at the top of the device display
* **Interactive (iOS 8 and above)** - action buttons inside the banner of a received notification
* **Silent (iOS 8 and above)** - sending notifications without distrubing the user

### Push notification types 
{: #push-notification-types }
#### Tag notifications
{: #tag-notifications }
Tag notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.  

Tags-based notifications allow segmentation of notifications based on subject areas or topics. Notification recipients can choose to receive notifications only if it is about a subject or topic that is of interest. Therefore, tags-based notification provides a means to segment recipients. This feature enables you to define tags and send or receive messages by tags. A message is targeted to only the devices that are subscribed to a tag.

#### Broadcast notifications
{: #broadcast-notifications }
Broadcast notifications are a form of tag push notifications that are targeted to all subscribed devices, and are enabled by default for any push-enabled {{ site.data.keys.product_adj }} application by a subscription to a reserved `Push.all` tag (auto-created for every device). Broadcast notifications can be disabled by unsubscribing from the reserved `Push.all` tag.

#### Unicast notifications
{:# unicast-notifications }
Unicast notifications, or User Authenticated Notifications that are secured with OAuth. These are notification messages target a particular device or a userID(s). The userID in the user subscription can come from the underlying security context.

#### Interactive notifications
{: #interactive-notifications }
With interactive notification, when a notification arrives, users can take actions without opening the application. When an interactive notification arrives, the device shows action buttons along with the notification message. Currently, interactive notifications are supported on devices with iOS version 8 onwards. If an interactive notification is sent to an iOS device with version earlier than 8, the notification actions are not displayed.

> Learn how to handle [interactive notifications](handling-push-notifications/interactive).

#### Silent notifications
{: #silent-notifications }
Silent notifications are notifications that do not display alerts or otherwise disturb the user. When a silent notification arrives, the application handing code runs in background without bringing the application to foreground. Currently, the silent notifications are supported on iOS devices with version 7 onwards. If the silent notification is sent to iOS devices with version lesser than 7, the notification is ignored if the application is running in background. If the application is running in the foreground, then the notification callback method is invoked.

> Learn how to handle [silent notifications](handling-push-notifications/silent).

**Note:** Unicast notifications do not contain any tag in the payload. The notification message can target multiple devices or users by specifying multiple deviceIDs or userIDs respectively, in the target block of the POST message API.

## SMS Notifications
{: #sms-notifications }
To start receiving SMS notifications, an application must first register to an SMS notification subscription. To subscribe to SMS notifications, the user supplies a mobile phone number and approves the notification subscription. A subscription request is sent to the {{ site.data.keys.mf_server }} upon receipt of the user approval. When a notification is retrieved from the {{ site.data.keys.mf_console }}, it is processed and sent through a preconfigured SMS gateway.

To configure a gateway, see the [Sending Notifications](sending-notifications) tutorial.

## Proxy settings
{: #proxy-settings }
Use the proxy settings to set the optional proxy through which notifications are sent to APNS and GCM. You can set the proxy by using the **push.apns.proxy.*** and **push.gcm.proxy.*** configuration properties. For more information, see [List of JNDI properties for {{ site.data.keys.mf_server }} push service](../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

> **Note:** WNS does not have proxy support.

## Tutorials to follow next
{: #tutorials-to-follow-next }
Follow through the below required setup of the server-side and client-side in order to be able to send and receive push notifications:
