---
title: MobileFirst Foundation iFix 8.0.0.0-MFPF-IF20170605-2216 released
date: 2017-06-07
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **June 5th, 2017**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

Starting this version of the iFix, the Android SDK has been modified to use a newer version of **OkHttp (version 3.4.1)** instead of the old version that was previously bundled with the MobileFirst SDK for Android. This iFix also adds OkHttp as a dependency rather than being bundled with the SDK. This allows for freedom of choice of using the OkHttp library for developers and also prevents conflicts with multiple versions of OkHttp. In order to accommodate this change, existing Android projects must add the following dependencies to the build.gradle file of the app module.

```
dependencies {
    compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'
    compile 'com.squareup.okhttp3:okhttp:3.4.1'
}
```

### APARs Fixed
**PI81990** WHEN RUNNING MFP IN A RESTRICTED LAN NETWORK, THE CONSOLE APPLICATION DOES NOT LOAD IN THE BROWSER AND SHOW A BLANK PAGE.

**PI79411** XAMARIN SDK'S WORKLIGHTCLIENT.AUTHORIZATIONMANAGER.OBTAINACCESST OKEN("") DOES NOT HAVE AN OPTION TO DEFINE CALLBACK HANDLERS.

**PI74873** MEMORY LEAK MAY OCCUR WHEN USING WLRESOURCEREQUEST

**PI82126** ANDROID APPLICATION SOMETIME CRASHES WITH JAVA.IOEOFEXCEPTION

**PI82537** SCRIPTS (BYOL) FOR DEPLOYING APPCENTER ON BLUEMIX (CONTAINERSAND LBP)

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers included in this iFix

**iOS SDK**

IBMMobileFirstPlatformFoundation 8.0.2017051104

**Andriod SDK**

IBMMobileFirstPlatformFoundation 8.0.2017060616

**Xamarin SDK**

ibm-worklight-8.0.2017051208

**Cordova plug-ins**

cordova-plugin-mfp 8.0.2017060208

cordova-template-mfp 8.0.2017060206


##  Known Limitations

The Android SDK bundled with the MobileFirst Foundation DevKit has a known issue with certificate pinning. The SDK downloaded the version from [Maven Central](https://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation) does not have this issue. Download the latest version of the SDK from [Maven Central](https://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation).

Deploying Appcenter on Bluemix (PI82537) has a known limitation, the Application Center server will connect to the Application Center database (DashDB) via non SSL. This will be fixed in the next iFix.
