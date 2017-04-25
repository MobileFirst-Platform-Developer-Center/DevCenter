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
* cordova-android: **>= 5.1.1 und < 6.0**
* cordova-windows: **>= 4.3.2 und < 5.0**

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Cordova-SDK-Komponenten](#cordova-sdk-components)
- [{{ site.data.keys.product_adj }}-Cordova-SDK hinzufügen](#adding-the-mobilefirst-cordova-sdk)
- [{{ site.data.keys.product_adj }}-Cordova-SDK aktualisieren](#updating-the-mobilefirst-cordova-sdk)
- [Generierte Artefakte des {{ site.data.keys.product_adj }}-Cordova-SDK](#generated-mobilefirst-cordova-sdk-artifacts)
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

- [Apache Cordova CLI 6.x](https://www.npmjs.com/package/cordova) und die {{ site.data.keys.mf_cli }} sind auf der Entwicklerworkstation installiert. 
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst) und [Cordova-Entwicklungsumgebung einrichten](../../../installation-configuration/development/cordova) durchgearbeitet. 

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
1. Erstellen Sie mit folgendem Befehl ein Cordova-Projekt: `cordova create projectName applicationId --template cordova-template-mfp`.
     
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

4. Erstellen Sie die Anwendungsressourcen mit dem Befehl `cordova prepare command`:

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
    - Wenn ein ferner Server verwendet wird,
fügen Sie ihn mit dem [Befehl `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) hinzu. 

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
{: updating-the-mobilefirst-cordova-sdk }
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

<div class="panel-group accordion" id="config-xml" role="tablist" aria-multiselectable="false">
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

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das {{ site.data.keys.product_adj }}-Cordova-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
