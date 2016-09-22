---
layout: tutorial
title: Administrating applications through Ant
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
* Make sure that a supported version of Apache Ant and a Java runtime environment are installed on the computer.

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

* [Calling the **mfpadm** Ant task](#calling-the-mfpadm-ant-task)
* [Commands for general configuration](#commands-for-general-configuration)
* [Commands for adapters](#commands-for-adapters)
* [Commands for apps](#commands-for-apps)
* [Commands for devices](#commands-for-devices)
* [Commands for troubleshooting](#commands-for-troubleshooting)

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

| Attribute      | Description | Required | Default | 
|----------------|-------------|----------|---------|
| url	         | The base URL of the MobileFirst web application for administration services | Yes	 | |
| secure	     | Whether to avoid operations with security risks | No | true |
| user	         | The user name for accessing the MobileFirst administration services | Yes | |
| password	     | The password for the user | Either one is required | |
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

| Element                       | Description | Count |
|-------------------------------|-------------|-------|
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
| delete-app	                | Deletes an app | 0..∞ | 
| show-app-version              | Shows information about an app version | 0..∞ | 
| delete-app-version            | Delete a version of an app | 0..∞ | 
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
When you call the **mfpadm** Ant task, you can include various commands that access the global configuration of the IBM MobileFirst Server or of a runtime.

#### The `show-global-config` command
The `show-global-config` command shows the global configuration. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output	     | Name of the output file.  |	No	   | Not applicable |
| outputproperty | Name of the Ant property for the output. | No | Not applicable |

**Example**  

```xml
<show-global-config/>
```

This command is based on the [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST service.

<br/>
#### The `show-user-config` command
The `show-user-config` command, outside of `<adapter>` and `<app-version>` elements, shows the user configuration of a runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	     | Name of the runtime.      | Yes     |	Not available |
| format	     | Specifies the output format. Either json or xml. | Yes | Not available       | 
| output	     | Name of the file in which to store the output.   | No  | Not applicable      | 
| outputproperty | Name of an Ant property in which to store the output.  | No | Not applicable |

**Example**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

This command is based on the [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST service.

<br/>
#### The `set-user-config` command
The `set-user-config` command, outside of `<adapter>` and `<app-version>` elements, specifies the user configuration of a runtime. It has the following attributes for setting the entire configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime        | Name of the runtime. | Yes | Not available | 
| file	         | Name of the JSON or XML file that contains the new configuration. | Yes | Not available | 

The `set-user-config` command has the following attributes for setting a single property in the configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	     | Name of the runtime. | Yes | Not available | 
| property	     | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. | Yes | Not available | 
| value	         | The value of the property. | Yes | Not available |

**Example**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

This command is based on the [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST service.

<br/>
#### The `show-confidential-clients` command
The `show-confidential-clients` command shows the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients). This command has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime        | Name of the runtime. | Yes | Not available | 
| format         | Specifies the output format. Either json or xml. | Yes | Not available | 
| output         | Name of the file in which to store the output. | No | Not applicable | 
| outputproperty | Name of an Ant property in which to store the output. | No | Not applicable | 

**Example**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

This command is based on the [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc) REST service.

<br/>
#### The `set-confidential-clients` command
The `set-confidential-clients` command specifies the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients). This command has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime        | Name of the runtime. | Yes | Not available | 
| file	         | Name of the JSON or XML file that contains the new configuration. | Yes | Not available | 

**Example**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

This command is based on the [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST service.

<br/>
#### The `set-confidential-clients-rule` command
The `set-confidential-clients-rule` command specifies a rule in the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients). This command has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime        | Name of the runtime. | Yes | Not available | 
| id             | The identifier of the rule. | Yes | Not available | 
| displayName    | The display name of the rule. | Yes | Not available | 
| secret         | The secret of the rule. | Yes | Not available | 
| allowedScope   | The scope of the rule. A space-separated list of tokens. | Yes | Not available | 

**Example**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

This command is based on the [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST service.

### Commands for adapters
When you call the **mfpadm** Ant task, you can include various commands for adapters.

#### The `list-adapters` command
The `list-adapters` command returns a list of the adapters deployed for a given runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime        | Name of the runtime. | 	Yes | Not available | 
| output	     | Name of output file. | 	No  | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<list-adapters runtime="mfp"/>
```

This command is based on the [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST service.

<br/>
#### The `deploy-adapter` command
The `deploy-adapter` command deploys an adapter in a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	     | Name of the runtime. | Yes | Not available | 
| file           | Binary adapter file (.adapter). | Yes | Not available |

**Example**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

This command is based on the [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST service.

<br/>
#### The `show-adapter` command
The `show-adapter` command shows details about an adapter. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name | Name of an adapter. | Yes | Not available | 
| output | Name of output file. | No | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

This command is based on the [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST service.

<br/>
#### The `delete-adapter` command
The `delete-adapter` command removes (undeploys) an adapter from a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name    | Name of an adapter. | Yes | Not available | 

**Example**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

This command is based on the [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST service.

<br/>
#### The `adapter` command group
The `adapter` command group has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name | Name of an adapter. | Yes | Not available | 

The `adapter` command supports the following elements.

| Element          | Description |	Count    | 
|------------------|-------------|-------------|
| get-binary	   | Gets the binary data. | 0..∞ | 
| show-user-config | Shows the user configuration. | 0..∞ | 
| set-user-config  | Specifies the user configuration. | 0..∞ | 

<br/>
#### The `get-binary` command
The `get-binary` command inside an `<adapter>` element returns the binary adapter file. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| tofile	     | Name of the output file. | Yes | Not available | 

**Example**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

This command is based on the [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST service.

<br/>
#### The `show-user-config` command
The `show-user-config` command, inside an `<adapter>` element, shows the user configuration of the adapter. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| format	     | Specifies the output format. Either json or xml. | Yes | Not available       | 
| output	     | Name of the file in which to store the output.   | No  | Not applicable      | 
| outputproperty | Name of an Ant property in which to store the output.  | No | Not applicable |

**Example**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

This command is based on the [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST service.

<br/>
#### The `set-user-config` command
The `set-user-config` command, inside an `<adapter>` element, specifies the user configuration of the adapter. It has the following attributes for setting the entire configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| file	Name of the JSON or XML file that contains the new configuration. | Yes | Not available | 

The command has the following attributes for setting a single property in the configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| property | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. | Yes | Not available | 
| value | The value of the property. | Yes | Not available | 

**Examples**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

This command is based on the [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST service.

### Commands for apps
When you call the **mfpadm** Ant task, you can include various commands for apps.

#### The `list-apps` command
The `list-apps` command returns a list of the apps that are deployed in a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes	Not available | 
| output | Name of the output file. | No	Not applicable | 
| outputproperty | Name of the Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<list-apps runtime="mfp"/>
```

This command is based on the [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST service.

<br/>
#### The `deploy-app` command
The `deploy-app` command deploys an app version in a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| file | The application descriptor, a JSON file. | Yes | Not available | 

**Example**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

This command is based on the [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST service.

<br/>
#### The `show-app` command
The `show-app` command returns a list of the app versions that are deployed in a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name | Name of an app. | Yes | Not available | 
| output | Name of output file. | No | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

This command is based on the [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST service.

<br/>
#### The `delete-app` command
The `delete-app` command removes (undeploys) an app, with all its app versions, for all environments for which it was deployed, from a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name | Name of an app. | Yes | Not available | 

**Example**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

This command is based on the [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST service.

<br/>
#### The `show-app-version` command
The `show-app-version` command shows details about an app version in a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	Name of the runtime. | Yes | Not available | 
| name	Name of the app. | Yes | Not available | 
| environment	Mobile platform. | Yes | Not available | 
| version	Version number of the app. | Yes | Not available | 

**Example**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

This command is based on the [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST service.

<br/>
#### The `delete-app-version` command
The `delete-app-version` command removes (undeploys) an app version from a runtime. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	Name of the runtime. | Yes | Not available | 
| name	Name of the app. | Yes | Not available | 
| environment	Mobile platform. | Yes | Not available | 
| version	Version number of the app. | Yes | Not available | 

**Example**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

This command is based on the [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST service.

<br/>
#### The `app` command group
The `app` command group has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime	Name of the runtime. | Yes | Not available | 
| name	Name of the app. | Yes | Not available | 

The app command group supports the following elements.

| Element | Description | Count | 
|---------|-------------|-------|
| show-license-config | Shows the token license configuration. | 0.. | 
| set-license-config | Specifies the token license configuration. | 0.. | 
| delete-license-config | Removes the token license configuration. | 0.. | 

<br/>
#### The `show-license-config` command
The `show-license-config` command shows the token license configuration of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output         |	Name of a file in which to store the output. | Yes | Not available |
| outputproperty | 	Name of an Ant property in which to store the output. | Yes	| Not available |

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

This command is based on the [Application license configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST service.

<br/>
#### The `set-license-config` command
The `set-license-config` command specifies the token license configuration of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| appType | Type of app: B2C or B2E | Yes | Not available | 
| licenseType | Type of application: APPLICATION or ADDITIONAL_BRAND_DEPLOYMENT or NON_PRODUCTION. | Yes | Not available | 

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

This command is based on the [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST service.

<br/>
#### The `delete-license-config` command
The `delete-license-config` command resets the token license configuration of an app, that is, reverts it to the initial state.

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

This command is based on the [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST service.

<br/>
#### The `app-version` command group
The `app-version` command group has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| name | Name of an app. | Yes | Not available | 
| environment | Mobile platform. | Yes | Not available | 
| version | Version of the app. | Yes | Not available | 

The `app-version` command group supports the following elements:

| Element | Description | Count | 
|---------|-------------|-------|
| get-descriptor | Gets the descriptor. | 0.. | 
| get-web-resources | Gets the web resources. | 0.. | 
| set-web-resources | Specifies the web resources. | 0.. | 
| get-authenticity-data | Gets the authenticity data. | 0.. | 
| set-authenticity-data | Specifies the authenticity data. | 0.. | 
| delete-authenticity-data | Deletes the authenticity data. | 0.. | 
| show-user-config | Shows the user configuration. | 0.. | 
| set-user-config | Specifies the user configuration. | 0.. | 

<br/>
#### The `get-descriptor` command
The `get-descriptor` command, inside an `<app-version>` element, returns the application descriptor of a version of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output | Name of a file in which to store the output. | No | Not applicable | 
| outputproperty | Name of an Ant property in which to store the output. | No | Not applicable | 

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

This command is based on the [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) service.

<br/>
#### The `get-web-resources` command
The `get-web-resources` command, inside an `<app-version>` element, returns the web resources of a version of an app, as a .zip file. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| tofile | 	Name of the output file. | Yes |Not available | 

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

This command is based on the [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST service.

<br/>
#### The `set-web-resources` command
The `set-web-resources` command, inside an `<app-version>` element, specifies the web resources for a version of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| file | Name of the input file (must be a .zip file). | Yes |Not available |

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

This command is based on the [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST service.

<br/>
#### The `get-authenticity-data` command
The `get-authenticity-data` command, inside an `<app-version>` element, returns the authenticity data of a version of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output | 	Name of a file in which to store the output. | No | Not applicable | 
| outputproperty | Name of an Ant property in which to store the output. | No | Not applicable | 

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

This command is based on the [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST service.

<br/>
#### The `set-authenticity-data` command
The `set-authenticity-data` command, inside an `<app-version>` element, specifies the authenticity data for a version of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| file | Name of the input file:<ul><li>Either a authenticity_data file,</li><li>or a device file (.ipa, .apk, or .appx file), from which the authenticity data is extracted.</li></ul> |  Yes | Not available | 

**Examples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

This command is based on the [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST service.

<br/>
#### The `delete-authenticity-data` command
The `delete-authenticity-data` command, inside an `<app-version>` element, deletes the authenticity data of a version of an app. It has no attributes.

**Example**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

This command is based on the [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST service.

<br/>
#### The `show-user-config` command
The `show-user-config` command, inside an `<app-version>` element, shows the user configuration of a version of an app. It has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| format | Specifies the output format. Either json or xml. | Yes | Not available | 
| output | Name of the output file.	No	Not applicable | 
| outputproperty | Name of the Ant property for the output. | No | Not applicable | 

**Examples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

This command is based on the [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST service.

<br/>
#### The `set-user-config` command
The `set-user-config` command, inside an `<app-version>` element, specifies the user configuration for a version of an app. It has the following attributes for setting the entire configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| file | Name of the JSON or XML file that contains the new configuration. | Yes | Not available | 

The `set-user-config` command has the following attributes for setting a single property in the configuration.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| property | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. | Yes | Not available | 
| value	| The value of the property. | Yes | Not available | 

**Examples**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### Commands for devices
When you call the **mfpadm** Ant task, you can include various commands for devices.

#### The `list-devices` command
The `list-devices` command returns the list of devices that have contacted the apps of a runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| query	 | A friendly name or user identifier to search for. This parameter specifies a string to search for. All devices that have a friendly name or user identifier that contains this | string (with case-insensitive matching) are returned. | No | Not applicable | 
| output | 	Name of output file. | No | Not applicable | 
| outputproperty | 	Name of Ant property for the output. | No | Not applicable | 

**Examples**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

This command is based on the [Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) REST service.

<br/>
#### The `remove-device` command
The `remove-device` command clears the record about a device that has contacted the apps of a runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| id | Unique device identifier. | Yes | Not available | 

**Example**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

This command is based on the [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST service.

<br/>
#### The `device` command group
The `device` command group has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| id | Unique device identifier. | Yes | Not available | 

The `device` command supports the following elements.

| Element        | Description |       Count |
|----------------|-------------|-------------|
| set-status | Changes the status. | 0..∞ | 
| set-appstatus | Changes the status for an app. | 0..∞ | 

<br/>
#### The `set-status` command
The `set-status` command changes the status of a device, in the scope of a runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| status | New status. | Yes | Not available | 

The status can have one of the following values:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Example**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

This command is based on the [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST service.

<br/>
#### The `set-appstatus` command
The `set-appstatus` command changes the status of a device, regarding an app in a runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| app	| Name of an app. | Yes | Not available | 
| status | 	New status. | Yes | Not available | 

The status can have one of the following values:

* ENABLED
* DISABLED

**Example**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

This command is based on the [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST service.

### Commands for troubleshooting
You can use Ant task commands to investigate problems with MobileFirst Server web applications.

#### The `show-info` command
The `show-info` command shows basic information about the MobileFirst administration services that can be returned without accessing any runtime nor database. Use this command to test whether the MobileFirst administration services are running at all. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output | 	Name of output file. | No | Not applicable | 
| outputproperty | 	Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<show-info/>
```

<br/>
#### The `show-versions` command
The `show-versions` command displays the MobileFirst versions of various components:

* **mfpadmVersion**: the exact MobileFirst Server version number from which the **mfp-ant-deployer.jar **file is taken.
* **productVersion**: the exact MobileFirst Server version number from which the **mfp-admin-service.war** file is taken.
* **mfpAdminVersion**: the exact build version number of **mfp-admin-service.war** alone.

The command has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output | 	Name of output file. | No | Not applicable | 
| outputproperty | 	Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<show-versions/>
```

<br/>
#### The `show-diagnostics` command
The `show-diagnostics` command shows the status of various components that are necessary for the correct operation of the MobileFirst administration service, such as the availability of the database and of auxiliary services. This command has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| output | 	Name of output file. | No | Not applicable | 
| outputproperty | 	Name of Ant property for the output. | No | Not applicable | 

**Example**  

```xml
<show-diagnostics/>
```

<br/>
#### The `unlock` command
The `unlock` command releases the general-purpose lock. Some destructive operations take this lock in order to prevent concurrent modification of the same configuration data. In rare cases, if such an operation is interrupted, the lock might remain in locked state, making further destructive operations impossible. Use the unlock command to release the lock in such situations. The command has no attributes.

**Example**  

```xml
<unlock/>
```

<br/>
#### The `list-runtimes` command
The `list-runtimes` command returns a list of the deployed runtimes. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| output | Name of output file. | No | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Examples**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

This command is based on the [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST service.

<br/>
#### The `show-runtime` command
The `show-runtime` command shows information about a given deployed runtime. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| output | Name of output file. | No | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Example**

```xml
<show-runtime runtime="mfp"/>
```

This command is based on the [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST service.

<br/>
#### The `delete-runtime` command
The `delete-runtime` command deletes the runtime, including its apps and adapters, from the database. You can delete a runtime only when its web application is stopped. The command has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime |  Name of the runtime. | Yes | Not available |
| condition | Condition when to delete it: empty or always. **Attention:** The always option is dangerous. | No | Not applicable |

**Example**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

This command is based on the [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST service.

<br/>
#### The `list-farm-members` command
The `list-farm-members` command returns a list of the farm member servers on which a given runtime is deployed. It has the following attributes:

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| output | Name of output file. | No | Not applicable | 
| outputproperty | Name of Ant property for the output. | No | Not applicable | 

**Example**

```xml
<list-farm-members runtime="mfp"/>
```

This command is based on the [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST service.

<br/>
#### The `remove-farm-member` command
The `remove-farm-member` command removes a server from the list of farm members on which a given runtime is deployed. Use this command when the server has become unavailable or disconnected. The command has the following attributes.

| Attribute      | Description |	Required | Default |
|----------------|-------------|-------------|---------|
| runtime | Name of the runtime. | Yes | Not available | 
| serverId | Identifier of the server.	 | Yes | Not applicable | 
| force | Force removal of a farm member, even if it is available and connected. | No | false | 

**Example**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

This command is based on the [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST service.
