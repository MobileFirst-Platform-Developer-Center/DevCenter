---
layout: tutorial
title: Analytics 문제점 해결
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_analytics }}를 사용할 때 발생할 수 있는 문제를 해결하는 데 도움을 주는 정보를 찾아보십시오.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Analytics Console에 데이터가 없음</h4></div>
  <div class="panel-body">
  <p>다음 가능성을 확인해 보십시오.</p>
  <ul>
    <li>앱이 로그를 {{ site.data.keys.mf_analytics_server }}에 전달하는 {{ site.data.keys.mf_server }}를 가리키도록 설정되어 있는지 확인하십시오. <code>mfpclient.plist</code>(iOS), <code>mfpclient.properties</code>(Android) 또는 <code>config.xml</code>(Cordova) 파일에 다음 값이 설정되어 있는지 확인하십시오.

{% highlight xml %}
protocol = http 또는 https
host = {{ site.data.keys.mf_server }}의 IP 주소
port = 분석 보고를 위해 server.xml 파일에 설정된 HTTP 포트
wlServerContext = 기본적으로 "/mfp/"
{% endhighlight %}</li>

    <li>{{ site.data.keys.mf_server }}가 {{ site.data.keys.mf_analytics_server }}를 가리키는지 확인하십시오.

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>send 메소드를 호출하고 있는지 확인하십시오.
        <ul>
            <li>iOS:
                <ul>
                    <li>Objective-C: <code>[[WLAnalytics sharedInstance] send];</code></li>
                    <li>Swift: <code>WLAnalytics.sharedInstance().send()</code></li>
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
  <div class="panel-heading"><h4>충돌 개요 테이블에는 충돌 데이터가 있지만 충돌 요약 테이블에는 아무것도 없는 이유</h4></div>
  <div class="panel-body">
    <p>앱이 다시 실행되고 나면 충돌 로그를 서버에 전송해야 합니다. 충돌 후 앱이 로그를 전송하는지 확인하십시오. 확실히 하기 위해, 앱 시작 시 로그를 전송하여 이전에 전송되지 않은 정보가 보고되게 하십시오.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>서버 사용 플로우 그래프 또는 네트워크 요청 그래프에 데이터가 없는 이유</h4></div>
  <div class="panel-body">
    <p>네트워크 디바이스 이벤트에 대한 분석을 수집하도록 앱을 구성하십시오.</p>

{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>Cordova를 사용하는 크로스 플랫폼 앱의 경우, 구성이 네이티브 앱과 동일하므로 iOS 또는 Android 안내서를 따르십시오.</li>
        <li>iOS에서 네트워크 분석 데이터 캡처를 사용으로 설정하려면 애플리케이션 위임 <code>application:didFinishLaunchingWithOptions</code> 메소드에 다음 코드를 추가하십시오.<br/>

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

        <li>Android에서 네트워크 분석 데이터 캡처를 사용으로 설정하려면 애플리케이션 서브클래스 <code>onCreate</code> 메소드에 다음 코드를 추가하십시오.<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>앱 세션에 대한 데이터가 없는 이유</h4></div>
  <div class="panel-body">
    <p>라이프사이클 디바이스 이벤트 리스너를 사용하여 분석을 수집하도록 앱을 구성하십시오.</p>

    <ul>
        <li>Cordova를 사용하는 크로스 플랫폼 앱의 경우, 구성이 네이티브 앱과 동일하므로 iOS 또는 Android 안내서를 따르십시오.</li>
        <li>iOS에서 네트워크 분석 데이터 캡처를 사용으로 설정하려면 애플리케이션 위임 <code>application:didFinishLaunchingWithOptions</code> 메소드에 다음 코드를 추가하십시오.<br/><br/>

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

        <li>Android에서 네트워크 분석 데이터 캡처를 사용으로 설정하려면 애플리케이션 서브클래스 <code>onCreate</code> 메소드에 다음 코드를 추가하십시오.<br/>

        <b>Java</b>

{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>여러 사용자가 Analytics Console에 액세스하는 경우 콘솔이 응답하지 않음</h4></div>
  <div class="panel-body">
  <br>
    <p>{{ site.data.keys.product }} Analytics가 <b>8.5.5.6 이전의</b> WebSphere Liberty 버전에 배치되었으며 여러 사용자가 콘솔에 액세스하는 경우 콘솔이 멈추거나 추가 사용자 요청에 대해 응답을 중지합니다.
</p>

    <ul>
        <li>이 상황은 WebSphere Liberty에서 요청을 서비스하기 위한 <code>Executor</code> 스레드가 부족하게 되어 발생합니다. 이는 교착 상황으로 이어집니다.</li>

        <li><a href="https://developer.ibm.com/wasdev/docs/was-liberty-threading-and-why-you-probably-dont-need-to-tune-it/" target="_blank">Liberty 코어 스레드</a>의 기본 수는 하드웨어 스레드의 수입니다.
</li>
        <li>이 문제를 해결하려면 Liberty executor 스레드 매개변수의 스레드 수를 기본값보다 큰 값으로 구성하십시오.
<br/>
Liberty의 <code>server.xml</code>에 다음 구성을 추가하십시오.
<br/>

{% highlight xml %}
<executor name="LargeThreadPool" id="default" coreThreads="80" maxThreads="80" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS" />
{% endhighlight %}</li>
<li>이러한 <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_tun.html" target="_blank">튜닝 설정</a>은 Websphere Liberty 8.5.5.6의 경우에는 일반적으로 필요하지 않습니다.</li>
    </ul>
  </div>
</div>

## 추가 참조
{: #additional_references}

* [MobileFirst Analytics 프로덕션 클러스터 설정에 대한 우수 사례](../../analytics/bestpractices-prod/)
* [{{ site.data.keys.mf_analytics_server }} 관련 자주 묻는 질문(FAQ)](../../analytics/bestpractices-prod/faq/)
