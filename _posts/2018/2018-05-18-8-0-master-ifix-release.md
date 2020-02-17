---
title:  iFix and CD Update release information for Mobile Foundation v8.0
date: 2020-02-17
permalink: '/blog/2018/05/18/8-0-master-ifix-release/'
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
- iFix
- CDUpdate_iFix
pinned: true
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix *8.0.0.0-MFPF-IF202002111526*  is released for Mobile Foundation 8.0, dated **February 11th, 2020**.
<br/>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF202002111526" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF202002111526">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF202002111526" href="#collapse-mfp-ifix-IF202002111526" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF202002111526"><b>8.0.0.0-MFPF-IF202002111526</b></a>&nbsp;&nbsp;<span class="label label-primary">latest</span>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF202002111526">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>February 11th, 2020</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/>

            <h3>APARs</h3>
            <b>PH21853</b> MOBILE FOUNDATION SERVER PODS NOT MOVING READY STATE WHENCONFIGURED WITH ANALYTICS.<br/>
            <b>PH21852</b> CONTAINERCONFIG ERROR OCCURS DURING CREATION OF CR FOR MFPDEPLOYMENTS.<br/>
            <b>PH21438</b> FCM SUPPORT FOR PUSH NOTIFICATION IN XAMARIN SDK.<br/>
            <b>PH21435</b> ANALYTICS SEND METHOD FAILED TO RETURN FAILURE MESSAGE WHEN IT FAILS.<br/>
            <b>PH21347</b> IONIC 4 APPS BUILT WITH PRODUCTION CONFIGURATION FAIL DURING MFP INITIALIZATION.<br/>
            <b>PH21211</b> WLAUTHORIZATIONMANAGER.SETLOGINTIMEOUT() IS MISSING IN IONIC.<br/>
            <b>PH20958</b> UNABLE TO INSTALL APPLICATIONS USING APPLICATION CENTER CLIENT APP ON ANDROID 10.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF202002111526" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-mfp-devkit-IF202002111526" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF202002111526"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF202002111526">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF202002111526.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF202002111526.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF202002111526.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-cordova-plugins-IF202002111526" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF202002111526"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF202002111526">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2020020207</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2020012903</b><br/>
                              cordova-plugin-mfp-push            8.0.2019121811<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              <b>cordova-plugin-mfp-analytics      8.0.2020020207</b><br/>
                              ibm-mfp-web-sdk                     8.0.2019120211<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-tools-IF202002111526" aria-expanded="true" aria-controls="collapse-tools-IF202002111526">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF202002111526">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-ios-sdk-IF202002111526" aria-expanded="true" aria-controls="collapse-ios-sdk-IF202002111526"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF202002111526">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2020020508</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2020020508</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2019121007<br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics             8.0.2020020508</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-android-sdk-IF202002111526" aria-expanded="true" aria-controls="collapse-android-sdk-IF202002111526"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF202002111526">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2020011312</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807<br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics     8.0.2020011312</b><br/>
                                <b>adapter-maven-plugin                8.0.2020020501</b><br/>
                                <b>adapter-maven-archetype-sql        8.0.2020020501</b><br/>
                                <b>adapter-maven-archetype-java        8.0.2020020501</b><br/>
                                <b>adapter-maven-archetype-http        8.0.2020020501</b><br/>
                                <b>adapter-maven-api                   8.0.2020020501</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-win-sdk-IF202002111526" aria-expanded="true" aria-controls="collapse-win-sdk-IF202002111526">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF202002111526">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019120813<br/>
                                <b>IBM MobileFirstPlatform Push SDK  8.0.2020013116</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-xamarin-sdk-IF202002111526" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF202002111526">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF202002111526">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF202002111526">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202002111526" href="#collapse-reactnative-sdk-IF202002111526" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF202002111526">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF202002111526" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF202002111526">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019110405<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019102104<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

## Previous iFixes & CD Updates for MobileFirst Foundation 8.0

IFixes for MobileFirst Foundation 8.0 that was released earlier is listed here.<br/>
*List below includes iFixes and CD Updates released since 2018 only.*

