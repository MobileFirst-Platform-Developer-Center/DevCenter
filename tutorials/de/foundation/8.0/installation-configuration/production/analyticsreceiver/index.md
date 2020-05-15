---
layout: tutorial
title: MobileFirst Analytics Receiver Server installieren und konfigurieren
breadcrumb_title: MobileFirst Analytics Receiver Server installieren
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mobile Analytics Receiver Server ist ein optionaler Server, der implementiert werden kann, um anstelle der Mobile-Foundation-Server-Laufzeit Mobile-Foundation-Analytics-Ereignisse mobiler Clientanwendungen
zu senden. Mithilfe dieser Implementierungsoption kann die Mobile-Foundation-Server-Laufzeit von der Verarbeitung der Analyseereignisse entlastet werden, sodass sie voll für die Ausführung von Laufzeitfunktionen genutzt werden kann.   

{{ site.data.keys.mf_analytics_receiver_server }} wird in Form einer WAR-Datei bereitgestellt, die Sie auf einem separaten Server installieren sollten. Sie können eine der folgenden Installationsmethoden nutzen:

* Installation mit Ant-Tasks
* Manuelle Installation

Wenn Sie {{ site.data.keys.mf_analytics_receiver_server }}  im Webanwendungsserver Ihrer Wahl installiert haben, sind zusätzliche Konfigurationsschritte
erforderlich. Weitere Informationen finden Sie unten im Abschnitt "{{ site.data.keys.mf_analytics_receiver_server }}  nach der Installation konfigurieren". Wenn Sie im Installationsprogramm das manuelle Setup auswählen, lesen Sie die Dokumentation zu dem Anwendungsserver, den Sie verwenden.

> **Hinweis:** Installieren Sie auf einer Hostmaschine nicht mehr als eine Instanz von
{{ site.data.keys.mf_analytics_receiver_server }}. 

Die Analytics-Receiver-WAR-Datei wird bei der Installation von
MobileFirst Server ebenfalls installiert.
Weitere Informationen finden Sie unter "MobileFirst-Server-Verteilungsstruktur". 

* Weitere Informationen zur Installation von
{{ site.data.keys.mf_analytics_receiver_server }} finden Sie im
[{{ site.data.keys.mf_analytics_receiver_server }} Installationshandbuch](installation).
* Weitere Informationen zur Konfiguration des IBM MobileFirst Analytics Receiver enthält das
[Konfigurationshandbuch](configuration).
