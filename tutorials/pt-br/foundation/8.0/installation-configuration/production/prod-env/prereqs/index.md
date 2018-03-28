---
layout: tutorial
title: Installation prerequisites
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
For smooth installation of MobileFirst Server, ensure that you fulfil all the software prerequisites.

Before you install MobileFirst Server, you need to have the following software.

* **Database Management System (DBMS)**
  A DBMS is needed to store the technical data of MobileFirst Server components. You must use one of the supported DBMS:

  * IBM DB2
  * MySQL
  * Oracle

  For more information about the versions of DBMS that are supported by the product, see [System requirements](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). If you use a relational DBMS (IBM DB2, Oracle, or MySQL), you need the JDBC driver for that database during the installation process. The JDBC drivers are not provided by MobileFirst Server installer. Make sure that you have the JDBC driver.

  * For DB2, use the DB2 JDBC driver V4.0 (db2jcc4.jar).
  * For MySQL, use the Connector/J JDBC driver.
  * For Oracle, use the Oracle thin JDBC driver.

* **Java™ application server**
  A Java application server is needed to run the MobileFirst Server applications. You can use any of the following application servers:

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  For more information about the versions of application servers that are supported by the product, see [System requirements](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). The application server must run with Java 7 or later. By default, some versions of WebSphere Application Server run with Java 6. With this default, they cannot run MobileFirst Server.

* **IBM Installation Manager V1.8.4 or later**
  Installation Manager is used to run the installer of MobileFirst Server. You must install Installation Manager V1.8.4 or later. The older versions of Installation Manager are not able to install IBM MobileFirst Platform Foundation V8.0 because the post installation operations of the product require Java 7. The older versions of Installation Manager come with Java 6.

  Download the installer of IBM Installation Manager V1.8.4 or later from [Installation Manager and Packaging Utility download links](http://www-01.ibm.com/support/docview.wss?uid=swg27025142).

* **Installation Manager repository for MobileFirst Server**
  You can download the repository from the IBM MobileFirst Platform Foundation eAssembly on [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm). The name of the pack is `IBM MobileFirst Platform Foundation V8.0.zip` file of Installation Manager Repository for IBM MobileFirst Platform Server.

  You might also want to apply the latest fix pack that can be downloaded from [IBM Support Portal](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation). The fix pack cannot be installed without the repository of the base version in the repositories of Installation Manager.

The IBM MobileFirst Platform Foundation eAssembly includes the following installers:
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

For Liberty, you can also use IBM WebSphere SDK Java Technology edition with IBM WebSphere Application Server Liberty Core supplement.

## Parent topic
{: #parent-topic }

* [Installing MobileFirst Server in a production environment](../).
