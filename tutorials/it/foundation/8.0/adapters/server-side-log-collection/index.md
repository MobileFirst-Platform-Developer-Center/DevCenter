---
title: Server-side log collection
breadcrumb_title: Server-side log collection
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

Logging is the instrumentation of source code that uses API calls to record messages in order to facilitate diagnostics and debugging. The {{ site.data.keys.mf_server }} gives you the ability to control  which logs should be collected remotely. This gives the server administrator more fine tuned control over the server resources.

Logging libraries typically have verbosity controls that are frequently called **levels**. From least to most verbose: ERROR, WARN, INFO, and DEBUG.

## Log Collection in Adapters
{: #log-collection-in-adapters }

Logs in adapters can be viewed in the underlying application server logging mechanism.  
In WebSphere full profile and Liberty profile the **messages.log** and **trace.log** files are used, depending on the specified logging level.

These logs can also be forwarded to the Analytics console as explained in the tutorials for [Java adapters](java-adapter) and [JavaScript adapters](javascript-adapter).

## Accessing the log files
{: #accessing-the-log-files }

* In an on-prem installation of the {{ site.data.keys.mf_server }}, the file is available depending on the underlying application server.
    * [IBM WebSphere Application Server Full Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* To get to the logs in a cloud deployment in:
    * IBM Containers or Liberty Build Pack, see the [IBM Containers log and trace collection](../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/) tutorial.
    * Mobile Foundation IBM Cloud service, see [Accessing server logs](../../bluemix/using-mobile-foundation/#accessing-server-logs) section in the [Using Mobile Foundation](../../bluemix/using-mobile-foundation) tutorial.
