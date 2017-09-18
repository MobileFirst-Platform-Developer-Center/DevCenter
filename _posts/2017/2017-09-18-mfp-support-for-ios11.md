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

Every year Apple releases a new iOS iteration, and with every release we keep our promise to customer by ensuring compatibility, embracing iOS changes smoothly with minimal impacts. With this years Apple release of iOS11, we are pleased to announce that we extend MobileFirst Platform Foundation v7.1 and v8.0 support on iOS 11.And even better we dont need an update for iOS11 for MobileFirst Platform Foundation v8.0 except IBM Web SDK.

For reference, make sure to read through our [support plan for Android O and iOS 11](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

We have been testing the iOS11 beta version and details can be seen [Compatibility tests for iOS 11.]({{site.baseurl}}/blog/2017/07/24/compatibility-tests-for-ios-11/).  We have verified various features of MobileFirst Platform Foundation on the iOS11 seed build as well for MobileFirst Platform Foundation v7.1 and v8.0.
MobileFirst Platform Foundation v7.1, v8.0 has embraced iOS 11 very well except few UI glitches, we tested a bunch of feature like connection to the server, OAuth flow, form based authentication, invoking of JavaScript adapters, push notifications, AppCenter, remote disable to name a few .All these features work well, however we did notice few issues which we have documented here.

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Known Issues
* Starting with iOS 11, Apple had updated WebCrypto API in Safari 11 which is not compatible with the current MobileFirst API.  As a result, the MobileFirst Mobile and Web app might failed to start when the device has upgraded to iOS 11. Updating to the latest version of IBM Web sdk will resolve this issue and can be downloaded from [here.](https://www.npmjs.com/package/ibm-mfp-web-sdk)

* Starting with iOS 11, Apple had updated behaviour around the status bar area which will be particularly important for developers using tools like Apache Cordova or Ionic. In particular, this change in behaviour affects any web-based apps that use fixed position header bars when they are built for iOS 11.As you scroll up, the content will move up behind the status bar. Updating to the [latest iFix](TBD) of IBM MobileFirst Platform Foundation v7.1 will resolve the above issue. For MobileFirst Platform Foundation v8.0, developer can fix on their own as fix suggested on [Known Issues for iOS 11.]({{site.baseurl}}/blog/2017/07/24/compatibility-tests-for-ios-11/).

* We also see issue when using command "cordova emulate ios" similar to one reported [here]( https://github.com/phonegap/ios-sim/issues/218).

### WatchOS 4
Apple has released WatchOS 4 alongside iOS 11.To support watchOS 2 onwards, MobileFirst Platform provides a framework `IBMMobileFirstPlatformFoundationWatchOS` along with the core `IBMMobileFirstPlatformFoundation` framework. This framework can be used in WatchKit extension in the Xcode project.

Existing application(s) that were created using MobileFirst Platform v8.0 watchOS `IBMMobileFirstPlatformFoundationWatchOS` framework will work on WatchOS 4.0 as they did on watchOS 2 and 3.
Steps to be followed while developing watchOS application(s) and the limitations can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/watchos)

#### Additional Information
For more information on iOS11 features refer [here](https://www.apple.com/in/ios/ios-11/)

Stay tuned for more updates.
