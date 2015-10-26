---
layout: tutorial
title: Trusteer for iOS
---

Trusteer Mobile SDK collects multiple mobile device risk factors and provides them to the mobile app, enabling organizations to restrict mobile app functionality based on risk levels. In your IBM MobileFirst Platform Foundation application, you may want
to protect access to some specific resources or procedures based risk levels, such as detected malware or whether the device is jailbroken or rooted. For example, you could prevent a malware-ridden device from logging into your banking app, and prevent
rooted devices from using the “transfer funds” feature.

<h2>Obtain Trusteer SDK for iOS</h2>
Before starting make sure you have the following items:
<ul>
    <li>Trusteer Mobile iOS library (libtas_full.a)</li>

    <li>A MobileFirst-compatible Trusteer license file (tas.license)</li>

    <li>A Trusteer configuration package (default_conf.rpkg)</li>

    <li>A Trusteer Application Security Manifest (manifest.rpkg)</li>
</ul>

See Trusteer documentation or contact Trusteer support if you are missing any of those items. You may receive those items either as standalone files, or as an MobileFirst Application Component. To learn more about installing an MobileFirst Application
Component (*.WLC) see MobileFirst documentation.
<strong>Note:</strong> You still need to follow the following steps if you use a WLC file.

<h2>Copy Files Into XCode Project</h2>
Create a directory on your system called “tas” containing the 4 above files. If you’ve installed Trusteer as an Application Component, this folder will be created for you in the native folder. In your XCode project (whether MobileFirst-generated Hybrid,
or your own using MobileFirst Native API), drag the folder created above onto your project navigator. Check “Copy items into destination group’s folder (if needed)”. Select “Create folder references for any added folders”. Make sure your target is
selected.

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/trusteer-drag-ios.png">
    <img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/trusteer-drag-ios.png" alt="trusteer-drag-ios" width="926" height="559" class="aligncenter size-full wp-image-8188" />
</a>

Drag the “
<strong>tas.license</strong>” file from the tas folder into the “
<strong>Resources</strong>” folder. Make sure the file contains your license information. The format of the file should be: [code] vendorId=com.mycompany clientId=my.client.id clientKey=YMAQAABNFUWS2L [/code]

<h2>Link Trusteer Libraries</h2>
In
<strong>Build Phases > Link Binary With Libraries</strong>, drag and drop
<strong>libtas_full.a</strong> to link your project with the Trusteer library.
<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/trusteer-build-phases.png">
    <img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/05/trusteer-build-phases.png" alt="trusteer-build-phases" width="656" height="290" class="aligncenter size-full wp-image-11889" />
</a>

In
<strong>Build Settings > Linking > Other Linker Flags</strong>, add:
<code>-force_load "$(SRCROOT)/tas/libtas_full.a"</code>.
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/TR_IOS_forceload.png">
    <img src="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/TR_IOS_forceload.png" alt="TR_IOS_forceload" width="594" height="132" class="aligncenter size-full wp-image-1348" />
</a>

In
<strong>Build Settings > Linking > Dead Code Stripping</strong>, select
<code>NO</code>.
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/TR_IOS_deadcode.png">
    <img src="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/10/TR_IOS_deadcode.png" alt="TR_IOS_deadcode" width="480" height="108" class="aligncenter size-full wp-image-1349" />
</a>

<strong>Note :</strong> If the iOS project is native, please follow the standard MobileFirst native requirements are described in the MobileFirst documentation as well as the requirements described in the Trusteer documentation. For example, Trusteer requires
CoreMotion.framework in addition to MobileFirst's standard requirements.

