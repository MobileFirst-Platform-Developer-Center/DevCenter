---
layout: tutorial
title: Entwicklung für Apple watchOS
breadcrumb_title: watchOS 2, watchOS 3
relevantTo: [ios]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
In diesem Beispiel lernen Sie, wie die Entwicklungsumgebung für watchOS 2 eingerichtet und das {{ site.data.keys.product_adj }}-Framework verwendet wird. Das erstellte und verwendete Beispiel gilt für watchOS 2. Es funktioniert aber auch unter watchOS 3.

## Setup
{: #setup }
Erstellen Sie das Xcode-Projekt, fügen Sie das
watchOS-Framework hinzu und konfigurieren Sie die erforderlichen Ziele, um Ihre Entwicklungsumgebung für watchOS einzurichten. 

1. Erstellen Sie in Xcode eine watchOS-2-App. 
    * Wählen Sie die Option **File → New → Project** aus. Daraufhin wird der Dialog **Choose a template for your new project** angezeigt. 
    * Wählen Sie die Option **watchOS2/Application ** aus und klicken Sie auf **Next**.
    * Benennen Sie das Projekt und klicken Sie auf **Next**.
    * Wählen Sie vom Navigationsdialog den Projektordner aus.

    Die Projektnavigationsstruktur enthält jetzt einen Haupt-App-Ordner, einen Ordner
**[Projektname] WatchKit Extension** und ein Ziel.


    ![watchOS-Projekt in Xcode](WatchOSProject.jpg)

2. Fügen Sie das {{ site.data.keys.product_adj }}-watchOS-Framework
hinzu. 
    * Informationen zur Installation der erforderlichen Frameworks mit CocoaPods enthält das Lernprogramm [Natives {{ site.data.keys.product_adj }}-SDK hinzufügen](../../application-development/sdk/ios/#adding-support-for-apple-watchos). 
    * Gehen Sie wie folgt vor, um die erforderlichen Frameworks manuell zu installieren: 
        * Fordern Sie im Download-Center in der {{ site.data.keys.mf_console }} das watchOS-Framework an. 
        * Wählen Sie links im Navigationsbereich den Ordner **[Projektname] WatchKit Extension** aus. 
        * Wählen Sie im Menü **Datei** den Eintrag **Dateien
hinzufügen** aus.
        * Klicken Sie auf die Schaltfläche **Optionen** und wählen Sie Folgendes aus: 
            * Optionen **Copy items if needed** und **Create
groups**
            * **[Projektname] WatchKit Extension** im Abschnitt **Add to targets**
        * Klicken Sie auf **Hinzufügen**.

        Wenn Sie jetzt im Abschnitt **Targets** den Ordner **[Projektname] WatchKit Extension** auswählen, sehen Sie Folgendes: 
            * Der Frameworkpfad erscheint in der Einstellung **Framework Search
Paths** im Abschnitt **Search Paths** der Registerkarte
**Build Settings**. 
            * Im Abschnitt **Link Binary With Libraries** der Registerkarte
**Build Phases** wird die Datei **IBMMobileFirstPlatformFoundationWatchOS.framework** aufgelistet.
            ![Frameworks in Verbindung mit watchOS](watchOSlinkedframeworks.jpg)

        > **Hinweis:** WatchOS 2 erfordert Bitcode. Ab Xcode 7 sind die **Build
Options** auf **Enable Bitcode Yes** gesetzt (Abschnitt **Build
Options** der Registerkarte **Build Settings**).

3. Registrieren Sie sowohl die Haupt-App als auch die WatchKit-Erweiterung beim Server. Führen Sie für jede Bundle-ID `mfpdev app register` aus (oder führen Sie die Registrierung in der
{{ site.data.keys.mf_console }} aus):
    * com.worklight.[Projektname]
    * com.worklight.[Projektname].watchkitextension

4. Navigieren Sie in Xcode im Menü "File -> Add
File" zur Datei mfpclient.plist, die mit
mfpdev erstellt wurde, und fügen Sie sie zum Projekt hinzu. 
    * Wählen Sie im Feld **Target Membership** die anzuzeigende Datei aus. Wählen Sie zusätzlich zu **WatchOSDemoApp** das Ziel
**WatchOSDemoApp
WatchKit Extension** aus. 

Das Xcode-Projekt enthält jetzt eine Haupt-App und eine watchOS-2-App, die unabhängig voneinander entwickelt werden können. Der Swift-Eintrittspunkt für die
watchOS-2-App ist die Datei **InterfaceController.swift** im Ordner **[Projektname] watchKit Extension**". Der Objective-C-Eintrittspunkt ist die Datei **ViewController.m**. 

## {{ site.data.keys.product_adj }}-Sicherheit für eine iPhone-App und eine watchOS-App einrichten
{: #setting-up-mobilefirst-security-for-the-iphone-app-and-the-watchos-app }
Die Apple Watch unterscheidet sich physisch vom iPhone. Die Sicherheitsüberprüfungen müssen daher zum jweiligen Eingabegerät
passen. Die Apple
Watch hag beispielsweise nur einen Ziffernblick, sodass die übliche Sicherheitsüberprüfung mit Benutzernamen/Kennwort nicht möglich ist. Der Zugriff auf geschützte Ressourcen auf dem Server könnte dafür über
einen PIN-Code aktiviert werden. Aufgrund dieser und vergleichbarer Unterschiede ist es notwendig, für jedes Ziel andere Sicherheitsüberprüfungen
einzurichten. 

Es folgt ein Beispiel für die Erstellung einer App, einmal mit einem
iPhone und einmal mit einer Apple Watch als Ziel. Die Architektur ermöglicht für jedes dieser Ziele eine eigene Sicherheitsüberprüfung. Die unterschiedlichen
Sicherheitsüberprüfungen sind nur Beispiele dafür, wie Features für diese Ziele gestaltet werden können.
Es kann weitere Sicherheitsüberprüfungen geben. 

1. Bestimmen Sie den Bereich und die Sicherheitsüberprüfungen, die für die geschützte Ressource gelten.
2. Gehen Sie in der {{ site.data.keys.mf_console }} wie folgt vor:
    * Stellen Sie sicher, dass beide Apps beim Server registriert sind: 
        * com.worklight.[Projektname]
        * com.worklight.[Projektname].watchkitextension
    * Ordnen Sie scopeName wie folgt den definierten Sicherheitsüberprüfungen zu: 
        * Für com.worklight.[Projektname] muss scopeName der Überprüfung mit
Benutzernamen/Kennwort zugeordnet werden. 
        * Für com.worklight.[Projektname].watchkitapp.watchkitextension muss scopeName der Sicherheitsüberprüfung mit
PIN-Code zugeordnet werden. 

## Einschränkung für watchOS
{: #watchos-limitation }
Die optionalen Frameworks, die Features
zu den {{ site.data.keys.product_adj }}-Apps hinzufügen, werden nicht für die
watchOS-Entwicklung bereitgestellt. Darüber hinaus gibt es Features, für die es Einschränkungen seitens
der Uhr mit watchOS oder der Apple Watch gibt. 

| Feature | Einschränkung |
|---------|------------|
| openSSL | Nicht unterstützt |
| JSONStore| Nicht unterstützt |
| Benachrichtigungen | Nicht unterstützt |
| Vom {{ site.data.keys.product_adj }}-Code angezeigte Nachrichtenalerts | Nicht unterstützt |
| Validierung der Anwendungsauthentizität | Nicht mit Bitcode kompatibel und daher nicht unterstützt |
| Inaktivierung/Benachrichtigung über Fernzugriff	| Erfordert Anpassungen (siehe unten) |
| Sicherheitsüberprüfung mit Benutzernamen/Kennwort | Sicherheitsüberprüfung CredentialsValidation verwenden |

### Inaktivierung/Benachrichtigung über Fernzugriff
{: #remote-disablenotify }
In der
{{ site.data.keys.mf_console }} können Sie
{{ site.data.keys.mf_server }} so konfigurieren, dass
der Zugriff auf Clientanwendungen je nach ausgeführter Version inaktiviert (und eine Nachricht zurückgegeben) wird
(siehe [Anwendungszugriff
auf geschützte Ressourcen über Fernzugriff inaktivieren](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources)). Zwei Optionen stellen Standard-UI-Alerts bereit: 

* Wenn die App aktiv ist und Nachrichten gesendet werden: **Aktiv und Benachrichtigung**
* Wenn die App veraltet ist und der Zugriff verweigert wird: **Zugriff verweigert**

watchOS:

* Wenn die App auf **Aktiv und Benachrichtigung** gesetzt ist und Sie Nachrichten anzeigen möchten, muss ein Abfrage-Handler für die Inaktivierung über Fernzugriff implementiert und registriert werden. Der angepasste Abfrage-Handler muss mit der Sicherheitsüberprüfung
`wl_remoteDisableRealm` initialisiert werden.

* Wenn der Zugriff inaktiviert ist (**Zugriff verweigert**), empfängt die Client-App im Fehler-Callback oder im Handler des Anforderungsdelegaten eine
Fehlernachricht. Der Entwickler kann entscheiden, wie der Fehler behandelt werden soll.
Der Benutzer kann über die UI benachrichtigt werden oder der Fehler kann ins Protokoll geschrieben werden. Darüber hinaus kann ein angepasster Abfrage-Handler erstellt und
verwendet werden. 
