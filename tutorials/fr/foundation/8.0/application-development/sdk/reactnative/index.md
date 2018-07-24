---
layout: tutorial
title: Adding the MobileFirst Foundation SDK to React Native Applications
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
In this tutorial, you learn how to add the {{ site.data.keys.product_adj }} SDK to a new or existing React Native application, which has been created with React Native CLI. You also learn how to configure the {{ site.data.keys.mf_server }} to recognise the application, and to find information about the {{ site.data.keys.product_adj }} configuration files that are changed in the project.

The {{ site.data.keys.product_adj }} React Native SDK is provided as a react native npm plug-in, and is registered at [NPM](https://www.npmjs.com/package/cordova-plugin-mfp).  

Available plug-ins are:

* **react-native-ibm-mobilefirst** - The core SDK plug-in

#### Jump to:
{: #jump-to }
- [React Native SDK components](#react-native-sdk-components)
- [Adding the {{ site.data.keys.product_adj }} React Native SDK](#adding-the-mobilefirst-react-native-sdk)
- [Updating the {{ site.data.keys.product_adj }} React Native SDK](#updating-the-mobilefirst-react-native-sdk)
- [Generated {{ site.data.keys.product_adj }} React Native SDK artifacts](#generated-mobilefirst-reactnative-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)


## React Native SDK components
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
The react-native-ibm-mobilefirst plug-in is the core {{ site.data.keys.product_adj }} plug-in for React Native and is required. If you install any of the other {{ site.data.keys.product_adj }} plug-ins, the react-native-ibm-mobilefirst plug-in is automatically installed too, if not already installed.

**Prerequisites:**

- [React Native CLI](https://www.npmjs.com/package/react-native) and {{ site.data.keys.mf_cli }} installed on the developer workstation.
- A local or remote instance of {{ site.data.keys.mf_server }} is running.
- Read the [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/development/mobilefirst) and [Setting up your React Native development environment](../../../installation-configuration/development/reactnative) tutorials.

## Adding the {{ site.data.keys.product }} React Native SDK
{: #adding-the-mobilefirst-react-native-sdk }
Follow the instructions below to add the {{ site.data.keys.product }} React Native SDK to a new or existing React Native project, and register it in the {{ site.data.keys.mf_server }}.

Before you start, make sure that the {{ site.data.keys.mf_server }} is running.  
If using a locally installed server: From a **Command-line** window, navigate to the server's folder and run the command: `./run.sh`.

### Adding the SDK
{: #adding-the-sdk }

#### New Application
{: #new-application }
1. Create a React Native project: `react-native init projectName`.  
   For example:

   ```bash
   react-native init Hello
   ```
     - *Hello* is the folder name and name of the application.

    > The templated **index.js** enables you to use additional {{ site.data.keys.product_adj }} features as such [Multilingual application  translation](../../translation) and initialization options (see the user documentation for more information).

2. Change directory to the root of the React Native project: `cd hello`

3. Add the MobileFirst Plugins by using the NPM CLI command: `npm install react-native-plugin-name`
For example:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > The above command adds MobileFirst Core SDK Plugin to the React native project.


4. Link the plugin libraries by running the command:

   ```bash
   react-native link
   ```

#### Existing Application
{: #existing-application }

1. Navigate to the root of your existing React Native project and add the {{ site.data.keys.product_adj }} core React Native plug-in:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. Link the plugin libraries by running the command:

   ```bash
   react-native link
   ```

### Registering the application
{: #registering-the-application }

1. Open a **Command-line** window and navigate to the root of the  particular platform (iOS or Android) of the project.  

2. Register the application to {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```

  * **iOS** :

    If your platform is iOS then you are asked to provide the application’s BundleID. **Important**: The BundleID is **case sensitive**.

    The `mfpdev app register` CLI command first connects to the MobileFirst Server to register the application, then generates the **mfpclient.plist** file at the root of the Xcode project, and adds to it the metadata that identifies the MobileFirst Server.

  *  **Android** :

      If your platform is Android then you are asked to provide the application’s package name. **Important**: The package name is **case sensitive**.

       The `mfpdev app register` CLI command first connects to the MobileFirst Server to register the application, followed by generating the **mfpclient.properties** file in the **[project root]/app/src/main/assets/** folder of the Android Studio project and to add to it the metadata that identifies the MobileFirst Server.


If a remote server is used, [use the command](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) `mfpdev server add` to add it.

The `mfpdev app register` CLI command first connects to the {{ site.data.keys.mf_server }} to register the application. 	Each platform is registered as an application in {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tip:** You can also register applications from the {{ site.data.keys.mf_console }}:    
>
> 1. Load the {{ site.data.keys.mf_console }}.  
> 2. Click the **New** button next to **Applications** to register a new application and follow the on-screen instructions.  


## Updating the {{ site.data.keys.product_adj }} React Native SDK
{: #updating-the-mobilefirst-react-native-sdk }
To update the {{ site.data.keys.product_adj }} React native SDK with the latest release, remove the **react-native-ibm-mobilefirst** plug-in: run the `npm uninstall react-native-ibm-mobilefirst` command and then run the `npm install react-native-ibm-mobilefirst` command to add it again.

SDK releases can be found in the SDK's [NPM repository](https://www.npmjs.com/package/xxxxxx).

## Generated {{ site.data.keys.product_adj }} React Native SDK artifacts
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Android Environment

#### mfpclient.properties
{: #mfpclient.properties }
Located in the **./app/src/main/assets/** folder of the Android Studio project, this file defines the client-side properties used for registering your Android app on the {{ site.data.keys.mf_server }}.

| Property            | Description                                                         | Example values |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | The communication protocol with the {{ site.data.keys.mf_server }}.             | http or https  |
| wlServerHost        | The host name of the {{ site.data.keys.mf_server }}.                            | 192.168.1.63   |
| wlServerPort        | The port of the {{ site.data.keys.mf_server }}.                                 | 9080           |
| wlServerContext     | The context root path of the application on the {{ site.data.keys.mf_server }}. | /mfp/          |
| languagePreferences | Sets the default language for client sdk system messages.           | en             |


### iOS Enviroment

#### mfpclient.plist
{: #mfpclientplist }
Located at the root of the project, this file defines the client-side properties used for registering your iOS app on the {{ site.data.keys.mf_server }}.

| Property            | Description                                                         | Example values |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | The communication protocol with the {{ site.data.keys.mf_server }}.             | http or https  |
| host        | The host name of the {{ site.data.keys.mf_server }}.                            | 192.168.1.63   |
| port        | The port of the {{ site.data.keys.mf_server }}.                                 | 9080           |
| wlServerContext     | The context root path of the application on the {{ site.data.keys.mf_server }}. | /mfp/          |
| languagePreferences | Sets the default language for client sdk system messages.           | en             |


## Tutorials to follow next
{: #tutorials-to-follow-next }
With the {{ site.data.keys.product_adj }} React Native SDK now integrated, you can now:

- Review the [Using the {{ site.data.keys.product }} SDK tutorials](../)
- Review the [Adapters development tutorials](../../../adapters/)
- Review the [Authentication and security tutorials](../../../authentication-and-security/)
- Review the [Notifications tutorials](../../../notifications/)
- Review [All Tutorials](../../../all-tutorials)
