---
layout: tutorial
title: App entwickeln
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #developing-an-app }

Beim Entwickeln einer App führen Sie die folgenden Schritte aus:

1. Erstellen Sie eine App (siehe Abschnitt [App erstellen](../getting-started/)).
2. Gestalten Sie Ihre App, indem Sie die erforderlichen Steuerelemente hinzufügen (siehe [Digital-App-Builder-Schnittstelle](../dab-interface/)).
3. Fügen Sie benötigte Services (Watson Chat, Watson Visual Recognition, Push-Benachrichtigungen, Dataset) zu Ihrer App hinzu.
4. Fügen Sie Plattformen hinzu bzw. modifizieren Sie diese (siehe Abschnitt [Einstellungen > App-Details](../dab-interface/)).
5. Sehen Sie sich eine Vorschau Ihrer App an (siehe [App-Vorschau im Simulator](#preview-the-app-using-the-simulator)).
6. Wenn Ihre Anwendung nach der Vorschau bereit ist und Sie alle ggf. vorhandenen Fehler korrigiert haben, führen Sie die folgenden Buildschritte aus:

    * **Android-App:**

        a. Navigieren Sie zu dem Verzeichnis, das Sie beim Erstellen der App angegeben haben.

        b. Navigieren Sie zum Ionic-Ordner.

        c. Navigieren Sie zu **Plattform > Android**.

        d. Öffnen Sie Android Studio und wählen Sie **File > Open Project** aus. Wählen Sie den in Schritt c angegebenen Android-Ordner aus.

        e. Erstellen Sie den Projektbuild. 

        >**Hinweis**: Führen Sie für die Veröffentlichung und Erstellung die Schritte im Lernprogramm [https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/) aus.

    * **iOS-App**:
 
        a. Navigieren Sie zu dem Verzeichnis, das Sie beim Erstellen der App angegeben haben.

        b. Navigieren Sie zum Ionic-Ordner.

        c. Navigieren Sie zu "Plattform" > "iOS".

        d. Öffnen Sie **Xcode** und erstellen Sie den Projektbuild. 

        >**Hinweis**: Führen Sie für die Veröffentlichung und Erstellung die Schritte im Lernprogramm [https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/) aus.


### App-Vorschau im Simulator
{: #preview-the-app-using-the-simulator }

Sie können eine Vorschau der entwickelten App anzeigen. Stellen Sie dazu eine Verbindung zur Simulation mit dem ausgewählten Kanal her.

* Für eine Vorschau der App für iOS müssen Sie **Xcode** aus dem Apple App Store herunterladen und installieren.
* Gehen Sie für eine Vorschau der App für Android wie folgt vor: 
    * Installieren Sie Android Studio und befolgen Sie die Anweisungen ([https://developer.android.com/studio/](https://developer.android.com/studio/)).
    * Konfigurieren Sie eine virtuelle Android-Maschine. Diesbezügliche Anweisungen finden Sie [hier](https://developer.android.com/studio/releases/emulator).

