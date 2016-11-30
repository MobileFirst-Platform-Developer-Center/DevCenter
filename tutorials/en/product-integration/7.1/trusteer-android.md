---
layout: tutorial
title: Trusteer for Android
relevantTo: [android]
downloads:
  - name: Native Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrusteerAndroid/tree/release71
  - name: MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/TrusteerIntegration/tree/release71
---
### Overview
Trusteer Mobile SDK collects multiple mobile device risk factors and provides them to the mobile app, enabling organizations to restrict mobile app functionality based on risk levels. In your IBM MobileFirst Platform Foundation application, you may want to protect access to some specific resources or procedures based risk levels, such as detected malware or whether the device is jailbroken or rooted. For example, you could prevent a malware-ridden device from logging into your banking app, and prevent rooted devices from using the “transfer funds” feature.

### Obtain Trusteer SDK for Android
To use Trusteer within an IBM MobileFirst Platform Foundation application, you first need to separately obtain the Trusteer SDK, license information, required libraries and manifest files.
See Trusteer documentation or contact Trusteer support if you are missing any of those items.

You may receive those items either as separate files, or as an MobileFirst Application Component (WLC).
You still need to follow these steps if you use a WLC file.

### Install Trusteer SDK
If you’ve received an Application Component from Trusteer, search the IBM MobileFirst documentation for “Adding application components to MobileFirst projects”. Then make sure the file “**tas.license**” contains your license information.

If you’ve received the Trusteer SDK, follow the Trusteer documentation to add the Trusteer SDK to your Android project. Make sure you have the “**tas.license**” file in your “**assets**” folder. Its format should be:

{% highlight bash %}
vendorId=com.mycompany
clientId=my.client.id
clientKey=YMAQAABNFUWS2L
{% endhighlight %}

### Initialize the Trusteer Mobile SDK
By default, the Trusteer Mobile SDK is initialized automatically when you integrate the SDK into a MobileFirst project. However, to provide more flexibility and eliminate potential initialization failure, it is recommended that you disable the automatic SDK initialization and instead initialize the SDK manually:

