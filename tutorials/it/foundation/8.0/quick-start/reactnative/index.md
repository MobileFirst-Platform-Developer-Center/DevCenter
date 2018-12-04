---
layout: tutorial
title: React Native end-to-end demonstration
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The purpose of this demonstration is to explain an end-to-end flow:

1. A sample application that is pre-bundled with the {{ site.data.keys.product_adj }} client SDK is registered and downloaded from the {{ site.data.keys.mf_console }}.
2. A new or provided adapter is deployed to the {{ site.data.keys.mf_console }}.  
3. The application logic is changed to make a resource request.

**End result**:

* Successfully ping the {{ site.data.keys.mf_server }}.
* Successfully retrieve data using an adapter.

### Prerequisites:
{: #prerequisites }
* Xcode for iOS, Android Studio for Android
* React Native CLI
* *Optional*. {{ site.data.keys.mf_cli }} ([download]({{site.baseurl}}/downloads))
* *Optional*. Stand-alone {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### Step 1. Starting the {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Make sure you have [created a Mobile Foundation instance](../../bluemix/using-mobile-foundation), or if you are using the [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), navigate to the server's folder and run the command: `./run.sh` in Mac and Linux or `run.cmd` in Windows.

### Step 2. Creating and registering an application
{: #2-creating-and-registering-an-application }
Open the {{ site.data.keys.mf_console }} by loading the URL: `http://your-server-host:server-port/mfpconsole` in the browser. If the server is running locally, use  `http://localhost:9080/mfpconsole`. The *username/password* is **admin/admin**.

1. Click the **New** button next to **Applications**
    * Select a platform: **Android, iOS**
    * Enter **com.ibm.mfpstarter.reactnative** as the **application identifier**
    * Enter **1.0.0** as the **version**
    * Click on **Register application**

    <img class="gifplayer" alt="Register an application" src="register-an-application-reactnative.png"/>

2. Download the React Native sample application from [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative).

### Step 3. Editing application logic
{: #3-editing-application-logic }
1. Open the React native project in your code editor of choice.

2. Select the **app.js** file, which is located at project's root folder and paste the following code snippet, replacing the existing `WLAuthorizationManager.obtainAccessToken()` function:

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
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
        alert("Failed to connect to MobileFirst Server");
      });
```

### Step 4. Deploy an adapter
{: #4-deploy-an-adapter }
Download the [.adapter artifact](../javaAdapter.adapter) and deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action.

Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the *Hello World* **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="sample application" style="float:right"/>

### Step 5. Testing the application
{: #5-testing-the-application }
1.  Make sure that you have installed the {{ site.data.keys.mf_cli }}, then navigate to the particular platform's (iOS or Android) root folder and run the command `mfpdev app register`. If a remote {{ site.data.keys.mf_server }} is used, [run the command](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) to add the server,
```bash
mfpdev server add
```
followed by the command to register the app, for example:
```bash
mfpdev app register myIBMCloudServer
```
2. Run the following command, to run the application:
```bash
react-native run-ios|run-android
```

If a device is connected, the application will be installed and launched in the device. Otherwise, the simulator or emulator will be used.

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
