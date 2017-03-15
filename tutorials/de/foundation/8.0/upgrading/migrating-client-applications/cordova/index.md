---
layout: tutorial
title: Vorhandene Cordova- und Hybridanwendungen umstellen
breadcrumb_title: Cordova- und Hybridanwendungen
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie eine mit der
IBM MobileFirst Foundation ab Version 6.2.0
erstellte Cordova- oder Hybridanwendung migrieren möchten, müssen Sie ein Cordova-Projekt erstellen, das die Plug-ins der aktuellen Version verwendet. Ersetzen Sie
dann die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. Das Unterstützungstool für die Migration
kann Ihnen bei dieser Aufgabe helfen. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Vergleich von Cordova-Apps, die mit Version 8.0 und mit älteren Versionen bis Version 7.1 entwickelt wurden](#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)
* [Vorhandene Hybrid-Apps oder plattformübergreifende Apps auf von
{{ site.data.keys.product_full }} 8.0 unterstützte Cordova-Apps umstellen](#migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80)
* [Verschlüsselung für Cordova umstellen](#migrating-encryption-for-ios-cordova)
* [Direkte Aktualisierung umstellen](#migrating-direct-update)
* [WebView-Upgrade](#upgrading-the-webview)
* [Gelöschte Komponenten](#removed-components)

## Vergleich von Cordova-Apps, die mit Version 8.0 und mit älteren Versionen bis Version 7.1 entwickelt wurden
{: #comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before }
Nachfolgend werden mit
{{ site.data.keys.product_adj }} Version 8.0 entwickelte Cordova-Apps mit Cordova- und Hybrid-Apps verglichen, die
mit
Version 7.1 entwickelt wurden.

| Feature | Mit IBM {{ site.data.keys.product }}<br/>Version 8.0 entwickelte Cordova-App |	Mit IBM {{ site.data.keys.product }}<br/>Version 7.1 entwickelte Cordova-App | Mit IBM {{ site.data.keys.product }}<br/>Version 7.1 entwickelte Hybrid-App |
|---------|-------|---------|-------|------|
| **IDE Eclipse Studio** | | | | |	 	 	 
| Eclipse-Plug-in und Integration | Ja | Nicht unterstützt | Ja (proprietär) |
| Anwendungskomponenten | Ja (Cordova)<br/><br/>Hinweis: Erstellen Sie Ihre eigenen Cordova-Plug-ins, um die Anwendungskomponenten in Ihrer Organisation zu verwalten.  | Ja (Cordova)<br/><br/>Hinweis: Erstellen Sie Ihre eigenen Cordova-Plug-ins, um die Anwendungskomponenten in Ihrer Organisation zu verwalten.  | Ja (proprietär) |
| Projektschablonen | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie den Apache-Cordova-Befehl `cordova create --template`.  | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie den Befehl `mfp cordova create --template` oder den Apache-Cordova-Befehl
`cordova create --copy-from`.  | Ja (proprietär) |
| Dojo- und jQuery-IDE-Instrumentierung | Ja<br/><br/>Hinweis: Dojo und jQuery Mobile sind JavaScript-Frameworks, die Sie in
Cordova-Apps verwenden können.  | Ja<br/><br/>Hinweis: Dojo und jQuery Mobile sind JavaScript-Frameworks, die Sie in
Cordova-Apps verwenden können.  | Ja |
| Mobile Benutzerschnittstellenmuster | Nicht unterstützt | Nicht unterstützt | Nicht mehr verwendet |
| **Anwendbare untergeordnete Typen** | | |
| Shellkomponente | Nicht unterstützt<br/><br/>Hinweis: Wenn eine Hybrid-App bisher Shells und innere Anwendungen genutzt hat, sollten Sie Cordova-Designmuster verwenden und die
Shellkomponenten als Cordova-Plug-ins implementieren, die anwendungsübergreifend genutzt werden können.  | Nicht unterstützt | Ja |
| Innere Hybridanwendung | Nicht unterstützt<br/><br/>Hinweis: Wenn eine Hybrid-App bisher Shells und innere Anwendungen genutzt hat, sollten Sie Cordova-Designmuster verwenden und die
Shellkomponenten als Cordova-Plug-ins implementieren, die anwendungsübergreifend genutzt werden können.  | Nicht unterstützt | Ja |
| **Anwendungsfeatures** | | | 	 	 	 
| Betriebssystem für mobile Geräte	| iOS 8 oder eine aktuellere Version, Android 4.1 oder eine aktuellere Version, Windows Phone 8.1, Windows Phone 10.  | iOS 7 oder eine aktuellere Version, Android 4 oder eine aktuellere Version  | iOS, Android und Windows Phone 8 |
| Webanwendungen | Ja, als eine mit Apache Cordova entwickelte JavaScript-Anwendung.  | Nicht unterstützt | Ja, als eine Umgebung desktopbrowser oder mobilewebapp |
| Direkte Aktualisierung | Ja | Ja | Ja |
| {{ site.data.keys.product_adj }}-Sicherheitsframework | Ja | Ja | Ja |
| Anwendungsauthentizität | Ja | Ja | Ja |
| Certificate Pinning | Ja | Nein | Ja |
| JSONStore | Ja | Verwenden Sie das Plug-in cordova-plugin-mfp-jsonstore.  | Ja | Ja |
| FIPS 140-2 | Ja. Verwenden Sie das Plug-in cordova-plugin-mfp-fips. <br/><br/>Einschränkung: FIPS wird für Android und iOS unterstützt, aber nicht
für Windows.  | Nein | Ja |
| Verschlüsselung von Webressourcen der Anwendung in der Binärdatei  | Ja |	Nein | Ja |
| Verifizierung der Integrität von Webressourcen durch Bildung einer Kontrollsumme bei jedem App-Start | Ja | Nicht unterstützt | Ja |
| Angabe der App-Zielkategorie (B2E oder B2C) im Rahmen der Lizenzüberwachung für
adressierbare Geräte  | Ja | Nein | Ja |
| Gemeinsame Nutzung einfacher Daten | Nein | Ja | Ja |
| Single Sign-on | Ja<br/><br/>Hinweis: Das Geräte-Single-Sign-on wird jetzt über die neue Konfigurationseigenschaft
enableSSO für die Sicherheitsüberprüfung im Anwendungsdeskriptor unterstützt.  | Ja | Ja |
| {{ site.data.keys.product_adj }}-Anwendungsoberflächen | Nein<br/><br/>Hinweis: Verwenden Sie für die Erkennung und Handhabung unterschiedlich großer Geräteanzeigen Standardverfahren für die
Webentwicklung (z. B. Responsive Web-Design).  | Nein<br/><br/>Hinweis: Verwenden Sie für die Erkennung und Handhabung unterschiedlich großer Geräteanzeigen Standardverfahren für die
Webentwicklung (z. B. Responsive Web-Design).  | Ja |
| Umgebungsoptimierung | Ja (Cordova)  |  Definieren Sie Webressourcen für eine bestimmte Plattform im Verzeichnis "merges".  | Ja (Cordova). Definieren Sie Webressourcen für eine bestimmte Plattform im Verzeichnis "merges". Weitere Informationen finden Sie in der Apache-Cordova-Dokumentation unter Using merges to Customize Each Platform. | Ja (proprietär) |
| Push-Benachrichtigungen | Ja. Verwenden Sie das Plug-in cordova-plugin-mfp-push. <br/><br/>Einschränkung: Sie können vordefinierte MobileFirst-Sicherheitsüberprüfungen nur dem Bereich push.mobileclient zuordnen. Angepasste Sicherheitsüberprüfungen werden nicht unterstützt, weil die JavaScript-Abfrage-Handler nicht aufgerufen werden.  | Ja<br/><br/>Hinweis: Für Android müssen Sie das Plug-in cordova-plugin-mfp-push hinzufügen. Für iOS benötigen Sie dieses Plug-in nicht, weil die clientseitige Push-Unterstützung für iOS im MFP-Kern-Plug-in enthalten ist. | Ja |
| Verwaltung von Cordova-Plug-ins | Ja | Ja | Nein |
| Messages (i18n) | Ja | Ja | Ja |
| Tokenlizenzierung | Ja | Ja | Ja |
| **Anwendungsoptimierung** | | |
| Kompression | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (proprietär) |
| Verkettung von JS und CSS | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (proprietär) |
| Verschleierung | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (Cordova)<br/><br/>Hinweis: Verwenden Sie allgemeine Open-Source-Tools.  | Ja (proprietär) |
| Android Pro Guard | Ja<br/><br/>Hinweis: In {{ site.data.keys.product }} Version 8.0.0 ist die vordefinierte Konfigurationsdatei proguard-project.txt für die Android-ProGuard-Versschleierung bei einer {{ site.data.keys.product_adj }}-Android-Anwendung nicht enthalten.  | Ja<br/><br/>Hinweis: Informationen zur Aktivierung von Pro Guard finden Sie in der Android-Dokumentation.  | Ja |

## Vorhandene Hybrid-Apps oder plattformübergreifende Apps auf von {{ site.data.keys.product }} 8.0 unterstützte Cordova-Apps umstellen
{: #migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80 }
Sie können vorhandene Hybrid-Apps oder plattformübergreifende Apps (Cordova), die mit der
IBM MobileFirst Platform Foundation ab Version
6.2 entwickelt wurden, auf Cordova-Apps
umstellen, die von {{ site.data.keys.product }} Version 8.0 unterstützt werden. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Umstellung einer Cordova-App mit dem Unterstützungstool für die Migration
beginnen](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)
* [Migration einer {{ site.data.keys.product_adj }}-Hybrid-App abschließen](#completing-migration-of-a-mobilefirst-hybrid-app)
* [Migration einer {{ site.data.keys.product_adj }}-Cordova-App abschließen](#completing-migration-of-a-mobilefirst-cordova-app)

### Umstellung einer Cordova-App mit dem Unterstützungstool für die Migration
beginnen
{: #starting-the-cordova-app-migration-with-the-migration-assistance-tool }
Das Unterstützungstool für die Migration hilft Ihnen, Ihre
mit früheren
{{ site.data.keys.product_adj }}-Versionen erstellten plattformübergreifenden Apps vorzubereiten, indem es APIs identifiziert, die nicht mehr gültig sind, und die Projekte in Cordova-Apps kopiert, die von Version
8.0 unterstützt werden. 

Die folgenden Informationen müssen vor Verwendung des Unterstützungstools für die Migration beachtet werden: 

* Sie benötigen eine mit der IBM MobileFirst Platform Foundation
erstellte Hybrid- oder Cordova-Anwendung, die Sie mit dem Befehl `mfp cordova create` erstellt haben. 
* Sie benötigen Internetzugriff. 
* Node.js ab Version 4.0.0 muss installiert sein. 
* Sie müssen die Cordova-Befehlszeilenschnittstelle (CLI, Command-Line Interface) installiert haben. Außerdem müssen alle Produkte installiert sein, die
für die Verwendung der Cordova-CLI für Ihre Zielplattformen vorausgesetzt werden. Weitere Informationen finden Sie auf der Apache-Cordova-Website
unter [The
Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html). 
* Sie müssen die Einschränkungen des Migrationsprozesses kennen und verstehen. Weitere Informationen
finden Sie unter
[Apps früherer Releases umstellen](../).

Plattformübergreifende Apps, die mit Befehlen aus einer früheren Version der
IBM MobileFirst Platform Foundation oder mit Cordova mit
Befehlen der
IBM MobileFirst Platform Foundation erstellt
wurden, müssen geändert werden, damit sie in Version
8.0 unterstützt werden. Das Unterstützungstool für die Migration führt die folgenden Funktionen aus, um den Prozess zu vereinfachen: 

* Es scannt die JavaScript- und HTML-Dateien der mit
der IBM MobileFirst Platform Foundation erstellten Hybrid- oder
Cordova-App
und identifiziert APIs, die in Version 8.0 weggefallen sind oder nicht weiter unterstützt werden bzw. modifiziert wurden. 
* Es kopiert die Struktur und die Script- und Konfigurationsdateien der ursprünglichen, mit der
IBM MobileFirst Platform Foundation erstellten
Hybrid- oder Cordova-App in eine Cordova-Struktur, die in Version 8.0 unterstützt wird.

Das Unterstützungstool für die Migration modifiziert oder verschiebt keinen Entwicklercode und keine Kommentare Ihrer App.
Nach Ausführung dieses Tools müssen Sie den Migrationsprozess fortsetzen
(siehe [Migration einer MobileFirst-Hybrid-App abschließen](#completing-migration-of-a-mobilefirst-hybrid-app)
oder [Migration einer MobileFirst-Cordova-App abschließen](#completing-migration-of-a-mobilefirst-cordova-app)). 

<!--1. Download the migration assistance tool by using one of the following methods:
    * Download the .tgz file from the [Jazzhub repository](https://hub.jazz.net/project/ibmmfpf/mfp-migrator-tool).
    * Download the {{ site.data.keys.mf_dev_kit }}, which contains the migration assistance tool as a file named mfpmigrate-cli.tgz, from the MobileFirst Operations Console.
    * Download the tool by using the instructions that are provided. -->
1. Installieren Sie das Unterstützungstool für die Migration. 
    * Navigieren Sie zu dem Verzeichnis, in das Sie die Datei .tgz heruntergeladen haben. 
    * Installieren Sie das Tool mit npm. Geben Sie dazu den folgenden Befehl ein: 

   ```bash
   npm install -g Name_der_tgz-Datei
   ```
      Für Einzelheiten zum npm-Paket **mfpmigrate-cli** klicken Sie [hier](https://www.npmjs.com/package/mfpmigrate-cli).
2. Scannen und kopieren Sie die mit der IBM MobileFirst Platform Foundation erstellte App. Geben Sie dazu
den folgenden Befehl ein: 

   ```bash
   mfpmigrate client --in Quellenverzeichnis --out Zielverzeichnis --projectName neues_Projektverzeichnis
   ```

   * **Quellenverzeichnis**  
   Aktuelle Position des Prjekts, das Sie migrieren. Für Hybridanwendungen muss diese Option auf
den Ordner **application** der Anwendung zeigen. 
   * **Zielverzeichnis**    
Optionaler Name des Verzeichnisses, in dem die neue, mit Version 8.0 kompatible Cordova-Struktur ausgegeben wird. Dieses Verzeichnis ist ein übergeordnetes Verzeichnis des
Ordners **new-project-directory**. Wenn der Ordner nicht angegeben ist, wird er in dem Verzeichnis erstellt, in dem der Befehl ausgeführt wird. 
   * **neues_Projektverzeichnis**
   Optionaler Name des Ordners mit dem neuen Inhalt Ihres Projekts.
   Dieser Ordner begindet sich innerhalb des Ordners *destination_directory* und enthält alle Informationen für Ihre
Cordova-App. Wenn diese Option nicht angegeben ist, wird der Standardname `App-Name-App-ID-Version` verwendet.
   <br/>
Wenn der Befehl "client" des Unterstützungstools für die Migration ausgeführt wird, führt das Tool die folgenden
Schritte aus:
  
        * Es identifiziert APIs in der vorhandenen, mit der
IBM MobileFirst Platform Foundation erstellten App,
die in Version 8.0 gelöscht oder geändert wurden oder nicht weiter unterstützt werden. 
        * Es erstellt ausgehend von der Struktur der ursprünglichen App eine Cordova-Struktur. 
        * Es kopiert die folgenden Elemente oder fügt sie ggf. hinzu: 
            * Android-Betriebssystem
            * iPhone- und iPad-Betriebssystem
            * Windows-Betriebssystem
            * cordova-mfp-plugin
            * Plugin cordova-plugin-mfp-jsonstore, wenn im alten Projekt das JSONStore-Feature installiert war
            * Plug-in cordova-plugin-mfp-fips, wenn im alten Projekt das FIPS-Feature installiert war
            * Plug-in cordova-plugin-mfp-push, wenn im alten Projekt das Feature für Push-Benachrichtigungen installiert war 
            * Hybridzertifikate, wenn im alten Projekt das Certificate Pinning aktiviert war
            * Anwendungs-, Script- und XML-Dateien
		* Es öffnet die resultierende Informationsdatei in Ihrem Browser, wenn der Befehl ausgeführt ist. 

        > **Wichtiger Hinweis:** Das Unterstützungstool für die Migration kopiert keinen Entwicklercode oder kommentierten Text in die neue Struktur. 
3. Lösen Sie die API-Probleme in der neuen Cordova-App.
    * Lesen Sie die Datei **api-report.html**, die im **Zielverzeichnis** erstellt und nach Ausführung des Befehls in Ihrem Standardbrowser geladen wird. In jeder Zeile der in dieser Datei enthaltenen Tabelle ist eine in der App verwendete API angegeben, die weggefallen ist oder geänderte bzw. gelöscht wurde und nicht mit Version 8.0 kompatibel ist. In dieser Datei ist auch eine Ersetzungsmöglichkeit für gelöschte APIs angegeben, soweit verfügbar.

    | Dateipfad | Zeilennummer | API | Zeileninhalt | Kategorie der API-Änderung | Beschreibung und Aktionselement |
    |-----------|-------------|------|--------------|----------------------------|---------------------------------|
    | c:\local\Cordova\www\js\index.js |	15 | `WL.Client.getAppProperty` | {::nomarkdown}<ul><li><code>document.getElementById('app_version')</code></li><li><code>textContent = WL.Client.getAppProperty("APP_VERSION");</code></li></ul>{:/} | Nicht unterstützt | In Version 8.0 gelöscht. Verwenden Sie zum Abrufen der App-Version ein Cordova-Plug-in. Es gibt keine Ersatz-API. |

    * Lösen Sie die in der Datei **api-report.html** bezeichneten Probleme.
4. Kopieren Sie den Entwicklercode der ursprünglichen App-Struktur manuell an die richtige Position der neuen Cordova-Struktur. Kopieren Sie den Inhalt der folgenden Verzeichnisse entsprechend dem Typ der mit der IBM MobileFirst Platform Foundation erstellten Quellen-App:
    * **Mit der IBM MobileFirst Platform Foundation erstellte Hybrid-App**  
    Kopieren Sie den Inhalt des Verzeichnisses **common** der Quellen-App in das Verzeichnis **www** der neuen Cordova-App.
    * **Mit der IBM MobileFirst Platform Foundation erstellte Cordova-App** Kopieren Sie den Inhalt des Verzeichnisses **www** der Quellen-App in das Verzeichnis **www** der neuen Cordova-App.
5. Führen Sie den Befehl "scan" des Unterstützungstools für die Migration für Ihre neue App aus, um sich zu vergewissern, dass die API-Änderungen abgeschlossen sind.
    * Geben Sie zum Scannen den folgenden Befehl ein: 

      ```bash
      mfpmigrate scan --in Quellenverzeichnis --out Zielverzeichnis --type hybrid
      ```
        * **Quellenverzeichnis**  
Aktuelle Position der zu scannenden Dateien. Bei einer mit der IBM MobileFirst Platform Foundation erstellten Hybrid-App ist diese Position das Verzeichnis
**common** Ihrer App.
Bei einer mit {{ site.data.keys.product }} Version 8.0 erstellten plattformübergreifenden Cordova-App
ist diese Position das Verzeichnis **www**. 
        * **Zielverzeichnis**  
Verzeichnis, in das die Scanergebnisse ausgegeben werden
		* **Scantyp**  
Zu scannender Projekttyp. 
    * Lösen Sie alle verbliebenen Probleme aus der Datei **api-report.html**. 
6. Wiederholen Sie Schritt 6, um die neue Cordova-App mit dem Tool zu scannen, bis alle
Probleme gelöst sind. 

### Migration einer {{ site.data.keys.product_adj }}-Hybrid-App abschließen
{: #completing-migration-of-a-mobilefirst-hybrid-app }
Nachdem Sie das Unterstützungstool für die Migration verwendet haben, müssen Sie einige Abschnitte Ihres Codes manuell modifizieren, um den
Migrationsprozess abzuschließen. 

* Sie müssen bereits das Unterstützungstool für die Migration (mfpmigrate) für Ihre
vorhandene Hybrid-App ausgeführt haben. Weitere Informationen finden Sie unter
[Migration einer Cordova-App
mit dem Unterstützungstool für die Migration starten](#starting-the-cordova-app-migration-with-the-migration-assistance-tool).
* Sie müssen die Cordova-Befehlszeilenschnittstelle (CLI, Command-Line Interface) installiert haben. Außerdem müssen alle Produkte installiert sein, die
für die Verwendung der Cordova-CLI für Ihre Zielplattformen vorausgesetzt werden, falls Sie weitere Cordova-Plug-ins installieren müssen (siehe Schrit 6). Weitere
Informationen finden Sie auf der Apache-Cordova-Website
unter [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html). 
* Sie benötigen Internetzugang, wenn Sie eine neue Version von
jQuery herunterladen müssen (Schritt 1c) oder zusätzliche Cordova-Plug-ins installieren müssen (Schritt 6). 
* Wenn Sie weitere Cordova-Plug-ins installieren müssen (Schritt 6), ist eine Installation von Node.js ab Version 4.0.0 erforderlich. 

Führen Sie die hier beschriebenen Schritte aus, um die Migration
Ihrer MobileFirst-Hybridanwendung von
IBM MobileFirst Platform Foundation Version 7.1
auf eine Cordova-Anwendung mit Unterstützung
für {{ site.data.keys.product }} 8.0 abzuschließen. 

Nach der Migration kann Ihre App Cordova-Plattformen und Plug-ins nutzen, die Sie
unabhängig von der IBM MobileFirst Platform Foundation erworben haben. So können Sie für die App-Entwicklung weiter
Ihre bevorzugten
Cordova-Entwicklungstools nutzen. 

1. Aktualisieren Sie die Datei **www/index.html**. 
    * Fügen Sie zur Kopfzeile Ihrer Datei index.html vor dem bereits vorhandenen CSS-Code
den folgenden CSS-Code hinzu: 

      ```html
      <link rel="stylesheet" href="worklight/worklight.css">
      <link rel="stylesheet" href="css/main.css">
      ```

      > **Note:** Die Datei **worklight.css** setzt das Attribut "body" auf "relative". Wenn sich dies auf den Stil Ihrer App auswirkt, deklarieren Sie einen anderen Wert für die Position in Ihrem eigenen CSS-Code.
Beispiel:

      ```css
      body {
            position: absolute;
      }
      ```

    * Fügen Sie nach den CSS-Definitionen Cordova-JavaScript zur Kopfzeile
der Datei hinzu. 

      ```html
      <script type="text/javascript" src="cordova.js"></script>
      ```    

    * Entfernen Sie die folgende Codezeile, wenn sie vorhanden ist. 

      ```html
      <script>window.$ = window.jQuery = WLJQ;</script>
      ```

      Sie können Ihre eigene
jQuery-Version herunterladen und wie in der folgenden Codezeile angegeben laden.


      ```html
      <script src="lib/jquery.min.js"></script>
      ```

      Sie müssen die optionale jQuery-Ergänzung nicht in den Ordner **lib** verschieben. Sie können diese Ergänzung an eine beliebige Position verschieben, müssen jedoch in der Datei **index.html** einen ordnungsgemäßen Verweis angeben.

2. Aktualisieren Sie die Datei **www/js/InitOptions.js** so, dass
`WL.Client.init` automatisch aufgerufen wird. 
    * Entfernen Sie folgenden Code aus **InitOptions.js**.

      Die Funktion `WL.Client.init` wird über die globale Variable
**wlInitOptions** automatisch aufgerufen.

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

3. Aktualisieren Sie die Datei **www/InitOptions.js** so, dass
`WL.Client.init` manuell aufgerufen wird (optional). 
    * Bearbeiten Sie die Datei **config.xml**. Setzen Sie das Attribut
"enabled" des Elements `<mfp:clientCustomInit>` auf "true". 
    * Wenn Sie die MobileFirst-Standardschablone für Hybridanwendungen
verwenden, ersetzen Sie den folgenden Code: 

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

      Geben Sie folgenden Ersatzcode an: 

      ```javascript
      if (document.addEventListener) {
            document.addEventListener('mfpready', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            document.attachEvent('mfpready',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

4. Wenn Sie Logik verwenden, die für eine Hybridumgebung spezifisch ist,
z. B. in Ihrer Datei **app/iphone/js/main.js**, kopieren Sie die Funktion `wlEnvInit()` und fügen Sie sie am Ende von
**www/main.js** an (optional).

   ```javascript
   // Diese Methode wlEnvInit wird nach erfolgreicher Initialisierung automatisch von der MobileFirst-Laufzeit aufgerufen.
   function wlEnvInit() {
        wlCommonInit();
        if (cordova.platformId === "ios") {
            // Hier kommt der Code für die Umgebungsinitialisierung für iOS.
        } else if (cordova.platformId === "android") {
            // Hier kommt der Code für die Umgebungsinitialisierung für Android.
        }
   }
   ```

5. Wenn Ihre ursprüngliche Anwendung das FIPS-Feature verwendet,
ändern Sie den JQuery-Ereignislistener in einen JavaScript-Ereignislistener, der auf den Empfang des WL/FIPS/READY-Ereignisses wartet (optional). Weitere Informationen zu FIPS finden Sie unter
[Unterstützung für FIPS 140-2](../../../administering-apps/federal/#fips-140-2-support).
6. Wenn Ihre ursprüngliche Anwendung Cordova-Plug-ins anderer Anbieter verwendet, die vom Unterstützungstool für die Migration nicht ersetzt
oder bereitgestellt werden, fügen Sie die Plug-ins manuell mit dem Befehl
`cordova plugin add` zur Cordova-App hinzu (optional). Welche Plug-ins vom Tool ersetzt werden, erfahren Sie unter
[Migration einer Cordova-App mit dem Unterstützungstool für die Migration starten](#starting-the-cordova-app-migration-with-the-migration-assistance-tool). 

### Migration einer {{ site.data.keys.product_adj }}-Cordova-App abschließen
{: #completing-migration-of-a-mobilefirst-cordova-app }
Nachdem Sie das Unterstützungstool für die Migration verwendet haben, müssen Sie einige Abschnitte Ihres Codes manuell modifizieren, um den
Migrationsprozess abzuschließen. 

* Sie müssen bereits das Unterstützungstool für die Migration (**mfpmigrate**) für Ihre
vorhandene Cordova-App ausgeführt haben. Weitere Informationen finden Sie unter
[Migration einer Cordova-App
mit dem Unterstützungstool für die Migration starten](#starting-the-cordova-app-migration-with-the-migration-assistance-tool).
* Sie müssen die Cordova-Befehlszeilenschnittstelle (CLI, Command-Line Interface) installiert haben. Außerdem müssen alle Produkte installiert sein, die
für die Verwendung der Cordova-CLI für Ihre Zielplattformen vorausgesetzt werden. Weitere Informationen finden Sie auf der Apache-Cordova-Website
unter [The
Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html). 
* Sie benötigen Internetzugriff. 
* Node.js ab Version 4.0.0 muss installiert sein. 

Die mit dem Befehl **mfp cordova create** erstellte Cordova-App verwendet die mit der Vorgängerversion der
IBM MobileFirst Platform Foundation
bereitgestellte Version der Cordova-Plattform und Cordova-Plug-ins. Nach der Migration kann Ihre umgestellte App
Cordova-Plattformen und -Plug-ins verwenden, die Sie unabhängig von der
{{ site.data.keys.product }} erworben haben. Dies ist die einzige, in
IBM MobileFirst Foundation Version
8.0 verfügbare Unterstützung für Cordova-Anwendungen.

Für die Umstellung müssen Sie das Unterstützungstool für die Migration
ausführen und anschließend weitere Modifikationen an Ihrer App vornehmen. 

1. Neben den Cordova-Plug-ins, die
die Verwendung von in Ihrer ursprünglichen Anwendung verfügbaren {{ site.data.keys.product_adj }}-Features
ermöglichen, können Sie mit dem Cordova-Entwicklungstool Ihrer Wahl beliebige weitere Cordova-Plug-ins hinzufügen. Sie können beispielsweise über die Cordova-CLI die Plug-ins
**cordova-plugin-file** und **cordova-plugin-file-transfer** hinzufügen. Geben Sie dazu Folgendes ein:



   ```bash
   cordova plugin add cordova-plugin-file cordova-plugin-file-transfer
   ```

   > **Hinweis:** Das Unterstützungstool für die Migration (**mfpmigrate**) fügt die Cordova-Plug-ins für
{{ site.data.keys.product_adj }}-Features hinzu, sodass Sie diese
Features nicht mehr hinzufügen müssen. Weitere Informationen zu diesen Plug-ins finden Sie unter
[Cordova-Plug-ins für {{ site.data.keys.product_adj }}](../../../application-development/sdk/cordova).

2. Wenn Ihre ursprüngliche Anwendung das FIPS-Feature verwendet,
ändern Sie den JQuery-Ereignislistener in einen JavaScript-Ereignislistener, der auf den Empfang des WL/FIPS/READY-Ereignisses wartet (optional). Weitere Informationen zu FIPS finden Sie unter
[Unterstützung für FIPS 140-2](../../../administering-apps/federal/#fips-140-2-support).
3. Wenn Ihre ursprüngliche Anwendung Cordova-Plug-ins anderer Anbieter verwendet, die vom Unterstützungstool für die Migration nicht ersetzt
oder bereitgestellt werden, fügen Sie die Plug-ins manuell mit dem Befehl
**cordova plugin add** zur Cordova-App hinzu (optional). Welche Plug-ins vom Tool ersetzt werden, erfahren Sie unter
[Migration einer Cordova-App mit dem Unterstützungstool für die Migration starten](#starting-the-cordova-app-migration-with-the-migration-assistance-tool). 
4. Nur für Apps mit iOS-Plattform, die OpenSSL verwenden (optional): Fügen Sie das Plug-in **cordova-plugin-mfp-encrypt-utils** zu Ihrer App hinzu. Das Plug-in **cordova-plugin-mfp-encrypt-utils** stellt
iOS-OpenSSL-Frameworks für die Verschlüsselung von Cordova-Anwendungen auf der
iOS-Plattform bereit. 

Jetzt haben Sie eine Cordova-App mit
{{ site.data.keys.product_adj }}-Funktionalität, die Sie mit Ihren bevorzugten Cordova-Tools
weiterentwickeln können. 

## Verschlüsselung für Cordova umstellen
{: #migrating-encryption-for-ios-cordova }
Wenn Ihre iOS-Cordova- oder -Hybrindanwendung die OpenSSL-Verschlüsselung verwendet hat, möchten Sie Ihre App vielleicht auf die neue
native Verschlüsselung von Version 8.0 umstellen. Wenn Sie
OpenSSL weiterhin verwenden möchten, müssen Sie ein zusätzliches Cordova-Plug-in installieren. 

Weitere Informationen zu den iOS-Cordova-Verschlüsselungsoptionen für die Migration finden Sie im Abschnitt
[Migrationoptionen](../../../application-development/sdk/cordova/additional-information/#migration-options)
unter [OpenSSL in Cordova-Anwendungen
ermöglichen](../../../application-development/sdk/cordova/additional-information/#enabling-openssl-in-cordova-applications). 

## Direkte Aktualisierung umstellen
{: #migrating-direct-update }
Die direkte Aktualisierung wird nach dem ersten Zugriff auf eine geschützte Ressource ausgelöst. Der Implementierungsprozess für neue Webressourcen hat sich in
Version 8.0 geändert. 

Wenn eine Clientanwendung in
Version 8.0 auf eine
ungeschützte {{ site.data.keys.product_adj }}-Ressource zugreift,
empfängt sie im Gegensatz zu früheren Versionen keine Aktualisierungen, auch wenn auf dem Server Aktualisierungen verfügbar sind. Eine Ressource könnte ungeschützt sein, weil
OAuth mit der Annotation
`@OAuth(security=false)` oder in der Konfiguration inaktiviert wurde. Sie haben folgende Möglichkeiten, dieses Risiko zu umgehen: 

* Fordern Sie explizit ein Zugriffstoken an (siehe Erläuterungen zur API
`obtainAccessToken`
in der Beschreibung der Klasse [`WLAuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc)). 
* Rufen Sie eine andere geschützte Ressource auf (siehe Beschreibung der Klasse
[`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html?view=kc)). 

Verwendung der direkten Aktualisierung: Ab Version 8.0 wird keine **.wlapp**-Datei mehr auf
den {{ site.data.keys.mf_server }} hochgeladen.
Stattdessen laden Sie ein kleineres Webressourcenarchiv (ZIP-Datei) hoch. Die Archivdatei enthält
nicht mehr die Webvorschaudateien oder Oberflächen, die in den Vorgängerversionen häufig verwendet wurden. Das Archiv enthält jetzt nur noch die Webressourcen, die an die Clients gesendet werden, sowie
Kontrollsummen für die Validierung der direkten Aktualisierung. 

> Weitere Informationen finden Sie in der
[Dokumentation zur direkten Aktualisierung](../../../application-development/direct-update).

## WebView-Upgrade
{: #upgrading-the-webview }
Im Cordova-SDK (JavaScript) von IBM MobileFirst Foundation Version 8.0
gibt es zahlreiche Änderungen, die Anpassungen Ihres Codes erforderlich machen. 

Der manuelle Migrationsprozess verläuft in mehreren Phasen: 

* Neues -Cordova-Projekt
erstellen
* Erforderliche Webressourcenelemente durch Code aus der Vorgängerversion ersetzen
* Durch SDK-Änderungen notwendige Änderungen am JavaScript-Code
vornehmen

In Version 8.0 wurden viele {{ site.data.keys.product_adj }}-API-Elemente entfernt. Gelöschte Elemente sind in einer IDE, di edie automatische Korrektur für
JavaScript unterstützt deutlich als nicht vorhanden gekennzeichnet. 

In der folgenden Tabelle sind API-Elemente aufgelistet, die entfernt werden müssen. Außerdem gibt es Vorschläge, wie die Funktionalität ersetzt werden kann. Viele Elemente, die entfernt wurden,
sind Benutzerschnittstellenelemente, die durch Cordova-Plug-ins oder
HTML-5-Elemente ersetzt werden können. Einige Methoden haben sich ebenfalls geändert. 

#### Weggefallene JavaScript-UI-Elemente
{: #discontinued-javascript-ui-elements }

| API-Element | Migrationspfad |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>WL.BusyIndicator</code></li><li><code>WL.OptionsMenu</code></li><li><code>WL.TabBar</code></li><li><code>WL.TabBarItem</code></li></ul>{:/} | Verwenden Sie Cordova-Plug-ins oder HTML-5-Elemente.  |
| `WL.App.close()` | Handhaben Sie dieses Ereignis außerhalb von {{ site.data.keys.product_adj }}. |
| `WL.App.copyToClipboard()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen.  |
| `WL.App.openUrl(url, target, options)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen.<br/><br/>Hinweis: Dieses Feature wird vom Cordova-Plug-in InAppBrowser bereitgestellt. |
| {::nomarkdown}<ul><li><code>WL.App.overrideBackButton(callback)</code></li><li><code>WL.App.resetBackButton()</code></li></ul> | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. <br/><br/>Hinweis: Dieses Feature wird vom Cordova-Plug-in backbutton bereitgestellt. |
| `WL.App.getDeviceLanguage()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. <br/><br/>Hinweis: Dieses Feature wird vom Cordova-Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.App.getDeviceLocale()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. <br/><br/> Hinweis: Dieses Feature wird vom Cordova-Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.App.BackgroundHandler` | Verwenden Sie zum Ausführen einer angepassten Handlerfunktion den Cordova-Standardereignislistener "pause". Verwenden Sie ein Cordova-Plug-in, mit dem die Privatsphäre gewahrt werden kann und das iOS- und Android-Systeme oder -Benutzer daran hindert, Screenshots zu erstellen. Weitere Informationen entnehmen Sie bitte der Beschreibung zu PrivacyScreenPlugin unter [https://github.com/devgeeks/PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin). |
| {::nomarkdown}<ul><li><code>WL.Client.close()</code></li><li><code>WL.Client.restore()</code></li><li><code>WL.Client.minimize()</code></li></ul>{:/}| Die Funktionen wurden zur Unterstützung der AIR-Plattform bereitgestellt, die von {{ site.data.keys.product }} Version 8.0 nicht unterstützt wird. |
| `WL.Toast.show(string)` | Verwenden Sie Cordova-Plug-ins für Toast. |

#### Weitere weggefallene JavaScript-Elemente
{: #other-discontinued-javascript-elements }

| API | Migrationspfad |
|-----|----------------|
| `WL.Client.checkForDirectUpdate(options)` | Kein Ersatz<br/><br/>Hinweis: Sie können [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) aufrufen, um eine verfügbare direkte Aktualisierung auszulösen. Der Zugriff auf ein Sicherheitstoken löst die direkte Aktualisierung aus, sofern auf dem Server eine direkte Aktualisierung verfügbar ist. Eine bedarfsabhängige Auslösung der direkten Aktualisierung ist nicht möglich. |
| {::nomarkdown}<ul><li><code>WL.Client.setSharedToken({key: myName, value: myValue})</code></li><li><code>WL.Client.getSharedToken({key: myName})</code></li><li><code>WL.Client.clearSharedToken({key: myName})</code></li></ul>{:/} | Kein Ersatz |
| {::nomarkdown}<ul><li><code>WL.Client.isConnected()</code></li><li><code>connectOnStartup init option</code></li></ul> | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken), um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden. |
| {::nomarkdown}<ul><li><code>WL.Client.setUserPref(key,value, options)</code></li><li><code>WL.Client.setUserPrefs(userPrefsHash, options)</code></li><li><code>WL.Client.deleteUserPrefs(key, options)</code></li></ul>{:/} | Kein Ersatz. Sie können einen Adapter und die API [MFP.Server.getAuthenticatedUser](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser) verwenden, um Benutzervorgaben zu verwalten. |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | Kein Ersatz |
| `WL.Client.logActivity(activityType)` | Verwenden Sie [`WL.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Logger.html?view=kc).  |
| `WL.Client.login(realm, options)` | Verwenden Sie [`WLAuthorizationManager.login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#login).  |
| `WL.Client.logout(realm, options)` | Verwenden Sie [`WLAuthorizationManager.logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#logout).  |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken).  |
| {::nomarkdown}<ul><li><code>WL.Client.transmitEvent(event, immediate)</code></li><li><code>WL.Client.purgeEventTransmissionBuffer() </code></li><li><code>WL.Client.setEventTransmissionPolicy(policy)</code></li></ul>{:/} | Erstellen Sie einen angepassten Adapter für den Empfang von Benachrichtigungen über diese Ereignisse. |
| {::nomarkdown}<ul><li><code>WL.Device.getContext()</code></li><li><code>WL.Device.startAcquisition(policy, triggers, onFailure)</code></li><li><code>WL.Device.stopAcquisition()</code></li><li><code>WL.Device.Wifi</code></li><li><code>WL.Device.Geo.Profiles</code></li><li><code>WL.Geo </code></li></ul>{:/} | Verwenden Sie für die Geoortung die native API oder Cordova-Plug-ins von anderen Anbietern. |
| `WL.Client.makeRequest (url, options)` | Erstellen Sie einen angepassten Adapter, der diese Funktionalität bereitstellt.  |
| `WL.Device.getID(options)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. <br/><br/>Hinweis: Dieses Feature wird von **device.uuid** aus dem Plug-in **cordova-plugin-device** bereitgestellt. |
| `WL.Device.getFriendlyName()` | Verwenden Sie `WL.Client.getDeviceDisplayName`.  |
| `WL.Device.setFriendlyName()` | Verwenden Sie `WL.Client.setDeviceDisplayName`.  |
| `WL.Device.getNetworkInfo(callback)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. <br/><br/>Hinweis: Dieses Feature wird vom Plug-in **cordova-plugin-network-information** bereitgestellt.  |
| `WLUtils.wlCheckReachability()` | Erstellen Sie einen angepassten Adapter für die Überprüfung der Serververfügbarkeit.  |
| `WL.EncryptedCache` | Verwenden Sie JSONStore zum lokalen Speichern verschlüsselter Daten. JSONStore ist in **cordova-plugin-mfp-jsonstore** enthalten.  |
| `WL.SecurityUtils.remoteRandomString(bytes)` | Erstellen Sie einen angepassten Adapter, der diese Funktionalität bereitstellt.  |
| `WL.Client.getAppProperty(property)` | Sie können die Eigenschaft für die App-Version mit dem Plug-in **cordova-plugin-appversion** abrufen. Die zurückgegebene Version ist die Version der nativen App (nur Android und iOS). |
| `WL.Client.Push.*` | Verwenden Sie die [clientseitige JavaScript-Push-API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_js_client_push_api.html?view=kc#r_client_push_api) aus dem Plug-in **cordova-plugin-mfp-push**. Weitere Informationen finden Sie unter [Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen](../../migrating-push-notifications). |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | Verwenden Sie [`MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-mfp-push-hybrid/html/MFPPush.html?view=kc#registerDevice), um das Gerät für Push und SMS zu registrieren.  |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken), um ein Token für den erforderlichen Bereich anzufordern.  |
| `WLClient.getLastAccessToken(scope)` | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken).  |
| {::nomarkdown}<ul><li><code>WLClient.getLoginName()</code></li><li><code>WL.Client.getUserName(realm)</code></li></ul>{:/} | Kein Ersatz |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | Verwenden Sie [`WLAuthorizationManager.isAuthorizationRequired`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#isAuthorizationRequired) und [`WLAuthorizationManager.getResourceScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#getResourceScope). |
| `WL.Client.isUserAuthenticated(realm)` | Kein Ersatz |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | Kein Ersatz |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | Kein Ersatz |
| `WL.Client.createChallengeHandler(realmName)` | Verwenden Sie [`WL.Client.createGatewayChallengeHandler(gatewayName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler), um einen Abfrage-Handler für angepasste Gateway-Abfragen zu erstellen. Verwenden Sie [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler), um einen Abfrage-Handler für die Behandlung von Abfragen zu {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen zu erstellen. |
| `WL.Client.createWLChallengeHandler(realmName)` | Verwenden Sie [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler). |
| `challengeHandler.isCustomResponse()` - hier steht `challengeHandler` für ein Abfrage-Handler-Objekt, das von `WL.Client.createChallengeHandler()` zurückgegeben wird | Verwenden Sie `gatewayChallengeHandler.canHandleResponse()`, wobei `gatewayChallengeHandler` für ein Abfrage-Handler-Objekt steht, das von [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) zurückgegeben wird. |
| `wlChallengeHandler.processSucccess()` - hier steht `wlChallengeHandler` für ein Abfrage-Handler-Objekt, das von `WL.Client.createWLChallengeHandler()` zurückgegeben wird | Verwenden Sie `securityCheckChallengeHandler.handleSuccess()`, wobei `securityCheckChallengeHandler` für ein Abfrage-Handler-Objekt steht, das von [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) zurückgegeben wird. |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler ein Abfrage-Handler-Objekt, das von [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) zurückgegeben wird. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen ein Abfrage-Handler-Objekt, das von [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) zurückgegeben wird. |
| `WL.Client.AbstractChallengeHandler.submitFailure(err)` | Verwenden Sie [`WL.Client.AbstractChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.AbstractChallengeHandler.html?view=kc#cancel). |
| `WL.Client.createProvisioningChallengeHandler()` | Kein Ersatz. Die Bereitstellung für Geräte erfolgt jetzt automatisch über das Sicherheitsframework. |

#### Nicht mehr verwendete JavaScript-APIs
{: #deprecated-javascript-apis }

| API | Migrationspfad |
|-----|----------------|
| {::nomarkdown}<ul><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)</code></li><li><code>WL.Client.invokeProcedure(invocationData, options) </code></li><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)</code></li><li><code>WLProcedureInvocationResult</code></li></ul>{:/} | Verwenden Sie stattdessen `WLResourceRequest`. Hinweis: Die invokeProcedure-Implementierung verwendet WLResourceRequest. |
| `WLClient.getEnvironment` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. Hinweis: Dieses Feature wird vom Plug-in device.platform bereitgestellt.  |
| `WL.Client.getLanguage` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. Hinweis: dieses Feature wird vom Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.Client.connect(options)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |

## Gelöschte Komponenten
{: #removed-components }
Ein in MobileFirst Platform Foundation Studion 7.1
erstelltes Cordova-Projekt enthielt viele Ressourcen, die Funktionen unterstützten. In Version 8.0 wird jedoch nur reines
Cordova unterstützt. Die {{ site.data.keys.product_adj }}-API bietet somit keine Unterstützung mehr
für diese Funktionen. 

### Oberflächen
{: #skins }
Mithilfe der Oberflächen von MobileFirst-Anwendungen
konnten Sie die Benutzerschnittstelle für verschiedene Geräte und Formate optimieren.
Version 8.0 bietet keine Unterstützung mehr für solche Oberflächen.   
Um diese Funktionalität ersetzen zu können, sollten Sie sich mit Responsive-Web-Design-Methoden beschäftigen, die es in
Cordova und HTML 5 gibt.

### Shells
{: #shells }
Mit **Shells** konnten eine Reihe von Funktionen entwickelt werden, die von Anwendungen (gemeinsam) genutzt wurden. Auf diesem Wege konnten Entwickler, die über mehr Erfahrungen mit der nativen Umgebung verfügten,
einige Kernfunktionen bereitstellen. Diese Shells waren als **innere Anwendungen** gepackt und wurden von Entwicklern im Bereich Geschäftslogik und Benutzerschnittstellenentwicklung
genutzt. 

Wenn eine Hybrid-App bisher Shells und innere Anwendungen genutzt hat, sollten Sie Cordova-Designmuster verwenden und die
Shellkomponenten als Cordova-Plug-ins implementieren, die anwendungsübergreifend genutzt werden können. Vielleicht finden Entwickler einen Weg, Teile des Shell-Codes
wiederzuverwenden und auf Cordova-Plug-ins umzustellen. 

Wenn ein Kunde beispielsweise über gemeinsame Webressourcen (JavaScript, CSS-Dateien, Grafiken, HTML) für alle seine Apps verfügt, kann er ein Cordova-Plug-in erstellen, das diese
Ressourcen in den Ordner
www der App kopiert. 

Angenommen, diese Ressourcen befinden sich im Ordner src/www/acme/: 

* src/www/acme/js/acme.js
* src/www/acme/css/acme.css
* src/www/acme/img/acme-logo.png
* src/www/acme/html/banner.html
* src/www/acme/html/footer.html
* plugin.xml

Die Datei **plugin.xml** enthält das Tag `<asset>` mit der Quelle und dem Ziel (source und target) für das Kopieren der Ressourcen. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plugin
     xmlns="http://apache.org/cordova/ns/plugins/1.0"     
     xmlns:rim="http://www.blackberry.com/ns/widgets"
     xmlns:android="http://schemas.android.com/apk/res/android"
     id="cordova-plugin-acme"
     version="1.0.1">
<name>ACME Company Shell Component</name>
<description>ACME Company Shell Component</description>
<license>MIT</license>
<keywords>cordova,acme,shell,components</keywords>
<issue>https://www.acme.com/support</issue>
<asset src="src/www/acme" target="www/acme"/>
</plugin>
```

Nachdem **plugin.xml** zur Cordova-Datei **config.xml** hinzugefügt wurde, werden die in "asset src" aufgelisteten Ressourcen während der Kompilierung nach
"asset
target" kopiert.   
In der Datei **index.html** oder innerhalb der App können diese Ressourcen dann wiederverwendet werden. 

```html
<link rel="stylesheet" type="text/css" href="acme/css/acme.css">
<script type="text/javascript" src="acme/js/acme.js"></script>
<div id="banner"></div>
<div id="app"></div>
<div id="footer"></div>
<script type="text/javascript">
    $("#banner").load("acme/html/banner.html");
    $("#footer").load("acme/html/footer.html");
</script>
```

### Seite 'Einstellungen'
{: #settings-page }
Die Seite **Einstellungen** war ein
in der MobileFirst-Hybrid-App verfügbares Benutzerschnittstellenelement, über das
der Entwickler in der Laufzeit zu Testzwecken die Server-URL ändern konnte. Jetzt kann der Entwickler die
vorhandene {{ site.data.keys.product_adj }}-Client-API zum Ändern der Server-URL in der Laufzeit
verwenden. Weitere Informationen finden Sie unter
[WL.App.setServerUrl](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html?cp=SSHS8R_8.0.0#setServerUrl).

### Kompression
{: #minification }
MobileFirst Studio 7.1
stellte eine OOTB-Methode bereit, die vor der Kompilierung alle unnötigen Zeichen aus Ihrem JavaScript-Code entfernt hat, um die Größe des Codes zu verringern. Diese nicht mehr vorhandene Funktionalität
kann durch das Hinzufügen von Cordova-Hooks zu Ihrem Projekt ersetzt werden. 

Es sind viele Hooks für die Kompression Ihrer JavaScript- und
css-Dateien verfügbar. Sie können diese in das Ereignis `before_prepare` in der Datei **config.xml** der App aufnehmen. 

Empfehlungen für Hooks: 

* [https://www.npmjs.com/package/uglify-js](https://www.npmjs.com/package/uglify-js)
* [https://www.npmjs.com/package/clean-css](https://www.npmjs.com/package/clean-css)

Diese Hooks können in einer Plug-in-Datei oder in der Datei
**config.xml** der Anwendung mit dem Element `<hook>` definiert werden.   
Im folgenden Beispiel wird das Hookereignis `before_prepare` verwendet,
um ein Script auszuführen, das den Code komprimiert, bevor
Cordova das Kopieren der Dateien in
den Ordner **www/** der einzelnen Plattformen vorbereitet: 

```html
<hook type="before_prepare" src="scripts/uglify.js" />
```