<div class="panel-group accordion" id="mfp-8.0-ifix-IF202001211306" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF202001211306">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF202001211306" href="#collapse-mfp-ifix-IF202001211306" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF202001211306"><b>8.0.0.0-MFPF-IF202001211306</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF202001211306">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>January 21st, 2020</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/>

            <h3>Features</h3>
            <blockquote>
            <ul>
            <li><p>The <b>Custom Chart Filter</b> tab in Mobile Analytics console has now been enhanced to allow users to optionally search for custom property values instead of choosing from a drop-down list of values. This is particularly useful when there is a vast variety of property values to choose from for a given property.</p></li><br/>
            <li><p>Model Update and Direct Update has been updated to use WKWebView instead of the deprecated UIWebView.</p></li><br/>
            <li>Support for Web Push Notifications. <a href="{{ site.baseurl }}/tutorials/en/foundation/8.0/notifications/sending-web-push-notifications/" target="_blank">Learn more</a> about sending notifications to web platforms.</li></ul></blockquote>

            <h3>APARs</h3>
            <b>PH21078</b> Delta DU Updates should return 200 when complete delta being sent.<br/>
            <b>PH20906</b> ERROR 405: REQUEST METHOD PUT NOT SUPPORTED AFTER OS UPDATE WHEN APP DATA BACKED UP TO A CLOUD IN ANDROID NATIVE APPS.<br/>
            <b>PH20447</b> FAILURE TO BUILD ANDROID APPLICATION WITH MOBILEFIRST PUSH LIBRARIES ON ANDROID STUDIO.<br/>
            <b>PH20172</b> CANCEL SECURITY CHALLENGES IS MISSING IN THE REACT-NATIVE PLUGIN.<br/>
            <b>PH20153</b> REMOVE CODE REFERENCES TO MALLOC() IN NATIVE IOS SDK.<br/>
            <b>PH20121</b> ANDROID APP CAN CRASH WITH CONCURRENTMODIFICATIONEXCEPTION ERROR WHEN CALLS TO SERVER FAILS.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF202001211306" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-mfp-devkit-IF202001211306" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF202001211306"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF202001211306">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF202001211306.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF202001211306.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF202001211306.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-cordova-plugins-IF202001211306" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF202001211306"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF202001211306">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2020012010</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019121604<br/>
                              <b>cordova-plugin-mfp-push            8.0.2019121811</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019120211<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-tools-IF202001211306" aria-expanded="true" aria-controls="collapse-tools-IF202001211306">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF202001211306">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-ios-sdk-IF202001211306" aria-expanded="true" aria-controls="collapse-ios-sdk-IF202001211306"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF202001211306">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019121811</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2020011414</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2019121007<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-android-sdk-IF202001211306" aria-expanded="true" aria-controls="collapse-android-sdk-IF202001211306"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF202001211306">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019122413</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2020011707</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2020011707</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2020011707</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2020011707</b><br/>
                                <b>adapter-maven-api                  8.0.2020011707</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-win-sdk-IF202001211306" aria-expanded="true" aria-controls="collapse-win-sdk-IF202001211306">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF202001211306">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019120813<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-xamarin-sdk-IF202001211306" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF202001211306">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF202001211306">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF202001211306">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF202001211306" href="#collapse-reactnative-sdk-IF202001211306" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF202001211306"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF202001211306" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF202001211306">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019110405</b><br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019102104<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201912101319" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201912101319">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201912101319" href="#collapse-mfp-ifix-IF201912101319" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201912101319"><b>8.0.0.0-MFPF-IF201912101319</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201912101319">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>December 10th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/>

            <h3>Features</h3>
            <blockquote>
            <ul>
            <li><p>Mobile Foundation in Cloud Pak for Apps is now bundled with <b>Tekton pipelines for automating common DevOps tasks</b>. <a href="{{ site.baseurl }}/tutorials/en/foundation/8.0/ibmcloud/mobilefoundation-on-openshift/tekton-pipelines-mf/" target="_blank">Learn more.</a></p></li><br/>
            <li><p>Support for adapter grouping. <b>Adapter grouping</b> feature enables you to group resource adapters and run them on a set of Mobile Foundation nodes. The adapter group can be scaled by adding more nodes to the group, based on the adapter load. <a href="{{ site.baseurl }}/tutorials/en/foundation/8.0/adapters/adapter-grouping/" target="_blank">Learn more.</a></p></li></ul></blockquote>

            <h3>APARs</h3>
            <b>PH19999</b> CUSTOM PIE CHART SHOWS ONLY 10 RECORDS IN ANALYTICS CONSOLE.<br/>
            <b>PH19843</b> WEBENCRYPT MALFUNCTIONS ON WINDOWS MACHINES.<br/>
            <b>PH19641</b> WEB SDK KEYPAIR VALUES ARE STORED IN PLAIN TEXT IN THE INDEXEDDB OF THE BROWSER.<br/>
            <b>PH19494</b> ERROR WHILE ADDING AN APP LINK FROM GOOGLE PLAY STORE AND ITUNES.<br/>
            <b>PH19211</b> IBM APPLICATION CENTRE CLIENT - SSL ERROR WHILE RUNNING IN MDM MANAGED DEVICES.<br/>
            <b>PH17004</b> Remediate false positive reports regarding use of weak hash APIs: CC_SHA1_FINAL, CC_SHA1_INIT, AND CC_SHA1_UPDATE.<br/>
            <b>PH16321</b> ANDROID APP ICONS ARE NOT SHOWING CORRECTLY IN APPLICATION CENTER.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201912101319" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-mfp-devkit-IF201912101319" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201912101319"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201912101319">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201912101319.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201912101319.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201912101319.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-cordova-plugins-IF201912101319" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201912101319"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201912101319">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019120904</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019121604</b><br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              <b>ibm-mfp-web-sdk                     8.0.2019120211</b><br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-tools-IF201912101319" aria-expanded="true" aria-controls="collapse-tools-IF201912101319">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201912101319">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-ios-sdk-IF201912101319" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201912101319"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201912101319">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019120717</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019120717</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                <b>IBMMobileFirstPlatformFoundationJSONStore    8.0.2019121007</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-android-sdk-IF201912101319" aria-expanded="true" aria-controls="collapse-android-sdk-IF201912101319"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201912101319">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019100905<br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2019120501</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2019120501</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2019120501</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2019120501</b><br/>
                                <b>adapter-maven-api                  8.0.2019120501</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-win-sdk-IF201912101319" aria-expanded="true" aria-controls="collapse-win-sdk-IF201912101319"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201912101319">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2019120813</b><br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-xamarin-sdk-IF201912101319" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201912101319">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201912101319">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201912101319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201912101319" href="#collapse-reactnative-sdk-IF201912101319" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201912101319">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201912101319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201912101319">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019102104<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201911280551" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201911280551">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201911280551" href="#collapse-mfp-ifix-IF201911280551" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201911280551"><b>8.0.0.0-MFPF-IF201911280551</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201911280551">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>November 28th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs</h3>
            <b>PH19673</b> UNABLE TO SAVE PUSH CONFIGURATIONS ON ICP WHEN USED WITH ORACLEDB.<br/>
            <b>PH19129</b> THE SERVER RESPONSE LACKS SPECIFIC HTTP HEADERS : STRICT TRANSPORT TYPE, CONTENT-TYPE.<br/>
            <b>PH18037</b> ADDRESS THE SECURITY VULNERABILITIES FOUND IN 3rd PARTY LIBRARIES.<br/>
            <b>PH16176</b> XAMARIN-IOS PACKAGE VULNERABILITY.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201911280551" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-mfp-devkit-IF201911280551" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201911280551"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201911280551">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201911280551.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201911280551.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201911280551.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-cordova-plugins-IF201911280551" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201911280551">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201911280551">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019111409<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019111409<br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-tools-IF201911280551" aria-expanded="true" aria-controls="collapse-tools-IF201911280551">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201911280551">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-ios-sdk-IF201911280551" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201911280551"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201911280551">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019112609</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019112609</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                <b>IBMMobileFirstPlatformFoundationJSONStore    8.0.2019112710</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-android-sdk-IF201911280551" aria-expanded="true" aria-controls="collapse-android-sdk-IF201911280551"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201911280551">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019100905<br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2019111508</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2019111508</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2019111508</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2019111508</b><br/>
                                <b>adapter-maven-api                  8.0.2019111508</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-win-sdk-IF201911280551" aria-expanded="true" aria-controls="collapse-win-sdk-IF201911280551">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201911280551">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-xamarin-sdk-IF201911280551" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201911280551">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201911280551">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201911280551">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911280551" href="#collapse-reactnative-sdk-IF201911280551" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201911280551">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201911280551" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201911280551">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019102104<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>    
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201911181126" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201911181126">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201911181126" href="#collapse-mfp-ifix-IF201911181126" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201911181126"><b>8.0.0.0-MFPF-IF201911181126</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201911181126">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>November 18th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Currency support</h3>
            <blockquote><h4>DB2 11.1 software bundle update for Mobile Foundation V8.0</h4>
            <p>Mobile Foundation v8.0 currently provides DB2 10.5, which is going out of support on April 30th, 2020. To continue the support for DB2, we are updating the license to DB2 11.1, which is available as part of the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc" target="_blank">iFix IF201911181126</a>. Customers can log in to <a href="https://www.ibm.com/software/passportadvantage/pao_customer.html" target="_blank">Passport Advantage</a> using their IBM credentials and download the DB2 11.1 software bundle. Along with this update, we are also providing <a href="https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/c0058536.html" target="_blank">DB2 Advanced Workgroup Server Edition 11.1</a> for Z environment and <a href="https://www.ibm.com/support/pages/what-db2-oem-high-capacity-feature-option-license-db2hclic" target="_blank">DB2 OEM High Capacity Add on 11.1</a> for customers who want more hardware capacity to run their database workloads.
            You can read about the functionality of DB2 servers <a href="https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/r0053238.html" target="_blank">here</a> and follow the <a href="https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.qb.upgrade.doc/doc/c0023662.html" target="_blank">documentation</a> for upgrading to DB2 11.1.</p></blockquote>

            <h3>APARs</h3>
            <b>PH18886</b> RUNNING AN IONIC APPLICATION HANGS AT BLACK SCREEN IN CASE OF USING LIVE-RELOAD OPTION.<br/>
            <b>PH18624</b> CHANGEPASSOWORD ON MULTIPLE OPENED COLLECTION CAUSING APP TO THR OW EXCEPTION IN CORDOVA APP.<br/>
            <b>PH18466</b> NOT ALL ADAPTER API ENDPOINTS IN ANALYTICS DASHBOARD.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201911181126" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-mfp-devkit-IF201911181126" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201911181126"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201911181126">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201911181126.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201911181126.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201911181126.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-cordova-plugins-IF201911181126" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201911181126"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201911181126">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019111409</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019111409</b><br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-tools-IF201911181126" aria-expanded="true" aria-controls="collapse-tools-IF201911181126">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201911181126">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-ios-sdk-IF201911181126" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201911181126"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201911181126">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019103114<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019103114<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                <b>IBMMobileFirstPlatformFoundationJSONStore    8.0.2019103114</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-android-sdk-IF201911181126" aria-expanded="true" aria-controls="collapse-android-sdk-IF201911181126"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201911181126">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019100905<br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019082807<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2019102506</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2019102506</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2019102506</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2019102506</b><br/>
                                <b>adapter-maven-api                  8.0.2019102506</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-win-sdk-IF201911181126" aria-expanded="true" aria-controls="collapse-win-sdk-IF201911181126">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201911181126">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-xamarin-sdk-IF201911181126" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201911181126">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201911181126">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201911181126">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201911181126" href="#collapse-reactnative-sdk-IF201911181126" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201911181126">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201911181126" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201911181126">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019102104<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019102104<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201911050809" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201911050809">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201911050809" href="#collapse-mfp-ifix-IF201911050809" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201911050809"><b>8.0.0.0-MFPF-IF201911050809</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201911050809" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201911050809">
            <div class="panel-body">
            CD Update 6 for MobileFirst Foundation 8.0, dated <b>November 5th, 2019</b>.

            <h2>Changes in this CD Update</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h2>Features</h2>
            <blockquote>To view the details about the features included in this CD Update, see the <a href="{{site.baseurl}}/blog/2019/11/13/8-0-cd-update-release">announcement</a>.</blockquote>

            <h3>APARs</h3>
            <b>PH18477</b> IOS APPLICATIONS ARE NOT DISPLAYED IN THE APPLICATION CENTER INSTALLER PAGE.<br/>
            <b>PH17554</b> CALLS TO PROTECTED ADAPTER METHODS INTERMITTENTLY FAIL WITH HTTP 401 ON IOS.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.



        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201910101148" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201910101148">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201910101148" href="#collapse-mfp-ifix-IF201910101148" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201910101148"><b>8.0.0.0-MFPF-IF201910101148</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201910101148">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>October 10th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs</h3>
            <b>PH17865</b> SINCE IOS 13, A USER OF SAFARI ISN'T ABLE TO DOWNLOAD A NEW IPA VERSION OF AN APPLICATION FROM APPLICATION CENTER.<br/>
            <b>PH17860</b> BYOL PACKAGE USES OLD LIBRARIES OF MOBILE FOUNDATION ANALYTICS.<br/>
            <b>PH17732</b> REMOVE REDUNDANT FILES FROM NATIVE ANDROID CORE SDK TO REDUCE THE APK SIZE.<br/>
            <b>PH16757</b> 404 ERROR PAGE SHOWING APPLICATION SERVER HTTP RESPONSE.<br/>
            <b>PH17113</b> HELM CHART INSTALLATION THROWS PARSING ERROR WHEN DB DRIVER PVC IS PROVIDED.<br/>
            <b>PH17114</b> POD CRASHES WHEN CUSTOM KEYSTORESECRET IS PROVIDED.<br/>
            <b>PH17115</b> CONNECTION FAILURES ARE SEEN WHEN MOBILE FOUNDATION IS DEPLOYED WITH ORACLE DATABASE.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201910101148" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-mfp-devkit-IF201910101148" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201910101148"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201910101148">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201910101148.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201910101148.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201910101148.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-cordova-plugins-IF201910101148" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201910101148">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201910101148">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019091217<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019072908<br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-tools-IF201910101148" aria-expanded="true" aria-controls="collapse-tools-IF201910101148">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201910101148">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-ios-sdk-IF201910101148" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201910101148">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201910101148">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-android-sdk-IF201910101148" aria-expanded="true" aria-controls="collapse-android-sdk-IF201910101148"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201910101148">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019082915</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019072605<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2019092701</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2019092701</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2019092701</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2019092701</b><br/>
                                <b>adapter-maven-api                  8.0.2019092701</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-win-sdk-IF201910101148" aria-expanded="true" aria-controls="collapse-win-sdk-IF201910101148">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201910101148">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-xamarin-sdk-IF201910101148" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201910101148">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201910101148">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201910101148">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201910101148" href="#collapse-reactnative-sdk-IF201910101148" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201910101148">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201910101148" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201910101148">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019071506<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201909261537" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201909261537">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201909261537" href="#collapse-mfp-ifix-IF201909261537" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201909261537"><b>8.0.0.0-MFPF-IF201909261537</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201909261537">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>September 26th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs</h3>
            <b>PH16755</b> NETWORK AND ADAPTER TABLES IN ANALYTICS CONSOLE SHOWS ONLY 10  ENTRIES.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201909261537" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-mfp-devkit-IF201909261537" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201909261537"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201909261537">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201909261537.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201909261537.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201909261537.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-cordova-plugins-IF201909261537" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201909261537">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201909261537">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019091217<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019072908<br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-tools-IF201909261537" aria-expanded="true" aria-controls="collapse-tools-IF201909261537">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201909261537">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-ios-sdk-IF201909261537" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201909261537">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201909261537">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-android-sdk-IF201909261537" aria-expanded="true" aria-controls="collapse-android-sdk-IF201909261537"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201909261537">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019072508<br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019072605<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin               8.0.2019091817</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2019091817</b><br/>
                                <b>adapter-maven-archetype-java       8.0.2019091817</b><br/>
                                <b>adapter-maven-archetype-http       8.0.2019091817</b><br/>
                                <b>adapter-maven-api                  8.0.2019091817</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-win-sdk-IF201909261537" aria-expanded="true" aria-controls="collapse-win-sdk-IF201909261537">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201909261537">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-xamarin-sdk-IF201909261537" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201909261537">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201909261537">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201909261537">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909261537" href="#collapse-reactnative-sdk-IF201909261537" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201909261537">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201909261537" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201909261537">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019071506<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201909190904" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201909190904">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201909190904" href="#collapse-mfp-ifix-IF201909190904" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201909190904"><b>8.0.0.0-MFPF-IF201909190904</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201909190904">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>September 19th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <p>Support for React Native 0.60 has been added to MobileFirst react native plugins.</p>

            <h3>APARs</h3>
            <b>PH16769</b> QUARTZ JAR IN MFP RUNTIME WAR LOOKS FOR TERRACOTA WEBSITE FOR QUARTZ UPDATE.<br/>
            <b>PH16456</b> ADDING CORDOVA-PLUGIN-MFP 8.0.2019072911 ON FRESHLY MIGRATED IONIC4 PROJECT LET A BLANK PAGE ON IOS DEVICE.<br/>
            <b>PH16425</b> ON CANCELING THE CHALLENGE HANDLER, THE POP UP DOES NOT DISAPPEAR.<br/>
            <b>PH16206</b> DEVICE_ARCHIVE DIR DOES NOT GET CREATED AND DOESNT ARCHIVE DATA WHEN LICENSE TRACKING IS ON.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201909190904" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-mfp-devkit-IF201909190904" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201909190904"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201909190904">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201909190904.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201909190904.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201909190904.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-cordova-plugins-IF201909190904" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201909190904"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201909190904">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019091217</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019072908<br/>
                              cordova-plugin-mfp-push            8.0.2019090606<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019090714<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-tools-IF201909190904" aria-expanded="true" aria-controls="collapse-tools-IF201909190904">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201909190904">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-ios-sdk-IF201909190904" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201909190904">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201909190904">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019070714<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2019082914<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-android-sdk-IF201909190904" aria-expanded="true" aria-controls="collapse-android-sdk-IF201909190904"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201909190904">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019072508</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019072605<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                <b>adapter-maven-plugin              8.0.2019070812</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019070812</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019070812</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019070812</b><br/>
                                <b>adapter-maven-api                 8.0.2019070812</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-win-sdk-IF201909190904" aria-expanded="true" aria-controls="collapse-win-sdk-IF201909190904">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201909190904">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-xamarin-sdk-IF201909190904" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201909190904">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201909190904">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201909190904">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909190904" href="#collapse-reactnative-sdk-IF201909190904" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201909190904">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201909190904" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201909190904">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019071506<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019071506<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>  

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201909091050" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201909091050">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201909091050" href="#collapse-mfp-ifix-IF201909091050" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201909091050"><b>8.0.0.0-MFPF-IF201909091050</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201909091050">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>September 9th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <p>Support for React Native 0.60 has been added to MobileFirst react native plugins.</p>

            <h3>APARs</h3>
            <b>PH16468</b> IN IOS 13 DEVICES PUSH REGISTRATION FAILS.<br/>
            <b>PH16463</b> DIRECT UPDATE IS FAILING ON SLOW NETWORK ON IOS.<br/>
            <b>PH16097</b> CANNOT BUILD ANDROID APP WITH PUSH PLUGIN ADDED.<br/>
            <b>PH16048</b> MFP v8 Support on Oracle 18c.<br/>
            <b>PH15828</b> IOS APPLICATION CRASHES AFTER UPGRADING TO CORDOVA PLUGINVERSION 8.0.2019050614.<br/>
            <b>PH15627</b> ELF BUILT WITHOUT POSITION INDEPENDENT EXECUTABLE (PIE) AND STACK PROTECTION FLAGS.<br/>
            <b>PH15561</b> JSONSTORE INITIALIZATION FAILS ON ANDROID 5.X 64-BIT DEVICES.<br/>
            <b>PH15361</b> CALLING PROTECTED RESOURCES WHILE A LOGOUT IS IN PROGRESS RETURNS INVALID CLIENT ERROR.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201909091050" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-mfp-devkit-IF201909091050" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201909091050"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201909091050">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201909091050.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201909091050.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201909091050.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-cordova-plugins-IF201909091050" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201909091050"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201909091050">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019090714</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019072908</b><br/>
                              <b>cordova-plugin-mfp-push            8.0.2019090606</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              <b>cordova-plugin-mfp-analytics      8.0.2019090714</b><br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-tools-IF201909091050" aria-expanded="true" aria-controls="collapse-tools-IF201909091050">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201909091050">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-ios-sdk-IF201909091050" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201909091050"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201909091050">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019070714</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019070714</b><br/>
                                <b>IBMMobileFirstPlatformFoundationPush          8.0.2019082914</b><br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-android-sdk-IF201909091050" aria-expanded="true" aria-controls="collapse-android-sdk-IF201909091050"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201909091050">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019072508</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019072605</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                adapter-maven-plugin              8.0.2019070809<br/>
                                adapter-maven-archetype-sql      8.0.2019070809<br/>
                                adapter-maven-archetype-java      8.0.2019070809<br/>
                                adapter-maven-archetype-http      8.0.2019070809<br/>
                                adapter-maven-api                 8.0.2019070809<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-win-sdk-IF201909091050" aria-expanded="true" aria-controls="collapse-win-sdk-IF201909091050">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201909091050">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-xamarin-sdk-IF201909091050" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201909091050">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201909091050">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201909091050">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201909091050" href="#collapse-reactnative-sdk-IF201909091050" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201909091050"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201909091050" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201909091050">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019071506</b><br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019071506</b><br/>
                                <b>react-native-ibm-mobilefirst-push 8.0.2019071506</b><br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201908051227" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201908051227">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201908051227" href="#collapse-mfp-ifix-IF201908051227" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201908051227"><b>8.0.0.0-MFPF-IF201908051227</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201908051227">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>August 5th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <p>Support for React Native 0.60 has been added to MobileFirst react native plugins.</p>

            <h3>APARs</h3>
            <b>PH14751</b> JSONSTORE SUPPORT FOR 64-BIT ARCHITECTURE USING OPENSSL-FIPS LIBRARY.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201908051227" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-mfp-devkit-IF201908051227" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201908051227"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201908051227">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201908051227.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201908051227.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201908051227.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-cordova-plugins-IF201908051227" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201908051227"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201908051227">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019070909<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2019070909<br/>
                              cordova-plugin-mfp-fips            8.0.2019070909<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019072908</b><br/>
                              cordova-plugin-mfp-push            8.0.2019070108<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019070908<br/>
                              ibm-mfp-web-sdk                     8.0.2019070909<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-tools-IF201908051227" aria-expanded="true" aria-controls="collapse-tools-IF201908051227">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201908051227">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-ios-sdk-IF201908051227" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201908051227">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201908051227">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019060711<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019060711<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-android-sdk-IF201908051227" aria-expanded="true" aria-controls="collapse-android-sdk-IF201908051227"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201908051227">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019061806</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019072505</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                adapter-maven-plugin              8.0.2019070809<br/>
                                adapter-maven-archetype-sql      8.0.2019070809<br/>
                                adapter-maven-archetype-java      8.0.2019070809<br/>
                                adapter-maven-archetype-http      8.0.2019070809<br/>
                                adapter-maven-api                 8.0.2019070809<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-win-sdk-IF201908051227" aria-expanded="true" aria-controls="collapse-win-sdk-IF201908051227">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201908051227">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-xamarin-sdk-IF201908051227" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201908051227">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201908051227">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201908051227">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201908051227" href="#collapse-reactnative-sdk-IF201908051227" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201908051227"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201908051227" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201908051227">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019071506</b><br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019071506</b><br/>
                                <b>react-native-ibm-mobilefirst-push 8.0.2019071506</b><br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201907171034" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201907171034">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201907171034" href="#collapse-mfp-ifix-IF201907171034" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201907171034"><b>8.0.0.0-MFPF-IF201907171034</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201907171034">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>July 17th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs</h3>
            <b>PH14615</b> ANALYTICS SERVER FAILED TO PARSE LOGS WHICH CONTAINS "\0"CHARACTER.<br/>
            <b>PH14522</b> ANALYTICS SERVER NEED TO HANDLE NPE THROWN DUE TO EMPTY CLIENT LOG.<br/>
            <b>PH14521</b> RESTRICT SHOWING MFP LOGIN SPECIFIC API CALLS FROM NETWORKSUMMARY TABLE.<br/>
            <b>PH14091</b> MFP CORDOVA IOS APPLICATION DOES NOT WORK WITH CORDOVA-PLUGIN-WKWEBVIEW-ENGINE PLUGIN.<br/>
            <b>PH14028</b> FORMATTING ISSUE WITH CSV FILE EXPORTED VIA ANALYTICS CONSOLE.<br/>


            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201907171034" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-mfp-devkit-IF201907171034" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201907171034"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201907171034">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201907171034.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201907171034.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201907171034.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-cordova-plugins-IF201907171034" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201907171034"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201907171034">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019070909</b><br/>
                              <b>cordova-plugin-mfp-encrypt-utils   8.0.2019070909</b><br/>
                              <b>cordova-plugin-mfp-fips            8.0.2019070909</b><br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019070908<br/>
                              cordova-plugin-mfp-push            8.0.2019070108<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019070908<br/>
                              <b>ibm-mfp-web-sdk                     8.0.2019070909</b><br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-tools-IF201907171034" aria-expanded="true" aria-controls="collapse-tools-IF201907171034">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201907171034">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-ios-sdk-IF201907171034" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201907171034">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201907171034">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019060711<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019060711<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-android-sdk-IF201907171034" aria-expanded="true" aria-controls="collapse-android-sdk-IF201907171034">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201907171034">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019061806</b><br/>
                                ibmmobilefirstplatformfoundationpush             8.0.2019031906<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019063013<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806<br/>
                                adapter-maven-plugin              8.0.2019070809<br/>
                                adapter-maven-archetype-sql      8.0.2019070809<br/>
                                adapter-maven-archetype-java      8.0.2019070809<br/>
                                adapter-maven-archetype-http      8.0.2019070809<br/>
                                adapter-maven-api                 8.0.2019070809<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-win-sdk-IF201907171034" aria-expanded="true" aria-controls="collapse-win-sdk-IF201907171034">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201907171034">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-xamarin-sdk-IF201907171034" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201907171034">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201907171034">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201907171034">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907171034" href="#collapse-reactnative-sdk-IF201907171034" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201907171034">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201907171034" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201907171034">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019051709<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>  

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201907091643" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201907091643">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201907091643" href="#collapse-mfp-ifix-IF201907091643" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201907091643"><b>8.0.0.0-MFPF-IF201907091643</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201907091643">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>July 9th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <blockquote><b>Additional message features and attributes for FCM</b><br/>

            Push Notifications now supports the following additional message attributes.<br/>

            <ul><li>Silent type notification</li>
            <li>Interactive category notification</li>
            <li>Priority property</li></ul> </blockquote>

            <h3>APARs</h3>
            <b>PH14216</b> ADD NEW JNDI PROPERTY MFP.SCHEDULER.STARTHOUR TO MAKE SCHEDULER START TIME CONFIGURABLE.<br/>
            <b>PH14098</b> IMPLEMENT INAPP FEEDBACK FEATURE FOR ONPREM ANALYTICS.<br/>
            <b>PH13997</b> NONEXISTENT RESOURCE URL RETURNS HTTP 200. SHOULD RETURN HTTP404.<br/>
            <b>PH13824</b> MFP ANALYTICS EXPORT DATA DOESN'T WORK ON CHROME AND FIREFOXBROWSERS.<br/>
            <b>PH13587</b> FAILED TO RE-INITIALISE JSONSTORE AFTER DESTROYED WHEN AN APP RELEASED IN 64 BIT MODE ON AN EXISTING 32-BIT MODE JSONSTORE APP.<br/>


            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201907091643" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-mfp-devkit-IF201907091643" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201907091643"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201907091643">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201907091643.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201907091643.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201907091643.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-cordova-plugins-IF201907091643" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201907091643"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201907091643">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019070908</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019070908</b><br/>
                              <b>cordova-plugin-mfp-push            8.0.2019070108</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              <b>cordova-plugin-mfp-analytics      8.0.2019070908</b><br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-tools-IF201907091643" aria-expanded="true" aria-controls="collapse-tools-IF201907091643">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201907091643">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-ios-sdk-IF201907091643" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201907091643"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201907091643">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019060711</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019060711</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics             8.0.2019060711</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-android-sdk-IF201907091643" aria-expanded="true" aria-controls="collapse-android-sdk-IF201907091643"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201907091643">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019061806</b><br/>
                                <b>ibmmobilefirstplatformfoundationpush             8.0.2019031906</b><br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019063013</b><br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics     8.0.2019061806</b><br/>
                                <b>adapter-maven-plugin              8.0.2019070809</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019070809</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019070809</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019070809</b><br/>
                                <b>adapter-maven-api                 8.0.2019070809</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-win-sdk-IF201907091643" aria-expanded="true" aria-controls="collapse-win-sdk-IF201907091643">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201907091643">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-xamarin-sdk-IF201907091643" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201907091643">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201907091643">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201907091643">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201907091643" href="#collapse-reactnative-sdk-IF201907091643" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201907091643">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201907091643" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201907091643">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019051709<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201906211318" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201906211318">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201906211318" href="#collapse-mfp-ifix-IF201906211318" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201906211318"><b>8.0.0.0-MFPF-IF201906211318</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201906211318">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>June 21st, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <blockquote>Mobile Foundation v8.0 is now available as a certified Cloud Pak, see the <a href="{{site.baseurl}}/blog/2019/06/28/announce-mf-cloud-pak-availability/">announcement</a>.</blockquote>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201906211318" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-mfp-devkit-IF201906211318" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201906211318"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201906211318">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201906211318.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201906211318.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201906211318.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-cordova-plugins-IF201906211318" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201906211318">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201906211318">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019061808<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019061808<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019050614<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-tools-IF201906211318" aria-expanded="true" aria-controls="collapse-tools-IF201906211318">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201906191215">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-ios-sdk-IF201906211318" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201906211318">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201906211318">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-android-sdk-IF201906211318" aria-expanded="true" aria-controls="collapse-android-sdk-IF201906211318">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201906211318">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019052014<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                adapter-maven-plugin              8.0.2019051307<br/>
                                adapter-maven-archetype-sql      8.0.2019051307<br/>
                                adapter-maven-archetype-java      8.0.2019051307<br/>
                                adapter-maven-archetype-http      8.0.2019051307<br/>
                                adapter-maven-api                 8.0.2019051307<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-win-sdk-IF201906211318" aria-expanded="true" aria-controls="collapse-win-sdk-IF201906211318">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201906211318">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-xamarin-sdk-IF201906211318" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201906211318">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201906211318">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201906211318">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906211318" href="#collapse-reactnative-sdk-IF201906211318" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201906211318">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201906211318" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201906211318">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019061404<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019051709<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201906191215" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201906191215">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201906191215" href="#collapse-mfp-ifix-IF201906191215" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201906191215"><b>8.0.0.0-MFPF-IF201906191215</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201906191215">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>June 19th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH13461</b>  CURRENCY UPGRADE THE WEBSPHERE LIBERTY VERSION TO 19.0.0.5 IN ICP & BYOL INSTALLABLES.<br/>
            <b>PH13304</b>  CHANGE THE DEPENDENCY DECLARATION STATEMENT 'COMPILE' TO 'IMPLEMENTATION' IN BUILD.GRADLE FILE.<br/>
            <b>PH13123</b>  RESPONSE JSON AND RESPONSE HEADER FIELDS NOT SET IN FAILURE RESPONSE IN CORDOVA ANDROID.<br/>
            <b>PH13188</b>  PUSH SERVICE WITHIN THE SERVER CONFIGURATION USES RUNTIME_SVC_NAME INSTEAD OF ANALYTICS INTERNAL ENDPOINT FOR MFP ON ICP.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201906191215" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-mfp-devkit-IF201906191215" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201906191215"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201906191215">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201906191215.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201906191215.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201906191215.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-cordova-plugins-IF201906191215" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201906191215"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201906191215">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019061808</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019061808</b><br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019050614<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-tools-IF201906191215" aria-expanded="true" aria-controls="collapse-tools-IF201906191215">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201906191215">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-ios-sdk-IF201906191215" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201906191215">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201906191215">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-android-sdk-IF201906191215" aria-expanded="true" aria-controls="collapse-android-sdk-IF201906191215"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201906191215">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019052014<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                <b>adapter-maven-plugin              8.0.2019051307</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019051307</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019051307</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019051307</b><br/>
                                <b>adapter-maven-api                 8.0.2019051307</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-win-sdk-IF201906191215" aria-expanded="true" aria-controls="collapse-win-sdk-IF201906191215">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201906191215">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-xamarin-sdk-IF201906191215" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201906191215">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201906191215">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201906191215">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201906191215" href="#collapse-reactnative-sdk-IF201906191215" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201906191215"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201906191215" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201906191215">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019061404</b><br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019061404</b><br/>
                                <b>react-native-ibm-mobilefirst-push 8.0.2019051709</b><br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201905231219" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201905231219">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201905231219" href="#collapse-mfp-ifix-IF201905231219" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201905231219"><b>8.0.0.0-MFPF-IF201905231219</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201905231219">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>May 23rd, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH12535</b>  ACCESSING THE MFP CONSOLE (SERVER/ANALYTICS/APPCENTER) THROUGH ICP DEFAULT INGRESS WITH HTTPS APPENDS PORT 80.<br/>
            <b>PH11616</b>  ANDROID AND IOS CLIENTS RECEIVE INVALID_REQUEST AFTER APP UPDATE.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201905231219" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-mfp-devkit-IF201905231219" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201905231219"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201905231219">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201905231219.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201905231219.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201905231219.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-cordova-plugins-IF201905231219" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201905231219"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201905231219">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019052114</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019050614<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019050614<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-tools-IF201905231219" aria-expanded="true" aria-controls="collapse-tools-IF201905231219">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201905231219">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-ios-sdk-IF201905231219" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201905231219">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201905231219">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-android-sdk-IF201905231219" aria-expanded="true" aria-controls="collapse-android-sdk-IF201905231219"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201905231219">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019052014</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                adapter-maven-plugin              8.0.2019043010<br/>
                                adapter-maven-archetype-sql      8.0.2019043010<br/>
                                adapter-maven-archetype-java      8.0.2019043010<br/>
                                adapter-maven-archetype-http      8.0.2019043010<br/>
                                adapter-maven-api                 8.0.2019043010<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-win-sdk-IF201905231219" aria-expanded="true" aria-controls="collapse-win-sdk-IF201905231219">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201905231219">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-xamarin-sdk-IF201905231219" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201905231219">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201905231219">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201905231219">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905231219" href="#collapse-reactnative-sdk-IF201905231219" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201905231219"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201905231219" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201905231219">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019041208<br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019041511</b><br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201905141027" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201905141027">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201905141027" href="#collapse-mfp-ifix-IF201905141027" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201905141027"><b>8.0.0.0-MFPF-IF201905141027</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201905141027">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>May 14th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH11499</b>  DIRECTUPDATE FAILS ON IOS WHEN UPDATE SIZE IS GREATER THAN 8 MB WHEN USING A FIREWALL WHICH DOES HARDCHECK ON CONTENTLENGTH.<br/>
            <b>PH12093</b>  JSONSTORE COLLECTION THROWS INITIALISATION ERROR ON CALLING OPENCOLLECTIONS API ON AN ALREADY OPENED COLLECTION.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201905141027" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-mfp-devkit-IF201905141027" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201905141027"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201905141027">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201905141027.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201905141027.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201905141027.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-cordova-plugins-IF201905141027" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201905141027"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201905141027">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019050614<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019050614<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              <b>cordova-plugin-mfp-analytics      8.0.2019050614</b><br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-tools-IF201905141027" aria-expanded="true" aria-controls="collapse-tools-IF201905070819">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201905141027">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-ios-sdk-IF201905141027" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201905141027">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201905141027">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019042610<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-android-sdk-IF201905141027" aria-expanded="true" aria-controls="collapse-android-sdk-IF201905141027"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201905141027">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019041807<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019042610</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                <b>adapter-maven-plugin              8.0.2019043010</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019043010</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019043010</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019043010</b><br/>
                                <b>adapter-maven-api                 8.0.2019043010</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-win-sdk-IF201905141027" aria-expanded="true" aria-controls="collapse-win-sdk-IF201905141027">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201905141027">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-xamarin-sdk-IF201905141027" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201905141027">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201905141027">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201905141027">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905141027" href="#collapse-reactnative-sdk-IF201905141027" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201905141027">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201905141027" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201905141027">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019041208<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019041208<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201905070819" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201905070819">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201905070819" href="#collapse-mfp-ifix-IF201905070819" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201905070819"><b>8.0.0.0-MFPF-IF201905070819</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201905070819">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>May 7th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH11616</b>  IOS CLIENTS RECEIVES INVALID_REQUEST AFTER APP UPDATE.<br/>
            <b>PH11106</b>  AN ERROR FOUND IN THE LATEST CORDOVA PLUGIN.<br/>
            <b>PH10990</b>  PREPARESERVERDBS SCRIPT FAILS TO CREATE MFP TABLES IN BYOL DEPLOYMENT WHEN DASHDB SERVICE KEY NAME HAS SPACES.<br/>
            <b>PH10641</b>  JSONSTORE SUPPORT FOR 64 BIT ARCHITECTURES.<br/>
            <b>PH09659</b>  THE ANDROID SDK DOES NOT CLEAR THE CORRECT DATA DURING RE-REGISTRATION OF THE CLIENT.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201905070819" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-mfp-devkit-IF201905070819" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201905070819"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201905070819">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201905070819.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201905070819.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201905070819.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-cordova-plugins-IF201905070819" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201905070819"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201905070819">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019050614</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019050614</b><br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019021303<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-tools-IF201905070819" aria-expanded="true" aria-controls="collapse-tools-IF201905070819">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201905070819">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-ios-sdk-IF201905070819" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201905070819"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201905070819">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019042610</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019042610</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-android-sdk-IF201905070819" aria-expanded="true" aria-controls="collapse-android-sdk-IF201905070819"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201905070819">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019041807</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019032505</b><br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                <b>adapter-maven-plugin              8.0.2019032901</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019032901</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019032901</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019032901</b><br/>
                                <b>adapter-maven-api                 8.0.2019032901</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-win-sdk-IF201905070819" aria-expanded="true" aria-controls="collapse-win-sdk-IF201905070819">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201905070819">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-xamarin-sdk-IF201905070819" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201905070819">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201905070819">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201905070819">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201905070819" href="#collapse-reactnative-sdk-IF201905070819" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201905070819">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201905070819" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201905070819">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019041208<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019041208<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201904160914" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201904160914">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201904160914" href="#collapse-mfp-ifix-IF201904160914" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201904160914"><b>8.0.0.0-MFPF-IF201904160914</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201904160914">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>April 16th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH09721</b>  CORDOVA IOS APPLICATION DOES NOT TIMEOUT FOR WLAUTHORIZATIONMANAGER.LOGIN.<br/>
            <b>PH10615</b>  SETLOGINTIMEOUT WAS NOT EXPOSED THROUGH  REACT NATIVE BRIDGE FOR IOS.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201904160914" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-mfp-devkit-IF201904160914" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201904160914"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201904160914">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201904160914.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201904160914.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201904160914.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-cordova-plugins-IF201904160914" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201904160914"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201904160914">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019041010</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019021303<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-tools-IF201904160914" aria-expanded="true" aria-controls="collapse-tools-IF201904160914">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201904160914">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-ios-sdk-IF201904160914" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201904160914">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201904160914">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019032216<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019032216<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-android-sdk-IF201904160914" aria-expanded="true" aria-controls="collapse-android-sdk-IF201904160914">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201904160914">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019021111<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                adapter-maven-plugin              8.0.2019032313<br/>
                                adapter-maven-archetype-sql      8.0.2019032313<br/>
                                adapter-maven-archetype-java      8.0.2019032313<br/>
                                adapter-maven-archetype-http      8.0.2019032313<br/>
                                adapter-maven-api                 8.0.2019032313<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-win-sdk-IF201904160914" aria-expanded="true" aria-controls="collapse-win-sdk-IF201904160914">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201904160914">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-xamarin-sdk-IF201904160914" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201904160914">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201904160914">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201904160914">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904160914" href="#collapse-reactnative-sdk-IF201904160914" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201904160914"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201904160914" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201904160914">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019041208</b><br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019041208</b><br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201904021040" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201904021040">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201904021040" href="#collapse-mfp-ifix-IF201904021040" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201904021040"><b>8.0.0.0-MFPF-IF201904021040</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201904021040">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>April 2nd, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH09992</b>  IBMMOBILEFIRSTPLATFORMFOUNDATIONWATCHOS.FRAMEWORK IS NOT BUILT WITH BITCODE ENABLED.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201904021040" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-mfp-devkit-IF201904021040" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201904021040"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201904021040">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201904021040.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201904021040.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201904021040.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-cordova-plugins-IF201904021040" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201904021040"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201904021040">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019040115</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019021303<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-tools-IF201904021040" aria-expanded="true" aria-controls="collapse-tools-IF201904021040">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201904021040">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-ios-sdk-IF201904021040" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201904021040"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201904021040">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019032216</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019032216</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-android-sdk-IF201904021040" aria-expanded="true" aria-controls="collapse-android-sdk-IF201904021040"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201904021040">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019021111<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                <b>adapter-maven-plugin              8.0.2019032313</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019032313</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019032313</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019032313</b><br/>
                                <b>adapter-maven-api                 8.0.2019032313</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-win-sdk-IF201904021040" aria-expanded="true" aria-controls="collapse-win-sdk-IF201904021040">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201904021040">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-xamarin-sdk-IF201904021040" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201904021040">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201904021040">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201904021040">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201904021040" href="#collapse-reactnative-sdk-IF201904021040" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201904021040"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201904021040" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201904021040">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019030111<br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019032910</b><br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201903250706" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201903250706">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201903250706" href="#collapse-mfp-ifix-IF201903250706" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201903250706"><b>8.0.0.0-MFPF-IF201903250706</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201903250706">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>March 25th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH09118</b>  CLIENT JWT AUTHENTICATION FAILS IN WEB SDK ENVIRONMENTS.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201903250706" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-mfp-devkit-IF201903250706" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201903250706"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201903250706">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201903250706.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201903250706.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201903250706.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-cordova-plugins-IF201903250706" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201903250706">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201903250706">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019030615<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              cordova-plugin-mfp-push            8.0.2019031905<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019021303<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-tools-IF201903250706" aria-expanded="true" aria-controls="collapse-tools-IF201902040810">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201903250706">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-ios-sdk-IF201903250706" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201903250706">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201903250706">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019030211<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019030211<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018121407<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-android-sdk-IF201903250706" aria-expanded="true" aria-controls="collapse-android-sdk-IF201903250706"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201903250706">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019021111<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2019031206<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                <b>adapter-maven-plugin              8.0.2019032311</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019032311</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019032311</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019032311</b><br/>
                                <b>adapter-maven-api                 8.0.2019032311</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-win-sdk-IF201903250706" aria-expanded="true" aria-controls="collapse-win-sdk-IF201903250706">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201903250706">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-xamarin-sdk-IF201903250706" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201903250706">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201903250706">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201903250706">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903250706" href="#collapse-reactnative-sdk-IF201903250706" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201903250706">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201903250706" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201903250706">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019030111<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019030111<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201903190949" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201903190949">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201903190949" href="#collapse-mfp-ifix-IF201903190949" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201903190949"><b>8.0.0.0-MFPF-IF201903190949-CDUpdate-05</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201903190949" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201903190949">
            <div class="panel-body">
            CD Update-05 for MobileFirst Foundation 8.0, dated <b>March 19th, 2019</b>.

            <h2>Changes in this CD Update</h2>
            <i>For a cumulative list of all previous CD Update announcements, see the <a href="http://mobilefirstplatform.ibmcloud.com/blog/tag/CDUpdate_8.0/">here</a>.</i><br/>

            <h2>Features</h2>
            <blockquote>To view the details about the features included in this CD Update, see the <a href="{{site.baseurl}}/blog/2019/03/22/8-0-cd-update-release">announcement</a>.</blockquote>

        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201903181319" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201903181319">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201903181319" href="#collapse-mfp-ifix-IF201903181319" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201903181319"><b>8.0.0.0-MFPF-IF201903181319</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201903181319">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>March 18th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH09486</b>  INTERMITTENT ERROR OCCURS WHEN INVOKING CUSTOM JAVA CLASSES FROM JAVASCRIPT ADAPTER.<br/>
            <b>PH08951</b>  WITH MULTIPLE PUSH SDK'S, APP CRASHES IF PAYLOAD STRING IS NOT PART OF NOTIFICATION JSON.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201903181319" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-mfp-devkit-IF201903181319" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201903181319"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201903181319">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201903181319.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201903181319.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201903181319.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-cordova-plugins-IF201903181319" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201903181319"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201903181319">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019030612<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              <b>cordova-plugin-mfp-push            8.0.2019031905</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              cordova-plugin-mfp-analytics      8.0.2019021303<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-tools-IF201903070211" aria-expanded="true" aria-controls="collapse-tools-IF201903181319">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201903181319">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-ios-sdk-IF201903181319" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201903181319">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201903181319">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019030211<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019030211<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-android-sdk-IF201903181319" aria-expanded="true" aria-controls="collapse-android-sdk-IF201903181319">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201903181319">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2019021111<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018121407<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110<br/>
                                IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910<br/>
                                adapter-maven-plugin              8.0.2019021416<br/>
                                adapter-maven-archetype-sql      8.0.2019021416<br/>
                                adapter-maven-archetype-java      8.0.2019021416<br/>
                                adapter-maven-archetype-http      8.0.2019021416<br/>
                                adapter-maven-api                 8.0.2019021416<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-win-sdk-IF201903181319" aria-expanded="true" aria-controls="collapse-win-sdk-IF201903181319">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201903181319">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2019020516<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-xamarin-sdk-IF201903181319" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201903181319">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201903181319">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201903181319">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903181319" href="#collapse-reactnative-sdk-IF201903181319" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201903181319">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201903181319" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201903181319">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2019030111<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2019030111<br/>
                                react-native-ibm-mobilefirst-push 8.0.2019030111<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201903070211" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201903070211">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201903070211" href="#collapse-mfp-ifix-IF201903070211" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201903070211"><b>8.0.0.0-MFPF-IF201903070211</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201903070211">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>March 7th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>Features</h3>
            <blockquote>Starting with this iFix, support for cordova-android@8.0.0 is provided.</blockquote>

            <h3>APARs Fixed</h3>
            <b>PH09167</b>  THE CODE DOES NOT RECOGNISE THE TOMCAT V8.5 AND V9 DIRECTORY.<br/>
            <b>PH08712</b>  BUILDING AND UPGRADING LIBCRYPTO.SO FILE WITH LATEST OPENSSL AND OPENSSL-FIPS VERSION.<br/>
            <b>PH08680</b>  CORDOVA ANDROID BUILD COMMAND IN RELEASE MODE FAILS WITH PUSH PLUGIN.<br/>
            <b>PH08320</b>  LOGGING TO ANALYTICS SERVICE FROM SERVER THROWS EXCEPTIONS WHILE PARSIN.<br/>
            <b>PH07633</b>  MOBILEFIRST IOS WATCH OS FRAMEWORK THROWS WARNING WHICH RISKS REJECTION OF THE APP IN THE APPSTORE.<br/>
            <b>PH07333</b>  FIX TRIGGERFEEDBACKMODE() METHOD RELATED TO INAPP FEEDBACK WHICH IS LOGGING SENSITIVE INFORMATION IN LOGCAT.<br/>
            <b>PH07033</b>  AN ANDROID APP FAILS TO CONNECT TO A SERVER AFTER RESTORING BACKED UP DATA FOLLOWING A FACTORY RESET OF THE DEVICE.<br/>
            <b>PH06915</b>  POOR PERFORMANCE DURING TLS HANDSHAKE IN V8.0 WHEN COMPARED WITH V7.1.<br/>
            <b>PH06982</b>  XAMARIN SDK IS UNABLE TO HANDLE COMPLEX CUSTOM ATTRIBUTES DURING LOGIN.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201903070211" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-mfp-devkit-IF201903070211" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201903070211"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201903070211">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201903070211.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201903070211.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201903070211.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-cordova-plugins-IF201903070211" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201903070211"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201903070211">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019030612</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              <b>cordova-plugin-mfp-push            8.0.2019022010</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              <b>cordova-plugin-mfp-analytics      8.0.2019021303</b><br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-tools-IF201903070211" aria-expanded="true" aria-controls="collapse-tools-IF201902040810">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201903070211">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-ios-sdk-IF201903070211" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201903070211"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201903070211">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019030211</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019030211</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics             8.0.2019012819</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-android-sdk-IF201903070211" aria-expanded="true" aria-controls="collapse-android-sdk-IF201903070211"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201903070211">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2019021111</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018121407<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2019011110</b><br/>
                                <b>IBMMobileFirstPlatformFoundationAnalytics     8.0.2019012910</b><br/>
                                <b>adapter-maven-plugin              8.0.2019021416</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019021416</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019021416</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019021416</b><br/>
                                <b>adapter-maven-api                 8.0.2019021416</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-win-sdk-IF201903070211" aria-expanded="true" aria-controls="collapse-win-sdk-IF201903070211"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201903070211">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2019020516</b><br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-xamarin-sdk-IF201903070211" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201903070211">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201903070211">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201903070211">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201903070211" href="#collapse-reactnative-sdk-IF201903070211" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201903070211"><b>React Native SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201903070211" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201903070211">
                        <div class="panel-body">
                                <b>react-native-ibm-mobilefirst 8.0.2019030111</b><br/>
                                <b>react-native-ibm-mobilefirst-jsonstore  8.0.2019030111</b><br/>
                                <b>react-native-ibm-mobilefirst-push 8.0.2019030111</b><br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201902040810" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201902040810">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201902040810" href="#collapse-mfp-ifix-IF201902040810" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201902040810"><b>8.0.0.0-MFPF-IF201902040810</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201902040810">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>February 4th, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <h3>APARs Fixed</h3>
            <b>PH07909</b>  PUSH NOTIFICATION CONNECTIONS TO FCM NOT RELEASED.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201902040810" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-mfp-devkit-IF201902040810" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201902040810"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201902040810">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201902040810.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201902040810.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201902040810.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-cordova-plugins-IF201902040810" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201902040810">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201902040810">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2019012308<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2019012308<br/>
                              cordova-plugin-mfp-push            8.0.2018121910<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-tools-IF201902040810" aria-expanded="true" aria-controls="collapse-tools-IF201902040810">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201902040810">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-ios-sdk-IF201902040810" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201902040810">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201902040810">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2019012808<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019012808<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-android-sdk-IF201902040810" aria-expanded="true" aria-controls="collapse-android-sdk-IF201902040810">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201902040810">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018112912<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018121407<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514<br/>
                                adapter-maven-plugin              8.0.2019012906<br/>
                                adapter-maven-archetype-sql      8.0.2019012906<br/>
                                adapter-maven-archetype-java      8.0.2019012906<br/>
                                adapter-maven-archetype-http      8.0.2019012906<br/>
                                adapter-maven-api                 8.0.2019012906<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-win-sdk-IF201902040810" aria-expanded="true" aria-controls="collapse-win-sdk-IF201902040810">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201902040810">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018100111<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-xamarin-sdk-IF201902040810" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201902040810">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201902040810">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201902040810">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201902040810" href="#collapse-reactnative-sdk-IF201902040810" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201902040810">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201902040810" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201902040810">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018111809<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2018111809<br/>
                                react-native-ibm-mobilefirst-push 1.0.0<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201901311547" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201901311547">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201901311547" href="#collapse-mfp-ifix-IF201901311547" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201901311547"><b>8.0.0.0-MFPF-IF201901311547</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201901311547">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>January 31st, 2019</b>.

            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <blockquote>This iFix adds support for Model Update. Mobile Foundation applications can now embed Machine Learning models, which can be updated over-the-air with newer versions. <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/model-update/">Learn more</a>.</blockquote>

            <h3>APARs Fixed</h3>
            <b>PH07792</b>  PERFORMANCE OPTIMIZATION TO AVOID MULTIPLE DATABASE CONNECTIONS TO MFP RUNTIMES DATABASE.<br/>
            <b>PH07459</b>  DIRECT UPDATE NOT TRIGGERED AFTER UPGRADING THE APP FROM APP STORE/GOOGLE PLAY STORE.<br/>
            <b>PH07433</b>  THE AUTHORIZATION HEADER IN THE \AUTHORIZATION ENDPOINT REQUEST IS SENT EMPTY.<br/>
            <b>PH07033</b>  AFTER FACTORY RESET AND RELOADING THE APP WLAUTHORIZATIONMANAGER.OBTAINACCESSTOKEN PUT NOT SUPPORTED ERROR.<br/>
            <b>PH06633</b>  CORDOVA BUILD ANDROID FAILS WITH COMPILESDKVERSION ERROR.<br/>


            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201901311547" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-mfp-devkit-IF201901311547" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201901311547"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201901311547">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201901311547.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201901311547.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201901311547.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-cordova-plugins-IF201901311547" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201901311547"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201901311547">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2019012308</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2019012308</b><br/>
                              cordova-plugin-mfp-push            8.0.2018121910<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-tools-IF201901311547" aria-expanded="true" aria-controls="collapse-tools-IF201901311547">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201901311547">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018121711<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-ios-sdk-IF201901311547" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201901311547"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201901311547">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2019012808</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2019012808</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-android-sdk-IF201901311547" aria-expanded="true" aria-controls="collapse-android-sdk-IF201901311547"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201901311547">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018112912<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018121407<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514<br/>
                                <b>adapter-maven-plugin              8.0.2019012906</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2019012906</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2019012906</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2019012906</b><br/>
                                <b>adapter-maven-api                 8.0.2019012906</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-win-sdk-IF201901311547" aria-expanded="true" aria-controls="collapse-win-sdk-IF201901311547">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201901311547">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018100111<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018090415<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-xamarin-sdk-IF201901311547" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201901311547">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201901311547">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201901311547">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201901311547" href="#collapse-reactnative-sdk-IF201901311547" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201901311547">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201901311547" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201901311547">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018111809<br/>
                                react-native-ibm-mobilefirst-jsonstore  8.0.2018111809<br/>
                                react-native-ibm-mobilefirst-push 1.0.0<br/>
                        </div>
                    </div>        
                </div>
            </div>        
        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201812191602" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201812191602">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201812191602" href="#collapse-mfp-ifix-IF201812191602" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201810040631"><b>8.0.0.0-MFPF-IF201812191602-CDUpdate-04</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201812191602" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201812191602">
            <div class="panel-body">
            CD Update-04 for MobileFirst Foundation 8.0, dated <b>December 19th, 2018</b>.

            <h2>Changes in this CD Update</h2>
            <i>For a cumulative list of all previous CD Update announcements, see the <a href="http://mobilefirstplatform.ibmcloud.com/blog/tag/CDUpdate_8.0/">here</a>.</i><br/><br/>

            <h2>Features</h2>
            <blockquote>To view the details about the features included in this CD Update, see the <a href="https://mobilefirstplatform.ibmcloud.com/blog/2018/12/24/8-0-cd-update-release">announcement</a>.</blockquote>

            <h3>APARs Fixed</h3>
            <b>PH06599</b>  CURRENCY UPGRADE TO LIBERTY (18.0.0.4) AND IBM JAVA 8.0.5.26.<br/>
            <b>PH06226</b>  THE MESSAGE RETURNING FROM MFP SERVER INCLUDES THE SERVER URL.<br/>
            <b>PH05860</b>  THE MFPDEV-CLI FAILS USING THE COMMAND ‘MFPDEV  INFO’ AND ‘MFPDEV APP PREVIEW’ HAS ISSUE WITH LEFT PANEL AND AUTOMATIC RELOAD.<br/>
            <b>PH05557</b>  GETTING ERROR FWLAC0101W WHEN ADDING LINK TO GOOGLE PLAY STORE.<br/>
            <b>PH03741</b>  MOBILEFIRST BINARY USES BANNED API(S).<br/>
            <b>PH03726</b>  XAMARIN IOS UI HANGS ON CALLING USERINPUTEVENT.WAITONE() API AFTER INVOKING A NEW UI.<br/>
            <b>PH03491</b>  A MOBILEFIRST CORDOVA APP MIGHT CRASH ON IOS DEVICES AFTER A SERIES OF LOGINS/LOGOUTS.<br/>
            <b>PH02986</b>  REGULAR CLEAN UP OF MFP SERVER TABLES TO REMOVE STALE RECORDS.<br/>
            <b>PH02548</b> MOBILEFIRST SDK USES THE MALLOC API WITHOUT RELEASING MEMORY.<br/>


        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201811050432" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201811050432">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201811050432" href="#collapse-mfp-ifix-IF201811050432" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201811050432"><b>8.0.0.0-MFPF-IF201811050432-CDUpdate-03</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201811050432" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201811050432">
            <div class="panel-body">
            CD Update-03 for MobileFirst Foundation 8.0, dated <b>November 5th, 2018</b>.

            <h2>Changes in this CD Update</h2>
            <i>For a cumulative list of all previous CD Update announcements, see the <a href="http://mobilefirstplatform.ibmcloud.com/blog/tag/CDUpdate_8.0/">here</a>.</i><br/><br/>

            <h2>Features</h2>
            <blockquote>To view the details about the features included in this CD Update, see the <a href="https://mobilefirstplatform.ibmcloud.com/blog/2018/11/15/8-0-cd-update-release/">announcement</a>.</blockquote>

            <h3>APARs Fixed</h3>
            <b>PH04756</b>  IOS APPS BUILT WITH MFP SDK MAY CRASH INTERMITTENTLY WHEN INVOKING OBTAINACCESSToken API.<br/>
            <b>PH04503</b>  APP FALLS INTO INRECOVERABLE STATE AFTER DIRECT UPDATE FAILED.<br/>
            <b>PH04229</b>  FWLST0904E ERROR OCCURS INTERMITTENTLY ON JAVASCRIPT PROCEDURE CALLS.<br/>
            <b>PH04117</b>  MFP ADAPTER POTENTIAL SECURITY RISK WHEN CALLING NON-EXISTENCEADAPTER.<br/>
            <b>PH04094</b>  PUSH NOTIFICATIONS MAY BE LOST IN CORDOVA-BASED ANDROID APPS IF MULTIPLE NOTIFICATIONS ARE RECEIVED WHILE THE APP IS RUNNING.<br/>
            <b>PH03280</b>  VULNERABILITY IN ADVANCE ENCRYPTION STANDARD ALGORITHM.<br/>
            <b>PH01886</b>  INCOMPATIBILITY IN API SIGNATURES BETWEEN THE CORDOVA SDK AND WEB SDK.<br/>

        </div>
    </div>
