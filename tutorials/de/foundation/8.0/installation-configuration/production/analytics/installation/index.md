---
layout: tutorial
title: MobileFirst Analytics Server Installationshandbuch
breadcrumb_title: Installationshandbuch
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
{{ site.data.keys.mf_analytics_server }}
wird als Set von Java-EE-Dateien (Standard-WAR-Dateien) oder als eine EAR-Datei implementiert und geliefert. Der Server kann daher in einem der folgenden unterstützten Anwendungsserver
installiert werden: WebSphere Application Server,
WebSphere Application Server Liberty oder
Apache Tomcat (nur WAR-Dateien).

{{ site.data.keys.mf_analytics_server }} verwendet eine
eingebettete Elasticsearch-Bibliothek als Data-Store und für die Clusterverwaltung. Da diese Bibliothek als hochleistungsfähige speicherinterne Abfrage- und Suchmaschine verwendet werden soll, ist eine schnelle
Platten-E/A erforderlich. Aus dem Grund müssen für ein Produktionssystem einige Voraussetzungen erfüllt sein. Generell ist es sehr wahrscheinlich, dass Sie nicht genug Haupt- und Plattenspeicher haben (oder feststellen, dass die Platten-E/A Ihr Leistungsengpass ist), bevor
die CPU zum Problem wird. In einer Clusterumgebung benötigen Sie benachbarte Knoten, die schnell und zuverlässig sind.

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Systemvoraussetzungen](#system-requirements)
* [Hinweise zur Kapazität](#capacity-considerations)
* [{{ site.data.keys.mf_analytics }} in WebSphere Application Server Liberty installieren](#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
* [{{ site.data.keys.mf_analytics }} in Tomcat installieren](#installing-mobilefirst-analytics-on-tomcat)
* [{{ site.data.keys.mf_analytics }} in WebSphere Application Server installieren](#installing-mobilefirst-analytics-on-websphere-application-server)
* [{{ site.data.keys.mf_analytics }} mit Ant-Tasks installieren](#installing-mobilefirst-analytics-with-ant-tasks)
* [{{ site.data.keys.mf_analytics_server }} auf einem Server mit vorhandener Vorgängerversion installieren](#installing-mobilefirst-analytics-server-on-servers-running-previous-versions)

## Systemvoraussetzungen
{: #system-requirements }

### Betriebssysteme
{: #operating-systems }
* CentOS/RHEL 6.x/7.x
* Oracle Enterprise Linux 6/7 nur mit RHEL Kernel
* Ubuntu 12.04/14.04
* SLES 11/12
* OpenSuSE 13.2
* Windows Server 2012/R2
* Debian 7

### JVM
{: #jvm }
* Oracle JVM 1.7u55+
* Oracle JVM 1.8u20+
* IcedTea OpenJDK 1.7.0.55+

### Hardware
{: #hardware }
* Arbeitsspeicher: Mehr Arbeitsspeicher ist besser, aber nicht mehr als 64 GB pro Knoten. 32 GB und 16 GB sind auch akzeptabel.
Bei Weniger als 8 GB sind viele kleine Knoten im Cluster erforderlich. Mehr als 64 GB sind verschwenderisch und hinsichtlich der Art, wie Java den Arbeitsspeicher für Zeiger verwendet, auch problematisch.
* Platte: Verwenden Sie nach Möglichkeit SSDs oder, wenn SSDs nicht infrage kommen, schnell drehende herkömmliche Platten in einer RAID-0-Konfiguration.
* CPU: Die zentrale Verarbeitungseinheit ist tendenziell der Leistungsengpass. Verwenden Sie Systeme mit 2 bis 8 Kernen.
* Netz: Wenn Sie Ihren Cluster horizontal skalieren müssen, benötigen Sie ein schnelles und zuverlässiges Rechenzentrum mit
unterstützten Geschwindigkeiten von 1 bis 10 Gigabit (im Gigabit-Ethernet-Netz GbE).

### Hardwarekonfiguration
{: #hardware-configuration }
* Weisen Sie Ihrer JVM die Hälfte des verfügbaren Arbeitsspeichers zu, jedoch nicht mehr als 32 GB.
    * Setzen Sie die Umgebungsvariable **ES\_HEAP\_SIZE** auf 32g.
    * Legen Sie die JVM-Flags mit -Xmx32g -Xms32g fest.
* Inaktivieren Sie die Auslagerung auf Platte. Wenn das Betriebssystem die Möglichkeit hat, Heapspeicher auf Platte auszulagern und wieder zurückzuverlagern, sinkt die Leistung
beträchtlich.
    * Verwenden Sie für eine temporäre Lösung `sudo swapoff -a`.
    * Bearbeiten Sie für eine dauerhafte Lösung **/etc/fstab** gemäß der Beschreibung in der Betriebssystemdokumentation.
    * Wenn keine dieser Optionen infrage kommt, definieten Sie die Elasticsearch-Option **bootstrap.mlockall:
true**.  (Dieser Wert ist der Standardwert in der eingebetteten Elasticsearch-Instanz.)
* Erhöhen Sie die zulässige Anzahl offener Dateideskriptoren.
    * Linux begrenzt die offenen Dateideskriptoren pro Prozess auf lediglich 1024.
    * Lesen Sie in Ihrer Betriebssystemdokumentation nach, wie dieser Wert dauerhaft drastisch erhöht werden kann, sagen wir auf
64.000.
* Elasticsearch verwendet eine Mischung aus NioFS und MMapFS für die diversen Dateien. Erhöhen Sie die maximale Anzahl der Dateizuordnungen so, dass
ausreichend virtueller Speicher für mit mmap zugeordnete Dateien verfügbar ist.
    * Verwenden Sie für eine temporäre Lösung `sysctl -w vm.max_map_count=262144`.
    * Für eine dauerhafte Lösung müssen Sie die Einstellung **vm.max\_map\_count** in Ihrer Datei
**/etc/sysctl.conf** modifizieren.
* Wenn Sie BSD und Linux verwenden, müssen Sie den E/A-Scheduler Ihres Betriebssystems auf
**deadline** oder **noop** einstellen und nicht auf **cfq**.

## Hinweise zur Kapazität
{: #capacity-considerations }
Die Frage zur Kapazität wird am häufigsten gestellt. Wie viel Arbeitsspeicher ist erforderlich und wie viel Plattenspeicher? Wie viele Knoten werden benötigt? Die Antwort auf alle diese Fragen lautet: Es kommt darauf an.

Mit BM {{ site.data.keys.mf_analytics }} haben Sie die Möglichkeit,
viele heterogene Ereignistypen zu erfassen, z. B. unformatierte Client-SDK-Debugprotokolle, vom Server gemeldete Netzereignisse,
kundendspeifische Daten und vieles mehr. Da es sich um ein großes Datensystem handelt, gelten entsprechend hohe Systemanforderungen.

Welche Art von Daten und wie viele Daten Sie erfassen und wie lange Sie diese erfassten Daten aufbewahren, hat einen
entscheidenden Einfluss auf Ihren Speicherbedarf und auf die Gesamtleistung. Beschäftigen Sie sich beispielsweise näher mit folgenen Fragen:

* Sind unformatierte Debugclientprotokolle nach einem Monat noch sinnvoll?
* Verwenden Sie das **Alert**-Feature
in {{ site.data.keys.mf_analytics }}?
Wenn ja, fragen Sie Ereignisse der letzten Minuten oder länger zurückliegende Ereignisse ab?
* Verwenden Sie kundenspezifische Diagramme? Wenn ja, erstellen Sie diese Diagramme für integrierte Daten oder für Schlüssel-Wert-Paare einer kundenspezifischen
Instrumentierung? Wie lange bewahren Sie die Daten auf?

Für die Darstellung der integrierten Diagramme in der {{ site.data.keys.mf_analytics_console }}
werden die Daten abgefragt, die {{ site.data.keys.mf_analytics_server }}
bereits für eine schnelle Anzeige für den Konsolenbenutzer zusammengefasst und optimiert hat.
Diese für die integrierten Diagramme vorab zusammengefassten und optimierten Daten sind nicht für Alerts oder kundenspezifische Diagramme geeignet, bei denen der Konsolenbenutzer die Abfragen definiert.

Wenn Sie unformatierte Dokumente abfragen, Filter anwenden, Daten zusammenfassen und die zugrunde liegende Abfrageengine auffordern, Durchschnittswerte und Prozentsätze zu berechnen, geht die
Abfrageleistung notwendigerweise zurück. Dieser Anwendungsfall ist es, der hinsichtlich der Kapazität gründlich durchdacht werden muss. Wenn Ihre Abfrageleistung ungenügend ist, müssen Sie entscheiden, ob Sie alte Daten
wirklich zur Anzeige in einer Konsole für Echtzeitdarstellungen aufbewahren wollen oder ob diese Daten
aus dem {{ site.data.keys.mf_analytics_server }} gelöscht werden sollen.
Ist eine echtzeitorientierte Konsolendarstellung wirlich für Monate zurückliegende Daten nützlich?

### Indizes, Shards und Knoten
{: #indicies-shards-and-nodes }
Der zugrunde liegende Data-Store ist Elasticsearch. Sie müssen sich ein wenig mit Indizes, Shards und Knoten auskennen und wissen, wie die Konfiguration die Leistung
beeinflusst. Einen Index können Sie sich in etwa als eine logische Dateneinheit vorstellen. Ein Index hat eine Eins-zu-viele-Zuordnung zu Shards, wobei
der Konfigurationsschlüssel shards lautet. {{ site.data.keys.mf_analytics_server }}
erstellt pro Dokumenttyp einen gesonderten Index. Wenn in Ihrer Konfiguration keine Dokumenttypen gelöscht werden, entspricht die Anzahl der erstellten Indizes der
Anzahl der von
{{ site.data.keys.mf_analytics_server }} angebotenen Dokumenttypen.

Wenn Sie shards auf 1 setzen, hat jeder Index immer nur ein primäres Shard, in das Daten geschrieben werden. Wenn Sie
shards auf 10 setzen, stehen jedem Index 10 Shards zur Verfügung. Wenn Sie allerdings nur einen Knoten haben, bedeuten mehr Shards Leistungseinbußen. Dieser eine Knoten müsste
jeden Index jetzt ausgewogen auf 10 Shards auf derselben physischen Platte verteilen. Setzen Sie shards nur auf
10, wenn Sie eine sofortige (oder umgehende) vertikale Skalierung auf zehn physische Knoten im Cluster planen.

Dasselbe Prinzip gilt für Replikate (**replicas**). Setzen Sie **replicas** nur auf einen Wert größer als 10, wenn Sie
eine sofortige (oder umgehende) vertikale Skalierung auf eine entsprechende Knotenzahl planen.   
Wenn Sie **shards** beispielsweise auf 4 und **replicas** auf 2 setzen, können Sie auf acht (4 * 2) Knoten skalieren.

## MobileFirst Analytics in WebSphere Application Server Liberty installieren
{: #installing-mobilefirst-analytics-on-websphere-application-server-liberty }
Stellen Sie sicher, dass die EAR-Datei für {{ site.data.keys.mf_analytics }} vorhanden ist. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../appserver). Die Datei **analytics.ear** befindet sich im Ordner **<MF-Server-Installationsverzeichnis>\analytics**. Weitere Informationen zum Herunterladen und Installieren von
WebSphere Application Server Liberty finden Sie
im Artikel [About WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/) auf
IBM developerWorks.

1. Erstellen Sie einen Server. Führen Sie dazu in Ihrem Ordner **./wlp/bin**
den folgenden Befehl aus:

   ```bash
   ./server create <Servername>
   ```

2. Installieren Sie die genannten Features, indem Sie in Ihrem Ordner
**./bin** den folgenden Befehl ausführen:

   ```bash
   ./featureManager install jsp-2.2 ssl-1.0 appSecurity-1.0 localConnector-1.0
   ```

3. Fügen Sie die Datei **analytics.ear** zum Ordner
**./usr/servers/<Servername>/apps** Ihres Liberty-Servers hinzu.
4. Ersetzen Sie den Inhalt des Tags `<featureManager>` durch die Datei **./usr/servers/<Servername>/server.xml** mit folgendem Inhalt:

   ```xml
   <featureManager>
        <feature>jsp-2.2</feature>
        <feature>ssl-1.0</feature>
        <feature>appSecurity-1.0</feature>
        <feature>localConnector-1.0</feature>
   </featureManager>
   ```

5. Konfigurieren Sie **analytics.ear** in der Datei
**server.xml** als Anwendung mit rollenbasierter Sicherheit. Im folgenden Beispiel wird eine fest codierte Basisbenutzerregistry erstellt und jeder der Analyserollen ein Benutzer zugewiesen.

   ```xml
   <application location="analytics.ear" name="analytics-ear" type="ear">
        <application-bnd>
            <security-role name="analytics_administrator">
                <user name="admin"/>
            </security-role>
            <security-role name="analytics_infrastructure">
                <user name="infrastructure"/>
            </security-role>
            <security-role name="analytics_support">
                <user name="support"/>
            </security-role>
            <security-role name="analytics_developer">
                <user name="developer"/>
            </security-role>
            <security-role name="analytics_business">
                <user name="business"/>
            </security-role>
        </application-bnd>
   </application>

   <basicRegistry id="worklight" realm="worklightRealm">
        <user name="business" password="demo"/>
        <user name="developer" password="demo"/>
        <user name="support" password="demo"/>
        <user name="infrastructure" password="demo"/>
        <user name="admin" password="admin"/>
   </basicRegistry>
   ```

   > Weitere Informationen zum Konfigurieren von Benutzerregistrytypen wie LDAP finden Sie in unter
[Benutzerregistry für das
Liberty-Profil konfigurieren](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.iseries.doc/ae/twlp_sec_registries.html) in der Produktdokumentation zu
WebSphere Application Server.

6. Starten Sie den Liberty-Server. Führen Sie dazu in Ihrem Ordner
**bin** den folgenden Befehl aus:

   ```bash
   ./server start <Servername>
   ```

7. Rufen Sie die {{ site.data.keys.mf_analytics_console }} auf.

   ```bash
   http://localhost:9080/analytics/console
   ```

Weitere Informationen zur Verwaltung von
WebSphere Application Server Liberty finden Sie unter
[Liberty-Profil über die Befehlszeile
verwalten](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_script.html) in der Produktdokumentation zu WebSphere Application Server.

## {{ site.data.keys.mf_analytics }} in Tomcat installieren
{: #installing-mobilefirst-analytics-on-tomcat }
Stellen Sie sicher, dass die WAR-Dateien
für {{ site.data.keys.mf_analytics }} vorhanden sind. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../appserver). Die Dateien
**analytics-ui.war** und **analytics-service.war** befinden sich im Ordner **<MF-Server-Installationsverzeichnis>\analytics**. Weitere Informationen zum Herunterladen und Installieren von Tomcat finden Sie auf der Webseite von [Apache Tomcat](http://tomcat.apache.org/). Sie müssen die Version herunterladen, die Java 7 oder eine aktuellere Java-Version
unterstützt. Welche Tomcat-Version Java 7 unterstützt erfahren Sie unter
[Apache Tomcat
Versions](http://tomcat.apache.org/whichversion.html).

1. Fügen Sie die Dateien **analytics-service.war** und **analytics-ui.war** zum Tomcat-Ordner **webapps** hinzu.
2. Entfernen Sie in der Datei **conf/server.xml** das Kommentarzeichen vor dem folgenden Abschnitt, der in einem neu heruntergeladenen Tomcat-Archiv vorhanden, aber auf Kommentar gesetzt ist.

   ```xml
   <Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

3. Deklarieren Sie die beiden WAR-Dateien in der Datei **conf/server.xml** und definieren Sie eine Benutzerregistry.

   ```xml
   <Context docBase ="analytics-service" path ="/analytics-service"></Context>
   <Context docBase ="analytics" path ="/analytics"></Context>
   <Realm className ="org.apache.catalina.realm.MemoryRealm"/>
   ```

   Das **MemoryRealm** erkennt die in der Datei **conf/tomcat-users.xml** definierten Benutzer. Weitere Informationen zu anderen Möglichkeiten finden Sie unter [Apache Tomcat Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

4. Fügen Sie die folgenden Abschnitte zur Datei **conf/tomcat-users.xml** hinzu, um ein **MemoryRealm** zu konfigurieren.
    * Fügen Sie die Sicherheitsrollen hinzu.

      ```xml
      <role rolename="analytics_administrator"/>
      <role rolename="analytics_infrastructure"/>
      <role rolename="analytics_support"/>
      <role rolename="analytics_developer"/>
      <role rolename="analytics_business"/>
      ```
    * Fügen Sie ein paar Benutzer mit den gewünschten Rollen hinzu.

      ```xml
      <user name="admin" password="admin" roles="analytics_administrator"/>
      <user name="support" password="demo" roles="analytics_support"/>
      <user name="business" password="demo" roles="analytics_business"/>
      <user name="developer" password="demo" roles="analytics_developer"/>
      <user name="infrastructure" password="demo" roles="analytics_infrastructure"/>
      ```    
    * Starten Sie Ihren Tomcat-Server und öffnen Sie die {{ site.data.keys.mf_analytics_console }}.

      ```xml
      http://localhost:8080/analytics/console
      ```

    Weitere Informationen zum Starten des Tomcat-Servers finden Sie auf der offiziellen Tomcat-Site, z. B. unter [Apache Tomcat 7](http://tomcat.apache.org/tomcat-7.0-doc/introduction.html) für Tomcat 7.0.

## {{ site.data.keys.mf_analytics }} in WebSphere Application Server installieren
{: #installing-mobilefirst-analytics-on-websphere-application-server }
Die ersten Installationsschritte zur Beschaffung der Installationsartefakte (JAR- und EAR-Dateien) sind
unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../appserver) beschrieben. Die Dateien
**analytics.ear**, **analytics-ui.war** und **analytics-service.war** befinden sich im Ordner
**<MF-Installationsverzeichnis>\analytics**.

In den folgenden Schritten ist beschrieben, wie die Analytics-EAR-Datei in
WebSphere Application Server installiert und ausgeführt wird.
Wenn Sie die einzelnen WAR-Dateien in
WebSphere Application Server installieren, führen Sie nach der Implementierung beider WAR-Dateien
nur die Schritte
2-7 für die WAR-Datei **analytics-service** aus.
Für die WAR-Datei analytics-ui darf die Klassenladereihenfolge nicht geändert werden.

1. Implementieren Sie die EAR-Datei im Anwendungsserver, aber starten Sie sie nicht.. Weitere Informationen
zur Installation einer EAR-Datei in
WebSphere Application Server
finden Sie unter
[Unternehmensanwendungen über die Konsole
installieren](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_instwiz.html) in der Produktdokumentation zu WebSphere Application Server.

2. Wählen Sie in der Liste **Unternehmensanwendungen** den Eintrag **MobileFirst Analytics** aus.

    ![Installation von WebSphere-Unternehmensanwendungen](install_webphere_ent_app.jpg)

3. Klicken Sie auf **Laden von Klassen und Erkennung von Dateiaktualisierungen**.

    ![Laden von Klassen in WebSphere](install_websphere_class_load.jpg)

4. Setzen Sie die Reihenfolge für das Laden von Klassen auf **Übergeordnete zuletzt**.

    ![Reihenfolge für das Laden von Klassen ändern](install_websphere_app_class_load_order.jpg)

5. Klicken Sie auf **Zuordnung von Sicherheitsrollen zu Benutzern/Gruppen**, um den Benutzer mit Administratorberechtigung zuzuordnen.

    ![Reihenfolge für das Laden von Klassen](install_websphere_sec_role.jpg)

6. Klicken Sie auf **Module verwalten**.

    ![Module in WebSphere verwalten](install_websphere_manage_modules.jpg)

7. Wählen Sie das Modul **analytics** aus und ändern Sie die
Reihenfolge der Klassenlader in **übergeordnete zuletzt**.

    ![Analytics-Modul in WebSphere](install_websphere_module_class_load_order.jpg)

8. Aktivieren Sie wie folgt die **Verwaltungssicherheit** und die **Anwendungssicherheit**
in der Administrationskonsole von WebSphere Application Server:
    * Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an.
    * Im Menü **Sicherheit > Globale Sicherheit** müssen die Einträge
**Verwaltungssicherheit aktivieren** und **Anwendungssicherheit aktivieren** ausgewählt sein.
Hinweis: Die Anwendungssicherheit kann erst aktiviert werden, wenn die **Verwaltungssicherheit** aktiviert ist.
    * Klicken Sie auf
**OK** und speichern Sie die Änderungen.
9. Starten Sie die Anwendung {{ site.data.keys.mf_analytics }} und öffnen Sie im Browser den Link `http://<Hostname>:<Port>/analytics/console`.

## {{ site.data.keys.mf_analytics }} mit Ant-Tasks installieren
{: #installing-mobilefirst-analytics-with-ant-tasks }
Stellen Sie sicher, dass die erforderlichen WAR-Dateien und Konfigurationsdateien vorliegen:
**analytics-ui.war** und **analytics-service.war**. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../appserver). Die Dateien
**analytics-ui.war** und **analytics-service.war** befinden sich im Ordner
**MobileFirst_Platform_Server\analytics**.

Sie müssen die Ant-Task auf dem Computer ausführen, auf dem der
Anwendungsserver oder der Network
Deployment Manager für
WebSphere Application Server Network Deployment installiert ist. Wenn Sie die Ant-Task
von einem Computer aus starten möchten, auf dem
{{ site.data.keys.mf_server }} nicht
installiert ist, müssen Sie die Datei **<MF-Server-Installationsverzeichnis>/MobileFirstServer/mfp-ant-deployer.jar**
auf diesen Computer kopieren.


> Hinweis: Der Platzhalter **MF-Server-Installationsverzeichnis** steht für
das Verzeichnis, indem Sie {{ site.data.keys.mf_server }} installiert haben.

1. Bearbeiten Sie das Ant-Script, das Sie später für die
Implementierung der WAR-Dateien von
{{ site.data.keys.mf_analytics }}
verwenden werden.
    * Sehen Sie sich die Beispielkonfigurationsdateien
unter [Beispielkonfigurationsdateien
für {{ site.data.keys.mf_analytics }}](../../installation-reference/#sample-configuration-files-for-mobilefirst-analytics) an.
    * Ersetzen Sie die Platzhalterwerte durch die Eigenschaften am Anfang der Datei.

    > Hinweis: Wenn Sie in den Werten der Ant-XML-Scripts die folgenden Sonderzeichen verwenden, müssen Sie sie mit Escapezeichen angeben:

    >
    > * Das Dollarzeichen ($) muss mit $$ angegeben werden, sofern Sie mit der Syntax
${variable}, die im Abschnitt
[Properties](http://ant.apache.org/manual/properties.html) der Veröffentlichung
"Apache Ant Manual" beschrieben ist, nicht explizit auf eine Ant-Variable verweisen möchten.

    > * Das Et-Zeichen (&) muss mit
&amp; angegeben werden, sofern Sie nicht explizit auf eine XML-Entität verweisen möchten.
    > * Anführungszeichen (") müssen mit &quot; angegeben werden, es sei denn, sie werden in einer Zeichenfolge verwendet, die in Hochkommata gesetzt ist.

2. Installation eines Clusters mit Knoten auf mehreren Servern:
    * Sie müssen das Kommentarzeichen vor der Eigenschaft **wl.analytics.masters.list** entfernen und als Wert der Eigenschaft
die Liste der Hostnamen und Transportports der Masterknoten angeben. Beispiel: `node1.mycompany.com:96000,node2.mycompany.com:96000`
    * Fügen Sie in den Tasks **installanalytics**, **updateanalytics** und
**uninstallanalytics** das Attribut **mastersList** zu den **elasticsearch**-Elementen
hinzu.

    **Hinweis:** Wenn Sie die Eigenschaft bei einer Installation in einem Cluster mit WebSphere Application Server Network Deployment
nicht definieren, berechnet die Ant-Task die Datenendpunkte für alle Member des Clusters zum Zeitpunkt der Installation und setzt die JNDI-Eigenschaft
**masternodes** auf diesen Wert.


3. Führen Sie zum Implementieren der WAR-Dateien den folgenden Befehl aus: `ant -f configure-appServer-analytics.xml install`
    Den Ant-Befehl finden Sie unter **MF-Server-Installationsverzeichnis/shortcuts**. Auf dem Server wird ein Knoten mit {{ site.data.keys.mf_analytics }}
vom Standardmastertyp und mit dem Standarddatentyp installiert. Bei Verwendung von WebSphere Application Server Network Deployment
 erfolgt die Installation in jedem Member eines Clusters.
4. Speichern Sie die Ant-Datei, damit sie Ihnen später für die Anwendung eines Fixpacks oder für ein Upgrade zur Verfügung steht. Wenn Sie die Kennwörter nicht speichern möchten, können Sie sie durch
"************" (12 Sterne) ersetzen und eine interaktive Aufforderung zur Kennworteingabe verwenden.

    **Hinweis:** Wenn Sie zu einem Cluster mit {{ site.data.keys.mf_analytics }} einen Knoten
hinzufügen, müssen Sie die JNDI-Eigenschaft analytics/masternodes aktualisieren. Die Eigenschaft muss die Ports aller Masterknoten im Cluster
enthalten.

## {{ site.data.keys.mf_analytics_server }} auf einem Server mit vorhandener Vorgängerversion installieren
{: #installing-mobilefirst-analytics-server-on-servers-running-previous-versions }
Wenn Sie
{{ site.data.keys.mf_analytics_server }} Version 8.0.0
installieren, besteht keine Möglichkeit, auf einem Server mit vorhandener Vorgängerversion ein Upgrade für
{{ site.data.keys.mf_analytics_server }} durchzuführen.
Sie können jedoch einige Eigenschaften und Analysedaten migrieren.

Auf Servern, auf denen eine frühere Version von
{{ site.data.keys.mf_analytics_server }} ausgeführt wird,
können Sie die Analysedaten und JNDI-Eigenschaften aktualisieren.

### Von Vorgängerversionen des {{ site.data.keys.mf_analytics_server }} verwendete Servereigenschaften migrieren
{: #migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server }
Wenn Sie {{ site.data.keys.mf_analytics_server }} Version 8.0.0 auf einem Server installieren, auf dem bereits eine
frühere Version von
{{ site.data.keys.mf_analytics_server }} ausgeführt wurde, müssen Sie auf diesem Server die Werte
der JNDI-Eigenschaften aktualisieren.

Einige Ereignistypen haben sich in Version 8.0.0 gegenüber den älteren Versionen von {{ site.data.keys.mf_analytics_server }} geändert. Aufgrund dieser Änderung müssen alle JNDI-Eigenschaften, die bisher in Ihrer Serverkonfiguration definiert waren, auf den neuen Ereignistyp umgestellt werden.

In der folgenden Tabelle sind die alten Ereignistypen den neuen Typen zugeordnet. Einige Ereignistypen haben sich nicht geändert.

| Alter Ereignistyp| Neuer Ereignistyp|
|---------------------------|------------------------|
| AlertDefinition	        | AlertDefinition|
| AlertNotification	        | AlertNotification|
| AlertRunnerNode	        | AlertRunnerNode|
| AnalyticsConfiguration| AnalyticsConfiguration|
| CustomCharts	            | CustomChart|
| CustomData	            | CustomData|
| Devices	                | Device|
| MfpAppLogs| AppLog|
| MfpAppPushAction| AppPushAction|
| MfpAppSession	            | AppSession|
| ServerLogs	            | ServerLog|
| ServerNetworkTransactions| NetworkTransaction|
| ServerPushNotifications| PushNotification|
| ServerPushSubscriptions| PushSubscription|
| Users	                    | User|
| inboundRequestURL	        | resourceURL|
| mfpAppName	            | appName|
| mfpAppVersion	            | appVersion|

### Migration von Analysedaten
{: #analytics-data-migration }
Die {{ site.data.keys.mf_analytics_console }}
wurde intern verbessert. Dabei musste das Speicherformat der Daten geändert werden. Die Daten müssen auf das neue
Datenformat umgestellt werden, damit weiterhin Interaktionen mit den bereits erfassten Analysedaten möglich sind.

Wenn Sie die {{ site.data.keys.mf_analytics_console }}
nach Ihrem Upgrade auf Version 8.0.0 zum ersten Mal anzeigen, werden
keine Statistiken ausgegeben.
Ihre Daten sind nicht verloren. Sie müssen aber auf das neue
Datenformat umgestellt werden.

Auf jeder Seite der {{ site.data.keys.mf_analytics_console }} wird ein Alert angezeigt, um Sie daran zu erinnern,
dass Dokumente migriert werden müssen. Der Alerttext enthält auch einen Link
zur Migrationsseite.

Die folgende Abbildung zeigt einen Beispielalert auf der Seite **Übersicht** im Abschnitt
**Dashboard**:

![Migrationsalert in der Konsole](migration_alert.jpg)

### Migrationsseite
{: #migration-page }
Sie können in der
{{ site.data.keys.mf_analytics_console }} über das Schraubenschlüsselsymbol auf die Migrationsseite zugreifen.
Auf der Migrationsseite wird angezeigt, wie viele Dokumente migriert werden müssen und in welchen Indizes sie gespeichert sind. Es ist
nur eine Aktion
verfügbar: **Migration durchführen**.

In der folgenden Abbildung sehen Sie die Migrationsseite, wie sie angezeigt wird, wenn Dokumente migriert werden müssen:

![Migrationsseite der Konsole](migration_page.jpg)

> **Hinweis:** Dieser Prozess dauert unter Umständen lange und kann nicht gestoppt werden. Die genaue Zeit hängt vom vorhandenen
Datenvolumen ab.


Die Migration von einer Million Dokumenten auf einem Knoten mit einem Arbeitsspeicher von
32 GB (wovon 16 GB der JVM zugeordnet sind) und einem Prozessor mit vier Kernen dauert ungefähr drei Minuten. Nicht umgestellte Dokumente werden nicht abgefragt und daher auch nicht
in der {{ site.data.keys.mf_analytics_console }} ausgegeben.

Wenn die Migration während des laufenden Prozesses fehlschlägt, wiederholen Sie sie. Bei dieser Wiederholung werden bereits umgestellte Dokumente nicht erneut migriert. Die Integrität Ihrer Daten bleibt gewahrt.
