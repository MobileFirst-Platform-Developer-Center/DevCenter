---
title: Apple watchOS 2.0 support in MobileFirst Platform Foundation 8.0 Beta
date: 2016-04-01
tags:
- MobileFirst_Platform
- iOS
- Apple_Watch
version:
- 8.0
author:
  name: Amichai Meir
---

> To follow through this blog post, make sure to first [join the MobileFirst Platform Foundation 8.0 Beta Program]({{site.baseurl}}/beta/).

## Overview
**Prerequisite:** Make sure to read the [Authentication Concepts]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/) tutorial first.

MobileFirst Platform Foundation 8.0 beta's Native iOS SDK now contains support for Apple's  watchOS 2.0.  
In addition to the iOS framework (`IBMMobileFirstPlatformFoundation`) there is now also a watchOS   `IBMMobileFirstPlatformFoundationWatchOS` framework which can be used in the WatchKit Extension target of an Xcode project.

The watch app, as any regular iOS app, should be registered as a separate application in the MobileFirst Operations Console using the Bundle Identifier of the WatchKit Extension. That app is independent from its iPhone counterpart and has its own security. It should define its own Challenge Handler using the tools available in the watch (for example: an end-user can't effectively use user/password but can type a pin code as shown in the demo below).

### Installing the SDK using CocoaPods
In order to install the SDK using CocoaPods, your Podfile should include the target of the WatchKit Extension.  
For example: [https://github.com/amichaim/WatchOSDemo/blob/master/WatchOSDemoApp/Podfile](https://github.com/amichaim/WatchOSDemo/blob/master/WatchOSDemoApp/Podfile).

### Import IBMMobileFirstPlatformFoundationWatchOS
In the watch Extension's source files you should import the `IBMMobileFirstPlatformFoundationWatchOS` framework in order to use MobileFirst code:

##### Objective C:

```objc
#import <IBMMobileFirstPlatformFoundationWatchOS/IBMMobileFirstPlatformFoundationWatchOS.h>
```

##### Swift:

```swift
import IBMMobileFirstPlatformFoundationWatchOS
```

### Support "Access Disabled" and "Active and Notifying" messages
By default, the iOS MobileFirst framework provides a built-in UI alert for returning the messages for the "Access Disabled" and "Active and Notifying" options. This is not supported for the watchOS MobileFirst framework.
Therefore, in order to see messages from "Access Disabled" or "Active and Notifying", a custom remote disable challenge handler should be implemented and registered. The custom challenge handler should be initialized with the security check wl_remoteDisableRealm. An example of such an implementation appears in the demo below.


### watchOS Demo App

There is also a complete demo app. The demo accesses a resource protected by specific "scope". The iPhone app and watchOS app map to their respecive security checks: the iPhone app maps to a username/password security check, and the watchOS app maps to a pin-code security check.

You can download the demo Xcode project from GitHub: [https://github.com/amichaim/WatchOSDemo](https://github.com/amichaim/WatchOSDemo).

In order to use the demo app:

1. From command-line, navigate to the WatchOSDemoApp and run `pod install`. There is a prepared Podfile located within the project.

2. Open the workspace created: WatchOSDemoApp.xcworkspace.

3. Under **Pods/Pods/IBMMobileFirstPlatformFoundation** both *IBMMobileFirstPlatformFoundation.framework* and *IBMMobileFirstPlatformFoundationWatchOS.framework* are available:

    ![Image of framework files]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Pod_frameworks.png)

4. Edit the **mfpclient.plist** file and set the `host` property.

    ![Image of editing the .plist file in Xcode]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/mfpclient.plist_edit.png)

    Make sure the file should be member of both targets - WatchOSDemoApp and WatchOSDemoApp WatchKit Extension:

    ![Image of memberships in Xcode]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/mfpclient.plist_membership.png)

5. Deploy the adapters UsernamePasswordAdapter.adapter, PinCodeAdapter.adapter and bankAdapter.adapter to the server from the MobileFirst Operations Console.

6. Register both apps com.worklight.WatchOSDemoApp and com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension from the MobileFirst Operations Console, and map the scope element `balanceCheckScope` to security check as follows:
    - For com.worklight.WatchOSDemoApp map it to `usernamePassword`
    - For com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension map it to `pinCode`

7. Run the app using the schema "WatchOSDemoApp WatchKit App":

    ![Image of how to run the project in Xcode]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Run_demo_app_on_watch.png)

Clicking on "My Balance" should display the Pin Code screen.  
A valid pin is "1234" (That can be changed in the security check using the MobileFirst Operations Console). Try first an incorrect pin - the Pin Code screen should appear again with "Please try again". Then try with a valid pin - you should get the balance screen.  

![Image of Balance button in watch app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Balance_btn_watch.png)
![Image of Pin Code screen in watch app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Pincode_screen.png)
![Image of balance result in watch app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Watch_balance_screen.png)

Do the same in the iPhone app - Login screen with username/password should be opened. Any username/password pair where the username and password are identical is valid (for example "user" and "user").

![Image of Balance button in iPhone app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Balance_btn_iphone.png)
![Image of User Password screen in iPhone app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/User_password_screen.png)
![Image of balance result in iPhone app]({{site.baseurl}}/assets/blog/2016-04-01-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Iphone_balance_screen.png)
