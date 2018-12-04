---
layout: tutorial
title: Ionic end-to-end demonstration
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The purpose of this demonstration is to explain an end-to-end flow. The following steps are carried out.

1. A sample application that is pre-bundled with the {{ site.data.keys.product_adj }} client SDK is registered and downloaded from the {{ site.data.keys.mf_console }}.
2. A new or provided adapter is deployed to the {{ site.data.keys.mf_console }}.  
3. The application logic is changed to make a resource request.

**End result**:

* Successfully ping the {{ site.data.keys.mf_server }}.
* Successfully retrieve data using an adapter.

### Prerequisites:
{: #prerequisites }
* Xcode for iOS, Android Studio for Android or Visual Studio 2015 or greater for Windows 10 UWP
* Ionic CLI
* *Optional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads)).
* *Optional*. Stand-alone {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads)).

### Step 1. Starting the {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Make sure you have [created a Mobile Foundation instance](../../bluemix/using-mobile-foundation), or if you are using the [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navigate to the server's folder and run the command: `./run.sh` in Mac and Linux or `run.cmd` in Windows.

### Step 2. Creating and registering an application
{: #2-creating-and-registering-an-application }
Open the {{ site.data.keys.mf_console }} by loading the URL: `http://your-server-host:server-port/mfpconsole` in a browser. If server is running locally, use `http://localhost:9080/mfpconsole`. The *username/password* is **admin/admin**.

1. Click the **New** button next to **Applications**
    * Select a platform from the list of platforms: **Android, iOS, Windows, Browser**
    * Enter **com.ibm.mfpstarterionic** as the **application identifier**
    * Enter **1.0.0** as the **version**
    * Click on **Register application**

    <img class="gifplayer" alt="Register an application" src="register-an-application-ionic.png"/>

2. Download the sample Ionic application from [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic).

### Step 3: Adding the MobileFirst SDK to Ionic application
{: #adding_mfp_ionic_sdk}

Follow the steps below to add MobileFirst Ionic SDK to the downloaded Ionic sample application.

1. Navigate to the root of your existing Ionic project and add the {{ site.data.keys.product_adj }} core Ionic Cordova plug-in.

2. Change directory to the root of the Ionic project: `cd MFPStarterIonic`

3. Add the MobileFirst Plugins by using the Ionic CLI command: `ionic cordova plugin add cordova-plugin-name`
For example:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > The above command adds MobileFirst Core SDK Plugin to the Ionic project.

4. Add one or more supported platforms to the Cordova project by using the Ionic CLI command: `ionic cordova platform add ios|android|windows|browser`. For example:

   ```bash
   cordova platform add ios
   ```

5. Prepare the application resources by running the `ionic cordova prepare command`:

   ```bash
   ionic cordova prepare
   ```

### Step 4. Editing application logic
{: #3-editing-application-logic }
1. Open the Ionic project in the code editor of your choice.

2. Select the **src/js/index.js** file and paste the following code snippet, replacing the existing `WLAuthorizationManager.obtainAccessToken()` function:

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                (response) => {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                (error) => {
                    alert("Failure: " + JSON.stringify(error));
                }
            );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### Step 5. Deploy an adapter
{: #4-deploy-an-adapter }
Download this [.adapter artifact](../javaAdapter.adapter) and deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action.

Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the *Hello World* **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="sample application" style="float:right"/>

### Step 6. Testing the application
{: #5-testing-the-application }
1. From a **Command-line** window, navigate to the Cordova project's root folder.
2. Run the command: `ionic cordova platform add ios|android|windows|browser` to add a platform.
3. In the Ionic project, select the **config.xml** file and edit the  `<mfp:server ... url=" "/>` value with the **protocol**, **host** and **port** properties with the correct values for your {{ site.data.keys.mf_server }}.
    * If using a local {{ site.data.keys.mf_server }}, the values are typically **http**, **localhost** and **9080**.
    * If using a remote {{ site.data.keys.mf_server }} (on IBM Cloud), the values are typically **https**, **your-server-address** and **443**.
    * If using a Kubernetes cluster on IBM Cloud Private and if the deployment is of type **NodePort**, the value of the port would typically be the **NodePort** exposed by the service in Kubernetes cluster.

    Alternatively, if you have installed the {{ site.data.keys.mf_cli }}, then navigate to the project root folder and run the command `mfpdev app register`. If a remote {{ site.data.keys.mf_server }} is used, [run the command](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)
    ```bash
    mfpdev server add
    ```
     to add the server, followed by the command to register the app, for example:
    ```bash
    mfpdev app register myIBMCloudServer
    ```

If a device is connected, the application is installed and launched in the device.
Otherwise, the simulator or emulator will be used.

<br clear="all"/>
### Results
{: #results }
* Clicking the **Ping {{ site.data.keys.mf_server }}** button displays **Connected to {{ site.data.keys.mf_server }}**.
* If the application was able to connect to the {{ site.data.keys.mf_server }}, a resource request call using the deployed Java adapter takes place. The adapter response is then displayed in an alert.

## Next steps
{: #next-steps }
Learn more on using adapters in applications, and how to integrate additional services such as Push Notifications, using the {{ site.data.keys.product_adj }} security framework and more:

- Review the [Application development](../../application-development/) tutorials
- Review the [Adapters development](../../adapters/) tutorials
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review the [Notifications tutorials](../../notifications/)
- Review [All Tutorials](../../all-tutorials)
