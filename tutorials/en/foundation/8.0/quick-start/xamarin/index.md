---
layout: tutorial
title: Xamarin end-to-end demonstration
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The purpose of this demonstration is to experience an end-to-end flow:

1. A sample application that is bundled with the {{ site.data.keys.product_adj }} Xamarin client SDK is registered with the {{ site.data.keys.mf_console }}.
2. A new or provided adapter is deployed to the {{ site.data.keys.mf_console }}.  
3. The application logic is changed to make a resource request.

**End result**:

* Successfully pinging the {{ site.data.keys.mf_server }}.

#### Prerequisites:
{: #prerequisites }
* Xamarin Studio
* *Optional*. Stand-alone {{ site.data.keys.mf_server }} ([download]({{site.baseurl}}/downloads))

### 1. Starting the {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Make sure you have [created a Mobile Foundation instance](../../bluemix/using-mobile-foundation), or  
If using the [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/), navigate to the server's folder and run the command: `./run.sh` in Mac and Linux or `run.cmd` in Windows.

### 2. Creating an application
{: #2-creating-an-application }
In a browser window, open the {{ site.data.keys.mf_console }} by loading the URL: `http://your-server-host:server-port/mfpconsole`. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.

1. Click the **New** button next to **Applications**
    * Select the **Android** platform
    * Enter **com.ibm.mfpstarterxamarin** as the **application identifier** (depending on the application scaffold you will download in the next step)
    * Enter **1.0** as the **version** value
    * Click on **Register application**

    <img class="gifplayer" alt="Register an application" src="register-an-application-xamarin.gif"/>

### 3. Editing application logic
{: #3-editing-application-logic }
* Create a Xamarin project.
* Add the Xamarin SDK as mentioned in the [Adding the SDK](../../application-development/sdk/xamarin/) tutorial.
* Add a property of type `IWorklightClient` in any class file as below.

   ```csharp
   /// <summary>
   /// Gets or sets the worklight sample client.
   /// </summary>
   /// <value>The worklight client.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* If you're devleoping for iOS, paste the following code inside **FinishedLaunching** method of the **AppDelegate.cs** file:

  ```csharp
   {ClassName}.WorklightClient = WorklightClient.CreateInstance();
  ```
* If you're devleoping for Android, include the following line of code inside **OnCreate** method of the **MainActivity.cs** file:

  ```csharp
   {ClassName}.WorklightClient = WorklightClient.CreateInstance(this);
  ```
* Define a method to obtain the access token and perform a resource request to the MFP Server as below.
   
    ```csharp
    public async void ObtainToken()
           { 
            try
                   {
       
                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
       
                       if (accessToken.Value != null && accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");
       
                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();
       
                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```
  
* Invoke **ObtainToken** method within a class constructor or on click of a button.

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

<!-- <img src="device-screen.png" alt="sample app" style="float:right"/>-->
### 5. Testing the application
{: #5-testing-the-application }
1. In Xamarin Studio, select the **mfpclient.plist** file and edit the **protocol**, **host** and **port** properties with the correct values for your {{ site.data.keys.mf_server }}.
    * If using a local {{ site.data.keys.mf_server }}, the values are typically **http**, **localhost** and **9080**.
    * If using a remote {{ site.data.keys.mf_server }} (on Bluemix), the values are typically **https**, **your-server-address** and **443**.

2. Press the **Play** button.

<br clear="all"/>
### Results
{: #results }
* Clicking the **Ping MobileFirst Server** button will display **Connected to MobileFirst Server**.
* If the application was able to connect to the {{ site.data.keys.mf_server }}, a resource request call using the deployed Java adapter will take place.

The adapter response is then printed in the Xamarin Studio Console.

![Image of application that successfully called a resource from the {{ site.data.keys.mf_server }}](console-output.png)

## Next steps
{: #next-steps }
Learn more on using adapters in applications, and how to integrate additional services such as Push Notifications, using the {{ site.data.keys.product_adj }} security framework and more:

- Review the [Adapters development](../../adapters/) tutorials
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review [All Tutorials](../../all-tutorials)
