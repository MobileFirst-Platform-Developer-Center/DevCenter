---
layout: tutorial
title: JavaScript Client-side API Reference
breadcrumb_title: Client-side
show_disqus: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
> [Click to view](../../../api-ref/wl-client-js-apidoc/html/refjavascript-client/html/index.html) the full API reference for JavaScript applications.

The following table lists the functions that you can perform in Javascript applications, and the corresponding API method.

| Function | Description |
|----------|-------------|
| `WL.Client`, `WL.App` | Initializing and reloading an application, Globalizing application texts | 
| `WLAuthorizationManager` | Obtain client ID and authorization header |
| `WL.Badge` | Defining the application badge |
| `WL.Logger` | Printing log messages to the log for the environment |
| `WL.NativePage` | Switching the currently displayed, web-based screen with a natively written page |
| `WLResourceRequest` | Send requests to protected and unprotected resources | 
| `WL.JSONStore` | Client-side API providing a lightweight, document-oriented storage system | 

## Additional information
### The Options object
The `options` object contains properties that are common to all methods. It is used in all asynchronous calls to {{ site.data.keys.mf_server }}.

Sometimes it is augmented by properties that are only applicable to specific methods. These additional properties are detailed as part of the description of the specific methods.

The common properties of the options object are as follows:

```javascript
options = {
    onSuccess: successHandler(response),
    onFailure: failureHandlder(response),
    invocationContext: invocation-context
};
```

The meaning of each property is as follows:

| Property | Description |
|----------|-------------|
| `onSuccess` | Optional. The function to be invoked on successful completion of the asynchronous call. The syntax of the `onSuccess` function is: `success-handler-function(response)` where `response` is an object that contains at a minimum the following property: {::nomarkdown}<ul><li><b>invocationContext</b> - The <code>invocationContext</code> object that was originally passed to the {{ site.data.keys.mf_server }} in the <code>options</code> object, or <code>undefined</code> if no <code>invocationContext</code> object was passed.</li><li><b>status</b> - The HTTP response status</li></ul>{:/} **Note:** For methods for which the `response` object contains additional properties, these properties are detailed as part of the description of the specific method. |
| `onFailure` | Optional. The function to be invoked when the asynchronous call fails. Such failures include both server-side errors, and client-side errors that occurred during asynchronous calls, such as server connection failure or timed out calls. **Note:** The function is not called for client-side errors that stop the execution by throwing an exception. The syntax of the onFailure function is: `failure-handler-function(response)` where `response` is an object that contains the following properties: {::nomarkdown}<ul><li><b>invocationContext</b> - The <code>invocationContext</code> object that was originally passed to the {{ site.data.keys.mf_server }} in the <code>options</code> object, or <code>undefined</code> if no <code>invocationContext</code> object was passed.</li><li><b>errorCode</b> - An error code string. All error codes that can be returned are defined as constants in the <code>WL.ErrorCode</code> object in the <b>worklight.js</b> file.</li><li><b>errorMsg</b> - An error message that is provided by the {{ site.data.keys.mf_server }}. This message is for the developer's use only, and should not be displayed to the user. It will not be translated to the user's language.</li><li><b>status</b> - The HTTP response status</li></li>{:/} **Note:** For methods for which the `response` object contains additional properties, these properties are detailed as part of the description of the specific method. |
| `invocationContext` | Optional. An object that is returned to the success and failure handlers. The `invocationContext` object is used to preserve the context of the calling asynchronous service upon returning from the service. For example, the `invokeProcedure` method might be called successively, using the same success handler. The success handler needs to be able to identify which call to invokeProcedure is being handled. One solution is to implement the `invocationContext` object as an integer, and increment its value by one for each call of `invokeProcedure`. When it invokes the success handler, the {{ site.data.keys.product_adj }} framework passes to it the `invocationContext` object of the options object associated with the `invokeProcedure` method. The value of the `invocationContext` object can be used to identify the call to `invokeProcedure` with which the results that are being handled are associated. | 

## The WL.ClientMessages object
You can see a list of the system messages that are stored in the `WL.ClientMessages` object, and enable the translation of these system messages.

The `WL.ClientMessages` object is an object that stores the system messages that are defined in the **worklight/messages/messages.json** file. This file is in the environment folder of the projects that you generated with {{ site.data.keys.product }}. To enable the translation of a system message, you must override the value of this message in the `WL.ClientMessages` object, as indicated in the following code example:

```javascript
WL.ClientMessages.invalidUsernamePassword="The custom user name and password are not valid";
```

**Note:** You must override the system messages on a global JavaScript level because some parts of the code run only after the application successfully initialized.




