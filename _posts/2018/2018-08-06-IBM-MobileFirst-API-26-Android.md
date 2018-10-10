---
title: Update your MobileFirst Android apps to API Level 26 
date: 2018-09-13
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- API_26
version:
- 8.0
- 7.1
- 7.0
- 6.3
author:
  name: Srihari Kulkarni
---

If you have been following the mobile developers' chatter on the internet, you are probably already aware that new apps submitted to the [Google Play Store requires apps to target API level 26 (Android Oreo) or higher](https://developer.android.com/distribute/best-practices/develop/target-sdk), since August 1, 2018. Existing apps on the Play Store will have to target their apps to API 26 (Android Oreo) or higher before publishing any updates starting November 1, 2018. 

>**Important:** App updates that do not target API 26 or higher will be rejected from the Play Store starting November 1, 2018. 

To prevent your MobileFirst app updates from being blocked in Google Play Store and to be able to continue to publish updates to your app, change the `targerSdkVersion` to 26 or higher in your `build.gradle`.

In accordance with the [support plan for IBM MobileFirst](https://mobilefirstplatform.ibmcloud.com/blog/2017/01/11/support-plan-for-next-android-ios-mobile-os/), all existing apps built on MobileFirst v7.1 and v8.0 will be compliant with this new requirement. 

>**Update:** To keep your existing MobileFirst v7.1 apps compatible with API level 26, upgrade to the [*iFix 7.1.0.0-MFPF-IF201810081403*](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/7-1-master-ifix-release/). 
>
>No action is required for apps built on MobileFirst v8.0. 

**This support does not extend to MobileFirst v7.0 and earlier releases**. 

>**Mandatory:** If you are still publishing apps built on MobileFirst v7.0 or earlier, please upgrade your apps to MobileFirst 7.1 or 8.0 immediately. 

This restriction is only for apps that are distributed through the Google Play Store and is not applicable to apps distributed through App Center. 

Also, read our earlier posts on supporting [Android Oreo](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/) and [Android Pie](https://mobilefirstplatform.ibmcloud.com/blog/2018/08/06/IBM-MobileFirst-Android-Pie/).
