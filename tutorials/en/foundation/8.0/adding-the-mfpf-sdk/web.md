---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to Web Applications
breadcrumb_title: Mobile Web
relevantTo: [web]
weight: 6
---
## Overview
In this tutorial you will learn how to register a web application with the MobileFirst Server, as well as downloading and adding the MobileFirst SDK to web applications.  

The MobileFirst Cordova SDK is provided as a set of JavaScript files, [and is available at NPM](https://www.npmjs.com/package/ibm-mfp-web-sdk).  
The SDK is comprised of the following files:

- **ibmmfpf.js** - the core of the SDK.
- **ibmmfpfanalytics.js** - provides support for MobileFirst Platform Foundation Analytics.
- **webcrypto-shim.js** - *optional*. Web Cryptography API shim for legacy browsers [https://github.com/vibornoff/webcrypto-shim](https://github.com/vibornoff/webcrypto-shim).

**Prerequisite:** to run NPM commands, [Node.js](https://nodejs.org) is required.

#### Jump to:

- [Registering the web application](#registering-the-web-application)
- [Adding the MobileFirst Web SDK](#adding-the-mobilefirst-web-sdk)
- [Initializing the MobileFirst Web SDK](#initializing-the-mobilefirst-web-sdk)
- [Updating the MobileFirst Web SDK](#updating-the-mobilefirst-web-sdk)
- [Same Origin Policy](#same-origin-policy)
- [Tutorials to follow next](#tutorials-to-follow-next)

### Registering the web application
The application registration is performed either from the MobileFirst Operations Console, or from the MobileFirst CLI.

#### From MobileFirst Operations Console

1. Open your browser of choice and load the MobileFirst Operations Console using the address `http://localhost:9080/mfpconsole/`.
2. Click the "New" button next to "Applications" to create a new application.
3. Select **Web** as the platform, and provide its name and its application identifier. Then, click **Save**.

![Adding the Web platform](add-web-platform.png)

#### From MobileFirst CLI

1. From a **command-line** window, navigate to the root folder of the web application.
2. Run the command: `mfpdev app register web com.sample.myapp`.
 - Replace "com.sample.myapp" with your application's identifier.

## Adding the MobileFirst Web SDK
To add the SDK to new or existing web applications, first download it to your workstation and then add it to your web application.

### Downloading the SDK
1. From a **command-line** window, navigate to your web application's root folder.
2. Run the command: `npm install ibm-mfp-web-sdk`.

This creates the following directory structure:

![SDK folder contents](sdk-folder.png)

### Adding the SDK
To add the MobileFirst Web SDK, reference it in standard fashion in the web application.  
The SDK also [supports AMD](https://en.wikipedia.org/wiki/Asynchronous_module_definition), so you can use Module Loaders such as [RequireJS](http://requirejs.org/) to load the SDK.

#### Standard
Reference the **ibmmfpf.js** file in the `HEAD` element.  

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

#### Using Require JS

**HTML**  

```html
<script type="text/javascript" src="node_modules/requirejs/require.js" data-main="index"></script>
```

**JavaScript**

```javascript
require.config({
	'paths': {
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['mfp'], function(WL) {
    // application logic.
});
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important:** If adding Analytics support or Web Cryptography support for legacy browsers, place the **ibmmfpfanalytics.js** and **webcrypto-shim.js** file references **before** the **ibmmfpf.js** file reference.

## Initializing the MobileFirst Web SDK
Initialize the MobileFirst Web SDK by specifying the **context root** and **application ID** values in the main JavaScript file of your web application:

```javascript
var wlInitOptions = {
    mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Developer Kit
    applicationId : 'com.sample.mobilewebapp'
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Application logic.
});
```

- **mfpContextRoot:** the context root used by the MobileFirst Server.
- **applicationId:** the application package name, as defined while [registering the application](#registering-the-web-application).

## Updating the MobileFirst Web SDK
SDK releases can be found in the SDK's [NPM repository](https://www.npmjs.com/package/ibm-mfp-web-sdk).  
To update the MobileFirst Web SDK with the latest release: 

1. Navigate to the root folder of the web application.
2. Run the command: `npm update ibm-mfp-web-sdk`.

## Same Origin Policy
Because web resources may be hosted on different a server machine than the one that MobileFirst Server is installed on, this may trigger a [Same Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) violation.

Same Origin Policy is a restriction embosed on web browsers. For example, if an application is hosted on the domain **example.com**, it is not allowed for the same application to also access contect that is available on another server, or for that matter, from the MobileFirst Server.

Web apps that are using the MobileFirst Web SDK should be handled in a supporting topology, for example by using a Reverse Proxy to internally redirect requests to the appropriate server while maintaining the same single origin.

> Learn more about the topic of Same Origin Policy in Web applications [in the user documentation](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/wl_welcome.html)

### Alternatives
During development, this restriction can be alleviated by:

- Serving the web application resources' from the same WebSphere Liberty profile application server that is used in the MobileFirst Developer Kit.
- Using Node.js as a proxy to redirect application requests to the MobileFirst Server.

> Learn more in [Setting up the Web development environmnt](../../setting-up-your-development-environment/web-development-environment) tutorial

## Tutorials to follow next
With the MobileFirst Web SDK now integrated, you can now:

- Review the [Using the MobileFirst Platform Foundation SDK tutorials](../../using-the-mfpf-sdk/)
- Review the [Adapters development tutorials](../../adapters/)
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review [All Tutorials](../../all-tutorials)
