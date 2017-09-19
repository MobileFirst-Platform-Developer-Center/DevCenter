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
  name: Sandhya Suman
additional_authors:
- Shubha S
---
Apple announced iOS 11 during their annual WWDC2017 conference. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 11 [in this news bulletin](https://developer.apple.com/ios/).

![iOS11]({{site.baseurl}}/assets/blog/2017-07-24-compatibility-tests-for-ios-11/ios11_beta.png)

We have been testing the iOS11 beta with the latest being beta 3. We have verified various features of MobileFirst Platform Foundation on the iOS11 beta 3 for MobileFirst Platform Foundation v7.1 and v8.0. For reference, make sure to read through our [support plan for Android O and iOS 11](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

We encourage you to start testing your application(s) with iOS 11.


## MobileFirst Platform Foundation Support for iOS 11(beta 3)

This blog details iOS 11 support in MobileFirst Platform v7.1 and v8.0, and the steps that developers and IT administrators might need to take.
> **Note:** Applications that are built with IBM MobileFirst Platform Foundation v7.1 and v8.0 are supported on [iOS 11 beta 3 build](https://developer.apple.com/download)

> **Disclaimer:** *Some of the action items that are addressed in the list below are not under IBM’s control. Therefore, we expect developers and IT managers to ensure that their infrastructure is up-to-date according to Apple’s requirements.*

#### Existing application
Existing application(s) that were created using MobileFirst Platform v7.1 and v8.0 **will work** on iOS 11 as they did on previous versions of iOS.

#### Updating application on the App Store (built using older Xcode)
You can opt to build application(s) with Xcode 8 (older Xcode) and republish to the App Store. These application(s) will work on iOS 11.

#### Updating existing application or submitting new application on the App Store (built using Xcode 9)
Review the following section to learn what actions you need to take so that your app can support iOS 11. These needs to be considered only if you are building the application(s) using new [Xcode 9 build](https://developer.apple.com/download).

* 64-bit Apps on iOS 11 - As Apple warned users with iOS 10.3, iOS 11 officially drops support for 32-bit applications. Any 32-bit app will refuse to launch and instead show an alert asking the developer to release a 64-bit update. Refer [here](https://developer.apple.com/news/?id=06282017b).
We highly encourage to migrate your existing apps to 64 bit.

* Swift Apps on iOS11 - [Xcode 9 build](https://developer.apple.com/download) can build targets written in only Swift 4 or Swift 3. Xcode 9 can be used for migration to Swift 4, This can be easily done using the [migration guide](https://swift.org/migration-guide).
As per Apple, If your app is written in Swift, you can submit your apps to the App Store written in either Swift 3.0 or 2.3. We strongly encourage you to migrate your code to Swift 3. However, if you need to first update your code to Swift 2.3, you can run the Xcode 8 migrator later to move from 2.3 to 3.0.
We have planned to check Swift 4.0 compatibility with MobileFirst Platform Foundation 7.1 and 8.0 in near future and will talk in another blog.

Compatibility tests with [iOS 11 beta 3](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10.3.x to iOS 11 beta 3.

For the tests, [XCode 9 beta 2](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps. For more details on Xcode 9 , refer [Whats new in XCode9](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/WhatsNewXcode/xcode_9/xcode_9.html)  

Highlighted features that were tested are:

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

All the above features were validated to work on iOS 11 beta 3.  

#### Known Issues
* Starting with iOS 11, Apple has updated [WebCrypto API](https://www.w3.org/TR/WebCryptoAPI/) in Safari 11 which is not compatible with the current MobileFirst API.Refer [Whats New In Safari  11](https://developer.apple.com/library/content/releasenotes/General/WhatsNewInSafari/Safari_11_0/Safari_11_0.html) for details.As a results, a web app consuming the Web SDK for MobileFirst will fail to launch on a device running on iOS 11. Updating to the latest version of IBM Web sdk will resolve this issue and can be downloaded from [here.](https://www.npmjs.com/package/ibm-mfp-web-sdk)

* Starting with iOS 11, Apple had updated behaviour around the status bar area which will be particularly important for developers using tools like Apache Cordova or Ionic. In particular, this change in behaviour affects any web-based apps that use fixed position header bars when they are built for iOS 11.We observed following issues.

* We observed UI contains white areas at the top and bottom of the screen when running on iPhone X simulator as below.
![iPhone X Ui Issue]({{site.baseurl}}/assets/blog/2017-07-24-compatibility-tests-for-ios-11/IPhoneX_UIIssue.png)

* As you scroll up, the content will move up behind the status bar. As you scroll down, it will again fall down below the status bar.A quick video to explain the issue and the fix is available below.

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/3JJ9UqVWjvQ"></iframe>
  </div>
</div>

In the html file of the app set ‘ viewport-fit=cover’  in viewport meta tag.    

```html
 <meta name=“viewport” content=“user-scalable=no, initial-scale=1,viewport-fit=cover, maximum-scale=1, minimum-scale=1, width=device-width”> .
```
Also in  Also in  .css file add the padding as below  under header .

```css
header { /* …other header content.. */   padding-top: constant(safe-area-inset-top);  }
```
iOS11 compatibility tests are planned for following:
* Live Update SDK
* Mobile Foundation WatchOS framework with WatchOS4

Please refer our latest [blog]({{site.baseurl}}/blog/2017/09/18/mfp-support-for-ios11/) for any further news on iOS11 compatibility.
