---
layout: tutorial
title: Simple Data Sharing
relevantTo: [ios,android,cordova]
weight: 12
---
## Overview
The Simple Data Sharing feature makes it possible to securely share lightweight information among a family of applications on a single device. This feature uses native APIs that are already present in the different mobile SDKs to provide one unified developer API. This MobileFirst API abstracts the different platform complexities, making it easier for developers to quickly implement code that allows for inter-application communication.

This feature is supported on iOS and Android for both Cordova and native applications.

After you enable the Simple Data Sharing feature, you can use the provided Cordova and native APIs to exchange simple string tokens among a family of applications on a device.

#### Jump to

* [Terminology](#terminology)
* [Enabling the Simple Data Sharing feature](#enabling-the-simple-data-sharing-feature)
* [Simple Data Sharing API concepts](#simple-data-sharing-api-concepts)
* [Limitations and considerations](#limitations-and-considerations)

## Terminology
### MobileFirst application family
An application family is a way to associate a group of applications which share the same level of trust. Applications in the same family can securely and safely share information with each other.

To be considered part of the same MobileFirst application family, all applications in the same family must comply with the following requirements:

* Specify the same value for the application family in the application descriptor.
	* For iOS applications, this requirement is synonymous to the access group entitlements value.
	* For Android applications, this requirement is synonymous to the **sharedUserId** value in the **AndroidManifest.xml** file.
		
        > **Note:** For Android, the name must be in the **x.y** format.

* Applications must be signed by the same signing identity. This requirement means that only applications from the same organization can use this feature.	
    * For iOS applications, this requirement means the same Application ID prefix, provisioning profile, and signing identity is used to sign the application.
	* For Android applications, this requirement means the same signing certificate and key.

Aside from the IBM MobileFirst Foundation provided APIs, applications in the same MobileFirst application family can also use the data sharing APIs that are available through their respective native mobile SDK APIs.

### String tokens
Sharing string tokens across applications of the same MobileFirst application family can now be accomplished in hybrid or native iOS and Android applications through the Simple Data Sharing feature.

String tokens are considered simple strings, such as passwords or cookies. Using large strings results in considerable performance degradation.

Consider encrypting tokens when you use the APIs for added security.

> For more information, see [JSONStore security utilities](../jsonstore/security-utilities/).

## Enabling the Simple Data Sharing feature
Wheter your app is a native app or a Cordova-based app, the instructions below apply to both.  
Open your application in Xcode/Android Studio and:

### iOS
1. In Xcode, add a Keychain Access Group with a unique name for all the apps which you want to make part of the same application family. The application-identifier entitlement must be the same for all applications in your family.
2. Ensure that applications that are part of the same family share the same Application ID prefix. For more information, see 3. Managing Multiple App ID Prefixes in the iOS Developer Library.
4. Save and sign applications. Ensure that all applications in this group are signed by the same iOS certificate and provisioning profiles.
5. Repeat the steps for all applications that you want to make part of the same application family.

You can now use the native Simple Data Sharing APIs to share simple strings among the group of applications in the same family. 

### Android
1. Enable the Simple Data Sharing option by specifying the application family name as the **android:sharedUserId** element in the manifest tag of your **AndroidManifest.xml** file. For example: 

    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
    ```
    
2. Ensure that applications that are part of the same family are signed by the same signing credentials.
3. Uninstall any earlier versions of the applications that did not specify a **sharedUserId** or that used a different **sharedUserId**.
4. Install the application on the device.
5. Repeat the steps for all applications that you want to make part of the same application family.

You can now use the native Simple Data Sharing APIs that are provided to share simple strings among the group of applications in the same family.

## Simple Data Sharing API concepts
The Simple Data Sharing APIs allow any application in the same family to set, get, and clear key-value pairs from a common place. The Simple Data Sharing APIs are similar for every platform, and provide an abstraction layer, hiding the complexities that exist with each native SDK's APIs, making it easy to use.

The following examples show how you can set, get, and delete tokens from the shared credential storage for the different environments.

### JavaScript
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> For more information about the Cordova APIs, see the [getSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#setSharedToken), [setSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#getSharedToken), and [clearSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#clearSharedToken) functions in the API reference.

### Objective-C
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> For more information about the Objective-C APIs, see the [WLSimpleDataSharing](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLSimpleDataSharing.html) class in the API reference.

### Java
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> For more information about the Java APIs, see Class [WLSimpleDataSharing](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/WLSimpleDataSharing.html) in the API reference.

## Limitations and considerations
### Security considerations
Because this feature allows for data access among a group of applications, special care must be taken to protect access to the device from unauthorized users. Consider the following security aspects:

#### Device Lock
For added security, ensure that devices are secured by a device password, passcode, or pin, so that access to the device is secured if the device is lost or stolen.

#### Jailbreak Detection
Consider using a mobile device management solution to ensure that devices in your enterprise are not jailbroken or rooted.

#### Encryption
Consider encrypting any tokens before you share them for added security. For more information, see JSONStore security utilities.

### Size limit
This feature is meant for sharing of small strings, such as passwords or cookies. Be cognizant not to abuse this feature, as there are performance implications with such attempts to encrypt and decrypt or read and write any large values of data.

### Maintenance challenges
Android developers must be aware that enabling this feature, or changing the application family value, results in their inability to upgrade existing applications that were installed under a different family name. For security reasons, Android requires earlier applications to be uninstalled before applications under a new family name can be installed.
