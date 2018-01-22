---
title: IBM Mobile Foundation Product Advisory - Possible impact on extended app authenticity due to Android changes
date: 2018-01-22
version:
- 7.1
- 7.0
tags:
- MobileFirst_Foundation
- Advisory
- App_Authenticity
author:
  name: Neeti Sukhtankar
---
In Dec 2017, Google announced that starting 2018 they will start adding a small amount of security metadata on top of each APK to verify that it was officially distributed by Google Play. This metadata is intended to provide a badge of authenticity for apps distributed via the Google Play Store. You can read more about the announcement in the Android Developers Blog [here](https://android-developers.googleblog.com/2017/12/improving-app-security-and-performance.html).

For apps running on IBM Mobile Foundation v7.1 or earlier, the addition of this metadata could alter the app binary, and possibly cause the extended app authenticity check to fail. This change is not likely to affect our basic app authenticity capability (available in Mobile Foundation v7.1 and earlier) or the static or dynamic app authenticity capability (available in Mobile Foundation v8.0). For more information about basic and extended app authenticity, see [here](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/admin/r_enabling_extended_authenticity_checking.html).

After Google releases this feature (no firm date yet), the Mobile Foundation team will test and assess the impact of this change on our extended app authenticity feature, and take the necessary remedial action, if any. We will keep you advised of any impact, and any actions that you might need to take. For now, this is an advisory notification and no action is needed from you.
