---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Cordova Applications
breadcrumb_title: Cordova SDK
relevantTo: [cordova]
weight: 1
---

### Overview
The MobileFirst Platform Foundation SDK provides a set of API methods enabling a developer to implement various MobileFirst features, such as: authentication and security mechanisms, notifications, resource requests, collecting analytics data and more.

> For a complete list of MobileFirst SDK abilities [visit the user documentation](#) <span style="color:red">TODO: missing link</a>

In this tutorial you will learn how to add the MobileFirst Native SDK as an Apache Cordova plugin ([cordova-plugin-mfp](https://www.npmjs.com/package/cordova-plugin-mfp)) using NPM to either a new or existing Cordova application. You will also learn how to configure the MobileFirst Server to recognize the application, as well as find information about the MobileFirst configuration files that are added to the project.

**Pre-requisites:** Apache Cordova and MobileFirst CLI installed on the developer workstation.  
Make sure you have read through the [Setting up your development environment](../../setting-up-your-development-environment) tutorials.

**Jump to:**

- [Creating a Cordova app using the MobileFirst template](#adding-the-mobilefirst-native-sdk)
- [Adding the MobileFirst Cordova Plugin](#adding-the-mobilefirst-native-sdk)
- [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)



### Adding the MobileFirst Plugin to a Cordova project
Before starting, make sure the MobileFirst Server is running.  
From **Terminal** run the command:

```bash
mfpdev server start
```

Follow the below instructions to add the MobileFirst Cordova Plugin to either a new or existing Cordova project and register the app in a MobileFirst Server.

1. Create a Cordova project or use an existing one. The MobileFirst template app can be used to create a new Cordova project. To use the template app, open **Terminal**  and run the command:
```bash
cordova create myapp com.ibm.app myapp --template cordova-template-mfp
```
The ***myapp*** folder will be created with a copy of the cordova-template-mfp project

2. Navigate to the root of the Cordova project.

3. Add the MobileFirst Cordova Plugin[cordova-plugin-mfp](https://www.npmjs.com/package/cordova-plugin-mfp)) using the cordova CLI. This will install the plugin from [NPM](https://www.npmjs.com/package/cordova-plugin-mfp):
 ```bash
 cordova plugin add cordova-plugin-mfp
 ```

4. Add one or more platforms to the project using the Cordova CLI
    To add ios platform:
    ```bash
    cordova platform add ios
    ```
   To add android platform:
    ```bash
    cordova platform add android
    ```
### Registering the Cordova app in MobileFirst Server

4. Register the application with MobileFirst Server with the command: 
 
    ```bash
    mfpdev app register
    ```
    
    The <code>mfpdev app register</code> CLI command first connects to the MobileFirst Server and registers the application, followed by updating the <code>config.xml</code> file at the root of the Cordova project adding to it the metadata that identifies the MobileFirst Server. Each platform is registered as a native app in MobileFirst Server.
    
       <span style="color:red">TODO: Not sure if the following is valid for Cordova</a> 
    > The application registration can also be done from the MobileFirst Operations Console:    
        1. Open your browser of choice and load the MobileFirst Operations Console using the address  <code>http://localhost:10080/mfpconsole/</code>. You can also open the console from **Terminal** using the CLI command <code>mfpdev server console</code>.  
        2. Click on the "Create new" button next to "Applications" to create a new application. Follow the on-screen instructions.  
        3. After successfully registering your application you can optionally download a "skeleton" Android Studio project pre-bundled with the MobileFirst Native SDK.

    
    > <b>Tip:</b> Learn more about the various CLI commands in the [Introduction to MobileFirst CLI](#) tutorial <span style="color:red">TODO: missing link</a>
        
### Preview, emulate or run application on a device
#### Preview the Application
5. After registered in a MobileFirst Server, the app can be previewed with the command
```bash
mdo app preview
```
The preview can be done in two ways, with Simple Browser Rendering or with Mobile Browser Simulator. With Simple Browser Rendering the app is presented as a web page in your browser while Mobile Browser Simulator will simulate a Mobile Device in your browser and the app is presented inside the simulated device.
```bash
? Select how to preview your app: (Use arrow keys)
❯ browser: Simple browser rendering 
  mbs: Mobile Browser Simulator 
```
#### Run the application on a emulator or on a device

6. Use the Cordova CLI to run the application on a emulator or on a real device.
	To emulate the application execute the command <code> cordova emulate <platform> </code>
		example for ios:
		```bash
		cordova emulate ios
		```
		example for android:
		```bash
		cordova emulate android
		```
	To run the application on a real device attached to the development machin, execute the command <code> cordova run <platform> </code>
		example for ios:
		```bash
		cordova run ios
		```
		example for android:
		```bash
		cordova run android
		```
		
		


#### Execute the
<br>
#### Note about Swift:
> Because Swift is designed to be compatible with Objective-C you can use the MobileFirst SDK from within an iOS Swift project, too. Create a Swift project and follow the same steps, as described at the beginning of the tutorial, to integrate the MobileFirst Native SDK. Use <code>import IBMMobileFirstPlatformFoundation</code> in any class that needs to use the SDK.

#### Note about iOS 9:
> If you are developing for iOS9, [consider disabling ATS](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error) in the application's <code>info.plist</code> to be able to test locally without security restrictions.

### Generated MobileFirst Native SDK artifacts
Two MobileFirst-related artifacts are available in the Xcode project after it has been integrated with the MobileFirst Native SDK: the <code>mfpclient.plist</code> and the <code>application-descriptor.json</code> file.

#### mfpclient.plist 
Located at the root of the project, this file contains server configuration properties and is user-editable:

- <code>protocol</code> – The communication protocol to MobileFirst Server. Either <code>HTTP</code> or <code>HTPS</code>.
- <code>host</code> – The hostname of the MobileFirst Server instance.
- <code>port</code> – The port of the MobileFirst Server instance.
- <code>wlServerContext</code> – The context root path of the application on the MobileFirst Server instance.
- <code>languagePreference</code> - Sets the default language for client sdk system messages

#### application-descriptor.json
Located in the **&lt;xcode-project-root-directory&gt;/mobilefirst** folder, this file contains application configuration settings such as its <code>bundleId</code and <code>version</code> and is user-editable.

If edited, be sure to update the MobileFirst Server by running the CLI command: <code>mfpdev app push</code>.  
The file can also be updated by pulling from the server its latest variation by running the CLI command: <code>mfpdev app pull</code>.

The file can be edited via the MobileFirst Operations Console.

```javascript
{
    "applicationKey": {
        "bundleId": "com.sampleone.bankApp",
        "version": "1.0",
        "clientPlatform":"ios"
    },
  
    ...
    ...
    ...
 }
 ```

### Tutorials to follow next
Now that the application is integrated with the MobileFirst Native SDK you can continue reading tutorials for [Native iOS development](../../ios-tutorials/) to learn more about authentication and security, server-side development, notifications, and more.
