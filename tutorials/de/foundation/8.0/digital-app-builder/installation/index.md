---
layout: tutorial
title: Installation und Konfiguration
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #installation-and-configuration }

Sie können den Digital App Builder jetzt auf den Plattformen Mac OS und Windows installieren. Bei der Erstinstallation wird gleichzeitig geprüft, ob vorausgesetzte Software vorhanden ist. Diese wird ggf. mit installiert. Sie können Java, Xcode und Android Studio zum Generieren von Adaptern und für eine App-Vorschau während der Entwicklung installieren. 

### Installation unter Mac OS
{: #installing-on-macos }

1. Laden Sie die .dmg-Datei (**IBM.Digital.App.Builder-n.n.n.dmg**, wobei `n.n.n` die Versionsnummer ist) über [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) oder von [hier](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases) herunter.
2. Klicken Sie doppelt auf die .dmg-Datei, um das Installationsprogramm anzuhängen.
3. Ziehen Sie in dem vom Installationsprogramm geöffneten Fenster IBM Digital App Builder mit der Maus in den Ordner **Applications** und legen Sie den App Builder dort ab.
4. Klicken Sie doppelt auf das Symbol für IBM Digital App Builder oder auf die ausführbare Datei, um den Digital App Builder zu öffnen.
    > **Hinweis**: Wenn der Digital App Builder zum ersten Mal installiert wird, öffnet er die Schnittstelle für die Installation von vorausgesetzter Software.
    
    ![Digital App Builder installieren](dab-install-startup.png)

5. Klicken Sie auf **Start setup**. Daraufhin erscheint die Anzeige mit der Lizenzvereinbarung.

    ![Anzeige der Lizenzvereinbarung](dab-install-license.png)

6. Akzeptieren Sie die Lizenzvereinbarung und klicken Sie auf **Next**. Daraufhin erscheint die Anzeige **Install Pre-requisites**.
    >**Hinweis**: Es wird überprüft, ob vorausgesetzte Software bereits installiert ist. Für jede dieser Softwarekomponenten wird der Status angezeigt.

    ![Anzeige 'Install Pre-requisites'](dab-install-prereq.png)

7. Klicken Sie auf **Install**, um die Softwarevoraussetzungen zu installieren, für die der Status **To be installed** ("zu installieren") angezeigt wird.

    ![Anzeige 'Install Pre-requisites'](dab-install-prereq-tobeinstalled.png)

8. Nach der Installation der Softwarevoraussetzungen erscheint die Startanzeige des Digital App Builder. Klicken Sie auf **Start building**.

    ![Startanzeige des Digital App Builder](dab-install-startup-screen.png)

9. *Optional* - Nach Installation der Softwarevoraussetzungen überprüft das Installationsprogramm, ob JAVA vorhanden ist, weil der Digital App Builder JAVA für die Arbeit mit Ihren Datasets benötigt.
    >**Hinweis**: Wenn Java noch nicht installiert ist, müssen Sie die Installation manuell durchführen. Informationen zur Installation von Java finden Sie unter [Installing Java](https://www.java.com/en/download/help/download_options.xml).
10. *Optional* - Das Installationsprogramm überprüft, ob die optionalen Komponenten Xcode (für die Voranzeige Ihrer App in einem iOS-Simulator während der Mac-OS-Entwicklung) und Android Studio (für die Voranzeige Ihrer Android-App unter Mac OS und Windows) installiert sind.
    >**Hinweis**: Sie müssen Xcode und Android Studio manuell installieren. Informationen zur Cocoapods-Installation finden Sie unter [Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods). Hinweise zur Installation von Android Studio finden Sie unter [Installing Android Studio](https://developer.android.com/studio/). 

>**Hinweis**: Sie können jederzeit eine [Prüfung der Voraussetzungen](#prerequisites-check) durchführen, um sicherzustellen, dass die Installation für die Entwicklung Ihrer App vollständig ist. Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

### Installation unter Windows
{: #installing-on-windows }

Öffnen Sie eine Eingabeaufforderung im Administratormodus und führen Sie die folgenden Befehle aus:

1. Laden Sie die .exe-Datei (**IBM.Digital.App.Builder.Setup.n.n.n.exe**, wobei `n.n.n` die Versionsnummer ist) über [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) oder von [hier](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases) herunter.
2. Klicken Sie für die Installation doppelt auf die ausführbare Datei von Digital App Builder. 

    ![Digital App Builder installieren](dab-install-startup.png)

3. Klicken Sie auf **Start setup**. Daraufhin erscheint die Anzeige mit der Lizenzvereinbarung.

    ![Anzeige der Lizenzvereinbarung](dab-install-license.png)

4. Akzeptieren Sie die Lizenzvereinbarung und klicken Sie auf **Next**. Daraufhin erscheint die Anzeige **Install Pre-requisites**.
    >**Hinweis**: Es wird überprüft, ob vorausgesetzte Software bereits installiert ist. Für jede dieser Softwarekomponenten wird der Status angezeigt.

    ![Anzeige 'Install Pre-requisites'](dab-install-prereq.png)

5. Klicken Sie auf **Install**, um die Softwarevoraussetzungen zu installieren, für die der Status **To be installed** ("zu installieren") angezeigt wird.

    ![Anzeige 'Install Pre-requisites'](dab-install-prereq-tobeinstalled.png)

6. Nach der Installation der Softwarevoraussetzungen erscheint die Startanzeige des Digital App Builder. Klicken Sie auf **Start building**.

    ![Startanzeige des Digital App Builder](dab-install-startup-screen.png)

    > **Hinweis**: Auf dem Desktop wird unter **Start > Programme** eine Verknüpfung erstellt. Der Standardinstallationsordner ist `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.2`.

7. *Optional* - Nach Installation der Softwarevoraussetzungen überprüft das Installationsprogramm, ob JAVA vorhanden ist, weil der Digital App Builder JAVA für die Arbeit mit Ihren Datasets benötigt.
    >**Hinweis**: Wenn Java noch nicht installiert ist, müssen Sie die Installation manuell durchführen. Informationen zur Installation von Java finden Sie unter [Installing Java](https://www.java.com/en/download/help/download_options.xml).
8. *Optional* - Das Installationsprogramm überprüft, ob die optionalen Komponenten Xcode (für die Voranzeige Ihrer App in einem iOS-Simulator während der Mac-OS-Entwicklung) und Android Studio (für die Voranzeige Ihrer Android-App unter Mac OS und Windows) installiert sind.
    >**Hinweis**: Sie müssen Android Studio manuell installieren. Hinweise zur Installation von Android Studio finden Sie unter [Installing Android Studio](https://developer.android.com/studio/). 

>**Hinweis**: Sie können jederzeit eine [Prüfung der Voraussetzungen](#prerequisites-check) durchführen, um sicherzustellen, dass die Installation für die Entwicklung Ihrer App vollständig ist. Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

### Prüfung der Voraussetzungen
{: #prerequisites-check }

Bevor Sie eine App entwickeln, können Sie **Hilfe > Prüfung der Voraussetzungen** auswählen, um eine Überprüfung der Voraussetzungen durchzuführen.

![Prüfung der Voraussetzungen](dab-prerequsites-check.png)

Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

>**Hinweis**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) ist nur für Mac OS erforderlich.

