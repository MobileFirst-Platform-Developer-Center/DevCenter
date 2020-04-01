---
title: Mobile Foundation support for Ionic 5
date: 2020-03-31
tags:
- MobileFirst_Platform
- Mobile_Foundation
- iOS
version:
- 8.0
author:
  name: Srutha Keerthi
---

We are happy to announce that IBM Mobile Foundation v8.0 officially supports the latest Ionic 5. Ionic 5 was released in February this year. Most of the changes have been made in the Ionic core. There have been multiple UI changes, especially in iOS.
There is a new API for creating custom animations, support for a lot of new designs in Ionicons, new Ionic colors have been introduced, new starter designs, improvements to component customization and more.
The official Ionic 5 announcement can be found [here](https://ionicframework.com/blog/announcing-ionic-5/).

The following Mobile Foundation v8.0 features have been validated with the stable release of Ionic 5 and *cordova-plugin-mfp* version 8.0.2020030204.

* Invoking back-end procedures through adapters
* Application management
* JSONStore
* Oauth handshake with Mobile Foundation server
* Push notifications

#### Direct Update
We have observed some intermittent loading issues concerning direct update. For direct update to work without any issues, add the *worklight.d.ts* reference in the *module.ts* files along with *component.ts* files to avoid the possible loading errors.

The below reference addition has to be done in *module.ts* files (along with the *component.ts* files):
`///<reference path="../../plugins/cordova-plugin-mfp/typings/worklight.d.ts"/>`

#### Application Authenticity
Dynamic App Authenticity is fully functional in both Android and iOS. We have observed that despite the BTS tool being able to create the required checksum, the server is unable to capture the required BTS enablement. We are actively working on resolving this issue. Please revisit this blog for updates on the resolution.


The runs have been performed on an app with the following versions of dependency packages.
* Ionic CLI: 5.4.15
* Ionic Framework: 5.0.5(@ionic/angular)
* cordova-android: 8.1.0
* cordova-ios: 5.1.1

>**NOTE**: Mobile Foundation v8.0 does not support `@ionic/react` and `@ionic/vue` yet.

Get started [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/ionic/).
