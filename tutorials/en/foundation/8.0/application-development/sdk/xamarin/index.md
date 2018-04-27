---
layout: tutorial
title: Adding the MobileFirst Foundation SDK to Xamarin Applications
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview 
The {{ site.data.keys.product }} SDK consists of a collection of dependencies that are packaged inside a NuGet package that can be added to your Xamarin project from [Nuget Package Manager](https://www.nuget.org/packages?q=mobilefirst) .

The packages correspond to core functions and other functions:

* **IBM.MobileFirstPlatformFoundation** - Contains MobileFirst client sdk libraries which implements client-to-server connectivity, handles authentication and security aspects, resource requests, and other required core functions along with JSONStore framework .
 
* **IBM.MobileFirstPlatformFoundationPush** - Contains the push notification framework. For more information, review the [Notifications tutorials](../../../notifications/).

In this tutorial you learn how to add the {{ site.data.keys.product_adj }} Native SDK by using NuGet Package Manager to a new or existing Xamarin.Android or Xamarin.iOS application . You also learn how to configure the {{ site.data.keys.mf_server }} to recognize the application.

**Prerequisites:**

- Visual Studio 2017 installed on the developer workstation for macOS .
- Visual Studio 2015 or Visual Studio 2017 community Version installed on the developer workstation for Windows OS . Make sure that you are not using Express edition of Visual Studio .If so it is recommended to update to a Community edition .  
- A local or remote instance of {{ site.data.keys.mf_server }} is running.
- Read the [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/development/) and [Setting up your Xamarin development environment](../../../installation-configuration/development/xamarin/) tutorials.

#### Jump to:
{: #jump-to }
- [Adding the {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Updating the {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Tutorials to follow next](#tutorials-to-follow-next)

## Adding the {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Follow the instructions below to add the {{ site.data.keys.product_adj }} Native SDK to a new or existing Xcode project, and to register the application to the {{ site.data.keys.mf_server }}.

Before you start, make sure that the {{ site.data.keys.mf_server }} is running.  
If using a locally installed server: From a **Command-line** window, navigate to the server's folder and run the command: `./run.sh`.

### Creating an application
{: #creating-an-application }
Create a Xamarin solution using Xamarin Studio or Visual Studio or use an existing one.

### Adding the SDK
{: #adding-the-sdk }
1. The {{ site.data.keys.product_adj }} Native SDK is provided via Nuget Gallery/Repository .
2. To import MobileFirst packages, use the NuGet package manager. NuGet is the package manager for the Microsoft development platform, including .NET. The NuGet client tools provide the ability to produce and use packages. The NuGet Gallery is the central package repository used by all package authors and users. Right click on the Packages directory, select Add packages and in the search option, search for *IBM MobileFirst Platform*. Choose **IBM.MobileFirstPlatformFoundation**.
![Adding sdk from nuget.org]({{site.baseurl}}/assets/xamarin-tutorials/add-package1.png)
3. Click Add packages. This action installs the Mobile Foundation Native SDK and its dependencies. 
![Adding sdk from nuget.org]({{site.baseurl}}/assets/xamarin-tutorials/add-package2.png)


### Registering the application
{: #registering-the-application }
1. Load the {{ site.data.keys.mf_console }}.
2. Click the New button next to Applications to register a new application and follow the on-screen instructions.
3. Android and iOS applications have to be registered separately. This ensures both the Android application and iOS application can connect successfully to the server. The registration details for Android and iOS applications can be found in the `AndroidManifest.xml` and `Info.plist` respectively.
3. After the application is registered, navigate to the application's Configuration Files tab and copy or download the mfpclient.plist and mfpclient.properties file. Follow the onscreen instructions to add the file to your project.

### Completing the setup process
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Right-click the Xamarin iOS project and select **Add files..**. Browse and find the `mfpclient.plist` to the root of the project. Choose **Copy file to project** if prompted.
2. Right-click the `mfpclient.plist` file and select **Build action**.Choose **Content**.

#### mfpclient.properties
{: #mfpclientproperties }
1. Right-click the *Assets* folder of Xamarin Android project and select **Add files..**. Browse and find the `mfpclient.properties` to the folder. Choose **Copy file to project** if prompted.
2. Right-click the `mfpclient.properties` file and select **Build action**.Choose **Android asset**.

### Referencing the SDK
{: #referencing-the-sdk }
Whenever you want to use the {{ site.data.keys.product_adj }} Native SDK, make sure that you import the {{ site.data.keys.product }} framework:

CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## Updating the {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
To update the {{ site.data.keys.product_adj }} Native SDK with the latest release, update the version of the SDK via the Nuget Gallery .

## Generated {{ site.data.keys.product_adj }} Native SDK artifacts
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
This file defines the client-side properties used for registering your iOS app on the {{ site.data.keys.mf_server }}.

| Property            | Description                                                         | Example values |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | The communication protocol with the {{ site.data.keys.mf_server }}.             | http or https  |
| host        | The host name of the {{ site.data.keys.mf_server }}.                            | 192.168.1.63   |
| port        | The port of the {{ site.data.keys.mf_server }}.                                 | 9080           |
| wlServerContext     | The context root path of the application on the {{ site.data.keys.mf_server }}. | /mfp/          |
| languagePreferences | Sets the default language for client sdk system messages.           | en             |

## Tutorials to follow next
{: #tutorials-to-follow-next }
With the {{ site.data.keys.product_adj }} Native SDK now integrated, you can now:

- Review the [Adapters development tutorials](../../../adapters/)
- Review the [Authentication and security tutorials](../../../authentication-and-security/)
- Review the [Notifications tutorials](../../../notifications/)
- Review [All Tutorials](../../../all-tutorials)
