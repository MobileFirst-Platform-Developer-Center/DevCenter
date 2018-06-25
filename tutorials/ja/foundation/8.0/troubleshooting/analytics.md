---
layout: tutorial
title: Analytics のトラブルシューティング
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
以下に、{{ site.data.keys.mf_analytics }} を使用する際に発生する可能性がある問題を解決するために役立つ情報を記載しています。

<div class="panel panel-default">
  <div class="panel-heading"><h4>Analytics コンソール内にデータがありません</h4></div>
  <div class="panel-body">
  <p>以下の可能性を調べてください。</p>
  <ul>
    <li>{{ site.data.keys.mf_analytics_server }}にログを転送する {{ site.data.keys.mf_server }} を指すようにアプリケーションが設定されていることを確認します。<code>mfpclient.plist</code> (iOS) ファイル、<code>mfpclient.properties</code> (Android) ファイル、または <code>config.xml</code> (Cordova) ファイルで必ず以下の値を設定するようにしてください。

{% highlight xml %}
protocol = http または https
host = ご使用の {{ site.data.keys.mf_server }} の IP アドレス
port = 分析を報告するために server.xml ファイルに設定されている HTTP ポート
wlServerContext = デフォルトでは「/mfp/」
{% endhighlight %}</li>

    <li>必ず {{ site.data.keys.mf_server }} が {{ site.data.keys.mf_analytics_server }}を指すようにしてください。

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>send メソッドを呼び出していることを確認します。
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
  <div class="panel-heading"><h4>「異常終了の概要」表には異常終了のデータがありますが、「異常終了の要約」表には何もありません。なぜですか?</h4></div>
  <div class="panel-body">
    <p>アプリケーションが再度実行されたら、異常終了のログをサーバーに送信する必要があります。異常終了の後、アプリケーションがログを送信していることを確認します。念のため、アプリケーションの開始時にログを送信して、前に未送信の情報があれば報告されるようにしてください。</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>「サーバー使用状況フロー」グラフおよび「ネットワーク要求」グラフにデータがありません。なぜですか?</h4></div>
  <div class="panel-body">
    <p>Network デバイス・イベントで分析を収集するようにアプリケーションを構成してください。</p>

{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>Cordova を使用するクロスプラットフォーム・アプリケーションの場合、ネイティブ・アプリケーションと構成が同じであるため、iOS または Android のガイドに従ってください。</li>
        <li>iOS でネットワーク分析データの収集を有効にするには、Application Delegate の <code>application:didFinishLaunchingWithOptions</code> メソッドに次のコードを追加します。<br/>

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

        <li>Android でネットワーク分析データの収集を有効にするには、Application サブクラスの <code>onCreate</code> メソッドに次のコードを追加します。<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>アプリケーション・セッションのデータがありません。なぜですか?</h4></div>
  <div class="panel-body">
    <p>Lifecycle デバイス・イベント・リスナーを使用して分析を収集するようにアプリケーションを構成してください。</p>

    <ul>
        <li>Cordova を使用するクロスプラットフォーム・アプリケーションの場合、ネイティブ・アプリケーションと構成が同じであるため、iOS または Android のガイドに従ってください。</li>
        <li>iOS でネットワーク分析データの収集を有効にするには、Application Delegate の <code>application:didFinishLaunchingWithOptions</code> メソッドに次のコードを追加します。<br/><br/>

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

        <li>Android でネットワーク分析データの収集を有効にするには、Application サブクラスの <code>onCreate</code> メソッドに次のコードを追加します。<br/>

        <b>Java</b>

{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>複数のユーザーが Analytics コンソールにアクセスすると、コンソールが応答しなくなります</h4></div>
  <div class="panel-body">
  <br>
    <p>{{ site.data.keys.product }} Analytics が WebSphere Liberty バージョン <b>8.5.5.6 より前</b>にデプロイされている場合に、複数のユーザーがコンソールにアクセスすると、コンソールはフリーズしたり、その後のユーザー要求に応答しなくなったりします。
</p>

    <ul>
        <li>この状況は、要求を処理するための <code>Executor</code> スレッドを WebSphere Liberty が使い尽くしたために発生します。これによってデッドロック状況が発生します。</li>

        <li><a href="https://developer.ibm.com/wasdev/docs/was-liberty-threading-and-why-you-probably-dont-need-to-tune-it/" target="_blank">Liberty コア・スレッド</a>のデフォルトの数は、ハードウェア・スレッドの数です。
</li>
        <li>この問題を解決するには、Liberty executor スレッド数のパラメーターを、デフォルトより大きい値に構成します。
<br/>
以下の構成を Liberty の <code>server.xml</code> に追加します。
<br/>

{% highlight xml %}
<executor name="LargeThreadPool" id="default" coreThreads="80" maxThreads="80" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS" />
{% endhighlight %}</li>
<li>これらの<a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_tun.html" target="_blank">調整設定</a>は通常、Websphere Liberty 8.5.5.6 の場合は不要です。</li>
    </ul>
  </div>
</div>
