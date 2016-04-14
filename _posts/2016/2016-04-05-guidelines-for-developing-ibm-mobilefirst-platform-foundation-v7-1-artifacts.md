---
title: Guidelines for developing IBM MobileFirst Platform Foundation V7.1 artifacts
date: 2016-04-5
tags:
- MobileFirst_Platform
- Migration
version:
- 7.1
author:
  name: Uri Segev
---
## Overview
As the world evolves towards standard development practices, so is IBM® and its MobileFirst™ Platform Foundation (“the product”). This document provides you with guidelines to consider when developing IBM MobileFirst Platform Foundation V7.1 artifacts. As this product moves towards more standard development practices, if you follow these guidelines, the migration of your artifacts developed with V7.1 to the future release of the product should be easier.

Note: IBM’s statements regarding its plans, directions, and intent are subject to change or withdrawal without notice at IBM’s sole discretion. Information regarding potential future products is intended to outline our general product direction and it should not be relied on in making a purchasing decision. The information mentioned regarding potential future products is not a commitment, promise, or legal obligation to deliver any material, code or functionality. Information about potential future products may not be incorporated into any contract. The development, release, and timing of any future features or functionality described for our products remains at our sole discretion.

## Development guidelines
### Adapters
IBM MobileFirst Platform Foundation V7.1 supports two types of adapters: Java™ adapters and JavaScript™ adapters.

#### Java adapters
In the 8.0 beta release, the security API has changed. By wrapping the calls to security APIs, you can restrict the impact of these changes to only your wrapper methods. For example, instead of writing the following code:

```java
api.getSecurityAPI().getSecurityContext().getUserIdentity().getId()
```

Consider writing the following code:

```java
public String getUserID(){
    return api.getSecurityAPI().getSecurityContext().getUserIdentity().getId();
}
```

And use `getUserID()` in all your resources that require the user ID.

#### JavaScript adapters

1. If you use security APIs, consider using wrappers, as for Java adapters.

2. MobileFirst Server V7.1 supports [both stateless and stateful modes of operations](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_overview_session_indep.html). The only method supported by MobileFirst Platform Foundation 8.0 beta is stateless, which allows for better scalability and availability.<br /><br />Because the state full mode is not supported in MobileFirst Platform Foundation 8.0 beta, you should avoid using the state full mode. If your application requires persisting information between invocations on the server side, consider using a back-end database, or a distributed cache system; and avoid using global variables to save data on the session. 

3. MobileFirst Platform Foundation 8.0 beta supports only HTTP and SQL JavaScript adapters. Use only these supported adapter types. Note that additional adapter types might be added after the beta of the future release of the product.

### Security
IBM MobileFirst Platform Foundation V7.1 supports two methods of authentication: [classic and OAuth](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/r_security_framework.html). JavaScript adapters are protected by using the classic authentication, and Java adapters are protected by using OAuth. As OAuth is the standard authorization mode, you should opt for using it over the classic method.

As a consequence, instead of JavaScript adapters, consider using Java adapters, as they are the only ones that support OAuth.

### Client applications

#### General
1.	Consider using `WLResourceRequest` API for sending client requests to the server that use the OAuth-based security and session independent mode. Avoid using the RPC APIs such as: `WLClient.connect()` or `WLClient.invokeProcedure()`. 

2.	For geolocation, use the APIs that are provided by the device operating systems or third-party solutions. Avoid using MobileFirst GeoLocation APIs as they will no longer be available in future releases.
	
#### Hybrid applications
1.	Develop pure Cordova apps by using the IBM MobileFirst Platform Command Line Interface (CLI). Avoid building legacy MobileFirst hybrid apps.

2.	Use the MobileFirst [JSONStore document storing system](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_jsonstore.html). Avoid using MobileFirst encrypted cache, which has fewer capabilities.

3.	Use Cordova available plug-ins for UI controls. Avoid using MobileFirst UI controls such as: BusyIndicator, OptionsMenu, TabBar, and SimpleDialog. 

4.	Use methods such as responsive design to adjust your app for multiple screen sizes. Avoid using MobileFirst skins, which is not standard.

5.	For minification and uglification of JavaScript code, use available packages such as [clean-css](https://www.npmjs.com/package/clean-css) or [uglify-js](https://www.npmjs.com/package/uglify-js). Avoid using the MobileFirst Studio plug-in features for minification and concatenation. 

#### Android applications
1.	Use Gradle to add the MobileFirst SDK for native Android apps to your app.

2.	Develop native Android apps by using the MobileFirst CLI and Android Studio.

3.	Android is dropping support for Apache HTTP Client, so avoid using the WLResourceRequest APIs that use Apache HTTP Client objects. Instead, use the following APIs:

```java
send(WLResponseListener listener);
send(String requestBody, WLResponseListener listener);
send(HashMap formParameters, WLResponseListener listener);
send(JSONObject json, WLResponseListener listener);
send(byte[] data, WLResponseListener listener);
```

#### iOS applications
1.	Use CocoaPods to add the MobileFirst SDK for native iOS apps to your app.

2.	When you use the MobileFirst application authenticity protection, disable the bitcode build flag. 

### Push notifications
1.	Use MobileFirst [tag-based push notifications](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_push_notif_tag_based.html). Avoid using event source-based push notifications.

2.	To send push notifications, use the Push Service [sendMessage REST API]( https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_push_notif_restapis.html). Avoid using the send notifications WL.Server APIs as part of your MobileFirst adapters.