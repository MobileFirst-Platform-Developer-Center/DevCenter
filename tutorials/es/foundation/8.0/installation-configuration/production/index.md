---
layout: tutorial
title: Instalación de MobileFirst Server para un entorno de producción 
breadcrumb_title: Production Environment
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Esta sección proporciona detalles para ayudarle a planificar y a preparar una instalación para el entorno específico.  
Para obtener más información acerca de la configuración de {{ site.data.keys.mf_server }}, consulte [Configuración de {{ site.data.keys.mf_server }}](server-configuration).

#### Ir a
{: #jump-to }

* [Requisitos previos](#prerequisites)
* [A continuación](#whats-next)

## Requisitos previos
{: #prerequisites }
Para una instalación sin problemas de {{ site.data.keys.mf_server }}, asegúrese de cumplir todos los requisitos previos de software.

**Sistema de gestión de bases de datos (DBMS)**  
Un DBMS es necesario para almacenar los datos técnicos de los componentes de {{ site.data.keys.mf_server }}. Debe utilizar uno de los DBMS soportados:

* IBM DB2 
* MySQL
* Oracle

Para obtener más información sobre las versiones de DBMS soportadas por el producto, consulte [Requisitos del sistema](../../product-overview/requirements). Si utiliza un DBMS relacional (IBM DB2, Oracle, o MySQL), necesita el controlador JDBC para esa base de datos durante el proceso de instalación. Los controladores JDBC no los proporciona el instalador de {{ site.data.keys.mf_server }}. Asegúrese de que tiene el controlador JDBC.

* Para DB2, utilice el controlador JDBC de DB2 V4.0 (db2jcc4.jar).
* Para MySQL, utilice el controlador JDBC de Connector/J.
* Para Oracle, utilice el controlador JDBC ligero de Oracle.

**Servidor de aplicaciones Java**  
Se necesita un servidor de aplicaciones Java para ejecutar las aplicaciones {{ site.data.keys.mf_server }}. Puede utilizar cualquiera de los siguientes servidores de aplicaciones:

* WebSphere Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

Para obtener más información sobre las versiones de servidores de aplicaciones que están soportadas por el producto, consulte [Requisitos del sistema](../../product-overview/requirements). El servidor de aplicaciones debe ejecutarse con Java 7 o posterior. De forma predeterminada, algunas versiones de WebSphere Application Server se ejecutan con Java 6. Con este valor predeterminado, no pueden ejecutar {{ site.data.keys.mf_server }}

**IBM Installation Manager V1.8.4 o posterior**  
Installation Manager se utiliza para ejecutar el instalador de {{ site.data.keys.mf_server }}. Debe instalar Installation Manager V1.8.4 o posterior. Las versiones anteriores de Installation Manager no están disponibles para instalar {{ site.data.keys.product_full }} {{ site.data.keys.product_version }} porque las operaciones posteriores a la instalación del producto requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.

Descargue el instalador de IBM Installation Manager V1.8.4 o posterior de [Enlaces de descarga de Installation Manager y Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).

**Repositorio de Installation Manager para {{ site.data.keys.mf_server }}**  
Puede descargar el repositorio desde {{ site.data.keys.product }} eAssembly en [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). El nombre del paquete es **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} archivo .zip de Installation Manager Repository for IBM MobileFirst Platform Server**.

También es posible que desee aplicar el fixpack más reciente que se puede descargar desde [IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). El fixpack no se puede instalar sin el repositorio de la versión base en los repositorios de Installation Manager.

{{ site.data.keys.product }} eAssembly incluye los siguientes instaladores:

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Para Liberty, también puede utilizar la edición IBM WebSphere SDK Java Technology con el suplemento de IBM WebSphere Application Server Liberty Core.

## A continuación
{: #whats-next }

* [Ejecución de IBM Installation Manager](installation-manager)
* [Configuración de bases de datos](databases)
* [Flujos de red y topologías](topologies)
* [Instalación de {{ site.data.keys.mf_server }} en un servidor de aplicaciones](appserver)
