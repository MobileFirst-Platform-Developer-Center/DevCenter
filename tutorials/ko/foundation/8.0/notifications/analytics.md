---
layout: tutorial
title: 푸시 알림에 대한 Analytics 지원 설정
breadcrumb_title: Setting Up Analytics Support
relevantTo: [ios,android,windows,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
푸시 알림에 대한 Analytics 지원을 설정하려면 **Analytics 플러그인**을 초기화하고 구성하기 위해 다음과 같은 JNDI 특성을 설정해야 합니다. Analytics 플러그인은 푸시 알림 서비스에 의해 제공됩니다. 제공되지 않는 경우 푸시 알림 서비스는 시스템 로거에서 이벤트를 로깅하도록 기본적으로 설정됩니다.

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

{{ site.data.keys.mf_analytics }} 플러그인을 구성하고 초기화하려면 다음과 같은 특성이 필요합니다. 사용자 이름 및 비밀번호는 제공된 엔드포인트에서 Analytics 서비스에 대해 인증하는 데 사용됩니다.

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

푸시 알림 서비스에서 디스패치된 알림을 추적하려면 다음과 같은 특성이 **true**(기본값임)로 설정되어 있는지 확인하십시오.

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

이 이벤트의 전송을 사용 안함으로 설정하려면 이 특성을 **false**로 설정하십시오.

Analytics Console에서 푸시 알림 보고서를 보는 것에 대한 정보는 [푸시 알림 보고서](../../analytics/console/push-notifications/)를 참조하십시오.

> 푸시 서비스의 JNDI 특성에 대한 자세한 정보는 [{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)을 참조하십시오.
> **참고:** {{ site.data.keys.product_full }} 설치 프로그램은 이 특성을 작성하여 기본값으로 설정합니다.
