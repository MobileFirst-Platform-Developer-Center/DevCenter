---
title: Apple watchOS 2.0 support in MobileFirst Platform Foundation 8.0
date: 2016-01-19
tags:
- MobileFirst_Platform
- iOS
- Apple_Watch
author:
  display_name: Amichai Meir
---

## Overview
**Prerequisite:** Make sure to read the [Authentication Concepts]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/authentication-concepts/) tutorial first.

MobileFirst Platform Foundation 8.0 beta's Native iOS SDK now contains support for Apple's  watchOS 2.0.  
In addition to the iOS framework, IBMMobileFirstPlatformFoundation.framework, there is now also a watchOS framework, IBMMobileFirstPlatformFoundationWatchOS, which can be used in the WatchKit Extension target of an Xcode project.

The watch app, as any regular iOS app, should be registered as a separate application in the MobileFirst Operations Console using the Bundle Identifier of the WatchKit Extension. That app is independent from its iPhone counterpart and has it's own security. It should define it's own Challenge Handler using the tools available in the watch (for example: an end-user can't effectively use user/password but can tap a pin code as shown in the demo bellow).

### Installing the SDK using CocoaPods
In order to install the SDK using CocoaPods, your Podfile should include the target of the WatchKit Extenstion.  
For example: [https://github.ibm.com/MFPSamples/WatchOSDemo/blob/master/WatchOSDemoApp/Podfile](https://github.ibm.com/MFPSamples/WatchOSDemo/blob/master/WatchOSDemoApp/Podfile).

### Import IBMMobileFirstPlatformFoundationWatchOS
In the watch Extension's source files you should import `IBMMobileFirstPlatformFoundationWatchOS` in order to use MobileFirst code:

##### Objective C:

```objc
#import <IBMMobileFirstPlatformFoundationWatchOS/IBMMobileFirstPlatformFoundationWatchOS.h>
```

##### Swift:

```swift
import IBMMobileFirstPlatformFoundationWatchOS
```

### Watch OS Demo App

There is also a complete demo app. Demonstrated in the app is accessing a resource protected by specific "scope" with the iPhone app and watch app maping to the respecive appropriate security checks: the iPhone app maps to a username/password security check, and the watch app maps to a pin-code security check.

You can download the demo Xcode project from GitHub: [https://github.ibm.com/MFPSamples/WatchOSDemo](https://github.ibm.com/MFPSamples/WatchOSDemo).

In order to use the demo app:

1. From command-line, navigate to the WatchOSDemoApp and run `pod install`. There is a Podfile prepared located within the project.

2. Open the workspace created - WatchOSDemoApp.xcworkspace

3. Under **Pods/Pods/IBMMobileFirstPlatformFoundation** both *IBMMobileFirstPlatformFoundation.framework* and *IBMMobileFirstPlatformFoundationWatchOS.framework* are available:

    ![Image of framework files]({{site.baseurl}}/assets/blog/2016-01-19-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Pod_frameworks.png)

4. Edit the **mfpclient.plist** file and set the `host` property. Make sure the file is a member of both targets - WatchOSDemoApp and WatchOSDemoApp WatchKit Extension:

    ![Image of editing the .plist file in Xcode](/assets/blog/2016-01-19-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/mfpclient.plist_edit.png)

    Remember the file should be member of both targets - WatchOSDemoApp and WatchOSDemoApp WatchKit Extension:
    
    ![Image of memberships in Xcode]({{site.baseurl}}/assets/blog/2016-01-19-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/mfpclient.plist_membership.png)

5. Deploy the adapters UsernamePasswordAdapter.adapter, PinCodeAdapter.adapter and bankAdapter.adapter to the server from the MobileFirst Operations Console.

6. Register both apps com.worklight.WatchOSDemoApp and com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension from the MobileFirst Operations Console, and map the scope element `balanceCheckScope` to security check as follows:
    - For com.worklight.WatchOSDemoApp map it to `usernamePassword`
    - For com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension map it to `pinCode`

7. Run the app using the schema "WatchOSDemoApp WatchKit App":

    ![Image of how to run the project in Xcode]({{site.baseurl}}/assets/blog/2016-01-19-apple-watchOS-2-0-support-in-mobilefirst-platform-foundation-8-0/Run_demo_app_on_watch.png)

Clicking on "My Balance" should display the Pin Code screen  
A valid pin is "1234". Try first an incorrect pin - the Pin Code screen should appear again with "Please try again". Then try with a valid pin - you should get the balance screen.  

Do the same in the iPhone app - Login screen with username/password should be opened. Valid username/password is when the username is the same as the password (for example "user" and "user").
