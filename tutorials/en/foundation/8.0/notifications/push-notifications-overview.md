---
layout: tutorial
title: Push Notifications Overview
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 1
---
## Overview
IBM MobileFirst Platform Foundation provides a unified set of API methods to send notifications to iOS, Android, Windows 8 Universal, Windows 10 UWP and Cordova (iOS, Android) applications.

This tutorial provides an introduction to push notifications and the supported notifications types, required setup steps to ready the MobileFirst Server to be able to send notificaitons, and the setup steps to ready Native and Cordova applications with support for push notifications, as well as delving into supported scenarios such as sending notifications to applications with and without authentication and available notification types.

**Prerequisites:** 

* MobileFirst Server to run locally, or a remotely running MobileFirst Server.

#### Jump to:
* [What is Push Notification?](#what-is-push-notification)
* [Push Notification Types](#push-notification-types)
* [Setting up support for Push Notifications](#setting-up-support-for-push-notifications)

### What is Push Notification?
Push notifications is the ability of a mobile device to receive messages that are "pushed" from a server.  
Notifications are received regardless of whether the application is currently running in the foreground or background.  

### Notifications can take several forms:

* **Alert (all)** -  a pop-up text message
* **Badge (iOS), Tile (Windows 8.1 Universal, Windows 10 UWP)** - a graphical representation that allows a short text or image
* **Banner (iOS), Toast (Windows 8.1 Universal, Windows 10 UWP)** - a disappearing pop-up text message at the top of the device display
* **Sound (all)** - a sound file playing when a notification is received
* **Interactive (iOS 8 and above)** - action buttons inside the banner of a received notification
* **Silent (iOS 7 and above)** - sending notifications without distrubing the user

### Device support
Push notifications are supported for the following mobile platforms:

* Android 2.3.5, 4.x, 5.x, 6.x
* iOS 6, 7, 8 and 9
* Windows 8.1 Universal
* Windows 10 UWP

### Push Notification Types 

#### Tag notifications
Tag notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.  
Tags represent topics of interest to the user and provide the ability to receive notifications according to the chosen interest.

#### Broadcast notifications
Broadcast notifications are a form of tag push notifications that are targeted to all subscribed devices. Broadcast notifications are enabled by default for any push-enabled MobileFirst application by a subscription to a reserved `Push.all` tag (auto-created for every device). Broadcast notifications can be disabled by unsubscribing from the reserved `Push.all` tag.

#### User Authenticated Notifications
User Authenticated Notifications are notifications secured with OAuth.

> For more information about notifications types, see the topic about push notifications in the user documentation.

## Setting up support for Push Notifications
<span style="color:red">Provide the steps to ready the server with push notifications support for iOS and Android (Windows is post-beta(?)).

This section assumes you have an application registered in the server, and should explain how to add a certificate for iOS (as well mention what are the available certificate types) and where to get it from, how to create GCM credentials and how to add them.</span>

=== 
this overview tutorial should explain:
- how to setup authenticated push; 
- prerequisite should be the security tutorial to understand the foundation of the new security model
- maybe this should not be in this overview tutorial... maybe another set of tutorials limited to security in push?

===
The handling in client side tutorials should explain:
- how to setup push notifications support in iOS Xcode project (editing the podfile?)
- how to setup push notifications support in Andrid Studio project (editing the builde.gradle file?)
- how to setup push notifications support in Cordova applications
- how to intercept and display notifications in the client

=== 
The sending push notifications tutorials should explain:
- the Push REST API
- the send push console tab 
- and any server-side push API that can be used in adapters