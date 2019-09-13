---
layout: tutorial
title: Kundenspezifische Diagramme erstellen
breadcrumb_title: Custom Charts
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit kundenspezifischen Diagrammen können Sie erfasste
Analysedaten aus Ihrem Anatytics-Datastore in Diagrammen darstellen, die standardmäßig nicht in
der {{ site.data.keys.mf_analytics_console }} verfügbar sind. Diese Darstellungsoption ist eine wirksame Methode für die Analyse geschäftskritischer Daten. 

Folgende Arten kundenspezifischer Diagramme sind verfügbar:
**App-Sitzung**, **Netztransaktionen**, **Push-Benachrichtigungen**,
**Clientprotokolle**, **Serverprotokolle**, **Kundenspezifische Daten**.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Kundenspezifisches Diagramm erstellen](#creating-a-custom-chart)
* [Diagrammtypen](#chart-types)
* [Kundenspezifische Diagramme für Clientprotokolle erstellen](#creating-custom-charts-for-client-logs)
* [Daten kundenspezifischer Diagramme exportieren](#exporting-custom-chart-data)
* [Definition kundenspezifischer Diagramme exportieren und importieren](#exporting-and-importing-custom-chart-definitions)

## Kundenspezifisches Diagramm erstellen
{: #creating-a-custom-chart }

Das Erstellungsprogramm für kundenspezifische Diagramme im **Dashboard** der {{ site.data.keys.mf_analytics_console }} führt Sie durch die vier Hauptschritte. 

### 1. Allgemeine Einstellungen
{: #1-general-settings }

Klicken Sie auf der Registerkarte **Kundenspezifische Diagramme** auf die Schaltfläche **Diagramm erstellen**.   

Wählen Sie auf der Registerkarte **Allgemeine Einstellungen** die Optionen "Diagrammtitel", "Ereignisttyp" und "Diagrammtyp" aus.   
Wenn Sie den Ereignistyp und den Diagrammtyp ausgewählt haben, erscheint die Registerkarte
**Diagrammdefinition**. 

### 2. Register 'Diagrammdefinition'
{: #2-the-chart-definition-tab }

Auf der Registerkarte **Diagrammdefinition** können Sie das Diagramm für den zuvor
ausgewählten Diagrammtyp definieren. Nachdem Sie das Diagramm definiert haben, können Sie die Diagrammfilter und -eigenschaften
festlegen. 

### 3. Register 'Diagrammfilter'
{: #3-the-chart-filters-tab }

Mit **Diagrammfiltern** können Sie das kundenspezifische Diagramm optimieren. Für jedes Diagramm können mehrere Filter
definiert werden.   
Wenn Sie beispielsweise die durschnittliche Dauer der App-Sitzungen für eine bestimmte App anzeigen möchten,
können Sie die folgenden Optionen angeben: 

1. Wählen Sie **Anwendungsname** als **Eigenschaft** aus.
2. Wählen Sie für **Operator** die Option **ist gleich** aus.
3. Wählen Sie als **Wert** den Namen Ihrer App aus.
4. Klicken Sie auf **Filter hinzufügen**.

Der App-Namensfilter wird zur Tabelle der Filter für Ihr Diagramm hinzugefügt. 

### 4. Diagrammeigenschaften
{: #4-chart-properties }

Für die Diagrammtypen **Tabelle**, **Balkendiagramm** und
**Kurvendiagramm** sind Diagrammeigenschaften verfügbar. Mithilfe von Diagrammeigenschaften
sollen die Daten effektiver dargestellt werden können. 

Wenn Sie ein Diagramm vom Typ **Tabelle** erstellt haben, können Sie die Diagrammeigenschaften für die Größe
der Tabellenseite,
das Feld für die Sortierung und die Sortierreihenfolge des Feldes festlegen. 

Wenn Sie ein Diagramm vom Typ **Balkendiagramm** oder **Kurvendiagramm** erstellt haben, können Sie über die Diagrammeigenschaften
Schwellenwerte festlegen, um für Betrachter des Diagramms ein Bezugssystem hinzuzufügen. 

<img class="gifplayer"  alt="Kundenspezifisches Diagramm erstellen" src="creating-custom-charts.png"/>

## Diagrammtypen
{: #chart-types }

### Balkendiagramm
{: #bar-graph }

Das Balkendiagramm eignet sich für die Darstellung numerischer Daten auf einer X-Achse. Wenn Sie ein Balkendiagramm definieren, müssen Sie zuerst den Wert für die
X-Achse auswählen. Folgende Werte stehen zur Auswahl: 

* **Zeitachse** - Wählen Sie für die X-Achse den Wert
Zeitachse aus, wenn Sie einen Datentrend anzeigen möchten (z. B. die durchschnittliche Dauer von App-Sitzungen über der Zeit). 
* **Eigenschaft** - Wählen
Sie Eigenschaft aus, wenn Sie einen Zähler für eine bestimmte Eigenschaft aufgegliedert darstellen möchten. Wenn Sie
für die X-Achse den Wert
Eigenschaft auswählen, wird damit für die Y-Achse implizit
Gesamt ausgewählt. Angenommen, Sie möchten für einen bestimmten Ereignistyp die Anzahl, aufgeschlüsselt nach App-Namen, darstellen.
Wählen Sie in dem Fall für die X-Achse den Wert Eigenschaft und Anwendungsname als
Eigenschaft aus. 

Nach dem Wert für die X-Achse definieren Sie einen Wert für die
Y-Achse. Wenn Sie für die X-Achse den Wert
Zeitachse gewählt haben, stehen für die
Y-Achse die folgenden Werte zur Auswahl: 

* **Durchschnitt** - Zeigt den Durchschnitt für eine numerische Eigenschaft des angegebenen Ereignistyps an
* **Gesamt** - Zeigt die Gesamtzahl für eine Eigenschaft des angegebenen Ereignistyps an. 
* **Eindeutig** - Zeigt die eindeutige Anzahl für eine Eigenschaft des angegebenen Ereignistyps an. 

Nachdem Sie die Diagrammachsen definiert haben, müssen Sie einen Wert für Eigenschaft wählen. 

### Kurvendiagramm
{: #line-graph }

In einem Kurvendiagramm können Metriken über der Zeit dargestellt werden. Dieser Diagrammtyp ist wertvoll, wenn Sie Daten als Trend über der Zeit
darstellen möchten. Der erste Wert, der beim Erstellen eines Kurvendiagramms definiert werden muss, ist
der Wert für Messung. Gültige Werte sind: 

* **Durchschnitt** - Zeigt den Durchschnitt für eine numerische Eigenschaft des angegebenen Ereignistyps an
* **Gesamt** - Zeigt die Gesamtzahl für eine Eigenschaft des angegebenen Ereignistyps an. 
* **Eindeutig** - Zeigt die eindeutige Anzahl für eine Eigenschaft des angegebenen Ereignistyps an. 

Nachdem Sie die Messung definiert haben, müssen Sie einen Wert für Eigenschaft wählen. 

### Ablaufdiagramm
{: #flow-chart }

In einem Ablaufdiagramm kann ein Verlauf von einer Eigenschaft zu einer anderen aufgegliedert dargestellt werden. Für ein Ablaufdiagramm müssen die folgenden Eigenschaften
festgelegt werden: 

* **Quelle** - Wert eines Quellenknotens im Diagramm
* **Ziel** - Wert eines Zielknotens im Diagramm
* **Eigenschaft** - Eigenschaftswert vom Quellen- oder Zielknoten

Ein Ablaufdiagramm ermöglicht eine Darstellung verschiedener Quellen, aufgegliedert nach dem Ziel oder umgekehrt. Wenn Sie beispielsweise eine Aufgliederung der Protokollkategorien
für eine App sehen
möchten, können Sie die folgenden Werte definieren. 

* Wählen Sie Anwendungsname als Quelle aus.
* Wählen Sie Protokollebene als Ziel aus.
* Wählen Sie als Eigenschaft den Namen Ihrer App aus.

### Metrikgruppe
{: #metric-group }

Mithilfe einer Metrikgruppe kann für eine einzelne gemessene Metrik ein Durchschnitt, eine Gesamtanzahl oder eine eindeutige Anzahl
angezeigt werden. Zum Definieren einer Metrikgruppe müssen Sie einen der folgenden Werte für
Messung definieren: 

* **Durchschnitt** - Zeigt den Durchschnitt für eine numerische Eigenschaft des angegebenen Ereignistyps an
* **Gesamt** - Zeigt die Gesamtzahl für eine Eigenschaft des angegebenen Ereignistyps an. 
* **Eindeutig** - Zeigt die eindeutige Anzahl für eine Eigenschaft des angegebenen Ereignistyps an. 

Nachdem Sie die Messung definiert haben, müssen Sie einen Wert für Eigenschaft wählen. Die Metrik wird in der Metrikgruppe angezeigt. 

### Kreisdiagramm
{: #pie-chart }

In einem Kreisdiagramm können die Werte für eine bestimmte Eigenschaft aufgegliedert angezeigt werden.
Wenn Sie beispielsweise eine Absturzaufgliederung sehen
möchten, definieren Sie die folgenden Werte: 

* Wählen Sie App-Sitzung als Ereignistyp aus.
* Wählen Sie Kreisdiagramm als Diagrammtyp aus.
* Wählen Sie "Geschlossen von" als Eigenschaft aus.

Das Ergebnis ist ein Kreisdiagramm, in dem die vom Benutzer geschlossenen App-Sitzungen den durch einen Absturz geschlossenenen App-Sitzungen
gegenübergestellt sind. 

### Tabelle
{: #table }

Eine Tabelle ist für Rohdaten sinnvoll. Zum Erstellen einer Tabelle müssen Sie einfach nur Spalten für die darzustellenden Rohdaten hinzufügen.   
Da für bestimmte Ereignistypen nicht alle Eigenschaften erforderlich sind, können in Ihrer Tabelle Nullwerte erscheinen. Wenn Sie verhindern möchten, dass solche Zeilen in Ihrer Tabelle
angezeigt werden, fügen Sie auf der Registerkarte Diagrammfilter einen Filter Vorhanden für eine bestimmte Eigenschaft hinzu. 

## Kundenspezifische Diagramme für Clientprotokolle erstellen
{: #creating-custom-charts-for-client-logs }

Sie können kundenspezifische Diagramme für Clientprotokolle erstellen, die Informationen enthalten, die mit der Plattform-API
Logger gesendet wurden.
  
Die Protokolle enthalten außerdem Kontextinformationen zum Gerät, z. B. zur Umgebung, zum App-Namen und zur App-Version. 

> **Hinweis:** Sie müssen kundenspezifische Ereignisse protokollieren, um kundenspezifische Diagramme mit Daten zu füllen. Informationen zum Senden kundenspezifischer Ereignisse von der Client-App finden Sie unter [Kundenspezifische Daten erfassen](../../analytics-api/#custom-events).



1. Die Daten von Client-Apps werden eingetragen, wenn Sie erfasste Protokolle an den Server senden (siehe
[Erfasste Protokolle senden](../../analytics-api/#sending-analytics-data)).
2. Klicken Sie in der {{ site.data.keys.mf_analytics_console }} auf das Register **Kundenspezifische Diagramme** und
fahren Sie mit der Erstellung eines Diagramms fort: 
    * **Diagrammtitel**: Anwendung und Protokollebenen
    * **Ereignistyp**: Clientprotokolle
    * **Diagrammtyp**: Ablaufdiagramm

3. Klicken Sie auf das Register **Diagrammdefinition** und geben Sie folgende Werte an: 
    * **Quelle**: Anwendungsname
    * **Ziel**: Protokollebene
    * **Eigenschaft**: Name Ihrer App

4. Klicken Sie auf die Schaltfläche **Speichern**.

## Daten kundenspezifischer Diagramme exportieren
{: #exporting-custom-chart-data }

Sie können die für ein kundenspezifisches Diagramm angezeigten Daten herunterladen.   

![Symbole für den Export von Daten kundenspezifischer Diagramme](export-data.png)

* **Mit URL exportieren** - Symbol in Form von Kettengliedern
* **Diagramm herunterladen** - Symbol in Form eines Abwärtspfeils
* **Diagramm barbeiten** - Symbol in Form eines Stifts
* **Diagramm löschen** - Symbol in Form eines Papierkorbs

Klicken Sie auf das Symbol **Diagramm herunterladen**, um von der
{{ site.data.keys.mf_analytics_console_short }} eine Datei im JSON-Format herunterzuladen.  
Klicken Sie auf das Symbol **Mit Link exportieren**, um
in der {{ site.data.keys.mf_analytics_console_short }} einen Exportlink zu generieren,
der von einem HTTP-Client aufgerufen werden kann. Diese Option ist sinnvoll, wenn Sie ein Script zur Automation des Exportprozesses für ein besstimmtes Zeitintervall schreiben möchten. 

## Definition kundenspezifischer Diagramme exportieren und importieren
{: #exporting-and-importing-custom-chart-definitions }

Sie können die Definitionen Ihrer kundenspezifischen Diagramme über die
{{ site.data.keys.mf_analytics_console_short }} exportieren und importieren. Wenn Sie von einer Testumgebung zu einer Implementierung in der Produktionsumgebung wechseln, können Sie Zeit sparen, indem Sie die Definitionen Ihrer kundenspezifischen
Diagramme exportieren, anstatt die Diagramme für Ihren neuen Cluster neu zu erstellen. 

1. Klicken Sie im Dashboard der {{ site.data.keys.mf_analytics_console_short }} auf das Register **Kundenspezifische Diagramme**. 
2. Klicken Sie auf **Diagramme exportieren**, um eine JSON-Datei mit Ihrer Diagrammdefinition herunterzuladen. 
3. Wählen Sie eine Speicherposition für die JSON-Datei aus. 
4. Klicken Sie auf **Diagramme importieren**, um Ihre JSON-Datei zu importieren. Wenn Sie die Definition eines bereits vorhandenen kundenspezifischen Diagramms importieren, ist die Definition im Ergebnis doppelt vorhanden. Das bedeutet auch, dass
die {{ site.data.keys.mf_analytics_console_short }}
das kundenspezifische Diagramm doppelt anzeigt. 
