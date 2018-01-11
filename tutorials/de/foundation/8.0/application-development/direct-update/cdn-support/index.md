---
layout: tutorial
title: Anforderungen nach direkter Aktualisierung mit einem CDN bedienen
breadcrumb_title: CDN-Unterstützung
relevantTo: [cordova]
weight: 1
---
## Übersicht
{: #overview }
Sie können konfigurieren, dass Anforderungen nach direkter Aktualisierung von einem CDN
(Content Delivery Network) anstatt von {{ site.data.keys.mf_server }} bedient werden.

#### Vorteile bei Verwendung eines CDN
{: #advantages-of-using-a-cdn }
Wenn Sie Anforderungen nach direkter Aktualisierung nicht mit
{{ site.data.keys.mf_server }}, sondern mit einem CDN bedienen, ergeben sich
folgende Vorteile: 

* {{ site.data.keys.mf_server }} wird vom Netzaufwand entlastet.
* Die bei Bedienung von Anforderungen mit
{{ site.data.keys.mf_server }} erreichte Übertragungsrate von 250 MB/s wird überschritten.
* Alle Benutzer machen unabhängig von ihrem Standort eine einheitlichere Erfahrung mit der direkten Aktualisierung.

#### Allgemeine Voraussetzungen
{: #general-requirements }
Wenn Sie Anforderungen nach direkter Aktualisierung mit einem CDN bedienen möchten, müssen Sie sicherstellen,
dass Ihre Konfiguration die folgenden Bedingungen erfüllt:

* Das CDN muss ein Reverse Proxy sein, der dem {{ site.data.keys.mf_server }} (oder ggf. einem weiteren
Reverse Proxy) vorgeschaltet ist.
* Wenn Sie die Anwendung in Ihrer Entwicklungsumgebung
erstellen, geben Sie als Zielserver den Host und Port des CDN an und nicht den Host und Port von
{{ site.data.keys.mf_server }}. Wenn Sie beispielsweise
den MobileFirst-CLI-Befehl
"mfpdev
server add" ausführen, geben Sie den Host und Port des CDN an. 
* In der CDN-Verwaltungsanzeige müssen Sie die folgenden URLs für direkte Aktualisierung für das Caching vorsehen, damit das CDN alle
Anforderungen bis auf die Anforderungen nach direkter Aktualisierung an den
{{ site.data.keys.mf_server }} übergibt. Bei Anforderungen nach direkter Aktualisierung
prüft das CDN,
ob es den Inhalt abgerufen hat. Ist das der Fall, gibt es den Inhalt zurück, ohne sich an den
{{ site.data.keys.mf_server }} zu wenden.
Andernfalls nimmt es Kontakt zum {{ site.data.keys.mf_server }} auf,
ruft das Archiv für die direkte Aktualisierung (ZIP-Datei) ab und speichert sie für die nächsten an diese URL gerichteten Anforderungen. Für Anwendungen, die mit
Version 8.0 der {{ site.data.keys.product_full }} erstellt wurden, lautet die URL für direkte Aktualisierung `PROTOKOLL://DOMÄNE:PORT/KONTEXTPFAD/api/directupdate/VERSION/KONTROLLSUMME/TYP`.
Das Präfix `PROTOKOLL://DOMÄNE:PORT/KONTEXTPFAD` ist bei
allen Laufzeitanforderungen konstant. Beispiel: http://my.cdn.com:9080/mfp/api/directupdate/0.0.1/742914155/full?appId=com.ibm.DirectUpdateTestApp&clientPlatform=android

Das
Beispiel enthält zusätzliche Anforderungsparameter, die auch Teil der Anforderung sind.

* Das CDN muss das Caching der Anforderungsparameter erlauben. Zwei Archive für direkte Aktualisierung unterscheiden sich möglicherweise nur
durch ihre Anforderungsparameter. 
* Das CDN muss TTL für die Antwort zur direkten Aktualisierung unterstützen, damit mehrere direkte Aktualisierungen auf dieselbe Version
möglich sind.
* Das CDN darf die im
-Server-Client-Protokoll verwendeten HTTP-Header weder ändern noch entfernen.

## Beispielkonfiguration
{: #example-configuration }
In diesem Beispiel wird eine
Akamai-CDN-Konfiguration verwendet, bei der das Archiv für direkte Aktualisierung zwischengespeichert wird. Folgende Aufgaben werden vom Netzadministrator, vom {{ site.data.keys.product_adj }}-Administrator und vom Akamai-Administrator ausgeführt:

#### Netzadministrator
{: #network-administrator }
Er erstellt für Ihren {{ site.data.keys.mf_server }} eine
weitere Domäne im DNS.
Wenn Ihre Serverdomäne beispielsweise yourcompany.com ist, muss eine zusätzliche Domäne wie
`cdn.yourcompany.com` erstellt werden. Im DNS setzt er für die neue Domäne `cdn.yourcompany.com` einen `CNAME` auf den von Akamai angegebenen Domänennamen, z. B. auf `yourcompany.com.akamai.net`. 

#### {{ site.data.keys.product_adj }}-Administrator
{: #mobilefirst-administrator }
Er legt die neue Domäne cdn.yourcompany.com als MobileFirst-Server-URL für die
{{ site.data.keys.product_adj }}-Anwendungen fest.
Für die Ant-Builder-Task lautet die Eigenschaft beispielsweise `<property name="wl.server" value="http://cdn.yourcompany.com/${contextPath}/"/>`.

#### Akamai-Administrator
{: #akamai-administrator }
1. Er öffnet den Akamai Property Manager und setzt die Eigenschaft **host name** auf den Wert der
neuen Domäne.


    ![Wert der Eigenschaft 'host name' auf die neue Domäne setzen](direct_update_cdn_3.jpg)
    
2. Auf der Registerkarte "Default Rule" konfiguriert er
Host und Port des ursprünglichen {{ site.data.keys.mf_server }} und setzt den
Wert **Custom Forward Host Header** auf die neu erstellte Domäne.


    ![Wert der Eigenschaft 'Custom Forward Host Header' auf neu erstellte Domäne setzen](direct_update_cdn_4.jpg)
    
3. Wählen Sie in der Liste **Caching Option** den Eintrag **No Store** aus. 

    ![Eintrag 'No Store' in der Liste 'Caching Option' auswählen](direct_update_cdn_5.jpg)

4. Konfigurieren Sie auf der Registerkarte **Static Content** die Übereinstimmungskriterien nach Maßgabe der Anwendungs-URL für direkte Aktualisierung. Erstellen Sie beispielsweise eine Bedingung `If Path matches one of URL_für_direkte_Aktualisierung`.

    ![Übereinstimmungskriterien nach Maßgabe der Anwendungs-URL für direkte Aktualisierung konfigurieren](direct_update_cdn_6.jpg)
    
5. Legen Sie Werte ähnlich den folgenden fest, um das Caching-Verhalten so zu konfigurieren, dass die URL für direkte Aktualisierung zwischengespeichert und die Lebensdauer (TTL) festgelegt wird.

    | Feld | Wert |
    |-------|-------|
    | Caching Option | Cache |
    | Force Revaluation of Stale Objects | Serve stale if unable to validate |
    | Max-Age | 3 minutes |

    ![Werte zum Konfigurieren des Caching-Verhaltens festlegen](direct_update_cdn_7.jpg)

6. Konfigurieren Sie das Verhalten für den Cacheschlüssel so, dass im Cacheschlüssel alle Anforderungsparameter verwendet werden. (Dies ist notwendig, damit verschiedene Archive für die direkte Aktualisierung für verschiedene Anwendungen oder Versionen zwischengespeichert werden können.) Wählen Sie beispielsweise in der Liste **Behavior** die `Option Include all parameters (preserve order from request)` aus.

    ![Verhalten des Cacheschlüssels so konfigurieren, dass alle Anforderungsparameter in dem Schlüssel verwendet werden](direct_update_cdn_8.jpg)


