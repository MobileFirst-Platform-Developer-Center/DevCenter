---
layout: tutorial
title: OpenWhisk-Adapter
breadcrumb_title: OpenWhisk-Adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

OpenWhisk ist eine FaaS-Plattform (Function-as-a-Service), die die Ausführung von Code in einer serverlosen und skalierbaren Umgebung ermöglicht. Eines der Einsatzgebiete der Plattform OpenWhisk ist die Entwicklung und Ausführung von serverlosem Back-End-Code für mobile Geräte. [Hier](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south) erfahren Sie mehr über die Plattform OpenWhisk für Bluemix.

Mit MobileFirst-Foundation-Adaptern wird die notwendige serverseitige Logik ausgeführt. Adapter werden zudem verwendet, um Informationen für Clientanwendungen und Cloud-Services von Back-End-Systemen abzurufen. Die {{ site.data.keys.product }} stellt jetzt einen Adapter für OpenWhisk-Funktionen bereit. 

##  OpenWhisk-Adapter
{: #openwhisk-adapter}

Die {{ site.data.keys.product_full }} stellt mit dem [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) einen OpenWhisk-Adapter bereit. Dieser Adapter kann in der Mobile-Foundation-Konsole über das **Download-Center** heruntergeladen und implementiert werden. 

Nachdem Sie den Adapter heruntergeladen und implementiert haben, müssen Sie ihn so konfigurieren, dass er eine Verbindung zu OpenWhisk herstellt.

### Adapter für Verbindung zu OpenWhisk konfigurieren
{: configure-adapter-connect-openwhisk}

Wenn Sie den Adapter für eine Verbindung zu OpenWhisk konfigurieren möchten, öffnen Sie die Seite **Adapter Configuration** und tragen Sie aus dem OpenWhisk-Autorisierungsschlüssel die Werte für _**username**_ und _**password**_ ein. Die Werte für _**username**_ und _**password**_ erhalten Sie, indem Sie den folgenden OpenWhisk-CLI-Befehl ausführen: 

```bash
./wsk property get --auth KEY
```

Der obige Befehl gibt den Autorisierungsschlüssel zurück. Der Schlüssel enthält zwei Angaben, die durch einen Doppelpunkt getrennt sind. Links vom Doppelpunkt ist der Benutzername (_**username**_) angegeben und rechts vom Doppelpunkt das Kennwort (_**password**_).

_**username:password**_

Die mit dem obigen Befehl abgerufenen Werte für _**username**_ und _**password**_ müssen auf der Konfigurationsseite für den OpenWhisk-Adapter angegeben werden. Speichern Sie dann die Konfiguration. Die Client-Apps können jetzt die Adapter-API aufrufen, um den OpenWhisk-Back-End-Code aufzurufen. 

>Falls Sie den Quellcode des OpenWhisk-Adapters modifizieren möchten, können Sie ihn aus diesem [Github-Repository](https://github.com/mfpdev/mfp-extension-adapters) herunterladen.
