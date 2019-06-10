---
layout: tutorial
title: Installation und Konfiguration
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #installation-and-configuration }

Sie können den Digital App Builder auf den Plattformen Mac OS und Windows installieren.

### Installation unter Mac OS
{: #installing-on-macos }

1. Installieren Sie **Node.js** und **npm**. Laden Sie dazu das Setup von [https://nodejs.org/en/download](https://nodejs.org/en/download) herunter (Node.js ab Version 8.x). Weitere Informationen zu Installationsanweisungen finden Sie [hier](https://nodejs.org/en/download/package-manager/). Überprüfen Sie wie folgt die Node- und npm-Version:
    ```java
    $node -v
    v8.10.0
    $npm -v
    6.4.1
    ```
2. Installieren Sie **Cordova**. Sie können das Paket von [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html) herunterladen und installieren.
    ```java
    $ npm install -g cordova
    $ cordova –version
    7.0.1
    ```

    >**Hinweis**: Wenn bei der Ausführung des Befehls `$npm install -g cordova` Berechtigungsprobleme auftreten, verwenden Sie eine höhere Berechtigungsstufe für die Installation (`$ sudo npm install -g cordova`).

3. Installieren Sie **Ionic**. Sie können das Paket von [Ionic](https://ionicframework.com/docs/cli/) herunterladen und installieren.
    ```java
    $ npm install -g ionic
    $ ionic –version
    4.2.0
    ```

    >**Hinweis**: Wenn bei der Ausführung des Befehls `$npm install -g ionic` Berechtigungsprobleme auftreten, verwenden Sie eine höhere Berechtigungsstufe für die Installation (`$ sudo npm install -g ionic`).

4. Laden Sie die .dmg-Datei (**IBM.Digital.App.Builder-8.0.0.dmg**) über [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) oder von [hier](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases) herunter.
5. Klicken Sie doppelt auf die .dmg-Datei, um das Installationsprogramm anzuhängen.
6. Ziehen Sie in dem vom Installationsprogramm geöffneten Fenster IBM Digital App Builder mit der Maus in den Ordner **Applications** und legen Sie den App Builder dort ab.
7. Klicken Sie doppelt auf das Symbol für IBM Digital App Builder oder auf die ausführbare Datei, um den Digital App Builder zu öffnen.
>**Hinweis**: Wenn der Digital App Builder zum ersten Mal installiert wird, öffnet er die Schnittstelle und führt eine [Überprüfung der Voraussetzungen](#prerequisites-check) durch. Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

### Installation unter Windows
{: #installing-on-windows }

Öffnen Sie eine Eingabeaufforderung im Administratormodus und führen Sie die folgenden Befehle aus:

1. Installieren Sie **Node.js** und **npm**. Laden Sie dazu das Setup von [https://nodejs.org/en/download](https://nodejs.org/en/download) herunter (Node.js ab Version 8.x). Weitere Informationen zu Installationsanweisungen finden Sie [hier](https://nodejs.org/en/download/package-manager/). Überprüfen Sie wie folgt die Node- und npm-Version:
     

    ```java
    C:\>node -v
    v8.10.0
    C:\>npm -v
    6.4.1
    ```

2. Installieren Sie **Cordova**. Sie können das Paket von [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html) herunterladen und installieren.

    ```java
    C:\>npm install -g cordova
    C:\>cordova –v
    7.0.1
    ```

3. Installieren Sie **Ionic**. Sie können das Paket von [Ionic](https://ionicframework.com/docs/cli/) herunterladen und installieren.

    ```java
    C:\>npm install -g ionic
    C:\> ionic –version
    4.2.0
    ``` 

4. Laden Sie die .exe-Datei (**IBM.Digital.App.Builder.Setup.exe**) über [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) oder von [hier](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases) herunter.
5. Klicken Sie für die Installation doppelt auf die ausführbare Datei von Digital App Builder. Auf dem Desktop wird unter **Start > Programme** eine Verknüpfung erstellt. Der Standardinstallationsordner ist `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.0`.
>**Hinweis**: Wenn der Digital App Builder zum ersten Mal installiert wird, öffnet er die Schnittstelle und führt eine [Überprüfung der Voraussetzungen](#prerequisites-check) durch. Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

### Prüfung der Voraussetzungen
{: #prerequisites-check }

Bevor Sie eine App entwickeln, können Sie **Hilfe > Prüfung der Voraussetzungen** auswählen, um eine Überprüfung der Voraussetzungen durchzuführen.

![Prüfung der Voraussetzungen](dab-prerequsites-check.png)

Falls Fehler auftreten, korrigieren Sie diese und starten Sie den Digital App Builder neu, bevor Sie eine App erstellen. 

>**Hinweis**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) ist nur für Mac OS erforderlich.

