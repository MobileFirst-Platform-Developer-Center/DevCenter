---
title: MobileFirst Foundation iFix release information for 8.0
date: 2018-05-18
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
- iFix
- All_8.0_iFixes
pinned: true
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix *8.0.0.0-MFPF-IF201809041150*  released for MobileFirst Foundation 8.0, dated **September 4th, 2018**.
<br/>

<div class="panel-group accordion" id="mfp-8.0-ifix-IF201809041150" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-ifix-IF201809041150">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-8.0-ifix-IF201809041150" href="#collapse-mfp-ifix-IF201809041150" aria-expanded="true" aria-controls="collapse-mfp-ifix-IF201809041150"><b>iFix 8.0.0.0-MFPF-IF201809041150</b> <span class="label label-primary">latest</span></a>
            </h4>
        </div>
        <div id="collapse-mfp-ifix-IF201809041150" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-ifix-IF201809041150">
            <div class="panel-body">
            iFix for MobileFirst Foundation 8.0, dated <b>September 4th, 2018</b>.
            <h2>Changes in this iFix</h2>
            <i>For a cumulative list of all previous fixes, see the <a href="http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc">iFix download page on IBM Fix Central</a>.</i><br/><br/>

            <blockquote>This iFix includes a change to remove <i>libstdc++</i> as a dependency to Cordova projects. This is required for new apps running on iOS 12. For further details, refer to <a href="https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/">this blog post</a>.</blockquote>

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

## Previous iFixes for MobileFirst Foundation 8.0

IFixes for MobileFirst Foundation 8.0 that was released earlier is listed here.<br/>
*List below includes iFixes released in 2018 only.*

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
