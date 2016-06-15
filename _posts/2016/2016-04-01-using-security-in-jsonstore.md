---
title: Using Security in OpenSource JSONStore
date: 2016-4-1
tags:
- iOS
- Android
- JSONStore
version:
- 6.3
- 7.0
- 7.1
author:
  name: Nana Amfo
---



# Overview 
JSONStore is a lightweight, document-oriented storage system that enables persistent storage of JSON documents for Android applications.  
Recently, the JSONStore framework has been released as an open source framework.  

IBM MobileFirst Platform Foundation provides libraries that allow to enable security features such as encryption and FIPS support in JSONStore.  
By the end of this blog you will have a JSONStore framework that is secured for your project.

**Note:** This version of JSONStore is not supported for MobileFirst Platform Foundation v8 beta.

## Android applications

#### Installing JSONStore

In order to install JSONStore follow the step by step instructions described at [https://github.com/ibm-bluemix-mobile-services/jsonstore-android](https://github.com/ibm-bluemix-mobile-services/jsonstore-android)

#### Enabling encryption and FIPS support

Unzip the **jsonstore_encryption.zip** file and pull out the `Android` folder. You should see `jniLibs`, `libs`, and `assets` subdirectories. 

Copy the contents of `libs` directory and paste them in your `libs` directory in your Anroid. Likewise, do the same for the `jniLibs` and `assets` directory. If you do not have an assets or jniLibs directory you can create them under `src/main`. 

In your build.gradle make sure the following line is included under dependencies

```xml
compile fileTree(dir: 'libs', include: ['*.jar'])
```

Below screenshot shows the final file system layout after following the above instructions

![Enabling JSONStore]({{site.baseurl}}/assets/blog/2016-04-01-using-security-in-jsonstore/enable-security.png)

Once all the required libraries are in place the last remaining thing to do is to call below method to enable encryption in your JSONStore application.

```java
JSONStore.getInstance(getApplicationContext()).setEncryption(true)
``` 
Now you can use JSONStoreInitOptions instance to set username and password for encrypting your JSONStore collections. 

> To ensure that FIPS compliant encryption is enabled look for the below text in LogCat output

```xml
04-08 19:56:42.566 13387-13387/? D/libuvpn: SSL Version=OpenSSL 1.0.2f-fips 28 Jan 2016
04-08 19:56:42.626 13387-13387/? D/libuvpn: --------------------------------------------------
												FIPS_mode initially 0, setting to 1
04-08 19:56:42.626 13387-13387/? D/libuvpn:   FIPS_mode_set succeeded
 											---------------------------------------------------
```

## iOS applications

#### Installing JSONStore

In order to install JSONStore follow the step by step instructions described at [https://github.com/ibm-bluemix-mobile-services/jsonstore-ios](https://github.com/ibm-bluemix-mobile-services/jsonstore-ios)

#### Enabling encryption and FIPS support

Remove the `sqlite3` pod from your Podspec file and run `pod install`

Unzip the **jsonstore_encryption.zip** file and open the iOS folder found inside of it. 

Drag and drop `SQLCipher.framework` and `libSQLCipherDatabase.a` fils from iOS folder to your iOS project in Xcode. When prompted make sure that the `Copy items if needed` checkbox is checked. 

Open "Link Binary with Libraries" section in the "Build Phases" tab of your iOS project settings. Make sure that "SQLCipher.framework" and "libSQLCipherDatabase.a" are present. Add them if they're not.

Once all the required files are added call the below method in your iOS application

```objc
[[JSONStore sharedInstance] setEncryption:YES];
```

To ensure that FIPS compliant encryption is enabled execute the below command

```objc
NSLog(@"%@", [[JSONStore sharedInstance] fileInfoAndReturnError:nil]);
```

The Xcode console output should contain isEncrypted=1 property like shown on a snippet below

```xml
2016-04-08 14:54:45.789 JSONStoreTestIOS[48114:20123219] (
         {
         isEncrypted = 1;
         name = myname;
         size = 3072;
     }
 )
```

## Cordova applications

#### Installing JSONStore

In order to install JSONStore Cordova plugin follow the step by step instructions described at [https://github.com/ibm-bluemix-mobile-services/jsonstore-cordova](https://github.com/ibm-bluemix-mobile-services/jsonstore-cordova)

#### Enabling encryption and FIPS support

Follow the instructions for adding files for native application. Once all the required files are added call the below method in your Cordovaq application

```javascript
JSONStore.setEncryption(true)
```
