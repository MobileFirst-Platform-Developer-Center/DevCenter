---
layout: tutorial
title: Using MobileFirst Developer CLI to Manage MobileFirst Artifacts
weight: 1
relevantTo: [ios,android,windows,cordova]
---
## Overview

IBM MobileFirst Platform Foundation provides a Command Line Interface (CLI) tool to easily create, manage, push, and register  MobileFirst client and server artifacts. The CLI tool enables you to use your preferred code editors or alternative IDEs.

By using the CLI, you can create and manage the following types of applications: Cordova-based applications (iOS, Android and Windows) using the MobileFirst JavaScript SDK as a cordova plug-in, and Native applications using the MobileFirst Native SDK (iOS, Android, Windows Universal, Windows Phone Silverlight).

You can also create, register, and manage MobileFirst adapters to either local or remote MobileFirst Server instances, and administer projects from the command line or via REST services, or from the MobileFirst Operations Console.

For more information regarding SDK integration in native applications, see the tutorials in the [Configuring the MobileFirst Platform Foundation SDK category](../../configuring-the-mfpf-sdk)

For more information regarding SDK integration in Cordova applications, see the  [Integrating MobileFirst Platform Foundation SDK in Pure Cordova Applications](../integrating-mfpf-sdk-in-pure-cordova-applications/) tutorial.

>Learn more about the MobileFirst CLI in the "MobileFirst Platform Command Line Interface" topic in the user documentation

#### Jump to

* [Installing the Command Line Interface](#installation)
* [Managing MobileFirst Server instances](#managingServers)
* [Managing Applications](#managingApplications)
* [Managing Adapters](#adapters)
* [Exporting and importing MobileFirst projects](#importExport)
* [Optimizing applications with CLI](#optimizing)
* [Helpful commands](#helpfulCommands)


## Installing the Command Line Interface

Before continuing with this tutorial, [you must first register and download</a> the CLI Installer](https://www14.software.ibm.com/webapp/iwm/web/signup.do?source=swg-worklight&S_PKG=ov1268&S_CMP=web_dw_rt_swd) the CLI Installer.

Installation and setup instructions are provided in the download page.

The CLI Installer adds the installation folder to your *path* environment variable so that you can run CLI commands from any directory.


## Managing MobileFirst Server instances

The instance of the Liberty development server is created in the default user directory. For example:<br />
`/Users/cli-user/.ibm/mobilefirst/7.1.0.00-build-number/server`.

### Server commands

* mfpdev server info
* mfpdev server add
* mfpdev server edit
* mfpdev server remove
* mfpdev server console
* mfpdev server clean

## Managing applications

* mfpdev app register
* mfpdev app config
* mfpdev app preview
* mfpdev app webupdate
* mfpdev app pull
* mfpdev app push

## Managing and Testing Adapters

* mfpdev adapter create
* mfpdev adapter build
* mfpdev adapter deploy
* mfpdev adapter call

## Helpful commands

* mfpdev config
* mfpdev help
* mfpdev info
* mfpdev -v

## Tutorials to follow next

to be updated...
