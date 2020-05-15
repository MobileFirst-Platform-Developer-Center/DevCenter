---
layout: tutorial
title: Ein-/Ausschalten von Features mit der Liveaktualisierung
weight: 13
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Ein-/Ausschalten von Features mit der Liveaktualisierung
{: #dab-feature-toggle-live-update }

Sie können die Liveaktualisierung nutzen, um verschiedene Aspekte Ihrer App konfigurierbar zu machen und über Fernzugriff Features ein- oder auszuschalten. Zudem können Sie dynamisch die Eigenschaften der App steuern, indem Sie die Werte von Variablen direkt in der MobileFirst Operations Console ändern.

* Mit dem Binärwert "Ein/Aus" eines App-Features kann das Feature ein- oder ausgeschaltet werden.
* Eigenschaften sind Name-Wert-Paare, über die das Verhalten der App gesteuert werden kann.

>**Hinweis**: Die Liveaktualisierung ist erst verfügbar, wenn die App betriebsbereit ist.

### Liveaktualisierung aktivieren

Sie können wie folgt vorgehen, um das Feature für Liveaktualisierungen zu aktivieren:

1. Wählen Sie **Engagement** aus. Daraufhin wird die Liste der verfügbaren Services angezeigt. 

    ![Engagement - Liveaktualisierung](dab-live-update.png)

2. Wählen Sie **Liveaktualisierung** aus und klicken Sie auf **Aktivieren**. Daraufhin wird die Liveaktualisierung in Mobile Foundation Server konfiguriert. Wenn die Liveaktualisierung erfolgreich aktiviert ist, wird ein Popup-Fenster angezeigt.

    ![Liveaktualisierung aktivieren](dab-live-update-enable.png)

3. Klicken Sie auf **+ Neues Feature**, um ein neues Feature für Mobile Foundation Server zu definieren. Daraufhin erscheint die nachfolgend dargestellte Anzeige.

    ![Neue Eigenschaft](dab-live-update-feature-new.png)

4. Geben Sie die **Feature-ID** und den **Featurenamen** ein und legen Sie die Standardeinstellung für **Sichtbarkeit** fest.

    * **Feature-ID** - Eindeutige ID für ein Feature
    * **Featurename** - Name, der ein Feature beschreibt

5. Klicken Sie auf **Erstellen**.

6. Ganz ähnlich wird eine Eigenschaft für Liveaktualisierung definiert. Machen Sie dafür die folgenden Angaben:

    * **Eigenschafts-ID**
    * **Eigenschaftsname**
    * **Eigenschaftswert**

### Liveaktualisierung im Entwurfmodus verwenden

Wenn Sie im Entwurfmodus arbeiten und die Option für Liveaktualisierung aktiviert haben, können Sie für das ausgewählte Steuerelement den **Textwert** oder die **Textfarbe** oder die **Hintergrundfarbe** ändern und für diese Änderungen eine Liveaktualisierung durchführen, indem Sie eine neue Eigenschaft definieren oder eine vorhandene Eigenschaft auswählen und bearbeiten. Sie können den Eigenschaftswert in der Tabelle für Liveaktualisierungen modifizieren, in der die Features und ihre zugehörigen Eigenschaften aufgelistet sind.

#### Steuerelement mit einem Feature verknüpfen

Gehen Sie wie folgt vor, um ein Steuerelement mit einem Feature zu verknüpfen:

1. Klicken Sie auf ein Steuerelement, um es auszuwählen. 
2. Definieren Sie ein neues Feature. Klicken Sie dazu im Abschnitt **Steuerelemente ein-/ausblenden** für die Option **Feature auswählen** auf das Pluszeichen (**+**). 
3. Geben Sie für das neue Feature jeweils einen Wert für **Feature-ID** und **Featurename** an und aktivieren oder inaktivieren Sie die Sichtbarkeit über den **An-/Ausschalter**.

#### Eigenschaft eines Steuerelements modifizieren

Gehen Sie wie folgt vor, um die Eigenschaft eines Steuerelements zu modifizieren:

Wählen Sie ein Steuerelement aus und geben Sie **${property_name}** ein oder wählen Sie die zuzuordnende Eigenschaft in der Liste aus. Sie können auch eine neue Eigenschaft erstellen. Wählen Sie dazu **Neue Eigenschaft hinzufügen** aus und geben Sie jeweils einen Wert für **Eigenschafts-ID**, **Eigenschaftsname** und **Eigenschaftswert** an.
 
Für Liveaktualisierungen können Sie die folgenden Steuerelemente und Eigenschaften verwenden:

* **Schaltfläche** - Textwert, Textfarbe, Hintergrundfarbe
* **Überschrift** - Textwert, Textfarbe
* **Bezeichnung** - Textwert, Textfarbe

### Liveaktualisierung im Codemodus hinzufügen

Gehen Sie wie folgt vor, um die Liveaktualisierung zu Ihrer App hinzuzufügen:

**Methode 1**

1. Öffnen Sie die App im Codemodus.
2. Navigieren Sie zu Ihrer Datei `projectname/ionic/src/app/app.component.ts`.

    ![Liveaktualisierung im Codemodus hinzufügen - Methode 1](dab-live-update-new-feature-code.png)

3. Wählen Sie die Methode für die Initialisierung der Liveaktualisierung aus.
4. Bearbeiten Sie den Code so, dass ein Steuerelement ein-/ausgeblendet wird und die Eigenschaft des Steuerelements definiert wird.

**Methode 2**

1. Öffnen Sie die App im Codemodus.
2. Navigieren Sie zu den Code-Snippets und klicken Sie auf **</>**.
3. Unter **Liveaktualisierung** können Sie mit der Maus das Code-Snippet **Feature für Liveaktualisierung** oder **Eigenschaft für Liveaktualisierung** an die gewünschte Position ziehen.

    ![Liveaktualisierung im Codemodus hinzufügen - Methode 2](dab-live-update-new-feature-code-snippet.png)

4. Bearbeiten Sie den Code so, dass ein Steuerelement ein-/ausgeblendet wird und die Eigenschaft des Steuerelements definiert wird.
