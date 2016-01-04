---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Windows 10 UWP Applications
breadcrumb_title: Windows 10 UWP SDK
relevantTo: [windows10]
weight: 5
---
## Description and screenshots might change as Nuget for Windows UWP is being worked on.

## Overview
The MobileFirst Platform Foundation SDK provides a set of API methods enabling a developer to implement various MobileFirst features, such as: authentication and security mechanisms, notifications, resource requests, collecting analytics data and more.

> For a complete list of MobileFirst SDK abilities [visit the user documentation](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/wl_welcome.html).

In this tutorial you will learn how to add the MobileFirst Native SDK using Nuget to either a new or existing Windows 8 Universal application. You will also learn how to configure the MobileFirst Server to recognize the application, as well as find information about the MobileFirst configuration files that are added to the project.

**Pre-requisites:** Microsoft Visual Studio 2015 running on Windows 10 and MobileFirst CLI installed on the developer workstation.  
Make sure you have read the [Setting up your MobileFirst development environment](../../setting-up-the-mobilefirst-development-environment) tutorial.

#### Jump to:

- [Adding the MobileFirst Native SDK](#adding-the-mobilefirst-native-sdk)
- [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)

### Adding the MobileFirst Native SDK

Before starting, make sure the MobileFirst Server is running.  
From **Terminal** run the command:

```bash
mfpdev server start
```

Follow the below instructions to manually add the MobileFirst Native SDK to either a new or existing Xcode project.

1. Create a Windows 8 Universal project using Visual Studio 2013/2015 or use an existing project.  

2. Open **Terminal** and navigate to the root of the Xcode project.  

3. Run the command:

    ```bash
    mfpdev app register
    ```

    The <code>mfpdev app register</code> CLI command first connects to the MobileFirst Server to register the application, followed by generating the <code>mfpclient.plist</code> file at the root of the Xcode project, and adding to it the metadata that identifies the MobileFirst Server.

    > <b>Tip:</b> The application registration can also be performed from the MobileFirst Operations Console:    
        1. Open your browser of choice and load the MobileFirst Operations Console using the address <code>http://localhost:10080/mfpconsole/</code>. You can also open the console from **Terminal** using the CLI command <code>mfpdev server console</code>.  
        2. Click on the "Create new" button next to "Applications" to create a new application and follow the on-screen instructions.  
        3. After successfully registering your application you can optionally download a "skeleton" Xcode project pre-bundled with the MobileFirst Native SDK.

4. Run the command:

    ```bash
    mfpdev app pull
    ```
    The <code>mfpdev app pull</code> CLI command creates the **mobilefirst** folder at the root of the Xcode project and downloads into it the <code>application-descriptor.json</code> file, containing application configuration data.

    These files are further explained in the [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts) section below.

    > <b>Tip:</b> Learn more about the various CLI commands in the [Using CLI to manage MobileFirst artifacts](../../client-side-development/using-cli-to-manage-mobilefirst-artifacts/) tutorial.

5. To import worklight studio packages, NuGet package manager is used.
NuGet is the package manager for the Microsoft development platform including .NET. The NuGet client tools provide the ability to produce and consume packages. The NuGet Gallery is the central package repository used by all package authors and consumers.

6. Open the Windows 8 Universal project in Visual studio 2013/2015. Right click the project solution and navigate -> Manage Nuget packages for solution.

![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

 7.In the search option , search for IBM MobileFirst Platform. Choose IBM.MobileFirstPlatform.8.0.0.0.

![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

 8.Click Install. This installs the IBM MobileFirstPlatform Native SDK and its dependencies.

Alternatively,

Browse to [https://www.nuget.org/packages](https://www.nuget.org/packages)

- Search for IBM MobileFirstPlatform SDK

- Download IBM.MobileFirstPlatform.8.0.0.0.nupkg to your filesystem.
- Open the Windows 8 Universal project in Visual Studio 2013/2015. Click on Tools -> NuGet Package Manager -> Package Manager Settings.

![Add-Nuget-lcoally-VS-settings](Add-Nuget-locally0.png)

- Select Package Sources
- Click Add (+)
Give some name to your package and choose the path to your .nupkg file and click update.

![Add-Nuget-locally-source](Add-Nuget-locally1.png)

Close the dialog. 	

- In Solution explorer, right click the solution and choose  "Manage NuGet Packages for Solution".
Select the source you created in the previous step or search for IBM MobileFirst Platform in search tab.
Choose "IBM MobileFirst Platform".

![Add-Nuget-choose-source](Add-Nuget-locally2.png)

- Click on Install

![Add-Nuget-installSDK](Add-Nuget.png)

## Generated MobileFirst Native SDK artifacts
Two MobileFirst-related artifacts are available in the Android Studio project after it has been integrated with the MobileFirst Native SDK: the <code>mfpclient.resw</code> and the <code>application-descriptor.json</code> file.

### mfpclient.resw

Located at the root of the project, this file contains server connectivity properties and is user-editable:

- <code>protocol</code> – The communication protocol to MobileFirst Server. Either <code>HTTP</code> or <code>HTPS</code>.
- <code>host</code> – The hostname of the MobileFirst Server instance.
- <code>port</code> – The port of the MobileFirst Server instance.
- <code>wlServerContext</code> – The context root path of the application on the MobileFirst Server instance.
- <code>languagePreference</code> - Sets the default language for client sdk system messages

In Visual Studio, open the **Properties** window of the *mfpclient.resw* file and set the **Copy to Output Directory** option to **Copy always**.

Add the following capabilities to the *Package.appxmanifest*:

>Internet (Client &amp; Server)

>Private Networks (Client &amp; Server)

For more information, see the topic about developing native C# applications for Windows Universal, in the user documentation.

## Tutorials to follow next
Now that your application contains the Native API library, you can follow the tutorials in the
[Native Windows 8 Development](../../native/windows8/) section to learn more about authentication and security, server-side development, advanced client-side development, notifications and more.
