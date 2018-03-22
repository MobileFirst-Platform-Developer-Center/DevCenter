---
layout: tutorial
title: Wichtigste Leistungsmerkmale des Produkts
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }}
stellt Funktionen für Entwicklung, Tests,
Back-End-Verbindungen, Push-Benachrichtigungen, Offlinemodus, Aktualisierung, Sicherheit, Analyse, Überwachung und für die Veröffentlichung von Anwendungen
bereit.

### Entwicklung
{: #deployment }
Mit der {{ site.data.keys.product }}
verfügen Sie über ein Framework
für die Entwicklung, Optimierung, Integration und Verwaltung sicherer mobiler Anwendungen (Apps). Die {{ site.data.keys.product }}
führt keine
proprietäre Programmiersprache und kein proprietäres Modell ein, mit denen sich Benutzer erst vertraut machen müssten. 

Sie können HTML5, CSS3 und JavaScript für die App-Entwicklung verwenden.
Sie haben die Möglichkeit,
nativen Code
(Java oder Objective-C) zu schreiben. Die
{{ site.data.keys.product }}
stellt ein SDK mit Bibliotheken bereit, auf die Sie vom nativen Code aus
zugreifen können.

#### Unterstützte Plattformen
{: #supported-platforms }
Die SDKs der {{ site.data.keys.product }} unterstützen folgende Plattformen: 

* iOS
* Android
* Windows Universal 8.1 und Windows 10 UWP
* Web-Apps

### Back-End-Verbindungen
{: #back-end-connections }
Einige mobile Anwendungen werden nur offline (d. h. ohne Verbindung zu einem Back-End-System) ausgeführt.
Die meisten mobilen Anwendungen stellen jedoch eine Verbindung zu vorhandenen Unternehmensservices her, um die kritischen Benutzerfunktionen bereitstellen
zu können. Kunden können eine mobile Anwendung beispielsweise nutzen, um jederzeit und unabhängig von Öffnungszeiten online einzukaufen. Die Aufträge müssen in jedem Fall von der vorhandenen
E-Commerce-Plattform des Onlinegeschäfts verarbeitet werden. Für den gemeinsamen Einsatz von mobilen Anwendungen und Unternehmensservices
müssen Sie Middleware verwenden, z. B. ein mobiles Gateway. Die
{{ site.data.keys.product }}
kann als eine solche
Middleware-Lösung genutzt werden und die Kommunikation mit Back-End-Services vereinfachen.

### Push-Benachrichtigungen
{: #push-notifications }
Mit Push-Benachrichtigungen können Unternehmensanwendungen Informationen an mobile Geräte senden, auch wenn die
Anwendungen nicht genutzt werden. Die
{{ site.data.keys.product }}
stellt ein einheitliches
Benachrichtigungsframework als konsistenten Mechanismus für solche Push-Benachrichtigungen bereit. Angesichts der Tatsache, dass jede mobile Plattform ein anderes
Verfahren für Push-Benachrichtigungen nutzt, können Sie mithilfe dieses einheitlichen Benachrichtigungsframeworks
Push-Benachrichtigungen senden, ohne die Details der einzelnen adressierten Geräte oder Plattformen zu kennen.

### Offlinemodus
{: #offline-mode }
Unter dem Gesichtspunkt der Konnektivität können mobile Anwendungen offline, online oder im gemischten Modus
arbeiten. Die
{{ site.data.keys.product }} nutzt eine Client-Server-Architektur, die
erkennen kann, ob ein Gerät mit dem Netz verbunden ist und welche Qualität diese Verbindung hat. In ihrer Funktion als Clients versuchen
mobile Anwendungen
regelmäßig, eine Verbindung zum Server herzustellen und die Stabilität der Verbindung zu beurteilen. Bei mangelnder Konnektivität kann eine mobile Anwendung genutzt werden,
die offline ausgeführt werden kann. Einige Funktionen können dann jedoch eingeschränkt sein. Wenn Sie eine mobile Anwendung für den Offlinebetrieb erstellen, ist es hilfreich, Informationen zu dem mobilen Gerät
zu speichern, damit die Funktionalität im Offlinemodus erhalten bleibt. Diese Informationen kommen in der Regel von einem Back-End-System.
Sie müssen die Datensynchronisation mit dem Back-End-System daher als Teil der Anwendungsarchitektur berücksichtigen. In der
{{ site.data.keys.product }} gibt es ein Feature für
das Austauschen und Speichern von Daten
mit der Bezeichnung
JSONStore.
Mit diesem
Feature können Sie Datensätze in einer Datenquelle erstellen, lesen, aktualisieren und löschen. Im Offlinebetrieb werden die einzelnen Operationen
in eine Warteschlange gestellt.
Sobald eine Verbindung hergestellt ist, wird die Operation zum Server übertragen und dann für die Quellendaten ausgeführt.

### Aktualisierung
{: #update }
Die {{ site.data.keys.product }} vereinfacht das Versionsmanagement und die Kompatibilität
mobiler Anwendungen. Immer, wenn ein Benutzer eine mobile Anwendung startet, kommuniziert die Anwendung mit einem Server. Im Kontakt zu diesem Server kann die {{ site.data.keys.product }} feststellen, ob eine neuere
Version der Anwendung verfügbar ist und den Benutzer ggf. darüber informieren oder mittels Push-Operation eine Aktualisierung der Anwendung auf dem Gerät
durchführen.
Der Server kann auch ein Upgrade auf die neueste Version einer Anwendung forcieren, um die Weiterverwendung einer veralteten
Version zu verhindern.

### Sicherheit
{: #security }
Der Schutz vertraulicher und privater Daten ist für alle Anwendungen in einem Unternehmen kritisch. Dies gilt
auch für mobile Anwendungen. Die mobile Sicherheit greift auf mehreren Ebenen, z. B. auf der Ebene der mobilen Anwendung, der Ebene mobiler Anwendungsservices oder
der Ebene von Back-End-Services. Sie müssen für den Schutz der Privatsphäre Ihrer Kunden sorgen und verhindern, dass nicht berechtigte Benutzer
auf vertrauliche Daten zugreifen. Bei mobilen Geräten, die in Privatbesitz sind, erfolgt die Kontrolle z. B. durch das Betriebssystem für mobile Geräte und
damit auf etwas niedrigerem Sicherheitsniveau.

Die
{{ site.data.keys.product }} ermöglicht eine
sichere End-to-End-Kommunikation mit einem Server, der den Datenfluss zwischen der mobilen Anwendung und Ihren Back-End-Systemen überwacht. Mit der
{{ site.data.keys.product }} haben Sie die Möglichkeit,
angepasste Sicherheits-Handler für jeglichen Zugriff auf diesen Datenfluss zu definieren. Da bei jedem Zugriff auf Daten einer mobilen Anwendung diese Serverinstanz passiert wird, können Sie unterschiedliche Sicherheits-Handler für mobile Anwendungen, Webanwendungen
und den Back-End-Zugriff festlegen.
Durch diese Differenzierung können Sie für verschiedene Funktionen Ihrer mobilen Anwendung separate Authentifizierungsstufen
definieren oder den Zugriff einer mobilen Anwendung auf sensitive Daten unterbinden.

### Analytics
{: #analytics }
Mit dem Feature {{ site.data.keys.mf_analytics }} können Sie Apps, Services, Geräte und andere Quellen durchsuchen, um Daten zur Nutzung
zu erfassen oder Probleme zu erkennen.

Neben zusammenfassenden Berichten über App-Aktivitäten stellt
die {{ site.data.keys.product }} eine skalierbare Plattform für Betriebsanalyse bereit, auf die
über die {{ site.data.keys.mf_console }} zugegriffen werden kann.
Mit dem {{ site.data.keys.mf_analytics_short }}-Feature können Unternehmen
von Geräten, Apps und Servern erfasste Protokolle und Ereignisse durchsuchen, um Muster und Probleme zu finden und Statistiken zur Plattformnutzung
zu erstellen. Sie können ganz nach Bedarf die Analyse und/oder Berichte aktivieren.

### Überwachung
{: #monitoring }
In der {{ site.data.keys.product }} gibt es eine Reihe
von Verfahren für Betriebsanalysen und die Erstellung von Berichten, mit denen Sie Daten
Ihrer
MobileFirst-Foundation-Anwendungen und -Server sammeln, anzeigen und analysieren und den Serverzustand
überwachen können. 

### Anwendungen veröffentlichen
{: #application-publishing }
Das {{ site.data.keys.product }} Application Center
ist ein Speicher für Unternehmensanwendungen. Mit dem Application Center
steht Einzelpersonen und Gruppen in Ihrem Unternehmen ein Repository mobiler Anwendungen zur Verfügung, das Sie installieren, konfigurieren und verwalten
können. Sie steuern, welche Personen in Ihrer Organisation Zugriff auf das Application
Center haben und Anwendungen in das Application-Center-Repository hochladen können und
welche Personen diese Anwendungen herunterladen und auf einem mobilen Gerät installieren dürfen.
Über das Application Center können Sie auch Rückmeldungen von
Benutzern und Zugriffsinformationen von Geräten, auf denen Anwendungen installiert sind, erfassen.

Das Konzept des Application Center ist mit dem öffentlichen
App Store von Apple oder dem Google Play Store vergleichbar. Im Unterschied zu den genannten Stores ist das Application Center jedoch
auf den Entwicklungsprozess ausgerichtet. 

In dem vom Application Center bereitgestellten Repository können Dateien mobiler Anwendungen gespeichert werden.
Mit einer webbasierten Konsole kann das Repository verwaltet werden. Mit der außerdem vom Application Center zur Verfügung gestellten mobilen Clientanwendung
können Benutzer den Katalog der im Application Center gespeicherten Anwendungen ansehen, Anwendungen installieren, Feedback für das Entwicklerteam geben und
Produktionsanwendungen für IBM Endpoint Manager zugänglich machen. Der
Application-Center-Zugriff mit dem Ziel, Anwendungen herunterzuladen und zu installieren, wird über Zugriffskontrolllisten gesteuert.
