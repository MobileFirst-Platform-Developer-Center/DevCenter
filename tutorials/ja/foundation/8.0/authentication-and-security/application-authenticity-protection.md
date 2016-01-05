---
layout: tutorial
title: Application Authenticity Protection
breadcrumb_title: Application Authenticity Protection
relevantTo: [android,ios,windows,cordova]
weight: 5
---
## Overview
By issuing an HTTP request, any entity can access the HTTP services (APIs) that IBM MobileFirst Platform Foundation Server offers.  
The out-of-the-box Application Authenticity Protection [security check](../authentication-concepts/) ensures that an application that tries to connect to a MobileFirst Server instance is the authentic one and was not tampered with or modified by a third-party attacker.

To enable Application Authenticity Protection you can either follow the on-screen instructions in the MobileFirst Operations Console → [your-application] → Authenticity, or review the information below.

#### Availability
Application Authenticity Protection is available in all supported platforms (iOS, Android, Windows 8 Universal, Windows 10 UWP) in both Cordova and Native applications.

> <b>Note:</b> Application Authenticity Protection is <b>not available</b> in the MobileFirst Development Server. To test, use a remote application server such as a QA, UAT or Production server.

#### Jump to:

- [Authenticity flow](authenticity-flow)
- [Enabling authenticity](enabling-authenticity)
- [Configuring authenticity](configuring-authenticity)

## Authenticity Flow
Application Authenticity Protection is based on certificate keys that are used to sign the application bundles.
Only the developer or the enterprise who have the original private key that was used to create the application are able to modify, repackage, and re-sign the bundle.

Once an application has successfuly registered with the MobileFirst Server, and passed the Authenticity challenge, an Authenticity token is granted. For as long as the token is valid, the Authenticity challenge will not occur again. See [Configuring authenticity](configuring-authenticity) to learn how this can be customized.

<span style="color:red">TODO: Update with a new diagram from the design team</span>

![Authenticity flow](check_flow.jpg)

> The challenge token in the diagram is processed by compiled native code, so that third-party attackers cannot see the logic of this processing.

## Enabling Application Authenticity Protection
In order to enable Application Authenticity Protection in your Cordova or Native application, the application's binary file needs to be signed using the MobileFirst-supplied command line tool. Eligible binary files are: `ipa` for iOS, `apk` for Android and `appx` for Windows 8 Universal &amp; Windows 10 UWP.

1. Open **Terminal** and run the command: `java -jar path-to-mfp-server-authenticity-tool.jar path-to-binary-file`

    For example:

    ```bash
    java -jar /Users/idanadar/Desktop/mfp-server-authenticity-tool.jar /Users/idanadar/Desktop/MyBankApp.ipa
    ```

    The result of the command above is a `.authenticity_data` file generated next to the `MyBankApp.ipa` file, called `MyBankApp.authenticity_data`.
 
2. Open the MobileFirst Operations Console in your browser of choice.
3. Select your application from the left-side pane and click on the Authenticiy menu item.
3. Click on "Upload File" to upload the `.authenticity_data` file.

After uploading the `.data` file Application Authenticity Protection will be enabled for the application.

<span style="color:red">TODO: add image of where to upload .data file</span>

#### Disabling Authenticity
In order to disable Application Authenticity Protection, click the "Delete Authenticity File" button.

<span style="color:red">TODO: add image of where to remove .data file</span>

## Configuring Authenticity
The Application Authenticity Protection security check has two available properties.  
To configure, load the MobileFirst Operations Console and navigate to **[your application]** → **Security** → **???**

- `expirationSec`: Defaults to 3600 seconds / 1 hour. Defines the duration until the Authenticity token expires.
- `inactivityTimeoutSec`: Defaults to 0 seconds / no inactivity timeout. Defines the duration of inactivity that if met, will force token expiration.

<span style="color:red">TODO: add image of where to edit the properties</span>
