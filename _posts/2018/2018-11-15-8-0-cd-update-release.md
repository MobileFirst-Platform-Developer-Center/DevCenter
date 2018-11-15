---
title: Mobile Foundation 8.0.0.0-MFPF-IF201811050432-CDUpdate-03 released
date: 2018-11-15
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
We are pleased to announce the continuous delivery (CD) update 2 for Mobile Foundation v8.0.

>To learn more about the continuous delivery support model, refer to the [Mobile Foundation v8.0 CD support announcement](https://www-01.ibm.com/common/ssi/ShowDoc.wss?docURL=/common/ssi/rep_ca/0/897/ENUS217-390/index.html&request_locale=en).


## What is included in this CD update
*This CD update is cumulative and includes fixes and features included in all previous CD Updates and iFixes released since the last CD update (8.0.0.0-MFPF-IF201807180449-CDUpdate-02). See the [list of iFixes](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).*

### Features included in this CD update
*Below is the list of major features included in this CD update.*

#### Features introduced with this CD update
>
##### <span style="color:NAVY">**Support for React Native development**</span>
>
Mobile Foundation introduces the refresh token feature on iOS starting with this CD Update. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).
>

#### Features included in this CD update (from previous iFixes)

##### <span style="color:NAVY">**Support for Cordova v8 and Cordova Android v7**</span>

Starting from this iFix (*8.0.0.0-MFPF-IF201810040631*), Mobile Foundation adds support for Node v8.x for the MobileFirst CLI.

##### <span style="color:NAVY">**Automated synchronization of JSONStore collections with CouchDB databases**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF201809041150*), a change to remove *libstdc++* as a dependency to Cordova projects is introduced. This is required for new apps running on iOS 12. For further details, such as a workaround, refer to [this blog post](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/).


### APAR Fixes in this CD update

>
**PH04756** IOS APPS BUILT WITH MFP SDK MAY CRASH INTERMITTENTLY WHEN INVOKING OBTAINACCESSToken API.<br/>
**PH04503** APP FALLS INTO INRECOVERABLE STATE AFTER DIRECT UPDATE FAILED.<br/>
**PH04229** FWLST0904E ERROR OCCURS INTERMITTENTLY ON JAVASCRIPT PROCEDURE CALLS.<br/>
**PH04117** MFP ADAPTER POTENTIAL SECURITY RISK WHEN CALLING NON-EXISTENCEADAPTER.<br/>
**PH04094** PUSH NOTIFICATIONS MAY BE LOST IN CORDOVA-BASED ANDROID APPS IF MULTIPLE NOTIFICATIONS ARE RECEIVED WHILE THE APP IS RUNNING.<br/>
**PH03280** VULNERABILITY IN ADVANCE ENCRYPTION STANDARD ALGORITHM.<br/>
**PH01886** INCOMPATIBILITY IN API SIGNATURES BETWEEN THE CORDOVA SDK AND WEB SDK.
>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / CD update package for on-prem production environment](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FOther%20software&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=All&platform=All&function=fixId&fixids=8.0.0.0-MFPF-IF201811050432-CDUpdate-03&includeRequisites=1&includeSupersedes=0&downloadMethod=http) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

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
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201811050432-CDUpdate-01.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201811050432-CDUpdate-01.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201811050432-CDUpdate-01.exe</b><br/>
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
                  <b>cordova-plugin-mfp              8.0.2018102517</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017090705<br/>
                  cordova-plugin-mfp-jsonstore       8.0.2018071703<br/>
                  <b>cordova-plugin-mfp-push             8.0.2018101607</b><br/>
                  cordova-template-mfp               8.0.2017060206<br/>
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
                  <b>mfpdev-cli 8.0.2018102606</b><br/>
                  mfpmigrate-cli 8.0.20171211072611<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-ios-sdk" aria-expanded="true" aria-controls="collapse-ios-sdk"><b>iOS SDK</b></a>
            </h4>
        </div>
        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                    <b>IBMMobileFirstPlatformFoundation             8.0.2018103116</b><br/>
                    <b>IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2018103116</b><br/>
                    IBMMobileFirstPlatformFoundationPush         8.0.2018022719<br/>
                    IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
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
                    <b>ibmmobilefirstplatformfoundation  8.0.2018102610</b><br/>
                    <b>ibmmobilefirstplatformfoundationpush            8.0.2018100111</b><br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2018062910<br/>
                    <b>adapter-maven-plugin              8.0.2018102301</b><br/>
                    <b>adapter-maven-archetype-sql       8.0.2018102301</b><br/>
                    <b>adapter-maven-archetype-java      8.0.2018102301</b><br/>
                    <b>adapter-maven-archetype-http      8.0.2018102301</b><br/>
                    <b>adapter-maven-api                 8.0.2018102301</b><br/>
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
                    IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                    IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
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
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-reactnative-sdk" aria-expanded="true" aria-controls="collapse-reactnative-sdk"><b>React Native SDK</b></a>
            </h4>
        </div>
        <div id="collapse-reactnative-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk">
            <div class="panel-body">
                    <b>react-native-ibm-mobilefirst 8.0.2018072413</b><br/>
            </div>
        </div>        
    </div>
  </div>        
