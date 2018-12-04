---
title: 'Migrate your client Apps on Android to FCM'
date: 2018-04-20
tags:
- MobileFirst_Foundation
- Push_Notifications
version:
- 8.0
- 7.1
author:
  name: Soumya Y Shanthimohan
---

Google Cloud Messaging (GCM) has been [deprecated](https://developers.google.com/cloud-messaging/faq) and is integrated with Firebase Cloud Messaging (FCM). Google will turn off most GCM services by April 2019.

The **Push Notifications on IBM Mobile Foundation** has been updated to use the FCM endpoints. For now, the existing applications using GCM services will continue to work.

However, the Push Notifications service will pull out support for GCM projects soon.

If you are using a GCM project, then [migrate the GCM client apps](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/handling-push-notifications/android/#migrate-to-fcm) on Android to FCM  at the earliest.

Note that there will be no change in the SDK and the client app would behave as expected. After migrating to FCM, update your project to use FCM credentials instead of the old GCM credentials.

We recommend the developers to upgrade at the earliest.

>**Note:** The GCM to FCM client side support is part of the plugin version **8.0.2018072407**.
