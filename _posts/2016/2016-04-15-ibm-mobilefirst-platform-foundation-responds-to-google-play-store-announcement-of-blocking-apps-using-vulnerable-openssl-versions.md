---
title: IBM MobileFirst Platform Foundation Responds to Google Play Store Announcement of Blocking Apps Using Vulnerable OpenSSL Version
date: 2016-04-27
tags:
- MobileFirst_Platform
- OpenSSL
- Google_Play_Store
author:
  name: Nana Amfo
---

Google has extended the target date for the Google Play Store blocking to July 11, 2016.

> **Mandatory iFix**
For Google to identify patched applications built with IBM MobileFirst Platform Foundation on the Google Play Store, *customers must install the iFixes with the build dates as mentioned below, or iFixes with a later build date.* This is <strong>mandatory</strong> for all Android applications built with MobileFirst Platform Foundation that were submitted to the Google Play Store.

Related APAR: PI60605 OPENSSL RECEIVED SECURITY UPDATES AND MUST BE UPGRADED TO 1.0.2F

Applications that are built using MobileFirst Studio from the following iFixes, will have the build ID embedded in them. Google will use the Build ID to identify IBM MobileFirst apps. This in turn will ensure Google will not block the applications from the Google Play Store.

* 7.1.0 IF20160421-0604 and later builds
* 7.0.0 IF20160423-2222 and later builds
* 6.3.0 IF20160427-1829 and later builds
* 6.2.0 IF20160423-1301 and later builds
* 6.1.0 IF20160423-1311 and later builds

After installing the iFix, rebuild the application, create a new APK, and upload it to the Google Play Store.

<hr/>


The Google Play Store is notifying app developers that . Beginning July 11, 2016, Google Play will block publishing of any new apps or updates that use older versions of OpenSSL. If you’re using a 3rd party library that bundles OpenSSL, you’ll need to upgrade it to a version that bundles OpenSSL 1.02f/1.01r or higher. 

The iFixes are available from Fix Central with any build dated April 27, 2016 or afterwards. That is, all builds dated on or after April 28, 2016 contain all of the CVE fixes.

The IBM distribution of OpenSSL is embedded in the MobileFirst Platform Foundation product, and the vulnerability fixes to OpenSSL are delivered as a MobileFirst Platform Foundation iFix. 
 