---
title: Mobile Foundation 8.0.0.0-MFPF-IF201903190949-CDUpdate-05 released
date: 2019-03-22
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
We are pleased to announce the continuous delivery (CD) update 5 for Mobile Foundation v8.0.

>To learn more about the continuous delivery support model, refer to the [Mobile Foundation v8.0 CD support announcement](https://www-01.ibm.com/common/ssi/ShowDoc.wss?docURL=/common/ssi/rep_ca/0/897/ENUS217-390/index.html&request_locale=en).


## What is included in this CD update
*This CD update is cumulative and includes fixes and features included in all previous CD Updates and iFixes released since the last CD update (8.0.0.0-MFPF-IF201812191602-CDUpdate-04). See the [list of iFixes](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).*

### Features included in this CD update
*Below is the list of major features included in this CD update.*

#### Features introduced with this CD update
>
##### <span style="color:NAVY">**CoreML Update**</span>
>
Mobile Foundation applications can now embed ML models using Model Update feature, which can be updated “over-the-air” with newer versions. Enterprises can now  ensure that their app users always use updated AI models. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/model-update/).
>
##### <span style="color:NAVY">**App Authenticity for watchOS**</span>
>
WatchOS Application Authenticity feature protects applications against unlawful attempts to access MobileFirst Server by fake or tampered watchOS applications. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/watchos/).
>
##### <span style="color:NAVY">**Push Notifications - Additional message features and attributes for FCM**</span>
>
We have now added support for notification styles like Inbox notification, BigText notification, Picture notification, and lights.
>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / CD update package for on-prem production environment](http://www.ibm.com/support/fixcentral/quickorder?product=ibm%2FOther+software%2FIBM+MobileFirst+Platform+Foundation&fixids=8.0.0.0-MFPF-IF201812191602-CDUpdate-04&source=SAR) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers in this CD update

<div class="panel-group accordion" id="mfp-component-builds" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-devkit">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-mfp-devkit" aria-expanded="true" aria-controls="collapse-mfp-devkit"><b>MobileFirst DevKit</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-devkit" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit">
            <div class="panel-body">
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201903190949-CDUpdate-05.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201903190949-CDUpdate-05.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201903190949-CDUpdate-05.exe</b><br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="cordova-plugins">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-cordova-plugins" aria-expanded="true" aria-controls="collapse-cordova-plugins"><b>Cordova plugins</b></a>
            </h4>
        </div>
        <div id="collapse-cordova-plugins" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins">
            <div class="panel-body">
                  <b>cordova-plugin-mfp              8.0.2019030615</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017090705<br/>
                  cordova-plugin-mfp-jsonstore       8.0.2019012308<br/>
                  <b>cordova-plugin-mfp-push             8.0.2019031905</b><br/>
                  cordova-template-mfp               8.0.2017060206<br/>
                  cordova-plugin-mfp-analytics         8.0.2019021303<br/>
                  ibm-mfp-web-sdk                    8.0.2018071716<br/>
                  passport-mfp-token-validation      8.0.2017010917<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="tools">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-tools" aria-expanded="true" aria-controls="collapse-tools">Tools</a>
            </h4>
        </div>
        <div id="collapse-tools" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools">
            <div class="panel-body">
                  mfpdev-cli 8.0.2018121711<br/>
                  mfpmigrate-cli 8.0.20171211072611<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-ios-sdk" aria-expanded="true" aria-controls="collapse-ios-sdk">iOS SDK</a>
            </h4>
        </div>
        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                    IBMMobileFirstPlatformFoundation             8.0.2019030211<br/>
                    IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2019030211<br/>
                    IBMMobileFirstPlatformFoundationPush         8.0.2018121407<br/>
                    IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                    IBMMobileFirstPlatformFoundationAnalytics               8.0.2019012819<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-android-sdk" aria-expanded="true" aria-controls="collapse-android-sdk"><b>Android SDK</b></a>
            </h4>
        </div>
        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                    ibmmobilefirstplatformfoundation   8.0.2019021111<br/>
                    <b>ibmmobilefirstplatformfoundationpush            8.0.2019031206</b><br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110<br/>
                    IBMMobileFirstPlatformFoundationAnalytics   8.0.2019012910<br/>
                    <b>adapter-maven-plugin              8.0.2019022810</b><br/>
                    <b>adapter-maven-archetype-sql       8.0.2019022810</b><br/>
                    <b>adapter-maven-archetype-java      8.0.2019022810</b><br/>
                    <b>adapter-maven-archetype-http      8.0.2019022810</b><br/>
                    <b>adapter-maven-api                 8.0.2019022810</b><br/>
                    mfp-security-checks-base          8.0.2018030404<br/>
                    mfp-java-token-validator          8.0.2017020112<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-win-sdk" aria-expanded="true" aria-controls="collapse-win-sdk">Windows SDK</a>
            </h4>
        </div>
        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                    IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                    IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="xamarin-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-xamarin-sdk" aria-expanded="true" aria-controls="collapse-xamarin-sdk">Xamarin SDK</a>
            </h4>
        </div>
        <div id="collapse-xamarin-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk">
            <div class="panel-body">
                    IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="reactnative-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-reactnative-sdk" aria-expanded="true" aria-controls="collapse-reactnative-sdk">React Native SDK</a>
            </h4>
        </div>
        <div id="collapse-reactnative-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk">
            <div class="panel-body">
                    react-native-ibm-mobilefirst 8.0.2019030111<br/>
                    react-native-ibm-mobilefirst-jsonstore 8.0.2019030111<br/>
                    react-native-ibm-mobilefirst-push      8.0.2019030111<br/>
            </div>
        </div>        
    </div>
  </div>        
