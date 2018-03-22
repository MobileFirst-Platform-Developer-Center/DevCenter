---
layout: tutorial
title: 在应用程序服务器上为 Application Center 设置日志记录和跟踪
breadcrumb_title: Setting up logging and tracing
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以为特定应用程序服务器设置日志记录和跟踪参数，使用 JNDI 属性来控制所有受支持应用程序服务器上的输出。

您可以按照专门针对特定应用程序服务器的方式，为 Application Center 的跟踪操作设置日志记录级别和输出文件。 此外，{{ site.data.keys.product_full }} 还提供 Java™ 命名和目录接口 (JNDI) 属性来控制跟踪输出的格式和重定向，并打印生成的 SQL 语句。

#### 跳至：
{: #jump-to }
* [在 WebSphere Application Server Full Profile 中启用日志记录和跟踪](#logging-in-websphere)
* [在 WebSphere Application Server Liberty 中启用日志记录和跟踪](#logging-in-liberty)
* [在 Apache Tomcat 中启用日志记录和跟踪](#logging-in-tomcat)
* [用于控制跟踪输出的 JNDI 属性](#jndi-properties-for-controlling-trace-output)

## 在 WebSphere Application Server Full Profile 中启用日志记录和跟踪
{: #logging-in-websphere }
您可以为应用程序服务器上的跟踪操作设置日志记录级别和输出文件。

当您尝试诊断 Application Center（或 {{ site.data.keys.product }} 的其他组件）中的问题时，能够查看日志消息非常重要。 要打印日志文件中可阅读的日志消息，必须指定适用的设置作为 Java™ 虚拟机 (JVM) 属性。

1. 打开 WebSphere Application Server 管理控制台
2. 选择**故障诊断 → 日志和跟踪**。
3. 在“**日志记录和跟踪**”中，选择相应的应用程序服务器，然后选择**更改日志详细信息级别**。
4. 选择包及其相应的详细信息级别。 本示例为 {{ site.data.keys.product }}（包括 Application Center）启用级别为 **FINEST**（相当于 **ALL**）的日志记录。

```xml
com.ibm.puremeap.*=all
com.ibm.mfp.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

其中：

* **com.ibm.puremeap.*** 适用于 Application Center。
* **com.ibm.mfp.**\*、**com.ibm.worklight.*** 和 **com.worklight.*** 适用于其他 {{ site.data.keys.product_adj }} 组件。

跟踪发送至名为 **trace.log** 的文件，而不是发送至 **SystemOut.log** 或 **SystemErr.log** 文件。

## 在 WebSphere Application Server Liberty 中启用日志记录和跟踪
{: #logging-in-liberty }
您可以为 Liberty 应用程序服务器上 Application Center 的跟踪操作设置日志记录级别和输出文件。

当您尝试诊断 Application Center 中的问题时，能够查看日志消息非常重要。 要打印日志文件中可阅读的日志消息，必须指定适用的设置。

要为 {{ site.data.keys.product }}（包括 Application Center）启用级别为 FINEST（相当于 ALL）的日志记录，请在 server.xml 文件中添加一行。 例如：

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.mfp.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

在此示例中，包的多个条目及其日志记录级别使用冒号 (:) 分隔。

跟踪发送至名为 **trace.log** 的文件，而不是发送至 **messages.log** 或 **console.log** 文件。

有关更多信息，请参阅 [Liberty Profile：日志记录和跟踪](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc)。

## 在 Apache Tomcat 中启用日志记录和跟踪
{: #logging-in-tomcat }
您可以为 Apache Tomcat 应用程序服务器上执行的跟踪操作设置日志记录级别和输出文件。

当您尝试诊断 Application Center 中的问题时，能够查看日志消息非常重要。 要打印日志文件中可阅读的日志消息，必须指定适用的设置。

要为 {{ site.data.keys.product }}（包括 Application Center）启用级别为 **FINEST**（相当于 **ALL**）的日志记录，请编辑 **conf/logging.properties** 文件。 例如，添加类似于以下行的行：

```xml
com.ibm.puremeap.level = ALL
com.ibm.mfp.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

有关更多信息，请参阅 [Tomcat 中的日志记录](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)。

## 用于控制跟踪输出的 JNDI 属性
{: #jndi-properties-for-controlling-trace-output }
在所有受支持的平台上，您可以使用 Java™ 命名和目录接口 (JNDI) 属性来格式化并重定向 Application Center 的跟踪输出，并打印生成的 SQL 语句。

以下 JNDI 属性适用于 Application Center 服务 (**applicationcenter.war**) 的 Web 应用程序。

| 属性设置 | 设置 | 描述 |
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | 缺省情况下，此属性设置为 false。 将其设置为 true，可使用空格对 JSON 输出进行格式化，以便更容易在日志文件中阅读。 |
| ibm.appcenter.logging.tosystemerror | true | 缺省情况下，此属性设置为 false。 将其设置为 true，可将系统错误的所有日志消息打印到日志文件中。 使用此属性可全局开启日志记录。 |
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE | 此设置将所有生成的 SQL 语句打印在日志文件中。 |
