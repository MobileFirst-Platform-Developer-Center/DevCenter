---
layout: tutorial
title: Push Notifications Overview
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 1
---
## Overview
IBM MobileFirst Platform Foundation provides a unified set of API methods to send notifications to Native iOS, Android, Windows 8 Universal, Windows 10 UWP and Cordova (iOS, Android) applications.

This tutorial provides an introduction to push notifications and the supported notifications types, required setup steps to ready the MobileFirst Server to be able to send notificaitons, and the steps to setup Native and Cordova applications with support for push notifications, as well as delving into supported scenarios such as sending notifications to applications with and without authentication.

### Agenda
* [What is Push Notification?](#what-is-push-notification)
* [Push Notification Types](#push-notification-types)
* [Setting up support for Push Notifications](#setting-up-support-for-push-notifications)

### What is Push Notification?
Push notifications is the ability of a mobile device to receive messages that are "pushed" from a server.

Notifications are received regardless of whether the application is currently running.  
Notifications can take several forms:

* **Alert (all)** -  a pop-up text message
* **Badge (iOS), Tile (Windows 8.1 Universal, Windows 10 UWP)** - a graphical representation that allows a short text or image
* **Banner (iOS), Toast (Windows 8.1 Universal, Windows 10 UWP)** - a disappearing pop-up text message at the top of the device display
* **Sound (all)** - a sound file playing when a notification is received
* **Interactive (iOS 9)** - action buttons inside the banner of a received notification

**Device support**  
Push notifications are supported for the following mobile platforms:

* Android 2.3.5, 4.x, 5.x, 6.x
* iOS 6, 7, 8 and 9
* Windows 8.1 Universal
* Windows 10 UWP

### Push Notification Types

#### Tag notifications
Tag push notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.

#### Broadcast notifications
Broadcast push notifications are a form of tag push notifications that are targeted to all subscribed devices.

#### User Authenticated Notifications
User Authenticated Notifications are notifications secured with OAuth.

Unicast notifications are targeted to a particular device or a `userID`. Unicast notifications do not require any additional setup and are enabled by default when the MobileFirst application is enabled for push notifications.

> For more information about unicast notifications, see the topic about sending push notifications, in the user documentation.

#### Interactive notifications
Interactive push notifications enables action buttons to be added for received notifications. (*iOS 8 and above only*)

#### Silent notifications
Silent push notifications enables notifications to be sent without disturbing the user. (*iOS 7 and above only*)

#### REST API for Push Notifications
MobileFirst Platform Foundation exposes a REST API endpoint that can be accessed by non-mobile clients. It is another way to use the push service without needing to develop and deploy MobileFirst adapters.

> For more information about the REST API for push notification, see the topic about REST API Runtime Services, in the user documentation.

## Setting up support for Push Notifications

- need to write here how to setup the server (if needed at all)
- how to edit the xcode project podfile with push
- how to edit andrid studio project builde.gralde with Push
- how to edit windows project nuget file with Push
- (idan will take care of tutorial UI for this)
- how to setup push on the server for ios/android/windows
- need to consider perhaps to put all the setup into a seperate tutorial as it looks like it'll be a lot of text
- need to think together with nathan about how/where to explain the security aspect of push Notifications
