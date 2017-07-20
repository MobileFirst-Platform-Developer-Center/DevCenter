---
title: MobileFirst Foundation iFix 8.0.0.0-MFPF-IF20170710-1834 released
date: 2017-07-11
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
A new iFix has been released for MobileFirst Foundation 8.0, dated **July 10th, 2017**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

### Adapters for building a cognitive app
With this iFix, Mobile Foundation has introduced pre-built adapters for Watson Cognitive Services such as [_**WatsonConversation**_](https://git.ng.bluemix.net/imfsdkt/console-tools-and-sdks/raw/master/WatsonConversation.adapter), [_**WatsonDiscovery**_](https://git.ng.bluemix.net/imfsdkt/console-tools-and-sdks/raw/master/WatsonDiscovery.adapter), and  [_**WatsonNLU (Natural Language Understanding)**_](https://git.ng.bluemix.net/imfsdkt/console-tools-and-sdks/raw/master/WatsonNLU.adapter). These adapters are available to be downloaded and deployed from the **Download Center** in the Mobile Foundation Console.

### OpenWhisk adapter for building a serverless app
With this iFix, Mobile Foundation has introduced a pre-built adapter called [_**OpenWhisk adapter**_]("https://git.ng.bluemix.net/imfsdkt/console-tools-and-sdks/raw/master/OpenWhisk.adapter) for the [OpenWhisk Platform](https://console.bluemix.net/openwhisk/). The adapter is available to be downloaded and deployed from the **Download Center** in the Mobile Foundation Console.

### APARs Fixed

**PI84204** SENSITIVE INFORMATION IN MFP CONSOLE VISIBLE TO ALL USERS OF THE CONSOLE <br>
**PI84213** SIGN_OUT MENU ITEM IS MISSING FROM THE MFP OPERATIONS CONSOLE INBYOL DEPLOYMENTS<br>
**PI84208** SUPPORT MOBILE FOUNDATION 8.0 DEPLOYMENT ON BLUEMIX KUBERNETES CLUSTER USING SCRIPTS<br>

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
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201707101834.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201707101834.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201707101834.exe</b><br/>
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
                  cordova-plugin-mfp              8.0.2017070506<br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017021815<br/>
                  <b>cordova-plugin-mfp-jsonstore       8.0.2017070506</b><br/>
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
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-tools" aria-expanded="true" aria-controls="collapse-tools">Tools</a>
            </h4>
        </div>
        <div id="collapse-tools" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools">
            <div class="panel-body">
                  mfpdev-cli 8.0.2017012016<br/>
                  mfpmigrate-cli 8.0.2017061505<br/>
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
                    IBMMobileFirstPlatformFoundation             8.0.2017062203<br/>
                    IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017053010<br/>
                    IBMMobileFirstPlatformFoundationPush         8.0.2017061612<br/>
                    IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds" href="#collapse-android-sdk" aria-expanded="true" aria-controls="collapse-android-sdk">Android SDK</a>
            </h4>
        </div>
        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                    ibmmobilefirstplatformfoundation 8.0.2017062005<br/>
                    ibmmobilefirstplatformfoundationpush            8.0.2017011813<br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2017011811<br/>
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
