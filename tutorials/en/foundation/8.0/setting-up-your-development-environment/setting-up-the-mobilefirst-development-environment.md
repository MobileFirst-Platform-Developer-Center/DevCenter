---
layout: tutorial
title: Setting up the MobileFirst development environment
breadcrumb_title: MobileFirst environment
relevantTo: [ios,android,windows,cordova]
weight: 1
---
## Overview
This tutorial covers the basics of the IBM MobileFirst Platfrom Foundation development environment and tools.

- The MobileFirst developer tools are supported on the following operating systems: Windows, Apple OS X and Linux.
- The MobileFirst Operations Console is supported in modern browsers such as: Internet Explorer 10+, latest Chrome, Safari and Firefox.

#### Jump to:

- [MobileFirst Development Server](#mobilefirst-development-server)
- [MobileFirst Command-line Interface](#mobilefirst-command-line-interface)
- [MobileFirst Studio](#mobilefirst-studio)
- [Applications and Adapters Development](#applications-and-adapters-development)

## MobileFirst Development Server
The IBM MobileFirst Development Server is a web application archive (.war) that is deployed on an IBM WebSphere Liberty profile Application Server.  
From the MobileFirst Server's Operations Console a developer can:

- Register and deploy applications and adapters
- Optionally download native/Cordova application templates 
- Configure application aspects:
    - Authentication and security
    - Authenticity
    - Push Notifications
    - Direct Update
- Generate DevOps scripts for continuous integration workflows and faster development cycles
- and more

To learn more about the MobileFirst Operations Console, see the tutorial: [Using the MobilFirst Platform Operations Console](../../quick-start/console/).  
To download and install the MobileFirst Development Server, visit the [downloads]({{site.base}}/downloads/) page.

## MobileFirst Command-line Interface
The IBM MobileFirst command-line interface (CLI) tool enables developers to:

- Manage MobileFirst Servers
- Register and configure applications
- Create, build, deploy and test adapters

To download and install the MobileFirst CLI, visit the [downloads]({{site.base}}/downloads/) page.

> Learn more about the various CLI commands in the [Using CLI to manage MobileFirst artifacts](../../client-side-development/using-cli-to-manage-mobilefirst-artifacts/) tutorial.

## MobileFirst Studio
IBM MobileFirst Studio is an Eclipse plug-in that interfaces with the MobileFirst CLI and provides a User Interface for commands such as:

- Application &amp; adapter creation and registration
- Updating of applications and adapters to or from the server
- Opening the MobileFirst Operations Console
- Use of Direct Update

To download and install MobileFirst Studio, visit the [downloads]({{site.base}}/downloads/) page.

#### Requirements
To use MobileFirst Studio for Cordova application development, it is also required to download and install the [THyM Eclipse plug-in](https://www.eclipse.org/community/eclipse_newsletter/2014/november/article3.php).

## Applications and adapters development
You can use your preferred code editor or alternative IDEs, such as Atom.io, Eclipse, IntelliJ and others, to implement applications and adapters.  
To learn more about MobileFirst development, refer to [the tutorials sections](../../all-tutorials/).  
