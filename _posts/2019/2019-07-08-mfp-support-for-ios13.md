---
title: IBM MobileFirst Platform Foundation Support for iOS 13
date: 2019-09-09
tags:
- MobileFirst_Platform
- Announcement
- iOS
version:
- 8.0
- 7.1
author:
  name: Sandhya Suman
additional_authors:  
  - Vidyasagar Gaikwad
---

> **Update:** Please refer our latest [blog]({{site.baseurl}}/blog/2019/09/19/IBM-MobileFoundation-iOS13/) for the latest news on iOS13 compatibility with MobileFirst .

If you are an on-premise 7.1 or 8.0 customer or [Mobile Foundation Service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn about Mobile Foundation support for iOS 13.

Apple announced iOS 13 during their annual *WWDC2019* conference. You can read more about all the new features in iOS 13 [here](https://developer.apple.com/ios/whats-new/).

We have been testing the iOS 13 beta with the latest being beta 3. We have verified various features of MobileFirst Platform Foundation on the iOS 13 beta 3 for MobileFirst Platform Foundation v7.1 and v8.0. For reference, make sure to read through our [support plan for newer iOS version](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

We encourage you to start testing your application(s) with iOS 13.

## MobileFirst Platform Foundation Support for iOS 13 (beta 3)

#### Existing application
Existing application(s) that were created using MobileFirst Platform v7.1 and v8.0 **will work** on iOS 13 as they did on previous versions of iOS.

Compatibility tests with [iOS 13 beta 3](https://developer.apple.com/download) have been performed using an iPhone 7 that was upgraded from iOS 12.3 to iOS 13 beta 3 for MobileFirst Foundation v7.1 and v8.0.

For the tests, [XCode 11 beta 3](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps. 

#### Submitting application to App Store 
Apps built with older Xcode(10.1 and above) can still be submitted to App Store. The minimum iOS SDK level 12.1 should be used in any newer or existing apps. Refer [here](https://developer.apple.com/ios/submit/) for details.  

#### Swift Apps on iOS13
[Xcode 11 build](https://developer.apple.com/download) can build targets written in only **Swift 4.0** or above. Swift 5.0 with ABI is available since Xcode 10.2, migration tools are available with Xcode 13 as well to migrate to Swift 5.0. 

As per Apple you can submit apps in **Swift 4.0** to the App Store and migrate individual modules to Swift 5 when you are ready. We strongly encourage you to migrate your code to **Swift 5.0**.

Features that were tested for Mobilefirst Foundation (MFP) v8.0:

* OAuth Flow
* Invoking backend procedures through adapters
* Challenge Handling
* JSONStore
* Direct Update
* Secure Direct Update
* Application Management
* Application Authenticity
* Remote Disable
* Device SSO
* Push notifications
* Certificate Pinning

Features that were tested for Mobilefirst Foundation (MFP) v7.1:
* JSONStore
* Direct Update
* Application Management
* Application Authenticity
* Remote Disable
* Device SSO
* Push notifications
* Certificate Pinning

>**Update:** Above features are tested on iPad OS and no issues were found.

#### Known Issues

##### Too Many HTTP Redirect on v7.1
While Testing OAuth Flow on v7.1 we found the following issues in App.

![too many HTTP redirect]({{site.baseurl}}/assets/blog/2019-07-08-mfp-support-for-ios13/too many HTTP redirect.png)

The feature impacted because of the issues are 

* OAuth Flow
* Invoking backend procedures through adapters
* Challenge Handling

>**Update:** We don't see `Too Many HTTP Redirect` issue anymore with iOS 13 beta 8. Therefore, we are not publishing any fixes for the issue.

##### CNCopyCurrentNetworkInfo Returns Nil
MobileFirst SDK for v7.1 makes use of `CNCopyCurrentNetworkInfo` inside `Device->wifi->getConnectedAccessPoint` API. As per Apple iOS 13 guideline one of the following conditions should be met in order to get a correct response from `CNCopyCurrentNetworkInfo`, else it returns nil.
- The app uses Core Location, and has the user's authorization to use location information.
- The app uses the NEHotspotConfiguration API to configure the current Wi-Fi network.
- The app has active VPN configurations installed.

Learn more by reading the updated documentation or viewing the the Advances in Networking session video from WWDC19. Also refer [here](
https://developer.apple.com/documentation/systemconfiguration/1614126-cncopycurrentnetworkinfo
), for more details.

Apple further recommends *If your app is using this API, we encourage you to adopt alternative approaches that don't require Wi-Fi or network information. Valid SSID and BSSID information from CNCopyCurrentNetworkInfo will still be provided to VPN apps, apps that have used NEHotspotConfiguration to configure the current Wi-Fi network, and apps that have obtained permission to access user location through Location Services.*

##### Push Notification Registration Issue
While fresh installation of apps using MobileFirst Push notification on iOS 13, regresitration is failing due to error in parsing the token from APNS server. The issue is similar to one reported on [Apple developer Forum](https://forums.developer.apple.com/thread/117545). Also, this issue is seen only on Xcode v11 with iOS 13 devices. Applications built using Xcode v10.2 will not see the issue.

>**Note** Customer should upgrade to cocopod version `IBMMobileFirstPlatformFoundationPush@8.0.2019082914` for v8 native app and npm version `cordova-plugin-mfp-push@8.0.2019090606` for v8 cordova apps.

#### WatchOS 6
We have verified basic OAuth Flow and Application Authenticity on watchOS 6.

#### iPadOS 13
iPadOS 13 doesnt have a separate SDK with Xcode 11 beta. iPAD available with Xcode11 still using iOS 13 only.

![iPadOS 13 deployment info]({{site.baseurl}}/assets/blog/2019-07-08-mfp-support-for-ios13/iPadOS 13 deployment info.png)

![xcode11SDKs]({{site.baseurl}}/assets/blog/2019-07-08-mfp-support-for-ios13/xcode11SDKs.png)


>**Update:** We had used iPadOS 13 beta restore images on iPad and verified all Major features of MFP.


We have also verified MFP based cordova, ionic and react-native apps.

All the above features were validated to work on iOS 13 beta 3.  

iOS 13 compatibility tests are planned for the following:

* Application Center


*Stay tuned for further updates.*

> **Disclaimer:** *Some of the action items that are addressed in the list above are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*
