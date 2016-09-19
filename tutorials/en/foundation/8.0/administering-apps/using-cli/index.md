---
layout: tutorial
title: Administrating applications through the Command-line
weight: 4
---
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

For more information about running the MobileFirst Server installer, see [Running IBM Installation Manager](../../../installation-configuration/production/installation-manager/).

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

* For WebSphere® Application Server: https://server:9443/mfpadmin
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

1. Install MacPorts by using the installer from [www.macports.org](www.macports.org).
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

#### The `show confidential-clients` command
The `show confidential-clients` command shows the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../../authentication-and-security/confidetnial-clients).

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

#### The `set confidential-clients` command
The `set confidential-clients` command specifies the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../../authentication-and-security/confidential-clients).

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

#### The `set confidential-clients-rule` command
The `set confidential-clients-rule` command specifies a rule in the configuration of the confidential clients that can access a runtime. For more information about confidential clients, see [Confidential clients](../../../authentication-and-security/confidential-clients).

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
### Commands for apps
### Commands for devices
### Commands for troubleshooting