---
layout: tutorial
title: Installing and configuring for token licensing
weight: 5
---
## Overview
If you plan to use token licensing for MobileFirst Server, you must install the Rational® Common Licensing library and configure your application server to connect MobileFirst Server to the Rational License Key Server.

The following topics describe the installation overview, the manual installation of Rational Common Licensing library, the configuration of the application server, and the platform limitations for token licensing.

#### Jump to

* [Planning for the use of token licensing](#planning-for-the-use-of-token-licensing)
* [Installation overview for token licensing](#installation-overview-for-token-licensing)
* [Connecting MobileFirst Server installed on Apache Tomcat to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Connecting MobileFirst Server installed on WebSphere Application Server Liberty profile to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Connecting MobileFirst Server installed on WebSphere Application Server to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Limitations of supported platforms for token licensing](#limitations-of-supported-platforms-for-token-licensing)
* [Troubleshooting token licensing problems](#troubleshooting-token-licensing-problems)

## Planning for the use of token licensing
If the token licensing is purchased for MobileFirst Server, you have extra steps to consider in the installation planning.

### Technical restrictions
Here are the technical restrictions for the use of token licensing:

#### Supported Platforms:
The list of platforms that support token licensing is listed at [Limitations of supported platforms for token licensing](#limitations-of-supported-platforms-for-token-licensing). The MobileFirst Server running on a platform that is not listed might not be possible to install and configure for token licensing. The native libraries for the Rational® Common Licensing client might not available for the platform or not supported.

#### Supported Topologies:
The topologies that are supported by token licensing is listed at [Constraints on MobileFirst Server administration service, MobileFirst Server live update service and MobileFirst runtime](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-runtime).

### Network requirement
MobileFirst Server must be able to communicate with the Rational License Key Server.

This communication requires the access to the following two ports of the license server:

* License manager daemon (**lmgrd**) port - the default port number is 27000.
* Vendor daemon (**ibmratl**) port
 
To configure the ports so that they use static values, see How to serve a license key to client machines through a firewall.

### Installation Process

You need to activate token licensing when you run the IBM® Installation Manager at installation time. For more information about the instructions for enabling token licensing, see [Installation overview for token licensing](#installation-overview-for-token-licensing).

After MobileFirst Server is installed, you must manually configure the server for token licensing. For more information, see the following topics in this section.

The MobileFirst Server is not functional before you complete this manual configuration. The Rational Common Licensing client library is to be installed in your application server, and you define the location of the Rational License Key Server.

### Operations
After you install and configure IBM MobileFirst Platform Server for token licensing, the server validates licenses during various scenarios. For more information about the retrieval of tokens during operations, see [Token license validation]().

If you need to test a non-production application on a production server with token licensing enabled, you can declare the application as non-production. For more information about declaring the application type, see [Setting the application license information]().

## Installation overview for token licensing
If you intend to use token licensing with IBM MobileFirst Foundation, make sure that you go through the following preliminary steps in this order.

> **Important:** Your choice about token licensing (activating it or not) as part of an installation that supports token licensing cannot be modified. If later you need to change the token licensing option, you must uninstall IBM MobileFirst Platform Foundation and reinstall it.

1. Activate token licensing when you run IBM® Installation Manager to install IBM MobileFirst Foundation.

    #### Graphic mode installation
    If you install the product in graphic mode, select **Activate token licensing with the Rational License Key Server** option in the **General settings** panel during the installation.
    
    ![Activting token licensing in the IBM installation manager](licensing_with_tokens_activate.jpg)
    
    #### Command line mode installation
    If you install in silent mode, set the value as **true** to the **user.licensed.by.tokens** parameter in the response file.  
    For example, you can use:
    
    ```bash
    imcl install com.ibm.mobilefirst.foundation.server -repositories mfp_repository_dir/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
    ```
    
2. Deploy the MobileFirst Server to an application server after the product installation is complete. For more information, see [Installing MobileFirst Server to an application server](../appserver).

3. Configure MobileFirst Server for token licensing. The steps depend on your application server.

* For WebSphere Application Server Liberty profile, see [Connecting MobileFirst Server installed on WebSphere Application Server Liberty profile to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* For Apache Tomcat, see [Connecting MobileFirst Server installed on Apache Tomcat to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* For WebSphere Application Server full profile, see [Connecting MobileFirst Server installed on WebSphere Application Server to the Rational License Key Server](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server).

## Connecting MobileFirst Server installed on Apache Tomcat to the Rational License Key Server
## Connecting MobileFirst Server installed on WebSphere Application Server Liberty profile to the Rational License Key Server
## Connecting MobileFirst Server installed on WebSphere Application Server to the Rational License Key Server
## Limitations of supported platforms for token licensing
The list of operating system, its version, and the hardware architecture that supports MobileFirst Server with token licensing enabled.

For token licensing, the MobileFirst Server needs to connect to the Rational® License Key Server by using the Rational Common Licensing library.

This library is composed of a Java™ library and also native libraries. These native libraries depend on the platform where MobileFirst Server is running. Thus, the token licensing by MobileFirst Server is supported only on platforms where the Rational Common Licensing library can be run.

The following table describes the platforms that support MobileFirst Server with the token licensing.

| Operating System             | Operating System version |	Hardware architecture |
|------------------------------|--------------------------|-----------------------|
| AIX®                         | 7.1                      |	POWER8® (64-bit only) |
| SUSE Linux Enterprise Server | 11	                      | x86-64 only           |
| Windows Server               | 2012	                  | x86-64 only           |

Token licensing does not support 32-bit Java Runtime Environment (JRE). Make sure that the application server uses a 64-bit JRE.

## Troubleshooting token licensing problems