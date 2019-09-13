---
layout: tutorial
title: Modellaktualisierung in Anwendungen
breadcrumb_title: Model Update
relevantTo: [iOS]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mit der Einführung von Machine-Learning-Modellen wie CoreML und TensorFlow Lite können mobile Apps auf Geräten ML-Operationen ausführen, z. B. eine Bilderkennung, auch wenn das Gerät offline ist. Ein wichtiges Merkmal von Machine-Learning-Modellen ist, dass sie sich kontinuierlich entwickeln. Die Aktualisierung solcher Modelle mit neueren Versionen wird zu einer sehr kritischen Aufgabe für den Erfolg einer mobilen App. 

Damit Sie dieser Forderung leichter nachkommen können, gibt es in der IBM Mobile Foundation das neue Feature für Modellaktualisierung. In die Mobile Foundation können jetzt ML-Modelle eingebettet werden, die drahtlos mit neueren Versionen aktualisiert werden können. Organisationen können so sicherstellen, dass Endbenutzer stets die aktualisierten KI-Modelle verwenden. 

Komprimieren Sie das neueste Modell (ZIP-Format), um die Modellversion an eine Anwendung zu senden. Diese `.zip`-Datei muss in der MobileFirst Operations Console auf der Registerkarte **Machine Learning** hochgeladen werden. Ruft die Anwendung im Anschluss daran die API `downloadModelUpdate` auf, wird die Modellaktualisierung aktiviert. 

>**Unterstützte Plattformen:** Zurzeit wird die Modellaktualisierung nur für iOS unterstützt.   

### Wichtige Hinweise
{: #notes }
* Mit der Modellaktualisierung werden nur KI-Modelle wie das CoreML-Modell von Apple oder das TensorFlow-Modell von Google aktualisiert. 

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to}

