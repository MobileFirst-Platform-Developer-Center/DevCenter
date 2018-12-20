---
layout: tutorial
title: MobileFirst-Artefakte über die MobileFirst-CLI verwalten
breadcrumb_title: Using the MobileFirst CLI
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## Übersicht
{: #overview }
{{ site.data.keys.product_full }} stellt eine Befehlszeilenschnittstelle (CLI) für den Entwickler bereit (Befehl **mfpdev**) bereit,
über die Client- und Serverartefakte ohne großen Aufwand verwaltet werden können.   
Mit der CLI können Sie Cordova-basierte Anwendungen verwalten,
die das {{ site.data.keys.product_adj }}-Cordova-Plug-in verwenden, sowie native Anwendungen,
die das native {{ site.data.keys.product_adj }}-SDK verwenden.

Zudem können Sie Adapter in lokalen oder fernen MobileFirst-Server-Instanzen erstellen, registrieren und verwalten und
Projekte über die Befehlszeile, über REST-Services oder über die
{{ site.data.keys.mf_console }} verwalten. 

Die **mfpdev**-Befehle können im interaktiven Modus oder im Direktmodus ausgeführt werden. Im interaktiven Modus geben Sie den Befehl ohne Optionen ein und werden dann aufgefordert, Antworten einzugeben. Im Direktmodus geben Sie den vollständigen Befehl mit Optionen ein. Es gibt keine Eingabeaufforderung. Die Eingabeaufforderungen sind, soweit anwendbar, vom Kontext der Zielplattform für die App abhängig, der an dem Verzeichnis erkennbar ist, in dem Sie den Befehl ausführen. Über die Taste mit dem Aufwärts- oder dem Abwärtspfeil
auf Ihrer Tastatur können Sie durch die Auswahloptionen navigieren. Wenn die gewünschte Auswahl hervorgehoben und mit vorangestelltem Zeichen
">" angezeigt wird, drücken Sie die Eingabetaste. 

In diesem Lernprogramm erfahren Sie, wie die Befehlszeilenschnittstelle (`mfpdev`) installiert
und für die Verwaltung von MobileFirst-Server-Instanzen, Anwendungen und Adaptern verwendet wird. 

> Weitere Informationen zur SDK-Integration in Cordova-Anwendungen und nativen Anwendungen enthalten die Lernprogramme
der Kategorie [SDK der {{ site.data.keys.product }} hinzufügen](../../application-development/sdk/).



#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prerequisites)
* [{{ site.data.keys.mf_cli }} installieren](#installing-the-mobilefirst-cli)
* [Liste der CLI-Befehle](#list-of-cli-commands)
* [Interaktiver Modus und Direktmodus](#interactive-and-direct-modes)
* [MobileFirst-Server-Instanzen verwalten](#managing-mobilefirst-server-instances)
* [Anwendungen verwalten](#managing-applications)
* [Adapter verwalten und testen](#managing-and-testing-adapters)
* [Hilfreiche Befehle](#helpful-commands)
* [Befehlszeilenschnittstelle aktualisieren und deinstallieren](#update-and-uninstall-the-command-line-interface)

## Voraussetzungen
{: #prerequisites }
Die {{ site.data.keys.mf_cli }} ist als NPM-Paket in der [NPM-Registry](https://www.npmjs.com/) verfügbar.  

Stellen Sie sicher, dass in der Entwicklungsumgebung **Node.js** und **NPM** für die Instalation von NPM-Paketen installiert sind.   
Folgen Sie für die Installation von Node.js den Anweisungen auf [nodejs.org](https://nodejs.org). 

Führen Sie den Befehl `node -v` aus, um sich zu vergewissern, dass Node.js ordnungsgemäß installiert wurde.

```bash
node -v
v6.11.1
```

> **Hinweis:** Die unterstützte Mindestversion von **Node.js** ist Version **4.2.3**. Aufgrund der schnellen Entwicklung bei den **Node**- und
**NPM**-Paketen besteht die Möglichkeit, dass die MobileFirst-CLI nicht mit allen verfügbaren Versionen von **Node** und **NPM**, einschließlich der jeweils neuesten Version, vollständig funktioniert.  
> 
> Stellen Sie für eine ordnungsgemäße Funktionsweise der MobileFirst-CLI bis einschließlich iFix-Version 8.0.2018040312 sicher, dass **Node** auf dem Stand von Version **6.11.1** und **NPM** auf dem Stand von Version **3.10.10** ist.
>
> Ab der iFix-Version 8.0.2018100112 der MobileFirst-CLI können Sie Node Version 8.x oder 10.x verwenden.

## {{ site.data.keys.mf_cli }} installieren
{: #installing-the-mobilefirst-cli }
Führen Sie für die Installation der Befehlszeilenschnittstelle den folgenden Befehl aus: 

```bash
npm install -g mfpdev-cli --no-optional
```


Wenn Sie die CLI-ZIP-Datei über das Download-Center der {{ site.data.keys.mf_console }} heruntergeladen haben, verwenden Sie den folgenden Befehl: 

```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- Sie können die CLI ohne die optionalen Abhängigkeiten installieren. Fügen Sie in dem Fall das Attribut
`--no-optional` hinzu (`npm install -g --no-optional Pfad_zu_mfpdev-cli.tgz`). 

Führen Sie zur Überprüfung der Installation den Befehl `mfpdev` ohne Argumente aus. Der Befehl gibt den folgenden Hilfetext aus: 

```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [Optionen]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## Liste der CLI-Befehle
{: #list-of-cli-commands }

|Befehlspräfix |Befehlsaktion |Beschreibung |
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
|`mfpdev app`	                                                |register                                     |Registriert eine App bei {{ site.data.keys.mf_server }} |
|                                                               |config |Ermöglicht Ihnen, den Back-End-Server und die Laufzeit für Ihre App anzugeben. Für Cordova-Apps können Sie außerdem diverse zusätzliche Aspekte konfigurieren, z. B. die Standardsprache für Systemnachrichten oder die Überprüfung der Kontrollsumme. Für Cordova-Apps gibt es weitere Konfigurationsparameter. |
|                                                               |pull |Ruft eine vorhandene App-Konfiguration vom Server ab |
|                                                               |push                                         |Sendet die Konfiguration einer App an den Server |
|                                                               |preview |Ermöglicht eine Voranzeige Ihrer Cordova-App ohne ein tatsächliches Gerät für den Zielplattformtyp. Sie können die Voranzeige im {{ site.data.keys.mf_mbs }} oder in Ihrem Web-Browser sehen. |
|                                                               |webupdate |Packt die Anwendungsressourcen aus dem Verzeichnis www in einer ZIP-Datei zusammen, die für die direkte Aktualisierung verwendet werden kann |
|mfpdev server	                                                |info |Zeigt Informationen zu {{ site.data.keys.mf_server }} an |
|                                                               |add |Fügt eine neue Serverdefinition zu Ihrer Umgebung hinzu |
|                                                               |edit |Ermöglicht die Bearbeitung einer Serverdefinition |
|                                                               |remove |Entfernt eine Serverdefinition aus Ihrer Umgebung |
|                                                               |console                                      |Öffnet die {{ site.data.keys.mf_console }} |
|                                                               |clean |Hebt die Registrierung von Apps bei {{ site.data.keys.mf_server }} auf und entfernt Adapter aus dem Server |
|mfpdev adapter |create                                       |Erstellt einen Adapter |
|                                                               |build                                        |Erstellt einen Adapterbuild |
|                                                               |build all |Findet alle Adapter im aktuellen Verzeichznis, einschließlich der Unterverzeichnisse, und erstellt einen Build für diese Adapter |
|                                                               |deploy                                       |Implementiert einen Adapter in {{ site.data.keys.mf_server }} |
|                                                               |deploy all |Findet alle Adapter im aktuellen Verzeichznis, einschließlich der Unterverzeichnisse, und implementiert sie in {{ site.data.keys.mf_server }} |
|                                                               |call |Ruft eine Adapterprozedur in {{ site.data.keys.mf_server }} auf |
|                                                               |pull |Ruft eine vorhandene Adapterkonfiguration vom Server ab |
|                                                               |push                                         |Sendet die Konfiguration eines Adapters an den Server |
|mfpdev                                                        |config |Legt Ihre Konfigurationsvorgaben für die Voranzeige fest (Browsertyp, Zeitlimit und Serverzeitlimit für die mfpdev-Befehlszeilenschnittstelle) |
|                                                               |info |Zeigt Informationen zu Ihrer Umgebung an, z. B. das Betriebssystem, die Speicherbelegung, die Knotenversion und die Version der Befehlszeilenschnittstelle. Wenn das aktuelle Verzeichnis eine Cordova-Anwendung ist, werden zusätzlich Informationen vom Cordova-Befehl cordova info angezeigt. |
|                                                               |-v |Zeigt die Nummer der derzeit verwendeten Version der {{ site.data.keys.mf_cli }} an |
|                                                               |-d, --debug |Debugmodus: Erzeugt Degubausgaben |
|                                                               |-dd, --ddebug |Ausführlicher Debugmodus: Erzeugt ausführliche Debugausgaben |
|                                                               |-no-color |Unterdrückt die Verwendung von Farben für die Befehlsausgabe |
|mfpdev help
|Befehlsname |Zeigt Hilfe für MobileFirst-CLI-Befehle (mfpdev-Befehle) an. Durch Angabe von Argumenten können konkrete Hilfetexte für einzelne Befehlstypen oder für einen Befehl angezeigt werden ("mfpdev help server add"). |

## Interaktiver Modus und Direktmodus
{: #interactive-and-direct-modes }
Alle Befehle können im **interaktiven Modus** oder im **Direktmodus** ausgeführt werden. Im interaktiven Modus werden Sie zur Eingabe der erforderlichen Parameter aufgefordert und es werden einige Standardwerte verwendet. Im Direktmodus müssen die Parameter zusammen mit dem auszuführenden Befehl angegeben werden. 

Beispiel:

`mfpdev server add` im interaktiven Modus: 

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
Im Direktmodus würde dieser Befehl wie folgt aussehen:



```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

Die korrekte Syntax für einen Befehl im Direktmodus können Sie mit dem Befehl `mfpdev help <Befehl>` ermitteln.


## MobileFirst-Server-Instanzen verwalten
{: #managing-mobilefirst-server-instances }
Mit dem Befehl `mfpdev server <option>` können Sie die verwendeten Instanzen von
{{ site.data.keys.mf_server }} verwalten. Mindestens eine Serverinstanz muss als Standardinstanz aufgelistet sein. Der Standardserver wird immer verwendet, wenn kein anderer Server angegeben ist. 

### Serverinstanzen auflisten
{: #list-server-instances }
Führen Sie den folgenden Befehl aus, um die zur Verfügung stehenden MobileFirst-Server-Instanzen aufzulisten: 

```bash
mfpdev server info
```

Standardmäßig wird automatisch ein lokales Serverprofil erstellt und von der CLI als Standard verwendet. 

### Neue Serverinstanz hinzufügen
{: #add-a-new-server-instance }
Wenn Sie eine weitere lokale oder ferne MobileFirst-Server-Instanz verwenden,
können Sie sie zur Liste der verfügbaren Instanzen hinzufügen. Verwenden Sie dazu den folgenden Befehl: 

```bash
mfpdev server add
```

Folgen Sie den Eingabeaufforderungen, um den Servernamen, die Server-URL und die Berechtigungsnachweise (Benutzer und Kennwort) anzugeben.   
Wenn Sie beispielsweise einen {{ site.data.keys.mf_server }} hinzufügen möchten, der in einem IBM Cloud-Service "Mobile Foundation" ausgeführt wird, verwenden Sie den folgenden Befehl: 

```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully. 
```

- Ersetzen Sie die vollständig qualifizierte URL des Servers ("fully qualified URL of this server") durch Ihre eigene. 

### Serverinstanzen bearbeiten
{: #edit-server-instances }
Wenn Sie die Details einer registrierten Serverinstanz bearbeiten möchten, führen Sie den folgenden Befehl aus. Folgen Sie den interaktiven Eingabeaufforderungen
und wählen Sie den zu bearbeitenden Server aus. Geben Sie dann die zu aktualisierenden Informationen an. 

```bash
mfpdev server edit
```

Verwenden Sie folgenden Befehl, um einen Server als Standardserver festzulegen: 

```bash
mfpdev server edit <Servername> --setdefault
```

### Serverinstanzen entfernen
{: #remove-server-instances }
Wenn Sie eine Serverinstanz aus der Liste registrierter Server entfernen möchten, führen Sie den folgenden Befehl aus: 

```bash
mfpdev server remove
```

Wählen Sie den Server in der interaktiven Liste aus. 

### {{ site.data.keys.mf_console }} öffnen
{: #open-mobilefirst-operations-console }
Wenn Sie die Konsole des registrierten Standardservers öffnen möchten, führen Sie den folgenden Befehl aus: 

```bash
mfpdev server console
```

Wenn Sie die Konsole eines anderen Servers öffnen möchten, geben Sie den Servernamen als Befehlsparameter an: 

```bash
mfpdev server console <Servername>
```

### Apps und Adapter von einem Server entfernen
{: #remove-apps-and-adapters-from-a-server }
Wenn Sie alle bei einem Server registrierten Apps und Adapter entfernen möchten, führen Sie den folgenden Befehl aus: 

```bash
mfpdev server clean
```

Wählen Sie an der interaktiven Eingabeaufforderung den zu bereinigenden Server aus.   
Die Serverinstanz wird in einen bereinigten Zustand (d. h. einen Server ohne implementierte Apps oder Adapter) versetzt. 

## Anwendungen verwalten
{: #managing-applications }
Mit dem Befehl `mfpdev app` können Anwendungen, die mit dem MobileFirst-Platform-SDK erstellt wurden, verwaltet werden. 

### Anwendung in einer Serverinstanz registrieren
{: #register-an-application-in-a-server-instance }
Eine Anwendung muss bei einem {{ site.data.keys.mf_server }} registriert sein, um ausgeführt werden zu können.   
Führen Sie im Stammordner eines App-Projekts den folgenden Befehl aus, um die App zu registrieren: 

```bash
mfpdev app register
```

Dieser Befehl kann im Standardverzeichnis einer Cordova-, Android-, iOS- oder Windows-Anwendung ausgeführt werden.   
Er verwendet für die folgenden Schritte den Standardserver und die Standardlaufzeit: 

* Registrierung einer Anwendung bei einem Server
* Generierung einer Standarddatei mit Clienteigenschaften für die Anwendung
* Aufnahme der Serverinformationen in die Clienteigenschaftendatei

Bei einer Cordova-Anwendung aktualisiert dieser Befehl die Datei config.xml.   
Bei einer iOS-Anwendung aktualisiert dieser Befehl die Datei mfpclient.plist.   
Bei einer Android- oder Windows-Anwendung aktualisiert dieser Befehl die Datei mfpclient.properties. 

Verwenden Sie die folgende Syntax, wenn Sie eine App bei einem anderen als dem Standardserver und einer vom Standard abweichenden Laufzeit registrieren möchten: 

```
mfpdev app register <Server> <Laufzeit>
```

Für Windows-Plattformen muss der Befehl mit dem Argument `-w <Plattform>` angegeben werden. Hier steht `<Plattform>` für eine Liste der zu registrierenden Windows-Plattformen. Die einzelnen Plattformen sind jeweils durch ein Komma getrennt. Gültige
Werte sind `windows`,`windows8` und `windowsphone8`.

```
mfpdev app register -w windows8
```

### Anwendung konfigurieren
{: #configure-an-application }
Wenn eine Anwendung registriert wird, werden serverbezogene Attribute zur Konfigurationsdatei der Anwendung hinzugefügt.   
Sie können die Werte dieser Attribute mit folgendem Befehl ändern: 

```bash
mfpdev app config
```

Dieser Befehl zeigt eine interaktive Liste mit Attributen an, die geändert werden können, und fordert Sie zur Eingabe neuer Werte für die Attribute auf.   
Welche Attribute angezeigt werden, hängt von der jeweiligen Plattform ab (iOS, Android, Windows).

Verfügbare Konfigurationen: 

* Angabe von Serveradresse und Laufzeit für die zu registrierende Anwendung

    > **Beispielanwendungsfall:** Sie möchten eine Anwendung bei einem {{ site.data.keys.mf_server }} mit einer bestimmten Adresse registrieren. Die Anwendung soll aber auch in der Lage sein, eine Verbindung zu einer anderen Serveradresse herzustellen, z. B. zu einem DataPower-Gerät.
    >
    > 1. Führen Sie `mfpdev app register` aus, um die Anwendung bei der erforderlichen MobileFirst-Server-Adresse zu registrieren.
    > 2. Führen Sie `mfpdev app config` aus und passen Sie den Wert der Eigenschaft **server** an die Adresse des DataPower-Geräts an. Sie können den Befehl auch im **Direktmodus** ausführen: `mfpdev app config server http(s)://Server-IP-Adresse_oder_Hostname:Port`.



* Festlegung des öffentlichen Schlüssels für die direkte Aktualisierung
* Festlegung der Standardpsrache für die Anwendung. (Die Standardsprache ist Englisch (en).)
* Festlegung, ob der Kontrollsummentest für Webressourcen aktiviert werden soll 
* Angabe der Dateierweiterungen, die beim Kontrollsummentest für Webressource ignoriert werden sollen

<div class="panel-group accordion" id="app-config" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Weitere Informationen zu den Einstellungen für die Kontrollsumme von Webressourcen</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>Bei den Einstellungen für die Kontrollsumme von Webressourcen gibt es bei Verwendung von <b>mfpdev</b> im Direktmodus für jede mögliche Zielplattform (Android, iOS, Windows 8, Windows Phone 8 und Windows 10 UWP) einen plattformspezifischen Schlüssel. Dieser Schlüssel beginnt mit einer Zeichenfolge, die den Plattformnamen repräsentiert. Die Einstellung <code>windows10_security_test_web_resources_checksum</code>, die auf "true" oder "false" gesetzt sein kann, gibt beispielsweise an, ob der Kontrollsummentest der Webressourcen für Windows10 UWP aktiviert werden soll.</p>

                <table class="table table-striped">
                    <tr>
                        <td><b>Einstellung</b></td>
                        <td><b>Beschreibung</b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>Gibt den öffentlichen Schlüssel für die Authentifizierung der direkten Aktualisierung an. Der Schlüssel muss im Base64-Format vorliegen.</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td>Wenn diese Einstellung auf <code>true</code> gesetzt ist, wird der Test der Webressourcenkontrollsumme für iOS-Cordova-Apps aktiviert. Die Standardeinstellung ist <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td>Wenn diese Einstellung auf <code>true</code> gesetzt ist, wird der Test der Webressourcenkontrollsumme für Android-Cordova-Apps aktiviert. Die Standardeinstellung ist <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td>Wenn diese Einstellung auf <code>true</code> gesetzt ist, wird der Test der Webressourcenkontrollsumme für Windows-10-UWP-Cordova-Apps aktiviert. Die Standardeinstellung ist <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td>Wenn diese Einstellung auf <code>true</code> gesetzt ist, wird der Test der Webressourcenkontrollsumme für Windows-8.1-Cordova-Apps aktiviert. Die Standardeinstellung ist <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td>Wenn diese Einstellung auf <code>true</code> gesetzt ist, wird der Test der Webressourcenkontrollsumme für Windows-Phone-8.1-Cordova-Apps aktiviert. Die Standardeinstellung ist <code>false</code>.</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>Gibt an, welche Dateierweiterungen beim Testen der Kontrollsumme von Webressourcen für iOS-Cordova-Apps ignoriert werden sollen. Geben Sie mehrere Erweiterungen jeweils durch ein Komma getrennt an. Beispiel: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>Gibt an, welche Dateierweiterungen beim Testen der Kontrollsumme von Webressourcen für Android-Cordova-Apps ignoriert werden sollen. Geben Sie mehrere Erweiterungen jeweils durch ein Komma getrennt an. Beispiel: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>Gibt an, welche Dateierweiterungen beim Testen der Kontrollsumme von Webressourcen für Windows-10-UWP-Cordova-Apps ignoriert werden sollen. Geben Sie mehrere Erweiterungen jeweils durch ein Komma getrennt an. Beispiel: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>Gibt an, welche Dateierweiterungen beim Testen der Kontrollsumme von Webressourcen für Windows-8.1-Cordova-Apps ignoriert werden sollen. Geben Sie mehrere Erweiterungen jeweils durch ein Komma getrennt an. Beispiel: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>Gibt an, welche Dateierweiterungen beim Testen der Kontrollsumme von Webressourcen für Windows-8.1-Cordova-Apps ignoriert werden sollen. Geben Sie mehrere Erweiterungen jeweils durch ein Komma getrennt an. Beispiel: jpg,gif,pdf</td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>


### Cordova-Anwendung voranzeigen
{: #preview-a-cordova-application }
Die Webressourcen einer Cordova-Anwendung können in einem Browser vorangezeigt werden. Das Voranzeigen einer Anwendung beschleunigt die Entwicklung, da keine Emulatoren und Simulatoren der nativen Plattform verwendet wreden müssen. 

Vor Ausführung des Befehls "preview" müssen Sie das Projekt vorbereiten. Fügen Sie dazu die Variable `wlInitOptions` hinzu. Führen Sie die folgenden Schritte aus:

1. Fügen Sie die Variable *wlInitOptions* zur Haupt-JavaScript-Datei hinzu. Bei einer Standard-Cordova-App ist das die Datei **index.js**.

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" ist das Standardkontextstammverzeichnis von {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Durch eigenen Wert ersetzen
   };
   ```

2. Registrieren Sie die App mit folgendem Befehl erneut:

   ```bash
   mfpdev app register
   ```

 3. Führen Sie den folgenden Befehl aus:

    ```bash
    cordova prepare
    ```

 4. Zeigen Sie eine Vorschau der Cordova-Anwendung an. Führen Sie dazu im Stammordner der Cordova-Anwendung den folgenden Befehl aus:

    ```bash
    mfpdev app preview
    ```

Sie werden aufgefordert, die Plattform für die Vorschau und die Art der Vorschau auszuwählen. Zur Auswahl stehen die beiden Optionen MBS und Browser.

* MBS - {{ site.data.keys.mf_mbs }}. Bei Auswahl dieser Option wird ein mobiles Gerät in einem Browser simuliert. Gleichzeitig wird eine rudimentäre Cordova-API-Simulation für Karmera, Dateiupload, Geoortung und anderes bereitgestellt. Hinweis: Den Cordova-Browser können Sie nicht mit der Option MBS verwenden. 
* Browser - Einfache Darstellung in einem Browser. Bei Auswahl dieser Option werden die Webressourcen der Cordova-Anwendung als normale Browser-Webseite dargestellt. 

> Weitere Einzelheiten zu den Vorschauoptionen enthält das Lernprogramm zur [Cordova-Entwicklung](../cordova-apps).

### Direkte Aktualisierung von Webressourcen
{: #update-web-resources-for-direct-update }
Die Webressourcen einer Cordova-App wie HTML-, CSS- und JS-Dateien im Ordner **www** können mithilfe des MobileFirst-Foundation-Features
für direkte Aktualisierung aktualisiert werden,
ohne dass die App neu auf dem mobilen Gerät installiert werden muss. 

> Weitere Einzelheiten zur Funktionsweise der direkten Aktualisierung enthält das Lernprogramm [Direkte Aktualisierung in Cordova-Anwendungen](../direct-update).



Wenn Sie neue Webressourcen für die Aktualisierung einer Cordova-Anwendung senden möchten, führen Sie folgenden Befehl aus: 

```bash
mfpdev app webupdate
```

Dieser Befehl packt die aktualisierten Webressourcen zu einer ZIP-Datei und lädt diese Datei auf den registrierten Standard-MobileFirst-Server hoch. Sie finden die gepackten Webressourcen im Ordner **[Stammorder_des_Cordova-Projekts]/mobilefirst/**. 

Wenn Sie die Webressourcen an eine andere Serverinstanz senden möchten, geben Sie mit dem Befehl den Servernamen und die Laufzeit an: 

```bash
mfpdev app webupdate <Servername> <Laufzeit>
```

Mit dem Parameter --build können Sie die ZIP-Datei mit den gepackten Webressourcen generieren, ohne die Datei auf einen Server hochzuladen: 

```bash
mfpdev app webupdate --build
```

Wenn Sie ein erstelltes Paket hochladen möchten, verwenden Sie den Parameter --file: 

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

Sie können den Inhalt des Pakets auch verschlüsseln. Verwenden Sie dazu den Parameter --encrypt:

```bash
mfpdev app webupdate --encrypt
```

### {{ site.data.keys.product_adj }}-Anwendungskonfiguration mit Pull und Push übertragen
{: #pull-and-push-the-mobilefirst-application-configuration }
Wenn eine {{ site.data.keys.product_adj }}-Anwendung bei einem
{{ site.data.keys.mf_server }} registriert ist, kann ein Teil der Anwendungskonfiguration
in der MobileFirst-Server-Konsole geändert werden. Die so geänderte Konfiguration kann dann mittels Pull vom Server
zur Anendung übertragen werden. Verwenden Sie dazu den folgenden Befehl: 

```bash
mfpdev app pull
```

Es ist auch möglich, die Anwendungskonfiguration lokal zu ändern, und die Änderungen per Push mit folgendem Befehl zum
{{ site.data.keys.mf_server }} zu übertragen: 

```bash
mfpdev app push
```

**Beispiel:** In der {{ site.data.keys.mf_console }} können Sie Bereiche Sicherheitsüberprüfungen zuordnen
und diese Änderung dann mihilfe einer Pull-Operation zum Server übertragen. Verwenden Sie dazu den obigen Befehl. Die heruntergeladene ZIP-Datei wird im Projektordner
**[Stammverzeichnis]/mobilefirst** gespeichert und kann später mit dem Befehl
`mfpdev app push` auf einen anderen {{ site.data.keys.mf_server }} hochgeladen werden.
Diese Wiederverwendung bereits erstellter Konfigurationen ermöglicht eine rasche Konfiguration und Einrichtung. 

## Adapter verwalten und testen
{: #managing-and-testing-adapters }
Adapter können mit dem Befehl `mfpdev adapter` verwaltet werden.

> Weitere Informationen zu Adaptern enthalten die Lernpgoramme der Kategorie [Adapter](../../adapters/). 


### Adapter erstellen
{: #create-an-adapter }
Verwenden Sie den folgenden Befehl, um einen neuen Adapter zu erstellen: 

```bash
mfpdev adapter create
```

Folgen Sie den Eingabeaufforderungen uind geben Sie den Namen, den Typ und die Gruppen-ID des Adapters an. 

### Adapterbuild erstellen
{: #build-an-adpater }
Führen Sie im Stammordner des Adapters den folgenden Befehl aus, um einen Adapterbuild zu erstellen: 

```bash
mfpdev adapter build
```

Mit diesem Befehl wird im Ordner **<Adaptername>/target** eine Datei .adapter erstellt. 

### Adapter implementieren
{: #deploy-an-adapter}
Mit dem folgenden Befehl wird der Adapter im Standardserver implementiert: 

```bash
mfpdev adapter deploy
```

Verwenden Sie für die Implementierung auf einem anderen Server den folgenden Befehl: 

```bash
mfpdev adapter deploy <Servername>
```

### Adapter in der Befehlszeile aufrufen
{: #call-an-adapter-from-the-command-line }
Ein implementierter Adapter kann in der Befehlszeile aufgerufen werden, um sein Verhalten zu testen. Verwenden Sie dazu den folgenden Befehl: 

```bash
mfpdev adapter call
```

Sie werden aufgefordert, den Adapter, die Prozedur und die zu verwendenden Parameter anzugeben. Die Befehlsausgabe ist die Antwort der Adapterprozedur. 

> Weitere Informationen enthält das Lernprogramm
[Adapter testen und debuggen](../../adapters/testing-and-debugging-adapters/). 

## Hilfreiche Befehle
{: #helpful-commands }
Verwenden Sie den folgenden Befehl, um für die CLI (mfpdev) Vorgaben wie den Standardbrowser und den Standardvorschaumodus festzulegen: 

```bash
mfpdev config
```

Wenn Sie die Hilfetexte für alle mfpdev-Befehle sehen möchten, verwenden Sie den folgenden Befehl: 

```bash
mfpdev help
```

Mit dem folgenden Befehl wird eine Liste mit Informationen zu Ihrer Umgebung generiert: 

```bash
mfpdev info
```

Mit folgendem Befehl können Sie die Version der CLI (mfpdev) ausgeben: 

```bash
mfpdev -v
```

## Befehlszeilenschnittstelle aktualisieren und deinstallieren
{: #update-and-uninstall-the-command-line-interface }
Führen Sie den folgenden Befehl aus, um die Befehlszeilenschnittstelle zu aktualisieren: 

```bash
npm update -g mfpdev-cli
```

Führen Sie den folgenden Befehl aus, um die Befehlszeilenschnittstelle zu deinstallieren: 

```bash
npm uninstall -g mfpdev-cli
```
