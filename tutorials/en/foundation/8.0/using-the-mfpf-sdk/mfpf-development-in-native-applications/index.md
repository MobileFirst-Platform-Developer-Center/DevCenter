---
layout: tutorial
title: MobileFirst Foundation development in Native applications
breadcrumb_title: Native Application development
relevantTo: [ios,android,windows]
weight: 3
---
<br/>
This tutorial provides additional information for native applications that are developed with IBM MobileFirst Foundation.

## iOS application development

### Adding the MobileFirst iOS SDK
To develop a native iOS application, you must add the MobileFirst framework files to your Xcode project and register the app on the IBM MobileFirst Platform Server. You can add the MobileFirst frameworks to your Xcode project either manually or using CocoaPods.

> Learn more on [adding the MobileFirst SDK](../adding-the-mfpf-sdk/ios) and registering iOS applications

### Adding optional MobileFirst iOS frameworks
MobileFirst iOS functionality is provided by a collection of frameworks that can be added to your app. Only one of these frameworks is required (IBMMobileFirstPlatformFoundation). You can add optional frameworks according to the features you want to implement in your app. You reduce the size of the app by including only the frameworks required by your chosen features.

For an existing MobileFirst Xcode project, you can add frameworks manually by linking the frameworks in Xcode or by using Cocoapods.

| Feature                                            | Frameworks (linked in the Link Binary with Libraries list in the Build Phases tab) | 
|----------------------------------------------------|------------------------------------------------------------------------------------|
| JSONStore                                          | **IBMMobileFirstPlatformFoundationJSONStore**, **SQLCipher**. In addition, import the **IBMMobileFirstPlatformFoundationJSONStore** header to your code. For more information on setup, see the [JSONStore tutorial](../jsonstore/ios). |
| OpenSSL                                            | **openssl**, **IBMMobileFirstPlatformFoundationOpenSSLUtils**. For more information on OpenSSL, see [Enabling OpenSSL for iOS](enabling-openssl-in-ios) |
| Push                                               | **IBMMobileFirstPlatformFoundationPush**. In addition, import the **IBMMobileFirstPlatformFoundationPush** header to your code. For more information, see the [Notifications tutorials](../notifications). |
| watchOS                                            | **IBMMobileFirstPlatformFoundationWatchOS**. The watchOS framework requires a different structure for the Xcode project. For information on adding the watchOS framework, see [Adding watchOS frameworks](/watchos). |