---
title: MobileFirst Foundation iFix 8.0.0.0-IF20170125-0919 released
date: 2017-02-01
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
author:
  name: Idan Adar 
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **January 25th, 2017**.

> **Update, February 2nd:** newer Native iOS SDK and Cordova plug-ins were released to CocoaPods and npm.
> * iOS SDK: Includes Swift 3.0 compatibility fixes and the ability to [make resource request calls in the background]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/resource-request/ios/#callback-queue-for-completionhandler-and-delegate).
> * Cordova SDK: Fix client-server version compatibility.

## Known issues
* ~~If using the updated **cordova-plugin-mfp** plug-in with an older MobileFirst Server build, you may not be able to connect to the server. This will be fixed in an updated plug-in in the coming days.~~ This issue is fixed with the updated cordova-plugin-mfp@8.0.2017013103. Install it by removing and re-adding the plug-in.
* The **test** confidential client is missing. It can be manually added via **MobileFirst Operations Console → Runtime Settings → Confidential Clients** with the scope set to "*".

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

**MobileFirst Server**  
PI74759 CAN'T PASS A JSON OBJECT OR A JSON ARRAY AS A PARAMETER TO MFP.SERVER.INVOKEPROCEDURE  
PI74262 THE JSON OBJECT RETURNED FROM INVOKESQLSTOREDPROCEDURE DOES NOT CONTAIN THE ISSUCCESSFUL STATUS  
PI74084 JAVA TOKEN VALIDATOR AND OAUTH TAI THREAD BOTTLNECK  

**MobileFirst Operations Console**  
PI74404 TOTAL NUMBER OF DEPLOYED APPS AND ADAPTERS MAY NOT BE DISPLAYED CORRECTLY IN MOBILEFIRST OPERATIONS CONSOLE  

**Application Center**  
PI74108 SPEEDUP APPLICATION INSTALLATION BY AVOIDING TO LOAD FEEDBACKS AND INSTALLATION OF APP VERSIONS UNNECESSARILY
PI72837 APPCENTER INSTALLER.HTML PAGE DOES NOT FUNCTION PROPERLY IN ANDROID CHROME VERSION 54.X IN TABLET MODE  
PI62939 "SERVER IS UNREACHABLE..." ERROR DISPLAYED WHEN UNINSTALLING AN APP USING THE APP CENTER MOBILE CLIENT ON A WINDOWS DEVICE    

**Client SDKs**  
PI75296 WHEN THE USER PUSHES JSONSTORE DATA TO THE ADAPTER USING THE PUSH API, THE PARAMETERS PASSED DO NO GET SENT TO THE ADAPTER  
PI75098 MALFORMED HTTP RESPONSE CAUSED IOS APP CRASH  
PI74988 MULTIPLE AUTHORIZATION CALLS ARE MADE FOR EACH REST CALL IN ANDROID APPLICATION  
PI74123 WEB APPLICATION WILL NOT WORK IN INTERNET EXPLORER 10  
PI72718 IN XAMARIN MFP SDK 8.0 ON WINDOWS UWP ADDHEADER(WEBHEADERCOLLECTION HEADER) IS NOT AVAILABLE  
PI72691 CANCELLING AN AUTHENTICATION CHALLENGE FROM SERVER DOES NOT WORK IN MFP 8.0 XAMARIN SDK FOR ANDROID AND IOS  
PI72602 WINDOWS WORKLIGHTCHALLENGEHANDLER'S HANDLESUCCESS() & HAN DLEFAILURE() METHODS OF ARE NOT INVOKED IN AUTHENTICATION FLOW  
PI72397 Multiple Android devices may get the same device ID (In Android 6.0 and above)  

See additional changes to cordova-plugin-mfp in the [previous stand-alone release of the plug-in]({{ site.baseurl }}/blog/2017/01/06/8-0-cordova-plugin-mfp-release/).

**MobileFirst CLI**  
No additional changes [since the previous build]({{ site.baseurl }}/blog/2017/01/06/8-0-cli-release/).

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).

**MobileFirst CLI**  
To upgrade, run `npm install -g mfpdev-cli`.

> Be sure to use Node.js 5 or 6. Node.js 7 has a known issue and cannot be used.

## Individual artifacts build numbers included in iFix
**Server**  
server runtime 8.0.2017011711

**Web SDK**  
ibm-mfp-web-sdk 8.0.2016121609  

**iOS SDK**  
IBMMobileFirstPlatformFoundationPush 8.0.2017012509  
IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017012509  
IBMMobileFirstPlatformFoundationJSONStore 8.0.2017012509  
IBMMobileFirstPlatformFoundation 8.0.2017012509  

*Update - available on CocoaPods*  
IBM MobileFirst Platform Foundation iOS SDK 8.0.2017013015  
IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017013015  
IBMMobileFirstPlatformFoundationJSONStore 8.0.2017013015

**Android SDK**  
ibmmobilefirstplatformfoundationjsonstore 8.0.2017011811  
ibmmobilefirstplatformfoundationpush  8.0.2017011813  
ibmmobilefirstplatformfoundation 8.0.2017012509  

*Update - available on gradle*  
ibmmobilefirstplatformfoundation-8.0.2017012919

**Windows SDK**  
IBM.MobileFirstPlatformFoundationPush 8.0.2017012419  
IBM.MobileFirstPlatformFoundation 8.0.2017012514

**Xamarin SDK**  
ibm-worklight-8.0.2017013105 - *Coming soon*

**Cordova plug-ins**  
cordova-plugin-mfp 8.0.2017012210  
 +cordova-plugin-mfp-push 8.0.2017012410  
 +cordova-plugin-mfp-jsonstore 8.0.2017012210  
 +cordova-plugin-mfp-fips 8.0.2017012210  
 +cordova-plugin-mfp-encrypt-utils 8.0.2017012210  
 +cordova-template-mfp 8.0.2017012210 
 
*Update - available on npm*
cordova-plugin-mfp 8.0.2017013103    
cordova-plugin-mfp-push 8.0.2017012410  
cordova-plugin-mfp-jsonstore 8.0.2017013103  
cordova-plugin-mfp-fips 8.0.2017013103  
cordova-plugin-mfp-encrypt-utils 8.0.2017013103  
cordova-template-mfp 8.0.2017013103  

**Tools**  
mfpdev-cli 8.0.201701201  
