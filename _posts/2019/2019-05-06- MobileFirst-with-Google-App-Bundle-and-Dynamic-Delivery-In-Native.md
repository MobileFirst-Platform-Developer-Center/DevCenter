
title: MobileFirst with Google App Bundle and Dynamic Delivery In Native Android Apps
date: 2019-05-06
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


[Google I/O 2018](https://events.google.com/io2018/) announced a new publishing format for Android Developers - [Android App Bundle](https://developer.android.com/platform/technology/app-bundle). 

App Bundle enables you to deliver an optimised App to the end user which is significantly smaller in size than using the traditional apk. This technology extends to enable developers to roll out features on demand to users with [Dynamic Delivery](https://developer.android.com/studio/projects/dynamic-delivery#dynamic_feature_modules).


###MobileFirst with Dynamic Delivery 
####Configuration 

To create your app with Android App Bundle and Dynamic Delivery features follow the blog [Get started with Android App Bundles ](https://developer.android.com/guide/app-bundle/#get_started)

To call MobileFirst APIs from the base application module of a multi-feature app,no additional configuration is required.

To call MobileFirst APIs in a feature modules, use the `api` declaration instead `implementation`.Using implementation will restrict the access of the MobileFirst APIs within the same module, while using `api`  would make MobileFirst APIs available across all modules present in the app including feature modules.For more details read [API and implementation separation](https://docs.gradle.org/current/userguide/java_library_plugin.html#sec:java_library_separation).

Make the following change in your base app's **build.gradle** file in order to call MobileFirst APIs from an app enabled for Dynamic Delivery

From

```
implementation ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0+’ 
```
```
implementation ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0+
```
```
implementation 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
```

To 

```
api ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0+’ 
```

```
api ’com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0+’ 
```

```
api 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
```

 
We have validated all the MobileFirst functionalities from both base module and feature module of an Android Native app.You can exploit Google App Bundle and Dynamic Delivery features with your MobileFirst native Android apps.Refer the MobileFirst Native Android sample app with App Bundle and Dynamic Delivery features placed [here](https://github.com/MobileFirst-Platform-Developer-Center/mfp-appbundle-sample) .

