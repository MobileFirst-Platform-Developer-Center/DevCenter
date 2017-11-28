---
layout: tutorial
title: 为生产环境安装 MobileFirst Server
breadcrumb_title: 生产环境
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
本部分提供了一些详细信息，可帮助您针对特定环境规划和准备安装。  
有关 {{ site.data.keys.mf_server }} 配置的更多信息，请参阅[配置 {{ site.data.keys.mf_server }}](server-configuration)。

#### 跳至：
{: #jump-to }

* [先决条件](#prerequisites)
* [后续操作](#whats-next)

## 先决条件
{: #prerequisites }
为顺利安装 {{ site.data.keys.mf_server }}，请确保满足所有软件先决条件。

**数据库管理系统 (DBMS)**  
需要 DBMS 来存储 {{ site.data.keys.mf_server }} 组件的技术数据。 您必须使用受支持的某一个 DBMS：

* IBM DB2 
* MySQL
* Oracle

有关产品支持的 DBMS 版本的更多信息，请参阅[系统需求](../../product-overview/requirements)。 如果使用关系 DBMS（IBM DB2、Oracle 或 MySQL），那么在安装过程中，此数据库需要 JDBC 驱动程序。 {{ site.data.keys.mf_server }} 安装程序未提供 JDBC 驱动程序。 确保您有 JDBC 驱动程序。

* 对于 DB2，使用 DB2 JDBC 驱动程序 V4.0 (db2jcc4.jar)。
* 对于 MySQL，使用 Connector/J JDBC 驱动程序。
* 对于 Oracle，使用 Oracle 瘦 JDBC 驱动程序。

**Java 应用程序服务器**  
需要 Java 应用程序服务器才能运行 {{ site.data.keys.mf_server }} 应用程序。 您可以使用以下任何应用程序服务器：

* WebSphere Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

有关产品支持的应用程序服务器版本的更多信息，请参阅[系统需求](../../product-overview/requirements)。 必须使用 Java 7 或更高版本运行应用程序服务器。 缺省情况下，使用 Java 6 运行某些版本的 WebSphere Application Server。此时，将无法运行 {{ site.data.keys.mf_server }}

**IBM Installation Manager V1.8.4 或更高版本**  
Installation Manager 用于运行 {{ site.data.keys.mf_server }} 的安装程序。 必须安装 Installation Manager V1.8.4 或更高版本。 更低版本的 Installation Manager 将无法安装 {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}，因为该产品的安装后操作需要使用 Java 7，而更低版本的 Installation Manager 只随附了 Java 6。

从 [Installation Manager 和 Packaging Utility 下载链接](http://www.ibm.com/support/docview.wss?uid=swg27025142)下载 IBM Installation Manager V1.8.4 或更高版本的安装程序。

**{{ site.data.keys.mf_server }} 的 Installation Manager 存储库**  
可以从 [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm) 上的 {{ site.data.keys.product }} eAssembly 中下载该存储库。 包名称为 **IBM MobileFirst Platform Server 的 Installation Manager 存储库 IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip 文件**。

您可能还想应用可从 [IBM 支持门户网站](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation)下载的最新修订包。 如果 Installation Manager 的存储库中无基本版本的存储库，将无法安装修订包。

{{ site.data.keys.product }} eAssembly 包含以下安装程序：

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

对于 Liberty，还可以将 IBM WebSphere SDK Java Technology Edition 与 IBM WebSphere Application Server Liberty Core 附加组件结合使用。

## 后续操作
{: #whats-next }

* [运行 IBM Installation Manager](installation-manager)
* [设置数据库](databases)
* [拓扑和网络流](topologies)
* [将 {{ site.data.keys.mf_server }} 安装到应用程序服务器中](appserver)
