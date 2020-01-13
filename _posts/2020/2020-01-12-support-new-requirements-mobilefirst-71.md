---
title: Support statement for new requirements on MobileFirst Platform Foundation v7.1
date: 2020-01-12
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- iOS
version:
- 7.1
author:
  name: Srihari Kulkarni
---

MobileFirst Platform Foundation version v7.1 is approaching its end of support, which is on [March 31, 2020](https://www-01.ibm.com/support/docview.wss?uid=swg3s894700o65547s81). Any upcoming requirements or deprecations from the Apple or Google ecosystem are considered [new features](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/), and therefore _will not be supported even under an extended support contract_. This applies to the following list of upcoming requirements.

1. Use of UIWebView - New apps containing UIWebView [will not be accepted to the Apple App Store](https://developer.apple.com/news/?id=12232019b), starting April 2020 and app updates using UIWebView from December 2020.

2. Use of legacy binary protocol for Push Notifications - Apple has [notified developers](https://developer.apple.com/news/?id=11042019a) about switching to HTTP/2 based APNs provider for sending push notifications. Starting from November 2020, all notifications should be sent over the HTTP/2 protocol.

3. Support for new mobile OS releases - Support for new OS releases for all supported platforms such as Android, iOS, and Windows when available will not be made available on MobileFirst Platform Foundation v7.1.

>**Note**: This is not an exhaustive list and any new requirements or deprecations from Apple or Google in the future, will also be considered as new features.

Mobile Foundation v8.0 accounts for the above changes and _will provide support for new and upcoming mobile OS versions_. Therefore, if your apps are running on MobileFirst Platform Foundation v7.1, especially the ones that are published to public app stores, we strongly recommend you to migrate to Mobile Foundation v8.0 at the earliest to avail continued support for new mobile OS versions and developer ecosystem changes.
