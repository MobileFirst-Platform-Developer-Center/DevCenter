---
layout: tutorial
title: MobileFirst Analytics Receiver Server Installationshandbuch
breadcrumb_title: Installationshandbuch
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
{{ site.data.keys.mf_analytics_receiver_server }}
wird als Java-EE-Standard-WAR-Datei implementiert und geliefert. Der Server kann daher in einem der folgenden unterstützten Anwendungsserver
installiert werden: WebSphere Application Server,
WebSphere Application Server Liberty oder
Apache Tomcat (nur WAR-Dateien). 

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Systemvoraussetzungen](#system-requirements)
* [Hinweise zur Kapazität](#capacity-considerations)
* [{{ site.data.keys.mf_analytics_receiver }} in WebSphere Application Server Liberty installieren](#installing-mobilefirst-analytics-receiver-on-websphere-application-server-liberty)
* [{{ site.data.keys.mf_analytics_receiver }} in Tomcat installieren](#installing-mobilefirst-analytics-receiver-on-tomcat)
* [{{ site.data.keys.mf_analytics_receiver }} in WebSphere Application Server installieren](#installing-mobilefirst-analytics-receiver-on-websphere-application-server)
* [{{ site.data.keys.mf_analytics_receiver }} mit Ant-Tasks installieren](#installing-mobilefirst-analytics-receiver-with-ant-tasks)

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
* Ordnen Sie der JVM reichlich Kapazität (10.000) für die Skalierung der speicherinternen Warteschlange zu (was einem Xmx-Mindestwert von 6 GB entspricht).
* Wenn Sie BSD und Linux verwenden, müssen Sie den E/A-Scheduler Ihres Betriebssystems auf
**deadline** oder **noop** einstellen und nicht auf **cfq**.

## Hinweise zur Kapazität
{: #capacity-considerations }
Die Frage zur Kapazität wird am häufigsten gestellt. Wie viel Arbeitsspeicher ist erforderlich und wie viel Plattenspeicher? Wie viele Knoten werden benötigt? Die Antwort auf alle diese Fragen ist stets subjektiv. 

Der IBM {{ site.data.keys.mf_analytics_receiver }} erfordert keinen Plattenspeicher, weil er lediglich Protokolle von mobilen Anwendungen empfängt und an den Analyseserver weiterleitet. Es werden keine Ereignisdaten gespeichert. 

## {{ site.data.keys.mf_analytics_receiver }} in WebSphere Application Server Liberty installieren
{: #installing-mobilefirst-analytics-receiver-on-websphere-application-server-liberty }
Stellen Sie sicher, dass die WAR-Datei für den {{ site.data.keys.mf_analytics_receiver }} vorhanden ist. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../prod-env/appserver). Die Datei **analytics-receiver.war** befindet sich im Ornder `<MF-Server-Installationsverzeichnis>\analyticsreceiver`. Weitere Informationen zum Herunterladen und Installieren von
WebSphere Application Server Liberty finden Sie
im Artikel [About WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/) auf
IBM developerWorks.

1. Erstellen Sie einen Server. Führen Sie dazu in Ihrem Ordner `./wlp/bin`
den folgenden Befehl aus: 

   ```bash
   ./server create <Servername>
   ```

2. Installieren Sie die Features, indem Sie from Ihrem Ordner
`./bin` den folgenden Befehl ausführen: 

   ```bash
   ./featureManager install jsp-2.2 ssl-1.0 appSecurity-1.0 localConnector-1.0
   ```

3. Fügen Sie die Datei **analytics-receiver.war** zum Ordner `./usr/servers/<Servername>/apps` Ihres Liberty-Servers hinzu.
4. Ersetzen Sie den Inhalt des Tags **<featureManager>** durch die Datei `./usr/servers/<Servername>/server.xml` mit folgendem Inhalt:

   ```xml
   <featureManager>
        <feature>jsp-2.2</feature>
        <feature>ssl-1.0</feature>
        <feature>appSecurity-1.0</feature>
        <feature>localConnector-1.0</feature>
   </featureManager>
   ```

5. Konfigurieren Sie **analytics-receiver.war** in der Datei
`server.xml` als Anwendung mit rollenbasierter Sicherheit. Im folgenden Beispiel wird eine fest codierte Basisbenutzerregistry erstellt und jeder der Analyserollen ein Benutzer zugewiesen. 

   ```xml
   <application id="analytics-receiver" name="analytics-receiver" location="analytics-receiver.war" type="war">
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

7. Überprüfen Sie den Status, indem Sie die URL health aufrufen.

   ```bash
   http://localhost:9080/analytics-receiver/rest/data/health
   ```

Weitere Informationen zur Verwaltung von
WebSphere Application Server Liberty finden Sie unter
[Liberty-Profil über die Befehlszeile
verwalten](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_script.html) in der Produktdokumentation zu WebSphere Application Server.

## {{ site.data.keys.mf_analytics_receiver }} in Tomcat installieren
{: #installing-mobilefirst-analytics-receiver-on-tomcat }
Stellen Sie sicher, dass die WAR-Dateien
für {{ site.data.keys.mf_analytics_receiver }} vorhanden sind. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../prod-env/appserver). Die Datei **analytics-receiver.war** befindet sich im Ornder `<MF-Server-Installationsverzeichnis>\analyticsreceiver`. Weitere Informationen zum Herunterladen und Installieren von Tomcat finden Sie auf der Webseite von [Apache Tomcat](http://tomcat.apache.org/). Sie müssen die Version herunterladen, die Java 7 oder eine aktuellere Java-Version
unterstützt. Welche Tomcat-Version Java 7 unterstützt erfahren Sie unter
[Apache Tomcat
Versions](http://tomcat.apache.org/whichversion.html).

1. Fügen Sie die Datei **analytics-receiver.war** zum Tomcat-Ordner `webapps` hinzu.
2. Entfernen Sie in der Datei `conf/server.xml` das Kommentarzeichen vor dem folgenden Abschnitt, der in einem neu heruntergeladenen Tomcat-Archiv auf Kommentar gesetzt ist.

   ```xml
   <Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
   ```

3. Deklarieren Sie die beiden WAR-Dateien in der Datei `conf/server.xml` und definieren Sie eine Benutzerregistry. 

   ```xml
   <Context docBase ="analytics-receiver-service" path ="/analytics-receiver"></Context>
   <Realm className ="org.apache.catalina.realm.MemoryRealm"/>
   ```

   Das **MemoryRealm** erkennt die in der Datei
`conf/tomcat-users.xml` definierten Benutzer. Informationen zu weiteren verfügbaren Optionen finden Sie unter
[Apache Tomcat Realm
Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

4. Fügen Sie die folgenden Abschnitte zur Datei `conf/tomcat-users.xml` hinzu, um ein
**MemoryRealm** zu konfigurieren.
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
    * Starten Sie Ihren Tomcat Server und überprüfen Sie den Service, indem Sie die URL health aufrufen.

      ```text
      http://localhost:8080/analytics-receiver/rest/data/health
      ```

    Weitere Informationen zum Starten des Tomcat-Servers finden Sie auf der offiziellen Tomcat-Site,
z. B. unter [Apache Tomcat 7](http://tomcat.apache.org/tomcat-7.0-doc/introduction.html) für Tomcat
7.0.

## {{ site.data.keys.mf_analytics_receiver }} in WebSphere Application Server installieren
{: #installing-mobilefirst-analytics-receiver-on-websphere-application-server }
Die ersten Installationsschritte zur Beschaffung der Installationsartefakte (JAR- und EAR-Dateien) sind
unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../prod-env/appserver) beschrieben. Die Datei **analytics-receiver.war** befindet sich im Ornder `<MF-Server-Installationsverzeichnis>\analyticsreceiver`. 

In den folgenden Schritten ist beschrieben, wie die Analytics-EAR-Datei in
WebSphere Application Server installiert und ausgeführt wird.
Wenn Sie die einzelnen WAR-Dateien in
WebSphere Application Server installieren, führen Sie nach der Implementierung
nur die Schritte
2 bis 7 für die WAR-Datei **analytics-receiver** aus.


1. Implementieren Sie die WAR-Datei im Anwendungsserver, aber starten Sie sie nicht. Informationen
zur Installation einer EAR-Datei in
WebSphere Application Server
finden Sie unter
[Unternehmensanwendungen über die Konsole
installieren](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/trun_app_instwiz.html) in der Produktdokumentation zu WebSphere Application Server. 

2. Wählen Sie in der Liste **Unternehmensanwendungen** den Eintrag **MobileFirst Analytics Receiver** aus.

    ![Installation von WebSphere-Unternehmensanwendungen](install_webphere_ent_app.jpg)

3. Klicken Sie auf **Laden von Klassen und Erkennung von Dateiaktualisierungen**. 

    ![Laden von Klassen in WebSphere](install_websphere_class_load.jpg)

4. Setzen Sie die Reihenfolge für das Laden von Klassen auf **Übergeordnete zuletzt**.

    ![Reihenfolge für das Laden von Klassen ändern](install_websphere_app_class_load_order.jpg)

5. Klicken Sie auf **Zuordnung von Sicherheitsrollen zu Benutzern/Gruppen**, um den Benutzer mit Administratorberechtigung zuzuordnen. 

    ![Reihenfolge für das Laden von Klassen](install_websphere_sec_role.jpg)

6. Klicken Sie auf **Module verwalten**.

    ![Module in WebSphere verwalten](install_websphere_manage_modules.jpg)

7. Wählen Sie das Modul **analytics-receiver** aus und ändern Sie die
Reihenfolge der Klassenlader in **übergeordnete zuletzt**.

    ![Analytics-Modul in WebSphere](install_websphere_module_class_load_order.jpg)

8. Aktivieren Sie wie folgt die **Verwaltungssicherheit** und die **Anwendungssicherheit**
in der Administrationskonsole von WebSphere Application Server: 
    * Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. 
    * Im Menü **Sicherheit > Globale Sicherheit** müssen die Einträge **Verwaltungssicherheit aktivieren** und **Anwendungssicherheit aktivieren** ausgewählt sein.
    > **Hinweis**: Die Anwendungssicherheit kann erst aktiviert werden, wenn die **Verwaltungssicherheit** aktiviert ist. 
    * Klicken Sie auf
**OK** und speichern Sie die Änderungen.

9. Führen Sie die folgenden Schritte aus, um den Zugriff auf den Analytics Service über die Swagger-Dokumentation zu ermöglichen:
    * Klicken Sie auf **Server > Servertypen > WebSphere-Anwendungsserver** und wählen Sie in der Serverliste den Server aus, in dem der Analytics Service implementiert ist.
    * Klicken Sie unter **Serverinfrastruktur** auf **Java** und navigieren Sie zu **Java- und Prozessverwaltung > Prozessdefinition > Java Virtual Machine > Angepasste Eigenschaften**.
      - Definieren Sie die folgende angepasste Eigenschaft:<br/>
        **Eigenschaftsname:** *com.ibm.ws.classloader.strict*<br/>
        **Wert:** *true*

10. Starten Sie die Anwendung {{ site.data.keys.mf_analytics_receiver }} und prüfen Sie, ob die URL health im Browser aufgerufen werden kann: `http://<Hostname>:<Port>/analytics-receiver/rest/data/health`.

## {{ site.data.keys.mf_analytics_receiver }} mit Ant-Tasks installieren
{: #installing-mobilefirst-analytics-receiver-with-ant-tasks }
Stellen Sie sicher, dass die erforderliche WAR- und Konfigurationsdatei vorliegt: **analytics-receiver.war**. Weitere Informationen zu den Installationsartefakten
finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../../prod-env/appserver). Die Datei **analytics-receiver.war** finden Sie unter `MobileFirst_Platform_Server\AnalyticsReceiver`.

Sie müssen die Ant-Task auf dem Computer ausführen, auf dem der Anwendungsserver oder der Network Deployment Manager für WebSphere Application Server Network Deployment installiert ist. Wenn Sie die Ant-Task
von einem Computer aus starten möchten, auf dem
{{ site.data.keys.mf_server }} nicht
installiert ist, müssen Sie die Datei `\<MF-Server-Installationsverzeichnis\>/MobileFirstServer/mfp-ant-deployer.jar`
auf diesen Computer kopieren.


> **Hinweis**: **MF-Server-Installationsverzeichnis** steht hier für
das Verzeichnis, indem Sie {{ site.data.keys.mf_server }} installiert haben. 

1. Bearbeiten Sie das Ant-Script, das Sie später für die
Implementierung der WAR-Dateien von
{{ site.data.keys.mf_analytics_receiver }}
verwenden werden.
    * Sehen Sie sich die Beispielkonfigurationsdateien
unter [Beispielkonfigurationsdateien
für {{ site.data.keys.mf_analytics_receiver }}](../../installation-reference/#sample-configuration-files-for-mobilefirst-analytics) an.
    * Ersetzen Sie die Platzhalterwerte durch die Eigenschaften am Anfang der Datei.

    > **Hinweis**: Wenn Sie in den Werten der Ant-XML-Scripts die folgenden Sonderzeichen verwenden, müssen Sie sie mit Escapezeichen angeben:
    >
    > * Das Dollarzeichen ($) muss mit $$ angegeben werden, sofern Sie mit der Syntax ${variable}, die im Abschnitt [Properties](http://ant.apache.org/manual/properties.html) der Veröffentlichung "Apache Ant Manual" beschrieben ist, nicht explizit auf eine Ant-Variable verweisen möchten.
    > * Das Et-Zeichen (&) muss mit &amp; angegeben werden, sofern Sie nicht explizit auf eine XML-Entität verweisen möchten.
    > * Anführungszeichen (") müssen mit &quot; angegeben werden, es sei denn, sie werden in einer Zeichenfolge verwendet, die in Hochkommata gesetzt ist.

2. Führen Sie den folgenden Befehl aus, um die WAR-Datei zu implementieren:
   ```bash
   ant -f configure-appServer-analytics-receiver.xml install
   ```
    Sie finden den Ant-Befehl unter `MF-Server-Installationsverzeichnis/shortcuts`. Auf dem Server wird ein Knoten mit dem {{ site.data.keys.mf_analytics_receiver }} installiert. Bei Verwendung von WebSphere Application Server Network Deployment erfolgt die Installation in jedem Member eines Clusters.
3. Speichern Sie die Ant-Datei, damit sie Ihnen später für die Anwendung eines Fixpacks oder für ein Upgrade zur Verfügung steht. Wenn Sie die Kennwörter nicht speichern möchten, können Sie sie durch `************` (12 Sterne) ersetzen und eine interaktive Aufforderung zur Kennworteingabe verwenden.
