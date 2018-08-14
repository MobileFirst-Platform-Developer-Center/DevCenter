---
title: IBM MobileFirst and Android Pie
date: 2018-08-06
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- Android_P
version:
- 7.1
- 8.0
author:
  name: Manjunath Kallannavar
additional_authors:
- Shubha S
---


Android Pie is [here](https://blog.google/products/android/introducing-android-9-pie/) and IBM MobileFirst is ready for it. 

In our previous [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/05/mobilefirst-android-P/), we mentioned about the various new changes seen in Android Pie and what you, as a developer should be doing about it. 

With the final release of Android Pie, we have validated MobileFirst v8.0 and v7.1 and the following features work fine with Android Pie. 

* Invoking backend procedures through adapters
* Application Authenticity
* Application management
* Application Center
* JSONStore
* Direct Update
* Oauth handshake with Mobile First server 
* Push notifications (v8) 


### Targeting your apps for API level 28  

#### MobileFirst v8.0 apps 

* If you are targeting your MobileFirst v8 application for API level 28, you will have to update your Native Android project to point to the [latest MobileFirst SDK](http://search.maven.org/#artifactdetails%7Ccom.ibm.mobile.foundation%7Cibmmobilefirstplatformfoundation%7C8.0.2018071606%7Caar) `com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.2018071606`. If you are working on a Cordova project, please remove the `cordova-plugin-mfp` from your project and add the `cordova-plugin-mfp@8.0.2018080605` [version to your project](https://www.npmjs.com/package/cordova-plugin-mfp).
	
	No action is required if the `targetSdkVersion` of your apps is 27 or lower. This is essential to accommodate the [deprecated BC provider APIs](https://android-developers.googleblog.com/2018/03/cryptography-changes-in-android-p.html) in API 28. 


* If your app communicates over cleartext or HTTP, you will have to whitelist the domains to which cleartext traffic is allowed, in your apps Network security configuration. Read [this article](https://android-developers.googleblog.com/2016/04/protecting-against-unintentional.html) for more information

#### MobileFirst v7.1 apps 

For MobileFirst v7.1 apps targeting API level 28, you will have to add the legacy Apache HTTP library as a dependency in your `AndroidManifest.xml`.
Add the following line under the `<application>` tag of your `AndroidManifest.xml`.
```xml
<uses-library android:name="org.apache.http.legacy" android:required="false"/>
```