<h2>Access Risk Items in JavaScript</h2>
Optionally, you can access the client-side generated Trusteer data object using the following API: [code lang="javascript"] WL.Trusteer.getRiskAssessment(onSuccess, onFailure); [/code] Where onSuccess is a function that will receive a
<code>JSON</code> object containing all the data processed by Trusteer. See Trusteer documentation to get information on each risk item. [code lang="javascript"] function onSuccess(result) { //See in the logs what the full result looks like WL.Logger.debug(JSON.stringify(result));
//Check for a specific flag if (result["os.rooted"]["value"] != 0) { alert("This device is jailbroken!"); } } [/code]

<h2>Access Risk Items in Objective-C</h2>
Optionally, you can access the client-side generated Trusteer data object using the following API: [code lang="obj-c"] NSDictionary* risks =[[WLTrusteer sharedInstance] riskAssessment]; [/code] This returns an
<code>NSDictionary</code> of all the data processed by Truster. See Trusteer documentation to get information on each risk item. [code lang="obj-c"] //See in the logs what the full result looks like NSLog(@"%@",risks); //Check for a specific flag NSNumber*
rooted = [[risks objectForKey:@"os.rooted"] objectForKey:@"value"]; if([rooted intValue]!= 0){ NSLog(@"Device is jailbroken!"); } [/code]

<h2>Authentication Config</h2>
To prevent access to specific resources when a device is at risk, you can protect your adapter procedures or your applications with a custom security test containing a Trusteer realm. See MobileFirst documentation for general information on security tests
and realms. The Trusteer realm will check the data generated by the Trusteer SDK and allow/reject the request based on the parameters you set. Here is an example of a Trusteer realm and login module you can add to your
<strong>authenticationConfig.xml</strong>. [code lang="xml"]
<realms>
    ...
    <realm name="wl_basicTrusteerFraudDetectionRealm" loginModule="trusteerFraudDetectionLogin">
        <className>
            com.worklight.core.auth.ext.TrusteerAuthenticator
        </className>
        <parameter name="rooted-device" value="block" />
        <parameter name="device-with-malware" value="block" />
        <parameter name="rooted-hiders" value="block" />
        <parameter name="unsecured-wifi" value="alert" />
        <parameter name="outdated-configuration" value="alert" />
    </realm>
</realms>
[/code] [code lang="xml"]
<loginModules>
    ...
    <loginModule name="trusteerFraudDetectionLogin">
        <className>
            com.worklight.core.auth.ext.TrusteerLoginModule
        </className>
    </loginModule>
</loginModules>
[/code] This realm contains 5 parameters:
<ul>
    <li>
        <strong>rooted-device</strong> - indicates whether the device is rooted (android) or jailbroken (iOS)</li>

    <li>
        <strong>device-with-malware</strong> - indicates whether the device contains malware</li>

    <li>
        <strong>rooted-hiders</strong> - indicate that the device contains root hiders applications that hides the fact that the device is rooted/jailbroken</li>

    <li>
        <strong>unsecured-wifi</strong> - indicates that the device is currently connected to an insecure wifi.</li>

    <li>
        <strong>outdated-configuration</strong> - indicates that Trusteer SDK configuration hasn't updated for some time (didn't connect to the Trusteer server).</li>

</ul>
The possible values are
<code>block</code>,
<code>alert</code> or
<code>accept</code>.

<h2>JavaScript Challenge Handler</h2>
Assuming you’ve added a Trusteer realm to your server’s authentication configuration file, you can register a challenge handler to receive the responses from the authenticator. [code lang="javascript"] var trusteerChallengeHandler = WL.Client.createWLChallengeHandler("wl_basicTrusteerFraudDetectionRealm");
[/code] Notice that you are registering a
<code>WLChallengeHandler</code> and not a
<code>ChallengeHandler</code>. See IBM MobileFirst documentation on
<code>WLChallengeHandler</code>. If you have set one of your realm options to
<code>block</code>, a blocking event will trigger
<code>handleFailure</code>. [code lang="javascript"] trusteerChallengeHandler.handleFailure = function(error) { WL.SimpleDialog.show("Error", "Operation failed. Please contact customer support (reason code: " + error.reason + ")", [{text:"OK"}]); }; [/code]
<strong>
    <code>error.reason</code>
