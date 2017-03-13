---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

{{ site.data.keys.mf_analytics_full }} erfasst Daten von Aktivitäten zwischen App und Server, aus Clientprokollen, von Clientabstürzen sowie aus
clientseitigen Protokollen von {{ site.data.keys.mf_server }} und von Clientgeräten. Anhand der erfassten Daten erhalten Sie
tiefe Einblicke in die mobile Umgebung und die Serverinfrastruktur. Zum Lieferumfang gehören Standardberichte zur Kundenbindung, Absturzberichte, Berichte mit Aufgliederungen nach Gerätetyp und Betriebssystem, mit kundenspezifischen Daten
und Diagrammen, Berichte zur Netznutzung, Berichte mit den Ergebnissen von Push-Benachrichtigungen, Berichte zum App-internen Verhalten, die Erfassung von Debug-Protollen und vieles mehr. 

{{ site.data.keys.mf_server }} ist bei Lieferung für die Erstellung von Berichten zur Netzinfrastruktur
instrumentiert. Wenn der Client und der Server ihre Netznutzung melden, werden die Daten zusammengefasst. Sie können dann ausmachen, ob die Verantwortung für eine schwache Leistung beim Netz, beim Server oder bei den
Back-End-Systemen liegt. Außerdem können Sie steuern,
auf welche Logger-Daten Analytics zugreift, indem Sie Filter auf der Clientseite und für den
{{ site.data.keys.mf_analytics_server }} definieren. Sie wählen aus, wie ausführlich die Ereignisse gemeldet werden,
legen die Datenaufbewahrungsrichtlinie, definieren bedingte Alerts, erstellen kundenspezifische Diagramme und beschäftigen sich mit neuen Daten. 

#### Plattformunterstützung
{: #platform-support }

{{ site.data.keys.mf_analytics }} unterstützt Folgendes: 

* Native iOS- und Android-Clients
* Cordova-Anwendungen (iOS, Android)
* Webanwendungen
* Es gibt **keine** Unterstützung für Windows 8.1 Universal oder Windows 10 UWP. 

IBM {{ site.data.keys.mf_server }} ist bei Lieferung für die Erstellung von Berichten zur Netzinfrastruktur
instrumentiert. Wenn der Client und der Server ihre Netznutzung mleden, werden die Daten zusammengefasst. Sie können dann ausmachen, ob die Verantwortung für eine schwache Leistung beim Netz, beim Server oder bei den
Back-End-Systemen liegt. 

## Cliententwicklung
{: #client-development }

Zwei Clientklassen (Logger und Analytics) arbeiten zusammen, um Rohdaten an den Server zu senden. 

### Analytics-API
{: #the-analytics-api }

Die Analytics-Client-API erfasst Daten zu einer Vielzahl von Ereignissen
und sendet die Daten an {{ site.data.keys.mf_analytics_server }}.
> Weitere Informationen enthält das Lernprogramm [Analytics-Cliententwicklung](analytics-api).

### Logger-API
{: #the-logger-api }

Der Logger fungiert als Standard-Logger. Vom Client können Sie auch Logger-Daten für jede
Protokollierungsstufe an {{ site.data.keys.mf_analytics_server }}
senden. Ab welcher Stufe Protokollierungsanforderungen zulässig sind, wird jedoch von der Serverkonfiguration gesteuert. Anforderungen unterhalb dieser Stufe werden ignoriert. 

Die Protokollierungsstufen müssen kontrolliert werden, um zwei Anforderungen ins Gleichgewicht zu bringen. Zum einen besteht ein Bedarf, Informationen zu erfassen, und zum anderen
gibt es die Anforderung, die Datenmenge zu beschränken, weil die Speichermöglichkeiten begrenzt sind. 

> Weitere Informationen enthält das Lernprogramm [Clientprotokollierung](../application-development/client-side-log-collection/).



Außerdem können Sie steuern,
auf welche Logger-Daten Analytics zugreift, indem Sie Filter auf der Clientseite und für den
{{ site.data.keys.mf_analytics_server }} definieren.

## Analytics Console und Operations Console
{: #the-analytics-and-operations-consoles }

Die {{ site.data.keys.product_full }} stellt eine Analytics Console und eine Operations Console bereit. In der
{{ site.data.keys.mf_console_full }} wird definiert, wie Analytics Server mit den Clientanwendungen arbeitet. In der
{{ site.data.keys.mf_analytics_console_full }} werden die verschiedenen Analytics-Berichte konfiguriert und angezeigt. 

> Weitere Informationen enthält das Lernprogramm [Operations Console](console).



> Weitere Informationen zur Erstellung kundenspezifischer Diagramme in der Analytics Console enthält das Lernprogramm
[Kundenspezifische Diagramme](console/custom-charts). 

## Analytics Server
{: #the-analytics-server }

Analytics Server ist sowohl in der Entwicklungs- als auch in der Produktionsumgebung verfügbar.

Für die Entwicklung wird Analytics Server zusammen mit dem {{ site.data.keys.mf_dev_kit }} installiert. Weitere Informationen
finden Sie unter
[{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../installation-configuration/development/mobilefirst/). Wenn das Kit installiert ist,
steht die {{ site.data.keys.mf_analytics_console_short }} für Ihre Entwicklungsaufgaben zur Verfügung. 

Für die Produktion sind je nach
Infrastruktur, Geschäftsanforderungen,
Systemdesign usw. andere Installations- und Konfigurationsoptionen verfügbar. Weitere Informationen
finden Sie unter [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../installation-configuration/production/analytics/).

{{ site.data.keys.mf_analytics }} verwendet Elasticsearch. [Informieren Sie sich über die
Nutzung von Elasticsearch](elasticsearch) in der {{ site.data.keys.product }}.

## Fehlerbehebung
{: #troubleshotting }

Informationen zur Fehlerbehebung für {{ site.data.keys.mf_analytics }} finden Sie unter [Behebung von Analytics-Fehlern](../troubleshooting/analytics/).

## Nächste Abschnitte
{: #what-to-read-next }
