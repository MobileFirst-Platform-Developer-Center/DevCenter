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
* **Interactive (iOS 8 and above)** - action buttons inside the banner of a received notification
* **Silent (iOS 7 and above)** - sending notifications without distrubing the user

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

> For more information about unicast notifications, see the topic about sending push notifications, in the user documentation.

## Setting up support for Push Notifications
- how to configure the server with p12 certificate for iOS, otpional certificate for Windows and GCM credentials for Android

===
The handling in client side tutorials should show:
- how to edit the xcode project podfile with push
- how to edit andrid studio project builde.gralde with Push
- how to edit windows project nuget file with Push
- how to intercept and display notifications in the client

=== 
the overview tutorial should show:
- how to setup authenticated push; prerequisite should be the security tutorial to understand the foundation of the new security model

===
