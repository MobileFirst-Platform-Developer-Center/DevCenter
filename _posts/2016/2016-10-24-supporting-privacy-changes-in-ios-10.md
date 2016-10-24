---
title: Supporting privacy changes in iOS 10
date: 2016-10-24
tags:
- MobileFirst_Foundation
- iOS
version:
- 8.0
- 7.1
- 7.0
- 6.3
author: 
  name: Vittal R Pai
---
Starting iOS 10, Apple made some significant changes to iOS applicaions this requires that the applications should declare private data information in the project's `Info.plist` file, in case the application is making use of private data. If declaration is not made in the `Info.plist` file it will cause the application to crash or it will be rejected while it is submitted to the App Store this holds good for enterprise applications as well. 

According to Apple the following are the list of frameworks that count as private data.

> Contacts, Calendar, Reminders, Photos, Bluetooth Sharing, Microphone, Camera, Location, Health, HomeKit, Media Library, Motion, CallKit, Speech Recognition, SiriKit, TV Provider.


Prior to MFP 8.0, MFP packages cordova plugins in hybrid applications which uses frameworks that count as private data. If these plugins are not being used in your applications, it would still crash or get rejected as Apple flags them anyway because it contains code that accesses private data even though it's not being invoked. 

There are two ways this can be resolved

#### Solution 1 (Applicable to all versions of MFP)

Declare the usage of the private data in `Info.plist` file. In case you are using camera plugin in your application.

- Open Info.plist file in Xcode project
- Add `Privacy - Camera Usage Description` Key and Usage description in your plist file 
![Camera Plist Usage]({{site.baseurl}}/assets/blog/2016-10-24-supporting-privacy-changes-in-ios-10/camera-usage.png)

Privacy setting keys for private data usage can be found [here](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html).

#### Solution 2 (Applicable only for MFP versions prior to 8.0)

Remove the plugin from Hybrid application. In case you are not using camera plugin, follow these steps to remove the plugin from your hybrid application.

- Remove the following entries from `cordova_plugins.js` located under www/worklight folder.

```javascript
    {
        "file": "plugins/org.apache.cordova.camera/www/CameraConstants.js",
        "id": "org.apache.cordova.camera.Camera",
        "clobbers": [
            "Camera"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.camera/www/CameraPopoverOptions.js",
        "id": "org.apache.cordova.camera.CameraPopoverOptions",
        "clobbers": [
            "CameraPopoverOptions"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.camera/www/Camera.js",
        "id": "org.apache.cordova.camera.camera",
        "clobbers": [
            "navigator.camera"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.camera/www/ios/CameraPopoverHandle.js",
        "id": "org.apache.cordova.camera.CameraPopoverHandle",
        "clobbers": [
            "CameraPopoverHandle"
        ]
    },
```
- Delete `org.apache.cordova.camera` folder located under www/worklight/plugins folder
- Remove `CDVCamera.h` and `CDVCamera.m` files from CordovaLib.xcodeproj

> **Note :** The above solutions need to be applied each time you install a new iFix version to the existing hybrid application for MFP versions prior to 8.0.