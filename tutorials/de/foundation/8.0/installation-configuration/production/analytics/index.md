---
layout: tutorial
title: MobileFirst Analytics Server installieren und konfigurieren
breadcrumb_title: Installing MobileFirst Analytics Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
{{ site.data.keys.mf_analytics_server }} wird in Form zweier WAR-Dateien bereitgestellt. Für eine komfortable Implementierung in
WebSphere Application Server
oder WebSphere Application Server Liberty
wird {{ site.data.keys.mf_analytics_server }} auch als eine EAR-Datei, die die beiden WAR-Dateien enthält,
bereitgestellt.

> **Hinweis:** Installieren Sie auf einer Hostmaschine nicht mehr als eine Instanz von
{{ site.data.keys.mf_analytics_server }}. Weitere Informationen zur Verwaltung Ihres Clusters
finden Sie in der Elasticsearch-Dokumentation. 

Die Analyse-WAR-Dateien und die Analyse-EAR-Datei werden bei der Installation von
MobileFirst Server ebenfalls installiert.
Weitere Informationen finden Sie unter "MobileFirst-Server-Verteilungsstruktur". Wenn Sie die WAR-Datei implementieren, ist die MobileFirst Analytics Console unter `http://<Hostname>:<Port>/analytics/console` verfügbar, z. B. unter `http://localhost:9080/analytics/console`.

* Weitere Informationen zur Installation von
{{ site.data.keys.mf_analytics_server }} finden Sie im
[{{ site.data.keys.mf_analytics_server }} Installationshandbuch](installation).
* Weitere Informationen zur Konfiguration von IBM MobileFirst Analytics enthält das
[Konfigurationshandbuch](configuration).
