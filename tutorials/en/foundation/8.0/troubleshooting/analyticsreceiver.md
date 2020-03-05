---
layout: tutorial
title: Troubleshooting Analytics Receiver
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Find information to help resolve issues that you might encounter when you use the {{ site.data.keys.mf_analytics_receiver }}.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Mobile application failed to transmit data to {{ site.data.keys.mf_analytics_receiver }}
</h4></div>
  <div class="panel-body">
  <p>Check the following possibilities.</p>
  <ul>
    <li>Verify that your {{ site.data.keys.mf_server }} points to the right values of {{ site.data.keys.mf_analytics_receiver }}. Ensure that <i>mfp.analytics.receiver.url</i> is pointing to the {{ site.data.keys.mf_analytics_receiver }} specific rest endpoint (<code>http://hostip:port/analytics-receiver/rest</code>). </li>
    <li>Also, make sure that the endpoint url contains a fully qualified hostname. Otherwise, mobile application will fail to communicate with {{ site.data.keys.mf_analytics_receiver }} and is expected to throw following error.

{% highlight xml %}
External network Access failed. Response: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=Unable to resolve host "*****": No address associated with hostname, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> Registering an app with {{ site.data.keys.mf_server }} to get back {{ site.data.keys.mf_analytics_receiver }} specific REST URL and credentials. So try to uninstall the app and install and register the app with {{ site.data.keys.mf_server }} to get the {{ site.data.keys.mf_analytics_receiver }} specific details. Check whether client logs are successfully transmitted through the {{ site.data.keys.mf_analytics_receiver }}. </li>
    </ul>
  </div>
</div>
