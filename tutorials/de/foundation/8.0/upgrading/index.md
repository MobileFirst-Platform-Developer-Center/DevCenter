---
layout: tutorial
title: Frühere Releases umstellen
weight: 12
---
## Übersicht
{: #overview }
In {{ site.data.keys.product_full }} Version 8.0
gibt es neue Konzepte für die Anwendungsentwicklung und -implementierung sowie einige API-Änderungen. Hier können Sie sich über diese Änderungen informieren, um die Umstellung Ihrer
MobileFirst-Anwendungen
zu planen. 

> [Nutzen Sie für einen schnellen Einstieg in den Migrationsprozess das Migrations-Cookbook](migration-cookbook). 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Warum auf {{ site.data.keys.product_full }} 8.0 umstellen?](#why-migrate-to-ibm-mobilefirst-foundation-80)
* [Änderungen beim Entwicklungs- und Implementierungsprozess](#changes-in-the-development-and-deployment-process)
* [Cordova- oder Hybridanwendung umstellen](#migrating-a-cordova-or-hybrid-application)
* [Native Anwendung umstellen](#migrating-a-native-application)
* [Adapter und Sicherheit umstellen](#migrating-adapters-and-security)
* [Unterstützung für Push-Benachrichtigungen umstellen](#migrating-push-notifications-support)
* [Änderungen bei den Serverdatenbanken und der Serverstruktur](#changes-in-the-server-databases-and-in-the-server-structure)
* [Mobile Daten in Cloudant speichern](#storing-mobile-data-in-cloudant)
* [Fixpack auf {{ site.data.keys.mf_server }} anwenden](#applying-a-fix-pack-to-mobilefirst-server)

## Warum auf IBM MobileFirst Foundation 8.0 umstellen?
{: #why-migrate-to-ibm-mobilefirst-foundation-80}

### Nötige Anstrengungen und Kenntnisse sowie erforderliche Zeit für die Erstellung von Anwendungen verringern
* Schnelleres, einfacheres und intelligenteres Erstellen von Apps mit Standardpaketmanagern (npm, CocoaPods, Gradle, NuGet) und Maven für die automatisierte Erstellung von Java-Adaptern
* Einfachere und modulare Integration von MobileFirst-SDKs
* Neue und verbesserte Attraktivität für den Benutzer, z. B. durch Vorwegnahme der nächsten Benutzeraktion und Bereitstellung von Hilfeinformationen beim Registrieren, Konfigurieren und Implementieren von Apps

### Erweiterte Automation sowie neuer Entwicklungs- und IT-Self-Service
* Neues Feature für Liveaktualisierung zur Auslagerung und dynamischen Änderung von konfigurierbaren App-Informationen (Push-Benachrichtigungen, Authentifizierung, Adapter, App-Verhalten und Workflow)
* Konzeptionell vollständige Überarbeitung und radikale Vereinfachung der Konsolenbenutzeraktionen für die Registrierung, Implementierung und Verwaltung von Apps
* Neue einfachere App-Architektur, in der keine wechselseitige Entwicklungs- und IT-Abhängigkeit mehr nötig ist
* Verbesserte Problembestimmung mit neuen Absturzanalysen, konfigurierbaren Alerts und Analyse der zugrunde liegenden Ursachen
* Verbesserte Push-Benachrichtigungsservices, die das Senden gezielter, abonnementgestützter Benachrichtigungen von der Webkonsole aus ermöglichen

### Mehr Optionen für die Hybrid-Cloud-Implementierung
* Bereitstellung von MobileFirst-Foundation-Entwicklungsumgebungen und -Testumgebungen sowie von voll skalierbaren MobileFirst-Foundation-Produktionsumgebungen in Bluemix Public per Mausklick
* Integration von IBM DevOps Services und UrbanCode für die Erstellung Ihrer Implementierungspipelines

### Mehrkanal-API-Erstellung und -Management
* Intensivierung der API-Connect-Mehrkanalsicherheit mit speziellen Sicherheitserweiterungen für mobile Geräte (Intensivierung, Multifaktor) für maximalen Schutz und anschließende Durchsetzung in der Datenverwaltungszone mit IBM DataPower
* Erstellung und Definition von mit API Connect kompatiblen Swagger-REST-APIs in MobileFirst Foundation Version 8 und anschließende Verwaltung und Sicherung dieser APIs in API Connect

## Änderungen beim Entwicklungs- und Implementierungsprozess
{: #changes-in-the-development-and-deployment-process }
> Wenn Sie schnell praktische Entwicklungserfahrungen mit
{{ site.data.keys.product }} Version 8.0.0 sammeln möchten, sehen Sie sich die [Lernprogramme für den
Schnelleinstieg](../quick-start)
an. In dieser Produktversion
erstellen Sie keine Projekt-WAR-Datei mehr, die in dem Anwendungsserver installiert werden muss, in
dem {{ site.data.keys.mf_server }} ausgeführt wird, bevor die Apps hochgeladen werden können. Stattdessen wird
{{ site.data.keys.mf_server }} einmalig installiert, und Sie laden dann die serverseitige **Konfiguration** für Ihre Apps, für Ressourcensicherheit oder für den Push-Service auf den Server hoch. Sie können die Konfiguration Ihrer Apps in der
{{ site.data.keys.mf_console }} modifizieren. Sie können auch ein Befehlszeilentool oder die Server-REST-API verwenden, um eine neue **Konfigurationsdatei** für Ihre Apps hochzuladen. 

MobileFirst-Projekte gibt es nicht mehr. Sie entwickeln Ihre mbile App nun in der Entwicklungsumgebung Ihrer Wahl. Die Serverseite Ihrer Anwendung entwickeln Sie separat in Java oder JavaScript. Adapter können Sie mit
Apache Maven oder einer Maven-fähigen IDE wie Eclipse, IntelliJ und anderen entwickeln. 

In den Vorgängerversionen wurden Anwendungen implementiert, indem eine .wlapp-Datei
auf den Server hochgeladen wurde. Die Datei enthielt beschreibende Daten für die Anwendung und im Falle von Hybridanwendungen die
Webressourcen. In Version 8.0 wird die
.wlapp-Datei durch eine JSON-Anwendungsdeskriptordatei für die Registrierung einer App beim Server
ersetzt. Für Cordova-Anwendungen, die die direkte Aktualisierung verwenden, müssen Sie keine neue Version der
.wlapp-Datei auf den Server hochladen, sondern ein Webressourcenarchiv.

Wenn Sie Ihre App entwickeln,
verwenden Sie für viele Aufgaben die {{ site.data.keys.mf_cli }}, z. B.
zum Regstrieren einer App beim Zielserver oder zum Hochladen der serverseitigen Konfiguration. 

### Weggefallene Features und Ersetzungspfad
{: #discontinued-features-and-replacement-path}
{{ site.data.keys.product }} Version
8.0.0
ist im Vergleich zur Vorgängerversion stark vereinfacht. Ein Ergebnis dieser Vereinfachung ist, dass einige Features aus Version 7.1 in
Version 8.0 wegfallen. 

> Weitere Informationen zu weggefallenen Features und zum Ersetzungspfad finden Sie unter
[In Version 8.0 weggefallene und nicht mehr enthaltene
Features](../product-overview/release-notes/deprecated-discontinued). ## Cordova- oder Hybridanwendung umstellen
{: #migrating-a-cordova-or-hybrid-application }
Sie können die Entwicklung von Cordova-Apps mit dem
Apache-Cordova-Befehlszeilentool oder in einer Cordova-fähigen IDE wie Visual
Studio Code, Eclipse, IntelliJ und anderen beginnen. 

Fügen Sie Unterstützung für die {{ site.data.keys.product_adj }}-Features hinzu, indem Sie die {{ site.data.keys.product_adj }}-Plug-ins zu Ihrer App hinzufügen. Weitere Informationen zu den Unterschieden zwischen Cordova- oder Hybrid-Apps von Version 7.1 und Cordova-Apps von Version
8.0 finden Sie unter [Vergleich von
in Version 8.0 und bis Version 7.1 entwickelten Cordova-Apps](migrating-client-applications/cordova/#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before).

Für die Migration einer Cordova- oder Hybrid-App sind folgende Schritte erforderlich: 

* Führen Sie für Ihre Planung das Unterstützungstool für die Migration für Ihr vorhandenes Projekt aus. Sehen Sie sich den generierten Bericht an und schätzen Sie den für die Migration erforderlichen
Aufwand ein. Weitere Informationen finden Sie unter
[Migration einer
Cordova-App mit dem Unterstützungstool für die Migration starten](migrating-client-applications/cordova/#starting-the-cordova-app-migration-with-the-migration-assistance-tool).
* Ersetzen Sie die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0.0 enthalten sind. Eine Liste der API-Änderungen finden Sie unter
[Upgrade für WebView](migrating-client-applications/cordova/#upgrading-the-webview).
* Sie müssen den Aufruf von Clientressourcen ändern, die das klassische Sicherheitmodell verwenden. Verwenden Sie beispielsweise die API
`WLResourceRequest` anstelle der nicht weiter unterstützten API `WL.Client.invokeProcedure`. 
* Wenn Sie die direkte Aktualisierung verwenden, lesen Sie die Informationen unter
[Direkte Aktualisierung umstellen](migrating-client-applications/cordova/#migrating-direct-update).
* Weitere Informationen zur Umstellung von
Cordova- oder Hybrid-Apps finden Sie unter
[Vorhandene Cordova- und Hybridanwendungen umstellen](migrating-client-applications/cordova).

> **Hinweis:** Für die Migration der Unterstützung für Push-Benachrichtigungen sind sowohl auf der Clientseite als auch auf der Serverseite Änderungen notwendig, die weiter unten im Abschnitt
"Unterstützung für Push-Benachrichtigungen umstellen" beschrieben sind.

## Native Anwendung umstellen
{: #migrating-a-native-application }
Für die Migration einer nativen Anwendung sind folgende Schritte erforderlich: 

* Führen Sie für Ihre Planung das Unterstützungstool für die Migration für Ihr vorhandenes Projekt aus. Sehen Sie sich den generierten Bericht an und schätzen Sie den für die Migration erforderlichen
Aufwand ein. 
* Aktualisieren Sie Ihr Projekt, damit es das SDK von {{ site.data.keys.product }} Version 8.0 verwendet. 
* Ersetzen Sie die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. Das Unterstützungstool für die
Migration kann Ihren Code scannen und Berichte zu den zu ersetzenden APIs generieren. 
* Sie müssen den Aufruf von Clientressourcen ändern, die das klassische Sicherheitmodell verwenden. Verwenden Sie beispielsweise
die API `WLResourceRequest` anstelle der nicht weiter unterstützten API
`invokeProcedure`. 
    * Weitere Informationen zur Umstellung von
nativen iOS-Apps finden Sie unter
[Vorhandene native iOS-Anwendungen umstellen](migrating-client-applications/ios).
    * Weitere Informationen zur Umstellung von
nativen Android-Apps finden Sie unter
[Vorhandene native Android-Anwendungen umstellen](migrating-client-applications/android).
    * Weitere Informationen zur Umstellung von
nativen Windows-Apps finden Sie unter
[Vorhandene native Windows-Anwendungen umstellen](migrating-client-applications/windows).

> **Hinweis:** Für die Migration der Unterstützung für Push-Benachrichtigungen sind sowohl auf der Clientseite als auch auf der Serverseite Änderungen notwendig, die weiter unten im Abschnitt [Unterstützung für Push-Benachrichtigungen umstellen](#migrating-push-notifications-support) beschrieben sind.

## Adapter und Sicherheit umstellen
{: #migrating-adapters-and-security }
Ab Version 8.0 sind Adapter Maven-Projekte. Das {{ site.data.keys.product_adj }}-Sicherheitsframework basiert auf
OAuth, Sicherheitsbereichen und Sicherheitsüberprüfungen. Sicherheitsbereiche definieren die Sicherheitsanforderungen für den Zugriff auf eine Ressource. Sicherheitsüberprüfungen definieren, wie eine
Sicherheitsanforderung überprüft wird. Sicherheitsüberprüfungen werden als Java-Adapter geschrieben. Praktische Erfahrungen mit Adaptern und dem Thema
Sicherheit können Sie mithilfe der Lernprogramme
[Java- und JavaScript-Adapter erstellen](../adapters/creating-adapters)
und
[Autorisierungskonzepte](../authentication-and-security)
sammeln. 

{{ site.data.keys.mf_server }} arbeitet nur im
sitzungsunabhängigen Modus, und Adapter dürfen einen Zustand nicht lokal in einer Java Virtual Machine (JVM) speichern. 

Sie können Eigenschaften von Adpatern
externalisieren, um die Adapter für den Kontext, in dem sie ausgeführt werden sollen, zu konfigurieren, z. B. für einen Test- oder Produktionsserver. Die Werte dieser Eigenschfaten sind jedoch nicht mehr in einer
Eigenschaftendatei oder Projekt-WAR-Datei enthalten. Sie definieren Sie vielmehr
in der {{ site.data.keys.mf_console }} oder mithilfe eines Befehlszeilentools oder einer
Server-REST-API. 

* Weitere Informationen zur Umstellung von Adaptern finden Sie unter
[Vorhandene Adapter auf {{ site.data.keys.mf_server }} Version 8.0 umstellen](migrating-adapters). 
* Weitere Informationen zu Änderungen der serverseitigen APIs finden Sie unter
[Änderungen der serverseitigen API in Version 8.0](../product-overview/release-notes/deprecated-discontinued/#server-side-api-changes). 
* Eine Einführung in die Entwicklung von Adaptern mit
Apache Maven finden Sie unter
[Adapter als Apache-Maven-Projekte](../adapters).
* Weitere Informationen zur Umstellung der Authentifizierung und der Sicherheit finden Sie unter
[Authentifizierung und Sicherheit auf {{ site.data.keys.product_adj }} Version 8.0 umstellen](migrating-security). 

## Unterstützung für Push-Benachrichtigungen umstellen
{: #migrating-push-notifications-support }
Das auf Ereignisquellen basierende Modell wird nicht mehr unterstützt. Verwenden Sie stattdessen die tagbasierte Benachrichtigung. Weitere Informationen zur Umstellung der
Push-Benachrichtigungen für Ihre Client-Apps und serverseitigen Komponenten
finden Sie unter [Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen](migrating-push-notifications) und
[Migrationsszenarien](migrating-push-notifications/#migration-scenarios).

Ab Version 8.0 können Sie den Push-Service auf der Serverseite konfigurieren. Die Push-Zertifikate werden auf dem Server gespeichert. Sie können Sie in der
{{ site.data.keys.mf_console }} definieren oder das Hochladen von Zertifikaten mit einem Befehlszeilentool oder der Push-Service-REST-API
automatisieren. Außerdem können Sie Push-Benachrichtigungen von der
{{ site.data.keys.mf_console }} aus senden.

Der Push-Service wird durch das OAuth-Sicherheitsmodell geschützt. Sie müssen serverseitige Komponenten, die die Push-Service-REST-API nutzen, als
vertrauliche Clients von {{ site.data.keys.mf_server }} konfigurieren. 

### Datenmigrationstool für Push-Benachrichtigungen
{: #push-notifications-data-migration-tool }
Es steht ein Datenmigrationstool für Push-Benachrichtigungen zur Verfügung. Das Migrationstool vereinfacht
die Umstellung von Push-Daten von MobileFirst Platform Foundation 7.1 (Geräte, Benutzerabonnements,
Berechtigungsnachweise und Tags) auf {{ site.data.keys.product }} 8.0.

> [Informieren Sie sich über das Migrationstool](migrating-push-notifications/#migration-tool).

## Änderungen bei den Serverdatenbanken und der Serverstruktur
{: #changes-in-the-server-databases-and-in-the-server-structure }
{{ site.data.keys.mf_server }} ermöglicht Änderungen
an der App-Sicherheit, der Konnektivität und an Push-Operationen, ohne dass eine Codeänderung, ein neuer App-Build oder eine erneute Implementierung
notwendig ist. Allerdings bringen diese Änderungen auch Änderungen an den Datenbankschemata, an den in der Datenbank gespeicherten Daten und am Installationsprozess
mit sich. 

Aufgrund dieser Änderungen
gibt es in der {{ site.data.keys.product }} keine automatisierten Scripts für die Umstellung
Ihrer Datenbanken von einer früheren Version auf Version 8.0.0 oder für die Aktualisierung
einer vorhandenen Serverinstallation. Wenn Sie neue Versionen Ihrer Apps auf Version 8.0.0 umstellen möchten, müssen Sie einen neuen
Server installieren, den Sie neben Ihrem bsiherigen Server ausführen können. Führen Sie dann ein Upgrade für Ihre Apps und Adapter auf
Version 8.0.0
durch und implementieren Sie sie im neuen Server. 

## Mobile Daten in Cloudant speichern
{: #storing-mobile-data-in-cloudant }
Das speichern mobiler Daten in Cloudant mit dem IMFData-Framework oder dem
CloudantToolkit wird nicht mehr unterstützt. Informationen zu einer alternativen API finden Sie unter [Apps umstellen, die mobile
Daten mit IMFData oder
dem Cloudant-SDK in Cloudant speichern](migrating-data).

## Fixpack auf {{ site.data.keys.mf_server }} anwenden
{: #applying-a-fix-pack-to-mobilefirst-server }
Hier erfahren Sie,
wie Sie das Server Configuration Tool
für ein Upgrade von
{{ site.data.keys.mf_server }} Version 8.0.0 auf ein Fixpack oder einen vorläufigen Fix
verwenden können. Wenn Sie {{ site.data.keys.mf_server }} mit Ant-Tasks installiert haben, können Sie das
Fixpack oder den vorläufigen Fix auch mit Ant-Tasks anwenden. 

Wählen Sie den für Ihre Erstinstallationsmethode passenden Artikel aus,
um einen vorläufigen Fix oder ein Fixpack für {{ site.data.keys.mf_server }}
anzuwenden: 

* [Fixpack
oder vorläufigen Fix mit dem Server Configuration Tool anwenden](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-server-configuration-tool)
* [Fixpack
mit Ant-Dateien anwenden](../installation-configuration/production/appserver/#applying-a-fix-pack-by-using-the-ant-files)
