---
layout: tutorial
title: Handling Push Notifications in iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
{{ site.data.keys.product_adj }}-provided Notifications API can be used in order to register &amp; unregister devices, and subscribe &amp; unsubscribe to tags. In this tutorial, you will learn how to handle push notification in iOS applications using Swift.

For information about Silent or Interactive notifications, see:

* [Silent notifications](../silent)
* [Interactive notifications](../interactive)

**Prerequisites:**

* Make sure you have read the following tutorials:
	* [Push Notifications Overview](../../)
    * [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/#installing-a-development-environment)
    * [Adding the {{ site.data.keys.product }} SDK to iOS applications](../../../application-development/sdk/ios)
* {{ site.data.keys.mf_server }} to run locally, or a remotely running {{ site.data.keys.mf_server }}.
* {{ site.data.keys.mf_cli }} installed on the developer workstation


### Jump to:
{: #jump-to }
* [Notifications configuration](#notifications-configuration)
* [Notifications API](#notifications-api)
* [Handling a push notification](#handling-a-push-notification)


### Notifications Configuration
{: #notifications-configuration }
Create a new Xcode project or use and existing one.
If the {{ site.data.keys.product_adj }} Native iOS SDK is not already present in the project, follow the instructions in the [Adding the {{ site.data.keys.product }} SDK to iOS applications](../../../application-development/sdk/ios) tutorial.


### Adding the Push SDK
{: #adding-the-push-sdk }
1. Open the project's existing **podfile** and add the following lines:

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - Replace **Xcode-project-target** with the name of your Xcode project's target.

2. Save and close the **podfile**.
3. From a **Command-line** window, navigate into to the project's root folder.
4. Run the command `pod install`
5. Open project using the **.xcworkspace** file.

## Notifications API
{: #notifications-api }
### MFPPush Instance
{: #mfppush-instance }
All API calls must be called on an instance of `MFPPush`.  This can be by created as a `var` in a view controller such as `var push = MFPPush.sharedInstance();`, and then calling `push.methodName()` throughout the view controller.

Alternatively you can call `MFPPush.sharedInstance().methodName()` for each instance in which you need to access the push API methods.

### Challenge Handlers
{: #challenge-handlers }
If the `push.mobileclient` scope is mapped to a **security check**, you need to make sure matching **challenge handlers** exist and are registered before using any of the Push APIs.

> Learn more about challenge handlers in the [credential validation](../../../authentication-and-security/credentials-validation/ios) tutorial.

### Client-side
{: #client-side }
| Swift Methods                                                                                                | Description                                                             |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`initialize()`](#initialization)                                                                            | Initializes MFPPush for supplied context.                               |
| [`isPushSupported()`](#is-push-supported)                                                                    | Does the device support push notifications.                             |
| [`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token)                  | Registers the device with the Push Notifications Service.               |
| [`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token)                                                | Sends the device token to the server                                    |
| [`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags)                                | Retrieves the tag(s) available in a push notification service instance. |
| [`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe)     | Subscribes the device to the specified tag(s).                          |
| [`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)              | Retrieves all tags the device is currently subscribed to.               |
| [`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) | Unsubscribes from a particular tag(s).                                  |
| [`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister)                     | Unregisters the device from the Push Notifications Service              |

#### Initialization
{: #initialization }
Initialization is required for the client application to connect to MFPPush service.

* The `initialize` method should be called first before using any other MFPPush APIs.
* It registers the callback function to handle received push notifications.

```swift
MFPPush.sharedInstance().initialize();
```

#### Is push supported
{: #is-push-supported }
Checks if the device supports push notifications.

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```

#### Register device &amp; send device token
{: #register-device--send-device-token }
Register the device to the push notifications service.

```swift
MFPPush.sharedInstance().registerDevice({(options, response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Successfully registered
    } else {
        // Registration failed with error
    }
})
```

`options` = `[NSObject : AnyObject]` which is an optional parameter that is a dictionary of options to be passed with your register request, sends the device token to the server to register the device with its unique identifier.

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **Note:** This is typically called in the **AppDelegate** in the `didRegisterForRemoteNotificationsWithDeviceToken` method.

#### Get tags
{: #get-tags }
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
{: #subscribe }
Subscribe to desired tags.

```swift
var tagsArray: [AnyObject] = ["Tag 1" as AnyObject, "Tag 2" as AnyObject]

MFPPush.sharedInstance().subscribe(self.tagsArray, completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
    if error == nil {
        // Subscribed successfully
    } else {
        // Failed to subscribe with error
    }
})
```


#### Get subscriptions
{: #get-subscriptions }
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
{: #unsubscribe }
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
{: #unregister }
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
{: #handling-a-push-notification }

Push notifications are handled by the native iOS framework directly. Depending on your application lifecyle, different methods will be called by the iOS framework.

For example if a simple notification is received while the application is running, **AppDelegate**'s `didReceiveRemoteNotification` will be triggered:

```swift
func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")

    // display the alert body
    if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
            showAlert(body)
    }
}
```

> Learn more about handling notifications in iOS from the Apple documentation: http://bit.ly/1ESSGdQ

<img alt="Image of the sample application" src="notifications-app.png" style="float:right"/>

## Sample application
{: #sample-application }
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80) the Xcode project.

### Sample usage
{: #sample-usage }
Follow the sample's README.md file for instructions.
