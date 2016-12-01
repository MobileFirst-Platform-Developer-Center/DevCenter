---
layout: tutorial
title: Troubleshooting Analytics
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
Find information to help resolve issues that you might encounter when you use the MobileFirst Foundation's Operational Analytics.

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
    </ul>
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
{% endhighlight %}</li>

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
