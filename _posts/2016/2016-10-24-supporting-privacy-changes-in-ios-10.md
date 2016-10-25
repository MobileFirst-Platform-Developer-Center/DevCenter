---
title: Supporting Privacy changes in iOS 10
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
Starting iOS 10, Apple mandated that all applications should declare any usage of user's private data information in the project's `Info.plist` file. If such a declaration is not made in the `Info.plist` file, it will cause the application to exit. This holds good for enterprise applications as well. 
Apple is also rejecting submissions to the App Store for applications that make use of user's private data but do not make the necessary or requisite declarations in `Info.plist` file  

According to this [blog](http://useyourloaf.com/blog/privacy-settings-in-ios-10/), use of any of the frameworks in the following list is considered as usage of user's private data.

> Contacts, Calendar, Reminders, Photos, Bluetooth Sharing, Microphone, Camera, Location, Health, HomeKit, Media Library, Motion, CallKit, Speech Recognition, SiriKit, TV Provider.

For versions of Mobilefirst Platform Foundation v7.1 and earlier, hybrid applications created using Mobilefirst Studio would create a cordova project with several cordova plugins embedded in it. Some of these Cordova plugins use frameworks that count as usage of user's private data. Even if these plugins are not used by your applications, the application would get rejected  during submission to the App Store as Apple flags such applications as containing code that access user's private data even though it's not being invoked.

The following are the list of cordova plugins which are embedded inside Mobilefirst hybrid applications which accesss user's private data.

- Camera
- Contact
- Geolocation
- Media
- Media-capture

The following two solutions can be used to overcome the problem of a MobileFirst hybrid application being rejected by Apple App Store. 

#### Solution 1 (Applicable to all versions of MFP)

Declare the usage of the user's private data in `Info.plist` file.
Example : In case you are using camera plugin in your application, follow these steps to declare the usage of private data.

- Open Info.plist file in Xcode project
- Add `Privacy - Camera Usage Description` Key and Usage description in your plist file 
![Camera Plist Usage]({{site.baseurl}}/assets/blog/2016-10-24-supporting-privacy-changes-in-ios-10/camera-usage.png)

Privacy setting keys for private data usage can be found [here](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html).

#### Solution 2 (Applicable only for MFP versions 7.1 and earlier)

Remove the plugin from Hybrid application.
Example : In case you are not using camera plugin, follow these steps to remove the plugin from your hybrid application.

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