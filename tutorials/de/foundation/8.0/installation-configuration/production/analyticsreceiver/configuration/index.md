---
layout: tutorial
title: MobileFirst Analytics Receiver Server Konfigurationshandbuch
breadcrumb_title: Konfigurationshandbuch
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Informationen zur Konfiguration von {{ site.data.keys.mf_analytics_receiver_server }}.

#### Fahren Sie mit folgendem Abschnitt fort:
{: #jump-to }

* [Konfigurationseigenschaften](#configuration-properties)

### Eigenschaften
{: #properties }
Eine vollständige Liste der Konfigurationseigenschaften finden Sie im Abschnitt
[Konfigurationseigenschaften](#configuration-properties). Dort ist
auch beschrieben, wie die Eigenschaften in Ihrem Anwendungsserver definert werden. 

## Konfigurationseigenschaften
{: #configuration-properties }
{{ site.data.keys.mf_analytics_receiver_server }} kann mit der folgenden Zusatzkonfiguration gestartet werden. 

Die Konfiguration erfolgt mit JNDI-Eigenschaften in {{ site.data.keys.mf_server }} und
{{ site.data.keys.mf_analytics_receiver_server }}.
{{ site.data.keys.mf_analytics_receiver_server }}
unterstützt außerdem die Steuerung der Konfiguration mithilfe von Umgebungsvariablen, die dann Vorrang vor den JNDI-Eigenschaften haben. 

Die Laufzeitwebanwendung Analytics Receiver
muss neu gestartet werden, damit Änderungen an diesen Eigenschaften wirksam werden. Der gesamte Anwendungsserver muss nicht neu gestartet
werden. 

Wenn Sie eine JNDI-Eigenschaft für WebSphere Application Server Liberty festlegen möchten, fügen Sie wie folgt einen Tag zur Datei `server.xml` hinzu: 

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Wenn Sie eine JNDI-Eigenschaft für Tomcat festlegen möchten, fügen Sie wie folgt einen Tag zur Datei `context.xml` hinzu: 

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

Die JNDI-Eigenschaften von WebSphere Application Server sind als Umgebungsvariablen verfügbar. 

* Wählen Sie in der WebSphere-Application-Server-Konsole **Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen** aus.
* Wählen Sie die Anwendung für **{{ site.data.keys.product_adj }}-Verwaltungsservices** aus. 
* Klicken Sie unter **Eigenschaften des Webmoduls** auf **Umgebungseinträge für Webmodule**, um die JNDI-Eigenschaften anzuzeigen.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
In der folgenden Tabelle sind Eigenschaften angegeben, die in {{ site.data.keys.mf_analytics_receiver_server }} festgelegt werden können.

|Eigenschaft |Beschreibung |Standardwert |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          |Setzen Sie diese Eigenschaft auf die URL Ihrer {{ site.data.keys.mf_analytics_console }}, z. B. `http://Hostname:Port/analytics/console`. Bei Festlegung dieser Eigenschaft wird das Analysesymbol in der {{ site.data.keys.mf_console }} aktiviert. |Keiner |
| receiver.analytics.url                  | Die von {{ site.data.keys.mf_analytics_server }} zugänglich gemachte URL für den Empfang eingehender Analysedaten (erforderlich). Beispiel: `http://Hostname:Port/analytics-service/rest`. |Keiner |
| receiver.analytics.username             |Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
| receiver.analytics.password             |Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
| receiver.analytics.event.qsize          | Die Größe der Warteschlange für Analyseereignisse. Dieser Wert sollte mit Bedacht hinzugefügt werden und eine großzügige Auslegung des JVM-Heapspeichers berücksichtigen. Standardwarteschlangengröße: 10000 |Keiner |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
In der folgenden Tabelle sind Eigenschaften angegeben, die in {{ site.data.keys.mf_server }} festgelegt werden können.

|Eigenschaft |Beschreibung |Standardwert |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  |Die von {{ site.data.keys.mf_analytics_receiver_server }} zugänglich gemachte URL für den Empfang eingehender Analysedaten und die Weiterleitung der Daten zu {{ site.data.keys.mf_analytics_server }} (erforderlich). Beispiel: `http://Hostname:Port/analytics-receiver/rest`. |Keiner |
| mfp.analytics.receiver.username             |Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
| mfp.analytics.receiver.password             |Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. |Keiner |
