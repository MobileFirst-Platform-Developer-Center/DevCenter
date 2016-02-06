---
layout: tutorial
title: Handling Push Notifications in Windows 8
relevantTo: [windows8]
weight: 6
---
In this tutorial, you will be learning how to handle push notification for Windows 8 applications.

Tag notifications are notification messages that are targeted to all the devices that are subscribed to a particular tag.
Tags represent topics of interest to the user and provide the ability to receive notifications according to the chosen interest.

Broadcast notifications are a form of tag push notifications that are targeted to all subscribed devices. Broadcast notifications are enabled by default for any push-enabled MobileFirst application by a subscription to a reserved `Push.all` tag (auto-created for every device). This ability can be disabled by by unsubscribing from the reserved `Push.all` tag.
### Agenda
* [Notifications configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)
* [Handling a secure push notification](#handling-a-secure-push-notification)

### Notifications Configuration

### Notifications API

#### API methods for tag notifications
##### Client-side API
* `WLPush.subscribeTag(tagName,options)` - Subscribes the device to the specified tag name.
* `WLPush.unsubscribeTag(tagName,options)` - Unsubscribes the device from the specified tag name.
* `WLPush.isTagSubscribed(tagName)` - Returns whether the device is subscribed to a specified tag name.

#### API methods for tag and broadcast notifications
##### Client-side API

* `WLNotificationListener` - Defines the callback method to be notified when the notification arrives.
`client.getPush().setWLNotificationListener(listener)
`
* The `onMessage(props,payload)` method of WLNotificationListener is called when a push notification is received by the device.
⋅⋅* *props* – A JSON block that contains the notification properties of the platform.
⋅⋅* *payload* – A JSON block that contains other data that is sent from MobileFirst Server. It also contains the tag name for tag-based and broadcast notification. The tag name appears in the “tag” element. For broadcast notification, the default tag name is `Push.ALL`.

### Handling a push notification

### Handling a secure push notification
