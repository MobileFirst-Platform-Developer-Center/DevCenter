---
layout: tutorial
title: Setting Up the Development Environment
breadcrumb_title: Development Environment
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
You can use the {{ site.data.keys.mf_server }} either via the [Mobile Foundation IBM Cloud service](../../bluemix/using-mobile-foundation), or locally using the {{ site.data.keys.mf_dev_kit_full }} (used for local development purposes). {{ site.data.keys.mf_server }} setzt
Java 7 bzw. Java 8 voraus.

If you intend on using the Mobile Foundation IBM Cloud service, an account on bluemix.net is required.

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
