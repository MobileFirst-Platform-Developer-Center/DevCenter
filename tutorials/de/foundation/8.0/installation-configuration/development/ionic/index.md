---
layout: tutorial
title: Ionic-Entwicklungsumgebung einrichten
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Ionic ist ein auf [AngularJS](https://angularjs.org/) und [Apache Cordova](https://cordova.apache.org/) basierendes Framework, das Sie mit Webtechnologien wie HTML, CSS und JavaScript dabei unterstützt, rasch mobile Hybrid-Apps und Web-Apps zu erstellen.

Wenn Sie ein Entwickler sind und Ionic als Framework für die Entwicklung Ihrer mobilen App oder Web-App gewählt haben, finden Sie in den folgenden Abschnitten einführende Informationen zum SDK der [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) in Ihrer Ionic-App.

Zum Schreiben von Anwendungen können Sie Ihren bevorzugten Codeeditor nutzen, z. B. Atom.io, Visual Studio Code, Eclipse, IntelliJ und andere.

**Voraussetzung:** Wenn Sie Ihre Ionic-Entwicklungsumgebung einrichten, müssen Sie das Lernprogramm [MobileFirst-Entwicklungsumgebung einrichten](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) durchgearbeitet haben.

## Ionic-CLI installieren
{: #installing_cli }
Bevor Sie mit der Ionic-Entwicklung beginnen können, müssen Sie die [Ionic-CLI](https://ionicframework.com/docs/cli/) installieren.

**Gehen Sie für die Installation der Ionic-CLI wie folgt vor:**

* Sie müssen [NodeJS](https://nodejs.org/en/) herunterladen und installieren.
* Führen Sie in einem Befehlszeilenfenster den folgenden Befehl aus:
```bash  
  npm install -g ionic
```  

## Mobile-Foundation-SDK zu Ihrer Ionic-App hinzufügen
{: #adding_mfp_ionic_sdk }
Für die Fortsetzung der MobileFirst-Entwicklung von Ionic-Anwendungen müssen Sie das MobileFirst-Cordova-SDK bzw. die MobileFirst-Cordova-Plug-ins zu Ihrer Ionic-Anwendung hinzufügen.

Informieren Sie sich darüber, wie das MobileFirst-SDK zu Cordova-Anwendungen hinzugefügt wird.
Informationen zur Anwendungsentwicklung enthält das Lernprogramm [Mobile-Foundation-SDK zu Ionic-Anwendungen hinzufügen]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic).
