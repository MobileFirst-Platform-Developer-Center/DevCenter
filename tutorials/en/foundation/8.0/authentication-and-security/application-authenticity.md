---
layout: tutorial
title: Application Authenticity 
breadcrumb_title: Application Authenticity
relevantTo: [android,ios,windows,cordova]
weight: 10
---
## Overview
By issuing an HTTP request, any entity can access the HTTP services (APIs) that IBM MobileFirst Platform Foundation Server offers.  
The out-of-the-box Application Authenticity [security check](../authentication-concepts/) ensures that an application that tries to connect to a MobileFirst Server instance is the authentic one and was not tampered with or modified by a third-party attacker.

To enable Application Authenticity you can either follow the on-screen instructions in the **MobileFirst Operations Console** → **[your-application]** → **Authenticity**, or review the information below.

#### Availability
Application Authenticity is available in all supported platforms (iOS, Android, Windows 8.1 Universal, Windows 10 UWP) in both Cordova and Native applications.

> <b>Note:</b> Application Authenticity is <b>not available</b> in the MobileFirst Development Server. To test, use a remote application server such as a QA, UAT or Production server.

#### Jump to:

- [Authenticity flow](authenticity-flow)
- [Enabling authenticity](enabling-application-authenticity)
- [Disabling authenticity](disabling-application-authenticity)
- [Configuring authenticity](configuring-application-authenticity)

## Authenticity Flow
Once an application has passed the Authenticity challenge, an Authenticity scope is granted. For as long as the token is valid, the Authenticity challenge will not occur again. See [Configuring authenticity](configuring-authenticity) to learn how this can be customized.

![Authenticity flow](check_flow.jpg)

> The challenge token in the diagram is processed by compiled native code, so that third-party attackers cannot see the logic of this processing.

## Enabling Application Authenticity
To enable Application Authenticity in your Cordova or Native application, the application's binary file needs to be signed using the MobileFirst-supplied command line tool. Eligible binary files are: `ipa` for iOS, `apk` for Android and `appx` for Windows 8.1 Universal &amp; Windows 10 UWP.

1. Open a **Command-line** window and run the command: `java -jar path-to-mfp-server-authenticity-tool.jar path-to-binary-file`

    For example:

    ```bash
    java -jar /Users/idanadar/Desktop/mfp-server-authenticity-tool.jar /Users/idanadar/Desktop/MyBankApp.ipa
    ```

    The result of the command above is an `.authenticity_data` file generated next to the `MyBankApp.ipa` file, called `MyBankApp.authenticity_data`.
 
2. Open the MobileFirst Operations Console in your browser of choice.
3. Select your application from the left-side pane and click on the Authenticiy menu item.
3. Click on "Upload Authenticity File" to upload the `.authenticity_data` file.

When the `.authenticity_data` file is uploaded, Application Authenticity is enabled.

![Enable Application Authenticity by uploading an .authenticity_data file](enable_authenticity.png)

## Disabling Application Authenticity
To disable Application Authenticity, click the "Delete Authenticity File" button.

![Disable Application Authenticity by removing a previously uploaded .authenticity_data file](disable_authenticity.png)

## Configuring Application Authenticity
The Application Authenticity out-of-the-box security check can be configured with the following property:

- `expirationInSec`: Defaults to 3600 seconds / 1 hour. Defines the duration until the Authenticity token expires.

Once an authenticity check has been performed, it will not be performed again until the token has expired based on the set value.

#### To configure the `expirationInSec` property:

1. Load the MobileFirst Operations Console and navigate to **[your application]** → **Security** → **Security Check Configurations** and click on **Create New**.

2. Search for the "appAuthenticity" scope element.

3. Set a new value in seconds.

![Configuring the expirationSec property in the console](configuring_expirationSec.png)

