---
layout: tutorial
title: MobileFirst Server in einer Produktionsumgebung installieren
breadcrumb_title: Installing MobileFirst Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Dieses Lernprogramm ist für Entwickler und Administratoren bestimmt, die MobileFirst Server in einer Produktionsumgebung installieren und konfigurieren möchten.
Hier finden Sie ausführliche Schritte, die über das Lernprogramm zur Installation von MobileFirst Server hinausgehen und Sie beim Planen und Vorbereiten einer Installation für Ihre konkrete Umgebung unterstützen. 


## Installationsvoraussetzungen
{: #prereqs }

Damit die Installation von MobileFirst Server
reibungslos durchgeführt werden kann, müssen Sie sicherstellen, dass alle [Voraussetzungen](prereqs) bezüglich der Software erfüllt sind.

## IBM Installation Manager ausführen
{: #run-install-mgr }

IBM Installation
Manager installiert
die Dateien und Tools von {{ site.data.keys.mf_server_full }} auf Ihrem Computer. Gehen Sie gemäß der Anleitung in diesem
[Lernprogramm zur Installation und Ausführung von IBM Installation Manager](../installation-manager) vor.

## Datenbanken einrichten
{: #databases }

Richten Sie die Datenbank für MobileFirst-Server-Komponenten ein. Gehen Sie gemäß der Anleitung in diesem [Lernprogramm zur Einrichtung der Datenbank](databases) vor.

## Topologien und Netzabläufe
{: #topologies }

Es gibt Abschnitte zu möglichen Servertopologien für MobileFirst-Server-Komponenten und zu den Netzabläufen. Gehen Sie gemäß der Anleitung in diesem [Lernprogramm zu den möglichen Servertopologien und Netzabläufen](topologies) vor.

## MobileFirst Server in einem Anwendungsserver installieren
{: #install-to-appserver }

Die Installation der Komponenten können Sie mit Ant-Tasks,
dem Server Configuration Tool oder manuell ausführen. Informieren Sie sich über die Voraussetzungen
und die Einzelheiten des Installationsprozesses, damit Sie die Komponenten erfolgreich im Anwendungsserver
installieren können. Gehen Sie gemäß der Anleitung in diesem [Lernprogramm zur Installation der MobileFirst-Komponenten in einem Anwendungsserver](appserver) vor.
