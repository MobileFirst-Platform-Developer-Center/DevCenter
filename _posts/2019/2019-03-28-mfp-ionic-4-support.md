---
title: Support for Ionic 4 in Mobile Foundation v8.0
date: 2019-03-28
tags:
- Announcement
- Mobile_Foundation
- Ionic_4
version:
- 8.0
author:
  name: Vittal Pai
---
We are pleased to announce the official support of Ionic 4 in IBM Mobile Foundation v8.0. This support is introduced from iFix *8.0.0.0-MFPF-IF201903250706* onwards.

You are required to install the ionic application with `cordova-plugin-mfp` version *8.0.2019031808* or greater.

We have validated the following Mobile Foundation v8.0 Foundation features with the stable release of Ionic 4.
* Invoking back-end procedures through adapters
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Oauth handshake with Mobile Foundation server
* Push notifications

From this release onwards, the `cordova-plugin-mfp` is not compatible with the version 1.x of `cordova-plugin-ionic-webview`, as it contains major webview changes. This release of `cordova-plugin-mfp` removes support for `cordova-plugin-ionic-weview` version 1.x and below. Please update `cordova-plugin-ionic-webview` to version 2.0 or higher.
