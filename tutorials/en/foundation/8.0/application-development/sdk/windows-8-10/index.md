---
layout: tutorial
title: Adding the MobileFirst Foundation SDK to Windows 8.1 Universal or Windows 10 UWP Applications
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The {{ site.data.keys.product }} SDK consists of a collection of dependencies that are available through [Nuget](https://www.nuget.org/), and which you can add to your Visual Studio project. The dependencies correspond to core functions and other functions:

* **IBMMobileFirstPlatformFoundation** - Implements client-to-server connectivity, handles authentication and security aspects, resource requests, and other required core functions.

In this tutorial, you learn how to add the {{ site.data.keys.product_adj }} Native SDK by using Nuget to a new or existing Windows 8.1 Universal application or to a Windows 10 UWP (Universal Windows Platform) application. You also learn how to configure the {{ site.data.keys.mf_server }} to recognize the application, and to find information about the {{ site.data.keys.product_adj }} configuration files that are added to the project.

**Prerequisites:**

- Microsoft Visual Studio 2013 or 2015 and {{ site.data.keys.mf_cli }} installed on the developer workstation. Developing Windows 10 UWP solution requires at least Visual Studio 2015.
- A local or remote instance of {{ site.data.keys.mf_server }} is running.
- Read the [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/development/mobilefirst) and [Setting up your Windows 8 Universal and Windows 10 UWP development environment](../../../installation-configuration/development/windows) tutorials.

#### Jump to:
{: #jump-to }
- [Adding the {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Updating the {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Generated {{ site.data.keys.product_adj }} Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)

## Adding the {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Follow the instructions below to add the {{ site.data.keys.product_adj }} Native SDK to a new or existing Visual Studio project, and to register the application to the {{ site.data.keys.mf_server }}.

Before you start, make sure that the {{ site.data.keys.mf_server }} instance is running.  
If you use a locally installed server: From a **Command-line** window, navigate to the server's folder and run the command: `./run.cmd`.

### Creating an application
{: #creating-an-application }
Create a Windows 8.1 Universal or Windows 10 UWP project by using Visual Studio 2013/2015 or use an existing project.  

### Adding the SDK
{: #adding-the-sdk }
1. To import {{ site.data.keys.product_adj }} packages, use the NuGet package manager.
NuGet is the package manager for the Microsoft development platform, including .NET. The NuGet client tools provide the ability to produce and use packages. The NuGet Gallery is the central package repository used by all package authors and users.

2. Open the Windows 8.1 Universal or Windows 10 UWP project in Visual studio 2013/2015. Right-click the project solution and select  **Manage Nuget packages**.

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. In the search option, search for "IBM MobileFirst Platform". Choose **IBM.MobileFirstPlatform.{{ site.data.keys.product_V_R_M_I }}**.

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. Click **Install**. This action installs the {{ site.data.keys.product }} Native SDK and its dependencies. This step also generates an empty `mfpclient.resw` file in the `strings` folder of the Visual Studio project.

5. Ensure that, at a minimum, the following capabilities are enabled in `Package.appxmanifest`:

    - Internet (Client)

### Registering the application
{: #reigstering-the-application }
1. Open the **Command-line** and navigate to the root of the Visual Studio project.  

2. Run the command:

   ```bash
   mfpdev app register
   ```
    - If you use a remote server, [use the command `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) to add it.

The `mfpdev app register` CLI command first connects to the {{ site.data.keys.mf_server }} to register the application, then updates the **mfpclient.resw** file in the **strings** folder in the Visual Studio project, and adds to it the metadata that identifies the {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tip:** You can also register applications from the {{ site.data.keys.mf_console }}:    
>
> 1. Load the {{ site.data.keys.mf_console }}.  
> 2. Click the **New** button next to **Applications** to register a new application and follow the on-screen instructions.  
> 3. After the application is registered, navigate to the application's **Configuration Files** tab and copy or download the **mfpclient.resw** file. Follow the onscreen instructions to add the file to your project.

## Updating the {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
To update the {{ site.data.keys.product_adj }} Native SDK with the latest release, run the following command from the root folder of the Visual Studio project in a **Command-line** window:

```bash
Nuget update
```

## Generated {{ site.data.keys.product_adj }} Native SDK artifacts
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.resw
{: #mfpclientresw }
Located in the `strings` folder of the project, this file contains server connectivity properties and is user-editable:

- `protocol` – The communication protocol to {{ site.data.keys.mf_server }}. Either `HTTP` or `HTTPS`.
- `WlAppId` - The identifier of the application. This should be same as the application identifier in the server.
- `host` – The host name of the {{ site.data.keys.mf_server }} instance.
- `port` – The port of the {{ site.data.keys.mf_server }} instance.
- `wlServerContext` – The context root path of the application on the {{ site.data.keys.mf_server }} instance.
- `languagePreference` - Sets the default language for client sdk system messages.

## Tutorials to follow next
{: #tutorials-to-follow-next }
With the MobileFirst Native SDK now integrated, you can now:

- Review the [Using the {{ site.data.keys.product }} SDK tutorials](../)
- Review the [Adapters development tutorials](../../../adapters/)
- Review the [Authentication and security tutorials](../../../authentication-and-security/)
- Review the [Notifications tutorials](../../../notifications/)
- Review [All Tutorials](../../../all-tutorials)
