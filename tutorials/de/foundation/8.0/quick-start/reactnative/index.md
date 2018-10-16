---
layout: tutorial
title: End-to-End-Demonstration für React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Bei der folgenden Demonstration geht es darum, einen End-to-End-Ablauf zu veranschaulichen:

1. Eine im Lieferumfang des {{ site.data.keys.product_adj }}-Client-SDK enthaltene Beispielanwendung wird in der {{ site.data.keys.mf_console }} registriert und heruntergeladen.
2. Ein neuer oder bereitgestellter Adapter wird über die {{ site.data.keys.mf_console }} implementiert.  
3. Die Anwendungslogik wird geändert, um eine Ressourcenanforderung zu ermöglichen.

**Endergebnis**:

* Erfolgreiches Absetzen eines Pingsignals an {{ site.data.keys.mf_server }}
* Erfolgreiches Abrufen von Daten mit einem Adapter

### Voraussetzungen: 
{: #prerequisites }
* Xcode für iOS, Android Studio für Android
* React-Native-CLI
* *Optional*: {{ site.data.keys.mf_cli }} ([Download]({{site.baseurl}}/downloads))
* *Optional*: Eigenständiger {{ site.data.keys.mf_server }} ([Download]({{site.baseurl}}/downloads))

### Schritt 1: {{ site.data.keys.mf_server }} starten
{: #1-starting-the-mobilefirst-server }
Sie müssen eine [Mobile-Foundation-Instanz erstellt](../../bluemix/using-mobile-foundation) haben. Falls Sie das [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) verwenden, navigieren Sie zum Ordner des Servers und führen Sie unter Mac und Linux den Befehl `./run.sh` oder unter Windows den Befehl `run.cmd` aus.

### Schritt 2: Anwendung erstellen und registrieren
{: #2-creating-and-registering-an-application }
Öffnen Sie im Browser die {{ site.data.keys.mf_console }}. Laden Sie dazu die URL `http://your-server-host:server-port/mfpconsole`. Wenn der Server lokal ausgeführt wird, verwenden Sie `http://localhost:9080/mfpconsole`. Geben Sie für *Benutzername/Kennwort* die Werte **admin/admin** ein.

1. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**.
    * Wählen Sie eine der Plattformen **Android, iOS** aus.
    * Geben Sie als **Anwendungs-ID** den Wert **com.ibm.mfpstarter.reactnative** ein.
    * Geben Sie für die **Version** den Wert **1.0.0** ein.
    * Klicken Sie auf **Anwendung registrieren**.

    <img class="gifplayer" alt="Anwendung registrieren" src="register-an-application-reactnative.png"/>

2. Laden Sie die React-Native-Beispielanwendung von [GitHub](https://github.ibm.com/MFPSamples/MFPStarterReactNative) herunter.

### Schritt 3: Anwendungslogik bearbeiten
{: #3-editing-application-logic }
1. Öffnen Sie das React-Native-Projekt in einem Editor Ihrer Wahl.

2. Wählen Sie die Datei **app.js** aus dem Stammordner des Projekts aus und fügen Sie das folgende Code-Snippet als Ersatz für die vorhandene Funktion `WLAuthorizationManager.obtainAccessToken()` ein:

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
        resourceRequest.send().then(
          (response) => {
            // Zeigt in einem Alertdialog "Hello world" an
                    alert("Success: " + response.responseText);
          },
          (error) => {
            alert("Failure: " + JSON.stringify(error));
          }
        );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        alert("Failed to connect to MobileFirst Server");
      });
```

### Schritt 4: Adapter implementieren
{: #4-deploy-an-adapter }
Laden Sie das [Adapterartefakt](../javaAdapter.adapter) herunter und implementieren Sie es über die {{ site.data.keys.mf_console }}, indem Sie **Aktionen → Adapter implementieren** auswählen.

Alternativ können Sie neben **Adapter** auf die Schaltfläche **Neu** klicken.  

1. Wählen Sie **Aktionen → Beispiel herunterladen** aus. Laden Sie das **Java**-Adapterbeispiel *Hello World* herunter.

    > Wenn Maven und die {{ site.data.keys.mf_cli }} nicht installiert sind, folgen Sie den auf dem Bildschirm angezeigten Anweisungen unter **Entwicklungsumgebung einrichten**. 

2. Navigieren Sie in einem **Befehlszeilenfenster** zum Stammverzeichnis des Adapter-Maven-Projekts und führen Sie den folgenden Befehl aus:

    ```bash
    mfpdev adapter build
    ```

3. Wenn der Build fertiggestellt ist, implementieren Sie den Adapter über die
{{ site.data.keys.mf_console }}, indem Sie **Aktionen → Adapter implementieren** auswählen. Sie finden den Adapter im Ordner **[adapter]/target**.

    <img class="gifplayer" alt="Adapter implementieren" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="Beispielanwendung" style="float:right"/>

### Schritt 5: Awendung testen
{: #5-testing-the-application }
1.  Vergewissern Sie sich, dass die {{ site.data.keys.mf_cli }} installiert ist. Navigieren Sie dann zum Stammordner der entsprechenden Plattform (iOS oder Android) und führen Sie den Befehl `mfpdev app register` aus. Bei Verwendung eines fernen {{ site.data.keys.mf_server }} müssen Sie den [Befehl zum Hinzufügen eines Servers ausführen](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance).
```bash
mfpdev server add
```
Im Anschluss führen Sie den Befehl für die Registrierung der App aus. Beispiel:
```bash
mfpdev app register myIBMCloudServer
```
2. Führen Sie den folgenden Befel aus, um die Anwendung auszuführen:
```bash
react-native run-ios|run-android
```

Wenn das Gerät verbunden ist, wird die Anwendung auf dem Gerät installiert und dann gestartet. Andernfalls wird der Simulator oder Emulator verwendet.

<br clear="all"/>
### Ergebnisse
{: #results }
* Wenn Sie auf die Schaltfläche **{{ site.data.keys.mf_server }} pingen** klicken, wird **Verbunden mit {{ site.data.keys.mf_server }}** angezeigt.
* Wenn die Anwendung eine Verbindung zu {{ site.data.keys.mf_server }} herstellen konnte, findet ein Ressourcenanforderungsaufruf unter Verwendung des implementierten Java-Adapters statt. Die Antwort des Adapters wird in Form eines Alerts angezeigt.

## Nächste Schritte
{: #next-steps }
Informieren Sie sich über die Verwendung von Adaptern in Anwendungen und über die Integration von zusätzlichen Services wie Push-Benachrichtigungen mithilfe des {{ site.data.keys.product_adj }}-Sicherheitsframeworks. Weitere Möglichkeiten sind:

- Gehen Sie die Lernprogramme zur [Anwendungsentwicklung](../../application-development/) durch.
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../adapters/) durch.
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../authentication-and-security/) durch.
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../notifications/) durch.
- Sehen Sie sich [alle Lernprogramme](../../all-tutorials) an.
