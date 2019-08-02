---
title: 64-bit Google Play Store Compliance for MobileFirst  
date: 2019-05-24
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- 64-bit
- Google Play Store
version:
- 7.1
- 8.0
author:
  name: Manjunath Kallanavar
additional_authors:
- Srihari Kulkarni
---

**Update 31 Jul 2019:** A new set of JSONStore SDKs have been published ( Android Native [ibmmobilefirstplatformfoundationjsonstore v8.0.2019072505](https://search.maven.org/artifact/com.ibm.mobile.foundation/ibmmobilefirstplatformfoundationjsonstore/8.0.2019072505/aar), Cordova [cordova-plugin-mfp-jsonstore v8.0.2019072908](https://www.npmjs.com/package/cordova-plugin-mfp-jsonstore) for Mobile Foundation v8 and [iFix 7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR)for Mobile Foundation v7.1) for 64-bit compatibility. These are enhanced from the previous release and do not require the intermediate build in 32-bit mode to ensure data retention. Use these versions of the SDK to ensure JSONStore data will be retained across app upgrades irrespective of the mode and the iFix level of the SDK in the previously built app.


> **Note:** 64-bit support is provided for apps developed using MobileFirst Platform Foundation v7.1 and Mobile Foundation v8.0. If you are using MobileFirst Platform Foundation v7.0 or lower, please upgrade to the latest version of Mobile Foundation.

If you are tuned into the Android Developers Blog, then you would know by now that all apps to be published to the Google Play Store starting 1st Aug, 2019 are [required to publish both 32 and 64 bit versions of any native libraries](https://android-developers.googleblog.com/2019/01/get-your-apps-ready-for-64-bit.html).

The MobileFirst SDKs have shipped with 32-bit libraries so far. Today, we are releasing updates to the Android and Cordova plugins that comply with this Google Play Store requirement. This is applicable to both the Core SDK and the JSONStore SDK.

## FIPS 140-2 Support

One of the [known limitations](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/known-issues-limitations/#fips-104-2-feature-limitations) of MobileFirst is the restricted availability of FIPS 140-2 support for JSONStore data in 64-bit mode applications on Android. This limitation is no longer applicable if you are on JSONStore SDK level Android Native [ibmmobilefirstplatformfoundationjsonstore v8.0.2019072505](https://search.maven.org/artifact/com.ibm.mobile.foundation/ibmmobilefirstplatformfoundationjsonstore/8.0.2019072505/aar) or above, Cordova [cordova-plugin-mfp-jsonstore v8.0.2019072908](https://www.npmjs.com/package/cordova-plugin-mfp-jsonstore) or above for Mobile Foundation v8 and [iFix 7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR) or above for Mobile Foundation v7.1 .

## Backward compatibility
>**Update:** This section is not applicable if you are on JSONStore SDK level Android Native [ibmmobilefirstplatformfoundationjsonstore v8.0.2019072505](https://search.maven.org/artifact/com.ibm.mobile.foundation/ibmmobilefirstplatformfoundationjsonstore/8.0.2019072505/aar) or above, Cordova [cordova-plugin-mfp-jsonstore v8.0.2019072908](https://www.npmjs.com/package/cordova-plugin-mfp-jsonstore) or above for Mobile Foundation v8 and [iFix 7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR) or above for Mobile Foundation v7.1 .

	
The 64-bit libraries for Android will use a different encryption library for performing the encryption compared to the existing libraries that offered only 32-bit support. As a result of this, any existing JSONStore Collections on the device will not be accessible when your app is built in 64-bit mode. The existing collection will have to be destroyed and a new one created.

If data retention is essential to the app, then upgrading the app with the iFix version *8.0.0.0-MFPF-IF201905070819* (*7.1.0.0-MFPF-IF201905221643* for MobileFirst Foundation v7.1) in 32-bit mode will perform an in-place migration to use the new encryption library. Any subsequent upgrade to the app in 32 or 64-bit mode will retain the data.

## MobileFirst 8.0 apps

Before you publish your app to the Play Store with 64-bit compliance, add the following SDKs to your project.

### Cordova apps

```bash
cordova plugin remove cordova-plugin-mfp
cordova plugin remove cordova-plugin-mfp-jsonstore

cordova plugin add cordova-plugin-mfp@latest
cordova plugin add cordova-plugin-mfp-jsonstore@latest
```

Add the following line to the `<mfp:android>` section of `config.xml`(This step is not needed if you are on JSONStore SDK level Android Native [ibmmobilefirstplatformfoundationjsonstore v8.0.2019072505](https://search.maven.org/artifact/com.ibm.mobile.foundation/ibmmobilefirstplatformfoundationjsonstore/8.0.2019072505/aar) or above , Cordova [cordova-plugin-mfp-jsonstore v8.0.2019072908](https://www.npmjs.com/package/cordova-plugin-mfp-jsonstore) or above).

```bash
<mfp:mode64bit>true</mfp:mode64bit>
```
to build the app in 64-bit mode.


### Android Native apps

Edit your `app/build.gradle` file to include the following lines in the `dependencies` section.

```
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0.+'
```

Edit the `app/build.gradle` file and add the following lines in the `packagingOptions` section (This step is not needed if you are on JSONStore SDK level Android Native [ibmmobilefirstplatformfoundationjsonstore v8.0.2019072505](https://search.maven.org/artifact/com.ibm.mobile.foundation/ibmmobilefirstplatformfoundationjsonstore/8.0.2019072505/aar) or above , Cordova [cordova-plugin-mfp-jsonstore v8.0.2019072908](https://www.npmjs.com/package/cordova-plugin-mfp-jsonstore) or above).

```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```
### React-Native apps

64-bit support for Android apps on React Native is available in version starting 0.59 of [React Native](http://facebook.github.io/react-native/blog/2019/03/12/releasing-react-native-059). Support for React Native 64-bit Android apps is available in IBM Mobile Foundation from iFix *8.0.0.0-MFPF-IF201906191215* onwards.



```bash 
npm uninstall react-native-ibm-mobilefirst
npm uninstall react-native-ibm-mobilefirst-jsonstore
npm install react-native-ibm-mobilefirst@latest
npm install react-native-ibm-mobilefirst-jsonstore@latest
npm install
react-native link
```
Edit the `<ProjectName>/android/app/build.gradle` file and add the following lines in the `packagingOptions` section

```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```

## MobileFirst 7.1 apps

Install iFix version *7.1.0.0-MFPF-IF201905221643* or higher to get support for 64 bit compatibility. Before you publish your app to the Play Store with 64-bit compliance, add the appropriate SDKs to your project.


### Hybrid apps
Follow the steps provided below to add 64-bit libraries to your app

>**Update** : Below steps are not needed if you are on iFix level [7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR) or above .

#### Step 1: After you have built your `android` environment, copy the following files from

```
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/arm64-v8a/libauthjni.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/x86_64/libauthjni.so
```
to

```
<ProjectName>/apps/<ApplicationName>/android/native/libs/arm64-v8a/libauthjni.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/x86_64/libauthjni.so
```

**Optional**: If you are using JSONStore in your app, copy the following additional files from

```
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/arm64-v8a/libcrypto.so.1.1.zip
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/x86_64/libcrypto.so.1.1.zip

<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/arm64-v8a/libcrypto.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/x86_64/libcrypto.so

<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/arm64-v8a/libsqlcipher.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/64bit/x86_64/libsqlcipher.so
```
to

```
<ProjectName>/apps/<ApplicationName>/android/native/assets/featurelibs/arm64-v8a/libcrypto.so.1.1.zip
<ProjectName>/apps/<ApplicationName>/android/native/assets/featurelibs/x86_64/libcrypto.so.1.1.zip

<ProjectName>/apps/<ApplicationName>/android/native/libs/arm64-v8a/libcrypto.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/x86_64/libcrypto.so

<ProjectName>/apps/<ApplicationName>/android/native/libs/arm64-v8a/libsqlcipher.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/x86_64/libsqlcipher.so
```
> **NOTE**: If 64-bit folders x86_64 and arm64-v8a are not present in your project ,create these folders and then copy the files.

#### Step 2: Make the following build configuration

**Projects using Android Studio**

Edit the `app/build.gradle` file and add the following lines in the `packagingOptions` section

```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```

**Projects using Eclipse based ADT**

Delete the following files

```
<ProjectName>/apps/<ApplicationName>/android/native/libs/armeabi/libopenssl_fips.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/armeabi-v7a/libopenssl_fips.so
<ProjectName>/apps/<ApplicationName>/android/native/libs/x86/libopenssl_fips.so
```

### Native apps

Refer to this [documentation page](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/hello-world/configuring-a-native-android-application-with-the-mfp-sdk/#localMethod) on how to add MobileFirst libraries to a native Android app.

>**Update** : Below steps are not needed if you are on iFix level [7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR) or above.

#### Step 1: In addition to the aforementioned steps, copy the following files into the `jniLibs` path of your project

```
<ProjectName>/apps/<ApplicationName>/64bit/arm64-v8a/libauthjni.so
<ProjectName>/apps/<ApplicationName>/64bit/x86_64/libauthjni.so
```

**Optional**: If you are using JSONStore, copy these additional files into `jniLibs` path of your project.

```
<ProjectName>/apps/<ApplicationName>/64bit/arm64-v8a/libcrypto.so
<ProjectName>/apps/<ApplicationName>/64bit/x86_64/libcrypto.so

<ProjectName>/apps/<ApplicationName>/64bit/arm64-v8a/libsqlcipher.so
<ProjectName>/apps/<ApplicationName>/64bit/x86_64/libsqlcipher.so
```

```
<ProjectName>/apps/<ApplicationName>/64bit/arm64-v8a/libcrypto.so.1.1.zip
<ProjectName>/apps/<ApplicationName>/64bit/x86_64/libcrypto.so.1.1.zip
```
to the `assets/featurelibs` path of your native project.

> **NOTE**: If 64-bit folders x86_64 and arm64-v8a are not present in your project ,create these folders and then copy the files.

#### Step 2: Make the following build configuration

Edit your `app/build.gradle` file and add the following lines in the `packagingOptions` section

```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```


### Cordova apps

####  Step 1: Remove and add the the MobileFirst plugins and the `android` platform.

```
mfp cordova plugin remove cordova-plugin-mfp-jsonstore
mfp cordova plugin remove cordova-plugin-mfp
mfp cordova plugin add cordova-plugin-mfp
mfp cordova plugin add cordova-plugin-mfp-jsonstore
mfp cordova platform remove android
mfp cordova platform add android
```
>**Update** : Below steps are not needed if you are on iFix level [7.1.0.0-MFPF-IF201907301558 ](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=7.1.0.0-MFPF-IF201907301558&source=SAR) or above.

####  Step 2: Copy the following files

```
<ProjectPath>/plugins/cordova-plugin-mfp/src/android/assets/featurelibs/arm64-v8a/*
<ProjectPath>/plugins/cordova-plugin-mfp/src/android/assets/featurelibs/x86_64/*

<ProjectPath>/plugins/cordova-plugin-mfp/src/android/libs/64bit/arm64-v8a/libauthjni.so
<ProjectPath>/plugins/cordova-plugin-mfp/src/android/libs/64bit/x86_64/libauthjni.so
```
to

```
<ProjectPath>/platforms/android/assets/featurelibs/arm64-v8a/*
<ProjectPath>/platforms/android/assets/featurelibs/x86_64/*

<ProjectPath>/platforms/android/arm64-v8a/libauthjni.so
<ProjectPath>/platforms/android/x86_64/libauthjni.so
```

**Optional**: If you are using JSONStore, copy the following files additionally.

```
<ProjectPath>/plugins/cordova-plugin-mfp-jsonstore/src/android/libs/64bit/arm64-v8a/libsqlcipher.so
<ProjectPath>/plugins/cordova-plugin-mfp-jsonstore/src/android/libs/64bit/x86_64/libsqlcipher.so
```
to

```
<ProjectPath>/platforms/android/arm64-v8a/libsqlcipher.so
<ProjectPath>/platforms/android/x86_64/libsqlcipher.so
```

####  Step 3: Make the following build configuration

Edit your  `app/build.gradle` file and add the following lines in the `packagingOptions` section

 ```
packagingOptions {
   ...
   exclude 'lib/armeabi/libopenssl_fips.so'
   exclude 'lib/armeabi-v7a/libopenssl_fips.so'
   exclude 'lib/x86/libopenssl_fips.so'
}
```
