---
layout: tutorial
title: Dataset hinzufügen
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Dataset hinzufügen
{: #dab-login-form }

### Neues Dataset im Entwurfsmodus erstellen
{: #data-set-design-mode }

1. Öffnen Sie auf der Landing-Page des Digital App Builder eine vorhandene App oder erstellen Sie eine App im Entwurfsmodus.
2. Klicken Sie im linken Fensterbereich auf **Daten**.

    ![Daten](dab-list-menu.png)

3. Klicken Sie auf **Neues Dataset hinzufügen**. Daraufhin wird das Fenster "Dataset hinzufügen" angezeigt.

    ![Neues Dataset hinzufügen](dab-list-add-data-set.png)

4. Erstellen Sie ein Dataset. Für die Erstellung können Sie eine vorhandene Quelle verwenden (Standardoption). Sie können aber auch eine Datenquelle für einen Mikroservice unter Verwendung eines Open-API-Dokuments erstellen.
    * **Von vorhandener Datenquelle erstellen** (Standardoption) - Bei Auswahl dieser Option werden in die Dropdown-Liste alle Datenquellen (Adapter) von der konfigurierten Mobile-Foundation-Server-Instanz eingetragen. 
    * **Datenquelle für einen Mikroservice mit dem Open-API-Dokument erstellen** - Bei Auswahl dieser Option können Sie eine Datenquelle mithilfe einer Open-API-Spezifikation (Swagger-JSON/YAML-Datei) erstellen und daraus dann ein Dataset.

#### Dataset von einer vorhandenen Datenquelle erstellen

1. Wählen Sie die Datenquelle für die Erstellung des Datasets aus.
2. Daraufhin werden die verfügbaren Entitäten der Datenquelle aufgelistet. Wählen Sie die zu erstellende Entität aus.
3. Geben Sie dem Dataset einen Namen und klicken Sie auf die Schaltfläche **Hinzufügen**. Das Dataset wird damit hinzugefügt. Sie können die dem Dataset zugeordneten Attribute und Aktionen sehen.

    ![Neues Dataset mit Attributen](dab-list-dataset-attributes.png)

4. Einige Attribute und Aktionen können je nach Verwendungszweck des Datasets ausgeblendet werden.
5. Sie können auch die **Anzeigebeschriftungen** für die Attribute bearbeiten.
6. Darüber hinaus können Sie die GET-Aktionen testen. Geben Sie dazu die erforderlichen Attribute an und klicken Sie auf **Diese Aktion ausführen** für die entsprechende Aktion. Denken Sie daran, dass Sie den Namen des vertraulichen Clients und das zugehörige Kennwort auf der Registerkarte **Einstellungen** angegeben haben müssen.

#### Datenquelle für einen Mikroservice mit einer Swagger-Datei erstellen

1. Wählen Sie die **JSON/YAML-Datei** aus, für die Sie eine Datenquelle erstellen möchten, und klicken Sie auf **Generieren**.
2. Daraufhin wird ein Adapter generiert, der ein Konfigurationsartefakt für den MF-Server ist, das Sie wiederverwenden und in der Mobile-Foundation-Server-Instanz implementieren können.
3. Wählen Sie die Entität aus, für die Sie die Datenquelle definieren möchten.
4. Geben Sie dem Dataset einen Namen und klicken Sie auf die Schaltfläche **Hinzufügen**.
5. Das Dataset wird damit hinzugefügt. Sie können die dem Dataset zugeordneten Attribute und Aktionen sehen.

Sie können dieses Dataset jetzt an eines der datengebundenen Steuerelemente binden.

#### Dataset in die App einbinden

1. Navigieren Sie zu der Seite Ihrer App im Entwurfsmodus, zu der Sie die Liste hinzufügen möchten.
2. Klicken Sie auf **Steuerelemente anzeigen**, um **DATENGEBUNDEN** einzublenden.
3. Klicken Sie auf **DATENGEBUNDEN**, um die Anzeige zu erweitern. Ziehen Sie dann die **Liste** mit der Maus und legen Sie sie im Erstellungsbereich ab.
4. Aktualisieren Sie die **Werte** nach Bedarf. 
5. Fügen Sie den **Listentitel** hinzu.
6. Wählen Sie den **Listentyp** aus, mit dem Sie arbeiten möchten.
7. Fügen Sie Inhalt zu dem Listenelement hinzu.
8. Stellen Sie eine Verbindung zu einem zu verwendenden Dataset her. 

### Neues Dataset im Codemodus erstellen
{: #data-set-code-mode }

1. Öffnen Sie auf der Landing-Page des Digital App Builder eine vorhandene App oder erstellen Sie eine App im Codemodus.
2. Klicken Sie auf **</>**  (**Code-Snippets anzeigen**).
3. Navigieren Sie zu **IONIC** und fügen Sie das erforderliche Code-Snippet hinzu (Simple List, Card List, Header Button) und modifizieren Sie den Code nach Bedarf.


