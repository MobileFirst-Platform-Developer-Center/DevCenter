---
layout: tutorial
title: MobileFirst-Entwicklungsumgebung einrichten
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} setzt sich aus mehreren Komponenten zusammen: Client-SDKs, Adapterarchetypen, Sicherheitsüberprüfungen und Authentifizierungstools.

Diese Komponenten sind in Onlinerepositorys verfügbar und können mit Paketmanagern installiert werden. Die Onlinerepositorys
stellen jeweils das neueste Release einer Komponente bereit. Die gleichen Komponenten können mit dem {{ site.data.keys.mf_dev_kit }} für die lokale Nutzung heruntergeladen werden. Im {{ site.data.keys.mf_dev_kit_short }} ist die Version enthalten,
die zum Zeitpunkt der Erstellung des jeweiligen Developer-Kit-Builds verfügbar war.
Wenn Sie die neueste Version verwenden möchten, müssen Sie einen neuen Developer-Kit-Build herunterladen.

Informieren Sie sich nun tiefergehend über die Komponenten der {{ site.data.keys.product }}.

> Um die {{ site.data.keys.product }} zu bewerten, müssen Sie nur mit dem IBM Cloud-Service "Mobile Foundation" eine Instanz von {{ site.data.keys.mf_server }} in IBM Cloud aktivieren. Anweisungen enthält das Lernpgoramm [Mobile Foundation verwenden](../../../bluemix/using-mobile-foundation/). Für eine lokale Installation können Sie auch das {{ site.data.keys.mf_dev_kit_short }} installieren.

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Installationshandbuch](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [Komponenten der {{ site.data.keys.product }}](#mobilefirst-foundation-components)
* [Anwendungs- und Adapterentwicklung](#applications-and-adapters-development)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Installationshandbuch
{: #installation-guide }
[Lesen Sie im Installationshandbuch nach](installation-guide), wie Sie die MobileFirst Foundation rasch auf Ihrer Workstation einrichten können.

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
Das {{ site.data.keys.mf_dev_kit_short }} stellt eine einsatzbereite Entwicklungsumgebung bereit, die nur minimal konfiguriert werden muss. Das Kit umfasst die folgenden
Komponenten: {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_console }}, MobileFirst Developer CLI (Befehlszeilenschnittstelle)
sowie optional SDKs und Adaptertools, die heruntergeladen werden können.

> **Hinweis:** Wenn Sie Ihre Entwicklungsumgebung auf einem Computer ohne
Internetzugang einrichten müssen, können Sie Komponenten offline
installieren (siehe
[How to set up
an offline IBM MobileFirst Development Environment]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment)).

### {{ site.data.keys.mf_dev_kit_short }} Installer
{: #developer-kit-installer }
Der Installer stellt ein Komponentenpaket für eine lokale Installation bereit, falls keine Internetverbindung verfügbar ist.  
Die Komponenten sind über das Download-Center in der {{ site.data.keys.mf_console }} verfügbar.

> Öffnen Sie zum Herunterladen des Installers die Seite [Downloads]({{site.baseurl}}/downloads/).

## Komponenten der {{ site.data.keys.product }}
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Mit dem {{ site.data.keys.mf_dev_kit_short }} wird ein im Anwendungsserver WebSphere Liberty Profile implementierter
{{ site.data.keys.mf_server }} bereitgetellt. Der Server ist mit einer "mfp"-Laufzeit vorkonfiguriert und verwendet eine dateisystembasierte Apache-Derby-Datenbank.

Im Stammverzeichnis des {{ site.data.keys.mf_dev_kit_short }} sind die folgenden Scripts zur Ausführung über die Befehlszeile verfügbar:

* `run.[sh|cmd]`: Ausführung von {{ site.data.keys.mf_server }} mit anschließenden Liberty-Server-Nachrichten
    * Wenn der Prozess im Hintergrund ausgeführt werden soll, fügen Sie das Attribut `-bg` hinzu.
* `stop.[sh|cmd]`: Stoppen der aktuellen MobileFirst-Server-Instanz
* `console.[sh|cmd]`: Öffnen der {{ site.data.keys.mf_console }}

Für Mac und Linux lautet die Dateierweiterung `.sh` und für Windows lautet sie `.cmd`.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
Die {{ site.data.keys.mf_console }} ermöglicht Entwicklern die Ausführung folgender Funktionen:

- Anwendungen und Adapter registrieren und implementieren
- Startercodeschablonen für native Anwendungen bzw. Cordova-Anwendungen herunterladen (optional)
- Authentifizierungs- und Sicherheitseigenschaften einer Anwendung konfigurieren
- Anwendungen verwalten:
    - Anwendungsauthentizität
    - Direkte Aktualisierung
    - Inaktivierung/Benachrichtigung über Fernzugriff
- Push-Benachrichtigungen an iOS- und Android-Geräte senden
- DevOps-Scripts für fortlaufende Integrationsworkflows und kürzere Entwicklungszyklen generieren

> Informieren Sie sich anhand des Lernprogramms [MobilFirst Operations Console verwenden](../../../product-overview/components/console/) über die {{ site.data.keys.mf_console }}.

### Befehlszeilenschnittstelle der {{ site.data.keys.product }}
{: #mobilefirst-foundation-command-line-interface }
Sie können die
{{ site.data.keys.mf_cli }} zusätzlich zur
{{ site.data.keys.mf_console }} nutzen, um Anwendungen zu entwickeln und zu verwalten. Die CLI-Befehle, die mit `mfpdev` beginnen, unterstützen folgende Arten von Aufgaben:

* Apps bei {{ site.data.keys.mf_server }} registrieren
* Apps konfigurieren
* Adapter erstellen und implementieren
* Cordova-Apps voranzeigen und aktualisieren

> Öffnen Sie zum Herunterladen und Installieren der {{ site.data.keys.mf_cli }} die Seite
[Downloads]({{site.baseurl}}/downloads/).  
> Weitere Informationen zu den verschiedenen CLI-Befehlen enthält das Lernprogramm [{{ site.data.keys.product_adj }}-Artefakte über die CLI verwalten](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### Client-SDKs und Adaptertools der {{ site.data.keys.product }}
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
Die {{ site.data.keys.product }} stellt Client-SDKs für Cordova-Anwendungen sowie für native Plattformen
(iOS, Android sowie Windows 8.1 Universal und Windows 10 UWP) bereit. Darüber hinaus stehen Adaptertools für die Entwicklung von Adaptern und Sicherheitsüberprüfungen zur Verfügung.

* Wenn Sie die {{ site.data.keys.product_adj }}-Client-SDKs verwenden möchten, wechseln Sie zur Lernprogrammkategorie zum [Hinzufügen des SDK der {{ site.data.keys.product }}](../../../application-development/sdk/).  
* Informationen zur Entwicklung von Adaptern enthält die Lernprogrammkategorie zu [Adaptern](../../../adapters/).  
* Hinweise zur Entwicklung von Sicherheitsüberprüfungen finden Sie in der Lernprogrammkategorie zur [Authentifizierung und Sicherheit](../../../authentication-and-security/).  

## Anwendungs- und Adapterentwicklung
{: #applications-and-adapters-development }

### Anwendungen
{: #applications }
* Cordova-Anwendungen erfordern Node.js und die Cordova-CLI. Informieren Sie sich anhand des Abschnitts [Cordova-Entwicklungsumgebung einrichten](../cordova).

    Für die Implementierung von Anwendungen und Adaptern können Sie Ihren bevorzugten Codeeditor nutzen, z. B.
Atom.io, Visual Studio Code, Eclipse, IntelliJ und andere.  

* Für native Anwendungen ist Xcode, Android Studio oder Visual Studio erforderlich. Informieren Sie sich anhand des Abschnitts [iOS/Android/Windows-Entwicklungsumgebung einrichten](../).

### Adapter
{: #adapters }
Für Adapter müssen Sie Apache Maven installieren. In der Kategorie [Adapter](../../../adapters/) finden Sie weitere Informationen zu Adaptern sowie zur Erstellung, Entwicklung und Implementierung von Adaptern.

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Öffnen Sie die Seite [Alle Lernprogramme](../../../all-tutorials/) und wählen Sie eine Lernprogrammkategorie aus.
