---
layout: tutorial
title: Analytics Receiver 문제점 해결
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_analytics_receiver }}를 사용할 때 발생할 수 있는 문제를 해결하는 데 도움을 주는 정보를 찾아보십시오.

<div class="panel panel-default">
  <div class="panel-heading"><h4>모바일 애플리케이션에서 데이터를 {{ site.data.keys.mf_analytics_receiver }}에 전송하지 못했습니다.
</h4></div>
  <div class="panel-body">
  <p>다음 가능성을 확인해 보십시오.</p>
  <ul>
    <li>{{ site.data.keys.mf_server }}에서 올바른 {{ site.data.keys.mf_analytics_receiver }} 값을 지정하는지 확인하십시오. <i>mfp.analytics.receiver.url</i>이 {{ site.data.keys.mf_analytics_receiver }} 고유 REST 엔드포인트를 지정하는지 확인합니다(<code>http://hostip:port/analytics-receiver/rest</code>). </li>
    <li>또한 엔드포인트 url에 완전한 호스트 이름이 포함되어야 합니다. 그렇지 않으면, 모바일 애플리케이션에서 {{ site.data.keys.mf_analytics_receiver }}와 통신할 수 없으며 다음 오류가 발생합니다. 

{% highlight xml %}
External network Access failed. Response: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=Unable to resolve host "*****": No address associated with hostname, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> {{ site.data.keys.mf_server }}로 앱에 등록하면 {{ site.data.keys.mf_analytics_receiver }} 고유 REST URL과 인증 정보를 가져옵니다. 따라서 앱 설치를 취소하고 {{ site.data.keys.mf_server }}로 앱을 설치 및 등록하여 {{ site.data.keys.mf_analytics_receiver }} 고유 세부사항을 가져옵니다. {{ site.data.keys.mf_analytics_receiver }}를 통해 클라이언트 로그를 전송했는지 확인하십시오. </li>
    </ul>
  </div>
</div>
