---
layout: tutorial
title: End-to-End-Demonstration für Web-Apps
breadcrumb_title: Web-Apps
relevantTo: [javascript]
weight: 5
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
* Moderner Web-Browser
* *Optional*: {{ site.data.keys.mf_cli }} ([Download]({{site.baseurl}}/downloads))
* *Optional*: Eigenständiger {{ site.data.keys.mf_server }} ([Download]({{site.baseurl}}/downloads))

### 1. {{ site.data.keys.mf_server }} starten
{: #starting-the-mobilefirst-server }
Stellen Sie sicher, dass eine [Mobile-Foundation-Instanz erstellt](../../bluemix/using-mobile-foundation) wurde oder,   
falls Sie das [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) verwenden, navigieren
Sie zum Ordner des Servers und führen Sie unter Mac und Linux den Befehl `./run.sh` oder unter Windows den Befehl `run.cmd` aus.

### 2. Anwendung erstellen und registrieren
{: #creating-and-registering-an-application }
Öffnen Sie in einem Browser die {{ site.data.keys.mf_console }}. Laden Sie dazu die URL `http://your-server-host:server-port/mfpconsole`. Wenn Sie die Konsole lokal ausführen, verwenden Sie [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Geben Sie für Benutzername/Kennwort die Werte *admin/admin* an.
 
1. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**. 
    * Wählen Sie die **Web**-Plattform aus. 
    * Geben Sie als **Anwendungs-ID** den Wert **com.ibm.mfpstarterweb** ein. 
    * Klicken Sie auf **Anwendung registrieren**. 

    <img class="gifplayer" alt="Anwendung registrieren" src="register-an-application-web.png"/>
 
2. Klicken Sie auf die Kachel **Startercode abrufen** und wählen Sie die Webbeispielanwendung zum Download aus. 

    <img class="gifplayer" alt="Beispielanwendung herunterladen" src="download-starter-code-web.png"/>
 
### 3. Anwendungslogik bearbeiten
{: #editing-application-logic }
1. Öffnen Sie das Projekt in einem Editor Ihrer Wahl. 

2. Wählen Sie die Datei **client/js/index.js** aus und fügen Sie das folgende Code-Snippet
als Ersatz für die vorhandene Funktion `WLAuthorizationManager.obtainAccessToken()` ein: 

   ```javascript
   WLAuthorizationManager.obtainAccessToken()
        .then(
            function(accessToken) {
                titleText.innerHTML = "Yay!";
                statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
                
                var resourceRequest = new WLResourceRequest(
                    "/adapters/javaAdapter/resource/greet/",
                    WLResourceRequest.GET
                );
                
                resourceRequest.setQueryParameter("name", "world");
                resourceRequest.send().then(
                    function(response) {
                        // Zeigt in einem Alertdialog "Hello world" an
                    alert("Success: " + response.responseText);
                    },
                    function(response) {
                        alert("Failure: " + JSON.stringify(response));
                    }
                );
            },

            function(error) {
                titleText.innerHTML = "Bummer...";
                statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
            }
        );
   ```
    
### 4. Adapter implementieren
{: #deploy-an-adapter }
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


<img src="web-success.png" alt="Beispielanwendung" style="float:right"/>
### 5. Awendung testen
{: #testing-the-application }
1. Navigieren Sie in einem **Befehlszeilenfenster** zum Ordner **[Projektstammverzeichnis] → node-server**. 
2. Führen Sie den Befehl `npm start` aus, um die erforderliche Node.js-Konfiguration zu installieren und den Node.js-Server zu starten. 
3. Öffnen Sie die Datei **[Projektstammverzeichnis] → node-server → server.js** und bearbeiten Sie die Variablen **host** und **port**. Geben Sie die entsprechenden Werte für Ihren {{ site.data.keys.mf_server }} an.
    * Wenn Sie einen lokalen {{ site.data.keys.mf_server }} verwenden, lauten die Werte normalerweise **http**, **localhost** und **9080**.
    * Wenn Sie einen fernen {{ site.data.keys.mf_server }} (für Bluemix) verwenden, lauten die Werte in der Regel **https**, **your-server-address** und **443**. 

   Beispiel:   
    
   ```javascript
   var host = 'https://mobilefoundation-xxxx.mybluemix.net'; // Adresse von Mobile Foundation Server
   var port = 9081; // zu verwendende lokale Portnummer
   var mfpURL = host + ':443'; // Portnummer von Mobile Foundation Server
   ```
   
4. Rufen Sie in Ihrem Browser die URL [http://localhost:9081/home](http://localhost:9081/home) auf.

<br>
#### Secure-Origins-Richtlinie
{: #secure-origins-policy }
Wenn Sie während der Entwicklung Chrome und sowohl HTTP als auch einen Host verwenden, der **nicht** "localhost" ist,
erlaubt der Browser möglicherweise nicht das Laden einer Anwendung. Der Grund dafür ist die in diesem Browser implementierte und standardmäßig verwendete Secure-Origins-Richtlinie. 

Sie können dies ändern, indem Sie den Chrome-Browser mit folgender Option starten: 

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- Die Option funktioniert, wenn Sie "test-to-new-user-profile/myprofile" durch die Position eines Ordners ersetzen, der als neues Chrome-Benutzerprofil verwendet werden kann. 

<br clear="all"/>
### Ergebnisse
{: #results }
* Wenn Sie auf die Schaltfläche
**Ping {{ site.data.keys.mf_server }}** klicken, wird
**Connected to {{ site.data.keys.mf_server }}** angezeigt.
* Wenn die Anwendung eine Verbindung zu {{ site.data.keys.mf_server }} herstellen konnte, findet ein Ressourcenanforderungsaufruf unter Verwendung des implementierten Java-Adapters statt. 

Die Antwort des Adapters wird in Form eines Alerts angezeigt. 

## Nächste Schritte
{: #next-steps }
Informieren Sie sich über die Verwendung von Adaptern in Anwendungen und über die Integration von zusätzlichen Services wie Push-Benachrichtigungen
mithilfe des {{ site.data.keys.product_adj }}-Sicherheitsframeworks. Weitere Möglichkeiten sind: 

- Gehen Sie die Lernprogramme zur [Anwendungsentwicklung](../../application-development/) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../authentication-and-security/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../all-tutorials) an. 
