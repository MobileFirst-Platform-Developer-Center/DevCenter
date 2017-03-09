---
title: MobileFirst Foundation iFix 8.0.0.0-IF20170220-1900 released
date: 2017-03-09
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **February 20th, 2017**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

### New features


**Dynamic App Authenticity**

This iFix introduces a new implementation of *Application Authenticity*. This implementation does not require the offline **mfp-app-authenticity** tool for generating the **.authenticity_data** file. Instead, you can enable or disable *Application Authenticity* from the MobileFirst console. For more information see [Configuring Application Authenticity](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity/#configuring-application-authenticity ).

>**Important:** Android, iOS, Windows, Xamarin, Web & Cordova applications built with _**iFix 8.0.0.00-20170216-202020**_ will require a _**minimum server version of 8.0.0.00-20170216-202020**_. If you're using an older version of the server, please upgrade your server by downloading the latest build from [FixCentral](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) or from the [Downloads](https://mobilefirstplatform.ibmcloud.com/downloads/) page.


If you are using Mobile Foundation on IBM Bluemix, please **Re-create** the server with the updated version.

>**Note:** The server behavior during **Re-create** would vary depending on the plan selected. Refer to the [Mobile Foundation documentation](https://console.ng.bluemix.net/docs/services/mobilefoundation/index.html#gettingstartedtemplate) for more information.

### APARs Fixed
**PI75479** BITCODE NOT SUPPORTED IN MFP V8.0

**PI72424** INCORRECT SERVERS DISPLAYED FOR NODE IN SERVER CONFIGURATION TOOL

**PI66415** OUR DEFAULT SCOPE IS EMPTY STRING AND WE CHANGE IT TO: "REGISTEREDCLIENT".


## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers included in this iFix
**Server**  
Server runtime 8.0.2017021501

**MobileFirst DevKit**

8.0.0.0-MFPF-DevKit-Linux-IF201702201900.bin         
8.0.0.0-MFPF-DevKit-Mac-IF201702201900.zip     
8.0.0.0-MFPF-DevKit-Windows-IF201702201900.exe

**Web SDK**  
ibm-mfp-web-sdk 8.0.2017021409

**iOS SDK**  
IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017021516

IBMMobileFirstPlatformFoundation 8.0.2017022013

**Android SDK**  
ibmmobilefirstplatformfoundation 8.0.2017021516  

**Windows SDK**  
IBM.MobileFirstPlatformFoundation 8.0.2017021614

**Cordova plug-ins**  
cordova-plugin-mfp 8.0.2017021815

cordova-plugin-mfp-jsonstore 8.0.2017021815  

cordova-plugin-mfp-fips 8.0.2017021815

cordova-plugin-mfp-encrypt-utils 8.0.2017021815

cordova-template-mfp 8.0.2017021815
