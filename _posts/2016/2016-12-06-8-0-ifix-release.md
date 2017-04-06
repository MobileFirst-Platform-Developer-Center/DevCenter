---
title: MobileFirst Foundation iFix 8.0.0.0-IF20161122-19 released
date: 2016-12-06
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
author:
  name: Idan Adar 
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **November 22nd, 2016**.

For on-prem installations, [download the iFix package](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central).  

> Mobile Foundation Bluemix service users, check your service dashboard for available updates.

## Included changes in this iFix
*For a cumulative list of all previous fixes, see the iFix download page on IBM Fix Central.*

#### MobileFirst Server, Operational Analytics and Application Center
> To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/) / [Developer Kit for customers](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc), iFix package for production environment, or refresh your Mobile Foundation service from your service Dashboard.

**MobileFirst Server**

PI71502 LAST ACCESS TIME IS NOT PROVIDED IN THE GET DEVICES REST API  
PI71291 TEST CONFIDENTIAL CLIENT IS MISSING IN DEVKIT SERVER  
PI71066 MOBILEFIRST SERVER SHOWS CERTIFICATE EXPIRED FOR HYBRID APP ON RUNNING ON IOS DEVICES  
PI70459 LOW SEVERITY SECURITY VULNERABILITIES IN LIBERTY MIGHT REQUIRE BUNDLING OF A NEW LIBERTY VERSION IN PA  
PI69400 WITH NO APPS DEPLOYED, REQUESTING THE DOWNLOAD OF THE LICENSE TRACKING REPORT RESULTS IN AN ERROR 500  

**MobileFirst Operational Analytics**  

PI71936 MULTIPLE ANALYTICS HEADERS ( X-WL-CLIENTLOG* ) ARE SENT ON HTTP REQUESTS  
PI71216 WHEN LOGGING WRONG TIME IS SHOWN IN THE ANALYTICS CONSOLE  
PI70820 DOCUMENTATION DOES NOT SPECIFY THAT USERINFO PASSED TO OCLOGGER LOGWITHLEVEL IS LOGGED AS CUSTOM ANALYTICS  

**Application Center**  

PI71975 MOBILEFIRST APPLICATION CENTER DISPLAYS LOW RESOLUTION ICON FOR IOS APPS    
PI70850 / PI72086 APPCENTER INSTALLER.HTML PAGE DOES NOT FUNCTION PROPERLY IN ANDROID CHROME VERSION 53.0.2785.124  

#### Client SDKs
> To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).

PI72402 INFINITE FAILURE LOOP OF DIRECT UPDATE IN ANDROID    
PI72174 DIRECT UPDATE WL.SIMPLEDIALOG.SHOW ERROR  
PI71695 CORDOVA BUILD ERROR OCCURS WHEN ADDING CORDOVA PLUGIN INTO AN EXISTING VISUAL STUDIO CORDOVA PROJECT  
PI71643 IOS DIRECT UPDATE DOWNLOAD FAIL IF SERVED FROM CLUSTER  
PI66577 PROGRESS BAR MAY DISAPPEAR DURING DIRECT UPDATE    
PI71613 CORDOVA IOS APP BUILD FAILS WITH CORDOVA-PLUGIN-MFP-JSONSTORE WITH "LD: FRAMEWORK NOT FOUND SQLCIPHER" ERROR  
PI68080 WLLOGGER MAY CAUSE INTERMITTENT APPLICATION CRASH ON ANDROID  
PI66883 JSONSTORE FAILS AND PRODUCES CLIENT ERRORS IN APPLICATIONS RUNNING ON ANDROID N  

#### MobileFirst CLI
> To upgrade, run `npm upgrade -g mfpdev-cli`.

PI72368 WHEN RUNNING THE COMMAND `MFPDEV ADAPTER CALL` ON CERTAIN ADAPTERS THE PROGRAM MAY ABRUPTLY END RETURNING AN ERROR  
PI71800 WEBUPDATE FAILS WHEN THE APP HAS MULTIPLE PACKAGE NAMES  
PI71330 MFPDEV APP PREVIEW COMMAND DOES NOT ALLOW USE OF THE "PROMPT()" FUNCTION ON THE ANDROID PLATFORM  
PI71328 MFPDEV ADAPTER BUILD/DEPLOY ALL COMMANDS FAILS UNDER CERTAIN CONDITIONS  
PI69118 `NPM INSTALL` ON THE MFPDEV-CLI FAILS WITH THE LATEST NPM VERSION (3.10.7)  
PI66180 WHEN UPDATING THE MFPDEV-CLI, USER CONFIGURATION SETTINGS ARE NOT MIGRATED  
PI66177 WLAPPID IS NOT BEING SET IN MFPCLIENT.RESW FILES FOR WINDOWS PROJECTS  
PI64854 MFPDEV CLI CREATES ADAPTERS BY USING ARCHETYPE WITH VERSION 8.0.0  
PI64852 MFPDEV HELP HAS WRONG INFORMATION FOR APP PULL AND APP PUSH  

## Individual artifacts build numbers

server runtime 8.0.0.00-20161122-002317  
mfpdev-cli 8.0.0.0-IF8.0.20161107-13    
ibm-mfp-web-sdk for 8.0.0.0-IF8.0.20161121-09  
cordova-template-mfp 8.0.0.0-IF8.0.20161107-13  
cordova-plugin-mfp 8.0.0.0-IF8.0.20161107-13  
cordova-plugin-mfp-jsonstore 8.0.0.0-IF8.0.20161107-13  
cordova-plugin-mfp-fips 8.0.0.0-IF8.0.20161107-13  
cordova-plugin-mfp-push 8.0.0.0-IF8.0.20161103-05  




