---
title: 'Migrate your client Apps on Android to FCM'
date: 2018-04-20 // date of the blog post publication
tags:
- MobileFirst_Foundation
- Push_Notifications
version:
- 8.0
- 7.1
author:
  name: Soumya Y Shanthimohan
---

The Push Notifications on IBM Mobile Foundation earlier sent notifications from the MobileFirst Server to the vendor [Apple, Google (FCM/GCM), Microsoft, SMS Gateways] infrastructure, and from there to the mobile and browser applications.

As you may be aware, Google has [deprecated GCM](https://developers.google.com/cloud-messaging/faq) and has integrated Cloud Messaging with Firebase.

The MobileFirst Server has now been updated to use only [Apple, **Google (FCM)**, Microsoft, SMS Gateways] infrastructure to dispatch notifications.

If you are using a GCM project, ensure that you [migrate the GCM client apps on Android to FCM](https://developers.google.com/cloud-messaging/android/android-migrate-fcm) .