- [Funktionsweise der Modellaktualisierung](#how-model-update-works)
- [Modellpakete erstellen und implementieren](#creating-and-deploying-model-packages)
- [Update aufrufen](#invoking-an-update)

## Funktionsweise der Modellaktualisierung
{: #how-model-update-works }
Die Modelle werden anfänglich in das Anwendungspaket aufgenommen, damit die Offlineverfügbarkeit gewährleistet ist. Später überprüft die Anwendung bei jedem Aufruf der API `downloadModelUpdate` mit {{ site.data.keys.mf_server }}, ob Updates vorliegen. 

Nach einer Modellaktualisierung gibt die API `downloadModelUpdate` die Position des heruntergeladenen Modells zurück. Diese Position wird bei jedem Update aktualisiert. 

### Versionssteuerung
{: #versioning }
Die Modellaktualisierung gilt nur für eine bestimmte Anwendungsversion. Das bedeutet, dass eine für Version 2.0 einer Anwendung generierte Aktualisierung nicht für eine andere Version dieser Anwendung ausgeführt werden kann. 

## Modellpakete erstellen und implementieren
{: #creating-and-deploying-model-packages }
Wenn eine neuere oder aktualisierte Modellversion verfügbar ist, führen Sie die folgenden Schritte aus, um die Modelldatei in {{ site.data.keys.mf_server }} hochzuladen.

### Schritte:

 1. Erstellen Sie ein `.zip`-Archiv aus Machine-Larning-Modelldateien (z. B. `.mlmodel` ).
 2. Öffnen Sie die {{ site.data.keys.mf_console }} und klicken Sie im linken Fensterbereich auf die Anwendung.
 3. Navigieren Sie zur Registerkarte **Machine Learning** und klicken Sie auf **Upload model archive**, um die Modellpakete hochzuladen.

## Update aufrufen
{: #invoking-an-update }
Eine Modellaktualisierung der Anwendung kann durch Aufrufen der folgenden API überprüft werden. 

### iOS

```
 WLClient.sharedInstance().downloadModelUpdate(completionHandler: CompletionHandler, showProgressBar: Boolean);
```

>**Hinweis:** Diese API darf nicht zusammen mit der API `ObtainAccessToken` oder `WLResourceRequest` aufgerufen werden. 

Anwendungsentwickler werden diese API in der Regel während des Anwendungsstarts aufrufen. 

Die API `downloadModelUpdate` gibt die folgenden Statuscodes zurück sowie einen Link zum heruntergeladenen Paket bei erfolgreichem Download oder den Pfad zum zuvor heruntergeladenen Paket.

Für den abschließenden Status wird einer der folgenden Codes zurückgegeben: 

|Statuscode|Beschreibung |
|-------------|-------------|
|`SUCCESS` |Die Modellaktualisierung wurde fehlerfrei abgeschlossen.|
|`CANCELED` |Die Modellaktualisierung wurde abgebrochen. |
|`FAILURE_NETWORK_PROBLEM` |Es gab während der Aktualisierung ein Problem mit einer Netzverbindung.|
|`FAILURE_DOWNLOADING` |Die Datei wurde nicht vollständig heruntergeladen.|
|`FAILURE_NOT_ENOUGH_SPACE` |Auf dem Gerät ist nicht genug Speicher verfügbar, um die Aktualisierungsdatei herunterzuladen und zu entpacken.|
|`FAILURE_UNZIPPING` |Beim Entpacken der Aktualisierungsdatei ist ein Problem aufgetreten. |
|`FAILURE_ALREADY_IN_PROGRESS` | Eine Aktualisierung wurde angefordert, als bereits eine Aktualisierung lief. |
|`FAILURE_INTEGRITY` |Die Authentizität der Aktualisierungsdatei kann nicht verifiziert werden.|
|`FAILURE_UNKNOWN` |Unerwarteter interner Fehler|


## Sichere Modellaktualisierung
{: #secure-model-update }
Die sichere Modellaktualisierung ist standardmäßig inaktiviert. Sie verhindert, dass ein Angreifer von {{ site.data.keys.mf_server }} (oder von einem Content Delivery Network (CDN)) an die Clientanwendung übertragene Modelle ändert. 

### Authentizität der Modellaktualisierung aktivieren
Verwenden Sie Ihr bevorzugtes Tool, um den öffentlichen Schlüssel aus dem MobileFirst-Server-Keystore zu extrahieren und in einen Base64-Schlüssel zu konvertieren.   
Verwenden Sie den so erzeugten Wert dann wie folgt: 

1. Öffnen Sie in der Clientanwendung die MobileFirst-Konfigurationsdatei (d. h. `mfpclient.plist` für iOS und `mfpclient.properties` für Android).
2. Fügen Sie den neuen Schlüsselwert `wlSecureModelUpdatePublicKey` hinzu.
3. Geben Sie den öffentlichen Schlüssel als Wert an und speichern Sie die Datei.

Alle folgenden Modellaktualisierungen für Clientanwendungen sind nun durch die Authentizität der Modellaktualisierung geschützt. 

> Wie Sie den Anwendungsserver mit der aktalisieren Keystore-Datei konfigurieren können, erfahren Sie unter [Sichere Modellaktualisierung implementieren](secure-model-update/). 

### Modellaktualisierung in Entwicklung, Tests und Produktion
In der Entwicklungs- und Testphase werden Entwickler für eine Modellaktualisierung normalerweise einfach ein Archiv auf den Entwicklungsserver hochladen.
Diese Vorgehensweise ist einfach zu implementieren, aber auch nicht sehr sicher, denn Modelle können während der Übertragung oder nach dem Herunterladen auf dem Gerät manipuliert werden können.

In der Testphase für die Produktion oder auch in Vorbereitung auf die Produktion wird dringend die Implementierung der sicheren Modellaktualisierung empfohlen, bevor Ihre Anwendung im App Store veröffentlicht wird. Für die sichere Modellaktualisierung ist ein RSA-Schlüsselpaar erforderlich, das aus einem von einer Zertifizierungsstelle signierten Serverzertifikat extrahiert wird.

>**Hinweis:** Denken Sie daran, dass die Keystore-Konfiguration
nach der Veröffentlichung der Anwendung nicht modifiziert werden darf. Heruntergeladene Aktualisierungen erst wieder authentifiziert, wenn
die Anwendung mit einem neuen öffentlichen Schlüssel rekonfiguriert und erneut veröffentlicht wurde. Ohne diese Schritte schlägt die Modellaktualisierung auf dem Client fehl.

> Weitere Informationen finden Sie unter [Sichere Modellaktualisierung](secure-model-update/).

### Datenübertragungsgeschwindigkeit bei der Modellaktualisierung
Unter optimalen Bedingungen kann ein einzelner
{{ site.data.keys.mf_server }} Daten per Push mit einer
Geschwindigkeit von 250 MB pro Sekunde übertragen. Wenn eine höhere Geschwindigkeit erforderlich ist, ziehen Sie einen Cluster oder einen CDN-Service
in Betracht. 
