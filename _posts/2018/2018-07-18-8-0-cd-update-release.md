---
title: Mobile Foundation 8.0.0.0-MFPF-IF201807180449-CDUpdate-02 released
date: 2018-07-24
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
*This CD update is cumulative (includes fixes and features from 8.0.0.0-MFPF-IF201711230641-CDUpdate-01) and includes fixes and features included in all previous iFixes released since the last CD update (8.0.0.0-MFPF-IF201711230641-CDUpdate-01). See the [list of iFixes](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).*

### Features included in this CD update
*Below is the list of major features included in this CD update.*

#### Features introduced with this CD update
>
##### <span style="color:NAVY">**Support for React Native development**</span>
>
Mobile Foundation [announces]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/) the support for React Native development with the availability of IBM Mobile Foundation SDK for React Native apps. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).
>
##### <span style="color:NAVY">**Automated synchronization of JSONStore collections with CouchDB databases for iOS and Cordova SDK**</span>
>
Starting with this CD Update, using MobileFirst iOS SDK and Cordova SDK, you can automate the synchronization of data between a JSONStore Collection on a device with any flavour of CouchDB database, including [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). For more information on this feature, read this [blog post]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/).
>
##### <span style="color:NAVY">**Introducing Refresh tokens**</span>
>
Mobile Foundation now introduces special kind of tokens called Refresh tokens that can be used to request a new access token.  [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).
>


#### Features included in this CD update (from previous iFixes)

##### <span style="color:NAVY">**Support for Cordova v8 and Cordova Android v7**</span>

Starting from this iFix (*8.0.0.0-MFPF-IF201804051553*), MobileFirst Cordova plugins for Cordova v8 and Cordova Android v7 is supported. To work with the mentioned version of Cordova, you need to get the latest MobileFirst plugins and upgrade to the latest CLI (mfpdev-cli) version. For details on supported versions for individual platforms, refer to  [Adding the MobileFirst Foundation SDK to Cordova Applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Automated synchronization of JSONStore collections with CouchDB databases**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF201802201451*), using MobileFirst Android SDK, you can automate the synchronization of data between a JSONStore Collection on a device with any flavour of CouchDB database, including [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). For more information on this feature, read this [blog post]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).



### APAR Fixes in this CD update

>
**PH00482** SUPPORT FOR REFRESH TOKEN<br/>
**PH00480** UPGRADING JAVA AND LIBERTY VERSIONS FOR BYOL/ICP PACKAGES<br/>
**PH00105** USE OF ANALYTICS WEB SDK MODIFIES THE NATIVE OBJECT XMLHTTPREQUEST.<br/>
**PH00066** DB2 Q-REPLICATION WITH MFP DB NOT WORKING IN MFP8<br/>
**PI99445** USE OF HARD-CODED PASSWORD IN JSONSTORE CODE<br/>
**PI99056** UNABLE TO REMOVE A COOKIE USING MOBILEFIRST V8 ANDROID SDK<br/>
**PI97512** HTTPS CONNECTION CREATES NEW SOCKET FOR ALL REQUESTS.
>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / CD update package for on-prem production environment](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FOther%20software&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=All&platform=All&function=fixId&fixids=8.0.0.0-MFPF-IF201807180449-CDUpdate-02&includeRequisites=1&includeSupersedes=0&downloadMethod=http) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

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
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201807180449-CDUpdate-01.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201807180449-CDUpdate-01.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201807180449-CDUpdate-01.exe</b><br/>
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
                  <b>cordova-plugin-mfp              8.0.2018071703</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017090705<br/>
                  <b>cordova-plugin-mfp-jsonstore       8.0.2018071703</b><br/>
                  <b>cordova-plugin-mfp-push             8.0.2018072407</b><br/>
                  cordova-template-mfp               8.0.2017060206<br/>
                  <b>ibm-mfp-web-sdk                    8.0.2018071716</b><br/>
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
                  mfpdev-cli 8.0.2018040312<br/>
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
                    <b>IBMMobileFirstPlatformFoundation             8.0.2018071512</b><br/>
                    <b>IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2018071512</b><br/>
                    IBMMobileFirstPlatformFoundationPush         8.0.2018022719<br/>
                    <b>IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512</b><br/>
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
                    <b>ibmmobilefirstplatformfoundation  8.0.2018071002</b><br/>
                    <b>ibmmobilefirstplatformfoundationpush            8.0.2018071309</b><br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2018062910<br/>
                    <b>adapter-maven-plugin              8.0.2018071312</b><br/>
                    <b>adapter-maven-archetype-sql       8.0.2018071312</b><br/>
                    <b>adapter-maven-archetype-java      8.0.2018071312</b><br/>
                    <b>adapter-maven-archetype-http      8.0.2018071312</b><br/>
                    <b>adapter-maven-api                 8.0.2018071312</b><br/>
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
