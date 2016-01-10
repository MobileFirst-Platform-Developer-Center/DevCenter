---
layout: tutorial
title: Adapter end-to-end demonstration
relevantTo: [ios,android,windows,cordova]
weight: 6
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an adapter is quickly created using the MobileFirst Operations Console, and the application is able to get a response from the MobileFirst Server using an MobileFirst Adapter.

#### Prerequisites:

* Configured Xcode for iOS, Android Studio for Android or Visual Studio 2013/2015 for Windows 8/10
* Maven and MobileFirst CLI installed
* *Optional* Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

From a **Command-line** window, navigate to the server's **scripts** folder and run the command: <code>./start.sh</code> in Mac and Linux or <code>start.cmd</code> in Windows.

### 2. Creating an adapter

1. Click on the "Create new" button next to **Adapters** and download the **JavaScript-HTTP** adapter sample.

    > If Maven and MobileFirst CLI are not installed, follow the **Setting up your environment** instructions to install.

    ![Image of create an adapter](create-an-adapter.png)
    
    ![Image of downloading an adapter sample](download-adapter-code.png)

### 3. Editing adapter logic

<span style="color:red">Update adapter name</span>

1. Open the adapter's Maven project in your IDE of choicea, navigate to the **[adapter-project/src/main/js/adapter-impl.js]** and paste the following code snippet:

    ```javascript
    WLResourceRequest code snippet here
    ```

2. From a **Command-line** window, navigate to the adapter's Maven project and run the command: 

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, run the command:

    ```bash
    mfpdev adapter deploy
    ```

    If using a remote MobileFirst Server, run the command:

    ```bash
    mfpdev adapter deploy Replace-with-remote-server-name
    ```
 
### 4. Testing the adapter
From a **Command-line** window, navigate to the adapter's Maven project and run the command: 

<span style="color:red">Update command</span>

```bash
mfpdev adapter call MyHTTPAdapter/MyProcedure ...
```

<hr>

## Next steps

* Learn how to make [resource request calls using adapters from the application logic](../../server-side-development)
* Review [All Tutorials](../../all-tutorials)

