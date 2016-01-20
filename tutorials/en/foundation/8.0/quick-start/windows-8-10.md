---
layout: tutorial
title: Windows 8.1 Universal and Windows 10 UWP end-to-end demonstration
relevantTo: [windows]
weight: 4
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application and an adapter are registered using the MobileFirst Operations Console, an "skeleton" Visual Studio project is downloaded and edited to call the adapter, and the result is printed to the log - verifying a successful connection with the MobileFirst Server.

#### Prerequisites:

* Configured Visual Studio 2013/5
* MobileFirst Developer CLI ([download]({{site.baseurl}}/downloads))
* *Optional* Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

From a **Command-line** window, navigate to the server's **scripts** folder and run the command: `start.bat`.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: `http://your-server-host:server-port/mfpconsole`. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.

1. Click on the "Create new" button next to **Applications** and select the desired *platform*, *identifier* and *version* values.

    ![Image of selecting platform, and providing an identifier and version](create-an-application.png)

2. Click on the **Get Starter Code** tile and select to download Windows 8.1 or Windows 10 Starter Code.

    ![Image of downloading a sample application](download-sample-application.png)

    ![Image of download a sample application](download-application-code.png)

### 3. Editing application logic

1. Open the Visual Studio project.

2. Select the solution's **MainPage.xaml.cs** file and paste the following code snippet:

    ```csharp
    IWorklightClient _newClient = WorklightClient.CreateInstance();

    StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/users/world");    

    WorklightResourceRequest rr = _newClient.ResourceRequest(uriBuilder.ToString(), "GET");

    WorklightResponse resp = await rr.Send();

    Debug.WriteLine("Response is " + resp.ResponseText);
    ```

### 4. Creating an adapter

1. Click on the "Create new" button next to **Adapters** and download the **Java** adapter sample.

    > If Maven and MobileFirst CLI are not installed, follow the on-screen **Setting up your environment** instructions to install.

    ![Image of create an adapter](create-an-adapter.png)

    ![Image of downloading an adapter sample](download-adapter-code.png)

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

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

### 5. Testing the application

1. In Visual Studio, click on the **Start Debugging** button.

    ![Image of application that successfully called a resource from the MobileFirst Server ]()

## Next steps
Learn more on using adapters in applications, and how to integrate additional services such as Push Notifications, using the MobileFirst security framework and more:

- Review the [Server-side development tutorials](../../server-side-development/)
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review the [Notifications tutorials](../../notifications/)
- Review [All Tutorials](../../all-tutorials)
