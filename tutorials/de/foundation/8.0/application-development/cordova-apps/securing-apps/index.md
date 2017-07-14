---
layout: tutorial
title: Cordova-Anwendungen schützen
breadcrumb_title: Anwendungen schützen
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Webressourcen Ihrer Cordova-Pakete verschlüsseln
{: #encrypting-the-web-resources-of-your-cordova-packages }
Das Risiko, dass jemand Ihre Webressourcen im Anwendungspaket
(.apk oder .ipa) sieht und modifiziert, können Sie auf ein Minimum reduzieren,
indem Sie den Befehl
`mfpdev app webencrypt` oder das Flag `mfpwebencrypt` der {{ site.data.keys.mf_cli }}
verwenden, um die Daten zu verschlüsseln. Das hier beschriebene Verfahren ermöglicht keine Verschlüsselung, die nicht geknackt werden könnte. Es ermöglicht aber eine Basisverschleierung. 

**Voraussetzungen:**

* Die Cordova-Entwicklungstools müssen installiert sein. In diesem Beispiel wird die Apache-Cordova-Befehlszeilenschnittstelle verwendet.
Wenn Sie andere Cordova-Entwicklungstools verwenden, werden einige Ihrer Schritte anders sein. Anweisungen finden Sie in der Dokumentation
zum verwendeten Cordova-Tool. 
* Die {{ site.data.keys.mf_cli }} muss installiert sein.
* Das { site.data.keys.product_adj }}-Cordova-Plug-in muss installiert sein. 

Diese Schritte führen Sie am besten aus, nachdem Sie die Entwicklung Ihrer App abgeschlossen haben, wenn die App bereit für die Implementierung ist. Wenn Sie einen der folgenden Befehle
nach der Verschlüsselung der Webressourcen ausführen, wird der verschlüsselte Inhalt entschlüsselt. 

* cordova prepare
* cordova build
* cordova run
* cordova emulate
* mfpdev app webupdate
* mfpdev app preview

Wenn Sie einen der aufgelisteten Befehle nach der Verschlüsselung der Webressourcen ausführen, müssen Sie diese Schritte erneut ausführen, um die Webressourcen wieder zu
verschlüsseln. 

1. Öffnen Sie ein Terminalfenster und navigieren Sie zum Stammverzeichnis der Cordova-App, die Sie verschlüsseln wollen.
2. Bereiten Sie die App durch Eingabe eines der folgenden Befehle vor: 
    - cordova prepare
    - mfpdev app webupdate
3. Führen Sie einen der folgenden Schritte aus, um den Inhalt zu verschlüsseln: 
    - Geben Sie den Befehl `mfpdev app webencrypt` ein. **Tipp:** Wenn Sie Informationen zum Befehl
`mfpdev app webencrypt` anzeigen möchten, geben Sie
`mfpdev help app webencrypt` ein.
    - Sie können die Webressourcen von Cordova-Paketen auch verschlüsseln, indem Sie den Befehl
`cordova compile` oder
`cordova build` beim Erstellen Ihrer Pakete mit dem Flag `mfpwebencrypt` verwenden.

        - `cordova compile -- --mfpwebencrypt` | `cordova build -- --mfpwebencrypt`
    <br/>
Die Betriebssysteminformationen im Ordner **www** werden durch eine Datei **resources.zip** mit dem verschlüsselten Inhalt ersetzt.  
Wenn Ihre App für das
Android-Betriebssystem bestimmt und die Datei **resources.zip** größer als 1 MB ist, wird die
Datei **resources.zip** in kleinere ZIP-Dateien (mit einer Größe von 768 KB) unterteilt, die den Namen
**resources.zip.nnn** haben. Die Variable
nnn steht hier für eine Zahl von 001 bis 999.
4. Testen Sie die Anwendung mit den verschlüsselten Ressourcen mithilfe des Emulators, der mit den plattformspezifischen Tools bereitgestellt wird. Sie können den
Emulator beispielsweise in Android Studio für Android oder in Xcode für iOS verwenden.

**Hinweis:** Verwenden Sie die folgenden Cordova-Befehle nicht zum Testen der Anwendung, nachdem Sie die Anwendung verschlüsselt haben:

