---
title: IBM MobileFirst Platform Foundation Support for iOS 10
date: 2016-09-16
tags:
- MobileFirst_Platform
- iOS
version:
- 8.0
- 7.1
- 7.0
- 6.3
author: 
  name: Vittal R Pai
---
The MobileFirst Platform Foundation v6.3 to v8.0 are supported on iOS 10. Read more on our support plan [here](https://mobilefirstplatform.ibmcloud.com/blog/2016/06/05/support-plan-for-ios-10/).

The blog inscribes the steps that developers and IT administrators might have to incorporate in their applications.

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### **Existing application**
Existing application(s) that were built using MobileFirst Platform v6.3 or later **will work** on iOS 10 as they did on previous versions of iOS.

#### **Updating application on the App Store** (built using previous versions of Xcode)
You can opt to build application(s) with Xcode 7 and republish to the App Store. These application(s) will work as expected on iOS 10.

#### **Updating existing application or submitting new app to the App Store** (built using Xcode 8)
Review the following sections to learn what actions needs to be taken to ensure that your application(s) can support iOS 10. The following needs to be taken into consideration only if the application(s) are built using [Xcode 8](https://developer.apple.com/download).

* If your application uses the `KeyChain` implementation, your app might crash because of `KeyChain` - It happens because Apple changed the way of working with keychain in iOS 10. To fix this issue you simply should go to Targets->Capabilities and enable keychain sharing.
* If your application is using `Push notification` feature, Make sure sure you have turned on Push Capability in you project.
   - If you have developed an application which uses push feature on or below Xcode v7 and whenever opened a same project in Xcode 8, Please make sure that Push capability feature is enabled in XCode Project.
* Hybrid iOS Application which has FIPS feature enabled does not send request/connect to MFP server over HTTPS. This is a known issue, it needs an interim fix ([PI69371](https://www-945.ibm.com/support/fixcentral)) to be applied to the Client Application.
* `NSContactsUsageDescription` or `NSMicrophoneUsageDescription` keys are now mandatory in the plist file while accessing contacts or microphone in cordova/hybrid iOS application. This affects users who use `cordova-plugin-contact` or `cordova-plugin-media` API's. The fix is simply to include those keys in application plist file.
* iOS applications written in Swift need to be migrated to Swift 3.0 or Swift 2.3. This can be easily done using the migration guide [provided by Apple](https://swift.org/migration-guide).

<br>
###IBM Application Center

IBM Application Center from MobileFirst Platform Foundation, version 6.3 - 8.0 works with iOS 10 except for one minor issue related to Push notifications.

It is noticed that when the Mobilefirst Application Center is configured to send push notifications, users might not be notified of updates for the application installed on iOS 10 device. This is a known issue, it needs an interim fix ([PI69110](https://www-945.ibm.com/support/fixcentral)) to be applied to the AppCenter server setup.

<br>
###WatchOS 3
Apple has released WatchOS 3 alongside iOS 10, a new version of the Watch operating system for Apple Watch which brings in massive improvements to the OS.

To support watchOS 3, MobileFirst Platform provides a framework `IBMMobileFirstPlatformFoundationWatchOS` along with the core `IBMMobileFirstPlatformFoundation` framework. This framework can be used in WatchKit extension in the Xcode project.

The watch application, as any regular iOS application, should be registered as a separate application in the MobileFirst Operations Console using the Bundle Identifier of the WatchKit Extension. That application is independent from its iPhone counterpart and has its own security. It should define its own Challenge Handler just like a native iOS application.

Existing application(s) that were created using MobileFirst Platform v8.0 watchOS `IBMMobileFirstPlatformFoundationWatchOS` framework will work on WatchOS 3.0 as they did on watchOS 2e.
Steps to be followed while developing watchOS application(s) and the limitations can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/using-the-mfpf-sdk/watchos)

<br>
###MobileFirst Xamarin Application

Similar to the Mobilefirst native iOS SDK, the [IBM MobileFirst SDK for Xamarin](https://components.xamarin.com/view/ibm-worklight?version=8.0.0.1) has also been successfully validated with iOS 10. Existing application(s) created using the IBM MobileFirst SDK for Xamarin will work on iOS 10.

<br>
####Additional Information
[WWDC 2016.](https://developer.apple.com/videos/wwdc2016/)

> **Note:** For compatibility results between iOS 10 and MobileFirst Platform releases, see the blog post: [Compatibility tests for iOS 10 with supported MobileFirst Platform Foundation releases]({{site.baseurl}}/blog/2016/07/01/compatibility-tests-for-ios-10/).
