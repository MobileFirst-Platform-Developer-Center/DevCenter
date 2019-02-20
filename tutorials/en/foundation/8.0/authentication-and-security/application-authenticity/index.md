---
layout: tutorial
title: Application Authenticity
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

To properly secure your application, enable the predefined {{ site.data.keys.product_adj }} application-authenticity [security check](../#security-checks) (`appAuthenticity`). When enabled, this check validates the authenticity of the application before providing it with any services. Applications in production environment should have this feature enabled.

To enable application authenticity, you can either follow the on-screen instructions in the **{{ site.data.keys.mf_console }}** → **[your-application]** → **Authenticity**, or review the information below.

#### Availability
{: #availability }
* Application authenticity is available in all supported platforms (iOS, watchOS, Android, Windows 8.1 Universal, Windows 10 UWP) in both Cordova and native applications.

#### Jump to:
{: #jump-to }
- [Application Authenticity flow](#application-authenticity-flow)
- [Enabling Application Authenticity](#enabling-application-authenticity)
- [Configuring Application Authenticity](#configuring-application-authenticity)
- [Build Time Secret (BTS)](#bts)
- [Troubleshooting](#troubleshooting)
  - [Reset](#reset)
  - [Validation Types](#validation)
  - [Support for SDK versions 8.0.0.0-MFPF-IF201701250919 or earlier](#legacy)

## Application Authenticity Flow
{: #application-authenticity-flow }
The application-authenticity security check is run during the application's registration to {{ site.data.keys.mf_server }}, which occurs the first time an instance of the application attempts to connect to the server. By default the authenticity check does not run again.

Once app authenticity is enabled and if customer needs to introduce any changes in their application, then the application version needs to be upgraded.

See [Configuring application authenticity](#configuring-application-authenticity) to learn how to customize this behavior.

## Enabling Application Authenticity
{: #enabling-application-authenticity }
For application authenticity to be enabled in your application:

1. Open the {{ site.data.keys.mf_console }} in your favorite browser.
2. Select your application from the navigation sidebar and click on the **Authenticity** menu item.
3. Toggle the **On/Off** button in the **Status** box.

![Enable Application Authenticity](enable_application_authenticity.png)

MobileFirst Server validates the application's authenticity on the first attempt to connect to the server. To apply this validation also to protected resources, add the `appAuthenticity` security check to the protecting scope.

### Disabling Application Authenticity
{: #disabling-application-authenticity }
Some changes to the application during development might cause it to fail the authenticity validation. Accordingly, it is recommended to disable application authenticity during the development process. Applications in production environment should have this feature enabled.

To disable application authenticity, toggle back the **On/Off** button in the **Status** box.

## Configuring Application Authenticity
{: #configuring-application-authenticity }
By default, Application Authenticity is checked only during client registration. However, just like any other security check, you can decide to protect your application or resources with the `appAuthenticity` security check from the console, following the instructions under [Protecting resources](../#protecting-resources).

You can configure the predefined application-authenticity security check with the following property:

- `expirationSec`: Defaults to 3600 seconds / 1 hour. Defines the duration until the authenticity token expires.

After an authenticity check has completed, it does not occur again until the token has expired based on the set value.

#### To configure the `expirationSec` property:
{: #to-configure-the-expirationsec property }
1. Load the {{ site.data.keys.mf_console }}, navigate to **[your application]** → **Security** → **Security-Check Configurations**, and click on **New**.

2. Search for the `appAuthenticity` scope element.

3. Set a new value in seconds.

![Configuring the expirationSec property in the console](configuring_expirationSec.png)

## Build Time Secret (BTS)
{: #bts }
The Build Time Secret (BTS) is an **optional tool to enhance authenticity validation**, for iOS and watchOS applications only. The tool injects the application with a secret determined at build time, which is later used in the authenticity validation process.

The BTS tool can be downloaded from the **{{ site.data.keys.mf_console }}** → **Download Center**.

To use the BTS tool in Xcode:
1. Under the **Build Phases** tab click the **+** button and create new **Run Script Phase**.
2. Copy the path of BTS Tool and paste in the new **Run Script Phase** you have created.
3. Drag the **Run Script Phase** above the **Compile sources** phase.
4. This step is required only if the application environment is watchOS. To enable BTS, developer needs to pass any swift file name, which is packaged in the watchOS extension after the BTS tool location.

For example, suppose if the watchOS extension package contains `HelloWatchOS.swift` file, the developer will need to pass `HelloWatchOS` as an argument along with the path of BTS tool.

The tool should  be used when building a production version of the application.

## Troubleshooting
{: #troubleshooting }

### Reset
{: #reset }
The application authenticity algorithm uses application data and metadata in its validation. The first device to connect to the server after enabling application authenticity provides a "fingerprint" of the application, containing some of this data.

It is possible to reset this fingerprint, providing the algorithm with new data. This could be useful during development (for example after changing the application in Xcode). To reset the fingerprint, use the **reset** command from the [**mfpadm** CLI](../../administering-apps/using-cli/).

After resetting the fingerprint, the appAuthenticity security check continues to work as before (this will be transparent to the user).

### Validation Types
{: #validation }

Mobile First Platform Foundation provides static and dynamic app authenticity for applications. These validation types differ on the algorithm and attributes used to generate app authenticity seeds. By default, when application authenticity is enabled, it uses the **dynamic** validation algorithm. Both the validation types ensure the security of the application. Dynamic app authenticity uses strict validations and checks for app authenticity. For static app authenticity, we use slightly relaxed algorithm, which will not use all the validation checks as used in dynamic app authenticity.

The dynamic app authenticity is configurable from MobileFirst Console. The internal algorithm takes care of generating app authenticity data based on the options chosen in console.
For static app authenticity, one need to use the [**mfpadm** CLI](../../administering-apps/using-cli/).

For enabling static app authenticity and to switch between validation types, use the [**mfpadm** CLI](../../administering-apps/using-cli/):

```bash
mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```
`TYPE` can either be `dynamic` or `static`.

### Support for SDK versions 8.0.0.0-MFPF-IF201701250919 or earlier
{: #legacy }
The dynamic and static validation types are only supported by client SDKs released in **February 2017 or later**. For SDK versions **8.0.0.0-MFPF-IF201701250919 or earlier**, use the legacy application authenticity tool:

The application binary file must be signed by using the mfp-app-authenticity tool. Eligible binary files are: `ipa` for iOS, `apk` for Android, and `appx` for Windows 8.1 Universal &amp; Windows 10 UWP.

1. Download the mfp-app-authenticity tool from the **{{ site.data.keys.mf_console }} → Download Center**.
2. Open a **Command-line** window and run the command: `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file`

   For example:

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   This command generates an `.authenticity_data` file, called `MyBankApp.authenticity_data`, next to the `MyBankApp.ipa` file.
3. Upload the `.authenticity_data` file using the [**mfpadm** CLI](../../administering-apps/using-cli/):
  ```bash
  app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-data FILE
  ```
