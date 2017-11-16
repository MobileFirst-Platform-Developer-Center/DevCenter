---
layout: tutorial
title: Anwendungen entwickeln
show_children: true
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Entwicklungskonzepte und Übersicht
{: #development-concepts-and-overview }
Wenn Sie Ihre App mit den Tools der {{ site.data.keys.product_full }}
entwickeln, müssen Sie diverse Komponenten und Elemente entwickeln oder konfigurieren. Wenn Sie über diese Komponenten und Elemente
informiert sind, geht die Entwicklung Ihrer App reibungslos und schneller voran. 

Sie werden sich aber nicht nur mit diesen Konzepten vertraut machen, sondern erhalten auch Informationen zu den {{ site.data.keys.product_adj }}-APIs für native, Cordova- und Webanwendungen wie JSONStore und WLResourceRequest. Zudem werden Sie das Debuggen von Anwendungen, die Verwendung der direkten Aktualisierung für Webressourcen, die Liveaktualisierung zum Erstellen von Benutzersegmenten und die Bearbeitung von Apps, Adaptern und anderen Artefakten über die {{ site.data.keys.mf_cli }} erlernen.

Navigieren Sie in der Seitenleiste zum betreffenden Abschnitt oder
lesen Sie hier weiter,
um mehr über die verschiedenen {{ site.data.keys.product_adj }}-Komponenten zu erfahren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Anwendungen](#applications)
* [{{ site.data.keys.mf_server }}](#mobilefirst-server)
* [Adapter](#adapters)
* [Lernprogramme für die Clientseite](#client-side-tutorials-to-follow)

### Anwendungen
{: #applications }
Anwendungen weden für einen Ziel-MobileFirst-Server erstellt, auf dem es eine serverseitige Konfiguration für die Anwendungen gibt.
Sie müssen Ihre Anwendungen bei
{{ site.data.keys.mf_server }} registrieren, bevor Sie sie konfigurieren. 

Anwendungen werden
anhand folgender Elemente identifiziert: 

* App-ID
* Versionsnummer
* Zielimplementierungsplattform

> **Hinweis:** Da es nicht mehrere Versionen einer Webanwendung geben kann, ist die Versionsnummer für Webanwendungen nicht zutreffend. 

Diese Kennungen werden auf der Clientseite und der Serverseite verwendet, um sicherzustellen, dass Apps richtig
implementiert werden und nur die ihnen zugewiesenen Ressourcen nutzen. Unterschiedliche Komponenten der
{{ site.data.keys.product }} verwenden verschiedene Kombinationen dieser
Kennungen auf unterschiedliche Art. 

Die App-ID hängt von der Zielbereitstellungsplattform ab. 

**Android**  
Die Kennung ist der Name des Anwendungspakets. 

**iOS**  
Die Kennung ist die ID des Anwendungsbundles. 

**Windows**  
Die Kennung ist der Name der Anwendungsassembly. 

**Web**  
Die Kennung ist eine eindeutige ID, die vom Entwickler zugewiesen wird. 

Wenn Apps für verschiedene Zielplattformen dieselbe App-ID haben,
geht {{ site.data.keys.mf_server }} davon aus, dass es sich bei all diesen Apps
um eine App mit verschiedenen Plattforminstanzen handelt.
Die folgenden Apps werden beispielsweise als verschiedene Plattforminstanzen *derselben App* angesehen: 

* iOS-app mit der Bundle-ID `com.mydomain.mfp`
* Android-App mit dem Paketnamen `com.mydomain.mfp`
* Windows-10-UWP-App mit dem Assemblynamen `com.mydomain.mfp`
* Web-App mit zugewiesener ID `com.mydomain.mfp`

Die Zielbereitstellungsplattform für die App hängt nicht davon ab, ob die App als native App oder Cordova-App entwickelt wurde. Die beiden folgenden Apps
werden in der
{{ site.data.keys.product }} beispielsweise als iOS-Apps betrachtet:

* iOS-App, die Sie mit Xcode und nativem Code entwickeln
* iOS-App, die Sie mit Cordova-Technologien für plattformübergreifende Entwicklung entwickeln

> **Hinweis:** Die Funktion **Keychain Sharing** ist obligatorisch, wenn Sie Xcode 8 verwenden und iOS-Apps im iOS-Simulator ausführen. Sie müssen diese Funktion manuell aktivieren, bevor Sie das Xcode-Projekt erstellen.



### Anwendungskonfiguration
{: #application-configuration }
Wie bereits erwähnt, wird eine Anwendung sowohl auf der Clientseite als auch auf der Serverseite konfiguriert.   

Die Clientkonfiguration für native und Cordova-iOS-, Cordova-Android- und Windows-Anwendungen
wird in einer Clienteigenschaftendatei gespeichert (**mfpclient.plist** für iOS, **mfpclient.properties** für Android
oder **mfpclient.resw** für Windows). Bei Webanwendungen werden die Konfigurationseigenschaften
als Parameter an die [Initialisierungsmethode](../application-development/sdk/web) des SDK übergeben.

Zu den Clientkonfigurationseigenschaften gehören die Anwendungs-ID und Informationen wie die URL der
MobileFirst-Server-Laufzeit
und Sicherheitsschlüssel, die für den Zugriff auf den Server
erforderlich sind.   
Die Serverkonfiguration für die App umfasst Informationen wie den App-Managementstatus, Webressourcen für
die direkte Aktualisierung, konfigurierte Sicherheitsbereiche und die Protokollkonfiguration. 

> In den Lernprogrammen zum [Hinzufügen der SDKs der {{ site.data.keys.product }}](sdk) erfahren Sie, wie die {{ site.data.keys.product_adj }}-Client-SDKs hinzugefügt werden.



Die Clientkonfiguration muss definiert werden, bevor Sie
den Anwendungsbuild erstellen. Die Konfigurationseigenschaften in der Client-App müssen zu den Eigenschaften passen, die in
der MobileFirst-Server-Laufzeit für die Client-App definiert sind. Sicherheitsschlüssel in der Clientkonfiguration müssen beispielsweise mit den Schlüsseln auf dem Server
übereinstimmen. Die Clientkonfiguration von Nicht-Web-Apps können Sie über die {{ site.data.keys.mf_cli }} ändern. 

Die Serverkonfiguration für eine App ist an die
Kombination aus App-ID, Versionsnummer und Zielplattform gebunden. Sie müssen Ihre App in der MobileFirst-Server-Laufzeit
registrieren, bevor Sie eine serverseitige Konfiguration für die App hinzufügen. Zum Konfigurieren der Serverseite einer App wird in der Regel die
{{ site.data.keys.mf_console }} verwendet.
Sie können die Serverseite einer App auch mit folgenden Methoden konfigurieren: 

* Rufen Sie vorhandene JSON-Konfigurationsdateien mit dem Befehl `mfpdev
app pull` vom Server ab. Aktualisieren Sie die Dateien und laden Sie die geänderte Konfiguration mit dem Befehl
`mfpdev app push` hoch. 
* Verwenden Sie das Programm oder die Ant-Task **mfpadm**. Informationen zur Verwendung von
mfpadm finden Sie unter
[{{ site.data.keys.product_adj }}-Anwendungen
über die Befehlszeile verwalten](../administering-apps/using-cli) und
[{{ site.data.keys.product_adj }}-Anwendungen mit Ant verwalten](../administering-apps/using-ant). 
* Verwenden Sie die REST-API des {{ site.data.keys.product_adj }}-Verwaltungsservice. Weitere Informationen zu der REST-API finden Sie unter
[REST-API für den MobileFirst-Server-Verwaltungsservice](../api/rest/administration-service/).

Mit diesen Methoden können Sie auch die
Konfiguration Ihres {{ site.data.keys.mf_server }} automatisieren. 

> **Beachten Sie Folgendes:** Sie können die Serverkonfiguration sogar modifizieren, während der
{{ site.data.keys.mf_server }} aktiv ist und Datenverkehr von Apps empfängt. Sie müssen den Server nicht stoppen,
um die Serverkonfiguration für eine App zu ändern. 

Auf einem Produktionsserver entspricht
die App-Version üblicherweise der in einem App Store veröffentlichten Version einer Anwendung. Einige Serverkonfigurationselemente wie die Konfiguration der
App-Authentizität, sind für die im Store veröffentlichte App eindeutig. 

## {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.mf_server }} bildet die Serverseite Ihrer mobilen App.
Mit {{ site.data.keys.mf_server }} haben Sie Zugriff auf Funktionen wie das Anwendungsmanagement
und die Anwendungssicherheit. Ihre mobile App erhält über MobileFirst Server mithilfe von Adaptern sicheren Zugriff auf andere Back-End-Systeme. 

{{ site.data.keys.mf_server }} ist die Kernkomponente, die viele Features der
{{ site.data.keys.product }} bereitstellt. Dazu gehören unter anderem: 

* Anwendungsmanagement
* Anwendungssicherheit, einschließlich der Authentifizierung von Geräten und Benutzern und der Überprüfung der Anwendungsauthentizität
* Sicherer Zugriff auf Back-End-Services mithilfe von Adaptern
* Direkte Aktualisierung von Webressourcen für Cordova-Apps
* Push-Benachrichtigungen und Push-Abonnements
* App-Analysen

Sie müssen {{ site.data.keys.mf_server }} während des gesamten Lebenszyklus Ihrer App verwenden, angefangen bei Entwicklung und Tests
bis hin zur Implementierung in der Produktion und zur Wartung.   

> Wenn Sie Ihre App entwickeln, steht Ihnen ein vorkonfigurierter Server
zur Verfügung. Informationen zur Verwendung von {{ site.data.keys.mf_server }} für die Entwicklung Ihrer App
finden Sie unter [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../installation-configuration/development). 

{{ site.data.keys.mf_server }} umfasst die folgenden Komponenten, die
alle auch im
{{ site.data.keys.mf_server }} enthalten sind.
In einfachen Fällen werden alle Komponenten in demselben Anwendungsserver ausgeführt.
In einer Produktions- oder Testumgebung können Sie jedoch einige Komponenten in anderen Anwendungsservern ausführen. Informationen zu möglichen Topologien für diese
MobileFirst-Server-Komponenten finden Sie unter
[Topologien und Netzabläufe](../installation-configuration/production/topologies). 

### {{ site.data.keys.product_adj }} und MobileFirst-Server-Verwaltungsservice
{: #mobilefirst-and-the-mobilefirst-server-administration-service }
Die Operations Console ist eine Webschnittstelle, die Sie zum Anzeigen und Bearbeiten der MobileFirst-Server-Konfigurationen
verwenden können.
Von der Operations Console aus können Sie auch auf die {{ site.data.keys.mf_analytics_console }} zugreifen. Das Kontextstammverzeichnis
der Operations Console des Entwicklungsservers ist **/mfpconsole**.

Der Verwaltungsservice ist der Haupteintrittspunkt für die Verwaltung Ihrer
Apps. Sie können über eine webbasierte Schnittstelle mit der
{{ site.data.keys.mf_console }} auf den Verwaltungsservice zugreifen.
Für den Zugriff auf den Verwaltungsservice können Sie auch das Befehlszeilentool **mfpadm** oder die REST-API des Verwaltungsservice
verwenden. 

> Machen Sie sich mit den [Features der {{ site.data.keys.mf_console }}](../product-overview/components/console) vertraut.

### {{ site.data.keys.product_adj }}-Laufzeit
{: #mobilefirst-runtime }
Die Laufzeit ist der Haupteintrittspunkt für eine
{{ site.data.keys.product_adj }}-Client-App. Die Laufzeit ist auch der
Standardautorisierungsserver für die OAuth-Implementierung
der {{ site.data.keys.product }}. 

Bei innovativem Einsatz kann es in seltenen Fällen
in einem einzelnen {{ site.data.keys.mf_server }} mehrere Instanzen einer Gerätelaufzeit geben. Eine Instanz hat ein eigenes Kontextstammverzeichnis. Das Kontextstammverzeichnis wird verwendet, um den Namen einer Laufzeit in der Operations Console anzuzeigen. Verwenden Sie mehrere
Instanzen, wenn Sie verschiedene Konfigurationen auf der Serverebene benötigen (z. B. gemeine Schlüssel für den Keystore). 

Wenn es in Ihrem
{{ site.data.keys.mf_server }} nur eine Instanz einer Gerätelaufzeit gibt, müssen Sie
das Kontextstammverzeichnis in der Regel nicht kennen. Angenommen Sie registrieren eine Anwendung mit dem Befehl
`mfpdev
app register` in einer Laufzeit und im {{ site.data.keys.mf_server }} gibt es nur eine Laufzeit.
Die Anwendung wird in dem Fall automatisch für diese Laufzeit registriert. 

### Push-Service von {{ site.data.keys.mf_server }}
{: #mobilefirst-server-push-service }
Der Push-Service ist Ihr Haupteintrittspunkt für Push-Operationen wie Push-Benachrichtigungen und Push-Abonnements. Für die Kommunikation mit Push-Services verwenden Client-Apps die
URL der Laufzeit und ersetzen das Kontextstammverzeichnis durch
/mfppush. Sie können den Push-Service in der
{{ site.data.keys.mf_console }} oder über die REST-API für Push-Services
konfigurieren und verwalten. 

Wenn Sie die Push-Services in einem separaten Anwendungsserver außerhalb der
der {{ site.data.keys.product_adj }}-Laufzeit ausführen, müssen Sie den
Datenverkehr des Push-Service mit Ihrem HTTP-Server zum richtigen Anwendungsserver weiterleiten. 

### {{ site.data.keys.mf_analytics }} und {{ site.data.keys.mf_analytics_console }}
{: #mobilefirst-analytics-and-the-mobilefirst-analytics-console }
{{ site.data.keys.mf_analytics_full }} ist eine optionale Komponente mit einem skalierbaren Analysefeature, auf das Sie über die {{ site.data.keys.mf_console }} zugreifen können. Mit dem Analysefeature können Sie Protokolle und Ereignisse, die von Geräten, Apps und Servern erfasst wurden, nach Mustern, Problemen und Statistikdaten zur Plattformnutzung durchsuchen.

In der {{ site.data.keys.mf_console }} können Sie Filter definieren, um die Weiterleitung an den Analyseservice zu aktivieren oder zu inaktivieren. Sie können auch die Art der gesendeten Informationen filtern. Auf der Clientseite können Sie die Protokollerfassungs-API verwenden, um Ereignisse und Daten an den Analyseserver zu senden.

Wenn Sie {{ site.data.keys.mf_server }} in der gewünschten Topologie
installiert und konfiguriert haben,
haben Sie für die weitere Konfiguration von {{ site.data.keys.mf_server }} und der zugehörigen Anwendungen
folgende Optionen: 

* {{ site.data.keys.mf_console }}
* REST-API des MobileFirst-Server-Verwaltungsservice
* Befehlszeilentool **mfpadm**

Nach der Erstinstallation und -konfiguration müssen Sie auf keine Anwendungsserverkonsole oder -schnittstelle zugreifen,
um
die {{ site.data.keys.product }} zu konfigurieren.  
Wenn Sie Ihre App in der Produktion implementieren möchten, können Sie sie in folgenden MobileFirst-Server-Produktionsumgebungen
implementieren: 

#### In Ihren Räumlichkeiten
{: #on-premises }
> Informationen zur Installation und Konfiguration
von {{ site.data.keys.mf_server }} in Ihrer lokalen Umgebung
finden Sie unter
[IBM {{ site.data.keys.mf_server }} installieren](../installation-configuration/production/appserver).
#### In der Cloud
{: #on-the-cloud }
* [{{ site.data.keys.mf_server }} in IBM Bluemix](../bluemix)
* [{{ site.data.keys.mf_server }} in IBM PureApplication](../installation-configuration/production/pure-application)

## Adapter
{: #adapters }
In der {{ site.data.keys.product }} verbinden Adapter Ihre
Back-End-Systeme sicher mit Clientanwendungen und Cloud-Services.   

Sie können Adapter in JavaScript oder
Java schreiben und als Maven-Projekte erstellen und implementieren.   
Adapter werden in einer
{{ site.data.keys.product_adj }}-Laufzeit in
{{ site.data.keys.mf_server }} implementiert. 

In einem Produktionssystem werden Adapter normalerweise in einem Cluster aus Anwendungsservern ausgeführt. Implementieren Sie Ihre Adapter als REST-Services ohne Sitzungsinformationen und lokal auf dem Server
gespeichert. So stellen Sie sicher, dass Ihr Adapter in einer Clusterumgebung ordnungsgemäß funktioniert. 

Ein Adapter kann benutzerdefinierte Eigenschaften haben. Diese Eigenschaften können auf der Serverseite konfiguriert werden, ohne dass der
Adapter neu implementiert werden muss. Beim Wechsel von der Test- zur Produktionsumgebung können Sie beispielsweise die URL ändern, mit der
Ihr Adapter auf Ressourcen zugreift. 

Für die Implementierung eines Adapters in einer
{{ site.data.keys.product_adj }}-Laufzeit können Sie die
{{ site.data.keys.mf_console }} nutzen, den Befehl
mfpdev adapter deploy verwenden oder den Adapter direkt von Maven aus implementieren. 

> Unter [Adapterkategorien](../adapters) können Sie sich über Adapter und die Entwicklung von JavaScript- und Java-Adaptern informieren.

## Lernprogramme für die Clientseite
{: #client-side-tutorials-to-follow }
