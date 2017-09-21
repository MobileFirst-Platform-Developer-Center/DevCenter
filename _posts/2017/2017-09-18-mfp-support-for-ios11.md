---
title: IBM MobileFirst Platform Foundation Support for iOS 11
date: 2017-09-18
tags:
- MobileFirst_Platform
- Announcement
- iOS
version:
- 8.0
- 7.1
author:
  name: Sandhya Suman
---

Every year Apple releases a new version of iOS, and with every release MobileFirst keeps a promise to our customers by ensuring compatibility with the latest version and embracing new iOS changes with minimal impact. With this year's release of Apple iOS11, MobileFirst is pleased to announce the support of iOS 11 on MobileFirst Platform Foundation v7.1 and v8.0.  For more details, read through our [support plan for Android O and iOS 11](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

The beta version of iOS 11 has been extensively tested with MFP and details can be seen [Compatibility tests for iOS 11.]({{site.baseurl}}/blog/2017/07/24/compatibility-tests-for-ios-11/).  Complete features of MobileFirst Platform foundation has been tested on iOS11 seed build for versions v7.1 and v8.0.
MobileFirst Platform Foundation v7.1, v8.0  is compatible with iOS 11 and all the functions works fine with the exception of a few UI glitches.  The following features have been extensively tested

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Application Authenticity
* Analytics
* Push Notifications
* Remote Disable
* Application Center

The above mentioned functions of MobileFirst works fine with iOS 11, however few issues maybe noted, which are documented below.

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Known Issues
* Starting with iOS 11, Apple has updated [WebCrypto API](https://www.w3.org/TR/WebCryptoAPI/) in Safari 11 which is not compatible with the current MobileFirst API. Refer [Whats New In Safari  11](https://developer.apple.com/library/content/releasenotes/General/WhatsNewInSafari/Safari_11_0/Safari_11_0.html) for details. As a result, a web app consuming the Web SDK for MobileFirst will fail to launch on a device running on iOS 11. Updating to the latest version of [IBM Web SDK](https://www.npmjs.com/package/ibm-mfp-web-sdk) will resolve this issue.

* Starting iOS 11, Apple has modified the way the status bar area is shown on the screen particularly to support iPhone X which comes with a notch in the display. This is particularly important for cross-platform developers using tools such as Apache Cordova or Ionic. In particular, this change in behaviour affects any webview based apps that use fixed position header bars when they are built for iOS 11.

See our earlier [blog]({{site.baseurl}}/blog/2017/07/24/compatibility-tests-for-ios-11/) for guidance on how to fix this issue for MobileFirst Platform Foundation v7.1 and v8.0. IBM will release an iFix so that the change is available when you create a new hybrid project. Existing apps, however, have to make the change in their HTML.

* Although this is not an issue with MobileFirst, customers must be aware of an issue when using command `cordova emulate ios` . See this [link]( https://github.com/phonegap/ios-sim/issues/218) for more details.
To overcome this issue apply the latest Cordova update, using command `cordova platform add ios@https://github.com/apache/cordova-ios/`.

### WatchOS 4
Apple has released WatchOS 4 alongside iOS 11. To support watchOS 2 onwards, MobileFirst Platform provides a framework `IBMMobileFirstPlatformFoundationWatchOS` along with the core `IBMMobileFirstPlatformFoundation` framework. This framework can be used in WatchKit extension in the Xcode project.

Existing application(s) that were created using MobileFirst Platform v8.0 watchOS `IBMMobileFirstPlatformFoundationWatchOS` framework will work on WatchOS 4.0 as they did on watchOS 2 and 3.
Steps to be followed while developing watchOS application(s) and the limitations can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/watchos).

#### Additional Information
For more information on iOS11 features refer [here](https://www.apple.com/in/ios/ios-11/).

Stay tuned for more updates.
