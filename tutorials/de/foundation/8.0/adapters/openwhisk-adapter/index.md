---
layout: tutorial
title: Cloud-Functions-Adapter
breadcrumb_title: Cloud Functions adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

> OpenWhisk hat jetzt die Bezeichnung Cloud Functions.

IBM Cloud Functions ist eine FaaS-Plattform (Function-as-a-Service), die die Ausführung von Code in einer serverlosen und skalierbaren Umgebung ermöglicht. Eines der Einsatzgebiete der Cloud-Functions-Plattform ist die Entwicklung und Ausführung von serverlosem Back-End-Code für mobile Geräte. [Hier](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south) erfahren Sie mehr über die Cloud-Functions-Plattform für IBM Cloud. 

Mit MobileFirst-Foundation-Adaptern wird die notwendige serverseitige Logik ausgeführt. Adapter werden zudem verwendet, um Informationen für Clientanwendungen und Cloud-Services von Back-End-Systemen abzurufen. Die {{ site.data.keys.product }} stellt jetzt einen Adapter für Cloud Functions bereit. 

##  Cloud-Functions-Adapter
{: #cloud-functions-adapter}

Die {{ site.data.keys.product_full }} stellt mit dem [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) einen Cloud-Functions-Adapter bereit. Dieser Adapter kann in der Mobile-Foundation-Konsole über das **Download-Center** heruntergeladen und implementiert werden. 

Nachdem Sie den Adapter heruntergeladen und implementiert haben, müssen Sie ihn so konfigurieren, dass er eine Verbindung zu Cloud Funcions herstellt.

### Adapter für Verbindung zu Cloud Functions konfigurieren
{: configure-adapter-connect-cloud-functions}

Wenn Sie den Adapter für eine Verbindung zu Cloud Functions konfigurieren möchten, öffnen Sie die Seite **Adapter Configuration** und tragen Sie aus dem Cloud-Functions-Autorisierungsschlüssel die Werte für _**username**_ und _**password**_ ein. Die Werte für _**username**_ und _**password**_ erhalten Sie, indem Sie den folgenden Cloud-Functions-CLI-Befehl ausführen: 

```bash
./wsk property get --auth KEY
```

Der obige Befehl gibt den Autorisierungsschlüssel zurück. Der Schlüssel enthält zwei Angaben, die durch einen Doppelpunkt getrennt sind. Links vom Doppelpunkt ist der Benutzername (_**username**_) angegeben und rechts vom Doppelpunkt das Kennwort (_**password**_).

_**username:password**_

Die mit dem obigen Befehl abgerufenen Werte für _**username**_ und _**password**_ müssen auf der Konfigurationsseite für den Cloud-Functions-Adapter angegeben werden. Speichern Sie dann die Konfiguration. Die Client-Apps können jetzt die Adapter-API aufrufen, um den Cloud-Functions-Back-End-Code aufzurufen. 

>Falls Sie den Quellcode des Cloud-Functions-Adapters modifizieren möchten, können Sie ihn aus diesem [Github-Repository](https://github.com/mfpdev/mfp-extension-adapters) herunterladen.
