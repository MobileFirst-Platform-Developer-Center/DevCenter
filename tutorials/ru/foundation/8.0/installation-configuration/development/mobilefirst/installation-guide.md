---
layout: tutorial
title: Workstation Installation Guide
breadcrumb_title: Installation guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Follow this installation guide in order to setup your workstation for development using {{ site.data.keys.product }}.

## DevKit Installer
{: #devkit-installer }
The [{{ site.data.keys.mf_dev_kit }} Installer]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) will install a ready-to-use {{ site.data.keys.mf_server }}, database and runtime on your developer machine.  

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
{: #installation }
Get the DevKit Installer from the [Downloads page]({{site.baseurl}}/downloads/), and follow the on-screen instructions.

![devkit installer](devkit-installer.png)

### Starting and stopping the server
{: #starting-and-stopping-the-server }
Open a command-line window and navigate to the extracted folder location.

*Mac and Linux:*  

* To start the server: `./run.sh -bg`
* To stop the server: `./stop.sh`

*Windows:*  

* To start the server: `./run.cmd -bg`
* To stop the server: `./stop.cmd`

### Accessing the {{ site.data.keys.mf_console }}
{: #accessing-the-mobilefirst-operations-console }
You can access the [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) in the following ways:

* From command-line, execute: `mfpdev server console`
* From a browser, visit: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![console]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
The [{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) is a command-line interface enabling you to register applications in the {{ site.data.keys.mf_server }}, pull/push application from/to the {{ site.data.keys.mf_server }}, create Java and JavaScript adapters, manage multiple local and remote servers, update live applications using Direct Update and so on.

**Prerequisite:**  
1. NodeJS and NPM are requirements before you can install the {{ site.data.keys.mf_cli }}.  
 Download and install [NodeJS v6.11.1](https://nodejs.org/download/release/v6.11.1/) and NPM v3.10.10.

 To Verify the installation, open a command-line window and execute: `node -v`.

2. Some CLI commands, such as creating, building and deploying adapters require Maven. See the next section for installation instructions.

### Installation of {{ site.data.keys.mf_cli }}
{: #installation-cli }
Open Terminal and execute: `npm install -g mfpdev-cli`.  

*Mac and Linux:* Note that you may need to run the command using `sudo`.  
Read more about [fixing NPM permissions](https://docs.npmjs.com/getting-started/fixing-npm-permissions).

To Verify the installation, open a command-line window and execute: `mfpdev -v` or `mfpdev help`.

![console](mfpdev-cli.png)

## Adapters and Security Checks
{: #adapters-and-security-checks }
[Adapters]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) and [Security Checks]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security) are your door-way to introduce authentication and other security layers to your application.

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
{: #usage }
With Apache Maven installed, you can now create adapters either via Maven command-line commands, or by using the {{ site.data.keys.mf_cli }}.  
For more information, review the [Adapters tutorials]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).
