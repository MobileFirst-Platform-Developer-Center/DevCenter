---
layout: tutorial
title: Application Authenticity Protection
breadcrumb_title: Application Authenticity Protection
relevantTo: [android,ios,windows,cordova]
weight: 1
---
## Overview
By issuing an HTTP request, any entity can access the HTTP services (APIs) that IBM MobileFirst Platform Foundation Server offers.  
The Application Authenticity Protection feature ensures that an application that tries to connect to a MobileFirst Server instance is the authentic one and was not tampered with or modified by a third-party attacker.

Application Authenticity Protection is available for:

- Cordova applications (iOS, Android, Windows 8, Windows 10)
- Native applications (iOS, Android, Windows 8, Windows 10)

> <b>Note:</b> Application Authenticity Protection is <b>not available</b> in the MobileFirst Development Server. To test, follow the below instructions in a remote application server, such as a QA, UAT or Production server.

**Jump to:**

- [Authenticity flow](authenticity-flow)
- [Enabling authenticity](enabling-authenticity)
- [Configuring authenticity](configuring-authenticity)

## Authenticity Flow
Application Authenticity Protection is based on certificate keys that are used to sign the application bundles.
Only the developer or the enterprise who have the original private key that was used to create the application are able to modify, repackage, and re-sign the bundle.

![Authenticity flow](https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/04/09_15_check_flow.jpg)

> The challenge token in the diagram is processed by compiled native code, so that third-party attackers cannot see the logic of this processing.

## Enabling Application Authenticity Protection
In order to enable Application Authenticity Protection for your Cordova or Native application, the application's binary file needs to be signed using the MobileFirst-supplied command line tool. Eligible binary files are: `ipa` for iOS, `apk` for Android and `appx` for Windows 8 Universal &amp; Windows 10 UWP.

1. Open **Terminal** and run the command: `java -jar [path-to]/mfp-server-authenticity-tool.jar [path-to]/[binary-file]`

    For example:

    ```bash
    java -jar /Users/idanadar/Desktop/mfp-server-authenticity-tool.jar /Users/idanadar/Desktop/MyBankApp.ipa
    ```

    The result of the command above is a `.properties` file generated next to the `MyBankApp.ipa` file.
 
2. Open the MobileFirst Operations Console in your browser of choice and navigate to the ... screen.
3. Follow the on-screen instructions to upload the `.properties` file.

<span style="color:red">TODO: add image of where to upload .properties file</span>

#### Disabling Authenticity
In order to disable Application Authenticity Protection, remove the previously uploaded `.properties` file.

<span style="color:red">TODO: add image of where to remove .properties file</span>

## Configuring Authenticity
Application Authenticity Protection has two available properties:

<span style="color:red">TODO: add missing property description</span>  

- `expirationInSec`:
- `inactivityTimeoutInSec`:

<span style="color:red">TODO: add image of where to edit the properties</span>