---
title: Analytics Logs
---
### Analytics Logs

Client-side logs are captured based on the logging level that is set on the client. If you want to create analytics logs that are always captured regardless of the logging level, you can use the ```WL.Analytics``` API.

```javascript
// Create an analytics log message
WL.Analytics.log("Analytics log message");
// Create a custom activity>
WL.Analytics.log({_activity: "customActivity"});
// Create a custom activity with a log message
WL.Analytics.log({_activity: "customActivity"}, "Analytics log message");
```
