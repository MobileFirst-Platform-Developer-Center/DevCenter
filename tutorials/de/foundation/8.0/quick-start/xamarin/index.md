---
layout: tutorial
title: End-to-End-Demonstration für Xamarin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Bei der folgende Demonstration geht es darum, einen End-to-End-Ablauf zu veranschaulichen: 

1. Ein im Lieferumfang des {{ site.data.keys.product_adj }}-Client-SDK für Xamarin enthaltene Beispielanwendung wird
in der {{ site.data.keys.mf_console }} registriert. 
2. Ein neuer oder bereitgestellter Adapter wird über die {{ site.data.keys.mf_console }} implementiert.  
3. Die Anwendungslogik wird geändert, um eine Ressourcenanforderung zu ermöglichen. 

**Endergebnis**:

* Erfolgreiches Absetzen eines Pingsignals an {{ site.data.keys.mf_server }}

#### Voraussetzungen: 
{: #prerequisites }
* Xamarin Studio
* *Optional*: Eigenständiger {{ site.data.keys.mf_server }} ([Download]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} starten
{: #1-starting-the-mobilefirst-server }
Stellen Sie sicher, dass eine [Mobile-Foundation-Instanz erstellt](../../bluemix/using-mobile-foundation) wurde oder,   
falls Sie das [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/) verwenden, navigieren
Sie zum Ordner des Servers und führen Sie unter Mac und Linux den Befehl `./run.sh` oder unter Windows den Befehl `run.cmd` aus.

### 2. Anwendung erstellen
{: #2-creating-an-application }
Öffnen Sie in einem Browser die {{ site.data.keys.mf_console }}. Laden Sie dazu die URL `http://your-server-host:server-port/mfpconsole`. Wenn Sie die Konsole lokal ausführen, verwenden Sie [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Geben Sie für Benutzername/Kennwort die Werte *admin/admin* an.

1. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**. 
    * Wählen Sie die **Android**-Plattform aus. 
    * Geben Sie für die **Anwendungs-ID** den Wert **com.ibm.mfpstarterxamarin** ein.
(Der Wert hängt vom Anwendungsgerüst ab, das Sie im nächsten Schritt herunterladen weren.) 
    * Geben Sie für die **Version** den Wert **1.0** ein. 
    * Klicken Sie auf **Anwendung registrieren**. 

    <img class="gifplayer" alt="Anwendung registrieren" src="register-an-application-xamarin.gif"/>

### 3. Anwendungslogik bearbeiten
{: #3-editing-application-logic }
* Erstellen Sie ein Xamarin-Projekt. 
* Fügen Sie das Xamarin-SDK hinzu, wie es im Lernprogramm [SDK hinzufügen](../../application-development/sdk/xamarin/) beschrieben ist. 
* Fügen Sie wie unten zu jeder Klassendatei eine Eigenschaft vom Typ `IWorklightClient` hinzu. 

   ```csharp
   /// <summary>
   /// Ruft den Worklight-Beispielclient ab oder legt diesen fest
   /// </summary>
   /// <value>Worklight-Client</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* Wenn Sie für iOS entwickeln, fügen Sie in der Datei **AppDelegate.cs** den folgenden Code zur Methode **FinishedLaunching** hinzu: 

  ```csharp
   {ClassName}.WorklightClient = WorklightClient.CreateInstance();
  ```
* Wenn Sie für Android entwickeln, nehmen Sie
in der Datei **MainActivity.cs** die folgende Codezeile in die Methode **OnCreate** auf: 

  ```csharp
   {ClassName}.WorklightClient = WorklightClient.CreateInstance(this);
  ```
* Definieren Sie eine Methode, um das Zugriffstoken abzurufen und führen Sie wie unten eine Ressourcenanforderung an den MFP Server aus. 
   
    ```csharp
    public async void ObtainToken()
           { 
            try
                   {
       
                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
       
                       if (accessToken.Value != null && accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");
       
                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();
       
                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```
  
* Rufen Sie die Methode **ObtainToken** aus einem Klassenkonstruktor heraus oder in Verbindung mit dem Klicken auf eine Schaltfläche auf. 

### 4. Adapter implementieren
{: #4-deploy-an-adapter }
Laden Sie [dieses vorbereitete Adapterartefakt](../javaAdapter.adapter) herunter und implementieren Sie
es über die {{ site.data.keys.mf_console }}, indem Sie **Aktionen → Adapter implementieren** auswählen. 

Alternativ können Sie neben **Adapter** auf die Schaltfläche **Neu** klicken.   

1. Wählen Sie **Aktionen → Beispiel herunterladen** aus. Laden Sie das **Java**-Adapterbeispiel "Hello World" herunter. 

   > Wenn Maven und die {{ site.data.keys.mf_cli }} nicht installiert sind,
folgen Sie den auf dem Bildschirm angezeigten Anweisungen unter **Entwicklungsumgebung einrichten**.

2. Navigieren Sie in einem **Befehlszeilenfenster** zum Stammverzeichnis des Adapter-Maven-Projekts und führen Sie den
folgenden Befehl aus: 

   ```bash
   mfpdev adapter build
   ```

3. Wenn der Build fertiggestellt ist, implementieren Sie den Adapter über die
{{ site.data.keys.mf_console }}, indem Sie **Aktionen → Adapter implementieren** auswählen. Sie finden den Adapter im Ordner
**[adapter]/target**. 

   <img class="gifplayer" alt="Adapter implementieren" src="create-an-adapter.png"/>

<!-- <img src="device-screen.png" alt="sample app" style="float:right"/>-->
### 5. Awendung testen
{: #5-testing-the-application }
1. Wählen Sie in Xamarin Studio die Datei **mfpclient.plist** aus und bearbeiten Sie die Eigenschaften **protocol**, **host** und **port**. Geben Sie die für diese Eigenschaften die entsprechenden Werte für Ihren {{ site.data.keys.mf_server }} ein.
    * Wenn Sie einen lokalen {{ site.data.keys.mf_server }} verwenden, lauten die Werte normalerweise **http**, **localhost** und **9080**.
    * Wenn Sie einen fernen {{ site.data.keys.mf_server }} (für Bluemix) verwenden, lauten die Werte in der Regel **https**, **your-server-address** und **443**.

2. Klicken Sie auf die Schaltfläche **Play**. 

<br clear="all"/>
### Ergebnisse
{: #results }
* Wenn Sie auf die Schaltfläche **Ping MobileFirst Server** klicken, wird **Connected to MobileFirst Server** angezeigt.
* Wenn die Anwendung eine Verbindung zu {{ site.data.keys.mf_server }} herstellen konnte, findet ein Ressourcenanforderungsaufruf unter Verwendung des implementierten Java-Adapters statt. 

Die Antwort des Adapters wird in der Konsole von Xamarin Studio ausgegeben. 

![Anwendung, die erfolgreich eine Ressource von {{ site.data.keys.mf_server }} aufgerufen hat](console-output.png)

## Nächste Schritte
{: #next-steps }
Informieren Sie sich über die Verwendung von Adaptern in Anwendungen und über die Integration von zusätzlichen Services wie Push-Benachrichtigungen
mithilfe des {{ site.data.keys.product_adj }}-Sicherheitsframeworks. Weitere Möglichkeiten sind: 

- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../authentication-and-security/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../all-tutorials) an. 
