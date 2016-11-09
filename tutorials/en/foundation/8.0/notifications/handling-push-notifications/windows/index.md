---
layout: tutorial
title: Handling Push Notifications in Windows 8.1 Universal and Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 7
downloads:
  - name: Download Windows 8.1 Universal Project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80
  - name: Download Windows 10 UWP Project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin10/tree/release80

---
## Overview
MobileFirst-provided Notifications API can be used in order to register &amp; unregister devices, and subscribe &amp; unsubscribe to tags. In this tutorial, you will learn how to handle push notification in native Windows 8.1 Universal and Windows 10 UWP applications using C#.

**Prerequisites:**

* Make sure you have read the following tutorials:
	* [Push Notifications Overview](../../)
    * [Setting up your MobileFirst development environment](../../../installation-configuration/#installing-a-development-environment)
    * [Adding the MobileFirst Platform Foundation SDK to windows applications](../../../application-development/sdk/windows-8-10)
* MobileFirst Server to run locally, or a remotely running MobileFirst Server.
* MobileFirst CLI installed on the developer workstation

#### Jump to:
* [Notifications configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)

## Notifications Configuration
Create a new Visual Studio project or use and existing one.  
If the MobileFirst Native Windows SDK is not already present in the project, follow the instructions in the [Adding the MobileFirst Foundation SDK to Windows applications](../../../application-development/sdk/windows-8-10) tutorial.

### Adding the Push SDK

1. Select Tools → NuGet Package Manager → Package Manager Console.
2. Choose the project where you want to install the MobileFirst push component.
3. Add theMobileFirst push SDK by running the **Install-Package IBM.MobileFirstPlatformFoundationPush** command.

## Pre-requisite WNS configuration
1. Ensure the application is with Toast notification capability. This can be enabled in Package.appxmanifest.
2. Ensure `Package Identity Name` and `Publisher` should be updated with the values registered with WNS.
3. (Optional) Delete TemporaryKey.pfx file.

## Notifications API
### MFPPush Instance
All API calls must be called on an instance of `MFPPush`.  This can be by creating a variable such as `private MFPPush PushClient = MFPPush.GetInstance();`, and then calling `PushClient.methodName()` throughout the class.

Alternatively you can call `MFPPush.GetInstance().methodName()` for each instance in which you need to access the push API methods.

### Challenge Handlers
If the `push.mobileclient` scope is mapped to a **security check**, you need to make sure matching **challenge handlers** exist and are registered before using any of the Push APIs.

> Learn more about challenge handlers in the [credential validation](../../../authentication-and-security/credentials-validation/ios) tutorial.

### Client-side

| C Sharp Methods                                                                                                | Description                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`Initialize()`](#initialization)                                                                            | Initializes MFPPush for supplied context.                               |
| [`IsPushSupported()`](#is-push-supported)                                                                    | Does the device support push notifications.                             |
| [`RegisterDevice(JObject options)`](#register-device-amp-send-device-token)                  | Registers the device with the Push Notifications Service.               |
| [`GetTags()`](#get-tags)                                | Retrieves the tag(s) available in a push notification service instance. |
| [`Subscribe(String[] Tags)`](#subscribe)     | Subscribes the device to the specified tag(s).                          |
| [`GetSubscriptions()`](#get-subscriptions)              | Retrieves all tags the device is currently subscribed to.               |
| [`Unsubscribe(String[] Tags)`](#unsubscribe) | Unsubscribes from a particular tag(s).                                  |
| [`UnregisterDevice()`](#unregister)                     | Unregisters the device from the Push Notifications Service              |

#### Initialization
Initialization is required for the client application to connect to MFPPush service.

* The `Initialize` method should be called first before using any other MFPPush APIs.
* It registers the callback function to handle received push notifications.

```csharp
MFPPush.GetInstance().Initialize();
```

#### Is push supported
Checks if the device supports push notifications.

```csharp
Boolean isSupported = MFPPush.GetInstance().IsPushSupported();

if (isSupported ) {
    // Push is supported
} else {
    // Push is not supported
}
```

#### Register device &amp; send device token
Register the device to the push notifications service.

```csharp
JObject Options = new JObject();
MFPPushMessageResponse Response = await MFPPush.GetInstance().RegisterDevice(Options);         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```

#### Get tags
Retrieve all the available tags from the push notification service.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetTags();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
} else{
    Message = new MessageDialog("Failed to get Tags list");
}
```

#### Subscribe
Subscribe to desired tags.

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Get subscription tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Subscribe(Tags);
if (Response.Success == true)
{
    //successfully subscribed to push tag
}
else
{
    //failed to subscribe to push tags
}
```

#### Get subscriptions
Retrieve tags the device is currently subscribed to.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetSubscriptions();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
}
else
{
    Message = new MessageDialog("Failed to get subcription list...");
}
```

#### Unsubscribe
Unsubscribe from tags.

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// unsubscribe tag
MFPPushMessageResponse Response = await MFPPush.GetInstance().Unsubscribe(Tags);
if (Response.Success == true)
{
    //succes
}
else
{
    //failed to subscribe to tags
}
```


#### Unregister
Unregister the device from push notification service instance.

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().UnregisterDevice();         
if (Response.Success == true)
{
    // Successfully registered
} else {
    // Registration failed with error
}
```


## Handling a push notification
In order to handle a push notification you will need to set up a `MFPPushNotificationListener`.  This can be achieved by implementing the following method.

1. Create a class by using interface of type MFPPushNotificationListener

   ```csharp
   internal class NotificationListner : MFPPushNotificationListener
   {
        public async void onReceive(String properties, String payload)
   {
        // Handle push notification here      
   }
   }
   ```

2. Set the class to be the listener by calling `MFPPush.GetInstance().listen(new NotificationListner())`
3. In the onReceive method you will receive the push notification and can handle the notification for the desired behavior.


<img alt="Image of the sample application" src="sample-app.png" style="float:right"/>

## Windows Universal Push Notifications Service

No specific port needs to be open in your server configuration.

WNS uses regular http or https requests.


## Sample application

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) the Windows 8.1 Universal project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80) Windows 10 UWP project.

### Sample usage
Follow the sample's README.md file for instructions.