</div>   
</div>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201810040631" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201810040631">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201810040631" href="#collapse-mfp-ifix-IF201810040631" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201810040631"><b>iFix 8.0.0.0-MFPF-IF201810040631</b> </a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201810040631">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>October 4th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <blockquote>This iFix adds support for Node v8.x for the MobileFirst CLI.</blockquote>

            <h3>APARs Fixed</h3>

            <b>PH03755</b>  MOBILEFIRST ICP PACKAGE TO EXTEND SUPPORT FOR DEPLOYMENT ON IBMCLOUD KUBERNETES SERVICE (IKS).<br/>
            <b>PH03687</b>  MONITORING FOR MOBILE FOUNDATION RUNNING ON IBM CLOUD PRIVATE.<br/>
            <b>PH03387</b>  MFP 8.0 - ISPUSHSUPPORTED API FAILS IN ANDROID P DEVICE.<br/>
            <b>PH03276</b>  CERTIFICATE PINNING IGNORES INVALID CERTIFICATES.<br/>
            <b>PH03155</b>  UPDATE TO PERSISTENT DATA FAILS ON RETRYING TO OPTIMISTICLOCKINGEXCEPTION.<br/>
            <b>PH03154</b>  POST MIGRATION FROM GCM TO FCM ,WITH NEW HYBRID PROJECTSBUILD.GRADLE FILE IS NOT POINTING TO LATEST FIREBASE CHANGES.<br/>
            <b>PH03116</b>  THE CLIENT RECEIVES "INVALID_REQUEST" ERROR DURING UPDATE REGISTRATION AND NEVER RECOVERS.<br/>
            <b>PH02951</b>  "INCORRECT JWT FORMAT" ERROR OCCURS FOR SOME MOBILE CLIENTS.<br/>
            <b>PH02932</b>  OPENSSL HAS RECEIVED SECURITY UPDATES 1.0.2P AND MUST BEUPGRADED TO THE LATEST VERSION.<br/>
            <b>PH02674</b>  MFP 8.0 MFP-PUSH-SERVICE TO SUPPORT LATEST APNS MESSAGESTRUCTURE.<br/>
            <b>PI99457</b>  UNABLE TO ADD THE IBM.MOBILEFIRSTPLATFORMFOUNDATION NUGET PACKAGE INTO VISUAL STUDIO 2017.<br/>
            <b>PI99454</b>  PROBLEM IN JSONSTORE CHANGE() API FOR WIN PLATFORM.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201810040631" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-mfp-devkit-IF201810040631" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201810040631"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201810040631">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201810040631.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201810040631.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201810040631.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-cordova-plugins-IF201810040631" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201810040631"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201810040631">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018090313</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2018090313</b><br/>
                              <b>cordova-plugin-mfp-push            8.0.2018100111</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-tools-IF201810040631" aria-expanded="true" aria-controls="collapse-tools-IF201810040631"><b>Tools</b></a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201810040631">
                        <div class="panel-body">
                              <b>mfpdev-cli 8.0.2018100112</b><br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-ios-sdk-IF201810040631" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201810040631">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201810040631">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2018082906<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018082906<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-android-sdk-IF201810040631" aria-expanded="true" aria-controls="collapse-android-sdk-IF201810040631"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201810040631">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018092809</b><br/>
                                <b>ibmmobilefirstplatformfoundationpush            8.0.2018100107</b><br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514<br/>
                                <b>adapter-maven-plugin              8.0.2018092101</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2018092101</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018092101</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018092101</b><br/>
                                <b>adapter-maven-api                 8.0.2018092101</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-win-sdk-IF201810040631" aria-expanded="true" aria-controls="collapse-win-sdk-IF201810040631"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201810040631">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2018090415</b><br/>
                                <b>IBM MobileFirstPlatform Push SDK  8.0.2018090415</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-xamarin-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201810040631">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201810040631">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201810040631">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201810040631" href="#collapse-reactnative-sdk-IF201810040631" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201810040631">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201810040631" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201810040631">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018072413<br/>
                        </div>
                    </div>        
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201809041150" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201809041150">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201809041150" href="#collapse-mfp-ifix-IF201809041150" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201809041150"><b>iFix 8.0.0.0-MFPF-IF201809041150</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201809041150">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>September 4th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <blockquote>This iFix includes a change to remove <i>libstdc++</i> as a dependency to Cordova projects. This is required for new apps running on iOS 12. For further details, such as a workaround, refer to <a href="https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/">this blog post</a>.</blockquote>

            <h3>APARs Fixed</h3>

            <b>PH02184</b> AFTER APPLYING AN IFIX TO MOBILEFIRST, LARGE STACK TRACES BEGAN TO APPEAR IN THE SERVER OUTPUT.<br/>
            <b>PH01542</b> XSL TRANSFORMATION IGNORED IN JAVASCRIPT ADAPTERS WHEN BACKEND RESPONSE HTTP STATUS CODE >= 400.<br/>
            <b>PH01012</b> GENERATING AN ANDROID APK FAILS IN RELEASE MODE WHEN PROGUARD IS USED.<br/>
            <b>PI99457</b> UNABLE TO ADD THE IBM.MOBILEFIRSTPLATFORMFOUNDATION PACKAGE  INTO VISUAL STUDIO 2017.<br/>
            <b>PI98348</b> DIRECT UPDATE WOULD FAIL IF TURN OFF WIFI.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201809041150" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-mfp-devkit-IF201809041150" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201809041150"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201809041150">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201809041150.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201809041150.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201809041150.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-cordova-plugins-IF201809041150" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201809041150"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201809041150">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018090311</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2018080605<br/>
                              cordova-plugin-mfp-push            8.0.2018072407<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-tools-IF201809041150" aria-expanded="true" aria-controls="collapse-tools-IF201809041150">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201809041150">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-ios-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201809041150"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201809041150">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018082906</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018082906</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-android-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-android-sdk-IF201809041150"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201809041150">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018083007</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514<br/>
                                <b>adapter-maven-plugin              8.0.2018082311</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2018082311</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018082311</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018082311</b><br/>
                                <b>adapter-maven-api                 8.0.2018082311</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-win-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-win-sdk-IF201809041150"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201809041150">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2018081607</b><br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-xamarin-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201809041150">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201809041150">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201809041150">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201809041150" href="#collapse-reactnative-sdk-IF201809041150" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201809041150">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201809041150">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018072413<br/>
                        </div>
                    </div>        
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>  
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201808170826" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201808170826">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201808170826" href="#collapse-mfp-ifix-IF201808170826" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201808170826"><b>iFix 8.0.0.0-MFPF-IF201808170826</b> </a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201808170826">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>August 17th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PH01779</b> MOBILEFIRST SERVER PERFORMING SLOW WITH LOAD<br/>
            <b>PI99633</b> ZIPPERDOWN VULNERABILITY AFFECTING IOS APPS<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201808170826" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-mfp-devkit-IF201808170826" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201808170826"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201808170826">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201808170826.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201808170826.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201808170826.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-cordova-plugins-IF201808170826" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201808170826">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201808170826">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2018080605<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore      8.0.2018080605<br/>
                              cordova-plugin-mfp-push            8.0.2018072407<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-tools-IF201808170826" aria-expanded="true" aria-controls="collapse-tools-IF201808170826">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201808170826">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20180813050750<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-ios-sdk-IF201808170826" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201808170826"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201808170826">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018071515</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018071515</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-android-sdk-IF201808170826" aria-expanded="true" aria-controls="collapse-android-sdk-IF201808170826"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201808170826">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018071606<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514<br/>
                                <b>adapter-maven-plugin              8.0.2018081616</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2018081616</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018081616</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018081616</b><br/>
                                <b>adapter-maven-api                 8.0.2018081616</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-win-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-win-sdk-IF201808131120">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201808170826">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-xamarin-sdk-IF201808170826" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201808170826">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201808170826">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201808170826">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808170826" href="#collapse-reactnative-sdk-IF201808170826" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201808170826">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201808170826" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201808170826">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018072413<br/>
                        </div>
                    </div>        
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   
<div class="panel-group accordion" id="mfp-8.0-ifix-IF201808131120" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201808131120">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201808131120" href="#collapse-mfp-ifix-IF201808131120" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201808131120"><b>iFix 8.0.0.0-MFPF-IF201808131120</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201808131120">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>August 13th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PH01690</b> MFP 8.0 PUSH TO AUTHENTICATE THE REQUESTS USING A JNDI PROPERTY<br/>
            <b>PI99731</b> THE MFP SERVER VERSION IS RETURNED AS PART OF ERROR RESPONSE<br/>
            <b>PI99443</b> IMPROPER OUTPUT NEUTRALIZATION FOR LOGS IN JSONSTORE CODE<br/>
            <b>PI96509</b> UNABLE TO INSTALL MFPMIGRATE-CLI<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201808131120" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-mfp-devkit-IF201808131120" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201808131120"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201808131120">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201808131120.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201808131120.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201808131120.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-cordova-plugins-IF201808131120" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201808131120"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201808131120">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018080605</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2018080605</b><br/>
                              cordova-plugin-mfp-push            8.0.2018072407<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                     8.0.2018071716<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-tools-IF201808131120" aria-expanded="true" aria-controls="collapse-tools-IF201808131120"><b>Tools</b></a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201808131120">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              <b>mfpmigrate-cli 8.0.20180813050750</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-ios-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201808131120">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201808131120">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018071512<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2018071512<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-android-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-android-sdk-IF201808131120"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201808131120">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018071606</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2018070514</b><br/>
                                <b>adapter-maven-plugin              8.0.2018071507</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2018071507</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018071507</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018071507</b><br/>
                                <b>adapter-maven-api                 8.0.2018071507</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-win-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-win-sdk-IF201808131120">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201808131120">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-xamarin-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201808131120">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201808131120">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="reactnative-sdk-IF201808131120">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201808131120" href="#collapse-reactnative-sdk-IF201808131120" aria-expanded="true" aria-controls="collapse-reactnative-sdk-IF201808131120">React Native SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-reactnative-sdk-IF201808131120" class="panel-collapse collapse" role="tabpanel" aria-labelledby="reactnative-sdk-IF201808131120">
                        <div class="panel-body">
                                react-native-ibm-mobilefirst 8.0.2018072413<br/>
                        </div>
                    </div>        
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201807180449" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201807180449">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201807180449" href="#collapse-mfp-ifix-IF201807180449" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201807180449"><b>8.0.0.0-MFPF-IF201807180449-CDUpdate-02</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201807180449" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201807180449">
            <div class="panel-body">
            CD Update-02 for MobileFirst Foundation 8.0, dated <b>July 18th, 2018</b>.

            <h2>Changes in this CD Update</h2>
            <i>For a cumulative list of all previous CD Update announcements, see the <a href="http://mobilefirstplatform.ibmcloud.com/blog/tag/CDUpdate_8.0/">here</a>.</i><br/><br/>

            <h2>Features</h2>
            <blockquote>To view the details about the features included in this CD Update, see the <a href="https://mobilefirstplatform.ibmcloud.com/blog/2018/07/24/8-0-cd-update-release/">announcement</a>.</blockquote>

            <h3>APARs Fixed</h3>
            <b>PH00482</b>  SUPPORT FOR REFRESH TOKEN.<br/>
            <b>PH00480</b>  UPGRADING JAVA AND LIBERTY VERSIONS FOR BYOL/ICP PACKAGES.<br/>
            <b>PH00105</b>  USE OF ANALYTICS WEB SDK MODIFIES THE NATIVE OBJECT XMLHTTPREQUEST.<br/>
            <b>PH00066</b>  DB2 Q-REPLICATION WITH MFP DB NOT WORKING IN MFP8.<br/>
            <b>PI99445</b>  USE OF HARD-CODED PASSWORD IN JSONSTORE CODE.<br/>
            <b>PI99056</b>  UNABLE TO REMOVE A COOKIE USING MOBILEFIRST V8 ANDROID SDK.<br/>
            <b>PI97512</b>  HTTPS CONNECTION CREATES NEW SOCKET FOR ALL REQUESTS.<br/>

        </div>
    </div>
