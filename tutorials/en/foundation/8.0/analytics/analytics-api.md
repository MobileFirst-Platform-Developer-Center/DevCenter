---
title: Analytics API
relevantTo: [android,iOS, hybrid]
---

### Using the Analytics API for collecting Custom Analytics

Analytics API is part of three SDK's; Android, iOS, and cordova. When collecting analytics the app writes to the devices file system until the `send` API is called. After the `send` API is called the app deletes the data from the file system and begins collecting again.

## Cordova

Creating custom events in Cordova is simply just calling:
 ```javascript
WL.Analytics.log("Custom event", {"property" : 'value'});
WL.Analytics.send();
 ```
> **Note**: `WL.Analytics.send();` will send all collected data, even data collected by MobileFirst Platform Foundation. To disable collecting out of the box data you can call `WL.Analytics.disable();`.

## Android

To collect custom analytics in Android you need to import WLAnalytics.

```java
import com.worklight.common.WLAnalytics;
```
Make sure you set the Logger context with:

```java
WLAnalytics.setContext(this)
```

Without a context you will not be able to collect analytics data.

 After setting the first two configurations you can start to log data like in the example below.

 ```java
String json = "{\"property\" : \"value\"}";
try {
   WLAnalytics.log("Custom event", new JSONObject(json));
} catch (JSONException e) {
   e.printStackTrace();
}
```

Be sure to send your data with:
```java
WLAnalytics.send();
```
> **Note**: `WLAnalytics.send();` will send all collected data, even data collected by MobileFirst Platform Foundation. To disable collecting out of the box data you can call `WLAnalytics.disable();`.

## iOS (Objective-C)

To collect custom analytics in iOS you need to import WLAnalytics.
```objective-c
#import "WLAnalytics.h";
```

After importing WLAnalytics you can now use the API to collect custom data like below:

```objective-c
NSDictionary *inventory = @{
    @"property" : @"value",
};
[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

> **Note**: `[[WLAnalytics sharedInstance] send];` will send all collected data, even data collected by MobileFirst Platform Foundation. To disable collecting out of the box data you can call `[[WLAnalytics sharedInstance] disable]`.
