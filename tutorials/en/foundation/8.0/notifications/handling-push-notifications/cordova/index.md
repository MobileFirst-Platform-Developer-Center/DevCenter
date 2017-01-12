---
layout: tutorial
title: Handling Push Notifications in Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Before iOS, Android and Windows Cordova applications are able to receive and display push notifications, the **cordova-plugin-mfp-push** Cordova plug-in needs to be added to the Cordova project. Once an application has been configured, {{ site.data.keys.product_adj }}-provided Notifications API can be used in order to register &amp; unregister devices, subscribe &amp; unsubscribe tags and handle notifications. In this tutorial, you will learn how to handle push notification in Cordova applications.

> **Note:** In the release, authenticated notifications are **not supported** in Cordova applications due to a defect. However a workaround is provided: each `MFPPush` API call can be wrapped by `WLAuthorizationManager.obtainAccessToken("push.mobileclient").then( ... );`. The provided sample application uses this workround.

For information about Silent or Interactive notifications in iOS, see:

* [Silent notifications](../silent)
* [Interactive notifications](../interactive)

**Prequisites:**

* Make sure you have read the following tutorials:
    * [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/#installing-a-development-environment)
    * [Adding the {{ site.data.keys.product }} SDK to Cordova applications](../../../application-development/sdk/cordova)
    * [Push Notifications Overview](../../)
* {{ site.data.keys.mf_server }} to run locally, or a remotely running {{ site.data.keys.mf_server }}
* {{ site.data.keys.mf_cli }} installed on the developer workstation
* Cordova CLI installed on the developer workstation

#### Jump to
{: #jump-to }
* [Notifications Configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)
* [Sample application](#sample-application)

## Notifications Configuration
{: #notifications-configuration }
Create a new Cordova project or use an existing one, and add one or more of the supported platforms: iOS, Android, Windows.

> If the {{ site.data.keys.product_adj }} Cordova SDK is not already present in the project, follow the instructions in the [Adding the {{ site.data.keys.product }} SDK to Cordova applications](../../../application-development/sdk/cordova) tutorial.

### Adding the Push plug-in
{: #adding-the-push-plug-in }
1. From a **command-line** window, navigate to the root of the Cordova project.  

2. Add the push plug-in to by running the command:

   ```bash
   cordova plugin add cordova-plugin-mfp-push
   ```

3. Build the Cordova project by running the command:

   ```bash
   cordova build
   ```

### iOS platform
{ #ios-platform }
The iOS platform requires an additional step.  
In Xcode, enable push notifications for your application in the **Capabilities** screen.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important:** the bundleId selected for the application must match the AppId that you have previously created in the Apple Developer site. See the [Push Notifications Overview] tutorial.

![image of where is the capability in Xcode](push-capability.png)

## Notifications API
{: #notifications-api }
### Client-side
{: #client-side }

| Javascript Function | Description |
| --- | --- |
| [`MFPPush.initialize(success, failure)`](#initialization) | Initialize the MFPPush instance. | 
| [`MFPPush.isPushSupported(success, failure)`](#is-push-supported) | Does the device support push notifications. | 
| [`MFPPush.registerDevice(options, success, failure)`](#register-device) | Registers the device with the Push Notifications Service. | 
| [`MFPPush.getTags(success, failure)`](#get-tags) | Retrieves all the tags available in a push notification service instance. | 
| [`MFPPush.subscribe(tag, success, failure)`](#subscribe) | Subscribes to a particular tag. | 
| [`MFPPush.getSubsciptions(success, failure)`](#get-subscriptions) | Retrieves the tags device is currently subscribed to | 
| [`MFPPush.unsubscribe(tag, success, failure)`](#unsubscribe) | Unsubscribes from a particular tag. | 
| [`MFPPush.unregisterDevice(success, failure)`](#unregister) | Unregisters the device from the Push Notifications Service | 

### API implementation
{: #api-implementation }
#### Initialization
{: #initialization }
Initialize the **MFPPush** instance.

- Required for the client application to connect to MFPPush service with the right application context.  
- The API method should be called first before using any other MFPPush APIs.
- Registers the callback function to handle received push notifications.

```javascript
MFPPush.initialize (
    function(successResponse) {
        alert("Successfully intialized");
        MFPPush.registerNotificationsCallback(notificationReceived);
    },
    function(failureResponse) {
        alert("Failed to initialize");
    }
);
```

#### Is push supported
{: #is-push-supported }
Check if the device supports push notifications.

```javascript
MFPPush.isPushSupported (
    function(successResponse) {
        alert("Push Supported: " + successResponse);
    },
    function(failureResponse) {
        alert("Failed to get push support status");
    }
);
```

#### Register device
{: #register-device }
Register the device to the push notifications service. If no options are required, options can be set to `null`.


```javascript
var options = { };
MFPPush.registerDevice(
    options,
    function(successResponse) {
        alert("Successfully registered");
    },
    function(failureResponse) {
        alert("Failed to register");
    }
);
```

#### Get tags
{: #get-tags }
Retrieve all the available tags from the push notification service.

```javascript
MFPPush.getTags (
    function(tags) {
        alert(JSON.stringify(tags));
},
    function() {
        alert("Failed to get tags");
    }
);
```

#### Subscribe
{: #subscribe }
Subscribe to desired tags.

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.subscribe(
    tags,
    function(tags) {
        alert("Subscribed successfully");
    },
    function() {
        alert("Failed to subscribe");
    }
);
```

#### Get subscriptions
{: #get-subscriptions }
Retrieve tags the device is currently subscribed to.

```javascript
MFPPush.getSubscriptions (
    function(subscriptions) {
        alert(JSON.stringify(subscriptions));
    },
    function() {
        alert("Failed to get subscriptions");
    }
);
```

#### Unsubscribe
{: #unsubscribe }
Unsubscribe from tags.

```javascript
var tags = ['sample-tag1','sample-tag2'];

MFPPush.unsubscribe(
    tags,
    function(tags) {
        alert("Unsubscribed successfully");
    },
    function() {
        alert("Failed to unsubscribe");
    }
);
```

#### Unregister
{: #unregister }
Unregister the device from push notification service instance.

```javascript
MFPPush.unregisterDevice(
    function(successResponse) {
        alert("Unregistered successfully");
    },
    function() {
        alert("Failed to unregister");
    }
);
```

## Handling a push notification
{: #handling-a-push-notification }
You can handle a received push notification by operating on its response object in the registered callback function.

```javascript
var notificationReceived = function(message) {
    alert(JSON.stringify(message));
};
```

<img alt="Image of the sample application" src="notifications-app.png" style="float:right"/>
## Sample application
{: #sample-application }
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80) the Cordova project.

**Note:** The latest version of Google Play Services is required to be installed on any Android device for the sample to run.

### Sample usage
{: #sample-usage }
Follow the sample's README.md file for instructions.
