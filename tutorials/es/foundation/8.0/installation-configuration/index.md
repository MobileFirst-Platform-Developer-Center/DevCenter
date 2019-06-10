---
layout: tutorial
title: Instalación y configuración
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona herramientas de desarrollo y componentes del lado del servidor que puede instalar de forma local o desplegar en la nube para pruebas o uso de producción. Revise los temas de instalación adecuados para el escenario de instalación.

### Configurar un entorno de desarrollo
{: #installing-a-development-environment }
Si desarrolla el lado del cliente o el lado del servidor de las aplicaciones móviles, utilice el servicio
[{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) o el servicio  [{{ site.data.keys.mf_bm }} ](../bluemix/using-mobile-foundation) para comenzar.

**Uso de {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

{{ site.data.keys.mf_dev_kit }} incluye todo lo que se necesita para ejecutar y depurar aplicaciones móviles en una estación de trabajo personal. Para desarrollar una aplicación mediante {{ site.data.keys.mf_dev_kit }}, siga el tutorial  [Configuración del entorno de desarrollo de MobileFirst](development/mobilefirst).

**Uso de {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

El servicio de {{ site.data.keys.mf_bm }} proporciona una funcionalidad similar al  {{ site.data.keys.mf_dev_kit }}, sin embargo, el servicio se ejecuta en IBM Cloud.

**Configuración del entorno de desarrollo para aplicaciones  {{ site.data.keys.product }} **
{: #setting-dev-env-mf-apps }

{{ site.data.keys.product }} proporciona una flexibilidad enorme en relación con las plataformas y las herramientas que pueden utilizarse para desarrollar aplicaciones de  {{ site.data.keys.product }}. Sin embargo son necesarias algunas configuraciones básicas para habilitar las herramientas seleccionadas para
interactuar con  {{ site.data.keys.product }}.  

Seleccione entre los siguientes enlaces para configurar el entorno de desarrollo en relación con el método de desarrollo que utilizará la aplicación:

* [Configure el entorno de desarrollo de Cordova](development/cordova)
* [Configure el entorno de desarrollo de iOS](development/ios)
* [Configure el entorno de desarrollo de Android](development/android)
* [Configure el entorno de desarrollo de Windows](development/windows)
* [Configure el entorno de desarrollo de Xamarin](development/xamarin)
* [Configure el entorno de desarrollo de Web](development/web)

### Configuración de un servidor de prueba o de producción local
{: #installing-a-test-or-production-server-on-premises }

La primera parte de la instalación de los usos del servidor de {{ site.data.keys.product }} utiliza un producto de IBM llamado IBM Installation Manager. IBM Installation Manager v1.8.4 o superior deberá instalarse antes de instalar los componentes del Servidor {{ site.data.keys.product }}.

> **Importante:** Asegúrese de que utiliza IBM Installation Manager V1.8.4 o posterior. Las versiones anteriores de Installation Manager no están disponibles para instalar {{ site.data.keys.product }} {{ site.data.keys.product_version }} porque las operaciones posteriores a la instalación del producto requieren Java 7. Las versiones anteriores de Installation Manager se suministran con Java 6.

El asistente de instalación de {{ site.data.keys.mf_server }} utiliza IBM Installation Manager para colocar todos los componentes en el servidor.  Las herramientas y bibliotecas que también están instaladas requieren desplegar los componentes del servidor {{ site.data.keys.product }}
al servidor de aplicaciones.  Se recomienda que no se instale todos los componentes en la misma instancia del servidor de aplicaciones, excepto en caso de un servidor de desarrollo. Las herramientas de desarrollo permiten la selección de los componentes que se deben instalar.  Consulte[Flujos de red y topologías](production/prod-env/topologies) para considerar algunos puntos antes de instalar el servidor.

Lea más adelante, para obtener información sobre la preparación e instalación de {{ site.data.keys.mf_server }} y otros servicios opcionales para su entorno específico. Para una configuración sencilla, lea el tutorial [Configurar una prueba o entorno de producción ](production).

* [Verificación de requisitos previos](production/prod-env/prereqs)
* [{{ site.data.keys.mf_server }} descripción general de componentes ](production/prod-env/topologies)
* Los factores que deben considerarse antes de cargar las herramientas y bibliotecas para desplegar los componentes de MobileFirst Server opcionalmente
  * licencia de señal
  * MobileFirst Foundation Application Centre
  * Administrador frente a modalidad de usuario
* Estructura de distribución de MobileFirst Server después de cargar archivos
* Cargar archivos mediante
  * el uso del asistente de instalación IBM Installation Manager
  * la ejecución de IBM Installation Manager en la línea de mandatos
  * el uso del archivo de respuestas XML, instalación silenciosa
* [Configuración base de datos de fondo para componentes de MobileFirst Foundation Server ](production/prod-env/databases)
* [Instalación de MobileFirst Server en un servidor de aplicaciones](production/prod-env/appserver)
* [Configuración de MobileFirst Server](production/server-configuration)
* [Instalación de MobileFirst Analytics Server](production/analytics/installation)
* [Instalación de Application Center](production/appcenter)
* [Despliegue de MobileFirst Server en IBM PureApplication System](production/pure-application)

### Configuración de un entorno de prueba o producción
{: #setting-up-test-or-production-server}

Obtenga más información sobre el proceso de instalación de {{ site.data.keys.mf_server }} siguiendo las instrucciones para crear un clúster funcional de {{ site.data.keys.mf_server }} con dos nodos en el perfil de WebSphere Application Server Liberty. La instalación puede completarse utilizando herramientas gráficas (GUI) o líneas de mandatos.

* [La instalación del modo GUI con IBM Installation Manager y la herramienta de configuración del servidor ](production/simple-install/tutorials/graphical-mode).
* [Instalación de la línea de mandatos con la herramienta de línea de mandatos](production/simple-install/tutorials/command-line).

Después de completar la instalación mediante uno de los dos métodos anteriores, podría necesitarse la [configuración](production/server-configuration) posterior según los requisitos.

### Configuración de características opcionales en su prueba o entorno de producción
{: #setting-up-optional-features-test-or-production-server}

{{ site.data.keys.product }} incluye componentes opcionales que pueden utilizarse para aumentar el entorno de prueba o de producción.  Consulte los siguientes tutoriales para obtener más información:

* [Instalación y configuración de  {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/)
* [Instalación y configuración de {{ site.data.keys.mf_app_center }}](production/appcenter)

### Despliegue el entorno de prueba o de producción de {{ site.data.keys.mf_server }} en la nube
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

Si tiene la intención de desplegar {{ site.data.keys.mf_server }} en la nube, consulte las siguientes opciones:

* [Uso de {{ site.data.keys.mf_server }} en IBM Cloud](../bluemix).
* [Utilización de {{ site.data.keys.mf_server }} en IBM PureApplication](production/pure-application).

### Actualización desde versiones anteriores
{: #upgrading-from-earlier-versions }
Para obtener información sobre cómo actualizar instalaciones y aplicaciones existentes a una versión más reciente, consulte [Actualización a {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).
