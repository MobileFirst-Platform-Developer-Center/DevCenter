---
title: Recopilación de registros del lado del servidor
breadcrumb_title: Recopilación de registros del lado del servidor
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general 
{: #overview }

La creación de registros es la instrumentación del código fuente que utiliza llamadas de API para grabar mensajes con el propósito de facilitar la depuración y los diagnósticos. {{ site.data.keys.mf_server }} proporciona la posibilidad de controlar los registros que se deben recopilar de forma remota. Esto ofrece el administrador del servidor un control más preciso sobre los recursos del servidor. 

Las bibliotecas de creación de registros habitualmente tienen controles de detalle de registro que habitualmente se denominan **niveles**. De menos detalle a más detalle son: ERROR, WARN, INFO y DEBUG. 

## Recopilación de registro en adaptadores
{: #log-collection-in-adapters }

Los registros en los adaptadores se pueden visualizar en el mecanismo de registro del servidor de aplicaciones subyacente.     
En el perfil completo de WebSphere y en el perfil de Liberty, se utilizan los archivos **messages.log** y **trace.log**, dependiendo del nivel de creación de registro especificado.    

Estos registros también se pueden reenviar a la consola de analíticas tal como se explicó en las guías de aprendizaje para [Adaptadores Java](java-adapter) y [Adaptadores JavaScript](javascript-adapter).  

## Acceso a los archivos de registro
{: #accessing-the-log-files }

* En una instalación local de {{ site.data.keys.mf_server }}, el archivo está disponible dependiendo del servidor de aplicaciones subyacente.  
    * [Perfil completo de IBM WebSphere Application Server](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [Perfil de IBM WebSphere Application Server Liberty](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* Para obtener los registros en un despliegue en la nube en: 
    * IBM Containers o Liberty Build Pack, consulte la guía de aprendizaje [Recopilación de rastreo y registro de IBM Containers](../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/).  
    * Servicio Mobile Foundation Bluemix, consulte la sección [Acceso a registros de servidor](../../bluemix/using-mobile-foundation/#accessing-server-logs) en la guía de aprendizaje [Utilización de Mobile Foundation](../../bluemix/using-mobile-foundation). 
