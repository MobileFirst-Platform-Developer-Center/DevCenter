---
layout: tutorial
title: Setting logging and tracing for Application Center on the application server
breadcrumb_title: Setting up logging and tracing
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
You can set logging and trace parameters for particular application servers and use JNDI properties to control output on all supported application servers.

You can set the logging levels and the output file for tracing operations for Application Center in ways that are specific to particular application servers. In addition, {{ site.data.keys.product_full }} provides Java™ Naming and Directory Interface (JNDI) properties to control the formatting and redirection of trace output, and to print generated SQL statements.

#### Jump to
{: #jump-to }
* [Enabling logging and tracing in WebSphere Application Server full profile](#logging-in-websphere)
* [Enabling logging and tracing in WebSphere Application Server Liberty](#logging-in-liberty)
* [Enabling logging and tracing in Apache Tomcat](#logging-in-tomcat)
* [JNDI properties for controlling trace output](#jndi-properties-for-controlling-trace-output)

## Enabling logging and tracing in WebSphere Application Server full profile
{: #logging-in-websphere }
You can set the logging levels and the output file for tracing operations on the application server.

When you try to diagnose problems in the Application Center (or other components of {{ site.data.keys.product }}), it is important to be able to see the log messages. To print readable log messages in log files, you must specify the applicable settings as Java™ virtual machine (JVM) properties.

1. Open the WebSphere  Application Server administrative console.
2. Select **Troubleshooting → Logs and Trace**.
3. In **Logging and tracing**, select the appropriate application server and then select **Change log detail levels**.
4. Select the packages and their corresponding detail level. This example enables logging for {{ site.data.keys.product }}, including Application Center, with level **FINEST** (equivalent to **ALL**).

```xml
com.ibm.puremeap.*=all
com.ibm.mfp.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

Where:

* **com.ibm.puremeap.*** is for Application Center.
* **com.ibm.mfp.**\*, **com.ibm.worklight.*** and **com.worklight.*** are for other {{ site.data.keys.product_adj }} components.

The traces are sent to a file called **trace.log**, not to **SystemOut.log** or to **SystemErr.log**.

## Enabling logging and tracing in WebSphere Application Server Liberty
{: #logging-in-liberty }
You can set the logging levels and the output file for tracing operations for Application Center on the Liberty application server.

When you try to diagnose problems in the Application Center, it is important to be able to see the log messages. To print readable log messages in log files, you must specify the applicable settings.

To enable logging for {{ site.data.keys.product }}, including Application Center, with level FINEST(equivalent to ALL), add a line to the server.xml file. For example:

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.mfp.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

In this example, multiple entries of a package and its logging level are separated by a colon (:).

The traces are sent to a file called **trace.log**, not to **messages.log** or to **console.log**.

For more information, see [Liberty profile: Logging and Trace](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc).

## Enabling logging and tracing in Apache Tomcat
{: #logging-in-tomcat }
You can set the logging levels and the output file for tracing operations undertaken on the Apache Tomcat application server.

When you try to diagnose problems in the Application Center, it is important to be able to see the log messages. To print readable log messages in log files, you must specify the applicable settings.

To enable logging for {{ site.data.keys.product }}, including Application Center, with level **FINEST** (equivalent to **ALL**), edit the **conf/logging.properties** file. For example, add lines similar to these lines:

```xml
com.ibm.puremeap.level = ALL
com.ibm.mfp.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

For more information, see [Logging in Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html).

## JNDI properties for controlling trace output
{: #jndi-properties-for-controlling-trace-output }
On all supported platforms, you can use Java™ Naming and Directory Interface (JNDI) properties to format and redirect trace output for Application Center and to print generated SQL statements.

The following JNDI properties are applicable to the web application for Application Center services (**applicationcenter.war**).

| Property settings | Setting | Description |
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | By default, this property is set to false. Set it to true to format JSON output with blank spaces, for easier reading in log files. |
| ibm.appcenter.logging.tosystemerror | true | By default, this property is set to false. Set it to true to print all log messages to system error in log files. Use the property to turn on logging globally. |
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE | This setting prints all the generated SQL statements to the log files. |
