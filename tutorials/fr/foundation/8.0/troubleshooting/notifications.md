---
layout: tutorial
title: Traitement des incidents liés aux notifications push
breadcrumb_title: Notifications
relevantTo: [ios,android,windows,cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous trouverez ici des informations qui vous aideront à résoudre les problèmes que vous êtes susceptible de rencontrer lors de l'utilisation du service Push de {{ site.data.keys.product }}.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Comment le service Push traite-t-il les différentes situations de notification d'échec de distribution ?</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>Si la réponse de GCM est "internal server error" (erreur de serveur interne) ou "GCM service is unavailable" (le service GCM n'est pas disponible), une nouvelle tentative d'envoi de la notification est effectuée. La fréquence des tentatives est déterminée en fonction de la valeur de "Retry-After".</li>
        <li>GCM n'est pas accessible : une erreur est indiquée dans le fichier <b>trace.log</b> et le message envoyé n'est pas renvoyé.</li>
        <li>GCM est accessible mais des échecs sont reçus
            <ul>
                <li>Non enregistré / ID non valide / ID non concordant / enregistrement manquant :  utilisation non valide probable de l'ID d'appareil ou enregistrement non valide de l'application dans GCM. L'ID d'appareil est supprimé de la base de données afin d'éviter la présence de données périmées dans la base de données. La notification n'est pas renvoyée.</li>
                <li>Le message est trop volumineux : aucune nouvelle tentative de renvoi du message n'est effectuée et un journal est enregistré dans le fichier <b>trace.log</b>.</li>
                <li>Code d'erreur 401 : probablement dû à une erreur d'authentification, aucune nouvelle tentative de renvoi du message n'est effectuée et un journal est enregistré dans le fichier <b>trace.log</b>.</li>
                <li>Code d'erreur 400 ou 403 : aucune nouvelle tentative de renvoi du message n'est effectuée et un journal est enregistré dans le fichier <b>trace.log</b>.</li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>Dans le cas d'APNS, une tentative de renvoi est effectuée si la connexion APNS est fermée. Trois tentatives d'établissement de connexion avec APNS sont effectuées. Dans les autres cas, aucune nouvelle tentative d'envoi n'est effectuée.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Obtention d'erreurs liées à "apns-environment" dans Xcode</h4></div>
  <div class="panel-body">
    <p>Vérifiez que la fonction Push est activée dans le profil de mise à disposition employé pour la connexion aux applications. Vous pouvez vérifier ce paramètre dans la page des paramètres de l'ID d'appli dans le portail Apple Developer.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Des exceptions de socket Java sont présentes dans les journaux lors de la répartition d'une notification APNS et la notification n'atteint jamais l'appareil</h4></div>
  <div class="panel-body">
    <p>APNS requiert des connexions socket permanentes entre {{ site.data.keys.mf_server }} et le service APNS. Le service Push suppose qu'il existe un socket ouvert et essaie d'envoyer la notification. Il arrive cependant fréquemment qu'un pare-feu client soit configuré pour fermer les sockets non utilisés (le service n'est peut-être pas souvent utilisé). De telles fermetures brutales de socket sont introuvables par les noeuds finaux car les sockets se ferment normalement lorsqu'un noeud final envoie le signal et que l'autre en accuse réception. Lorsque la tentative de répartition du service Push est effectuée sur un socket fermé, les journaux affichent les exceptions de socket.</p>
    
    <p>Afin d'éviter ce problème, vérifiez qu'aucune règle de pare-feu ne ferme les sockets APNS ou utilisez la <a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">propriété JNDI</a> <code>push.apns.connectionIdleTimeout</code> du service Push. Si vous configurez cette propriété, le serveur ferme normalement le socket utilisé pour les notifications push APNS dans un délai imparti (inférieur au délai d'attente du pare-feu pour les sockets). Un client peut ainsi fermer les sockets avant leur arrêt brutal par le pare-feu.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Des erreurs liées à SOCKS sont générées lors de l'envoi d'une notification push à des appareils iOS</h4></div>
  <div class="panel-body">
    <p>Exemple : <blockquote>java.net.SocketException: Malformed reply from SOCKS serverat java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    Des notifications APNS sont envoyées via des sockets TCP. Les notifications APNS doivent alors prendre en charge les sockets TCP. Un proxy HTTP normal (qui fonctionne avec GCM) n'est pas suffisant ici. Le seul proxy pris en charge dans le cas de notifications APNS est donc un proxy SOCKS. Le protocole SOCKS version 4 ou 5 est pris en charge. L'exception est émise lorsque des propriétés JNDI sont configurées pour acheminer des notifications APNS via un proxy SOCKS, mais que le proxy n'est pas configuré, est en ligne, n'est pas disponible ou bloque le trafic. Les clients doivent vérifier que leur proxy SOCKS est disponible et opérationnel.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Une notification a été envoyée, mais elle n'a jamais atteint l'appareil</h4></div>
  <div class="panel-body">
    <p>Les notifications peuvent être instantanées, mais il arrive qu'elles soient retardées. Le retard peut varier de quelques secondes à plusieurs minutes. Il existe plusieurs raisons à cela :</p>
    <ul>
        <li>{{ site.data.keys.mf_server }} ne contrôle pas la notification une fois qu'elle atteint le service du médiateur.</li>
        <li>Les besoins liés au statut réseau ou de connexion de l'appareil (démarré/arrêté) doivent être pris en compte.</li>
        <li>Vérifiez si des pare-feux ou des proxys sont utilisés et, si tel est le cas, qu'ils ne sont pas configurés pour bloquer la communication vers le médiateur (et inversement).</li>
        <li>Ne créez pas de liste blanche d'adresses IP de manière sélective dans votre pare-feu pour les médiateurs GCM/APNS/WNS au lieu d'utiliser les adresses URL réelles des médiateurs. Cela peut générer des problèmes car l'URL d'un médiateur peut être résolue en n'importe quelle adresse IP. Les clients doivent autoriser l'accès à l'URL et non à l'adresse IP. Notez que le fait de vérifier la connectivité du médiateur via la commande telnet auprès de l'URL du médiateur ne permet pas forcément de se prémunir contre tous les problèmes. En particulier pour iOS, cela ne prouve que la connectivité sortante. L'envoi réel est effectué via des sockets TCP non vérifiés par telnet. Si vous n'autorisez que des adresses IP spécifiques, le comportement suivant est susceptible de se produire, par exemple, pour GCM : <blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Sous iOS, certaines notifications parviennent jusqu'à l'appareil, mais d'autres ne l'atteignent pas</h4></div>
  <div class="panel-body">
    <p>La qualité de service d'Apple définit ce qu'on appelle la <b>coalescence des notifications</b>. Cela signifie que le serveur APNS ne conserve qu'une seule notification en cas de non distribution immédiate à un appareil (identifié via un jeton). Prenons l'exemple de cinq notifications réparties l'une après l'autre. Si l'appareil se trouve sur un réseau instable et que la première notification est distribuée, la deuxième est stockée temporairement par le serveur APNS. La troisième notification est alors envoyée et atteint le serveur APNS. La deuxième notification antérieure et non distribuée est alors supprimée et la troisième notification (ultérieure) est stockée. Aux yeux d'un utilisateur final, cela se manifeste par des notifications manquantes.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Sous Android, les notifications sont disponibles uniquement si l'application est exécutée et qu'elle se trouve au premier plan.</h4></div>
  <div class="panel-body">
    <p>Si l'application n'est pas en cours d'exécution ou si elle est à l'arrière-plan, le fait de taper sur la notification dans son ombre ne lance par l'application. Cela peut être dû à la modification de la zone <b>app_name</b> dans le fichier <b>strings.xml</b> en un nom personnalisé. Cela entraîne une non-concordance entre le nom de l'application et l'action d'intention définie dans le fichier <b>AndroidManifest.xml</b>.  Si vous devez indiquer un autre nom pour l'application, utilisez à la place la zone <b>app_label</b> ou employez des définitions personnalisées dans le fichier <b>strings.xml</b>.</p>
  </div>
</div>


<div class="panel panel-default">
  <div class="panel-heading"><h4>Exceptions SSLHandshakeExceptions lors de l'envoi de notifications push à APNS</h4></div>
  <div class="panel-body">
  <p>Exemple :</p> <blockquote>ApnsConnection | com.ibm.mfp.push.server.notification.apns.Apns.Connectionlmpl sendMessage Failed to send message Message (Id=1;  Token=xxxx; Payload={"payload":{"\nid\":\"44b7f47\",\"tag\":\"Push.ALL\"}", "aps":{"alert":{"action-loc-key":null,"body":"TEST"}}})... trying again after delay javax.net.ssl.SSLHandshakeException:Received fatal alert: handshake_failure</blockquote>
<p>Ce problème a été signalé uniquement lors de l'utilisation de machines virtuelles IBM JDK 1.8. La solution consiste à mettre à niveau IBM JDK 1.8 vers la version 8.0.3.11 ou ultérieure.</p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Le service Push est indiqué comme inactif dans {{ site.data.keys.mf_console }}</h4></div>
  <div class="panel-body">
    <p>Le service Push est indiqué comme inactif malgré le déploiement du fichier .war et la configuration appropriée des propriétés <code>mfp.admin.push.url</code>, <code>mfp.push.authorization.server.url</code> et <code>secret</code> dans le fichier <b>server.xml</b>.</p>
    <p>Vérifiez que les propriétés JNDI du serveur sont correctement définies pour le service MFP Admin. Voici un exemple de configuration correcte :</p>

{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value='"http://localhost:9080/imfpush"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.server.url" value='"http://localhost:9080/mfp"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.id" value='"push-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.secret" value='"pushSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.id" value='"admin-client-id"'/>
<jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.secret" value='"adminSecret"'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.password" value='"{xor}DCs+LStubWw="'/>
<jndiEntry jndiName="mfpadmin/mfp.config.service.user" value='"configUser"'/>
{% endhighlight %}
  </div>
</div>
