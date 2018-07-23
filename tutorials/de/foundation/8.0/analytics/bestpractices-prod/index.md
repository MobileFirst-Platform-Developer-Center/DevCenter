---
layout: tutorial
title: Bewährte Verfahren für die Einrichtung eines MobileFirst-Analytics-Produktionsclusters
breadcrumb_title: Best Practices
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

In diesem Abschnitt sind bewährte Verfahren für das Einrichten eines Analytics Server in der Produktion beschrieben. Sie erfahren, was zu tun ist und was Sie nicht tun dürfen.


## {{site.data.keys.mf_analytics_server }} - Konfigurationseinstellungen
{: #mfp-analytics-config }

In der Produktionsumgebung muss es zwingend eine Datenbereinigung geben, damit nicht die Gesamtheit der Dokumente von Anfang an auf Platte gespeichert werden. Wenn Sie für verschiedene Ereignisdokumente die passenden TTL-Werte festlegen, können Sie den Suchbereich für Elasticsearch-Abfragen erheblich reduzieren.
Nachfolgend sind die TTL-Werte angegeben, die für MobileFirst Analytics Server Version 8.0 festgelegt werden müssen: 

**TTL-Eigenschaften für Analytics-Ereignnise/Dokumente**

* TTL_PushNotification
*  TTL_PushSubscriptionSummarizedHourly
*  TTL_ServerLog
*  TTL_AppLog 
* TTL_NetworkTransaction 
* TTL_AppSession
*  TTL_AppSessionSummarizedHourly
*  TTL_NetworkTransactionSummarizedHourly 
* TTL_CustomData
* TTL_AppPushAction
*  TTL_AppPushActionSummarizedHourly
*  TTL_PushSubscription

**Verwendungsbeispiel:**
```xml
<jndiEntry jndiName="analytics/TTL_AppLog" value= '"20d"' />
```

> Es wird erwartet, dass TTL-Werte Zeichenfolgeliterale sind, die in einfache Anführungszeichen gesetzt übergeben werden müssen. 

## {{site.data.keys.mf_analytics_server }} - Topologie
{: #mfp-analytics-topology }

Analytics-Cluster mit mehreren Knoten
*	Es ist wichtig, dass den Knoten ein Load Balancer vorgeschaltet ist, um sicherzustellen, dass die Belastung der Analyseschicht gleichmäßig auf die Knoten verteilt ist. 
*	Wenn in einem Analytics-Cluster mit zwei Knoten kein Load Balancer verwendet wird, ist es sinnvoll, die Analytics Console des Knotens zu konfigurieren oder zu verwenden, der keine Daten von MobileFirst Server akzeptiert.

**Beispiel:**

Nehmen wir an, es gibt zwei Knoten für den Analytics Server.
In einem solchen Fall wird die folgende MobileFirst-Server-Konfiguration für Analytics empfohlen:

**Empfohlen:**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node2:9080/analytic/console*

**NICHT empfohlen:**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node1:9080/analytic/console*

So kann der Benutzer die Arbeitslast der Knoten reduzieren, wenn der Benutzer die Analytics Console anzeigt. 

## {{ site.data.keys.mf_analytics_server }} - Leistungsoptimierung
{: #mfp-analytics-perf-tuning }

### Optimierung des Betriebssystems
{: #os-tuning }

* Erhöhen Sie die zulässige Anzahl offener Dateideskriptoren auf 32 K oder 64 K.
* Erhöhen Sie die Anzahl der virtuellen Speicherzuordnungen.

>**Hinweis:** Informieren Sie sich anhand der Dokumentation zum verwendeten Betriebssystem. 

### Optimierung des Anwendungsservers
{: #app-server-tuning }

Wenn Sie WebSphere Application Server Liberty Profile bis Version 8.5.5.6 verwenden, müssen Sie die Einstellungen für die Thread-Pool-Größe der JVM explizit optimieren. 

Dies hat viele Benutzer dazu bewogen, die **coreThreads** auf einen hohen Wert zu setzen, damit es auf keinen Fall zu einem Deadlock des Steuerprogramms kommt. In Version 8.5.5.6 wurde allerdings der Algorithmus für automatische Optimierung so modifiziert, dass er aggresiv versucht, Deadlocks zu verhindern. Jetzt ist ein Deadlock des Steuerprogramms fast unmöglich. Wenn Sie also bisher die **coreThreads** so eingestellt haben, dass Deadlocks des Steuerprogramms verhindert werden, könnten Sie dies überdenken und wieder den Standardwert nutzen, sobald Sie auf Version 8.5.5.6 umgestellt haben.

**Beispiel:**

```xml
<executor name="LargeThreadPool" id="default"  coreThreads="200" maxThreads="400" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```     

### Analytics-Optimierung
{: #analytics-tuning }

* Die beiden Java-Optionen **Xms** und **Xmx** (für Minimum und Maximum) müssen auf denselben Wert gesetzt werden.
* Maximal zulässige Heapspeichergröße pro JVM < = RAM-Größe/2
* Anzahl der primären Shards = Anzahl der Knoten im Analytics Cluster
* Anzahl der Replikate pro Shard >= 2

> **Hinweis:** Wenn es nur einen Knoten gibt, benötigen Sie keine Replikate.

### Elasticsearch-Optimierung
{: #es-tuning }

Die Elasticsearch-Optimierung kann in einer separaten YAML-Datei (z. B. mit dem Namen `elasticsearchconfig.yml`) ausgeführt werden. Der Pfad zu dieser Datei kann in der Analytics-Server-Konfiguration (mit den JNDI-Eigenschaften) konfiguriert werden.

**Eigenschaftsname:** *analytics/settingspath*<br/>
**Wert:** *\<Pfad_zu_elasticsearchconfig.yml\>*

Wenden Sie die Elasticsearch-Optimierungsparameter an, indem Sie die Werte zu einer `.yml`-Datei hinzufügen und mit dem JNDI-Eintrag auf diese zugreifen.

Die Elasticsearch-Optimierungsparameter können zunächst für eine grundlegende Optimierung der Umgebung verwendet werden. Später kann eine weitergehende Optimierung auf der Basis der Infrastrukturressourcen erfolgen.

1. Legen Sie einen Wert für **indices.fielddata.cache.size** fest.

   Beispiel:
   ```
   indices.fielddata.cache.size:  35%
   ```  

   >**Hinweis:** Verwenden Sie **analytics/indices.fielddata.cache.size** mit Vorsicht.
   > Wählen Sie keinen zu hohen Wert für diesen Parameter, da es sonst zu Speicherengpässen kommen kann. Die der Analytics-Plattform zugrunde liegende Technologie lädt mehrere Feldwerte in den Speicher, um einen schnelleren Zugriff auf die entsprechenden Dokumente zu ermöglichen. Dieser Speicher wird als Cache für Feldwerte bezeichnet. Standardmäßig ist die Menge der Daten, die in den Cache für Feldwerte geladen werden können, unbegrenzt. Wenn der Cache für Feldwerte zu groß wird, kann es zu einer Ausnahme aufgrund von nicht ausreichendem Speicher und zum Absturz der Analytics-Plattform kommen.

2. Legen Sie einen Wert für **indices.fielddata.breaker.limit** fest.

   Setzen Sie **indices.fielddata.breaker.limit** auf einen Wert, der größer als der Wert von **indices.fielddata.cache.size** ist.

   Wenn die Cachegröße bei *35%* liegt, müssen Sie "indices.fielddata.breaker.limit also auf einen Wert setzen, der größer als 35 ist. 

3. Legen Sie einen Wert für **indices.fielddata.cache.expire** fest.

   Dieser Wert gibt die Ablaufzeit für den Elasticsearch-Cache an und verhindert, dass der Cache übermäßig groß wird und den Heapspeicher ausfüllt.

   > **indices.fielddata.cache.expire**
   >
   > Diese zeitbasierte Einstellung bewirkt, dass Felddaten nach einer bestimmten Zeit der Inaktivität verfallen. Der Standardwert ist -1. Sie können beispielsweise 5 m für eine Verfallszeit von 5 Minuten angeben. 

4. Standarmäßig findet in Analytics KEINE Datenbereinigung statt.

   Konfigurieren Sie die Lebensdauer (TTL) so, dass eine angemessene Datenbereinigung durchgeführt wird. Andernfalls kann der Datenspeicher unbegrenzt anwachsen.

## {{ site.data.keys.mf_analytics_server }} - Was zu tun ist und was nicht getan werden sollte
{: #mfp-analytics-dos-donts }

-	Vermeiden Sie das Löschen des Verzeichnisses "analyticsData", wenn die Analytics-Knoten aktiv sind.
-	Vermeiden Sie in einem Cluster mit mehreren Knoten, dass derselbe Knoten für die Push-Übertragung von Ereignissen in den Analytics-Cluster und für den Zugriff auf die Konsole verwendet wird. Am besten wäre es, dem Analytics-Cluster einen Load Balancer vorzuschalten.
-	Vermeiden Sie für Analytics-Cluster die Anwendung von Methoden für Cluster von Anwendungsservern. Elasticsearch verwendet für die Clustererstellung eigene Knotenerkennungsverfahren.
-	Vermeiden Sie in IBM WebSphere Application Server Full Profile oder IBM WebSphere Application Server Network Deployment die Verwendung von OpenJDK (oder Sun Java) für Analytics.
-	Geben Sie für die Mindestgröße bzw. die maximale Größe des Heapspeichers von Analytics nie einen Wert an, der über der halben RAM-Größe für den Knoten liegt. Wenn Sie beispielsweise einen Knoten mit einer RAM-Größe von 16 GB haben, liegt die maximal zulässige Größe des Heapspeichers für Analytics bei 8 GB.
- Verwenden Sie für den Analytics-Cluster einen eindeutigen Namen (JNDI-Eigenschaft **analytics/clustername**). Vermeiden Sie die Verwendung des Standardnamens *worklight*.

## {{ site.data.keys.mf_analytics_server }} - SDK-Hinweise
{: #mfp-analytics-sdk-issues }

### 1. Cordova-Anwendungen müssen auf einer nativen Plattform für Lebenszyklusereignisse initialisiert werden, damit die Erfassung von App-Sitzungen möglich ist.
{: #mfp-cordova-apps-appsession }

In MobileFirst Platform Foundation Version 8.0 werden wird die Anzahl der App-Sitzungen erhöht/erfasst, wenn die App vom Hintergrund in den Vordergrund kommt.  

Für die Erfassung von App-Sitzungen werden Listener für Lebenszyklusereignisse hinzugefügt. Die nativen SDKs stellen geeignete APIs für das Hinzufügen dieser Listener bereit. Im Falle von Cordova gibt es jedoch keine JavaScript-API zum Hinzufügen solcher Listener für Lebenszyklusereignisse. Die Listener müssen vielmehr über native Plattform-APIs für Cordova-Anwendungen hinzugefügt werden. 

Auszug aus der [Dokumentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/analytics-api/#client-lifecycle-events):

<blockquote>Wenn das Analytics-SDK konfiguriert ist, werden auf dem Gerät des Benutzers App-Sitzungen aufgezeichnet. Wenn die App vom Vordergrund in den Hintergrund gelangt, wird in der {{ site.data.keys.mf_analytics_console_short }} eine Sitzung erstellt, die in {{ site.data.keys.mf_analytics }} aufgezeichnet wird. Wenn das Gerät für die Aufzeichnung von Sitzungen konfiguriert ist und Sie Ihre Daten senden, wird die {{ site.data.keys.mf_analytics_console_short }} mit Daten gefüllt (siehe unten). </blockquote>

Für eine Cordova-App auf der iOS-Plattform muss beispielsweise Folgendes zur Datei `AppDelegate.m` hinzugefügt werden:
```
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
[[WLAnalytics sharedInstance] send];
```
### 2. Anzeige angepasster Daten in der Analytics Console
{: #view-custom-data-console }

Für ein schnelles Auffinden der angepassten, an Analytics Server gesendeten Daten mithilfe der Analytics-Client-SDK-APIs können Sie den folgenden Schritt ausführen. 

Navigieren Sie zu **Analytics Console > Dashboard > Kundenspezifische Diagramme > Kundenspezifisches Diagramm erstellen**.

![Kundenspezifisches Diagramm erstellen]({{ site.baseurl }}/tutorials/en/foundation/8.0/analytics/bestpractices-prod/create_custom_chart.png)

Weitere Informationen finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/console/custom-charts/) in der Dokumentation.

## {{ site.data.keys.mf_analytics_server }} - Fehlerbehebung
{: #mfp-analytics-troubleshooting }

1.	Version der Kundenumgebung:<br/>
    Stellen Sie die Einzelangaben des gesamten Software-Stacks zusammen, einschließlich Betriebssystem, JDK/JRE, Anwendungsserver sowie Version und Buildversion der MobileFirst Platform Foundation.
2.	Vergleichen Sie die Umgebungsdetails mit der Softwarekompatibilitätsmatrix bzw. den Voraussetzungen für IBM MobileFirst Analytics.
3.	Stellen Sie die Topologie- und Hardwarespezifikationen für Analytics zusammen.
4.	Überprüfen Sie (bei Leistungsproblemen), ob eine Leistungsoptimierung durchgeführt wurde.
5.	Stellen Sie für MobileFirst Platform Foundation Server die Datei `server.xml` (Liberty) und die JNDI-Umgebungseinträge/Eigenschaften (WAS Full Profile bzw. ND) zusammen, um die Analytics-Integrationskonfiguration zu überprüfen.
6.	Erstellen Sie einen Screenshot der Analytics Console.
7.	Stellen Sie für Analytics die Datei `server.xml` (Liberty) und die JNDI-Umgebungseinträge/Eigenschaften (WAS Full Profile bzw. ND) zusammen, um die Analytics-Integrationskonfiguration zu überprüfen.
8.	Erfassen Sie die Ausgabe der REST-APIs, die im Abschnitt **Wichtige Befehle und APIs für die Fehlerbehebung in Analytics** aufgelistet sind.

## Dienstprogramme zur Fehlerbehebung
{: #urilities-for-troubleshooting }

Mit den folgenden Open-Source-Tools können Sie die Elasticsearch-Indizes, die Daten- und Shard-Zuordnungen usw. effektiv darstellen. 

-	[Cerebro](https://github.com/lmenezes/cerebro)
-	[Sense (Beta)](https://github.com/cheics/sense)

### Wichtige Befehle und APIs für die Fehlerbehebung in Analytics
{: #commands-apis}

Führen Sie mit cURL die folgenden REST-APIs aus, um die Antwort zur Identifizierung diverser Informationen zu Cluster/Shards/Indizes zu erfassen:
```
http://<es_node>:9500/_cluster/health
http://<es_node>:9500/_cluster/stats
http://<es_node>:9500/_cat/shards
http://<es_node>:9500/_node/status
http://<es_node>:9500/_cat/indices
```

## Referenzinformationen
{: #references}

*	[MobileFirst Analytics - Quick & Dirty Clusters](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/10/mobilefirst-analytics-quick-dirty-clusters/)
*	[MobileFirst Analytics - Planning for Production](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/01/mobilefirst-analytics-planning-for-production/)
*	[MobileFirst Analytics Server Installationshandbuch](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/installation-configuration/production/analytics/installation/)
*	[Setting JNDI property for Mobile Analytics Time To Live(TTL) value as days in Liberty Profile](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/03/liberty-analytics-jndi-ttl-setting/)
