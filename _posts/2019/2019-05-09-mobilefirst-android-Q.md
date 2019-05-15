---
title: Mobile Foundation compatibility for Android Q Beta version
date: 2019-05-10
tags:
- MobileFirst_Platform
- Mobile_Foundation
- Announcement
- Android_Q
version:
- 8.0
- 7.1
author:
  name: Vidyasagar Gaikwad
additional_authors:
 - Shubha S
---


Google has announced the next version of Android, which is [Android Q](https://developer.android.com/preview/overview). The developer preview of Android Q was launched in March 2019 and has been available for a while now for testing, development, and feedback. Android Q introduces a variety of new [features and capabilities](https://developer.android.com/preview/features.html) for end users, which gives security enhancements (such as improved biometric authentication dialogs, improved fallback support for device credentials), TLS 1.3 support, connectivity, system-wide dark mode, permissions usage, built-in screen record features and many more.

We have been testing the developer previews of Android Q Beta 2. We have verified various features of [Mobile Foundation](https://cloud.ibm.com/catalog/services/mobile-foundation) on the developer previews of Android Q for Mobile Foundation. v7.1 and v8.0.

## Mobile Foundation Support for Android Q(Beta 2)
This post provides details about Android Q support in Mobile Foundation v7.1 and v8.0, and the steps that developers and IT administrators might need to take.

Here are some notable feature compatibility tests that were performed using Android Q with Mobile Foundation v7.1 and v8.0.

Mobile Foundation v8.0:

* Invoking backend procedures through adapters 
* Application Authenticity
* Application management
* JSONStore
* Direct Update 
* Oauth Flow 
* Certificate pinning
* Device SSO
* Analytics
* Push Notifications


Mobile Foundation v7.1:

* Adapter Integration
* Direct Update
* Application Management
* Application Authenticity
* Certificate Pinning
* JSONStore
* Authorization Flow
* Analytics



### Existing applications
Our tests have also ensured that native Android and hybrid/Cordova apps built on older versions of Android work on the developer previews of Android Q. We have also ensured the integrity of apps on devices that upgrade from Android P to Android Q.


### Known Issues
After upgrading to Android Q if the targetSdkVersion is set to API Level 'Q', the application will crash by throwing an exception `java.lang.NoClassDefFoundError:failed resolution of :Lorg/apache/http/ProtocolVersion`, which is an Android bug, [find the issue tracker here](https://issuetracker.google.com/issues/79478779). The applications that are built using MobileFirst 7.1 version are affected by this.
You should be able to workaround this issue by adding this line to your `AndroidManifest.xml` under `<application>` tag.
 ```xml
  <uses-library android:name="org.apache.http.legacy" android:required="false"/>
 ```
 

We encourage you to start testing your applications with the developer previews of [Android Q](https://developer.android.com/preview/get). We would love to hear back from you.  

>Watch this post for more updates, as we continue to update our findings on the future developer previews of Android Q.

