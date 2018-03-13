---
layout: tutorial
title: Logging in JavaScript (Cordova, Web) Applications
breadcrumb_title: Logging in JavaScript
relevantTo: [javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
This tutorial provides the required code snippets in order to add logging capabilities in JavaScript (Cordova, Web) applications.

**Prerequisite:** Make sure to read the [overview of client-side log collection](../).

## Enabling log capture
{: #enabling-log-capture }
By default, log capture is enabled. Log capture saves logs to the client and can be enabled or disabled programmatically. Logs are sent to the server with an explicit send call, or with auto log

> **Note:** Enabling log capture at verbose levels can impact the consumption of the device CPU, file system space, and the size of the payload when the client sends logs over the network.

To disable log capturing:

### Cordova
{: #cordova }
```javascript
WL.Logger.config({capture: false});
```

### Web
{: #web }
```javascript
ibmmfpfanalytics.logger.enable(false);
```

## Sending captured logs
{: #sending-captured-logs }
Send logs to the {{ site.data.keys.product_adj }} according to your application's logic. Auto log send can also be enabled to automatically send logs. If logs are not sent before the maximum size is reached, the log file is then purged in favor of newer logs.

> **Note:** Adopt the following pattern when you collect log data. Sending data on an interval ensures that you are seeing your log data in near real-time in the {{ site.data.keys.mf_analytics_console }}.

#### Cordova apps
{: #cordova-apps }

To ensure that all captured logs are sent, consider one of the following strategies:

* Call the `send` method at a time interval.
* Call the `send` method from within the app lifecycle event callbacks.
* Increase the max file size of the persistent log buffer (in bytes):
```javascript
setInterval(function() {
    WL.Logger.send();
}, 60000);
```

```javascript
WL.Logger.config({ maxFileSize: 150000 });
```

#### Web apps
{: #web-apps }

```javascript
setInterval(function() {
   ibmmfpfanalytics.logger.send();
}, 60000);
```

The maximum file size for the Web API is 5 mb and cannot be changed.

## Auto log sending
{: auto-log-sending }
By default, auto log send is enabled. Each time a successful resource request is sent to the server, the captured logs are also sent, with a 60-second minimum interval between sends. Auto log send can be enabled or disabled from the client. By default auto log send is enabled.

#### For Cordova apps
{: #for-cordova-apps }
To enable:

```javascript
WL.Logger.config({autoSendLogs: true});
```

To disable:

```javascript
WL.Logger.config({autoSendLogs: false});
```

#### For Web apps
{: #for-web-apps }
To enable:

```javascript
ibmmfpfanalytics.autoSendLogs(true);
```

To disable:

```javascript
ibmmfpfanalytics.autoSendLogs(false);
```

## Fine-tuning with the Logger API
{: #fine-tuning-with-the-logger-api }
The {{ site.data.keys.product_adj }} client SDK makes internal use of the Logger API. By default, you are capturing log entries made by the SDK. To fine-tune log collection, use logger instances with package names. You can also control which logging level is captured by the analytics using server-side filters.

As an example to capture logs only where the level is ERROR for the `myApp` package name, follow these steps.

#### Fine-tuning Cordova apps
{: #fine-tuning-cordova-apps }
1. Use a `WL.Logger` instance with the `myApp` package name.

   ```javascript
   var logger = WL.Logger.create({ pkg: 'MyApp' });
   ```

2. **Optional:** Specify a filter to restrict log capture and log output to only the specified level and package programmatically.

   ```javascript
   WL.Logger.config({
        filters: {
            'MyApp': 'ERROR'
        }
   });
   ```

3. **Optional:** Control the filters remotely by fetching a server configuration profile.

#### Web apps
{: #fine-tuning-web-apps }
For the Web SDK the level cannot be set by the client. All logging is sent to the server until the configuration is changed by retrieving the server configuration profile.

## Fetching server configuration profiles
{: #fetching-server-configuration-profiles }
Logging levels can be set by the client or by retrieving configuration profiles from the server. From the {{ site.data.keys.mf_analytics_console }}, a log level can be set globally (all logger instances) or for a specific package or packages. For information on configuring the filter from the {{ site.data.keys.mf_analytics_console }}, see [Configuring log filters](../../../analytics/console/log-filters/).  For the client to fetch the configuration overrides that are set on the server, the `updateConfigFromServer` method must be called from a place in the code that is regularly run, such as in the app lifecycle callbacks.

#### Fetching server configuration profiles for Cordova apps
{: #fetching-server-configuration-profiles-cordova-apps }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Fetching server configuration profiles for Web apps
{: #fetching-server-configuration-profiles-web-apps }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

## Logging example
{: #logging-example }
Outputs to a browser JavaScript console, LogCat, or Xcode console.

### Logging example Cordova
{: #logging-example-cordova }

```javascript
var MathUtils = function(){
   var logger = WL.Logger.create({pkg: 'MathUtils'});
   var sum = function(a, b){
      var sum = a + b;
      logger.debug('sum called with args ' + a + ' and ' + b + '. Returning ' + sum);
      return sum;
   };
}();
```

### Logging example Web
{: #logging-example-web }
For logging with Web applications, use the preceding example and replace

```javascript
var logger = WL.Logger.create({pkg: 'MathUtils'});
```

with

```javascript
var logger = ibmmfpfanalytics.logger.create({pkg: 'MathUtils'});
```
