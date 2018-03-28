---
layout: tutorial
title: Cordova end-to-end demonstration
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The purpose of this demonstration is to experience an end-to-end flow:

1. A sample application that is pre-bundled with the {{ site.data.keys.product_adj }} client SDK is registered and downloaded from the {{ site.data.keys.mf_console }}.
2. A new or provided adapter is deployed to the {{ site.data.keys.mf_console }}.  
3. The application logic is changed to make a resource request.

**End result**:

* Successfully pinging the {{ site.data.keys.mf_server }}.
* Successfully retrieving data using an adapter.

#### Prerequisites:
{: #prerequisites }
* Xcode for iOS, Android Studio for Android or Visual Studio 2013/2015 for Windows 8.1 Universal / Windows 10 UWP
* Cordova CLI 6.x.
* *Optional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads))
* *Optional*. Stand-alone {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### 1. Starting the {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Make sure you have [created a Mobile Foundation instance](../../bluemix/using-mobile-foundation), or  
If using the [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navigate to the server's folder and run the command: `./run.sh` in Mac and Linux or `run.cmd` in Windows.

### 2. Creating and registering an application
{: #2-creating-and-registering-an-application }
In a browser window, open the {{ site.data.keys.mf_console }} by loading the URL: `http://your-server-host:server-port/mfpconsole`. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.

1. Click the **New** button next to **Applications**
    * Select a platform: **Android, iOS, Windows**
    * Enter **com.ibm.mfpstartercordova** as the **application identifier**
    * Enter **1.0.0** as the **version**
    * Click on **Register application**

    <img class="gifplayer" alt="Register an application" src="register-an-application-cordova.png"/>

2. Click on the **Get Starter Code** tile and select to download the Cordova sample application.

    <img class="gifplayer" alt="Download sample application" src="download-starter-code-cordova.png"/>

### 3. Editing application logic
{: #3-editing-application-logic }
1. Open the Cordova project in your code editor of choice.

2. Select the **www/js/index.js** file and paste the following code snippet, replacing the existing `WLAuthorizationManager.obtainAccessToken()` function:

```javascript
WLAuthorizationManager.obtainAccessToken()
    .then(
        function(accessToken) {
            titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";

            var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );

            resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                function(response) {
                    alert("Failure: " + JSON.stringify(response));
                }
            );
        },

        function(error) {
            titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
    );
```

### 4. Deploy an adapter
{: #4-deploy-an-adapter }
Download [this prepared .adapter artifact](../javaAdapter.adapter) and deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action.

Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>   


<img src="cordovaQuickStart.png" alt="sample application" style="float:right"/>
### 5. Testing the application
{: #5-testing-the-application }
1. From a **Command-line** window, navigate to the Cordova project's root folder.
2. Run the command: `cordova platform add ios|android|windows` to add a platform.
3. In the Cordova project, select the **config.xml** file and edit the  `<mfp:server ... url=" "/>` value with the **protocol**, **host** and **port** properties with the correct values for your {{ site.data.keys.mf_server }}.
    * If using a local {{ site.data.keys.mf_server }}, the values are typically **http**, **localhost** and **9080**.
    * If using a remote {{ site.data.keys.mf_server }} (on IBM Cloud), the values are typically **https**, **your-server-address** and **443**.
    * If using a Kubernetes cluster on IBM Cloud Private and if the deployment is of type **NodePort**, the value of the port would typically be the **NodePort** exposed by the service in Kubernetes cluster.

    Alternatively, if you have installed the {{ site.data.keys.mf_cli }}, then navigate to the project root folder and run the command `mfpdev app register`. If a remote {{ site.data.keys.mf_server }} is used, [run the command `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) to add the server, followed by for example: `mfpdev app register myIBMCloudServer`.

If a device is connected, the application will be installed and launched in the device,  
Otherwise the Simulator or Emulator will be used.

<br clear="all"/>
### Results
{: #results }
* Clicking the **Ping {{ site.data.keys.mf_server }}** button will display **Connected to {{ site.data.keys.mf_server }}**.
* If the application was able to connect to the {{ site.data.keys.mf_server }}, a resource request call using the deployed Java adapter will take place.

The adapter response is then displayed in an alert.

## Next steps
{: #next-steps }
Learn more on using adapters in applications, and how to integrate additional services such as Push Notifications, using the {{ site.data.keys.product_adj }} security framework and more:

- Review the [Application development](../../application-development/) tutorials
- Review the [Adapters development](../../adapters/) tutorials
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review the [Notifications tutorials](../../notifications/)
- Review [All Tutorials](../../all-tutorials)
