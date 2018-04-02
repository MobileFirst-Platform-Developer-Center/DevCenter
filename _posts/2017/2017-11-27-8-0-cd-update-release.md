---
title: Mobile Foundation 8.0.0.0-MFPF-IF201711230641-CDUpdate-01 released
date: 2017-11-27
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- CDUpdate_8.0
- CDUpdate
author:
  name: Neeti Sukhtankar
---
We are pleased to announce the continuous delivery (CD) update for Mobile Foundation v8.0.

>To learn more about the continuous delivery support model, refer to the [Mobile Foundation v8.0 CD support announcement](https://www-01.ibm.com/common/ssi/ShowDoc.wss?docURL=/common/ssi/rep_ca/0/897/ENUS217-390/index.html&request_locale=en).


## What is included in this CD update
*This CD update is cumulative of fixes and features included in all previous iFixes released since GA (i.e., from June 2016 to November 9th, 2017]. See the [list of iFixes](https://mobilefirstplatform.ibmcloud.com/blog/tag/iFix_8.0/).*

### Features included in this CD update
*Below is the list of major features included in this CD update.*

#### Features introduced with this CD update
>
##### <span style="color:NAVY">**Support for Eclipse UI editor**</span>
>
WYSIWYG editor is now provided in MobileFirst Studio’s Eclipse. Developers can design and implement UI for their Cordova applications using this UI editor. [Learn more](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).
>
##### <span style="color:NAVY">**New adapters for building cognitive apps**</span>
>
Mobile Foundation has introduced two new pre-built cognitive services adapters for the [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) and [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator) services. These adapters are available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.


#### Features included in this CD update (from previous iFixes)

##### <span style="color:NAVY">**Dynamic App Authenticity**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170220-1900*, A new implementation of *application authenticity* is provided. This implementation does not require the offline *mfp-app-authenticity* tool for generating the *.authenticity_data* file. Instead, you can enable or disable *application authenticity* from the MobileFirst console. For more information see [Configuring Application Authenticity](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity).

##### <span style="color:NAVY">**Appcenter (client & server) support for Windows 10**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170327-1055*, Windows 10 UWP apps are supported in IBM Application Center. The user can now upload Windows 10 UWP apps and install the same on their device. The Windows 10 UWP client project for installing the UWP app is now shipped with the Application Center. You can open the project in Visual Studio and create a binary (for example, *.appx*) for distribution. Application Center does not provide a predefined method of distributing the mobile client. For more information, see [Microsoft Windows 10 Universal (Native) IBM AppCenter client](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

##### <span style="color:NAVY">**MobileFirst Eclipse plugin support for Eclipse Neon**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170426-1210*, MobileFirst Eclipse plugin is updated to support Eclipse Neon.

##### <span style="color:NAVY">**Android SDK modified to use a newer version of OkHttp (version 3.4.1)**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170605-2216*, Android SDK has been modified to use a newer version of *OkHttp (version 3.4.1)* instead of the old version that was previously bundled with the MobileFirst SDK for Android. OkHttp is added as a dependency rather than being bundled with the SDK. This allows freedom of choice in using the OkHttp library for developers and also prevents conflicts with multiple versions of OkHttp.

##### <span style="color:NAVY">**Support for Cordova v7**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170608-0406*, Cordova v7 is supported. For details on supported versions of individual platforms, refer to [Adding the MobileFirst Foundation SDK to Cordova Applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

##### <span style="color:NAVY">**Multiple certificate pinning support**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170624-0159*), Mobile Foundation supports pinning of multiple certificates. Earlier to this iFix, Mobile Foundation supported pinning of a single certificate. Mobile Foundation introduced a new API, which allows connection to multiple hosts by allowing the user to pin public keys of multiple X509 certificates to the client application. This feature is supported only for native Android and iOS apps. Learn more about *Multiple certificate pinning support* from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs*.

##### <span style="color:NAVY">**Adapters for building a cognitive app**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation has introduced pre-built adapters for Watson cognitive services such as [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter), and [*WatsonNLU (Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter). These adapters are available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.

##### <span style="color:NAVY">**Cloud Functions adapter for building a serverless app**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation introduced a pre-built adapter called [*Cloud Functions adapter*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter) for the [Cloud Functions Platform](https://console.bluemix.net/openwhisk/). The adapter is available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.

##### <span style="color:NAVY">**Support for pinning multiple certificates in the Cordova SDK**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF20170803-1112*) pinning of multiple certificates is supported in the Cordova SDK. Read more on *Multiple certificate pinning support* from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs* .

##### <span style="color:NAVY">**Support for Cordova browser platform**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170823-1236*), {{ site.data.keys.product }} supports the Cordova browser platform along with the earlier supported platforms of Cordova Windows, Cordova Android, and Cordova iOS. [Learn more](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**Generate an adapter from its OpenAPI specification**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170901-1903*), {{ site.data.keys.product }} introduced the capability to auto-generate an adapter from its OpenAPI specification. {{ site.data.keys.product }} users can now focus on the application logic instead of creating the {{ site.data.keys.product }} adapter, which connects the application to the desired back-end service. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**Support for iOS 11 and iPhone X**</span>

Mobile Foundation announced the support for iOS 11 and iPhone X on Mobile Foundation v8.0. For further details, read the blog post [IBM MobileFirst Platform Foundation Support for iOS 11 and iPhone X](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/).

##### **<span style="color:NAVY">Support for Android Oreo</span>**

Mobile Foundation announced the support for Android Oreo with this [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/). Both native Android apps and hybrid/Cordova apps, built on older versions of Android, work as expected on Android Oreo when the device is upgraded through an OTA.

##### <span style="color:NAVY">**Mobile Foundation can now be deployed on Kubernetes clusters**</span>

Mobile Foundation user can now deploy Mobile Foundation, which includes the Mobile Foundation Server, Mobile Analytics Server, and the Application Center, on Kubernetes clusters. The deployment package has been updated to support Kubernetes deployment. Read the [announcement](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/).


### APAR Fixes in this CD update

>
**PI89436**   PUSH SDK DOES NOT PICK UP THE GATEWAY CONTEXT ROOT IN CLOUD ENVIRONMENT.<br/>
**PI89422**   UNEXPECTED ERROR "FWLSE0803E" KEEP SHOWING IN MPF SERVER LOG.<br/>
**PI89399**   CORDOVA APPLICATION THROWS UNCAUGHT EXCEPTION WHEN RUNNING ON WIN 10 PLATFORM.<br/>
**PI88626**   DEVICE ID CHANGES FOR CORDOVA APPLICATIONS STARTING FROM THE SAME DEVICE UPON UPGRADE.<br/>
**PI78066**   THE ONINITFRAMEWORKCOMPLETE() CALLBACK IS NOT CONSISTENTLY BEING CALLED.<br/>
**PI73963**   INVALID DOC FOR WL.CLIENT.INIT - INITOPTIONS OBJECT IN WEB ENV.<br/>
**PI86913**   IOS APP CRASHES WHEN ATTEMPTING TO ACCESS KEYCHAIN WHILE RUNNING IN BACKGROUND.
>

## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / CD update package for on-prem production environment](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FOther%20software&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=All&platform=All&function=fixId&fixids=8.0.0.0-MFPF-IF201711230641-CDUpdate-01&includeRequisites=1&includeSupersedes=0&downloadMethod=http) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

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
                  <b>8.0.0.0-MFPF-DevKit-Linux-IF201711230641-CDUpdate-01.bin</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201711230641-CDUpdate-01.zip</b><br/>
                  <b>8.0.0.0-MFPF-DevKit-Windows-IF201711230641-CDUpdate-01.exe</b><br/>
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
                  <b>cordova-plugin-mfp              8.0.2017112205</b><br/>
                  cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                  cordova-plugin-mfp-fips            8.0.2017090705<br/>
                  cordova-plugin-mfp-jsonstore       8.0.2017090705<br/>
                  <b>cordova-plugin-mfp-push             8.0.2017112208</b><br/>
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
                    <b>IBMMobileFirstPlatformFoundation             8.0.2017112205</b><br/>
                    <b>IBMMobileFirstPlatformFoundationOpenSSLUtils 8.0.2017112205</b><br/>
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
                    ibmmobilefirstplatformfoundation  8.0.2017101807<br/>
                    ibmmobilefirstplatformfoundationpush            8.0.2017011813<br/>
                    ibmmobilefirstplatformfoundationjsonstore       8.0.2017092509<br/>
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
                    IBMMobileFirstPlatform Foundation 8.0.2017092012<br/>
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
