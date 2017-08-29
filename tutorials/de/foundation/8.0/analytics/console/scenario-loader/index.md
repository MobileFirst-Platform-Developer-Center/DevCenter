---
layout: tutorial
title: Scenario Loader
breadcrumb_title: Scenario Loader
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

> **Hinweis:** Der Scenario Loader ist *experimenteller* Natur und wird daher nicht vollständig unterstützt. Berücksichtigen Sie dies bei der Verwendung des Loaders. 
>
> * Einige Diagramme werden nicht mit Daten gefüllt. 

Der Scenario Loader trägt in der {{ site.data.keys.mf_analytics_console_full }} Pseudodaten in diverse Diagramme und Berichte ein. Die Daten werden im
Elasticsearch-Datastore gespeichert und sicher von Ihren vorhandenen Test- oder Produktionsdaten separiert. 

Die geladenen Daten sind synthetische Daten, die direkt in den Datastore injiziert werden, und nicht das Ergebnis
der Erstellung tatsächlicher Analysedaten durch den Client oder Server. Diese Daten sollen dem Benutzer eine bessere Ansicht der verschiedenen, auf der Benutzerschnittstelle angezeigten Berichte und Diagramme ermöglichen. Verwenden Sie die Daten also **nicht** für Testzwecke. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Vorbereitungen](#before-you-start)
* [Verbindung zum Scenario Loader herstellen](#connecting-to-the-scenario-loader)
* [Laden der Daten konfigurieren](#configuring-the-data-loading)
* [Daten laden und löschen](#loading-and-deleting-the-data)
* [Mit Daten gefüllte Diagramme und Tabellen anzeigen](#viewing-the-populated-charts-and-tables)
* [Debugmodus inaktivieren](#disabling-the-debug-mode)

## Vorbereitungen
{: #before-you-start }

Der Scenario Loader ist im Paket mit der {{ site.data.keys.mf_analytics_console }} enthalten. Vergewissern Sie sich, dass
Ihre {{ site.data.keys.mf_analytics_console_short }} aktiv und zugänglich ist, bevor Sie eine Verbindung zum Scenario Loader herstellen. 

## Verbindung zum Scenario Loader herstellen
{: #connecting-to-the-scenario-loader }

1. Aktivieren Sie den Scenario Loader, indem Sie das JVM-Argument `-DwlDevEnv=true`
oder die Umgebungsvariable `ANALYTICS_DEBUG=true` definieren.

2. In Ihrem Browser können Sie mit der Konsolen-URL `http://<Konsolenpfad>/scenarioLoader` auf den Scenario Loader zugreifen.
Hier steht `<Konsolenpfad>` für den in der Datei `mfp-server/usr/servers/mfp/server.xml` definierten JNDI-Eigenschaftswert.
Beispiel: 

    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. Die Seite "Scenario Loader" und die Navigationsleiste der
{{ site.data.keys.mf_analytics_console_short }} werden angezeigt. Der Scenario Loader ist weiterhin nicht über die Navigationsleiste zugänglich. 

## Laden der Daten konfigurieren
{: #configuring-the-data-loading}

1. Im Abschnitt **Testing Configuration** gibt es mehrere Einstellungen,
mit denen die Art der generierten Daten (Register **Basic**) und die Menge der generierten Daten (Register **Capacity Planning**)
gesteuert werden können. Vergewissern Sie sich, dass die Einstellung
**Days of history** auf mindestens 30 Tage gesetzt ist, damit genügend Daten geladen werden. 

    Alle verfügbaren Informationen zu diesen Einstellungen sind Sie im Abschnitt **Testing Configuration** enthalten. 

2. Klicken Sie auf das Symbol **Verwaltung** (<img  alt="Schraubenschlüsselsymbol" style="margin:0;display:inline" src="wrench.png"/>) und wählen
Sie das Register **Settings** aus. Vergewissern Sie sich, dass im Abschnitt
**Advanced** die Eigenschaft **Default tenant** auf den Wert `dummy_data_for_demo_purposes_only` gesetzt ist.

## Daten laden und löschen
{: #loading-and-deleting-the-data }

Klicken Sie zum Laden der Daten im Abschnitt **Scenario Operations** auf die Schaltfläche **Start Scenario Loading**. 

Klicken Sie zum Löschen der Daten im Abschnitt **Testing Configuration** auf die Schaltfläche **Delete Now**. 

**Bitte beachten:** Lesen Sie den Haftungsausschluss bezüglich des Erstellens und Löschens von Daten im Abschnitt **Scenario Operations**. 

## Mit Daten gefüllte Diagramme und Tabellen anzeigen
{: #viewing-the-populated-charts-and-tables }

Wenn die Daten geladen sind, werden zwar nicht in alle, aber in viele Diagramme und Tabellen, die in der Analytics Console verfügbar sind, Daten eingetragen. 

Verwenden Sie die Navigationsleiste der {{ site.data.keys.mf_analytics_console_short }}, um sich die mit Daten gefüllten Diagramme und Tabellen auf den diversen Seiten und Registerkarten anzusehen. 

## Debugmodus inaktivieren
{: #disabling-the-debug-mode }

Wenn Sie nach dem Arbeiten mit synthetischen Daten im Debugmodus reale Daten verwenden möchten, gehen Sie wie folgt vor: 

1. Löschen Sie die Daten. Klicken Sie dazu
im Abschnitt **Testing Configuration** auf die Schaltfläche **Delete Now**. 
2. Vergewissern Sie sich, dass im Abschnitt **Settings** → **Advanced**
die Eigenschaft **Default tenant** auf den Wert `worklight` gesetzt ist.
3. Setzen Sie die zuvor auf "true" gesetzte Variable auf "false"
(JVM-Argument `-DwlDevEnv=false` oder Umgebungsvariable `ANALYTICS_DEBUG=false`).
4. Starten Sie {{ site.data.keys.mf_analytics_server }} neu.
