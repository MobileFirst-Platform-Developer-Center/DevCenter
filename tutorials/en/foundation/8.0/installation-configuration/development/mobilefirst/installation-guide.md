---
layout: tutorial
title: Workstation Installation Guide
breadcrumb_title: Installation guide
weight: 10
---
## Overview
Follow this installation guide in order to setup your workstation for development using MobileFirst Foundation.

## DevKit Installer
The MobileFirst Foundation [Development Kit Installer]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) will install a ready-to-use MobileFirst Server, database and runtime on your developer machine.  

**Prerequisite:**  
The installer requires Java installed.

1. [Install Oracle's JRE](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).
    
2. Add a `JAVA_HOME` variable, pointing to the JRE

    *Mac and Linux:* Edit your **~/.bash_profile**:
    
    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```
    
    *Windows:*  
    [Follow this guide](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html).

### Installation
Get the DevKit Installer from the [Downloads page]({{site.baseurl}}/downloads/), and follow the on-screen instructions.

![devkit installer](devkit-installer.png)

### Starting and stopping the server
Open a command-line window and navigate to the extracted folder location.

*Mac and Linux:*  

* To start the server: `./run.sh -bg`
* To stop the server: `./stop.sh`

*Windows:*  

* To start the server: `./run.cmd -bg`
* To stop the server: `./stop.cmd`

### Accessing the MobileFirst Operations Console
You can access the [MobileFirst Operations Console]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) in the following ways:

* From command-line, execute: `mfpdev server console`
* From a browser, visit: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![console]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## MobileFirst CLI
The [MobileFirst CLI]({{site.baseurl}}/tutorials/en/foundation/8.0/app-dev/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) is a command-line interface enabling you to register applications in the MobileFirst Server, pull/push application from/to the MobileFirst Server, create Java and JavaScript adapters, manage multiple local and remote servers, update live applications using Direct Update and so on.

**Prerequisite:**  
1. NodeJS is a requirement before you can install the MobileFirst CLI.  
 Download and install [NodeJS v4.4.3 LTS](https://nodejs.org/en/).

 To Verify the installation, open a command-line window and execute: `node -v`.

2. Some CLI commands, such as creating, building and deploying adapters require Maven. See the next section for installation instructions.

### Installation 
Open Terminal and execute: `npm install -g mfpdev-cli`.  

*Mac and Linux:* Note that you may need to run the command using `sudo`.  
Read more about [fixing NPM permissions](https://docs.npmjs.com/getting-started/fixing-npm-permissions).
    
To Verify the installation, open a command-line window and execute: `mfpdev -v` or `mfpdev help`.

![console](mfpdev-cli.png)

## MobileFirst Adapters and Security Checks
[MobileFirst Adapters]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) and [Security Checks]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security) are your door-way to introduce authentication and other security layers to your application.

**Prerequisite:**  
Apache Maven is a required to set-up before you can create adapters and security checks.  
    
1. [Download the Apache Maven .zip](https://maven.apache.org/download.cgi)
2. Add a `MVN_PATH` variable, pointing to the Maven folder
    
    *Mac and Linux:* Edit your **~/.bash_profile**:
    
    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows:*  
    [Follow this guide](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/).
Verify the installation by executing: `mvn -v`.

### Usage
With Apache Maven installed, you can now create adapters either via Maven command-line commands, or by using the MobileFirst CLI.  
For more informationm, review the [Adapters tutorials]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).