</div>   
</div>


<div class="panel-group accordion" id="mfp-8.0-ifix-IF201807050331" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201807050331">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201807050331" href="#collapse-mfp-ifix-IF201807050331" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201807050331"><b>iFix 8.0.0.0-MFPF-IF201807050331</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201807050331">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>July 5th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI99733</b> STRENGTHEN MFP AUTHORIZATION TO PREVENT REDIRECTING TO OUTSIDEURLS<br/>
            <b>PI99720</b> REFERENCEERROR: "MFP" IS NOT DEFINED EXCEPTION OCCURS INTERMITTENTLY WITH JAVASCRIPT ADAPTER PROCEDURE CALLS<br/>
            <b>PI99576</b> FULL DIRECTUPDATE FAILS IN I-OS WHEN THERE IS AN IHS IN BETWEEN CONFIGURED TO CHECK LENGTH.<br/>
            <b>PI99541</b> USER IS PROMPTED FOR DIRECT UPDATE INFINITELY IN AN IONIC APP ON IOS<br/>
            <b>PI99298</b> ONERRORREMOTEDISABLEDENIAL FUNCTION NOT WORKING AS EXPECTED FOR IOS PLATFORM.<br/>
            <b>PI99174</b> SESSION INFORMATION IS STORED IN LOCAL STORAGE AND PERSISTS AFTER THE BROWSER EXITS.<br/>
            <b>PI99044</b> THE CLIENT ID GETS RESET DURING REGISTRATION FAILURE AFTER APP UPGRADE<br/>
            <b>PI98535</b> DATA DOWNLOAD FROM ANALYTICS CONSOLE HAS NUMBER LIMITATION<br/>
            <b>PI98507</b> MISSING "USER ID" IN EXPORTED RECORDS WHEN EXPORTING CUSTOMCHARTS FROM WITHIN ANALYTICS CONSOLE.<br/>
            <b>PI98473</b> MEMORY LEAK DETECTED IN PINTRUSTEDCERTIFICATEPUBLICKEYFROMFILE in MFP CLIENT SDK<br/>
            <b>PI98072</b> ANALYTICS CUSTOM CHART DOWNLOAD BUTTON DOWNLOADS ONLY 10 ROWS<br/>
            <b>PI94587</b> ADDING THE ABILITY TO CONFIGURE THE TIMEOUT VALUE FOR   WLAUTHORIZATIONMANAGER.LOGIN()<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201807050331" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-mfp-devkit-IF201807050331" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201807050331"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201807050331">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201807050331.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201807050331.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201807050331.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-cordova-plugins-IF201807050331" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201807050331"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201807050331">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018070216</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore      8.0.2018070216</b><br/>
                              cordova-plugin-mfp-push            8.0.2018040410<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-tools-IF201807050331" aria-expanded="true" aria-controls="collapse-tools-IF201807050331">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201807050331">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-ios-sdk-IF201807050331" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201807050331"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201807050331">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018070209</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018070209</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-android-sdk-IF201807050331" aria-expanded="true" aria-controls="collapse-android-sdk-IF201807050331"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201807050331">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018062910</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2018062910</b><br/>
                                <b>adapter-maven-plugin              8.0.2018062907</b><br/>
                                <b>adapter-maven-archetype-sql      8.0.2018062907</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018062907</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018062907</b><br/>
                                <b>adapter-maven-api                 8.0.2018062907</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-win-sdk-IF201807050331" aria-expanded="true" aria-controls="collapse-win-sdk-IF201807050331">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201807050331">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201807050331">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201807050331" href="#collapse-xamarin-sdk-IF201807050331" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201807050331">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201807050331" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201807050331">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201806141530" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201806141530">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201806141530" href="#collapse-mfp-ifix-IF201806141530" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201806141530"><b>iFix 8.0.0.0-MFPF-IF201806141530</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201806141530">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>June 14th, 2018</b>. This iFix replaces the previous iFix *8.0.0.0-MFPF-IF201806061601*, which had to be pulled out due to stability issues.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI98568</b> COMMA APPENDED TO THE END OF THE AUTHORIZATION HEADER IN IOSONLY<br/>
            <b>PI98457</b> RE-REGISTER A IOS DEVICE USING THE MFPPUSH FAILS<br/>
            <b>PI98178</b> STRENGTHEN MFP OAUTH FLOW TO AVOID MISUSE OF REDIRECT URI AND CROSS SITE SCRIPTING<br/>
            <b>PI97687</b> SENSITIVE DATA IS RECORDED IN DEVICE LOG FOR ANDROID   APPLICATION.<br/>
            <b>PI93025</b> THE RESPONSE OF REST API(PUSH DEVICE REGISTRATIONS (GET)) DOESN'T MATCH THE DESCRIPTION IN KC.<br/>
            <b>PI93372</b> UNABLE TO SET UP CONFIDENTIAL CLIENTS WHEN THE PUSH SERVICE IS NOT DEPLOYED<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201806141530" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-mfp-devkit-IF201806141530" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201806141530"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201806141530">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201806141530.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201806141530.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201806141530.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-cordova-plugins-IF201806141530" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201806141530"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201806141530">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018060412</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore       8.0.2018060412</b><br/>
                              cordova-plugin-mfp-push            8.0.2018040410<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-tools-IF201806141530" aria-expanded="true" aria-controls="collapse-tools-IF201806141530">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201806141530">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-ios-sdk-IF201806141530" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201806141530"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201806141530">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018060112</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018060112</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-android-sdk-IF201806141530" aria-expanded="true" aria-controls="collapse-android-sdk-IF201806141530"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201806141530">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018060105</b><br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2018032914</b><br/>
                                <b>adapter-maven-plugin              8.0.2018060901</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2018060901</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018060901</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018060901</b><br/>
                                <b>adapter-maven-api                 8.0.2018060901</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-win-sdk-IF201806141530" aria-expanded="true" aria-controls="collapse-win-sdk-IF201806141530">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201806141530">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201806141530">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201806141530" href="#collapse-xamarin-sdk-IF201806141530" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201806141530">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201806141530" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201806141530">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   

 <div class="panel-group accordion" id="mfp-8.0-ifix-IF201805071746" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201805071746">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201805071746" href="#collapse-mfp-ifix-IF201805071746" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201805071746"><b>iFix 8.0.0.0-MFPF-IF201805071746</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201805071746">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>May 7th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI97298</b> MFP DEVICES (GET) API DOES NOT WORK CONSISTENTLY WHEN USING 'QUERY' PARAMETER<br/>
            <b>PI97147</b> REDOS SECURITY VULNERABILITY DISCOVERED INCORDOVA-PLUGIN-GLOBALIZATION<br/>
            <b>PI97119</b> ISSUE WITH USING CUSTOM JAVA CLASSES FROM JAVASCRIPT ADAPTER<br/>
            <b>PI94184</b> APP RUNNING ON WINDOWS 10 CANNOT RECEIVE A GZIP COMPRESSED  TRANSFER VIA HTTP<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201805071746" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-mfp-devkit-IF201805071746" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201805071746"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201805071746">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201805071746.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201805071746.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201805071746.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-cordova-plugins-IF201805071746" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201805071746"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201805071746">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018050404</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore       8.0.2018040508<br/>
                              cordova-plugin-mfp-push            8.0.2018040410<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-tools-IF201805071746" aria-expanded="true" aria-controls="collapse-tools-IF201805071746">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201805071746">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-ios-sdk-IF201805071746" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201805071746">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201805071746">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2018040422<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018031513<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-android-sdk-IF201805071746" aria-expanded="true" aria-controls="collapse-android-sdk-IF201805071746"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201805071746">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018031911<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610<br/>
                                <b>adapter-maven-plugin              8.0.2018050201</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2018050201</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018050201</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018050201</b><br/>
                                <b>adapter-maven-api                 8.0.2018050201</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-win-sdk-IF201805071746" aria-expanded="true" aria-controls="collapse-win-sdk-IF201805071746">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201805071746">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018041611<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2018041611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201805071746">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201805071746" href="#collapse-xamarin-sdk-IF201805071746" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201805071746">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201805071746" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201805071746">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>   

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201804170743" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201804170743">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201804170743" href="#collapse-mfp-ifix-IF201804170743" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201804170743"><b>iFix 8.0.0.0-MFPF-IF201804170743</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201804170743">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>April 17th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI96632</b> ADDING SUPPORT FOR FCM END-POINT<br/>
            <b>PI96588</b> SERVER INFO DOES NOT APPEAR IN THE SERVER LOG SEARCH UNDER THEANALYTICS CONSOLE<br/>
            <b>PI93139</b> DIRECT UPDATE FAILED MIGHT FAIL ON IOS DEVICE<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201804170743" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-mfp-devkit-IF201804170743" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201804170743"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201804170743">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201804170743.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201804170743.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201804170743.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-cordova-plugins-IF201804170743" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201804170743">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201804170743">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2018040508<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore       8.0.2018040508<br/>
                              cordova-plugin-mfp-push            8.0.2018040410<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-tools-IF201804170743" aria-expanded="true" aria-controls="collapse-tools-IF201804170743">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201804170743">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-ios-sdk-IF201804170743" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201804170743">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201804170743">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2018040422<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018031513<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-android-sdk-IF201804170743" aria-expanded="true" aria-controls="collapse-android-sdk-IF201804170743"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201804170743">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018031911<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610<br/>
                                <b>adapter-maven-plugin              8.0.2018031101</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2018031101</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018031101</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018031101</b><br/>
                                <b>adapter-maven-api                 8.0.2018031101</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-win-sdk-IF201804170743" aria-expanded="true" aria-controls="collapse-win-sdk-IF201804170743"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201804170743">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2018041611</b><br/>
                                <b>IBM MobileFirstPlatform Push SDK  8.0.2018041611</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201804170743">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804170743" href="#collapse-xamarin-sdk-IF201804170743" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201804170743">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201804170743" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201804170743">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>         
            </div>
        </div>      
    </div>
