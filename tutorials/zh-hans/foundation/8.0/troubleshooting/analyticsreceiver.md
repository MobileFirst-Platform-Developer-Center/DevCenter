---
layout: tutorial
title: 对 Analytics Receiver 进行故障诊断
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
请查找相关信息来帮助解决在使用 {{ site.data.keys.mf_analytics_receiver }} 时可能遇到的问题。

<div class="panel panel-default">
  <div class="panel-heading"><h4>移动应用程序无法将数据传输到 {{ site.data.keys.mf_analytics_receiver }}
</h4></div>
  <div class="panel-body">
  <p>检查以下可能性。</p>
  <ul>
    <li>验证您的 {{ site.data.keys.mf_server }} 是否指向 {{ site.data.keys.mf_analytics_receiver }} 的正确值。确保 <i>mfp.analytics.receiver.url</i> 指向特定于 {{ site.data.keys.mf_analytics_receiver }}的 rest 端点 (<code>http://hostip:port/analytics-receiver/rest</code>)。</li>
    <li>另外，请确保端点 URL 包含标准主机名。否则，移动应用程序将无法与 {{ site.data.keys.mf_analytics_receiver }} 通信，并且预计会抛出以下错误。

{% highlight xml %}
External network Access failed. Response: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=Unable to resolve host "*****": No address associated with hostname, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> 向 {{ site.data.keys.mf_server }} 注册应用程序以获取特定于 {{ site.data.keys.mf_analytics_receiver }} 的 REST URL 和凭证。因此请尝试卸载然后安装应用程序，向 {{ site.data.keys.mf_server }} 注册该应用程序，以获取特定于 {{ site.data.keys.mf_analytics_receiver }} 的详细信息。检查客户机日志是否已通过 {{ site.data.keys.mf_analytics_receiver }} 成功传输。</li>
    </ul>
  </div>
</div>
