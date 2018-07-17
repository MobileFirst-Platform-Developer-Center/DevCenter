---
layout: tutorial
title: 설치 전제조건
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
MobileFirst Server의 원활한 설치를 위해서는 모든 소프트웨어 전제조건이 충족되어야 합니다.

MobileFirst Server를 설치하기 전에 다음 소프트웨어가 있어야 합니다.

* **DBMS(Database Management System)**
   DBMS는 MobileFirst Server 컴포넌트의 기술 데이터를 저장하는 데 필요합니다. 지원되는 다음 DBMS 중 하나를 사용해야 합니다.

  * IBM  DB2
  * MySQL
  * Oracle

  제품에서 지원하는 DBMS의 버전에 대한 자세한 정보는 [시스템 요구사항](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)을 참조하십시오. 관계형 DBMS(IBM DB2, Oracle 또는 MySQL)를 사용하는 경우, 설치 프로세스 동안 해당 데이터베이스에 대한 JDBC 드라이버가 필요합니다. JDBC 드라이버는 MobileFirst Server 설치 프로그램에서 제공하지 않습니다. JDBC 드라이버가 있는지 확인하십시오.

  * DB2의 경우, DB2 JDBC 드라이버 V4.0(db2jcc4.jar)을 사용하십시오.
  * MySQL의 경우, Connector/J JDBC 드라이버를 사용하십시오.
  * Oracle의 경우, Oracle 씬 JDBC 드라이버를 사용하십시오.

* **Java™ 애플리케이션 서버**
  Java 애플리케이션 서버는 MobileFirst Server 애플리케이션을 실행하는 데 필요합니다. 다음과 같은 애플리케이션 서버를 사용할 수 있습니다.

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  제품에서 지원하는 애플리케이션 서버의 버전에 대한 자세한 정보는 [시스템 요구사항](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html)을 참조하십시오. 애플리케이션 서버는 Java 7 이상에서 실행해야 합니다. 기본적으로 WebSphere Application Server의 일부 버전은 Java 6으로 실행됩니다. 이 기본값을 사용하는 경우 해당 서버에서는 MobileFirst Server를 실행할 수 없습니다.

* **IBM Installation Manager V1.8.4 이상**
  Installation Manager가 MobileFirst Server의 설치 프로그램을 실행하는 데 사용됩니다. Installation Manager V1.8.4 이상을 설치해야 합니다. 제품의 설치 후 작업에 Java 7이 필요하므로 이전 버전의 Installation Manager는 IBM MobileFirst Platform Foundation V8.0을 설치할 수 없습니다. 이전 버전의 Installation Manager는 Java 6과 함께 제공됩니다.

  [Installation Manager and Packaging Utility download links](http://www-01.ibm.com/support/docview.wss?uid=swg27025142)에서 IBM Installation Manager V1.8.4 이상의 설치 프로그램을 다운로드하십시오.

* **MobileFirst Server용 Installation Manager 저장소**
  [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm)의 IBM MobileFirst Platform Foundation eAssembly에서 해당 저장소를 다운로드할 수 있습니다. 이 팩의 이름은 IBM MobileFirst Platform Server용 Installation Manager 저장소의 `IBM MobileFirst Platform Foundation V8.0.zip` 파일입니다.

  [IBM Support Portal](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation)에서 다운로드할 수 있는 최신 수정팩을 적용할 수도 있습니다. Installation Manager의 저장소에 기본 버전의 저장소가 없으면 수정팩을 설치할 수 없습니다.

IBM MobileFirst Platform Foundation eAssembly에는 다음과 같은 설치 프로그램이 포함되어 있습니다.
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Liberty의 경우, IBM WebSphere Application Server Liberty Core가 추가된 IBM WebSphere SDK Java Technology Edition도 사용할 수 있습니다.

## 상위 주제
{: #parent-topic }

* [프로덕션 환경에서 MobileFirst Server 설치](../).
