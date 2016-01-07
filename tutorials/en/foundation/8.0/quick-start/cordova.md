---
layout: tutorial
title: Cordova end-to-end demonstration
relevantTo: [cordova]
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application &amp; an adapter are quickly created using the MobileFirst Operations Console, and the application is able to call a resource on the MobileFirst Server, using an MobileFirst Adapter.

#### Requirements:

* <span style="color:red">Stand-alone MobileFirst Server / MobileFirst CLI</span>
* Configured Xcode 6.x for iOS, Android Studio for Android or Visual Studio for Windows 8/10

<hr> 

### 1. Starting the MobileFirst Server

From a **Terminal** window:

* If using the MobileFirst CLI, run the command: <code>mfpdev server start</code>.
* If using a stand-alone MobileFirst Server, navigate to the server's **scripts** folder and run the command: <code>./start.cmd</code> in Mac, <code>./start.sh</code> in Linux or <code>start.bat</code> in Windows.

### 2. Creating an application

Open the MobileFirst Operations Console by loading the URL <code>http://localhost:9080/mfpconsole</code>.  
The username/password are *demo/demo*.
 
1. Click on "Create new" next to **Applications**.

    ![Image of creating a new application](create-app.png)

2. Select the Desired platform, and provide an identifier &amp; version values.

    ![Image of selecting platform, and providing an identifier and version](register-app.png)
 
3. Click on the **Download Sample** tile and select to download a Hybrid sample.

    ![Image of downloading a sample application](download-sample.png)

### 3. Creating an adapter

From the MobileFirst Operations Console,

1. Click on "Create new" next to **Adapters**.

    ![Image of creating a new adapters](create-adapter.png)

2. Download an adapter sample.

    ![Image of downloading an adapter sample]()
 
3. <span style="color:red">Build the adapter.</span>

    ![Image of building the adapter]()

### 4. Editing application logic to use an adapter

1. Open the Cordova project in your code editor of choice.

2. Select the index.js file and edit it by adding the following code snippet in the <code>wlCommonInit()</code> function:

    ```javascript
    WLResourceRequest code snippet here
    ```

### 5. Running the application

1. In **Terminal**, navigate to the Cordova project root folder.
2. Run the commands: <code>cordova bulid</code> followed by <code>cordova run</code>.

 - If a device is connected, the application will be installed and launched in the device,
 - Otherwise the Simulator or Emulator will be used.

    ![Image of application that successfully called a resource from the MobileFirst Server ]()

