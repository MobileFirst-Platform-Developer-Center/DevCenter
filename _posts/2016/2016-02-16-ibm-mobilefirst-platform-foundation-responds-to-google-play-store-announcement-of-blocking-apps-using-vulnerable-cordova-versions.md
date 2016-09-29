---
title: IBM MobileFirst Platform Foundation Responds to Google Play Store Announcement of Blocking Apps Using Vulnerable Cordova Versions
date: 2016-02-16
tags:
- MobileFirst_Platform
- Cordova
- Google_Play_Store
author:
  name: Karen Tran
---
> [UPDATE Sept. 28, 2016] Update to a later iFix to avoid both OpenSSL and Cordova vulnerabilities

The Play Store started blocking Android applications that contain vulnerable versions of OpenSSL. MobileFirst Platform Foundation has updated their OpenSSL version to a compliant version back in May.

Refer to this blog post for more information on the OpenSSL vulnerability: [OpenSSL Vulnerability Blog](https://mobilefirstplatform.ibmcloud.com/blog/2016/04/27/ibm-mobilefirst-platform-foundation-responds-to-google-play-store-announcement-of-blocking-apps-using-vulnerable-openssl-versions/)

Install the following iFixes to avoid the OpenSSL blocking:

* 7.1.0 IF20160724-1420 and later builds
* 7.0.0 IF20160526-2153 and later builds
* 6.3.0 IF20160526-2153 and later builds
* 6.2.0 IF20160524-0631 and later builds
* 6.1.0 IF20160528-1310 and later builds

Installing this iFix ensures that you will not hit the Cordova or OpenSSL blocking.

When resubmitting your APK file to the Play Store, make sure that Google is scanning the correct APK with the correct version of your app. In several instances, users have reported that Google scanned an old APK instead of the new one. Contact Google Support to confirm.

<hr/>
> [UPDATE Apr. 21, 2016] Google confirms that it has deployed the MobileFirst Build ID solution to detect MobileFirst applications on the Play Store.

All MobileFirst applications **MUST** apply the iFixes listed in the Mar. 16, 2016 update below or later iFixes. Applications built with these iFixes applied will not get flagged.

<hr/>

> [UPDATE Apr. 1, 2016]
Google confirms that  has extended the target date for the Google Play Store blocking to July 11, 2016.

<hr/>

> **[UPDATE Mar. 16, 2016] Mandatory iFix**
For Google to identify patched applications built with IBM MobileFirst Platform Foundation on the Google Play Store, *customers must install the iFixes with the build dates as mentioned below, or iFixes with a later build date.* This is <strong>mandatory</strong> for all Android applications built with MobileFirst Platform Foundation that were submitted to the Google Play Store.

Related APAR: PI58161 ADD BUILD ID TO PROPERTIES FILE TO IDENTIFY MOBILEFIRST PLATFORM FOUNDATION APPLICATIONS

Hybrid applications that are built using MobileFirst Studio from the following iFixes, will have the build ID embedded in them. Google will use the Build ID to identify IBM MobileFirst apps. This in turn will ensure Google will not block the applications from the Google Play Store.

* 7.1.0 IF20160307-2032 and later builds
* 7.0.0 IF20160303-2248 and later builds
* 6.3.0 IF20160305-1806 and later builds
* 6.2.0 IF20160305-1300 and later builds
* 6.1.0 IF20160305-1310 and later builds

After installing the iFix, rebuild the application, create a new APK, and upload it to the Google Play Store.

<hr/>

> [UPDATE Feb. 17, 2016] IBM has assurance from Google that the Google Play Store will not block MobileFirst Platform Foundation apps that have the IBM patched distribution of Cordova for these CVEs. The blocking was scheduled to begin on May 9th. The warning emails will discontinue being sent within two to three weeks.

The Google Play Store is notifying app developers that "Beginning May 9, 2016, Google Play will block publishing of any new apps or updates that use pre-4.1.1 versions of Apache Cordova. " due to Apache Cordova pre-4.1.1 containing security vulnerabilities. Google is suggesting that customers should upgrade to Apache Cordova 4.1.1 or higher.  While it is correct that open source Apache Cordova prior to version 4.1.1 contains these vulnerabilities, **this is not the case for IBM MobileFirst Platform Foundation customers who have applied the IBM iFixes for the vulnerabilities**. The iFixes are available from Fix Central with any build dated July 7, 2015 or afterwards. That is, all builds dated on or after July 7, 2015 contain all of the CVE fixes.

It appears that the Google Play Store's blocking determination is based solely on the Cordova version used in the application, and therefore is not aware that Cordova has been patched when in MobileFirst Platform Foundation based apps.

The IBM distribution of Cordova is embedded in the MobileFirst Platform Foundation product, and the vulnerability fixes to Cordova are delivered as a MobileFirst Platform Foundation iFix. **For MobileFirst Platform Foundation customers, it is not necessary to upgrade to Cordova 4.1.1 to address these vulnerabilities, only to apply the above patches.**

IBM is engaged in discussion with the Google Play Store, as has been done in the past, to avoid flagging Apps built with IBM MobileFirst Platform Foundation that do not contain vulnerabilities.

This blog post will be updated once we have a resolution and Apps are no longer being flagged in the Play Store.
