---
title: Logging in Java Adapters
relevantTo: [JavaScrt Adapters]
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in a Java adapter.

## Server Setup

In the MobileFirst Platform Foundation Operation Console go to the `Runtime` menu selection in the navbar on the left. Under the `Runtime Properties` tab Additional packages can be selected in order to send to the analytics server. Here specifify the class name of the java adapter in which logs are suppose to be sent to the server.

## Logging example
Import the java logging package:

```java
import java.util.logging.Logger;
```

Define a logger:

```java
static Logger logger = Logger.getLogger(JavaLoggerTestResource.class.getName());
```

Now inside a method include logging:

```java
logger.warning("Logging warning message...");
```

This message outputs to the `trace.log` file of the MobileFirst Platform Foundation Operations Console server. If the server administrator is forwarding logs from the Operations Console to the Analytics Console the `logger` message will also appear in the Server Log Search.