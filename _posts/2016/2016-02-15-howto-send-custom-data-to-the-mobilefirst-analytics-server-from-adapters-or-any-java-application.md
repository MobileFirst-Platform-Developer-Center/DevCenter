---
title: 'HowTo: Send Custom Data to the MobileFirst Analytics Server from adapters or any java application'
date: 2016-02-15
tags:
- MobileFirst_Platform
- Analytics
version:
- 7.1
author:
  name: Yoel Nunez
---
## Overview
Sending custom data from your MobileFirst 7.1 apps to the Operational Analytics Server can be accomplished by using the <code>log</code> methods from the <code>WLAnalytics</code> and <code>WL.Analytics</code> objects in hybrid and native Android and iOS environments. However, sending custom data from MobileFirst Adapters, JavaScript or Java, is not supported. Hence, I decided to write some code to send custom data from any java application.


* [About This Library](#about-this-library)
* [GitHub Repository](#github-repository)
* [Usage in Java](#usage-in-java)
* [Usage in JavaScript Adapters](#usage-in-javascript-adapters)
* [Adapter based authentication sample](#adapter-based-authentication-sample)
* [Final Thoughts](#final-thoughts)

## About This Library
I decided to go with Gradle for building, testing, managing dependencies, and packaging my code in a jar. Since I'm building a jar, I can add it to the <code>server/lib</code> folder in my MobileFirst project to be able to use it with JavaScript adapters. On the other hand, if I want to use the jar with Java adapters, I just need to drop in the jar in the lib folder of the Java adapter.

The functionality of the API is very straight forward. First, I create a <code>ServerContext</code> object which contains information about the MobileFirst Operational Analytics server i.e., endpoint, username, and password. Second, I create an <code>AppContext</code> object which contains information about the application and device i.e., app name, app version, device id, os, os version, and model. Third, I get an instance of the <code>AnalyticsAPI</code> by passing the <code>AppContext</code>. Fourth, I log the data by passing a message string and a <code>JSONObject</code> with all the metadata. Finally, I call the <code>send</code> method from the <code>AnalyticsAPI</code> and that's all. Now, let's jump right into the code.

## GitHub Repository
[https://github.com/ynunez/MobileFirstAnalyticsSender](https://github.com/ynunez/MobileFirstAnalyticsSender)

## Usage in Java
At this point I'm assuming that you have built the library from the repository listed above and added the resulting jar to your project.

```java
import com.yoelnunez.mobilefirst.analytics.AnalyticsAPI;
import com.yoelnunez.mobilefirst.analytics.exceptions.MissingServerContextException;
import com.yoelnunez.mobilefirst.analytics.util.AppContext;
import com.yoelnunez.mobilefirst.analytics.util.ServerContext;
import org.json.JSONObject;

public class MyCustomApplication {
  public static void main(String[] args) {
    // should match the value of the `wl.analytics.url` jndi property in your server.xml file
    String analyticsEndpoint = "http://yoelnunez.com/analytics/v2"

    // IMPORTANT: setting the analytics server info
    AnalyticsAPI.setContext(new ServerContext(analyticsEndpoint, "myUsername", "myPassword"));

    try {

      // Attach some metadata to your logs, i.e., which app and device
      AppContext appContext = new AppContext();
      appContext.setAppName("CustomerApplication");
      appContext.setAppVersion("1.0");
      appContext.setDeviceID("my-device-id");
      appContext.setDeviceOS("Android");
      appContext.setDeviceOSVersion("6.0");
      appContext.setDeviceModel("Nexus 5X");

      // Analytics api instance
      AnalyticsAPI analytics = AnalyticsAPI.createInstance(appContext);


      JSONObject customer1 = new JSONObject();
      customer1.put("firstName", "Yoel");
      customer1.put("lastName", "Nunez");
      customer1.put("age", 25);

      // log custom data
      analytics.log("customer1", customer1);


      JSONObject customer2 = new JSONObject();
      customer2.put("firstName", "John");
      customer2.put("lastName", "Doe");
      customer2.put("age", 23);

      // log custom data
      analytics.log("customer2", customer2);


      // send data to analytics server
      AnalyticsAPI.send();

    } catch (MissingServerContextException e) {
      // analytics server endpoint details missing
    }
  }
}
```

## Usage in JavaScript Adapters
If you want to use the library in your JavaScript adapters, then you have to make sure you add the resulting jar to the server/lib folder in your MobileFirst project and then redeploy the newly generated war to your MobileFirst server.

```javascript
/**
 * Aliasing the Analytics API for easier usage.
 * For example, you can use:
 *    Analytics.Util.ServerContext
 * instead of 
 *    com.yoelnunez.mobilefirst.analytics.util.ServerContext
 */
var Analytics = {
	Util: com.yoelnunez.mobilefirst.analytics.util,
	API: com.yoelnunez.mobilefirst.analytics.AnalyticsAPI
};

/**
 * Get the Analytics Server information like endpoint, username,
 * and password form the JNDI configutation then set the server context
 */
(function() {
	var url = WL.Server.configuration['wl.analytics.url'],
		user = WL.Server.configuration['wl.analytics.username'],
		pass = WL.Server.configuration['wl.analytics.password'];
	
	var context = new Analytics.Util.ServerContext(url, user, pass);
	
	Analytics.API.setContext(context);
})();

/**
 * Logging custom data from procedure
 */
function adapterProcedureTest(firstName, lastName){
	var httpRequest = WL.Server.getClientRequest();

	var userIP = httpRequest.getRemoteAddr();
  
	var api = Analytics.API.createInstance(appContextFromRequest(httpRequest));

	var metadata = {
		userIP: httpRequest.getRemoteAddr(),
		fullName: firstName + " " + lastName
	};

	// in JS, we have to serialize the JSONObject and pass it as a string
	api.log("adapter-invocation", JSON.stringify(metadata));
  
	Analytics.API.send();
  
	return metadata;
}

/**
 * Creates an AppContext object from the request containing device and
 * application information i.e., app name, version, os, model, etc.
 * 
 * This is required to get an instance of the AnalyticsAPI
 * 
 * @param request
 * @returns {Analytics.Util.AppContext}
 */
function appContextFromRequest(request) {
	var context = new Analytics.Util.AppContext();

	// getting some metadata from request headers
	context.setAppName(request.getHeader('x-wl-clientlog-appname'));
	context.setAppVersion(request.getHeader('x-wl-clientlog-appversion'));
	context.setDeviceID(request.getHeader('x-wl-device-id'));
	context.setDeviceOS(request.getHeader('x-wl-clientlog-env'));
	context.setDeviceOSVersion(request.getHeader('x-wl-clientlog-osversion'));
	context.setDeviceModel(request.getHeader('x-wl-clientlog-model'));
	
	return context;
}
```

## Adapter based authentication sample
In this sample I'm logging the reason for the login failure, i.e., wrong password and user not found, and sending it over to the MobileFirst Analytics sever.

[https://github.com/ynunez/AdapterBasedAuthWithCustomAnalytics](https://github.com/ynunez/AdapterBasedAuthWithCustomAnalytics)

## Final Thoughts
Although sending custom data from adapters is not supported, by writing some code I am able to send custom data from JavaScript adapters, Java adapters, and from any other Java application. That custom data can later be visualized by creating some <strong>Custom Charts</strong> and can even be exported to use somewhere else. 
