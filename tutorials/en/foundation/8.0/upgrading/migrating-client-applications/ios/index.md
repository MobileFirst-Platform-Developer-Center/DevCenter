---
layout: tutorial
title: Migrating existing iOS applications
breadcrumb_title: iOS
weight: 2
---
To migrate an existing native iOS project that was created with IBM MobileFirst™ Platform Foundation version 6.2.0 or later, you must modify the project to use the SDK from the current version. Then you replace the client-side APIs that are discontinued or not in v8.0. The migration assistance tool can scan your code and generate reports of the APIs to replace.

#### Jump to

* [Scanning existing MobileFirst native iOS apps to prepare for MobileFirst version 8.0](#scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-mobilefirst-version-8-0)
* [Migrating an existing iOS project to version 8.0 manually](#migrating-an-existing-ios-project-to-version-8-0-manually)
* [Migrating an existing native iOS projects to version 8.0 with CocoaPods](#migrating-an-existing-native-ios-projects-to-version-8-0-with-cocoapods)
* [Migrating encryption in iOS](#migrating-encryption-in-ios)
* [Updating the iOS code](#updating-the-ios-code)

## Scanning existing MobileFirst native iOS apps to prepare for MobileFirst version 8.0
The migration assistance tool helps you prepare your apps that were created with previous versions of IBM MobileFirst™ Platform Foundation for migration by scanning the sources of the native iOS apps that were developed by using Swift or Objective-C and generating a report of APIs that are deprecated or discontinued in version 8.0.

The following information is important to know before you use the migration assistance tool:

* You must have an existing IBM MobileFirst Platform Foundation native iOS application.
* You must have internet access.
* You must have node.js version 4.0.0 or later installed.
* Review and understand the limitations of the migration process. For more information, see [Migrating apps from earlier releases](../).


## Migrating an existing iOS project to version 8.0 manually
## Migrating an existing native iOS projects to version 8.0 with CocoaPods
## Migrating encryption in iOS
If your iOS application used OpenSSL encryption, you might want to migrate your app to the new v8.0 native encryption. Also, if you want to continue using OpenSSL, you must install some additional frameworks.

For more information on the iOS encryption options for migration, see [Enabling OpenSSL for iOS](../../application-development/sdk/ios/additional-information/#enabling-openssl-for-ios).

## Updating the iOS code 
