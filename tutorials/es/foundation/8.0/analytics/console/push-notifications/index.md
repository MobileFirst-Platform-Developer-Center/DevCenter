---
layout: tutorial
title: Notificaciones push
breadcrumb_title: Notificaciones push
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

Una vez configurado el soporte de {{ site.data.keys.mf_analytics }} para las notificaciones push (consulte [Configuración del soporte de analíticas](../../../notifications/analytics/)), será posible crear informes sobre la utilización de push.


## Informes push
{: #push-reports }

Los informes de notificaciones push pasan a estar disponibles después de haber configurado {{ site.data.keys.mf_analytics_short }}. Los sucesos de push se envían al servicio de {{ site.data.keys.mf_analytics_short }}.


1. En {{ site.data.keys.mf_analytics_console }}, elija la sección de **Infraestructura** desde la barra de navegación.

2. Elija el separador **Notificaciones push**.


Se visualizan dos tipos de informe: 

**Solicitudes de notificación**  
El número de solicitudes se muestra de acuerdo con el periodo, las aplicaciones y las versiones solicitadas, desglosadas por fecha.


**Notificación por mediador**  
El número de solicitudes se desglosa por plataforma de aplicación, para el periodo, las aplicaciones y las versiones.


![Informes de notificaciones push](pushNotifications.png)
