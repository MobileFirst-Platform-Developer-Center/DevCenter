---
layout: tutorial
title: End-to-End-Demonstration für Windows 8.1 Universal und Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Bei der folgende Demonstration geht es darum, einen End-to-End-Ablauf zu veranschaulichen: 

1. Eine im Lieferumfang des {{ site.data.keys.product_adj }}-Client-SDK enthaltene Beispielanwendung wird
in der {{ site.data.keys.mf_console }} registriert und heruntergeladen. 
2. Ein neuer oder bereitgestellter Adapter wird über die {{ site.data.keys.mf_console }} implementiert.  
3. Die Anwendungslogik wird geändert, um eine Ressourcenanforderung zu ermöglichen. 

**Endergebnis**:

* Erfolgreiches Absetzen eines Pingsignals an {{ site.data.keys.mf_server }}
* Erfolgreiches Abrufen von Daten mit einem Adapter

#### Voraussetzungen: 
{: #prerequisites }
* Konfiguriertes Visual Studio 2013/5
* *Optional*: {{ site.data.keys.mf_cli }} ([Download]({{site.baseurl}}/downloads))
* *Optional*: Eigenständiger {{ site.data.keys.mf_server }} ([Download]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} starten
{: #1-starting-the-mobilefirst-server }
Stellen Sie sicher, dass eine [Mobile-Foundation-Instanz erstellt](../../bluemix/using-mobile-foundation) wurde oder,   
falls Sie das [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) verwenden, navigieren
Sie zum Ordner des Servers und führen Sie den Befehl `./run.cmd` aus.

### 2. Anwendung erstellen
{: #2-creating-an-application }
Öffnen Sie in einem Browser die {{ site.data.keys.mf_console }}. Laden Sie dazu die URL `http://your-server-host:server-port/mfpconsole`. Wenn Sie die Konsole lokal ausführen, verwenden Sie [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Geben Sie für Benutzername/Kennwort die Werte *admin/admin* an.

1. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**. 
    * Wählen Sie eine **Windows**-Plattform aus. 
    * Geben Sie als **Anwendungs-ID** für Windows **MFPStarterCSharp.Windows** oder für Windows Phone **MFPStarterCSharp.WindowsPhone** ein.
    * Geben Sie für die **Version** den Wert **1.0.0** ein. 
    * Klicken Sie auf **Anwendung registrieren**. 

    <img class="gifplayer" alt="Anwendung registrieren" src="register-an-application-windows.png"/>

2. Klicken Sie auf die Kachel **Startercode abrufen** und wählen Sie die Beispielanwendung für Windows 8.1 oder Windows 10 zum Download aus. 

    <img class="gifplayer" alt="Beispielanwendung herunterladen" src="download-starter-code-windows.png"/>

### 3. Anwendungslogik bearbeiten
{: #3-editing-application-logic }
1. Öffnen Sie das Visual-Studio-Projekt. 

2. Wählen Sie die Datei **MainPage.xaml.cs** der Lösung aus und fügen Sie das folgende Code-Snippet in die Methode GetAccessToken() ein: 

   ```csharp
   try
      {
          IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken && accessToken.Value != null && accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. Adapter implementieren
{: 4-deploy-an-adapter }
Laden Sie [dieses vorbereitete Adapterartefakt](../javaAdapter.adapter) herunter und implementieren Sie es über die {{ site.data.keys.mf_console }}, indem Sie **Aktionen → Adapter implementieren** auswählen.

<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="Beispiel-App" style="float:right"/>
### 5. Awendung testen
{: 5-testing-the-application }
1. Wählen Sie in Visual Studio die Datei **mfpclient.resw** aus und bearbeiten Sie die Eigenschaften **protocol**, **host** und **port**. Geben Sie die für diese Eigenschaften die entsprechenden Werte für Ihren {{ site.data.keys.mf_server }} ein.
    * Wenn Sie einen lokalen {{ site.data.keys.mf_server }} verwenden, lauten die Werte normalerweise **http**, **localhost** und **9080**.
    * Wenn Sie einen fernen {{ site.data.keys.mf_server }} (für Bluemix) verwenden, lauten die Werte in der Regel **https**, **your-server-address** und **443**.

    Wenn Sie die {{ site.data.keys.mf_cli }} installiert haben, können Sie alternativ zum Projektstammverzeichnis navigieren und den Befehl `mfpdev app register` ausführen. Bei Verwendung eines fernen {{ site.data.keys.mf_server }} müssen Sie den [Befehl `mfpdev server add` ausführen](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance), um den Server hinzuzufügen, gefolgt beispielsweise von `mfpdev app register myBluemixServer`.

2. Klicken Sie auf die Schaltfläche **App ausführen**.

### Ergebnisse
{: #results }
* Wenn Sie auf die Schaltfläche **Ping {{ site.data.keys.mf_server }}** klicken, wird **Connected to {{ site.data.keys.mf_server }}** angezeigt.
* Wenn die Anwendung eine Verbindung zu {{ site.data.keys.mf_server }} herstellen konnte, findet ein Ressourcenanforderungsaufruf unter Verwendung des implementierten Java-Adapters statt.

Die Antwort des Adapters wird in der Ausgabekonsole von Visual Studio ausgegeben.

![Anwendung, die erfolgreich eine Ressource von {{ site.data.keys.mf_server }} aufgerufen hat](success_response.png)

## Nächste Schritte
{: #next-steps }
Informieren Sie sich über die Verwendung von Adaptern in Anwendungen und über die Integration von zusätzlichen Services wie Push-Benachrichtigungen mithilfe des {{ site.data.keys.product_adj }}-Sicherheitsframeworks. Weitere Möglichkeiten sind:

- Gehen Sie die Lernprogramme zur [Anwendungsentwicklung](../../application-development/) durch.
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../adapters/) durch.
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../authentication-and-security/) durch.
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../notifications/) durch.
- Sehen Sie sich [alle Lernprogramme](../../all-tutorials) an.
