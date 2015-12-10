---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Android Applications
breadcrumb_title: Android SDK
relevantTo: [android]
weight: 3
---
### Overview
The MobileFirst Platform Foundation SDK provides a set of API methods enabling a developer to implement various MobileFirst features, such as: authentication and security mechanisms, notifications, resource requests, collecting analytics data and more.

> For a complete list of MobileFirst SDK abilities [visit the user documentation](#) <span style="color:red">TODO: missing link</a>

In this tutorial you will learn how to add the MobileFirst Native SDK using CocoaPods to either a new or existing Android application. You will also learn how to configure the MobileFirst Server to recognize the application, as well as find information about the MobileFirst configuration files that are added to the project.

**Pre-requisites:** Android Studio and MobileFirst CLI installed on the developer workstation.  
Make sure you have read through the [Setting up your development environment](../../setting-up-your-development-environment) tutorials.

**Jump to:**

- [Registering the application in the MobileFirst Operations Console](#registering-the-application-in-the-mobilefirst-operations-console)
- [Manually Adding the MobileFirst Native SDK](#manually-adding-the-mobilefirst-native-sdk)
- [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)

### Registering the Application in the MobileFirst Operations Console
Before starting, make sure the MobileFirst Server is running.  
From **Terminal** run the command: <code>mfpdev server start</code>.

1. Open your browser of choice and load the MobileFirst Operations Console using the address  <code>http://localhost:10080/mfpconsole/</code>. You can also open the console from **Terminal** using the CLI command <code>mfpdev server console</code>.
2. Click on the "Create new" button next to "Applications" to create a new application. Follow the on-screen instructions.

![Register application in the MobileFirst Operations Console](register-app-in-console.png)

After successfully registering your application you can optionally download a "skeleton" Android Studio project pre-bundled with the MobileFirst Native SDK.

If you prefer to manually add the MobileFirst Native SDK, [continue reading](#manually-adding-the-mobilefirst-native-sdk).

### Manually Adding the MobileFirst Native SDK
Follow the below instructions to manually add the MobileFirst Native SDK to either a new or existing Android Studio project.

1. Create an Android project or use an existing one.  

2. In <strong>Project > Gradle scripts</strong>, select <strong>build.gradle (Module: app)</strong>.

3. Add the following lines below <code>apply plugin: 'com.android.application'</code>:

    ```xml
    repositories{
        jcenter()
    }
    ```
    
4. Add the following inside <code>android</code>:
    
    ```xml
    packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
    }
    ```
    
5. Add the following lines inside <code>dependencies</code>:

    ```xml
    compile group: 'com.ibm.mobile.foundation',
    name: 'ibmmobilefirstplatformfoundation',
    version: '8.0.0.0',
    ext: 'aar',
    transitive: true
    ```
    
6. Add the following permissions to the <code>AndroidManifest.xml</code> file:

    ```xml
    <uses-permission android:name=android.permission.INTERNET/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    <uses-permission android:name="android.permission.GET_TASKS"/>
    ```
7. Add the MobileFirst UI activity:

    ```xml
    <activity android:name="com.worklight.wlclient.ui.UIActivity" />
    ```

Now that the MobileFirst Native SDK was added to the Android Studio project, the final step to perform is to ensure that the MobileFirst Server will recognize any future requests arriving to it from the application.

### Generated MobileFirst Native SDK artifacts
Two MobileFirst-related artifacts are available in the Android Studio project after it has been integrated with the MobileFirst Native SDK: the <code>mfpclient.properties</code> and the <code>application-descriptor.json</code> file.

#### mfpclient.properties 
Located at the <code>./app/src/main/assets/</code> folder of the project, this file contains server configuration properties and is user-editable:

- <code>protocol</code> – The communication protocol to MobileFirst Server. Either <code>HTTP</code> or <code>HTPS</code>.
- <code>host</code> – The hostname of the MobileFirst Server instance.
- <code>port</code> – The port of the MobileFirst Server instance.
- <code>wlServerContext</code> – The context root path of the application on the MobileFirst Server instance.
- <code>languagePreference</code> - Sets the default language for client sdk system messages

#### application-descriptor.json
Located in the **&lt;android-studio-project-root-directory&gt;/mobilefirst** folder, this file contains application configuration settings such as its <code>bundleId</code and <code>version</code> and is user-editable.

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