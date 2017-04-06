---
title: MobileFirst Foundation iFix 8.0.0.0-IF20170327-1055 released
date: 2017-04-06
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **March 27th, 2017**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

### New features
**PI78681 APPCENTER (CLIENT & SERVER) SUPPORT FOR WINDOWS 10**

With this iFix _*Application Center*_ ships the Windows 10 UWP client project for installing the UWP app. You can open the project in Visual Studio and create a binary (for example: **.appx**) for distribution. Application Center does not provide a predefined method of distributing the mobile client. For more information see [Microsoft Windows 10 Universal (Native) IBM AppCenter client](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

### APARs Fixed
**PI78757** WORKLIGHTRESOURCEREQUEST.SEND() HANGS IF DEVICE IS OFFLINEON WINDOWS10

**PI79414** CORDOVA JSONSTORE FAILS WITH LATEST CORDOVA 5.0 ONCORDOVA-WINDOWS5 PLATFORM

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers included in this iFix

**Windows SDK**  
IBM MobileFirstPlatformFoundation 8.0.2017030814

**Xamarin SDK**
ibm-worklight-8.0.2017040506

**Cordova plug-ins**  
cordova-plugin-mfp-jsonstore 8.0.2017033009

cordova-plugin-mfp 8.0.2017033009  
