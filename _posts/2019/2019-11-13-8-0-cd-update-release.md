---
title: Mobile Foundation 8.0.0.0-MFPF-IF201911050809-CDUpdate-06 released
date: 2019-11-13
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- CDUpdate_8.0
- CDUpdate
- iFix_8.0
author:
  name: Krishnakumar Balachandar
---
We are pleased to announce the continuous delivery (CD) update 6 for Mobile Foundation v8.0. This update includes the addition of several new features across various components of Mobile Foundation.

>To learn more about the continuous delivery support model, refer to the [Mobile Foundation v8.0 CD support announcement](https://www-01.ibm.com/common/ssi/ShowDoc.wss?docURL=/common/ssi/rep_ca/0/897/ENUS217-390/index.html&request_locale=en).


## What is included in this CD update
*This CD update is cumulative and includes fixes and features included in all previous CD Updates and iFixes released since the last CD update (8.0.0.0-MFPF-IF201903190949-CDUpdate-05). See the [list of iFixes]({{site.baseurl}}/blog/2018/05/18/8-0-master-ifix-release/).*

## Features included in this CD update
*Below is the list of major features included in this CD update.*

### Features introduced with this CD update
>
#### <span style="color:Black">Server</span>
##### <span style="color:NAVY">**Performance Improvements**</span>
>
Optimized Mobile Foundation database operations and introduced automated purging of records database.
>
##### <span style="color:NAVY">**Application Center now available inside DevKit**</span>
>
Application Center is now available as a package with [DevKit]({{site.baseurl}}/downloads/). This enables developers to build apps and publish them to the private store, which is now available as part of the DevKit.
>
##### <span style="color:NAVY">**Stack support for vendor software**</span>
>
Mobile Foundation now supports Windows 16 and Oracle 12c.
>
##### <span style="color:NAVY">**Support for application development frameworks**</span>
>
Mobile Foundation supports the latest frameworks released by Apple and Google with support for [iOS 13]({{site.baseurl}}/blog/2019/09/19/IBM-MobileFoundation-iOS13/), iPadOS and [Android 10]({{site.baseurl}}/blog/2019/09/04/mobilefirst-android-Q/). The platform also provides an SDK for Swift 5.
>
##### <span style="color:NAVY">**Connect securely to backend apps using an API Proxy**</span>
>
When connecting to the enterprise backend, it is possible to leverage the security and analytics of Mobile Foundation platform using the API Proxy. API Proxy proxies the requests to the actual backend. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/digital-app-builder/api-proxy/).
>

>
#### <span style="color:Black">Analytics</span>
##### <span style="color:NAVY">**In-App Feedback**</span>
>
The in-app feedback feature was earlier available in the Mobile Foundation service on IBM Cloud and has now been ported to the on-prem and container distribution of Mobile Foundation. Using this feature users can share feedback from the app in the form of screen shots, annotations and text. An administrator can login to the analytics console to view the feedback received and take necessary action.
>

>
#### <span style="color:Black">OpenShift package</span>
##### <span style="color:NAVY">**Mobile Foundation is part of IBM Cloud Pak for Applications v3**</span>
>
Mobile Foundation is now available as part of [IBM Cloud Pak for Apps]({{site.baseurl}}/blog/2019/09/13/announcing-support-for-mf-on-rhocp/) and supports RedHat Open Shift 3.11. The services currently available are mobile core, analytics, push notifications and app center. Using this capability developers can build cloud native applications using backend microservices and mobile services.
>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / CD update package for on-prem production environment](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=8.0.0.0-MFPF-IF201911050809-CDUpdate-06&source=SAR) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers in this CD update

<div class="panel-group accordion" id="mfp-component-builds-IF201911050809" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-devkit-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-mfp-devkit-IF201911050809" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201911050809"><b>MobileFirst DevKit</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-devkit-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201911050809">
            <div class="panel-body">
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201911050809-CDUpdate-06.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201911050809-CDUpdate-06.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201911050809-CDUpdate-06.exe</b><br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="cordova-plugins-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-cordova-plugins-IF201911050809" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201911050809"><b>Cordova plugins</b></a>
            </h4>
        </div>
        <div id="collapse-cordova-plugins-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201911050809">
            <div class="panel-body">
                  <b>cordova-plugin-mfp              8.0.2019110212</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                  cordova-plugin-mfp-fips            8.0.2019070909<br/>
                  <b>cordova-plugin-mfp-jsonstore      8.0.2019110212</b><br/>
                  cordova-plugin-mfp-push            8.0.2019090606<br/>
                  cordova-template-mfp               8.0.2017060206<br/>
                  cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                  ibm-mfp-web-sdk                     8.0.2019070909<br/>
                  passport-mfp-token-validation      8.0.2017010917<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="tools-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-tools-IF201911050809" aria-expanded="true" aria-controls="collapse-tools-IF201911050809">Tools</a>
            </h4>
        </div>
        <div id="collapse-tools-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201911050809">
            <div class="panel-body">
                  mfpdev-cli 8.0.2018121711<br/>
                  mfpmigrate-cli 8.0.20180813050750<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-ios-sdk-IF201911050809" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201911050809"><b>iOS SDK</b></a>
            </h4>
        </div>
        <div id="collapse-ios-sdk-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201911050809">
            <div class="panel-body">
                    <b>IBMMobileFirstPlatformFoundation              8.0.2019103114</b><br/>
                    <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019103114</b><br/>
                    IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                    IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                    IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-android-sdk-IF201911050809" aria-expanded="true" aria-controls="collapse-android-sdk-IF201911050809"><b>Android SDK</b></a>
            </h4>
        </div>
        <div id="collapse-android-sdk-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201911050809">
            <div class="panel-body">
                    <b>ibmmobilefirstplatformfoundation 8.0.2019100905</b><br/>
                    ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                    <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807</b><br/>
                    IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                    <b>adapter-maven-plugin               8.0.2019101201</b><br/>
                    <b>adapter-maven-archetype-sql       8.0.2019101201</b><br/>
                    <b>adapter-maven-archetype-java       8.0.2019101201</b><br/>
                    <b>adapter-maven-archetype-http       8.0.2019101201</b><br/>
                    <b>adapter-maven-api                  8.0.2019101201</b><br/>
                    mfp-security-checks-base          8.0.2018030404<br/>
                    mfp-java-token-validator          8.0.2017020112<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-win-sdk-IF201911050809" aria-expanded="true" aria-controls="collapse-win-sdk-IF201911050809">Windows SDK</a>
            </h4>
        </div>
        <div id="collapse-win-sdk-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201911050809">
            <div class="panel-body">
                    IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                    IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="xamarin-sdk-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-xamarin-sdk-IF201911050809" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201911050809">Xamarin SDK</a>
            </h4>
        </div>
        <div id="collapse-xamarin-sdk-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201911050809">
            <div class="panel-body">
                    IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="reactnative-sdk-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911050809" href="#collapse-reactnative-sdk-IF201911050809" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201911050809"><b>React Native SDK</b></a>
            </h4>
        </div>
        <div id="collapse-reactnative-sdk-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201911050809">
            <div class="panel-body">
                    <b>react-native-ibm-mobilefirst 8.0.2019102104</b><br/>
                    <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019102104</b><br/>
                    <b>react-native-ibm-mobilefirst-push 8.0.2019102104</b><br/>
            </div>
        </div>        
    </div>
</div>     
