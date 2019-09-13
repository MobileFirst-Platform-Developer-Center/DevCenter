---
layout: tutorial
title: Datenaufbewahrung und -bereinigung
breadcrumb_title: Data Retention and Purging
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

MobileFirst-Analytics-Daten werden auf dem Server gespeichert und stehen bis zu ihrer Löschung für die Berichterstellung zur Verfügung. Sie können steuern, welche Ereignistypdaten aufbewahrt oder gelöscht werden. Sie können Daten in regelmäßigen Intervallen oder manuell bereinigen. 

## Datenaufbewahrung in der Analytics Console konfigurieren
{: #configuring-data-retention-from-the-analytics-console }

1. Klicken Sie in der {{ site.data.keys.mf_analytics_console }} auf das Symbol **Verwaltung** (<img  alt="Schraubenschlüsselsymbol" style="margin:0;display:inline" src="wrench.png"/>).
2. Wählen Sie das Register **Einstellungen** aus. 

   ![Datenaufbewahrung konfigurieren](analytics_console_data_retention.png)

   * Wählen Sie das Optionsfeld **Löschen** aus, wenn Daten sofort gelöscht werden sollen. 
   * Wählen Sie in der Spalte **Daten aufbewahren für** die Anzahl der Tage für die Aufbewahrung aus oder übernehmen Sie den Standardwert
**Daten ewig aufbewahren**. 

3. Klicken Sie auf **Änderungen speichern**.

Die neue Aufbewahrungsrichtlinie ist etabliert. 
