---
title: Logging in JavaScript Adapters
relevantTo: [JavaScript Adapters]
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in a JavaScript adapter.

## Server Setup

In the MobileFirst Platform Foundation Operation Console go to the `Runtime` menu selection in the navbar on the left. Under the `Runtime Properties` tab Additional packages can be selected in order to send to the analytics server. Here specifify `MFP.Logger` to forward JavaScript Adapter logs to the server.

## Logging example
The message below outputs to the `trace.log` file of the MobileFirst Platform Foundation Operations Console server. If the server administrator is forwarding logs from the Operations Console to the Analytics Console the `logger` message will also appear in the Server Log Search.

```javascript
MFP.Logger.debug("This is a Debug message from a JavaScript Adapter);
```