* `cordova run`
* `cordova emulate`

Diese Befehle aktualisieren den verschlüsselten Inhalt im Ordner www und speichern ihn wieder als entschlüsselten Inhalt. Wenn Sie diese Befehle verwenden, müssen Sie die Schritte für die Verschlüsselung des Inhalts erneut ausführen, bevor Sie die App
veröffentlichen. 

### Kontrollsummenfeature für Webressourcen aktivieren
{: #enabling-the-web-resources-checksum-feature }
Wenn das Kontrollsummenfeature für Webressourcen aktiviert ist, vergleicht es die Originalwebressourcen beim Start einer App
mit einer gespeicherten Referenzversion, die beim ersten Start dieser App erfasst wurde.
Dies ist eine gute Möglichkeit, Abweichungen der App festzustellen, die darauf hinweisen könnten, dass die App modifiziert wurde. Diese Vorgehensweise ist mit dem Feature für direkte
Aktualisierung kompatibel. 

**Voraussetzungen:**

* Die Cordova-Entwicklungstools müssen installiert sein. In diesem Beispiel wird die Apache-Cordova-Befehlszeilenschnittstelle verwendet.
Wenn Sie andere Cordova-Entwicklungstools verwenden, werden einige Ihrer Schritte anders sein. Anweisungen finden Sie in der Dokumentation
zum verwendeten Cordova-Tool. 
* Die {{ site.data.keys.mf_cli }} muss installiert sein. 
* Das { site.data.keys.product_adj }}-Plug-in muss installiert sein. 
* Sie müssen die gewüschnte Plattform zu Ihrem Cordova-Projekt hinzufügen, bevor Sie das Kontrollsummenfeature für Webressourcen
mit dem Befehl `cordova platform add [android|ios|windows|browser]` für das jeweilige Bettriebssystem aktivieren. 

Gehen Sie wie folgt
vor, um das Kontrollsummenfeature für Webressourcen für eine Cordova-App zu aktivieren: 

1. Navigieren Sie in einem Terminalfenster zum Stammverzeichnis Ihrer Ziel-App. 
2. Geben Sie den folgenden Befehl ein, um das Kontrollsummenfeature für Webressourcen für eine Betriebssystemumgebung Ihrer Cordova-App zu aktivieren:

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_test_web_resources_checksum true
   ```

   Beispiel:   
    
   ```bash
   mfpdev app config android_security_test_web_resources_checksum true
   ```

   Sie können das Feature inaktivieren, indem Sie
in dem Befehl **true** durch
**false** ersetzen.

   
   > **Tipp:** Wenn Sie Informationen zum Befehl
`mfpdev app config` anzeigen möchten, geben Sie
`mfpdev help app config` ein.
    
3. Geben Sie den folgenden Befehl ein, um die Dateitypen zu identifizieren, die während des Kontrollsummentests ignoriert werden sollen:

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_ignore_file_extensions [ Dateierweiterung1,Dateierweiterung2 ]
   ```
    
   Mehrere Erweiterungen
müssen ohne Leerzeichen und jeweils durch ein Komma getrennt angegeben werden. Beispiel: 
    
   ```bash
   mfpdev app config android_security_ignore_file_extensions jpg,png,pdf
   ```
    
**Wichtiger Hinweis:** Bei Asuführung dieses Befehls werden festgelegte Werte außer Kraft gesetzt. 

Je mehr Dateien der Kontrollsummentest für Webressourcen scannen muss, desto länger dauert es, bis die App geöffnet wird. Sie können die Erweiterung für einen Dateityp angeben, der übergangen werden soll,
um die Startgeschwindigkeit der App zu verbessern. 

Das Kontrollsummenfeature für Webressourcen ist für Ihre App aktiviert. 

1. Führen Sie den Befehl `cordova prepare` aus, um die Änderungen in Ihre App zu integrieren. 
2. Erstellen Sie einen App-Build, indem Sie den Befehl `cordova build` eingeben. 
3. Führen Sie Ihre App aus. Geben Sie dazu den Befehl `cordova run` ein. 
