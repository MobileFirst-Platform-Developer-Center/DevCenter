---
title: Support Statement for New Requirements on MobileFirst v7.1
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

MobileFirst version v7.1 is reaching its end of support date on [March 31, 2020](https://www-01.ibm.com/support/docview.wss?uid=swg3s894700o65547s81). Any upcoming requirements from the Apple / Google ecosystem are considered as [new features](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/) and therefore **will not be supported even under an extended support contract**. This applies to the following list of upcoming requirements. This is not an exhaustive list and any new requirements imposed by Apple or Google in future will also be considered as new features. 

1. Use of UIWebView - New apps containing UIWebView [will not be accepted to the Apple App Store](https://developer.apple.com/news/?id=12232019b) starting April 2020 and app updates using UiWebView from December 2020. 

2. Use of legacy binary protocol for Push notifications - Apple has [notified developers](https://developer.apple.com/news/?id=11042019a) about switching to HTTP/2 based APNs provider for sending push notifications. Starting November 2020, all notifications should be sent over the HTTP/2 protocol. 

3. Support for new mobile OS releases - Support for new OS releases for all supported platforms - Android, iOS, Windows when available will not be available on MobileFirst v7.1 

MobileFirst v8 already accounts for the aforementioned changes and will provide support for new, upcoming mobile OSes. Therefore, if your apps are running on MobileFirst v7.1, we strongly encourage you to migrate to MobileFirst v8 at the earliest to avail of continued support for new mobile OSes and changes in the developer ecosystem.
