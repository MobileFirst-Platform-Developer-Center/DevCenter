---
title: MobileFirst Foundation iFix 8.0.0.0-MFPF-IF201803160641 released
date: 2018-03-22
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
- iFix
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **March 16th, 2018**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

### APARs Fixed

**PI95013** Push All does not increment all mediators in analytics console.<br/>
**PI94996** WLAUTHORIZATIONMANAGER API THROWS UNCLEAR ERROR WHEN THERE IS  NO INTERNET CONNECTION.<br/>
**PI94653** REMEMBER ME EXPIRATION VALUES OF GREATER THAN 2 WEEKS RESET TO DEFAULT OF 2 WEEKS.<br/>
**PI94587** ADDING THE ABILITY TO CONFIGURE THE TIMEOUT VALUE FOR WLAUTHORIZATIONMANAGER.LOGIN().<br/>
**PI94548** ANDROID RESPONSE HEADER CONTENT LOST.<br/>
**PI94184** APP RUNNING ON WINDOWS 10 CANNOT RECEIVE A GZIP COMPRESSED  TRANSFER VIA HTTP.<br/>
**PI93325** Fix for XSS vulnerability seen for non-existent adapter procedure.<br/>
**PI93148** APPLICATION CENTER DOES NOT PICK UP IOS NATIVE APP ICONS CORRECTLY.<br/>
**PI92835** DIRECT UPDATE DOES NOT WORK ON ANDROID 4.4 WITH TLS 1.1/12  PROTOCOL.<br/>
**PI91941** AFTER A BACKUP AND RESTORE VIA ICLOUD OR ITUNES ON IOS 11.X DEVICE, THE APP MIGHT BE CORRUPTED AND NEED TO BE REINSTALLED.<br/>
**PI91278** AFTER BACKUP THEN RESTORE THROUGH ICLOUD ON TO A DIFFERENTDEVICE, LOGIN FAILS.<br/>
**PI89436** PUSH SDK DOES NOT PICK UP THE GATEWAY CONTEXT ROOT IN CLOUD  ENVIRONMENT.<br/>
**PI70186** WINDOWS APPS CANNOT CONNECT TO MOBILEFIRST SERVER THROUGH DATAPOWER GATEWAY CHALLENGE HANDLER.<br/>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers in this iFix
*The artifacts updated in the iFix are emphasized.*

<div class="panel-group accordion" id="mfp-component-builds" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-devkit">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-mfp-devkit" aria-expanded="true" aria-controls="collapse-mfp-devkit"><b>MobileFirst DevKit</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-devkit" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit">
            <div class="panel-body">
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201803160641.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201803160641.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201803160641.exe</b><br/>
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
                  <b>cordova-plugin-mfp              8.0.2018031007</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017090705<br/>
                  cordova-plugin-mfp-jsonstore       8.0.2018021611<br/>
                  <b>cordova-plugin-mfp-push            8.0.2018030609</b><br/>
                  cordova-template-mfp               8.0.2017060206<br/>
                  ibm-mfp-web-sdk                    8.0.2017082310<br/>
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
                  mfpdev-cli 8.0.2017102406<br/>
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
                    <b>IBMMobileFirstPlatformFoundation              8.0.2018030804</b><br/>
                    IBMMobileFirstPlatformFoundationOpenSSLUtils  8.0.2017121910<br/>
                    <b>IBMMobileFirstPlatformFoundationPush          8.0.2018022719</b><br/>
                    IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
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
                    <b>ibmmobilefirstplatformfoundation 8.0.2018031510</b><br/>
                    <b>ibmmobilefirstplatformfoundationpush            8.0.2018022719</b><br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610<br/>
                    <b>adapter-maven-plugin              8.0.2018022601</b><br/>
                    <b>adapter-maven-archetype-sql       8.0.2018022601</b><br/>
                    <b>adapter-maven-archetype-java      8.0.2018022601</b><br/>
                    <b>adapter-maven-archetype-http      8.0.2018022601</b><br/>
                    <b>adapter-maven-api                 8.0.2018022601</b><br/>
                    <b>mfp-security-checks-base          8.0.2018030404</b><br/>
                    mfp-java-token-validator          8.0.2017020112<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-win-sdk" aria-expanded="true" aria-controls="collapse-win-sdk"><b>Windows SDK</b></a>
            </h4>
        </div>
        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                    <b>IBMMobileFirstPlatform Foundation 8.0.2018030908</b><br/>
                    IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
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
</div>        
