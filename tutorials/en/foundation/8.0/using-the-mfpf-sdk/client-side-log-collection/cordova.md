---
layout: tutorial
title: Logging in Cordova Applications
relevantTo: [cordova]
weight: 1
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in Cordova applications.

**Prerequisite:** Make sure to read the [overview of client-side log collection](../).

## Logging example
Outputs to a browser JavaScript console, LogCat, or Xcode console.

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

## Additional API Methods For Specific Tasks
Log capture is enabled by default. To turn log capture on or off:

```javascript
WL.Logger.config({capture: false})
```

The default capture level is FATAL in development and in production. To control the capture level (verbosity):

```javascript
WL.Logger.config({level: 'FATAL'})
```

Log sending is enabled by default. To turn automatic log sending on or off:

```javascript
WL.Logger.config({autoSendLogs: false})
```

> For more information about the `Logger` API, see the API reference in the user documentation.
