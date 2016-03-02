---
layout: tutorial
title: Push Notifications Overview
show_children: true
relevantTo: [ios,android,cordova]
weight: 1
---
## Overview
IBM MobileFirst Platform Foundation provides a unified set of API methods to send notifications to iOS, Android and Cordova (iOS, Android) applications. Continue reading to learn more on the available push support, such as available notification forms types, how to send notifications to devices and how to handle received notifications in your application.

#### Jump to:
* [What is a Push Notification](#what-is-a-push-notification)
* [Push Notification Types](#push-notification-types)
* [Tutorials to follow next](#tutorials-to-follow-next)

## What is a Push Notification
Push notifications is the ability of a mobile device to receive messages that are "pushed" from a server.  
Notifications are received regardless of whether the application is currently running in the foreground or background.  

### Notifications can take several forms:

* **Alert (iOS, Android)** -  a pop-up text message
* **Badge (iOS)** - a graphical representation that allows a short text or image
* **Banner (iOS)** - a disappearing pop-up text message at the top of the device display
* **Sound (iOS, Android)** - a sound file playing when a notification is received
* **Interactive (iOS 8 and above)** - action buttons inside the banner of a received notification
* **Silent (iOS 8 and above)** - sending notifications without distrubing the user

### Device support
Push notifications are supported for the following platforms in MobileFirst Platform Foundation:

* iOS 8.x, 9.x
* Android 4.x, 5.x, 6.x

## Push Notification Types 

#### Tag notifications
Tag notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.  
Tags represent topics of interest to the user and provide the ability to receive notifications according to the chosen interest.

#### Broadcast notifications
Broadcast notifications are a form of tag push notifications that are targeted to all subscribed devices. Broadcast notifications are enabled by default for any push-enabled MobileFirst application by a subscription to a reserved `Push.all` tag (auto-created for every device). Broadcast notifications can be disabled by unsubscribing from the reserved `Push.all` tag.

#### User Authenticated Notifications
User Authenticated Notifications are notifications secured with OAuth.

> For more information about notifications types, see the topic about push notifications in the user documentation.

## Tutorials to follow next
Follow through the below required setup of the server-side and client-side in order to be able to send and receive push notifications:

* [Sending push notifications](../sending-push-notifications)
* [Handling push notifications in Cordova applications](../handling-push-notifications-in-cordova)
* [Handling push notifications in iOS applications](../handling-push-notifications-in-ios)
* [Handling push notifications in Android applications](../handling-push-notifications-in-android)
