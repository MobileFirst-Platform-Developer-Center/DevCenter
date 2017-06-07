---
layout: tutorial
title: Bekannte Probleme und Einschränkungen
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Bekannte Probleme
{: #known-issues }
Klicken Sie auf den folgenden Link, um eine dynamisch generierte Liste mit Dokumenten für dieses konkrete Release und alle zugehörigen Fixpacks zu empfangen.
Die Dokumente enthalten auch Angaben zu bekannten Problemen mit den entsprechenden Lösungen sowie zu relevanten Downloads:
[http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0](http://www.ibm.com/support/search.wss?tc=SSVNUQ&tc=SSHT2F&atrn=SWVersion&atrv=8.0).


## Bekannte Einschränkungen
{: #known-limitations }
Die Beschreibung der bekannten Einschränkungen in der
{{ site.data.keys.product_full }}
finden Sie an verschiedenen Stellen der Dokumentation: 

* Wenn eine bekannte Einschränkung für ein bestimmtes Feature gilt, steht die Beschreibung in dem Artikel, in dem dieses Feature
erklärt ist.
Sie können dort sofort nachlesen, wie sich die Einschränkung auf das Feature auswirkt.
* Handelt es sich um eine bekannte allgemeine Einschränkung, also eine Einschränkung, die in unterschiedlichen Artikeln erwähnt werden müsste oder für die
es möglicherweise keinen speziellen Artikel gibt, finden Sie die Beschreibung der Einschränkung hier.

### Globalisierung
{: #globalization }
Falls Sie für den internationalen Einsatz geeignete Apps entwickeln, gelten die folgenden
Einschränkungen: 

* Partielle Übersetzung: Teile des Produkts {{ site.data.keys.product }} Version 8.0 und der Dokumentation
sind in die folgenden Sprachen übersetzt: vereinfachtes Chinesisch, traditionelles Chinesisch,
Französisch, Deutsch, Italienisch, Japanisch, Koreanisch,
brasilianisches Portugiesisch, Russisch und Spanisch. Übersetzt sind Texte, die dem Benutzer angezeigt werden.
* BIDI-Unterstützung: Die von der {{ site.data.keys.product }} generierten Anwendungen sind nicht voll
BIDI-fähig. Standardmäßig erfolgt keine Spiegelung von Elementen der grafischen Benutzerschnittstelle und keine Steuerung der
Textrichtung. Generierte Anwendungen sind jedoch nicht fest an diese Einschränkung gebunden. Entwickler können durch manuelle Anpassungen im generierten Code
eine vollständige BIDI-Nutzung erreichen. 

Obwohl für die Kernfunktionen der {{ site.data.keys.product }} die Übersetzung
ins Hebräische möglich ist, werden einige Elemente der grafischen Benutzerschnittstelle nicht gespiegelt. 

* Beschränkungen für Adapternamen: Namen von Adaptern müssen für die Erstellung von Java-Klassennamen gültige Namen sein. Sie dürfen nur die folgenden Zeichen enthalten: 
    * Groß- und Kleinbuchstaben (A-Z und a-z)
    * Ziffern (0-9)
    * Unterstreichungszeichen (_)

* Unicode-Zeichen: Unicode-Zeichen, die nicht zur mehrsprachigen Basisebene gehören, werden nicht unterstützt.
* Sprachliche Unterscheidung und Unicode-Normalisierungsformen: In folgenden Anwendungsfällen werden bei der Abfrage
im Gegensatz zu einem normalen Abgleich keine
sprachlichen Unterscheidungen, z. B. die Verwendung von Akzenten, die Unterscheidung der Groß-/Kleinschreibung und die Darstellung von Umlauten durch zwei Zeichen,
berücksichtigt, damit die Suchfunktion in verschiedenen Sprachen ordnungsgemäß ausgeführt werden kann und die Datensuche nicht die Normalisierungsform C (NFC) verwendet. 
    * In der {{ site.data.keys.mf_analytics_console }}, wenn Sie für ein kundenspezifisches Diagramm einen angepassten Filter
erstellen. Die Nachrichteneigenschaft in dieser Konsole verwendet allerdings die Normalisierungsform C
(NFC) und berücksichtigt sprachliche Unterscheidungen. 
    * In der {{ site.data.keys.mf_console }}, wenn Sie auf der Seite
"Anwendungen durchsuchen" nach einer Anwendung, auf der Seite
"Adapter durchsuchen" nach einem Adapter, auf der Seite "Push" nach einem Tag oder auf der Seite
"Geräte" nach einem Gerät suchen
    * In den Suchfunktionen für die JSONStore-API

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
Für
{{ site.data.keys.mf_analytics }} gelten die folgenden
Einschränkungen: 

* Sicherheitsanalysen (d. h. Daten zu Anforderungen, die die Sicherheitsüberprüfungen nicht bestehen) werden nicht unterstützt. 
* In der {{ site.data.keys.mf_analytics_console }} folgt das
Zahlenformat nicht den ICU-Regeln (International
Components for Unicode).
* Zahlen in der {{ site.data.keys.mf_analytics_console }} verwenden nicht das bevorzugte Zahlenscript des Benutzers. 
* Daten, Zeiten und Zahlen werden in der {{ site.data.keys.mf_analytics_console }} entsprechend der Spracheinstellung des Betriebssystems und
unabhängig von der Ländereinstellung von
Microsoft Internet
Explorer angezeigt.
* Wenn Sie einen kundenspezifischen Filter für ein kundenspezifisches Diagramm erstellen, müssen die numerischen Daten
in westlichen (Base 10) oder europäischen Ziffern (0,
1, 2, 3, 4, 5, 6, 7, 8, 9) angegeben werden. 
* Wenn Sie auf der Seite "Alert-Management" der {{ site.data.keys.mf_analytics_console }}
einen kundenspezifischen Filter für ein kundenspezifisches Diagramm erstellen, müssen die numerischen Daten
in westlichen (Base 10) oder europäischen Ziffern (0,
1, 2, 3, 4, 5, 6, 7, 8, 9) angegeben werden. 
* Die Seite "Analytics" der {{ site.data.keys.mf_console }} unterstützt
die folgenden
Browser: 
    * Microsoft Internet
Explorer ab Version 10
    * Mozilla Firefox ESR oder eine aktuellere Version
    * Apple Safari für iOS ab Version 7.0 
    * Neueste Version von Google Chrome
* Das Analytics-Client-SDK ist nicht für Windows verfügbar.


### Mobiler IBM MobileFirst-Foundation-Application-Center-Client
{: #ibm-mobilefirst-foundation-application-center-mobile-client }
Der mobile Application-Center-Client
folgt den kulturellen Konventionen des aktiven Geräts, z. B. bezüglich des Datumsformats. Die
strengeren ICU-Regeln (International Components for Unicode) werden nicht in jedem Fall befolgt.

### {{ site.data.keys.mf_console_full }}
{: #ibm-mobilefirst-operations-console }
Für {{ site.data.keys.mf_console }} gelten die folgenden
Einschränkungen: 

* Sie unterstützt nur teilweise bidirektionale Sprachen. 
* Wenn Benachrichtigungen an ein Android-Gerät gesendet werden, kann die Textrichtung nicht geändert werden. 
    * Werden die ersten Buchstaben in einer von rechts nach links geschriebenen Sprache wie Arabisch oder Hebräisch eingegeben, hat automatisch der gesamte Text diese Ausrichtung. 
    * Werden die ersten Buchstaben in einer von links nach rechts geschriebenen Sprache eingegeben, hat automatisch der gesamte Text diese Ausrichtung. 
* Zeichenfolge und Textausrichtung von bidirektionalen Sprachen entsprechen nicht den kulturellen Gewohnheiten. 
* Numerische Werte in den numerischen Feldern werden nicht nach den Formatierungsregeln der Ländereinstellung ausgewertet. In der Konsole werden formatierte Zahlen angezeigt,
als Eingabe jedoch nur unformatierte Zahlen akzeptiert, z. B.
1000 und nicht 1 000 oder 1.000.
* Die Antwortzeiten
auf der Seite "Analytics" der
{{ site.data.keys.mf_console }} hängen
von mehreren Faktoren ab, z. B. von der Hardware (Arbeitsspeicher, CPUs), der Menge aufgelaufener Analysedaten und
vom MobileFirst-Analytics-Clustering. Sie sollten Ihre Auslastung testen, bevor Sie
{{ site.data.keys.mf_analytics }} in
der Produktion einführen. 

### Server Configuration Tool
{: #server-configuration-tool }
Für das Server Configuration Tool gelten die folgenden
Einschränkungen:

* Der beschreibende Name einer Serverkonfiguration darf nur Zeichen des Systemzeichensatzes enthalten. Unter Windows ist dies der
ANSI-Zeichensatz. 
* Kennwörter, die Anführungszeichen oder Apostrophe enthalten, funktionieren möglicherweise nicht ordnungsgemäß. 
* Für die Konsole des Server
Configuration Tool gelten dieselben Globalisierungseinschränkungen wie für die
Anzeige von Zeichenfolgen, die über die Standardcodepage hinausgehende Zeichen enthalten,
in der Windows-Konsole. 

Darüber hinaus könnten Sie unter dem Gesichtspunkt der Globalisierung Einschränkungen oder
Besonderheiten feststellen, die auf Einschränkungen bei anderen Produkten zurückzuführen sind, z. B. bei
verwendeten Browsern, Datenbankmanagementsystemen oder Software Development Kits. Beispiel: 

* Sie dürfen den Benutzernamen und das Kennwort für das Application
Center nur mit ASCII-Zeichen definieren.
Diese Einschränkung
gilt, weil WebSphere Application Server (Full Profile oder
Liberty Profile)
nur Kennwörter und Benutzernamen unterstützt, die ausschließlich aus ASCII-Zeichen
bestehen (siehe "Für Benutzer-IDs und Kennwörter gültige Zeichen"). 
* Windows:
    * Wenn Sie in der Protokolldatei des
Testservers lokalisierte Nachrichten sehen möchten, müssen Sie die
Protokolldatei mit der Codierung UTF-8 öffnen.
    * Diese Einschränkungen haben folgende Ursachen: 
        * Der Testserver
wird in WebSphere Application Server Liberty Profile
installiert. In diesem Anwendungsserver wird die Protokolldatei generell mit ANSI-Codierung erstellt. Dies gilt mit Ausnahme der lokalisierten Nachrichten, für die die Codierung
UTF-8 verwendet wird.

* In Java 7.0 Service Refresh
4-FP2 und Vorgängerversionen können Sie Unicode-Zeichen, die nicht zur
mehrsprachigen Basisebene gehören, nicht in das Eingabefeld kopieren.
Vermeiden Sie dieses Problem, indem Sie den Ordnerpfad manuell erstellen und den Ordner dann während der Installation
auswählen. 
* Angepasste Titel und Schaltflächennamen für die Methoden "alert", "confirm" und "prompt" müssen Sie kurzhalten, um zu verhindern, dass sie am Anzeigerand
abgeschnitten werden. 
* Der JSONStore kann keine Normalisierung durchführen. Die Find-Funktionen der JSONStore-API berücksichtigen keine
sprachlichen Unterscheidungen, z. B. die Verwendung von Akzenten, die Unterscheidung der Groß-/Kleinschreibung und die Darstellung von Umlauten durch zwei Zeichen. 

### Adapter und Abhängigkeiten von Produkten anderer Anbieter
{: #adapters-and-third-party-dependencies }
Bei Interaktionen zwischen Abhängigkeiten und Klassen im Anwendungsserver, einschließlich der gemeinsam genutzten
{{ site.data.keys.product_adj }}-Bibliothekn, treten die folgenden bekannten Probleme auf. 

#### Apache HttpClient
{: #apache-httpclient }
Die {{ site.data.keys.product }} verwendet intern
Apache HttpClient. Wenn Sie eine Apache-HttpClient-Instanz als Abhängigkeit zu einem Java-Adapter hinzufügen, funktionieren im Adapter die folgenden APIs nicht ordnungsgemäß:
`AdaptersAPI.executeAdapterRequest`,
`AdaptersAPI.getResponseAsJSON` und
`AdaptersAPI.createJavascriptAdapterRequest`. Das liegt daran, dass die APIs
Apache-HttpClient-Typen in ihrer Signatur enthalten. Umgehen Sie das Problem, indem Sie den internen Apache HttpClient
verwenden, den Abhängigkeitsbereich in der Datei **pom.xml** jedoch ändern.

#### Bouncy Castle Cryptographic Library
{: #bouncy-castle-cryptographic-library }
Die {{ site.data.keys.product }} verwendet selbst
Bouncy Castle. Unter Umständen ist es möglich, im Adapter eine andere Version von Bouncy Castle zu verwenden. Die Folgen müssen jedoch gründlich getestet werden.
Manchmal füllt der {{ site.data.keys.product_adj }}-Bouncy-Castle-Code bestimmte
statische Singleton-Felder der `javax.security`-Paketklassen und hindert damit die in einem Adapter verwendete
Bouncy-Castle-Version daran, Funktionen zu nutzen, die auf diese Felder zurückgreifen. 

#### Implementierung von Apache-CXF-JAR-Dateien
{: #apache-cxf-implementaton-of-jar-files }
CXF wird in der {{ site.data.keys.product_adj }}-JAX-RS-Implementierung verwendet, sodass
Sie keine Apache-CXF-JAR-Dateien zu einem Adapter hinzufügen können. 

### Aktualisierungsprobleme des mobilen Application-Center-Clients unter
Android 4.0.x
{: #application-center-mobile-client-refresh-issues-on-android-40x}
Es ist bekannt, dass bei der WebView-Komponente von Android 4.0.x mehrere Aktualisierungsprobleme
auftreten. Wenn Sie für Geräte ein Upgrade auf Android 4.1.x durchführen, sollte eine Besserung
eintreten.

Wenn Sie den Application-Center-Client aus Quellen erstellen, sollte sich die Situation durch die Inaktivierung der
Hardwarebeschleunigung auf Anwendungsebene im
Android-Manifest unter
Android 4.0.x verbessern. Die Anwendung muss in dem Fall mit
Android SDK 11 oder einer neueren SDK-Version erstellt werden.

### Application Center erfordert MobileFirst Studio Version 7.1 für Import und Erstellung des mobilen Application-Center-Clients
{: #application-center-requires-mobilefirst-studio-v71-for-importing-and-building-the-application-center-mobile-client }
Für die Erstellung des mobilen Application-Center-Clients benötigen Sie MobileFirst Studio Version 7.1. Sie können
MobileFirst Studio von der Seite [Downloads]({{site.baseurl}}/downloads) herunterladen. Klicken Sie auf das Register
**Previous MobileFirst
Platform Foundation Releases**. Auf der Registerkarte finden Sie den Download-Link. Installationsanweisungen
finden Sie im IBM Knowledge Center für Version 7.1 unter
[MobileFirst
Studio installieren](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html). Weitere Informationen zur Erstellung des mobilen
Application-Center-Clilents finden Sie unter [Verwendung des mobilen Clients vorbereiten](../../../appcenter/preparations).

### Application Center und Microsoft Windows Phone 8.1
{: #application-center-and-microsoft-windows-phone-81 }
Das
Application Center unterstützt die Verteilung von Anwendungen in Form von Windows-Phone-Anwendungspaketdateien (.xap) für
Microsoft Windows Phone 8.0 und Microsoft Windows Phone 8.1. In Microsoft Windows Phone 8.1
hat Microsoft ein neues universelles Format für Anwendungspaketdateien (.appx) eingeführt.
Das
Application Center unterstützt zurzeit nicht die Verteilung von Anwendungspaketdateien (.appx) für Microsoft Windows Phone 8.1. Es ist auf
Windows-Phone-Anwendungspaketdateien (.xap) beschränkt. 

Das
Application Center unterstützt die Verteilung von Anwendungspaketdateien (.appx) nur für Microsoft Windows Store (Desktop-Anwendungen). 

### {{ site.data.keys.product_adj }}-Anwendungen mit Ant oder über die Befehlszeile verwalten
{: #administering-mobilefirst-applications-through-ant-or-through-the-command-line }
Wenn Sie nur
das {{ site.data.keys.mf_dev_kit_full }} herunterladen und installieren, ist das Tool **mfpadm** nicht verfügbar. Das Tool
mfpadm wird mit dem Installationsprogramm für
{{ site.data.keys.mf_server }} installiert. 

### Vertrauliche Clients
{: #confidential-clients }
Verwenden Sie für die IDs und geheimen Schlüssel vertraulicher Clients nur ASCII-Zeichen. 

### Direkte Aktualisierung
{: #direct-update }
In Version 8.0.0 wird die direkte Aktualisierung unter Windows nicht unterstützt.

### Einschränkungen für FIPS 140-2
{: #fips-104-2-feature-limitations }
Die folgenden bekannten Einschränkungen gelten für die Verwendung von
FIPS 140-2 in der {{ site.data.keys.product }}:
* Der Modus mit FIPS-140-2-Zulassung gilt nur für den Schutz (die Verschlüsselung) lokaler Daten im
JSONStore und den Schutz der HTTPS-Kommunikation zwischen einem {{ site.data.keys.product_adj }}-Client
und {{ site.data.keys.mf_server }}. 
    * Wenn der {{ site.data.keys.product_adj }}-Client und der
{{ site.data.keys.mf_server }} über HTTPS kommunizieren, werden die FIPS-140-2-Bibliotheken nur auf dem Client
verwendet. Für direkte Verbindungen zu anderen Servern oder Services werden keine
FIPS-140-2-Bibliotheken verwendet.
* Dieses Feature wird nur auf der iOS- und der Android-Plattform unterstützt.
    * Unter Android wird dieses Feature nur für Geräte oder Simulatoren unterstützt, die die Architektur x86 oder
armeabi verwenden.
Für
Android mit armv5- oder armv6-Architektur wird das Feature nicht unterstützt.
Das liegt daran, dass die verwendete OpenSSL-Bibliothek keine
FIPS-140-2-Zulassung für armv5 oder armv6 mit Android erhalten hat. Obwohl die
{{ site.data.keys.product_adj }}-Bibliothek
die 64-Bit-Architektur unterstützt, wird FIPS 140-2 von dieser Architektur nicht unterstützt. FIPS 140-2 kann auf 64-Bit-Geräten ausgeführt werden, wenn das Projekt nur
native 32-Bit-NDK-Bibliotheken enthält. 
    * Unter iOS wird das Feature für die i386-, x86_64-, armv7-, armv7s-
und arm64-Architektur unterstützt. 
* Dieses Feature funktioniert nur in Hybridanwendungen (nicht in nativen Anwendungen). 
* In nativem iOS ist FIPS standardmäßig über die iOS-FIPS-Bibliotheken aktiviert. Es ist keine Aktion zum Aktivieren von FIPS 140-2 erforderlich. 
* Die Verwendung des Features für Benutzerregistrierung auf dem Client wird von
FIPS 140-2 nicht unterstützt. 
* Das Application
Center (Client) bietet keine Unterstützung für FIPS 140-2. 

### Installation eines Fixpacks oder eines vorläufigen Fix
für das Application Center oder für {{ site.data.keys.mf_server }}
{: #installation-of-a-fix-pack-or-interim-fix-to-the-application-center-or-the-mobilefirst-server }
Wenn Sie auf das
Application Center oder auf {{ site.data.keys.mf_server }}
ein Fixpack oder eine vorläufige Korrektur anwenden,
sind manuelle Anpassungen erforderlich. Möglicherweise müssen Sie Ihre Anwendungen für einige Zeit schließen. 

### Architekturen mit JSONStore-Unterstützung
{: #jsonstore-supported-architectures }
Für
Android unterstützt JSONStore die folgenden Architekturen: ARM, ARMV7 und x86 (32 Bit). Andere Architekturen werden zurzeit nicht unterstützt.
Wenn Sie versuchen, andere Architekturen zu verwenden, können Ausnahmen und potenziell Anwendungsabstürze eintreten. 

JSON wird für native Windows-Anwendungen nicht unterstützt. 

### Einschränkungen für den Liberty-Server
{: #liberty-server-limitations }
Wenn Sie den
Liberty-Server mit JDK 7 (32 Bit) verwenden, wird Eclipse möglicherweise nicht gestartet.
Es kann sein, dass Sie folgenden Fehler empfangen: "Error
occurred during initialization of VM. Could not reserve enough space
for object heap. Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit."

Lösen Sie dieses Problem, indem Sie
für 64-Bit-Eclipse und 64-Bit-Windows das 64-Bit-SDK verwenden. Wenn Sie auf einem 64-Bit-Computer das
32-Bit-JDK verwenden, können Sie die JVM-Vorgaben
**mx512m** und **Xms216m** konfigurieren. 

### Einschränkungen für LTPA-Token
{: #ltpa-token-limitations }
Wenn ein LTPA-Token vor
der Benutzersitzung abläuft, tritt eine Ausnahme `SESN0008E` ein. 

Ein
LTPA-Token wird der aktuellen Benutzersitzung zugeordnet. Wenn die Sitzung vor dem LTPA-Token abläuft, wird automatisch eine neue Sitzung erstellt. Läuft das LTPA-Token jedoch vor der Benutzersitzung ab,
tritt die folgende Ausnahme ein: 

`com.ibm.websphere.servlet.session.UnauthorizedSessionRequestException: SESN0008E:
Ein als anonymous authentifizierter Benutzer hat versucht, auf eine Sitzung zuzugreifen, deren Eigner {Benutzername} ist.`

Angesichts dieser
Einschränkung müssen Sie das Ablaufen der Benutzersitzung beim Ablaufen des LTPA-Tokens erzwingen. 
* Setzen Sie in WebSphere Application Server Liberty
das httpSession-Attribut invalidateOnUnauthorizedSessionRequestException in der Datei server.xml
auf "true". 
* Fügen Sie in WebSphere Application Server
die angepasste Sitzungsmanagementeigenschaft InvalidateOnUnauthorizedSessionRequestException mit dem Wert
"true" hinzu, um das Problem zu lösen. 

**Hinweis:** In bestimmten Versionen von
WebSphere Application Server oder WebSphere Application Server Liberty
wird die Ausnahme noch protokolliert, obwohl die Sitzung ordnungsgemäß inaktiviert wurde.
Weitere Informationen finden Sie im [APAR PM85141](http://www.ibm.com/support/docview.wss?uid=swg1PM85141).

### Microsoft Windows Phone
8
{: #microsoft-windows-phone-8 }
Die Architektur x64 wird für Windows-Phone-8.1-Umgebungen nicht unterstützt. 

### Microsoft-Windows-10-Apps (universelle Windows-Plattform)
{: #microsoft-windows-10-uwp-apps }
Das Feature für die Anwendungsauthentizitätsfunktion funktioniert nicht für
{{ site.data.keys.product_adj }}-Windows-10-UWP-Apps, wenn
das {{ site.data.keys.product_adj }}-SDK mit dem
NuGet-Paket installiert wird. Als Ausweichmaßnahme können Entwickler das NuGet-Paket herunterladen und die Verweise auf das
{{ site.data.keys.product_adj }}-SDK
manuell hinzufügen. 

### Unvorhersehbare Ergebnisse bei Verwendung der CLI für verschachtelte Projekte
{: #nested-projects-can-result-in-unpredictable-results-with-the-cli }
Verschachteln Sie keine Projekte ineinander, wenn Sie die
{{ site.data.keys.mf_cli }} verwenden.
Es könnte sonst passieren, dass Sie nicht das erwartete Projekt bearbeiten. 

### Cordova-Webressourcen im
{{ site.data.keys.mf_mbs }} voranzeigen
{: #previewing-cordova-web-resources-with-the-mobile-browser-simulator }
Sie können Ihre Webressourcen im {{ site.data.keys.mf_mbs }} voranzeigen. Der Simulator unterstützt
jedoch nicht alle {{ site.data.keys.product_adj }}-JavaScript-APIs. Insbesondere das OAuth-Protokoll wird nicht vollständig unterstützt.
Sie können jedoch Adapteraufrufe mit `WLResourceRequest` testen.


### Physisches iOS-Gerät für Test der erweiterten App-Authentizität erforderlich
{: #physical-ios-device-required-for-testing-extended-app-authenticity }
Zum Testen der erweiterten App-Authentizität ist ein physisches iOS-Gerät erforderlich, weil eine
IPA-Datei nicht in einem iOS-Simulator installiert werden kann. 

### MobileFirst-Server-Unterstützung für Oracle 12c
{: #support-of-oracle-12c-by-mobilefirst-server }
Die
Installationstools für {{ site.data.keys.mf_server }} (Installation
Manager, Server Configuration Tool und
Ant-Tasks) unterstützen eine Installation mit Oracle 12c als Datenbank. 

Die Benutzer und Tabellen können von den Installationstools erstellt werden. Die Datenbanken müssen jedoch bereits vor Ausführung der Installationstools
vorhanden sein. 

### Untrestützung für Push-Benachrichtigungen
{: #support-for-push-notification }
Ungeschütztes Push wird in Cordova (unter iOS und Android) untertsützt.

### Cordova-iOS-Plattform aktualisieren
{: #updating-cordova-ios-platform }
Wenn Sie die Cordova-iOS-Plattform einer Cordova-App aktualisieren möchten, müssen Sie die Plattform deinstallieren und erneut installieren. Führen Sie dazu die folgenden Schritte aus: 

1. Navigieren Sie auf der Befehlszeilenschnittstelle zum Projektverzeichnis der App. 
2. Führen Sie den Befehl `cordova platform rm ios` aus, um die Plattform zu entfernen. 
3. Führen Sie den Befehl `cordova platform add ios@version` aus, um die neue Plattform zu der App hinzuzufügen. Hier steht "version" für die Version der Cordova-iOS-Plattform. 
4. Führen Sie den Befehl `cordova prepare` aus, um die Änderungen zu integrieren. 

Die Aktualisierung schlägt fehl, wenn Sie den Befehl `cordova platform update ios` verwenden. 

### Webanwendungen
{: #web-applications }
Für Webanwendungen gelten die folgenden Einschränkungen: 
- {: #web_app_limit_ms_ie_n_edge }
In Microsoft Internet Explorer (IE) und Microsoft Edge werden
App-Verwaltungsnachrichten und Client-Web-SDK-Nachrichten
entsprechend den Regions- und Formatvorgaben des Betriebssystems
und nicht gemäß den konfigurierten Vorgaben für die Anzeigesprache des Browsers oder Betriebssystems angezeigt
(siehe auch [Administratornachrichten
in mehreren Sprachen definieren](../../../administering-apps/using-console/#defining-administrator-messages-in-multiple-languages)). 

### WKWebView-Unterstützung für iOS-Cordova-Anwendungen
{: #wkwebview-support-for-ios-cordova-applications }
In
iOS-Cordova-Apps mit
WKWebView funktionieren unter Umständen die Features für App-Benachrichtigungen und direkte Aktualisierung nicht ordnungsgemäß. 

Diese Einschränkung
ist auf den Fehler
"file:// url XmlHttpRequests are not allowed in WKWebViewEgine"
in **cordova-plugin-wkwebview-engine** zurückzuführen.

Sie können dieses Problem umgehen, indem Sie in Ihrem Cordova-Projekt den folgenden Befehl ausführen:
`cordova plugin add https://github.com/apache/cordova-plugins.git#master:wkwebview-engine-localhost`. 

Wenn Sie diesen Befehl ausführen, wird ein lokaler Web-Server in Ihrer Cordova-Anwendung ausgeführt.
Im Anschluss können Sie Ihre lokalen Dateien bereitstellen
und aufrufen und müssen für die Arbeit mit lokalen Dateien nicht
das URI-Schema file:// verwenden. 

**Hinweis:** Dieses Cordova-Plug-in wird nicht in npm (Node Package Manager) veröffentlicht. 

### Cordova-Plug-in-Statusleiste (cordova-plugin-statusbar) funktioniert nicht in einer mit cordova-plugin-mfp geladenen Cordova-Anwendung
{: #cordova-plugin-statusbar-does-not-work-with-cordova-application-loaded-with-cordova-plugin-mfp }
Die Cordova-Plug-in-Statusleiste (cordova-plugin-statusbar) funktioniert nicht in einer mit cordova-plugin-mfp geladenen Cordova-Anwendung. 

Ein Entwickler kann dieses Problem umgehen, indem er
`CDVViewController` als Stammansichtencontroller festlegt. Dazu muss das Code-Snippet in der Methode
`wlInitDidCompleteSuccessfully` wie folgt in der Datei **MFPAppdelegate.m** des Cordova-iOS-Projekts ersetzt werden. 

Vorhandenes Code-Snippet: 

```objc
(void)wlInitDidCompleteSuccessfully
{ 
UIViewController* rootViewController = self.window.rootViewController;
// Cordova-Ansichtencontroller erstellen
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
// Rahmen der Ansicht des Cordova-Ansichtencontrollers an die Begrenzungen der übergeordneten Ansicht anpassen
cordovaViewController.view.frame = rootViewController.view.bounds;
// Cordova-Ansicht anzeigen [rootViewController addChildViewController:cordovaViewController];
[rootViewController.view addSubview:cordovaViewController.view];
[cordovaViewController didMoveToParentViewController:rootViewController];
}
```

Empfohlenes Code-Snippet mit Problemumgehung für die Einschränkung: 

```objc
(void)wlInitDidCompleteSuccessfully
{
 // Cordova-Ansichtencontroller erstellen
CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;
cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
[self.window setRootViewController:cordovaViewController];
[self.window makeKeyAndVisible];
}
```

### Keine Unterstützung für unbearbeitete IPv6-Adressen in Android-Anwendungen
{: #raw-ipv6-address-not-supported-in-android-applications }
Wenn Sie für Ihre native Android-Anwendung die Eigenschaft **wlServerHost** in **mfpclient.properties** konfigurieren und sich Ihr
{{ site.data.keys.mf_server }} auf einem Host mit IPv6-Adresse befindet, verwenden Sie einen zugeordneten Hostnamen als IPv6-Adresse. Wenn Sie die
Eigenschaft **wlServerHost** mit einer unbearbeiteten IPv6-Adresse konfigurieren,
scheitert der Versuch der Anwendung, eine Verbindung zu {{ site.data.keys.mf_server }} herzustellen.

### Nicht empfohlene Modifikation des Standardverhaltens einer Cordova-App
{:  #modifying_default_behaviour_of_a_cordova_app_is_not_recommended}
Die Modifikation des Standardverhaltens einer Cordova-App (z. B. durch Außerkraftsetzen des Verhaltens der Schaltfläche "Back")
beim Hinzufügen des
{{ site.data.keys.product_adj }}-Cordova-SDK zum Projekt, kann dazu führen, dass die App
bei Übergabe an den Google Play Store zurückgewiesen wird.
Sollte die Übergabe an den Google Play Store aus anderen Gründen fehlschlagen, wenden Sie sich an den Google-Support.
