---
layout: tutorial
title: Desarrollo de aplicaciones
show_children: true
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general y conceptos para el desarrollo
{: #development-concepts-and-overview }
Cuando desarrolla una aplicación con el conjunto de herramientas de {{ site.data.keys.product_full }}, debe desarrollar o configurar distintos componentes y elementos.
Conocer los componentes y los elementos involucrados al desarrollar una aplicación le ayudará a que proceso de desarrollo transcurra adecuadamente.


Además de familiarizarse con estos conceptos, también aprenderá sobre las API que {{ site.data.keys.product_adj }} proporciona para aplicaciones web, Cordova y nativas como, por ejemplo, JSONStore y WLResourceRequest, así como a depurar aplicaciones, utilizar Direct Update para renovar los recursos web, utilizar Live Update para segmentar su base de usuarios así como a manejar aplicaciones, adaptadores y otros artefactos utilizando {{ site.data.keys.mf_cli }}.


Navegue al tema relevante desde la navegación lateral, o continúe leyendo para obtener más información sobre los distintos componentes de {{ site.data.keys.product_adj }}.


#### Ir a 
{: #jump-to }
* [Aplicaciones](#applications)
* [{{ site.data.keys.mf_server }}](#mobilefirst-server)
* [Adaptadores](#adapters)
* [Guías de aprendizaje del lado del cliente con las que continuar](#client-side-tutorials-to-follow)

### Aplicaciones
{: #applications }
Las aplicaciones se compilan para una instancia de {{ site.data.keys.mf_server }} de destino  y tienen una configuración del lado del servidor en dicho servidor de destino.
Debe registrar las aplicaciones en {{ site.data.keys.mf_server }} para poder configurarlas.


Las aplicaciones se identifican con los siguientes elementos:

* ID de aplicación
* Número de versión
* Plataforma de despliegue de destino

> **Nota:** El número de versión no se aplica a las aplicaciones web.
No se pueden tener varias versiones de la misma aplicación web.


Estos identificadores se utilizan tanto en el lado del cliente como en el lado del servidor para asegurarse de que las aplicaciones se despliegan correctamente y únicamente utilizan los recursos que tienen asignados.
Las distintas partes de {{ site.data.keys.product }} utilizan diversas combinaciones de estos identificadores de distintas formas.


El ID de aplicación depende de la plataforma de despliegue de destino:

**Android**  
El identificador es el nombre del paquete de la aplicación. 

**iOS**  
El identificador es el nombre del ID del paquete de la aplicación. 

**Windows**  
El identificador es el nombre del ensamblaje de la aplicación. 

**Web**  
El identificador es un identificador exclusivo asignado por el desarrollador.

Si las aplicaciones para las distintas plataformas de destino tienen todas el mismo ID de aplicación, {{ site.data.keys.mf_server }} considera que todas estas aplicaciones son la misma con diferentes instancias de plataforma.
Por ejemplo, las siguientes aplicaciones se consideran instancias de plataforma diferentes de *la misma aplicación*:

* Una aplicación iOS con un ID de paquete `com.mydomain.mfp`.
* Una aplicación Android con un nombre de paquete `com.mydomain.mfp`.
* Una aplicación de plataforma Windows 10 Universal Windows Platform con un nombre de ensamblaje `com.mydomain.mfp`.
* Una aplicación web con el ID `com.mydomain.mfp`.

La plataforma de despliegue de destino para la aplicación es independiente de si la aplicación se ha desarrollado como una aplicación nativa o de Cordova.
Por ejemplo, las siguientes aplicaciones se consideran que son aplicaciones de iOS en {{ site.data.keys.product }}:


* Una aplicación iOS desarrollada con Xcode y código nativo. 
* Una aplicación iOS desarrollada con tecnologías de desarrollo entre plataformas de Cordova

> **Nota:** La funcionalidad de **compartición de la cadena de claves** es obligatoria al ejecutar aplicaciones iOS en el simulador de iOS al utilizar Xcode 8. Necesitará habilitar esta funcionalidad de forma manual antes de compilar el proyecto Xcode.

### Configuración de la aplicación
{: #application-configuration }
Como se ha mencionado, una aplicación se configura tanto en el lado del cliente como en el lado del servidor.
  

Para aplicaciones nativas, Cordova iOS, Android y Windows, la configuración de cliente se almacena en un archivo de propiedades de cliente (**mfpclient.plist** en iOS, **mfpclient.properties** en Android o **mfpclient.resw** en Windows).
En el caso de aplicaciones web, las propiedades de configuración se pasan como parámetros al [método de inicialización](../application-development/sdk/web) del SDK.


Las propiedades de configuración del cliente incluyen el ID de la aplicación e información como el URL del tiempo de ejecución de {{ site.data.keys.mf_server }} y claves de seguridad que se necesitan para acceder al servidor.
  
La configuración del servidor para la aplicación incluye información como, por ejemplo, el estado de gestión de la aplicación, los recursos web para Direct Update, ámbitos de seguridad configurados y configuración de registro.


> Aprenda a añadir los SDK de cliente de {{ site.data.keys.product_adj }} en las guías de aprendizaje de [Adición de SDK de {{ site.data.keys.product }}](sdk).

La configuración el cliente se debe definir antes de compilar la aplicación.
Las propiedades de configuración de la aplicación del cliente deben coincidir con las propiedades definidas para esta aplicación en el tiempo de ejecución de {{ site.data.keys.mf_server }}.
Por ejemplo, las claves de seguridad en la configuración del cliente deben coincidir con las claves en el servidor.
Para aplicaciones no web, cambie la configuración del cliente con {{ site.data.keys.mf_cli }}.

La configuración del servidor para las aplicaciones está relacionada con la combinación del ID de aplicación, el número de versión y la plataforma de destino.
Debe registrar su aplicación en un tiempo de ejecución de {{ site.data.keys.mf_server }} antes de añadir configuraciones del lado del servidor para la aplicación.
La configuración del lado del servidor de una aplicación suele llevarse a cabo con {{ site.data.keys.mf_console }}. También puede configurar el lado del servidor de una aplicación con los métodos siguientes:


* Tomar los archivos de configuración JSON existentes del servidor con el mandato `mfpdev app pull`, y subir la configuración cambiada con el mandato `mfpdev app push`.

* Utilizar la tarea Ant o el programa **mfpadm**.
Para obtener información sobre la utilización de mfpadm, consulte [Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de la línea de mandatos](../administering-apps/using-cli) y [Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de Ant](../administering-apps/using-ant).

* Utilice la API REST del servicio de administración de {{ site.data.keys.product_adj }}.
Para obtener información sobre la API REST, consulte [API REST para el servicio de administración de {{ site.data.keys.mf_server }}](../api/rest/administration-service/).

También puede utilizar estos métodos para automatizar la configuración de {{ site.data.keys.mf_server }}.

> **Recuerde: ** La configuración del servidor se puede modificar incluso cuando {{ site.data.keys.mf_server }} está en ejecución y recibiendo tráfico de las aplicaciones.
No es necesario detener el servidor para cambiar la configuración del servidor para una aplicación.
En un servidor de producción, la versión de la aplicación normalmente se corresponde con la versión de la aplicación publicada en la tienda de aplicaciones.
Algunos elementos de configuración como, por ejemplo, la configuración para la autenticidad de la aplicación, son exclusivos para la aplicación publicada en la tienda.


## {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
El lado del servidor de su aplicación móvil es {{ site.data.keys.mf_server }}. {{ site.data.keys.mf_server }} da acceso a características tales como las de gestión y  seguridad de la aplicación, así como proporciona acceso seguro a su aplicación móvil para otros sistemas de fondo a través de adaptadores.


{{ site.data.keys.mf_server }} es el componente principal que proporciona muchas características de {{ site.data.keys.product }}, entre otras:


* Gestión de aplicaciones
* Seguridad de aplicaciones, incluidos usuarios y dispositivos de autenticación con sus funciones de verificación de autenticidad 
* Acceso seguro a los servicios de fondo a través de adaptadores
* Actualización de recursos web de aplicaciones Cordova a través de Direct Update
* Notificaciones push y suscripciones push
* Analíticas de aplicaciones

Necesitará utilizar {{ site.data.keys.mf_server }} durante el ciclo de vida de la aplicación, desde el desarrollo hasta las pruebas a través del mantenimiento y despliegue de producción.
  

> Existe un servidor configurado de forma previa para que lo pueda utilizar al desarrollar sus aplicaciones.
Para obtener información sobre {{ site.data.keys.mf_server }} y cómo utilizarlo mientras desarrolla sus aplicaciones, consulte [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../installation-configuration/development).

{{ site.data.keys.mf_server }} consta de los siguientes componentes.
Todos estos componentes también se incluyen en {{ site.data.keys.mf_server }}.
En los casos simples, todos se ejecutan en el mismo servidor de aplicaciones, sin embargo, en un entorno de producción o prueba, los componentes se puede ejecutar en diferentes servidores de aplicaciones.
Para obtener información sobre posibles topologías para estos componentes de {{ site.data.keys.mf_server }}, consulte [Topologías y los flujos de red](../installation-configuration/production/topologies).

### {{ site.data.keys.product_adj }} y el servicio de administración de {{ site.data.keys.mf_server }}

{: #mobilefirst-and-the-mobilefirst-server-administration-service }
La consola de operaciones es una interfaz web que sirve para ver y editar las configuraciones de {{ site.data.keys.mf_server }}.
Acceda a {{ site.data.keys.mf_analytics_console }} desde aquí.
La raíz de contexto para la consola de operaciones en el servidor de desarrollo es **/mfpconsole**.

El servicio de administración es el punto de entrada principal para gestionar sus aplicaciones.
Acceda al servicio de administración a través de una interfaz basada en la web con {{ site.data.keys.mf_console }}.
También puede acceder al servicio de administración con la herramienta de línea de mandatos **mfpadm** o con la API REST del servicio de administración.


> Aprenda más sobre las [Características de {{ site.data.keys.mf_console }}](../product-overview/components/console).

### Tiempo de ejecución de {{ site.data.keys.product_adj }}
{: #mobilefirst-runtime }
El tiempo de ejecución es el punto de entrada principal para una aplicación de cliente de {{ site.data.keys.product_adj }}.
El tiempo de ejecución también es el servidor de autorización predeterminado para la implementación OAuth de {{ site.data.keys.product }}.


En casos especiales, es posible tener varias instancias de un tiempo de ejecución de dispositivo en un único {{ site.data.keys.mf_server }}.
Cada instancia tiene su propia raíz de contexto.
La raíz de contexto se utiliza para visualizar el nombre de un tiempo de ejecución en la consola de operaciones.
Utilice varias instancias en aquellos casos en los que necesite configuraciones de lado del servidor diferentes como, por ejemplo, para las claves secretas para un almacén de claves.


Si solo tiene una instancia de un tiempo de ejecución de dispositivo en {{ site.data.keys.mf_server }}, normalmente no necesitará conocer la raíz de contexto del tiempo de ejecución.
Por ejemplo, cuando se registra una aplicación para un tiempo de ejecución con el mandato `mfpdev app register` cuando {{ site.data.keys.mf_server }} sólo tiene un tiempo de ejecución, la aplicación se registra de forma automática para dicho tiempo de ejecución.


### Servicio push de {{ site.data.keys.mf_server }}
{: #mobilefirst-server-push-service }
El servicio push es el punto de acceso principal para las operaciones relacionadas con push, por ejemplo, notificaciones push y suscripciones push.
Para ponerse en contacto con los servicios push, las aplicaciones de cliente utilizan el URL del tiempo de ejecución sustituyendo la raíz de contexto por /mfppush.
El servicio push se puede configurar y gestionar con {{ site.data.keys.mf_console }} con la API REST del servicio push.


Si ejecuta los servicios push en un servidor de aplicaciones distinto del tiempo de ejecución de {{ site.data.keys.product_adj }}, debe direccionar el tráfico del servicio push al servidor de aplicaciones correcto con su servidor HTTP.


### {{ site.data.keys.mf_analytics }} y {{ site.data.keys.mf_analytics_console }}
{: #mobilefirst-analytics-and-the-mobilefirst-analytics-console }
{{ site.data.keys.mf_analytics_full }} es un componente opcional que proporciona una característica de analíticas escalables a la que es posible acceder desde {{ site.data.keys.mf_console }}.
Esta característica de analíticas permite buscar patrones, estadísticas de uso de plataforma y problemas a través de registros y sucesos que se recopilan desde dispositivos, aplicaciones y servidores.


Desde {{ site.data.keys.mf_console }}, defina filtros para habilitar o inhabilitar el reenvío de datos de las analíticas Service.
También se puede filtrar el tipo de información que se envía.
En el lado del cliente, utilice la API de captura de registro del lado del cliente para enviar sucesos y datos al servidor de analíticas.


Después de instalar y configurar {{ site.data.keys.mf_server }} en la topología que desee, cualquier configuración adicional de {{ site.data.keys.mf_server }} y sus aplicaciones se puede realizar totalmente a través de cualquiera de los métodos siguientes:


* {{ site.data.keys.mf_console }}
* API REST del servicio de administración de {{ site.data.keys.mf_server }} 
* Herramienta de línea de mandatos **mfpadm**

Después de la instalación y configuración inicial, no es necesario acceder a ninguna interfaz o consola del servidor de aplicaciones para configurar {{ site.data.keys.product }}.
  
Cuando despliegue su aplicación en el entorno de producción, podrá hacerlo en los siguientes entornos de producción de {{ site.data.keys.mf_server }}:


#### Localmente
{: #on-premises }
> Para obtener información sobre cómo instalar y configurar {{ site.data.keys.mf_server }} en un entorno local, consulte [Instalación de IBM {{ site.data.keys.mf_server }}](../installation-configuration/production/appserver).
#### En la nube
{: #on-the-cloud }
* [Utilización de {{ site.data.keys.mf_server }} en IBM Bluemix](../bluemix).
* [Utilización de {{ site.data.keys.mf_server }} en IBM PureApplication](../installation-configuration/production/pure-application).

## Adaptadores
{: #adapters }
Los adaptadores en {{ site.data.keys.product }} permiten conectar de forma segura sus sistemas de fondo con servicios de nube y aplicaciones de cliente.   

Los adaptadores se pueden codificar en JavaScript o Java y se compilan y despliegan como proyectos Maven.
  
Los adaptadores se despliegan en un tiempo de ejecución de {{ site.data.keys.product_adj }} en {{ site.data.keys.mf_server }}.


En un sistema de producción, los adaptadores suelen ejecutarse en un clúster de servidores de aplicaciones.
Implemente los adaptadores como servicios REST sin información de sesión y almacenados de forma local en el servidor para asegurarse de que el adaptador funciona bien en un entorno en clúster.


Un adaptador puede tener propiedades definidas por el usuario.
Estas propiedades se pueden configurar en el lado del servidor sin volver a desplegar el adaptador.
Por ejemplo, puede cambiar el URL que el adaptador utiliza para acceder a los recursos al moverlo desde el entorno de prueba al de producción.


Despliegue un adaptador en un tiempo de ejecución de {{ site.data.keys.product_adj }} desde {{ site.data.keys.mf_console }} mediante un mandato mfpdev de despliegue de adaptador o directamente desde Maven.


> Aprenda más sobre los adaptadores y el desarrollo de adaptadores Java y JavaScript en la categoría de [Adaptadores](../adapters). 

## Guías de aprendizaje del lado del cliente con las que continuar
{: #client-side-tutorials-to-follow }
