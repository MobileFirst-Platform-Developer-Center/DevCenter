---
layout: tutorial
title: Entwicklungsumgebung einrichten
breadcrumb_title: Entwicklungsumgebung
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Bevor Sie die {{ site.data.keys.product_full }} für die Entwicklung von Client- und Server-Code nutzen können, muss die Entwicklungsumgebung eingerichtet werden. Im Rahmen dieser Einrichtung werden Sie diverse erforderliche Softwareprodukte und Tools installieren. Nachfolgend sind die Softwareprodukte aufgelistet, die Sie - abhängig von Ihren Anforderungen - auf Ihrer Entwicklerworkstation installieren müssen.

Ausführliche schrittweise Anweisungen finden Sie in diesem [Installationshandbuch für Workstations](mobilefirst/installation-guide/).

#### Fahren Sie mit folgenden Abschnitten fort:

* [Server](#server)
* [Anwendungsentwicklung](#application-development)
* [Adapterentwicklung](#adapter-development)
* [Plattformspezifische Anweisungen](#platform-specific-instructions)

### Server
{: #server }
{{ site.data.keys.mf_server }} können Sie über den [Mobile-Foundation-Bluemix-Service](../../bluemix/using-mobile-foundation) nutzen oder
lokal über das {{ site.data.keys.mf_dev_kit_full }} (das für die lokale Entwicklung bestimmt ist). {{ site.data.keys.mf_server }} setzt
Java 7 bzw. Java 8 voraus.

Wenn Sie den Mobile-Foundation-Bluemix-Service verwenden möchten, benötigen Sie ein Konto auf bluemix.net.

### Anwendungsentwicklung
{: #application-development }
Folgende Softwareprodukte werden als Minimum benötigt:

* Node.js (Voraussetzung für die {{ site.data.keys.mf_cli }})
* {{ site.data.keys.mf_cli }}
* Cordova-CLI
* IDEs:
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io / Visual Studio Code / WebStorm / IntelliJ / Eclipse / andere IDEs

### Adapterentwicklung
{: #adapter-development }
Folgende Softwareprodukte werden als Minimum benötigt:

* Node.js (Voraussetzung für die {{ site.data.keys.mf_cli }})
* {{ site.data.keys.mf_cli }} (*optional*)
* Maven (erfordert Java)
* IDEs:
    - IntelliJ / Eclipse / andere IDEs

### Plattformspezifische Anweisungen
{: #platform-specific-instructions }
