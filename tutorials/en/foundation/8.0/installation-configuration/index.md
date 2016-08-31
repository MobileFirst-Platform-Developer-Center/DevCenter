---
layout: tutorial
title: Installation and Configuration
weight: 2
---
## Overview
IBM MobileFirst Foundation provides development tools and server-side components that you can install on-premises or deploy to the cloud for test or production use. Review the installation topics appropriate for your installation scenario.

### Installing a development environment
If you develop the client-side or the server-side of mobile apps, use either the [MobileFirst Developer Kit](development/mobilefirst/) or [Mobile Foundation Bluemix service](../bluemix/using-mobile-foundation) to get started.

* [Set-up the MobileFirst development environment](development/mobilefirst/)
* [Set-up the Cordova development environment](development/cordova)
* [Set-up the iOS development environment](development/ios)
* [Set-up the Android development environment](development/android)
* [Set-up the Windows development environment](development/windows)
* [Set-up the Web development environment](development/web)

### Installing a test or production server on-premises
IBM installations are based on an IBM product called IBM Installation Manager. Install IBM Installation Manager V1.8.4 or later separately before you install IBM MobileFirst Foundation.

> **Important:** Ensure that you use IBM Installation Manager V1.8.4 or later. The older versions of Installation Manager are not able to install IBM MobileFirst Foundation v8.0 because the postinstallation operations of the product require Java 7. The older versions of Installation Manager come with Java 6.

The MobileFirst Server installer copies onto your computer all the tools and libraries that are required for deploying MobileFirst Server components and optionally the IBM MobileFirst Platform Application Center to your application server.

If you install a test or production server, start with **Tutorials about MobileFirst Server installation** below for a simple installation and to learn about the installation of MobileFirst Server. For more information about preparing an installation for your specific environment, see [Installing MobileFirst Server for a production environment](production).

**Tutorials about MobileFirst Server installation**  
Learn about the MobileFirst Server installation process by walking through the instructions to create a functional MobileFirst Server, cluster with two nodes on WebSphere® Application Server Liberty profile. The installation can be done in two ways:

* [By using the graphical mode of IBM® Installation Manager](graphical-mode) and the Server Configuration Tool.
* [By using the command line tool](command-line).

Afterwards you'll have a working MobileFirst Server. However, you need to configure it, in particular for security, before you use the server. For more information, see [Configuring MobileFirst Server](production/configuring-mobilefirst-server).

**Additions**  

* To add MobileFirst Analytics Server to your installation, see [MobileFirst Analytics Server installation guide]().  
* To install IBM MobileFirst Platform Application Center, see [Installing and configuring the Application Center]().

### Deploying MobileFirst Server to the cloud
If you plan to deploy MobileFirst Server to the cloud, see [Deploying MobileFirst Server to the cloud]().

### Upgrading from earlier versions
For information about upgrading existing installations and applications to a newer version, see [Upgrading to IBM MobileFirst Foundation v8.0]().


