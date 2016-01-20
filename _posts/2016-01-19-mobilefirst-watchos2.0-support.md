---
title: watchOS 2.0 support in MFP 8.0
date: 2016-01-19
tags:
- MobileFirst_Platform
- iOS
- Apple_Watch
author:
  display_name: Amichai Meir
---

This blogpost is here to tell you about the MobileFirst SDK support for Apple Watch.

### Overview

MobileFirst 8.0 beta SDK is coming with support for watchOS 2.0.
In addition to the iOS framework - IBMMobileFirstPlatformFoundation there is a watchOS framework - IBMMobileFirstPlatformFoundationWatchOS, which can be used in the WatchKit Extension targets of Xcode project.
The watch app as any regular app should be registered as a separate app in the MFP Console, using Bundle Identifier of the WatchKit Extension.
That app is independent from it's iOS counterpart and has it's own security. It should define it's own Challenge Handler, using the tools available in the watch. (For example can't effectively use user/password but can tap a pin code as shown in the demo bellow).


### Install the SDK using CocoaPods

In order to install the SDK using CocoaPods, your Podfile should include the target of WatchKit Extenstion.
See example [here](https://github.ibm.com/MFPSamples/WatchOSDemo/blob/master/WatchOSDemoApp/Podfile).

### Import IBMMobileFirstPlatformFoundationWatchOS

In the watch Extension's source files you should import IBMMobileFirstPlatformFoundationWatchOS in order to use MobileFirst code:

##### Objective C:

`#import <IBMMobileFirstPlatformFoundationWatchOS/IBMMobileFirstPlatformFoundationWatchOS.h>`

##### Swift:

`import IBMMobileFirstPlatformFoundationWatchOS`


### Watch OS Demo App

A complete demo app available, there we demonstrate accessing a resource protected by specific "scope" with the iPhone app and watch app maping to the respecive appropriate security checks:
iPhone app maps to username/password security check and watch app maps to pin-code security check.

You can find the whole WatchOSDemo project [here](https://github.ibm.com/MFPSamples/WatchOSDemo).

In order to use the demo app:

- Get into the WatchOSDemoApp and run `pod install`. We have a Podfile prepared located within the project.
- Open the workspace created - WatchOSDemoApp.xcworkspace
- See you have under Pods/Pods/IBMMobileFirstPlatformFoundation both IBMMobileFirstPlatformFoundation.framework and IBMMobileFirstPlatformFoundationWatchOS.framework:
![my-alt-text](/assets/blog/2016-01-19-mobilefirst-watchos2.0-support/Pod_frameworks.png)
- Edit mfpclient.plist to set `host` property. Remember the file should be member of both targets - WatchOSDemoApp and WatchOSDemoApp WatchKit Extension:
![my-alt-text](/assets/blog/2016-01-19-mobilefirst-watchos2.0-support/mfpclient.plist_membership.png)
- Deploy the adapters UsernamePasswordAdapter.adapter, PinCodeAdapter.adapter and bankAdapter.adapter into the server.
- Register both apps com.worklight.WatchOSDemoApp and com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension in the MFP console, and map the scope element `balanceCheckScope` to security check as follows:
<br>
For com.worklight.WatchOSDemoApp map it to `usernamePassword`
<br>
For com.worklight.WatchOSDemoApp.watchkitapp.watchkitextension map it to `pinCode`
- Run the app using the schema "WatchOSDemoApp WatchKit App":
![my-alt-text](/assets/blog/2016-01-19-mobilefirst-watchos2.0-support/Run_demo_app_on_watch.png)
- Click "My Balance" - Pin Code screen should be opened.
- Valid pin is "1234". Try first wrong pin - Pin Code screen should appear again with "Please try again". Try then the valid pin - you should get the balance.
- Do the same in the iPhone app - Login screen with username/password should be opened. Valid username/password is when username == password.
