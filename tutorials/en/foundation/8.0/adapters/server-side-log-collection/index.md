---
title: Server-side log collection
breadcrumb_title: Server-side log collection
relevantTo: [ios,android,windows,cordova]
weight: 7
---

## Overview
Logging is the instrumentation of source code that uses API calls to record messages in order to facilitate diagnostics and debugging. The MobileFirst Platform Foundation Operations Server gives you the ability to contorl which logs should be collected remotley. This gives the server administrator more fine tuned control over the server resources.

Features the server offers:

* [Remote Client Side Logging](#server-control-of-client-log-capture)
* [Additional Packages](#additional-packages)
* [Log Collection in Adapters](#log-collection-in-adapters)

## Logging levels
Logging libraries typically have verbosity controls that are frequently called **levels**. From least to most verbose: ERROR, WARN, INFO, LOG and DEBUG. 

## Server Control of Client Log Capture
Administrators can control the MobileFirst client SDK log capture and levels from the **MobileFirst Operations Console → [your application] → Log Filters**.  
Through `Log Filters` you are able to create a filter level that you can log at.

![Log filtering from the console](log-filtering.png)

In order to use the server configuration the client has to use the `updateConfigFromServer` method in the `Logger` API.

#### Android

```java
Logger.updateConfigFromServer();
```

#### iOS

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova

```javascript
WL.Logger.updateConfigFromServer();
```

The `Logger` configuration values returned from the server will take precidence over any value set on the client side. When the Client Log Profile is removed and the client tries to retrieve the Client Log Profile, the client will receive an empty payload. If an empcdty payload is received then the `Logger` configuration will default to what was originally configured on the client.

## Forwarding Server Logs
The MobileFirst Platform Foundation Operations Console also gives the server administrator the ability to persist logs and send those logs to the [MobileFirst Analytics Console](../operational-analytics/). 

To forward server logs navigate to the Runtime's **Settings** screen and provide the used logger package under **Additional Packages**.  
The collected logs can then be viewed in the Analytics console. This is useful for a user when they want to take advantage of triaging adapter logs in the Analytics console without having to collect all server logs. 

## Log Collection in Adapters
Logs in adapters can be viewed in the underlying application server logging mechanism.  

* In WebSphere full profile and Liberty profile the **messages.log** and **trace.log** files are used, depending on the specified logging level in the **server.xml** file. These logs, however, can also be forwarded to the Analytics console. 

Select an adapter type:

* [JavaScript Adapters](javascript-adapter/)
* [Java Adapters](java-adapter/)

## For more information
> For more information about logging and log capture, see the user documentation.
