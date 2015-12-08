---
layout: tutorial
title: Resource Request from Native iOS Objective-C Applications
relevantTo: [ios]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresObjC
---
<span style = "color:red">RENAMING</span>

### Overview
MobileFirst applications can access resources using the `WLResourceRequest` REST API.  
The REST API works with all adapters and external resources <span style = "color:red"> LINK TO using-mobilefirst-server-authenticate-external-resources</span>.  
This tutorial explains how to use the `WLResourceRequest` API with an HTTP adapter.

<span style = "color:red">To create and configure an Android native project, first follow the <a href="../../configuring-the-mfpf-sdk/configuring-a-native-android-application-with-the-mfp-sdk/">Configuring a native Android application with the MobileFirst Platform SDK</a> tutorial.</span>

### Invoking an adapter procedure
Use the `WLResourceRequest` class to invoke adapter procedures or call any REST resources.

1. Define the URI of the resource:

    ```objc
    NSURL* url = [NSURL URLWithString:@"/adapters/RSSReader/getFeed"];
    ```
  * For JavaScript adapters, use `/adapters/{AdapterName}/{procedureName}`
  * For Java adapters, use `/adapters/{AdapterName}/{path}`
  * To access resources outside of the project, use the full URL

2. Create a `WLResourceRequest` object and choose the HTTP method (GET, POST, etc):

    ```objc
    WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
    ```
3. Add the required parameters:
  * In JavaScript adapters, which use ordered nameless parameters, pass an array of parameters with the name `params`:

        ```objc
        [request setQueryParameterValue:@"['MobileFirst_Platform']" forName:@"params"];
        ```
  * In Java adapters or external resources, use the `setQueryParameter` method for each parameter:

        ```objc
        [request setQueryParameterValue:@"value1" forName:@"param1"];
        [request setQueryParameterValue:@"value2" forName:@"param2"];
        ```
4. Trigger the request using the `sendWithCompletionHandler` method:

    ```objc
    [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
        NSString* resultText;
        if(error != nil){
            resultText = @"Invocation failure.";
            resultText = [resultText stringByAppendingString: error.description];
        }
        else{
            resultText = @"Invocation success.";
            resultText = [resultText stringByAppendingString:response.responseText];
        }
        [self updateView:resultText];
    }];
    ```
    Use the `response` and `error` objects to get the data that is retrieved from the adapter.  
    The `response` object contains the response data and you can use its methods and properties to retrieve the required information.
</br>
> There are other signatures for the `send` method, which are not covered in this tutorial. Those signatures enable you to set parameters in the body instead of the query, or to handle the response with a delegate instead of a completion handler. See the user documentation to learn more.

### Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProcedures) the MobileFirst project.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/InvokingAdapterProceduresObjC) the Native project.


* The `InvokingAdapterProcedures` project contains a **MobileFirst native API** which you can deploy to your MobileFirst Server instance and required to deploy to the server.
* The `InvokingAdapterProceduresObjC` project contains a **native iOS application** that uses a MobileFirst native API library to communicate with the MobileFirst Server instance.
* Make sure to update the `worklight.plist` file in **NativeiOSInvoking** with the relevant server settings.

<span style = "color:red">SCREENSHOT</span>
