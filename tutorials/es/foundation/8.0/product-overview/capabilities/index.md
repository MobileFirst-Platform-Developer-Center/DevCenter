---
layout: tutorial
title: Prestaciones principales del producto
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Con {{ site.data.keys.product_full }}, puede utilizar prestaciones como el desarrollo, pruebas, conexiones de fondo, notificaciones push, modo fuera de línea, actualizaciones, seguridad, analíticas, supervisión y publicación de aplicaciones.

### Desarrollo
{: #deployment }
{{ site.data.keys.product }} proporciona una infraestructura que permite el desarrollo, la optimización, la integración y la gestión de aplicaciones seguras que se ejecutan en los teléfonos inteligentes y en otros entornos del consumidor. {{ site.data.keys.product }} no introduce un lenguaje de programación de propietario o un nuevo modelo que aprender.

Puede desarrollar sus aplicaciones con HTML5, CSS3 y JavaScript. Opcionalmente, puede escribir código nativo (Java u Objective-C). {{ site.data.keys.product }} proporciona un SDK que incluye bibliotecas a las que puede acceder desde código nativo.

#### Plataformas soportadas:
{: #supported-platforms }
Los SDK de {{ site.data.keys.product }} dan soporte a las siguientes plataformas:

* iOS
* Android
* Windows Universal 8.1 y Windows 10 UWP
* Aplicaciones web

### Conexiones de fondo
{: #back-end-connections }
Algunas aplicaciones se ejecutan exclusivamente fuera de línea y sin conexión a un sistema de fondo; aun así, la mayoría se conectan a servicios de negocio existentes para proporcionar funciones críticas relacionadas con el usuario. Por ejemplo, los clientes podrán utilizar una aplicación para comprar en cualquier sitio y a cualquier hora, independientemente del horario de apertura del establecimiento. Sus pedidos se procesarán mediante la plataforma de comercio electrónico existente del establecimiento. Para integrar una aplicación con servicios de negocios, debe utilizar un middleware como, por ejemplo, una pasarela móvil. {{ site.data.keys.product }} puede actuar como esta solución middleware y facilitar la comunicación con servicios de fondo.

### Notificaciones push
{: #push-notifications }
Con las notificaciones push, las aplicaciones de empresa pueden enviar información a los dispositivos móviles, incluso si la aplicación no se está utilizando. {{ site.data.keys.product }} incluye una infraestructura de notificaciones unificadas que proporciona un mecanismo coherente para dichas notificaciones push. Con esta infraestructura de notificación unificada, puede enviar notificaciones push sin necesidad de conocer los detalles de cada dispositivo o plataforma de llegada, ya que cada plataforma tiene un mecanismo diferente para este tipo de notificaciones push.

### Modalidad fuera de línea
{: #offline-mode }
En términos de conectividad, las aplicaciones pueden funcionar fuera de línea, en línea o en una modalidad mixta. {{ site.data.keys.product }} utiliza una arquitectura cliente/servidor que detecta si el dispositivo tiene conectividad de red y qué tipo de calidad tiene. Actuando como un cliente, las aplicaciones intentan periódicamente conectarse al servidor y determinar la calidad de la conexión. Una aplicación con la modalidad de fuera de línea habilitada puede utilizarse cuando un dispositivo móvil carece de conectividad; no obstante, algunas funciones pueden estar limitadas. La creación de este tipo de aplicaciones es útil, porque almacenan información sobre el dispositivo móvil y ayuda a preservar su funcionalidad en la modalidad fuera de línea. Esta información, normalmente, proviene de un sistema de fondo; además, debe considerar la sincronización de datos con el componente de fondo como parte de la arquitectura de la aplicación. {{ site.data.keys.product }} incluye una función que se denomina JSONStore para el intercambio de datos y almacenamiento. Con esta característica, puede crear, leer, actualizar y suprimir registros de datos procedentes de un origen de datos. Cada operación se pondrá en cola cuando se trabaje fuera de línea. Cuando haya una conexión disponible, la operación se transfiere al servidor y se llevará a cabo en relación a los datos de origen.

### Actualización
{: #update }
{{ site.data.keys.product }} simplifica la gestión de versiones y la compatibilidad de aplicaciones móviles. Cuando un usuario inicia una aplicación, ésta se comunica con un servidor. Mediante este servidor, {{ site.data.keys.product }} determina si existe una versión más reciente de la aplicación y, si es el caso, ofrece información al usuario sobre la actualización o envía una actualización de aplicación al dispositivo. El servidor también puede forzar la actualización a la última versión para evitar un uso continuado de una versión anticuada.

### Seguridad
{: #security }
La protección de información confidencial y privada es crucial para todas las aplicaciones de una empresa, incluidas las móviles. La seguridad en las aplicaciones móviles se aplica a varios niveles como, por ejemplo, en las propias aplicaciones, en los servicios que dan o en el servicio de fondo. Debe asegurarse de que la privacidad del cliente y los datos confidenciales están protegidos y que ningún usuario no autorizado acceda a ellos. Tratar con dispositivos móviles privados significa renunciar al control en determinados niveles inferiores de seguridad como, por ejemplo, en el sistema operativo móvil.

{{ site.data.keys.product }} proporciona una comunicación segura de principio a fin mediante un servidor que supervisa el flujo de datos entre la aplicación y los sistemas de fondo. Con {{ site.data.keys.product }}, puede definir manejadores de seguridad personalizados para cualquier acceso a este flujo de datos. Puesto que cualquier acceso a datos de un teléfono móvil aplicación tiene que pasan a través de esta instancia de servidor, puede definir los manejadores de seguridad diferente para aplicaciones móviles, aplicaciones web, y viceversa- finalizar el acceso. Con este tipo de seguridad granular, puede definir niveles de autenticación separados para diversas funciones de la aplicación. También puede impedir que las aplicaciones móviles accedan a información confidencial.

### Analíticas
{: #analytics }
La característica {{ site.data.keys.mf_analytics }} permite buscar en aplicaciones, servicios, dispositivos y otros orígenes para recopilar datos sobre su utilización o para detectar problemas.

Además de los informes de resumen sobre la actividad de las aplicaciones, {{ site.data.keys.product }} incluye una plataforma escalable de analíticas de funcionamiento, a la que se puede acceder desde la consola de {{ site.data.keys.mf_console }}. La característica {{ site.data.keys.mf_analytics_short }} permite que las empresas busquen en registros y sucesos recopilados por los dispositivos, las aplicaciones, los servidores para patrones, los problemas y las estadísticas de utilización de la plataforma. Puede habilitar los análisis, los informes, o ambos, de acuerdo a sus necesidades.

### Supervisión
{: #monitoring }
{{ site.data.keys.product }} incluye una serie de analíticas operativas y mecanismos de creación de informes para la recopilación, visualización y análisis de datos de las aplicaciones y los servidores de {{ site.data.keys.product }} y para supervisar el estado general del servidor.

### Publicación de aplicaciones
{: #application-publishing }
{{ site.data.keys.product }} Application Center es similar a una tienda de aplicaciones empresariales. Con Application Center, puede instalar, configurar y administrar un repositorio de aplicaciones móviles para un uso individual o de grupo de toda la empresa. Puede controlar quién de la organización puede acceder a Application Center y cargar aplicaciones al repositorio de Application Center y, también, quiénes pueden descargar e instalar dichas aplicaciones en un dispositivo móvil. También puede utilizar el Application Center para recopilar comentarios de los usuarios y acceder a información sobre los dispositivos en los que se han instalado las aplicaciones.

El concepto de Application Center es similar a la App Store pública de Apple o a la tienda de Google Play; pero difiere en que el destino es el proceso de desarrollo.

Application Center proporciona un repositorio para almacenar los archivos de la aplicación móvil y una consola basada en web para gestionar dicho repositorio. Application Center también proporciona una aplicación de cliente móvil que permite a los usuarios navegar por el catálogo de aplicaciones que Application Center ha almacenado, instalar aplicaciones, proporcionar información de comentarios al equipo de desarrollo y exponer aplicaciones de producción en IBM Endpoint Manager. El acceso a la descarga e instalación de aplicaciones desde Application Center está controlado mediante listas de control de acceso (ACL).
