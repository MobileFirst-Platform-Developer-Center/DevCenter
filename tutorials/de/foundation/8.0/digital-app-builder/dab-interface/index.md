---
layout: tutorial
title: Digital-App-Builder-Schnittstelle
weight: 4
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Schnittstelle des Digital App Builder
{: #digital-app-builder-interface }

Die angezeigte Schnittstelle des Digital App Builder richtet sich nach dem ausgewählten Modus (Entwurf/Code).

### Schnittstelle des Digital App Builder im Entwurfsmodus

![DAB-Schnittstelle im Entwurfsmodus](dab-workbench-elements.png)

Links im Navigationsfenster der Digital-App-Builder-Schnittstelle finden Sie Folgendes:

* **Workbench** - Blendet die Seitendetails ein oder aus
* **Daten** - Hilft Ihnen, ein Dataset durch Herstellen einer Verbindung zu einer vorhandenen Datenquelle hinzuzufügen oder eine Datenquelle für einen Mikroservice unter Verwendung eines Open-API-Dokuments zu erstellen. 
* **Watson** - Umfasst die Komponenten Image Recognition und Chatbot (Watson Assistant) zum Konfigurieren einer vorhandenen Instanz oder zum Erstellen einer neuen Instanz. 
* **Engagement** - Sie können die Verbundenheit mit den Benutzern Ihrer App stärken, indem Sie Services für Push-Benachrichtigungen zur App hinzufügen und das Feature für Liveaktualisierung verwenden, um Steuerelemente und Seiten einer aktiven App ein-/auszublenden oder deren Eigenschaften zu ändern.
* **Konsole** - Zeigt die Konsole an, in der Sie die Aktivitäten sehen können. 
* **Einstellungen** - Zeigt die App-Details, Serverinfos, Plug-ins und Projektreparaturen (wie die erneute Erstellung von Abhängigkeiten bzw. Plattformen oder die Zurücksetzung der IBM Cloud-Berechtigungsnachweise) an und ermöglicht die Aktivierung bzw. Inaktivierung der Analyse. 

#### Workbench
{: #workbench }

Die Workbench hilft Ihnen bei der Gestaltung der Seiten. Sie besteht aus drei Arbeitsbereichen:

![Workbench](dab-workbench.png)

1. **Seiten/Steuerelemente**: In diesem Bereich wird der Name standardmäßig erstellter Seiten angezeigt. Verwenden Sie das Pluszeichen (**+**), um eine neue Seite zu erstellen. Wenn Sie auf das Symbol **Steuerelemente** klicken, werden Steuerelemente angezeigt, die Sie beim Hinzufügen von Funktionen zu einer Seite in einer App unterstützen. Sie können die Steuerelemente mit der Maus von der jeweiligen Steuerelementpalette in den Erstellungsbereich einer Seite ziehen und dort ablegen. Jedes Steuerelement verfügt über eine Gruppe von Eigenschaften und Aktionen. Sie können die Eigenschaften jedes ausgewählten Steuerelements modifizieren.

    Im Folgenden sind die verfügbaren Steuerelemente aufgelistet:
    * **Basis**: Diese Basissteuerelemente (Schaltfläche, Überschrift, Bild und Bezeichnung) können Sie mit der Maus in den Erstellungsbereich ziehen, dort ablegen und die Eigenschaften und Aktionen konfigurieren.

        ![Seiten/Steuerelemente](dab-workbench-basic-controls.png)

        * **Schaltfläche** - Schaltflächen haben eine Eigenschaft für die Beschriftung. Auf der Registerkarte "Aktion" können Sie die Seite angeben, zu der per Klick auf die Schaltfläche navigiert werden soll.
        * **Überschrift** - Hilft Ihnen, eine Überschrift für die Anwendung hinzuzufügen, z. B. eine Seitenüberschrift.
        * **Bild** - Hilft Ihnen, ein lokales Bild hochzuladen oder eine Bild-URL anzugeben.
        * **Bezeichnung** - Hilft Ihnen, statischen Text zu Ihrem Seitenhauptteil hinzuzufügen. 
    * **Datengebunden** - Hilft Ihnen, eine Verbindung zu einem Dataset herzustellen und Operationen für die Entitäten in dem Dataset auszuführen. Zum Steuerelement "Datengebunden" gehören die beiden Komponenten **Liste** und **Bezeichnung 'Verbunden'**.

        ![Datengebundene Steuerelemente](dab-workbench-databound-controls.png)

        * **Liste** - Sie können eine neue Seite erstellen und die Listenkomponente mit der Maus auf die Seite ziehen. Fügen Sie den Listentitel (**List Title**) hinzu. Wählen Sie den Typ der zu bearbeitenden Liste aus. Fügen Sie Inhalte zur Bearbeitung hinzu und wählen Sie das zu verwendende Dataset aus.

        Weitere Informationen zum Hinzufügen des **Dataset** finden Sie [hier](../how-to-add-dataset/).

    * **Anmeldung** - Das Steuerelement "Anmeldung" besteht aus einem Anmeldeformular.  
 
        Mit dem Anmeldeformular können Sie eine Anmeldeseite für Ihre Anwendung erstellen, von der aus der Benutzer eine Verbindung zum Mobile Foundation Server herstellen kann. Der Mobile Foundation Server stellt ein Sicherheitsframework für die Authentifizierung von Benutzern und die Bereitstellung des Sicherheitskontextes für den Zugriff auf die Datasets zur Verfügung. Weitere Informationen finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/creating-a-security-check/).

        ![Anmeldeformular](dab-workbench-login-control.png)

        Weitere Informationen zum Hinzufügen des **Anmeldeformulars** finden Sie [hier](../how-to-login/).

    * **KI** - Mithilfe von KI-Steuerelementen können Sie Watson-KI-Leistungsmerkmale zu Ihrer App hinzufügen.

        * **Watson Chat** - Dieses Steuerelement stellt eine komplette Chatschnittstelle bereit, die mit dem Service Watson Assistant für IBM Cloud gesteuert werden kann. 

            ![Watson Assistant](dab-workbench-ai-watson-chat.png)

            * Wählen Sie im Eigenschaftenabschnitt den konfigurierten Service Watson Assistant aus. Wählen Sie dann den Arbeitsbereich aus, zu dem Sie eine Verbindung herstellen möchten. Wie ein Chatdialog definiert und trainiert wird, erfahren Sie in Watson unter [Chatbot](../how-to-chatbot/).

        * **Watson Visual Recognition** - Mit diesem Steuerelement kann ein Foto gemacht werden, das dann vom Service Watson Visual Recognition identifiziert werden kann.
         
            ![Watson Visual Recognition](dab-workbench-ai-watson-vr.png)
 
            *  Wählen Sie im Eigenschaftenabschnitt den konfigurierten Service Visual Recognition und das Klassifikationsmodell aus. Wie Sie zum Definieren und Trainieren Ihre eigenen Bilder verwenden können, erfahren Sie in Watson unter [Bilderkennung](../how-to-image-recognition/).

2. Abschnitt **Erstellungsbereich** - Dieser Bereich besteht aus dem aktuell ausgewählten Kanal, dem Namen der aktuellen Seite, dem Veröffentlichungsbereich und dem eigentlichen Erstellungsbereich.

    * Symbol **Kanal** - Mithilfe dieses Symbols wird der derzeit ausgewählte Kanal angezeigt. Sie können weitere Kanäle hinzufügen. Wählen Sie dazu im Plattformabschnitt unter **Einstellungen > App > App-Details** die erforderlichen Kanäle aus.
    * Aktueller Seitenname - Es wird der Seitenname im Erstellungsbereich angezeigt. Nach einem Seitenwechsel wird der Name aktualisiert, sodass der Name der dann ausgewählten Seite angezeigt wird.
    * **App erstellen/voranzeigen** - Diese Schaltfläche hat zwei Funktionen. Sie hilft Ihnen, eine Vorschau der App, die Sie entwickeln, zu sehen und die App zu erstellen.
    * **App veröffentlichen** - Mithilfe dieser Option können Sie Ihre App für Android/iOS erstellen und im App Center veröffentlichen.
    * **Erstellungsbereich** - Im Mittelpunkt dieses Abschnitts befindet sich der Erstellungsbereich, in dem entweder das Design oder der Code angezeigt wird. Sie können die Steuerelemente mit der Maus in den Erstellungsbereich ziehen und die App erstellen.

3. Registerkarte **Eigenschaften/Aktionen** - Auf der rechten Seite befindet sich die Registerkarte für Eigenschaften und Aktionen. Wenn ein Steuerelement im Erstellungsbereich abgelegt wird, können Sie die Eigenschaften des Steuerelements bearbeiten und modifizieren und ein Steuerelement mit einer auszuführenden Aktion verbinden.

#### Daten
{: #dataset-integration}

Sie können ein Dataset für einen Mikroservice erstellen. Nach Erstellung des Datasets können Sie dann die datengebundenen Steuerelemente in Ihrer App verbinden.

Weitere Informationen zum Hinzufügen des **Dataset** finden Sie [hier](../how-to-add-dataset/).

#### Watson
{: #integrating-with-watson-services}

Der Digital App Builder bietet die Möglichkeit, die App für eine Verbindung zu den verschiedenen, von IBM Cloud bereitgestellten Watson-Services zu konfigurieren.

#### Engagement
{: #engagement}

Sie können Push-Benachrichtigungen zu Ihrer App hinzufügen und die Benutzerbindung verbessern oder die Funktion für Liveaktualisierung nutzen, um Steuerelemente und Seiten einer aktiven App ein-/auszublenden oder deren Eigenschaften zu ändern.

#### Konsole
{: #console }

In der Konsole können Sie den Code für die einzelnen Komponenten anzeigen. Hier sehen Sie außerdem die Informationen zu verschiedenen Aktivitäten und Fehlern.

#### Einstellungen
{: #settings}

Unter "Einstellungen" können Sie die App-Einstellungen verwalten und während des Erstellungsprozesses auftretende Fehler korrigieren. Zum Bereich der Einstellungen gehören die Registerkarten **App-Details**, **Server**, **Plug-ins** und **Projekt reparieren**.

### Schnittstelle des Digital App Builder im Codemodus

![DAB-Schnittstelle im Codemodus](dab-workbench-elements-codemode.png)

Im Codemodus finden Sie Folgendes links im Navigationsfenster der Digital-App-Builder-Schnittstelle:

* **Workbench** - Blendet die Dateien ein oder aus
* **Watson** - Umfasst die Komponenten Image Recognition und Chatbot (Watson Assistant) zum Konfigurieren einer vorhandenen Instanz oder zum Erstellen einer neuen Instanz. 
* **Engagement** - Sie können die Verbundenheit mit den Benutzern Ihrer App stärken, indem Sie Services für Push-Benachrichtigungen zur App hinzufügen und das Feature für Liveaktualisierung verwenden, um Steuerelemente und Seiten einer aktiven App ein-/auszublenden oder deren Eigenschaften zu ändern.
* **API** - Hilft, den Server durch Bereistellung von JSON-Daten während der Entwicklung nachzuahmen.
* **Konsole** - Zeigt die Konsole an, in der Sie die Aktivitäten sehen können. 
* **Einstellungen** - Zeigt die App-Details, Serverinfos, Plug-ins und Projektreparaturen (wie die erneute Erstellung von Abhängigkeiten bzw. Plattformen oder die Zurücksetzung der IBM Cloud-Berechtigungsnachweise) an und ermöglicht die Aktivierung bzw. Inaktivierung der Analyse. 

#### Workbench (Codemodus)
{: #workbench }

Die Workbench hilft Ihnen bei der Gestaltung der Seiten. Sie besteht aus zwei Arbeitsbereichen:

1. **Projektdateien**: In diesem Bereich wird die Liste der Dateien, die automatisch erstellt und dieser App zugeordnet werden. Verwenden Sie das Pluszeichen (**+**), um eine neue Seite zu erstellen. Wenn Sie auf das Symbol **Steuerelemente** (**</>**) klicken, wird das Fenster **Code-Snippets** angezeigt. Sie können diese Code-Snippets mit der Maus ziehen und in Ihrem Code ablegen. Dort können Sie die Eigenschaften der ausgewählten Steuerelemente modifizieren.

#### Code-Snippets (nur Codemodus)
{: #code-snippets}

Einige der gängigen Code-Snippets sind vordefiniert und können einfach per Drag-and-drop vom Code-Snippets-Abschnitt zu den Quellendateien hinzugefügt wreden. Der Abschnitt enthält Code-Snippets der folgenden Kategorien:

* **Mobile Core** - Code-Snippets für Basisoperationen in IBM Mobile Foundation Server
* **Analytics** - Code-Snippets für kundenspezifische Analysen und Benutzerfeedback
* **Ionic** - Code-Snippets für einfache Ionic-Komponenten
* **Push** - Code-Snippets für das Arbeiten mit Push-Benachrichtigungen
* **Liveaktualisierung** - Code-Snippets für die Verwendung von Liveaktualisierungen für das ein-/ausschalten von Features

