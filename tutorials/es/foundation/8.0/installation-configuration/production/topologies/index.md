---
layout: tutorial
title: Topologías y flujos de red
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La información que se presenta aquí detalla las topologías de servidor posibles para componentes de {{ site.data.keys.mf_server }}, así como los flujos de red disponibles.  
Los componentes se despliegan según la topología de servidor que utiliza. Los flujos de red le explican cómo se comunican los componentes entre ellos y con los dispositivos de usuarios finales.

#### Ir a
{: #jump-to }

* [Flujos de red entre los componentes de {{ site.data.keys.mf_server }}](#network-flows-between-the-mobilefirst-server-components)
* [Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}](#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)
* [Varios tiempos de ejecución de {{ site.data.keys.product }}](#multiple-mobilefirst-foundation-runtimes)
* [Varias instancias de {{ site.data.keys.mf_server }} en el mismo servidor o celda de WebSphere Application Server](#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell)

## Flujos de red entre los componentes de {{ site.data.keys.mf_server }}
{: #network-flows-between-the-mobilefirst-server-components }
Los componentes de {{ site.data.keys.mf_server }} se pueden comunicar entre ellos a través de JMX o HTTP. Debe configurar ciertas propiedades JNDI para habilitar las comunicaciones.  
Los flujos de red entre los componentes y el dispositivo se pueden ilustrar con la siguiente imagen:

![Diagrama de los flujos de red de los componentes de {{ site.data.keys.product }}](mfp_components_network_flows.jpg)

Los flujos entre los varios componentes de {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }}, los dispositivos móvil y el servidor de aplicaciones se explican en las siguientes secciones:

1. [Tiempo de ejecución de {{ site.data.keys.product }} para el servicio de administración de {{ site.data.keys.mf_server }}](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)
2. [Servicio de administración de {{ site.data.keys.mf_server }} para tiempo de ejecución de {{ site.data.keys.product }} en otros servidores](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers)
3. [Servicio de administración de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product_adj }} para el gestor de despliegue en WebSphere Application Server Network Deployment](#mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment)
4. [Servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product }} para {{ site.data.keys.mf_analytics }}](#mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics)
5. [Servicio de administración de {{ site.data.keys.mf_server }} para el servicio de Live Update de {{ site.data.keys.mf_server }}](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service)
6. [{{ site.data.keys.mf_console }} para el servicio de administración de {{ site.data.keys.mf_server }}](#mobilefirst-operations-console-to-mobilefirst-server-administration-service)
7. [Servicio de administración de {{ site.data.keys.mf_server }} para servicio de envío por push de {{ site.data.keys.mf_server }} y para el servidor de autorizaciones](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)
8. [Servicio de envío por push de {{ site.data.keys.mf_server }} a un servicio de notificación de push externo (saliente)](#mobilefirst-server-push-service-to-an-external-push-notification-service-outbound)
9. [Dispositivos móvil para el tiempo de ejecución de {{ site.data.keys.product }}](#mobile-devices-to-mobilefirst-foundation-runtime)

### Tiempo de ejecución de {{ site.data.keys.product }} para el servicio de administración de {{ site.data.keys.mf_server }}
{: #mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service }
El tiempo de ejecución y el servicio de administración se pueden comunicar entre ellos a través de JMX y HTTP. Esta comunicación se produce durante la fase de inicialización del tiempo de ejecución. El tiempo de ejecución se pone en contacto con el servicio de administración local de su servidor de aplicaciones para obtener la lista de los adaptadores y las aplicaciones que debe servir. La comunicación también sucede cuando algunas operaciones de administración se ejecutan desde {{ site.data.keys.mf_console }} o desde el servicio de administración. En WebSphere Application Server Network Deployment, el tiempo de ejecución puede contactar un servicio de administración instalado en otro servidor o celda. Esto permite el despliegue asimétrico (consulte [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)). Sin embargo, en el resto de los servidores de aplicaciones (Apache Tomcat, WebSphere Application Server Liberty o WebSphere Application Server autónomo), el servicio de administración debe estar en ejecución en el mismo servidor que el tiempo de ejecución.

Los protocolos para JMX dependen del servidor de aplicaciones:

* Apache Tomcat: RMI
* WebSphere Application Server Liberty: HTTPS (con el conector REST)
* WebSphere Application Server: SOAP o RMI

Para la comunicación a través de JMX, es necesario que estos protocolos estén disponibles en el servidor de aplicaciones. Para obtener más información sobre los requisitos, consulte [Requisitos previos del servidor de aplicaciones](../appserver/#application-server-prerequisites).

Los beans de JMX del tiempo de ejecución y el servicio de administración se obtienen del servidor de aplicaciones. Sin embargo, en el caso de WebSphere Application Server Network Deployment, los beans de JMX se obtienen del gestor de despliegue. El gestor de despliegue tiene la vista de todos los beans de una celda en WebSphere Application Server Network Deployment. Como tal, algunas configuraciones no son necesarias en WebSphere Application Server Network Deployment (como por ejemplo la configuración de la granja de servidores), y es posible el despliegue asimétrico en WebSphere Application Server Network Deployment. Para obtener más información, consulte [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime).

Para distinguir diferentes instalaciones de {{ site.data.keys.mf_server }} en el mismo servidor de aplicaciones o en la misma celda de WebSphere Application Server, puede utilizar un ID de entorno, que es una variable JNDI. De forma predeterminada, esta variable tiene un valor vacío. Un tiempo de ejecución con un ID de entorno dado solo se comunica con un servicio de administración que tenga el mismo ID de entorno. Por ejemplo, el servicio de administración tiene un ID de entorno establecido en X y el tiempo de ejecución tiene un ID de entorno diferente (por ejemplo, Y), en este caso, los dos componentes no se ven entre sí. {{ site.data.keys.mf_console }} no muestra ningún tiempo de ejecución disponible.

Un servicio de administración debe ser capaz de comunicarse con todos los componentes de tiempo de ejecución de {{ site.data.keys.product }} de un clúster. Cuando se ejecuta una operación de administración, como subir una nueva versión de un adaptador o cambiar el estado activo de una aplicación, se debe notificar a todos los componentes de tiempo de ejecución de un clúster sobre el cambio. Si el servidor de aplicaciones no es WebSphere Application Server Network Deployment, esta comunicación solo puede suceder si se configura una granja de servidores. Para obtener más información, consulte [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime).

El tiempo de ejecución también se comunica con el servicio de administración a través de HTTP o HTTPS para descargar artefactos grandes como los adaptadores. El servicio de administración genera un URL y el tiempo de ejecución abre y saca conexiones HTTP o HTTPS para solicitar un artefacto desde este URL. Es posible sustituir la generación de URL predeterminada definiendo las propiedades JNDI (mfp.admin.proxy.port, mfp.admin.proxy.protocol y mfp.admin.proxy.host) en el servicio de administración. Es posible que el servicio de administración también necesite comunicarse con el tiempo de ejecución a través de HTTP o HTTPS para obtener las señales de OAuth utilizadas para ejecutar las operaciones push. Para obtener más información, consulte [Servicio de administración de {{ site.data.keys.mf_server }} para servicio de envío por push de {{ site.data.keys.mf_server }} y para el servidor de autorizaciones](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server).

Las propiedades JNDI utilizadas para la comunicación entre el tiempo de ejecución y el servicio de administración son las siguientes:

#### Servicio de administración de {{ site.data.keys.mf_server }}
{: #mobilefirst-server-administration-service }

* [Propiedades JNDI para servicios de administración: JMX](../server-configuration/#jndi-properties-for-administration-service-jmx)
* [Propiedades JNDI para servicios de administración: proxies](../server-configuration/#jndi-properties-for-administration-service-proxies)
* [Propiedades JNDI para servicios de administración: Topologías](../server-configuration/#jndi-properties-for-administration-service-topologies)

#### Tiempo de ejecución de {{ site.data.keys.product }}
{: #mobilefirst-foundation-runtime }

* [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

### Servicio de administración de {{ site.data.keys.mf_server }} para tiempo de ejecución de {{ site.data.keys.product }} en otros servidores
{: #mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers }
Como se describe en [Tiempo de ejecución de {{ site.data.keys.product }} para el servicio de administración de {{ site.data.keys.mf_server }}](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service), es necesario tener la comunicación entre un servicio de administración y todos los componentes de tiempo de ejecución de un clúster. Cuando se ejecuta una operación de administración, se puede notificar a todos los componentes de tiempo de ejecución de un clúster sobre esta modificación. La comunicación se realiza a través de JMX.

En WebSphere Application Server Network Deployment, esta comunicación se puede producir sin ninguna configuración específica. Todos los MBeans de JMX que corresponden al mismo ID de entorno se obtienen desde el gestor de despliegue.

Para un clúster de WebSphere Application Server autónomo, perfil de Liberty de WebSphere Application Server o Apache Tomcat, la comunicación solo puede suceder si se configura una granja de servidores. Para obtener más información, consulte [Instalación de una granja de servidores](../appserver/#installing-a-server-farm). 

### El servicio de administración de {{ site.data.keys.mf_server }} y el tiempo de ejecución de MobileFirst para el gestor de despliegue en WebSphere Application Server Network Deployment
{: #mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment }
En WebSphere Application Server Network Deployment, el tiempo de ejecución y el servicio de administración obtienen los MBeans de JMX utilizados en el [tiempo de ejecución de {{ site.data.keys.product }} para el servicio de administración de {{ site.data.keys.mf_server }}](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service) y el [servicio de administración de {{ site.data.keys.mf_server }} para el tiempo de ejecución de {{ site.data.keys.product }} en otros servidores](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers) comunicándose con el gestor de despliegue. Las propiedades JNDI correspondientes son **mfp.admin.jmx.dmgr.*** en [Propiedades JNDI para servicios de administración: JMX](../server-configuration/#jndi-properties-for-administration-service-jmx).

El gestor de despliegue debe ejecutarse para permitir las operaciones que requieren la comunicación JMX entre el tiempo de ejecución y el servicio de administración. Dichas operaciones pueden ser una inicialización de tiempo de ejecución o la notificación de una modificación realizada mediante el servicio de administración.

### Servicio de envío por push de {{ site.data.keys.mf_server }} y tiempo de ejecución de {{ site.data.keys.product }} para {{ site.data.keys.mf_analytics }}
{: #mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics }
El tiempo de ejecución envía datos a {{ site.data.keys.mf_analytics }} a través de HTTP o HTTPS. Las propiedades JNDI del tiempo de ejecución que se utilizan para definir estas comunicaciones son:

* **mfp.analytics.url**: El URL expuesto por el servicio {{ site.data.keys.mf_analytics }} para recibir datos analíticos entrantes desde el tiempo de ejecución. Ejemplo: `http://<hostname>:<port>/analytics-service/rest`

    Cuando {{ site.data.keys.mf_analytics }} se instala como clúster, los datos se pueden enviar a cualquier miembro del clúster. 

* **mfp.analytics.username**: El nombre de usuario utilizado para acceder al servicio {{ site.data.keys.mf_analytics }}. El servicio de analítica está protegido por un rol de seguridad.
* **mfp.analytics.password**: La contraseña para acceder al servicio de análisis.
* **mfp.analytics.console.url**: El URL que se pasa a {{ site.data.keys.mf_console }} para visualizar un enlace a {{ site.data.keys.mf_analytics_console }}. Ejemplo: `http://<hostname>:<port>/analytics/console`
    Las propiedades JNDI del servicio de envío por push que se utilizan para definir estas comunicaciones son:
* **mfp.push.analytics.endpoint**: El URL expuesto por el servicio {{ site.data.keys.mf_analytics }} para recibir datos analíticos entrantes desde el servicio de envío por push. Ejemplo: `http://<hostname>:<port>/analytics-service/rest`

    Cuando {{ site.data.keys.mf_analytics }} se instala como clúster, los datos se pueden enviar a cualquier miembro del clúster.    
* **mfp.push.analytics.username**: El nombre de usuario utilizado para acceder al servicio {{ site.data.keys.mf_analytics }}. El servicio de analítica está protegido por un rol de seguridad.
* **mfp.push.analytics.password**: La contraseña para acceder al servicio de análisis.

### Servicio de administración de {{ site.data.keys.mf_server }} para el servicio de Live Update de {{ site.data.keys.mf_server }}
{: #mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service }
El servicio de administración se comunica con el servicio Live Update para almacenar y recuperar información de configuración sobre los artefactos de {{ site.data.keys.product }}. La comunicación se realiza a través de HTTP o HTTPS.

El URL para contactar con el servicio Live Update lo genera automáticamente el servicio de administración. Ambos servicios deben estar en el mismo servidor de aplicaciones. La raíz de contexto del servicio de Live Update debe definirse de esta forma: `<adminContextRoot>config`. Por ejemplo, si la raíz de contexto del servicio de administración es **mfpadmin**, la raíz de contexto del servicio de Live Update debe ser **mfpadminconfig**.Es posible sustituir la generación de URL predeterminada definiendo las propiedades JNDI (**mfp.admin.proxy.port**, **mfp.admin.proxy.protocol** y **mfp.admin.proxy.host**) en el servicio de administración. 

Las propiedades JNDI para configurar esta comunicación entre los dos servicios son:

* **mfp.config.service.user**
* **mfp.config.service.password**
* Y las propiedades en [Propiedades JNDI para servicios de administración: proxies](../server-configuration/#jndi-properties-for-administration-service-proxies).

### {{ site.data.keys.mf_console }} para el servicio de administración de {{ site.data.keys.mf_server }}
{: #mobilefirst-operations-console-to-mobilefirst-server-administration-service }
{{ site.data.keys.mf_console }} es una interfaz de usuario de web y actúa como front end del servicio de administración. Se comunica con los servicios REST del servicio de administración a través de HTTP o HTTPS. Los usuarios con permisos para utilizar la consola, también deben tener permiso para utilizar el servicio de administración. Cada usuario que esté correlacionado con cierto rol de seguridad de la consola también debe estar correlacionado con el mismo rol de seguridad del servicio. Con esta configuración, el servicio puede aceptar las solicitudes de la consola.

Las propiedades JNDI para configurar esta comunicación están en [Propiedades JNDI para {{ site.data.keys.mf_console }}](../server-configuration/#jndi-properties-for-mobilefirst-operations-console).

> Nota: La propiedad **mfp.admin.endpoint** permite a la consola localizar el servicio de administración. Puede utilizar el carácter asterisco "\*" como comodín para especificar que el URL, generado por la consola para contactar con el servicio de administración, utiliza el mismo valor que la última solicitud HTTP entrante en la consola. Por ejemplo: `*://*:*/mfpadmin` significa que utiliza el mismo protocolo, host y puerto que la consola pero utiliza **mfpadmin** como raíz de contexto. Esta propiedad se especifica para la aplicación de consola.
### Servicio de administración de {{ site.data.keys.mf_server }} para servicio de envío por push de {{ site.data.keys.mf_server }} y para el servidor de autorizaciones
{: #mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server }
El servicio de administración se comunica con el servicio de envío por push para solicitar varias operaciones de envío por push. Esta comunicación está protegida mediante el protocolo OAuth. Ambos servicios deben estar registrados como clientes confidenciales. Se puede realizar un registro inicial al instalar. En este proceso, ambos servicios deben contactar con un servidor de autorizaciones. Este servidor de autorizaciones puede ser el tiempo de ejecución de {{ site.data.keys.product }}.

Las propiedades JNDI del servicio de administración para configurar estas comunicaciones son:

* **mfp.admin.push.url**: El URL del servicio de envío por push.
* **mfp.admin.authorization.server.url**: El URL del servidor de autorizaciones de {{ site.data.keys.product }}.
* **mfp.admin.authorization.client.id**: El ID de cliente del servicio de administración, como un cliente confidencial de OAuth.
* **mfp.admin.authorization.client.secret**: El código secreto utilizado para obtener las señales basadas en OAuth.

> Nota: Las propiedades **mfp.push.authorization.client.id** y **mfp.push.authorization.client.secret** del servicio de administración se pueden utilizar para registrar el servicio de envío por push de forma automática como cliente confidencial cuando se inicia el servicio de administración. El servicio de envío por push debe configurarse con los mismos valores.
Las propiedades JNDI del servicio de envío por push para configurar estas comunicaciones son:

* **mfp.push.authorization.server.url**: El URL del servidor de autorizaciones de {{ site.data.keys.product }}. Igual que la propiedad **mfp.admin.authorization.server.url**.
* **mfp.push.authorization.client.id**: El ID de cliente del servicio de envío por push para contactar con el servidor de autorizaciones.
* **mfp.push.authorization.client.secret**: El código secreto utilizado para contactar con el servidor de autorizaciones.

### Servicio de envío por push de {{ site.data.keys.mf_server }} a un servicio de notificación de push externo (saliente)
{: #mobilefirst-server-push-service-to-an-external-push-notification-service-outbound }
El servicio de envío por push genera tráfico saliente al servicio de notificación externo como Apple Push Notification Service (APNS) o Google Cloud Messaging (GCM). Esta comunicación también se puede realizar a través de un proxy. Dependiendo del servicio de notificación, se deben establecer las siguientes propiedades JNDI:

* **push.apns.proxy**
* **push.gcm.proxy**

Para obtener más información, consulte [Lista de propiedades JNDI para el servicio de envío por push de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

### Dispositivos móvil para el tiempo de ejecución de {{ site.data.keys.product }}
{: #mobile-devices-to-mobilefirst-foundation-runtime }
Los dispositivos móvil contactan con el tiempo de ejecución. La seguridad de esta comunicación está determinada por la configuración de la aplicación y los adaptadores solicitados. Para obtener más información, consulte [Infraestructura de seguridad de {{ site.data.keys.product_adj }}](../../../authentication-and-security).

## Restricciones en los componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }}
{: #constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics }
Comprenda las restricciones de los varios componentes de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_analytics }} antes de decidir su topología de servidor.

* [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)
* [Restricciones del servicio de envío por push de {{ site.data.keys.mf_server }}](#constraints-on-mobilefirst-server-push-service)

### Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}
{: #constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime }
Descubra las restricciones y la modalidad de despliegue del servicio de administración, del servicio Live Update y del tiempo de ejecución por topología de servidor.

El servicio de Live Update debe estar instalado con el servicio de administración en el mismo servidor de aplicaciones como se explica en [Servicio de administración de {{ site.data.keys.mf_server }} para el servicio de Live Update de {{ site.data.keys.mf_server }}](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service). La raíz de contexto del servicio de Live Update debe definirse de esta forma: `/<adminContextRoot>config`. Por ejemplo, si la raíz de contexto del servicio de administración es **/mfpadmin**, la raíz de contexto del servicio de Live Update debe ser **/mfpadminconfig**.

Puede utilizar cualquiera de las siguientes topologías de servidores de aplicaciones:

* Servidor autónomo: Perfil de Liberty de WebSphere Application Server, Apache Tomcat o perfil completo de WebSphere Application Server
* Granja de servidores: Perfil de Liberty de WebSphere Application Server, Apache Tomcat o perfil completo de WebSphere Application Server
* Celda de WebSphere Application Server Network Deployment
* Colectividad de Liberty

#### Modalidades de despliegue
{: #modes-of-deployment }
Dependiendo de la topología de servidor de aplicaciones que utilice, tiene dos modalidades de despliegue para elegir para desplegar el servidor de aplicaciones, el servicio Live Update y el tiempo de ejecución en la infraestructura de servidor de aplicaciones. En el despliegue asimétrico, puede instalar los tiempos de ejecución en diferentes servidores de aplicaciones desde los servicios de administración y Live Update.

**Despliegue simétrico**  
En el despliegue simétrico, debe instalar los componentes de administración de {{ site.data.keys.product }} ({{ site.data.keys.mf_console }}, el servicio de administración y las aplicaciones de servicio de Live Update) y el tiempo de ejecución en el mismo servidor de aplicaciones.

**Despliegue asimétrico**  
En el despliegue asimétrico, puede instalar los tiempos de ejecución en diferentes servidores de aplicaciones desde los componentes de administración de {{ site.data.keys.product }}.  
El despliegue asimétrico solo está soportado en la topología de celda de WebSphere Application Server Network Deployment y para la topología de colectividad de Liberty.

#### Seleccionar una topología
{: #select-a-topology }

* [Topología de servidor autónomo](#stand-alone-server-topology)
* [Topología de granja de servidores](#server-farm-topology)
* [Topología de colectividad de Liberty](#liberty-collective-topology)
* [Topologías de WebSphere Application Server Network Deployment](#websphere-application-server-network-deployment-topologies)
* [Utilización de un proxy inverso con topologías de granja de servidores y WebSphere Application Server Network Deployment](#using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies)

### Topología de servidor autónomo
{: #stand-alone-server-topology }
Puede configurar una topología autónoma para el perfil completo de WebSphere Application Server, el perfil de Liberty de WebSphere Application Server y Apache Tomcat.
En esta topología, todos los componentes de administración y los tiempos de ejecución se despliegan en una sola máquina virtual Java (JVM).

![Topología autónoma](standalone_topology.jpg)

Con una JVM, solo es posible el despliegue simétrico con las características siguientes:

* Se pueden desplegar uno o varios componentes de administración. Cada {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Se pueden desplegar uno o varios tiempos de ejecución. 
* Una {{ site.data.keys.mf_console }} puede gestionar varios tiempos de ejecución.
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución.

#### Configuración de propiedades JNDI
{: #configuration-of-jndi-properties }
Algunas propiedades JNDI son necesarias para habilitar la comunicación Java Management Extensions (JMX) entre el servicio de administración y el tiempo de ejecución y para definir el servicio de administración que gestiona un tiempo de ejecución. Para obtener detalles sobre estas propiedades, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) y [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

**Servidor de perfil de Liberty de WebSphere Application Server autónomo**  
Las siguientes propiedades JNDI globales son necesarias para los servicios de administración y los tiempos de ejecución.

| Propiedades JNDI         | Valores |
|--------------------------|--------|
| mfp.topology.platform	   | Liberty |
| mfp.topology.clustermode | Autónomo|
| mfp.admin.jmx.host       | El nombre de host del servidor de perfil de Liberty de WebSphere Application Server. |
| mfp.admin.jmx.port       | El puerto del conector REST que es el puerto del atributo httpsPort declarado en el elemento `<httpEndpoint>` del archivo server.xml del servidor de perfil de Liberty de WebSphere Application Server. Esta propiedad no tiene valor predeterminado. |
| mfp.admin.jmx.user       | El nombre de usuario del administrador de WebSphere Application Server Liberty, que debe ser idéntico al nombre definido en el elemento `<administrator-role>` del archivo server.xml del servidor de perfil de Liberty de WebSphere Application Server. |
| mfp.admin.jmx.pwd        | La contraseña del usuario administrador de WebSphere Application Server Liberty. |

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución. 

Cuando despliega varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI **mfp.admin.environmentid** local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

**Servidor Apache Tomcat autónomo**
Las siguientes propiedades JNDI locales son necesarias para los servicios de administración y los tiempos de ejecución.

| Propiedades JNDI       |	Valores    |
|------------------------|------------|
| mfp.topology.platform  | Tomcat     |
| mfp.topology.clustermode | Autónomo |

Las propiedades JVM también son necesarias para definir la invocación a método remoto (RMI) de Java Management Extensions (JMX). Para obtener más información, consulte [Configuración de la conexión de JMX para Apache Tomcat](../appserver/#apache-tomcat-prerequisites).

Si el servidor Apache Tomcat se está ejecutando detrás de un cortafuegos, las propiedades JNDI **mfp.admin.rmi.registryPort** y **mfp.admin.rmi.serverPort** son necesarias para el servicio de administración. Consulte [Configuración de la conexión de JMX para Apache Tomcat](../appserver/#apache-tomcat-prerequisites).

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución.   
Cuando despliega varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI mfp.admin.environmentid local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI mfp.admin.environmentid local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

**Servidor de WebSphere Application Server autónomo**  
Las siguientes propiedades JNDI locales son necesarias para los servicios de administración y los tiempos de ejecución.

| Propiedades JNDI         | Valores                |
|--------------------------| -----------------------|
| mfp.topology.platform    | WAS                    |
| mfp.topology.clustermode | Autónomo               |
| mfp.admin.jmx.connector  | El tipo de conector JMX; el valor puede ser SOAP o RMI. |

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución.   
Cuando despliega varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI **local mfp.admin.environmentid** local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

### Topología de granja de servidores
{: #server-farm-topology }
Puede configurar una topología de granja de servidores para los servidores de aplicaciones de perfil completo de WebSphere Application Server, perfil de Liberty de WebSphere Application Server o Apache Tomcat.


Una granja es una granja de servidores individuales donde se despliegan los mismos componentes y donde se comparten las mismas bases de datos de servicio de administración y tiempo de ejecución entre los servidores. La topología de granja permite que la carga de aplicaciones {{ site.data.keys.product }} se distribuya a través de varios servidores. Cada servidor en la granja debe ser una máquina virtual Java (JVM) del mismo tipo de servidor de aplicaciones; es decir, una granja de servidores homogénea. Por ejemplo, un conjunto de varios servidores Liberty se puede configurar como una granja de servidores. A la inversa, una combinación de servidor Liberty, servidor Tomcat o WebSphere Application Server autónomo no se puede configurar como granja de servidores.

En esta topología, todos los componentes de administración ({{ site.data.keys.mf_console }}, el servicio de administración y el servicio Live Update) y los tiempos de ejecución se despliegan en cada servidor de la granja.

![Topología de una granja de servidores](server_farm_topology.jpg)

Esta topología solo soporta el despliegue simétrico. Los tiempos de ejecución y los componentes de administración deben desplegarse en cada servidor de la granja. El despliegue de esta topología tiene las características siguientes:

* Se pueden desplegar uno o varios componentes de administración. Cada instancia de {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Los componentes de administración deben desplegarse en todos los servidores de la granja. 
* Se pueden desplegar uno o varios tiempos de ejecución. 
* Los tiempos de ejecución deben desplegarse en todos los servidores de la granja. 
* Una {{ site.data.keys.mf_console }} puede gestionar varios tiempos de ejecución.
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración. Todas las instancias desplegadas del mismo servicio de administración comparten el mismo esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.Todas las instancias desplegadas del mismo servicio Live Update comparten el mismo esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución. Todas las instancias desplegadas del mismo tiempo de ejecución comparten el mismo esquema de base de datos de tiempo de ejecución.

#### Configuración de propiedades JNDI
{: #configuration-of-jndi-properties-1 }
Algunas propiedades JNDI son necesarias para habilitar la comunicación JMX entre el servicio de administración y el tiempo de ejecución del mismo servidor y para definir el servicio de administración que gestiona un tiempo de ejecución. Para su comodidad, las tablas siguientes listan estas propiedades. Para obtener instrucciones sobre cómo instalar una granja de servidores, consulte [Instalación de una granja de servidores](../appserver/#installing-a-server-farm). Para obtener más información sobre las propiedades JNDI, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) y [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

**Granja de servidores de perfil de Liberty de WebSphere Application Server**  
Las siguientes propiedades JNDI globales son necesarias en cada servicio de la granja para los servicios de administración y los tiempos de ejecución.

<table>
    <tr>
        <th>
            Propiedades JNDI
        </th>
        <th>
            Valores
        </th>
    </tr>
    <tr>
        <td>
            mfp.topology.platform
        </td>
        <td>
            Liberty
        </td>
    </tr>
    <tr>
        <td>
            mfp.topology.clustermode
        </td>
        <td>
            Granja de servidores
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.host
        </td>
        <td>
            El nombre de host del servidor de perfil de Liberty de WebSphere Application Server
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.port
        </td>
        <td>
            El puerto del conector REST que debe ser idéntico al valor del atributo httpsPort declarado en el elemento <code>httpEndpoint</code> del archivo <b>server.xml</b> del servidor de perfil de Liberty de WebSphere Application Server.
{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*" />
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.user
        </td>
        <td>
            El nombre de usuario del administrador de WebSphere Application Server Liberty definido en el elemento <code>administrator-role</code> del archivo <b>server.xml</b> del servidor de perfil de Liberty de WebSphere Application Server.
            
{% highlight xml %}
<administrator-role>
    <user>MfpRESTUser</user>
</administrator-role>
{% endhighlight %}        
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.pwd
        </td>
        <td>
            La contraseña del usuario administrador de WebSphere Application Server Liberty. </td>
    </tr>
</table>

La propiedad JNDI **mfp.admin.serverid** es necesaria para que el servicio de administración gestione la configuración de granja de servidores. Su valor es el ID del servidor, que debe ser diferente para cada servidor en la granja de servidores.

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución. 

Cuando despliega varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI mfp.admin.environmentid local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

**Granja de servidores Apache Tomcat**  
Las siguientes propiedades JNDI globales son necesarias en cada servicio de la granja para los servicios de administración y los tiempos de ejecución.

| Propiedades JNDI         |	Valores   |
|--------------------------|-----------|
| mfp.topology.platform	   | Tomcat    |
| mfp.topology.clustermode | Granja de servidores |

Las propiedades JVM también son necesarias para definir la invocación a método remoto (RMI) de Java Management Extensions (JMX). Para obtener más información, consulte [Configuración de la conexión de JMX para Apache Tomcat](../appserver/#apache-tomcat-prerequisites).

La propiedad JNDI **mfp.admin.serverid** es necesaria para que el servicio de administración gestione la configuración de granja de servidores. Su valor es el ID del servidor, que debe ser diferente para cada servidor en la granja de servidores.

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución. 

Cuando despliega varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI mfp.admin.environmentid local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

**Granja de servidores de perfil completo de WebSphere Application Server**  
Las siguientes propiedades JNDI globales son necesarias en cada servidor en la granja para los servicios de administración y los tiempos de ejecución.

| Propiedades JNDI           | Valores|
|----------------------------|--------|
| mfp.topology.platform	WAS  | WAS    |
| mfp.topology.clustermode   | Granja de servidores|
| mfp.admin.jmx.connector    | SOAP   |

Las siguientes propiedades JNDI son necesarias para que el servicio de administración gestione la configuración de granja de servidores. 

| Propiedades JNDI   | Valores|
|--------------------|--------|
| mfp.admin.jmx.user | El nombre de usuario de WebSphere Application Server. Este usuario debe definirse en el registro de usuarios de WebSphere Application Server. |
| mfp.admin.jmx.pwd	 | La contraseña del usuario de WebSphere Application Server. |
| mfp.admin.serverid | El ID del servidor, que debe ser diferente para cada servidor en la granja de servidores e idéntico al valor de esta propiedad utilizada para este servidor en el archivo de configuración de granja de servidores.|

Se pueden desplegar varios componentes de administración para habilitar la ejecución de misma JVM en componentes de administración separados que gestionan diferentes tiempos de ejecución. 

Cuando despliega varios los componentes de administración, debe especificar los siguientes valores:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI **mfp.admin.environmentid** local.
* En cada tiempo de ejecución, el mismo valor para la propiedad JNDI **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona el tiempo de ejecución.

### Topología de colectividad de Liberty
{: #liberty-collective-topology }
Puede desplegar los componentes de {{ site.data.keys.mf_server }} en una topología de colectividad de Liberty.

En la topología de colectividad de Liberty, los componentes de administración de {{ site.data.keys.mf_server }} ({{ site.data.keys.mf_console }}, el servicio de administración y el servicio Live Update) se despliegan en un controlador colectivo y los tiempos de ejecución de {{ site.data.keys.product }} en un miembro de colectivo. Esta topología solo soporta el despliegue asimétrico, los tiempos de ejecución no pueden desplegarse en un controlador colectivo. 

![Topología para colectividad de Liberty](liberty_collective_topology.jpg)

El despliegue de esta topología tiene las características siguientes:

* Se pueden desplegar uno o varios componentes de administración en uno o varios controladores del colectivo. Cada instancia de * * {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Se pueden desplegar uno o varios tiempos de ejecución en los miembros de clúster del colectivo. 
* Una {{ site.data.keys.mf_console }} gestiona varios tiempos de ejecución desplegados en los miembros de clúster del colectivo. 
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución.

#### Configuración de propiedades JNDI
{: #configuration-of-jndi-properties-2 }
Las siguientes tablas listan las propiedades JNDI son necesarias para habilitar la comunicación JMX entre el servicio de administración y el tiempo de ejecución y para definir el servicio de administración que gestiona un tiempo de ejecución. Para obtener más información sobre estas propiedades, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) y [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime). Para obtener instrucciones sobre cómo instalar una colectividad de Liberty manualmente, consulte [Instalación manual en la colectividad de Liberty de WebSphere Application Server](../appserver/#manual-installation-on-websphere-application-server-liberty-collective). 

Las siguientes propiedades JNDI globales son necesarias para los servicios de administración:

<table>
    <tr>
        <th>
            Propiedades JNDI
        </th>
        <th>
            Valores
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>Clúster</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>controlador</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>El nombre de host del controlador de Liberty.</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>El puerto del conector REST que debe ser idéntico al valor del atributo <b>httpsPort</b> declarado en el elemento <code>httpEndpoint</code> del archivo server.xml del controlador de Liberty.
{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>El nombre de usuario del administrador controlador definido en el elemento <code>administrator-role</code> del archivo <b>server.xml</b> del controlador de Liberty.
{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>La contraseña del usuario administrador del controlador de Liberty. </td>
    </tr>
</table>

Se pueden desplegar varios componentes de administración para permitir que el controlador ejecute componentes de administración separados que gestionan diferentes tiempos de ejecución. 

Cuando despliega varios componentes de administración, debe especificar en cada servicio de administración, un valor exclusivo para la propiedad JNDI **mfp.admin.environmentid** local.

Las siguientes propiedades JNDI globales son necesarias para los tiempos de ejecución:

<table>
    <tr>
        <th>
            Propiedades JNDI
        </th>
        <th>
            Valores
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>Clúster</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>Un valor que identifica de forma exclusiva el miembro de colectivo. Debe ser distinto para cada miembro del colectivo. El valor <code>controller</code> no se puede utilizar puesto que está reservado para el controlador colectivo. </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>El nombre de host del controlador de Liberty.</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>El puerto del conector REST que debe ser idéntico al valor del atributo <b>httpsPort</b> declarado en el elemento <code>httpEndpoint</code> del archivo server.xml del controlador de Liberty.
{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>El nombre de usuario del administrador controlador definido en el elemento <code>administrator-role</code> del archivo <b>server.xml</b> del controlador de Liberty.
{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>La contraseña del usuario administrador del controlador de Liberty. </td>
    </tr>
</table>

La siguiente propiedad JNDI es necesaria para el tiempo de ejecución cuando se utilizan varios controladores (réplicas) que utilizan los mismos componentes de administración:

| Propiedades JNDI| Valores| 
|-----------------|--------|
| mfp.admin.jmx.replica | Lista de puntos finales de las diferentes réplicas de controlador con la siguiente sintaxis: `replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` | 

Cuando se despliegan varios componentes de administración en el controlador, cada tiempo de ejecución debe tener el mismo valor para la propiedad JNDI local **mfp.admin.environmentid** como el valor definido por el servicio de administración que gestiona el tiempo de ejecución.

### Topologías de WebSphere Application Server Network Deployment
{: #websphere-application-server-network-deployment-topologies }
Los componentes de administración y los tiempos de ejecución se despliegan en servidores o clústeres de la celda de WebSphere Application Server Network Deployment.

Ejemplos de estas topologías soportan el despliegue asimétrico, simétrico o ambos. Puede, por ejemplo, desplegar los componentes de administración ({{ site.data.keys.mf_console }}, el servicio de administración y el servicio Live Update) en un clúster y los tiempos de ejecución gestionados por estos componentes en otro clúster.

#### Despliegue simétrico en el mismo servidor o clúster
{: #symmetric-deployment-in-the-same-server-or-cluster }
El diagrama siguiente muestra el despliegue simétrico en el que los tiempos de ejecución y los componentes de administración se despliegan en el mismo servidor o clúster.

![Una topología de WAS ND](was_nd_topology_1.jpg)

El despliegue de esta topología tiene las características siguientes:

* Se pueden desplegar uno o varios componentes de administración en uno o varios servidores o clústeres de la celda. Cada instancia de * {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Se pueden desplegar uno o varios tiempos de ejecución en el mismo servidor o clúster como los componentes de administración que los gestionan. 
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución.

#### Despliegue asimétrico con tiempos de ejecución y servicios de administración en diferente servidor o clúster
{: #asymmetric-deployment-with-runtimes-and-administration-services-in-different-server-or-cluster }
El diagrama siguiente muestra una topología donde los entornos de ejecución se despliegan en un servidor o clúster diferente desde el servicio de administración.

![Topología para WAS ND](was_nd_topology_2.jpg)

El despliegue de esta topología tiene las características siguientes:

* Se pueden desplegar uno o varios componentes de administración en uno o varios servidores o clústeres de la celda. Cada instancia de * {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Se pueden desplegar uno o varios tiempos de ejecución otros servidores o clústeres de la celda. 
* Una {{ site.data.keys.mf_console }} gestiona varios tiempos de ejecución otros servidores o clústeres de la celda. 
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución.

Esta topología es ventajosa, puesto que permite aislar los tiempos de ejecución de los componentes de administración y de otros tiempos de ejecución. Se puede utilizar para proporcionar aislamiento de rendimiento, para aislar aplicaciones críticas y para aplicar el acuerdo de nivel de servicio (SLA).

#### Despliegue simétrico y asimétrico
{: #symmetric-and-asymmetric-deployment }
El diagrama siguiente muestra un ejemplo de despliegue simétrico en el Cluster1 y un despliegue asimétrico en el Cluster2, donde el Runtime2 y Runtime3 se despliegan en un clúster distinto de los componentes de administración. {{ site.data.keys.mf_console }} gestiona los tiempos de ejecución desplegados en el Cluster1 y Cluster2.

![Topología para WAS ND](was_nd_topology_3.jpg)

El despliegue de esta topología tiene las características siguientes:

* Se pueden desplegar uno o varios componentes de administración en uno o varios servidores o clústeres de la celda. Cada instancia de {{ site.data.keys.mf_console }} se comunica con un servicio de administración y un servicio Live Update.
* Se pueden desplegar uno o varios tiempos de ejecución en uno o varios servidores o clústeres de la celda. 
* Una {{ site.data.keys.mf_console }} gestiona varios tiempos de ejecución desplegados en el mismo o en otros servidores o clústeres de la celda. 
* Un tiempo de ejecución se gestiona solo por un {{ site.data.keys.mf_console }}.
* Cada servicio de administración utiliza su propio esquema de base de datos de administración.
* Cada servicio Live Update utiliza su propio esquema de base de datos de Live Update.
* Cada tiempo de ejecución utiliza su propio esquema de base de datos de tiempo de ejecución.

#### Configuración de propiedades JNDI
{: #configuration-of-jndi-properties-3 }
Algunas propiedades JNDI son necesarias para habilitar la comunicación JMX entre el servicio de administración y el tiempo de ejecución y para definir el servicio de administración que gestiona un tiempo de ejecución. Para obtener detalles sobre estas propiedades, consulte [Lista de propiedades JNDI para el servicio de administración de {{ site.data.keys.mf_server }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service) y [Lista de propiedades JNDI para el tiempo de ejecución de {{ site.data.keys.product_adj }}](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

Las siguientes propiedades JNDI locales son necesarias para los servicios de administración y los tiempos de ejecución:

| Propiedades JNDI|	Valores|
|-----------------|--------|
| mfp.topology.platform	| WAS |
| mfp.topology.clustermode | Clúster|
| mfp.admin.jmx.connector |	El tipo de conector JMX para conectar con el gestor de despliegue. El valor puede ser SOAP o RMI. SOAP es el valor predeterminado y preferido. Debe utilizar RMI si el puerto SOAP está inhabilitado. |
| mfp.admin.jmx.dmgr.host |	El nombre de host del gestor de despliegue. |
| mfp.admin.jmx.dmgr.port |	El RMI o el puerto SOAP utilizado por el gestor de despliegue, dependiendo del valor de mfp.admin.jmx.connector. |

Se pueden desplegar varios componentes de administración para permitirle ejecutar el mismo servidor o clúster con componentes de administración separados gestionando cada uno de los diferentes tiempos de ejecución. 

Cuando se despliegan varios los componentes de administración, debe especificar:

* En cada servicio de administración, un valor exclusivo para la propiedad JNDI **mfp.admin.environmentid** local.
* En cada tiempo de ejecución, el mismo valor para **mfp.admin.environmentid** local como el valor definido para el servicio de administración que gestiona ese tiempo de ejecución.

Si el host virtual correlacionado con una aplicación de servicio de administración no es el host predeterminado, debe establecer las siguientes propiedades en la aplicación de servicio de administración:

* **mfp.admin.jmx.user**: El nombre de usuario del administrador de WebSphere Application Server
* **mfp.admin.jmx.pwd**: La contraseña del administrador de WebSphere Application Server

### Utilización de un proxy inverso con topologías de granja de servidores y WebSphere Application Server Network Deployment
{: #using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies }
Puede utilizar un proxy inverso con topologías distribuidas. Si su topología utiliza un proxy inverso, configure las propiedades JNDI necesarias para el servicio de administración.

Puede utilizar un proxy inverso, como IBM HTTP Server, para afrontar topologías de granjas de servidores o WebSphere Application Server Network Deployment. En este caso, debe configurar los componentes de administración de forma adecuada.

Puede llamar al proxy inverso desde:

* El navegador cuando accede a {{ site.data.keys.mf_console }}.
* El tiempo de ejecución, cuando llama al servicio de administración.
* El componente {{ site.data.keys.mf_console }}, cuando llama al servicio de administración.

Si el proxy inverso está en una DMZ (una configuración de cortafuegos para asegurar redes de área local) y se utiliza un cortafuegos entre la DMZ y la red interna, este cortafuegos debe autorizar todas las solicitudes entrantes desde los servidores de aplicaciones.

Cuando se utiliza un proxy inverso delante de la infraestructura de servidor de aplicaciones, se deben definir las siguientes propiedades JNDI para el servicio de administración.

| Propiedades JNDI|	Valores|
|-----------------|--------|
| mfp.admin.proxy.protocol | El protocolo utilizado para comunicar con el proxy inverso. Puede ser HTTP o HTTPS. |
| mfp.admin.proxy.host | El nombre de host del proxy inverso. |
| mfp.admin.proxy.port | El número de puerto del proxy inverso. |

La propiedad **mfp.admin.endpoint** que hacer referencia al URL del proxy inverso también es necesaria para {{ site.data.keys.mf_console }}.

### Restricciones del servicio de envío por push de {{ site.data.keys.mf_server }}
{: #constraints-on-mobilefirst-server-push-service }
El servicio de envío por push puede estar en el mismo servidor de aplicaciones que el servicio de administración o el tiempo de ejecución, o puede estar en un servidor de aplicaciones distinto. El URL utilizado por las aplicaciones de cliente para contactar con el servicio de envío por push es el mismo que el URL utilizado por el cliente de aplicaciones para contactar con el tiempo de ejecución, se espera que la raíz de contexto del tiempo de ejecución se sustituya por imfpush. Si instala el servicio de envío por push en un servidor distinto al del tiempo de ejecución, su servidor HTTP debe dirigir el tráfico de la raíz de contexto /imfpush a un servidor donde se ejecute el servicio de envío por push.

Para obtener más información sobre las propiedades JNDI necesarias para adaptar la instalación a una topología, consulte [Servicio de administración de {{ site.data.keys.mf_server }} para servicio de envío por push de {{ site.data.keys.mf_server }} y para el servidor de autorizaciones](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server). El servicio de envío por push debe instalarse con la raíz de contexto **/imfpush**.

## Varios tiempos de ejecución de {{ site.data.keys.product }}
{: #multiple-mobilefirst-foundation-runtimes }
Puede instalar varios tiempos de ejecución. Cada tiempo de ejecución debe tener su propia raíz de contexto y todos los tiempos de ejecución los gestiona el mismo servicio de administración de {{ site.data.keys.mf_server }} y {{ site.data.keys.mf_console }}.

Se aplican las constantes descritas en [Restricciones en el servicio de administración de {{ site.data.keys.mf_server }}, el servicio de Live Update de {{ site.data.keys.mf_server }} y el tiempo de ejecución de {{ site.data.keys.product }}](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime). Cada tiempo de ejecución (con su raíz de contexto) debe tener sus propias tablas de bases de datos.

> Para obtener instrucciones, consulte [Configuración de varios tiempos de ejecución](../server-configuration/#configuring-multiple-runtimes).

## Varias instancias de {{ site.data.keys.mf_server }} en el mismo servidor o celda de WebSphere Application Server
{: #multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell }
Definiendo un ID de entorno común, es posible instalar varias instancias de {{ site.data.keys.mf_server }} en el mismo servidor.

Puede instalar varias instancias del servicio de administración de {{ site.data.keys.mf_server }}, del servicio Live Update de {{ site.data.keys.mf_server }} y del tiempo de ejecución de {{ site.data.keys.product }} en el mismo servidor de aplicaciones o la misma celda de WebSphere Application Server. Sin embargo, debe distinguir sus instalaciones con la variable JNDI: **mfp.admin.environmentid**, que es una variable del servicio de administración y el tiempo de ejecución. El servicio de administración gestiona solo los tiempos de ejecución que tienen el mismo identificador de entorno. Como tal, solo los componentes de tiempo de ejecución y el servicio de administración que tengan el mismo valor para **mfp.admin.environmentid** se consideran parte de la misma instalación.
