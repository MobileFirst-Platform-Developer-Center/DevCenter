---
title: Should I use App Update or Direct Update? 
date: 2019-06-10
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- Direct Update
- App Update
version:
- 8.0
author:
  name: Srihari Kulkarni
---

Google I/O 2019 brought in a flurry of new feature announcements. One of the less publicised feature was that of [in-app updates for Android apps](https://developer.android.com/guide/app-bundle/in-app-updates). While the Google Play Store continues to be the channel for delivering app updates, in-app updates allow developers to prompt users to consume an app update from the Play Store without leaving their app. 

MobileFirst has had the ability to update app content from within the app for a long time now through [Direct Update](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/). 

So, 
* How is Android in-app udpate different from Direct Update?
* Is one better than the other? 
* Which is the best way to update my app? 

In this post, I'll attempt to answer these questions and more.

One of the first obvious difference you'd note is that the Android in-app update is delivered through the Play Store while MobileFirst Direct Update is delivered through the MobileFirst server or a [CDN](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/cdn-support/). This implies that your update still has to go through the Play Store review process and the associated delay. 

Another important difference is that Android app update is available to apps on, well, Android only. Direct update, on the other hand can be used on both Android and iOS platforms making it much more versatile. 

The limitation of Direct Update comes into play in the type of content it can update. Direct Update can only udpate web resources of Cordova-based apps, whereas the Android app update can update native content too and is perhaps suited to native apps. 

Apart from the major comparisons highlighted above, the following table gives you a more detailed comparison to help you judge better. 

|                                         | Mobile First Direct Update                                            | Android in-app update                                             |
|-----------------------------------------|----------------------------------------------------------------------|-------------------------------------------------------------------|
| Platform Support                        | <span style="color:green">**Android, iOS**</span>                                                         | Android only                                                      |
| Availability of update to users         | <span style="color:green">**Immediately after upload**</span>                                             | Subject to Play Store review timelines                            |
| Content that can be updated             | Web resources only (Cordova and Ionic apps)                                                  | <span style="color:green">**Native code (Native Android apps)**</span>                                                       |
| Cusomtizability                         | <span style="color:green">**Fully customizable by overriding the Direct Update Challenge handler**</span> | Partly customizable. Two modes available - flexible and immediate |
| Custom UX for downloading               | <span style="color:green">**Fully customizable**</span>                                                  | No customization - Play Store UI is shown to the user             |
| Additional coding required              | <span style="color:green">**None. Available out of the box**</span>                                       | App must be coded & prepared ahead of time                        |
| Resumable updates                       | <span style="color:green">**Yes**</span>                                                                  | No                                                                |
| Update download size                    | <span style="color:green">**Small. Only delta can be downloaded**</span>                                  | Full update is downloaded                                         |
| Option of rejecting an update for users | <span style="color:green">**Yes**</span>                                                                  | Yes - only in a flexible update                                   |
| Silent update                           | <span style="color:green">**Yes**</span>                                                                  | No                                                                |
| Other Limitations                       |Installed app and update must be from the same version                                            |<span style="color:green">**Update must be of a higher version than the installed version**</span>

### Conclusion

If you're a native Android app developer, the in-app udpate is a new capability that fills the gap of proving an update without the user having to launch the Play Store. Exploiting this requires some amount of forethought and code even before you deliver any updates. All this is still subject to the restrictions of the feature and Play Store

Direct Update, on the other hand is restricted to only Cordova and Ionic apps, but is far more versatile and powerful in creating a compelling user experience. 
