---
layout: tutorial
title: iOS end-to-end demonstration
relevantTo: [ios]
weight: 2
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow where an application is quickly created using the MobileFirst Operations Console and connectivity is verified with the MobileFirst Server.

#### Prerequisites:

* Configured Xcode
* *Optional* Stand-alone MobileFirst Server and MobileFirst CLI ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

1. From a **Command-line** window, navigate to the server's **scripts** folder and run the command: <code>./start.sh</code>.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: <code>http://your-server-host:server-port/mfpconsole</code>. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.
 
1. Click on the "Create new" button next to **Applications** and select the desired *platform*, *identifier* and *version* values.

    ![Image of selecting platform, and providing an identifier and version](create-an-application.png)
 
2. Click on the **Get Starter Code** tile and select to download the iOS Starter Code.

    ![Image of downloading a sample application](download-sample-application.png)
    
    ![Image of download a sample application](download-application-code.png)
 
### 3. Editing application logic

1. Open the Xcode project project

2. Select the **[project-root]/ViewController.m** file and paste the following code snippet in <code>viewDidLoad</code>:

    In Objective-C:

    ```objc
    WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { 
        (token, error) -> Void in
        
        if (error != nil) {
            NSLog(@"Access token not granted.");
        } else {
            NSLog(@"Access token granted.");
        }
    }
    ```
    
    In Swift:
    
    ```swift
    WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { 
        (token, error!)->Void
        
        if error != nil {
            NSLog("Access token not granted.")
        }
        else {
            NSLog("Access token granted.")
        }
    }
    ```

### 4. Creating an adapter

1. Click on the "Create new" button next to **Adapters** and download the **JavaScript-HTTP** adapter sample.

    > If Maven and MobileFirst CLI are not installed, follow the on-screen **Setting up your environment** instructions to install.

    ![Image of create an adapter](create-an-adapter.png)
    
    ![Image of downloading an adapter sample](download-adapter-code.png)

### 5. Editing adapter logic

1. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command: 

    ```bash
    mfpdev adapter build
    ```

2. When the build finishes, run the command:

    ```bash
    mfpdev adapter deploy
    ```

    If using a remote MobileFirst Server, run the command:

    ```bash
    mfpdev adapter deploy Replace-with-remote-server-name
    ```

### 6. Testing the application

1. In Xcode, press the **Play** button.

    ![Image of application that successfully called a resource from the MobileFirst Server ]()

## Next steps

- Review the [Client-side development tutorials](../../client-side-development/)
- Review the [Server-side development tutorials](../../server-side-development/)
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review [All Tutorials](../../all-tutorials)
