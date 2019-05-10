---
title: 64-bit Google Play Store Compliance for MobileFirst  
date: 2019-05-10
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- 64-bit
- Google Play Store
version:
- 7.1, 8.0
author:
  name: Manjunath Kallanavar
additional_authors:
- Srihari Kulkarni
---


If you are tuned into the Android Developers Blog, then you would know by now that all apps to be published to the Google Play Store starting 1st Aug, 2019 are [required to publish both 32 and 64 bit versions of any native libraries](https://android-developers.googleblog.com/2019/01/get-your-apps-ready-for-64-bit.html). 

The MobileFirst SDKs have shipped with 32-bit libraries so far. Today, we are releasing updates to the Android and Cordova plugins that comply with this Google Play Store requirement. This is applicable to both the Core SDK and the JSONStore SDK. Before you publish your app to the Play Store with 64-bit compliance, add the following SDKs to your project. 

#### Cordova:

```bash
cordova plugin remove cordova-plugin-mfp
cordova plugin remove cordova-plugin-mfp-jsonstore

cordova plugin add cordova-plugin-mfp@latest
cordova plugin add cordova-plugin-mfp-jsonstore@latest
```

Add the following line to the `<mfp:android>` section of `config.xml`

```bash
<mfp:mode64bit>true</mfp: mode64bit>
```
to build the app in 64-bit mode. 

#### Android:

Edit your `app/build.gradle` file to include the following lines

```
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0.+'
```

Edit the `app/build.gradle` file and add the following lines in the `packagingOptions` section 

```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```

## FIPS 140-2 Support

One of the [known limitations](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/known-issues-limitations/#fips-104-2-feature-limitations) of MobileFirst is the restricted availability of FIPS 140-2 support for JSONStore data in 64-bit mode applications on Android. With the support for 64-bit for Android applications added, this limitation will continue to prevail and Android applications built in 64-bit mode will not be FIPS 140-2 compliant. 

## Backward compatibility 

The 64-bit libraries for Android will use a different encryption library for performing the encryption compared to the existing libraries that offered only 32-bit support. As a result of this, any existing JSONStore Collections on the device will not be accessible when your app is built in 64-bit mode. The existing collection will have to be destroyed and a new one created.
 
If data retention is essential to the app, then upgrading the app with the iFix version *8.0.0.0-MFPF-IF201905070819* in 32-bit mode will perform an in-place migration to use the new encryption library. Any subsequent upgrade to the app in 32 or 64-bit mode will retain the data. 


## MobileFirst 7.1 apps 

64-bit Support for MobileFirst 7.1 apps will be announced soon. 
