---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
{{site.data.keys.mf_server }} está formado por varios componentes. Se proporciona una visión general de la arquitectura de {{site.data.keys.mf_server }} para ayudarle a entender las funciones de cada componente.


A diferencia de {{site.data.keys.mf_server }} V7.1 o anterior, el proceso de instalación de la versión 8.0.0 está separado del desarrollo y el despliegue de las operaciones de aplicaciones de dispositivo móvil.
En la versión 8.0.0, después de que se hayan configurado e instalado los componentes y la base de datos, {{site.data.keys.mf_server }} puede funcionar para la mayoría de sus operaciones sin la necesidad de acceder a la configuración de la base de datos o al servidor de aplicaciones.


La administración y las operaciones de despliegue de los artefactos de {{site.data.keys.product_adj }} se realizan por medio de {{site.data.keys.mf_console }}, o la API REST del servicio de administración de {{site.data.keys.mf_server }}.
Las operaciones también se pueden realizar utilizando algunas herramientas de línea de mandatos que engloban esta interfaz de programación de aplicaciones como, por ejemplo, mfpdev o mfpadm.
Los usuarios autorizados de {{site.data.keys.mf_server }} pueden modificar la configuración del lado del servidor de las aplicaciones móviles, subir o configurar código del lado del servidor (los adaptadores), subir nuevos recursos web para las aplicaciones móviles Cordova o ejecutar operaciones de gestión de aplicaciones entre otras.


{{site.data.keys.mf_server }} ofrece capas de seguridad adicional, además de las capas de seguridad de la infraestructura de la red o del servidor de aplicaciones.
Las características de seguridad incluyen el control de la autenticidad de las aplicaciones y el control de acceso a los recursos del lado del servidor y los adaptadores.
Estas configuraciones de seguridad también puede ser llevadas a cabo por los usuarios autorizados de {{site.data.keys.mf_console }} y el servicio de administración.
Puede determinar la autorización de los administradores de {{site.data.keys.product_adj }}, al correlacionar dichos administradores con roles de seguridad tal como se describe en [Configuración de la autenticación de usuarios para la administración de {{site.data.keys.mf_server }}](../../../installation-configuration/production/server-configuration).


Hay disponible para los desarrolladores una versión simplificada de {{site.data.keys.mf_server }} que está preconfigurada y que no necesita requisitos previos de software como, por ejemplo, una base de datos o un servidor de aplicaciones.
Consulte [Configuración de un servidor de desarrollo de {{site.data.keys.product_adj }}](../../../installation-configuration/development).


## Componentes de {{site.data.keys.mf_server }}
{ #mobilefirst-server-components }
A continuación se presenta la arquitectura de los componentes de {{site.data.keys.mf_server }}:

![Componentes que componen {{site.data.keys.mf_server }}](server_components.jpg)

### Componentes principales de {{site.data.keys.mf_server }}
{: #core-components-of-mobilefirst-server }
{{site.data.keys.mf_console }}, el servicio de administración de {{site.data.keys.mf_server }}, el servicio de actualización activa de {{site.data.keys.mf_server }}, los artefactos de {{site.data.keys.mf_server }} y el entorno de tiempo de ejecución de {{site.data.keys.product_adj }} es el conjunto mínimo de componentes que se han de instalar.
 

* El tiempo de ejecución proporciona los servicios de {{site.data.keys.product_adj }} para las aplicaciones móviles que se ejecutan en los dispositivos móviles.

* El servicio de administración proporciona las funcionalidades de configuración y administración.
Puede utilizar el servicio de administración a través de {{site.data.keys.mf_console }}, API REST del servicio de actualización activo o herramientas de línea de mandatos como, por ejemplo, mfpadm o mfpdev.
 
* El servicio de actualización activa gestiona datos de configuración que el servicio de administración utiliza.


Estos componentes precisan de una base de datos.
No hay coincidencias entre los nombres de las tablas de base de datos de cada componente.
Por ello, puede utilizar la misma base de datos o incluso el mismo esquema para almacenar todas las tablas de estos componentes.
Para obtener más información, consulte [Configuración de bases de datos](../../../installation-configuration/production/server-configuration).


Es posible instalar más de una instancia del tiempo de ejecución.
En este caso, cada instancia necesita su propia base de datos.
El componente de artefactos proporciona los recursos para {{site.data.keys.mf_console }}.
No precisa de una base de datos.


### Componentes opcionales de {{site.data.keys.mf_server }}
{: #optional-components-of-mobliefirst-server }
El servicio push de {{site.data.keys.mf_server }} proporciona funciones de notificación.
Debe estar instalado para que las aplicaciones móviles utilicen las características push de {{site.data.keys.product_adj }}.
Desde la perspectiva de las aplicaciones móviles, el URL del servicio push es el mismo que el URL en el tiempo de ejecución, con la diferencia que la raíz de contexto es `/imfpush`.


Si tiene pensado instalar el servicio en un servidor o en un clúster distinto del tiempo de ejecución, debe configurar las reglas de direccionamiento de su servidor HTTP.
La configuración es necesaria para asegurarse de que las solicitudes para el servicio push y el tiempo de ejecución se direccionan adecuadamente.
 

El servicio push precisa de una base de datos.
Las tablas del servicio push son distintas de las tablas del tiempo de ejecución, del servicio de administración y del servicio de actualización activa.
Por lo tanto, también se puede instalar en la misma base de datos o esquema.


El servicio {{site.data.keys.mf_analytics }} y {{site.data.keys.mf_analytics_console }} proporcionan información de analíticas y supervisión sobre la utilización de las aplicaciones móviles.
Las aplicaciones móviles pueden proporcionar más información con Logger SDK.
El servicio {{site.data.keys.mf_analytics }} no necesita una base de datos.
Almacena sus datos localmente en disco por utilizando Elasticsearch.
Los datos están estructurados en fragmentos que se pueden replicar entre los miembros de un clúster del servicio Analytics.


Para obtener más información sobre los flujos de red y las restricciones de topología para estos componentes, consulte [Topologías y los flujos de red](../../../installation-configuration/production/server-configuration).


### Proceso de instalación
{: #installation-process }
La instalación de {{site.data.keys.mf_server }} en el entorno local del cliente se puede realizar de las siguientes maneras:


* Server Configuration Tool - un asistente gráfico
* Tareas Ant a través de las herramientas de la línea de mandatos
* Instalación manual

Para obtener más información sobre la instalación de {{site.data.keys.mf_server }} en el entorno local del cliente, consulte:   

* Una [guía a través de toda la instalación](../../../installation-configuration/production/) de una granja de {{site.data.keys.mf_server }} en un perfil WebSphere Application Server Liberty.
La guía se basa en un escenario simple para que pueda probar la instalación tanto en la modalidad gráfica como en la modalidad de línea de mandatos.

* Una [sección detallada](../../../installation-configuration/production/) que contiene detalles acerca de los requisitos previos de instalación, la configuración de la base de datos, las topologías de servidor, el despliegue de los componentes en el servidor de aplicaciones y la configuración de servidor.


