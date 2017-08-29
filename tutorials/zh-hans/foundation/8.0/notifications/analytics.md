---
layout: tutorial
title: 对推送通知设置分析支持
breadcrumb_title: 设置分析支持
relevantTo: [ios,android,windows,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要对推送通知设置分析支持，必须设置以下 JNDI 属性以初始化和配置**“分析”插件**。“分析”插件由推送通知服务提供。如果未设置分析支持，那么推送通知服务在缺省情况下会将事件记录到系统记录器中。

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

需要使用以下属性来配置和初始化“{{ site.data.keys.mf_analytics }}”插件。在提供的端点上，将使用用户名和密码来向“分析”服务认证。

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

要跟踪从推送通知服务派出的通知，请确保将以下属性设置为 **true**（这是缺省值）：

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

要禁止发送此事件，请将该属性设置为 **false**。

有关在分析控制台中查看推送通知报告的信息，请参阅[推送通知报告](../../analytics/console/push-notifications/)。

> 有关推送服务的 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)。
> **注：**{{ site.data.keys.product_full }} 安装程序将创建这些属性并将其设置为缺省值。
