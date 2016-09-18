---
layout: tutorial
title: Administrating MobileFirst applications through Ant
weight: 3
---
## Overview
You can administer MobileFirst applications through the **mfpadm** Ant task.

#### Jump to

* [Comparison with other facilities](#comparison-with-other-facilities)
* [Prerequisites](#prerequisites)

## Comparison with other facilities
You can execute administration operations with IBM MobileFirst Foundation in the following ways:

* The MobileFirst Operations Console, which is interactive.
* The **mfpadm** Ant task.
* The **mfpadm** program.
* The MobileFirst administration REST services.

The **mfpadm** Ant task, **mfpadm** program, and REST services are useful for automated or unattended execution of operations, such as:

* Eliminating operator errors in repetitive operations, or
* Operating outside the operator's normal working hours, or
* Configuring a production server with the same settings as a test or preproduction server.

The **mfpadm** Ant task and the **mfpadm** program are simpler to use and have better error reporting than the REST services. The advantage of the **mfpadm** Ant task over the mfpadm program is that it is platform independent and easier to integrate when integration with Ant is already available.

## Prerequisites
The **mfpadm** tool is installed with the MobileFirst Server installer. In the rest of this page, **product\_install\_dir** indicates the installation directory of the MobileFirst Server installer.

Apache Ant is required to run the **mfpadm** task. For information about the minimum supported version of Ant, see System requirements.

For convenience, Apache Ant 1.9.4 is included in MobileFirst Server. In the **product\_install\_dir/shortcuts/** directory, the following scripts are provided.

* ant for UNIX / Linux
* ant.bat for Windows

These scripts are ready to run, which means that they do not require specific environment variables. If the environment variable JAVA_HOME is set, the scripts accept it.

You can use the **mfpadm** Ant task on a different computer than the one on which you installed MobileFirst Server.

* Copy the file **product\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar** to the computer.
* Make sure that a supported version of Apache Ant and a Java™ runtime environment are installed on the computer.

To use the **mfpadm** Ant task, add this initialization command to the Ant script:

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

Other initialization commands that refer to the same **mfp-ant-deployer.jar** file are redundant because the initialization by **defaults.properties** is also implicitly done by antlib.xml. Here is one example of a redundant initialization command:

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

For more information about running the MobileFirst Server installer, see [Running IBM Installation Manager](../../../installation-configuration/production/installation-manager/).

#### Jump to

* Calling the **mfpadm** Ant task
* Commands for general configuration
* Platform Server or of a runtime.
* Commands for adapters
* Commands for apps
* Commands for devices
* Commands for troubleshooting

### Calling the mfpadm Ant task
You can use the **mfpadm** Ant task and its associated commands to administer MobileFirst applications.
Call the **mfpadm** Ant task as follows:

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    some commands
</mfpadm>
```

#### Attributes
The **mfpadm** Ant task has the following attributes:

| Attribute | Description | Required | Default | 
|-----------|-------------|----------|---------|
| url	    | The base URL of the MobileFirst web application for administration services | Yes	 | |
| secure	| Whether to avoid operations with security risks | No | true |
| user	    |The user name for accessing the MobileFirst administration services | Yes | |
| password	| The password for the user | Either one is required | |
| passwordfile   |	The file that contains the password for the user | Either one is required | |	 
| timeout	     | Timeout for the entire REST service access, in seconds | No | |
| connectTimeout |	Timeout for establishing a network connection, in seconds | No | |	 
| socketTimeout  |	Timeout for detecting the loss of a network connection, in seconds | No | |
| connectionRequestTimeout |	Timeout for obtaining an entry from a connection request pool, in seconds | No | |
| lockTimeout    |	Timeout for acquiring a lock | No | |

**url** 
The base URL preferably uses the HTTPS protocol. For example, if you use default ports and context roots, use the following URL.

* For WebSphere® Application Server: [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* For Tomcat: [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**  
The default value is **true**. Setting **secure="false"** might have the following effects:

* The user and password might be transmitted in an unsecured way, possibly even through unencrypted HTTP.
* The server's SSL certificates are accepted even if self-signed or if they were created for a different host name than the specified server's host name.

**password**
Specify the password either in the Ant script, through the **password** attribute, or in a separate file that you pass through the **passwordfile** attribute. The password is sensitive information and therefore needs to be protected. You must prevent other users on the same computer from knowing this password. To secure the password, before you enter the password into a file, remove the read permissions of the file for users other than yourself. For example, you can use one of the following commands:

* On UNIX: `chmod 600 adminpassword.txt`
* On Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

Additionally, you might want to obfuscate the password to hide it from an occasional glimpse. To do so, use the **mfpadm** config password command to store the obfuscated password in a configuration file. Then, you can copy and paste the obfuscated password to the Ant script or to the password file.

The **mfpadm** call contains commands that are encoded in inner elements. These commands are executed in the order in which they are listed. If one of the commands fails, the remaining commands are not executed, and the **mfpadm** call fails.

#### Elements
You can use the following elements in **mfpadm** calls:

| Element | Description | Count |
|---------|-------------|-------|
| show-info	                    | Shows user and configuration information | 0..∞ | 
| show-global-config	        | Shows global configuration information | 0..∞ | 
| show-diagnostics              | Shows diagnostics information | 0..∞ | 
| show-versions	                | Shows versions information | 0..∞ | 
| unlock	                    | Releases the general-purpose lock | 0..∞ | 
| list-runtimes	                | Lists the runtimes | 0..∞ | 
| show-runtime      	        | Shows information about a runtime | 0..∞ | 
| delete-runtime	            | Deletes a runtime | 0..∞ | 
| show-user-config	            | Shows the user configuration of a runtime | 0..∞ | 
| set-user-config	            | Specifies the user configuration of a runtime | 0..∞ | 
| show-confidential-clients	    | Shows the configurations of confidential clients of a runtime | 0..∞ | 
| set-confidential-clients	    | Specifies the configurations of confidential clients of a runtime | 0..∞ | 
| set-confidential-clients-rule	| Specifies a rule for the confidential clients configuration of a runtime | 0..∞ | 
| list-adapters	                | Lists the adapters | 0..∞ | 
| deploy-adapter	            | Deploys an adapter | 0..∞ | 
| show-adapter	                | Shows information about an adapter | 0..∞ | 
| delete-adapter	            | Deletes an adapter | 0..∞ | 
| adapter	                    | Other operations on an adapter | 0..∞ | 
| list-apps	                    | Lists the apps | 0..∞ | 
| deploy-app	                | Deploys an app | 0..∞ | 
| show-app	                    | Shows information about an app | 0..∞ | 
| delete-app	                | 	Deletes an app | 0..∞ | 
| show-app-version              | 		Shows information about an app version | 0..∞ | 
| delete-app-version            | 	Delete a version of an app | 0..∞ | 
| app	                        | Other operations on an app | 0..∞ | 
| app-version	                | Other operations on an app version | 0..∞ | 
| list-devices	                | Lists the devices | 0..∞ | 
| remove-device	                | Removes a device | 0..∞ | 
| device	                    | Other operations for a device | 0..∞ | 
| list-farm-members	            | Lists the members of the server farm | 0..∞ | 
| remove-farm-member	        | Removes a server farm member | 0..∞ | 

#### XML Format
The output of most commands is in XML, and the input to specific commands, such as `<set-accessrule>`, is in XML too. You can find the XML schemas of these XML formats in the **product\_install\_dir/MobileFirstServer/mfpadm-schemas/** directory. The commands that receive an XML response from the server verify that this response conforms to the specific schema. You can disable this check by specifying the attribute **xmlvalidation="none"**. 

#### Output character set
Normal output from the mfpadm Ant task is encoded in the encoding format of the current locale. On Windows, this encoding format is the so-called "ANSI code page". The effects are as follows:

* Characters outside of this character set are converted to question marks when they are output.
* When the output goes to a Windows command prompt window (cmd.exe), non-ASCII characters are incorrectly displayed because such windows assume characters to be encoded in the so-called "OEM code page".

To work around this limitation:

* On operating systems other than Windows, use a locale whose encoding is UTF-8. This locale is the default locale on Red Hat Linux and macOS. Many other operating systems have the en_US.UTF-8 locale.
* Or use the attribute **output="some file name"** to redirect the output of a mfpadm command to a file.

### Commands for general configuration

### Platform Server or of a runtime.
### Commands for adapters
### Commands for apps
### Commands for devices
### Commands for troubleshooting


