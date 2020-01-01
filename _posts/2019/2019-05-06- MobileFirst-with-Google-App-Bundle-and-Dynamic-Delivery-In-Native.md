---
title: MobileFirst with Google App Bundle and Dynamic Delivery In Native Android Apps
date: 2019-06-13
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- Android App Bundle
- Dynamic Delivery
- Google Play Store
version:
- 8.0
author:
  name: Yash Soni
additional_authors:
  - Srihari Kulkarni
  - Manjunath Kallannavar
---

[Google I/O 2018](https://events.google.com/io2018/) announced a new publishing format for Android Developers - [Android App Bundle](https://developer.android.com/platform/technology/app-bundle).

App Bundle enables you to deliver an optimised app to the end user, this is significantly smaller in size than using the traditional *apk*. This technology extends to enable developers to roll out features on demand to users with [Dynamic Delivery](https://developer.android.com/studio/projects/dynamic-delivery#dynamic_feature_modules).


### MobileFirst with Dynamic Delivery
####  Configuration

To create your app with Android App Bundle and Dynamic Delivery features follow the blog [Get started with Android App Bundles ](https://developer.android.com/guide/app-bundle/#get_started).

To call MobileFirst APIs from the base application module of a multi-feature app, no additional configuration is required.

To call MobileFirst APIs in feature modules, use the `api` declaration instead of `implementation`. Using implementation will restrict the access of the MobileFirst APIs within the same module, while using `api`  would make MobileFirst APIs available across all modules present in the app including feature modules. For more details read [API and implementation separation](https://docs.gradle.org/current/userguide/java_library_plugin.html#sec:java_library_separation).

Make the following changes in the **build.gradle** file of your base app to call MobileFirst APIs from an app enabled for Dynamic Delivery.

**From**

```
implementation ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0+’
```
```
implementation ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0+
```
```
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
```

**To**

```
api ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0+’
```

```
api ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0+’
```

```
api 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
```
####Limitation:

**Due to the difference in packaging structure of an App Bundle between Android 5.x and Android 6.x & above devices, users on Android 5.x will not be able to connect to a MobileFirst server when App Authenticity is enabled and distributed as an App Bundle on Play Store. This limitation is observed only with combination of Android 5.x + App Authenticity + Android App Bundle. As a workaround, upload your app as a regular .apk file to the Play Store or restrict the minimum Android version to Android 6 or above or have a separate version of the app for Android 5.x devices.** 


We have validated all the MobileFirst functionalities from both base module and feature module of an Android Native app. You can exploit the Google App Bundle and Dynamic Delivery features with your MobileFirst native Android apps. Refer to the MobileFirst Native Android sample app with App Bundle and Dynamic Delivery features from [here](https://github.com/MobileFirst-Platform-Developer-Center/mfp-appbundle-sample).
