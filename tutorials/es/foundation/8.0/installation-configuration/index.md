---
layout: tutorial
title: Instalación y configuración
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona herramientas de desarrollo y componentes del lado del servidor que puede instalar de forma local o desplegar en la nube para pruebas o uso de producción. Revise los temas de instalación adecuados para el escenario de instalación.

### Instalación de un entorno de desarrollo
{: #installing-a-development-environment }
Si desarrolla el lado del cliente o el lado del servidor de aplicaciones móviles, utilice [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) o el [servicio de {{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation) para comenzar.

* [Configure el entorno de desarrollo de MobileFirst](development/mobilefirst/)
* [Configure el entorno de desarrollo de Cordova](development/cordova)
* [Configure el entorno de desarrollo de iOS](development/ios)
* [Configure el entorno de desarrollo de Android](development/android)
* [Configure el entorno de desarrollo de Windows](development/windows)
* [Configure el entorno de desarrollo de Xamarin](development/xamarin)
* [Configure el entorno de desarrollo de Web](development/web)

### Instalación de un servidor de prueba o de producción local
{: #installing-a-test-or-production-server-on-premises }
Las instalaciones de IBM se basan en un producto de IBM llamado IBM Installation Manager. Instale IBM Installation Manager V1.8.4 o posterior por separado antes de instalar {{ site.data.keys.product }}.

> **Importante:** Asegúrese de que utiliza IBM Installation Manager V1.8.4 o posterior. Las versiones anteriores de Installation Manager no están disponibles para instalar {{ site.data.keys.product }} {{ site.data.keys.product_version }} porque las operaciones posteriores a la instalación del producto requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.
El instalador de {{ site.data.keys.mf_server }} copia en el sistema todas las herramientas y bibliotecas necesarias para desplegar componentes de {{ site.data.keys.mf_server }} y opcionalmente {{ site.data.keys.mf_app_center_full }} en el servidor de aplicaciones.

Si instala una prueba o el servidor de producción, empiece por **Guía de aprendizajes sobre la instalación de {{ site.data.keys.mf_server }}** a continuación para una instalación sencilla y para obtener más información sobre la instalación de {{ site.data.keys.mf_server }}. Para obtener más información sobre cómo preparar una instalación para el entorno específico, consulte [Instalación de {{ site.data.keys.mf_server }} para un entorno de producción](production).

**Guías de aprendizaje sobre la instalación de {{ site.data.keys.mf_server }}**  
Obtenga más información sobre el proceso de instalación de {{ site.data.keys.mf_server }} examinando las instrucciones para crear {{ site.data.keys.mf_server }} funcional, un clúster con dos nodos en el perfil de WebSphere Application Server Liberty. La instalación puede hacerse de dos maneras:

* [Utilizando la modalidad gráfica de IBM Installation Manager](production/tutorials/graphical-mode) y la Herramienta de configuración del servidor.
* [Utilizando la herramienta de línea de mandatos](production/tutorials/command-line).

Posteriormente tendrá un {{ site.data.keys.mf_server }} en funcionamiento. Sin embargo, debe configurarlo, en particular para la seguridad, antes de utilizar el servidor. Para obtener más información, consulte [Configuración de {{ site.data.keys.mf_server }}](production/server-configuration).

**Adiciones**  

* Para añadir {{ site.data.keys.mf_analytics_server }} a su instalación, consulte la [guía de instalación de {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/).  
* Para instalar {{ site.data.keys.mf_app_center }}, consulte [Instalación y configuración de Application Center](production/appcenter).

### Despliegue de {{ site.data.keys.mf_server }} en la nube
{: #deploying-mobilefirst-server-to-the-cloud }
Si tiene la intención de desplegar {{ site.data.keys.mf_server }} en la nube, consulte las siguientes opciones:

* [Utilización de {{ site.data.keys.mf_server }} en IBM Bluemix](../bluemix).
* [Utilización de {{ site.data.keys.mf_server }} en IBM PureApplication](production/pure-application).

### Actualización desde versiones anteriores
{: #upgrading-from-earlier-versions }
Para obtener información sobre cómo actualizar instalaciones y aplicaciones existentes a una versión más reciente, consulte [Actualización a {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).


