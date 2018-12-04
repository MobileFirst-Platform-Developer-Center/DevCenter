---
layout: tutorial
title: 对分析进行故障诊断
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
请查找相关信息来帮助解决在使用 {{ site.data.keys.mf_analytics }} 时可能遇到的问题。

<div class="panel panel-default">
  <div class="panel-heading"><h4>分析控制台中没有任何数据</h4></div>
  <div class="panel-body">
  <p>检查以下可能性。</p>
  <ul>
    <li>验证您的应用程序是否已设置为指向 {{ site.data.keys.mf_server }}，此服务器会将日志转发至 {{ site.data.keys.mf_analytics_server }}。 确保在 <code>mfpclient.plist</code> (iOS)、<code>mfpclient.properties</code> (Android) 或 <code>config.xml</code> (Cordova) 文件中设置了以下值。

{% highlight xml %}
protocol = http or https
host = the IP address of your {{ site.data.keys.mf_server }}
port = the HTTP port that is set in the server.xml file for reporting analytics
wlServerContext = by default "/mfp/"
{% endhighlight %}</li>

    <li>确保 {{ site.data.keys.mf_server }} 指向 {{ site.data.keys.mf_analytics_server }}。

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>检查是否正在调用 send 方法。
        <ul>
            <li>iOS：
                <ul>
                    <li>Objective-C：<code>[[WLAnalytics sharedInstance] send];</code></li>
                    <li>Swift：<code>WLAnalytics.sharedInstance().send()</code></li>
                    <li>Android：<code>WLAnalytics.send();</code></li>
                    <li>Cordova：<code>WL.Analytics.send();</code></li>
                    <li>Web：<code>ibmmfpfanalytics.send();</code></li>
                </ul>
            </li>
        </ul>
    </li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>为何在“崩溃概述”表中出现崩溃数据，但在“崩溃摘要”表中却未显示任何数据？</h4></div>
  <div class="panel-body">
    <p>在应用程序恢复运行后，必须将崩溃日志发送至服务器。 验证您的应用程序在崩溃后是否发送了日志。 为安全起见，在应用程序启动时发送日志以确保报告了任何先前未发送的信息。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>为何在“服务器使用情况流程”图或“网络请求”图中没有任何数据？</h4></div>
  <div class="panel-body">
    <p>请将您的应用程序配置为在出现“网络”设备事件时收集分析数据。</p>

{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>对于使用 Cordova 的跨平台应用程序，请遵循 iOS 或 Android 指南进行操作，因为本机应用程序采用相同的配置。</li>
        <li>为确保捕获 iOS 中的网络分析数据，请在应用程序委托 <code>application:didFinishLaunchingWithOptions</code> 方法中添加以下代码。<br/>

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

        <li>为确保捕获 Android 中的网络分析数据，请在应用程序子类 <code>onCreate</code> 方法中添加以下代码。<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>为何没有应用程序会话数据？</h4></div>
  <div class="panel-body">
    <p>请将您的应用程序配置为使用“生命周期”设备事件侦听器来收集分析数据。</p>

    <ul>
        <li>对于使用 Cordova 的跨平台应用程序，请遵循 iOS 或 Android 指南进行操作，因为本机应用程序采用相同的配置。</li>
        <li>为确保捕获 iOS 中的网络分析数据，请在应用程序委托 <code>application:didFinishLaunchingWithOptions</code> 方法中添加以下代码。<br/><br/>

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

        <li>为确保捕获 Android 中的网络分析数据，请在应用程序子类 <code>onCreate</code> 方法中添加以下代码。<br/>

        <b>Java</b>

{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>当有多个用户正在访问分析控制台时，此控制台无响应。</h4></div>
  <div class="panel-body">
  <br>
    <p>如果在<b>低于 8.5.5.6</b> 的 WebSphere Liberty 版本上部署了 {{ site.data.keys.product }} 分析，并且有多个用户正在访问此控制台，此控制台会冻结或者停止响应任何其他用户请求。
</p>

    <ul>
        <li>发生此情况的原因是 WebSphere Liberty 的 <code>Executor</code> 线程不足，以致于无法为这些请求提供服务。 这将导致死锁情况。</li>

        <li><a href="https://developer.ibm.com/wasdev/docs/was-liberty-threading-and-why-you-probably-dont-need-to-tune-it/" target="_blank">Liberty 核心线程</a>的缺省数量等于硬件线程的数量。
</li>
        <li>要解决此问题，请在 Liberty Executor 线程参数中将线程数量配置为大于缺省值的值。
<br/>
在 Liberty 的 <code>server.xml</code> 中添加以下配置：
<br/>

{% highlight xml %}
<executor name="LargeThreadPool" id="default" coreThreads="80" maxThreads="80" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS" />
{% endhighlight %}</li>
<li>Websphere Liberty 8.5.5.6 通常不需要这些<a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_tun.html" target="_blank">调整设置</a>。</li>
    </ul>
  </div>
</div>

## 其他参考资料
{: #additional_references}

* [用于设置 MobileFirst Analytics 生产集群的最佳实践](../../analytics/bestpractices-prod/)
* [与 {{ site.data.keys.mf_analytics_server }} 相关的常见问题及解答](../../analytics/bestpractices-prod/faq/)
