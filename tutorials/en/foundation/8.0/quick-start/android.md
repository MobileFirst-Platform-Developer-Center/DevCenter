---
layout: tutorial
title: Android end-to-end demonstration
relevantTo: [android]
weight: 3
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application is quickly created using the MobileFirst Operations Console and connectivity is verified with the MobileFirst Server.

#### Prerequisites:

* Configured Android Studio
* *Optional* Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

From a **Command-line** window, navigate to the server's **scripts** folder and run the command: <code>./start.sh</code> in Mac and Linux or <code>start.cmd</code> in Windows.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: <code>http://your-server-host:server-port/mfpconsole</code>. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.
 
1. Click on the "Create new" button next to **Applications** and select the desired *platform*, *identifier* and *version* values.

    ![Image of selecting platform, and providing an identifier and version](create-an-application.png)
 
2. Click on the **Get Starter Code** tile and select to download the Android Starter Code.

    ![Image of downloading a sample application](download-sample-application.png)

### 3. Editing application logic

1. Open the Android Studio project.

2. Select the **app/java/com.mfp.sample/MainActivity.java** file and paste the following code snippet:

    ```java
    WLResourceRequest code snippet here
    ```

### 4. Testing the application

1. In Android Studio, click on the **Run App** button.

    ![Image of application that successfully called a resource from the MobileFirst Server ]()

<hr>

## Next steps

- To add an adapter follow the [Adapter end-to-end demonstration](../adapter)
- Review [All Tutorials](../../all-tutorials)
