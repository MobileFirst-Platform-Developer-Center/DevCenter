---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Web Applications
breadcrumb_title: Mobile Web
relevantTo: [web]
weight: 5
---
## Overview
In this tutorial you will learn how to register a web application with the MobileFirst Server, as well as download, add, initialize and update the MobileFirst SDK to web applications.  

The MobileFirst Cordova SDK is provided as a set of JavaScript plug-ins, [and is available at NPM](https://www.npmjs.com/package/ibm-mfp-web-core-sdk). The SDK is comprised of the following files:

- **ibmmfpf.js** - the core of the SDK.
- **ibmmfpfanalytics.js** - provides support for MobileFirst Platform Foundation Analytics.
- **webcrypto-shim.js** - Web Cryptography API shim for legacy browsers [https://github.com/vibornoff/webcrypto-shim](https://github.com/vibornoff/webcrypto-shim).

**Prerequisite:** to run NPM commands, [Node.js](https://nodejs.org) is required.

#### Jump to:

- [Registering the application](#registering-the-web-application)
- [Adding the MobileFirst Web SDK](#adding-the-mobilefirst-web-sdk)
- [Initializing the MobileFirst Web SDK](#initializing-the-mobilefirst-web-sdk)
- [Updating the MobileFirst Web SDK](#updating-the-mobilefirst-web-sdk)
- [Tutorials to follow next](#tutorials-to-follow-next)

### Registering the application
The application registration is performed from the MobileFirst Operations Console:    

1. Open your browser of choice and load the MobileFirst Operations Console using the address `http://localhost:9080/mfpconsole/`.
2. Click the "New" button next to "Applications" to create a new application and follow the on-screen instructions.  
3. Select **Web** as the platform, and provide a name and package ID. Then, click **Save**.

![Adding the Web platform](add-web-platform.png)

## Adding the MobileFirst Web SDK
To add the SDK, first download it to your workstation and then add it to your web application.

### Downloading the SDK
1. From a **command-line** window, navigate to your web application's root folder.
2. Run the command: `npm install ibm-mfp-web-core-sdk`.

This creates the following directory structure:

![SDK folder contents](sdk-folder.png)

### Adding the SDK
To add the SDK to your web application, reference the **ibmmfpf.js** file in the `HEAD` element.  
You can also use Module Loaders that [support AMD](https://en.wikipedia.org/wiki/Asynchronous_module_definition) such as [RequireJS](http://requirejs.org/) and others, to load the SDK.

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-core-sdk/ibmmfpf.js"></script>
</head>
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important:** If adding Analytics support or Web Cryptography support for legacy browsers, place the **ibmmfpfanalytics.js** and **webcrypto-shim.js** file references **before** the **ibmmfpf.js** file reference.

## Initializing the MobileFirst Web SDK
Initialize the MobileFirst Web SDK by specifying the **context root** and **application ID** values.  
In the main JavaScript file of your web application:

- **mfpContextRoot:** the context root used by the MobileFirst Server.
- **applicationId:** the application package name, as defined while [registering the application](#registering-the-web-application).

```javascript
var wlInitOptions = {
    mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development Kit
    applicationId : 'com.sample.mobilewebapp'
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Application logic.
});
```

## Updating the MobileFirst Web SDK
To update the MobileFirst Web SDK with the latest release: 

1. Navigate to the root folder of the web application 
2. Run the command: `npm update ibm-mfp-web-core-sdk`

SDK releases can be found in the SDK's [NPM repository](https://www.npmjs.com/package/ibm-mfp-web-core-sdk).

## Same Origin Policy
[Same Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) is a critical security mechanism for isolating potentially malicious documents.



## Tutorials to follow next
With the MobileFirst Cordova SDK now integrated, you can now:

- Review the [Using the MobileFirst Platform Foundation SDK tutorials](../../using-the-mfpf-sdk/)
- Review the [Adapters development tutorials](../../adapters/)
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review [All Tutorials](../../all-tutorials)
