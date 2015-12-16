---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Windows 8 Universal Applications
breadcrumb_title: Windows 8 Universal SDK
relevantTo: [windows8]
weight: 4
---
## Overview

To serve a native Windows 8 Universal application, MobileFirst Server must be aware of it. For this purpose, IBM MobileFirst Platform Foundation provides a Native API library, which contains a set of APIs and configuration files.

This tutorial explains how to generate the Windows 8 Universal Native API and how to integrate it with a native Windows Universal application. These steps are necessary for you to be able to use it later on for tasks such as connecting to MobileFirst Server, invoking adapter procedures, implementing authentication methods, and so on.

**Prerequisite:** Developers are expected to be proficient with Microsoft developer tools.

## Creating a MobileFirst native API

### CLI

1.[Using CLI](../../advanced-client-side-development/using-cli-create-build-manage-project-artifacts/) create a new MobileFirst project:

``````bash
$ mfp create HelloWorldNative</code>
``````

2.Go to the newly created project directory:
`````bash
$ cd HelloWorldNative
`````
3.Add a new Windows Universal native API:
`````bash
$ mfp add api Win8HelloWorld -e windows8
`````
4.Navigate into the native API folder and run the command:
`````bash
$ mfp push
`````
** Note:**
This action is required for MobileFirst Server to recognize the application if it attempts to connect.

## Manually adding the MobileFirst Native SDK

To import worklight studio packages, NuGet package manager is used.
NuGet is the package manager for the Microsoft development platform including .NET. The NuGet client tools provide the ability to produce and consume packages. The NuGet Gallery is the central package repository used by all package authors and consumers.

Follow the instructions to manually add MobileFirst native SDK to
an existing or new Windows 8 Univeral application.

1.
Create a Windows 8 Universal project using Visual Studio 2013/2015 or use an existing project.

2.
Right click the project solution and navigate -> Manage Nuget packages for solution.

3.
In the search option , search for IBM MobileFirst Platform. Choose IBM.MobileFirstPlatform.8.0.0.0.

4.
Click Install. This installs the IBM MobileFirstPlatform Native SDK and its dependencies.

Alternatively,

Browse to https://www.nuget.org/packages

- Search for IBM MobileFirstPlatform SDK

- Download IBM.MobileFirstPlatform.8.0.0.0.nupkg to your filesystem.
- Open Visual Studio 2013/2015. Click on Tools -> NuGet Package Manager -> Package Manager Settings.
Select Package Sources
Click Add (+)
Give some name to your package and choose the path to your .nupkg file and click update.
Close the dialog. 	

- In Solution explorer, right click on the Solution| Manage NuGet Packages for Solution...
Select the source you created in Step 1 or search for IBM MobileFirst Platform in search tab
Choose IBM MobileFirst Platform

- Click on Install

The MobileFirst native API contains several components:

- **worklight-windows8.dll** is a MobileFirst API library that you must copy to your native Windows 8 Universal project. This is contained within the "buildtarget" folder , under the respective hardware architecture.
- **Newtonsoft.Json.dll** is a library that provides JSON support.
- **SharpCompress.dll** is a library that provides compression support.
- **application-descriptor.xml** defines application metadata and security settings that MobileFirst Server enforces.
- **mfpclient.resw** contains connectivity settings that a native Windows Universal application uses. You must copy this file to your native Windows Universal project.
- As with any MobileFirst project, you create the server configuration by modifying the files that are in the **server\conf** folder.

### mfpclient.resw

You can edit the **wlclient.properties** file to set connectivity information.

- *wlServerProtocol* – The communication protocol to MobileFirst Server, which is either http or https.
- *wlServerHost* – The host name of the MobileFirst Server instance.
- *wlServerPort* – The port of the MobileFirst Server instance.
- *wlServerContext* – The context root path of the application on MobileFirst Server.
- *wlAppId* – The application ID as defined in the **application-descriptor.xml** file.
- *wlAppVersion* – The application version.
- *wlEnvironment* – The target environment of the native application.
- *wlPlatformVersion* – The MobileFirst Studio version.
- *languagePreferences* – The list of preferred locales.

In Visual Studio, open the **Properties**window of the *mfpclient.resw*file and set the **Copy to Output Directory** option to **Copy always**.

Add the following capabilities to the *Package.appxmanifest*:

>Internet (Client &amp; Server)

>Private Networks (Client &amp; Server)

For more information, see the topic about developing native C# applications for Windows Universal, in the user documentation.

## Tutorials to follow next
Now that your application contains the Native API library, you can follow the tutorials in the
[Native Windows 8 Development](../../native/windows8/) section to learn more about authentication and security, server-side development, advanced client-side development, notifications and more.
