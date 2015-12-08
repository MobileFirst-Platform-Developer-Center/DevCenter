---
layout: tutorial
title: Resource Request from Native Android Applications
relevantTo: [android]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresAndroid
---
<span style = "color:red">RENAMING</span>


### Overview
MobileFirst applications can access resources using the `WLResourceRequest` REST API.  
The REST API works with all adapters and external resources <span style = "color:red"> LINK TO using-mobilefirst-server-authenticate-external-resources</span>.  
This tutorial explains how to use the `WLResourceRequest` API with an HTTP adapter.

<span style = "color:red">To create and configure an Android native project, first follow the <a href="../../configuring-the-mfpf-sdk/configuring-a-native-android-application-with-the-mfp-sdk/">Configuring a native Android application with the MobileFirst Platform SDK</a> tutorial.</span>

### Initializing WLClient
<span style = "color:red">WLCLIENT.CONNECT</span>

1. Create an instance of the `WLClient` class.  
The `WLClient` instance requires a reference to the activity in which it is running.

    ```java
    WLClient client = WLClient.createInstance(context);
    ```

2. To establish a connection to the MobileFirst Server instance, use the `connect` method by specifying the `MyConnectListener` class instance as a parameter.  
The `WLClient` instance tries to connect to the MobileFirst Server according to the properties of the `mfpclient.properties` file.  
After the connection is established, it invokes one of the methods of the `MyConnectListener` class.
3. Specify that the `MyConnectListener` class implements the `WLResponseListener` interface.

    ```java
    public class MyConnectListener implements WLResponseListener  {
    }
    ```
The `WLResponseListener` interface defines two methods:
 * `public void onSuccess (WLResponse response) { }`
 * `public void onFailure (WLFailResponse response) { }`

    Use these methods to process connection success or connection failure.

### Invoking an adapter procedure
<span style = "color:red">After the connection is established with a MobileFirst Server instance</span>, you can use the `WLResourceRequest` method to invoke adapter procedures or to call any REST resources.

1. Define the URI of the resource:

    ```java
    URI adapterPath = new URI("/adapters/RSSReader/getFeed");
    ```
 * For JavaScript adapters, use `/adapters/{AdapterName}/{procedureName}`
 * For Java adapters, use `/adapters/{AdapterName}/{path}`
 * To access resources outside of the project, use the full URL

2. Create a `WLResourceRequest` object and choose the HTTP Method (GET, POST, etc):

    ```Java
    WLResourceRequest request = new WLResourceRequest(adapterPath,WLResourceRequest.GET);
    ```

3. Add the required parameters:
  * In JavaScript adapters, which use ordered nameless parameters, pass an array of parameters with the name `params`:

        ```java
        request.setQueryParameter("params","['MobileFirst_Platform']");
        ```
  * In Java adapters or external resources, use the `setQueryParameter` method for each parameter:

        ```java
        request.setQueryParameter("param1","value1");
        request.setQueryParameter("param2","value2");
        ```
4. Trigger the request using the `.send()` method.  
Specify a `MyInvokeListener` class instance as a parameter (will be further explained in the next section).

    ```java
    request.send(new MyInvokeListener());
    ```
</br>
> There are other signatures for the `send` method, which are not covered in this tutorial. Those signatures enable you to set parameters in the body instead of the query, or to handle the response with a delegate instead of a completion handler. See the user documentation to learn more.

### Receiving a procedure response
When the procedure invocation is completed, the framework calls one of the methods of the `MyInvokeListener` class.

1. Specify that the `MyInvokeListener` class implements the `WLResponseListener` interface:

    ```java
    public class MyInvokeListener implements WLResponseListener {
    }
    ```

2. Specify the `onSuccess` and `onFailure` methods.  
If the procedure invocation is successful, the `onSuccess` method is called. Otherwise, the `onFailure` method is called.
Use these methods to get the data that is retrieved from the adapter.  
The `response` object contains the response data, you can use its methods and properties to retrieve the required information.

    ```java
    public void onSuccess(WLResponse response) {
          String responseText = response.getResponseText();
          AndroidNativeApp.updateTextView("Adapter Procedure Invoked Successfuly\n" + responseText);
    }

    public void onFailure(WLFailResponse response) {
         String responseText = response.getResponseText();
         AndroidNativeApp.updateTextView("Failed to Invoke Adapter Procedure\n" + responseText);
    }
    ```

### Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures) the MobileFirst project.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresAndroid) the Native project.

* The `InvokingAdapterProcedures` project contains a MobileFirst Native API to deploy to your MobileFirst Server instance.
* The `InvokingAdapterProceduresAndroid` project contains a native Android application that uses a MobileFirst native API library to communicate with MobileFirst Server.
* Make sure to update the `mfpclient.properties` file in the native Android project with the required server settings.

<span style = "color:red">SCREENSHOT</span>
