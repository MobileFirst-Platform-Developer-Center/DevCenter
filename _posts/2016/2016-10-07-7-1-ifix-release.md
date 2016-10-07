---
title: MobileFirst Platform Foundation iFix 7.1.0.0-MFPF-IF201610060540 released
date: 2016-10-07
version:
- 7.1
tags:
- MobileFirst_Foundation
- Announcement
- iFix
- 7.1
author:
  name: Idan Adar 
---
A new iFix has been released for MobileFirst Platform Foundation 7.1.  
[Download iFix](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=7.1.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central)

## Highlights
* JSONStore support for Android N
* Fix for SSL keystore information leakage

## Included changes in this iFix
*For a cumulative list of all previous fixes, see the iFix download page on IBM Fix Central.*

PI69749 AFTER APPLYING A MFPF PRODUCT UPDATE, EXISTING APP MAY NOT BE ABLE TO OPEN JSONSTORE  
PI69662 NTLM AUTHENTICATION MAY FAIL UNDER LOAD  
PI69380 SSL THREAD INFORMATION NOT CLEARED AFTER ADAPTER CALL, RESULTING IN A CERTIFICATE CHAINING ERROR.  
PI69110 NOT GETTING NOTIFICATION ON 10.0, IF MINAPPOSVERSION IS 9.3  
PI67861 THERE IS CURRENTLY NO WAY TO PREVENT THE TRUSTEER SDK TO AUTO-INIT.  
PI67242 PUSH NOTIFICATION WONT SENT IN ANDROID DEVICES GCM WHEN MAX QUEUE LENGTH IS HIT  
PI66998 ATTEMPTING TO DO AN HTTP GET ON A DIRECTORY FROM THE MOBILEFIRST SERVER MAY REVEAL SERVER CONFIG INFORMATION  
PI66883 JSONSTORE FAILS AND PRODUCES CLIENT ERRORS IN APPLICATIONS RUNNING ON ANDROID N  
PI61676 ERROR "NO XAML WAS FOUND AT THE LOCATION" RECEIVED IN APP ON WINDOWS PHONE.  
PI61438 SENSITIVE SSL KEYSTORE INFORMATION MAY BE DISPLAYED IN CLIENT AND SERVER ERROR LOGS  