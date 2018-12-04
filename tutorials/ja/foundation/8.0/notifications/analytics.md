---
layout: tutorial
title: プッシュ通知に対する Analytics サポートのセットアップ
breadcrumb_title: Setting Up Analytics Support
relevantTo: [ios,android,windows,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
プッシュ通知に対する Analytics サポートをセットアップするには、以下の JNDI プロパティーを設定して、**Analytics プラグイン**を初期化および構成する必要があります。 Analytics プラグインは、プッシュ通知サービスによって提供されます。 これが設定されていない場合、プッシュ通知サービスは、システム・ロガーでイベントを記録するようにデフォルト設定されます。

```xml
<jndiEntryjndiName = "imfpush/mfp.push.services.ext.analytics" value = "com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
```

{{ site.data.keys.mf_analytics }} プラグインの構成と初期化のために、以下のプロパティーが必要です。 ユーザー名とパスワードが、指定されたエンドポイントで分析サービスとの認証を行うために使用されます。

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

プッシュ通知サービスからディスパッチされた通知をトラッキングするには、以下のプロパティーを **true** (これがデフォルト値です) に設定してください。

<!--
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagSubscribe" value = "true"/>
<jndiEntryjndiName = "imfpush/mfp.push.analytics.events.tagUnSubscribe" value = "true"/>
-->

```xml
<jndiEntryjndiName = "mfp.push.analytics.events.notificationDispatch" value = "true"/>
```

このイベントの送信を無効にするには、プロパティーを **false** に設定します。

Analytics コンソールでプッシュ通知レポートを表示する方法については、[プッシュ通知レポート](../../analytics/console/push-notifications/)を参照してください。

> プッシュ・サービスに関するこれらの JNDI プロパティーについて詳しくは、[{{ site.data.keys.mf_server }} プッシュ・サービスの JNDI プロパティーのリスト](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)を参照してください。
> **注:** {{ site.data.keys.product_full }} インストーラーは、これらのプロパティーを作成し、デフォルトにセットアップします。
