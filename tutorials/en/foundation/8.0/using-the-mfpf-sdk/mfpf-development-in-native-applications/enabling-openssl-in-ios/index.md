---
layout: tutorial
title: Enabling OpenSSL in iOS applications
breadcrumb_title: Enabling OpenSSL in iOS
relevantTo: [ios]
weight: 1
---

## Overview
The MobileFirst iOS SDK uses native iOS APIs for cryptography. You can configure IBM MobileFirst Foundation to use the OpenSSL cryptography library in iOS apps.  
Encryption/decryption is provided with the following APIs: `WLSecurityUtils.encryptText() `and `WLSecurityUtils.decryptWithKey()`.

## Option 1: Native encryption and decryption
Native encryption and decryption is provided by default, without using OpenSSL. This is equivalent to explicitly setting the encryption or decryption behavior as follows:
`WLSecurityUtils enableOSNativeEncryption:YES`

## Option 2: Enabling OpenSSL
OpenSSL is disabled by default. To enable it, proceed as follows:

1. Install the OpenSSL frameworks:
    - With CocoaPods: Install the **IBMMobileFirstPlatformFoundationOpenSSLUtils** pod with CocoaPods. 
    - Manually in Xcode: Link the **IBMMobileFirstPlatformFoundationOpenSSLUtils** and **openssl** frameworks manually in the **Link Binary With Libraries** section of the **Build Phases** tab.
    
2. The following code enables the OpenSSL option for the encryption/decryption: `WLSecurityUtils enableOSNativeEncryption:NO`. The code will now use the OpenSSL implementation if found and otherwise throw an error if the frameworks are not installed correctly.

## Migration options
If you have an MobileFirst project that was written in an earlier version, you might need to incorporate changes to continue using OpenSSL.

* If the application is not using encryption/decryption APIs and no encrypted data is cached on the device, no action is needed.
* If the application is using encryption/decryption APIs, you have the option of using these APIs with or without OpenSSL.

### Migrating to native encryption
1. Make sure the default native encryption/decryption option is chosen (see Option 1).
2. Migrating cached data: If the previous installation of IBM MobileFirst Platform Foundation saved encrypted data to the device using OpenSSL, OpenSSL frameworks must be installed as described in Option 2. The first time the application attempts to decrypt the data it will fall back to OpenSSL and then encrypt it using native encryption. If the OpenSSL framework is not installed an error is thrown. This way the data will be auto-migrated to native encryption allowing subsequent releases to work without the OpenSSL framework.

### Continuing with OpenSSL
If OpenSSL is required use the setup described in Option 2.
    



