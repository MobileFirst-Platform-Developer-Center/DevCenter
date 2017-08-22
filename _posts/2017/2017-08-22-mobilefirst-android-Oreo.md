---
title: MobileFirst Platform Foundation compatibility for Android Oreo Version 
date: 2017-08-21
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android_Oreo
version:
- 7.1
- 8.0
author:
  name: Shubha S
additional_authors:
- Srihari Kulkarni
---

On the day of the first total solar eclipse to sweep across the US in 99 years, Google made the next version of their Android operating system 'Android Oreo'. Over the air (OTA) updates of Android O are now available for download on select Pixel and Nexus devices. [Head here](https://developer.android.com/about/versions/o/download.html) to see if your device is listed. 

Android Oreo has introduced a variety of new [features and capabilities](http://www.androidauthority.com/android-8-0-review-758783/) like notification channels and notification dots for managing push notifications, Picture-in-Picture mode, autofill framework for managing user input. Behind the scenes, Android Oreo also introduces changes to limits on backgound operations and background location tracking. 

###What does it mean for MobileFirst apps ?

In general, both native and hybrid/Cordova apps built with IBM MobileFirst v7.1 and 8.0 play well with Android Oreo. 

In our [earlier blog post from March 2017](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/03/mobilefirst-android-o/), we had documented our experience with the developer previews of Android O. With the release version of Android Oreo too, 
we have verified all of the features of MobileFirst Platform Foundation. 

Here is a list of features of MobileFirst Platform Foundation that were verified for compatibility with Android Oreo.

- Invoking backend procedures through adapters
- Application Authenticity
- Application management
- Direct Update
- JSON Store 
- Unified Push notifications
- Operational Analytics 

Our tests have also ensured that native Android as well as hybrid/Cordova apps built on older versions of Android perfectly works on the Android Oreo when a device is upgraded through an OTA. We have also ensured integrity of apps on devices that upgrade from Android N to Android O. 

### Known Issues
There are no known outstanding issues with Android O - so with the latest iFix levels of MobileFirst 7.1 and 8.0, you should be ready to roll. 

How has your experience with Android Oreo been ? Anything you liked in particular ? Feel free to chime in with your comments. 
