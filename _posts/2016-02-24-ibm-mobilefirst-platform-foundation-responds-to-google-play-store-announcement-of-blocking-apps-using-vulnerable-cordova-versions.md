---
title: IBM MobileFirst Platform Foundation Responds to Google Play Store Announcement of Blocking Apps Using Vulnerable Cordova Versions
date: 2016-02-24
tags:
- MobileFirst_Platform
- Cordova
- Google Play Store
author:
  name: Karen Tran
---
> [UPDATE Feb. 17, 2016] IBM has assurance from Google that the Google Play Store will not block MobileFirst Platform Foundation apps that have the IBM patched distribution of Cordova for these CVEs. The blocking was scheduled to begin on May 9th. The warning emails will discontinue being sent within two to three weeks.

The Google Play Store is notifying app developers that "Beginning May 9, 2016, Google Play will block publishing of any new apps or updates that use pre-4.1.1 versions of Apache Cordova. " due to Apache Cordova pre-4.1.1 containing security vulnerabilities. Google is suggesting that customers should upgrade to Apache Cordova 4.1.1 or higher.  While it is correct that open source Apache Cordova prior to version 4.1.1 contains these vulnerabilities, **this is not the case for IBM MobileFirst Platform Foundation customers who have applied the IBM iFixes for the vulnerabilities**. The iFixes are available from Fix Central with any build dated July 7, 2015 or afterwards. That is, all builds dated on or after July 7, 2015 contain all of the CVE fixes.

It appears that the Google Play Store's blocking determination is based solely on the Cordova version used in the application, and therefore is not aware that Cordova has been patched when in MobileFirst Platform Foundation based apps.

The IBM distribution of Cordova is embedded in the MobileFirst Platform Foundation product, and the vulnerability fixes to Cordova are delivered as a MobileFirst Platform Foundation iFix. **For MobileFirst Platform Foundation customers, it is not necessary to upgrade to Cordova 4.1.1 to address these vulnerabilities, only to apply the above patches.**

IBM is engaged in discussion with the Google Play Store, as has been done in the past, to avoid flagging Apps built with IBM MobileFirst Platform Foundation that do not contain vulnerabilities.

This blog post will be updated once we have a resolution and Apps are no longer being flagged in the Play Store.