---
layout: tutorial
title: Resource Request from Native iOS Swift Applications
relevantTo: [ios]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresSwift
---

### Overview
MobileFirst applications can access resources using the `WLResourceRequest` REST API.  
The REST API works with all adapters and external resources <span style = "color:red"> LINK TO using-mobilefirst-server-authenticate-external-resources</span>.  
This tutorial explains how to use the `WLResourceRequest` API with an HTTP adapter.

<span style = "color:red">To create and configure an iOS native project, first follow the “<a href="../" title="Configuring a native iOS application with the MobileFirst Platform SDK">Configuring a native iOS application with the MobileFirst Platform SDK</a>” tutorial.
If you are developing Swift-based applications, make sure that you follow the additional steps.</span>

### Calling an adapter procedure
The `WLResourceRequest` class handles resource requests to MobileFirst adapters or external resources.

1. To call a procedure, create a `WLResourceRequest` object and specify the path to the adapter and the HTTP method(GET, POST, etc):

    ```swift
    let request = WLResourceRequest(URL: NSURL(string: "/adapters/RSSReader/getFeed"), method: WLHttpMethodGet)
    ```
  * For JavaScript adapters, use `/adapters/{AdapterName}/{procedureName}`
  * For Java adapters, use `/adapters/{AdapterName}/{path}`
  * To access resources outside of the project, use the full URL    

3. Add the required parameters:
  * In JavaScript adapters, which use ordered nameless parameters, pass an array of parameters with the name `params`:

        ```swift
        request.setQueryParameterValue("['MobileFirst_Platform']", forName: "params")
        ```
  * In Java adapters or external resources, use the `setQueryParameter` method for each parameter:

        ```swift
        request.setQueryParameterValue("value1", forName: "param1")
        request.setQueryParameterValue("value2", forName: "param2")
        ```
4. Call the procedure by using the `sendWithCompletionHandler` method.  
Supply a completion handler to manage the retrieved data:

    ```swift
    request.sendWithCompletionHandler { (WLResponse response, NSError error) -> Void in
        var resultText = ""
        if(error != nil){
            resultText = "Invocation failure. "
            resultText += error.description
        }
        else if(response != nil){
            resultText = "Invocation success. "
            resultText += response.responseText
        }
        self.updateView(resultText)
    }
    ```
    Use the `response` and `error` objects to get the data that is retrieved from the adapter.  
    The `response` object contains the response data and you can use its methods and properties to retrieve the required information.

</br>
> There are also other signatures for the `send` method, which are not covered in this tutorial. Those signatures enable you to set parameters in the body instead of the query and provide more granular management of the retrieved data (such as non-text responses, PDF, etc). You can use the `sendWithDelegate` method and provide a delegate that conforms to both the `NSURLConnectionDataDelegate` and `NSURLConnectionDelegate` protocols.  
See the user documentation to learn more about `WLResourceRequest`.

### Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures) the MobileFirst project.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresSwift) the Native project.

* The `InvokingAdapterProcedures` project contains a **MobileFirst native API** that you can deploy to your MobileFirst Server instance.
* The `InvokingAdapterProceduresSwift` project contains a **native iOS Swift application** that uses a MobileFirst native API library to communicate with the MobileFirst Server instance.
* Make sure to update the `mfpclient.plist` file in **NativeiOSInvoking** with the relevant server settings.

<span style = "color:red">SCREENSHOT</span>
