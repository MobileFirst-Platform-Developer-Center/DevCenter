---
layout: tutorial
title: Notifications
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 7
print_pdf: true
---
## Overview
Notifications is the ability of a mobile device to receive messages that are "pushed" from a server.  
Notifications are received regardless of whether the application is currently running in the foreground or background.  

IBM MobileFirst Foundation provides a unified set of API methods to send either push or SMS notifications to iOS, Android, Windows 8.1 Universal, Windows 10 UWP and Cordova (iOS, Android) applications. The notifications are sent from the MobileFirst Server to the vendor (Apple, Google, Microsoft, SMS Gateways) infrastructure, and from there to the relevant devices. The unified notification mechanism makes the entire process of communicating with the users and devices completely transparent to the developer.

Continue reading to learn more on the available push and SMS notification support, such as available notification forms types, how to send notifications to devices and how to handle received notifications in your application.

#### Jump to:

* [Push Notifications Types](#push-notifications-types)
* [SMS Notifications](#sms-notifications)
* [Tutorials to follow next](#tutorials-to-follow-next)

## Push Notifications types
Notifications can take several forms:

* **Alert (iOS, Android, Windows)** -  a pop-up text message
* **Sound (iOS, Android, Windows)** - a sound file playing when a notification is received
* **Badge (iOS), Tile (Windows)** - a graphical representation that allows a short text or image
* **Banner (iOS), Toast (Windows)** - a disappearing pop-up text message at the top of the device display
* **Interactive (iOS 8 and above)** - action buttons inside the banner of a received notification
* **Silent (iOS 8 and above)** - sending notifications without distrubing the user

### Device support
Push and SMS notifications are supported for the following platforms in MobileFirst Foundation:

* iOS 8.x, 9.x
* Android 4.x, 5.x, 6.x
* Windows 8.1, Windows 10

## Push Notification Types 

#### Tag notifications
Tag notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.  

Tags-based notifications allow segmentation of notifications based on subject areas or topics. Notification recipients can choose to receive notifications only if it is about a subject or topic that is of interest. Therefore, tags-based notification provides a means to segment recipients. This feature enables you to define tags and send or receive messages by tags. A message is targeted to only the devices that are subscribed to a tag.

#### Broadcast notifications
Broadcast notifications are a form of tag push notifications that are targeted to all subscribed devices, and are enabled by default for any push-enabled MobileFirst application by a subscription to a reserved `Push.all` tag (auto-created for every device). Broadcast notifications can be disabled by unsubscribing from the reserved `Push.all` tag.

#### Unicast Notifications
Unicast notifications, or User Authenticated Notifications that are secured with OAuth. These are notification messages target a particular device or a userID(s). The userID in the user subscription can come from the underlying security context.

**Note:** Unicast notifications do not contain any tag in the payload. The notification message can target multiple devices or users by specifying multiple deviceIDs or userIDs respectively, in the target block of the POST message API.

## SMS Notifications
To start receiving SMS notifications, an application must first register to an SMS notification subscription. To subscribe to SMS notifications, the user supplies a mobile phone number and approves the notification subscription. A subscription request is sent to the MobileFirst Server upon receipt of the user approval. When a notification is retrieved from the MobileFirst Operations Console, it is processed and sent through a preconfigured SMS gateway.

To configure a gateway, see the [Sending Notifications](sending-notifications) tutorial.

## Tutorials to follow next
Follow through the below required setup of the server-side and client-side in order to be able to send and receive push notifications:
