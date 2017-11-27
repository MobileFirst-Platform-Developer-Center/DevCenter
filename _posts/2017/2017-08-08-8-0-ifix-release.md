---
title: MobileFirst Foundation iFix 8.0.0.0-MFPF-IF20170803-1112 released
date: 2017-08-08
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
<p><font color="red">Please <b>do not</b> download this iFix as there is a known issue with this iFix.</font></p>

A new iFix has been released for MobileFirst Foundation 8.0, dated **August 3rd, 2017**.

> **Important:** There is a known issue with this iFix causing the Mobile Foundation server to not start properly. This is fixed in [iFix 8.0.0.0-MFPF-IF20170901-1903](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/05/8-0-ifix-release/).

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

###  Generate an adapter from its OpenAPI specification
{{ site.data.keys.product }} introduces the capability to auto-generate an adapter from its OpenAPI specification. {{ site.data.keys.product }} users can now focus on the application logic instead of creating the {{ site.data.keys.product }} adapter, which connects the application to the desired back-end service. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

### Support for pinning multiple certificates in the Cordova SDK
Starting with the iFix **8.0.0.0-MFPF-IF20170624-0159**, Mobile Foundation had introduced the support for pinning of multiple certificates. This was supported only for native android and iOS apps. Now, starting with this iFix (**8.0.0.0-MFPF-IF20170803-1112**) pinning of multiple certificates is supported in the Cordova SDK. Read more on **Multiple certificate pinning support** from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs* .

### APARs Fixed

**PI84719** NEW JNDI PROPERTY TO CONTROL ANALYTIC EVENT QUEUE SIZE TO IMPROVE PERFORMANCE <br>
**PI84522** MobileFirst SDK cannot pin a certificate using the WL.Client.pinTrustedCertificatePublicKey API when Web ResourcesE<br>

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
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201708031112.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201708031112.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201708031112.exe</b><br/>
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
                  <b>cordova-plugin-mfp              8.0.2017072706</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017021815<br/>
                  cordova-plugin-mfp-jsonstore       8.0.2017070506<br/>
                  cordova-plugin-mfp-push            8.0.2017062111<br/>
                  cordova-template-mfp               8.0.2017060206<br/>
                  ibm-mfp-web-sdk                    8.0.2017021409<br/>
                  passport-mfp-token-validation      8.0.2017010917<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="tools">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-tools" aria-expanded="true" aria-controls="collapse-tools"><b>Tools</b></a>
            </h4>
        </div>
        <div id="collapse-tools" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools">
            <div class="panel-body">
                  <b>mfpdev-cli 8.0.2017080206</b><br/>
                  mfpmigrate-cli 8.0.2017061505<br/>
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
                    <b>IBMMobileFirstPlatformFoundation             8.0.2017072608</b><br/>
                    <b>IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017072608</b><br/>
                    IBMMobileFirstPlatformFoundationPush         8.0.2017061612<br/>
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
                    <b>ibmmobilefirstplatformfoundation 8.0.2017062702</b><br/>
                    ibmmobilefirstplatformfoundationpush            8.0.2017011813<br/>
                    <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2017052514</b><br/>
                    adapter-maven-plugin              8.0.2017021701<br/>
                    adapter-maven-archetype-sql       8.0.2017021701<br/>
                    adapter-maven-archetype-java      8.0.2017021701<br/>
                    adapter-maven-archetype-http      8.0.2017021701<br/>
                    adapter-maven-api                 8.0.2017021701<br/>
                    mfp-security-checks-base          8.0.2017020112<br/>
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
                    IBMMobileFirstPlatform Foundation 8.0.2017012419<br/>
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
