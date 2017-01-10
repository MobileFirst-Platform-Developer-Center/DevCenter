---
layout: tutorial
title: Application Authenticity
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
By issuing an HTTP request, an application can access corporate HTTP services (APIs) that {{ site.data.keys.mf_server }} provides access to. The predefined application-authenticity [security check](../) ensures that an application that tries to connect to a {{ site.data.keys.mf_server }} instance is the authentic one.

To enable application authenticity, you can either follow the on-screen instructions in the **{{ site.data.keys.mf_console }}** → **[your-application]** → **Authenticity**, or review the information below.

#### Availability
{: #availability }
* Application authenticity is available in all supported platforms (iOS, Android, Windows 8.1 Universal, Windows 10 UWP) in both Cordova and native applications.

#### Limitations
{: #limitations }
* Application authenticity does not support **Bitcode** in iOS. Therefore, before using application authenticity, disable Bitcode in the Xcode project properties.

#### Jump to:
{: #jump-to }
- [Application Authenticity flow](#application-authenticity-flow)
- [Enabling Application Authenticity](#enabling-application-authenticity)
- [Configuring Application Authenticity](#configuring-application-authenticity)

## Application Authenticity Flow
{: #application-authenticity-flow }
By default, the application-authenticity security check is run during the application's runtime registration to {{ site.data.keys.mf_server }}, which occurs the first time an instance of the application attempts to connect to the server, the authenticity challenge does not occur again.

See [Configuring application authenticity](#configuring-application-authenticity) to learn how to customize this behavior.

## Enabling Application Authenticity
{: #enabling-application-authenticity }
For application authenticity to be enabled in your Cordova or native application, the application binary file must be signed by using the mfp-app-authenticity tool. Eligible binary files are: `ipa` for iOS, `apk` for Android, and `appx` for Windows 8.1 Universal &amp; Windows 10 UWP.

1. Download the mfp-app-authenticity tool from the **{{ site.data.keys.mf_console }} → Download Center**.
2. Open a **Command-line** window and run the command: `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file`

   For example:

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   This command generates an `.authenticity_data` file, called `MyBankApp.authenticity_data`, next to the `MyBankApp.ipa` file.

3. Open the {{ site.data.keys.mf_console }} in your favorite browser.
4. Select your application from the navigation sidebar and click on the **Authenticity** menu item.
5. Click on **Upload Authenticity File** to upload the `.authenticity_data` file.

When the `.authenticity_data` file is uploaded, application authenticity is enabled.

![Enable Application Authenticity](enable_application_authenticity.png)

### Disabling Application Authenticity
{: #disabling-application-authenticity }
To disable application authenticity, click the **Delete Authenticity File** button.

## Configuring Application Authenticity
{: #configuring-application-authenticity }
By default, Application Authenticity is checked only during client registration. Just like any other security check, you can decide to protect your application or resources with the `appAuthenticity` security check from the console, following the instructions under [Protecting resources](../#protecting-resources).

You can configure the predefined application-authenticity security check with the following property:

- `expirationSec`: Defaults to 3600 seconds / 1 hour. Defines the duration until the authenticity token expires.

After an authenticity check has completed, it does not occur again until the token has expired based on the set value.

#### To configure the `expirationSec` property:
{: #to-configure-the-expirationsec property }
1. Load the {{ site.data.keys.mf_console }}, navigate to **[your application]** → **Security** → **Security Check Configurations**, and click on **Create New**.

2. Search for the `appAuthenticity` scope element.

3. Set a new value in seconds.

![Configuring the expirationSec property in the console](configuring_expirationSec.png)
