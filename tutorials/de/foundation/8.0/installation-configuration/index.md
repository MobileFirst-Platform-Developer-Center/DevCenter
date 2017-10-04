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

### Entwicklungsumgebung installieren
{: #installing-a-development-environment }
Wenn Sie die Client- oder Serverseite mobiler Apps entwickeln möchten, beginnen Sie mit
dem [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) oder
dem Service [{{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation). 

* [MobileFirst-Entwicklungsumgebung einrichten](development/mobilefirst/)
* [Cordova-Entwicklungsumgebung einrichten](development/cordova)
* [iOS-Entwicklungsumgebung einrichten](development/ios)
* [Android-Entwicklungsumgebung einrichten](development/android)
* [Windows-Entwicklungsumgebung einrichten](development/windows)
* [Xamarin-Entwicklungsumgebung einrichten](development/xamarin)
* [Webentwicklungsumgebung einrichten](development/web)

### Test- oder Produktionsserver lokal installieren
{: #installing-a-test-or-production-server-on-premises }
IBM Installationen basieren
auf dem IBM Produkt
IBM Installation Manager.
Vor der Installation der {{ site.data.keys.product }} müssen Sie
IBM Installation Manager ab Version 1.8.4
in einem separaten Schritt
installieren.


> **Wichtiger Hinweis:** Sie müssen
IBM Installation Manager ab Version 1.8.4 verwenden. Die älteren Versionen des
Installation Manager sind nicht in der Lage, {{ site.data.keys.product }} {{ site.data.keys.product_version }}
zu installieren, da für den Installationsabschluss für das Produkt
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6. Das Installationsprogramm für {{ site.data.keys.mf_server }}
kopiert alle für die Implementierung von
MobileFirst-Server-Komponenten und optional des
{{ site.data.keys.mf_app_center_full }} in Ihrem Anwendungsserver erforderlichen Tools und Bibliotheken
auf Ihren Computer.


Wenn Sie einen Test- oder Produktionsserver installieren möchten, beginnen Sie mit den nachfolgenden
**Lernprogrammen zur Installation von {{ site.data.keys.mf_server }}** für eine einfache Installation,
um sich über die Installation von
{{ site.data.keys.mf_server }} zu informieren.
Weitere Informationen zur Vorbereitung einer Installation für Ihre konkrete Umgebung finden Sie unter
[{{ site.data.keys.mf_server }} für eine Produktionsumgebung installieren](production). 

**Lernprogramme zur Installation von {{ site.data.keys.mf_server }}**  
Hier lernen Sie, wie {{ site.data.keys.mf_server }} installiert wird, indem Sie
die Anweisungen für die Erstellung eines
funktionsfähigen MobileFirst Server in einem Cluster mit zwei Knoten in
WebSphere Application Server Liberty Profile durcharbeiten. Es gibt zwei Möglichkeiten der Installation: 

* [Grafikmodus von IBM Installation Manager](production/tutorials/graphical-mode) und Server Configuration Tool
* [Befehlszeilentool](production/tutorials/command-line)

Nach der Installation haben Sie einen funktionsbereiten {{ site.data.keys.mf_server }}. Bevor Sie den Server verwenden, müssen Sie ihn aber noch konfigurieren, insbesondere für die Sicherheit. Weitere Informationen finden Sie unter
[{{ site.data.keys.mf_server }} konfigurieren](production/server-configuration).

**Zusätze**  

* Wenn Sie
{{ site.data.keys.mf_analytics_server }} zu Ihrer Installation hinzufügen möchten,
lesen Sie die Informationen
im [{{ site.data.keys.mf_analytics_server }} Installationshandbuch](production/analytics/installation/).   
* Informationen zur Installation des {{ site.data.keys.mf_app_center }} finden Sie unter [Application Center installieren und konfigurieren](production/appcenter).

### {{ site.data.keys.mf_server }} in der Cloud
implementieren
{: #deploying-mobilefirst-server-to-the-cloud }
Für die Implementierung von {{ site.data.keys.mf_server }} in der Cloud gibt es die folgenden Möglichkeiten: 

* [{{ site.data.keys.mf_server }} in IBM Bluemix](../bluemix)
* j[{{ site.data.keys.mf_server }} in IBM PureApplication](production/pure-application)

### Upgrade für ältere Versionen
{: #upgrading-from-earlier-versions }
Informationen zum Durchführen von Upgrades auf eine neuere Version für vorhandene Installationen und Anwendungen finden Sie unter
[Upgrade
auf {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version). 


