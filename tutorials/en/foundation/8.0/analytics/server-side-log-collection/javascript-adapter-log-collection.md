---
title: Logging in JavaScript Adapters
relevantTo: [JavaScript Adapters]
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in a JavaScript adapter.

## Logging example
Outputs to a to the `trace.log` file of the MobileFirst Platform Foundation Operations Console. If the server administrator is forwarding logs from the Operations Console to the Analytics Console the `logger` message will also appear in the Server Log Search.

```javascript
MFP.Logger.debug("This is a Debug message from a JavaScript Adapter);
```
