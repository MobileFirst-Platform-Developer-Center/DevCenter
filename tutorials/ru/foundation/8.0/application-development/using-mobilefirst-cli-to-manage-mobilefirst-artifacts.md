---
layout: tutorial
title: Using MobileFirst CLI to Manage MobileFirst Artifacts
breadcrumb_title: Using the MobileFirst CLI
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## Overview
{: #overview }
{{ site.data.keys.product_full }} provides a Command Line Interface (CLI) tool for the developer, **mfpdev**, to easily manage client and server artifacts.  
Using the CLI you can manage Cordova-based applications that uses the {{ site.data.keys.product_adj }} Cordova plug-in, and Native applications that uses the {{ site.data.keys.product_adj }} Native SDK.

You can also create, register, and manage adapters to either local or remote {{ site.data.keys.mf_server }} instances, and administer projects from the command line or via REST services, or from the {{ site.data.keys.mf_console }}.

The **mfpdev** commands have two modes: interactive mode and direct mode. In interactive mode, you enter the command without options, and you are prompted for responses. In direct mode, you enter the full command, including options, and prompts are not provided. When applicable, the prompts are context-sensitive to the target platform of the app, as determined by the directory from which you run the command. Use the up and down arrow keys on your keyboard to move through the selections, and press the Enter key when the selection you want is highlighted and preceded by a ">" character.

In this tutorial you will learn how to install the `mfpdev` Command Line Interface (CLI) and how to use it to manage {{ site.data.keys.mf_server }} instances, applications and adapters.

> For more information regarding SDK integration in Cordova and Native applications, see the tutorials in the [Adding the {{ site.data.keys.product }} SDK](../../application-development/sdk/) category.

#### Jump to
{: #jump-to }
* [Prerequisites](#prerequisites)
* [Installing the {{ site.data.keys.mf_cli }}](#installing-the-mobilefirst-cli)
* [List of CLI commands](#list-of-cli-commands)
* [Interactive and Direct modes](#interactive-and-direct-modes)
* [Managing {{ site.data.keys.mf_server }} instances](#managing-mobilefirst-server-instances)
* [Managing Applications](#managing-applications)
* [Managing and Testing Adapters](#managing-and-testing-adapters)
* [Helpful commands](#helpful-commands)
* [Update and Uninstall the Command Line Interface](#update-and-uninstall-the-command-line-interface)

## Prerequisites
{: #prerequisites }
The {{ site.data.keys.mf_cli }} is available as an NPM package at the [NPM registry](https://www.npmjs.com/).  

Ensure **node.js** and **npm** is installed in the development environment in order to install NPM packages.  
Follow the installation instructions in [nodejs.org](https://nodejs.org) to install node.js.

To confirm that node.js is properly installed, run the command `node -v`.

```bash
node -v
v6.11.1
```

> **Note:** Minimum supported **node.js** version is **4.2.3**. Also, with the fast evolving **node** and **npm** packages, the MobileFirst CLI might not be fully functional with all the available versions of **node** and **npm** including the latest versions. 
> 
> For MobileFirst CLI versions upto and including iFix version 8.0.2018040312, ensure that **node** is on version **6.11.1** and **npm** version is **3.10.10**, for proper functioning of the CLI.
>
> For MobileFirst CLI iFix versions 8.0.2018100112 and higher, you can use Node version versions 8.x or 10.x

## Installing the {{ site.data.keys.mf_cli }}
{: #installing-the-mobilefirst-cli }
To install the Command Line Interface run the command:

```bash
npm install -g mfpdev-cli --no-optional
```


If the CLI .zip file was downloaded from the Download Center of the {{ site.data.keys.mf_console }}, use the command:

```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- To install the CLI without optional dependencies add the `--no-optional` flag:  `npm install -g --no-optional path-to-mfpdev-cli.tgz`

To confirm the installation, run the command `mfpdev` without any arguments and it will print the help text:

```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## List of CLI commands
{: #list-of-cli-commands }

| Command prefix                                                | Command action                               | Description                                                             |
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
| `mfpdev app`	                                                | register                                     | Registers your app with a {{ site.data.keys.mf_server }}.                           |
|                                                               | config                                       | Enables you to specify the back-end server and runtime to use for your app. In addition, for Cordova apps, enables you to configure several additional aspects such as the default language for system messages and whether to do a checksum security check. Other configuration parameters are included for Cordova apps.                                                                                                                                                |
|                                                               | pull                                         | Retrieves an existing app configuration from the server.                |
|                                                               | push                                         | Sends an app's configuration to the server.                             |
|                                                               | preview                                      | Enables you to preview your Cordova app without requiring an actual device of the target platform type. You can view the preview in either the {{ site.data.keys.mf_mbs }} or your web browser.                                                                               |
|                                                               | webupdate                                    | Packages the application resources contained in the www directory into a .zip file that can be used for the direct update process.                                                                                                                                     |
| mfpdev server	                                                | info                                         | Displays information about the {{ site.data.keys.mf_server }}.                      |
|                                                               | add                                          | Adds a new server definition to your environment                        |
|                                                               | edit                                         | Enables you to edit a server definition.                                |
|                                                               | remove                                       | Removes a server definition from your environment.                      |
|                                                               | console                                      | Opens the {{ site.data.keys.mf_console }}.                               |
|                                                               | clean                                        | Unregisters apps and removes adapters from the {{ site.data.keys.mf_server }}.      |
| mfpdev adapter                                                | create                                       | Creates an adapter.                                                     |
|                                                               | build                                        | Builds an adapter.                                                      |
|                                                               | build all                                    | Finds and builds all of the adapters in the current directory and its subdirectories. |
|                                                               | deploy                                       | Deploys an adapter to the {{ site.data.keys.mf_server }}.                           |
|                                                               | deploy all                                   | Finds all of the adapters in the current directory and its subdirectories, and deploys them to the {{ site.data.keys.mf_server }}. |
|                                                               | call                                         | Calls an adapter's procedure on the {{ site.data.keys.mf_server }}.                 |
|                                                               | pull                                         | Retrieves an existing adapter configuration from the server.                |
|                                                               | push                                         | Sends an adapter's configuration to the server.                             |
| mfpdev                                                        | config                                       | Sets your configuration preferences for preview browser type, preview timeout value, and server timeout value for the mfpdev command-line interface.                                                                                                                   |
|                                                               | info                                         | Displays information about your environment, including operating system, memory consumption, node version, and command-line interface version. If the current directory is a Cordova application, information provided by the Cordova cordova info command is also displayed. |
|                                                               | -v                                           | Displays the version number of the {{ site.data.keys.mf_cli }} currently in use. |
|                                                               | -d, --debug                                  | Debug mode: Produces debug output.                                      |
|                                                               | -dd, --ddebug                                | Verbose debug mode: Produces verbose debug output.                      |
|                                                               | -no-color                                    | Suppresses use of color in command output.                              |
| mfpdev help                                                   | name of command                              | Displays help for {{ site.data.keys.mf_cli }} (mfpdev) commands. With a arguments, displays more specific help text for each command type or command. i.e "mfpdev help server add" |

## Interactive and Direct modes
{: #interactive-and-direct-modes }
All commands can be executed in **interactive** or **direct mode**. In the interactive mode, the parameters required for the command will be prompted and some default values will be used. In direct mode, the parameters must be provided with the command being executed.

Example:

`mfpdev server add` in interactive mode:

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
The same command in direct mode would be

```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

To find what is the right syntax for a command in direct mode use `mfpdev help <command>`.


## Managing {{ site.data.keys.mf_server }} instances
{: #managing-mobilefirst-server-instances }
You can use `mfpdev server <option>` command to manage the instances of {{ site.data.keys.mf_server }} that are in use. There must be always at least one server instance listed as the default instance.   The default server is always used if another one was not specified.

### List server instances
{: #list-server-instances }
To list all the {{ site.data.keys.mf_server }} instances available to be used, run the command:

```bash
mfpdev server info
```

By default, a local server profile is created automatically and used as the current default by the CLI.

### Add a new server instance
{: #add-a-new-server-instance }
If you are using another local or remote {{ site.data.keys.mf_server }} instance you can add it to the list of instances available to be used with the command:

```bash
mfpdev server add
```

Follow the interactive prompt to provide a name to the server, the server URL and user/password credentials.  
For example, to add a {{ site.data.keys.mf_server }} that is running on a Mobile Foundation IBM Cloud service you would do the following:

```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully.
```

- Replace the "fully qualified URL of this server" with your own.

### Edit server instances
{: #edit-server-instances }
If you want to edit the details of a registered server instance, run the following command and follow the interactive prompt to select the server to be edited and provide the information to be updated.

```bash
mfpdev server edit
```

To set a server as the default one, use:

```bash
mfpdev server edit <server_name> --setdefault
```

### Remove server instances
{: #remove-server-instances }
To remove a server instance from the list of registered servers, run the command:

```bash
mfpdev server remove
```

And select the server from the interactive list

### Open {{ site.data.keys.mf_console }}
{: #open-mobilefirst-operations-console }
To open the console of the default server registered run the command:

```bash
mfpdev server console
```

To open the console of another server, inform the server name as a parameter of the command:

```bash
mfpdev server console <server_name>
```

### Remove apps and adapters from a server
{: #remove-apps-and-adapters-from-a-server }
To remove all apps and adapters registered in a server run the command:

```bash
mfpdev server clean
```

And select the server to clean form the interactive prompt.  
This will put the server instance in a clean state without any app or adapter deployed.

## Managing applications
{: #managing-applications }
The command `mfpdev app <option>` can be used to manage applications created with the {{ site.data.keys.product }} SDK.

### Register an application in a server instance
{: #register-an-application-in-a-server-instance }
An  application must be registered in a {{ site.data.keys.mf_server }} when it is ready to be executed.  
To register an app, run the following command from the root folder of the app project:

```bash
mfpdev app register
```

This command can be executed from the root of a Cordova, Android, iOS or Windows application.  
It will use the default server and runtime to run the following tasks:

* Register an application with a server.
* Generate a default client properties file for the application.
* Put the server information into the client properties file.

For a Cordova application, this command will update the config.xml file.  
For an iOS application, this command will update the mfpclient.plist file.  
For an Android or Windows application, this command will update the mfpclient.properties file.

To register an app to a server and runtime that is not the default one, use the syntax:

```
mfpdev app register <server> <runtime>
```

For Cordova Windows platform, the `-w <platform>` argument must be added to the command.  The `<platform>` argument is a comma separated list of the windows platforms to be registered. Valid values are `windows`,`windows8` and `windowsphone8`.

```
mfpdev app register -w windows8
```

### Configure an application
{: #configure-an-application }
When an application is registered, server related attributes are added to its configuration file.  
To change the values of these attributes, run the following command:

```bash
mfpdev app config
```

This command will interactively present a list of attributes that can be changed, and prompt for the new value of the attribute.  
The attributes available will vary for each platform (iOS, Android, Windows).

Available configurations are:

* The server address and runtime the application will be registered to

    > **Example use case:** in order to register an application to a {{ site.data.keys.mf_server }} with a certain address, but also have the application connect to a different server address, for example a DataPower appliance:
    >
    > 1. Run `mfpdev app register` to register the application in the expected {{ site.data.keys.mf_server }} address.
    > 2. Run `mfpdev app config` and change the **server** property's value to match the address of the DataPower appliance. You can also run the command in **direct mode**: `mfpdev app config server http(s)://server-ip-or-host:port`.

* Setting a public key for the Direct Update authenticity feature
* Setting application default language (default is English (en))
* Whether or not to enable the web resources checksum test
* What file extensions to ignore during the web resources checksum test

<div class="panel-group accordion" id="app-config" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Additional information about web resources checksum settings</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>For the web resources checksum settings, each possible target platform (Android, iOS, Windows 8, Windows Phone 8, and Windows 10 UWP) has a platform-specific key for use in <b>mfpdev</b> direct mode. These keys begin with a string that represents the platform name. For example, <code>windows10_security_test_web_resources_checksum</code> is a true or false setting that specifies whether to enable the web resources checksum test for Windows10 UWP.</p>

                <table class="table table-striped">
                    <tr>
                        <td><b>Setting</b></td>
                        <td><b>Description</b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>Specifies the public key for direct update authentication. The key must be in Base64 format.</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td>If set to <code>true</code>, enables the test for web resources checksum for iOS Cordova apps. The default is <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td>If set to <code>true</code>, enables the test for web resources checksum for Android Cordova apps. The default is <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td>If set to <code>true</code>, enables the test for web resources checksum for Windows 10 UWP Cordova apps. The default is <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td>If set to <code>true</code>, enables the test for web resources checksum for Windows 8.1 Cordova apps. The default is <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td>If set to <code>true</code>, enables the test for web resources checksum for Windows Phone 8.1 Cordova apps. The default is <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>Specifies what file extensions to ignore during web resources checksum testing for iOS Cordova apps. Separate multiple extensions with commas. For example: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>Specifies what file extensions to ignore during web resources checksum testing for Android Cordova apps. Separate multiple extensions with commas. For example:jpg, gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>Specifies what file extensions to ignore during web resources checksum testing for Windows 10 UWP Cordova apps. Separate multiple extensions with commas. For example: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>Specifies what file extensions to ignore during web resources checksum testing for Windows 8.1 Cordova apps. Separate multiple extensions with commas. For example: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>Specifies what file extensions to ignore during web resources checksum testing for Windows Phone 8.1 Cordova apps. Separate multiple extensions with commas. For example: jpg,gif,pdf</td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>


### Preview a Cordova application
{: #preview-a-cordova-application }
A Cordova application's web resources can be previewed using a browser. Previewing an application allows for fast and rapid develop without needing to use native platform specific emulators and simulators.

Before running the preview command, you must prepare the project by adding the `wlInitOptions` variable. Complete the following steps:

1. Add the *wlInitOptions* variable to your main JavaScript file, which is **index.js** in a standard Cordova app.

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" is the default context root of {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Replace with your own value.
   };
   ```

2. Register the app again by using the following command:

   ```bash
   mfpdev app register
   ```

 3. Run the following command:

    ```bash
    cordova prepare
    ```

 4. Preview the Cordova application by running the following command from the Cordova application root folder:

    ```bash
    mfpdev app preview
    ```

You will be prompted to select which platform to preview and which type of preview to use.
There are two options of preview: MBS and Browser.

* MBS - {{ site.data.keys.mf_mbs }}. This method simulates a mobile device in a browser, as well as provide rudimentary Cordova API simulation such as Camera, File Upload, Geolocation and more. Note: You cannot use the cordova-browser with the MBS option.
* Browser - Simple Browser Rendering. This method presents the www resources of the Cordova application as a usual browser web page.

> For more details about the preview options see the [Cordova development tutorial](../cordova-apps).

### Update web resources for Direct Update
{: #update-web-resources-for-direct-update }
The web resources of a cordova app, like .html, .css and .js files inside **www** folder can be updated without the need to reinstall the app at the mobile device. This is possible with the Direct Update feature provided by {{ site.data.keys.product }}.

> For more details about how Direct Update works see the tutorial [Using Direct Update in Cordova applications](../direct-update).

When you want to send a new set of web resources to be updated in a cordova application, run the command

```bash
mfpdev app webupdate
```

This command will package the updated web resources to a .zip file and upload it to the default {{ site.data.keys.mf_server }} registered. The packaged web resources can be found at the **[cordova-project-root-folder]/mobilefirst/** folder.

To upload the web resources to different server instance, inform the server name and runtime as part of the command

```bash
mfpdev app webupdate <server_name> <runtime>
```

You can use the --build parameter to generate the .zip file with the packaged web resources without uploading it to a server.

```bash
mfpdev app webupdate --build
```

To upload a package that was previously built, use the --file parameter

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

There is also the option to encrypt the content of package using the --encrypt parameter

```bash
mfpdev app webupdate --encrypt
```

### Pull and Push the {{ site.data.keys.product_adj }} Application configuration
{: #pull-and-push-the-mobilefirst-application-configuration }
After a {{ site.data.keys.product_adj }} Application is registered in a {{ site.data.keys.mf_server }}, it is possible to change some of the application configurations using the {{ site.data.keys.mf_server }} Console and them pull those configurations from the server to the application with the following command:

```bash
mfpdev app pull
```

It is also possible to change the application configurations locally and push the changes to the {{ site.data.keys.mf_server }} with the command:

```bash
mfpdev app push
```

**Example:** scope mapping to security checks can be performed in the {{ site.data.keys.mf_console }}, and then be pulled from  the server using the abve command. The downloaded .zip file is stored in the project's **[root directory]/mobilefirst** folder, and can be later used with the `mfpdev app push` to upload it to a different {{ site.data.keys.mf_server }}, allowing for fast configuration and setup by re-using the predefined configuration.

## Managing and Testing Adapters
{: #managing-and-testing-adapters }
It is possible to manage adapters with the command `mfpdev adapter <option>`.

> To learn more about adapters see the tutorials at the [Adapters](../../adapters/) category.


### Create an Adapter
{: #create-an-adapter }
To create a new Adapter, use the command

```bash
mfpdev adapter create
```

And follow the prompt to inform the name, type and group id of the adapter

### Build an Adapter
{: #build-an-adpater }
To build an adapter, run the following command from the adapter's root folder:

```bash
mfpdev adapter build
```

This will generate a .adapter file at the **<AdapterName>/target** folder.

### Deploy an Adapter
{: #deploy-an-adapter}
The following command will deploy the adapter to the default server:

```bash
mfpdev adapter deploy
```

To deploy to a different server, use:

```bash
mfpdev adapter deploy <server_name>
```

### Call an Adapter from the command line
{: #call-an-adapter-from-the-command-line }
After an adapter is deployed it is possible to call the adapter from the command line to test it's behavior with the command:

```bash
mfpdev adapter call
```

You will be prompted to inform the adapter, procedure and parameters to use. The output of the command will be the response of the adapter procedure.

> Learn more in the [Testing and debugging adapters](../../adapters/testing-and-debugging-adapters/) tutorial.

## Helpful commands
{: #helpful-commands }
To set preferences of the mfpdev CLI, such as default browser and default preview mode, use the command:

```bash
mfpdev config
```

To see the help content describing all mfpdev commands, use:

```bash
mfpdev help
```

The following command will generate a list with information about your environment:

```bash
mfpdev info
```

To print the version of the mfpdev CLI, use:

```bash
mfpdev -v
```

## Update and Uninstall the Command Line Interface
{: #update-and-uninstall-the-command-line-interface }
To update the command line interface run the command:

```bash
npm update -g mfpdev-cli
```

To uninstall the command line interface run the command:

```bash
npm uninstall -g mfpdev-cli
```
