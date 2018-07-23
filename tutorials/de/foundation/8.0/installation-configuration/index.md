---
layout: tutorial
title: Installation und Konfiguration
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} stellt Entwicklungstools und serverseitige Komponenten bereit, die Sie
lokal vor Ort installieren oder für Test- und Produktionszwecke in der Cloud implementieren können. Lesen Sie die Abschnitte zu dem für Sie zutreffenden
Installationsszenario.

### Entwicklungsumgebung einrichten
{: #installing-a-development-environment }
Wenn Sie die Client- oder Serverseite mobiler Anwendungen entwickeln möchten, beginnen Sie mit
dem [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) oder
dem Service [{{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation).

**Verwendung des {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

Das {{ site.data.keys.mf_dev_kit }} enthält alles Notwendige zum Ausführen und Debuggen mobiler Anwendungen auf einer persönlichen Workstation. Wie eine Anwendung mithilfe des {{ site.data.keys.mf_dev_kit }} entwickelt wird, erfahren Sie im Lernprogramm [MobileFirst-Entwicklungsumgebung einrichten](development/mobilefirst). 

**Verwendung des {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

Der Service {{ site.data.keys.mf_bm }} bietet ähnliche Funktionen wie das {{ site.data.keys.mf_dev_kit }} an, wird aber in IBM Cloud ausgeführt. 

**Entwicklungsumgebung für MobileFirst-Foundation-Anwendungen einrichten**
{: #setting-dev-env-mf-apps }

Die {{ site.data.keys.product }} ist enorm flexibel, wenn es um die Plattformen und Tools geht, die für die Entwicklung von MobileFirst-Foundation-Anwendungen genutzt werden können. Damit die gewählten Tools mit der {{ site.data.keys.product }} interagieren können, sind jedoch einige Konfigurationsschritte erforderlich.  

Wählen Sie aus den folgenden Links für die Einrichtung der Entwicklungsumgebung denjenigen aus, der Ihrem Anwendungsansatz entspricht:

* [Cordova-Entwicklungsumgebung einrichten](development/cordova)
* [iOS-Entwicklungsumgebung einrichten](development/ios)
* [Android-Entwicklungsumgebung einrichten](development/android)
* [Windows-Entwicklungsumgebung einrichten](development/windows)
* [Xamarin-Entwicklungsumgebung einrichten](development/xamarin)
* [Webentwicklungsumgebung einrichten](development/web)

### Test- oder Produktionsserver lokal einrichten
{: #installing-a-test-or-production-server-on-premises }

In der ersten Phase der Installation von {{ site.data.keys.product }} Server wird ein IBM Produkt mit dem Namen IBM Installation Manager verwendet. Sie müssen IBM Installation Manager ab Version 1.8.4 installiert haben, bevor Sie die Komponenten von {{ site.data.keys.product }} Server installieren. 

> **Wichtiger Hinweis:** Sie müssen
IBM Installation Manager ab Version 1.8.4 verwenden. Die älteren Versionen des
Installation Manager sind nicht in der Lage, {{ site.data.keys.product }} {{ site.data.keys.product_version }}
zu installieren, da für den Installationsabschluss für das Produkt
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6.

Der Installationsassistent für {{ site.data.keys.mf_server }} verwendet IBM Installation Manager, um alle Serverkomponenten auf den Anwendungsserver zu stellen. Es werden auch Tools und Bibliotheken installiert, die für die Implementierung der Komponenten von {{ site.data.keys.product }} Server im Anwendungsserver erforderlich sind. Es hat sich bewährt, nicht alle Komponenten in einer Anwendungsserverinstanz zu installieren, es sei denn, es handelt sich um einen Entwicklungsserver. Die Implementierungstools ermöglichen Ihnen, die zu installierenden Komponenten auszuwählen. Unter [Topologien und Netzabläufe](production/prod-env/topologies) sind Punkte beschrieben, die vor Installation des Servers zu berücksichtigen sind. 

Lesen Sie die folgenden Abschnitte, um sich über die Vorbereitung und Installation von {{ site.data.keys.mf_server }} und optionalen Services in Ihrer konkreten Umgebung zu informieren. Ein einfaches Setup finden Sie im Lernprogramm [Test- oder Produktionsumgebung einrichten](production). 

* [Vorbedingungen überprüfen](production/prod-env/prereqs)
* [Komponenten von {{ site.data.keys.mf_server }} im Überblick](production/prod-env/topologies)
* Vor dem Laden von Tools und Bibliotheken zum Implementieren der MobileFirst-Server-Komponenten und optional des Application Center zu berücksichtigende Faktoren
  * Tokenlizenz
  * MobileFirst Foundation Application Center
  * Administratormodus und Benutzermodus im Vergleich
* Verteilerweg von MobileFirst Server nach dem Laden der Dateien
* Laden von Dateien: 
  * mit dem Installationsassistent von IBM Installation Manager
  * mit IBM Installation Manager in der Befehlszeile
  * mit XML-Antwortdateien (unbeaufsichtigte Installation)
* [Back-End-Datenbanken für die Komponenten von MobileFirst Foundation Server konfigurieren](production/prod-env/databases)
* [MobileFirst Server in einem Anwendungsserver installieren](production/prod-env/appserver)
* [MobileFirst Server konfigurieren](production/server-configuration)
* [MobileFirst Analytics Server installieren](production/analytics/installation)
* [Application Center installieren](production/appcenter)
* [MobileFirst Server in IBM PureApplication System implementieren](production/pure-application)

### Test- oder Produktionsumgebung einrichten
{: #setting-up-test-or-production-server}

Hier lernen Sie, wie {{ site.data.keys.mf_server }} installiert wird, indem Sie
die Anweisungen für die Erstellung eines
funktionsfähigen MobileFirst-Server-Clusters mit zwei Knoten in
WebSphere Application Server Liberty Profile durcharbeiten. Für die Installation können Sie die Grafiktools (grafische Benutzerschnittstelle) oder die Befehlszeile verwenden. 

* [Installation im GUI-Modus mit IBM Installation Manager und dem Server Configuration Tool](production/simple-install/tutorials/graphical-mode)
* [Befehlszeileninstallation mit dem Befehlszeilentool](production/simple-install/tutorials/command-line)

Wenn Sie die Installation mit einer der beiden oben beschriebenen Methoden durchgeführt haben, können abhängig von den Voraussetzungen weitere [Konfigurationsschritte](production/server-configuration) erforderlich sein, um das Setup abzuschließen. 

### Optionale Features in der Test- oder Produktionsumgebung einrichten
{: #setting-up-optional-features-test-or-production-server}

Zur {{ site.data.keys.product }} gehören optionale Komponenten, die Sie zur Erweiterung Ihrer Test- oder Produktionsumgebung nutzen können. Weitere Informationen enthalten die folgenden Lernprogramme: 

* [{{ site.data.keys.mf_analytics_server }} installieren und konfigurieren](production/analytics/installation/)
* [{{ site.data.keys.mf_app_center }} installieren und konfigurieren](production/appcenter)

### Test- oder Produktionsumgebung mit {{ site.data.keys.mf_server }} in der Cloud implementieren
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

Für die Implementierung von {{ site.data.keys.mf_server }} in der Cloud gibt es die folgenden Möglichkeiten:

* [Verwendung von {{ site.data.keys.mf_server }} in IBM Cloud](../bluemix).
* [{{ site.data.keys.mf_server }} in IBM PureApplication](production/pure-application)

### Upgrade für ältere Versionen
{: #upgrading-from-earlier-versions }
Informationen zum Durchführen von Upgrades auf eine neuere Version für vorhandene Installationen und Anwendungen finden Sie unter
[Upgrade
auf {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).
