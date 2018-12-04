---
layout: tutorial
title: Fehlerbehebung für Analytics
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Informationen, die Ihnen bei der Lösung von Problemen helfen, die bei Verwendung von {{site.data.keys.mf_analytics }} auftreten können.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Es sind keine Daten in der Analysekonsole vorhanden.</h4></div>
  <div class="panel-body">
  <p>Prüfen Sie die folgenden Möglichkeiten:</p>
  <ul>
    <li>Stellen Sie sicher, dass Ihre Apps so eingestellt sind, dass sie auf den {{site.data.keys.mf_server }} zeigen, der die Protokolle an den {{site.data.keys.mf_analytics_server }} weiterleitet. Stellen Sie sicher, dass die folgenden Werte in den Dateien <code>mfpclient.plist</code> (iOS), <code>mfpclient.properties</code> (Android) oder <code>config.xml</code> (Cordova) definiert sind.

{% highlight xml %}
protocol = http oder https
host = IP-Adresse Ihres {{ site.data.keys.mf_server }}
port = in der Datei the server.xml für Analyseberichte festgelegter HTTP-Port
wlServerContext = standardmäßig "/mfp/"
{% endhighlight %}</li>

    <li>Stellen Sie sicher, dass Ihr {{site.data.keys.mf_server }} auf den {{site.data.keys.mf_analytics_server }} zeigt.

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>Vergewissern Sie sich, dass die Methode send aufgerufen wird.
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
  <div class="panel-heading"><h4>Warum gibt es Absturzdaten in der Tabelle "Absturzübersicht", aber keine Daten in der Tabelle "Absturzzusammenfassung"?</h4></div>
  <div class="panel-body">
    <p>Die Absturzprotokolle müssen an den Server gesendet werden, sobald die App erneut ausgeführt wird. Stellen Sie sicher, dass Ihre Apps nach einem Absturz Protokolle senden. Senden Sie die Protokolle zur Sicherheit beim App-Start, um sicherzustellen, dass alle zuvor nicht gesendeten Informationen gemeldet werden.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Warum enthält das Ablaufdiagramm zur Servernutzung oder das Diagramm der Netzanforderungen keine Daten?</h4></div>
  <div class="panel-body">
    <p>Konfigurieren Sie Ihre Apps für die Erfasssung von Analysedaten bei Gerätenetzereignissen ("Network"). </p>

{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>Folgen Sie für plattformübergreifende Apps, die Cordova verwenden, den Anweisungen für iOS oder Android, da die Konfiguration mit der für native Apps übereinstimmt.</li>
        <li>Wenn Sie die Erfassung von Analysedaten unter iOS ermöglichen wollen, fügen Sie den folgenden Code zur Methode <code>application:didFinishLaunchingWithOptions</code> Ihres Anwendungsdelegaten hinzu.<br/>

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

        <li>Wenn Sie die Erfassung von Analysedaten unter Android ermöglichen wollen, fügen Sie den folgenden Code zur Methode <code>onCreate</code> Ihrer Application-Unterklasse hinzu.<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Warum sind keine Daten zu App-Sitzungen vorhanden?</h4></div>
  <div class="panel-body">
    <p>Konfigurieren Sie Ihre Apps für die Erfasssung von Analysedaten mit dem Listener für Gerätelebenszyklusereignisse ("Lifecycle"). </p>

    <ul>
        <li>Folgen Sie für plattformübergreifende Apps, die Cordova verwenden, den Anweisungen für iOS oder Android, da die Konfiguration mit der für native Apps übereinstimmt.</li>
        <li>Wenn Sie die Erfassung von Analysedaten unter iOS ermöglichen wollen, fügen Sie den folgenden Code zur Methode <code>application:didFinishLaunchingWithOptions</code> Ihres Anwendungsdelegaten hinzu.<br/><br/>

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

        <li>Wenn Sie die Erfassung von Analysedaten unter Android ermöglichen wollen, fügen Sie den folgenden Code zur Methode <code>onCreate</code> Ihrer Application-Unterklasse hinzu.<br/>

        <b>Java</b>

{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Die Analytics Console reagiert nicht mehr, wenn mehrere Benutzer auf die Konsole zugreifen.</h4></div>
  <div class="panel-body">
  <br>
    <p>Wenn {{ site.data.keys.product }} Analytics in Vorversionen von WebSphere Liberty Version <b>8.5.5.6</b> implementiert ist und mehrere Benutzer auf die Konsole zugreifen, wird die Konsole blockiert bzw. reagiert die Konsole nicht mehr auf Benutzeranforderungen.
</p>

    <ul>
        <li>Zu dieser Situation kommt es, weil WebSphere Liberty keine <code>Executor</code>-Threads mehr für die Reaktion auf Anforderungen zur Verfügung stehen. Das führt zu einer Sperrsituation. </li>

        <li>Die Standardanzahl von <a href="https://developer.ibm.com/wasdev/docs/was-liberty-threading-and-why-you-probably-dont-need-to-tune-it/" target="_blank">Liberty-Kernthreads</a> ist die Anzahl der Hardware-Threads.
</li>
        <li>Lösen Sie dieses Problem, indem Sie die Anzahl der Threads mit dem Parameter für Liberty-Executor-Threads auf einen über dem Standardwert liegenden Wert setzen.
<br/>
Fügen Sie die folgende Konfiguration zur Liberty-Datei <code>server.xml</code> hinzu:
<br/>

{% highlight xml %}
<executor name="LargeThreadPool" id="default" coreThreads="80" maxThreads="80" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS" />
{% endhighlight %}</li>
<li>In WebSphere Liberty 8.5.5.6 sind diese <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_tun.html" target="_blank">Optimierungseinstellungen</a> in der Regel nicht erforderlich. </li>
    </ul>
  </div>
</div>

## Zusätzliche Referenzinformationen
{: #additional_references}

* [Bewährte Verfahren für die Einrichtung eines MobileFirst-Analytics-Produktionsclusters](../../analytics/bestpractices-prod/)
* [Häufig gestellte Fragen zu {{ site.data.keys.mf_analytics_server }}](../../analytics/bestpractices-prod/faq/)
