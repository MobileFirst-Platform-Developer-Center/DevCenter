---
title: Sending Data
---
### Sending data

Logs that are captured by the client-side logging APIs and the ```WL.Analytics``` APIs are sent to the server automatically upon a successful server connection or a successful adapter call.

```javascript
// Logs sent upon successful connection
WL.Client.connect();
// Logs sent upon successful adapter invocation
WLResourceRequest.send();
```
You can disable this automatic behavior by using the following call:

```javascript
// Disable automatic sending of client and analytics logs
WL.Logger.config({autoSendLogs: false});
```

If you want to send this data more frequently, you can use the following API calls:

```javascript
// Send client debug logs
WL.Logger.send();
// Send analytics logs
WL.Analytics.send();
```
