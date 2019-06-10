---
layout: tutorial
title: Registro en adaptadores JavaScript
relevantTo: [ios,android,windows,javascript]
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Esta guía de aprendizaje ofrece fragmentos de código necesarios para añadir funcionalidades de registro en un adaptador JavaScript.

## Ejemplo de creación de registro
{: #logging-example }

La salida del siguiente mensaje es en el archivo `trace.log` del servidor de aplicaciones. Si el administrador del servidor está reenviando registros desde {{ site.data.keys.mf_server }} a {{ site.data.keys.mf_analytics_server }} el mensaje del `registrador` también aparecerá en la vista **Infraestructura → Buscar en registro de servidores** en {{ site.data.keys.mf_analytics_console }}.

```javascript
MFP.Logger.debug("This is a debug message from a JavaScript adapter");
```

Niveles de creación de registro adicionales, de menos detalle a más detalle son: ERROR, WARN, INFO, LOG y DEBUG.

## Acceso a los archivos de registro
{: #accessing-the-log-files }

* En una instalación local de {{ site.data.keys.mf_server }}, el archivo está disponible dependiendo del servidor de aplicaciones subyacente.
    * [Perfil completo de IBM WebSphere Application Server](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [Perfil de IBM WebSphere Application Server Liberty](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* Para obtener los registros en un despliegue en la nube en:
    * IBM Containers o Liberty Build Pack, consulte la guía de aprendizaje [Recopilación de rastreo y registro de IBM Containers](../../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/).
    * Servicio Mobile Foundation IBM Cloud, consulte la sección [Acceso a registros de servidor](../../../bluemix/using-mobile-foundation/#accessing-server-logs) en la guía de aprendizaje [Utilización de Mobile Foundation](../../../bluemix/using-mobile-foundation).

## Reenvío de registros al servidor de Analytics
{: #forwarding-logs-to-the-analytics-server }

Los registros también se pueden reenviar a la consola de Analytics.

1. En {{ site.data.keys.mf_console }} seleccione la opción **Valores** desde la navegación de la barra lateral.
2. Pulse el botón **Editar** en el separador **Propiedades de entorno de ejecución**.
3. En la sección **Analíticas → Paquetes adicionales**, especifique **MFP.Logger** para reenviar registros de adaptador JavaScript a {{ site.data.keys.mf_server }}.

![Filtrado de registro desde la consola](javascript-filter.png)
