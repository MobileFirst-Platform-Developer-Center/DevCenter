---
title: IBM MobileFirst and iOS12
date: 2018-09-17
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- iOS12
version:
- 7.1
- 8.0
author:
  name: Sandhya Suman
---

iOS12 is [here](https://developer.apple.com/download/) and IBM MobileFirst is pleased to announce that we have embraced the iOS12 upgrade gracefully like every year.

In our previous [blog post]({{site.baseurl}}/blog/2018/07/23/mfp-support-for-ios12/), we mentioned about the various new changes seen in iOS12 and what you, as a developer should be doing about it.
Existing application(s) that were created using MobileFirst Platform v7.1 and v8.0 **will work** as they did on previous versions of iOS even after upgrade to iOS12.

We have validated MobileFirst v8.0 and v7.1 with the GM release of iOS12, and the all the major features listed below work fine with iOS12.

* Invoking backend procedures through adapters
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Oauth handshake with MobileFirst server
* Push notifications

### Targeting to build your app with iOS12  

* If you are planning to build your MobileFirst v8 application for iOS12  you have to remove *stdc++* library from your Dependencies. This is because *stdc++* is removed in iOS 12. Refer to **Known Issues** section in [this blog post]({{site.baseurl}}/blog/2018/07/23/mfp-support-for-ios12/), for details about the workaround.

* For Cordova apps, please upgrade to the latest iFix [mfp-ifix-IF201809041150]({{site.baseurl}}/blog/2018/05/18/8-0-master-ifix-release/#collapse-mfp-ifix-IF201809041150) so that your Cordova projects have the correct reference of *libc++*, automatically. For v7.1, you can upgrade to the iFix [7.1.0.0-MFPF-IF201808161052]({{site.baseurl}}/blog/2018/05/18/7-1-master-ifix-release/).
