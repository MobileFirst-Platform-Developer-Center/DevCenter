---
layout: tutorial
title: Neuerungen bei vorläufigen Fixes
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Mit vorläufigen Fixes werden Patches und Aktualisierungen bereitgestellt, um Probleme zu lösen und die {{ site.data.keys.product_full }} hinsichtlich neuer Releases von Betriebssystemen für mobile Geräte auf dem neuesten Stand zu halten. Vorläufige Fixes sind kumulativ. Wenn Sie den neusten vorläufigen Fix für Version 8.0 herunterladen, erhalten Sie gleichzeitig die Korrekturen aus allen früheren vorläufigen Fixes. 

Laden Sie den neuesten vorläufigen Fix herunter und installieren Sie ihn. Sie erhalten damit alle in den folgenden Abschnitten beschriebenen Korrekturen. Wenn Sie frühere Fixes installieren, erhalten Sie möglicherweise nicht alle der hier beschriebenen Korrekturen. 

> Eine Liste der iFix-Releases für {{ site.data.keys.product }} 8.0 finden Sie [in diesen Blogbeiträgen]({{site.baseurl}}/blog/tag/iFix_8.0/).

Wenn eine APAR-Nummer aufgeführt ist, können Sie überprüfen, ob das betreffende Feature in einem vorläufigen Fix enthalten ist, indem Sie in der Readme-Datei zum vorläufigen Fix nach dieser APAR-Nummer suchen. 

### Lizenzierung
{: #licensing }
#### PVU-Lizenzierung
{: #pvu-licensing }
{{ site.data.keys.product }} Extension Version 8.0.0 ist als neues Angebot mit PVU-Lizenzierung (Prozessor-Value-Unit) erhältlich. Weitere Informationen zur PVU-Lizenzierung
für {{ site.data.keys.product }} Extension finden Sie unter [{{ site.data.keys.product_adj }}-Lizenzierung](../../licensing).

### Webanwendungen
{: #web-applications }
#### Webanwendungen über die
{{ site.data.keys.mf_cli }} registrieren (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
Alternativ zur Registrierung von Clientanwendungen in der {{ site.data.keys.mf_console }}
können Sie die Anwendungen jetzt über die {{ site.data.keys.mf_cli }} (mfpdev) bei {{ site.data.keys.mf_server }} registrieren. Weitere Informationen finden Sie unter "Webanwendungen über die
{{ site.data.keys.mf_cli }} registrieren". 

### Cordova-Anwendungen
{: #cordova-applications }
#### Native IDE für ein Cordova-Projekt mit dem Studio-Plug-in in Eclipse öffnen
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Wenn Sie das Studio-Plug-in in Ihrer Eclipse-IDE installiert haben, können Sie
von der Eclipse-Schnittstelle aus ein vorhandenes Cordova-Projekt in Android Studio oder Xcode öffnen, einen Projektbuild erstellen und das Projekt ausführen. 

#### Neues Verzeichnis *projectName* als Option bei Verwendung des Unterstützungstools für die Migration
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
Wenn Sie das Unterstützungstool für die Migration verwenden, um Projekte zu migrieren, können Sie einen Namen für das Verzeichnis Ihres Cordova-Projekts angeben. Falls Sie keinen Namen angeben, wird der Standardname *App-Name-App-ID-Version* verwendet.

#### Verbesserung der Benutzerfreundlichkeit des Unterstützungstools für die Migration
{: #usability-improvements-to-the-migration-assistance-tool }
Es wurden folgende Änderungen vorgenommen, um die Benutzerfreundlichkeit des Unterstützungstools für die Migration zu verbessern: 

* Das Unterstützungstool für die Migration scannt HTML-Dateien und JavaScript-Dateien. 
* Im Anschluss an den Scan wird automatisch der Scanbericht in Ihrem Standardbrowser geöffnet. 
* Das Flag *--out* ist optional. Wenn kein Verzeichnis angegeben ist, wird das Arbeitsverzeichnis verwendet. 
* Wenn das Flag *--out* angegeben und das Verzeichnis nicht vorhanden ist, wird das Verzeichnis erstellt. 

### Adapter
{: #adapters }
#### Neue Befehle `mfpdev push` und `mfpdev pull` für die Konfiguration von Java- und JavaScript-Adaptern
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
Sie können die {{ site.data.keys.mf_cli }} verwenden, um die Konfiguration von Java- und JavaScript-Adaptern
per Push-Operation zu {{ site.data.keys.mf_server }} zu übertragen und Adapterkonfigurationen per Pull-Operation von {{ site.data.keys.mf_server }} abzurufen. 
