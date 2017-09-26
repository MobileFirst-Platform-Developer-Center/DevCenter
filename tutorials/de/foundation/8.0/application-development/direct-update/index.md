---
layout: tutorial
title: Direkte Aktualisierung in Cordova-Anwendungen
breadcrumb_title: Direkte Aktualisierung
relevantTo: [cordova]
weight: 8
downloads:
  - name: Cordova-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/CustomDirectUpdate/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mithilfe der direkten Aktualisierung können Cordova-Anwendungen drahtlos mit den neuesten Webressourcen aktualisiert werden, z. B. mit
applikativer Logik (JavaScript), HTML, CSS oder Bildern, die geändert, korrigiert oder neu erstellt wurden. Organisationen können so sicherstellen, dass Endbenutzer stets die neuste Version der Anwendung nutzen. 

Wenn eine Anwendung aktualisiert werden soll, müssen die aktualisierten Webressourcen der Anwendung gepackt über die
{{ site.data.keys.mf_cli }} oder mittels einer generierten Archivdatei auf den {{ site.data.keys.mf_server }} hochgeladen werden. Die direkte Aktualisierung wird dann automatisch aktiviert.
Nach der Aktivierung wird die direkte Aktualisierung bei jeder
Anforderung einer geschützten Ressource durchgesetzt. 

**Unterstützende Cordova-Plattformen**  
Die direkte Aktualisierung wird von den Plattformen Cordova iOS und Cordova Android unterstützt. 

**Direkte Aktualisierung in Entwicklung, Tests und Produktion**  
In der Entwicklungs- und Testphase werden Entwickler für eine direkte Aktualisierung normalerweise
einfach ein Archiv auf den Entwicklungsserver hochladen.
Diese Vorgehensweise ist einfach zu implementieren, aber auch nicht sehr sicher. In dieser Phase wird ein internes RSA-Schlüsselpaar
verwendet, das aus einem eingebetteten selbst siginierten
{{ site.data.keys.product_adj }}-Zertifikat
extrahiert wird. 

In der Phase der Liveproduktion oder auch in der Testphase in Vorbereitung auf die Produktion wird dringend die Implementierung der sicheren direkten Aktualisierung
empfohlen, bevor Ihre Anwendung im App Store veröffentlicht wird.
Für die sichere direkte Aktualisierung ist ein RSA-Schlüsselpaar erforderlich, das aus einem echten, von einer Zertifizierungsstelle signierten Serverzertifikat
extrahiert wird. 

**Hinweis:** Denken Sie daran, dass die Keystore-Konfiguration
nach der Veröffentlichung der Anwendung nicht modifiziert werden darf. Heruntergeladene Aktualisierungen erst wieder authentifiziert, wenn
die Anwendung mit einem neuen öffentlichen Schlüssel rekonfiguriert und erneut veröffentlicht wurde. Ohne diese beiden Schritte schlägt die direkte Aktualisierung auf dem Client
fehl. 

