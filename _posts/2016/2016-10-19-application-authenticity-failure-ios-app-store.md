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

This blog post details a possible scenario which can trigger a failure where Application Authenticity will reject an iOS application despite the application's authentic identity, in IBM MobileFirst Platform Foundation 7.0, 7.1 and 8.0, after the application was installed from the **Apple App Store**.

Related APARs:

* PI67872 EXTENDED APP AUTHENTICITY MAY FAIL ON APPLICATIONS INSTALLED FROM THE APPLE APP STORE.
* PI72795 APPLICATION AUTHENTICITY CHECK DOESN'T WORK IN IOS APPLICATIONS INSTALLED FROM THE APPLE APP STORE

Specifically for IBM MobileFirst Platform Foundation 7.0 and 7.1 the failure happens when using the **Extended** Application Authenticity feature. The Extended Application Authenticity algorithm relies on the binary content of the application. We suspect that Apple has recently started manipulating the binary content in the process of submitting apps, and this action in turn prevents the feature from working correctly.

To future-proof the feature from this failure, the MobileFirst Platform development team has started work on a redesign of the Application Authenticity feature, which will not use the binary content and thus will not be affected by such external manipulations.

### Workaround
For MobileFirst Platform Foundation 7.0 and 7.1, use **Basic** Application Authenticity (with bitcode switched off).  
The Basic Application Authenticity algorithm uses application metadata to generate challenges for the client. These challenges are generated in a random process which is very hard to reverse engineer/reproduce.

For MobileFirst Foundation 8.0 there is currently no workaround until an iFix containing a fix is released.

> **Note:** This blog post will be updated with news regarding fix availability, so keep an eye open for updates.
