---
layout: tutorial
title: Requisitos previos para la instalación
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Para una instalación sin problemas de MobileFirst Server, asegúrese de cumplir todos los requisitos previos de software.

Antes de instalar MobileFirst Server, tiene que tener el software siguiente.

* **Sistema de gestión de bases de datos (DBMS)**
  Un DBMS es necesario para almacenar los datos técnicos de los componentes de MobileFirst Server. Debe utilizar uno de los DBMS soportados:

  * IBM DB2
  * MySQL
  * Oracle

  Para obtener más información sobre las versiones de DBMS soportadas por el producto, consulte [Requisitos del sistema](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). Si utiliza un DBMS relacional (IBM DB2, Oracle, o MySQL), necesita el controlador JDBC para esa base de datos durante el proceso de instalación. Los controladores JDBC no los proporciona el instalador de MobileFirst Server. Asegúrese de que tiene el controlador JDBC.

  * Para DB2, utilice el controlador JDBC de DB2 V4.0 (db2jcc4.jar).
  * Para MySQL, utilice el controlador JDBC de Connector/J.
  * Para Oracle, utilice el controlador JDBC ligero de Oracle.

* **Servidor de aplicaciones Java™**
  Se necesita un servidor de aplicaciones Java para ejecutar las aplicaciones de MobileFirst Server. Puede utilizar cualquiera de los siguientes servidores de aplicaciones:

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  Para obtener más información sobre las versiones de servidores de aplicaciones que están soportadas por el producto, consulte [Requisitos del sistema](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). El servidor de aplicaciones debe ejecutarse con Java 7 o posterior. De forma predeterminada, algunas versiones de WebSphere Application Server se ejecutan con Java 6. Con este valor predeterminado, no pueden ejecutar MobileFirst Server.

* **IBM Installation Manager V1.8.4 o posterior**
  Installation Manager se utiliza para ejecutar el instalador de MobileFirst Server. Debe instalar Installation Manager V1.8.4 o posterior. Las versiones anteriores de Installation Manager no están disponibles para instalar IBM MobileFirst Platform Foundation V8.0 porque las operaciones posteriores a la instalación del producto requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.

  Descargue el instalador de IBM Installation Manager V1.8.4 o posterior de [Enlaces de descarga de Installation Manager y Packaging Utility](http://www-01.ibm.com/support/docview.wss?uid=swg27025142).

* **Repositorio de Installation Manager para MobileFirst Server**
  Puede descargar el repositorio desde IBM MobileFirst Platform Foundation eAssembly en [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm). El nombre del paquete es el archivo `IBM MobileFirst Platform Foundation V8.0.zip` de Installation Manager Repository for IBM MobileFirst Platform Server.

  También es posible que desee aplicar el fixpack más reciente que se puede descargar desde [IBM Support Portal](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation). El fixpack no se puede instalar sin el repositorio de la versión base en los repositorios de Installation Manager.

IBM MobileFirst Platform Foundation eAssembly incluye los siguientes instaladores:
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Para Liberty, también puede utilizar la edición IBM WebSphere SDK Java Technology con el suplemento de IBM WebSphere Application Server Liberty Core.

## Tema padre
{: #parent-topic }

* [Instalación de MobileFirst Server en un entorno de producción](../).
