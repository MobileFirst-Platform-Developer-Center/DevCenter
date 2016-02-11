---
title: Logging in MobileFirst Cordova applications (JavaScript)
relevantTo: [cordova]
---
### Logging example for hybrid applications (JavaScript)
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
### API calls for specific tasks
Log capture is enabled by default. To turn log capture on or off:

```WL.Logger.config({capture: false})```

The default capture level is DEBUG in development and FATAL in production. To control the capture level (verbosity):

```WL.Logger.config({level: 'FATAL'})```

Log sending is enabled by default. To turn automatic log sending on or off:

```WL.Logger.config({autoSendLogs: false})```
> For more information about ```WL.Logger API```, see the API reference in the user documentation
