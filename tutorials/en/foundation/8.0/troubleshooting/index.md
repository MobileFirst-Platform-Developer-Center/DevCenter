---
layout: tutorial
title: Troubleshooting
weight: 14
---
## Overview
Find below answers for frequantly asked questions about problems you may encounter.

#### Jump to
* [Notifications](#notifications)
* [Analytics](#analytics)

## Notifications
<div class="panel panel-default">
  <div class="panel-heading"><h4>How does the Push service treats various “failed to deliver” notification situations?</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>If the response from the GCM is "internal server error" or "GCM service is unavialable" then an attempt is made to resend the notification. The frequncy of attempts is determined based on the value of the "Retry-After".</li>
        <li>GCM is not reachable - an error is printed in the <b>trace.log</b> file and the message sending will not be  re-sent.</li>
        <li>GCM is reachable but failures were received
            <ul>
                <li>Not registered / invalid id / mismatch id / registration missing - likely to have been caused by an invalid usage of the device ID or registration of the app in GCM. The davice ID is deleted from the database in order to avoid stale data in the database. A notification is not resent.</li>
                <li>The message is too big - the message sending is not retryed and a log is recorded in the <b>trace.log</b> file.</li>
                <li>Error code 401 - likley due to authentication error, the message sending is not retryed and a log is recorded in the <b>trace.log</b> file.</li>
                <li>Error codes 400 or 403 - the message sending is not retryed and a log is recorded in the <b>trace.log</b> file.</li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>For APNS, a retry attempt is made if the APNS connection is closed. There will be three attempts to establish a connection with APNS. For other cases no retry attempt is made.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>I get errors related to "apns-environment" in Xcode</h4></div>
  <div class="panel-body">
    <p>Verify the provisioning profile used to sign the application has the Push capability enabled. This can be verified in the App ID's settings page in the Apple Developer Portal.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>There are Java socket exceptions in the logs when dispatching an APNS notifications and the notification never reaches the device</h4></div>
  <div class="panel-body">
    <p>APNS requires persistent socket connections between the MobileFirst Server and the APNS service. The Push service  assumes there is an open socket and tries to send the notification out. Many times though, a customer's firewall may be configured to close unused sockets (push might not be frequently used). Such abrupt socket closures cannot be found by either end point – because normal Socket closures happen with either end point sending the signal and the other acknowledging. When the Push service dispatch is attempted over a closed socket, the logs will show socket exceptions.</p>
    
    <p>To avoid, either ensure a firewall rules do not close APNS sockets, or use the `push.apns.connectionIdleTimeout` <a href="../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">JNDI property of the Push service</a>. By configuring this property, the server will gracefully close the socket used for APNS push notifications within a given timeout (less than the firewall timeout for sockets). This way, a customer can close sockets before it is abruptly shut down by the firewall.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>There are SOCKS-related errors when sending a push notification to iOS devices</h4></div>
  <div class="panel-body">
    <p>For example: <blockquote>java.net.SocketException: Malformed reply from SOCKS serverat java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    APNS notifications are sent over TCP sockets. This brings in the restriction that the proxy used for APNS notifications should support TCP sockets. A normal HTTP proxy (which works for GCM) does not suffice here. For this reason, the only proxy supported in case of APNS notifications is a SOCKS proxy. SOCKS protocol version 4 or 5 is supported. The exception is thrown when JNDI properties are configured to direct APNS notifications via a SOCKS proxy, but the proxy is either not configured, offline / not available, or blocks traffic. A customer should verify their SOCKS proxy is available and working.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>A notification was sent, but never reached the device</h4></div>
  <div class="panel-body">
    <p>Notifications can be instantaneous or may be delayed. The delay might be a few seconds to a few minutes. There are various reasons that can be accounted for:</p>
    <ul>
        <li>MobileFirst Server has no control over the notification once it has reached the mediator service.</li>
        <li>The device’s network or online status (device on /off) needs to be accounted for.</li>
        <li>Check if firewalls or proxies are used and if used, that they are not configured to block the communication to the mediator (and back).</li>
        <li>Do not selectively whitelist IPs in your firewall for the GCM/APNS/WNS mediators instead of using the actual mediators URLs. This can lead to issues, as the mediator URL may resolve to any IP. Customers should allow access to the URL and not the IP. Note that ensuring mediator connectivity by telnetting to the mediator URL does not always provide the complete picture. Specifically for iOS, this only proves outbound connectivity. The actual sending is done over TCP sockets which telnet does not guarantee. by allowing only specific IP address the following may occur, for example For GCM: <blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>In iOS, some notifications arrive to the device but some don’t</h4></div>
  <div class="panel-body">
    <p>Apple's QoS defines what is called <b>coalescing notifications</b>. What this means is that the APNS server will only maintain 1 notification in their server if it cannot be immediately delivered to a device (identified via a token). For example, if 5 notifications are dispatched one after the other. If the device is on a shaky network, then if the first one was delivered and the second one is stored by APNS server temporarily. By then the 3rd notification has been dispatched and reaches APNS server. Now, the earlier (undelivered) 2nd notification is discarded and the 3rd (and latest one) is stored. To the end user this manifests as missing notifications.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>In Android, notifications are available only if the app is running and in the foreground</h4></div>
  <div class="panel-body">
    <p>... If the application is not running, or when the application is in the background, tapping on the notification in the notification shade does not launch the application. This may be because the  <b>app_name</b> field in the <b>strings.xml</b> file was changed to a custom name. This causes a mismatch in the application name and the intent action defined in the <b>AndroidManifest.xml</b> file.  If a different name for the application is required, the <b>app_label</b> field should be used instead, or use custom definitions in the <b>strings.xml</b> file.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>The Push service is shown as Inactive in the MobileFirst Operations Console</h4></div>
  <div class="panel-body">
    <p>The Push service is shown as Inactive despite its .war file deployed and the <code>mfp.push.authorization.server.url</code>, and <code>secret</code> are configured correctly in the <b>server.xml</b> file.</p>
    <p>Verify that the server's JNDI properties are set correctly for the MFP Admin service. It should contain the following as an example:

{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value='"http://localhost:9080/imfpush"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.server.url" value='"http://localhost:9080/mfp"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.id" value='"push-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.secret" value='"pushSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.id" value='"admin-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.secret" value='"adminSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.password" value='"{xor}DCs+LStubWw="'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.user" value='"configUser"'/>
{% endhighlight %}
  </div>
</div>

## Analytics
<div class="panel panel-default">
  <div class="panel-heading"><h4>There is no data in the analytics console</h4></div>
  <div class="panel-body">
  <p>Check the following possibilities.</p>
  <ul>
    <li>Verify that your apps are set to point to the MobileFirst Server, which forwards the logs to the MobileFirst Analytics Server. Ensure that the following values are set in the <code>mfpclient.plist</code> (iOS),  <code>mfpclient.properties</code> (Android), or <code>config.xml</code> (Cordova) files.

{% highlight xml %}
protocol = http or https
host = the IP address of your MobileFirst Server
port = the HTTP port that is set in the server.xml file for reporting analytics
wlServerContext = by default "/mfp/"
{% endhighlight %}</li>

    <li>Ensure that your MobileFirst Server is pointing to your MobileFirst Analytics Server.

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>Check that you are calling the send method.
        <ul>
            <li>iOS:
                <ul>
                    <li>Objective-C: <code>[[WLAnalytics sharedInstance] send];</code></li>
                    <li>Swift:  <code>WLAnalytics.sharedInstance().send()</code></li>
                    <li>Android: <code>WLAnalytics.send();</code></li>
                    <li>Cordova: <code>WL.Analytics.send();</code></li>
                    <li>Web: <code>ibmmfpfanalytics.send();</code></li>
                </ul>
            </li>
        </ul>
    </li>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Why is there crash data in the Crash Overview table, but nothing in the Crash Summary table?</h4></div>
  <div class="panel-body">
    <p>The crash logs must be sent to the server once the app is again running. Verify that your apps are sending logs after a crash. To be safe, send logs on app start-up to ensure that any previously unsent information is reported.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Why is there no data in the Server Usage Flow graph or the Network Request graph?</h4></div>
  <div class="panel-body">
    <p>Configure your apps to collect analytics on the Network device event.</p>
    
{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>For cross-platform apps that use Cordova, follow the iOS or Android guides, as the configurations are the same as for native apps.</li>
        <li>To enable the capture of network analytic data in iOS, add the following code in your Application Delegate <code>application:didFinishLaunchingWithOptions</code> method.<br/>
        
        <b>Objective-C</b>

{% highlight objc %}
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:NETWORK];
{% endhighlight %}

        <b>Swift</b>

{% highlight swift %}
WLAnalytics.sharedInstance()
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK)
{% endhighlight %}

        <li>To enable the capture of network analytic data in Android, add the following code in your Application subclass <code>onCreate</code> method.<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Why is there no data for app sessions?</h4></div>
  <div class="panel-body">
    <p>Configure your apps to collect analytics using the Lifecycle device event listener.</p>
    
    <ul>
        <li>For cross-platform apps that use Cordova, follow the iOS or Android guides, as the configurations are the same as for native apps.</li>
        <li>To enable the capture of network analytic data in iOS, add the following code in your Application Delegate <code>application:didFinishLaunchingWithOptions</code> method.<br/><br/>
        
        <b>Objective-C</b>

{% highlight objc %}
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
{% endhighlight %}

        <b>Swift</b>

{% highlight swift %}
WLAnalytics.sharedInstance()
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE)
{% endhighlight %}</li>
        
        <li>To enable the capture of network analytic data in Android, add the following code in your Application subclass <code>onCreate</code> method.<br/>
        
        <b>Java</b>
        
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>
