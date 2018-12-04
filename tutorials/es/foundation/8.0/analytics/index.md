---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

{{ site.data.keys.mf_analytics_full }} recopila datos de las actividades entre las aplicaciones y el servidor, los registros de los clientes, los bloqueos de clientes y los registros del lado del servidor desde los dispositivos de cliente y {{ site.data.keys.mf_server }}. Los datos recopilados proporcionan una visión completa tanto de la infraestructura del servidor como de la distribución móvil. Se incluyen: informes predeterminados sobre la retención de usuarios, informes de bloqueos, desglose por tipos de dispositivo y sistemas operativos, gráficos personalizados y datos personalizados, utilización de red, resultados de notificaciones push, comportamiento interno de las aplicaciones o recopilación de datos de depuración entre otros.

{{ site.data.keys.mf_server }} viene preparado con una funcionalidad de creación de informes de la infraestructura de red. Cuando el cliente y el servidor informan sobre el uso de la red, los datos se agregan de forma que es posible atribuir un mal comportamiento a la red, al servidor o a los sistemas de fondo. Además, es posible controlar los datos de registrador a los que se accede y que son utilizados por las analíticas mediante la definición de filtros en el lado del cliente y en {{ site.data.keys.mf_analytics_server }}. Es posible elegir la política de retención de datos y el nivel de detalle de los sucesos de los que se informa, establecer alertas condicionales, crear gráficos personalizados y adquirir nuevos datos.

#### Soporte de plataformas
{: #platform-support }

{{ site.data.keys.mf_analytics }} da soporte a:

* Clientes Android e iOS nativos
* Aplicaciones Cordova (iOS, Android)
* Aplicaciones web
* El soporte para Windows 8.1 Universal o Windows 10 UWP **no está disponible**.

IBM {{ site.data.keys.mf_server }} viene preparado con una funcionalidad de creación de informes de la infraestructura de red. Cuando el cliente y el servidor informan sobre su uso de la red, los datos se agregan de forma que es posible atribuir un mal comportamiento a la red, al servidor o a los sistemas de fondo.

## Desarrollo de cliente
{: #client-development }

Hay dos clases de cliente que trabajan conjuntamente para enviar datos sin procesar al servidor: las clases de registrador (Logger) y analíticas (Analytics).

### API de analíticas
{: #the-analytics-api }

La API de cliente de analíticas recopila datos distintos sucesos y los envía a {{ site.data.keys.mf_analytics_server }}.
> Obtenga más información en la guía de aprendizaje de [Desarrollo de cliente de analíticas](analytics-api).

### API de registrador
{: #the-logger-api }

Las funciones del registrador son las de un registrador estándar. Desde el cliente también se pueden enviar datos de registrador a {{ site.data.keys.mf_analytics_server }} en cualquier nivel de registro. Sin embargo, la configuración del servidor controla qué nivel de solicitudes de registro se permiten. Las solicitudes que se envían por debajo de este umbral se omiten.

Es necesario controlar los niveles de registro para encontrar un equilibrio entre dos necesidades: la necesidad de recopilar información y la necesidad de limitar la cantidad de datos para adecuarla a las posibilidades de los límites del almacenamiento.

> Obtenga más información en la guía de aprendizaje de [Registro de cliente](../application-development/client-side-log-collection/).

Además, es posible controlar los datos de registrador a los que se accede y que son utilizados por las analíticas mediante la definición de filtros en el lado del cliente y en {{ site.data.keys.mf_analytics_server }}.

## Las consolas de operaciones y analíticas
{: #the-analytics-and-operations-consoles }

{{ site.data.keys.product_full }} proporciona las consolas de analíticas y operaciones. {{ site.data.keys.mf_console_full }} configura la forma en la que el servidor de analíticas funciona con las aplicaciones de cliente. El {{ site.data.keys.mf_analytics_console_full }} configura y visualiza los distintos informes de analíticas.

> Obtenga más información en la guía de aprendizaje de la [Consola de operaciones](console).

> Obtenga más información sobre la creación de gráficos personalizados con la consola de analíticas en la guía de aprendizaje de [Gráficos personalizados](console/custom-charts).

## El servidor da analíticas
{: #the-analytics-server }

El servidor de analíticas está disponible tanto en los entornos de desarrollo como de producción.

En el entorno de desarrollo, el servidor de analíticas se instala junto con {{ site.data.keys.mf_dev_kit }}.  Para obtener más información, consulte [Configuración del entorno de desarrollo {{ site.data.keys.product_adj }}](../installation-configuration/development/mobilefirst/). Una vez que el kit está instalado, {{ site.data.keys.mf_analytics_console_short }} está disponible para las necesidades de desarrollo.

En el entorno de producción, hay disponibles diferentes opciones de instalación y configuración, de acuerdo con la infraestructura disponible, las necesidades empresariales, el diseño del sistema, etc. Para obtener más información, consulte [Configuración del entorno de desarrollo {{ site.data.keys.product_adj }}](../installation-configuration/production/analytics/).

{{ site.data.keys.mf_analytics }} utiliza Elasticsearch. [Aprenda a utilizar Elasticsearch](elasticsearch) en {{ site.data.keys.product }}.

## Resolución de problemas
{: #troubleshotting }

Para obtener información sobre la resolución de problemas {{ site.data.keys.mf_analytics }}, consulte [Resolución de problemas de analíticas](../troubleshooting/analytics/).

## Qué leer a continuación
{: #what-to-read-next }
