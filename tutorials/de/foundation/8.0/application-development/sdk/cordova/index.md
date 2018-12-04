---
layout: tutorial
title: MobileFirst-Foundation-SDK zu Cordova-Anwendungen hinzufügen
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
In diesem Lernprogramm erfahren Sie, wie das {{ site.data.keys.product_adj }}-SDK zu einer neuen oder vorhandenen Cordova-Anwendung, die mit
Apache Cordova, Ionic oder einem anderen Tool eines anderen Anbieters erstellt wurde, hinzugefügt wird. Sie werden auch lernen,
wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen,
Außerdem erfahren Sie, wie Sie Informationen zu den {{ site.data.keys.product_adj }}-Konfigurationsdateien, die im Projekt geändert werden, finden können. 

Das {{ site.data.keys.product_adj }}-Cordova-SDK wird in Form von Cordova-Plug-ins bereitgestellt
[und in NPM registriert](https://www.npmjs.com/package/cordova-plugin-mfp).  
Folgende Plug-ins sind verfügbar: 

* **cordova-plugin-mfp** - zentrales SDK-Plug-in
* **cordova-plugin-mfp-push** - Unterstützung für Push-Benachrichtigungen
* **cordova-plugin-mfp-jsonstore** - Unterstützung für JSONStore
* **cordova-plugin-mfp-fips** - Unterstützung für FIPS (*nur Android*)
* **cordova-plugin-mfp-encrypt-utils** - Unterstützung für Ver- und Entschlüsselung (*nur iOS*)

#### Support-Level
{: #support-levels }
Von den MobileFirst-Plug-ins werden folgende Cordova-Plattformversionen unterstützt: 

* cordova-ios: **>= 4.1.1 und < 5.0**
* cordova-android: **>= 6.1.2 and <= 7.0**
* cordova-windows: **>= 4.3.2 und < 6.0**

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Cordova-SDK-Komponenten](#cordova-sdk-components)
- [{{ site.data.keys.product_adj }}-Cordova-SDK hinzufügen](#adding-the-mobilefirst-cordova-sdk)
- [{{ site.data.keys.product_adj }}-Cordova-SDK aktualisieren](#updating-the-mobilefirst-cordova-sdk)
- [Generierte Artefakte des {{ site.data.keys.product_adj }}-Cordova-SDK](#generated-mobilefirst-cordova-sdk-artifacts)
- [Unterstützung der Cordova-Browserplattform](#cordova-browser-platform)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

> **Hinweis:** Die Funktion **Keychain Sharing** ist obligatorisch, wenn Sie Xcode 8 verwenden und iOS-Apps im iOS-Simulator ausführen. Sie müssen diese Funktion manuell aktivieren, bevor Sie das Xcode-Projekt erstellen.



## Cordova-SDK-Komponenten
{: #cordova-sdk-components }
#### cordova-plugin-mfp
{: #cordova-plugin-mfp }
Das Plug-in cordova-plugin-mfp ist das zentrale {{ site.data.keys.product_adj }}-Plug-in für Cordova und ein erforderliches Plug-in. Wenn Sie eines der anderen
{{ site.data.keys.product_adj }}-Plug-ins installieren, wird das Plug-in cordova-plugin-mfp automatisch mitinstalliert, sofern es noch nicht installiert ist. 

> Die folgenden Cordova-Plug-ins werden als Abhängigkeiten von cordova-plugin-mfp installiert:
>   
>    - cordova-plugin-device
>    - cordova-plugin-dialogs
>    - cordova-plugin-globalization
>    - cordova-plugin-okhttp

#### cordova-plugin-mfp-jsonstore
{: #cordova-plugin-mfp-jsonstore }
Das Plug-in cordova-plugin-mfp-jsonstore ermöglicht Ihrer App die Verwendung von
JSONstore. Weitere Informationen zu JSONStore enthält das Lernprogramm [JSONStore](../../jsonstore/cordova/).  

#### cordova-plugin-mfp-push
{: #cordova-plugin-mfp-push }
Das Plug-in cordova-plugin-mfp-push stellt die Berechtigungen bereit, die für Android-Anwendungen erforderlich sind, um Push-Benachrichtigungen von
{{ site.data.keys.mf_server }} erhalten zu können. Für die Verwendung von Push-Benachrichtigungen ist ein zusätzliches Setup erforderlich. Weitere Informationen zu Push-Benachrichtigungen enthält das Lernprogramm zu
[Push-Benachrichtigungen](../../../notifications/).

#### cordova-plugin-mfp-fips
{: #cordova-plugin-mfp-fips }
Das Plug-in cordova-plugin-mfp-fips stellt
FIPS-140-2-Unterstützung für die Android-Plattform bereit. Weitere Informationen enthält der Artikel
[Unterstützung für FIPS 140-2](../../../administering-apps/federal/#fips-140-2-support).

#### cordova-plugin-mfp-encrypt-utils
{: #cordova-plugin-mfp-encrypt-utils }
Das Plug-in cordova-plugin-mfp-encrypt-utils stellt
iOS-OpenSSL-Frameworks für die Verschlüsselung von Cordova-Anwendungen auf der
iOS-Plattform bereit. Weitere Informationen finden Sie unter [OpenSSL für Cordova iOS aktivieren](additional-information).

**Voraussetzungen:**

- [Apache Cordova CLI (>=6.x und <9.0)](https://www.npmjs.com/package/cordova) und {{ site.data.keys.mf_cli }} sind auf der Entwicklerworkstation installiert.
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst) und [Cordova-Entwicklungsumgebung einrichten](../../../installation-configuration/development/cordova) durchgearbeitet. 
- Für Cordova für Windows muss eine Version von Visual C++ installiert sein, die mit den auf der Maschine installierten Versionen von Visual Studio und .NET kompatibel ist. 
- Im Falle von Windows Phone SDK 8.0 und Visual-Studio-Tools für universelle Windows-Apps müssen Sie sicherstellen, dass erstellte Cordova-Windows-Anwendungen über alle erforderlichen unterstützenden Bibliotheken verfügen. 

## {{ site.data.keys.product }}-Cordova-SDK hinzufügen
{: #adding-the-mobilefirst-cordova-sdk }
Folgen Sie den nachstehenden Anweisungen, um das Cordova-SDK der {{ site.data.keys.product }}
zu einem neuen oder vorhandenen Cordova-Projekt hinzuzufügen und bei {{ site.data.keys.mf_server }} zu registrieren.

Vergewissern Sie sich als Erstes, dass der {{ site.data.keys.mf_server }} aktiv
ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.sh` aus.

> **Hinweis:** Wenn Sie das SDK zu einer vorhandenen Cordova-Anwendung hinzufügen, überschreibt das Plug-in die Datei
`MainActivity.java` für Android und die Datei `Main.m` für iOS.



### SDK hinzufügen
{: #adding-the-sdk }
Sie können das Projekt mit der {{ site.data.keys.product_adj }}-Cordova-**Anwendungsschablone** erstellen. Die Schablone fügt die erforderlichen
{{ site.data.keys.product_adj }}-spezifischen Plug-in-Einträge zur Datei **config.xml** des Cordova-Projekts hinzu
und stellt eine einsatzbereite {{ site.data.keys.product_adj }}-spezifische Datei **index.js** bereit,
die für die {{ site.data.keys.product_adj }}-Anwendungsentwicklung konzipiert ist. 

#### Neue Anwendung
{: #new-application }
1. Erstellen Sie mit folgendem Befehl ein Cordova-Projekt: `cordova create projectName applicationId applicationName --template cordova-template-mfp`.
     
Beispiel: 

   ```bash
   cordova create Hello com.example.helloworld HelloWorld --template cordova-template-mfp
   ```
     - "Hello" ist der Ordnername der Anwendung. 
     - "com.example.helloworld" ist die ID der Anwendung. 
     - "HelloWorld" ist der Name der Anwendung. 
     - --template modifiziert die Anwendung mit {{ site.data.keys.product_adj }}-spezifischen Zusätzen.

    > Mit der von der Schablone bereitgestellten Datei **index.js** können Sie zusätzliche {{ site.data.keys.product_adj }}-Features verwenden, z. B. die [Anwendungsübersetzung in mehrere Sprachen](../../translation) und Initialisierungsoptionen. (Weitere Informationen finden Sie in der Benutzerdokumentation.)

2. Navigieren Sie mit `cd hello` zum Stammverzeichnis des Cordova-Projekts.

3. Fügen Sie mindestens eine unterstützte Plattform zum Cordova-Projekt hinzu. Verwenden Sie dazu den CLI-Befehl `cordova platform add ios|android|windows`. Beispiel: 

   ```bash
   cordova platform add ios
   ```

   > **Hinweis:** Da die Anwendung mit der {{ site.data.keys.product_adj }}-Schablone konfiguriert wurde, wird das zentrale {{ site.data.keys.product_adj }}-Cordova-Plug-in in Schritt 3 automatisch hinzugefügt, wenn die Plattform hinzugefügt wird.



4. Erstellen Sie die Anwendungsressourcen mit dem Befehl `cordova prepare`:

   ```bash
   cordova prepare
   ```

#### Vorhandene Anwendung
{: #existing-application }
1. Navigieren Sie zum Stammverzeichnis Ihres vorhandenen Cordova-Projekts und fügen Sie das zentrale {{ site.data.keys.product_adj }}-Cordova-Plug-in hinzu:

   ```bash
   cordova plugin add cordova-plugin-mfp
   ```

2. Navigieren Sie zum Ordner **www\js** und wählen Sie die Datei **index.js** aus. 

3. Fügen Sie die folgende Funktion hinzu: 

   ```javascript
   function wlCommonInit() {

   }
   ```

Die {{ site.data.keys.product_adj }}-API-Methoden sind nach dem Laden des {{ site.data.keys.product_adj }}-Client-SDK verfügbar Die Funktion
`wlCommonInit` wird nach dem Laden aufgerufen.   
Mit dieser Funktion können Sie die verschiedenen {{ site.data.keys.product_adj }}-API-Methoden aufrufen. 

### Anwendung registrieren
{: #registering-the-application }
1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Cordova-Projekts.   

2. Registrieren Sie die Anwendung bei {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```
    - Wenn ein ferner Server verwendet wird, fügen Sie ihn mit dem [Befehl `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) hinzu.

Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung
zu {{ site.data.keys.mf_server }} her, um die Anwendung zu registrieren. Anschließend wird die Datei
**config.xml** im Stammverzeichnis des Cordova-Projekts mit Metadaten aktualisiert, die den
{{ site.data.keys.mf_server }} angeben. 

Jede Plattform wird in {{ site.data.keys.mf_server }} als Anwendung registriert.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können
Anwendungen auch über die {{ site.data.keys.mf_console }} registrieren:    
>
> 1. Laden Sie die {{ site.data.keys.mf_console }}.  
> 2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen.   

### SDK verwenden
{: #using-the-sdk }
Die {{ site.data.keys.product_adj }}-API-Methoden sind nach dem Laden des {{ site.data.keys.product_adj }}-Client-SDK verfügbar Die Funktion
`wlCommonInit` wird nach dem Laden aufgerufen.   
Mit dieser Funktion können Sie die verschiedenen {{ site.data.keys.product_adj }}-API-Methoden aufrufen. 

## {{ site.data.keys.product_adj }}-Cordova-SDK aktualisieren
{: #updating-the-mobilefirst-cordova-sdk }
Wenn Sie das {{ site.data.keys.product_adj }}-Cordova-SDK auf den neuesten Releasestand bringen möchten, entfernen Sie
das Plug-in **cordova-plugin-mfp**. Führen Sie dazu den Befehl
`cordova plugin remove cordova-plugin-mfp` aus. Führen Sie dann den Befehl
`cordova plugin add cordova-plugin-mfp` aus, um das Plug-in wieder hinzuzufügen. 

SDK-Releases sind im [NPM-Repository](https://www.npmjs.com/package/cordova-plugin-mfp) für das jeweilige SDK enthalten.

## Generierte Artefakte des {{ site.data.keys.product_adj }}-Cordova-SDK
{: #generated-mobilefirst-cordova-sdk-artifacts }
### config.xml
{: #configxml }
Die Cordova-Konfigurationsdatei ist eine obligatorische
XML-Datei, die Anwendungsmetadaten enthält und im Stammverzeichnis der App gespeichert wird.   
Wenn das {{ site.data.keys.product_adj }}-Cordova-SDK zum Projekt hinzugefügt wurde,
empfängt die von Cordova generierte Datei **config.xml** neue Elemente,
die über den Namespace `mfp:` identifiziert werden können. Die hinzugefügten Elemente enthalten Informtionen zu
{{ site.data.keys.product_adj }}-Features und zu {{ site.data.keys.mf_server }}.

### Beispiel für zur Datei **config.xml** hinzugefügte {{ site.data.keys.product_adj }}-Einstellungen
{: #example-of-mobilefirst-settings-added-to-the-configxml-file}
```xml
<?xml version='1.0'encoding='utf-8'?>
<widget id="..." xmlns:mfp="http://www.ibm.com/mobilefirst/cordova-plugin-mfp">
    <mfp:android>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
        <mfp:appChecksum>0</mfp:appChecksum>
        <mfp:security>
            <mfp:testWebResourcesChecksum enabled="false" ignoreFileExtensions="png, jpg, jpeg, gif, mp4, mp3" />
        </mfp:security>
    </mfp:android>
    <mfp:windows>
        <mfp:sdkChecksum>3563350808</mfp:sdkChecksum>
       <mfp:windows10>
          <mfp:sdkChecksum>...</mfp:sdkChecksum>          
          <mfp:security>
             <mfp:testWebResourcesChecksum/>
          </mfp:security>
    </mfp:windows>
    <mfp:platformVersion>8.0.0.00-20151214-1255</mfp:platformVersion>
    <mfp:clientCustomInit enabled="false" />
    <mfp:server runtime="mfp" url="http://10.0.0.1:9080" />
    <mfp:directUpdateAuthenticityPublicKey>the-key</mfp:directUpdateAuthenticityPublicKey>
    <mfp:languagePreferences>en</mfp:languagePreferences>
</widget>
```

<div class="panel-group accordion" id="config-xml" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="config-xml-properties">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Für eine vollständige Liste der Eigenschaften in config.xml hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-config-xml-properties" class="panel-collapse collapse" role="tabpanel" aria-labelledby="config-xml-properties">
            <div class="panel-body">
                <table class="table table-striped">
                    <tr>
                        <td><b>Element</b></td>
                        <td><b>Beschreibung</b></td>
                        <td><b>Konfiguration</b></td>
                    </tr>
                    <tr>
                        <td><b>widget</b></td>
                        <td>Stammelement des Dokuments <a href="http://cordova.apache.org/docs/en/dev/config_ref/index.html">config.xml</a>. Das Element enthält zwei erforderliche Attribute: <ul><li><b>id</b>: Dies ist der Anwendungspaketname, der angegeben wurde, als das Cordova-Projekt erstellt wurde. Wenn dieser Wert nach der Registrierung der Anwendung bei {{ site.data.keys.mf_server }} manuell geändert wird, muss die Anwendung erneut registriert werden.</li><li><b>xmlns:mfp</b>: Dies ist der XML-Namespace des {{ site.data.keys.product_adj }}-Plug-ins.</li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:platformVersion</b></td>
                        <td>Erforderlich. Produktversion, mit der die Anwendung entwickelt wurde</td>
                        <td>Standardmäßig festgelegt; darf nicht geändert werden</td>
                    </tr>
                    <tr>
                        <td><b>mfp:directUpdateAuthenticityPublicKey</b></td>
                        <td>Optional; wenn Sie das Feature für die Authentizität direkter Aktualisierungen aktivieren, wird das Paket für direkte Aktualisierung während der Implementierung digital signiert. Nachdem der Client das Paket heruntergeladen hat, wird eine Sicherheitsüberprüfung ausgeführt, um die Paketauthentizität zu validieren. Dieser Zeichenfolgewert ist der öffentliche Schlüssel, mit dem die ZIP-Datei für die direkte Aktualisierung authentifiziert wird.</td>
                        <td>Wird mit dem Befehl <code>mfpdev app config direct_update_authenticity_public_key Schlüsselwert</code> festgelegt</td>
                    </tr>
                    <tr>
                        <td><b>mfp:languagePreferences</b></td>
                        <td>Optional; enthält eine Liste mit Ländereinstellungen für die Anzeige von Systemnachrichten. Die einzelnen Einträge sind jeweils durch ein Komma getrennt. </td>
                        <td>Wird mit dem Befehl <code>mfpdev app config language_preferences Schlüsselwert</code> festgelegt</td>
                    </tr>
                    <tr>
                        <td><b>mfp:clientCustomInit</b></td>
                        <td>Steuert, wie die Methode <code>WL.Client.init</code> aufgerufen wird. Standardmäßig ist dieses Attribut auf den Wert "false" gesetzt, sodass die Methode <code>WL.Client.init</code> automatisch aufgerufen wird, sobald das {{ site.data.keys.product_adj }}-Plug-in initialisiert ist. Setzen Sie dieses Attribut auf den Wert <b>true</b>, wenn der Clientcode explizit steuern soll, wann <code>WL.Client.init</code> aufgerufen wird.</td>
                        <td>Wird manuell bearbeitet; Sie können das Attribut <b>enabled</b> auf den Wert <b>true</b> oder <b>false</b> setzen.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:server</b></td>
                        <td>Verbindungsinformationen für die Verbindung zum fernen Server, die der Client standardmäßig für die Kommunikation mit {{ site.data.keys.mf_server }} verwendet <ul><li><b>url:</b> Der Wert für url gibt das Protokoll-, Host- und Portwert für {{ site.data.keys.mf_server }} an. Der Client verwendet diese Werte standardmäßig für die Verbindung zum Server.</li><li><b>runtime:</b> Der Wert für runtime gibt die MobileFirst-Server-Laufzeit an, in der die Anwendung registriert wurde. Weitere Informationen zur {{ site.data.keys.product_adj }}-Laufzeit finden Sie in der Übersicht über {{ site.data.keys.mf_server }}.</li></ul></td>
                        <td><ul><li>Der Serverwert für url wird mit dem Befehl <code>mfpdev app config server</code> festgelegt.</li><li>Der Serverwert für runtime wird mit dem Befehl <code>mfpdev app config runtime</code> festgelegt.</li></ul></td>
                    </tr>
                    <tr>
                        <td><b>mfp:ios</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die iOS-Plattform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:android</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die Android-Plattform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die Windows-Plattform.<ul><li><b>mfp:appChecksum</b></li><li><b>mfp:windowsphone8</b></li><li><b>mfp:windows8</b></li><li><b>mfp:windows10</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows8</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die Windows-8.1-Plattform.<ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windows10</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die Windows-10-Plattform.<ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:windowsphone8</b></td>
                        <td>Dieses Element enthält die gesamte, {{ site.data.keys.product_adj }}-bezogene Clientanwendungskonfiguration für die Windows-Phone-8.1-Plattform.<ul><li><b>mfp:sdkChecksum</b></li><li><b>mfp:security</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:appChecksum</b></td>
                        <td>Dieser Wert ist die Kontrollsumme der Anwendungswebressourcen. Er wird bei Ausführung von <code>mfpdev app webupdate</code> berechnet.</td>
                        <td>Kann nicht vom Benutzer konfiguiert werden; der Kontrollsummenwert wird bei Ausführung des Befehls <code>mfpdev app webupdate</code> aktualisiert. Wenn Sie weitere Informationen zum Befehl <code>mfpdev app webupdate</code> benötigen, geben Sie im Befehlsfenster <code>mfpdev help app webupdate</code> ein.</td>
                    </tr>
                    <tr>
                        <td><b>mfp:sdkChecksum</b></td>
                        <td>Dieser Wert ist die Kontrollsumme des IBM MobileFirst-Platform-SDK, über die der eindeutige Level des {{ site.data.keys.product_adj }}-SDK identifiziert wird.</td>
                        <td>Kenn nicht vom Benutzer konfiguriert werden; standardmäßig festgelegter Wert</td>
                    </tr>
                    <tr>
                        <td><b>mfp:security</b></td>
                        <td>Dieses Element enthält die plattformspezifische Konfiguration der Clientanwendung für die {{ site.data.keys.product_adj }}-Sicherheit. Enthält<ul><li><b>mfp:testWebResourcesChecksum</b></li></ul></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><b>mfp:testWebResourcesChecksum</b></td>
                        <td>Steuert, ob die Anwendung die Integrität ihrer Webressourcen bei jedem Start auf dem mobilen Gerät überprüft. Attribute: <ul><li><b>enabled:</b> Gültige Werte sind <b>true</b> und <b>false</b>. Wenn dieses Attribut auf <b>true</b> gesetzt ist, berechnet die Anwendung die Kontrollsumme ihrer Webressourcen und vergleicht diese Kontrollsumme mit einem Wert, der bei der ersten Ausführung der Anwendung gespeichert wurde.</li><li><b>ignoreFileExtensions:</b> Die Kontrollsummenberechnung hängt von der Größe der Webressourcen ab und kann einige Sekunden dauern. Sie können die Berechnung beschleunigen, indem Sie eine Liste mit Dateierweiterungen angeben, die bei der Berechnung ignoriert werden können. Dieser Wert wird ignoriert, wenn das Attribut <b>enabled</b> auf den Wert <b>false</b> gesetzt ist.</li></ul></td>
                        <td><ul><li>Das Attribut <b>enabled</b> wird mit dem Befehl <code>mfpdev app config android_security_test_web_resources_checksum Schlüsselwert</code> festgelegt.</li><li>Das Attribut <b>ignoreFileExtensions</b> wird mit dem Befehl <code>mfpdev app config android_security_ignore_file_extensions Wert</code> festgelegt.</li></ul></td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#config-xml-properties" data-target="#collapse-config-xml-properties" aria-expanded="false" aria-controls="collapse-config-xml-properties"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.product_adj }}-Einstellungen in der Datei config.xml bearbeiten
{: #editing-mobilefirst-settings-in-the-configxml-file }
Sie können die {{ site.data.keys.mf_cli }} verwenden, um mit folgendem Befehl die obigen Einstellungen zu bearbeiten: 

```bash
mfpdev app config
```
## Unterstützung der Cordova-Browserplattform
{: #cordova-browser-platform}

Die MobileFirst Platform bietet jetzt unterstützung für die Cordova-Browserplattform sowie für andere unterstützte Plattformen von Cordova für Windows, Cordova für Android und Cordova für iOS.

Die Verwendung der Cordova-Browserplattform zusammen mit der MobileFirst Platform (MFP) ist mit der gemeinsamen Verwendung der MFP und anderer Plattformen vergleichbar. Es folgt ein Beispiel, das dieses Feature veranschaulicht. 

Erstellen Sie mit folgendem Befehl eine Cordova-Anwendung:
```bash
cordova create <Name_Ihres_App-Ordners> <Paketname>
```
Dieser Befehl erstellt eine Vanilla-Cordova-App.

Fügen Sie mit folgendem Befehl das MFP-Plug-in hinzu:
```bash
   cordova plugin add cordova-plugin-mfp
   ```
Fügen Sie eine Schaltfläche hinzu, über die Sie ein Pingsignal an Ihren MFP Server absetzen können. (Der Server kann ein lokal bereitgestellter Server oder ein Server in IBM Cloud sein.) Klicken Sie auf die Schaltfläche, um das Pingsignal an Ihren MFP Server zu senden.
Sie können den folgenden Beispielcode nutzen:

#### index.html

```html
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
  <meta name="format-detection" content="telephone=no">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">


  <link rel="stylesheet" type="text/css" href="css/index.css" />

  <!-- Script mit definiertem wlCommonInit laden, bevor cordova.js geladen wird -->
  <script type="text/javascript" src="js/index.js"></script>
  <script type="text/javascript" src="cordova.js"></script>

  <title>MFP Starter - Cordova</title>
</head>

<body>

  <div id="main">
    <div id="main_title">Hello MobileFirst</div>
    <div id="main_status"></div>
    <div id="main_info"></div>
  </div>

  <div id="button_content">
    <button id="ping_button" style="display:none">Pingsignal an MobileFirst Server</button>
  </div>

</body>

</html>
```

#### index.js

```javascript

   var Messages = {
        // Hier Ihre Nachrichten für die Standardsprache hinzufügen.
  // Ähnliche Datei mit einem Sprachsuffix erstellen, die die übersetzten Nachrichten enthält.
  // key1 : message1,
};

   var wlInitOptions = {
      // Optionen für eine Initialisierung mit dem WL.Client-Objekt.
  // Initialisierungsoptionen enthält das IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" ist as Standardkontextstammverzeichnis für den MobileFirst-Entwicklungsserver
    applicationId : 'io.cordova.hellocordova' // durch eigene App-ID bzw. eigenen Paketnamen ersetzen
};

function wlCommonInit() {
  app.init();
}

var app = {
  // App initialisieren
  "init": function init() {
    var buttonElement = document.getElementById("ping_button");
    buttonElement.style.display = "block";
    buttonElement.addEventListener('click', app.testServerConnection, false);
  },
  // Serververbindung testen
  "testServerConnection": function testServerConnection() {

    var titleText = document.getElementById("main_title");
    var statusText = document.getElementById("main_status");
    var infoText = document.getElementById("main_info");
    titleText.innerHTML = "Hello MobileFirst";
    statusText.innerHTML = "Connecting to Server...";
    infoText.innerHTML = "";

    WLAuthorizationManager.obtainAccessToken()
      .then(
        function (accessToken) {
          titleText.innerHTML = "Yay!";
          statusText.innerHTML = "Connected to MobileFirst Server";
        },
        function (error) {
          titleText.innerHTML = "Bummer...";
          statusText.innerHTML = "Failed to connect to MobileFirst Server";
        }
        );
    },
 }

```

>**Hinweis:** Es ist wichtig, `mfpContextRoot` und `applicationId` in der Funktion **wlInitOptions** Ihrer Datei index.js anzugeben.

#### index.css

```css
body {
    position: static;
    font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    font-weight: 300;
    margin: 0px;
	padding: 0px;
}

#button_content {
  position: absolute;
  bottom: 10%;
  width: 100%;
}

#ping_button {
  display: block;
  margin: 0 auto;
  height: 50px;
  width: 240px;
  font-size: 20px;
  color: white;
  background-color: #325c80;
}

#main {
  top: 10%;
  position: absolute;
  text-align: center;
  width: 100%
}

#main_title {
  font-size: 40px;
}

#main_status {
  font-size: 20px;
  margin-top: 10px;
}

#main_info {
  font-size: 14px;
  margin-top: 10px;
}

```


Fügen Sie mit folgendem Befehl die Browserplattform hinzu:
```bash
cordova platform add browser
```
<!--
 (Register the app to the MFP server. The **mfpdev-cli** from version -.-.- and above recognizes cordova browser applications as web platform applications. If you are using a lower version then you can either upgrade to the latest version or manually register your application. -->

> Gehen Sie wie folgt vor, um Ihre Anwendung zu registrieren:
>
* Melden Sie sich bei der Konsole Ihres MFP Server an.
* Klicken Sie neben der Option _*Anwendungen*_ auf die Schaltfläche **Neu**.
* Benennen Sie Ihre Anwendung, wählen Sie **Web** als Plattform aus und geben Sie die ID Ihrer Anwendung an (die mit der Funktion **wlInitOptions** in Ihrer Datei `index.js` definiert wurde).
>
>**Vergessen Sie nicht**, die Serverdetails zur Datei `config.xml` Ihrer Anwendung hinzuzufügen. 

<!--If you are using **mfpdev-cli** (more about the `cli` commands can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/t_gs_cli.html)), add the MFP server using the following command:

```bash
mfpdev server add
```
Set it as the default server.

Register your application with the following command:

```bash
mfpdev app register
```
-->


 >**Hinweis**: Für die Registrierung der Browserplattform-App wird bald die *mfpdev-cli* freigegeben.

Führen Sie anschließend die folgenden Befehle aus:

```bash
cordova prepare
cordova build
cordova run
```

<!--This will launch two browsers. One of the browser runs on cordova browser's proxy server (that runs on port `8000`, generally) which cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)). The other browser would be an MFP proxy server (this runs on port `9081`) that will serve MFP requests.

If you click the button to ping MFP on the browser running on port `8000`, the ping will fail whereas clicking the button that runs on localhost port `9081` will be successful. All the cordova browser compatible cordova plugins and MFP features can be used without issues.-->

Damit wird ein Browser gestartet, der auf einem Proxy-Server (am Port `9081`) ausgeführt wird und eine Verbindung zu MFP Server herstellt. Der Standard-Proxy-Server des Cordova-Browsers (der am Port `8000` ausgeführt wird) ist unterdrückt, weil er aufgrund der [Same-Origin-Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) keine Verbindung zu MFP Server herstellen kann.

> Als Standardbrowser für die Ausführung ist **Chrome** festgelegt. Verwenden Sie die Option `--target`, wenn Sie andere Browser verwenden möchten. Sehen Sie sich dazu den folgenden Befehl an:
```bash
 cordova run --target=Firefox
 ```

Eine Vorschau der App kann mit folgendem Befehl angezeigt werden:

```bash
    mfpdev app preview
    ```

Die einzige unterstützte Browseroption ist *Simple Browser Rendering*. Die Option *Mobile Browser Support* wird nicht für die Browserplattform unterstützt. 

### Cordova-Browserressourcen mit WebSphere Liberty bereitstellen
{: #using-liberty-cordova-browser}

Folgen Sie den Anweisungen für die Verwendung von WebSphere Liberty in <a href="http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/">diesem</a> Lernprogramm und nehmen Sie die nachstehenden Änderungen vor.

Fügen Sie den Inhalt des Ordners `www` Ihres Browserprojekts zu `[MyWebApp] → src → Main → webapp` hinzu, wie es in Schritt 1 des Lernprogrammabschnitts **Maven-Webanwendung mit den Webanwendungsressourcen erstellen** beschrieben ist. Registrieren Sie abschließend Ihre App bei Ihrem Liberty-Server und testen Sie sie, indem Sie sie mit `localhost:9080/MyWebApp` im Browser ausführen. Fügen Sie außerdem die Ordner `sjcl` und `jssha` zum übergeordneten Ordner hinzu und ändern Sie die Verweise auf die Ordner entsprechend in der Datei `ibmmfpf.js`. 

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das {{ site.data.keys.product_adj }}-Cordova-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
