---
layout: tutorial
title: MobileFirst-Foundation-SDK zu universellen Windows-8.1- oder Windows-10-UWP-Anwendungen hinzufügen
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das SDK der {{ site.data.keys.product }}
besteht aus einer Reihe von Abhängigkeiten, die über den [Nuget](https://www.nuget.org/) verfügbar sind und zu einem Visual-Studio-Projekt hinzugefügt werden können. Die Abhängigkeiten entsprechen Kernfunktionen und anderen Funktionen:  

* **IBMMobileFirstPlatformFoundation** - Implementiert Client-Server-Konnektivität, handhabt Authentifizierungs- und Sicherheitsaspekte, Ressourcenanforderungen und weitere erforderliche Kernfunktionen

In diesem Lernprogramm erfahren Sie, wie das native {{ site.data.keys.product_adj }}-SDK mithilfe von Nuget
zu einer neuen oder vorhandenen universellen Windows-8.1-Anwendung oder Windows-10-UWP-Anwendung (universelle Windows-Plattform) hinzugfügt wird. Sie werden auch lernen,
wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen.
Außerdem erfahren Sie, wie Sie Informationen zu den {{ site.data.keys.product_adj }}-Konfigurationsdateien, die zum Projekt hinzugefügt werden, finden können. 

**Voraussetzungen:**

- Microsoft Visual Studio 2013 oder 2015 und die {{ site.data.keys.mf_cli }} sind auf der Entwicklerworkstation installiert. Für die Entwicklung einer Windows-10-UWP-Lösung ist Visual Studio 2015 oder eine aktuellere Version erforderlich.
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme
[{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst)
und [Windows-8-Universal- und Windows-10-UWP-Entwicklungsumgebung einrichten](../../../installation-configuration/development/windows) durchgearbeitet. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Natives {{ site.data.keys.product_adj }}-SDK hinzufügen](#adding-the-mobilefirst-native-sdk)
- [Natives {{ site.data.keys.product_adj }}-SDK manuell hinzufügen](#manually-adding-the-mobilefirst-win-native-sdk)
- [Natives {{ site.data.keys.product_adj }}-SDK aktualisieren](#updating-the-mobilefirst-native-sdk)
- [Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK](#generated-mobilefirst-native-sdk-artifacts)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

## Natives {{ site.data.keys.product_adj }}-SDK hinzufügen
{: #adding-the-mobilefirst-native-sdk }
Folgen Sie den nachstehenden Anweisungen, um das native {{ site.data.keys.product_adj }}-SDK
zu einem neuen oder vorhandenen Visual-Studio-Projekt hinzuzufügen und die Anwendung bei {{ site.data.keys.mf_server }} zu registrieren.

Vergewissern Sie sich als Erstes, dass die MobileFirst-Server-Instanz aktiv
ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.cmd` aus.

### Anwendung erstellen
{: #creating-an-application }
Erstellen Sie ein universelles Windows-8.1-Projekt oder ein Windows-10-UWP-Projekt. Verwenden Sie dazu Visual Studio 2013/2015. Sie können auch ein vorhandenes Projekt nutzen.   

### SDK hinzufügen
{: #adding-the-sdk }
1. Verwenden Sie für den Import von {{ site.data.keys.product_adj }}-Paketen den Paketmanager NuGet.
NuGet ist der Paketmanager für die Microsoft-Entwicklungsplattform, einschließlich .NET. Mit den NuGet-Client-Tools können Sie Pakete erzeugen und verwenden. Die NuGet Gallery ist das zentrale
Paketrepository, das alle Ersteller und Nutzer von Paketen verwenden. 

2. Öffnen Sie das universelle Windows-8.1-Projekt oder Windows-10-UWP-Projekt in Visual Studio 2013/2015. Klicken Sie mit der rechten Maustaste auf die Projektmappe und wählen Sie **NuGet-Pakete verwalten** aus.

    ![Add-Nuget-tosolution-VS-settings](Add-Nuget-tosolution0.png)

3. Suchen Sie mit der Suchfunktion nach "IBM MobileFirst Platform". Wählen Sie **IBM.MobileFirstPlatform.{{ site.data.keys.product_V_R_M_I }}** aus.

    ![Add-Nuget-tosolution-search](Add-Nuget-tosolution1.png)

    ![Add-Nuget-tosolution-choose](Add-Nuget-tosolution2.png)

4. Klicken Sie auf **Installieren**. Mit dieser Aktion werden das native SDK der {{ site.data.keys.product }} und die zugehörigen Abhängigkeiten installiert. Mit diesem Schritt wird außerdem eine leere Datei `mfpclient.resw` im Ordner `strings`
des Visual-Studio-Projekts generiert. 

5. Stellen Sie sicher, dass in `Package.appxmanifest` mindestens die folgenden Leistungsmerkmale aktiviert sind: 

    - Internet (Client)

### Natives {{ site.data.keys.product_adj }}-SDK manuell hinzufügen
{: #manually-adding-the-mobilefirst-win-native-sdk }

Sie können das SDK der {{ site.data.keys.product }} auch manuell hinzufügen:

<div class="panel-group accordion" id="adding-the-win-sdk" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="win-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>Für Anweisungen hier klicken</b></a>
                                </h4>
        </div>

        <div id="collapse-win-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="win-sdk">
            <div class="panel-body">
                <p>Sie können Ihre Umgebung für die Entwicklung von MobileFirst-Anwendungen vorbereiten, indem Sie die Framework- und Bibliotheksdateien manuell abrufen. Das SDK der {{ site.data.keys.product }} für Windows 8 Universal und Windows 10 UWP (universelle Windows-Plattform) ist auch über NuGet verfügbar.</p>

                <ol>
                    <li>Rufen Sie das SDK der {{ site.data.keys.product }} über das Download-Center der {{ site.data.keys.mf_console }} auf der Registerkarte <b>SDKs</b> ab.</li>
                    <li>Extrahieren Sie den Inhalt des in Schritt 1 heruntergeladenen SDK.</li>
                    <li>Öffnen Sie das native universelle Windows-Projekt in Visual Studio. Führen Sie folgende Schritte aus:
                        <ol>
                            <li>Wählen Sie <b>Extras → NuGet-Paket-Manager → Paket-Manager-Einstellungen</b> aus.</li>
                            <li>Wählen Sie die Option <b>Paketquellen</b> aus. Klicken Sie auf das Pluszeichen (<b>+</b>), um eine neue Paketquelle hinzuzufügen.</li>
                            <li>Geben Sie einen Namen für die Paketquelle an (z. B. <em>windows8nuget</em>).</li>
                            <li>Navigieren Sie zu dem Ordner, in den Sie das MobileFirst-SDK heruntergeladen und extrahiert haben. Klicken Sie auf <b>OK</b>.</li>
                            <li>Klicken Sie auf <b>Aktualisieren</b> und dann auf <b>OK</b>.</li>
                            <li>Klicken Sie oben rechts im <b>Projektmappen-Explorer</b> mit der rechten Maustaste auf den <b>Projektnamen</b>.</li>
                            <li>Wählen Sie <b>NuGet-Pakete für Projektmappe verwalten → Online → windows8nuget</b>.</li>
                            <li>Klicken Sie auf die Option <b>Installien</b>. Es erscheint die Option <b>Projekte auswählen</b>.</li>
                            <li>Stellen Sie sicher, dass alle Kontrollkästchen ausgewählt sind. Klicken Sie auf <b>OK</b>.</li>
                        </ol>

                    </li>
                </ol>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#win-sdk" data-target="#collapse-win-sdk" aria-expanded="false" aria-controls="collapse-win-sdk"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

### Anwendung registrieren
{: #reigstering-the-application }
1. Öffnen Sie eine **Befehlszeile** und navigieren Sie zum Stammverzeichnis des Visual-Studio-Projekts.   

2. Führen Sie den folgenden Befehl aus: 

   ```bash
   mfpdev app register
   ```
    - Wenn ein ferner Server verwendet wird,
fügen Sie ihn mit dem [Befehl `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) hinzu. 

Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung
zu {{ site.data.keys.mf_server }} her, um die Anwendung zu registrieren. Anschließend wird die Datei
**mfpclient.resw** im Ordner **strings** des Visual-Studio-Projekts aktualisiert. Zu der Datei werden Metadaten hinzugefügt, die den
{{ site.data.keys.mf_server }} angeben. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können
Anwendungen auch über die {{ site.data.keys.mf_console }} registrieren:    
>
> 1. Laden Sie die {{ site.data.keys.mf_console }}.  
> 2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen.   
> 3. Navigieren Sie nach der Anwendungsregistrierung zum Anwendungsregister **Konfigurationsdateien** und kopieren Sie die Datei **mfpclient.resw** laden Sie diese Datei herunter. Folgen Sie den angezeigten Anweisungen, um die entsprechende Datei zu Ihrem Projekt hinzuzufügen.

## Natives {{ site.data.keys.product_adj }}-SDK aktualisieren
{: #updating-the-mobilefirst-native-sdk }
Wenn Sie das native {{ site.data.keys.product_adj }}-SDK auf den neuesten Releasestand bringen wollen,
führen Sie in einem **Befehlszeilenfenster** im Stammverzeichnis des Visual-Studio-Projekts den folgenden Befehl aus: 

```bash
Nuget update
```

## Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.resw
{: #mfpclientresw }
Im Ordner `strings` des Projekts befindet sich diese Datei mit Serverkonnektivitätseigenschaften, die vom Benutzer bearbeitet werden können: 

- `protocol` – Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }}; `HTTP` oder `HTTPS`
- `WlAppId` - Kennung der Anwendung, die mit der Anwendungs-ID im Server übereinstimmen muss 
- `host` – Hostname der MobileFirst-Server-Instanz
- `port` – Port der MobileFirst-Server-Instanz
- `wlServerContext` – Kontextstammverzeichnis der Anwendung in der MobileFirst-Server-Instanz
- `languagePreference` - Legt die Standardsprache für Client-SDK-Systemnachrichten fest

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das native {{ site.data.keys.product_adj }}-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
