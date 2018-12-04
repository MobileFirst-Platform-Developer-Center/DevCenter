---
layout: tutorial
title: Configuración del soporte de Analytics para notificaciones push
breadcrumb_title: Setting Up Analytics Support
relevantTo: [ios,android,windows,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Para configurar el soporte de analíticas para notificaciones push, se deben establecer las siguientes propiedades JNDI para inicializar y configurar el **plugin de analíticas**. El servicio de notificaciones push proporciona el plugin de analíticas. Si no se define, el servicio de notificaciones push de forma predeterminada registrará sucesos en el registrador del sistema.

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

Se necesitan las siguientes propiedades para configurar e inicializar el plugin de {{ site.data.keys.mf_analytics }}. El nombre de usuario y la contraseña se utilizarán para autenticar el servicio de analíticas en el punto final proporcionado.

```xml
<jndiEntryjndiName = "imfpush/mfp.push.analytics.endpoint" value = "http://<mfpserver:port>/analytics-service/rest/data"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.user" value = "<username>"/>  
<jndiEntryjndiName = "imfpush/mfp.push.analytics.password" value = "<password>"/>
```

<!--
Push is meant to send two types of analytics events to the Analytics service. These are:

* Subscriptions/Un-subscriptions: To track the subscriptions to notifications.
* Push notifications: To track the push notifications dispatched out of the push notification service.

14/11/2016 only push notifications show up in reports, so we are removing any mention of the other events in the meantime, until there is a way to report on the other events.
-->

Para realizar un seguimiento de las notificaciones que el servicio de notificaciones push proporciona, asegúrese de que la siguiente propiedad está establecida en **true** (que es el valor predeterminado):

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

Para inhabilitar el envío de este suceso, establezca la propiedad en **false**.

Para obtener información sobre cómo visualizar informes de notificaciones push, consulte los [Informes de notificaciones push](../../analytics/console/push-notifications/).

> Para obtener más información sobre las propiedades JNDI para el servicio push, consulte[Lista de propiedades JNDI para el servicio push de {{ site.data.keys.mf_server }} ](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).
> **Nota:** El instalador de {{ site.data.keys.product_full }} crea y configura estas propiedades en los valores predeterminados.
