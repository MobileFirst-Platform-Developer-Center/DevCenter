---
layout: tutorial
title: 安装先决条件
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
为顺利安装 MobileFirst Server，请确保满足所有软件先决条件。

在安装 MobileFirst Server 之前，您需要具备以下软件。

* **数据库管理系统 (DBMS)**
  需要 DBMS 来存储 MobileFirst Server 组件的技术数据。 您必须使用受支持的某一个 DBMS：

  * IBM DB2
  * MySQL
  * Oracle

  有关产品支持的 DBMS 版本的更多信息，请参阅[系统需求](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)。 如果使用关系 DBMS（IBM DB2、Oracle 或 MySQL），那么在安装过程中，此数据库需要 JDBC 驱动程序。 MobileFirst Server 安装程序未提供 JDBC 驱动程序。 确保您有 JDBC 驱动程序。

  * 对于 DB2，使用 DB2 JDBC 驱动程序 V4.0 (db2jcc4.jar)。
  * 对于 MySQL，使用 Connector/J JDBC 驱动程序。
  * 对于 Oracle，使用 Oracle 瘦 JDBC 驱动程序。

* **Java™ 应用程序服务器**
  需要 Java 应用程序服务器才能运行 MobileFirst Server 应用程序。 您可以使用以下任何应用程序服务器：

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  有关产品支持的应用程序服务器版本的更多信息，请参阅[系统需求](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)。 必须使用 Java 7 或更高版本运行应用程序服务器。 缺省情况下，使用 Java 6 运行某些版本的 WebSphere Application Server。此时，将无法运行 MobileFirst Server。

* **IBM Installation Manager V1.8.4 或更高版本**
  Installation Manager 用于运行 MobileFirst Server 安装程序。 必须安装 Installation Manager V1.8.4 或更高版本。 更低版本的 Installation Manager 不能安装 IBM MobileFirst Platform Foundation V8.0，因为产品后安装操作需要 Java 7。更低版本的 Installation Manager 随附 Java 6。

  从 [Installation Manager 和 Packaging Utility 下载链接](http://www-01.ibm.com/support/docview.wss?uid=swg27025142)下载 IBM Installation Manager V1.8.4 或更高版本的安装程序。

* **MobileFirst Server 的 Installation Manager 存储库**
  您可以从 [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm) 上的 IBM MobileFirst Platform Foundation eAssembly 下载该存储库。 对于 IBM MobileFirst Platform Server 的 Installation Manager 存储库，包名称为 `IBM MobileFirst Platform Foundation V8.0.zip` 文件。

  您可能还想应用可从 [IBM 支持门户网站](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation)下载的最新修订包。 如果 Installation Manager 的存储库中无基本版本的存储库，将无法安装修订包。

IBM MobileFirst Platform Foundation eAssembly 包含以下安装程序：
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

对于 Liberty，还可以将 IBM WebSphere SDK Java Technology Edition 与 IBM WebSphere Application Server Liberty Core 附加组件结合使用。

## 父主题
{: #parent-topic }

* [在生产环境中安装 MobileFirst Server](../)。
