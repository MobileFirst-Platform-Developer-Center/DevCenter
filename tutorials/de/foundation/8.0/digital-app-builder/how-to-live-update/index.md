---
layout: tutorial
title: Ein-/Ausschalten von Features mit der Liveaktualisierung
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Ein-/Ausschalten von Features mit der Liveaktualisierung
{: #dab-feature-toggle-live-update }

Sie können die Liveaktualisierung nutzen, um verschiedene Aspekte Ihrer App konfigurierbar zu machen und über Fernzugriff Features ein- oder auszuschalten. Zudem können Sie dynamisch die Eigenschaften der App steuern, indem Sie die Werte von Variablen direkt in der MobileFirst Operations Console ändern.

Mit dem Binärwert "Ein/Aus" eines App-Features kann das Feature ein- oder ausgeschaltet werden.

Eigenschaften sind Name-Wert-Paare, über die das Verhalten der App gesteuert werden kann.

>**Hinweis**: Die Liveaktualisierung ist erst verfügbar, wenn die App betriebsbereit ist.


### Liveaktualisierung im Entwurfsmodus hinzufügen

Gehen Sie wie folgt vor, um die Liveaktualisierung zu Ihrer App hinzuzufügen:

1. Wählen Sie **Engagement** aus. Daraufhin wird die Liste der verfügbaren Services angezeigt. 

    ![Engagement - Liveaktualisierung](dab-live-update.png)

2. Wählen Sie **Liveaktualisierung** aus und klicken Sie auf **Aktivieren**. Daraufhin wird die Liveaktualisierung in Mobile Foundation Server konfiguriert. Wenn die Liveaktualisierung erfolgreich aktiviert ist, wird ein Popup-Fenster angezeigt.

    ![Liveaktualisierung aktivieren](dab-live-update-enable.png)

3. Klicken Sie auf **+ Neues Feature**, um ein neues Feature für Mobile Foundation Server zu definieren. Daraufhin erscheint die nachfolgend dargestellte Anzeige.

    ![Neues Feature](dab-live-update-new-feature.png)

4. Geben Sie die **Feature-ID** und den **Featurenamen** ein und legen Sie die Standardeinstellung für **Sichtbarkeit** fest.

    * **Feature-ID** - Eindeutige ID für ein Feature
    * **Featurename** - Name, der ein Feature beschreibt

    ![Neue Eigenschaft](dab-live-update-feature-new.png)

5. Klicken Sie auf **Erstellen**.

6. Ganz ähnlich wird eine Eigenschaft für Liveaktualisierung definiert. Machen Sie dafür die folgenden Angaben:

    * **Eigenschafts-ID**
    * **Eigenschaftsname**
    * **Eigenschaftswert**

### Liveaktualisierung im Codemodus hinzufügen

Gehen Sie wie folgt vor, um die Liveaktualisierung zu Ihrer App hinzuzufügen:

**Methode 1**

1. Öffnen Sie die App im Codemodus.
2. Navigieren Sie zu Ihrer Datei `projectname/ionic/src/app/app.component.ts`.

    ![Neue Eigenschaft - Methode 1](dab-live-update-new-feature-code.png)

3. Wählen Sie die Methode für die Initialisierung der Liveaktualisierung aus.
4. Bearbeiten Sie den Code so, dass ein Steuerelement ein-/ausgeblendet wird und die Eigenschaft des Steuerelements definiert wird.

**Methode 2**

1. Öffnen Sie die App im Codemodus.
2. Navigieren Sie zu den Code-Snippets und klicken Sie auf **</>**.
3. Wählen Sie "Live Update > Live Update Configuration" aus.

    ![Neue Eigenschaft - Methode 2](dab-live-update-new-feature-code-snippet.png)

4. Ziehen Sie das Code-Snippet **Live Update Configuration** mit der Maus und legen Sie es in Ihrem Code ab.
5. Bearbeiten Sie den Code so, dass ein Steuerelement ein-/ausgeblendet wird und die Eigenschaft des Steuerelements definiert wird.

