---
layout: tutorial
title: Fehlerbehebung bei Push-Benachrichtigungen
breadcrumb_title: Notifications
relevantTo: [ios,android,windows,cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Informationen, die Ihnen bei der Lösung von Problemen helfen, die bei Verwendung des Push-Service der {{ site.data.keys.product }} auftreten können.

<div class="panel panel-default">
  <div class="panel-heading"><h4>Wie verhält sich der Push-Service in verschiedenen Situationen mit fehlgeschlagener Zustellung von Benachrichtigungen?</h4></div>
  <div class="panel-body">
    <b>GCM</b><br/>
    <ul>
        <li>Wenn die Antwort von GCM "Internal Server Error" oder "GCM Service is unavialable" lautet, wird versucht, die Benachrichtigung erneut zu senden. Die Häufigkeit der Sendungswiederholungen richtet sich nach dem Wert von "Retry-After".</li>
        <li>Wenn GCM nicht erreichbar ist, wird ein Fehler in der Datei <b>trace.log</b> ausgegeben und das Senden der Nachricht nicht wiederholt. </li>
        <li>Wenn GCM erreichbar ist, aber Fehler festgestellt wurden:
            <ul>
                <li>Not registered / Invalid ID / Mismatch ID / Registration missing: Diese Fehler gehen wahrscheinlich auf eine ungültige Nutzung der Geräte-ID oder eine ungültige Registrierung der App in GCM zurück. Die Geräte-ID wird aus der Datenbank gelöscht, um veraltete Daten in der Datenbank zu vermeiden. Die Benachrichtigung wird nicht erneut gesendet.</li>
                <li>The message is too big: Das Senden der Nachricht wird nicht erneut versucht und in der Datei <b>trace.log</b> wird ein Protokoll erfasst. </li>
                <li>Error Code 401: Dieser Fehler ist wahrscheinlich auf einen Authentifizierungsfehler zurückzuführen. Das Senden der Nachricht wird nicht erneut versucht. In der Datei <b>trace.log</b> wird ein Protokoll erfasst. </li>
                <li>Error Code 400 / Error Code 403: Das Senden der Nachricht wird nicht erneut versucht und in der Datei <b>trace.log</b> wird ein Protokoll erfasst. </li>
            </ul>
        </li>
    </ul>
    <b>APNS</b><br/>
    <p>Wenn die APNS-Verbindung geschlossen ist, wird ein Wiederholungsversuch unternommen. Es wird dreimal versucht, eine Verbindung zum APNS herzustellen. In anderen Fällen wird kein Wiederholungsversuch unternommen. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Fehler mit Bezug zu "apns-environment" in Xcode werden gemeldet</h4></div>
  <div class="panel-body">
    <p>Vergewissern Sie sich, dass im Bereitstellungsprofil, das zum Signieren der Anwendung verwendet wird, die Push-Funktionalität aktiviert ist. Sie können dies im Apple Developer Portal auf der Seite mit den Einstellungen für die App-ID überprüfen. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Java-Socket-Ausnahmen in den Protokollen, wenn APNS-Benachrichtigungen gesendet werden und das Gerät nie erreichen</h4></div>
  <div class="panel-body">
    <p>Der APNS erfordert persistente Socket-Verbindungen zwischen dem {{ site.data.keys.mf_server }} und dem APNS. Der Push-Service setzt voraus, dass es ein offenes Socket gibt, und versucht, die Benachrichtigung zu senden. In vielen Fällen kann die Firewall eines Kunden jedoch so konfiguriert werden, dass nicht verwendete Sockets geschlossen werden (weil der Push-Service möglicherweise nicht häufig genutzt wird). Solche abrupten Socket-Schließungen können von keinem der Endpunkte gefunden werden, da bei normalen Socket-Schließungen der eine Endpunkt das Signal sendet und der andere Endpunkt das Signal bestätigt. Wenn das Senden mittels Push-Service über ein geschlossenes Socket versucht wird, sehen Sie Socket-Ausnahmen in den Protokollen. </p>
    
    <p>Sie können dieses Problem vermeiden, indem Sie sicherstellen, dass keine APNS-Sockets von Firewallregeln geschlossen werden, oder indem Sie die <a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">JNDI-Eigenschaft <code>push.apns.connectionIdleTimeout</code> des Push-Service</a> verwenden. Wenn Sie diese Eigenschaft konfigurieren, schließt der Server das für APNS-Push-Benachrichtigungen verwendete Socket ordnungsgemäß innerhalb eines bestimmten Zeitlimits (das kürzer als das Firewallzeitlimit für Sockets ist). Auf diese Weise kann ein Kunde Sockets schließen, bevor sie von der Firewall abrupt abgeschaltet werden. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>SOCKS-bezogene Fehler beim Senden einer Push-Benachrichtigung an iOS-Geräte</h4></div>
  <div class="panel-body">
    <p>Beispiel: <blockquote>java.net.SocketException: Malformed reply from SOCKS server at java.net.SocksSocketImpl.readSocksReply(SocksSocketImpl.java</blockquote>
    
    APNS-Benachrichtigungen werden über TCP-Sockets gesendet. Dies führt zu der Einschränkung, dass der für APNS-Benachrichtigungen verwendete Proxy TCP-Sockets unterstützen muss. Ein normaler HTTP-Proxy (der für GCM funktioniert) reicht hier nicht aus. Aus diesem Grund ist der einzige für APNS-Benachrichtigungen unterstützte Proxy ein SOCKS-Proxy. Version 4 oder 5 des SOCKS-Protokolls wird unterstützt. Die Ausnahme wird ausgelöst, wenn JNDI-Eigenschaften für die Übertragung von APNS-Benachrichtigungen über einen SOCKS-Proxy konfiguriert sind, der Proxy selbst jedoch nicht konfiguriert oder offline bzw. nicht verfügbar ist oder den Datenverkehr blockiert. Ein Kunde muss prüfen, ob sein SOCKS-Proxy verfügbar ist und funktioniert. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Eine gesendete Benachrichtigung erreicht nie das Gerät</h4></div>
  <div class="panel-body">
    <p>Benachrichtigungen können sofort oder verzögert gesendet werden. Die Verzögerung kann einige Sekunden bis ein paar Minuten betragen. Es gibt verschiedene Aspekte, die zu berücksichtigen sind: </p>
    <ul>
        <li>{{ site.data.keys.mf_server }} hat keine Kontrolle über die Benachrichtigung, sobald diese den Mediatorservice erreicht hat.</li>
        <li>Der Netz- oder Onlinestatus des Geräts (Gerät ein- oder ausgeschaltet) muss berücksichtigt werden.</li>
        <li>Es muss geprüft werden, ob Firewalls oder Proxys verwendet werden. Ist das der Fall, dürfen diese nicht so konfiguriert sein, dass sie die Kommunikation mit dem Mediator blockieren.</li>
        <li>In der Firewall dürfen für die GCM/APNS/WNS-Mediatoren keine ausgewählten IP-Adressen in Whitelists aufgenommen werden, anstatt die tatsächlichen Mediatoren-URLs zu verwenden. Dies kann zu Problemen führen, weil eine Mediator-URL in eine beliebige IP-Adresse aufgelöst werden kann. Kunden sollten den Zugriff auf die URL und nicht auf die IP-Adresse zulassen. Es ist zu beachten, dass bei Sicherstellung der Konnektivität mittels telnet-Übertragung an die Mediator-URL nicht alle Aspekte abgedeckt sind. Insbesondere unter iOS ist dies nur ein Beweis für eine funktionierende abgehende Verbindung. Der eigentliche Sendevorgang erfolgt über TCP-Sockets, die telnet nicht garantieren kann. Wenn nur bestimmte IP-Adressen zugelassen werden, kann bei Verwendung von GCM beispielsweise folgender Fehler auftreten: <blockquote>Caused by: java.net.UnknownHostException:android.googleapis.com:android.googleapis.com: Name or service not known.</blockquote></li>
    </ul>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Unter iOS erreichen nicht alle Benachrichtigungen das Gerät</h4></div>
  <div class="panel-body">
    <p>Apple definiert in seinen Richtlinien für Servicequalität so genannte kombinierte Benachrichtigungen (<b>coalescing notifications</b>). Dies bedeutet, dass der APNS-Server nur eine Benachrichtigung aufbewahrt, wenn eine sofortige Zustellung an ein (über ein Token identifiziertes) Gerät nicht möglich ist. Beispiel: Es gibt fünf Benachrichtigungen, die nacheinander gesendet werden. Wenn sich das Gerät in einem unzuverlässigen Netz befindet, sodass nur die erste Benachrichtigung zugestellt werden kann, wird die zweite vom APNS-Server vorübergehend gespeichert. In der Zwischenzeit wurde die dritte Benachrichtigung gesendet und hat den APNS-Server erreicht. Jetzt wird die frühere (noch nicht versendete) zweite Benachrichtigung gelöscht und die dritte (zuletzt eingegangene) Benachrichtigung gespeichert. Für den Endbenutzer bedeutet dies, das Benachrichtigungen fehlen. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Unter Android sind Benachrichtigungen nur verfügbar, wenn die App aktiv ist und im Vordergrund angezeigt wird</h4></div>
  <div class="panel-body">
    <p>... Wenn die Anwendung nicht oder im Hintergrund ausgeführt wird, wird die Anwendung nicht durch das Antippen der Benachrichtigung im Benachrichtigungsbereich gestartet. Dies kann daran liegen, dass der Wert des Feldes <b>app_name</b> in der Datei <b>strings.xml</b> in einen angepassten Namen geändert wurde. Dies hat eine Diskrepanz beim Anwendungsnamen und bei der in der Datei <b>AndroidManifest.xml </b> definierten beabsichtigten Aktion zur Folge. Falls ein anderer Name für die Anwendung erforderlich ist, sollte stattdessen das Feld <b>app_label</b> verwendet werden. Sie können auch angepasste Definitionen in der Datei <b>strings.xml</b> verwenden. </p>
  </div>
</div>


<div class="panel panel-default">
  <div class="panel-heading"><h4>SSLHandshakeExceptions beim Senden von Push-Benachrichtigungen an den APNS</h4></div>
  <div class="panel-body">
  <p>Beispiel: </p> <blockquote>ApnsConnection | com.ibm.mfp.push.server.notification.apns.Apns.Connectionlmpl sendMessage Failed to send message Message (Id=1;  Token=xxxx; Payload={"payload":{"\nid\":\"44b7f47\",\"tag\":\"Push.ALL\"}", "aps":{"alert":{"action-loc-key":null,"body":"TEST"}}})... trying again after delay javax.net.ssl.SSLHandshakeException:Received fatal alert: handshake_failure</blockquote>
<p>Das Problem zeigt sich nur, wenn JVMs mit IBM JDK 1.8 verwendet werden. Die Lösung besteht in einem Upgrade von IBM JDK 1.8 auf Version 8.0.3.11 oder eine aktuellere Version. </p>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading"><h4>Push-Service wird in der {{ site.data.keys.mf_console }} als inaktiv angezeigt</h4></div>
  <div class="panel-body">
    <p>Der Push-Service wird als inaktiv angezeigt, obwohl sie zugehörige WAR-Datei implementiert ist und die Eigenschaften <code>mfp.admin.push.url</code>, <code>mfp.push.authorization.server.url</code> und <code>secret</code> ordnungsgemäß in der Datei <b>server.xml</b> konfiguriert sind.</p>
    <p>Stellen Sie sicher, dass die JNDI-Eigenschaften des Servers für den MFP-Verwaltungsservice ordnungsgemäß festgelegt sind. Es sollte beispielsweise Folgendes definiert sein: </p>

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
