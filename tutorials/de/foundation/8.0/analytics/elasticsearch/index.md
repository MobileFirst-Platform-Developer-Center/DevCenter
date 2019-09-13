---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

{{ site.data.keys.mf_analytics_full }} verwendet **Elasticsearch 1.7.5**, um Daten zu speichern und Suchabfragen auszuführen.   

Elasticsearch ist eine verteilte Echtzeitsuchmaschine und -analyseengine, mit der mehr Daten in kürzerer Zeit gespeichert und durchsucht werden können. Elasticsearch wird für die Volltextsuche und die strukturierte Suche verwendet. 

Elasticsearch wird verwendet, um alle mobilen und Serverdaten im JSON-Format in den Elasticsearch-Instanzen
in {{ site.data.keys.mf_analytics_server }} zu speichern. 

Die Elasticsearch-Instanzen werden in Echtzeit abgefragt, um die {{ site.data.keys.mf_analytics_console_full }} mit Daten zu füllen.

Über {{ site.data.keys.mf_analytics }} sind sämtliche Elasticsearch-Funktionen zugänglich. Der Benutzer kann vollumfägnlich von
Elasticsearch-Abfragen, vom Elasticsearch-Debugging und von der Elasticsearch-Optimierung profitieren. 

Weitere Informationen zu weiteren, hier nicht beschriebenen Elasticsearch-Funktionen finden Sie in der
[Elasticsearch-Dokumentation](https://www.elastic.co/guide/en/elasticsearch/reference/1.7/index.html).

## Elasticsearch in {{ site.data.keys.mf_analytics_server }} verwalten
{: #managing-elasticsearch-on-the-mobilefirst-analytics-server }

Elasticsearch ist in den {{ site.data.keys.mf_analytics_server }} eingebettet und übernimmt das Knoten- und Clusterverhalten. 

> Weitere Informationen zum Konfigurieren von Elasticsearch in Analytics Server finden Sie
im [{{ site.data.keys.mf_analytics_server }} Konfigurationshandbuch](../../installation-configuration/production/analytics/configuration)
unter [Cluster-Management und
Elasticsearch](../../installation-configuration/production/analytics/configuration#cluster-management-and-elasticsearch).



### Elasticsearch-Eigenschaften
{: #elasticsearch properties }

Elasticsearch-Eigenschaften sind in Form von JNDI-Variablen und Umgebungseinträgen verfügbar.   
Nachfolgend ist für den Einstieg in die Anzeige von Elasticsearch-Daten eine sehr nützliche JNDI-Eigenschaft angegeben: 

```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
```

Diese JNDI-Eigenschaft ermöglicht die Anzeige Ihrer {{ site.data.keys.mf_analytics_short }}-Rohdaten im JSON-Format und
den Zugriff auf Ihre Elasticsearch-Instanz über den von Elasticsearch definierten Port. Der Standardport ist 9500.

> **Hinweis**: Diese Einstellung ist nicht sicher und sollte in einer Produktionsumgebung nicht aktiviert werden. 

## Elasticsearch-REST-API
{: #elasticsearch-rest-api }

Wenn Sie die Möglichkeit haben, auf eine Elasticsearch-Instanz zuzugreifen, können Sie angepasste Abfragen ausführen und ausführlichere Informationen zum Elasticsearch-Cluster anzuzeigen.

**Daten suchen und anzeigen**  
Sie können alle Ihre Daten anzeigen, indem Sie den REST-Endpunkt `_search` des Nutzers aufrufen.   

```
http://localhost:9500/*/_search
```

**Clusterzustand anzeigen**  

```
http://localhost:9500/_cluster/health
```

**Informationen zu aktuellen Knoten anzeigen**  

```
http://localhost:9500/_nodes
```

**Aktuelle Zuordnungen anzeigen**  

```
http://localhost:9500/*/_mapping
```

> Elasticsearch macht viele weitere REST-Endpunkte zugänglich. Weitere Informationen finden Sie in der
[Elasticsearch-Dokumentation](https://www.elastic.co/guide/en/elasticsearch/reference/1.7/index.html).

