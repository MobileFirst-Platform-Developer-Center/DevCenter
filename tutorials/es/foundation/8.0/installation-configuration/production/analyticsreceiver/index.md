---
layout: tutorial
title: Instalación y configuración de MobileFirst Analytics Receiver Server
breadcrumb_title: Instalación de MobileFirst Analytics Receiver Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Mobile Analytics Receiver Server es un servidor opcional que se puede desplegar para enviar sucesos de Mobile Foundation Analytics desde aplicaciones de cliente móvil, en lugar de desde el tiempo de ejecución de Mobile Foundation Server.  Esta opción de despliegue libera el proceso de sucesos del tiempo de ejecución de Mobile Foundation Server y, por lo tanto, permite que sus recursos se utilicen por completo para funciones de tiempo de ejecución.   

{{ site.data.keys.mf_analytics_receiver_server }} se entrega como un único archivo WAR. Debe instalarlo en un servidor separado. Puede instalarlo con uno de los métodos siguientes:

* Instalación con tareas Ant
* Instalación manual

Después de instalar {{ site.data.keys.mf_analytics_receiver_server }} en el servidor de aplicaciones web de su elección, debe realizar tareas de configuración adicionales. Para obtener más información, consulte Configuración de {{ site.data.keys.mf_analytics_receiver_server }} después de la instalación, a continuación. Si elige la configuración manual en el instalador, consulte la documentación del servidor de aplicaciones de su elección. 

> **Nota:** No instale más de una instancia de {{ site.data.keys.mf_analytics_receiver_server }} en una única máquina host. 

El archivo WAR de Analytics Receiver WAR se incluye con la instalación de MobileFirst Server. Para obtener más información, consulte la Estructura de distribución de MobileFirst Server. 

* Para obtener más información acerca de cómo instalar {{ site.data.keys.mf_analytics_receiver_server }}, consulte [{{ site.data.keys.mf_analytics_receiver_server }} Guía de instalación](installation).
* Para obtener información sobre cómo configurar IBM MobileFirst Analytics Receiver, consulte la [Guía de configuración](configuration).
