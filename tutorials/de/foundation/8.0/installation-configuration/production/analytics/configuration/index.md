---
layout: tutorial
title: MobileFirst Analytics Server Konfigurationshandbuch
breadcrumb_title: Konfigurationshandbuch
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
{{ site.data.keys.mf_analytics_server }}
muss konfiguriert werden. Einige der Konfigurationsparameter gelten für einen Einzelknoten und andere Parameter gelten für den gesamten Cluster.
Welcher Parameter wofür gilt, ist jeweils angegeben. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Konfigurationseigenschaften](#configuration-properties)
* [Analytics-Daten sichern](#backing-up-analytics-data)
* [Cluster-Management und Elasticsearch](#cluster-management-and-elasticsearch)

### Eigenschaften
{: #properties }
Eine vollständige Liste der Konfigurationseigenschaften finden Sie unter
[Konfigurationseigenschaften](#configuration-properties). Dort ist
auch beschrieben, wie die Eigenschaften in Ihrem Anwendungsserver definert werden. 

* Die Eigenschaft **discovery.zen.minimum\_master\_nodes** muss auf
**ceil((Anzahl der Clusterknoten, die als Master infrage kommen / 2) + 1)** gesetzt werden, um das
Split-Brain-Problem zu vermeiden. 
    * Elasticsearch-Knoten in einem Cluster, die als Materknoten ausgewählt werden können, müssen ein Quorum herstellen, um zu entscheiden, welcher dieser Knoten der Masterknoten wird. 
    * Wenn Sie einen als Masterknoten infrage kommenden Knoten zum Cluster hinzufügen, ändert sich die Anzahl der Knoten, die als Masterknoten ausgewählt werden können. Die entsprechende Einstellung muss sich also auch ändern. Sie müssen die Einstellung modifizieren, wenn Sie neue,
als Mater infrage kommende Knoten zum Cluster hinzufügen. Weitere Informationen zur Verwaltung Ihres Clusters finden Sie unter [Cluster-Management und Elasticsearch](#cluster-management-and-elasticsearch).
* Definieren Sie die Eigenschaft **clustername** aller Knoten, um Ihren Cluster zu benennen. 
    * Benennen Sie die Cluster, da bei einem Cluster mit Standardnamen die Möglichkeit besteht, dass eine Entwicklerinstanz von Elasticsearch
versehentlich Teil des Clusters wird. 
* Legen Sie für jeden Knoten die Eigenschaft **nodename** fest, um jedem Knoten einen Namen zu geben. 
    * Elasticsearch benennt jeden Knoten standardmäßig nach einer zufällig ausgewählten Marvel-Figur. Außerdem hat jeder Knoten nach jedem Neustart einen anderen Namen. 
* Delarieren Sie explizit den Dateisystempfad zum Datenverzeichnis, indem Sie für jeden Knoten die Eigenschaft
**datapath** definieren.
* Deklarieren Sie explizit die dedizierten Masterknoten, indem Sie für jeden Knoten die Eigenschaft
**masternodes**
definieren. 

### Einstellungen für die Clusterwiederherstellung
{: #cluster-recovery-settings }
Nach einer horizontalen Skalierung auf einen Cluster mit mehreren Knoten werden Sie feststellen, dass gelegentlich ein Neustart des gesamten Clusters notwendig ist. Wenn ein Neustart des gesamten Clusters erforderlich ist, müssen Sie
die Einstellungen für Wiederherstellung berücksichtigen. Angenommen, der Cluster hat zehn Knoten und während der Cluster Knoten für Knoten
hochgefahren wird, geht der Masterknoten davon aus, dass er sofort bei Verfügbarkeit eines Knotens im Cluster mit dem Lastausgleich
beginnen muss. Wenn es zulässig ist, dass sich der Masterknoten so verhält, ist ein recht großer Neuverteilungsaufwand erforderlich. Sie müssen die Clustereinstellungen so konfigurieren, dass
eine Mindestanzahl von Knoten im Cluster verfügbar ist, bevor der Masterknoten beginnt, die Knoten zu einer Neuverteilung aufzufordern. Damit können Sie die Zeit für einen Clusterneustart von Stunden auf Minuten
verkürzen. 

* Die Eigenschaft **gateway.recover\_after\_nodes** muss auf Ihre Vorgabe gesetzt werden, um Elasticsearch an einer Neuverteilung zu hindern, bis die angegebene Anzahl Clusterknoten hochgefahren und im Cluster verfügbar sind. Wenn es in Ihrem Cluster 10 Knoten gibt,
ist 8 eine angemessene Einstellung für **gateway.recover\_after\_nodes**. 
* Die Eigenschaft **gateway.expected\_nodes** muss auf die von Ihnen erwartete Anzahl Clusterknoten gesetzt werden. In diesem Beispiel hat die Eigenschaft
**gateway.expected_nodes** den Wert 10. 
* Die Eigenschaft **gateway.recover\_after\_time** muss so eingestellt werden, dass der Masterknoten nach seinem Start mit dem Senden von Neuverteilungsanweisungen
wartet, bis diese Zeit abgelaufen ist. 

Die Kombination der obigen Eigenschaften bedeutet, dass Elasticsearch wartet, bis die von
**gateway.recover\_after\_nodes definierte Anzahl Knoten verfügbar ist. Im Anschluss daran wartet Elasticsearch die mit
**gateway.recover\_after\_time** angegebene Anzahl von Minuten oder Elasticsearch wartet, bis die mit
**gateway.expected\_nodes** definierte Anzahl Knoten im Cluster verfügbar ist, je nachdem, was zuerst eintritt. 

### Was ist zu vermeiden?
{: #what-not-to-do }
* Lassen Sie nicht Ihren Produktionscluster außer Acht. 
    * Cluster müssen überwacht und betreut werden. Für diese Aufgen stehen viele gute Elasticsearch-Überwachungstools zur Verfügung. 
* Verwenden Sie für Ihre **datapath**-Einstellung kein NAS (Network-attached Storage), da Sie damit einen Single Point of Failure hätten und die Latenzzeit verlängern würden. Verwenden Sie immer Platten der lokalen Hosts. 
* Vermeiden Sie unbedingt Cluster, die sich über mehrere Rechenzentren und/oder über große geografische Entferungen
erstrecken. Die Latenzzeit zwischen Knoten ist ein gravierender Leistungsengpass. 
* Finden Sie Ihre eigene Lösung für die Verwaltung der Clusterkonfiguration. Verfügbar sind viele gute Lösungen wie
Puppet, Chef und Ansible. 

## Konfigurationseigenschaften
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }}
kann ohne jede weitere Konfiguration gestartet werden. 

Die Konfiguration erfolgt mit JNDI-Eigenschaften in {{ site.data.keys.mf_server }} und
{{ site.data.keys.mf_analytics_server }}.
{{ site.data.keys.mf_analytics_server }}
unterstützt außerdem die Steuerung der Konfiguration mithilfe von Umgebungsvariablen, die dann Vorrang vor den JNDI-Eigenschaften haben. 

Die Laufzeitwebanwendung "Analytics"
muss neu gestartet werden, damit Änderungen an diesen Eigenschaften wirksam werden. Der gesamte Anwendungsserver muss nicht neu gestartet
werden. 

Wenn Sie eine JNDI-Eigenschaft für WebSphere Application Server Liberty festlegen möchten, fügen Sie wie folgt einen Tag zur Datei **server.xml** hinzu: 

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Wenn Sie eine JNDI-Eigenschaft für Tomcat festlegen möchten, fügen Sie wie folgt
einen Tag zur Datei context.xml hinzu: 

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

Die JNDI-Eigenschaften von WebSphere Application Server sind als Umgebungsvariablen verfügbar. 

* Wählen Sie in der WebSphere-Application-Server-Konsole **Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen** aus.
* Wählen Sie die Anwendung für **{{ site.data.keys.product_adj }}-Verwaltungsservices** aus. 
* Klicken Sie unter **Eigenschaften des Webmoduls** auf **Umgebungseinträge für Webmodule**, um die JNDI-Eigenschaften anzuzeigen.

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
In der folgenden Tabelle sind Eigenschaften angegeben, die in {{ site.data.keys.mf_server }} festgelegt werden können.

| Eigenschaft | Beschreibung | Standardwert |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url | Setzen Sie diese Eigenschaft auf die URL Ihrer {{ site.data.keys.mf_analytics_console }}, z. B. http://Hostname:Port/analytics/console. Bei Festlegung dieser Eigenschaft wird das Analysesymbol in der {{ site.data.keys.mf_console }} aktiviert. | Keiner |
| mfp.analytics.logs.forward | Wenn diese Eigenschaft auf "true" gesetzt ist, werden auf dem {{ site.data.keys.mf_server }} aufgezeichnete Serverprotokolle in {{ site.data.keys.mf_analytics }} erfasst. | true |
| mfp.analytics.url | Die von {{ site.data.keys.mf_analytics_server }} zugänglich gemachte URL für den Empfang eingehender Analysedaten (erforderlich). Beispiel: http://hostname:port/analytics-service/rest/v2 | Keiner |
| analyticsconsole/mfp.analytics.url |	Vollständige URI der Analytics-REST-Services (optional). In einem Szenario mit einer Firewall oder einem geschützten Reverse Proxy muss diese URI die externe URI und nicht die interne URI im lokalen Netz sein. Dieser Wert kann anstelle des URI-Protokolls, des Hostnamens oder des Ports der eingehenden URL das Zeichen * enthalten. *://*:*/analytics-service zeigt beispielsweise an, dass das Protokoll, der Hostname und der Port dynamisch bestimmt werden. |
| mfp.analytics.username | Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. | Keiner |
| mfp.analytics.password | Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt durch Basisauthentifizierung geschützt ist. | Keiner |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
In der folgenden Tabelle sind Eigenschaften angegeben, die in {{ site.data.keys.mf_analytics_server }} festgelegt werden können.

| Eigenschaft | Beschreibung | Standardwert |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Definiert den Typ des Elasticsearch-Knotens. Gültige Werte sind "master" und "data". Wenn diese Eigenschaft nicht definiert ist, kommt der Knoten als Master- und Datenknoten infrage. | 	Keiner |
| analytics/shards | Anzahl der vom Cluster pro Index erstellten Shards. Der Wert kann nur von dem im Cluster zuerst gestarteten Knoten definiert und nicht geändert werden. | 1 |
| analytics/replicas_per_shard | Diese Eigenschaft gibt die Anzahl der Replikate pro Shard im Cluster an. Dieser Wert kann in einem aktiven Cluster dynamisch geändert werden. | 0 |
| analytics/masternodes | Zeichenfolge mit Komma als Trennzeichen, die den Hostnamen und Port der Knoten angibt, die als Masterknoten infrage kommen | Keiner |
| analytics/clustername | Diese Eigenschaft gibt den Namen des Clusters an. Definieren Sie diesen Wert, wenn es in einer Untergruppe mehrere Cluster gibt, die eindeutig identifizierbar sein sollen. | worklight |
| analytics/nodename | Diese Eigenschaft gibt den Namen eines Knotens im Cluster an. | Zufällig generierte Zeichenfolge |
| analytics/datapath | Diese Eigenschaft gibt den Pfad an, unter dem Analysedaten im Dateisystem gespeichert werden. | ./analyticsData |
| analytics/settingspath | Pfad zu einer Datei mit Elasticsearch-Einstellungen. Weitere Informationen finden Sie unter "Elasticsearch". | Keiner |
| analytics/transportport | Diese Eigenschaft gibt den Port für die Knoten-zu-Knoten-Kommunikation an. | 9600 |
| analytics/httpport | Diese Eigenschaft gibt den Port für die HTTP-Kommunikation mit Elasticsearch an. | 9500 |
| analytics/http.enabled | Aktiviert oder inaktiviert die HTTP-Kommunikation mit Elasticsearch | false |
| analytics/serviceProxyURL | Die WAR-Datei für die Analysebenutzerschnittstelle und die WAR-Datei für den Analyseservice können in gesonderten Anwendungsservern installiert werden. In dem Fall müssen Sie wissen, dass die JavaScript-Laufzeit in der WAR-Datei für die Benutzerschnittstelle durch eine Cross-Site-Scripting-Prävention im Browser blockiert werden kann. Zur Umgehung dieser Blockade enthält die WAR-Datei für die Benutzerschnittstelle Java-Proxy-Code, der dafür sorft, dass die JavaScript-Laufzeit REST-API-Antworten vom ursprünglichen Server abruft. Der Proxy ist aber so konfiguriert, dass REST-API-Anforderungen an die WAR-Datei für den Analyseservice weiterteleitet werden. Konfigurieren Sie diese Eigenschaft, wenn Sie Ihre WAR-Dateien in separaten Anwendungsservern installiert haben. | Keiner |
| analytics/bootstrap.mlockall | Diese Eigenschaft verhindert, dass Elasticsearch-Speicher auf die Platte ausgelagert wird. | true |
| analytics/multicast | Aktiviert oder inaktiviert die Multicast-Knotenerkennung | false |
| analytics/warmupFrequencyInSeconds | Häufigkeit mit der Initialisierungsabfragen im Hintergrund ausgeführt werden, damit Abfrageergebnisse in den Speicher geschrieben werden. Dadurch verbessert sich die Leistung der Webkonsole. Negative Werte inaktivieren die Initialisierungsabfragen. | 600 |
| analytics/tenant | Name des Elasticsearch-Hauptindex. | worklight |

Immer, wenn der Schlüssel keinen Punkt enthält (wie bei **httpport**, aber nicht bei
**http.enabled**), kann die Einstellung mit Systemumgebungsvariablen gesteuert werden. Der Name der Variablen muss in dem Fall mit dem Präfix
**ANALYTICS_** versehen werden. Wenn sowohl die JNDI-Eigenschaft als auch die Systemumgebungsvariable definiert ist, hat die Systemumgebungsvariable
Vorrang. Wenn Sie beispielsweise
die JNDI-Eigenschaft **analytics/httpport** und die Systemumgebungsvariable
**ANALTYICS_httpport** definiert haben, wird der Wert für
**ANALYTICS_httpport** verwendet. 

#### Dokumentlebensdauer
{: #document-time-to-live-ttl }
Die Lebensdauer ist für das Erstellen und Verwalten einer Datenaufbewahrungsrichtlinie wichtig. Ihre Entscheidungen in diesem Bereich haben dramatische Auswirkungen auf Ihren Systemressourcenbedarf. Je länger Sie Daten aufbewahren, desto mehr
Arbeitsspeicher und Plattenspeicher und wahrscheinlich auch Skalierungskapazität benötigen Sie. 

Für jeden Dokumenttyp wird eine eigene Lebensdauer definiert. Ist für ein Dokument die Lebensdauer festgelegt, wird es für diese Dauer aufbewahrt und dann automatisch
gelöscht. 

Jede JNDI-Eigenschaft für die Lebensdauer hat den Namen **analytics/TTL_[Dokumenttyp]**. Die Lebensdauereinstellung für
**NetworkTransaction** hat beispielsweise den Namen
**analytics/TTL_NetworkTransaction**.

Die Werte können wie folgt mit Basiszeiteinheiten festgelegt werden: 

* 1Y = 1 Jahr
* 1M = 1 Monat
* 1w = 1 Woche
* 1d = 1 Tag
* 1h = 1 Stunde
* 1m = 1 Minute
* 1s = 1 Sekunde
* 1ms = 1 Millisekunde

Es folgt eine Liste der unterstützten Dokumenttypen: 

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **Hinweis:** Wenn Sie eine Migration für frühere Versionen von {{ site.data.keys.mf_analytics_server }} durchführen und zuvor JNDI-Eigenschaften für die Lebensdauer konfiguriert hatten, lesen Sie die Informationen unter [Von früheren Versionen von {{ site.data.keys.mf_analytics_server }} verwendete Servereigenschaften umstellen](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server).



#### Elasticsearch
{: #elasticsearch }
Elasticsearch ist die Speicher- und Clustering-Technologie, die der {{ site.data.keys.mf_analytics_console }} zugrunde liegt.   
In Elasticsearch gibt es viele einstellbare Eigenschaften, vor allem für die Leistungsoptimierung. Viele der JNDI-Eigenschaften sind Abstraktionen der Eigenschaften von
Elasticsearch.

Alle Eigenschaften von
Elasticsearch können auch mit einer JNDI-Eigenschaft festgelegt werden. Dazu muss dem Namen der JNDI-Eigenschaft
die Zeichenfolge **analytics/** vorangestellt werden. Die Eigenschaft **threadpool.search.queue_size** ist beispielsweise
eine der Eigenschaften von Elasticsearch. Sie kann mit folgender JNDI-Eigenschaft
definiert werden. 

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

Normalerweise werden diese Eigenschaften in einer angepassten Datei mit Einstellungen
definiert. Wenn Sie sich mit
Elasticsearch und dem Format der Eigenschaftendateien von Elasticsearch auskennen, können Sie mit der
JNDI-Eigenschaft **settingspath** wie folgt den Pfad zu der Datei mit Einstellungen
angeben. 

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

Sie sollten die Finger von diesen Einstellungen lassen, wenn Sie kein IT-Manager mit Fachkenntnissen zu Elasticsearch sind, keine konkrete Notwendigkeit besteht und Sie keine diesbezügliche Anweisung von Ihrem Service- oder Unterstützungsteam
erhalten haben. 

## Analysedaten sichern
{: #backing-up-analytics-data }
Hier können Sie sich über die Sicherung Ihrer MobileFirst-Analytics-Daten informieren. 

Die Daten für {{ site.data.keys.mf_analytics }}
werden als Dateien im Dateisystem des {{ site.data.keys.mf_analytics_server }}
gespeichert. Die Position des Ordners wird von der JNDI-Eigenschaft datapath
in der Konfiguration von {{ site.data.keys.mf_analytics_server }}
angegeben. Weitere
Informationen zu den JNDI-Eigenschaften finden Sie unter
[Konfigurationseigenschaften](#configuration-properties). 

Die Konfiguration von {{ site.data.keys.mf_analytics_server }}
wird auch im Dateisystem gespeichert, und zwar in der Datei server.xml.

Sie können diese Dateien mit ggf. bereits etablierten Serversicherungsverfahren sichern. Für die Sicherung dieser Dateien ist keine spezielles Vorgehen erforderlich.
Sie müssen lediglich sicherstellen, dass Sie den
{{ site.data.keys.mf_analytics_server }}
gestoppt haben. Andernfalls könnten sich Daten während der Sicherung ändern, was bedeuten würde, dass Speicher abgelegte Daten nicht in das Dateisystem
geschrieben werden würden. Stoppen Sie
{{ site.data.keys.mf_analytics_server }}
vor Beginn der Sicherung, um inkonsistente Daten zu vermeiden. 

## Cluster-Management und Elasticsearch
{: #cluster-management-and-elasticsearch }
Cluster müssen verwaltet und ggf. mit weiteren Knoten ergänzt werden, um die Last der Speicher- und Kapazitätsanforderungen im Rahmen zu halten. 

### Knoten zum Cluster hinzufügen
{: #add-a-node-to-the-cluster }
Sie können einen Knoten zum Cluster hinzufügen, indem Sie
{{ site.data.keys.mf_analytics_server }}
installieren oder eine eigenständige Elasticsearch-Instanz ausführen. 

Wenn Sie sich für die eigenständige Elasticsearch-Instanz entscheiden, entlasten Sie den Cluster hinsichtlich des Speicher- und Kapazitätsbedarfs, aber nicht hinsichtlich der
Datenaufnahme. Datenberichte müssen zur Wahrung der Datenintegrität und für eine Datenoptimierung auf dem Weg zum persistenten Speicher immer den
{{ site.data.keys.mf_analytics_server }} passieren. 

Sie können die Komponenten beliebig kombinieren. 

Der zugrunde liegende Elasticsearch-Datastore erwartet homogene Knoten, sodass Sie ein leistungsstarkes Rack mit 8 Kernen und 64 GB Arbeitsspeicher nicht mit einem
übrig gebliebenen Notebook in Ihrem Clluster kombinieren dürfen. Verwenden Sie für die Knoten vergleichbare Hardware. 

#### {{ site.data.keys.mf_analytics_server }} zum Cluster hinzufügen
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
Hier erfahren Sie, wie ein
{{ site.data.keys.mf_analytics_server }} zum
Cluster hinzugefügt wird. 

Da Elasticsearch in den {{ site.data.keys.mf_analytics_server }} integriert ist, können Sie das Clusterverhalten mit Elasticsearch definieren. Erstellen Sie beispielsweise keine
WebSphere-Application-Server-Liberty-Farm und verwenden Sie auch keine anderen Anwendungsserver-Setups. 

Konfigurieren Sie den Knoten im folgenden Beispiel nicht als Master- oder Datenknoten, sondern als
"Such-Load-Balancer", dessen Aufgabe darin besteht, temporär verfügbar zu sein, um die REST-API von Elasticsearch
für Überwachung und dynamische Konfiguration zugänglich zu machen. 

**Hinweise:**

* Denken Sie daran, dass die Hardware und das Betriebssystem dieses Knotens gemäß den [Systemvoraussetzungen](../installation/#system-requirements) konfiguriert werden müssen.
* Port 9600 ist der von Elasticsearch verwendete Transportport. Daher muss der Port 9600 in allen Firewalls zwischen den Clusterknoten geöffnet sein. 

1. Installieren Sie die WAR-Datei des Analyseservice und (sofern gewünscht) die WAR-Datei der Analysebenutzerschnittstelle
im Anwendungsserver auf dem neu eingerichteten System. Installieren Sie diese Instanz von {{ site.data.keys.mf_analytics_server }}
auf einem der unterstützten App-Server. 
    * [{{ site.data.keys.mf_analytics }} in WebSphere Application Server Liberty installieren](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [{{ site.data.keys.mf_analytics }} in Tomcat installieren](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [{{ site.data.keys.mf_analytics }} in WebSphere Application Server installieren](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. Bearbeiten Sie die Konfigurationsdatei des Anwendungsservers, um JNDI-Eigenschaften zu konfigurieren. (Sie können auch Systemumgebungsvariablen verwenden.) Konfigurieren Sie mindestens die folgenden Flags: 

    | Flag | Wert (Beispiel) | Standardwert | Hinweis |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	| worklight | 	Cluster, in den dieser Knoten aufgenommen werden soll |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Mit dem Wert "false" kann eine versehentliche Aufnahme in den Cluster verhindert werden. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Keiner | 	Liste der Masterknoten im Cluster. Ändern Sie den Standardport 9600, wenn Sie für die Masterknoten eine Einstellung für den Transportport angegeben haben. |
    | node.master | 	false | 	true | 	Dieser Knoten darf kein Masterknoten sein. |
    | node.data |	false | 	true | 	Auf diesem Knoten dürfen keine Daten gespeichert werden. |
    | http.enabled | 	true	| true | 	Öffnen Sie den nicht gesicherten HTTP-Port 9200 für die REST-API von Elasticsearch. |

3. Für Produktionsszenarien müssen Sie alle Konfigurationsflags sorgfältig überdenken. Wenn Sie beispielsweise möchten, dass
Elasticsearch die Plug-ins in einem anderen Dateisystemverzeichnis als die Daten aufbewahrt, müssen Sie das Flag
**path.plugins** setzen. 
4. Führen Sie den Anwendungsserver aus und starten Sie ggf. die WAR-Anwendungen. 
5. Vergewissern Sie sich, dass dieser neue Knoten in den Cluster aufgenommen wurde. Sehen Sie sich dazu die Konsolenausgabe auf dem neuen Knoten an oder beobachten Sie
in der
{{ site.data.keys.mf_analytics_console }} auf der Seite **Administration** die
Knotenanzahl im Abschnitt **Cluster und Knoten**.

#### Eigenständigen Elasticsearch-Knoten zum Cluster hinzufügen
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
Hier erfahren Sie, wie ein eigenständiger Elasticsearch-Knoten zum Cluster hinzugefügt wird. 

Sie können einen eigenständigen Elasticsearch-Knoten mit wenigen einfachen Schritten zu Ihrem MobileFirst-Analytics-Cluster hinzufügen. Sie müssen allerdings entscheiden, welche Rolle dieser Knoten haben soll. Soll potenziell als Masterknoten infrage kommen? Wenn ja, müssen Sie das
Split-Brain-Problem vermeiden. Soll der Knoten ein Datenknoten sein oder ein reiner Clientknoten?
Vielleicht benötigen Sie einen reinen Clientknoten, der temporär gestartet werden kann, um die REST-API von
Elasticsearch für dynamische Konfigurationsänderungen an Ihrem aktiven Cluster zugänglich zu machen. 

Konfigurieren Sie den Knoten im folgenden Beispiel nicht als Master- oder Datenknoten, sondern als
"Such-Load-Balancer", dessen Aufgabe darin besteht, temporär verfügbar zu sein, um die REST-API von Elasticsearch
für Überwachung und dynamische Konfiguration zugänglich zu machen. 

**Hinweise:**

* Denken Sie daran, dass die Hardware und das Betriebssystem dieses Knotens gemäß den [Systemvoraussetzungen](../installation/#system-requirements) konfiguriert werden müssen.
* Port 9600 ist der von Elasticsearch verwendete Transportport. Daher muss der Port 9600 in allen Firewalls zwischen den Clusterknoten geöffnet sein. 

1. Laden Sie Elasticsearch von [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz) herunter.
2. Entpacken Sie die Datei.
3. Bearbeiten Sie die Datei **config/elasticsearch.yml** und konfigurieren Sie mindestens die folgenden Flags.

    | Flag | Wert (Beispiel) | Standardwert | Hinweis |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	| worklight | 	Cluster, in den dieser Knoten aufgenommen werden soll |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Mit dem Wert "false" kann eine versehentliche Aufnahme in den Cluster verhindert werden. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Keiner | 	Liste der Masterknoten im Cluster. Ändern Sie den Standardport 9600, wenn Sie für die Masterknoten eine Einstellung für den Transportport angegeben haben. |
    | node.master | 	false | 	true | 	Dieser Knoten darf kein Masterknoten sein. |
    | node.data |	false | 	true | 	Auf diesem Knoten dürfen keine Daten gespeichert werden. |
    | http.enabled | 	true	| true | 	Öffnen Sie den nicht gesicherten HTTP-Port 9200 für die REST-API von Elasticsearch. |


4. Für Produktionsszenarien müssen Sie alle Konfigurationsflags sorgfältig überdenken. Wenn Sie beispielsweise möchten, dass
Elasticsearch die Plug-ins in einem anderen Dateisystemverzeichnis als die Daten aufbewahrt, müssen Sie das Flag
path.plugins setzen. 
5. Führen Sie `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` aus, um das ICU-Plug-in zu installieren. 
6. Führen Sie `./bin/elasticsearch` aus.
7. Vergewissern Sie sich, dass dieser neue Knoten in den Cluster aufgenommen wurde. Sehen Sie sich dazu die Konsolenausgabe auf dem neuen Knoten an oder beobachten Sie
in der
{{ site.data.keys.mf_analytics_console }} auf der Seite **Administration** die
Knotenanzahl im Abschnitt **Cluster und Knoten**.

#### Unterbrecher
{: #circuit-breakers }
Hier können Sie sich über die Unterbrecher von Elasticsearch informieren.

In Elasticsearch gibt es mehrere Unterbrecher, die verhindern, dass Operationen zu einem
**OutOfMemoryError** führen. Wenn beispielsweise eine Abfrage, die Daten für die {{ site.data.keys.mf_console }} liefert,
am Ende 40 % des JVM-Heapspeichers beansprucht, werden der Unterbrecher und eine Ausnahme ausgelöst und die Konsole empfängt leere Daten. 

In Elasticsearch gibt es auch Schutzmechanismen, die ein übermäßiges Füllen der Platte mit Daten verhindern sollen. Wenn die Platte, auf die gemäß Konfiguration der
Elasticsearch-Datastore geschrieben wird, zu 90 % gefüllt ist, informiert der Elasticsearch-Knoten den Masterknoten im Cluster. Der Masterknoten leitet dann neue Schreiboperationen für Dokumente auf andere Knoten um. Falls es in Ihrem Cluster nur einen Knoten gibt, ist kein zweiter Knoten verfügbar, auf den die Daten
geschrieben werden könnten. In dem Fall werden keine Daten geschrieben. Die Daten sind also verloren. 
