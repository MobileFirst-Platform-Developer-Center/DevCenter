---
layout: tutorial
title: Setting Up Analytics Support for Push Notifications
breadcrumb_title: Setting Up Analytics Support
relevantTo: [ios,android,windows,cordova]
weight: 5
---
## Overview
To set up Analytics support for Push Notification, the following JNDI properties must be set in order to initialize and configure the **Analytics plug-in**. The Analytics plug-in is provided by the Push Notifications service. If it is not set, the Push Notifications service will default to logging the events in the system logger.

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

The following properties are required to configure and initialize the IBM MobileFirst Foundation Analytics plug-in. The username and password will be used to authenticate with the Analytics service at the provided endpoint.

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

To track the notifications dispatched out of the Push Notifications service, ensure the following property is set to **true** (which is the default value):

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

To disable the sending of this event, set the property to **false**.

For information on viewing the Push Notification reports in the Analytics Console, see [Push Notification Reports](../../analytics/console/push-notifications/).

> For more information on the JNDI properties for push service, see [List of JNDI properties for MobileFirst Server push service](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).
> **Note:** The IBM MobileFirst Platform Foundation installer creates and sets up these properties to defaults.
