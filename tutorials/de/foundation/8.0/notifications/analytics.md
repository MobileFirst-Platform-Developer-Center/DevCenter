---
layout: tutorial
title: Analytics-Unterstützung für Push-Benachrichtigungen einrichten
breadcrumb_title: Setting Up Analytics Support
relevantTo: [ios,android,windows,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Für das Setup der Analytics-Unterstützung für Push-Benachrichtigungen
müssen die folgenden JNDI-Eigenschaften definiert werden, um das **Analytics-Plug-in** zu initialisieren und zu konfigurieren. Das Analytics-Plug-in wird
vom Push-Benachrichtigungsservice bereitgestellt. Wenn die Eigenschaften nicht definiert sind, protokolliert der Push-Benachrichtigungsservice die Ereignisse
standardmäßig im System-Logger. 

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

Die folgenden Eigenschaften sind erforderlich, um das
MobileFirst-Analytics-Plug-in zu konfigurieren und zu initialisieren. Die Authentifizierung gegenäber dem Analytics-Service am angegebenen Endpunkt erfolgt mit Benutzernamen und Kennwort. 

```xml
<jndiEntryjndiName = "imfpush/mfp.push.analytics.endpoint" value = "http://<MFP-Server:Port>/analytics-service/rest/data"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.user" value = "<Benutzername>"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.password" value = "<Kennwort>"/>
```

<!--
Push is meant to send two types of analytics events to the Analytics service. These are:

* Subscriptions/Un-subscriptions: To track the subscriptions to notifications.
* Push notifications: To track the push notifications dispatched out of the push notification service.

14/11/2016 only push notifications show up in reports, so we are removing any mention of the other events in the meantime, until there is a way to report on the other events.
-->

Für die Verfolgung der vom Push-Benachrichtigungsservice versendeten Benachrichtigungen muss dei folgende
Eigenschaft auf (den Standardwert) **true** gesetzt sein: 

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

Wenn Sie das Senden des Ereignisses inaktivieren möchten, setzen Sie die Eigenschaft auf **false**.

Informationen zum Anzeigen der Berichte zu Push-Benachrichtigungen in der Analytics Console finden Sie
unter [Berichte zu Push-Benachrichtigungen](../../analytics/console/push-notifications/).

> Weitere Informationen zu den JNDI-Eigenschaften für den Push-Service finden Sie in der [Liste der JNDI-Eigenschaften für den Push-Service von {{ site.data.keys.mf_server }}](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).
  **Hinweis:** Das Installationsprogramm für die {{ site.data.keys.product_full }} erstellt diese
Eigenschaften und setzt sie auf die Standardwerte. 

