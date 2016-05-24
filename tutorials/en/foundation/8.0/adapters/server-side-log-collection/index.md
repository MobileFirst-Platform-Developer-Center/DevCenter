---
title: Server-side log collection
breadcrumb_title: Server-side log collection
relevantTo: [ios,android,windows,javascript]
weight: 7
---
## Overview
Logging is the instrumentation of source code that uses API calls to record messages in order to facilitate diagnostics and debugging. The MobileFirst Platform Foundation Operations Server gives you the ability to contorl which logs should be collected remotley. This gives the server administrator more fine tuned control over the server resources.

## Logging levels
Logging libraries typically have verbosity controls that are frequently called **levels**. From least to most verbose: ERROR, WARN, INFO, LOG and DEBUG. 

## Log Collection in Adapters
Logs in adapters can be viewed in the underlying application server logging mechanism.  

* In WebSphere full profile and Liberty profile the **messages.log** and **trace.log** files are used, depending on the specified logging level in the **server.xml** file. These logs, however, can also be forwarded to the Analytics console. 

Select an adapter type:

* [JavaScript Adapters](javascript-adapter/)
* [Java Adapters](java-adapter/)

## For more information
> For more information about logging and log capture, see the user documentation.