</div>     

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201804111321" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201804111321">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201804111321" href="#collapse-mfp-ifix-IF201804111321" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201804111321"><b>iFix 8.0.0.0-MFPF-IF201804111321</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201804111321">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>April 11th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI96635</b> APP APPEARS TO HANG WHEN MAX NUMBER OF INCORRECT CHALLENGEANSWER IS SUBMITTED.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201804111321" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-mfp-devkit-IF201804111321" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201804111321"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201804111321">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201804111321.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201804111321.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201804111321.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-cordova-plugins-IF201804111321" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201804111321">Cordova plugins</a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201804111321">
                        <div class="panel-body">
                              cordova-plugin-mfp              8.0.2018040508<br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore       8.0.2018040508<br/>
                              cordova-plugin-mfp-push            8.0.2018040410<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-tools-IF201804111321" aria-expanded="true" aria-controls="collapse-tools-IF201804111321">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201804111321">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2018040312<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-ios-sdk-IF201804111321" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201804111321"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201804111321">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018040422</b><br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018031513<br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-android-sdk-IF201804111321" aria-expanded="true" aria-controls="collapse-android-sdk-IF201804111321">Android SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201804111321">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018031911<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2018040207<br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610<br/>
                                adapter-maven-plugin              8.0.2018030101<br/>
                                adapter-maven-archetype-sql       8.0.2018030101<br/>
                                adapter-maven-archetype-java      8.0.2018030101<br/>
                                adapter-maven-archetype-http      8.0.2018030101<br/>
                                adapter-maven-api                 8.0.2018030101<br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-win-sdk-IF201804111321" aria-expanded="true" aria-controls="collapse-win-sdk-IF201804111321">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201804111321">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018030908<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201804111321">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804111321" href="#collapse-xamarin-sdk-IF201804111321" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201804111321">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201804111321" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201804111321">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>        
            </div>
        </div>      
    </div>
