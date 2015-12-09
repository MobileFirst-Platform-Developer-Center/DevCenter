---
layout: tutorial
title: Working offline
relevantTo: [cordova]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/WorkingOffline
---

## Working in offline mode
By using IBM MobileFirst Platform Foundation, it is possible to detect application connectivity failures and determine a course of action.  
Application going offline and online can be detected in two ways:

* Explicitly, when requesting a resource.
* Implicitly, by using JavaScript event listeners.

It is possible to define custom application behaviors for offline and online status.  
The developer is responsible for maintaining the offline or online state within the application, and ensuring that the application can recover from failed attempts to connect to the server.  
For example, before the application logs in a new user or accesses the server under a new user, the application must ensure that a successful logout was received by the server.  

This tutorial covers the following topics:

* [Active detection](#active-detection)
* [Passive detection](#passive-detection)
* [Additional methods](#additional-methods)
* [Heartbeat](#heartbeat)
* [Sample application](#sample-application)

## Active detection
### By using methods
Connectivity loss can be detected in two locations in the application code:

* Application initialization – In the `WL.Client.init()` method.
* Resource Request – When using `WLResourceRequest`.

To add connectivity failure detection in either location, add the `onConnectionFailure` property and specify a callback function to invoke if connectivity fails.

###By using JavaScript
#### initOptions.js

```javascript
var wlInitOptions = {
  onConnectionFailure: function (data){
    connectionFailure(data);
}
```

#### Implementation JS file

``` javascript
var resourceRequest = new WLResourceRequest(
  "/adapters/RSSReader/getFeed",
  WLResourceRequest.GET
);

resourceRequest.send().then(
    onConnectionSuccess,
    onConnectionFailure
);
```

## Passive detection
### Offline and online events
Each time the MobileFirst framework attempts to access MobileFirst Server, it might detect that the application switched from offline to online status or conversely.  
In both cases, JavaScript events are fired:

* The `WL.Events.WORKLIGHT_IS_DISCONNECTED` event is fired when connectivity to MobileFirst Server fails.
* The `WL.Events.WORKLIGHT_IS_CONNECTED` event is fired when connectivity to MobileFirst Server is restored.

The developer can also add event listeners to the above events and specify the callback functions to handle them.

```javascript
document.addEventListener(WL.Events.WORKLIGHT_IS_CONNECTED, connectDetected, false);
document.addEventListener(WL.Events.WORKLIGHT_IS_DISCONNECTED, disconnectDetected, false);
```

**Note:** `WL.Events.WORKLIGHT_IS_DISCONNECTED` and `WL.Events.WORKLIGHT_IS_CONNECTED` are namespace constants, not strings.

## Additional methods
More methods are provided by the MobileFirst framework to simplify online and offline development:

* `WL.Client.connect (options)` – Attempts to establish a connection to MobileFirst Server and to return to online mode. `options` is an object that contains the following keys:
  * `onSuccess` – Callback function to invoke when the server connection is established.
  * `onFailure` – Callback function to invoke when the server connection fails.
  * `timeout` – The number of milliseconds to wait for the server response before failing with request timeout.

* `WL.Device.getNetworkInfo()` - This method is available for the Android and iOS environments.
    A callback must be specified as a function parameter. The callback receives an object with the following properties:
  * `isAirplaneMode` – true/false
  * `carrierName` – string. For example, `AT&T` or `VERIZON`.
  * `telephonyNetworkType` – string. For example, `UMTS` or `GPRS`.
  * `isRoaming` – true/false
  * `networkConnectionType` – mobile/WiFi
  * `ipAddress` – string
  * `isNetworkConnected` – true/false

## Heartbeat
The heartbeat pings the server at specified intervals to verify connectivity.
You can use the heartbeat to periodically make sure that the application remains connected to the server.
Both the `WL.Events.WORKLIGHT_IS_CONNECTED` and `WL.Events.WORKLIGHT_IS_DISCONNECTED` events can be fired by the heartbeat in designated cases.
A developer can specify the heartbeat interval by using the `WL.Client.setHeartBeatInterval(intervalSeconds)` API method.
The following sample shows an offline and online detection mechanism.

```javascript
document.addEventListener(WL.Events.WORKLIGHT_IS_DISCONNECTED, MyApp.connectionFailure, false);
MyApp.connectionFailure = function() {
WL.Client.connect({
onSuccess: function() {
WL.Logger.debug(&quot;online&quot;);
MyApp.onlineRestored();
},
onFailure: function() {
WL.Logger.debug(&quot;Still offline... Trying to connect again in 5
seconds.&quot;);
window.setTimeout(MyApp.connectionFailure, 5000);
}
});
};
```

[code lang="js" highlight="2,4,6,12"]document.addEventListener(WL.Events.WORKLIGHT_IS_DISCONNECTED,
MyApp.connectionFailure, false);
MyApp.connectionFailure = function() {
    WL.Client.connect({
        onSuccess: function() {
            WL.Logger.debug(&quot;online&quot;);
            MyApp.onlineRestored();
        },
        onFailure: function() {
            WL.Logger.debug(&quot;Still offline... Trying to connect again in 5
            seconds.&quot;);
            window.setTimeout(MyApp.connectionFailure, 5000);
        }
    });
};[/code]
<ol>
<li>An event listener for a `WL.Events.WORKLIGHT_IS_DISCONNECTED` event is added to the document. `MyApp.connectionFailure()` is invoked when the event fires.</li>
<li>`WL.Client.connect()` tries to establish a server connection.</li>
<li>If the connection is successfully established, `MyApp.onlineRestored()` is invoked.</li>
<li>If the connection fails, a timeout is set for 5 seconds to invoke `MyApp.connectionFailure()` again.</li>
</ol>
## Sample application
<a href="https://github.com/MobileFirst-Platform-Developer-Center/WorkingOffline" target="_blank">Click to download</a> the MobileFirst project.
<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/12/06_01_sample.png"><img src="{{ site.baseurl }}/assets/backup/06_01_sample.png" alt="06_01_sample" width="320" height="590" class="aligncenter size-full wp-image-9839" /></a>
