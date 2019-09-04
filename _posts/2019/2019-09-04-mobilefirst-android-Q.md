---
title: IBM Mobile Foundation and Android 10
date: 2019-09-04
tags:
- MobileFirst_Platform
- Mobile_Foundation
- Announcement
- Android_10
version:
- 8.0
- 7.1
author:
  name: Vidyasagar Gaikwad
---

Android 10 is [here](https://android-developers.googleblog.com/2019/09/welcoming-android-10.html) and IBM Mobile Foundation is ready for it. 

In our previous [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2019/05/15/mobilefirst-android-Q/), we mentioned about the various new changes seen in Android 10 and the compatibility of Mobile Foundation platform with it.

With the final release of Android 10, we have validated Mobile Foundation v8.0 and v7.1 and the following features work fine on Android 10 without any change required.

* Invoking backend procedures through adapters
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Oauth handshake with Mobile Foundation server 
* Push notifications

![Sample Images]({{site.baseurl}}/assets/blog/2019-09-04-mobilefirst-android-Q/sampleimages.png)


### Dark theme in Android 10
[Dark theme](https://developer.android.com/guide/topics/ui/look-and-feel/darktheme) is available in Android 10. As a developer, you'll have to adapt your app for the dark theme. Read [this](https://developer.android.com/guide/topics/ui/look-and-feel/darktheme#supporting_dark_theme_in_your_app) document to know what changes you will have to make.  

### Targeting your apps for Android 10
Mobile Foundation apps built on v7.1 and v8.0 have been validated with `targetSdkVersion` set to 29. Do note that if your application has minSdkVersion less than 23 then you would get a warning message saying that "This app was built for an older version of Android and may not work properly" as shown in the below image.

![Min SDK issue]({{site.baseurl}}/assets/blog/2019-09-04-mobilefirst-android-Q/minsdkissue.png)

### Known issues
On Mobile Foundation v7.1 application, if the application is in background and several push notifications are sent to the application, clicking the received push notifications from the notification panel would not show the first notification in the app view. Rest of the notifications would be seen in the app view normally.

