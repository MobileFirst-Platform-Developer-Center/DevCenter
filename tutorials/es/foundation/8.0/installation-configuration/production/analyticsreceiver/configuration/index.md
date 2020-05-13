---
layout: tutorial
title: Guía de configuración de MobileFirst Analytics Receiver Server
breadcrumb_title: Guía de configuración 
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Configuración para {{ site.data.keys.mf_analytics_receiver_server }}.

#### Ir a
{: #jump-to }

* [Propiedades de configuración](#configuration-properties)

### Propiedades
{: #properties }
Para obtener una lista completa de las propiedades de configuración y cómo establecerlas en el servidor de aplicaciones, consulte la sección [Propiedades de configuración](#configuration-properties).

## Propiedades de configuración
{: #configuration-properties }
{{ site.data.keys.mf_analytics_receiver_server }} se puede iniciar correctamente con la configuración adicional siguiente. 

La configuración se realiza mediante las propiedades JNDI en {{ site.data.keys.mf_server }} y en {{ site.data.keys.mf_analytics_receiver_server }}. Además, {{ site.data.keys.mf_analytics_receiver_server }} da soporte al uso de variables de entorno para controlar la configuración. Las variables de entorno prevalecen sobre las propiedades JNDI.

El tiempo de ejecución de Analytics Receiver debe reiniciarse para que apliquen los cambios realizados en estas propiedades. No es necesario reiniciar todo el servidor de aplicaciones.

Para establecer una propiedad JNDI en WebSphere Application Server Liberty, añada una etiqueta al archivo `server.xml` como se indica a continuación.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Para establecer una propiedad JNDI en Tomcat, añada una etiqueta al archivo `context.xml` de este modo. 

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

Las propiedades JNDI en WebSphere Application Server están disponibles como variables de entorno.

* En la consola de WebSphere Application Server, seleccione **Aplicaciones → Tipos de aplicaciones → Aplicaciones empresariales de WebSphere**.
* Seleccione la aplicación **Servicio de administración de {{ site.data.keys.product_adj }}**.
* En **Propiedades de módulo web**, pulse **Entradas de entorno para módulos web** para visualizar las propiedades de JNDI.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
La tabla siguiente muestra las propiedades que se pueden establecer en {{ site.data.keys.mf_analytics_receiver_server }}.

| Propiedad                           | Descripción                                           | Valor predeterminado |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | Establezca esta propiedad en el URL de {{ site.data.keys.mf_analytics_console }}. Por ejemplo, `http://hostname:port/analytics/console`. El establecimiento de esta propiedad permite el icono de análisis de {{ site.data.keys.mf_console }}. | Ninguno |
| receiver.analytics.url                  |Necesario. El URL que expone {{ site.data.keys.mf_analytics_server }} que recibe datos analíticos de entrada. Por ejemplo, `http://hostname:port/analytics-service/rest`. | Ninguno |
| receiver.analytics.username             | El nombre de usuario que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | Ninguno |
| receiver.analytics.password             | La contraseña que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | Ninguno |
| receiver.analytics.event.qsize          | Tamaño de la cola de sucesos de análisis. Se debe añadir con precaución proporcionan un tamaño de pila JVM amplio. Tamaño de cola predeterminado, 10000  | Ninguno |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
La tabla siguiente muestra las propiedades que se pueden establecer en {{ site.data.keys.mf_server }}.

| Propiedad                           | Descripción                                           | Valor predeterminado |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  |Necesario. El URL expuesto por {{ site.data.keys.mf_analytics_receiver_server }} que recibe datos de análisis de entrada y los envía a {{ site.data.keys.mf_analytics_server }}. Por ejemplo, `http://hostname:port/analytics-receiver/rest`. | Ninguno |
| mfp.analytics.receiver.username             | El nombre de usuario que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | Ninguno |
| mfp.analytics.receiver.password             | La contraseña que se utiliza si el punto de entrada de datos está protegido con autenticación básica. | Ninguno |
