---
layout: tutorial
title: All-in-one end-to-end demonstration - TEST TUTORIAL
relevantTo: [ios]
weight: 2
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application &amp; an adapter are quickly created using the MobileFirst Operations Console, and the application is able to call a resource on the MobileFirst Server, using an MobileFirst Adapter.

#### Prerequisites:

* Configured Xcode for iOS, Android Studio for Android or Visual Studio for Windows 8/10
* *Optional* Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

<hr> 

### 1. Starting the MobileFirst Server

> If a remote server was already setup, skip this step.

From a **Terminal** window, navigate to the server's **scripts** folder and run the command: <code>./start.cmd</code>.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: <code>http://your-server-host:server-port/mfpconsole</code>. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *demo/demo*.
 
1. Click on the "Create new" button next to **Applications** and select the desired *platform*, *identifier* and *version* values.

    ![Image of selecting platform, and providing an identifier and version](create-an-application.png)
 
2. Click on the **Get Starter Code** tile and select to download the an application Starter Code.

    ![Image of downloading a sample application](download-sample-application.png)

    ### 3. Creating an adapter

    1. Click on the "Create new" button next to **Adapters** and download a sample adapter.

        ![Image of downloading an adapter sample](create-an-adapter.png)
     
    2. <span style="color:red">Build the adapter.</span>

        ![Image of building the adapter]()

    ### 4. Editing application logic

    1. Open the downloaded application project in the appropriate IDE.
    
    2. Insert a code snippet to call a resource request on the MobileFirst Server:

        #### Cordova
        Select the <b>index.js</b> file and add the following code snippet in the <code>wlCommonInit()</code> function:

        ```javascript
        WLResourceRequest code snippet here
        ```
        
        #### iOS
        Select the <b>index.js</b> file and add the following code snippet in the <code>wlCommonInit()</code> function:

        ```javascript
        WLResourceRequest code snippet here
        ```
        
        #### Android
        Select the <b>index.js</b> file and add the following code snippet in the <code>wlCommonInit()</code> function:

        ```javascript
        WLResourceRequest code snippet here
        ```
        
        #### Windows 8 Universal and Windows 10 UWP
        Select the <b>index.js</b> file and add the following code snippet in the <code>wlCommonInit()</code> function:

        ```javascript
        WLResourceRequest code snippet here
        ```
        
    ### 5. Running the application

    1. From a **Terminal** window, navigate to the Cordova project root folder.
    2. Run the commands: <code>cordova prepare</code> followed by <code>cordova run</code>.

     - If a device is connected, the application will be installed and launched in the device,
     - Otherwise the Simulator or Emulator will be used.

        ![Image of application that successfully called a resource from the MobileFirst Server ]()


