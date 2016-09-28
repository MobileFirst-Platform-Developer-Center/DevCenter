---
layout: tutorial
title: Migrating existing Cordova and hybrid applications
breadcrumb_title: Cordova and hybrid
weight: 1
---
## Overview
To migrate an existing Cordova or hybrid application that was created with IBM MobileFirst Foundation version 6.2.0 or later, you must create a Cordova project that uses the plug-ins from the current version. Then you replace the client-side APIs that are discontinued or not in v8.0. The migration assistance tool can help you in this task.

#### Jump to
* [Comparison of Cordova apps developed with v8.0 versus v7.1 and before](#comparison-of-cordova-apps-developed-with-v8-0-versus-v7-1-and-before)
* [Migrating existing hybrid or cross-platform apps to Cordova apps supported by MobileFirst Foundation 8.0](#migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-8-0)
* [Migrating encryption for iOS Cordova](#migrating-encryption-for-ios-cordova)
* [Migrating Direct Update](#migrating-direct-update)
* [Upgrading the WebView](#upgrading-the-webview)
* [Removed components](#removed-components)

## Comparison of Cordova apps developed with v8.0 versus v7.1 and before
Compare Cordova apps developed with IBM MobileFirst Foundation v8.0 and Cordova and hybrid apps developed with IBM MobileFirst Platform Foundation v7.1.

| Feature | Cordova app with IBM<br/>MobileFirst Foundation v8.0 |	Cordova app with IBM<br/>MobileFirst Platform Foundation v7.1 | MobileFirst hybrid app with IBM<br/>MobileFirst Platform Foundation V7.1 | 
|---------|-------|---------|-------|------|
| **IDE Eclipse Studio** | | | | |	 	 	 
| Eclipse plug-in and integration | Yes | Unsupported | Yes (Proprietary) | 
| Application Components | Yes (Cordova)<br/><br/>Note: Create your own Cordova plug-ins to manage application components in your organization. | Yes (Cordova)<br/><br/>Note: Create your own Cordova plug-ins to manage application components in your organization. | Yes (Proprietary) | 
| Project Templates | Yes (Cordova)<br/><br/>Note: Use the Apache Cordova `cordova create --template` command. | Yes (Cordova)<br/><br/>Note: Use `mfp cordova create --template` or the Apache Cordova command `cordova create --copy-from` | Yes (Proprietary) | 
| Dojo and jQuery IDE instrumentation | Yes<br/><br/>Note: Dojo and jQuery Mobile are JavaScript frameworks that you can use in Cordova apps. | Yes<br/><br/>Note: Dojo and jQuery Mobile are JavaScript frameworks that you can use in Cordova apps. | Yes | 
| Mobile UI Patterns | Unsupported | Unsupported | Deprecated |
| **Application sub types** | | | 
| Shell Component | Unsupported<br/><br/>Note: If the previous Hybrid app used shells and inner applications, it is recommended to adopt Cordova design patterns and implement the shell components as Cordova plug-ins, that can be shared across applications. | Unsupported | Yes | 
| Inner Hybrid Application | Unsupported<br/><br/>Note: If the previous Hybrid app used shells and inner applications, it is recommended to adopt Cordova design patterns and implement the shell components as Cordova plug-ins, that can be shared across applications. | Unsupported | Yes | 
| **Application Features** | | | 	 	 	 
| 


## Migrating existing hybrid or cross-platform apps to Cordova apps supported by MobileFirst Foundation 8.0
## Migrating encryption for iOS Cordova
If your iOS Hybrid or Cordova application used OpenSSL encryption, you may want to migrate your app to the new V8.0.0 native encryption. If you want to continue using OpenSSL you need to add an additional Cordova plug-in.

For more information on the iOS Cordova encryption options for migration see the [Migration options](../../application-development/sdk/cordova/additional-information/#migration-options) section within the [Enabling OpenSSL in Cordova Applications](../../application-development/sdk/cordova/additional-information/#enabling-openssl-in-cordova-applications) topic.

## Migrating Direct Update
Direct Update is triggered after the first access to a protected resource. The process to deploy new web resources has changed in v8.0.

Unlike in previous versions, in v8.0, if an application does not access a secure MobileFirst resource, the client application does not receive updates, even if updates are available on the server. A resource might be unprotected, for example because OAuth has been disabled by the annotation `@OAuth(security=false)` or by configuration. You can work around this risk in one of the following ways:

* Explicitly obtain an access token. See the `obtainAccessToken` API in the [`WLAuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc) class.
* Call another protected resource. See the [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html?view=kc) class.

To use Direct Update: Starting with v8.0, you no longer upload a **.wlapp** file to MobileFirst Server. Instead, you upload a smaller web resource archive (.zip file). The archive file no longer contains the web preview files or skins that were widely used in previous versions. These have been discontinued. The archive contains only the web resources that are sent to the clients, as well as checksums for Direct Update validations.

> For more information, see the [Direct Update documentation](../../application-development/direct-update).

## Upgrading the WebView
## Removed components
The Cordova project created by MobileFirst Platform Foundation Studio 7.1 included many resources that supported propriety functionality. However in v8.0 only pure Cordova is supported and the MobileFirst API no longer supports these features.

### Skins
MobileFirst application skins provided a way of optimizing the UI for adapting to different devices and formats and is no longer supported in v8.0.  
To replace this type of functionality it is recommended to adopt responsive web design methods provided by Cordova and HTML 5.

### Shells
**Shells** allowed the development of a set of functionalities to be used by and shared among applications. In this way developers who were more experienced with the native environment could provide a set of core functions. These shells were bundled into **inner applications** and used by developers who are involved with business logic or UI development.

If the previous hybrid app used shells and inner applications, it is recommended to adopt Cordova design patterns and implement the shell components as Cordova plug-ins, that can be shared across applications. Developers may find ways to reuse parts of shell code and migrate them to Cordova plug-ins.

For example, if a customer has a set of web resources (JavaScript, css files, graphics, html) that are common across all their apps they can create a Cordova plug-in that copies these resources into the app's www folder.

Let's say these resources are within the src/www/acme/ folder:

* src/www/acme/js/acme.js
* src/www/acme/css/acme.css
* src/www/acme/img/acme-logo.png
* src/www/acme/html/banner.html
* src/www/acme/html/footer.html
* plugin.xml

The **plugin.xml** file contains the `<asset>` tag, containing the source and target for copying the resources:

```xml
<?xml version="1.0" encoding="UTF-8"?> 
<plugin 
     xmlns="http://apache.org/cordova/ns/plugins/1.0"     
     xmlns:rim="http://www.blackberry.com/ns/widgets" 
     xmlns:android="http://schemas.android.com/apk/res/android" 
     id="cordova-plugin-acme" 
     version="1.0.1"> 
<name>ACME Company Shell Component</name> 
<description>ACME Company Shell Component</description> 
<license>MIT</license> 
<keywords>cordova,acme,shell,components</keywords> 
<issue>https://www.acme.com/support</issue> 
<asset src="src/www/acme" target="www/acme"/> 
</plugin> 
```

After the **plugin.xml** is added to the Cordova **config.xml** file, the resources listed in the asset src are copied to the asset target during compilation.  
Then in their **index.html** file or anywhere inside their app they can reuse these resources.

```html
<link rel="stylesheet" type="text/css" href="acme/css/acme.css">
<script type="text/javascript" src="acme/js/acme.js"></script>
<div id="banner"></div>
<div id="app"></div>
<div id="footer"></div>
<script type="text/javascript"> 
    $("#banner").load("acme/html/banner.html"); 
    $("#footer").load("acme/html/footer.html"); 
</script> 
```

### Settings page
The **settings page** was a UI available in the MobileFirst hybrid app that allowed the developer to change the server URL at runtime for testing purposes. The developer can now use existing MobileFirst Client API to change the server URL at runtime. For more information, see [WL.App.setServerUrl](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html?lang=en-us&cp=SSHS8R_8.0.0&view=kc#setServerUrl).

### Minification
MobileFirst Studio 7.1 provided an OOTB method of reducing the size of your JavaScript code by removing all unnecessary characters before compilation. This removed functionality can be replaced by adding Cordova hooks to your project.

Many hooks are available for minifying your Javascript and css files and can be placed in the config.xml at the before_prepare event.

Here are some recommended hooks:

* [https://www.npmjs.com/package/uglify-js](https://www.npmjs.com/package/uglify-js)
* [https://www.npmjs.com/package/clean-css](https://www.npmjs.com/package/clean-css)

These hooks can be defined in either a plug-in file or in the app's config.xml file, using the `<hook>` elements.  
In this example, using the before_prepare hook event, a script is run for minifying before cordova prepare copies the files to each platform's www/ folder:

```html
<hook type="before_prepare" src="scripts/uglify.js" />
```