</div>     

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201804051553" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201804051553">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201804051553" href="#collapse-mfp-ifix-IF201804051553" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201804051553"><b>iFix 8.0.0.0-MFPF-IF201804051553</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201804051553">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>April 5th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3> Support for Cordova v8 and Cordova Android v7</h3>
            Starting from this iFix (<i>8.0.0.0-MFPF-IF201804051553</i>), MobileFirst Cordova plugins for Cordova v8 and Cordova Android v7 is supported. To work with the mentioned version of Cordova, you need to get the latest MobileFirst plugins and upgrade to the latest CLI (<i>mfpdev-cli</i>) version.
            For details on supported versions for individual platforms, refer to <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels">Adding the MobileFirst Foundation SDK to Cordova Applications</a>.

            <h3>APARs Fixed</h3>

            <b>PI95771</b> ENABLE API SETDEVICEID()<br/>
            <b>PI94658</b> ATTEMPTS TO REMOVE COOKIES IN ANDROID SDK CAUSES THE APP TO  CRASH.<br/>
            <b>PI94482</b> USERID NOT GETTING UPDATED FOR PUSH DEVICE REGISTRATION AFTER SUCCESSIVE LOGIN ATTEMPTS.<br/>
            <b>PI93999</b> OPENSSL HAS RECEIVED SECURITY UPDATES 1.0.2N AND MUST BE UPGRADED TO THE LATEST VERSION.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201804051553" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-mfp-devkit-IF201804051553" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201804051553"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201804051553">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF20180405155.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF20180405155.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF20180405155.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-cordova-plugins-IF201804051553" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201804051553"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201804051553">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018040508</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore       8.0.2018040508</b><br/>
                              <b>cordova-plugin-mfp-push            8.0.2018040410</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-tools-IF201804051553" aria-expanded="true" aria-controls="collapse-tools-IF201804051553"><b>Tools</b></a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201804051553">
                        <div class="panel-body">
                              <b>mfpdev-cli 8.0.2018040312</b><br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-ios-sdk-IF201804051553" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201804051553"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201804051553">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018031513</b><br/>
                                <b>IBMMobileFirstPlatformFoundationOpenSSLUtils   8.0.2018031513</b><br/>
                                IBMMobileFirstPlatformFoundationPush          8.0.2018022719<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-android-sdk-IF201804051553" aria-expanded="true" aria-controls="collapse-android-sdk-IF201804051553"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201804051553">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018031911</b><br/>
                                <b>ibmmobilefirstplatformfoundationpush            8.0.2018040207</b><br/>
                                ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610<br/>
                                <b>adapter-maven-plugin              8.0.2018030101</b><br/>
                                <b>adapter-maven-archetype-sql       8.0.2018030101</b><br/>
                                <b>adapter-maven-archetype-java      8.0.2018030101</b><br/>
                                <b>adapter-maven-archetype-http      8.0.2018030101</b><br/>
                                <b>adapter-maven-api                 8.0.2018030101</b><br/>
                                mfp-security-checks-base          8.0.2018030404<br/>
                                mfp-java-token-validator          8.0.2017020112<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="win-sdk-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-win-sdk-IF201804051553" aria-expanded="true" aria-controls="collapse-win-sdk-IF201804051553">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201804051553">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2018030908<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201804051553">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201804051553" href="#collapse-xamarin-sdk-IF201804051553" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201804051553">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201804051553" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201804051553">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>           
            </div>
        </div>      
    </div>
