---
title: IBM MobileFirst Platform Foundation Support for iOS 13
date: 2019-07-08
tags:
- MobileFirst_Platform
- Announcement
- iOS
version:
- 8.0
- 7.1
author:
  name: Sandhya Suman, 
additional_authors:  
  - Vidyasagar Gaiakwad
---


If you are an on-premise 7.1 or 8.0 customer or [Mobile Foundation Service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn about Mobile Foundation support for iOS 13.

Apple announced iOS 13 during their annual *WWDC2019* conference. You can read more about all the new features in iOS 13 [here](https://developer.apple.com/ios/whats-new/).

We have been testing the iOS 13 beta with the latest being beta 3. We have verified various features of MobileFirst Platform Foundation on the iOS 13 beta 3 for MobileFirst Platform Foundation v7.1 and v8.0. For reference, make sure to read through our [support plan for newer iOS version](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

We encourage you to start testing your application(s) with iOS 13.

## MobileFirst Platform Foundation Support for iOS 13(beta 3)

#### Existing application
Existing application(s) that were created using MobileFirst Platform v7.1 and v8.0 **will work** on iOS 13 as they did on previous versions of iOS.

Compatibility tests with [iOS 13 beta 3](https://developer.apple.com/download) have been performed using an iPhone 7 that was upgraded from iOS 12.3 to iOS 13 beta 3 for MobileFirst Foundation v8.0 and v7.1.

For the tests, [XCode 11 beta 3](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps. 

#### Submitting application to App Store 
Apps built with older Xcode(10.1 and above) can still be submitted to App Store. The minimum iOS SDK level 12.1 should be used in any newer or existing apps. Refer [here](https://developer.apple.com/ios/submit/) for details.  

#### Swift Apps on iOS13
[Xcode 11 build](https://developer.apple.com/download) can build targets written in only **Swift 4.0** or above. Swift 5.0 with ABI is available since Xcode 10.2, migration tools are available with Xcode 13 as well to migrate to Swift 5.0. 

As per Apple you can submit apps in **Swift 4.0** to the App Store and migrate individual modules to Swift 5 when you are ready. We strongly encourage you to migrate your code to **Swift 5.0**.

Features that were tested for Mobilefirst Foundation (MFP) v7.1 and v8.0:

* OAuth Flow
* Invoking backend procedures through adapters
* Challenge Handling
* JSONStore
* Direct Update
* Application Management
* Application Authenticity
* Remote Disable
* Device SSO
* Push notifications
* Certificate Pinning

We have also verified MFP based cordova, ionic and react-native apps.

All the above features were validated to work on iOS 13 beta 3.  

iOS 13 compatibility tests are planned for the following:

* Application Center
* watchOS
* iPadOS

*Stay tuned for more updates.*

> **Disclaimer:** *Some of the action items that are addressed in the list above are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*
