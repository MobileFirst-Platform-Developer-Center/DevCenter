---
title: 'Fix for FILEURIEXPOSEDEXCEPTION with cordova-plugin-camera on Android N'
date: 2017-02-14
tags:
- MobileFirst_Foundation
- Cordova
- cordova_plugin_camera
- Android_N
version:
- 7.1
- 7.0
- 6.3
author:
    name: Karen Tran
---
Starting in Android Nougat, file URIs are restricted to the scope of the same app. This access restriction causes a `FileUriExposedException` when you use the Cordova camera plugin with the Android platform. When the device's camera app passes the file URI of a photo to the Cordova camera plugin, the plugin is not allowed to access the file URI. When the plugin tries to access the URI, the exception will be thrown and the app will crash.

Cordova has created a solution which utilizes the Android support libraries' FileProvider class to create a custom URI for photos in place of file URI. Cordova's solution fixes the issue, however, it requires adding the Android Support v4 library whenever the Cordova camera plugin is installed.

The solution has been backported to three versions of MobileFirst Foundation but requires additional setup from users who uses the Cordova camera plugin. Users who do not use the Cordova camera plugin do not need to do anything.

## iFixes
The following iFixes are available for download which contains the fix for:  
APAR PI73910 FILEURIEXPOSEDEXCEPTION WITH CORDOVA CAMERA PLUGIN ON ANDROID N

- 7.1.0 IF20170212-0550 and later builds
- 7.0.0 IF20170125-1125 and later builds
- 6.3.0 IF20170206-1104 and later builds

## Additional set-up for cordova-plugin-camera users
There are additional set-up steps for using the Cordova camera plugin. They have been documented in the Knowledge Center.

- [7.1.0 Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_android_cam_api_24.html#t_android_cam_api_24)

- [7.0.0 Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.0.0/com.ibm.worklight.dev.doc/dev/t_android_cam_api_24.html)

- [6.3.0 Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSHS8R_6.3.0/com.ibm.worklight.dev.doc/dev/t_android_cam_api_24.html)

Follow the instructions in the Knowledge Center for setting up your application with the updated camera plugin.

Even if you do not target Android API 24 or above, but you use the Cordova camera plugin, you must follow these set-up steps, otherwise your app will crash.

The set-up is not necessary for those who do NOT intend to use the Cordova camera plugin.
