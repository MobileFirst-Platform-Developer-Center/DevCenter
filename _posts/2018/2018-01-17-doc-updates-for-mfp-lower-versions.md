---
title: MobileFirst Platform Foundation documentation updates for lower versions
date: 2018-01-17
version:
- 6.0.2
- 6.1.0
- 6.2.0
tags:
- MobileFirst_Foundation
- Documentation_Updates
- Lower_Versions
- Worklight
author:
  name: Sreelatha Sankaranarayanan
additional_authors :
  - Nagashree Bhat
  - Soumya Y Shanthimohan
---
Documentation updates for the lower versions of MobileFirst Platform Foundation are compiled in this post. The updates here augment and in some cases replace or correct the information for the respective version documentation in the knowledge center.

>**Note:** This post will continue to be updated in future with necessary documentation updates to the lower versions of MobileFirst Platform Foundation.

## MobileFirst Platform Foundation v6.0.2 documentation updates

### DOC APAR PI78664
>Also refer to the [knowledge center documentation](https://www.ibm.com/support/knowledgecenter/SSZH4A_6.0.0/wl_welcome.html) for this version.

By default the permissions like **GET_ACCOUNTS** are added into the *AndoridManifest.xml* file at the time of build.
This can be removed manually if the application does not require push notifications.

```
<uses-permission android:name="android.permission.GET_ACCOUNTS"/>
```

This **GET_ACCOUNTS** was added to support push notification service. To support older devices ( pre 4.0.4) this permission has to be maintained as this was required since the then Android versions and Push technology needed it. Since then there have been changes and this permission is not required in the latest versions of MobileFirst Platform Foundation and also in Android.
The **GET_ACCOUNTS** permission was added by the studio in v6.0.2 because Push capability was part of any hybrid application that was created. The libraries and SDK were also present. So, by just invoking the API the developer could get Push working, without having to make any other changes.

This can be removed if there is no push notification in the app.
The developer can remove the unnecessary permissions, before building or generating the apk. If customer uses Worklight studio to rebuild the Android environment, the *AndroidManifest.xml* will be regenerated and the permissions added back again.

The requirement to set the **GET_ACCOUNTS** permission is to be decided by the developer as this varies from one application project to another. If a project needs
to use Push, then it needs to have the necessary permissions.


## IBM Worklight Foundation v6.2.0 and v6.1.0 documentation updates

### DOC APAR PI63575
> Refer to the [knowledge center documentation](https://www.ibm.com/support/knowledgecenter/en/SSZH4A_6.2.0/com.ibm.worklight.deploy.doc/admin/r_push_notification_settings.html) for this version.

The push JNDI property **push.apns.connectionIdleTimeout** is available on IBM Worklight Foundation V6.2.0 and V6.1.0 too.

```
Property name: push.apns.connectionIdleTimeout , Property description: APNs Idle Connection Timeout. Default : 0
```

The **push.apns.connectionIdleTimeout**  is an optional JNDI property.
