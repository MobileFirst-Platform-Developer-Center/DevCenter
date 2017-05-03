---
title: Note About Application Authenticity Failures in Applications Downloaded from the Apple App Store
date: 2016-10-19
version:
- 8.0
- 7.1
- 7.0
tags:
- MobileFirst_Foundation
- Application_Authenticity
author:
  name: Idan Adar
---

This blog post details a possible scenario, whereby the Application Authenticity validation rejects an iOS application that was installed from the Apple App Store, despite the application's authentic identity. This post is applicable to IBM MobileFirst Platform Foundation V7.0, V7.1, and V8.0.

Related APARs:

* PI67872 EXTENDED APP AUTHENTICITY MAY FAIL ON APPLICATIONS INSTALLED FROM THE APPLE APP STORE.
* PI72795 APPLICATION AUTHENTICITY CHECK DOESN'T WORK IN IOS APPLICATIONS INSTALLED FROM THE APPLE APP STORE

In MobileFirst Platform Foundation **V7.0 and V7.1**, the failure happens when the **Extended** Application Authenticity feature is used. The Extended Application Authenticity algorithm relies on the binary content of the application. The failure might result from manipulation of the binary content, by Apple, during the app submission process, which prevents the feature from working correctly.

To avoid such failures, the MobileFirst Platform development team is redesigning the Application Authenticity feature to eliminate the use of the binary content, and thus bypass the effects of such external manipulations.

### Workaround
For MobileFirst Platform Foundation **V7.0 and V7.1**, use **Basic** Application Authenticity (with bitcode switched off). The Basic Application Authenticity algorithm uses application metadata to generate challenges for the client. These challenges are generated in a random process, which is difficult to reverse engineer or reproduce.

For MobileFirst Foundation **V8.0**, until the Application Authenticity redesign is completed, an interim fix was released with a workaround that implements basic application-authenticity validation for iOS. For more information, see APAR PI72795.

> **Note:** For an update on this, please read [Extended application authenticity feature does not work in MobileFirst Platform for iOS v7.x and v8.0](https://mobilefirstplatform.ibmcloud.com/blog/2017/04/17/extended-app-authenticity-feature-does-not-work/).
