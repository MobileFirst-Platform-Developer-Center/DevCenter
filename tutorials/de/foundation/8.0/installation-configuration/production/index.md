---
layout: tutorial
title: MobileFirst Server für eine Produktionsumgebung installieren
breadcrumb_title: Produktionsumgebung
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier erfahren Sie
Einzelheiten, die Sie bei der Planung und Vorbereitung einer Installation für Ihre konkrete Umgebung unterstützen.   
Weitere Informationen zur Konfiguration von
{{ site.data.keys.mf_server }}
finden Sie unter
[{{ site.data.keys.mf_server }} konfigurieren](server-configuration). 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Voraussetzungen](#prerequisites)
* [Weitere Schritte](#whats-next)

## Voraussetzungen
{: #prerequisites }
Damit die Installation von {{ site.data.keys.mf_server }}
reibungslos durchgeführt werden kann, müssen Sie sicherstellen, dass alle Voraussetzungen bezüglich der
Software erfüllt sind.


**Datenbankmanagementsystem (DBMS)**  
Ein DBMS wird zum Speichern der technischen
Daten von MobileFirst-Server-Komponenten benötigt.
Verwenden Sie eines der unterstützten DBMS: 

* IBM DB2 
* MySQL
* Oracle

Weitere Infromationen zu den vom Produkt unterstützten DBMS-Versionen finden Sie in den
[Systemvoraussetzungen](../../product-overview/requirements). Wenn Sie ein relationales
DBMS (IBM DB2, Oracle oder MySQL) verwenden, benötigen
Sie während des Installationsprozesses den JDBC-Treiber für die Datenbank.
Die JDBC-Treiber werden nicht vom Installationsprogramm für
{{ site.data.keys.mf_server }} bereitgestellt.
Stellen Sie sicher, dass der JDBC-Treiber vorhanden ist. 

* Verwenden Sie für DB2 Version 4.0 des DB2-JDBC-Treibers (db2jcc4.jar).
* Verwenden Sie für MySQL den Connector/J-JDBC-Treiber. 
* Verwenden Sie für Oracle den Oracle-Thin-JDBC-Treiber. 

**Java-Anwendungsserver**  
Für die Ausführung der MobileFirst-Server-Anwendungen wird ein Java-Anwendungsserver benötigt.
Sie können einen der folgenden Anwendungsserver verwenden:

* WebSphere Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

Weitere Infromationen zu den vom Produkt unterstützten Anwendungsserverversionen finden Sie in den
[Systemvoraussetzungen](../../product-overview/requirements). Der Anwendungsserver muss mit
Java 7
oder einer aktuelleren Version ausgeführt werden. Einige Versionen von WebSphere Application Server werden standardmäßig mit
Java 6 ausgeführt. In diesen Versionen kann
{{ site.data.keys.mf_server }} nicht ausgeführt werden. 

**IBM Installation Manager ab Version 1.8.4**  
Der Installation Manager wird zur Ausführung des Installationsprogramms für
{{ site.data.keys.mf_server }} benötigt.
Sie müssen Installation Manager ab Version 1.8.4 installieren. Die älteren Versionen des
Installation Manager sind nicht in der Lage, {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}
zu installieren, da für den Installationsabschluss für das Produkt
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6. 

Laden Sie das Installationsprogramm für
IBM Installation
Manager ab Version 1.8.4
über die [Installation Manager and Packaging Utility Download
Links herunter](http://www.ibm.com/support/docview.wss?uid=swg27025142). 

**Installation-Manager-Repository für {{ site.data.keys.mf_server }}**  
Sie können das Repository über [IBM
Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm) aus der eAssembly für
die {{ site.data.keys.product }}
herunterladen.
Das Paket hat den Namen **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**.

Vielleicht möchten Sie ja auch das neueste Fixpack anwenden, das vom
[IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation) heruntergeladen werden kann. Das Fixpack kann nicht ohne das Repository der Basisversion in den Repositorys von Installation Manager installiert werden.

Die eAssembly zur {{ site.data.keys.product }} umfasst die folgenden
Installationsprogramme: 

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Für Liberty können Sie auch
die IBM WebSphere SDK Java Technology Edition
mit der Ergänzung IBM WebSphere Application
Server Liberty Core verwenden. 

## Weitere Schritte
{: #whats-next }

* [IBM Installation Manager ausführen](installation-manager)
* [Datenbanken einrichten](databases)
* [Topologien und Netzabläufe](topologies)
* [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](appserver)
