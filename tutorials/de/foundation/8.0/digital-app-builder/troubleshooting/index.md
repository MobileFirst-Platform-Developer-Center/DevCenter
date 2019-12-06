---
layout: tutorial
title: Fehlerbehebung
weight: 17
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #troubleshooting }

Hier finden Sie Hinweise zu einigen Problemen, die bei der Verwendung von IBM Digital App Builder auftreten können.

* Nutzen Sie beim Auftreten von Fehlern Folgendes:

    * Datei `log.log` im Ordnerpfad für die jeweilige Plattform:

        * Mac OS: `~/Library/Logs/IBM Digital App Builder/log.log`

        * Windows: `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`

    * Datei `applog.log` mit Protokollen zu Ihrer App (unter `<APP LOCATION>/ibm/applog.log`)

* Mit einer Swagger-Datei kann kein Dataset für einen Mikroservice erstellt werden.

    Bei Erstbenutzern des App Builder kann die Mikroserviceerstellung aufgrund der Netzlatenz fehlschlagen.
    Führen Sie die folgenden Schritte aus, um dieses Problem zu lösen:
    1. Öffnen Sie die Eingabeaufforderung und navigieren Sie zur Installationsposition der App.
    2. `cd ibm\adapterGenerator`
    3. Führen Sie den folgenden Befehl aus:
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. Wenn der obige Befehl erfolgreich ausgeführt wurde, können Sie mit der Verwendung des Mikroservice (Swagger-Datei) im Digital App Builder beginnen.

* Unter Windows ist keine App-Vorschau möglich.

    Navigieren Sie im Digital App Builder zu **Einstellungen > Projekt reparieren** und klicken Sie auf die Schaltflächen **Abhängigkeiten neu erstellen** und **Plattformen neu erstellen**.

* Eine Android-App funktioniert nach dem Hinzufügen der Listenkomponente nicht.

    Dieses Problem tritt bei Verwendung einer älteren Version als Android WebView 68.X.XXXX.XX auf. Führen Sie zum Lösen des Problems ein Upgrade auf Android WebView ab Version 68.X.XXXX.XX durch. 

* Unter Mac OS schlägt die App-Vorschau in einem Android-Simulator fehl. Die App stürzt dabei mit folgendem Fehler ab:

    `java.lang.RuntimeException: Unable to create application com.ibm.MFPApplication: java.lang.RuntimeException: Client configuration file mfpclient.properties not found in application assets. Use the MFP CLI command 'mfpdev app register' to create the file.`

    Korrigieren Sie diesen Fehler, indem Sie am Terminal zum Ionic-App-Verzeichnis navigieren und die folgenden Befehle ausführen:

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    Wiederholen Sie dann die Vorschau vom Digital App Builder aus.

* Der Adapter kann nicht generiert werden, wenn die Swagger-JSON/YAML-Datei importiert wird.

    Der Fehler beim Importieren der Swagger-JSON/YAML-Datei tritt wegen einer Maven-Abhängigkeit auf. 

    Im Idealfall werden alle Maven-Abhängigkeiten im Hintergrund heruntergeladen und installiert, wenn sie noch nicht vorhanden sind. In einigen Fällen schlägt Maven jedoch fehl, weil es im System mehrere Maven-Versionen gibt. Führen Sie zum Lösen dieses Problems die folgenden Schritte aus:

    a. Navigieren Sie zur App-Position und öffnen Sie je nach Betriebssystem die Datei execute.sh bzw. execute.bat (`<APP-POSITION>\ibm\adapterGenerator`).

    b. Ändern Sie alle Vorkommen von `call %MAVEN_HOME% clean install` in `call %MAVEN_HOME% -U clean install`.

        Wenn Sie `-U` hinzufügen, wird Maven gezwungen, alle externen Abhängigkeiten zu überprüfen, die gemäß der POM-Datei aktualisiert werden müssen.

* Die Prüfung der Voraussetzungen für Android Studio schlägt fehl, obwohl die vorausgesetzten Komponenten installiert sind.

    Stellen Sie sicher, dass sich die ausführbare Android-Datei im Pfad befindet (`<Pfad zum Android-SDK>/tools`), wenn Sie die Voraussetzungen überprüfen.

* Problem bei der App-Erstellung und -Voranzeige unter Windows 7

    Wenn Sie versuchen, eine neue App an einer anderen Plattenlaufwerkposition als `C:` zu erstellen, wird möglicherweise ein Fehler gemeldet.

    Sie müssen Ihr App-Projekt an der Laufwerkposition `C://<Ihr Ordnername/App-Name>` erstellen.

* Digital App Builder stürzt mit rotem Bildschirm ab.

    Wenn Sie bei einem Absturz einen roten Bildschirm sehen, überprüfen Sie die Protokolle an folgender Position:
    * Mac OS - `/Users/<Benutzername>/Library/Logs/IBM Digital App Builder/log.log`
    * Windows - `C:\\Users\<Benutzername>\AppData\Roming\IBM Digital App Builder\log.log`

    Wenn es sich um einen Fehler bei `getPath` aus `rendered.js` handelt, ist es ein bekanntes [Electron-Problem](https://github.com/electron/electron/issues/8205).

    Dies kommt gelegentlich vor.

    Nach einem Neustart des Digital App Builder sollte Ihr Szenario wieder funktionieren.
