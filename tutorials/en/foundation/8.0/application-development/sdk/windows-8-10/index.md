---
layout: tutorial
title: Adding the MobileFirst Foundation SDK to Windows 8.1 Universal or Windows 10 UWP Applications
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
## Overview

The MobileFirst Foundation SDK consists of a collection of dependencies that are available through [Nuget](https://www.nuget.org/), and which you can add to your Visual Studio project. The dependencies correspond to core functions and other functions:

* **IBMMobileFirstPlatformFoundation** - Implements client-to-server connectivity, handles authentication and security aspects, resource requests, and other required core functions.

In this tutorial, you learn how to add the MobileFirst Native SDK by using Nuget to a new or existing Windows 8.1 Universal application or to a Windows 10 UWP (Universal Windows Platform) application. You also learn how to configure the MobileFirst Server to recognize the application, and to find information about the MobileFirst configuration files that are added to the project.

> For instruction about how to manually add the SDK files to a project, [visit the user documentation](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/wl_welcome.html).

**Prerequisites:**

- Microsoft Visual Studio 2013 or 2015 and MobileFirst CLI installed on the developer workstation. Developing Windows 10 UWP solution requires at least Visual Studio 2015.
- A local or remote instance of MobileFirst Server is running.
- Read the [Setting up your MobileFirst development environment](../../installation-configuration/development/mobilefirst) and [Setting up your Windows 8 Universal and Windows 10 UWP development environment](../../installation-configuration/development/windows) tutorials.

#### Jump to:

- [Adding the MobileFirst Native SDK](#adding-the-mobilefirst-native-sdk)
- [Updating the MobileFirst Native SDK](#updating-the-mobilefirst-native-sdk)
- [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)

## Adding the MobileFirst Native SDK
Follow the instructions below to add the MobileFirst Native SDK to a new or existing Visual Studio project, and to register the application to the MobileFirst Server.

Before you start, make sure that the MobileFirst Server instance is running.  
If you use a locally installed server: From a **Command-line** window, navigate to the server's folder and run the command: `./run.cmd`.

### Creating an application
Create a Windows 8.1 Universal or Windows 10 UWP project by using Visual Studio 2013/2015 or use an existing project.  

### Adding the SDK

1. To import MobileFirst Studio packages, use the NuGet package manager.
NuGet is the package manager for the Microsoft development platform, including .NET. The NuGet client tools provide the ability to produce and use packages. The NuGet Gallery is the central package repository used by all package authors and users.

2. Open the Windows 8.1 Universal or Windows 10 UWP project in Visual studio 2013/2015. Right-click the project solution and select  **Manage Nuget packages**.

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. In the search option, search for "IBM MobileFirst Platform". Choose **IBM.MobileFirstPlatform.8.0.0.0**.

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. Click **Install**. This action installs the IBM MobileFirst Platform Native SDK and its dependencies. This step also generates an empty `mfpclient.resw` file in the `strings` folder of the Visual Studio project.

5. Ensure that, at a minimum, the following capabilities are enabled in `Package.appxmanifest`:

    - Internet (Client)

### Registering the application

1. Open the **Command-line** and navigate to the root of the Visual Studio project.  

2. Run the command:

    ```bash
    mfpdev app register
    ```
    - If you use a remote server, [use the command `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) to add it.

The `mfpdev app register` CLI command first connects to the MobileFirst Server to register the application, then updates the **mfpclient.resw** file in the **strings** folder in the Visual Studio project, and adds to it the metadata that identifies the MobileFirst Server.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tip:** You can also register applications from the MobileFirst Operations Console:    
>
> 1. Load the MobileFirst Operations Console.  
> 2. Click the **New** button next to **Applications** to register a new application and follow the on-screen instructions.  
> 3. After the application is registered, navigate to the application's **Configuration Files** tab and copy or download the **mfpclient.resw** file. Follow the onscreen instructions to add the file to your project.

## Updating the MobileFirst Native SDK
To update the MobileFirst Native SDK with the latest release, run the following command from the root folder of the Visual Studio project in a **Command-line** window:

```bash
Nuget update
```

## Generated MobileFirst Native SDK artifacts

### mfpclient.resw

Located in the `strings` folder of the project, this file contains server connectivity properties and is user-editable:

- `protocol` – The communication protocol to MobileFirst Server. Either `HTTP` or `HTTPS`.
- `WlAppId` - The identifier of the application. This should be same as the application identifier in the server.
- `host` – The host name of the MobileFirst Server instance.
- `port` – The port of the MobileFirst Server instance.
- `wlServerContext` – The context root path of the application on the MobileFirst Server instance.
- `languagePreference` - Sets the default language for client sdk system messages.

## Tutorials to follow next
With the MobileFirst Native SDK now integrated, you can now:

- Review the [Adapters development tutorials](../../adapters/)
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review the [Notifications tutorials](../../notifications/)
- Review [All Tutorials](../../all-tutorials)
