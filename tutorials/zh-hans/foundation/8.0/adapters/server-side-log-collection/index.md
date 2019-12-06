---
title: 服务器端日志收集
breadcrumb_title: Server-side log collection
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

日志记录是使用 API 调用来记录消息，从而促进诊断和调试的源代码工具。 {{ site.data.keys.mf_server }} 允许您远程控制应当收集的日志。 这使得服务器管理员能够更加细微地控制服务器资源。

日志记录库通常具有常常称为**级别**的详细程度控制。 从最低到最高详细度为：ERROR、WARN、INFO 和 DEBUG。

## 适配器中的日志集合
{: #log-collection-in-adapters }

可以在底层应用程序服务器日志记录机制中查看适配器中的日志。  
在 WebSphere 完整概要文件和 Liberty 概要文件中，根据指定的日志记录级别，使用 **messages.log** 和 **trace.log** 文件。

如 [Java 适配器](java-adapter)和 [JavaScript 适配器](javascript-adapter)的教程中所述，也可以将这些日志转发至分析控制台。

## 访问日志文件
{: #accessing-the-log-files }

* 在 {{ site.data.keys.mf_server }} 的预安装中，根据底层应用程序服务器提供该文件。
    * [IBM WebSphere Application Server 完整概要文件](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty 概要文件](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* 要获取以下各项中云部署中的日志：
    * Mobile Foundation IBM Cloud 服务，请参阅[使用 Mobile Foundation](../../bluemix/using-mobile-foundation) 教程中的[访问服务器日志](../../bluemix/using-mobile-foundation/#accessing-server-logs)部分。
