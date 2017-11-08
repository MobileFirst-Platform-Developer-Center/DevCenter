---
layout: tutorial
title: Instalación y configuración de MobileFirst Analytics Server
breadcrumb_title: Instalación de MobileFirst Analytics Server
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.mf_analytics_server }} se proporciona como dos archivos WAR independientes. Para su comodidad en el despliegue de WebSphere Application Server o WebSphere Application Server Liberty, {{ site.data.keys.mf_analytics_server }} también se proporciona como un archivo EAR que contiene los dos archivos WAR.

> **Nota:** No instale más de una instancia de {{ site.data.keys.mf_analytics_server }} en una única máquina host. Para obtener más información sobre cómo gestionar el clúster, consulte la documentación de Elasticsearch.

Los archivos WAR y EAR de análisis se incluyen con la instalación de MobileFirst Server. Para obtener más información, consulte la Estructura de distribución de MobileFirst Server. Al desplegar el archivo WAR, la consola de MobileFirst Analytics estará disponible en: `http://<hostname>:<port>/analytics/console`, por ejemplo: `http://localhost:9080/analytics/console`.

* Para obtener más información sobre cómo instalar {{ site.data.keys.mf_analytics_server }}, consulte [Guía de instalación de {{ site.data.keys.mf_analytics_server }}](installation).
* Para obtener más información sobre cómo configurar IBM MobileFirst Analytics, consulte [Guía de configuración](configuration).
