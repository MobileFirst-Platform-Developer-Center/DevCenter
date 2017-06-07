---
layout: tutorial
title: Logging in JavaScript Adapters
relevantTo: [ios,android,windows,javascript]
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

This tutorial provides the required code snippets in order to add logging capabilities in a JavaScript adapter.

## Logging example
{: #logging-example }

The message below outputs to the `trace.log` file of the application server. If the server administrator is forwarding logs from the {{ site.data.keys.mf_server }} to the {{ site.data.keys.mf_analytics_server }} the `logger` message will also appear in the **Infrastructure → Server Log Search** view in the {{ site.data.keys.mf_analytics_console }}.

```javascript
MFP.Logger.debug("This is a debug message from a JavaScript adapter");
```

Additional logging levels, from least to most verbose: ERROR, WARN, INFO, LOG and DEBUG. 

## Accessing the log files
{: #accessing-the-log-files }

* In an on-prem installation of the {{ site.data.keys.mf_server }}, the file is available depending on the underlying application server. 
    * [IBM WebSphere Application Server Full Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* To get to the logs in a cloud deployment in:
    * IBM Containers or Liberty Build Pack, see the [IBM Containers log and trace collection](../../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/) tutorial.
    * Mobile Foundation Bluemix service, see [Accessing server logs](../../../bluemix/using-mobile-foundation/#accessing-server-logs) section in the [Using Mobile Foundation](../../../bluemix/using-mobile-foundation) tutorial.

## Forwarding Logs to the Analytics server
{: #forwarding-logs-to-the-analytics-server }

Logs can also be forwarded to the Analytics console.

1. In {{ site.data.keys.mf_console }} select the **Settings** option from the sidebar navigation.
2. Click the **Edit** button in the **Runtime Properties tab**.
3. In the **Analytics → Additional packages** section, specify **MFP.Logger** to forward JavaScript Adapter logs to the {{ site.data.keys.mf_server }}.

![Log filtering from the console](javascript-filter.png)

