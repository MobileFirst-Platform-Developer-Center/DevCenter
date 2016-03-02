---
layout: tutorial
title: Using Analytics API in client applications
breadcrumb_title: Analytics API
relevantTo: [ios,android,windows,cordova]
weight: 3
---
## Overview
MobileFirst Platform Foundation Operational Analytics provides APIs to help the developer with collecting Analytics.  
Cordova applications start collecting analytics data out-of-the-box. However, for native platforms, iOS and Android, there is some instrumentation that the developer has to implement. 

#### Jump to:
* [Configuring Analytics on the Client Side](#configuring-analytics-on-the-client-side)
* [Enabling/Disabling Client Events](#Enabling/Disabling-client-event-types)
* [Custom Events](#custom-events)
 * [JavaScript API](#javascript-api)
 * [Java API](#java-api)
 * [Objective-C API](#objective-c-api)
* [Sending Analytics to the MFP Analytics Server](#sending-analytics-to-the-mfp-analytics-server)

## Configuring Analytics on the Client Side
Before you can start collecting the out-of-the-box data that Operational Analytics provides, you first need to import the corresponding libraries and initialize analytics API.  
### Android
#### Import Library
```java
import com.worklight.common.WLAnalytics;
```

#### Initialize Analytics
Inside the `onCreate` method of your main activity include:

```java
WLAnalytics.init(this.getApplication());
```

### iOS
#### Import Library

```objective-c
import "WLAnalytics.h"
```

#### Initialize Analytics
No initialization is needed for analytics on iOS.

## Sending Analytics
Sending Analytics is a crucial step to see client side analytics in the Analytics Console. When collecting Analytics, the analytics logs are stored in a log file on the client device which is sent to the analytics server after using the `send` method of the Analytics API.

#### JavaScript
```javascript
WL.Analytics.send();
```

#### Android

```java
WLAnalytics.send();
```

#### Objective-C
```objc
[[WLAnalytics sharedInstance] send];
```

## Enabling/Disabling Client Event Types
The Analytics API gives the developer the freedom to enable and disable collecting Analytics on the event they want to visualize on their analytics console. 

### Client Lifecycle Events
After configuring the Analytics SDK, app sessions will start to be recorded on the user's device. A session in MobileFirst Operational Analytics is recorded when the app is moved from the foreground then to the background, which creates a session on the analytics console.

As soon as the device is set up to record sessions and you send your data, you will see the analytics console populated with data like below.

![sessions-chart](analytics-app-sessions.png)

You can enable or disable the collecting of app sessions with the API below:

#### Android:
```java
//DeviceEvent.LIFECYCLE records app sessions
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE); 
```

#### Objective-C:
```objective-c
//DeviceEvent.LIFECYCLE records app sessions
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

### Client Network Activities
Collection on adapters and the network occur in two different locations - on the client and on the server.

* The client will collect information such as roundtrip time and payload size when you start collecting on the device event `Network`.
* The server will collect  backend information such as server processing time, adapter usage, procedures.

### To enable network events on the client:

#### Android:
```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

#### Objective-C:
```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

### To disable network events on the client:

#### Android:
```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

#### Objective-C:
```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

## Custom Events

#### JavaScript API
To create custom events in Cordova applications:

```javascript
WL.Analytics.log({"key" : 'value'});
WL.Analytics.send();
```

#### Android API
After setting the first two configurations you can start to log data:

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
WLAnalytics.send();
```

#### Objective-C API
After importing `WLAnalytics` you can now use the API to collect custom data:

```objective-c
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```