</div>     

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201803160641" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201803160641">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201803160641" href="#collapse-mfp-ifix-IF201803160641" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201803160641"><b>iFix 8.0.0.0-MFPF-IF201803160641</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201803160641">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>March 16th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI95013</b> Push All does not increment all mediators in analytics console.<br/>
            <b>PI94996</b> WLAUTHORIZATIONMANAGER API THROWS UNCLEAR ERROR WHEN THERE IS  NO INTERNET CONNECTION.<br/>
            <b>PI94653</b> REMEMBER ME EXPIRATION VALUES OF GREATER THAN 2 WEEKS RESET TO DEFAULT OF 2 WEEKS.<br/>
            <b>PI94587</b> ADDING THE ABILITY TO CONFIGURE THE TIMEOUT VALUE FOR WLAUTHORIZATIONMANAGER.LOGIN().<br/>
            <b>PI94548</b> ANDROID RESPONSE HEADER CONTENT LOST.<br/>
            <b>PI94184</b> APP RUNNING ON WINDOWS 10 CANNOT RECEIVE A GZIP COMPRESSED  TRANSFER VIA HTTP.<br/>
            <b>PI93325</b> Fix for XSS vulnerability seen for non-existent adapter procedure.<br/>
            <b>PI93148</b> APPLICATION CENTER DOES NOT PICK UP IOS NATIVE APP ICONS CORRECTLY.<br/>
            <b>PI92835</b> DIRECT UPDATE DOES NOT WORK ON ANDROID 4.4 WITH TLS 1.1/12  PROTOCOL.<br/>
            <b>PI91941</b> AFTER A BACKUP AND RESTORE VIA ICLOUD OR ITUNES ON IOS 11.X DEVICE, THE APP MIGHT BE CORRUPTED AND NEED TO BE REINSTALLED.<br/>
            <b>PI91278</b> AFTER BACKUP THEN RESTORE THROUGH ICLOUD ON TO A DIFFERENTDEVICE, LOGIN FAILS.<br/>
            <b>PI89436</b> PUSH SDK DOES NOT PICK UP THE GATEWAY CONTEXT ROOT IN CLOUD  ENVIRONMENT.<br/>
            <b>PI70186</b> WINDOWS APPS CANNOT CONNECT TO MOBILEFIRST SERVER THROUGH DATAPOWER GATEWAY CHALLENGE HANDLER.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201803160641" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-mfp-devkit-IF201803160641" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201803160641"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201803160641">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201803160641.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201803160641.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201803160641.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-cordova-plugins-IF201803160641" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201803160641"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201803160641">
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
                    <div class="panel-heading" role="tab" id="tools-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-tools-IF201803160641" aria-expanded="true" aria-controls="collapse-tools-IF201803160641">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201803160641">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2017102406<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-ios-sdk-IF201803160641" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201803160641"><b>iOS SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201803160641">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatformFoundation              8.0.2018030804</b><br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils  8.0.2017121910<br/>
                                <b>IBMMobileFirstPlatformFoundationPush          8.0.2018022719</b><br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-android-sdk-IF201803160641" aria-expanded="true" aria-controls="collapse-android-sdk-IF201803160641"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201803160641">
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
                    <div class="panel-heading" role="tab" id="win-sdk-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-win-sdk-IF201803160641" aria-expanded="true" aria-controls="collapse-win-sdk-IF201803160641"><b>Windows SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201803160641">
                        <div class="panel-body">
                                <b>IBMMobileFirstPlatform Foundation 8.0.2018030908</b><br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201803160641">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201803160641" href="#collapse-xamarin-sdk-IF201803160641" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201803160641">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201803160641" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201803160641">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>               
            </div>
        </div>      
    </div>
