---
layout: tutorial
title: Administrating applications through Terminal
breadcrumb_title: Administrating using terminal
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
You can administer MobileFirst applications through the **mfpadm** program.

#### Jump to

* [Comparison with other facilities](#comparison-with-other-facilities)
* [Prerequisites](#prerequisites)

## Comparison with other facilities
You can run administration operations with IBM MobileFirst Foundation in the following ways:

* The MobileFirst Operations Console, which is interactive.
* The mfpadm Ant task.
* The **mfpadm** program.
* The MobileFirst administration REST services.

The **mfpadm** Ant task, mfpadm program, and REST services are useful for automated or unattended execution of operations, such as the following use cases:

* Eliminating operator errors in repetitive operations, or
* Operating outside the operator's normal working hours, or
* Configuring a production server with the same settings as a test or preproduction server.

The **mfpadm** program and the mfpadm Ant task are simpler to use and have better error reporting than the REST services. The advantage of the mfpadm program over the mfpadm Ant task is that it is easier to integrate when integration with operating system commands is already available. Moreover, it is more suitable to interactive use.

## Prerequisites
The **mfpadm** tool is installed with the MobileFirst Server installer. In the rest of this page, **product\_install\_dir** indicates the installation directory of the MobileFirst Server installer.

The **mfpadm** command is provided in the **product\_install\_dir/shortcuts/** directory as a set of scripts:

* mfpadm for UNIX / Linux
* mfpadm.bat for Windows

These scripts are ready to run, which means that they do not require specific environment variables. If the environment variable **JAVA_HOME** is set, the scripts accept it.  
To use the **mfpadm** program, either put the **product\_install\_dir/shortcuts/** directory into your PATH environment variable, or reference its absolute file name in each call.

For more information about running the MobileFirst Server installer, see [Running IBM Installation Manager](../../installation-configuration/production/installation-manager/).

#### Jump to

* [Calling the **mfpadm** program](#calling-the-mfpadm-program)
* [Commands for general configuration](#commands-for-general-configuration)
* [Commands for adapters](#commands-for-adapters)
* [Commands for apps](#commands-for-apps)
* [Commands for devices](#commands-for-devices)
* [Commands for troubleshooting](#commands-for-troubleshooting)


### Calling the **mfpadm** program
You can use the **mfpadm** program to administer MobileFirst applications.

#### Syntax
Call the mfpadm program as follows:

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] some command
```

The **mfpadm** program has the following options:

| Option	| Type | Description | Required | Default | 
|-----------|------|-------------|----------|---------|
| --url | 	 | URL | Base URL of the MobileFirst web application for administration services | Yes | | 
| --secure	 | Boolean | Whether to avoid operations with security risks | No | true | 
| --user	 | name | User name for accessing the MobileFirst admin services | Yes |  | 	 
| --passwordfile | file | File containing the password for the user | No | 
| --timeout	     | Number  | Timeout for the entire REST service access, in seconds | No | 	 
| --connect-timeout | Number | Timeout for establishing a network connection, in seconds | No |
| --socket-timeout  | Number | Timeout for detecting the loss of a network connection, in seconds | No | 
| --connection-request-timeout | Number	Timeout for obtaining an entry from a connection request pool, in seconds | No |
| --lock-timeout | Number | Timeout for acquiring a lock, in seconds | No | 2 | 
| --verbose	     | Detailed output | No	| |  

**url**  
The URL preferably uses the HTTPS protocol. For example, if you use default ports and context roots, use this URL:

* For WebSphere  Application Server: https://server:9443/mfpadmin
* For Tomcat: https://server:8443/mfpadmin

**secure**  
The `--secure` option is set to true by default. Setting it to `--secure=false` might have the following effects:

* The user and password might be transmitted in an unsecured way (possibly even through unencrypted HTTP).
* The server's SSL certificates are accepted even if self-signed or if they were created for a different host name from the server's host name.

**password**  
Specify the password in a separate file that you pass in the `--passwordfile` option. In interactive mode (see Interactive mode), you can alternatively specify the password interactively. The password is sensitive information and therefore needs to be protected. You must prevent other users on the same computer from knowing these passwords. To secure the password, before you enter the password into a file, you must remove the read permissions of the file for users other than yourself. For example, you can use one of the following commands:

* On UNIX: `chmod 600 adminpassword.txt`
* On Windows: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

For this reason, do not pass the password to a process through a command-line argument. On many operating systems, other users can inspect the command-line arguments of your processes.

The mfpadm calls contains a command. The following commands are supported.

| Command                           | Description | 
|-----------------------------------|-------------|
| show info	| Shows user and configuration information. | 
| show global-config | Shows global configuration information. | 
| show diagnostics | Shows diagnostics information. | 
| show versions	| Shows version information. | 
| unlock | Releases the general-purpose lock. | 
| list runtimes [--in-database] | Lists the runtimes. | 
| show runtime [runtime-name] | Shows information about a runtime. | 
| delete runtime [runtime-name] condition | Deletes a runtime. | 
| show user-config [runtime-name] | Shows the user configuration of a runtime. | 
| set user-config [runtime-name] file | Specifies the user configuration of a runtime. | 
| set user-config [runtime-name] property = value | Specifies a property in the user configuration of a runtime. | 
| show confidential-clients [runtime-name] | Shows the configuration of the confidential clients of a runtime. | 
| set confidential-clients [runtime-name] file | Specifies the configuration of the confidential clients of a runtime. | 
| set confidential-clients-rule [runtime-name] id display-name secret allowed-scope | Specifies a rule for the configuration of the confidential clients of a runtime. | 
| list adapters [runtime-name] | Lists the adapters. | 
| deploy adapter [runtime-name] property = value | Deploys an adapter.| 
| show adapter [runtime-name] adapter-name | Shows information about an adapter.| 
| delete adapter [runtime-name] adapter-name | Deletes an adapter.| 
| adapter [runtime-name] adapter-name get binary [> tofile]	| Get the binary data of an adapter.| 
| list apps [runtime-name] | Lists the apps.| 
| deploy app [runtime-name] file | Deploys an app.| 
| show app [runtime-name] app-name | Shows information about an app.| 
| delete app [runtime-name] app-name | Deletes an app. | 
| show app version [runtime-name] app-name environment version | Shows information about an app version. |
| delete app version [runtime-name] app-name environment version | Deletes a version of an app. |
| app [runtime-name] app-name show license-config | Shows the token license configuration of an app. |
| app [runtime-name] app-name set license-config app-type license-type | Specifies the token license configuration for an app. |
| app [runtime-name] app-name delete license-config | Removes the token license configuration for an app. | 
| app version [runtime-name] app-name environment version get descriptor [> tofile]	| Gets the descriptor of an app version. | 
| app version [runtime-name] app-name environment version get web-resources [> tofile] | Gets the web resources of an app version. | 
| app version [runtime-name] app-name environment version set web-resources file | Specifies the web resources of an app version. | 
| app version [runtime-name] app-name environment version get authenticity-data [> tofile] | Gets the authenticity data of an app version. | 
| app version [runtime-name] app-name environment version set authenticity-data [file] | Specifies the authenticity data of an app version. | 
| app version [runtime-name] app-name environment version delete authenticity-data | Deletes the authenticity data of an app version. | 
| app version [runtime-name] app-name environment version show user-config | Shows the user configuration of an app version. | 
| app version [runtime-name] app-name environment version set user-config file | Specifies the user configuration of an app version. | 
| app version [runtime-name] app-name environment version set user-config property = value | Specifies a property in the user configuration of an app version. |
| list devices [runtime-name] [--query query] | Lists the devices. |
| remove device [runtime-name] id | Removes a device. |
| device [runtime-name] id set status new-status | Changes the status of a device. |
| device [runtime-name] id set appstatus app-name new-status | Changes the status of a device for an app. |
| list farm-members [runtime-name] | Lists the servers that are members of the server farm. |
| remove farm-member [runtime-name] server-id | Removes a server from the list of farm members. |

#### Interactive mode
Alternatively, you can also call **mfpadm** without any command in the command line. You can then enter commands interactively, one per line.
The `exit` command, or end-of-file on standard input (**Ctrl-D** on UNIX terminals) terminates mfpadm.

`Help` commands are also available in this mode. For example:

* help
* help show versions
* help device
* help device set status

#### Command history in interactive mode
On some operating systems, the interactive mfpadm command remembers the command history. With the command history, you can select a previous command, using the arrow-up and arrow-down keys, edit it, and execute it.

**On Linux**  
The command history is enabled in terminal emulator windows if the rlwrap package is installed and found in PATH. To install the rlwrap package:

* On Red Hat Linux: `sudo yum install rlwrap`
* On SUSE Linux: `sudo zypper install rlwrap`
* On Ubuntu: `sudo apt-get install rlwrap`

**On OS X**  
The command history is enabled in the Terminal program if the rlwrap package is installed and found in PATH. To install the rlwrap package:

1. Install MacPorts by using the installer from [www.macports.org](http://www.macports.org).
2. Run the command: `sudo /opt/local/bin/port install rlwrap`
3. Then, to make the rlwrap program available in PATH, use this command in a Bourne-compatible shell: `PATH=/opt/local/bin:$PATH`

**On Windows**  
The command history is enabled in cmd.exe console windows.

In environments where rlwrap does not work or is not required, you can disable its use through the option `--no-readline`.

#### The configuration file
You can also store the options in a configuration file, instead of passing them on the command line at every call. When a configuration file is present and the option –configfile=file is specified, you can omit the following options:

* --url=URL
* --secure=boolean
* --user=name
* --passwordfile=file
* --timeout=seconds
* --connect-timeout=seconds
* --socket-timeout=seconds
* --connection-request-timeout=seconds
* --lock-timeout=seconds
* runtime-name

Use these commands to store these values in the configuration file.

| Command | Comment |
|---------|---------| 
| mfpadm [--configfile=file] config url URL | | 
| mfpadm [--configfile=file] config secure boolean | | 
| mfpadm [--configfile=file] config user name | | 
| mfpadm [--configfile=file] config password | Prompts for the password. | 
| mfpadm [--configfile=file] config timeout seconds | | 
| mfpadm [--configfile=file] config connect-timeout seconds | | 
| mfpadm [--configfile=file] config socket-timeout seconds | | 
| mfpadm [--configfile=file] config connection-request-timeout seconds | | 
| mfpadm [--configfile=file] config lock-timeout seconds | | 
| mfpadm [--configfile=file] config runtime runtime-name | | 

Use this command to list the values that are stored in the configuration file: mfpadm `[--configfile=file]` config

The configuration file is a text file, in the encoding of the current locale, in Java™ .properties syntax. Default configuration file:

* UNIX: `$HOME/.mfpadm.config`
* Windows: `My Documents\IBM MobileFirst Platform Server Data\mfpadm.config`

**Note:** When you do not specify a `--configfile` option, the default configuration file is used only in interactive mode and in config commands. For noninteractive use of the other commands, you must explicitly designate the configuration file if you want to use one.

> **Important:** The password is stored in an obfuscated format that hides the password from an occasional glimpse. However, this obfuscation provides no security.

#### Generic options
There are also the usual generic options:

| Option	| Description | 
|-----------|-------------|
| --help	| Shows some usage help | 
| --version	| Shows the version | 

#### XML format
The commands that receive an XML response from the server verify that this response complies with the specific schema. You can disable this check by specifying `--xmlvalidation=none`.

#### Output character set
Normal output that is produced by the mfpadm program is encoded in the encoding format of the current locale. On Windows, this encoding format is "ANSI code page". The effects are as follows:

* Characters outside of this character set are converted to question marks when they are output.
* When the output goes to a Windows command prompt window (cmd.exe), non-ASCII characters are incorrectly displayed because such windows assume characters to be encoded in "OEM code page".

To work around this limitation:

* On operating systems other than Windows, use a locale whose encoding is UTF-8. This format is the default locale on Red Hat Linux and OS X. Many other operating systems have a `en_US.UTF-8` locale.
* Or use the mfpadm Ant task, with attribute `output="some file name"` to redirect the output of a command to a file.

### Commands for general configuration
When you call the **mfpadm** program, you can include various commands that access the global configuration of the IBM MobileFirst Server or of a runtime.

#### The `show global-config` command
The `show global-config` command shows the global configuration.

Syntax: `show global-config`

It takes the following options:

| Argument | Description |
|----------|-------------|
| --xml    | Produces XML output instead of tabular output. | 

**Example**  

```bash
show global-config
```

This command is based on the [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST service.

<br/>
#### The `show user-config` command
The `show user-config` command shows the user configuration of a runtime.

Syntax: `show user-config [--xml] [runtime-name]`

It takes the following arguments:

| Argument | Description |
|----------|-------------|
| runtime-name | Name of the runtime. |

The `show user-config` command takes the following options after the verb.

| Argument | Description | Required | Default | 
|----------|-------------|----------|---------|
| --xml | Produces output in XML format instead of JSON format. | No | Standard output | 

**Example**  

```bash
show user-config mfp
```

This command is based on the [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST service.

<br/>
#### The `set user-config` command
The `set user-config` command specifies the user configuration of a runtime or a single property among this configuration.

Syntax for the entire configuration: `set user-config [runtime-name] file`

It takes the following arguments:

| Attribute | Description | 
|-----------|-------------|
| runtime-name | Name of the runtime. | 
| file | Name of the JSON or XML file that contains the new configuration. | 

Syntax for a single property: `set user-config [runtime-name] property = value`

The `set user-config` command takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| property | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. |
| value | The value of the property. | 

**Examples**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

This command is based on the [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST service.

<br/>
#### The `show confidential-clients` command
The `show confidential-clients` command shows the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients).

Syntax: `show confidential-clients [--xml] [runtime-name]`

It takes the following arguments:

| Attribute | Description |
|-----------|-------------|
| runtime-name | Name of the runtime. |

The `show confidential-clients` command takes the following options after the verb.

| Argument | Description | Required | Default |
|----------|-------------|----------|---------|
| --xml | Produces output in XML format instead of JSON format. | No | Standard output |

**Example**

```bash
show confidential-clients --xml mfp
```

This command is based on the [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-) REST service.

<br/>
#### The `set confidential-clients` command
The `set confidential-clients` command specifies the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients).

Syntax: `set confidential-clients [runtime-name] file`

Its takes the following arguments:

| Attribute | Description | 
|-----------|-------------|
| runtime-name | Name of the runtime. | 
| file	Name of the JSON or XML file that contains the new configuration. | 

**Example**

```bash
set confidential-clients mfp clients.xml
```

This command is based on the [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST service.

<br/>
#### The `set confidential-clients-rule` command
The `set confidential-clients-rule` command specifies a rule in the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../authentication-and-security/confidential-clients).

Syntax: `set confidential-clients-rule [runtime-name] id displayName secret allowedScope`

It takes the following arguments:

| Attribute	| Description |
|-----------|-------------|
| runtime | Name of the runtime. | 
| id | The identifier of the rule. | 
| displayName | The display name of the rule. | 
| secret | The secret of the rule. | 
| allowedScope | The scope of the rule. A space-separated list of tokens. Use double-quotes to pass a list of two or more tokens. | 

**Example**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

This command is based on the [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST service.

### Commands for adapters
When you invoke the **mfpadm** program, you can include various commands for adapters.

### The `list adapters` command
The `list adapters` command returns a list of the adapters that are deployed for a runtime.

Syntax: `list adapters [runtime-name]`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. |

The `list adapters` command takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produce XML output instead of tabular output. | 

**Example**  

```xml
list adapters mfp
```

This command is based on the [Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST service.

<br/>
#### The `deploy adapter` command
The `deploy adapter` command deploys an adapter in a runtime.

Syntax: `deploy adapter [runtime-name] file`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. |
| file | Binary adapter file (.adapter) |

**Example**

```bash
deploy adapter mfp MyAdapter.adapter
```

This command is based on the [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST service.

<br/>
#### The `show adapter` command
The `show adapter` command shows details about an adapter.

Syntax: `show adapter [runtime-name] adapter-name`

It takes the following arguments.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. |
| adapter-name | Name of an adapter |

The `show adapter` command takes the following options after the object.

| Option | Description |
|--------|-------------|
| --xml | Produce XML output instead of tabular output. |

**Example**

```bash
show adapter mfp MyAdapter
```

This command is based on the [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST service.

<br/>
#### The `delete adapter` command
The `delete adapter` command removes (undeploys) an adapter from a runtime.

Syntax: `delete adapter [runtime-name] adapter-name`

It takes the following arguments:

| Argument | Description |
|----------|-------------|
| runtime-name | Name of the runtime. | 
| adapter-name | Name of an adapter. | 

**Example**

```bash
delete adapter mfp MyAdapter
```

This command is based on the [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-) REST service.

<br/>
#### The `adapter` command prefix
The `adapter` command prefix takes the following arguments before the verb.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| adapter-name | Name of an adapter. | 

<br/>
#### The `adapter get binary` command
The `adapter get binary` command returns the binary adapter file.

Syntax: `adapter [runtime-name] adapter-name get binary [> tofile]`

It takes the following options after the verb.

| Option | Description | Required | Default | 
|--------|-------------|----------|---------|
| > tofile | Name of the output file. | No | Standard output |

**Example**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

This command is based on the [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST service.

<br/>
#### The `adapter show user-config` command
The `adapter show user-config` command shows the user configuration of the adapter.

Syntax: `adapter [runtime-name] adapter-name show user-config [--xml]`

It takes the following options after the verb.

| Option | Description |
|--------|-------------|
| --xml | Produces output in XML format instead of JSON format. | 

**Example**

```bash
adapter mfp MyAdapter show user-config
```

This command is based on the [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST service.

<br/>
#### The `adapter set user-config` command
The `adapter set user-config` command specifies the user configuration of the adapter or a single property within this configuration.

Syntax for the entire configuration: `adapter [runtime-name] adapter-name set user-config file`

It takes the following arguments after the verb.

| Option | Description | 
|--------|-------------|
| file | Name of the JSON or XML file that contains the new configuration. |

Syntax for a single property: `adapter [runtime-name] adapter-name set user-config property = value`

It takes the following arguments after the verb.

| Option | Description |
|--------|-------------|
| property | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. | 
| value | The value of the property. | 

**Examples**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

This command is based on the [Adapter configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc) REST service.

### Commands for apps
When you invoke the **mfpadm** program, you can include various commands for apps.

#### The `list apps` command
The `list apps` command returns a list of the apps that are deployed in a runtime.

Syntax: `list apps [runtime-name]`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. |

The `list apps` command takes the following options after the object.

| Option | Description |
|--------|-------------|
| --xml | Produce XML output instead of tabular output. |

**Example**

```bash
list apps mfp
```

This command is based on the [Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST service.

#### The `deploy app` command
The `deploy app` command deploys an app version in a runtime.

Syntax: `deploy app [runtime-name] file`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. |
| file | The application descriptor, a JSON file. |

**Example**

```bash
deploy app mfp MyApp/application-descriptor.json
```

This command is based on the [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST service.

#### The `show app` command
The `show app` command shows details about an app in a runtime, in particular its environments and versions.

Syntax: `show app [runtime-name] app-name`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app. | 

The `show app` command takes the following options after the object.

| Option | Description |
|--------|-------------|
| --xml	 | Produce XML output instead of tabular output. |

**Example**

```bash
show app mfp MyApp
```

This command is based on the [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST service.

#### The `delete app` command
The `delete app` command removes (undeploys) an app, from all environments and all versions, from a runtime.

Syntax: `delete app [runtime-name] app-name`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app | 

**Example**

```bash
delete app mfp MyApp
```

This command is based on the [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST service.

#### The `show app version` command
The `show app version` command show details about an app version in a runtime.

Syntax: `show app version [runtime-name] app-name environment version`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app. | 
| environment | Mobile platform. | 
| version | Version of the app. | 

The `show app version` command takes the following options after the object.

| Argument | Description | 
| ---------|-------------|
| -- xml | Produces XML output instead of tabular output. | 

**Example**

```bash
show app version mfp MyApp iPhone 1.1
```

This command is based on the [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST service.

#### The `delete app version` command
The `delete app version` command removes (undeploys) an app version from a runtime.

Syntax: `delete app version [runtime-name] app-name environment version`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app. | 
| environment | Mobile platform. | 
| version | Version of the app. | 

**Example**

```bash
delete app version mfp MyApp iPhone 1.1
```

This command is based on the [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST service.

#### The `app` command prefix
The `app` command prefix takes the following arguments before the verb.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app. | 

#### The `app show license-config` command
The `app show license-config` command shows the token license configuration of an app.

Syntax: `app [runtime-name] app-name show license-config`

It takes the following options after the object:

| Argument | Description | 
|----------|-------------|
| --xml | Produces XML output instead of tabular output. | 

**Example**

```bash
app mfp MyApp show license-config
```

This command is based on the [Application license configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST service.

#### The `app set license-config` command
The `app set license-config` command specifies the token license configuration of an app.

Syntax: `app [runtime-name] app-name set license-config app-type license-type`

It takes the following arguments after the verb.

| Argument | Description | 
|----------|-------------|
| appType | Type of app: B2C or B2E. | 
| licenseType | Type of application: APPLICATION or ADDITIONAL_BRAND_DEPLOYMENT or NON_PRODUCTION. | 

**Example**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

This command is based on the [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST service.

#### The `app delete license-config` command
The `app delete license-config` command resets the token license configuration of an app, that is, reverts it to the initial state.

Syntax: `app [runtime-name] app-name delete license-config`

**Example**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

This command is based on the [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST service.

#### The `app version` command prefix
The `app version` command prefix takes the following arguments before the verb.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| app-name | Name of an app. | 
| environment | Mobile platform | 
| version | Version of the app | 

#### The `app version get descriptor` command
The `app version get descriptor` command returns the application descriptor of a version of an app.

Syntax: `app version [runtime-name] app-name environment version get descriptor [> tofile]`

It takes the following arguments after the verb.

| Argument | Description | Required | Default | 
|----------|-------------|----------|---------|
| > tofile | Name of the output file. | No | Standard output | 

**Example**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

This command is based on the [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST service.

#### The `app version get web-resources` command
The `app version get web-resources` command returns the web resources of a version of an app, as a .zip file.

Syntax: `app version [runtime-name] app-name environment version get web-resources [> tofile]`

It takes the following arguments after the verb.

| Argument | Description | Required | Default | 
|----------|-------------|----------|---------|
| > tofile | Name of the output file. | No | Standard output | 

**Example**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

This command is based on the [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST service.

#### The `app version set web-resources` command
The `app version set web-resources` command specifies the web resources for a version of an app.

Syntax: `app version [runtime-name] app-name environment version set web-resources file`

It takes the following arguments after the verb.

| Argument | Description | 
| file | Name of the input file (must be a .zip file). | 

**Example**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

This command is based on the [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST service.

#### The `app version get authenticity-data` command
The `app version get authenticity-data` command returns the authenticity data of a version of an app.

Syntax: `app version [runtime-name] app-name environment version get authenticity-data [> tofile]`

It takes the following arguments after the verb.

| Argument | Description | Required | Default | 
| > tofile | Name of the output file. | No | Standard output | 

**Example**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

This command is based on the [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST service.

#### The `app version set authenticity-data` command
The `app version set authenticity-data` command specifies the authenticity data for a version of an app.

Syntax: `app version [runtime-name] app-name environment version set authenticity-data file`

It takes the following arguments after the verb.

| Argument | Description | 
|----------|-------------|
| file | Name of the input file:<ul><li>Either a .authenticity_data file,</li><li>Or a device file (.ipa or .apk or .appx), from which the authenticity data is extracted.</li></ul>| 

**Examples**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

This command is based on the [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST service.

#### The `app version delete authenticity-data` command
The `app version delete authenticity-data` command deletes the authenticity data for a version of an app.

Syntax: `app version [runtime-name] app-name environment version delete authenticity-data`

**Example**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

This command is based on the [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST service.

#### The `app version show user-config` command
The `app version show user-config` command shows the user configuration of a version of an app.

Syntax: `app version [runtime-name] app-name environment version show user-config [--xml]`

It takes the following options after the verb.

| Argument | Description | Required | Default | 
|----------|-------------|----------|---------|
| [--xml] | Produce output in XML format instead of JSON format. | No | Standard output | 

**Example**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

This command is based on the [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST service.

### The `app version set user-config` command
The `app version set user-config` command specifies the user configuration for a version of an app or a single property among this configuration.

Syntax for the entire configuration: `app version [runtime-name] app-name environment version set user-config file`

It takes the following arguments after the verb.

| Argument | Description | 
|----------|-------------|
| file | Name of the JSON or XML file that contains the new configuration. | 

Syntax for a single property: `app version [runtime-name] app-name environment version set user-config property = value`

The `app version set user-config` command takes the following arguments after the verb.

| Argument | Description | 
|----------|-------------|
| property | Name of the JSON property. For a nested property, use the syntax prop1.prop2.....propN. For a JSON array element, use the index instead of a property name. | 
| value | The value of the property. | 

**Examples**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

This command is based on the [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST service.

### Commands for devices
When you invoke the **mfpadm** program, you can include various commands for devices.

#### The `list devices` command
The `list devices` command returns the list of devices that have contacted the apps of a runtime.

Syntax: `list devices [runtime-name] [--query query]`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| query | A friendly name or user identifier, to search for. This parameter specifies a string to search for. All devices that have a friendly name or user identifier that contains this string (with case-insensitive matching) are returned. | 

The `list devices` command takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. | 

**Examples**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

This command is based on the [Devices (GET) REST](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) service.

#### The `remove device` command
The `remove device` command clears the record about a device that has contacted the apps of a runtime.

Syntax: `remove device [runtime-name] id`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| id | Unique device identifier. | 

**Example**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

This command is based on the [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST service.

#### The `device` command prefix
The `device` command prefix takes the following arguments before the verb.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| id | Unique device identifier. | 

#### The `device set status` command
The `device set status` command changes the status of a device, in the scope of a runtime.

Syntax: `device [runtime-name] id set status new-status`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| new-status | New status. | 

The status can have one of the following values:

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**Example**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

This command is based on the [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST service.

#### The `device set appstatus` command
The `device set appstatus` command changes the status of a device, regarding an app in a runtime.

Syntax: `device [runtime-name] id set appstatus app-name new-status`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| app-name | Name of an app. | 
| new-status | New status. | 

The status can have one of the following values:

* ENABLED
* DISABLED


**Example**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

This command is based on the [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST service.

### Commands for troubleshooting
When you invoke the **mfpadm** program, you can include various commands for troubleshooting.

#### The `show info` command
The `show info` command shows basic information about the MobileFirst administration services that can be returned without accessing any runtime nor database. This command can be used to test whether the MobileFirst administration services are running at all.

Syntax: `show info`

It takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. |

**Example**

```bash
show info
```

#### The `show versions` command
The `show versions` command displays the MobileFirst versions of various components:

* **mfpadmVersion**: the exact MobileFirst Server version number from **which mfp-ant-deployer.jar** is taken.
* **productVersion**: the exact MobileFirst Server version number from which **mfp-admin-service.war** is taken
* **mfpAdminVersion**: the exact build version number of **mfp-admin-service.war** alone.

Syntax: `show versions`

It takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. | 

**Example**

```bash
show versions
```

#### The `show diagnostics` command
The `show diagnostics` command shows the status of various components that are necessary for the correct operation of the MobileFirst administration service, such as the availability of the database and of auxiliary services.

Syntax: `show diagnostics`

It takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. | 

**Example**

```bash
show diagnostics
```

#### The `unlock` command
The `unlock` command releases the general-purpose lock. Some destructive operations take this lock in order to prevent concurrent modification of the same configuration data. In rare cases, if such an operation is interrupted, the lock might remain in locked state, making further destructive operations impossible. Use the unlock command to release the lock in such situations.

**Example**

```bash
unlock
```

#### The `list runtimes` command
The `list runtimes` command returns a list of the deployed runtimes.

Syntax: `list runtimes [--in-database]`

It takes the following options:

| Option | Description | 
|--------|-------------|
| --in-database	| Whether to look in the database instead of via MBeans | 
| --xml | Produces XML output instead of tabular output. | 

**Examples**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

This command is based on the [Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST service.

#### The `show runtime` command
The `show runtime` command shows information about a given deployed runtime.

Syntax: `show runtime [runtime-name]`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 

The `show runtime` command takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. | 

This command is based on the [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST service.

**Example**

```bash
show runtime mfp
```

#### The `delete runtime` command
The `delete runtime` command deletes a runtime, including its apps and adapters, from the database. You can delete a runtime only when its web application is stopped.

Syntax: `delete runtime [runtime-name] condition`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| condition | Condition when to delete it: empty or always. **Attention:** The always option is dangerous. |

**Example**

```bash
delete runtime mfp empty
```

This command is based on the [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST service.

#### The `list farm-members` command
The `list farm-members` command returns a list of the farm member servers on which a given runtime is deployed.

Syntax: `list farm-members [runtime-name]`

It takes the following arguments:

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 

The `list farm-members` command takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --xml | Produces XML output instead of tabular output. | 

**Example**

```bash
list farm-members mfp
```

This command is based on the [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST service.

#### The `remove farm-member` command
The `remove farm-member` command removes a server from the list of farm members on which the specified runtime is deployed. Use this command when the server has become unavailable or disconnected.

Syntax: `remove farm-member [runtime-name] server-id`

It takes the following arguments.

| Argument | Description | 
|----------|-------------|
| runtime-name | Name of the runtime. | 
| server-id | Identifier of the server. | 

The `remove farm-member` command takes the following options after the object.

| Option | Description | 
|--------|-------------|
| --force | Force removal of a farm member, even if it is available and connected. | 

**Example**

```bash
remove farm-member mfp srvlx15
```

This command is based on the [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST service.
