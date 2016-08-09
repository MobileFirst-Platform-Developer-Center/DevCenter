---
layout: tutorial
title: Logging in JavaScript Adapters
relevantTo: [ios,android,window,javascript]
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in a JavaScript adapter.

## Logging example
The message below outputs to the `trace.log` file of the application server. If the server administrator is forwarding logs from the MobileFirst Server to the MobileFirst Analytics server the `logger` message will also appear in the Server Log Search view in the MobileFirst Analytics Console.

```javascript
MFP.Logger.debug("This is a debug message from a JavaScript adapter");
```

Additional logging levels, from least to most verbose: ERROR, WARN, INFO, LOG and DEBUG. 

## Server Setup
To set-up logging in JavaScript adapters:

1. In MobileFirst Operations Console select the **Settings** option from the sidebar navigation.
2. Click the **Edit** button in the **Runtime Properties tab**.
3. In the **Analytics → Additional packages** section, specify **MFP.Logger** to forward JavaScript Adapter logs to the MobileFirst Server.

![Log filtering from the console](javascript-filter.png)

