---
title: IBM MobileFirst Platform Foundation Support for iOS 12
date: 2018-07-23
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

If you are an on-premise 7.1 or 8.0 customer or [Mobile Foundation Service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn about  Mobile Foundation support for iOS 12 .

Apple announced iOS 12 during their annual WWDC2018 conference. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 12 [here](https://developer.apple.com/ios/whats-new/).

We have been testing the iOS12 beta with the latest being beta 3. We have verified various features of MobileFirst Platform Foundation on the iOS11 beta 3 for MobileFirst Platform Foundation v8.0. For reference, make sure to read through our [support plan for newer iOS version](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

We encourage you to start testing your application(s) with iOS 12.

## MobileFirst Platform Foundation Support for iOS 12(beta 3)

#### Existing application
Existing application(s) that were created using MobileFirst Platform v8.0 **will work** on iOS 12 as they did on previous versions of iOS.

#### Updating application on the App Store (built using older Xcode)
You can opt to build application(s) with Xcode 9 ( or older Xcode) and republish to the App Store. These application(s) will work on iOS 12. Make sure to build app with only 64 bit architecture.

#### Updating existing application or submitting new application on the App Store (built using Xcode 10)
Review the following section to learn what actions you need to take so that your app can support iOS 12. These needs to be considered only if you are building the application(s) using new [Xcode 10 build](https://developer.apple.com/download).

Compatibility tests with [iOS 12 beta 3](https://developer.apple.com/download) have been performed for MobileFirst Foundation 8.0 using an iPhone 6 plus that was upgraded from iOS 11.3.x to iOS 12 beta 3.

For the tests, [XCode 10 beta 2](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps. Xcode 10 uses a new build system. The new build system provides improved reliability and build performance and it catches project configuration problems that the legacy build system could not.
The legacy build system is still available in Xcode 10. To use the legacy build system, select it in the **File > Project Settings**. Refer the image below:

![Xcode10 Legacy build system settings]({{site.baseurl}}/assets/blog/2017-07-20-compatibility-tests-for-ios-12/xcode10-buildsystem.png)

For the compatibility test we had to use "legacy build system" to get rid of the issue reported [here](https://stackoverflow.com/questions/50718018/xcode-10-error-multiple-commands-produce)
For more details on Xcode 10, refer [Whats new in XCode10](https://developer.apple.com/xcode/whats-new/)  

Highlighted features that were tested for Mobilefirst Foundation 8.0:

* OAuth authorization flow
* Invoking backend procedures through adapters
* Challenge Handling
* JSONStore
* Direct Update
* Application Management
* Application Authenticity
* Remote Disable
* Device SSO

We had also verified MFP based cordova, ionic and react-native apps.

All the above features were validated to work on iOS 12 beta 3.  

### Known Issues
* Starting with iOS 12, **stdc++** library is removed from simulator runtime, but it remains in the iOS 12.0 (device) runtime for binary compatibility with shipping apps. **libstdc++** was deprecated 5 years ago. Apple's more recent platforms (tvOS and watchOS) doesn't support it.
In order to test your app on simulator, please use the workaround suggested [here](https://stackoverflow.com/questions/50694822/xcode-10-ios-12-does-not-contain-libstdc6-0-9).
Mostly, for a hybrid/cordova app we found that entry of **libstdc++** included in our project structure  was red because Xcode couldn't find the reference for it. After we removed the entry of **libstdc++** from the project structure and added the new lib instead(**libc++**), it worked without issues.
For a native app , you should remove **libstdc++** from other linker flags in your xcode project as below:
![iOS12 libstdc++  issue workaround]({{site.baseurl}}/assets/blog/2017-07-20-compatibility-tests-for-ios-12/ios12-stdlib-fix.png)

* During our compatibility test we found certificate pinning feature is not working. It looks very similar to the issue mentioned [here](https://github.com/AFNetworking/AFNetworking/issues/4229). We are currently investigating the issue. We will update here once we conclude our investigation.


> **Disclaimer:** *Some of the action items that are addressed in the list above are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

iOS11 compatibility tests are planned for following:

* Compatibility test for MobileFirst v7.1
* Push notifications
* Application Center
* Live Update SDK
* Mobile Foundation WatchOS framework with WatchOS5


*Stay tuned for more updates.*
