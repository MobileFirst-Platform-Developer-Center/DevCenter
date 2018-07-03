---
layout: tutorial
title: Adding the MobileFirst Foundation SDK to Cordova Applications
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
In this tutorial, you learn how to add the {{ site.data.keys.product_adj }} SDK to a new or existing Cordova application that has been created with Apache Cordova, Ionic, or another thirdy-party tool. You also learn how to configure the {{ site.data.keys.mf_server }} to recognize the application, and to find information about the {{ site.data.keys.product_adj }} configuration files that are changed in the project.

The {{ site.data.keys.product_adj }} Cordova SDK is provided as a set of Cordova plug-ins, [and is registered at NPM](https://www.npmjs.com/package/cordova-plugin-mfp).  
Available plug-ins are:

* **cordova-plugin-mfp** - The core SDK plug-in
* **cordova-plugin-mfp-push** - Provides push notifications support
* **cordova-plugin-mfp-jsonstore** - Provides JSONStore support
* **cordova-plugin-mfp-fips** - *Android only*. Provides FIPS support
* **cordova-plugin-mfp-encrypt-utils** - *iOS only*. Provides support for encryption and decryption

#### Support levels
{: #support-levels }
The Cordova platform versions supported by the MobileFirst plug-ins, are:

* cordova-ios: **>= 4.1.1 and < 5.0**
* cordova-android: **>= 6.1.2 and <= 7.0**
* cordova-windows: **>= 4.3.2 and < 6.0**

#### Jump to:
{: #jump-to }
- [Cordova SDK components](#cordova-sdk-components)
- [Adding the {{ site.data.keys.product_adj }} Cordova SDK](#adding-the-mobilefirst-cordova-sdk)
- [Updating the {{ site.data.keys.product_adj }} Cordova SDK](#updating-the-mobilefirst-cordova-sdk)
- [Generated {{ site.data.keys.product_adj }} Cordova SDK artifacts](#generated-mobilefirst-cordova-sdk-artifacts)
- [Cordova browser platform support](#cordova-browser-platform)
- [Tutorials to follow next](#tutorials-to-follow-next)

> **Note:** The **Keychain Sharing** capability is mandatory while running iOS apps in the iOS Simulator when using Xcode 8. You need to enable this capability manually before building the Xcode project.

## Cordova SDK components
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
The cordova-plugin-mfp plug-in is the core {{ site.data.keys.product_adj }} plug-in for Cordova, and is required. If you install any of the other {{ site.data.keys.product_adj }} plug-ins, the cordova-plugin-mfp plug-in is automatically installed, too, if not already installed.

> The following Cordova plug-ins are installed as dependencies of cordova-plugin-mfp:
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
The cordova-plugin-mfp-jsonstore plug-in enables your app to use JSONstore. For more information about JSONstore, see the [JSONStore tutorial](../../jsonstore/cordova/).  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
The cordova-plugin-mfp-push plug-in provides permissions that are necessary to use push notification from the {{ site.data.keys.mf_server }} for Android applications. Additional setup for using push notification is required. For more information about push notification, see the [Push notifications tutorial](../../../notifications/).

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
The cordova-plugin-mfp-fips plug-in provides FIPS 140-2 support for the Android platform. For more information, [see FIPS 140-2 support](../../../administering-apps/federal/#fips-140-2-support).

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
The cordova-plugin-mfp-encrypt-utils plug-in provides iOS OpenSSL frameworks for encryption for Cordova applications with the iOS platform. For more information, see [Enabling OpenSSL for Cordova iOS](additional-information).

**Prerequisites:**

- [Apache Cordova CLI](https://www.npmjs.com/package/cordova) and {{ site.data.keys.mf_cli }} installed on the developer workstation.
- A local or remote instance of {{ site.data.keys.mf_server }} is running.
- Read the [Setting up your {{ site.data.keys.product_adj }} development environment](../../../installation-configuration/development/mobilefirst) and [Setting up your Cordova development environment](../../../installation-configuration/development/cordova) tutorials.
- For cordova-windows, a version of Visual C++ that is compatible to the Visual Studio and .NET versions installed in the machine have to be installed.
- In case of Windows Phone SDK 8.0 and Visual Studio Tools for Universal Windows Apps, ensure that the cordova-windows applications created have all the required supporting libraries.

## Adding the {{ site.data.keys.product }} Cordova SDK
{: #adding-the-mobilefirst-cordova-sdk }
Follow the instructions below to add the {{ site.data.keys.product }} Cordova SDK to a new or existing Cordova project, and register it in the {{ site.data.keys.mf_server }}.

Before you start, make sure that the {{ site.data.keys.mf_server }} is running.  
If using a locally installed server: From a **Command-line** window, navigate to the server's folder and run the command: `./run.sh`.

> **Note:** If you are adding the SDK to an existing Cordova application, the plug-in overwrites the `MainActivity.java` file for Android and `Main.m` file for iOS.

### Adding the SDK
{: #adding-the-sdk }
Consider creating the project by using the {{ site.data.keys.product_adj }} Cordova **application template**. The template adds the necessary {{ site.data.keys.product_adj }}-specific plug-in entries to the Cordova project's **config.xml** file, and provides a {{ site.data.keys.product_adj }}-specific, ready-to-use, **index.js** file that is adjusted for {{ site.data.keys.product_adj }} application development.

#### New Application
{: #new-application }
1. Create a Cordova project: `cordova create projectName applicationId applicationName --template cordova-template-mfp`.  
   For example:

   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - "Hello" is the folder name of the application.
     - "com.example.helloworld" is the ID of the application.
     - "HelloWorld" is the Name of the application.
     - --template modifies the application with {{ site.data.keys.product_adj }}-specific additions.

    > The templated **index.js** enables you to use additional {{ site.data.keys.product_adj }} features as such [Multilingual application  translation](../../translation) and initialization options (see the user documentation for more information).

2. Change directory to the root of the Cordova project: `cd hello`

3. Add one or more supported platforms to the Cordova project by using the Cordova CLI command: `cordova platform add ios|android|windows`. For example:

   ```bash
   cordova platform add ios
   ```

   > **Note:** Because the application was configured using the {{ site.data.keys.product_adj }} template, the {{ site.data.keys.product_adj }} core Cordova plug-in is added automatically as the platform is added in step 3.

4. Prepare the application resources by running the `cordova prepare command`:

   ```bash
   cordova prepare
   ```

#### Existing Application
{: #existing-application }
1. Navigate to the root of your existing Cordova project and add the {{ site.data.keys.product_adj }} core Cordova plug-in:

   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. Navigate to the **www\js** folder and select the **index.js** file.

3. Add the following function:

   ```javascript
   function wlCommonInit() {

   }
   ```

The {{ site.data.keys.product_adj }} API methods are available after the {{ site.data.keys.product_adj }} client SDK has been loaded. The `wlCommonInit` function is then called.  
Use this function to call the various {{ site.data.keys.product_adj }} API methods.

### Registering the application
{: #registering-the-application }
1. Open a **Command-line** window and navigate to the root of the Cordova project.  

2. Register the application to {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```
    - If a remote server is used, [use the command `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) to add it.

The `mfpdev app register` CLI command first connects to the {{ site.data.keys.mf_server }} to register the application, then updates the **config.xml** file at the root of the Cordova project with metadata that identifies the {{ site.data.keys.mf_server }}.

Each platform is registered as an application in {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tip:** You can also register applications from the {{ site.data.keys.mf_console }}:    
>
> 1. Load the {{ site.data.keys.mf_console }}.  
> 2. Click the **New** button next to **Applications** to register a new application and follow the on-screen instructions.  

### Using the SDK
{: #using-the-sdk }
The {{ site.data.keys.product_adj }} API methods are available after the {{ site.data.keys.product_adj }} client SDK has been loaded. The `wlCommonInit` function is then called.  
Use this function to call the various {{ site.data.keys.product_adj }} API methods.

## Updating the {{ site.data.keys.product_adj }} Cordova SDK
{: #updating-the-mobilefirst-cordova-sdk }
To update the {{ site.data.keys.product_adj }} Cordova SDK with the latest release, remove the **cordova-plugin-mfp** plug-in: run the `cordova plugin remove cordova-plugin-mfp` command and then run the `cordova plugin add cordova-plugin-mfp` command to add it again.

SDK releases can be found in the SDK's [NPM repository](https://www.npmjs.com/package/cordova-plugin-mfp).

## Generated {{ site.data.keys.product_adj }} Cordova SDK artifacts
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
The Cordova configuration file is a mandatory XML file that contains application metadata, and is stored in the root directory of the app.  
After the {{ site.data.keys.product_adj }} Cordova SDK is added to the project, the Cordova-generated **config.xml** file receives a set of new elements that are identified with the namespace `mfp:`. The added elements contain information related to {{ site.data.keys.product_adj }} features and the {{ site.data.keys.mf_server }}.

### example of {{ site.data.keys.product_adj }} settings added to the **config.xml** file
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>          
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Click for full list of config.xml properties</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>Element</b></td>
                        <td><b>Description</b></td>
                        <td><b>Configuration</b></td>
                    </tr>
                    <tr>
                        <td><b>widget</b></td>
                        <td>Root element of the <a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">config.xml document</a>. The element contains two required attributes: <ul><li><b>id</b>: This is the application package name that was specified when the Cordova project was created. If this value is manually changed after the application was registered with the {{ site.data.keys.mf_server }}, then the application must be registered again.</li><li><b>xmlns:mfp</b>: The {{ site.data.keys.product_adj }} plug-in XML namespace.</li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>Required. The product version on which the application was developed.</td>
                        <td>Set by default. Must not be changed.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>Optional. When you enable the Direct Update Authenticity feature, the direct update package is digitally signed during deployment. After the client downloaded the package, a security check is run to validate the package authenticity. This string value is the public key that will be used to authenticate the direct update .zip file.</td>
                        <td>Set with the <code>mfpdev app config direct_update_authenticity_public_key key-value</code> command.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>Optional. Contains a comma-separated list of locales to display system messages.</td>
                        <td>Set with the <code>mfpdev app config language_preferences key-value</code> command.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td>Controls how the <code>WL.Client.init</code> method is called. By default, this value is set to false and the <code>WL.Client.init</code> method is automatically called after the {{ site.data.keys.product_adj }} plug-in is initialized. Set this value to <b>true</b> for the client code to explicitly control when <code>WL.Client.init</code> is called.</td>
                        <td>Edited manually. You can set the <b>enabled</b> attribute value to either <b>true</b> or <b>false</b>.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>Default remote server connection information, which the client application uses to communicate with the {{ site.data.keys.mf_server }}. <ul><li><b>url:</b> The url value specifies the {{ site.data.keys.mf_server }} protocol, host, and port values that the client will use to connect to the server by default.</li><li><b>runtime:</b> The runtime value specifies the {{ site.data.keys.mf_server }} runtime to which the application was registered. For more information about the {{ site.data.keys.product_adj }} runtime, see {{ site.data.keys.mf_server }} overview.</li></ul></td>
                        <td><ul><li>The server url value is set with <code>the mfpdev app config server</code> command.</li><li>The server runtime value is set with the <code>mfpdev app config runtime</code> command.</li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for the iOS platform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for the Android platform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for the Windows platform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for Windows 8.1 platforms.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for Windows 10 platforms.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>This element contains all {{ site.data.keys.product_adj }}-related client application configuration for Windows Phone 8.1 platforms.
                        <ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>This value is the checksum of application web resources. It is calculated when <code>mfpdev app webupdate</code> is run.</td>
                        <td>Not user-configurable. The checksum value is updated when the <code>mfpdev app webupdate</code> command is run. For more details about the <code>mfpdev app webupdate</code> command, type <code>mfpdev help app webupdate</code> in your command window.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>This value is the {{ site.data.keys.mf_console }} SDK checksum that is used to identify unique {{ site.data.keys.product_adj }} SDK levels.</td>
                        <td>Not user-configurable. This value is set by default.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>This element contains the client application's platform-specific configuration for {{ site.data.keys.product_adj }} security. Contains<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>Controls whether the application verifies the integrity of its web resources each time it starts running on the mobile device. Attributes: <ul><li><b>enabled:</b> Valid values are <b>true</b> and <b>false</b>. If this attribute is set to <b>true</b>, the application calculates the checksum of its web resources and compares this checksum with a value that was stored when the application was first run.</li><li><b>ignoreFileExtensions:</b> Checksum calculation can take a few seconds, depending on the size of the web resources. To make it faster, you can provide a list of file extensions to be ignored in this calculation. This value is ignored when the <b>enabled</b> attribute value is <b>false</b>.</li></ul></td>
                        <td><ul><li>The <b>enabled</b> attribute is set with the <code>mfpdev app config android_security_test_web_resources_checksum key-value</code> command.</li><li>The <b>ignoreFileExtensions</b> attribute is set with the <code>mfpdev app config android_security_ignore_file_extensions value</code> command.</li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>

### Editing {{ site.data.keys.product_adj }} settings in the config.xml file
{: #editing-mobilefirst-settings-in-the-configxml-file }
You can use the {{ site.data.keys.mf_cli }} to edit the above settings by running the command:

```bash
mfpdev app config
```
## Cordova Browser Platform support
{: #cordova-browser-platform}

MobileFirst Platform now supports the Cordova Browser platform along with the other supported platforms of Cordova Windows, Cordova Android, and Cordova iOS.

The use of Cordova Browser platform with MobileFirst Platform (MFP) is similar to using MFP with any of the other platforms. A sample to illustrate this feature is explained below.

Create a cordova application using the following command:
```bash
cordova create <your-appFolder-name> <package-name>
```
This will create a vanilla cordova app.

Add the MFP plugin using the following command:
```bash
cordova plugin add cordova-plugin-mfp
```
Add a button that can be used to ping your MFP server(the server could be your locally hosted server or server on IBM Cloud). Ping your MFP server on click of the button.
You can use the sample code below:

#### index.html

```html
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
  <meta name="format-detection" content="telephone=no">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">


  <link rel="stylesheet" type="text/css" href="css/index.css" />

  <!-- load script with wlCommonInit defined before loading cordova.js -->
  <script type="text/javascript" src="js/index.js"></script>
  <script type="text/javascript" src="cordova.js"></script>

  <title>MFP Starter - Cordova</title>
</head>

<body>

  <div id="main">
    <div id="main_title">Hello MobileFirst</div>
    <div id="main_status"></div>
    <div id="main_info"></div>
  </div>

  <div id="button_content">
    <button id="ping_button" style="display:none">Ping MobileFirst Server</button>
  </div>

</body>

</html>
```

#### index.js

```javascript

var Messages = {
  // Add here your messages for the default language.
  // Generate a similar file with a language suffix containing the translated messages.
  // key1 : message1,
};

var wlInitOptions = {
  // Options to initialize with the WL.Client object.
  // For initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development server
    applicationId : 'io.cordova.hellocordova' // Replace with your own app id/package name.
};

function wlCommonInit() {
  app.init();
}

var app = {
  //initialize app
  "init": function init() {
    var buttonElement = document.getElementById("ping_button");
    buttonElement.style.display = "block";
    buttonElement.addEventListener('click', app.testServerConnection, false);
  },
  //test server connection
  "testServerConnection": function testServerConnection() {

    var titleText = document.getElementById("main_title");
    var statusText = document.getElementById("main_status");
    var infoText = document.getElementById("main_info");
    titleText.innerHTML = "Hello MobileFirst";
    statusText.innerHTML = "Connecting to Server...";
    infoText.innerHTML = "";

    WLAuthorizationManager.obtainAccessToken()
      .then(
        function (accessToken) {
          titleText.innerHTML = "Yay!";
          statusText.innerHTML = "Connected to MobileFirst Server";
        },
        function (error) {
          titleText.innerHTML = "Bummer...";
          statusText.innerHTML = "Failed to connect to MobileFirst Server";
        }
        );
    },
 }

```

>**Note:** It is important to mention the `mfpContextRoot` and `applicationId` in the **wlInitOptions** in index.js file.

#### index.css

```css
body {
    position: static;
    font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    font-weight: 300;
    margin: 0px;
	padding: 0px;
}

#button_content {
  position: absolute;
  bottom: 10%;
  width: 100%;
}

#ping_button {
  display: block;
  margin: 0 auto;
  height: 50px;
  width: 240px;
  font-size: 20px;
  color: white;
  background-color: #325c80;
}

#main {
  top: 10%;
  position: absolute;
  text-align: center;
  width: 100%
}

#main_title {
  font-size: 40px;
}

#main_status {
  font-size: 20px;
  margin-top: 10px;
}

#main_info {
  font-size: 14px;
  margin-top: 10px;
}

```


Add the browser platform using the following command:
```bash
cordova platform add browser
```
<!--
 (Register the app to the MFP server. The **mfpdev-cli** from version -.-.- and above recognizes cordova browser applications as web platform applications. If you are using a lower version then you can either upgrade to the latest version or manually register your application. -->

> To manually register your application:
>
* Login to your MFP server's console.
* Click the **New** button next to the _*Applications*_ option.
* Provide a name to your application, select **Web** as the platform and provide your application's id (which was defined in the **wlInitOptions** function of your `index.js`).
>
>**Remember:** Add the server details to the `config.xml` of your application.

<!--If you are using **mfpdev-cli** (more about the `cli` commands can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/t_gs_cli.html)), add the MFP server using the following command:

```bash
mfpdev server add
```
Set it as the default server.

Register your application with the following command:

```bash
mfpdev app register
```
-->


 >**Note**: *mfpdev-cli* to register browser platform app will be released soon.

Then execute the following commands:

```bash
cordova prepare
cordova build
cordova run
```

<!--This will launch two browsers. One of the browser runs on cordova browser's proxy server (that runs on port `8000`, generally) which cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)). The other browser would be an MFP proxy server (this runs on port `9081`) that will serve MFP requests.

If you click the button to ping MFP on the browser running on port `8000`, the ping will fail whereas clicking the button that runs on localhost port `9081` will be successful. All the cordova browser compatible cordova plugins and MFP features can be used without issues.-->

This launches a browser that runs on a proxy server (on port `9081`) and connects to the MFP server. The cordova browser's default proxy server(that runs on port `8000`) has been suppressed as it cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy).

> The default browser to run is set to **Chrome**. Use the `--target` option to run on different browsers and can be used using the following command:
```bash
 cordova run --target=Firefox
 ```

The app can be previewed using the command:

```bash
mfpdev app preview
```

The only supported browser option is _*Simple Browser Rendering*_. The option _*Mobile Browser Support*_ is not supported for the browser platform.

### Using WebSphere Liberty to serve cordova browser resources
{: #using-liberty-cordova-browser}

Follow the instruction to use WebSphere Liberty in <a href="http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/">this</a> tutorial and make the below changes.

Add the contents of your browser project's `www` folder to `[MyWebApp] → src → Main → webapp ` as mentioned in Step 1 of **Building the Maven webapp with the web application’s resources** section of this tutorial. Finally, register your app on your Liberty server and test it by running it in the browser with the path `localhost:9080/MyWebApp`. Also add the `sjcl` and `jssha` folders to their parent folder and change their reference in the `ibmmfpf.js` file.

## Tutorials to follow next
{: #tutorials-to-follow-next }
With the {{ site.data.keys.product_adj }} Cordova SDK now integrated, you can now:

- Review the [Using the {{ site.data.keys.product }} SDK tutorials](../)
- Review the [Adapters development tutorials](../../../adapters/)
- Review the [Authentication and security tutorials](../../../authentication-and-security/)
- Review the [Notifications tutorials](../../../notifications/)
- Review [All Tutorials](../../../all-tutorials)
