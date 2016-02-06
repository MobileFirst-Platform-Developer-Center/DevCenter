---
layout: tutorial
title: Handling Push Notifications in Android
relevantTo: [android]
weight: 5
---
## Overview
Before Android applications are able to handle any recieved push notifications, they must configured with support for Google Play Services. Once an application has been configured, MobileFirst-provided Notifications API can be used in order to register &amp; unregister devices, and  subscribe &amp; unsubscribe to tags.

In this tutorial you learn how to configure an Android application and how to use the MobileFirst-provided Notifications API.

**Prerequisites:** 

* Android Studio and MobileFirst Developer CLI installed on the developer workstation.  
* MobileFirst Server to run locally, or a remotely running MobileFirst Server.
* Make sure you have read the [Setting up your MobileFirst development environment](../../../setting-up-your-development-environment/index) tutorial, as well as the [Adding the MobileFirst Platform Foundation SDK to Android applications](../../../adding-the-mfpf-sdk/android) tutorial.

#### Jump to:

* [Notifications configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)
* [Handling a secure push notification](#handling-a-secure-push-notification)

## Notifications Configuration
Create a new Android Studio project or use an existing one.  
If the MobileFirst Native Android SDK is not already present in the project, follow the instructions in the [Adding the MobileFirst Platform Foundation SDK to Android applications](../../../adding-the-mfpf-sdk/android) tutorial.

### Project setup

1. In **Android → Gradle scripts**, select the **build.gradle (Project: [application-name])** file.

2. Add the following line to `dependencies`:
	
	```xml
	classpath 'com.google.gms:google-services:2.0.0-alpha3'
	```

3. In **Android → Gradle scripts**, select the **build.gradle (Module: app)** file.

4. Add the following line below `apply plugin: 'com.android.application'`:

	```xml
	apply plugin: 'com.google.gms.google-services'
	```

5. Add the following line to `dependencies`:
	
	```xml
	com.google.android.gms:play-services-gcm:8.4.0
	com.squareup.okhttp:okhttp:2.6.0
	```

	<span style="color:red"> remove step 6 before going live</span>

6. Copy ibmmobilefirstplatformfoundationpush-1.0.0.aar (from halpert Electra DevOps Latest integration build) to `<android_sdk>\extras\google\m2repository\com\ibm\mobile\foundation\ibmmobilefirstplatformfoundationpush\1.0.0\ibmmobilefirstplatformfoundationpush-1.0.0.aar`

   	Remove libs folder from the aar.  
   	Note: This step is not required once the lib gets to maven central/jcenter. Just need to add mavenCentral()/jcenter() in app gradle.

7. Add the push required configuration in AndroidManifest.xml 

	<span style="color:red">TODO: explain what is needed to do in the AndroidManifest.xml file</span>

### Google Services setup
<span style="color:red">Idan: I would consider moving this entire section to the server-side setup in the overview.</span>

To setup the Android project with Google Services, visit [Google's Services website](https://developers.google.com/mobile/add?platform=android&cntapi=gcm&cnturl=https:%2F%2Fdevelopers.google.com%2Fcloud-messaging%2Fandroid%2Fclient&cntlbl=Continue%20Adding%20GCM%20Support&%3Fconfigured%3Dtrue).

1. Provide your application name and package name.
2. Select "Cloud Messaging" and click on **Enable Google cloud messaging**.

This step generates a `Server API Key` and a `Sender ID`.  
The generated values are used to identify the application by Google's GCM service in order to send notifications to the device. 

<span style="color:red">TODO: Add explanation what to do with these values (= add them in the Console).</span>

## Notifications API
<span style="color:red">TODO: Add introduction text to the API.</span>

### API methods for tag notifications
* `WLPush.subscribeTag(tagName,options)` - Subscribes the device to the specified tag name.
* `WLPush.unsubscribeTag(tagName,options)` -  Unsubscribes the device from the specified tag name
* `WLPush.isTagSubscribed(tagName)` - Returns whether the device is subscribed to a specified tag name

### API methods for tag and broadcast notifications

* `WLNotificationListener` - Defines the callback method to be notified when the notification arrives.
* `client.getPush().setWLNotificationListener(listener)` -
This method sets the implementation class of the `WLNotificationListener` interface.
* `client.getPush().setOnReadyToSubscribeListener(listener)` -
This method registers a listener to be used for push notifications. This listener should implement the `onReadyToSubscribe()` method.
* The `onMessage(props,payload)` method of `WLNotificationListener` is called when a push notification is received by the device.
--* *props* – A JSON block that contains the notifications properties of the platform.
--* *payload* – A JSON block that contains other data that is sent from MobileFirst Server. The JSON block also contains the tag name for tag-based or broadcast notification. The tag name appears in the “tag” element. For broadcast notification, the default tag name is `Push.ALL`.

## Handling a push notification

## Handling a secure push notification
