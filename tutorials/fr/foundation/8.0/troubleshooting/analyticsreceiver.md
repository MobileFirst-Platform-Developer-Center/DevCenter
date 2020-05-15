---
layout: tutorial
title: Traitement des incidents liés à Analytics Receiver
breadcrumb_title: Analytics Receiver
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous trouverez ici des informations qui vous aideront à résoudre les problèmes que vous êtes susceptible de rencontrer lors de l'utilisation de {{ site.data.keys.mf_analytics_receiver }}.

<div class="panel panel-default">
  <div class="panel-heading"><h4>L'application mobile n'a pas pu transmettre de données à {{ site.data.keys.mf_analytics_receiver }}
</h4></div>
  <div class="panel-body">
  <p>Vérifiez les points suivants :</p>
  <ul>
    <li>Vérifiez que {{ site.data.keys.mf_server }} pointe vers les valeurs appropriées de {{ site.data.keys.mf_analytics_receiver }}. Vérifiez que <i>mfp.analytics.receiver.url</i> pointe vers le point de terminaison {{ site.data.keys.mf_analytics_receiver }} REST spécifique (<code>http://hostip:port/analytics-receiver/rest</code>). </li>
    <li>Assurez-vous également que l'URL de point de terminaison contient un nom d'hôte qualifié complet. Sinon, l'application mobile ne pourra pas communiquer avec {{ site.data.keys.mf_analytics_receiver }} et renverra l'erreur suivante.

{% highlight xml %}
External network Access failed. Response: WLResponse [invocationContext=null, responseText=, status=-1] WLFailResponse [errorMsg=Unable to resolve host "*****": No address associated with hostname, errorCode=UNEXPECTED_ERROR]
{% endhighlight %}</li>
      <li> Enregistrez une application avec {{ site.data.keys.mf_server }} pour récupérer les données d'identification et l'URL REST spécifique de {{ site.data.keys.mf_analytics_receiver }}. Essayez de désinstaller l'application, puis d'installer et d'enregistrer l'application avec {{ site.data.keys.mf_server }} pour récupérer les détails spécifiques à {{ site.data.keys.mf_analytics_receiver }}. Vérifiez si les journaux client sont correctement transmis via {{ site.data.keys.mf_analytics_receiver }}. </li>
    </ul>
  </div>
</div>
