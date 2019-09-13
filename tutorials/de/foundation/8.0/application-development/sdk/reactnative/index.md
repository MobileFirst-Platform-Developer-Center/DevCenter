---
layout: tutorial
title: MobileFirst-Foundation-SDK zu React-Native-Anwendungen hinzufügen
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
In diesem Lernprogramm erfahren Sie, wie das {{site.data.keys.product_adj }}-SDK zu einer neuen oder vorhandenen React-Native-Anwendung, die über die React-Native-CLI erstellt wurde, hinzugefügt wird. Sie werden auch lernen, wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen. Außerdem erfahren Sie, wie Sie Informationen zu den {{ site.data.keys.product_adj }}-Konfigurationsdateien, die im Projekt geändert werden, finden können. 

Das {{ site.data.keys.product_adj }}-React-Native-SDK wird in Form eines React-Native-NPM-Plug-ins bereitgestellt und ist bei [NPM](https://www.npmjs.com/package/react-native-ibm-mobilefirst) registriert.  

Folgende Plug-ins sind verfügbar: 

* **react-native-ibm-mobilefirst** - zentrales SDK-Plug-in

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }
- [React-Native-SDK-Komponenten](#react-native-sdk-components)
- [{{ site.data.keys.product_adj }}-React-Native-SDK hinzufügen](#adding-the-mobilefirst-react-native-sdk)
- [{{ site.data.keys.product_adj }}-React-Native-SDK aktualisieren](#updating-the-mobilefirst-react-native-sdk)
- [Generierte Artefakte des {{ site.data.keys.product_adj }}-React-Native-SDK](#generated-mobilefirst-reactnative-sdk-artifacts)
- [Nächste Lernprogramme](#tutorials-to-follow-next)


## React-Native-SDK-Komponenten
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
Das Plug-in react-native-ibm-mobilefirst ist das zentrale {{ site.data.keys.product_adj }}-Plug-in für React Native und ein erforderliches Plug-in. Wenn Sie eines der anderen {{ site.data.keys.product_adj }}-Plug-ins installieren, wird das Plug-in react-native-ibm-mobilefirst automatisch mitinstalliert, sofern es noch nicht installiert ist. 

**Voraussetzungen:**

- [React Native CLI](https://www.npmjs.com/package/react-native) und die {{ site.data.keys.mf_cli }} sind auf der Entwicklerworkstation installiert.
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv.
- Sie haben die Lernprogramme [MobileFirst-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst) und [React-Native-Entwicklungsumgebung einrichten](../../../installation-configuration/development/reactnative) durchgearbeitet.

## {{ site.data.keys.product }}-React-Native-SDK hinzufügen
{: #adding-the-mobilefirst-react-native-sdk }
Folgen Sie den nachstehenden Anweisungen, um das React-Native-SDK der {{ site.data.keys.product }} zu einem neuen oder vorhandenen React-Native-Projekt hinzuzufügen und bei {{ site.data.keys.mf_server }} zu registrieren.

Vergewissern Sie sich als Erstes, dass der {{ site.data.keys.mf_server }} aktiv ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.sh` aus.

### SDK hinzufügen
{: #adding-the-sdk }

#### Neue Anwendung
{: #new-application }
1. Erstellen Sie wie folgt ein React-Native-Projekt: `react-native init Projektname`.  
Beispiel: 

   ```bash
   react-native init Hello
   ```
     - *Hello* ist der Ordnername und der Name der Anwendung.

    > Mit der von der Schablone bereitgestellten Datei **index.js** können Sie zusätzliche {{ site.data.keys.product_adj }}-Features verwenden, z. B. die [Anwendungsübersetzung in mehrere Sprachen](../../translation) und Initialisierungsoptionen. (Weitere Informationen finden Sie in der Benutzerdokumentation.)

2. Navigieren Sie mit `cd hello` zum Stammverzeichnis des React-Native-Projekts.

3. Fügen Sie die MobileFirst-Plug-ins mit dem folgenden NPM-CLI-Befehl hinzu: `npm install React-Native-Plug-in-Name`.
Beispiel:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > Mit dem obigen Befehl wird das zentrale MobileFirst-SDK-Plug-in zum React-Native-Projekt hinzugefügt.


4. Verbinden Sie die Plug-in-Bibliotheken mit dem folgenden Befehl:

   ```bash
   react-native link
   ```

#### Vorhandene Anwendung
{: #existing-application }

1. Navigieren Sie zum Stammverzeichnis Ihres vorhandenen React-Native-Projekts und fügen Sie das zentrale {{ site.data.keys.product_adj }}-React-Native-Plug-in hinzu:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. Verbinden Sie die Plug-in-Bibliotheken mit dem folgenden Befehl:

   ```bash
   react-native link
   ```

### Anwendung registrieren
{: #registering-the-application }

1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis der Projektplattform (iOS oder Android).  

2. Registrieren Sie die Anwendung bei {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```

  * **iOS**:

    Wenn Ihre Plattform iOS ist, werden Sie aufgefordert, die Bundle-ID (BundleID) der Anwendung anzugeben. **Wichtiger Hinweis**: Bei der Bundle-ID muss die **Groß-/Kleinschreibung beachtet** werden.

    Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung zu {{ site.data.keys.mf_server }} her, um die Anwendung zu generieren. Anschließend wird die Datei **mfpclient.plist** im Stammverzeichnis des Xcode-Projekts generiert, zu der Metadaten, die den {{ site.data.keys.mf_server }} angeben, hinzugefügt werden.

  *  **Android**:

      Wenn Ihre Plattform Android ist, werden Sie aufgefordert, den Paketnamen der Anwendung anzugeben. **Wichtiger Hinweis**: Beim Paketnamen muss die **Groß-/Kleinschreibung beachtet** werden.

       Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung zu {{ site.data.keys.mf_server }} her, um die Anwendung zu registrieren. Anschließend wird die Datei **mfpclient.properties** im Ordner **[Projektstammverzeichnis]/app/src/main/assets/** des Android-Studio-Projekts generiert. Zu der Datei werden Metadaten hinzugefügt, die den {{ site.data.keys.mf_server }} angeben.


Wenn ein ferner Server verwendet wird, fügen Sie ihn mit dem [Befehl ](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) `mfpdev server add` hinzu.

Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung zu {{ site.data.keys.mf_server }} her, um die Anwendung zu registrieren. Jede Plattform wird in {{ site.data.keys.mf_server }} als Anwendung registriert.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können
Anwendungen auch über die {{ site.data.keys.mf_console }} registrieren:    
>
> 1. Laden Sie die {{ site.data.keys.mf_console }}.  
> 2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen.   


## {{ site.data.keys.product_adj }}-React-Native-SDK aktualisieren
{: #updating-the-mobilefirst-react-native-sdk }
Wenn Sie das {{ site.data.keys.product_adj }}-React-Native-SDK auf den neuesten Releasestand bringen möchten, entfernen Sie das Plug-in **react-native-ibm-mobilefirst**. Führen Sie dazu den Befehl `npm uninstall react-native-ibm-mobilefirst` aus. Führen Sie dann den Befehl `npm install react-native-ibm-mobilefirst` aus, um das Plug-in wieder hinzuzufügen.

SDK-Releases sind im [NPM-Repository](https://www.npmjs.com/package/react-native-ibm-mobilefirst) für das jeweilige SDK enthalten.

## Generierte Artefakte des {{ site.data.keys.product_adj }}-React-Native-SDK
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Android-Umgebung

#### mfpclient.properties
{: #mfpclient.properties }
Diese Datei befindet sich im Ordner **./app/src/main/assets/** des Android-Studio-Projekts. Sie
enthält die clientseitigen Eigenschaften für die Registrierung Ihrer
Android-App bei {{ site.data.keys.mf_server }}. 

| Eigenschaft |Beschreibung |Beispielwerte |
|---------------------|---------------------------------------------------------------------|----------------|
|wlServerProtocol |Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }} |http oder https |
|wlServerHost |Hostname von {{ site.data.keys.mf_server }} |192.168.1.63 |
|wlServerPort |Port von {{ site.data.keys.mf_server }} |9080 |
|wlServerContext |Kontextstammverzeichnis der Anwendung auf dem {{ site.data.keys.mf_server }} |/mfp/ |
|languagePreferences |Legt die Standardsprache für Client-SDK-Systemnachrichten fest |en |


### iOS-Umgebung

#### mfpclient.plist
{: #mfpclientplist }
In dieser Datei, die sich im Stammverzeichnis des Projekts befindet, sind die clientseitigen Eigenschaften für die Registrierung Ihrer
iOS-App bei {{ site.data.keys.mf_server }}
definiert.

| Eigenschaft |Beschreibung |Beispielwerte |
|---------------------|---------------------------------------------------------------------|----------------|
|protocol |Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }} |http oder https |
|host |Hostname von {{ site.data.keys.mf_server }} |192.168.1.63 |
|port |Port von {{ site.data.keys.mf_server }} |9080 |
|wlServerContext |Kontextstammverzeichnis der Anwendung auf dem {{ site.data.keys.mf_server }} |/mfp/ |
|languagePreferences |Legt die Standardsprache für Client-SDK-Systemnachrichten fest |en |


## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das {{ site.data.keys.product_adj }}-React-Native-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch.
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch.
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch.
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch.
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an.
