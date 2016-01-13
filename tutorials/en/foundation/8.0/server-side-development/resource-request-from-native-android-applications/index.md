---
layout: tutorial
title: Resource Request from Native Android Applications
relevantTo: [android]
downloads:
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid
weight: 6
---
## Overview
MobileFirst applications can access resources using the `WLResourceRequest` REST API. The REST API works with all adapters and external resources.

This tutorial explains how to use the `WLResourceRequest` API with an HTTP adapter.

To create and configure an Android native project, first follow the [Adding the MobileFirst Platform Foundation SDK to Android Applications](../../adding-the-mfpf-sdk/adding-the-mfpf-sdk-to-android-applications) tutorial.

## WLResourceRequest
The `WLResourceRequest` class handles resource requests to adapters or external resources.

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

        ```js
        request.setQueryParameter("params","['param1', 'param2']");
        ```
  * In Java adapters or external resources, use the `setQueryParameter` method for each parameter:

        ```java
        request.setQueryParameter("param1","value1");
        request.setQueryParameter("param2","value2");
        ```
4. <span style="color:red">CHANGE according to the new sample</span>
Call the resource by using the `.send()` method.  
Specify a `MyInvokeListener` class instance:

    ```java
    request.send(new MyInvokeListener());
    ```

> See the user documentation to learn more about `WLResourceRequest` and other signatures for the `send` method, which are not covered in this tutorial.

## The response
<span style="color:red">CHANGE according to the new sample</span> When the resource call is completed, the framework calls one of the methods of the `MyInvokeListener` class.

1. <span style="color:red">CHANGE according to the new sample</span> Specify that the `MyInvokeListener` class implements the `WLResponseListener` interface:

    ```java
    public class MyInvokeListener implements WLResponseListener {
    }
    ```

2. Implement the `onSuccess` and `onFailure` methods.  
If the resource call is successful, the `onSuccess` method is called. Otherwise, the `onFailure` method is called.
Use these methods to get the data that is retrieved from the adapter.  
The `response` object contains the response data and you can use its methods and properties to retrieve the required information.

    ```java
    public void onSuccess(WLResponse response) {
          String responseText = response.getResponseText();
          AndroidNativeApp.updateTextView("Successfully called the resource\n" + responseText);
    }

    public void onFailure(WLFailResponse response) {
         String responseText = response.getResponseText();
         AndroidNativeApp.updateTextView("Failed to call the resource\n" + responseText);
    }
    ```

## Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/ResourceRequestAndroid) the Native project.

* The ResourceRequestAndroid project contains a native Android application that uses a MobileFirst native SDK to communicate with MobileFirst Server.
* Make sure to update the mfpclient.properties file in the native Android project with the required server settings.

<span style = "color:red">SCREENSHOT</span>
