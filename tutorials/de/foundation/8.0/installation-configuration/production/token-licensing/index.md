---
layout: tutorial
title: Installation und Konfiguration für Tokenlizenzierung
breadcrumb_title: Token licensing
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie die Tokenlizenzierung für {{ site.data.keys.mf_server }} verwenden möchten, müssen Sie die Bibliothek von Rational Common Licensing installieren und Ihren Anwendungsserver so konfigurieren, dass {{ site.data.keys.mf_server }} eine Verbindung zum Rational License Key Server herstellt.

In den folgenden Artikeln finden Sie eine Installationsübersicht. Außerdem erfahren Sie, wie die Bibliothek von Rational Common Licensing manuell installiert und der Anwendungsserver konfiguriert wird. Darüber hinaus gibt es eine Beschreibung der Plattformeinschränkungen für die Tokenlizenzierung.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Verwendung der Tokenlizenzierung planen](#planning-for-the-use-of-token-licensing)
* [Installationsübersicht für die Tokenlizenzierung](#installation-overview-for-token-licensing)
* [Verbindung zwischen dem in Apache Tomcat installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* [Verbindung zwischen dem in WebSphere Application Server Liberty Profile installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* [Verbindung zwischen dem in WebSphere Application Server installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)
* [Beschränkung hinsichtlich der unterstützten Plattformen für die Tokenlizenzierung](#limitations-of-supported-platforms-for-token-licensing)
* [Probleme mit der Tokenlizenzierung lösen](#troubleshooting-token-licensing-problems)

## Verwendung der Tokenlizenzierung planen
{: #planning-for-the-use-of-token-licensing }
Wenn Sie für {{ site.data.keys.mf_server }} die Tokenlizenzierung erworben haben, sind bei der Installationsplanung zusätzliche Schritte zu berücksichtigen. 

### Technische Beschränkungen
{: #technical-restrictions }
Nachfolgend sind die technischen Beschränkungen für die Nutzung der Tokenlizenzierung aufgeführt: 

#### Unterstützte Plattformen:
{: #supported-platforms }
Die Liste der Plattformen, die die Tokenlizenzierung unterstützen, finden Sie unter [Beschränkung hinsichtlich der unterstützten Plattformen für die Tokenlizenzierung](#limitations-of-supported-platforms-for-token-licensing). Für einen {{ site.data.keys.mf_server }}, der auf einer nicht aufgelisteten Plattform ausgeführt wird, kann möglicherweise keine Tokenlizenzierung installiert und konfiguriert werden. Es kann auch sein, dass die Bibliotheken für den Rational-Common-Licensing-Client für eine solche Plattform nicht verfügbar sind oder nicht unterstützt werden. 

#### Unterstützte Topologien: 
{: #supported-topologies }
Die für die Tokenlizenzierung unterstützten Topologien sind unter [Einschränkungen für den MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die {{ site.data.keys.product_adj }}-Laufzeit](../prod-env/topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) aufgelistet.

### Voraussetzung für den Netzbetrieb
{: #network-requirement }
{{ site.data.keys.mf_server }} muss mit dem Rational License Key Server kommunizieren können. 

Für diese Kommunikation ist der Zugriff auf die beiden folgenden Ports des Lizenzservers erforderlich: 

* Port des Lizenzmanagerdämons (**lmgrd**), standardmäßig 27000
* Port von Vendor Daemon (**ibmratl**)

Wie Sie die Ports so konfigurieren können, dass sie statische Werte verwenden, erfahren Sie unter "How to serve a license key to client machines through a firewall". 

### Installationsprozess
{: #installation-process }
Wenn Sie IBM Installation Manager ausführen, müssen Sie die Tokenlizenzierung während der Installation aktivieren. Genaue Anweisungen für die Aktivierung der Tokenlizenzierung finden Sie in der [Installationsübersicht für die Tokenlizenzierung](#installation-overview-for-token-licensing). 

Wenn {{ site.data.keys.mf_server }} installiert ist, müssen Sie den Server manuell für die Tokenlizenzierung konfigurieren. Weitere Infromationen finden Sie auf dieser Seite in den folgenden Abschnitten. 

{{ site.data.keys.mf_server }} ist erst funktionsbereit, wenn diese manuelle Konfiguration abgeschlossen ist. Die Bibliothek für den Rational-Common-Licensing-Client muss in Ihrem Anwendungsserver installiert werden, und Sie bestimmen die Position für Rational License Key Server. 

### Operationen
{: #operations }
Wenn Sie {{ site.data.keys.mf_server }} für die Tokenlizenzierung installiert und konfiguriert haben, werden Lizenzen in verschiedenen Szenarien vom Server validiert. Weitere Ifnormationen zum Abrufen von Token während der Ausführung von Operationen finden Sie unter [Validierung von Tokenlizenzen](../../../administering-apps/license-tracking/#token-license-validation). 

Wenn Sie auf einem Produktionsserver mit aktivierter Tokenlizenzierung eine Anwendung testen müssen, die keine Produktionsanwendung ist, können Sie die Anwendung entsprechend deklarieren. Weitere Informationen zum Deklarieren des Anwendungstyps finden Sie unter [Anwendungslizenzinformationen definieren](../../../administering-apps/license-tracking/#setting-the-application-license-information).

## Installationsübersicht für die Tokenlizenzierung
{: #installation-overview-for-token-licensing }
Wenn Sie planen, die Tokenlizenzierung mit der {{ site.data.keys.product }} zu verwenden, gehen Sie die folgenden vorläufigen Schritte in der hier angegebenen Reihenfolge durch. 

> **Wichtiger Hinweis:** Ihre während einer Installation mit Unterstützung für die Tokenlizenzierung getroffene Entscheidung über die Tokenlizenzierung (Aktivierung oder keine Aktivierung) kann nicht geändert werden. Wenn Sie die Tokenlizenzierungsoption später ändern wollen, müssen Sie die {{ site.data.keys.product }} deinstallieren und erneut installieren.


1. Aktivieren Sie die Tokenlizenzierung, wenn Sie IBM Installation Manager für die Installation der {{ site.data.keys.product }} ausführen.

   #### Installation im Grafikmodus
   Wenn Sie das Produkt im Grafikmodus installieren, wählen Sie während der Installation in der Anzeige **Allgemeine Einstellungen** die Option **Activate token licensing with the Rational License Key Server** aus. 

   ![Tokenlizenzierung in IBM Installation Manager aktivieren](licensing_with_tokens_activate.jpg)

   #### Installation im Befehlszeilenmodus
   Wenn Sie eine unbeaufsichtigte Installation durchführen, geben Sie in der Antwortdatei für den Parameter **user.licensed.by.tokens** den Wert **true** an.   
Sie können beispielsweise folgenden Befehl verwenden: 

   ```bash
   imcl install com.ibm.mobilefirst.foundation.server -repositories MFP-Repositoryverzeichnis/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.use.ios.edition=false,user.licensed.by.tokens=true -acceptLicense
      ```

2. Implementieren Sie nach Abschluss der Produktinstallation {{ site.data.keys.mf_server }} in einem Anwendungsserver. Weitere Informationen finden Sie unter [{{ site.data.keys.mf_server }} in einem Anwendungsserver installieren](../prod-env/appserver).

3. Konfigurieren Sie {{ site.data.keys.mf_server }} für die Tokenlizenzierung. Welche Schritte Sie ausführen müssen, hängt von Ihrem Anwendungsserver ab.

* WebSphere Application Server Liberty Profile: [Verbindung zwischen dem in WebSphere Application Server Liberty Profile installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server)
* Apache Tomcat: [Verbindung zwischen dem in Apache Tomcat installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server)
* WebSphere Application Server Full Profile: [Verbindung zwischen dem in WebSphere Application Server installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen](#connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server)

## Verbindung zwischen dem in Apache Tomcat installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen
{: #connecting-mobilefirst-server-installed-on-apache-tomcat-to-the-rational-license-key-server }
Sie müssen die nativen und Java-Bibliotheken von Rational Common Licensing im Anwendungsserver Apache Tomcat installieren, bevor Sie eine Verbindung vom {{ site.data.keys.mf_server }} zum Rational License Key Server herstellen.

* Rational License Key Server ab Version 8.1.4.8 muss installiert und konfiguriert sein. Über das Netz müssen Übertragungen zum und vom {{ site.data.keys.mf_server }} möglich sein. Dazu werden die Ports für wechselseitige Übertragung (**lmrgd** und **ibmratl**) geöffnet. Weitere Informationen finden Sie im [Portal für Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) und unter [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vergewissern Sie sich, dass die Lizenzschlüssel für die {{ site.data.keys.product }} generiert wurden. Weitere Informationen zum Generieren und Verwalten Ihrer Lizenzschlüssel mit dem IBM Rational License Key Center finden Sie unter [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) und [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} muss in Ihrem Apache Tomcat installiert und mit der Option Activate token licensing with the Rational License Key Server konfiguriert sein (siehe [Installationsübersicht für die Tokenlizenzierung](#installation-overview-for-token-licensing)).

### Bibliotheken von Rational Common Licensing installieren
{: #installing-rational-common-licensing-libraries }

1. Wählen Sie die native Bibliothek von Rational Common Licensing aus. Wählen Sie abhängig von Ihrem Betriebssystem und von der Bitversion der Java Runtime Environment (JRE), in der Ihr Apache Tomcat ausgeführt wird, unter **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs/bin/Ihre_Plattform/native_Bibliotheksdatei** die richtige native Bibliothek aus. Für Linux x86 mit einer 64-Bit-JRE finden Sie die Bibliothek beispielsweise in **Produktinstallationsverzeichnis/MobileFirstServer/tokensLibs/bin/Linux\_x86\_64/librcl\_ibmratl.so**.
2. Kopieren Sie die native Bibliothek auf den Computer, auf dem der Verwaltungsservice von {{ site.data.keys.mf_server }} ausgeführt wird. Das Verzeichnis könnte **${CATALINA_HOME}/bin** sein.
    > **Hinweis:** **${CATALINA_HOME}** ist das Installationsverzeichnis für Ihren Apache Tomcat.
3. Kopieren Sie die Datei **rcl_ibmratl.jar** in den Ordner **${CATALINA_HOME}/lib**. Die Datei **rcl_ibmratl.jar** ist eine Java-Bibliothek von Rational Common Licensing, die sich im Verzeichnis **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs** befindet. Die Bibliothek verwendet die native Bibliothek, die Sie in Schritt 2 kopiert haben. Sie kann nur einmal von Apache Tomcat geladen werden. Diese Datei muss sich im Verzeichnis **${CATALINA_HOME}/lib** befinden oder in einem Verzeichnis, das im Pfad des allgemeinen Klassenladers von Apache Tomcat enthalten ist.
    > **Wichtiger Hinweis:** Für die Java Virtual Machine (JVM) von Apache Tomcat sind Lese- und Ausführungsrechte für die kopierte native Bibliothek und die Java-Bibliothek erforderlich. Für die beiden kopierten Dateien muss es auch in Ihrem Betriebssystem (zumindest für den Anwendungsserverprozess) eine Lese- und Ausführungsberechtigung geben.
4. Konfigurieren Sie für die JVM Ihres Anwendungsservers den Zugriff auf die Bibliothek von Rational Common Licensing. Konfigurieren für alle Betriebssysteme die Datei **${CATALINA_HOME}/bin/setenv.bat** (oder **setenv.sh** unter UNIX), indem Sie die folgende Zeile hinzufügen:

   **Windows:**  

   ```bash
   set CATALINA_OPTS=%CATALINA_OPTS% -Djava.library.path=absoluter_Pfad_zum_zuvor_erstellten_Verzeichnis_bin
   ```

   **UNIX:**

   ```bash
   CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=absoluter_Pfad_zum_zuvor_erstellten_Verzeichnis_bin"
   ```

   > **Hinweis:** Wenn Sie den Konfigurationsordner des Servers, auf dem der Verwaltungsservice ausgeführt wird, verschieben, müssen Sie **java.library.path** aktualisieren und den neuen absoluten Pfad angeben.



5. Konfigurieren Sie{{ site.data.keys.mf_server }} für den Zugriff auf Rational License Key Server. Suchen Sie in der Datei **${CATALINA_HOME}/conf/server.xml** nach dem Element `Context` der Anwendung für die Verwaltungservices und fügen Sie die folgenden JNDI-Konfigurationszeilen hinzu:

   ```xml
   <Environment name="mfp.admin.license.key.server.host" value="RLKS-Hostname" type="java.lang.String" override="false"/>
   <Environment name="mfp.admin.license.key.server.port" value="RLKS-Port" type="java.lang.String" override="false"/>
   ```
   * **RLKS-Hostname** ist der Hostname von Rational License Key Server.
   * **RLKS-Port** ist der Port von Rational License Key Server. Der Standardwert ist **27000**.

Weitere Informationen finden Sie unter [JNDI-Eigenschaften für Verwaltungsservices: Lizenzierung](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installation in einer Apache-Tomcat-Server-Farm
{: #installing-on-apache-tomcat-server-farm }
Wenn Sie die Verbindung von {{ site.data.keys.mf_server }} in einer Apache-Tomcat-Server-Farm konfigurieren möchten, müssen Sie für jeden Knoten Ihrer Server-Farm, auf dem der MobileFirst-Server-Verwaltungsservice ausgeführt wird, alle Schritte ausführen, die im Abschnitt [Bibliotheken von Rational Common Licensing installieren](#installing-rational-common-licensing-libraries) beschrieben sind. Weitere Informationen zu dieser Topologie finden Sie unter [Server-Farmtopologie](../prod-env/topologies/#server-farm-topology) und [Server-Farm installieren](../prod-env/appserver/#installing-a-server-farm).

## Verbindung zwischen dem in WebSphere Application Server Liberty Profile installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-liberty-profile-to-the-rational-license-key-server }
Sie müssen die nativen und Java-Bibliotheken von Rational Common Licensing in Liberty Profile installieren, bevor Sie eine Verbindung vom {{ site.data.keys.mf_server }} zum Rational License Key Server herstellen.

* Rational License Key Server ab Version 8.1.4.8 muss installiert und konfiguriert sein. Über das Netz müssen Übertragungen zum und vom {{ site.data.keys.mf_server }} möglich sein. Dazu werden die Ports für wechselseitige Übertragung (**lmrgd** und **ibmratl**) geöffnet. Weitere Informationen finden Sie im [Portal für Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) und unter [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vergewissern Sie sich, dass die Lizenzschlüssel für die {{ site.data.keys.product }} generiert wurden. Weitere Informationen zum Generieren und Verwalten Ihrer Lizenzschlüssel mit dem IBM Rational License Key Center finden Sie unter [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) und [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} muss in Ihrem Apache Tomcat installiert und mit der Option Activate token licensing with the Rational License Key Server konfiguriert sein (siehe [Installationsübersicht für die Tokenlizenzierung](#installation-overview-for-token-licensing)).

### Bibliotheken von Rational Common Licensing installieren
{: #common-licensing-libraries-liberty }

1. Definieren Sie für den Rational-Common-Licensing-Client eine gemeinsam genutzte Bibliothek. Diese Bibliothek verwendet nativen Code und kann nur einmal vom Anwendungsserver geladen werden. Anwendungen, die diese Bibliothek verwenden, müssen sie daher als eine gemeinsam genutzte Bibliothek referenzieren.
   * Wählen Sie die native Bibliothek von Rational Common Licensing aus. Wählen Sie abhängig von Ihrem Betriebssystem und von der Bitversion der Java Runtime Environment (JRE), in der Ihr Liberty Profile ausgeführt wird, unter **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs/bin/Ihre_Plattform/native_Bibliotheksdatei** die richtige native Bibliothek aus. Für Linux x86 mit einer 64-Bit-JRE finden Sie die Bibliothek beispielsweise in **Produktinstallationsverzeichnis/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.
   * Kopieren Sie die native Bibliothek auf den Computer, auf dem der Verwaltungsservice von {{ site.data.keys.mf_server }} ausgeführt wird. Das Verzeichnis könnte **${shared.resource.dir}/rcllib** sein. Das Verzeichnis **${shared.resource.dir}** ist in der Regel ein Verzeichnis unter **usr/shared/resources**. Hier steht usr für das Verzeichis, das auch das Verzeichnis **usr/servers** enthält. Weitere Informationen zur Standardposition von **${shared.resource.dir}** finden Sie in der [Dokumentation zu WebSphere Application Server Liberty Core](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_dirs.html?lang=de&view=kc) im Abschnitt "Verzeichnispositionen und -Eigenschaften". Wenn der Ordner **rcllib** nicht vorhanden ist, erstellen Sie ihn. Kopieren Sie dann die Datei mit der nativen Bibliothek in den Ordner.

   > **Hinweis:** Stellen Sie sicher, dass die Java Virtual Machine (JVM) des Anwendungsservers Lese- und Ausführungsrechte für die native Bibliothek hat. Wenn die JVM des Anwendungsservers nicht über die Ausführungsrechte für die kopierte native Bibliothek verfügt, erscheint unter Windows im Anwendungsserverprotokoll die folgende Ausnahme:


   ```bash
   com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Access is denied).
   ```
   * Kopieren Sie die Datei **rcl_ibmratl.jar** in den Ordner **${shared.resource.dir}/rcllib**. Die Datei **rcl_ibmratl.jar** ist eine Java-Bibliothek von Rational Common Licensing, die sich im Verzeichnis **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs** befindet.

   > **Hinweis:** Die Java Virtual Machine von Liberty Profile muss in der Lage sein, die kopierte Java-Bibliothek zu lesen. Für diese Datei muss es in Ihrem Betriebssystem (zumindest für den Anwendungsserverprozess) eine Leseberechtigung geben.    
   * Deklarieren Sie in der Datei **${server.config.dir}/server.xml** eine gemeinsam genutzte Bibliothek, die die Datei **rcl_ibmratl.jar** verwendet.

   ```xml
   <!-- Gemeinsame Bibliothek für den RCL-Client deklarieren. -->
   <!- Da diese Bibliothek nativen Code verwendet, kann sie nur einmal geladen werden. -->
   <library id="RCLLibrary">
       <fileset dir="${shared.resource.dir}/rcllib" includes="rcl_ibmratl.jar"/>
   </library>
   ```    
   * Deklarieren Sie die gemeinsam genutzte Bibliothek als allgemeine Bibliothek für den MobileFirst-Server-Verwaltungsservice. Fügen Sie dazu ein Attribut (**commonLibraryRef**) zum Klassenlader für den Verwaltungsservice hinzu. Da die Bibliothek nur einmal geladen werden kann, muss sie als allgemeine Bibliothek und nicht als persönliche Bibliothek verwendet werden.

   ```xml
   <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            [...]
      <!- Gemeinsame Bibliothek als Attribut commonLibraryRef des Klassenladers der Anwendung deklarieren. -->
      <classloader delegation="parentLast" commonLibraryRef="RCLLibrary">
      </classloader>
   </application>
   ```
   * Wenn Sie Oracle als Datenbank verwenden, enthält die Datei **server.xml** bereits den folgenden Klassenlader:

   ```xml
   <classloader delegation="parentLast" commonLibraryRef="MobileFirst/JDBC/oracle">
    </classloader>
   ```

   Sie müssen die Rational-Common-Licensing-Bibliothek wie folgt als allgemeine Bibliothek zur Oracle-Bibliothek hinzufügen: 

   ```xml
   <classloader delegation="parentLast"
         commonLibraryRef="MobileFirst/JDBC/oracle,RCLLibrary">
   </classloader>
   ```
   * Konfigurieren Sie für die JVM Ihres Anwendungsservers den Zugriff auf die Bibliothek von Rational Common Licensing. Konfigurieren Sie für alle Betriebssysteme die Datei **${wlp.user.dir}/servers/Servername/jvm.options**, indem Sie die folgende Zeile hinzufügen:

   ```xml
   -Djava.library.path=absoluter_Pfad_zum_zuvor_erstellten_Ordner_rcllib
   ```

   > **Hinweis:** Wenn Sie den Konfigurationsordner des Servers, auf dem der Verwaltungsservice ausgeführt wird, verschieben, müssen Sie **java.library.path** aktualisieren und den neuen absoluten Pfad angeben.



   Das Verzeichnis **${wlp.user.dir}** befindet sich in der Regel im Verzeichnis **Liberty-Installationsverzeichnis/usr** und enthält das Verzeichnis "servers". Die Position des Verzeichnisses kann aber angepasst werden. Weitere Informationen finden Sie unter [Customizing the Liberty environment](http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_customvars.html?lang=en&view=kc). 

2. Konfigurieren Sie {{ site.data.keys.mf_server }} für den Zugriff auf Rational License Key Server.

   Fügen Sie zur Datei **${wlp.user.dir}/Servername/server.xml** die folgenden JNDI-Konfigurationszeilen hinzu:

   ```xml
   <jndiEntry jndiName="mfp.admin.license.key.server.host" value="RLKS-Hostname"/>
   <jndiEntry jndiName="mfp.admin.license.key.server.port" value="RLKS-Port"/>
   ```
   * **RLKS-Hostname** ist der Hostname von Rational License Key Server.
   * **RLKS-Port** ist der Port von Rational License Key Server. Der Standardwert lautet 27000.

   Weitere Informationen finden Sie unter [JNDI-Eigenschaften für Verwaltungsservices: Lizenzierung](../server-configuration/#jndi-properties-for-administration-service-licensing).

### Installation in einer Liberty-Profile-Server-Farm
{: #installing-on-liberty-profile-server-farm }
Wenn Sie die Verbindung von {{ site.data.keys.mf_server }} in einer Liberty-Profile-Server-Farm konfigurieren möchten, müssen Sie für jeden Knoten Ihrer Server-Farm, auf dem der MobileFirst-Server-Verwaltungsservice ausgeführt wird, alle Schritte ausführen, die im Abschnitt [Bibliotheken von Rational Common Licensing installieren](#installing-rational-common-licensing-libraries) beschrieben sind. Weitere Informationen zu dieser Topologie finden Sie unter [Server-Farmtopologie](../prod-env/topologies/#server-farm-topology) und [Server-Farm installieren](../prod-env/appserver/#installing-a-server-farm).

## Verbindung zwischen dem in WebSphere Application Server installierten {{ site.data.keys.mf_server }} und dem Rational License Key Server herstellen
{: #connecting-mobilefirst-server-installed-on-websphere-application-server-to-the-rational-license-key-server }
Sie müssen in WebSphere Application Server eine gemeinsam genutzte Bibliothek für die Rational-Common-Licensing-Bibliotheken konfigurieren, bevor {{ site.data.keys.mf_server }} eine Verbindung zum Rational License Key Server herstellt. 

* Rational License Key Server ab Version 8.1.4.8 muss installiert und konfiguriert sein. Über das Netz müssen Übertragungen zum und vom {{ site.data.keys.mf_server }} möglich sein. Dazu werden die Ports für wechselseitige Übertragung (**lmrgd** und **ibmratl**) geöffnet. Weitere Informationen finden Sie im [Portal für Rational License Key Server](https://www.ibm.com/support/entry/portal/product/rational/rational_license_key_server?productContext=-283469295) und unter [How to serve a license key to client machines through a firewall](http://www.ibm.com/support/docview.wss?uid=swg21257370).
* Vergewissern Sie sich, dass die Lizenzschlüssel für die {{ site.data.keys.product }} generiert wurden. Weitere Informationen zum Generieren und Verwalten Ihrer Lizenzschlüssel mit dem IBM Rational License Key Center finden Sie unter [IBM  Support - Licensing](http://www.ibm.com/software/rational/support/licensing/) und [Obtaining license keys with IBM Rational License Key Center](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/t_access_license_key_center.html).
* {{ site.data.keys.mf_server }} muss in Ihrem Apache Tomcat installiert und mit der Option Activate token licensing with the Rational License Key Server konfiguriert sein (siehe [Installationsübersicht für die Tokenlizenzierung](#installation-overview-for-token-licensing)).

### Bibliothek von Rational Common Licensing auf einem eigenständigen Server installieren
{: #installing-rational-common-licensing-library-on-a-stand-alone-server }

1. Definieren Sie für die Bibliothek von Rational Common Licensing eine gemeinsam genutzte Bibliothek. Diese Bibliothek verwendet nativen Code und kann während des Anwendungsserverlebenszyklus nur einmal von einem Klassenlader geladen werden. Aus diesem Grund wird die Bibliothek als gemeinsam genutzte Bibliothek deklariert und allen Anwendungsservern zugeordnet, die den MobileFirst-Server-Verwaltungsservice ausführen. Weitere Informationen zu den Gründen, aus denen diese Bibliothek als gemeinsam genutzte Bibliothek deklariert werden muss, finden Sie unter [Native Bibliotheken in gemeinsam genutzten Bibliotheken konfigurieren](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tcws_sharedlib_nativelib.html?view=kc).
    * Wählen Sie die native Bibliothek von Rational Common Licensing aus. Wählen Sie abhängig von Ihrem Betriebssystem und von der Bitversion der Java Runtime Environment (JRE), in der Ihr WebSphere Application Server ausgeführt wird, unter **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs/bin/Ihre_Plattform/native_Bibliotheksdatei** die richtige native Bibliothek aus.

        Für Linux x86 mit einer 64-Bit-JRE finden Sie die Bibliothek beispielsweise in **Produktinstallationsverzeichnis/MobileFirstServer/tokensLibs/bin/Linux_x86_64/librcl_ibmratl.so**.

        Wenn Sie die Bitversion der Java Runtime Environment für eine eigenständige Installation von WebSphere Application Server oder WebSphere Application Server Network Deployment bestimmen möchten, führen Sie **versionInfo.bat** unter Windows oder **versionInfo.sh** unter UNIX im Verzeichnis **bin** aus. Die Datei **versionInfo.sh** befindet sich im Verzeichnis **/opt/IBM/WebSphere/AppServer/bin**. Suchen Sie im Abschnitt **Installed Product** nach dem Wert für "Architecture". Die Java Runtime Environment ist eine 64-Bit-Umgebung, sofern dies explizit aus dem Wert für "Architecture" hervorgeht oder der Wert mit dem Suffix 64 bzw. _64 versehen ist.
    * Stellen Sie die native Bibliothek für Ihre Plattform in einen Ordner Ihres Betriebssystems. Beispiel: **/opt/IBM/RCL_Native_Library/**
    * Kopieren Sie die Datei **rcl_ibmratl.jar** in das Verzeichnis **/opt/IBM/RCL_Native_Library/**. Die Datei **rcl_ibmratl.jar** ist eine Java-Bibliothek von Rational Common Licensing, die sich im Verzeichnis **Produktinstallationsverzeichnis/MobileFirstServer/tokenLibs** befindet.

        > **Wichtiger Hinweis:** Für die Java Virtual Machine (JVM) des Anwendungsservers sind Lese- und Ausführungsrechte für die kopierte native Bibliothek und die Java-Bibliothek erforderlich. Für die beiden kopierten Dateien muss es auch in Ihrem Betriebssystem (zumindest für den Anwendungsserverprozess) eine Lese- und Ausführungsberechtigung geben.    
    * Deklarieren Sie in der Administrationskonsole von WebSphere Application Server eine gemeinsam genutzte Bibliothek.
        * Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an.
        * Erweitern Sie die Anzeige für **Umgebung → Gemeinsam genutzte Bibliotheken**.
        * Wählen Sie einen Bereich aus, der für alle Server, die den MobileFirst-Server-Verwaltungsservice ausführen, sichtbar ist, z. B. einen Cluster.
        * Klicken Sie auf **Neu**.
        * Geben Sie im Feld Name einen Namen für die Bibliothek ein, z. B. "RCL Shared Library".
        * Geben Sie im Feld Klassenpfad den Pfad zur Datei **rcl_ibmratl.jar** ein, z. B. **/opt/IBM/RCL_Native_Library/rcl_ibmratl.jar**.
        * Klicken Sie auf **OK** und speichern Sie die Änderungen. Diese Einstellung wird nach einem Neustart des Servers wirksam.

        > **Hinweis:** Der Pfad dieser nativen Bibliothek wird in Schritt 3 mit der Eigenschaft **ld.library.path** der Server-JVM festgelegt.

    * Ordnen Sie die gemeinsam genutzte Bibliothek allen Servern zu, die den MobileFirst-Server-Verwaltungsservice ausführen.

        Durch die Zuordnung zu einem Server kann die gemeinsam genutzte Bibliothek von mehreren Anwendungen verwendet werden. Wenn Sie den Rational-Common-Licensing-Client nur für den MobileFirst-Server-Verwaltungsservice benötigen, können Sie eine gemeinsam genutzte Bibliothek mit einem isolierten Klassenlader erstellen, die Sie dann der Anwendung für den Verwaltungsservice zuordnen.

        Die folgende Anweisung gilt für die Zuordnung der Bibliothek zu einem Server. In WebSphere Application Server Network Deployment müssen Sie diese Anweisung für alle Server ausführen, die den MobileFirst-Server-Verwaltungsservice ausführen.    
        * Legen Sie die Richtlinie und den Modus für den Klassenlader fest.    
            1. Klicken Sie in der Administrationskonsole von WebSphere Application Server auf **Server → Servertypen → WebSphere-Anwendungsserver → Servername**, um auf die Seite mit den Anwendungsservereinstellungen zuzugreifen.
            2. Definieren Sie wie folgt den Wert für die Klassenladerrichtlinie der Anwendung und den Klassenlademodus des Servers:
                * **Richtlinie für Klassenlader**: Mehrere
                * **Modus für das Laden von Klassen**: Mit dem übergeordneten Klassenlader geladene Klassen zuerst
            3. Klicken Sie im Abschnitt **Serverinfrastruktur** auf **Java- und Prozessverwaltung → Klassenlader**.
            4. Klicken Sie auf **Neu** und stellen Sie sicher, dass die Reihenfolge der Klassenlader auf **Mit dem übergeordneten Klassenlader geladene Klassen zuerst** gesetzt ist.
            5. Klicken Sie auf **Anwenden**, um eine neue Klassenlader-ID zu erstellen.                
        * Erstellen Sie für jede Bibliotheksdatei, die Ihre Anwendung erfordert, eine Bibliotheksreferenz.
            1. Klicken Sie auf den Namen des im vorherigen Schritt erstellten Klassenladers.
            2. Klicken Sie im Abschnitt **Weitere Eigenschaften** auf **Referenzen für gemeinsam genutzte Bibliotheken**.
            3. Klicken Sie auf **Hinzufügen**.
            4. Wählen Sie auf der Seite mit den Einstellungen für Bibliotheksreferenzen die entsprechende Bibliotheksreferenz aus. Der Name bezeichnet die gemeinsam genutzte Bibliotheksdatei, die Ihre Anwendung verwendet, z. B. RCL Shared Library.
            5. Klicken Sie auf **Anwenden** und speichern Sie die Änderungen.
2. Konfigurieren Sie die Umgebungseinträge für die Webanwendung für den MobileFirst-Server-Verwaltungsservice.
    * Klicken Sie in der Administrationskonsole von WebSphere Application Server auf **Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen** und wählen Sie die Anwendung für den Verwaltungsservice **MobileFirst_Administration_Service** aus.
    * Wählen Sie im Abschnitt **Eigenschaften des Webmoduls** den Eintrag **Umgebungseinträge für Webmodule** aus.
    * Geben Sie den Wert für **mfp.admin.license.key.server.host** und **mfp.admin.license.key.server.port** ein.
        * **mfp.admin.license.key.server.host** ist der Hostname von Rational License Key Server.
        * **mfp.admin.license.key.server.port** ist der Port von Rational License Key Server. Der Standardwert lautet 27000.
    * Klicken Sie auf **OK** und speichern Sie die Änderungen.
3. Konfigurieren Sie für die JVM Ihres Anwendungsservers den Zugriff auf die Bibliothek von Rational Common Licensing.
    * Klicken Sie in der Administrationskonsole von WebSphere Application Server auf **Server → Servertypen → WebSphere-Anwendungsserver** und wählen Sie Ihren Server aus.
    * Klicken Sie im Abschnitt **Serverinfrastruktur** auf **Java- und Prozessverwaltung → Prozessdefinition → Java Virtual Machine → Angepasste Eigenschaften → Neu**, um eine angepasste Eigenschaft hinzuzufügen.
    * Geben Sie im Feld **Name** **java.library.path** als Namen der angepassten Eigenschaft ein.
    * Geben Sie im Feld **Wert** den Pfad des Ordners ein, in den Sie die native Bibliotheksdatei in Schritt 1 b gestellt haben. Beispiel: **/opt/IBM/RCL_Native_Library/**
    * Klicken Sie auf **OK** und speichern Sie die Änderungen.
4. Starten Sie Ihren Anwendungsserver neu.

### Bibliothek von Rational Common Licensing in WebSphere Application Server Network Deployment installieren
{: #installing-rational-common-licensing-library-on-websphere-application-server-network-deployment }
Wenn Sie die native Bibliothek in WebSphere Application Server Network Deployment installieren möchten, müssen Sie alle Schritte ausführen, die im Abschnitt [Bibliothek von Rational Common Licensing auf einem eigenständigen Server installieren](#installing-rational-common-licensing-library-on-a-stand-alone-server) beschrieben sind. Die Server oder Cluster, die Sie konfigurieren, müssen neu gestartet werden, um die Änderungen in Kraft zu setzen. 

Auf jedem Knoten von WebSphere Application Server Network Deployment muss sich eine Kopie der nativen Bibliothek von Rational Common Licensing befinden. 

Für jeden Server, auf dem der MobileFirst-Server-Verwaltungsservice ausgeführt wird, muss der Zugriff auf die native Bibliothek konfiguriert werden, die Sie auf Ihren lokalen Computer kopiert haben. Diese Server müssen auch so konfiguriert werden, dass sie eine Verbindung zu Rational License Key Server herstellen.

> **Wichtiger Hinweis:** Wenn Sie einen Cluster mit WebSphere Application Server Network Deployment verwenden, könnte sich Ihr Cluster ändern. Jedes Mal, wenn Sie einen neuen Server hinzufügen, auf dem die Verwaltungsservices ausgeführt werden, müssen Sie diesen neuen Server entsprechend konfigurieren.



## Beschränkung hinsichtlich der unterstützten Plattformen für die Tokenlizenzierung
{: #limitations-of-supported-platforms-for-token-licensing }
In diesem Abschnitt finden Sie eine Auflistung der Plattformen (Betriebssystem, Betriebssystemversion und Hardwarearchitektur), die Unterstützung für {{ site.data.keys.mf_server }} mit aktivierter Tokenlizenzierung bieten. 

Für die Tokenlizenzierung muss {{ site.data.keys.mf_server }} über die Bibliothek von Rational Common Licensing eine Verbindung zum Rational License Key Server herstellen. 

Diese Bibliothek setzt sich aus einer Java-Bibliothek und nativen Bibliotheken zusammen. Die nativen Bibliotheken richten sich nach der Plattform, auf der {{ site.data.keys.mf_server }} ausgeführt wird. Die Tokenlizenzierung von {{ site.data.keys.mf_server }} wird somit nur von Plattformen unterstützt, auf denen die Bibliothek von Rational Common Licensing ausgeführt werden kann. 

In der folgenden Tabelle sind die Plattformen angegeben, die {{ site.data.keys.mf_server }} mit Tokenlizenzierung unterstützen. 

|Betriebssystem|Betriebssystemversion|	Hardwarearchitektur|
|------------------------------|--------------------------|-----------------------|
|AIX|7.1|	POWER8 (nur 64 Bit)|
|SUSE Linux Enterprise Server|11	                      |nur x86-64|
|Windows Server|2012	                  |nur x86-64|

Die Tokenlizenzierung unterstützt keine 32-Bit-JRE. Stellen Sie sicher, dass der Anwendungsserver eine 64-Bit-JRE verwendet. 

## Probleme mit der Tokenlizenzierung lösen
{: #troubleshooting-token-licensing-problems }
Hier finden Sie Informationen, die Ihnen bei der Lösung von Problemen mit der Tokenlizenzierung helfen. Solche Probleme können auftreten, wenn Sie dieses Feature bei der Installation von {{ site.data.keys.mf_server }} aktiviert haben. 

Wenn Sie nach Ausführung der Schritte unter "Installation und Konfiguration für die Tokenlizenzierung" den MobileFirst-Server-Verwaltungsservice starten, können im Anwendungsserverprotokoll oder in der {{ site.data.keys.mf_console }} Fehler oder Ausnahmen ausgegeben werden. Solche Ausnahmen können auf eine fehlerhafte Installation der Bibliothek von Rational Common Licensing oder eine falsche Konfiguration des Anwendungsservers zurückzuführen sein. 

**Apache Tomcat**  
Überprüfen Sie abhängig von Ihrer Plattform die Datei **catalina.log** oder **catalina.out**. 

**WebSphere® Application Server Liberty Profile**  
Überprüfen Sie die Datei **messages.log**. 

**WebSphere Application Server Full Profile**  
Überprüfen Sie die Datei **SystemOut.log**. 

> **Wichtiger Hinweis:** Wenn die Tokenlizenzierung in WebSphere Application Server Network Deployment oder einem Cluster installiert ist, müssen Sie das Protokoll jedes Servers überprüfen.



Nachfolgend sind die Ausnahmen aufgelistet, die nach der Installation und Konfiguration der Tokenlizenzierung eintreten können: 

* [Native Bibliothek von Rational Common Licensing nicht gefunden](#rational-common-licensing-native-library-is-not-found)
* [Gemeinsam genutzte Bibliothek von Rational Common Licensing nicht gefunden](#rational-common-licensing-shared-library-is-not-found)
* [Keine Verbindung zu Rational License Key Server konfiguriert](#the-rational-license-key-server-connection-is-not-configured)
* [Kein Zugriff auf Rational License Key Server möglich](#the-rational-license-key-server-is-not-accessible)
* [Initialisierung der API von Rational Common Licensing fehlgeschlagen](#failed-to-initialize-rational-common-licensing-api)
* [Nicht genug Tokenlizenzen](#insufficient-token-licenses)
* [Ungültige Datei rcl_ibmratl.jar](#invalid-rcl_ibmratljar-file)

### Native Bibliothek von Rational Common Licensing nicht gefunden
{: #rational-common-licensing-native-library-is-not-found }

> FWLSE3125E: Die native Bibliothek von Rational Common Licensing wurde nicht gefunden. Stellen Sie sicher, dass die JVM-Eigenschaft (java.library.path) mit dem richtigen Pfad definiert ist und dass die native Bibliothek ausgeführt werden kann. Starten Sie MobileFirst Server nach der Fehlerberichtigung neu.



#### WebSphere Application Server Full Profile
{: #for-websphere-application-server-full-profile }
Mögliche Fehlerursachen: 

* Auf Serverebene ist keine allgemeine Eigenschaft mit dem Namen **java.library.path** definiert.
* Der Pfad, der als Wert für die Eigenschaft **java.library.path** angegeben ist, enthält nicht die native Bibliothek von Rational Common Licensing.
* Es liegen nicht die erforderlichen Berechtigungen für die native Bibliothek vor. Der Benutzer, der unter UNIX und Windows mit der Java Runtime auf die Bibliothek zugreift, muss Lese- und Ausführungsrechte für die Bibliothek haben.
* Umgebung des Anwendungsservers

#### WebSphere Application Server Liberty Profile und Apache Tomcat
{: #for-websphere-application-server-liberty-profile-and-apache-tomcat }
Mögliche Fehlerursachen: 

* Der Wert der Eigenschaft java.library.path, der den Pfad zur nativen Bibliothek von Rational Common Licensing angibt, ist nicht oder falsch definiert.
    * Überprüfen Sie für Liberty Profile die Datei **${wlp.user.dir}/servers/server_name/jvm.options**.
    * Überprüfen Sie für Apache Tomcat je nach Plattform die Datei **${CATALINA_HOME}/bin/setenv.bat** oder **setenv.sh**.
* Die native Bibliothek befindet sich nicht in dem Pfad, der für die Eigenschaft **java.library.path** definiert ist. Überprüfen Sie, ob es in dem definierten Pfad die native Bibliothek mit dem erwarteten Namen gibt.
* Es liegen nicht die erforderlichen Berechtigungen für die native Bibliothek vor. Vor dem Fehler könnte die folgende Ausnahme aufgeführt sein: `com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: {0}\rcl_ibmratl.dll: Access is denied`.

Die Java Runtime Environment des Anwendungsservers benötigt Lese- und Ausführungsrechte für diese native Bibliothek. Für diese Datei muss es auch in Ihrem Betriebssystem (zumindest für den Anwendungsserverprozess) eine Lese- und Ausführungsberechtigung geben. 

* Die gemeinsam genutzte Bibliothek, die die Datei **rcl_ibmratl.jar** verwendet, ist nicht in der Datei **${server.config.dir}/server.xml** für Liberty Profile definiert. Es ist auch möglich, dass sich **rcl_ibmratl.jar** nicht im richtigen Verzeichnis befindet oder dass für das Verzeichnis nicht die erforderlichen Berechtigungen festgelegt sind.
* Die gemeinsam genutzte Bibliothek, die die Datei **rcl_ibmratl.jar** verwendet, ist in der Datei **${server.config.dir}/server.xml** für Liberty Profile nicht als allgemeine Bibliothek für die Verwaltungsservices von {{ site.data.keys.mf_server }} deklariert.
* Bei der Java Runtime Environment des Anwendungsservers und der nativen Bibliothek gibt es eine Kombination von 32-Bit- und 64-Bit-Objekten. Eine 32-Bit-JRE wird beispielsweise mit einer nativen 64-Bit-Bibliothek verwendet. Eine solche Kombination wird nicht unterstützt.

### Gemeinsam genutzte Bibliothek von Rational Common Licensing nicht gefunden
{: #rational-common-licensing-shared-library-is-not-found }

> FWLSE3126E: Die gemeinsam genutzte Bibliothek von Rational Common Licensing wurde nicht gefunden. Stellen Sie sicher, dass die gemeinsam genutzte Bibliothek konfiguriert ist. Starten Sie MobileFirst Server nach der Fehlerberichtigung neu.



Mögliche Fehlerursachen: 

* Die Datei **rcl_ibmratl.jar** befindet sich nicht im erwarteten Verzeichnis.
    * Überprüfen Sie für Apache Tomcat, ob sich diese Datei im Verzeichnis **${CATALINA_HOME}/lib** befindet.
    * Überprüfen Sie für WebSphere Application Server Liberty Profile, ob sich diese Datei in dem Verzeichnis befindet, das in der Datei server.xml für die gemeinsam genutzte Bibliothek des Rational-Common-Licensing-Clients definiert ist, z. B. in **${shared.resource.dir}/rcllib**. Vergewissern Sie sich, dass diese gemeinsam genutzte Bibliothek in der Datei **server.xml** als eine allgemeine Bibliothek für die Verwaltungsservices von {{ site.data.keys.mf_server }} referenziert wird.
    * Überprüfen Sie für WebSphere Application Server, ob sich diese Datei in dem Verzeichnis befindet, das im Klassenpfad der gemeinsam genutzten Bibliothek von WebSphere Application Server angegeben ist. Vergewissern Sie sich, dass der Klassenpfad der gemeinsam genutzten Bibliothek den Eintrag **absoluter\_Pfad/rcl_ibmratl.jar** enthält. Hier steht "absoluter\_Pfad" für den absoluten Pfad der Datei **rcl_ibmratl.jar**.

Die Eigenschaft **java.library.path** ist nicht für den Anwendungsserver definiert. Definieren Sie eine Eigenschaft mit dem Namen **java.library.path** und legen Sie als Wert den Pfad zur nativen Bibliothek von Rational Common Licensing fest, z. B. **/opt/IBM/RCL\_Native\_Library/**. 
* Es liegen nicht die erwarteten Berechtigungen für die native Bibliothek vor. Unter Windows muss die Java Runtime Environment des Anwendungsservers über die Lese- und Ausführungsrechte für die native Bibliothek verfügen.
* Bei der Java Runtime Environment des Anwendungsservers und der nativen Bibliothek gibt es eine Kombination von 32-Bit- und 64-Bit-Objekten. Eine 32-Bit-JRE wird beispielsweise mit einer nativen 64-Bit-Bibliothek verwendet. Eine solche Kombination wird nicht unterstützt.

### Keine Verbindung zu Rational License Key Server konfiguriert
{: #the-rational-license-key-server-connection-is-not-configured }

> FWLSE3127E: Die Verbindung zum Rational License Key Server ist nicht konfiguriert. Stellen Sie sicher, dass die JNDI-Verwaltungseigenschaften "mfp.admin.license.key.server.host" und "mfp.admin.license.key.server.port" definiert sind. Starten Sie MobileFirst Server nach der Fehlerberichtigung neu.



Mögliche Fehlerursachen: 

* Die native Bibliothek von Rational Common Licensing und die gemeinsam genutzte Bibliothek, die die Datei **rcl_ibmratl.jar** verwendet, sind richtig konfiguriert, aber in der Anwendung für den MobileFirst-Server-Verwaltungsservice ist der Wert der JNDI-Eigenschaften (**mfp.admin.license.key.server.host** und **mfp.admin.license.key.server.port**) nicht festgelegt.
* Rational License Key Server ist inaktiv.
* Der Host-Computer, auf dem Rational License Key Server installiert ist, ist nicht erreichbar. Überprüfen Sie die IP-Adresse oder den Hostnamen mit dem angegebenen Port.

### Kein Zugriff auf Rational License Key Server möglich
{: #the-rational-license-key-server-is-not-accessible }

> FWLSE3128E: Der Rational License Key Server "{Port}@{IP-Adresse oder Hostname}" ist nicht zugänglich. Stellen Sie sicher, dass der Lizenzserver aktiv und für MobileFirst Server zugänglich ist. Tritt dieser Fehler beim Start der Laufzeit auf, starten Sie MobileFirst Server nach der Fehlerberichtigung neu.



Mögliche Fehlerursachen: 

* Die gemeinsam genutzte Bibliothek und die native Bibliothek von Rational Common Licensing sind ordnungsgemäß definiert, aber es gibt keine gültige Konfiguration für die Verbindung zu Rational License Key Server. Überprüfen Sie die IP-Adresse, den Hostnamen und den Port des Lizenzservers. Vergewissern Sie sich, dass der Lizenzserver gestartet wurde und für den Computer, auf dem der Anwendungsserver installiert ist, zugänglich ist.
* Die native Bibliothek befindet sich nicht in dem Pfad, der für die Eigenschaft **java.library.path** definiert ist.
* Es liegen nicht die erforderlichen Berechtigungen für die native Bibliothek vor.
* Die native Bibliothek befindet sich nicht im definierten Verzeichnis.
* Rational License Key Server befindet sich hinter einer Firewall. Vor diesem Fehler könnte die folgende Ausnahme angegeben sein: [ERROR] Failed to get license for application 'WorklightStarter' because Rational Licence Key Server ({port}@{IP address or hostname}) is either down or not accessible. com.ibm.rcl.ibmratl.LicenseServerUnreachableException: All license files searched for features: {port}@{IP address or hostname}.

Stellen Sie sicher, dass der Port des Lizenzmanagerdämons (lmgrd) und der Port von Vendor Daemon (ibmratl) in Ihrer Firewall offen sind. Weitere Informationen finden Sie unter "How to serve a license key to client machines through a firewall".

### Initialisierung der API von Rational Common Licensing fehlgeschlagen
{: #failed-to-initialize-rational-common-licensing-api }

> Failed to initialize Rational Common Licensing (RCL) API because its native library could not be found or loaded. com.ibm.rcl.ibmratl.LicenseConfigurationException: java.lang.UnsatisfiedLinkError: rcl_ibmratl (Not found in java.library.path)


Mögliche Fehlerursachen: 

* Die native Bibliothek von Rational Common Licensing befindet sich nicht in dem Pfad, der für die Eigenschaft **java.library.path** definiert ist. Überprüfen Sie, ob es in dem definierten Pfad die native Bibliothek mit dem erwarteten Namen gibt.
* Die Eigenschaft **java.library.path** ist nicht für den Anwendungsserver definiert. Definieren Sie eine Eigenschaft mit dem Namen **java.library.path** und legen Sie als Wert den Pfad zur nativen Bibliothek von Rational Common Licensing fest, z. B. **/opt/IBM/RCL_Native_Library/**.
* Bei der Java Runtime Environment des Anwendungsservers und der nativen Bibliothek gibt es eine Kombination von 32-Bit- und 64-Bit-Objekten. Eine 32-Bit-JRE wird beispielsweise mit einer nativen 64-Bit-Bibliothek verwendet. Eine solche Kombination wird nicht unterstützt.

### Nicht genug Tokenlizenzen
{: #insufficient-token-licenses }

> FWLSE3129E: Nicht ausreichende Tokenlizenzen für das Feature "{0}".

Dieser Fehler tritt auf, wenn die Anzahl der verbliebenen Lizenzen auf dem Rational License Key Server nicht für die Implementierung einer neuen {{ site.data.keys.product_adj }}-Anwendung ausreicht. 

### Ungültige Datei rcl_ibmratl.jar
{: #invalid-rcl_ibmratljar-file }

> UTLS0002E: Die gemeinsam genutzte Bibliothek RCL Shared Library enthält einen Klassenpfadeintrag, der nicht in eine gültige JAR-Datei aufgelöst werden kann. Die erwartete Position der JAR-Datei für die Bibliothek ist {0}/rcl_ibmratl.jar.



**Hinweis:** Nur für WebSphere Application Server und WebSphere Application Server Network Deployment

Mögliche Fehlerursachen: 

* Es liegen nicht die erforderlichen Berechtigungen für die Java-Bibliothek **rcl_ibmratl.jar** vor. Im Anschluss an den Fehler könnte eine weitere Ausnahme angegeben sein: java.util.zip.ZipException: error in opening zip file. Überprüfen Sie, ob der Benutzer, der WebSphere Application Server installiert hat, über die Leseberechtigung für die Datei **rcl_ibmratl.jar** verfügt.
* Wenn keine weitere Ausnahme angegeben ist, besteht die Möglichkeit, dass die Datei **rcl_ibmratl.jar**, die im Klassenpfad der gemeinsam genutzten Bibliothek referenziert wird, ungültig oder nicht vorhanden ist. Vergewissern Sie sich, dass die Datei **rcl_ibmratl.jar** gültig bzw. im definierten Pfad vorhanden ist.
