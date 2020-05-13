---
layout: tutorial
title: Fehlerbehebung für den Analytics Receiver
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Informationen, die Ihnen bei der Lösung von Problemen helfen, die bei Verwendung des {{ site.data.keys.mf_analytics_receiver }} auftreten können.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Mobile Anwendungen können keine Daten an den {{ site.data.keys.mf_analytics_receiver }} übertragen</h4></div>
  <div class="panel-body">
  <p>Prüfen Sie die folgenden Möglichkeiten:</p>
  <ul>
    <li>Prüfen Sie, ob Ihr {{ site.data.keys.mf_server }} auf die richtigen Werte des {{ site.data.keys.mf_analytics_receiver }} zeigt. Stellen Sie sicher, dass <i>mfp.analytics.receiver.url</i> auf den für den {{ site.data.keys.mf_analytics_receiver }} spezifischen REST-Endpunkt (<code>http://hostip:port/analytics-receiver/rest</code>) zeigt.</li>
    <li>Vergewissern Sie sich, dsas die Endpunkt-URL einen vollständig qualifizierten Hostnamen enthält. Ist das nicht der Fall, können mobile Anwendungen nicht mit dem {{ site.data.keys.mf_analytics_receiver }} kommunizieren. Der folgende Fehler wird gemeldet.

{% highlight xml %}
External network Access failed. Response: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=Unable to resolve host "*****": No address associated with hostname, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> Registrieren Sie eine App bei {{ site.data.keys.mf_server }}, um wieder die REST-URL und die Berechtigungsnachweise für den {{ site.data.keys.mf_analytics_receiver }} zu erhalten. Versuchen Sie, die App zu deinstallieren und anschließend neu zu installieren und bei {{ site.data.keys.mf_server }} zu registrieren, um die spezifischen Daten für den {{ site.data.keys.mf_analytics_receiver }} zu erhalten. Überprüfen Sie, ob die Clientprotokolle erfolgreich mithilfe des {{ site.data.keys.mf_analytics_receiver }} übertragen werden.</li>
    </ul>
  </div>
</div>