</strong> can be one of the following:
<ul>
    <li>
        <code>TAS_ROOT</code>
    </li>
    <li>
        <code>TAS_ROOT_EVIDENCE</code>
    </li>
    <li>
        <code>TAS_MALWARE</code>
    </li>
    <li>
        <code>TAS_WIFI</code>
    </li>
    <li>
        <code>TAS_OUTDATED</code>
    </li>
    <li>
        <code>TAS_INVALID_HEADER</code>
    </li>
    <li>
        <code>TAS_NO_HEADER</code>
    </li>
</ul>

If your have set one of your realm options to alert, you can catch the alert event by implementing the
<code>processSuccess</code> method. [code lang="javascript"] trusteerChallengeHandler.processSuccess = function(identity) { var alerts = identity.attributes.alerts; //Array of alerts codes if (alerts.length > 0) { WL.SimpleDialog.show("Warning", "Please
note that your device is: " + alerts, [{ text: "OK " }]); } }; [/code]

<h2>Native Challenge Handler</h2>
Assuming you’ve added a Trusteer realm to your server’s authentication configuration file, you can register a challenge handler to receive the responses from the authenticator. Create a class that extends
<code>WLChallengeHandler</code>: [code lang="obj-c"] @interface TrusteerChallengeHandler : WLChallengeHandler @end [/code] Register your newly created challenge handler for your Trusteer realm: [code lang="obj-c"] [[WLClient sharedInstance] registerChallengeHandler:[[TrusteerChallengeHandler
alloc] initWithRealm:@"wl_basicTrusteerFraudDetectionRealm"]]; [/code] If you have set one of your realm options to
<code>block</code>, a blocking event will trigger
<code>handleFailure</code>. [code lang="obj-c"] @implementation TrusteerChallengeHandler //... -(void) handleFailure: (NSDictionary *)failure { NSLog(@"Your request could not be completed. Reason code: %@",failure[@"reason"]); } //... @end [/code]

<strong>
    <code>error.reason</code>
</strong> can be one of the following:
<ul>
    <li>
        <code>TAS_ROOT</code>
    </li>
    <li>
        <code>TAS_ROOT_EVIDENCE</code>
    </li>
    <li>
        <code>TAS_MALWARE</code>
    </li>
    <li>
        <code>TAS_WIFI</code>
    </li>
    <li>
        <code>TAS_OUTDATED</code>
    </li>
    <li>
        <code>TAS_INVALID_HEADER</code>
    </li>
    <li>
        <code>TAS_NO_HEADER</code>
    </li>
</ul>

If your have set one of your realm options to
<code>alert</code>, you can catch the alert event by implementing the
<code>handleSuccess</code> method. [code lang="obj-c"] @implementation TrusteerChallengeHandler //... -(void) handleSuccess:(NSDictionary *)success{ NSArray* alerts = success[@"attributes"][@"alerts"]; if(alerts && alerts.count){ for(NSString* alert in
alerts){ NSLog(@"This device is %@", alert); } } } //... @end [/code]

<h2>Sample application</h2>
<a href="https://github.ibm.com/MFPSamples/TrusteerObjC" target="_blank">Click to download</a> the MobileFirst project.


<h3>Sample Setup</h3>
Download the
<strong>TrusteerIntegrationProject</strong>. Import it into your IBM MobileFirst Studio workspace. For pure native, download and open
<strong>TrusteeriOSNativeProject</strong> as well (update worklight.plist with your IP address). Install the Trusteer SDK into your application(s) following the steps explained previously. Deploy and run it on your iOS device. The sample will display whether
or not it successfully loaded the Trusteer SDK. It will display whether your device is jailbroken or not. It features a button to “get sensitive data”, which invokes a dummy procedure protected by a Trusteer realm. Depending on the state of your device,
you should see “this is sensitive data”, or an error explaining why your request was rejected.
