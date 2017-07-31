---
layout: tutorial
title: Service Mobile Foundation on Bluemix verwenden
breadcrumb_title: Mobile Foundation Service
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
In diesem Lernprogramm finden Sie schrittweise Anleitungen für das Einrichten einer MobileFirst-Server-Instanz in Bluemix unter Verwendung des Service {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}** Service).   
Der {{ site.data.keys.mf_bm_short }} Service ist ein Bluemix-Service für eine schnelle automatische Installation skalierbarer Entwicklungs- und Produktionsumgebungen
mit MobileFirst Foundation Version 8.0 einer **Liberty-for-Java-Laufzeit**.

Der {{ site.data.keys.mf_bm_short }} Service bietet die folgenden Planoptionen an: 

1. **Developer**: Dieser Plan stellt {{ site.data.keys.mf_server }} als eine Cloud-Foundry-App in einer Liberty-for-Java-Laufzeit bereit. Der Plan unterstützt nicht die Verwendung externer Datenbanken und die Definition mehrerer Knoten. *Er ist nur für Entwicklung und Tests bestimmt*. Die Serverinstanz ermöglicht Ihnen, beliebig viele mobile Anwendungen für Entwicklung und Tests zu registrieren. 

    > **Hinweis:** Der Plan "Developer" bietet keine persistente Datenban an. Erstellen Sie daher unbedingt eine Sicherung Ihrer Konfiguration (siehe Abschnitt [Fehlerbehebung](#troubleshooting)).

2. **Developer Pro**: Dieser Plan stellt {{ site.data.keys.mf_server }} als eine Cloud-Foundry-App in einer Liberty-for-Java-Laufzeit bereit und ermöglicht Benutzern, beliebig viele mobile Anwendungen zu entwickeln und zu testen. Für den Plan ist der **dashDB-OLTP-Service** erforderlich. Der dashDB-Service wird separat erstellt und in Rechnung gestellt. Bei Bedarf können Sie den in IBM Containern implementierten {{ site.data.keys.mf_analytics_server }} hinzufügen. Die Containergebühren werden separat in Rechnung gestellt. Dieser Plan ist vom Volumen her begrenzt. Er ist für Entwicklung und Tests in einem Team, nicht aber für die Produktion konzipiert. Die Gebühren richten sich nach der Gesamtgröße Ihrer Umgebung.

3. **Professional Per Capacity:** Dieser Plan ermöglicht Benutzern, in der Produktion beliebig viele mobile Anwendungen zu erstellen, zu testen und auszuführen. Dies gilt unabhängig von der Anzahl mobiler App-Benutzer oder Geräte. Der Plan unterstützt umfangreiche Implementierungen und eine hohe Verfügbarkeit. Für den Plan ist der **dashDB-OLTP-Service** erforderlich. Der dashDB-Service wird separat erstellt und in Rechnung gestellt. Bei Bedarf können Sie den in IBM Containern implementierten {{ site.data.keys.mf_analytics_server }} hinzufügen. Die Containergebühren werden separat in Rechnung gestellt. Die Gebühren richten sich nach der Gesamtgröße Ihrer Umgebung.

4. **Professional 1 Application**: Dieser Plan stellt {{ site.data.keys.mf_server }} in Form einer skalierbaren Cloud-Foundry-App in einer Liberty-for-Java-Laufzeit bereit. Der Plan erfordert einen dashDB-Datenbankservice, der separat erstellt und abgerechnet wird. Der Plan ermöglicht Benutzern die Erstellung und Verwaltung einer einzelnen mobilen Anwendung. Eine mobile Anwendung kann es in mehreren Varianten geben, z. B. für iOS, Android, Windows und Mobile Web. 

> Auf der [Serviceseite von bluemix.net](https://console.ng.bluemix.net/catalog/services/mobile-foundation/) finden Sie weitere Informationen zu den verfügbaren Plänen und ihrer Fakturierung.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [{{ site.data.keys.mf_bm_short }} Service einrichten](#setting-up-the-mobile-foundation-service)
* [{{ site.data.keys.mf_bm_short }} Service verwenden](#using-the-mobile-foundation-service)
* [Serverkonfiguration](#server-configuration)
* [Erweiterte Serverkonfiguration](#advanced-server-configuration)
* [Analytics-Unterstützung hinzufügen](#adding-analytics-support)
* [Fixes für {{ site.data.keys.mf_server }} anwenden](#applying-mobilefirst-server-fixes)
* [Zugriff auf Serverprotokolle](#accessing-server-logs)
* [Fehlerbehebung](#troubleshooting)
* [Weiterführende Informationen](#further-reading)

## {{ site.data.keys.mf_bm_short }} Service einrichten
{: #setting-up-the-mobile-foundation-service }
Führen Sie zunächst die folgenden Schritte aus, um die verfügbaren Pläne einzurichten: 

1. Laden Sie [bluemix.net](http://bluemix.net), melden Sie sich an und klicken Sie auf **Katalog**.
2. Suchen Sie nach **Mobile Foundation** und klicken Sie auf die zugehörige Kacheloption. 
3. Geben Sie einen angepassten Namen für die Serviceinstanz ein oder übernehmen Sie den vorgegebenen Standardnamen (*optional*). 
4. Wählen Sie den gewünschten Preistarif aus und klicken Sie auf **Erstellen**.

    <img class="gifplayer" alt="Mobile-Foundation-Serviceinstanz erstellen" src="service-creation.png"/>

### Plan *Developer* einrichten
{: #setting-up-the-developer-plan }
1. Starten Sie {{ site.data.keys.mf_server }}.
    - Sie können die Basisversion der Serverkonfiguration verwenden und auf **Basisserver starten** klicken oder 
    - Sie können die Serverkonfiguration auf der [Registerkarte 'Einstellungen'](#advanced-server-configuration) aktualisieren und auf **Erweiterten Server starten** klicken. 

    Mit diesem Schritt wird eine Cloud-Foundry-App für den {{ site.data.keys.mf_bm_short }} Service generiert und die MobileFirst-Foundation-Umgebung initialisiert. Dieser Schritt kann zwischen 5 und 10 Minuten dauern. 

2. Wenn die Instanz bereit ist, können Sie den [Service verwenden](#using-the-mobile-foundation-service).

    ![Mobile-Foundation-Setup(overview-page.png)

### Pläne *Developer Pro*, *Professional Per Capacity* und *Professional 1 Application* einrichten
{: #setting-up-the-developer-pro-professional-percapacity-and-professional-1-application-plans }
1. Für diese Pläne ist eine externe [transaktionsorientierte dashDB-Datenbankinstanz](https://console.ng.bluemix.net/catalog/services/dashdb/) erforderlich.

    > Informieren Sie sich über die [Einrichtung einer dashDB-Datenbankinstanz]({{site.baseurl}}/blog/2016/11/02/using-dashdb-service-with-mobile-foundation/).

    Wenn Sie bereits eine dashDB-Serviceinstanz haben (DashDB Enterprise Transactional 2.8.500 oder Enterprise Transactional 12.128.1400), wählen Sie die Option **Vorhandenen Service verwenden** aus und geben Sie Ihre Berechtigungsnachweise an. 

    ![Mobile-Foundation-Setup(create-dashdb-instance-existing.png)

    1.b. Falls Sie noch keine dashDB-Serviceinstanz haben, wählen Sie die Option **Neuen Service erstellen** aus und folgen Sie den Anweisungen, die auf dem Bildschirm angezeigt werden. 

    ![Mobile-Foundation-Setup(create-dashdb-instance-new.png)

2. Starten Sie {{ site.data.keys.mf_server }}.
    - Sie können die Basisversion der Serverkonfiguration verwenden und auf **Basisserver starten** klicken oder 
    - Sie können die Serverkonfiguration auf der [Registerkarte 'Einstellungen'](#advanced-server-configuration) aktualisieren und auf **Erweiterten Server starten** klicken. 

    Mit diesem Schritt wird eine Cloud-Foundry-App für den {{ site.data.keys.mf_bm_short }} Service generiert und die MobileFirst-Foundation-Umgebung initialisiert. Dieser Schritt kann zwischen 5 und 10 Minuten dauern. 

3. Wenn die Instanz bereit ist, können Sie den [Service verwenden](#using-the-mobile-foundation-service).

    ![Mobile-Foundation-Setup(overview-page.png)

## {{ site.data.keys.mf_bm_short }} Service verwenden
{: #using-the-mobile-foundation-service }

Sobald {{ site.data.keys.mf_server }} aktiv ist, wird das folgende Dashboard angezeigt: 

![Mobile-Foundation-Setup(service-dashboard.png)

Klicken Sie auf **Analytics hinzufügen**, um Unterstützung für {{ site.data.keys.mf_analytics }} zu Ihrer Serverinstanz hinzuzufügen.
Weitere Informationen finden Sie im Abschnitt [Analytics-Unterstützung hinzufügen](#adding-analytics-support). 

Klicken Sie auf **Konsole starten**, um die {{ site.data.keys.mf_console }} zu öffnen. Der Standardbenutzername ist "admin". Das Kennwort können Sie sichtbar machen, indem Sie auf das Augensymbol klicken. 

![Mobile-Foundation-Setup(dashboard.png)

### Serverkonfiguration
{: #server-configuration }
Die Basisserverinstanz umfasst Folgendes: 

* Einzelknoten (Servergröße: "klein")
* 1 GB Hauptspeicher
* 2 GB Speicherkapazität

### Erweiterte Serverkonfiguration
{: #advanced-server-configuration }
Auf der Registerkarte **Einstellungen** können Sie die Serverinstanz mit Folgendem weiter anpassen: 

* Verschiedene Kombinationen aus Knoten, Hauptspeicher und Speicherkapazität
* Administratorkennwort für die {{ site.data.keys.mf_console }}
* LTPA-Schlüssel
* JNDI-Konfiguration
* Benutzerregistry
* Truststore
* Konfiguration von {{ site.data.keys.mf_analytics }}
* Datenbankauswahl "DashDB Enterprise Transactional 2.8.500" oder "Enterprise Transactional 12.128.1400" (aus dem Plan *Professional 1 Application*)
* VPN

![Mobile-Foundation-Setup(advanced-server-configuration.png)

## {{ site.data.keys.mf_analytics_short }}-Unterstützung hinzufügen
{: #adding-analytics-support }
Sie können Unterstützung für {{ site.data.keys.mf_analytics }} zu Ihrer Mobile-Foundation-Service-Instanz hinzufügen. Klicken Sie dazu auf der Dashboardseite des Service auf **Analytics hinzufügen**. Mit dieser Aktion wird ein IBM Container mit einer Instanz von {{ site.data.keys.mf_analytics }} bereitgestellt.

* Wenn Sie den Plan **Developer** nutzen, wird mit dieser Aktion außerdem automatisch
die {{ site.data.keys.mf_analytics_short }}-Service-Instanz an Ihre MobileFirst-Server-Instanz gebunden.   
* Wenn Sie den Plan **Developer Pro**, **Professional Per Capacity** oder **Proffessional 1 Application** nutzen, werden Sie im Rahmen dieser Aktion aufgefordert, weitere Optionen zu wählen (Anzahl der verfügbaren Knoten, verfügbarer Hauptspeicher und Speicherkapazität).  

Wenn die Operation abgeschlossen ist, müssen Sie in Ihrem Browser die Seite der {{ site.data.keys.mf_console }} neu laden, um auf die {{ site.data.keys.mf_analytics_console_short }} zugreifen zu können.   

> Weitere Informationen zu {{ site.data.keys.mf_analytics }} finden Sie in der [Kategorie '{{ site.data.keys.mf_analytics }}'](../../analytics). 

## Fixes für {{ site.data.keys.mf_server }} anwenden
{: #applying-mobilefirst-server-fixes }
Aktualisierungen für die {{ site.data.keys.mf_bm }} Services werden automatisch und ohne manuellen Eingriff durchgeführt. Die Durchführung muss lediglich bestätigt werden. Wenn eine Aktualisierung verfügbar ist, wird auf der Dashboardseite des Service ein Banner mit Anweisungen und Aktionsschaltflächen angezeigt. 

## Zugriff auf Serverprotokolle
{: #accessing-server-logs }
Öffnen Sie für den Zugriff auf Serverprotokolle die Seitenleistennavigation und klicken Sie auf **Apps → Cloud Foundry Apps**. Wählen Sie Ihren Service aus und klicken Sie auf **Laufzeit**. Klicken Sie dann auf das Register **Dateien**. 

Im Ordner **logs** finden Sie die Dateien **messages.log** und **trace.log**. 

#### Tracefunktion
{: #tracing }
Wenn Sie die Tracefunktion aktivieren, werden in der Datei **trace.log** Nachrichten der Ebene DEBUG ausgegeben. 

1. Wählen Sie unter **Laufzeit → Memory and Instances** Ihre Serviceinstanz aus. (Instanz-IDs beginnen bei **0**.) 
2. Klicken Sie auf die Aktionsoption **Trace**. 
3. Geben Sie die Traceanweisung `com.worklight.*=debug=enabled` ein und klicken Sie auf **Submit trace**.

Die Datei **trace.log** ist jetzt an der oben angegebenen Position verfügbar. 

<img class="gifplayer" alt="Serverprotokolle für den Mobile-Foundation-Service" src="server-logs.png"/>

## Fehlerbehebung
{: #troubleshooting }
Der Plan "Developer" stellt keine persistente Datenbank bereit, sodass potenziell ein Datenverlust möglich ist. Halten Sie sich daher zum Schutz vor Datenverlusten an die folgenden bewährten Verfahren: 

* Immer, wenn Sie eine der folgenden serverseitigen Aktionen ausführen: 
    * einen Adapter implementieren oder eine Adapterkonfiguration bzw. einen Eigenschaftswert aktualisieren
    * im Rahmen einer Sicherheitskonfiguration eine Bereichszuordnung oder ähnliches erstellen 

    Führen Sie in der Befehlszeile folgenden Befehl aus, um Ihre Konfiguration in eine ZIP-Datei herunterzuladen: 

  ```bash
  $curl -X GET -u admin:admin -o export.zip http://<App-Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/export/all
  ```

* Wenn Sie Ihren Server neu erstellen müssen oder Ihre Konfiguration verloren haben, führen Sie in der Befehlszeile den folgenden Befehl aus, um die Konfiguration in den Server zu importieren: 

  ```bash
  $curl -X POST -u admin:admin -F file=@./export.zip http://<App-Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi
  ```

## Weiterführende Informationen
{: #further-reading }
Jetzt, da Ihre MobileFirst-Server-Instanz betriebsbereit ist, können Sie die folgenden Schritte ausführen: 

* Machen Sie sich mit der [{{ site.data.keys.mf_console }}](../../product-overview/components/console) vertraut. 
* Nutzen Sie die [Lernprogramme für den Schnelleinstieg](../../quick-start), um Erfahrungen mit der MobileFirst Foundation zu sammeln.
* Arbeiten Sie alle [verfügbaren Lernprogramme](../../all-tutorials/) durch.
