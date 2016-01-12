---
layout: tutorial
title: Push Notifications Overview
show_children: true
relevantTo: [ios,android,windowsphone8,windows8,cordova]
weight: 1
---
should talk about the 
1. push service
2. obtaining tokenn
3. push flow

## Overview

IBM MobileFirst Platform Foundation provides a unified set of API methods to send notifications to devices on which MobileFirst applications are installed. Notification can be sent based on tags.

### Agenda

* [What is Push Notification?](#what-is-push-notification)
* [Push Notification Types](#push-notification-types)
* [REST API for Push Notifications](#rest-api-for-push-notifications)
* [Supported Environments](#supported-environments)

![ios-tag-sample](push-notifications-overview-pics/ios-tag-sample.png)

###What is Push Notification?

Push notifications is the ability of a mobile device to receive messages that are "pushed" from a server.

Notifications are received regardless of whether the application is currently running.
Notifications can take several forms:

* **Alert (all)** -  a pop-up text message
* **Badge (iOS), Tile (W8, WP8)** - a graphical representation that allows a short text or image
* **Banner (iOS), Toast (W8, WP8)** - a disappearing pop-up text message at the top of the device display
* **Sound (all)** - a sound file playing when a notification is received
* **Interactive (iOS 8)** - action buttons inside the banner of a received notification


**Device support**
Push notifications are supported for the following mobile platforms:

* Android 2.3.5, 4.x, 5.x, 6.x
* iOS 6, 7, 8 and 9
* Windows Phone 8.x
* Windows 8

###Push Notification Types
**Tag notifications**

Tag push notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.

**Broadcast notifications**

Broadcast push notifications are a form of tag push notifications that are targeted to all subscribed devices.

**Unicast notifications**

Unicast notifications are targeted to a particular device or a ```userID```. Unicast notifications do not require any additional setup and are enabled by default when the MobileFirst application is enabled for push notifications.

>For more information about unicast notifications, see the topic about sending push notifications, in the user documentation.

**Interactive notifications**

Interactive push notifications enables action buttons to be added for received notifications. (*iOS 8 and above only*)

**Silent notifications**

Silent push notifications enables notifications to be sent without disturbing the user. (*iOS 7 and above only*)

###REST API for Push Notifications

MobileFirst Platform Foundation exposes a REST API endpoint that can be accessed by non-mobile clients. It is another way to use the push service without needing to develop and deploy MobileFirst adapters.

>For more information about the REST API for push notification, see the topic about REST API Runtime Services, in the user documentation.

###Supported environments