> Weitere Informationen finden Sie unter [Sichere direkte Aktualisierung](#secure-direct-update).

**Datenübertragungsrate bei der direkten Aktualisierung**  
Unter optimalen Bedingungen kann ein einzelner
{{ site.data.keys.mf_server }} Daten per Push mit einer
Geschwindigkeit von 250 MB pro Sekunde übertragen. Wenn eine höhere Geschwindigkeit erforderlich ist, ziehen Sie einen Cluster oder einen CDN-Service
in Betracht.   

> Weitere Informationen finden Sie unter [Anforderungen nach direkter Aktualisierung mit einem CDN bedienen](cdn-support). 

### Hinweise
{: #notes }

* Bei der direkten Aktualisierung werden nur die Webressourcen der Anwendung aktualisiert. Wenn Sie native Ressourcen aktualisieren möchten, müssen Sie eine neue Anwendungsversion an den jeweiligen App Store übergeben. 
* Wenn Sie das Feature für direkte Aktualisierungen verwenden und das [Kontrollsummenfeature für Webressourcen](../cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature) aktiviert ist, wird bei jeder direkten Aktualisierung eine neue Kontrollsummenbasis erstellt. 
* Wenn für {{ site.data.keys.mf_server }} ein Upgrade mit einem Fixpack durchgeführt wurde,
stellt der Server weiter ordnungsgemäß direkte Aktualisierungen bereit. Wenn jedoch ein kürzlich erstelltes Archiv (ZIP-Datei) für die direkte Aktualisierung hochgeladen wird, kann die direkte Aktualisierung für
ältere Clients gestoppt werden, weil das Archiv die Version des Plug-ins
cordova-plugin-mfp enthält.
Der Server vergleicht die Clientversion mit der Plug-in-Version, bevor er das Archiv für einen mobilen Client bereitstellt. Stimmen beide Versionen größtenteils (d. h. bei den drei wichtigsten Ziffern) überein, findet eine normale direkte Aktualisierung statt. Andernfalls überspringt
{{ site.data.keys.mf_server }}
die Aktualisierung im Hintergrund. Eine Lösung bei abweichenden Versionen ist das Herunterladen des Plug-ins
cordova-plugin-mfp in der Version, die für Ihr ursprüngiches Cordova-Projekt verwendet wurde, und das erneute Generieren des Archivs für die direkte
Aktualisierung. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}

- [Funktionsweise der direkten Aktualisierung](#how-direct-update-works)
- [Aktualisierte Webressourcen erstellen und implementieren](#creating-and-deploying-updated-web-resources)
- [Attraktivität für den Benutzer](#user-experience)
- [Schnittstelle für direkte Aktualisierung anpassen](#customizing-the-direct-update-ui)
- [Vollständige direkte Aktualisierung und Delta-Aktualisierung](#delta-and-full-direct-update)
- [Sichere direkte Aktualisierung](#secure-direct-update)
- [Beispielanwendung](#sample-application)

## Funktionsweise der direkten Aktualisierung
{: #how-direct-update-works }
Die Webressourcen der Anwendung werden anfänglich in das Anwendungspaket aufgenommen, damit die Offlineverfügbarkeit gewährleistet ist. Später überprüft die Anwendung bei jeder an {{ site.data.keys.mf_server }} gerichteten Anforderung, ob Aktualisierungen vorhanden sind.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Hinweis:** Nach einer direkten Aktualisierung findet die nächste Überprüfung nach 60 Minuten statt.

Wenn eine direkte Aktualisierung durchgeführt wurde, verwendet die Anwendung nicht mehr die ursprünglich im Anwendungspaket enthaltenen Webressourcen. Sie verwendet stattdessen die aus der Anwendungs-Sandbox heruntergeladenen Webressourcen. Wenn der Anwendungscache auf dem Gerät gelöscht wird, werden wieder die Webressourcen aus dem ursprünglichen Paket verwendet. 

![Funktionsweise der direkten Aktualisierung](internal_function.jpg)

### Versionssteuerung
{: #versioning }
Die direkte Aktualisierung gilt nur für eine bestimmte Version. Das bedeutet, dass eine für Version 2.0 einer Anwendung generierte Aktualisierung nicht für eine andere Version dieser Anwendung ausgeführt werden kann. 

## Aktualisierte Webressourcen erstellen und implementieren
{: #creating-and-deploying-updated-web-resources }
Wenn Arbeiten an neuen Webressourcen ausgeführt werden, z. B. Fehlerkorrekturen oder geringfügige Änderungen,
müssen die aktualisierten Webressourcen gepackt und auf den {{ site.data.keys.mf_server }} hochgeladen werden.

1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Cordova-Projekts. 
2. Führen Sie den Befehl `mfpdev app webupdate` aus. 

Mit dem Befehl `mfpdev app webupdate` werden die aktualisierten Webressourcen zu einer ZIP-Datei gepackt
und auf den aktiven Standard-MobileFirst-Server auf der
Entwicklerworkstation hochgeladen. Sie finden die gepackten Webressourcen im Ordner **[Stammorder_des_Cordova-Projekts]/mobilefirst/**. 

Alternativen:

* Erstellen Sie die ZIP-Datei und laden Sie sie auf einen anderen {{ site.data.keys.mf_server }} hoch. Führen Sie dazu den Befehl `mfpde app webupdate [Servername] [Laufzeitname]` aus. Beispiel: 

  ```bash
  mfpdev app webupdate myQAServer MyBankApps
  ```

* Laden Sie die zuvor generierte ZIP-Datei hoch. Führen Sie dazu den folgenden Befehl aus: `mfpdev app webupdate [Servername] [Laufzeitname] --file [Pfad_zu_gepackten_Webressourcen]`. Beispiel: 

  ```bash
  mfpdev app webupdate myQAServer MyBankApps --file mobilefirst/ios/com.mfp.myBankApp-1.0.1.zip
  ```

* Laden Sie die gepackten Webressourcen manuell auf den {{ site.data.keys.mf_server }} hoch:
 1. Erstellen Sie die ZIP-Datei, ohne sie hochzuladen: 

    ```bash
    mfpdev app webupdate --build
    ```
 2. Laden Sie die {{ site.data.keys.mf_console }} und klicken Sie auf den Anwendungseintrag.
 3. Klicken Sie auf **Upload Web Resources File**, um die gepackten Webressourcen hochzuladen. 

    ![ZIP-Datei für direkte Aktualisierung in der Konsole hochladen](upload-direct-update-package.png)

> Führen Sie den Befehl `mfpdev app webupdate` aus, um mehr zu erfahren. 

## Attraktivität für den Benutzer
{: #user-experience }
Nach dem Empfang einer direkten Aktualisierung wird standardmäßig ein Dialog angezeigt, in dem der Benutzer gefragt wird, ob die Aktualisierung gestartet werden soll. Nach der Bestätigung durch den Benutzer wird eine Fortschrittsleiste angezeigt und die Webressourcen werden heruntergeladen. Nach Abschluss der Aktualisierung wird die Anwendung automatisch neu geladen. 

![Beispiel für direkte Aktualisierung](direct-update-flow.png)

## Schnittstelle für direkte Aktualisierung anpassen
{: #customizing-the-direct-update-ui }
Die dem Benutzer angezeigte Standardbenutzerschnittstelle für direkte Aktualisierung kann angepasst werden.   
Fügen Sie in der Datei **index.js** innerhalb der Funktion `wlCommonInit()` Folgendes hinzu: 

```javascript
wl_DirectUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext) {
    // Angepasste Logik für direkte Aktualisierung implementieren
};
```

- `directUpdateData` - JSON-Objekt mit der Eigenschaft `downloadSize`, die die Dateigröße des von {{ site.data.keys.mf_server }} herunterzuladenden
Aktualisierungspakets (in Bytes) angibt
- `directUpdateContext` - JavaScript-Objekt, das jeweils eine Funktion `.start()` und `.stop()`
zum Starten und Stoppen des Ablaufs der direkten Aktualisierung zugänglich macht

Wenn die Webressourcen auf dem {{ site.data.keys.mf_server }} neuer als die Webressourcen in der
Anwendung sind, werden zur Serverantwort Abfragedaten für die direkte Aktualisierung hinzugefügt. Wenn das
clientseitige {{ site.data.keys.product_adj }}-Framework die Abfrage zur direkten Aktualisierung erkennt, ruft es
die Funktion `wl_directUpdateChallengeHandler.handleDirectUpdate` auf. 

Die Funktion stellt ein Standarddesign für die direkte Aktualisierung bereit. Wenn eine direkte Aktualisierung verfügbar ist,
wird ein Dialog mit einer Standardnachricht angezeigt, und nach der Einleitung der direkten Aktualisierung erscheint
eine Standardfortschrittsanzeige. Sie können diese Funktion überschreiben und Ihre eigene Logik implementieren, wenn Sie ein angepasstes Verhalten
der Benutzerschnittstelle für direkte Aktualisierung erreichen oder das Dialogfenster für die direkte Aktualisierung anpassen möchten.

<img alt="Angepasster Dialog für direkte Aktualisierung" src="custom-direct-update-dialog.jpg" style="float:right; margin-left: 10px"/>
Im folgenden Beispielcode implementiert eine Funktion `handleDirectUpdate` eine angepasste Nachricht im Dialog für direkte Aktualisierung. Fügen Sie den folgenden Code zur Datei **www/js/index.js** des Cordova-Projekts hinzu.   
Weitere Beispiele für eine angepasste Benutzerschnittstelle für direkte Aktualisierung: 

- Mit einem JavaScript-Framework eines anderen Anbieters (z. B. Dojo oder jQuery Mobile, Ionic usw.) erstellter Dialog
- Vollständig native Benutzerschnittstelle durch Ausführung eines Cordova-Plug-ins
- Alternative HTML, die dem Benutzer mit Optionen angezeigt wird

```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext) {        
    navigator.notification.confirm(  // Erstellt einen Dialog
        'Custom dialog body text',
        // Dialogschaltflächen behandeln
          directUpdateContext.start();
        },
        'Custom dialog title text',
        ['Update']
    );
};
```

Sie können die direkte Aktualisierung starten, indem Sie immer, wenn der Benutzer im Dialog auf die Schaltfläche klickt,
eine Methode `directUpdateContext.start()` ausführen. Die Fortschrittsanzeige erscheint. Sie ähnelt der in den
Vorgängerversionen von
{{ site.data.keys.mf_server }}. 

Diese Methode unterstützt die folgenden Aufrufarten:

* Wenn keine Parameter angegeben sind,
verwendet {{ site.data.keys.mf_server }} die Standardfortschrittsanzeige. 
* Wenn eine Listenerfunktion wie `directUpdateContext.start(directUpdateCustomListener)` bereitgestellt wird, wird die direkte Aktualisierung im Hintergrund ausgeführt und sendet Lebenszyklusereignisse
an den Listener. Der angepasste Listener muss die folgenden Methoden implementieren:

```javascript
var directUpdateCustomListener = {
onStart : function ( totalSize ){ }, 
    onProgress : function ( status , totalSize , completedSize ){ }, 
    onFinish : function ( status ){ } 
};
```

Die Listenermethoden werden während der direkten Aktualisierung gemäß den folgenden Regeln gestartet:  
* Die Methode `onStart` wird mit dem Parameter `totalSize` aufgerufen, der die Größe der Aktualisierungsdatei
angibt.
* Die Methode `onProgress` wird mehrmals mit dem Status `DOWNLOAD_IN_PROGRESS` sowie mit
`totalSize` und `completedSize` (dem bisher heruntergeladenen Volumen) aufgerufen.
* Die Methode `onProgress` wird mit dem Status `UNZIP_IN_PROGRESS` aufgerufen.
* Die Methode `onFinish` wird mit einem der abschließenden Statuscodes
aufgerufen:      

| Statuscode| Beschreibung |
|-------------|-------------|
| `SUCCESS` | Die direkte Aktualisierung wurde fehlerfrei abgeschlossen.|
| `CANCELED` | Die direkte Aktualisierung wurde abgebrochen (weil beispielsweise die Methode `stop()` aufgerufen wurde).|
| `FAILURE_NETWORK_PROBLEM` | Es gab während der Aktualisierung ein Problem mit einer Netzverbindung.|
| `FAILURE_DOWNLOADING` | Die Datei wurde nicht vollständig heruntergeladen.|
| `FAILURE_NOT_ENOUGH_SPACE` | Auf dem Gerät ist nicht genug Speicher verfügbar, um die Aktualisierungsdatei herunterzuladen und zu entpacken.|
| `FAILURE_UNZIPPING` | Beim Entpacken der Aktualisierungsdatei ist ein Problem aufgetreten. |
| `FAILURE_ALREADY_IN_PROGRESS` | Die Startmethode wurde aufgerufen, als die direkte Aktualisierung bereits lief.|
| `FAILURE_INTEGRITY` | Die Authentizität der Aktualisierungsdatei kann nicht verifiziert werden.|
| `FAILURE_UNKNOWN` | Unerwarteter interner Fehler|

Wenn Sie einen angepassten Listener für die direkte Aktualisierung implementieren, müssen Sie sicherstellen, dass
nach Abschluss der direkten Aktualisierung
`onFinish()` aufgerufen und die App neu geladen wird. Wenn die direkte Aktualisierung nicht erfolgreich abgeschlossen werden kann,
müssen Sie
außerdem `wl_directUpdateChalengeHandler.submitFailure()` aufrufen. 

Das folgende Beispiel zeigt eine Implementierung eines angepassten Listeners für die direkte Aktualisierung:

```javascript
var directUpdateCustomListener = {
onStart: function(totalSize){
    // Angepassten Fortschrittsdialog anzeigen
  },
  onProgress: function(status,totalSize,completedSize){
    // Angepassten Fortschrittsdialog aktualisieren
  },
  onFinish: function(status){

    if (status == 'SUCCESS'){
      // Erfolgsnachricht anzeigen
      WL.Client.reloadApp();
    }
    else {
      // Angepasste Fehlernachricht anzeigen

      // Bei einem Fehler muss submitFailure aufgerufen werden.
      wl_directUpdateChallengeHandler.submitFailure();
    }
  }
};

wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  WL.SimpleDialog.show('Update Avalible', 'Press update button to download version 2.0', [{
    text : 'update',
    handler : function() {
      directUpdateContext.start(directUpdateCustomListener);
    }
  }]);
};
```

### Szenario: Direkte Aktualisierung ohne Benutzerschnittstelle durchführen
{: #scenario-running-ui-less-direct-updates }
Die {{ site.data.keys.product_full }} unterstützt
die direkte Aktualisierung ohne Benutzerschnittstelle, wenn die Anwendung im Vordergrund ausgeführt wird. 

Implementieren Sie
`directUpdateCustomListener` für die direkte Aktualisierung ohne Benutzerschnittstelle.
Stellen Sie für die Methoden `onStart` und `onProgress` leere Funktionsimplementierungen bereit.
Leere Implementierungen bewirken, dass die direkte Aktualisierung im Hintergrund ausgeführt wird.

Die Anwendung muss neu geladen werden, um den
Prozess der direkten Aktualisierung abzuschließen. Folgende Optionen sind verfügbar: 
* Die Methode `onFinish` kann auch leer sein. In dem Fall erfolgt die direkte Aktualisierung nach einem Neustart
der Anwendung. 
* Sie können einen angepassten Dialog implementieren, in dem der Benutzer über den notwendigen Neustart der Anwendung informiert oder
zum erneuten Starten der Anwendung aufgefordert wird (siehe folgendes Beispiel). 
* Die Methode `onFinish` kann
`WL.Client.reloadApp()` aufrufen, um einen Neustart der Anwendung durchzusetzen.

Nachfolgend sehen Sie eine
Beispielimplementierung von `directUpdateCustomListener`:

```javascript
var directUpdateCustomListener = {
onStart: function(totalSize){
  },
  onProgress: function(status,totalSize,completeSize){
  },
  onFinish: function(status){
    WL.SimpleDialog.show('New Update Available', 'Press reload button to update to new version', [ {
      text : WL.ClientMessages.reload,
      handler : WL.Client.reloadApp
    }]);
  }
};
```

Implementieren Sie die Funktion `wl_directUpdateChallengeHandler.handleDirectUpdate`.
Übergeben Sie die erstellte Implementierung von `directUpdateCustomListener` als Parameter
an die Funktion. Stellen Sie sicher, dass `directUpdateContext.start(directUpdateCustomListener)` aufgerufen wird. Nachfolgend sehen Sie eine
Beispielimplementierung von `wl_directUpdateChallengeHandler.handleDirectUpdate`:

```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  directUpdateContext.start(directUpdateCustomListener);
};
```

**Hinweis:** Wenn sich die Anwendung im Hintergrund befindet, wird die direkte Aktualisierung ausgesetzt.

### Szenario: Fehler bei der direkten Aktualisierung behandeln
{: #scenario-handling-a-direct-update-failure }
Dieses Szenario zeigt die Behandlung eines
Fehlers bei der direkten Aktualisierung, der beispielsweise wegen verlorener Konnektivität auftreten könnte. Der Benutzer kann in diesem Szenario die
App nicht verwenden, auch nicht im Offlinemodus. Ein Dialog wird angezeigt, in dem der Benutzer aufgefordert wird, den Vorgang erneut zu versuchen.

Erstellen Sie eine globale
Variable, um den Kontext für die direkte Aktualisierung zu speichern. Sie können diese später verwenden, wenn die direkte Aktualisierung
fehlschlägt. Beispiel: 

```javascript
var savedDirectUpdateContext;
```

Implementieren Sie einen
Abfrage-Handler für die direkte Aktualisierung. Speichern Sie dort den Kontext für die direkte Aktualisierung. Beispiel:

```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  savedDirectUpdateContext = directUpdateContext; // Kontext der direkten Aktualisierung speichern

  var downloadSizeInMB = (directUpdateData.downloadSize / 1048576).toFixed(1).replace(".", WL.App.getDecimalSeparator());
  var directUpdateMsg = WL.Utils.formatString(WL.ClientMessages.directUpdateNotificationMessage, downloadSizeInMB);

  WL.SimpleDialog.show(WL.ClientMessages.directUpdateNotificationTitle, directUpdateMsg, [{
    text : WL.ClientMessages.update,
    handler : function() {
      directUpdateContext.start(directUpdateCustomListener);
    }
  }]);
};
```

Erstellen Sie eine Funktion, die die direkte Aktualisierung über den Kontext für die direkte Aktualisierung startet. Beispiel: 

```javascript
restartDirectUpdate = function () {
savedDirectUpdateContext.start(directUpdateCustomListener); // gespeicherten Kontext der direkten Aktualisierung für Neustart der direkten Aktualisierung verwenden
};
```

Implementieren Sie `directUpdateCustomListener`.
Fügen Sie in der Methode `onFinish` eine Statusprüfung hinzu. Wenn der Status mit
"FAILURE" beginnt, öffnen Sie einen rein modalen Dialog mit der Option
"Try Again". Beispiel: 

```javascript
var directUpdateCustomListener = {
onStart: function(totalSize){
    alert('onStart: totalSize = ' + totalSize + 'Byte');
  },
  onProgress: function(status,totalSize,completeSize){
    alert('onProgress: status = ' + status + ' completeSize = ' + completeSize + 'Byte');
  },
  onFinish: function(status){
    alert('onFinish: status = ' + status);
    var pos = status.indexOf("FAILURE");
    if (pos > -1) {
      WL.SimpleDialog.show('Update Failed', 'Press try again button', [ {
        text : "Try Again",
        handler : restartDirectUpdate // direkte Aktualisierung neu starten
      }]);
    }
  }
};
```

Wenn der Benutzer auf die Schaltfläche **Try Again** klickt, startet die Anwendung die direkte Aktualisierung neu.

## Vollständige direkte Aktualisierung und Delta-Aktualisierung
{: #delta-and-full-direct-update }
Bei einer direkten Delta-Aktualisierung lädt eine Anwendung nur die Dateien herunter, die seit der letzten
Aktualisierung geändert wurden, und nicht die gesamten Webressourcen der Anwendung. Dadurch verkürzt sich die Downloadzeit. Zudem wird die Attraktivität für den Benutzer erhöht. 

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:**
Eine **Delta-Aktualisierung** ist nur möglich, wenn der Versionsstand der Webressourcen der Clientanwendung
um eine Version hinter dem Stand der zurzeit auf dem Server implementierten Anwendung zurückliegt. Liegt die Clientanwendung mehr als eine Version hinter der
derzeit implementierten anwendung zurück (was geschieht, wenn die Anwendung
auf dem Server seit der letzten Aktualisierung der Clientanwendung mindestens zweimal implementiert wurde),
wird eine **vollständige Aktualisierung** empfangen. (In dem Fall werden alle Webressourcen heruntergeladen und aktualisiert.)

## Sichere direkte Aktualisierung
{: #secure-direct-update }
Die sichere direkte Aktualisierung ist standardmäßig inaktiviert. Sie verhindert,
dass ein Angreifer von {{ site.data.keys.mf_server }} (oder von einem Content Delivery Network (CDN)) an die Clientanwendung übertragene Webressourcen ändert. 

**Gehen Sie wie folgt vor, um die Authentizität der direkten Aktualisierung zu aktivieren:**  
Verwenden Sie Ihr bevorzugtes Tool, um den öffentlichen Schlüssel aus dem MobileFirst-Server-Keystore
zu extrahieren und in einen Base64-Schlüssel zu konvertieren.   
Verwenden Sie den so erzeugten Wert dann wie folgt: 

1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Cordova-Projekts. 
2. Führen Sie den Befehl `mfpdev app config` aus und wählen Sie die Option "Direct Update Authenticity public key" aus. 
3. Geben Sie den öffentlichen Schlüssel an und bestätigen Sie die Eingabe. 

Alle folgenden direkten Aktualisierungen für Clientanwendungen sind nun durch die Authentizität der direkten Aktualisierung geschützt. 

> Wie Sie den Anwendungsserver mit der aktalisieren Keystore-Datei konfigurieren können, erfahren Sie unter [Sichere direkte Aktualisierung implementieren](secure-direct-update). 

## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/CustomDirectUpdate/tree/release80), um das Cordova-Projekt herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
