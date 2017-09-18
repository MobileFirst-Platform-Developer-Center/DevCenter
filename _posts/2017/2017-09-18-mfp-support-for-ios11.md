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
The MobileFirst Platform Foundation v7.0 to v7.0 are supported on iOS 10.

We have been testing the iOS11 beta version and details can be seen [Compatibility tests for iOS 11.]({{site.baseurl}}/blog/2017/07/24/compatibility-tests-for-ios-11/).  We have verified various features of MobileFirst Platform Foundation on the iOS11 seed build as well as for MobileFirst Platform Foundation v7.1 and v8.0. For reference, make sure to read through our [support plan for Android O and iOS 11](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

MobileFirst Platform Foundation v7.0, v7.1 has embraced iOS 11 very well, we tested a bunch of feature like connection to the server, OAuth flow, form based authentication, invoking of JavaScript adapters, push notifications. All these features work well, however we did notice few issues which we have documented here.


> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Known Issues
* Starting with iOS 11, Apple had updated WebCrypto API in Safari 11 which is not compatible with the current MobileFirst API.  As a result, the MobileFirst Mobile and Web app might failed to start when the device has upgraded to iOS 11.
The fix is added to IBM Web SDK , can be downloaded from [here.](https://www.npmjs.com/package/ibm-mfp-web-sdk)

* Starting with iOS 11, Apple had updated behaviour around the status bar area which will be particularly important for developers using tools like Apache Cordova or Ionic. In particular, this change in behaviour affects any web-based apps that use fixed position header bars when they are built for iOS 11.As you scroll up, the content will move up behind the status bar. As you scroll down, it will again fall down below the status bar.A quick demo to cover the issue and the fix is  [here.]https://www.youtube.com/watch?v=3JJ9UqVWjvQ&feature=youtu.be

In the html file of the app set ‘ viewport-fit=cover’  in viewport meta tag.    

```html
 <meta name=“viewport” content=“user-scalable=no, initial-scale=1,viewport-fit=cover, maximum-scale=1, minimum-scale=1, width=device-width”> .
```
Also in  Also in  .css file add the padding as below  under header .

```html
header { /* …other header content.. */   padding-top: constant(safe-area-inset-top);  }
```

iOS11 compatibility tests are planned for following:
* MobileFirst Xamarin Application
* Live Update SDK
* Mobile Foundation WatchOS framework with WatchOS4

Please continue to watch out this space for any new updates related to iOS 11 Support.


### WatchOS 4
Apple has released WatchOS 3 alongside iOS 10, a new version of the Watch operating system for Apple Watch which brings in massive improvements to the OS.

To support watchOS 3, MobileFirst Platform provides a framework `IBMMobileFirstPlatformFoundationWatchOS` along with the core `IBMMobileFirstPlatformFoundation` framework. This framework can be used in WatchKit extension in the Xcode project.

The watch application, as any regular iOS application, should be registered as a separate application in the MobileFirst Operations Console using the Bundle Identifier of the WatchKit Extension. That application is independent from its iPhone counterpart and has its own security. It should define its own Challenge Handler just like a native iOS application.

Existing application(s) that were created using MobileFirst Platform v8.0 watchOS `IBMMobileFirstPlatformFoundationWatchOS` framework will work on WatchOS 3.0 as they did on watchOS 2e.
Steps to be followed while developing watchOS application(s) and the limitations can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/watchos)

### MobileFirst Xamarin Application

Similar to the Mobilefirst native iOS SDK, the [IBM MobileFirst SDK for Xamarin](https://components.xamarin.com/view/ibm-worklight?version=8.0.0.1) has also been successfully validated with iOS 10. Existing application(s) created using the IBM MobileFirst SDK for Xamarin will work on iOS 10.

#### Additional Information
[WWDC 2016.](https://developer.apple.com/videos/wwdc2016/)

> **Note:** For compatibility results between iOS 10 and MobileFirst Platform releases, see the blog post: [Compatibility tests for iOS 10 with supported MobileFirst Platform Foundation releases]({{site.baseurl}}/blog/2016/07/01/compatibility-tests-for-ios-10/).
