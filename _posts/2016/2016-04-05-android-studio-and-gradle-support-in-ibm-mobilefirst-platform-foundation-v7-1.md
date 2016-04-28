---
title: Android Studio and Gradle Support for IBM MobileFirst Platform Foundation v7.1
date: 2016-04-05
tags:
- MobileFirst_Platform
- Android_Studio
- Gradle
- Google_Play_Services
version:
- 7.1
author:
  name: Karen Tran
---
Starting with iFix build IF20160224-2343 and later builds, hybrid Android applications created with IBM MobileFirst Platform Foundation v7.1 of Studio, CLI, or Cordova can be converted to an Android Studio-based project and be built with Gradle. Using Android Studio with Gradle gives developers useful tools that are not available in Eclipse such as multidex support, automatic dependency management, and product flavors to switch between different versions of the same app like a demo version and a full version.

Instructions on how to convert a MobileFirst project built with MobileFirst v7.1 to an Android Studio project can be found here:

* [Studio and CLI](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_conf_mfp_proj_and_stdio.html?lang=en)
* [Cordova](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_conf_cord_proj_and_stdio.html?lang=en)

Note: If using push notifications for Android, it is recommended to convert to Android Studio. Adding Google Play Services causes a dex error in MobileFirst v7.1, which Gradle can resolve. Instructions on adding Google Play Services to a MobileFirst project that has been converted to an Android Studio project can be found here:

* [Google Play Services in Android Studio](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_add_ggleplay_and_hyb_app.html?lang=en)
