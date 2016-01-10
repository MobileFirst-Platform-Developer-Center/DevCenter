---
layout: tutorial
title: Cordova end-to-end demonstration
relevantTo: [cordova]
weight: 1
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application &amp; an adapter are quickly created using the MobileFirst Operations Console, and the application is able to call a resource on the MobileFirst Server, using an MobileFirst Adapter.

#### Prerequisites:

* Configured Xcode for iOS, Android Studio for Android or Visual Studio 2013/2015 for Windows 8/10
* *Optional* Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

From a **Command-line** window, navigate to the server's **scripts** folder and run the command: <code>./start.sh</code> in Mac and Linux or <code>start.cmd</code> in Windows.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: <code>http://your-server-host:server-port/mfpconsole</code>. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *demo/demo*.
 
1. Click on the "Create new" button next to **Applications** and select the desired *platform*, *identifier* and *version* values.

    ![Image of selecting platform, and providing an identifier and version](create-an-application.png)
 
2. Click on the **Get Starter Code** tile and select to download the Cordova Starter Code.

    ![Image of downloading a sample application](download-sample-application.png)

### 3. Creating an adapter

1. Click on the "Create new" button next to **Adapters** and download a sample adapter.

    ![Image of downloading an adapter sample](create-an-adapter.png)
 
### 4. Editing application logic

1. Open the Cordova project in your code editor of choice.

2. Select the **www/js/index.js** file and paste the following code snippet:

    ```javascript
    WLResourceRequest code snippet here
    ```

### 5. Running the application

1. From a **Command-line** window, navigate to the Cordova project root folder.
2. Run the commands: <code>cordova prepare</code> followed by <code>cordova run</code>.

 - If a device is connected, the application will be installed and launched in the device,
 - Otherwise the Simulator or Emulator will be used.

    ![Image of application that successfully called a resource from the MobileFirst Server ]()

