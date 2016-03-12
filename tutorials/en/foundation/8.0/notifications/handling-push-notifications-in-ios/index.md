---
layout: tutorial
title: Handling Push Notifications in iOS applications
relevantTo: [ios]
weight: 5
downloads:
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80

---
## Overview
MobileFirst-provided Notifications API can be used in order to register &amp; unregister devices, and subscribe &amp; unsubscribe to tags. In this tutorial, you will learn how to handle push notification in iOS applications using Swift.

**Prerequisites:** 

* Make sure you have read the following tutorials:
	* [Push Notifications Overview](../push-notifications-overview)
    * [Setting up your MobileFirst development environment](../../setting-up-your-development-environment/)
    * [Adding the MobileFirst Platform Foundation SDK to iOS applications](../../adding-the-mfpf-sdk/ios)
* MobileFirst Server to run locally, or a remotely running MobileFirst Server.
* MobileFirst Developer CLI installed on the developer workstation


### Jump to:
* [Notifications configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)


### Notifications Configuration
Create a new Xcode project or use and existing one.  
If the MobileFirst Native iOS SDK is not already present in the project, follow the instructions in the [Adding the MobileFirst Platform Foundation SDK to iOS applications](../../adding-the-mfpf-sdk/ios) tutorial.


### Adding the Push SDK

1. Open the project's existing **podfile** and add the following line:

	```bash
	pod 'IBMMobileFirstPlatformFoundationPush'
	```

2. Save and close the **podfile**.
3. From a **Command-line** window, navigate into to the project's root folder.
4. Run the command `pod install`
5. Open project using the **.xcworkspace** file.


## Notifications API
### Client-side

| Swift Methods                                                                                                | Description                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize()`](#initialization)                                                                            | Initializes MFPPush for supplied context.                               |
| [`isPushSupported()`](#is-push-supported)                                                                    | Does the device support push notifications.                             |
| [`sendDeviceToken(deviceToken: NSData!)`](#send-device-token)                                                | Sends the device token to the server                                    |
| [`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device)                  | Registers the device with the Push Notifications Service.               |
| [`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags)                                | Retrieves the tag(s) available in a push notification service instance. |
| [`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe)     | Subscribes the device to the specified tag(s).                          |
| [`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)              | Retrieves all tags the device is currently subscribed to.               |
| [`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) | Unsubscribes from a particular tag(s).                                  |
| [`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister)                     | Unregisters the device from the Push Notifications Service              |


### API implementation

All API calls must be called on an instance of `MFPPush`.  This can be by created as a `var` in a view controller such as `var push = MFPPush.sharredInstance();`, and then calling `push.<api-call>` throughout the view controller.

Alternatively you can call `MFPPush.sharredInstance().<api_call>` for each instance in which you need to access the push API methods.


#### Initialization
Required for the client application to connect to MFPPush service.

* The API method should be called first before using any other MFPPush APIs. 
* Registers the callback function to handle received push notifications.

```swift
MFPPush.sharredInstance().initialize();
```


#### Is push supported
Checks if the device supports push notifications.

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```


#### Send device token
Sends the device token to the server to register the device with its unique identifier.

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

**Note:** This is typically called in the **AppDelegate** in the `didRegisterForRemoteNotificationsWithDeviceToken` method


#### Register device
Register the device to the push notifications service.

```swift
MFPPush.sharedInstance().registerDevice({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Successfully registered
    } else {
        // Registration failed with error
    }
})
```


#### Get tags
Retrieve all the available tags from the push notification service.

```swift
MFPPush.sharedInstance().getTags({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response.responseText)")
        if response.availableTags().isEmpty == true {
            // Successfully retrieved tags as list of strings
        } else {
            // Successfully retrieved response from server but there where no available tags
        }
    } else {
        // Failed to receive tags with error
    }
})
```


#### Subscribe
Subscribe to desired tags.

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Get tags
MFPPush.sharedInstance().getTags({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response.responseText)")
        if response.availableTags().isEmpty == true {
            self.tagsArray = []
            self.showAlert("There are no available tags")
        } else {
            self.tagsArray = response.availableTags()
            self.showAlert(String(self.tagsArray))
            print("Tags response: \(response)")
        }
    } else {
        self.showAlert("Error \(error.description)")
        print("Error \(error.description)")
    }
})
```


#### Get subscriptions
Retrieve tags the device is currently subscribed to.

```swift
MFPPush.sharedInstance().getSubscriptions({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Successfully received subscriptions as list of strings
    } else {
        // Failed to retrieve subscriptions with error
    }
})
```


#### Unsubscribe
Unsubscribe from tags.

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Unsubscribe from tags
MFPPush.sharedInstance().unsubscribe(tags, completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Unsubscribed successfully
    } else {
        // Failed to unsubscribe
    }
})
```


#### Unregister
Unregister the device from push notification service instance.

```swift
MFPPush.sharedInstance().unregisterDevice({(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Unregistered successfully
    } else {
        self.showAlert("Error \(error.description)")
        // Failed to unregister with error
    }
})
```


## Handling a push notification

Declare the following notification method `didReceiveRemoteNotification` in your **AppDelegate**

```swift
TODO:// Update var's

func application(application: UIApplication, didReceiveRemoteNotification   userInfo: [NSObject : AnyObject]) {
    print("Recieved Notification \(userInfo.description)")
    
    var alert: String = "alert"
    var alertID: String = "ID"
    var alertPayload: String = "Payload"
    
    //Handle notification
}
```

<img alt="Image of the sample application" src="notifications-app.png" style="float:right"/>
## Sample application

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80) the Xcode project.

### Sample usage
1. From a **Command-line** window, navigate to the project's root folder and run the command: `mfpdev app register`.
2. Import the project to Xcode using the .xcworkspace file, and run the sample by clicking the **Run** button.

**[Sending a notification](../sending-push-notifications):**

* Tag notification
    * Use the **MobileFirst Operations Console → [your application] → Push screen**.
* Authenticated notification:
    * Deploy the [**UserLogin** Security Check](../../authentication-and-security/user-authentication/security-check).
    * In **MobileFirst Operations Console → [your application] → Security tab**, map the **push.mobileclient** scope to the **UserLogin** Security Check.
    * Use the [REST APIs](../sending-push-notifications#via-mobilefirst-provided-rest-apis) to send the notification.
