---
title: Compatibility tests for iOS 11 with supported MobileFirst Platform Foundation releases
date: 2017-07-24
tags:
- MobileFirst_Platform
- iOS
version:
- 8.0
- 7.1

author:
  name: Shubha S., Sandhya Suman
---
Apple announced iOS 11 during their annual WWDC2017 conference. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 11 [in this news bulletin](https://developer.apple.com/ios/).

![iOS11]({{site.baseurl}}/assets/blog/2017-07-24-compatibility-tests-for-ios-11/ios11_beta.png)

We encourage you to start testing your application(s) with iOS 11.

#### **Latest Update !!**
Apple released [iOS 11 beta 3](https://developer.apple.com/download/) build to developers, including all the new features and changes.

## MobileFirst Platform Foundation Support for iOS 11(beta 3)

This blog details iOS 11 support in MobileFirst Platform v7.1 and v8.0, and the steps that developers and IT administrators might need to take.
> **Note:** Applications that are built with IBM MobileFirst Platform Foundation v7.1 and v8.0 are supported on [iOS 11 beta 3 build](https://developer.apple.com/download)

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Existing application
Existing application(s) that were created using MobileFirst Platform v7.1 or later **will work** on iOS 11 as they did on previous versions of iOS.

#### Updating application on the App Store (built using older Xcode)
You can opt to build application(s) with Xcode 8 (older Xcode) and republish to the App Store. These application(s) will work on iOS 11.

#### Updating existing application or submitting new application on the App Store (built using Xcode 9)
Review the following section to learn what actions you need to take so that your app can support iOS 11. These needs to be considered only if you are building the application(s) using new [Xcode 9 build](https://developer.apple.com/download).

* [Xcode 9 build] can build targets written in only Swift 4 or Swift 3. It also does not provide tool to convert to Swift 3. iOS applications written in Swift version below than 3 need to be migrated to Swift 3 or Swift 4. This can be easily done using the migration guide [provided by Apple](https://swift.org/migration-guide).

<br>
Compatibility tests with [iOS 11 beta 3](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 7.1 and 8.0 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10.3.x to iOS 11 beta 3.

For the tests, [XCode 9 beta 2](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are:

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics
* Push notifications

All the above features were validated to work on iOS 11 beta 3.  

#### Known Limitation
Existing JSONStrore app does not work as expected when device is upgraded from iOS 10 to iOS 11. We will continue to investigate the issue.

<br>
Please continue to watch out this space for any new updates related to iOS 11 Support.
