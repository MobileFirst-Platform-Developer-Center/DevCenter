---
title: Note About Application Authenticity Failures in Applications Downloaded from the Apple App Store
date: 2016-10-19
version: 
- 7.1
- 7.0
tags:
- MobileFirst_Foundation
- Application_Authenticity
author:
  name: Idan Adar 
---
This blog post details a possible scenario which can trigger false-positive failures in applications that utilize the Application Authenticity feature in IBM MobileFirst Platform Foundation 7.0, 7.1, after they were installed from the **Apple App Store**.

Related APAR: PI67872 EXTENDED APP AUTHENTICITY MAY FAIL ON APPLICATIONS INSTALLEDFROM THE APPLE APP STORE.

The failure happens when using the **Extended** Application Authenticity feature. The Extended Application Authenticity algorithm relies on the binary content of the application. We suspect that Apple has recently started manipulating the binary content in the process of submitting apps, and this action in turn prevents the feature from working correctly.

To future-proof the feature from these unwanted false-positives, the MobileFirst Platform development team has started work on a redesign of the Application Authenticity feature, which will not use the binary content and thus will not be affected by such external manipulations.

> **Note:** This blog post will be updated with news regarding the effort made, so keep an eye open for updates.  

### Workaround
For MobileFirst Platform Foundation 7.0 and 7.1, use **Basic** Application Authenticity (with bitcode switched off).  
The Basic Application Authenticity algorithm uses application metadata to generate challenges for the client. These challenges are generated in a random process which is very hard to reverse engineer/reproduce.
