---
title: MobileFirst Platform Foundation compatibility for Android O
date: 2017-07-03
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- Android_O
version:
- 7.1
- 8.0
author:
  name: Manjunath Kallannavar
additional_authors:
- Srihari Kulkarni
---

Google announced the next version of Android which is [Android O](https://developer.android.com/preview/index.html) in March 2017. The developer preview of Android O has been available for a while now for testing, development, and feedback. Android O introduces a variety of new [features and capabilities](http://www.androidauthority.com/android-8-0-review-758783/) like Notification channels, Autofill Framework, Picture-in-Picture mode etc. for end users.

We have been testing the developer previews of Android O with the latest being DP 3. We have verified all of the features of MobileFirst Platform Foundation on the developer previews of Android O for MobileFirst Platform Foundation v7.1 and v8.0. For reference, make sure to read through our [support plan for Android O and iOS 11](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/).

Invoking backend procedures through adapters, Application Authenticity, Application management, Direct Update, JSON Store and Unified Push notifications are some of the notable features of MobileFirst Platform Foundation that were verified for compatibility with Android O.

Our tests have also ensured that native Android as well as hybrid/Cordova apps built on older versions of Android perfectly works on the developer previews of Android O. We have also ensured integrity of apps on devices that upgrade from Android N to Android O.

### Known Issues
>If the **compileSdkVersion** and the **targetSdkVersion** of an application is set to _**API level 26**_, the `JSONStoreCollection.init()` API will fail with the following error
>
>```
java.lang.UnsatisfiedLinkError: dlopen failed: library "libutils.so" not found.
```
>
>This issue is not seen if the `compileSdkVersion` and `targetSdkVersion` are set to 25 or lower.
>We are working on resolving this issue. Watch this post for updates.

We encourage you to start testing your applications with the developer previews of Android O. We would love to read your comments below.  

>Watch this post for more updates, as we continue to update our findings on the future developer previews of Android O.
