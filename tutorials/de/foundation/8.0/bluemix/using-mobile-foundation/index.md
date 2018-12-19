---
layout: tutorial
title: Mobile Foundation Service in IBM Cloud verwenden
breadcrumb_title: Setting up Mobile Foundation service
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
In diesem Lernprogramm finden Sie schrittweise Anleitungen für das Einrichten einer MobileFirst-Foundation-Server-Instanz in IBM Cloud unter Verwendung des Service {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}** Service).   
Der {{ site.data.keys.mf_bm_short }} Service ist ein IBM Cloud-Service für eine schnelle automatische Installation skalierbarer Entwicklungs- und Produktionsumgebungen mit Mobile Foundation Version 8.0 einer **Liberty-for-Java-Laufzeit**.

Der {{ site.data.keys.mf_bm_short }} Service bietet die folgenden Planoptionen an: 

1. **Developer**: Dieser Plan stellt {{ site.data.keys.mfound_server }} als eine Cloud-Foundry-Anwendung in einer Liberty-for-Java-Laufzeit bereit. Die Liberty-for-Java-Gebühren werden gesondert in Rechnung gestellt und sind nicht in diesem Plan enthalten. Der Plan unterstützt nicht die Verwendung externer Datenbanken. Er ist für Entwicklung und Tests bestimmt. Die Mobile-Foundation-Server-Instanz des Plans *Developer* ermöglicht Ihnen, beliebig viele mobile Anwendungen für Entwicklung und Tests zu registrieren. Die Anzahl verbundener Geräte ist allerdings auf 10 beschränkt.

    > **Hinweis:** Der Plan "Developer" bietet keine persistente Datenbank an. Erstellen Sie daher unbedingt eine Sicherung Ihrer Konfiguration (siehe Abschnitt [Fehlerbehebung](#troubleshooting)).


2. **Professional Per Device:** Dieser Plan ermöglicht Benutzern, in der Produktion mobile Anwendungen zu erstellen, zu testen und auszuführen. Die Gebühren richten sich nach der Anzahl der pro Tag verbundenen Clientgeräte. Dieser Plan unterstützt umfangreiche Implementierungen und eine hohe Verfügbarkeit. Dieser Plan erfordert eine Serviceinstanz von IBM Db2 (aus einem beliebigen Plan mit Ausnahme von **Lite**) oder von Compose for PostgreSQL, die separat erstellt und in Rechnung gestellt wird. Mit diesem Plan wird ein Mobile Foundation Server in Liberty for Java mit mindestens 2 Knoten mit 1 GB bereitgestellt. Die Liberty-for-Java-Gebühren werden gesondert in Rechnung gestellt und sind nicht as diesem Plan enthalten.

3. **Professional 1 Application:** Dieser Plan ermöglicht Benutzern, eine mobile Anwendung mit einem verhersehbaren Preis zu erstellen und zu verwalten. Dies gilt unabhängig von der Anzahl mobiler App-Benutzer oder Geräte. Diese eine mobile Anwendung kann es in mehreren Varianten geben, z. B. für iOS, Android, Windows und Mobile Web. Mit diesem Plan wird ein Mobile Foundation Server als Cloud-Foundry-Anwendung in Liberty for Java mit mindestens 2 Knoten mit 1 GB bereitgestellt. Die Liberty-for-Java-Gebühren werden gesondert in Rechnung gestellt und sind nicht as diesem Plan enthalten. Dieser Plan erfordert auch eine Serviceinstanz von IBM Db2 (aus einem beliebigen Plan mit Ausnahme von **Lite**) oder von Compose for PostgreSQL, die separat erstellt und in Rechnung gestellt wird.

4. **Developer Pro**: Dieser Plan stellt {{ site.data.keys.mfound_server }} als eine Cloud-Foundry-App in einer Liberty-for-Java-Laufzeit bereit und ermöglicht Benutzern, beliebig viele mobile Anwendungen zu entwickeln und zu testen. Dieser Plan erfordert eine Serviceinstanz von **Db2** (aus einem beliebigen Plan mit Ausnahme von **Lite**). Die Serviceinstanz von Db2 wird separat erstellt und in Rechnung gestellt. Dieser Plan ist vom Volumen her begrenzt. Er ist für Entwicklung und Tests in einem Team, nicht aber für die Produktion konzipiert. Die Gebühren richten sich nach der Gesamtgröße Ihrer Umgebung.
>_Der Plan **Developer Pro** wird nicht weiter unterstützt._

5. **Professional Per Capacity:** Dieser Plan ermöglicht Benutzern, in der Produktion beliebig viele mobile Anwendungen zu erstellen, zu testen und auszuführen. Dies gilt unabhängig von der Anzahl mobiler App-Benutzer oder Geräte. Der Plan unterstützt umfangreiche Implementierungen und eine hohe Verfügbarkeit. Der Plan erfordert eine Serviceinstanz von **Db2** (aus einem beliebigen Plan mit Ausnahme von **Lite**). Die Serviceinstanz von Db2 wird separat erstellt und in Rechnung gestellt. Die Gebühren richten sich nach der Gesamtgröße Ihrer Umgebung.
>_Der Plan **Professional Per Capacity** wird nicht weiter unterstützt._

> Die [Servicedetails](https://console.bluemix.net/catalog/services/mobile-foundation/) enthalten weitere Informationen zu den verfügbaren Plänen und ihrer Fakturierung.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
- [Übersicht](#overview)
    - [Fahren Sie mit folgenden Abschnitten fort: ](#jump-to)
- [{{ site.data.keys.mf_bm_short }} Service einrichten](#setting-up-the--sitedatakeysmfbmshort--service)
  - [Plan *Developer* einrichten](#setting-up-the-developer-plan)
  - [Pläne *Professional 1 Application* und *Professional Per Device* einrichten](#setting-up-the-professional-1-application-and-professional-per-device-plan)
- [{{ site.data.keys.mf_bm_short }} Service verwenden](#using-the--sitedatakeysmfbmshort--service)
  - [Serverkonfiguration](#server-configuration)
  - [Erweiterte Serverkonfiguration](#advanced-server-configuration)
- [Fixes für {{ site.data.keys.mfound_server }} anwenden](#applying--sitedatakeysmfoundserver--fixes)
- [Zugriff auf Serverprotokolle](#accessing-server-logs)
    - [Tracefunktion](#tracing)
- [Fehlerbehebung](#troubleshooting)
- [Weiterführende Informationen](#further-reading)

## {{ site.data.keys.mf_bm_short }} Service einrichten
{: #setting-up-the-mobile-foundation-service }
Führen Sie zunächst die folgenden Schritte aus, um die verfügbaren Pläne einzurichten: 

1. Rufen Sie [bluemix.net](http://bluemix.net) auf, melden Sie sich an und klicken Sie auf **Katalog**.
2. Suchen Sie nach **Mobile Foundation** und klicken Sie auf die zugehörige Kacheloption. 
3. Geben Sie einen angepassten Namen für die Serviceinstanz ein oder übernehmen Sie den vorgegebenen Standardnamen (*optional*). 
4. Wählen Sie den gewünschten Preistarif aus und klicken Sie auf **Erstellen**.

    <img class="gifplayer" alt="Serviceinstanz von {{ site.data.keys.mf_bm_short }} erstellen" src="mf-create-new.png"/>

### Plan *Developer* einrichten
{: #setting-up-the-developer-plan }

Wenn Sie den {{ site.data.keys.mf_bm_short }} Service erstellen, wird der {{ site.data.keys.mfound_server }} erstellt.
  * Sie haben umgehend Zugriff auf den {{ site.data.keys.mfound_server }} und können mit Ihrer Arbeit beginnen.
  * Wenn Sie über die CLI auf den {{ site.data.keys.mfound_server }} zugreifen möchten, benötigen Sie Berechtigungsnachweise, die verfügbar sind, wenn Sie in der IBM Cloud-Konsole links im Navigationsfenster auf **Serviceberechtigungsnachweise** klicken. 

  ![{{ site.data.keys.mf_bm_short }} ](overview-page-new-2.png)

### Pläne *Professional 1 Application* und *Professional Per Device* einrichten
{: #setting-up-the-professional-1-application-n-professional-per-device-plan }
1. Diese Pläne erfordern eine externe [Db2-Datenbankinstanz (aus einem beliebigen Plan mit Ausnahme von **Lite**)](https://console.bluemix.net/catalog/services/db2/). 

    * Wenn Sie bereits eine Db2-Serviceinstanz haben, wählen Sie die Option **Vorhandenen Service verwenden** aus und geben Sie Ihre Berechtigungsnachweise an.

        ![Eichritung von {{ site.data.keys.mf_bm_short }}](create-db2-instance-existing.png)

    * Wenn Sie bereits eine Serviceinstanz von Compose for PostgreSQL haben, wählen Sie die Option **Vorhandenen Service verwenden** aus und geben Sie Ihre Berechtigungsnachweise an.

        ![Mobile-Foundation-Setup](create-postgres-instance-existing.png)


    * Falls Sie noch keine Serviceinstanz von Db2 oder Compose for PostgreSQL haben, wählen Sie die Option **Neuen Service erstellen** aus und folgen Sie den Anweisungen, die auf dem Bildschirm angezeigt werden. 

       ![Mobile-Foundation-Setup](create-db2-instance-new.png)

2. Starten Sie {{ site.data.keys.mfound_server }}.
    - Sie können die Basisversion der Serverkonfiguration verwenden und auf **Basisserver starten** klicken oder 
    - Sie können die Serverkonfiguration auf der [Registerkarte 'Einstellungen'](#advanced-server-configuration) aktualisieren und auf **Erweiterten Server starten** klicken. 

    Mit diesem Schritt wird eine Cloud-Foundry-App für den {{ site.data.keys.mf_bm_short }} Service generiert und die Mobile-Foundation-Umgebung initialisiert. Dieser Schritt kann zwischen 5 und 10 Minuten dauern. 

3. Wenn die Instanz bereit ist, können Sie den [Service verwenden](#using-the-mobile-foundation-service).

    ![Mobile-Foundation-Setup](overview-page.png)

## {{ site.data.keys.mf_bm_short }} Service verwenden
{: #using-the-mobile-foundation-service }

Sobald {{ site.data.keys.mfound_server }} aktiv ist, wird das folgende Dashboard angezeigt: 

![Mobile-Foundation-Setup](service-dashboard.png)

<!--Click on **Add Analytics** to add {{ site.data.keys.mf_analytics_service }} support to your server instance.
Learn more in the [Adding Analytics support](#adding-analytics-support) section.-->

* Klicken Sie auf **Konsole starten**, um die {{ site.data.keys.mf_console }} zu öffnen. Der Standardbenutzername ist *admin*. Das Kennwort können Sie sichtbar machen, indem Sie im Kennwortfeld auf das Augensymbol klicken. 

  ![Mobile-Foundation-Setup](dashboard.png)

* Klicken Sie in der {{ site.data.keys.mf_console }} auf **Analytics Console**, um die Mobile Analytics Console zu öffnen und die Analysedaten anzuzeigen. Sehen Sie sich dazu die folgende Abbildung an.

  ![Mobile Analytics Console](analytics-dashboard.png)


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

  *Erstellen Sie wie folgt das Truststore-Zertifikat für den Service Mobile Foundation:*

  * Verwenden Sie *cacerts* aus dem letzten Fixpack (Java 8 JDK von IBM Java oder Oracle Java).

  * Importieren Sie das zusätzliche Zertifikat mit folgendem Befehl in den Truststore:
    ```
    keytool -import -file firstCA.cert -alias firstCA -keystore truststore.jks
    ```

  >**Hinweis**: Sie können auch Ihren eigenen Truststore erstellen. Das Standardzertifikat muss aber dennoch verfügbar sein, damit der Service Mobile Foundation ordnungsgemäß funktioniert.

<!--* {{ site.data.keys.mf_analytics_service }} configuration-->
* VPN

![Mobile-Foundation-Setup](advanced-server-configuration.png)

<!--
## Adding {{ site.data.keys.mf_analytics_service }} support
{: #adding-analytics-support }
You can add {{ site.data.keys.mf_analytics_service }} support to your {{ site.data.keys.mf_bm_short }} service instance by clicking on **Add Analytics** from the service's Dashboard page. This action provisions a {{ site.data.keys.mf_analytics_service }} service instance.

>When you create or recreate the **Developer** plan instance of {{ site.data.keys.mf_bm_short }} service, the {{ site.data.keys.mf_analytics_service }} service instance is added by default.
-->
<!--* When using the **Developer** plan this action will also automatically hook the {{ site.data.keys.mf_analytics_service }} service instance to your {{ site.data.keys.mf_server }} instance.  
* When using the **Developer Pro**, **Professional Per Capacity** or **Professional 1 Application** plans, this action will require additional input from you to select: amount of available Nodes, available Memory and a storage volume. -->
<!--
Once the operation finishes, reload the {{ site.data.keys.mf_console }} page in your browser to access the {{ site.data.keys.mf_analytics_service_console }}.  

> Learn more about {{ site.data.keys.mf_analytics_service }} in the [{{ site.data.keys.mf_analytics_service }} category](../../analytics).

##  Removing {{ site.data.keys.mf_analytics_service }} support
{: #removing-analytics-support}

You can remove the {{ site.data.keys.mf_analytics_service }} support for your {{ site.data.keys.mf_bm_short }} service instance by clicking on **Delete Analytics**  from the service’s Dashboard page. This action deletes the {{ site.data.keys.mf_analytics_service }} service instance.

Once the operation finishes, reload the {{ site.data.keys.mf_console }} page in your browser.
-->
<!--
##  Switching from Analytics deployed with IBM Containers to Analytics service
{: #switching-from-analytics-container-to-analytics-service}

>**Note**: Deleting {{ site.data.keys.mf_analytics_service }} will remove all available analytics data. This data will not be available in the new {{ site.data.keys.mf_analytics_service }} instance.

User can delete current container by clicking on **Delete Analytics** button from service dashboard. This will remove the analytics instance and enable the **Add Analytics** button, which the user can click to add a new {{ site.data.keys.mf_analytics_service }} service instance.
-->

## Fixes für {{ site.data.keys.mfound_server }} anwenden
{: #applying-mobilefirst-server-fixes }
Aktualisierungen für die {{ site.data.keys.mf_bm }} Services werden automatisch und ohne manuellen Eingriff durchgeführt. Die Durchführung muss lediglich bestätigt werden. Wenn eine Aktualisierung verfügbar ist, wird auf der Dashboardseite des Service ein Banner mit Anweisungen und Aktionsschaltflächen angezeigt. 

## Zugriff auf Serverprotokolle
{: #accessing-server-logs }
Führen Sie für den Zugriff auf Serverprotokolle die folgenden Schritte aus. 

**Szenario 1:**

1. Richten Sie Ihre Hostmaschine ein. <br/>
   Für die Verwaltung der IBM Cloud-Cloud-Foundry-App müssen Sie die Cloud-Foundry-CLI installieren.<br/>
   Installieren Sie die [Cloud-Foundry-CLI](https://github.com/cloudfoundry/cli/releases).
2. Öffnen Sie das Terminal und melden Sie sich mit `cf login` für Ihre *Organisation* und Ihren *Bereich* an.
3. Führen Sie auf der Befehlszeilenschnittstelle den folgenden Befehl aus:
```bash
  cf ssh <Name_der_MFP-App> -c "/bin/cat logs/messages.log" > messages.log
```
4. Wenn der Trace aktiviert ist, führen Sie den folgenden Befehl aus:
```bash
  cf ssh <Name_der_MFP-App> -c "/bin/cat logs/trace.log" > trace.log
 ```

**Szenario 2:**      

* Öffnen Sie für den Zugriff auf Serverprotokolle die Seitenleistennavigation und klicken Sie auf **Apps → Dashboard → Cloud Foundry Apps**.
* Wählen Sie Ihre App aus und klicken Sie auf **Logs → View in Kibana**.
* Wählen Sie die Protokollnachrichten aus und kopieren Sie sie.


#### Tracefunktion
{: #tracing }
Wenn Sie die Tracefunktion aktivieren, werden in der Datei **trace.log** Nachrichten der Ebene DEBUG ausgegeben. 

1. Wählen Sie im Kombinationsfeld unter **Laufzeit → SSH** Ihre Serviceinstanz aus. (Die Instanz-IDs beginnen mit **0**).
2. Öffnen Sie in der Konsole für jede Instanz die Datei `/home/vcap/app/wlp/usr/servers/mfp/configDropins/overrides/tracespec.xml` im Editor vi.
3. Aktualisieren Sie die Traceanweisung `traceSpecification="=info:com.ibm.mfp.*=all"` und speichern Sie die Datei.

Die Datei **trace.log** ist jetzt an der oben angegebenen Position verfügbar. 

<img class="gifplayer" alt="Serverprotokolle für den Service {{ site.data.keys.mf_bm_short }}" src="mf-trace-setting.png"/>

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
Jetzt, da Ihre Instanz von {{ site.data.keys.mfound_server }} betriebsbereit ist, können Sie die folgenden Schritte ausführen: 

* Machen Sie sich mit der [{{ site.data.keys.mf_console }}](../../product-overview/components/console) vertraut. 
* Nutzen Sie die [Lernprogramme für den Schnelleinstieg](../../quick-start), um Erfahrungen mit der Mobile Foundation zu sammeln.
* Arbeiten Sie alle [verfügbaren Lernprogramme](../../all-tutorials/) durch.