-	Disable the automatic initialization of the Trusteer Mobile SDK by setting the `TRUSTEER_AUTO_INIT` property in your client properties file ([**wlclient.properties**](../../../foundation/7.1/hello-world/configuring-a-native-android-application-with-the-mfp-sdk/#wlclient-properties))  to `false`:
	```
	TRUSTEER_AUTO_INIT=false
	```
- 	Manually initialize the SDK. You can do this either by using the Trusteer Mobile SDK according to the Trusteer documentation, or by using the MobileFirst Trusteer API from your application's native Android code or hybrid JavaScript code:
	-	In your native Android code, call the `createInstance` method of the [`WLTrusteer`](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/WLTrusteer.html) class (where context refers to your Android context):
		```
		WLTrusteer.createInstance(context);
		```
	- 	In your hybrid JavaScript code, call the `init` method of the [`WL.Trusteer`](http://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Trusteer.html) class:
		```
		WL.Trusteer.init(onSucess,onFailure);
		```

### Access Risk Items in JavaScript
Optionally, you can access the client-side generated Trusteer data object using the following API:

{% highlight javascript linenos %}
WL.Trusteer.getRiskAssessment(onSuccess, onFailure);
{% endhighlight %}

Where <code>onSuccess</code> is a function that will receive a <code>JSON</code> object containing all the data processed by Trusteer. See Trusteer documentation to get information on each risk item.

{% highlight javascript linenos %}
function onSuccess(result) {
  //See in the logs what the full result looks like
  WL.Logger.debug(JSON.stringify(result));
  //Check for a specific flag
  if (result["os.rooted"]["value"] != 0) {
    alert("This device is jailbroken!");
  }
}
{% endhighlight %}

### Access Risk Items in Java
Optionally, you can access the client-side generated Trusteer data object using the following API:

{% highlight java linenos %}
WLTrusteer trusteer = WLTrusteer.getInstance();
JSONObject risks = trusteer.getRiskAssessment();
{% endhighlight %}

This returns an <code>JSONObject</code> of all the data processed by Truster. See Trusteer documentation to get information on each risk item.

{% highlight java linenos %}
JSONObject rooted = (JSONObject) risks.get("os.rooted");
if(rooted.getInt("value") > 0){
	//device is rooted
}
{% endhighlight %}

### Authentication Config
To prevent access to specific resources when a device is at risk, you can protect your adapter procedures or your applications with a custom security test containing a Trusteer realm. See MobileFirst documentation for general information on security tests and realms.

The Trusteer realm will check the data generated by the Trusteer SDK and allow/reject the request based on the parameters you set.

Here is an example of a Trusteer realm and login module you can add to your **authenticationConfig.xml**.

{% highlight xml linenos %}
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
{% endhighlight %}

{% highlight xml linenos %}
<loginModules>
  ...
  <loginModule name="trusteerFraudDetectionLogin">
    <className>
      com.worklight.core.auth.ext.TrusteerLoginModule
    </className>
  </loginModule>
</loginModules>
{% endhighlight %}

This realm contains 5 parameters:

* rooted-device - indicates whether the device is rooted (android) or jailbroken (iOS)
* device-with-malware  - indicates whether the device contains malware
* rooted-hiders - indicate that the device contains root hiders applications that hides the fact that the device is rooted/jailbroken
* unsecured-wifi - indicates that the device is currently connected to an insecure wifi
* outdated-configuration - indicates that Trusteer SDK  configuration hasn't updated for some time (didn't connect to the Trusteer server)

The possible values are <code>block</code>, <code>alert</code> or <code>accept</code>.

### JavaScript Challenge Handler
Assuming you’ve added a Trusteer realm to your server’s authentication configuration file, you can register a challenge handler to receive the responses from the authenticator.

{% highlight javascript linenos %}
var trusteerChallengeHandler = WL.Client.createWLChallengeHandler("wl_basicTrusteerFraudDetectionRealm");
{% endhighlight %}

Notice that you are registering a <code>WLChallengeHandler</code> and not a <code>ChallengeHandler</code>. See IBM MobileFirst documentation on <code>WLChallengeHandler</code>.

If you have set one of your realm options to <code>block</code>, a blocking event will trigger <code>handleFailure</code>.

{% highlight javascript linenos %}
trusteerChallengeHandler.handleFailure = function(error) {
      WL.SimpleDialog.show("Error", "Operation failed. Please contact customer support (reason code: " + error.reason + ")",  [{text:"OK"}]);
};
{% endhighlight %}

<code>error.reason</code> can be one of the following:
<ul>
	<li><code>TAS_ROOT</code></li>
	<li><code>TAS_ROOT_EVIDENCE</code></li>
 	<li><code>TAS_MALWARE</code></li>
	<li><code>TAS_WIFI</code></li>
	<li><code>TAS_OUTDATED</code></li>
	<li><code>TAS_INVALID_HEADER</code></li>
	<li><code>TAS_NO_HEADER</code></li>
</ul>

If your have set one of your realm options to alert, you can catch the alert event by implementing the <code>processSuccess</code> method.

{% highlight javascript linenos %}
trusteerChallengeHandler.processSuccess = function(identity) {
  var alerts = identity.attributes.alerts; //Array of alerts codes
  if (alerts.length > 0) {
    WL.SimpleDialog.show("Warning", "Please note that your device is: " + alerts, [{
      text: "OK "
    }]);
  }
};
{% endhighlight %}

### Native Challenge Handler
Assuming you’ve added a Trusteer realm to your server’s authentication configuration file, you can register a challenge handler to receive the responses from the authenticator.

Create a class that extends <code>WLChallengeHandler</code>:

{% highlight java linenos %}
public class TrusteerChallengeHandler extends WLChallengeHandler{
//...
}
{% endhighlight %}

In your application code, register your newly created challenge handler for your Trusteer realm:

{% highlight java linenos %}
WLClient.getInstance().registerChallenge(
  new TrusteerChallengeHandler("wl_basicTrusteerFraudDetectionRealm");
);
{% endhighlight %}

If you have set one of your realm options to block, a blocking event will trigger <code>handleFailure</code>.

{% highlight java linenos %}
public class TrusteerChallengeHandler extends WLChallengeHandler {
//...
  public void handleFailure(JSONObject error){
      String errorReason = error.getString("reason");
      //Show user that the request was denied.
  }
//...
}
{% endhighlight %}

<code>error.reason</code> can be one of the following:
<ul>
	<li><code>TAS_ROOT</code></li>
	<li><code>TAS_ROOT_EVIDENCE</code></li>
 	<li><code>TAS_MALWARE</code></li>
	<li><code>TAS_WIFI</code></li>
	<li><code>TAS_OUTDATED</code></li>
	<li><code>TAS_INVALID_HEADER</code></li>
	<li><code>TAS_NO_HEADER</code></li>
</ul>

If your have set one of your realm options to alert, you can catch the alert event by implementing the <code>handleSuccess</code> method.

{% highlight java linenos %}
public class TrusteerChallengeHandler extends WLChallengeHandler{
//…
  public void handleSuccess(JSONObject identity){
    JSONArray alerts = identity.getJSONObject(“attributes”).getJSONArray(“alerts”);

  	if(alerts.length() > 0) {
  		//Alert the user of potential issues.
  	}
  }
//...
}
{% endhighlight %}

### Sample application
<a href="https://github.com/MobileFirst-Platform-Developer-Center/TrusteerIntegration/tree/release71" target="_blank">Click to download</a> the MobileFirst project.  
<a href="https://github.com/MobileFirst-Platform-Developer-Center/TrusteerAndroid/tree/release71" target="_blank">Click to download</a> the Native Android project.


#### Sample Setup
Download the TrusteerIntegrationProject.
Import it into your MobileFirst Studio workspace.
For pure native, download and import TrusteerAndroidNativeProject as well (update **wlclient.properties** with your IP address)
Install the Trusteer SDK into your application(s) following the steps explained previously.
Deploy and run it on your Android device.

The sample will display whether or not it successfully loaded the Trusteer SDK.
It will display whether your device is rooted or not.
It features a button to “**get sensitive data**”, which invokes a dummy procedure protected by a Trusteer realm.
Depending on the state of your device, you should see “**this is sensitive data**”, or an error explaining why your request was rejected.
