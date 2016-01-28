---
layout: tutorial
title: Using MobileFirst Developer CLI to Manage MobileFirst Artifacts
weight: 1
relevantTo: [ios,android,windows,cordova]
---
## Overview

IBM MobileFirst Platform Foundation provides a Command Line Interface (CLI) tool - `mfpdev` - to easily  manage MobileFirst client and server artifacts. The CLI tool enables you to use your preferred code editors or alternative IDEs.

By using the CLI, you can manage Cordova-based applications that uses the MobileFirst Cordova plug-in, and Native applications that uses the MobileFirst Native SDK.

You can also create, register, and manage MobileFirst adapters to either local or remote MobileFirst Server instances, and administer projects from the command line or via REST services, or from the MobileFirst Operations Console.

For more information regarding SDK integration in native and Cordova applications, see the tutorials in the [Adding the MobileFirst Platform Foundation SDK category](../../adding-the-mfpf-sdk/)

In this tutorial you will learn how to install the `mfpdev` Command Line Interface (CLI) and how to use it to manage MobileFirst Server instances, applications and adapters.

>Learn more about the MobileFirst CLI in the "MobileFirst Platform Command Line Interface" topic in the user documentation

#### Jump to

* [Prerequisites](#prerequisites)
* [Installing the mfpdev CLI](#installation)
* [Interactive and Direct modes](#interactiveAndDirectModes)
* [Managing MobileFirst Server instances](#managingServers)
* [Managing Applications](#managingApplications)
* [Managing and Testing Adapters](#adapters)
* [Helpful commands](#helpfulCommands)
* [Update and Uninstall the Command Line Interface](#updateUninstall)

## Prerequisites
The Command Line Interface is available as a NPM package at [NPM registry](https://www.npmjs.com/). You must have node.js installed in your environment in order to install NPM packages.

Access [nodejs.org](https://nodejs.org) and follow the instructions there to install node.js.

To confirm that node.js is installed properly, execute the command `node -v`.

```bash
$ node -v
v4.2.3
```

>Note: Minimum supported node.js version is 4.2.3

<span style="color:red">TODO: Confirm if  node.js 5.0+ will be supported at GA</span>

## Interactive and Direct modes

All commands can be executed in interactive or direct mode. In the interactive mode, the parameters required for the command will be prompted and some default values will be used. In direct mode, the parameters must be provided with the command being executed.

Example:

`mfpdev server add` in interactive mode:

```bash
$ mfpdev server add
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the MobileFirst Server administrator login ID: admin
? Enter the MobileFirst Server administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the MobileFirst Server connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
The same command in direct mode would be

`mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault`

To find what is the right syntax for a command in direct mode use `mfpdev help <command>`

```
$ mfpdev help server add

NAME
     mobilefirst server add

SYNOPSIS
     mfpdev server add [
          <name>
          --url|-u <url>
          [--login|-l <login>]
          [--password|-p <password>]
          [--contextroot|-c <contextRoot>]
          [--timeout|-t <timeout>]
          [--setdefault|-s]
     ]

DESCRIPTION
     Adds a new server definition.

OPTIONS
	<name>: The name of the server to use as an alias.

	--url|-u <url>: The fully qualified URL of the server. The syntax must
	include the full: protocol://name.domain:port. The IP address may also be
	used instead of name.domain. This value is required if the server name is
	supplied on the command line.                

	[--login|-l <login>]: The admin login id used to manage the MobileFirst
	server. If not set, defaults to "demo".

	[--password|-p <password>]: The password for the admin login ID. If you do
	not set this, you are prompted for the admin password on all server
	management tasks.  There is no default password.

	[--contextroot|-c <contextRoot>]:  The context root of the MobileFirst
	administration services.  If not set, defaults to 'mfpadmin'.

	[--timeout|-t <timeout>]:  The MobileFirst server connection timeout
	value in seconds.

	[--setdefault|-s]: Providing this flag makes this new server the new
	default server profile. You can switch the default by using
	'mfpdev server edit'.


USAGE
	Interactive Mode:
          $ mfpdev server add

	Direct Mode:
          $ mfpdev server add name --url http://acme.com:10080 --setdefault
```

## Installing the mfpdev CLI

To install the Command Line Interface execute the command:

```bash
$ npm install -g mfpdev-cli
```
To confirm the installation execute the command `mfpdev` without any arguments and it will print the help text.

```
mfpdev
NAME
     IBM MobileFirst Platform Foundation Command Line Interface (CLI).


SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Platform Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Platform Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Platform Foundation at

          https://www.ibm.com/support/knowledgecenter.


ADAPTERS
     adapter build ................ Builds a MobileFirst Adapter
     adapter create ............... Creates a MobileFirst Adapter

APPLICATIONS
     app preview .................. Previews your app.
     app pull ..................... Pulls application artifacts from a server
     app push ..................... Pushes application artifacts to a server
     app register ................. Registers an application or applications to a server

GLOBAL
     config ....................... Sets your configuration preferences.
     info ......................... Displays information about your environment.

SERVERS
     server add ................... Adds a new server definition.
     server clean ................. Clean apps and adaptors in an existing server.
     server console ............... Opens the MobileFirst console.
     server edit .................. Edits an existing server definition.
     server info .................. Provides information for all servers or a specific server.
     server remove ................ Removes an existing server definition.

COMMAND-LINE FLAGS/OPTIONS
     -v, --version ................ Prints out this utilitys version
     -d, --debug .................. Debug mode produces debug log output
     -dd, --ddebug ................ Debug mode produces verbose log output
     --no-color ....................Suppresses use of color in command output

EXAMPLE USAGE
     $ mfpdev register
     $ mfpdev pulls
     $ mfpdev push
```


## Managing MobileFirst Server instances

You can use `mfpdev server <option>` command to manage the instances of MobileFirst Server that are in use.

### List server instances

To list all the MobileFirst Server instances available to be used, execute the  command

```bash
$ mfpdev server info
```

By default, a local server profile is created automatically and used as the current default by the CLI

### Add a new server instance

If you are using another local or remote MobileFirst Server instance you can add it to the list of instances available to be used with the command:

```bash
$ mfpdev server add
```

Follow the interactive prompt to provide a name to the server, the server URL and user/password credentials.

### Edit server instances

If you want to edit the details of a registered server instance, execute the command

```bash
$ mfpdev server edit
```

And follow the interactive prompt to select the server to be edited and provide the information to be updated

### Remove server instances

To remove a server instance from the list of registered servers, execute the command:

```bash
$ mfpdev server remove
```

And select the server from the interactive list

### Open server console

To open the console of the default server registered execute the command

```bash
$ mfpdev server console
```

This command will open the console of another server, not the default one, inform the server name as a parameter of the command

```bash
$ mfpdev server console **server_name**
```

### Remove apps and adapters from a server

To remove all apps and adapters registered in a server execute the command

```bash
$ mfpdev server clean
```
This will put the  server instance in a clean state

## Managing applications

The command `mfpdev app <option>` can be used to manage applications created with the MobileFirst Platform SDK.

### Register an application in a server instance

Applications created with MobileFirst Platform SDK, must be registered in a MobileFirst Server when it is ready to be executed.

To register an app, run the following command from the root folder of the app project.

```bash
$ mfpdev app register
```
This command can be executed from the root of a Cordova, Android, iOS or Windows application.

It will use the default server and runtime to execute the following tasks:

Register an application with a server
Generate a default client properties file for the application
Put the server information into the client properties file

For a Cordova application, this command will update the config.xml file
For an iOS application, this command will update the  file mfpclient.plist
For an Android or Windows application, this command will update the file mfpclient.properties

To register an app to a server and runtime that is not the default one, use the syntax

```
$ mfpdev app register **server** **runtime**
```

For Cordova Windows platform, the `-w <platform>` argument must be added to the command.  The `<platform>` argument is a comma separated list of the windows platforms to be registered. Valid values are `windows`,`windows8` and `windowsphone8`


### Config an application

When an application is registered, server related attributes are added to the app configuration file.

To change the value of those attributes, use the following command

```bash
$ mfpdev app config
```

This command will interactively present a list of attributes that can be changed and prompt for the new value of the attribute

### Preview a Cordova application

A Cordova application can be previewed using a browser. This is a way to preview an app faster then using the platform specific emulators and simulators.

To preview a Cordova application execute the command

```bash
$ mfpdev app preview
```
You will be prompted to select what platform to preview and what type of preview to be used.
There are two options of preview, MBS and Browser. MBS - Mobile Browser Simulator - will simulate a mobile device on browser. Browser - Simple Browser Rendering - will present the www resources of the cordova application as a usual browser web page.

>For more details about the preview options see the [UPDATE- Tutorial about preview](../url/to/be/updated)


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

## Update and Uninstall the Command Line Interface

To update the command line interface execute the command:

```bash
npm update -g mfpdev-cli
```

To uninstall the command line interface execute the command:

```bash
npm uninstall -g mfpdev-cli
```

## Tutorials to follow next

to be updated...
