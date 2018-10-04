---
layout: tutorial
title: Traitement des incidents liés à Analytics
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous trouverez ici des informations qui vous aideront à résoudre les problèmes que vous êtes susceptible de rencontrer lors de l'utilisation de {{ site.data.keys.mf_analytics }}.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Absence de données dans la console d'analyse</h4></div>
  <div class="panel-body">
  <p>Vérifiez les points suivants :</p>
  <ul>
    <li>Vérifiez que vos applications sont configurées pour pointer vers {{ site.data.keys.mf_server }}, qui réachemine les journaux vers {{ site.data.keys.mf_analytics_server }}. Assurez-vous que les valeurs suivantes sont définies dans le fichier <code>mfpclient.plist</code> (iOS), <code>mfpclient.properties</code> (Android) ou <code>config.xml</code> (Cordova).

{% highlight xml %}
protocol = http or https
host = the IP address of your {{ site.data.keys.mf_server }}
port = the HTTP port that is set in the server.xml file for reporting analytics
wlServerContext = by default "/mfp/"
{% endhighlight %}</li>

    <li>Vérifiez que votre serveur {{ site.data.keys.mf_server }} pointe vers votre serveur {{ site.data.keys.mf_analytics_server }}.

{% highlight xml %}
/analytics-service
/analytics
{% endhighlight %}</li>

    <li>Vérifiez que vous appelez la méthode send.
        <ul>
            <li>iOS :
                <ul>
                    <li>Objective-C : <code>[[WLAnalytics sharedInstance] send];</code></li>
                    <li>Swift : <code>WLAnalytics.sharedInstance().send()</code></li>
                    <li>Android : <code>WLAnalytics.send();</code></li>
                    <li>Cordova : <code>WL.Analytics.send();</code></li>
                    <li>Web : <code>ibmmfpfanalytics.send();</code></li>
                </ul>
            </li>
        </ul>
    </li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Pourquoi des données relatives aux pannes sont-elles présentes dans la table Présentation de la panne, mais pas dans la table Récapitulatif des pannes ?</h4></div>
  <div class="panel-body">
    <p>Les journaux relatifs aux pannes doivent être envoyés au serveur une fois que l'application est à nouveau exécutée. Vérifiez que vos applications envoient les journaux après une panne. Pour plus de sécurité, envoyez les journaux au démarrage des applications pour être sûr que d'éventuelles informations non envoyées précédemment sont signalées.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Pourquoi n'existe-t-il aucune donnée dans le graphique Flux d'utilisation du serveur ou Demandes de réseau ?</h4></div>
  <div class="panel-body">
    <p>Configurez vos applications de manière à ce qu'elles collectent des analyses sur l'événement d'appareil Réseau.</p>

{% highlight javascript %}
ibmmfpfanalytics.logger.config({analyticsCapture: true});
{% endhighlight %}

    <ul>
        <li>Dans le cas d'applications multiplateformes qui utilisent Cordova, consultez les guides relatifs à iOS ou Android car les configurations sont identiques à celles des applications natives.</li>
        <li>Pour activer la capture des données d'analyse réseau sous iOS, ajoutez le code suivant dans la méthode <code>application:didFinishLaunchingWithOptions</code> de votre application déléguée.<br/>

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

        <li>Pour activer la capture des données d'analyse réseau sous Android, ajoutez le code suivant dans la méthode <code>onCreate</code> de la sous-classe de l'application.<br/>

        <b>Java</b>
{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Pourquoi n'existe-t-il aucune donnée pour les sessions d'application ?</h4></div>
  <div class="panel-body">
    <p>Configurez vos applications de manière à ce qu'elles collectent des analyses à l'aide du programme d'écoute d'événement d'appareil du cycle de vie.</p>

    <ul>
        <li>Dans le cas d'applications multiplateformes qui utilisent Cordova, consultez les guides relatifs à iOS ou Android car les configurations sont identiques à celles des applications natives.</li>
        <li>Pour activer la capture des données d'analyse réseau sous iOS, ajoutez le code suivant dans la méthode <code>application:didFinishLaunchingWithOptions</code> de votre application déléguée.<br/><br/>

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

        <li>Pour activer la capture des données d'analyse réseau sous Android, ajoutez le code suivant dans la méthode <code>onCreate</code> de la sous-classe de l'application.<br/>

        <b>Java</b>

{% highlight java %}
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
{% endhighlight %}</li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>La console d'analyse ne répond plus lorsque plusieurs utilisateurs y accèdent.</h4></div>
  <div class="panel-body">
  <br>
    <p>Si {{ site.data.keys.product }} Analytics est déployé sur des versions de WebSphere Liberty <b>antérieures à la version 8.5.5.6</b> et si plusieurs utilisateurs accèdent à la console, cette dernière se fige et arrête de répondre aux demandes utilisateur ultérieures.
</p>

    <ul>
        <li>Cette situation se produit car WebSphere Liberty ne dispose pas d'une quantité suffisante d'unités d'exécution <code>Executor</code> pour servir les demandes. Cela entraîne une situation d'interblocage.</li>

        <li>Le nombre par défaut d'<a href="https://developer.ibm.com/wasdev/docs/was-liberty-threading-and-why-you-probably-dont-need-to-tune-it/" target="_blank">unités d'exécution de base Liberty</a> est le nombre d'unités d'exécution matérielles.
</li>
        <li>Pour résoudre ce problème, configurez le nombre d'unités d'exécution dans le paramètre des unités d'exécution Executor de Liberty en indiquant une valeur supérieure à la valeur par défaut.
<br/>
Ajoutez la configuration suivante dans le fichier <code>server.xml</code> de Liberty :
<br/>

{% highlight xml %}
<executor name="LargeThreadPool" id="default" coreThreads="80" maxThreads="80" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS" />
{% endhighlight %}</li>
<li>Ces <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_tun.html" target="_blank">paramètres d'optimisation</a> ne sont généralement pas requis avec WebSphere Liberty 8.5.5.6.</li>
    </ul>
  </div>
</div>

## Références complémentaires
{: #additional_references}

* [Best Practices for setting up MobileFirst Analytics production Cluster](../../analytics/bestpractices-prod/)
* [Questions posées fréquemment sur {{ site.data.keys.mf_analytics_server }}](../../analytics/bestpractices-prod/faq/)
