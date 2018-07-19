---
title: MobileFirst Platform Foundation compatibility for Android P Beta Version
date: 2018-07-05
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- Android_P
version:
- 7.1
- 8.0
author:
  name: Shubha S
---


Google announced the next version of Android, which is [Android P](https://android-developers.googleblog.com/2018/03/previewing-android-p.html) in March 2018. The developer preview of Android P was launched in March 2018 and has been available for a while now for testing, development, and feedback. Android P introduces a variety of new [features and capabilities](https://developer.android.com/preview/features) for end users, such as built-in support for notches, display cutout support, animation, HDR VP9 video, multi-camera support, notifications, indoor positioning with Wi-Fi RTT and many more.

We have been testing the developer previews of Android P with the latest being Beta 2. We have verified various features of [MobileFirst Platform Foundation](https://console.bluemix.net/catalog/services/mobile-foundation) on the developer previews of Android P for MobileFirst Platform Foundation v7.1 and v8.0.

## MobileFirst Platform Foundation Support for Android P(Beta 2)
This post provides details about Android P support in MobileFirst Platform v7.1, v8.0 and the steps that developers and IT administrators might need to take.

Here are some notable feature compatibility tests that are performed using Android P with MobileFirst 7.1 and 8.0 version.
Mobilefirst 8.0:

* Invoking backend procedures through adapters 
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Oauth Flow 
* Certificate pinning
* Device SSO

MobileFirst 7.1:

* Invoking backend procedures through adapters
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Authorization Flow


#### Existing applications
Our tests have also ensured that native Android, as well as hybrid/Cordova apps built on older versions of Android, works on the developer previews of Android P. We have also ensured the integrity of apps on devices that upgrade from Android O to Android P.

### Known Issues

* Starting with Android P the crypto provider support has been removed [check here for more information](https://android-developers.googleblog.com/2018/03/cryptography-changes-in-android-p.html). The MobileFirst SDK for Android is affected by this change. A fix is being worked upon and will be made available in a future iFix. As a developer, you will have to consume this iFix to be compatible with Android P. 
	If you want to target to API level 28 then it is recommended to use the minimum API level as 18. If you want to target devices which are of API 17 and lower, specify the target version as API 27 or lower.

* After upgrading to Android P if the targetSdkVersion is set to API 28, the application will crash by throwing an exception as `java.lang.NoClassDefFoundError:failed resolution of :Lorg/apache/http/ProtocolVersion`, which is an Android bug, [find the issue tracker here](https://issuetracker.google.com/issues/79478779). The applications that are built using MobileFirst 7.1 version are affected by this.
You should be able to workaround this issue by adding this line to your `AndroidManifest.xml` directly under `<application>` tag.
 ```xml
  <uses-library android:name="org.apache.http.legacy" android:required="false"/>
 ```
* Currently Push support is not available on MobileFirst for Android P. We are working on it, and will be updating the blog soon with our investigation results .
### Other notes
Android had provided the `android:usesCleartextTraffic` attribute in the Android manifest file to protect against unintentional switch over to clear text communication over HTTP from HTTPS. This has been around since Android M. However, starting with Android P, the default setting has been changed to block clear text traffic. If you would, however, want to continue to send information in clear text to a specific domain, you have to explicitly opt-in for specific domains [as detailed in this blog post](https://android-developers.googleblog.com/2016/04/protecting-against-unintentional.html).

We encourage you to start testing your applications with the developer previews of Android P [here](https://www.google.com/android/beta). We would love to hear back from you.  

>Watch this post for more updates, as we continue to update our findings on the future developer previews of Android P.