</div>     

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201802201451" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201802201451">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201802201451" href="#collapse-mfp-ifix-IF201802201451" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201802201451"><b>iFix 8.0.0.0-MFPF-IF201802201451</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201802201451">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>February 20th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>Automated synchronization of JSONStore collections with CouchDB databases</h3>

            Starting with this iFix, using MobileFirst Android SDK, you can automate the synchronization of data between a JSONStore Collection on a device with any flavour of CouchDB database, including <a href="https://www.ibm.com/in-en/marketplace/database-management">Cloudant</a>.
            For more information on this feature, read <a href="{{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/">this blog post</a>.

            <h3>APARs Fixed</h3>

            <b>PI92678</b> NOTIFICATION IS NOT SHOWN IN NOTIFICATION TRAY WHEN APP IS IN BACKGROUND.<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201802201451" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-mfp-devkit-IF201802201451" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201802201451"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201802201451">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201802201451.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201802201451.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201802201451.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-cordova-plugins-IF201802201451" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201802201451"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201802201451">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018021611</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              <b>cordova-plugin-mfp-jsonstore       8.0.2018021611</b><br/>
                              <b>cordova-plugin-mfp-push            8.0.2018021609</b><br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-tools-IF201802201451" aria-expanded="true" aria-controls="collapse-tools-IF201802201451">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201802201451">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2017102406<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-ios-sdk-IF201802201451" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201802201451">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201802201451">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2017121910<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils  8.0.2017121910<br/>
                                IBMMobileFirstPlatformFoundationPush         8.0.2017061612<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-android-sdk-IF201802201451" aria-expanded="true" aria-controls="collapse-android-sdk-IF201802201451"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201802201451">
                        <div class="panel-body">
                                ibmmobilefirstplatformfoundation 8.0.2018011011<br/>
                                ibmmobilefirstplatformfoundationpush            8.0.2017011813<br/>
                                <b>ibmmobilefirstplatformfoundationjsonstore       8.0.2018021610</b><br/>
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
                    <div class="panel-heading" role="tab" id="win-sdk-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-win-sdk-IF201802201451" aria-expanded="true" aria-controls="collapse-win-sdk-IF201802201451">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201802201451">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2017092012<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201802201451">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201802201451" href="#collapse-xamarin-sdk-IF201802201451" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201802201451">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201802201451" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201802201451">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>                   
            </div>
        </div>      
    </div>
</div>     

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201801301424" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201801301424">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201801301424" href="#collapse-mfp-ifix-IF201801301424" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201801301424"><b>iFix 8.0.0.0-MFPF-IF201801301424</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201801301424">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>January 30th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i>

            <h3>APARs Fixed</h3>

            <b>PI92805</b> EXPORTING NETWORK TRANSACTION DATA FAILED TO LIST ALL ADAPTERCALLS<br/>
            <b>PI92803</b> TTL MANAGER FAILED TO PURGE DATA IF TTL SET WITH 30D<br/>
            <b>PI92303</b> CROSS-SITE SCRIPTING (XSS) AND UNAUTHENTICATED ACCESS TO BUSINESS APPLICATION FILES<br/>
            <b>PI92168</b> UPLOADING APK FILE TO APPLICATION CENTER FAILS WITH NULLPOINTEREXCEPTION IN LOG<br/>
            <b>PI92043</b> LOGIN_IN_PROGRESS ERROR IS THROWN WHEN THE APP IS UNREGISTERED AND LOGOUT API CALLED BEFORE LOGIN<br/>
            <b>PI91471</b> HANDLEOPENURL() NOT WORK PROPERLY IN IOS<br/>
            <b>PI90760</b> THE ANDROID:MAXSDKVERSION VALUE IS OVERWRITTEN WHEN AN ANDROID APPLICATION IS BUILT<br/>
            <b>PI90122</b> HTTPS CLIENT CONNECT REQUEST TO SERVER RETURNS OAUTH COMPLIANT 302, BUT WITH HTTP URL<br/>
            <b>PI89372</b> The performance of JSONStore find has become severely degraded after applying an ifix.<br/>
            <b>PI86996</b> SET OFFSET IN PAGINATION IN ANDROID THROWING ERRORS<br/>

            <h2>How to upgrade</h2>
            <b>Server</b>
            To upgrade, download &amp; install the <a href="{{site.baseurl}}/downloads/">Developer Kit for evaluators</a>, <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">Developer Kit for customers / iFix package for on-prem production environment</a>(requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

            <b>Client SDKs</b>
            To upgrade, <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/">run the upgrade commands for your platform</a>.


            <h2> Individual artifact build numbers in this iFix</h2>
            <i>The artifacts updated in the iFix are emphasized.</i>

            <div class="panel-group accordion" id="mfp-component-builds-IF201801301424" role="tablist">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="mfp-devkit-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-mfp-devkit-IF201801301424" aria-expanded="true" aria-controls="collapse-mfp-devkit-IF201801301424"><b>MobileFirst DevKit</b></a>
                        </h4>
                    </div>
                    <div id="collapse-mfp-devkit-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-devkit-IF201801301424">
                        <div class="panel-body">
                              <b>8.0.0.0-MFPF-DevKit-Linux-IF201801301424.bin</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-MacOSX-IF201801301424.zip</b><br/>
                              <b>8.0.0.0-MFPF-DevKit-Windows-IF201801301424.exe</b><br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="cordova-plugins-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-cordova-plugins-IF201801301424" aria-expanded="true" aria-controls="collapse-cordova-plugins-IF201801301424"><b>Cordova plugins</b></a>
                        </h4>
                    </div>
                    <div id="collapse-cordova-plugins-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="cordova-plugins-IF201801301424">
                        <div class="panel-body">
                              <b>cordova-plugin-mfp              8.0.2018012409</b><br/>
                              cordova-plugin-mfp-encrypt-utils   8.0.2017021815<br/>
                              cordova-plugin-mfp-fips            8.0.2017090705<br/>
                              cordova-plugin-mfp-jsonstore       8.0.2017090705<br/>
                              cordova-plugin-mfp-push            8.0.2017082110<br/>
                              cordova-template-mfp               8.0.2017060206<br/>
                              ibm-mfp-web-sdk                    8.0.2017082310<br/>
                              passport-mfp-token-validation      8.0.2017010917<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="tools-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-tools-IF201801301424" aria-expanded="true" aria-controls="collapse-tools-IF201801301424">Tools</a>
                        </h4>
                    </div>
                    <div id="collapse-tools-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="tools-IF201801301424">
                        <div class="panel-body">
                              mfpdev-cli 8.0.2017102406<br/>
                              mfpmigrate-cli 8.0.20171211072611<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="ios-sdk-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-ios-sdk-IF201801301424" aria-expanded="true" aria-controls="collapse-ios-sdk-IF201801301424">iOS SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-ios-sdk-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk-IF201801301424">
                        <div class="panel-body">
                                IBMMobileFirstPlatformFoundation              8.0.2017121910<br/>
                                IBMMobileFirstPlatformFoundationOpenSSLUtils  8.0.2017121910<br/>
                                IBMMobileFirstPlatformFoundationPush         8.0.2017061612<br/>
                                IBMMobileFirstPlatformFoundationJSONStore    8.0.2017053010<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="android-sdk-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-android-sdk-IF201801301424" aria-expanded="true" aria-controls="collapse-android-sdk-IF201801301424"><b>Android SDK</b></a>
                        </h4>
                    </div>
                    <div id="collapse-android-sdk-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk-IF201801301424">
                        <div class="panel-body">
                                <b>ibmmobilefirstplatformfoundation 8.0.2018011011</b><br/>
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
                    <div class="panel-heading" role="tab" id="win-sdk-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-win-sdk-IF201801301424" aria-expanded="true" aria-controls="collapse-win-sdk-IF201801301424">Windows SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-win-sdk-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk-IF201801301424">
                        <div class="panel-body">
                                IBMMobileFirstPlatform Foundation 8.0.2017092012<br/>
                                IBM MobileFirstPlatform Push SDK  8.0.2017012419<br/>
                        </div>
                    </div>      
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="xamarin-sdk-IF201801301424">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#mfp-component-builds-IF201801301424" href="#collapse-xamarin-sdk-IF201801301424" aria-expanded="true" aria-controls="collapse-xamarin-sdk-IF201801301424">Xamarin SDK</a>
                        </h4>
                    </div>
                    <div id="collapse-xamarin-sdk-IF201801301424" class="panel-collapse collapse" role="tabpanel" aria-labelledby="xamarin-sdk-IF201801301424">
                        <div class="panel-body">
                                IBMMobileFirstPlatform SDK 8.0.2017051208<br/>
                        </div>
                    </div>      
                </div>
            </div>                  
            </div>
        </div>      
    </div>
</div>    
