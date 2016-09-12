---
title: Compatibility tests for iOS 10 with supported MobileFirst Platform Foundation releases
date: 2016-07-01
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
Apple announced iOS 10 mid-June during their annual WWDC conference. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 10 [in this news bulletin](http://www.apple.com/newsroom/2016/06/apple-previews-ios-10-biggest-ios-release-ever.html).

We encourage you to start testing your application(s) with iOS 10. Please see [our support plan for iOS 10]({{site.baseurl}}/blog/2016/06/05/support-plan-for-ios-10/).

#### **Latest Update !!**
Apple released [iOS 10.0.1 GM seed](https://developer.apple.com/download) build for developers, including all the new features and changes - this will be available to public on September 13 for iPhone, iPad and iPod touch. 

## MobileFirst Platform Foundation Support for iOS 10.0.1 (Seed GM build)

This blog details iOS 10 support in MobileFirst Platform v6.3 to v8.0, and the steps that developers and IT administrators might need to take.
> **Note:** Applications that are built with IBM MobileFirst Platform Foundation v6.3 to v8.0 are supported on [iOS 10 GM Seed build](https://developer.apple.com/download)

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Existing application
Existing application(s) that were created using MobileFirst Platform v6.3 or later **will work** on iOS 10 as they did on previous versions of iOS.


#### Updating application on the App Store (built using older Xcode)
You can opt to build application(s) with Xcode 7 (older Xcode) and republish to the App Store. These application(s) will work on iOS 10.


#### Updating existing application or submitting new application on the App Store (built using Xcode 8)
Review the following sections to learn what actions you need to take so that your app can support iOS 10. These needs to be considered only if you are building the application(s) using new [Xcode 8 Seed build](https://developer.apple.com/download).

* If your application uses the `KeyChain` implementation, your app might crash because of `KeyChain` - It happens because Apple changed the way of working with keychain in iOS 10. To fix this issue you simply should go to Targets->Capabilities and enable keychain sharing.
* If your application is using `Push notification` feature, Make sure sure you have turned on Push Capability in you project.
   - If you have developed an application which uses push feature on or below Xcode v7 and whenever opened a same project in Xcode 8, Please make sure that Push capability feature is enabled in XCode Project.
* `NSContactsUsageDescription` or `NSMicrophoneUsageDescription` keys are now mandatory in the plist file while accessing contacts or microphone in cordova/hybrid iOS application. This affects users who use `cordova-plugin-contact` or `cordova-plugin-media` API's. The fix is simply to include those keys in application plist file.
* iOS applications written in Swift need to be migrated to Swift 3.0 or Swift 2.3. This can be easily done using the migration guide [provided by Apple](https://swift.org/migration-guide).

Please continue to watch out this space for more updates as we do more validations and target to the test final GA builds when they become available(expected on September 13).

<br><br><br>

### Audit History (iOS 10 Beta testing-activities) :

#### iOS 10 beta 1

Compatibility tests with [iOS 10 beta 1](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 9.3.3 to iOS 10 beta 1.

For the tests, [XCode 8 beta 1](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 1.  


#### iOS 10 beta 2

Compatibility tests with [iOS 10 beta 2](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 1 to iOS 10 beta 2.

For the tests, [XCode 8 beta 2](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 2.  

#### iOS 10 beta 3

Compatibility tests with [iOS 10 beta 3](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 2 to iOS 10 beta 3.

For the tests, [XCode 8 beta 3](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 3.

#### iOS 10 beta 4

Compatibility tests with [iOS 10 beta 4](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 3 to iOS 10 beta 4.

For the tests, [XCode 8 beta 4](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management

All the above features were validated to work on iOS 10 beta 4. 

#### iOS 10 beta 7

Compatibility tests with [iOS 10 beta 7](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 4 to iOS 10 beta 7.

For the tests, [XCode 8 beta 6](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Mobilefirst Application Center

All the above features were validated to work on iOS 10 beta 7. 