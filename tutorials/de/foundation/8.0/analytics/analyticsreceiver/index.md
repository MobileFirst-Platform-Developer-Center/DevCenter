---
layout: tutorial
title: Analytics Receiver
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Der {{ site.data.keys.mf_analytics_receiver_short }} ist ein optionaler Service, der eingerichtet werden kann, um Ereignisprotokolle von mobilen Anwendungen zu empfangen und unter Verwendung einer speicherinternen Ereigniswarteschlange schrittweise an {{ site.data.keys.mf_analytics_short }} weiterzuleiten. Der {{ site.data.keys.mf_analytics_receiver_short }} speichert die Protokolle in einer speicherinternen Ereigniswarteschlange, bevor er sie an {{ site.data.keys.mf_analytics }} sendet.

Gemäß Standardeinrichtung und -konfiguration empfängt der {{ site.data.keys.mf_server }} alle Clientereignisprotokolle und leitet sie an {{ site.data.keys.mf_analytics }} weiter. Wenn es eine große Anzahl von Geräten gibt, die mobilen Clientanwendungen intensiv genutzt werden und sehr viele Analysedaten von Clientanwendungen protokolliert und gesendet werden, kann dies die Leistung des {{ site.data.keys.mf_server }} beeinträchtigen. Wird der {{ site.data.keys.mf_analytics_receiver_short }} aktiviert, kommt es zu einer Entlastung von {{ site.data.keys.mf_server }} von der Bearbeitung von Analyseereignissen, sodass Ressourcen von {{ site.data.keys.mf_server }} voll für Laufzeitfunktionen genutzt werden können. 

Der {{ site.data.keys.mf_analytics_receiver_short }} kann jederzeit eingerichtet und konfiguriert werden. Aktualisieren Sie die mobilen Clientanwendungen mit den neuesten Mobile-Foundation-Client-SDKs. Der Anwendungscode muss nicht geändert werden. Aktualisieren Sie die JNDI-Eigenschaften von {{ site.data.keys.mf_server }} mit den Konfigurationen des {{ site.data.keys.mf_analytics_receiver_short }}, damit der Analytics-Receiver-Endpunkt den Clientanwendungen für das Senden von Analyseereignissen zur Verfügung steht. 

![Analytics-Receiver-Topologie](AnalyticsTopology.png)

## Analytics-Receiver-Konfiguration
{: #analytics-receiver-configuration }

Die Analytics-Receiver-WAR-Datei wird bei der Installation von
MobileFirst Server ebenfalls installiert.
Weitere Informationen finden Sie unter "MobileFirst-Server-Verteilungsstruktur". 

* Informationen zur Installation von {{ site.data.keys.mf_analytics_receiver_server }} finden Sie im [{{ site.data.keys.mf_analytics_receiver_server }} Installationshandbuch](../../installation-configuration/production/analyticsreceiver/installation).
* Informationen zur Konfiguration des IBM MobileFirst Analytics Receiver finden Sie im [Konfigurationshandbuch](../../installation-configuration/production/analyticsreceiver/configuration).

* Führen Sie nach der Installation des {{ site.data.keys.mf_analytics_receiver_short }} eine kurze Konfigurationsprüfung durch. Stellen Sie sicher, dass die folgenden JNDI-Eigenschaften auf {{ site.data.keys.mf_analytics }} zeigen.

  | Eigenschaft |Beschreibung | Standardwert |
  |------------------------------------|-------------------------------------------------------|---------------|
  | receiver.analytics.url                  | Die von {{ site.data.keys.mf_analytics_server }} zugänglich gemachte URL für den Empfang eingehender Analysedaten (erforderlich). Beispiel: http://hostname:port/analytics-service/rest |Keiner |
  | receiver.analytics.username             |Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
  | receiver.analytics.password             |Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
  | receiver.analytics.event.qsize          | Die Größe der Warteschlange für Analyseereignisse (optional). Dieser Wert sollte mit Bedacht hinzugefügt werden und eine großzügige Auslegung des JVM-Heapspeichers berücksichtigen. Standardwarteschlangengröße: 10000 |Keiner |

* Wenn Sie den Receiver als *loguploader* für das Hochladen von Protokollen verwenden möchten, müssen die folgenden JNDI-Eigenschaften in {{ site.data.keys.mf_server }} definiert sein. Diese JNDI-Eigenschaften müssen auf {{ site.data.keys.mf_analytics_receiver_server }} zeigen.

  | Eigenschaft |Beschreibung | Standardwert |
  |------------------------------------|-------------------------------------------------------|---------------|
  | mfp.analytics.receiver.url                  |Die von {{ site.data.keys.mf_analytics_receiver_server }} zugänglich gemachte URL für den Empfang eingehender Analysedaten (erforderlich). Beispiel: http://hostname:port/analytics-receiver/rest |Keiner |
  | mfp.analytics.receiver.username             |Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
  | mfp.analytics.receiver.password             |Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |

* Stellen Sie sicher, dass das Setup von {{ site.data.keys.mf_analytics_short }} nicht mit {{ site.data.keys.mf_server }} kollidiert, denn Serverprotokolle werden weiterhin direkt von {{ site.data.keys.mf_server }} an {{ site.data.keys.mf_analytics_server }} übertragen.

## Fehlerbehebung
{: #troubleshooting }

Informationen zur Fehlerbehebung für {{ site.data.keys.mf_analytics_receiver }} finden Sie unter [Behebung von Analytics-Receiver-Fehlern](../../troubleshooting/analyticsreceiver/).
