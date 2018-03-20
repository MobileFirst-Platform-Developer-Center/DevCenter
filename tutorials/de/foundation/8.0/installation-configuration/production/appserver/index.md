---
layout: tutorial
title: MobileFirst Server in einem Anwendungsserver installieren
breadcrumb_title: Installing MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die Installation der Komponenten können Sie mit Ant-Tasks,
dem Server Configuration Tool oder manuell ausführen. Informieren Sie sich über die Voraussetzungen
und die Einzelheiten des Installationsprozesses, damit Sie die Komponenten erfolgreich im Anwendungsserver
installieren können. 

Bevor Sie die Komponenten im Anwendungsserver installieren, müssen Sie sicherstellen, dass die Datenbanken und Tabellen für die Komponenten
erstellt und einsatzbereit sind. Weitere Informationen finden Sie unter
[Datenbanken einrichten](../databases). 

Die Servertopologie für die Installation der Komponenten muss ebenfalls definiert werden (siehe [Topologien und Netzabläufe](../topologies)). 

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Voraussetzungen für den Anwendungsserver](#application-server-prerequisites)
* [Installation mit dem Server Configuration Tool](#installing-with-the-server-configuration-tool)
* [Installation mit Ant-Tasks](#installing-with-ant-tasks)
* [MobileFirst-Server-Komponenten manuell installieren](#installing-the-mobilefirst-server-components-manually)
* [Server-Farm installieren](#installing-a-server-farm)

## Voraussetzungen für den Anwendungsserver
{: #application-server-prerequisites }
Wählen Sie aus den folgenden Abschnitten den für Ihren Anwendungsserver aus und informieren Sie sich über die Voraussetzungen, die erfüllt sein müssen,
bevor Sie die
MobileFirst-Server-Komponenten installieren. 

* [Voraussetzungen für Apache Tomcat](#apache-tomcat-prerequisites)
* [Voraussetzungen für WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites)
* [Voraussetzungen für WebSphere Application Server und WebSphere Application Server Network Deployment](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Voraussetzungen für Apache Tomcat
{: #apache-tomcat-prerequisites }
{{ site.data.keys.mf_server }} stellt gewisse
Anforderungen an die Konfiguration von Apache Tomcat, die in den folgenden Abschnitten ausführlich erläutert werden.  
Stellen Sie sicher, dass die folgenden Bedingungen erfüllt sind: 

* Sie verwenden eine unterstützte Version von Apache Tomcat (siehe
[Systemvoraussetzungen](../../../product-overview/requirements)).
* Apache Tomcat wird mit JRE 7.0 oder einer aktuelleren Version ausgeführt. 
* Die JMX-Konfiguration lässt die Kommunikation zwischen dem Verwaltungsservice und der Laufzeitkomponente zu. Für die Kommunikation wird
RMI verwendet. Lesen Sie dazu weiter unten den Abschnitt **JMX-Verbindung für Apache Tomcat konfigurieren**. 

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Für Anweisungen zum Konfigurieren der JMX-Verbindung für Apache Tomcat hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Sie müssen eine sichere JMX-Verbindung für den Apache-Tomcat-Anwendungsserver konfigurieren.</p>
                <p>Mit dem Server Configuration Tool und den Ant-Tasks können Sie eine sichere JMX-Standardverbindung konfigurieren. Die Konfiguration umfasst die Definition eines fernen JMX-Ports und die Definition von Authentifizierungseigenschaften. Das Tool und die Tasks ändern die Dateien <b>Tomcat-Installationsverzeichnis/bin/setenv.bat</b> und <b>Tomcat-Installationsverzeichnis/bin/setenv.sh</b> und fügen <b>CATALINA_OPTS</b> die folgenden Optionen hinzu:</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                                    <p><b>Hinweis:</b> 8686 ist ein Standardwert. Der Wert für diesen Port kann geändert werden, wenn der Port auf dem Computer nicht verfügbar ist.</p>

                <ul>
                    <li>Die Datei <b>setenv.bat</b> wird verwendet, wenn Sie für den Start von Apache Tomcat <b>Tomcat-Installationsverzeichnis/bin/startup.bat</b> oder <b>Tomcat-Installationsverzeichnis/bin/catalina.bat</b> verwenden.</li>
                    <li>Die Datei <b>setenv.sh</b> wird verwendet, wenn Sie für den Start von Apache Tomcat <b>Tomcat-Installationsverzeichnis/bin/startup.sh</b> oder <b>Tomcat-Installationsverzeichnis/bin/catalina.sh</b> verwenden.</li>
                </ul>

                <p>Wenn Sie Apache Tomcat mit einem anderen Befehl starten, wird diese Datei möglicherweise nicht verwendet. Wenn Sie den Windows Service Installer von Apache Tomcat installiert haben, wird <b>setenv.bat</b> nicht vom Servicestarter verwendet.</p>

                <blockquote><b>Wichtiger Hinweis:</b> Diest Konfiguration ist standardmäßig nicht sicher. Zum Sichern der Konfiguration müssen Sie die Schritte 2 und 3 der folgenden Prozedur manuell ausführen.</blockquote>

                <p>Apache Tomcat manuell konfigurieren:</p>

                <ol>
                    <li>Für eine einfache Konfiguration fügen Sie <b>CATALINA_OPTS</b> die folgenden Optionen hinzu:

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>Informationen zum Aktivieren der Authentifizierung finden Sie in der Benutzerdokumentation zu Apache Tomcat (<a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL Support - BIO and NIO</a> und <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL Configuration HOW-TO</a>).</li>
                    <li>Fügen Sie für eine JMX-Konfiguration mit aktiviertem SSL die folgenden Optionen hinzu:
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<Keystore-Position>
-Djavax.net.ssl.trustStorePassword=<Keystore-Kennwort>
-Djavax.net.ssl.trustStoreType=<Keystore-Typ>
-Djavax.net.ssl.keyStore=<Keystore-Position>
-Djavax.net.ssl.keyStorePassword=<Keystore-Kennwort>
-Djavax.net.ssl.keyStoreType=<Keystore-Typ>
{% endhighlight %}

                    <b>Hinweis:</b> Der Port 8686 kann geändert werden. </li>
                    <li>
                        <p>Wenn die Tomcat-Instanz hinter einer Firewall ausgeführt wird, muss der JMX-Remote-Lifecycle-Listener konfiguriert werden. Suchen Sie in der Dokumentation zu Apache Tomcat nach <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX Remote Lifecycle Listener</a>.</p><p>Außerdem müssen dem Abschnitt "Context" in der Datei <b>server.xml</b> für die Anwendung "Verwaltungsservices" wie im folgenden Beispiel gezeigt die folgenden Umgebungseigenschaften hinzugefügt werden:</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="Registry-Port" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="Server-Port" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        Erläuterungen zum vorherigen Beispiel:
                        <ul>
                            <li>Für registryPort muss der Wert angegeben werden, den das Attribut <b>rmiRegistryPortPlatform</b> des JMX-Remote-Lifecycle-Listeners hat.</li>
                            <li>Für serverPort muss der Wert angegeben werden, den das Attribut <b>rmiServerPortPlatform</b> des JMX-Remote-Lifecycle-Listeners hat.</li>
                        </ul>
                    </li>
                    <li>Wenn Sie Apache Tomcat mit dem Apache Tomcat Windows Service Installer installiert haben, anstatt die Optionen zu <b>CATALINA_OPTS</b> hinzuzufügen, führen Sie <b>Tomcat-Installationsverzeichnis/bin/Tomcat7w.exe</b> aus und fügen Sie die Optionen auf der Registerkarte <b>Java</b> des Fensters <b>Properties</b> hinzu.

                    <img alt="Eigenschaften von Apache Tomcat 7" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Voraussetzungen für WebSphere Application Server Liberty
{: #websphere-application-server-liberty-prerequisites }
{{ site.data.keys.product_full }} stellt gewisse
Anforderungen an die Konfiguration des Liberty-Servers, die in den folgenden Abschnitten ausführlich erläutert werden.  

Stellen Sie sicher, dass die folgenden Bedingungen erfüllt sind: 

* Sie verwenden eine unterstützte Version von Liberty (siehe [Systemvoraussetzungen](../../../product-overview/requirements)).
* Liberty wird mit JRE 7.0 oder einer aktuelleren Version ausgeführt. JRE 6.0 wird nicht unterstützt.
* Einige Liberty-Versionen unterstützen die Features von Java EE 6 und von Java EE 7. Das Liberty-Feature jdbc-4.0 ist beispielsweise Teil von Java EE 6, wohingegen das Lieberty-Feature jdbc-4.1 Teil von Java EE 7 ist. {{ site.data.keys.mf_server }} Version 8.0.0 kann mit Features von Java EE 6 oder Java EE 7 installiert werden. Wenn Sie jedoch in demselben Liberty-Server eine ältere Version von {{ site.data.keys.mf_server }} ausführen möchten, müssen Sie die Features von Java EE 6 verwenden. Bis Version 7.1.0 bietet {{ site.data.keys.mf_server }} keine Unterstützung für Features von Java EE 7.
* JMX muss konfiguriert sein (siehe unten Abschnitt **JMX-Verbindung für WebSphere Application Server Liberty Profile konfigurieren**).
* Bei einer Installation in einer Produktionsumgebung auf Windows-, Linux- oder UNIX-Systemen können Sie den Liberty-Server als Dienst starten. In dem Fall geschieht Folgendes: Die MobileFirst-Server-Komponenten werden beim Computerstart automatisch gestartet. Der Prozess, der den Liberty-Server ausführt, wird nicht gestoppt, wenn sich der Benutzer, der den Prozess gestartet hat, abmeldet.
* {{ site.data.keys.mf_server }} Version 8.0.0 kann nicht in einem Liberty-Server implementiert werden, der die implementierten MobileFirst-Server-Komponenten der Vorgängerversion enthält.
* Bei einer Installation in einer Umgebung mit Liberty-Verbund müssen der Controler und die Cluster-Member des Liberty-Verbunds konfiguriert werden (siehe [Configuring a Liberty collective](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc)).

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>Für Anweisungen zum Konfigurieren der JMX-Verbindung für WebSphere Application Server Liberty Profile hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} setzt die Konfiguration einer sicheren JMX-Verbindung voraus.</p>

                <ul>
                    <li>Mit dem Server Configuration Tool und den Ant-Tasks können Sie eine sichere JMX-Standardverbindung konfigurieren. Die Konfiguration umfasst die Generierung eines selbst signierten SSL-Zertifikats mit einer Gültigkeit von 365 Tagen. Diese Konfiguration ist nicht für den Produktionseinsatz vorgesehen.</li>
                    <li>Zum Konfigurieren der sicheren JMX-Verbindung für den Produktionseinsatz folgen Sie den Anweisungen unter <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Sichere JMX-Verbindung zum Liberty-Profil konfigurieren</a>.</li>
                    <li>Das Feature "rest-connector" ist für WebSphere Application Server, Liberty Core und weitere Editionen von Liberty verfügbar, aber es ist auch möglich, einen Liberty-Server mit einem Teil der verfügbaren Features zu packen. Geben Sie den folgenden Befehl ein, um zu prüfen, ob das Feature "rest-connector" in Ihrer Installation von Liberty verfügbar ist:
{% highlight bash %}                    
Liberty-Installationsverzeichnis/bin/productInfo featureInfo
{% endhighlight %}
                    <b>Hinweis:</b> Vergewissern Sie sich, dass die Ausgabe dieses Befehls restConnector-1.0 enthält.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Voraussetzungen für WebSphere Application Server und WebSphere Application Server Network Deployment
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
{{ site.data.keys.mf_server }} stellt gewisse Anforderungen an die Konfiguration von WebSphere Application Server und WebSphere Application Server Network Deployment, die in den folgenden Abschnitten ausführlich erläutert werden.  
Stellen Sie sicher, dass die folgenden Bedingungen erfüllt sind: 

* Sie verwenden eine unterstützte Version von WebSphere Application Server (siehe [Systemvoraussetzungen](../../../product-overview/requirements)).
* Der Anwendungsserver wird mit JRE 7.0 ausgeführt. WebSphere Application Server verwendet standardmäßig das SDK von Java 6.0. Wie Sie zum SDK von Java 7.0 wechseln können, erfahren Sie unter [Switching to Java 7.0 SDK in WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* Die Verwaltungssicherheit ist aktiviert. Die {{ site.data.keys.mf_console }}, der MobileFirst-Server Verwaltungsservice und der MobileFirst-Server-Konfigurationsservice sind mit Sicherheitsrollen geschützt. Weitere Informationen finden Sie im Artikel [Sicherheit aktivieren](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* Die JMX-Konfiguration lässt die Kommunikation zwischen dem Verwaltungsservice und der Laufzeitkomponente zu. Die Kommunikation verwendet SOAP. Für WebSphere Application Server Network Deployment kann RMI verwendet werden. Weitere Informationen finden Sie unten im Abschnitt **JMX-Verbindung für WebSphere Application Server und WebSphere Application Server Network Deployment konfigurieren**.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>Für Anweisungen zum Konfigurieren einer JMX-Verbindung für WebSphere Application Server und WebSphere Application Server Network Deployment hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} setzt die Konfiguration einer sicheren JMX-Verbindung voraus.</p>

                <ul>
                    <li>Die {{ site.data.keys.mf_server }} muss für die Durchführung von JMX-Operationen auf den SOAP-Port oder RMI-Port zugreifen. Standardmäßig ist der SOAP-Port in einer WebSphere-Application-Server-Instanz aktiv. Die {{ site.data.keys.mf_server }} verwendet standardmäßig den SOAP-Port. Wenn der SOAP- und der RMI-Port inaktiviert sind, kann die {{ site.data.keys.mf_server }} nicht ausgeführt werden.</li>
                    <li>RMI wird nur in Verbindung mit WebSphere Application Server Network Deployment unterstützt. Von einem eigenständigen Profil oder einer Server-Farm mit WebSphere Application Server wird RMI nicht unterstützt.</li>
                    <li>Sie müssen die Verwaltungssicherheit und die Anwendungssicherheit aktivieren.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Dateisystemvoraussetzungen
{: #file-system-prerequisites }
Wenn Sie die {{ site.data.keys.mf_server }} in einem
Anwendungsserver installieren möchten, müssen die {{ site.data.keys.product_adj }}-Installationstools von einem Benutzer mit bestimmten
Dateisystemzugriffsrechten ausgeführt werden.  
Zu den Installationstools gehören folgende:

* IBM Installation Manager
* Server Configuration Tool
* Ant-Tasks für die Implementierung von {{ site.data.keys.mf_server }}

Für WebSphere Application Server Liberty Profile müssen
Sie berechtigt sein, die folgenden Aktionen auszuführen:

* Dateien im Liberty-Installationsverzeichnis lesen
* Dateien im Konfigurationsverzeichnis des Liberty-Servers
(in der Regel usr/servers/Servername) erstellen, Sicherungskopien
erstellen und die Dateien server.xml und jvm.options modifizieren
* Dateien und Verzeichnisse im Liberty-Verzeichnis für gemeinsam genutzte Ressourcen (in der Regel
usr/shared) erstellen
* Dateien im Liberty-Serververzeichnis apps (in der Regel
usr/servers/Servername/apps) erstellen

Für WebSphere Application Server Full Profile und WebSphere Application Server
Network Deployment müssen
Sie berechtigt sein, die folgenden Aktionen auszuführen:

* Dateien im Installationsverzeichnis von WebSphere Application Server lesen
* Konfigurationsdatei des ausgewählten WebSphere Application Server Full Profile
oder des Deployment-Manager-Profils lesen
* Befehl wsadmin ausführen
* Dateien im Konfigurationsverzeichnis profiles erstellen (Die
Installationstools stellen Ressourcen in dieses Verzeichnis, z. B. gemeinsame Bibliotheken oder
JDBC-Treiber.)

Für Apache Tomcat müssen
Sie berechtigt sein, die folgenden Aktionen auszuführen:

* Konfigurationsverzeichnis lesen
* Sicherungsdateien erstellen und Dateien im Konfigurationsverzeichnis modifizieren, z. B.
server.xml und tomcat-users.xml
* Sicherungsdateien erstellen und Dateien im Verzeichnis bin modifizieren, z. B.
setenv.bat
* Dateien im Verzeichnis lib erstellen
* Dateien im Verzeichnis webapps erstellen

Der Benutzer, der den Anwendungsserver ausführt, muss bei allen genannten Anwendungsservern berechtigt sein, die
Dateien zu lesen, die von dem Benutzer, der die
{{ site.data.keys.product_adj }}-Installationstools ausgeführt hat, erstellt wurden.

## Installation mit dem Server Configuration Tool
{: #installing-with-the-server-configuration-tool }
Sie können die MobileFirst-Server-Komponenten mit dem
Server Configuration Tool in Ihrem Anwendungsserver installieren. 

Das Server Configuration Tool
kann die Datenbank einrichten und die Komponenten in einem Anwendungsserver installieren. Dieses Tool ist für Einzelbenutzer bestimmt. Die Konfigurationsdateien werden auf Platte gespeichert. Das Verzeichnis, in dem sie
gespeichert werden, kann über die Menüoptionen
**File → Preferences** modifiziert werden. Die Dateien dürfen nur von jeweils einer
Instanz des
Server Configuration Tool verwendet werden. Das Tool kann den
gleichzeitigen Zugriff auf dieselbe Datei nicht handhaben. Wenn Sie mehrere Instanzen des Tools haben, die auf dieselbe
Datei zugreifen, könnten die Daten verlorengehen. Weitere Informationen zum Erstellen und Einrichten der Datenbanken mit dem Tool finden Sie unter
[Datenbanktabellen mit dem Server Configuration Tool erstellen](../databases/#create-the-database-tables-with-the-server-configuration-tool). Bereits vorhandene Datenbanken werden vom Tool erkannt. Das Tool überprüft dafür das Vorhandensein und den Inhalt
einiger Testtabellen, ohne diese Datenbanktabellen zu modifizieren. 

* [Unterstützte Betriebssysteme](#supported-operating-systems)
* [Unterstützte Topologien](#supported-topologies)
* [Server Configuration Tool ausführen](#running-the-server-configuration-tool)
* [Fixpack mit dem Server Configuration Tool anwenden](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### Unterstützte Betriebssysteme
{: #supported-operating-systems }
Sie können das Server Configuration Tool verwenden, wenn Sie eines der
folgenden Betriebssysteme verwenden: 

* Windows x86 oder x86-64
* macOS x86-64
* Linux x86
oder Linux x86-64

Das Tool ist für andere Betriebssysteme nicht verfügbar. Sie können
Ant-Tasks für die Installation der
MobileFirst-Server-Komponenten verwenden (siehe [Installation mit Ant Tasks](#installing-with-ant-tasks)).

### Unterstützte Topologien
{: #supported-topologies }
Das Server Configuration Tool installiert die
MobileFirst-Server-Komponenten mit folgenden Topologien: 

* Alle Komponenten ({{ site.data.keys.mf_console }}, MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die
{{ site.data.keys.product_adj }}-Laufzeit)
werden in einem Anwendungsserver installiert. Bei einer Installation in einem Cluster mit
WebSphere Application Server Network Deployment können Sie jedoch für den Verwaltungs- und Liveaktualisierungsservice und für
die Laufzeit einen anderen Cluster angeben. Bei einem Liberty-Verbund
werden die {{ site.data.keys.mf_console }}, der Verwaltungsservice und der Liveaktualisierungsservice in einem Verbundcontroller und die Laufzeit in einem Verbundmember
installiert.
* Wenn der MobileFirst-Server-Push-Service installiert werden soll, muss er auch in demselben Server installiert werden. Bei einer Installation in einem Cluster mit
WebSphere Application Server Network Deployment kann für den Push-Service
jedoch
ein anderer Cluster angegeben werden. Bei einem Liberty-Verbund wird der Push-Service in einem Liberty-Member installiert.
Dabei kann es sich um das Member handeln, in dem auch die Laufzeit installiert ist.
* Alle Komponenten verwenden dasselbe Datenbanksystem und denselben Benutzer. Bei Verwendung von DB2 verwenden alle Komponenten zudem dasselbe Schema.
* Das Server Configuration Tool installiert die Komponenten für einen
Einzelserver, außer bei einer asymmetrischen Implementierung in einem Liberty-Verbund und in
WebSphere Application Server Network Deployment. Wenn die Installation auf mehreren Servern erfolgen soll, muss nach Ausführung des Tools eine Farm konfiguriert werden. In
WebSphere Application Server Network Deployment ist keine Server-Farmkonfiguration erforderlich. 

Für andere Topologien oder Datenbankeinstellungen können Sie die Komponenten mit Ant-Tasks oder manuell installieren. 

### Server Configuration Tool ausführen
{: #running-the-server-configuration-tool }
Bevor Sie das Server Configuration Tool ausführen, müssen die folgenden
Bedingungen erfüllt sein: 

* Die Datenbanken und Tabellen für die Komponenten sind erstellt und einsatzbereit (siehe [Datenbanken einrichten](../databases)). 
* Die Servertopologie für die Installation der Komponenten ist festgelegt (siehe [Topologien und Netzabläufe](../topologies)). 
* Der Anwendungsserver ist konfiguriert (siehe [Voraussetzungen für Anwendungsserver](#application-server-prerequisites)).
* Der Benutzer, der das Tool ausführt, verfügt über die erforderlichen Dateisystemberechtigungen
(siehe [Dateisystemvoraussetzungen](#file-system-prerequisites)).

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>Für Anweisungen zur Ausführung des Server Configuration Tool hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Starten Sie das Server Configuration Tool.
                        <ul>
                            <li>Nutzen Sie unter Linux den Direktaufruf <b>Applications → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>Klicken Sie unter Windows auf <b>Start → Programme → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>Öffnen Sie unter macOS eine Shell-Konsole. Navigieren Sie zu <b>MFP-Server-Installationsverzeichnis/shortcuts</b> und geben Sie <b>./configuration-tool.sh</b> ein.</li>
                            <li><b>MFP-Server-Installationsverzeichnis</b> ist das Verzeichnis, in dem Sie {{ site.data.keys.mf_server }} installiert haben.</li>
                        </ul>
                    </li>
                    <li>Wählen Sie <b>File → New Configuration</b> aus, um eine MobileFirst-Server-Konfiguration zu erstellen.
                        <ul>
                            <li>Geben Sie im Fenster <b>Configuration Details</b> das Kontextstammverzeichnis des Verwaltungsservice und der Laufzeitkomponente ein. Außerdem sollten Sie eine Umgebungs-ID eingeben. Eine Umgebungs-ID wird in professionellen Anwendungsfällen verwendet, z. B., wenn <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">in einem Anwendungsserver oder in einer WebSphere-Application-Server-Zelle mehrere Instanzen von MobileFirst Server installiert werden</a>.</li>
                            <li>Entscheiden Sie im Fenster <b>Console Settings</b>, ob die {{ site.data.keys.mf_console }} installiert werden soll. Wenn die Konsole nicht installiert ist, müssen Sie für die Interaktion mit dem MobileFirst-Server-Verwaltungsservice Befehlszeilentools (<b>mfpdev</b> oder <b>mfpadm</b>) oder die REST-API verwenden.</li>
                            <li>Wählen Sie im Fenster <b>Database Selection</b> das zu verwendende Datenbankmanagementsystem aus. Alle Komponenten verwenden denselben Datenbanktyp und dieselbe Datenbankinstanz. Weitere Informationen zu den Fenstern für Datenbankangaben finden Sie unter <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Datenbanktabellen mit dem Server Configuration Tool erstellen</a>.</li>
                            <li>Wählen Sie im Fenster <b>Application Server Selection</b> den Anwendungsservertyp für die Implementierung von {{ site.data.keys.mf_server }} aus.</li>
                        </ul>
                    </li>
                    <li>Wählen Sie im Fenster <b>Application Server Settings</b> den Anwendungsserver aus. Gehen Sie dann wie folgt vor:
                        <ul>
                            <li>Installation in WebSphere Application Server Liberty:
                                <ul>
                                    <li>Geben Sie das Liberty-Installationsverzeichnis und den Namen des Servers für die Installation von {{ site.data.keys.mf_server }} ein.</li>
                                    <li>Sie können einen Standardbenutzer für die Anmeldung bei der Konsole erstellen. Dieser Benutzer wird in der Liberty-Basisregistry erstellt. Für eine Produktionsinstallation sollten Sie die Option <b>Create a default user</b> abwählen und den Benutzerzugriff nach der Installation konfigurieren. Weitere Informationen finden Sie unter <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren</a>.</li>
                                    <li>Wählen Sie den Implementierungstyp aus: <b>Standalone deployment</b> (Standardeinstellung) oder <b>Server farm deployment</b> oder <b>Liberty collective deployment</b>.</li>
                                </ul>

                                Wenn Sie die Option "Liberty collective deployment" ausgewählt haben, gehen Sie wie folgt vor:
                                <ul>
                                    <li>Machen Sie folgende Angaben:
                                        <ul>
                                            <li>Liberty-Verbundserver, auf dem die {{ site.data.keys.mf_console }} und der Liveaktualisierungsservice installiert sind. Der Server muss ein Liberty-Verbundcontroller sein.</li>
                                            <li>Liberty-Verbundserver, auf dem die Laufzeit installiert ist. Der Server muss ein Liberty-Verbundmember sein.</li>
                                            <li>Liberty-Verbundserver, auf dem der Push-Service installiert ist. Der Server muss ein Liberty-Verbundmember sein.</li>
                                        </ul>
                                    </li>
                                    <li>Geben Sie die Server-ID des Members ein. Jedes Member des Verbunds muss eine andere Kennung haben.</li>
                                    <li>Geben Sie den Clusternamen der Verbundmember ein.</li>
                                    <li>Geben Sie den Hostnamen und die HTTPS-Portnummer des Controllers ein. Die Werte müssen mit denen übereinstimmen, die im Element <code>variable</code> in der Datei <b>server.xml</b> des Liberty-Verbundcontrollers definiert sind.</li>
                                    <li>Geben Sie den Benutzernamen und das Kennwort des Controlleradministrators ein.</li>
                                </ul>
                            </li>
                            <li>Installation in WebSphere Application Server oder WebSphere Application Server Network Deployment:
                                <ul>
                                    <li>Geben Sie das Installationsverzeichnis für WebSphere Application Server ein.</li>
                                    <li>Wählen Sie das WebSphere-Application-Server-Profil aus, in dem Sie {{ site.data.keys.mf_server }} installieren möchten. Wählen Sie bei einer Installation in WebSphere Application Server Network Deployment das Profil des Deployment Manager aus. Im Deployment-Manager-Profil können Sie einen Geltungsbereich auswählen (<b>Server</b> oder <b>Cluster</b>). Bei Auswahl von <b>Cluster</b> müssen Sie Folgendes angeben:
                                        <ul>
                                            <li>Liberty-Verbundserver, auf dem die Laufzeit installiert ist.</li>
                                            <li>Liberty-Verbundserver, auf dem die {{ site.data.keys.mf_console }} und der Liveaktualisierungsservice installiert sind.</li>
                                            <li>Liberty-Verbundserver, auf dem der Push-Service installiert ist.</li>
                                        </ul>
                                    </li>
                                    <li>Geben Sie eine Administratoranmelde-ID und das zugehörige Kennwort ein. Der Benutzer mit Administratorberechtigung muss eine Administratorrolle haben.</li>
                                    <li>Wenn Sie die Option <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b> auswählen, wird der für die Installation von {{ site.data.keys.mf_server }} verwendete Benutzer der Verwaltungssicherheitsrolle der Konsole zugeordnet, die sich mit Administratorrechten bei der Konsole anmelden kann. Dieser Benutzer wird auch der Sicherheitsrolle des Liveaktualisierungsservice zugeordnet. Der Benutzername und das Kennwort werden als JNDI-Eigenschaften (<b>mfp.config.service.user</b> und <b>mfp.config.service.password</b>) des Verwaltungsservice definiert.</li>
                                    <li>Wenn Sie die Option <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b> nicht auswählen, müssen Sie vor der Verwendung von {{ site.data.keys.mf_server }} die folgenden Schritte ausführen:
                                        <ul>
                                            <li>Ermöglichen Sie die Kommunikation zwischen dem Verwaltungsservice und dem Liveaktualisierungsservice.
                                                <ul>
                                                    <li>Ordnen Sie einen Benutzer der Sicherheitsrolle <b>configadmin</b> des Liveaktualisierungsservice zu.</li>
                                                    <li>Geben Sie die Anmelde-ID und das Kennwort dieses Benutzers mit den JNDI-Eigenschaften (<b>mfp.config.service.user</b> und <b>mfp.config.service.password</b>) des Verwaltungsservice an.</li>
                                                    <li>Ordnen Sie den Sicherheitsrollen des Verwaltungsservice und der {{ site.data.keys.mf_console }} Benutzer zu (siehe <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren</a>).</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>Installation in Apache Tomcat:
                                <ul>
                                    <li>Geben Sie das Installationsverzeichnis von Apache Tomcat ein.</li>
                                    <li>Geben Sie den für die JMX-Kommunikation mit RMI verwendeten Port ein. Der Standardport ist 8686. Das Server Configuration Tool modifiziert zum Öffnen dieses Ports die Datei <b>Tomcat-Installationsverzeichnis/bin/setenv.bat</b> oder <b>Tomcat-Installationsverzeichnis/bin/setenv.sh</b>. Wenn Sie den Port manuell öffnen wollen oder bereits in <b>setenv.bat</b> oder <b>setenv.sh</b> über Code zum Öffnen des Ports verfügen, verwenden Sie das Tool nicht. Verwenden Sie stattdessen Ant-Tasks für die Installation. Bei der Installation mit Ant-Tasks gibt es eine Option für das manuelle Öffnen des RMI-Ports.</li>
                                    <li>Erstellen Sie einen Standardbenutzer für die Anmeldung bei der Konsole. Dieser Benutzer wird auch in der Konfigurationsdatei <b>tomcat-users.xml</b> erstellt. Für eine Produktionsinstallation sollten Sie die Option Create a default user abwählen und den Benutzerzugriff nach der Installation konfigurieren. Weitere Informationen finden Sie unter <a href="../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren</a>.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Wählen Sie im Fenster <b>Push Service Settings</b> die Option <b>Install the Push service</b> aus, wenn der Push-Service im Anwendungsserver installiert werden soll. Das Kontextstammverzeichnis ist <b>imfpush</b>. Definieren Sie die folgenden Parameter, um die Kommunikation zwischen dem Push-Service und dem Verwaltungsservice zu ermöglichen:
                        <ul>
                            <li>Geben Sie die URL des Push-Service und die URL der Laufzeit ein. Diese URL kann für eine Installation in Liberty, Apache Tomcat oder einem eigenständigen WebSphere Application Server automatisch berechnet werden. Dafür wird die URL der Komponente (Laufzeit oder Push-Service) auf dem lokalen Server verwendet. Wenn Sie die Installation in WebSphere Application Server Network Deployment ausführen oder die Kommunikation über einen Web-Proxy oder Load Balancer erfolgt, müssen Sie die URL manuell eingeben.</li>
                            <li>Geben Sie die ID und den geheimen Schlüssel der vertraulichen Clients für die OAuth-Kommunikation zwischen den Services ein. Andernfalls generiert das Tool Standardwerte und zufällige Kennwörter.</li>
                        </ul>
                    </li>
                    <li>Wählen Sie im Fenster <b>Analytics Settings</b> die Option <b>Enable the connection to the Analytics server</b> aus, wenn {{ site.data.keys.mf_analytics }} installiert wird. Geben Sie die folgenden Verbindungseinstellungen ein:
                        <ul>
                            <li>URL der Analysekonsole</li>
                            <li>URL des Analytics-Servers (Analytics-Datenservice)</li>
                            <li>Anmelde-ID und Kennwort des Benutzers, der Daten auf dem Analytics-Server veröffentlichen darf</li>
                        </ul>

                        Das Tool konfiguriert die Laufzeit und den Push-Service für das Senden von Daten an den Analytics-Server.
                    </li>
                    <li>Klicken Sie auf <b>Deploy</b>, um mit der Installation fortzufahren.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

Nach erfolgreicher Installation in Apache Tomcat oder Liberty Profile müssen Sie den Anwendungsserver neu starten.

Wenn
Apache Tomcat als Dienst gestartet wird, kann die Datei
setenv.bat oder setenv.sh mit der Anweisung zum Öffnen von RMI
möglicherweise nicht gelesen werden. In dem Fall
wird {{ site.data.keys.mf_server }} unter Umständen nicht
ordnungsgemäß funktionieren. Wie die erforderlichen Variablen definiert werden, erfahren Sie unter
[JMX-Verbindung für Apache Tomcat konfigurieren](#apache-tomcat-prerequisites). 

In
WebSphere Application Server Network Deployment werden die Anwendungen installiert, aber nicht
gestartet. Sie müssen sie manuell starten. Diesen Schritt können Sie in der
Administrationskonsole von WebSphere Application Server ausführen. 

Speichern Sie die
Konfigurationsdatei im Server Configuration Tool.
Möglicherweise benötigen Sie sie später für die Installation vorläufiger Fixes. Die Menüoptionen für die Anwendung eines vorläufigen Fix
sind **Configurations > Replace the deployed WAR files**.

### Fixpack mit dem Server Configuration Tool anwenden
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Wenn {{ site.data.keys.mf_server }} mit dem Server Configuration Tool installiert wurde und Sie die
Konfigurationsdatei aufbewahrt haben,
können Sie beim Anwenden eines Fixpacks oder eines vorläufigen Fix die Konfigurationsdatei wiederverwenden. 

1. Starten Sie das Server Configuration Tool.
    * Nutzen Sie unter Linux den Direktaufruf
**Applications
→ IBM MobileFirst Platform Server → Server Configuration
Tool**. 
    * Klicken Sie unter Windows auf **Start → Programme → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Öffnen Sie unter macOS eine Shell-Konsole. Navigieren Sie zu **MFP-Server-Installationsverzeichnis/shortcuts** und geben Sie
**./configuration-tool.sh** ein.
    * **MFP-Server-Installationsverzeichnis** ist das Verzeichnis, in dem Sie
{{ site.data.keys.mf_server }} installiert haben.

2. Klicken Sie auf **Configurations → Replace the deployed WAR files** und wählen Sie
eine vorhandene Konfiguration aus, um das Fixpack oder einen vorläufigen Fix anzuwenden. 

## Installation mit Ant-Tasks
{: #installing-with-ant-tasks }
Sie können die MobileFirst-Server-Komponenten mit Ant-Tasks in Ihrem Anwendungsserver installieren. 

Die Beispielkonfigurationsdateien für die Installation
von {{ site.data.keys.mf_server }} finden Sie im Verzeichnis
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples**. 

Sie können auch eine Konfiguration mit dem
Server Configuration Tool erstellen und
**File → Export Configuration
as Ant Files...** auswählen, um die Ant-Dateien zu exportieren. Für die Ant-Beispieldateien gelten dieselben Einschränkungen wie für das
Server Configuration Tool:

* Alle Komponenten ({{ site.data.keys.mf_console }}, MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice, die MobileFirst-Server-Artefakte sowie die MobileFirst-Foundation-Laufzeit) müssen in einem Anwendungsserver installiert werden. Bei einer Installation in einem Cluster mit WebSphere Application Server Network Deployment können Sie jedoch für den Verwaltungs- und Liveaktualisierungsservice und für die Laufzeit einen anderen Cluster angeben.
* Wenn der MobileFirst-Server-Push-Service installiert werden soll, muss er auch in demselben Server installiert werden. Bei einer Installation in einem Cluster mit WebSphere Application Server Network Deployment kann für den Push-Service jedoch ein anderer Cluster angegeben werden.
* Alle Komponenten verwenden dasselbe Datenbanksystem und denselben Benutzer. Bei Verwendung von DB2 verwenden alle Komponenten zudem dasselbe Schema.
* Das Server Configuration Tool installiert die Komponenten für einen Einzelserver. Wenn die Installation auf mehreren Servern erfolgen soll, muss nach Ausführung des Tools eine Farm konfiguriert werden. Die Server-Farmkonfiguration wird von WebSphere Application Server Network Deployment nicht unterstütz.

Sie können mit Ant-Tasks die Ausführung der Services von {{ site.data.keys.mf_server }}
in einer Server-Farm konfigurieren. Für die Aufnahme Ihres Servers in eine Farm müssen Sie
bestimmte Attribute angeben, mit denen Ihr Anwendungsserver entsprechend konfiguriert wird. Weitere Informationen zum Konfigurieren einer Server-Farm mit Ant-Tasks finden Sie
unter [Server-Farm mit Ant-Tasks installieren](#installing-a-server-farm-with-ant-tasks). 

Für andere unterstützte Topologien (siehe [Topologien und Netzabläufe](../topologies)) können Sie die Ant-Beispieldateien modifizieren. 

Es handelt sich um folgende Ant-Tasks: 

* [Ant-Tasks für die Installation der {{ site.data.keys.mf_console }}, der MobileFirst-Server-Artefakte, des MobileFirst-Server-Verwaltungsservice und des Liveaktualisierungsservice](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Ant-Tasks für die Installation des MobileFirst-Server-Push-Service](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

Eine Übersicht über die Installation mit der Beispielkonfigurationsdatei und den Beispiel-Taks finden Sie unter
[{{ site.data.keys.mf_server }} im Befehlszeilenmodus installieren](../tutorials/command-line).

Sie können eine Ant-Datei mit der Ant-Distribution ausführen, die Teil der Produktinstallation ist. Wenn Sie beispielsweise einen Cluster mit
WebSphere Application Server Network Deployment und
IBM DB2 als Datenbank verwenden, können Sie die
Ant-Datei **MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml** verwenden. Wenn Sie die Datei
bearbeitet und alle erforderlichen Eigenschaften eingegeben haben, können Sie im Verzeichnis
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples** die folgenden Befehle ausführen: 

* **MFP-Installationsverzeichnis/shortcuts/ant -f configure-wasnd-cluster-db2.xml
help** - Mit diesem Befehl wird die Liste aller gültigen Ziele der Ant-Datei für die Installation, Deinstallation oder Aktualisierung von
Komponenten angezeigt. 
* **MFP-Installationsverzeichnis/shortcuts/ant -f configure-wasnd-cluster-db2.xml
install** - Mit diesem Befehl wird {{ site.data.keys.mf_server }} in dem Cluster
mit WebSphere Application Server Network Deployment und DB2 als Datenquelle installiert.
Dabei werden die in den Eigenschaften der Ant-Datei angegebenen Parameter verwendet. 

<br/>
Erstellen Sie nach der Installation eine Kopie der Ant-Datei, die Sie später für die Anwendung eines Fixpacks nutzen können. 

### Fixpack mit Ant-Dateien anwenden
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Aktualisierung mit der Ant-Beispieldatei
{: #updating-with-the-sample-ant-file }
Wenn Sie eine der Ant-Beispieldateien aus dem Verzeichnis
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples**
für die Installation von {{ site.data.keys.mf_server }} verwendet haben, können Sie eine
Kopie dieser Ant-Datei für die Anwendung eines Fixpacks nutzen. Als Kennwort können Sie
12 Sterne (\*) anstelle des tatsächlichen Wertes angeben. Sie werden dann zur Eingabe des Kennworts aufgefordert, wenn die Ant-Datei
ausgeführt wird. 

1. Überprüfen Sie den Wert der Eigenschaft **mfp.server.install.dir** in der Ant-Datei. Er muss auf das Verzeichnis zeigen, das das Produkt mit dem angewendeten Fixpack enthält. Aus diesem Verzeichnis werden
die aktualisierten MobileFirst-Server-WAR-Dateien
verwendet. 
2. Führen Sie den Befehl `MFP-Installationsverzeichnis/shortcuts/ant -f Ihre_Ant-Datei update` aus. 

#### Aktualisierung mit eigener Ant-Datei
{: #updating-with-own-ant-file }
Wenn Sie Ihre eigene Ant-Datei verwenden, muss sie für alle Installations-Tasks
(**installmobilefirstadmin**, **installmobilefirstruntime** und
**installmobilefirstpush**) eine entsprechende Aktualisierungs-Task mit den gleichen Parametern enthalten. Die zugehörigen Aktualisierungs-Tasks
sind **updatemobilefirstadmin**, **updatemobilefirstruntime** und
**updatemobilefirstpush**. 

1. Überprüfen Sie den Klassenpfad des Elements **taskdef** für die Datei
**mfp-ant-deployer.jar**. Der Pfad muss auf die Datei
**mfp-ant-deployer.jar** einer MobileFirst-Server-Installation mit angewendetem Fixpack
zeigen. Die aktualisierten MobileFirst-Server-WAR-Dateien werden standardmäßig von der Position der Datei
**mfp-ant-deployer.jar** verwendet.
2. Führen Sie die Aktualisierungs-Tasks (**updatemobilefirstadmin**,
**updatemobilefirstruntime** und **updatemobilefirstpush**) in Ihrer Ant-Datei aus. 

### Modifizieren der Ant-Beispieldateien
{: #sample-ant-files-modifications }
Sie können die im Verzeichnis
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples** bereitgestellten Ant-Beispieldateien an Ihre Installationsanforderungen
anpassen.   
In den folgenden Abschnitten erfahren Sie, wie Sie die Ant-Beispieldateien modifizieren und die Installation an Ihre Anforderungen anpassen
können: 

1. [Zusätzliche JNDI-Eigenschaften angeben](#specify-extra-jndi-properties)
2. [Vorhandene Benutzer angeben](#specify-existing-users)
3. [Liberty-Java-EE-Version angeben](#specify-liberty-java-ee-level)
4. [JDBC-Eigenschaften der Datenquelle angeben](#specify-data-source-jdbc-properties)
5. [Ant-Dateien auf einem Computer ohne {{ site.data.keys.mf_server }} ausführen](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Ziele für WebSphere Application Server Network Deployment angeben](#specify-websphere-application-server-network-deployment-targets)
7. [RMI-Port für
Apache Tomcat manuell konfigurieren](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Zusätzliche JNDI-Eigenschaften angeben
{: #specify-extra-jndi-properties }
Die Ant-Tasks
**installmobilefirstadmin**, **installmobilefirstruntime**
und **installmobilefirstpush** deklarieren die Werte für JNDI-Eigenschaften, die erforderlich sind, damit die Komponenten
funktionieren. Mit diesen JNDI-Eigenschaften werden die JMX-Kommunikation und die Links zu anderen
Komponenten definiert (z. B. zum Liveaktualisierungsservice, zum Push-Service, zum Analyseservice oder zum Autorisierungsserver). Sie können aber auch Werte für andere JNDI-Eigenschaften
definieren. Verwenden Sie dafür das Element `<property>` der drei genannten Tasks. Eine Liste der JNDI-Eigenschaften finden Sie unter: 

* [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

Beispiel: 

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin> 
```

#### Vorhandene Benutzer angeben
{: #specify-existing-users }
Die Ant-Task
**installmobilefirstadmin** ertellt standardmäßig Benutzer. 

* In WebSphere Application Server Liberty definiert sie einen
Liberty-Administrator für die JMX-Kommunikation. 
* In einem beliebigen Anwendungsserver definiert sie einen Benutzer für die Kommunikation mit dem Liveaktualisierungsservice. 

Wenn Sie keinen neuen Benutzer erstellen, sondern einen vorhandenen Benutzer
verwenden möchten, können Sie wie folgt vorgehen: 

1. Geben Sie im Element `<jmx>` einen Benutzer und ein Kennwort an und setzen Sie das Attribut **createLibertyAdmin** auf den Wert "false". Beispiel: 

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. Geben Sie im Element `<configuration>` einen Benutzer und ein Kennwort an und setzen Sie das Attribut **createConfigAdminUser** auf den Wert "false". Beispiel: 

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

Der von den Ant-Beispieldateien erstellte Benutzer wird den Sicherheitsrollen des Verwaltungsservice und der Konsole
zugeordnet. Dieser Benutzer kann sich also nach der Installation bei
{{ site.data.keys.mf_server }} anmelden. Wenn Sie dieses Verhalten ändern möchten, entfernen Sie das Element `<user>` aus den Ant-Beispieldateien. Alternativ dazu können Sie das Attribut **password** aus dem Element `<user>` entfernen, damit der Benutzer nicht in der lokalen Registry des Anwendungsservers erstellt wird. 

#### Liberty-Java-EE-Version angeben
{: #specify-liberty-java-ee-level }
Einige Distributionen von
WebSphere Application Server Liberty unterstützen Features
von Java EE 6 oder Java EE 7. Standardmäßig erkennen die
Ant-Tasks automatisch, welche Features installiert werden müssen. Das Liberty-Feature **jdbc-4.0** wird beispielsweise für
Java EE
6 und das Feature **jdbc-4.1** für Java EE 7 installiert. Wenn die Liberty-Installation Features sowohl von
Java EE
6 als auch von Java EE 7 unterstützt, können Sie die Verwendung einer bestimmten Version der Features durchsetzen. Angenommen,
Sie planen,
{{ site.data.keys.mf_server }} Version 8.0.0
und Version 7.1.0 auf demselben Liberty-Server auszuführen. Bis Version 7.1.0 unterstützt {{ site.data.keys.mf_server }}
nur Features von Java EE 6. 

Wenn Sie also die Verwendung der Features von Java EE 6 erzwingen wollen, verwenden Sie das Attribut jeeversion des Elements `<websphereapplicationserver>`. Beispiel:

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### JDBC-Eigenschaften der Datenquelle angeben
{: #specify-data-source-jdbc-properties }
Sie können die Eigenschaften der JDBC-Verbindung mit dem Element `<property>` eines Elements `<database>` angeben. Dieses Element ist in den Ant-Tasks **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime** und **installmobilefirstpush** verfügbar. Beispiel:

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### Ant-Dateien auf einem Computer ohne {{ site.data.keys.mf_server }} ausführen
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
Wenn Sie die Ant-Tasks
auf einem Computer ohne installierten {{ site.data.keys.mf_server }} ausführen
möchten, benötigen Sie Folgendes: 

* Ant-Installation
* Kopie der Datei **mfp-ant-deployer.jar** für den fernen Computer. Diese Bibliothek enthält die Definition der Ant-Tasks. 
* Angabe der zu installierenden Ressourcen. Stanardmäßig werden die WAR-Dateien aus dem Umfeld von
**mfp-ant-deployer.jar** verwendet. Sie können die Position dieser WAR-Dateien jedoch angeben. Beispiel:

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

Weitere Informationen zur Verwendung von Ant-Tasks für die Installation der einzelnen MobileFirst-Server-Komponenten finden Sie in den [Referenzinformationen zur Installation](../installation-reference).

#### Ziele für WebSphere Application Server Network Deployment angeben
{: #specify-websphere-application-server-network-deployment-targets }
Für die Installation in WebSphere Application Server Network Deployment muss der Deployment Manager als WebSphere-Application-Server-Profil angegeben werden. Die Implementierung ist in folgenden Konfigurationen möglich: 

* Cluster
* Einzelserver
* Zelle (alle Server einer Zelle)
* Knoten (alle Server eines Knotens)

Die Beispieldateien (z. B.
**configure-wasnd-cluster-DBMS.xml**,
**configure-wasnd-server-DBMS.xml**
und **configure-wasnd-node-DBMS.xml**) enthalten die Deklaration für die Implementierung in den einzelnen Zielarten. Weitere Informationen
zur Verwendung von Ant-Tasks für die Installation der einzelnen MobileFirst-Server-Komponenten finden Sie in den
[Referenzinformationen zur Installation](../installation-reference).

> Hinweis: Ab
Version 8.0.0 wird keine Beispielkonfigurationsdatei für eine WebSphere-Application-Server-Network-Deployment-Zelle
bereitgestellt. 


#### RMI-Port für Apache Tomcat manuell konfigurieren
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
Die Ant-Tasks modifizieren standardmäßig die Datei **setenv.bat** oder
**setenv.sh**, um den RMI-Port zu öffnen. Wenn Sie den RMI-Port lieber manuell öffnen möchten, fügen Sie in den Tasks **installmobilefirstadmin**, **updatemobilefirstadmin** und **uninstallmobilefirstadmin** das Attribut **tomcatSetEnvConfig** mit dem Wert "false" zum Element `<jmx>` hinzu. 

## MobileFirst-Server-Komponenten manuell installieren
{: #installing-the-mobilefirst-server-components-manually }
Sie können die MobileFirst-Server-Komponenten manuell in Ihrem Anwendungsserver installieren.   
In den folgenden Abschnitten finden Sie vollständige Informationen, die Sie durch den Prozess für die Installation der
Komponenten in den unterstützten Anwendungen in der Produktion führen. 

* [Manuelle Installation in WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty)
* [Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund](#manual-installation-on-websphere-application-server-liberty-collective)
* [Manuelle Installation in Apache Tomcat](#manual-installation-on-apache-tomcat)
* [Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### Manuelle Installation in WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty }
Vergewissern Sie sich, dass die unter [Voraussetzungen für WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites) dokumentierten Voraussetzungen erfüllt sind. 

* [Topologieeinschränkungen](#topology-constraints)
* [Anwendungsservereinstellungen](#application-server-settings)
* [Für MobileFirst-Server-Anwendungen erforderliche Liberty-Features](#liberty-features-required-by-the-mobilefirst-server-applications)
* [Globale JNDI-Einträge](#global-jndi-entries)
* [Klassenladeprogramm](#class-loader)
* [Benutzerfeature Kennwort-Decoder](#password-decoder-user-feature)
* [Konfigurationsdetails](#configuration-details-liberty)

#### Topologieeinschränkungen
{: #topology-constraints }
Der MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die MobileFirst-Laufzeit müssen in einem Anwendungsserver installiert werden. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert:
"**Kontextstammverzeichnis_des_Verwaltungsservice**config". Das Kontextstammverzeichnis des Push-Service muss **imfpush** sein. Weitere Informationen zu den Einschränkungen finden Sie unter
[Einschränkungen für die
MobileFirst-Server-Komponenten und für {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Anwendungsservereinstellungen
{: #application-server-settings }
Sie müssen das Element
**webContainer** so konfigurieren, dass die Servlets sofort geladen werden. Diese Einstellung ist für die Initialisierung mit
JMX erforderlich. Beispiel: `<webContainer deferServletLoad="false"/>`.

Um Probleme durch Zeitlimitüberschreitungen zu vermeiden, die
in einigen Liberty-Versionen die Startsequenz für die Laufzeit und den Verwaltungsservice unterbrechen,
können Sie das Standardelement
**executor** ändern. Legen Sie für die Attribute
**coreThreads** und **maxThreads** große Werte fest.
Beispiel:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Sie können auch das Element **tcpOptions** konfigurieren und das Attribut **soReuseAddr** auf `true` setzen: `<tcpOptions soReuseAddr="true"/>`

#### Für MobileFirst-Server-Anwendungen erforderliche Liberty-Features
{: #liberty-features-required-by-the-mobilefirst-server-applications }
Für
Java EE
6 oder Java EE 7 können Sie die folgenden Features verwenden. 

**MobileFirst-Server-Verwaltungsservice**

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**MobileFirst-Server-Push-Service**  

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **servlet-3.0** (servlet-3.1 für Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }}-Laufzeit**  

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **servlet-3.0** (servlet-3.1 für Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Globale JNDI-Einträge
{: #global-jndi-entries }
Die folgenden globalen JNDI-Einträge sind erforderlich, um die
JMX-Kommunikation zwischen der Laufzeit und dem Verwaltungsservice zu konfigurieren: 

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

Diese globalen JNDI-Einträge werden mit der folgenden Syntax definiert. Den Einträgen wird kein Kontextstammverzeichnis vorangestellt. Beispiel: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Hinweis:** Verwenden Sie beim Definieren der JNDI-Werte die Syntax '"075"', um die Werte vor einer einer automatischen Konvertierung zu schützen, bei der 075 in 61 oder 31.500 in 31.5 konvertiert werden würde.



Weitere Informationen zu den JNDI-Eigenschaften für den Verwaltungsservice finden Sie in der
[Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  

Lesen Sie für eine Farmkonfiguration auch die folgenden
Artikel: 

* [Server-Farmtopologie](../topologies/#server-farm-topology)
* [Topologien und Netzabläufe](../topologies)
* [Server-Farm installieren](#installing-a-server-farm)

#### Klassenladeprogramm
{: #class-loader }
Das Klassenladeprogramm für alle Anwendungen muss mit der Delegierung
"Übergeordnete zuletzt" (parentLast) arbeiten. Beispiel:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Benutzerfeature Kennwort-Decoder
{: #password-decoder-user-feature }
Kopieren Sie den Kennwort-Decoder in Ihr Liberty-Profil. Beispiel:

* Auf UNIX- und Linux-Systemen:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp Produktinstallationsverzeichnis/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp Produktinstallationsverzeichnis/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Auf Windows-Systemen:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B Produktinstallationsverzeichnis\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B Produktinstallationsverzeichnis\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### Konfigurationsdetails
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>Konfigurationsdetails für den MobileFirst-Server-Verwaltungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>Der Verwaltungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Die WAR-Datei für den Verwaltungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-service.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpadmin</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis des Verwaltungsservice als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.admin.push.url</b>, wenn der Verwaltungsservice mit dem Kontextstammverzeichnis <b>/mfpadmin</b> installiert ist:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Wenn der Push-Service installiert ist, müssen Sie die folgenden JNDI-Eigenschaften konfigurieren:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Die JNDI-Eigenschaften für die Kommunikation mit dem Konfigurationsservice sind folgende:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice</a>.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Dateiquelle für den Verwaltungsservice muss <b>jndiName=Kontextstammverzeichnis/jdbc/mfpAdminDS</b> definiert werden. Das folgende Beispiel zeigt einen Fall, bei dem der Verwaltungsservice mit dem Kontextstammverzeichnis <b>/mfpadmin</b> installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Deklarieren Sie die folgenden Rollen im Element <b>application-bnd</b> der Anwendung:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>Konfigurationsdetails für den MobileFirst-Server-Liveaktualisierungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>Der Liveaktualisierungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für den Liveaktualisierungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-live-update.war</b>. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert: "<b>Kontextstammverzeichnis_des_Verwaltungsservice</b>config". Wenn das Kontextstammverzeichnis des Verwaltungsservice beispielsweise <b>/mfpadmin</b> ist, muss der Liveaktualisierungsservice das Kontextstammverzeichnis <b>/mfpadminconfig</b> haben.</p>

                <h3>Datenquelle</h3>
                <p>Der JNDI-Name der Datenquelle für den Liveaktualisierungsservice muss wie folgt definiert werden: "Kontextstammverzeichnis/jdbc/ConfigDS". Das folgende Beispiel zeigt einen Fall, bei dem der Liveaktualisierungsservice mit dem Kontextstammverzeichnis /mfpadminconfig installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Deklarieren Sie im Element <b>application-bnd</b> der Anwendung die Rolle configadmin. Dieser Rolle muss mindestens ein Benutzer zugeordnet sein. Der Benutzer und sein Kennwort müssen in den folgenden JNDI-Eigenschaften des Verwaltungsservice angegeben werden:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>Konfigurationsdetails für die {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>Die Konsole wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für die Konsole ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-ui.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpconsole</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis der Konsole als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.admin.endpoint</b>, wenn die Konsole mit dem Kontextstammverzeichnis <b>/mfpconsole</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>Die Eigenschaft mfp.admin.endpoint hat normalerweise den Wert <b>*://*:*/Kontextstammverzeichnis_des_Verwaltungsservice</b>.<br/>
                Weitere Informationen zu JNDI-Eigenschaften finden Sie unter <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI-Eigenschaften für die {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Sicherheitsrollen</h3>
                <p>Deklarieren Sie die folgenden Rollen im Element <b>application-bnd</b> der Anwendung:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Jeder Benutzer, der einer Sicherheitsrolle der Konsole zugeordnet ist, muss der gleichen Sicherheitsrolle des Verwaltungsservice zugeordnet sein.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>Konfigurationsdetails für die MobileFirst-Laufzeit</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>Die Laufzeit wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für die Laufzeit ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-server.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Das Standardkontextstammverzeichnis ist <b>/mfp</b>.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis der Laufzeit als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.analytics.url</b>, wenn die Laufzeit mit dem Kontextstammverzeichnis <b>/mobilefirst</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Sie müssen die Eigenschaft <b>mobilefirst/mfp.authorization.server</b> definieren. Beispiel:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Wenn {{ site.data.keys.mf_analytics }} installiert ist, müssen Sie die folgenden JNDI-Eigenschaften definieren:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Datenquelle für die Laufzeit muss <b>jndiName=Kontextstammverzeichnis/jdbc/mfpDS</b> definiert werden. Das folgende Beispiel zeigt einen Fall, bei dem die Laufzeit mit dem Kontextstammverzeichnis <b>/mobilefirst</b> installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>Konfigurationsdetails für den MobileFirst-Server-Push-Service</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>Der Push-Service wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für den Push-Service ist <b>MFP-Installationsverzeichnis/PushService/mfp-push-service.war</b>. Sie müssen <b>/imfpush</b> als Kontextstammverzeichnis festlegen. Andernfalls können die Clientgeräte keine Verbindung zu dem Service herstellen, denn das Kontextstammverzeichnis ist im SDK fest codiert.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis des Push-Service als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.push.analytics.user</b>, wenn der Push-Service mit dem Kontextstammverzeichnis <b>/imfpush</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Sie müssen die folgenden Eigenschaften definieren: <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b>: Der Wert muss <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> lauten.</li>
                    <li><b>mfp.push.db.type</b>: Der Wert für eine relationale Datenbank muss DB sein.</li>
                </ul>

                Wenn {{ site.data.keys.mf_analytics }} konfiguriert ist, definieren Sie die folgenden JNDI-Eigenschaften:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b>: Der Wert muss <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> lauten.</li>
                </ul>
                Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>Konfigurationsdetails für die MobileFirst-Server-Artefakte</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>Die Artefaktkomponente wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für diese Komponente ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-dev-artifacts.war</b>. Sie müssen <b>/mfp-dev-artifacts</b> als Kontextstammverzeichnis festlegen.</p>
            </div>
        </div>
    </div>
</div>

### Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund
{: #manual-installation-on-websphere-application-server-liberty-collective }
Vergewissern Sie sich, dass die unter [Voraussetzungen für WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites) dokumentierten Voraussetzungen erfüllt sind. 

* [Topologieeinschränkungen](#topology-constraints-collective)
* [Anwendungsservereinstellungen](#application-server-settings-collective)
* [Für MobileFirst-Server-Anwendungen erforderliche Liberty-Features](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [Globale JNDI-Einträge](#global-jndi-entries-collective)
* [Klassenladeprogramm](#class-loader-collective)
* [Benutzerfeature Kennwort-Decoder](#password-decoder-user-feature-collective)
* [Konfigurationsdetails](#configuration-details-collective)

#### Topologieeinschränkungen
{: #topology-constraints-collective }
Der MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die
{{ site.data.keys.mf_console }}
müssen in einem Liberty-Verbundcontroller installiert werden. Die {{ site.data.keys.product_adj }}-Laufzeit und der
MobileFirst-Server-Push-Service müssen in jedem Member des Liberty-Verbundclusters
installiert werden. 

Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert:
"**Kontextstammverzeichnis_des_Verwaltungsservice**config". Das Kontextstammverzeichnis des Push-Service muss **imfpush** sein. Weitere Informationen zu den Einschränkungen finden Sie unter
[Einschränkungen für die
MobileFirst-Server-Komponenten und für {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Anwendungsservereinstellungen
{: #application-server-settings-collective }
Sie müssen das Element
**webContainer** so konfigurieren, dass die Servlets sofort geladen werden. Diese Einstellung ist für die Initialisierung mit
JMX erforderlich. Beispiel: `<webContainer deferServletLoad="false"/>`.

Um Probleme durch Zeitlimitüberschreitungen zu vermeiden, die
in einigen Liberty-Versionen die Startsequenz für die Laufzeit und den Verwaltungsservice unterbrechen,
können Sie das Standardelement
**executor** ändern. Legen Sie für die Attribute
**coreThreads** und **maxThreads** große Werte fest.
Beispiel:

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Sie können auch das Element **tcpOptions** konfigurieren und das Attribut **soReuseAddr** auf `true` setzen: `<tcpOptions soReuseAddr="true"/>`

#### Für MobileFirst-Server-Anwendungen erforderliche Liberty-Features
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

Für
Java EE
6 oder Java EE 7 müssen Sie die folgenden Features hinzufügen. 

**MobileFirst-Server-Verwaltungsservice**

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**MobileFirst-Server-Push-Service**  

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **servlet-3.0** (servlet-3.1 für Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**{{ site.data.keys.product_adj }}-Laufzeit**  

* **jdbc-4.0** (jdbc-4.1 für Java EE 7)
* **servlet-3.0** (servlet-3.1 für Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Globale JNDI-Einträge
{: #global-jndi-entries-collective }
Die folgenden globalen JNDI-Einträge sind erforderlich, um die
JMX-Kommunikation zwischen der Laufzeit und dem Verwaltungsservice zu konfigurieren: 

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

Diese globalen JNDI-Einträge werden mit der folgenden Syntax definiert. Den Einträgen wird kein Kontextstammverzeichnis vorangestellt. Beispiel: `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Hinweis:** Verwenden Sie beim Definieren der JNDI-Werte die Syntax '"075"', um die Werte vor einer einer automatischen Konvertierung zu schützen, bei der 075 in 61 oder 31.500 in 31.5 konvertiert werden würde.



* Weitere Informationen zu den JNDI-Eigenschaften für den Verwaltungsservice finden Sie in der
[Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  
* Weitere Informationen zu den JNDI-Eigenschaften für die Laufzeit
finden Sie in der [Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

#### Klassenladeprogramm
{: #class-loader-collective }
Das Klassenladeprogramm für alle Anwendungen muss mit der Delegierung
"Übergeordnete zuletzt" (parentLast) arbeiten. Beispiel:

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader>
</application>
```

#### Benutzerfeature Kennwort-Decoder
{: #password-decoder-user-feature-collective }
Kopieren Sie den Kennwort-Decoder in Ihr Liberty-Profil. Beispiel:

* Auf UNIX- und Linux-Systemen:

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp Produktinstallationsverzeichnis/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp Produktinstallationsverzeichnis/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Auf Windows-Systemen:

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B Produktinstallationsverzeichnis\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B Produktinstallationsverzeichnis\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### Konfigurationsdetails
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>Konfigurationsdetails für den MobileFirst-Server-Verwaltungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>Der Verwaltungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Controller des Liberty-Verbunds implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Liberty-Verbundcontrollers ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Verwaltungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-service-collecitve.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpadmin</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis des Verwaltungsservice als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.admin.push.url</b>, wenn der Verwaltungsservice mit dem Kontextstammverzeichnis <b>/mfpadmin</b> installiert ist:</p>
{% highlight xml %}
<jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Wenn der Push-Service installiert ist, müssen Sie die folgenden JNDI-Eigenschaften konfigurieren:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Die JNDI-Eigenschaften für die Kommunikation mit dem Konfigurationsservice sind folgende:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice</a>.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Dateiquelle für den Verwaltungsservice muss <b>jndiName=Kontextstammverzeichnis/jdbc/mfpAdminDS</b> definiert werden. Das folgende Beispiel zeigt einen Fall, bei dem der Verwaltungsservice mit dem Kontextstammverzeichnis <b>/mfpadmin</b> installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Sicherheitsrollen</h3>
                <p>Deklarieren Sie die folgenden Rollen im Element <b>application-bnd</b> der Anwendung:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>Konfigurationsdetails für den MobileFirst-Server-Liveaktualisierungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>Der Liveaktualisierungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Controller des Liberty-Verbunds implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Liberty-Verbundcontrollers ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Liveaktualisierungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-live-update.war</b>. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert: "<b>Kontextstammverzeichnis_des_Verwaltungsservice</b>config". Wenn das Kontextstammverzeichnis des Verwaltungsservice beispielsweise <b>/mfpadmin</b> ist, muss der Liveaktualisierungsservice das Kontextstammverzeichnis <b>/mfpadminconfig</b> haben.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Datenquelle für den Liveaktualisierungsservice muss <b>/Kontextstammverzeichnis/jdbc/ConfigDS</b> definiert werden. Das folgende Beispiel zeigt einen Fall, bei dem der Liveaktualisierungsservice mit dem Kontextstammverzeichnis <b>/mfpadminconfig</b> installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Sicherheitsrollen</h3>
                <p>Deklarieren Sie im Element <b>application-bnd</b> der Anwendung die Rolle configadmin. Dieser Rolle muss mindestens ein Benutzer zugeordnet sein. Der Benutzer und sein Kennwort müssen in den folgenden JNDI-Eigenschaften des Verwaltungsservice angegeben werden:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>Konfigurationsdetails für die {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>Die Konsole wird als WAR-Anwendung bereitgestellt, die Sie im Controller des Liberty-Verbunds implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Liberty-Verbundcontrollers ausführen.
                <br/><br/>Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Konsole ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-ui.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpconsole</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis der Konsole als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.admin.endpoint</b>, wenn die Konsole mit dem Kontextstammverzeichnis <b>/mfpconsole</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>Die Eigenschaft mfp.admin.endpoint hat normalerweise den Wert <b>*://*:*/Kontextstammverzeichnis_des_Verwaltungsservice</b>.<br/>
                Weitere Informationen zu JNDI-Eigenschaften finden Sie unter <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI-Eigenschaften für die {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Sicherheitsrollen</h3>
                <p>Deklarieren Sie die folgenden Rollen im Element <b>application-bnd</b> der Anwendung:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Jeder Benutzer, der einer Sicherheitsrolle der Konsole zugeordnet ist, muss der gleichen Sicherheitsrolle des Verwaltungsservice zugeordnet sein.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>Konfigurationsdetails für die {{ site.data.keys.product_adj }}-Laufzeit</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>Die Laufzeit wird als WAR-Anwendung bereitgestellt, die Sie in den Cluster-Membern des Liberty-Verbunds implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> jedes Cluster-Members des Liberty-Verbunds ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Laufzeit ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-server.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Das Standardkontextstammverzeichnis ist <b>/mfp</b>.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis der Laufzeit als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.analytics.url</b>, wenn die Laufzeit mit dem Kontextstammverzeichnis <b>/mobilefirst</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Sie müssen die Eigenschaft <b>mobilefirst/mfp.authorization.server</b> definieren. Beispiel:</p>
{% highlight xml %}
<jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Wenn {{ site.data.keys.mf_analytics }} installiert ist, müssen Sie die folgenden JNDI-Eigenschaften definieren:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Datenquelle für die Laufzeit muss <b>jndiName=Kontextstammverzeichnis/jdbc/mfpDS</b> definiert werden. Das folgende Beispiel zeigt einen Fall, bei dem die Laufzeit mit dem Kontextstammverzeichnis <b>/mobilefirst</b> installiert ist und eine relationale Datenbank verwendet:</p>

{% highlight xml %}
<dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>Konfigurationsdetails für den MobileFirst-Server-Push-Service</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>Der Push-Service wird als WAR-Anwendung bereitgestellt, die Sie in einem Cluster-Member eines Liberty-Verbunds oder in einem Liberty-Server implementieren können. Wenn Sie den Push-Service in einem Liberty-Server installieren, lesen Sie die Informationen im Abschnitt <a href="#configuration-details-liberty">Konfigurationsdetails für den MobileFirst-Server-Push-Service</a> <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a>.
                <br/><br/>
                Wenn der MobileFirst-Server-Push-Service in einem Liberty-Verbund installiert wird, kann er in demselben Cluster wie die Laufzeit oder in einem anderen Cluster installiert werden.
                <br/><br/>
                Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> jedes Cluster-Members des Liberty-Verbunds ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty-collective">Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.    
                <br/><br/>
                Die WAR-Datei für den Push-Service ist <b>MFP-Installationsverzeichnis/PushService/mfp-push-service.war</b>. Sie müssen <b>/imfpush</b> als Kontextstammverzeichnis festlegen. Andernfalls können die Clientgeräte keine Verbindung zu dem Service herstellen, denn das Kontextstammverzeichnis ist im SDK fest codiert.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Wenn Sie die JNDI-Eigenschaften definieren, müssen die Namen mit dem Kontextstammverzeichnis des Push-Service als Präfix versehen werden. Das folgende Beispiel veranschaulicht die Deklaration von <b>mfp.push.analytics.user</b>, wenn der Push-Service mit dem Kontextstammverzeichnis <b>/imfpush</b> installiert ist:</p>

{% highlight xml %}
<jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Sie müssen die folgenden Eigenschaften definieren: <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b>: Der Wert muss <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> lauten.</li>
                    <li><b>mfp.push.db.type</b>: Der Wert für eine relationale Datenbank muss DB sein.</li>
                </ul>

                Wenn {{ site.data.keys.mf_analytics }} konfiguriert ist, definieren Sie die folgenden JNDI-Eigenschaften:
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b>: Der Wert muss <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> lauten.</li>
                </ul>
                Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>Konfigurationsdetails für die MobileFirst-Server-Artefakte</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>Die Artefaktkomponente wird als WAR-Anwendung bereitgestellt, die Sie im Controller des Liberty-Verbunds implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Liberty-Verbundcontrollers ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-liberty">Manuelle Installation in WebSphere Application Server Liberty</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für diese Komponente ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-dev-artifacts.war</b>. Sie müssen <b>/mfp-dev-artifacts</b> als Kontextstammverzeichnis festlegen.</p>
            </div>
        </div>
    </div>
</div>

### Manuelle Installation in Apache Tomcat
{: #manual-installation-on-apache-tomcat }
Vergewissern Sie sich, dass die unter [Voraussetzungen für Apache Tomcat](#apache-tomcat-prerequisites) dokumentierten Voraussetzungen erfüllt sind. 

* [Topologieeinschränkungen](#topology-constraints-tomcat)
* [Anwendungsservereinstellungen](#application-server-settings-tomcat)
* [Konfigurationsdetails](#configuration-details-tomcat)

#### Topologieeinschränkungen
{: #topology-constraints-tomcat }
Der MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die MobileFirst-Laufzeit müssen in einem Anwendungsserver installiert werden. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert:
"**Kontextstammverzeichnis_des_Verwaltungsservice**config". Das Kontextstammverzeichnis des Push-Service muss **imfpush** sein. Weitere Informationen zu den Einschränkungen finden Sie unter
[Einschränkungen für die
MobileFirst-Server-Komponenten und für {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Anwendungsservereinstellungen
{: #application-server-settings-tomcat }
Sie müssen das  **Valve-Element für Single Sign-On ** aktivieren. Beispiel:

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

Bei Bedarf können Sie das Speicherrealm aktivieren, wenn die Benutzer in
**tomcat-users.xml** definiert sind. Beispiel:

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
      ```
#### Konfigurationsdetails
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>Konfigurationsdetails für den MobileFirst-Server-Verwaltungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>Der Verwaltungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Verwaltungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-service.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpadmin</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Die JNDI-Eigenschaften werden im Element <code>Environment</code> des Anwendungskontexts definiert. Beispiel: </p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>Wenn Sie die JMX-Kommunikation mit der Laufzeit ermöglichen wollen, definieren Sie die folgenden JNDI-Eigenschaften:</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Wenn der Push-Service installiert ist, müssen Sie die folgenden JNDI-Eigenschaften konfigurieren:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Die JNDI-Eigenschaften für die Kommunikation mit dem Konfigurationsservice sind folgende:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice</a>.</p>

                <h3>Datenquelle</h3>
                <p>Die Datenquelle (jdbc/mfpAdminDS) wird im Element **Context** als Ressource deklariert. Beispiel: </p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>Sicherheitsrollen</h3>
                <p>Die für den Verwaltungsservice verfügbaren Sicherheitsrollen sind:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>Konfigurationsdetails für den MobileFirst-Server-Liveaktualisierungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>Der Liveaktualisierungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Liveaktualisierungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-live-update.war</b>. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert: "<b>Kontextstammverzeichnis_des_Verwaltungsservice</b>config". Wenn das Kontextstammverzeichnis des Verwaltungsservice beispielsweise <b>/mfpadmin</b> ist, muss der Liveaktualisierungsservice das Kontextstammverzeichnis <b>/mfpadminconfig</b> haben.</p>

                <h3>Datenquelle</h3>
                <p>Als JNDI-Name der Datenquelle für den Liveaktualisierungsservice muss <code>/jdbc/ConfigDS</code> definiert werden. Deklarieren Sie die Datenquelle im Element <code>Context</code> als Ressource. </p>

                <h3>Sicherheitsrollen</h3>
                <p>Für den LIveaktualisierungsservice ist die Sicherheitsrolle <b>configadmin</b> verfügbar.
                <br/><br/>
                Dieser Rolle muss mindestens ein Benutzer zugeordnet sein. Der Benutzer und sein Kennwort müssen in den folgenden JNDI-Eigenschaften des Verwaltungsservice angegeben werden:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>Konfigurationsdetails für die {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>Die Konsole wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen.
                <br/><br/>Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Konsole ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-ui.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpconsole</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie müssen die Eigenschaft <b>mfp.admin.endpoint</b> definieren. Diese Eigenschaft hat normalerweise den Wert <b>*://*:*/Kontextstammverzeichnis_des_Verwaltungsservice</b>.
                <br/><br/>
                Weitere Informationen zu JNDI-Eigenschaften finden Sie unter <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI-Eigenschaften für die {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Sicherheitsrollen</h3>
                <p>Die für diese Anwendung verfügbaren Sicherheitsrollen sind:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>Konfigurationsdetails für die {{ site.data.keys.product_adj }}-Laufzeit</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>Die Laufzeit wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Laufzeit ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-server.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Das Standardkontextstammverzeichnis ist <b>/mfp</b>.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie müssen die Eigenschaft <b>mfp.authorization.server</b> definieren. Beispiel: </p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>Wenn Sie die JMX-Kommunikation mit dem Verwaltungsservice ermöglichen wollen, definieren Sie die folgenden JNDI-Eigenschaften: </p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Wenn {{ site.data.keys.mf_analytics }} installiert ist, müssen Sie die folgenden JNDI-Eigenschaften definieren:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</p>

                <h3>Datenquelle</h3>
                <p>Der JNDI-Name der Datenquelle für die Laufzeit muss wie folgt definiert werden: <b>/jdbc/mfpDS</b>. Deklarieren Sie die Datenquelle im Element <b>Context</b> als Ressource.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>Konfigurationsdetails für den MobileFirst-Server-Push-Service</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>Der Push-Service wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte ausführen. Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.    
                <br/><br/>
                Die WAR-Datei für den Push-Service ist <b>MFP-Installationsverzeichnis/PushService/mfp-push-service.war</b>. Sie müssen <b>/imfpush</b> als Kontextstammverzeichnis festlegen. Andernfalls können die Clientgeräte keine Verbindung zu dem Service herstellen, denn das Kontextstammverzeichnis ist im SDK fest codiert.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie müssen die folgenden Eigenschaften definieren: </p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b>: Der Wert muss <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> lauten.</li>
                    <li><b>mfp.push.db.type</b>: Der Wert für eine relationale Datenbank muss DB sein.</li>
                </ul>

                <p>Wenn {{ site.data.keys.mf_analytics }} konfiguriert ist, definieren Sie die folgenden JNDI-Eigenschaften:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b>: Der Wert muss <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> lauten.</li>
                </ul>
                Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>Konfigurationsdetails für die MobileFirst-Server-Artefakte</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>Die Artefaktkomponente wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen. Informieren Sie sich unter <a href="#manual-installation-on-apache-tomcat">Manuelle Installation in Apache Tomcat</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für diese Komponente ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-dev-artifacts.war</b>. Sie müssen <b>/mfp-dev-artifacts</b> als Kontextstammverzeichnis festlegen.</p>
            </div>
        </div>
    </div>
</div>

### Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
Vergewissern Sie sich, dass die unter <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">Voraussetzungen für WebSphere Application Server und WebSphere Application Server Network Deployment</a> dokumentierten Voraussetzungen erfüllt sind. 

* [Topologieeinschränkungen](#topology-constraints-nd)
* [Anwendungsservereinstellungen](#application-server-settings-nd)
* [Klassenladeprogramm](#class-loader-nd)
* [Konfigurationsdetails](#configuration-details-nd)

#### Topologieeinschränkungen
{: #topology-constraints-nd }
<b>Eigenständiger WebSphere Application Server</b>  
Der MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie die MobileFirst-Laufzeit müssen in einem Anwendungsserver installiert werden. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert: "<b>Kontextstammverzeichnis_des_Verwaltungsservice</b>config". Das Kontextstammverzeichnis des Push-Service muss <b>imfpush</b> sein. Weitere Informationen zu den Einschränkungen finden Sie unter
[Einschränkungen für die
MobileFirst-Server-Komponenten und für {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

<b>WebSphere Application Server Network Deployment</b>  
Der Deployment Manager muss aktiv sein, wenn {{ site.data.keys.mf_server }} ausgeführt
wird. Der Deployment Manager wird für die JMX-Kommunikation zwischen der Laufzeit und dem Verwaltungsservice verwendet. Der Verwaltungsservice und der Liveaktualisierungsservice
müssen in demselben Anwendungsserver installiert sein. Die Laufzeit kann in einem anderen Server als der Verwaltungsservice
installiert werden. Dieser andere Server muss sich jedoch in derselben Zelle befinden. 

#### Anwendungsservereinstellungen
{: #application-server-settings-nd }
Die Verwaltungssicherheit und die Anwendungssicherheit müssen aktiviert sein. Sie können die Anwendungssicherheit
in der Administrationskonsole von WebSphere Application Server aktivieren: 

1. Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. 
2. Klicken Sie auf **Sicherheit → Globale Sicherheit**. Stellen Sie sicher, dass die Option Verwaltungssicherheit aktivieren ausgewählt ist.
3. Stellen Sie sicher, dass die Option **Anwendungssicherheit aktivieren** ausgewählt ist. Die Anwendungssicherheit kann nur aktiviert werden, wenn die Verwaltungssicherheit aktiviert ist.

4. Klicken Sie auf **OK**. 
5. Speichern Sie die Änderungen.

Weitere Informationen finden Sie in der Dokumentation zu WebSphere Application Server unter [Sicherheit aktivieren](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc) . 

Die Klassenladerrichtlinie des Servers
muss die Delegierung "übergeordneter zuletzt" unterstützen. Die WAR-Dateien von
{{ site.data.keys.mf_server }} müssen im Klassenladermodus
"übergeordneter zuletzt" installiert werden. Überprüfen Sie wie folgt die Klassenladerrichtlinie: 

1. Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. 
2. Klicken Sie auf **Server → Servertypen → WebSphere-Anwendungsserver** und wählen Sie den für die {{ site.data.keys.product }} verwendeten Server aus. 
3. Wenn die Klassenladerrichtlinie auf **Mehrere** gesetzt ist, müssen Sie nichts tun. 
4. Wenn die Klassenladerrichtlinie auf **Einer** und der Modus für das Laden von Klassen auf
**Mit dem lokalen Klassenlader geladene Klassen zuerst (übergeordneter zuletzt)** gesetzt ist, müssen Sie nichts tun. 
5. Wenn die Klassenladerrichtlinie auf **Einer** und der Modus für das Laden von Klassen auf
**Mit dem übergeordneten Klassenlader geladene Klassen zuerst** gesetzt ist, ändern Sie die Klassenladerrichtlinie in **Mehrere**. Setzen Sie außerdem die
Reihenfolge der Klassenlader aller Anwendungen mit Ausnahme der MobileFirst-Server-Anwendungen auf
**Mit dem übergeordneten Klassenlader geladene Klassen zuerst**. 

#### Klassenladeprogramm
{: #class-loader-nd }
Das Klassenladeprogramm für alle MobileFirst-Server-Anwendungen muss mit der Delegierung
"Übergeordnete zuletzt" (parentLast) arbeiten. 

Wenn Sie die Delegierung des Klassenladeprogramms nach der Installation einer Anwendung auf "übergeordneter zuletzt" setzen wollen, gehen
Sie wie folgt vor: 

1. Klicken Sie auf den Link **Anwendungen verwalten** oder klicken Sie auf **Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen**.
2. Klicken Sie auf die **MobileFirst-Server-Anwendung**. Der Name der Anwendung ist standardmäßig der Name der WAR-Datei. 
3. Klicken Sie im Abschnitt **Detaileigenschaften** auf den Link
**Laden von Klassen und Erkennung von Dateiaktualisierungen**. 
4. Wählen Sie im Fenster
**Reihenfolge der Klassenlader** die Option **Mit dem lokalen Klassenlader geladene Klassen
zuerst (übergeordneter zuletzt)** aus. 
5. Klicken Sie auf **OK**. 
6. Klicken Sie im Abschnitt **Module** auf
den Link **Module verwalten**.
7. Klicken Sie auf das Modul.

8. Wählen Sie für das Feld
**Reihenfolge der Klassenlader** die Option **Mit dem lokalen Klassenlader geladene Klassen
zuerst (übergeordneter zuletzt)** aus. 
9. Klicken Sie zweimal auf **OK**, um die Auswahl zu bestätigen und zum Fenster
**Konfiguration** für die Anwendung zurückzugelangen. 
10. Klicken Sie auf
**Speichern**, um die Änderungen dauerhaft zu speichern. 

#### Konfigurationsdetails
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>Konfigurationsdetails für den MobileFirst-Server-Verwaltungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>Der Verwaltungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Verwaltungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-service.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpadmin</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie können JNDI-Eigenschaften in der Administrationskonsole von WebSphere Application Server-Administration festlegen. Navigieren Sie zu <b>Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen → Anwendungsname → Umgebungseinträge für Webmodule</b> und legen Sie die Einträge fest.</p>

                <p>Wenn Sie die JMX-Kommunikation mit der Laufzeit ermöglichen wollen, definieren Sie die folgenden JNDI-Eigenschaften:</p>

                <b>WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b>: SOAP-Port des Deployment Manager</li>
                    <li><b>mfp.topology.platform</b>: Legen Sie den Wert <b>WAS</b> fest.</li>
                    <li><b>mfp.topology.clustermode</b>: Legen Sie den Wert <b>Cluster</b> fest.</li>
                    <li><b>mfp.admin.jmx.connector</b>: Legen Sie den Wert <b>SOAP</b> fest.</li>
                </ul>

                <b>Eigenständiger WebSphere Application Server</b>
                <ul>
                    <li><b>mfp.topology.platform</b>: Legen Sie den Wert <b>WAS</b> fest.</li>
                    <li><b>mfp.topology.clustermode</b>: Legen Sie den Wert <b>Standalone</b> fest.</li>
                    <li><b>mfp.admin.jmx.connector</b>: Legen Sie den Wert <b>SOAP</b> fest.</li>
                </ul>

                <p>Wenn der Push-Service installiert ist, müssen Sie die folgenden JNDI-Eigenschaften konfigurieren:</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Die JNDI-Eigenschaften für die Kommunikation mit dem Konfigurationsservice sind folgende:</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice</a>.</p>

                <h3>Datenquelle</h3>
                <p>Erstellen Sie eine Datenquelle für den Verwaltungsservice und ordnen Sie sie <b>jdbc/mfpAdminDS</b> zu.</p>

                <h3>Startreihenfolge</h3>
                <p>Der Verwaltungsservice muss vor der Laufzeit gestartet werden. Sie können die Reihenfolge im Abschnitt <b>Startverhalten</b> festlegen. Setzen Sie die Position in der Startreihenfolge für den Verwaltungsservice beispielsweise auf <b>1</b> und für die Laufzeit auf <b>2</b>.</p>

                <h3>Sicherheitsrollen</h3>
                <p>Die für den Verwaltungsservice verfügbaren Sicherheitsrollen sind:</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>Konfigurationsdetails für den MobileFirst-Server-Liveaktualisierungsservice</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>Der Liveaktualisierungsservice wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für den Liveaktualisierungsservice ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-live-update.war</b>. Das Kontextstammverzeichnis des Liveaktualisierungsservice wird wie folgt definiert: "<b>Kontextstammverzeichnis_des_Verwaltungsservice</b>config". Wenn das Kontextstammverzeichnis des Verwaltungsservice beispielsweise <b>/mfpadmin</b> ist, muss der Liveaktualisierungsservice das Kontextstammverzeichnis <b>/mfpadminconfig</b> haben.</p>

                <h3>Datenquelle</h3>
                <p>Erstellen Sie eine Datenquelle für den Liveaktualisierungsservice und ordnen Sie sie <b>jdbc/ConfigDS</b> zu. </p>

                <h3>Sicherheitsrollen</h3>
                <p>Für diese Anwendung ist die Rolle <b>configadmin</b> definiert. <br/><br/>
                Dieser Rolle muss mindestens ein Benutzer zugeordnet sein. Der Benutzer und sein Kennwort müssen in den folgenden JNDI-Eigenschaften des Verwaltungsservice angegeben werden:</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>Konfigurationsdetails für die {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>Die Konsole wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen.
                <br/><br/>Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Konsole ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-admin-ui.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Normalerweise wird der Name <b>/mfpconsole</b> verwendet.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie können JNDI-Eigenschaften in der Administrationskonsole von WebSphere Application Server-Administration festlegen. Navigieren Sie zu <b>Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen → Anwendungsname → Umgebungseinträge für Webmodule</b> und legen Sie die Einträge fest.
                <br/><br/>
                Sie müssen die Eigenschaft <b>mfp.admin.endpoint</b> definieren. Diese Eigenschaft hat normalerweise den Wert <b>*://*:*/Kontextstammverzeichnis_des_Verwaltungsservice</b>.
                <br/><br/>
                Weitere Informationen zu JNDI-Eigenschaften finden Sie unter <a href="../server-configuration/#jndi-properties-for-mobilefirst-operations-console">JNDI-Eigenschaften für die {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Sicherheitsrollen</h3>
                <p>Die für diese Anwendung verfügbaren Sicherheitsrollen sind:</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Jeder Benutzer, der einer Sicherheitsrolle der Konsole zugeordnet ist, muss der gleichen Sicherheitsrolle des Verwaltungsservice zugeordnet sein.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>Konfigurationsdetails für die MobileFirst-Laufzeit</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>Die Laufzeit wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> ausführen.
                <br/><br/>
                Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.
                <br/><br/>
                Die WAR-Datei für die Laufzeit ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-server.war</b>. Das Kontextstammverzeichnis können Sie ganz nach Wunsch festlegen. Das Standardkontextstammverzeichnis ist <b>/mfp</b>.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie können JNDI-Eigenschaften in der Administrationskonsole von WebSphere Application Server-Administration festlegen. Navigieren Sie zu <b>Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen → Anwendungsname → Umgebungseinträge für Webmodule</b> und legen Sie die Einträge fest.</p>

                <p>Sie müssen die Eigenschaft <b>mfp.authorization.server</b> mit dem Wert "embedded" definieren.<br/>
                Wenn Sie die JMX-Kommunikation mit dem Verwaltungsservice ermöglichen wollen, definieren Sie außerdem die folgenden JNDI-Eigenschaften: </p>

                <b>WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b>: Hostname des Deployment Manager</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b>: SOAP-Port des Deployment Manager</li>
                    <li><b>mfp.topology.platform</b>: Legen Sie den Wert <b>WAS</b> fest.</li>
                    <li><b>mfp.topology.clustermode</b>: Legen Sie den Wert <b>Cluster</b> fest.</li>
                    <li><b>mfp.admin.jmx.connector</b>: Legen Sie den Wert <b>SOAP</b> fest.</li>
                </ul>

                <b>Eigenständiger WebSphere Application Server</b>
                <ul>
                    <li><b>mfp.topology.platform</b>: Legen Sie den Wert <b>WAS</b> fest.</li>
                    <li><b>mfp.topology.clustermode</b>: Legen Sie den Wert <b>Standalone</b> fest.</li>
                    <li><b>mfp.admin.jmx.connector</b>: Legen Sie den Wert <b>SOAP</b> fest.</li>
                </ul>

                <p>Wenn {{ site.data.keys.mf_analytics }} installiert ist, müssen Sie die folgenden JNDI-Eigenschaften definieren:</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</p>

                <h3>Startreihenfolge</h3>
                <p>Die Laufzeit muss nach dem Verwaltungsservice gestartet werden. Sie können die Reihenfolge im Abschnitt <b>Startverhalten</b> festlegen. Setzen Sie die Position in der Startreihenfolge für den Verwaltungsservice beispielsweise auf <b>1</b> und für die Laufzeit auf <b>2</b>.</p>

                <h3>Datenquelle</h3>
                <p>Erstellen Sie eine Datenquelle für die Laufzeit und ordnen Sie sie <b>jdbc/mfpDS</b> zu.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>Konfigurationsdetails für den MobileFirst-Server-Push-Service</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>Der Push-Service wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.    
                <br/><br/>
                Die WAR-Datei für den Push-Service ist <b>MFP-Installationsverzeichnis/PushService/mfp-push-service.war</b>. Sie müssen <b>/imfpush</b> als Kontextstammverzeichnis festlegen. Andernfalls können die Clientgeräte keine Verbindung zu dem Service herstellen, denn das Kontextstammverzeichnis ist im SDK fest codiert.</p>

                <h3>Obligatorische JNDI-Eigenschaften</h3>
                <p>Sie können JNDI-Eigenschaften in der Administrationskonsole von WebSphere Application Server-Administration festlegen. Navigieren Sie zu <b>Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen → Anwendungsname → Umgebungseinträge für Webmodule</b> und legen Sie die Einträge fest.</p>

                <p>Sie müssen die folgenden Eigenschaften definieren: </p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b>: Der Wert muss <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b> lauten.</li>
                    <li><b>mfp.push.db.type</b>: Der Wert für eine relationale Datenbank muss DB sein.</li>
                </ul>

                <p>Wenn {{ site.data.keys.mf_analytics }} konfiguriert ist, definieren Sie die folgenden JNDI-Eigenschaften:</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b>: Der Wert muss <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b> lauten.</li>
                </ul>
                <p>Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der <a href="../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service</a>.</p>

                <h3>Datenquelle</h3>
                <p>Erstellen Sie die Datenquelle für den Push-Service und ordnen Sie sie <b>jdbc/imfPushDS</b> zu.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>Konfigurationsdetails für die MobileFirst-Server-Artefakte</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>Die Artefaktkomponente wird als WAR-Anwendung bereitgestellt, die Sie im Anwendungsserver implementieren können. Sie müssen für diese Anwendung einige Konfigurationsschritte in der Datei <b>server.xml</b> des Anwendungsservers ausführen. Informieren Sie sich unter <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Manuelle Installation in WebSphere Application Server und WebSphere Application Server Network Deployment</a> über die allgemeinen Konfigurationsdetails für alle Services, bevor Sie mit den hier beschriebenen Schritten fortfahren.</p>

                <p>Die WAR-Datei für diese Komponente ist <b>MFP-Installationsverzeichnis/MobileFirstServer/mfp-dev-artifacts.war</b>. Sie müssen <b>/mfp-dev-artifacts</b> als Kontextstammverzeichnis festlegen.</p>
            </div>
        </div>
    </div>
</div>

## Server-Farm installieren
{: #installing-a-server-farm }
Sie können Ihre Server-Farm mit Ant-Tasks, mit dem Server Configuration Tool oder manuell installieren.

* [Konfiguration einer Server-Farm planen](#planning-the-configuration-of-a-server-farm)
* [Server-Farm mit dem Server Configuration Tool installieren](#installing-a-server-farm-with-the-server-configuration-tool)
* [Server-Farm mit Ant-Tasks installieren](#installing-a-server-farm-with-ant-tasks)
* [Server-Farm manuell konfigurieren](#configuring-a-server-farm-manually)
* [Farmkonfiguration prüfen](#verifying-a-farm-configuration)
* [Lebenszyklus eines Server-Farmknotens](#lifecycle-of-a-server-farm-node)

### Konfiguration einer Server-Farm planen
{: #planning-the-configuration-of-a-server-farm }
Zum Planen der Konfiguration
einer Server-Farm müssen Sie den Anwendungsserver wählen,
die {{ site.data.keys.product_adj }}-Datenbanken konfigurieren
und die WAR-Dateien der MobileFirst-Server-Komponenten auf jedem Server der Farm implementieren. Sie können entscheiden, ob Sie
das Server Configuration Tool, Ant-Tasks oder manuelle
Operationen ausführen wollen, um die Server-Farm zu konfigurieren.

Wenn Sie die Installation einer Server-Farm planen, lesen Sie zuerst die Informationen unter
[Einschränkungen für den
MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie für die MobileFirst-Laufzeit](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime) und insbesondere im Abschnitt
[Server-Farmtopologie](../topologies/#server-farm-topology).

In der {{ site.data.keys.product }} setzt sich eine Server-Farm aus mehreren eigenständigen Anwendungsservern zusammen, die weder eingebunden sind, noch von einer verwaltenden Komponente eines Anwendungsservers verwaltet werden. {{ site.data.keys.mf_server }} stellt
intern ein Farm-Plug-in als Mittel für die Erweiterung eines Anwendungsservers bereit, sodass dieser als Member in eine Server-Farm aufgenommen werden kann.

#### Deklaration einer Server-Farm
{: #when-to-declare-a-server-farm }
**Deklarieren Sie in den folgenden Fällen eine Server-Farm:**

* {{ site.data.keys.mf_server }} wird in mehreren
Tomcat-Anwendungsservern installiert.
* {{ site.data.keys.mf_server }} wird auf mehreren Servern mit WebSphere Application Server, jedoch nicht in WebSphere Application Server Network Deployment installiert.
* {{ site.data.keys.mf_server }} wird auf mehreren Servern mit WebSphere Application Server Liberty installiert. 

**Deklarieren Sie in den folgenden Fällen keine Server-Farm:**

* Ihr Anwendungsserver ist eigenständig.
* Es werden mehrere Anwendungsserver mithilfe von WebSphere Application Server Network Deployment eingebunden.

#### Warum muss eine Farm deklariert werden?
{: #why-it-is-mandatory-to-declare-a-farm }
Jedes Mal, wenn in der
{{ site.data.keys.mf_console }} oder mithilfe der
MobileFirst-Server-Verwaltungsservices eine Verwaltungsoperation ausgeführt wird,
muss diese Operation in allen Instanzen einer Laufzeit repliziert werden. Ein Beispiel für eine solche Verwaltungsoperation ist das Hochladen einer neuen Version einer App oder
eines Adapters. Die Replikation erfolgt über
JMX-Aufrufe, die von der Instanz der Verwaltungsservices, die die
Operation verarbeitet, ausgeführt werden. Der Verwaltungsservice muss Kontakt zu allen Laufzeitinstanzen im Cluster aufnehmen. In den Umgebungen, die oben unter **Deklaration einer Server-Farm**
aufgelistet sind, kann
nur mit JMX Kontakt zur Laufzeit aufgenommen werden, wenn eine Farm konfiguriert ist.
Wenn ohne ordnungsgemäße Konfiguration der Farm ein Server zu einem Cluster hinzugefügt wird,
befindet sich die Laufzeit dieses Servers nach jeder Verwaltungsoperation in einem inkonsistenten Zustand, bis der Server neu gestartet wird.

### Server-Farm mit dem Server Configuration Tool installieren
{: #installing-a-server-farm-with-the-server-configuration-tool }
Mit dem Server Configuration Tool
können Sie jeden Server in der Farm gemäß den Anforderungen eines einzelnen Anwendungsservers konfigurieren, der für
jedes Member der Server-Farm verwendet wird. 

Wenn Sie mit dem
Server Configuration Tool eine Server-Farm installieren möchten,
erstellen Sie zunächst eigenständige Server und konfigurieren Sie die Truststores dieser Server
für eine sichere gegenseitige Kommunikation. Mit dem Tool führen Sie dann die folgenden Operationen aus: 

* Gemeinsame Datenbankinstanz für die MofileFirst-Server-Komponenten konfigurieren
* MobileFirst-Server-Komponenten auf den einzelnen Servern implementieren
* Konfiguration des Servers so modifizieren, dass der Server ein Member der Server-Farm wird

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Für Anweisungen zur Installation einer Server-Farm mit dem Server Configuration Tool hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} setzt die Konfiguration einer sicheren JMX-Verbindung voraus.</p>

                <ol>
                    <li>Bereiten Sie die Anwendungsserver vor, die als Server-Farmmember konfiguriert werden sollen.
                        <ul>
                            <li>Wählen Sie zum Konfigurieren der Member der Server-Farm den Anwendungsservertyp aus. Die {{ site.data.keys.product }} unterstützt in Server-Farmen die folgenden Anwendungsserver:
                                <ul>
                                    <li>WebSphere Application Server Full Profile<br/>
                                    <b>Hinweis:</b> In einer Farmtopologie können Sie den RMI-JMX-Connector nicht verwenden. In dieser Topologie unterstützt die {{ site.data.keys.product }} nur den SOAP-Connector.</li>
                                    <li>WebSphere Application Server Liberty Profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Informationen zu den unterstützten Versionen der Anwendungsserver finden Sie in den <a href="../../../product-overview/requirements">Systemvoraussetzungen</a>.

                                <blockquote><b>Wichtiger Hinweis:</b> Die {{ site.data.keys.product }} unterstützt nur homogene Server-Farmen. Eine Server-Farm wird als homogen eingestuft, wenn sie Anwendungsserver desselben Typs miteinander verbindet. Der Versuch, unterschiedliche Typen von Anwendungsservern zuzuordnen, könnte zur Laufzeit zu einem unvorhersehbaren Verhalten führen. Eine Farm von Tomcat-Servern und Servern mit WebSphere Application Server Full Profile ist beispielsweise eine ungültige Konfiguration.</blockquote>
                            </li>
                            <li>Richten Sie so viele eigenständige Server ein, wie Sie Member in der Farm benötigen. <ul>
                                    <li>Jeder dieser eigenständigen Server muss mit derselben Datenbank kommunizieren. Sie müssen sicherstellen, dass jeder von diesen Servern verwendete Port nicht von einem anderen Server, der auf demselben Host konfiguriert ist, verwendet wird. Diese Beschränkung gilt für die Ports, die von den Protokollen HTTP, HTTPS, REST, SOAP und RMI verwendet werden.</li>
                                    <li>In jedem dieser Server müssen der MobileFirst-Server-Verwaltungsservice, der MobileFirst-Server-Liveaktualisierungsservice und mindestens eine {{ site.data.keys.product_adj }}-Laufzeit implementiert sein.</li>
                                    <li>Witere Informationen zum Einrichten eines Servers finden Sie unter <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Einschränkungen für den MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</li>
                                </ul>
                            </li>
                            <li>Tauschen Sie die Unterzeichnerzertifikate aus, die sich im Truststore der einzelnen Server befinden.
                            <br/><br/>
                            Dieser Schritt ist für Farmen obligatorisch, die WebSphere Application Server Full Profile oder Liberty verwenden, da die Sicherheit aktiviert sein muss. Bei Liberty-Farmen muss außerdem die LTPA-Konfiguration auf jedem Server repliziert werden, damit das Single Sign-on funktioniert. Folgen Sie für diese Konfugration der Anleitung in Schritt 6 unter <a href="#configuring-a-server-farm-manually">Server-Farm manuell konfigurieren</a>.</li>
                        </ul>
                    </li>
                    <li>Führen Sie das Server Configuration Tool für jeden Server der Farm aus. Alle Server müssen dieselben Datenbanken verwenden. In der Anzeige <b>Application Server Settings</b> müssen Sie den Implementierungstyp <b>Server Farm Deployment</b> auswählen. Weitere Informationen zum Tool finden Sie unter <a href="#running-the-server-configuration-tool">Server Configuration Tool ausführen</a>.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Server-Farm mit Ant-Tasks installieren
{: #installing-a-server-farm-with-ant-tasks }
Mit Ant-Tasks
können Sie jeden Server in der Farm gemäß den Anforderungen eines einzelnen Anwendungsservers konfigurieren, der für
jedes Member der Server-Farm verwendet wird. 

Wenn Sie mit Ant-Tasks
eine Server-Farm installieren möchten,
erstellen Sie zunächst eigenständige Server und konfigurieren Sie die Truststores dieser Server
für eine sichere gegenseitige Kommunikation. Führen Sie dann Ant-Tasks aus, um die gemeinsame Datenbankinstanz für die
MofileFirst-Server-Komponenten zu konfigurieren. Abschließend müssen Sie Ant-Tasks ausführen, um
die MobileFirst-Server-Komponenten auf jedem Server zu implementieren und die Konfiguration der einzelnen Server so zu modifizieren, dass
sie Member der Server-Farm werden. 

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Für Anweisungen zur Installation einer Server-Farm mit Ant-Tasks hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} setzt die Konfiguration einer sicheren JMX-Verbindung voraus.</p>

                <ol>
                    <li>Bereiten Sie die Anwendungsserver vor, die als Server-Farmmember konfiguriert werden sollen.
                        <ul>
                            <li>Wählen Sie zum Konfigurieren der Member der Server-Farm den Anwendungsservertyp aus. Die {{ site.data.keys.product }} unterstützt in Server-Farmen die folgenden Anwendungsserver:
                                <ul>
                                    <li>WebSphere  Application Server Full Profile. <b>Hinweis:</b> In einer Farmtopologie können Sie den RMI-JMX-Connector nicht verwenden. In dieser Topologie unterstützt die {{ site.data.keys.product }} nur den SOAP-Connector.</li>
                                    <li>WebSphere Application Server Liberty Profile</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Informationen zu den unterstützten Versionen der Anwendungsserver finden Sie in den <a href="../../../product-overview/requirements">Systemvoraussetzungen</a>.

                                <blockquote><b>Wichtiger Hinweis:</b> Die {{ site.data.keys.product }} unterstützt nur homogene Server-Farmen. Eine Server-Farm wird als homogen eingestuft, wenn sie Anwendungsserver desselben Typs miteinander verbindet. Der Versuch, unterschiedliche Typen von Anwendungsservern zuzuordnen, könnte zur Laufzeit zu einem unvorhersehbaren Verhalten führen. Eine Farm von Tomcat-Servern und Servern mit WebSphere Application Server Full Profile ist beispielsweise eine ungültige Konfiguration.</blockquote>
                            </li>
                            <li>Richten Sie so viele eigenständige Server ein, wie Sie Member in der Farm benötigen.
                            <br/><br/>
                            Jeder dieser eigenständigen Server muss mit derselben Datenbank kommunizieren. Sie müssen sicherstellen, dass jeder von diesen Servern verwendete Port nicht von einem anderen Server, der auf demselben Host konfiguriert ist, verwendet wird. Diese Beschränkung gilt für die Ports, die von den Protokollen HTTP, HTTPS, REST, SOAP und RMI verwendet werden.
                            <br/><br/>
                            In jedem dieser Server müssen der MobileFirst-Server-Verwaltungsservice, der MobileFirst-Server-Liveaktualisierungsservice und mindestens eine {{ site.data.keys.product_adj }}-Laufzeit implementiert sein.
                            <br/><br/>
                            Weitere Informationen zum Einrichten eines Servers finden Sie unter <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Einschränkungen für den MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie für die {{ site.data.keys.product_adj }}-Laufzeit</a>.</li>
                            <li>Tauschen Sie die Unterzeichnerzertifikate aus, die sich im Truststore der einzelnen Server befinden.
                            <br/><br/>
                            Dieser Schritt ist für Farmen obligatorisch, die WebSphere Application Server Full Profile oder Liberty verwenden, da die Sicherheit aktiviert sein muss. Bei Liberty-Farmen muss außerdem die LTPA-Konfiguration auf jedem Server repliziert werden, damit das Single Sign-on funktioniert. Folgen Sie für diese Konfugration der Anleitung in Schritt 6 unter <a href="#configuring-a-server-farm-manually">Server-Farm manuell konfigurieren</a>.</li>
                        </ul>
                    </li>
                    <li>Konfigurieren Sie die Datenbank für den Verwaltungs- und Liveaktualisierungsservice und für die Laufzeit.
                        <ul>
                            <li>Entscheiden Sie, welche Datenbank verwendet werden soll, und wählen Sie die Ant-Task zum Erstellen und Konfigurieren der Datenbank im Verzeichnis <b>MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples</b> aus.
                                <ul>
                                    <li>Verwenden Sie für DB2 <b>create-database-db2.xml</b>.</li>
                                    <li>Verwenden Sie für MySQL <b>create-database-mysql.xml</b>.</li>
                                    <li>Verwenden Sie für Oracle <b>create-database-oracle.xml</b>.</li>
                                </ul>
                                <blockquote>Hinweis: Verwenden Sie nicht die Derby-Datenbank in einer Farmtopologie, weil die Derby-Datenbank immer nur jeweils eine Verbindung erlaubt.</blockquote>

                            </li>
                            <li>Bearbeiten Sie die Ant-Datei und geben Sie alle erforderlichen Eigenschaften für die Datenbank ein.
                            <br/><br/>
                            Legen Sie für die Konfiguration der von den MobileFirst-Server-Komponenten verwendeten Datenbank Werte für die folgenden Eigenschaften fest:
                                <ul>
                                    <li>Setzen Sie <b>mfp.process.admin</b> auf <b>true</b>, um die Datenbank für den Verwaltungs- und Liveaktualisierungsservice zu konfigurieren.</li>
                                    <li>Setzen Sie <b>mfp.process.runtime</b> auf <b>true</b>, um die Datenbank für die Laufzeit zu konfigurieren.</li>
                                </ul>
                            </li>
                            <li>Führen Sie die folgenden Befehle im Verzeichnis <b>MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples</b> aus. Ersetzen Sie die Datei <b>create-database-ant-file.xml</b> durch den Namen der von Ihnen gewählten Ant-Datei. <code>MFP-Installationsverzeichnis/shortcuts/ant -f create-database-ant-file.xml admdatabases</code> und <code>MFP-Installationsverzeichnis/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.
                            <br/><br/>
                            Da die MobileFirst-Server-Datenbanken von den Anwendungsservern einer Farm gemeinsam genutzt werden, müssen diese beiden Befehle unabhängig von der Anzahl der Server in der Farm nur einmal ausgeführt werden.</li>
                            <li>Wenn Sie eine weitere Laufzeit installieren möchten, müssen Sie eine weitere Datenbank mit einem anderen Datenbanknamen oder -schema konfigurieren. Bearbeiten Sie dazu die Ant-Datei. Modifizieren Sie die Eigenschaften und führen Sie den folgenden Befehl unabhängig von der Anzahl der Farm-Server einmal aus: <code>MFP-Installationsverzeichnis/shortcuts/ant -f create-database-ant-file.xml rtmdatabases</code>.</li>
                        </ul>
                    </li>
                    <li>Implementieren Sie den Verwaltungsservice, den Liveaktualisierungsservice und die Laufzeit auf den Servern und konfigurieren Sie die Server als Member einer Server-Farm.
                        <ul>
                            <li>Wählen Sie im Verzeichnis <b>MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples</b> die zu Ihrem Anwendungsserver und zu Ihrer Datenbank passende Ant-Datei aus, um den Verwaltungsservice, den Liveaktualisierungsservice und die Laufzeit auf den Servern zu implementieren.
                            <br/><br/>
                            Wählen Sie beispielsweise für eine Implementierung auf einem Liberty-Server mit DB2-Datenbank die Datei <b>configure-liberty-db2.xml</b> aus. Erstellen Sie für jedes Farmmember eine Kopie dieser Datei.
                            <br/><br/>
                            <b>Hinweis:</b> Bewahren Sie diese Dateien nach dem Konfigurieren auf. Sie können sie später wiederverwenden, wenn Sie ein Upgrade für die bereits implementierten MobileFirst-Server-Komponenten durchführen oder die Komponenten auf den Farmmembern deinstallieren.</li>
                            <li>Bearbeiten Sie jede Kopie der Ant-Datei. Geben Sie die Eigenschaften für die Datenbank ein, die Sie in Schritt 2 verwendet haben. Geben Sie zusätzlich die erforderlichen Eigenschaften für den Anwendungsserver ein.
                            <br/><br/>
                            Wenn Sie den Server als ein Server-Farmmember konfigurieren möchten, legen Sie die Werte für die folgenden Eigenschaften fest:
                                <ul>
                                    <li>Setzen Sie <b>mfp.farm.configure</b> auf true.</li>
                                    <li><b>mfp.farm.server.id</b>: Eine Kennung, die Sie für dieses Farmmember definieren. Jeder Server in der Farm muss eine eigene, eindeutige Kennung haben. Wenn zwei Server der Farm die gleiche Kennung haben, könnte sich die Farm unvorhersehbar verhalten.</li>
                                    <li><b>mfp.config.service.user</b>: Benutzername für den Zugriff auf den Liveaktualisierungsservice. Der Benutzername muss für alle Member der Farm der gleiche sein.</li>
                                    <li><b>mfp.config.service.password</b>: Kennwort für den Zugriff auf den Liveaktualisierungsservice. Das Kennwort muss für alle Member der Farm das gleiche sein.</li>
                                </ul>
                                Legen Sie für die Implementierung der WAR-Dateien der MobileFirst-Server-Komponenten auf dem Server Werte für die folgenden Eigenschaften fest:
                                    <ul>
                                        <li>Setzen Sie <b>mfp.process.admin</b> auf <b>true</b>, um die WAR-Dateien für den Verwaltungs- und Liveaktualisierungsservice zu implementieren.</li>
                                        <li>Setzen Sie <b>mfp.process.runtime</b> auf <b>true</b>, um die WAR-Datei für die Laufzeit zu implementieren.</li>
                                    </ul>
                                <br/>
                                <b>Hinweis:</b>Wenn Sie auf den Servern der Farm mehr als eine Laufzeit installieren wollen, geben Sie das Attribut "id" an und setzen Sie das Attribut in den Ant-Tasks <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> und <b>uninstallmobilefirstruntime</b> auf einen für jede Laufzeit eindeutigen Wert.
                                <br/>
                                Beispiel:
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>Führen Sie für jeden Server die folgenden Befehle aus. Ersetzen Sie die Datei configure-appserver-database-ant-file.xml durch den Namen der von Ihnen gewählten Ant-Datei. <code>MFP-Installationsverzeichnis/shortcuts/ant -f configure-appserver-database-ant-file.xml adminstall</code> und <code>MFP-Installationsverzeichnis/shortcuts/ant -f configure-appserver-database-ant-file.xml rtminstall</code>
                            <br/><br/>
                            Mit diesen Befehlen werden die Ant-Tasks <b>installmobilefirstadmin</b> und <b>installmobilefirstruntime</b> ausgeführt. Weitere Informationen zu diesen Tasks finden Sie unter <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">Ant tasks for installation of {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} artifacts, {{ site.data.keys.mf_server }} administration, and live update services</a> and <a href="../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen</a>.</li>
                            <li>Wenn Sie eine weitere Laufzeit installieren möchten, führen Sie die folgenden Schritte aus:
                                <ul>
                                    <li>Erstellen Sie eine Kopie der Ant-Datei, die Sie in Schritt 3.b konfiguriert haben.</li>
                                    <li>Bearbeiten Sie die Kopie. Legen Sie ein eindeutiges Kontextstammverzeichnis fest und setzen Sie das Attribut<b>id</b> für <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> und <b>uninstallmobilefirstruntime</b> auf einen Wert, der sich von dem der anderen Laufzeitkonfiguration unterscheidet.</li>
                                    <li>Führen Sie auf jedem Server der Farm den folgenden Befehl aus. Ersetzen Sie <b>configure-appserver-database-ant-file2.xml</b> durch den Namen der von Ihnen bearbeiteten Ant-Datei: <code>MFP-Installationsverzeichnis/shortcuts/ant -f configure-appserver-database-ant-file2.xml rtminstall</code>.</li>
                                    <li>Wiederholen Sie diesen Schritt für jeden Server der Farm.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>Führen Sie für alle Server einen Neustart durch.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Server-Farm manuell konfigurieren
{: #configuring-a-server-farm-manually }
Sie müssen jeden Server in der Farm gemäß den Anforderungen eines einzelnen Anwendungsservers konfigurieren, der für
jedes Member der Server-Farm verwendet wird. 

Wenn Sie eine Server-Farm planen, erstellen Sie zunächst eigenständige Server, die mit derselben Datenbankinstanz kommunizieren. Modifizieren Sie die Konfiguration dieser Server dann so,
dass sie Member einer Server-Farm werden. 

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>Für Anweisungen zum manuellen Konfigurieren einer Server-Farm hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>Wählen Sie zum Konfigurieren der Member der Server-Farm den Anwendungsservertyp aus. Die {{ site.data.keys.product }} unterstützt in Server-Farmen die folgenden Anwendungsserver:
                        <ul>
                            <li>WebSphere Application Server Full Profile<br/>
                            <b>Hinweis:</b> In einer Farmtopologie können Sie den RMI-JMX-Connector nicht verwenden. In dieser Topologie unterstützt die {{ site.data.keys.product }} nur den SOAP-Connector.</li>
                            <li>WebSphere Application Server Liberty Profile</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        Informationen zu den unterstützten Versionen der Anwendungsserver finden Sie in den <a href="../../../product-overview/requirements">Systemvoraussetzungen</a>.

                        <blockquote><b>Wichtiger Hinweis:</b> Die {{ site.data.keys.product }} unterstützt nur homogene Server-Farmen. Eine Server-Farm wird als homogen eingestuft, wenn sie Anwendungsserver desselben Typs miteinander verbindet. Der Versuch, unterschiedliche Typen von Anwendungsservern zuzuordnen, könnte zur Laufzeit zu einem unvorhersehbaren Verhalten führen. Eine Farm von Tomcat-Servern und Servern mit WebSphere Application Server Full Profile ist beispielsweise eine ungültige Konfiguration.</blockquote>
                    </li>
                    <li>Entscheiden Sie, welche Datenbank verwendet werden soll. Folgende Optionen stehen zur Auswahl:
                        <ul>
                            <li>DB2</li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        {{ site.data.keys.mf_server }}-Datenbanken werden von den Anwendungsservern einer Farm gemeinsam genutzt. Das bedeutet Folgendes:
                        <ul>
                            <li>Sie erstellen die Datenbank unabhängig von der Anzahl der Server in der Farm nur einmal.</li>
                            <li>Sie können die Derby-Datenbank nicht in einer Farmtopologie verwenden, weil die Derby-Datenbank immer nur jeweils eine Verbindung erlaubt.</li>
                        </ul>
                        Weitere Informationen zu Datenbanken finden Sie unter <a href="../databases">Datenbanken einrichten</a>.</li>
                    <li>Richten Sie so viele eigenständige Server ein, wie Sie Member in der Farm benötigen.
                        <ul>
                            <li>Jeder dieser eigenständigen Server muss mit derselben Datenbank kommunizieren. Sie müssen sicherstellen, dass jeder von diesen Servern verwendete Port nicht von einem anderen Server, der auf demselben Host konfiguriert ist, verwendet wird. Diese Beschränkung gilt für die Ports, die von den Protokollen HTTP, HTTPS, REST, SOAP und RMI verwendet werden.</li>
                            <li>In jedem dieser Server müssen der MobileFirst-Server-Verwaltungsservice, der MobileFirst-Server-Liveaktualisierungsservice und mindestens eine {{ site.data.keys.product_adj }}-Laufzeit implementiert sein.</li>
                            <li>Wenn jeder dieser Server ordnungsgemäß in einer eigenständigen Topologie funktioniert, können Sie die Server zu Membern einer Server-Farm machen.</li>
                        </ul>
                    </li>
                    <li>Stoppen Sie alle Server, die Member der Farm werden sollen.</li>
                    <li>Konfigurieren Sie jeden Server entsprechend dem Anwendungsservertyp. <br/>Sie müssen einige JNDI-Eigenschaften ordnungsgemäß definieren. In einer Server-Farmtopologie müssen die JNDI-Eigenschaften mfp.config.service.user und mfp.config.service.password aller Farmmember den gleichen Wert haben. Für Apache Tomcat müssen Sie außerdem überprüfen, ob die JVM-Argumente richtig definiert sind.
                        <ul>
                            <li><b>WebSphere Application Server Liberty Profile</b>
                                <br/>
                                Legen Sie in der Datei server.xml die im folgenden Beispielcode gezeigten JNDI-Eigenschaften fest.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="Farmmember1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="REST-Connector-Benutzer"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="Kennwort_des_REST-Connector-Benutzers"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                Die folgenden Eigenschaften müssen mit passenden Werten definiert werden:
                                <ul>
                                    <li><b>mfp.admin.serverid</b>: Die Kennung, die Sie für dieses Farmmember definiert haben. Diese Kennung muss für jedes Farmmember eindeutig sein. </li>
                                    <li><b>mfp.admin.jmx.user</b> und <b>mfp.admin.jmx.pwd</b>: Diese Werte müssen mit den Berechtigungsnachweisen eines im Element <code>administrator-role</code> deklarierten Benutzers übereinstimmen.</li>
                                    <li><b>mfp.admin.jmx.host</b>: Setzen Sie diesen Parameter auf die IP-Adresse oder den Hostnamen, die bzw. den ferne Member für den Zugriff auf diesen Server verwenden. Der Parameter darf daher nicht auf <b>localhost</b> gesetzt werden. Der Name dieses Hosts wird von den anderen Farmmembern verwendet. Der Host muss für alle Farmmember erreichbar sein.</li>
                                    <li><b>mfp.admin.jmx.port</b>: Setzen Sie diesen Parameter auf den Server-HTTPS-Port, der für die JMX-REST-Verbvindung verwendet wird. Sie finden den Wert im Element <code>httpEndpoint</code> der Datei <b>server.xml</b>.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                Modifizieren Sie die Datei <b>conf/server.xml</b>. Legen Sie im Verwaltungsservicekontext und in jedem Laufzeitkontext die folgenden JNDI-Eigenschaften fest.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="Farmmember1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                Die Eigenschaft <b>mfp.admin.serverid</b> muss auf die ID gesetzt werden, die Sie für dieses Farmmember definiert haben. Diese Kennung muss für jedes Farmmember eindeutig sein.
                                <br/>
                                Stellen Sie sicher, dass das JVM-Argument <code>-Djava.rmi.server.hostname</code> auf die IP-Adresse oder den Hostnamen gesetzt ist, die bzw. den ferne Member für den Zugriff auf diesen Server verwenden. Das Argument darf daher nicht auf <b>localhost</b> gesetzt werden. Außerdem müssen Sie sicherstellen, dass für das JVM-Argument <code>-Dcom.sun.management.jmxremote.port</code> ein Port definiert wird, der noch nicht für die Aktivierung von JMX-RMI-Verbindungen verwendet wird. Beide Argumente werden in der Umgebungsvariablen <b>CATALINA_OPTS</b> festgelegt.</li>
                            <li><b>WebSphere Application Server Full Profile</b>
                                <br/>
                                Sie müssen im Verwaltungsservice und in jeder im Server implementierten Laufzeitanwendung die folgenden JNDI-Eigenschaften deklarieren.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                Führen Sie in der WebSphere-Application-Server-Konsole die folgenden Schritte aus:
                                <ul>
                                    <li>Wählen Sie <b>Anwendungen → Anwendungstypen → Websphere-Unternehmensanwendungen</b> aus.</li>
                                    <li>Wählen Sie den Verwaltungsservice aus. </li>
                                    <li>Klicken Sie unter <b>Eigenschaften des Webmoduls</b> auf <b>Umgebungseinträge für Webmodule</b>, um die JNDI-Eigenschaften anzuzeigen.</li>
                                    <li>Legen Sie die Werte der folgenden Eigenschaften fest.
                                        <ul>
                                            <li>Setzen Sie <b>mfp.topology.clustermode</b> auf <b>Farm</b>.</li>
                                            <li>Setzen Sie <b>mfp.admin.serverid</b> auf die ID, die Sie für dieses Farmmember gewählt haben. Diese Kennung muss für jedes Farmmember eindeutig sein. </li>
                                            <li>Setzen Sie <b>mfp.admin.jmx.user</b> auf den Namen eines Benutzers, der Zugriff auf den SOAP-Connector hat.</li>
                                            <li>Setzen Sie <b>mfp.admin.jmx.pwd</b> auf das Kennwort des in <b>mfp.admin.jmx.user</b> deklarierten Benutzers.</li>
                                            <li>Setzen Sie <b>mfp.admin.jmx.port</b> auf den SOAP-Portwert.</li>
                                        </ul>
                                    </li>
                                    <li>Vergewissern Sie sich, dass <b>mfp.admin.jmx.connector</b> auf <b>SOAP</b> gesetzt ist.</li>
                                    <li>Klicken Sie auf <b>OK</b> und speichern Sie die Konfiguration.</li>
                                    <li>Nehmen Sie ähnliche Veränderungen für jede auf dem Server implementierte {{ site.data.keys.product_adj }}-Laufzeitumgebung vor.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Tauschen Sie die Serverzertifikate aus den Truststores aller Farmmember aus. Der Austausch von Serverzertifikaten zwischen den Truststores ist obligatorisch für Farmen, die WebSphere Application Server Full Profile und WebSphere Application Server LIberty Profile verwenden, weil die Kommunikation zwischen den Servern in diesen Farmen mit SSL geschützt wird.
                        <ul>
                            <li><b>WebSphere Application Server Liberty Profile</b>
                                <br/>
                                Sie können den Truststore mit IBM Dienstprogrammen wie Keytool oder iKeyman konfigurieren.
                                <ul>
                                    <li>Weitere Informationen zu Keytool finden Sie in der Dokumentation zu IBM SDK Java Technology Edition im Abschnitt <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a>.</li>
                                    <li>Weitere Informationen zu iKeyman finden Sie in der Dokumentation zu IBM SDK Java Technology Edition im Abschnitt <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a>.</li>
                                </ul>
                                Die Keystore- und Truststore-Position ist in der Datei <b>server.xml</b> definiert. Lesen Sie die Beschreibung der Attribute <b>keyStoreRef</b> und <b>trustStoreRef</b> unter <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">SSL-Konfigurationsattribute</a>. Standardmäßig befindet sich der Liberty-Profile-Keystore unter <b>${server.config.dir}/resources/security/key.jks</b>. Wenn der Truststore-Verweis in der Datei <b>server.xml</b> fehlt oder nicht definiert ist, wird der mit <b>keyStoreRef</b> angegebene Keystore verwendet. Der Server verwendet den Standard-Keystore. Die Datei wird erstellt, wenn der Server zum ersten Mal ausgeführt wird. In dem Fall wird ein Standardzertifikat mit einem Gültigkeitszeitraum von 365 Tagen erstellt. Für die Produktion sollten Sie die Verwendung eines eigenen Zertifikats (ggf. einschließlich der Zwischenzertifikate) in Betracht ziehen oder das Verfallsdatum des generierten Zertifikats ändern.

                                <blockquote>Hinweis: Wenn Sie die Position des Truststore bestätigen möchten, fügen Sie die folgende Deklaration zur Datei server.xml hinzu:
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                Starten Sie schließlich den Server und suchen Sie in der Datei <b>${wlp.install.dir}/usr/servers/Servername/logs/trace.log</b> nach Zeilen, die com.ibm.ssl.trustStore enthalten.
                                <ul>
                                    <li>Importieren Sie die öffentlichen Zertifikate der anderen Server der Farm in den Truststore, auf den die Konfigurationsdatei <b>server.xml</b> des Servers verweist. Das Lernprogramm (<a href="../tutorials/graphical-mode">{{ site.data.keys.mf_server }} im Grafikmodus installieren</a>) enthält die Anweisungen für den Austausch der Zertifikate zwischen zwei Liberty-Servern einer Farm. Weitere Informationen finden Sie unter <a href="../tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">Farm mit zwei Liberty-Servern für {{ site.data.keys.mf_server }} erstellen</a> in Schritt 5.</li>
                                    <li>Starten Sie jede Instanz von WebSphere Application Server Liberty Profile neu, damit die Sicherheitskonfiguration wirksam wird. Die folgenden Schritte sind erforderlich, wenn Sie mit SSO arbeiten möchten.</li>
                                    <li>Starten Sie ein Member der Farm. Nach erfolgreichem Start des Liberty-Servers wird in der LTPA-Standardkonfiguration der LTPA-Keystore <b>${wlp.user.dir}/servers/Servername/resources/security/ltpa.keys</b> generiert.</li>
                                    <li>Kopieren Sie die Datei <b>ltpa.keys</b> in das Verzeichnis <b>${wlp.user.dir}/servers/Servername/resources/security</b> jedes Farmmembers, um die LTPA-Keystores auf allen Farmmembern zu replizieren. Weitere Informationen zur LTPA-Konfiguration finden Sie unter <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">LTPA im Liberty-Profil konfigurieren</a>.</li>
                                </ul>
                            </li>
                            <li><b>WebSphere Application Server Full Profile</b>
                                <br/>
                                Konfigurieren Sie den Truststore in der Administrationskonsole von WebSphere Application Server.
                                <ul>
                                    <li>Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. </li>
                                    <li>Wählen Sie <b>Sicherheit → Verwaltung von SSL-Zertifikaten und Schlüsseln</b> aus.</li>
                                    <li>Wählen Sie unter <b>Zugehörige Elemente</b> die Option <b>Keystores und Zertifikate</b> aus.</li>
                                    <li>Stellen Sie sicher, dass der Eintrag <b>SSL-Keystores</b> im Feld <b>Keystore-Nutzung</b> ausgewählt ist. Jetzt können Sie die Zertifikate aller anderen Server in der Farm importieren. </li>
                                    <li>Klicken Sie auf <b>NodeDefaultTrustStore</b>. </li>
                                    <li>Wählen Sie unter <b>Weitere Eigenschaften</b> die Option <b>Unterzeichnerzertifikate</b> aus.</li>
                                    <li>Klicken Sie auf <b>Vom Port abrufen</b>. Jetzt können Sie Kommunikations- und Sicherheitsdetails aller anderen Server in der Farm eingeben. Führen Sie für jedes der übrigen Farmmember die folgenden Schritte aus.</li>
                                    <li>Geben Sie im Feld <b>Host</b> den Hostnamen oder die IP-Adresse des Servers ein.</li>
                                    <li>Geben Sie im Feld <b>Port</b> den SSL-Port für HTTPS-Transport ein.</li>
                                    <li>Wählen Sie unter <b>SSL-Konfiguration für abgehende Verbindung</b> die Option <b>NodeDefaultSSLSettings</b> aus.</li>
                                    <li>Geben Sie im Feld <b>Alias</b> einen Alias für dieses Unterzeichnerzertifikat ein. </li>
                                    <li>Klicken Sie auf <b>Unterzeichnerdaten abrufen</b>.</li>
                                    <li>Überprüfen Sie die Informationen, die vom fernen Server abgerufen werden. Klicken Sie dann auf <b>OK</b>.</li>
                                    <li>Klicken Sie auf <b>Speichern</b>.</li>
                                    <li>Starten Sie den Server erneut.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Farmkonfiguration prüfen
{: #verifying-a-farm-configuration }
Sie überprüfen den Status der Farmmember und stellen sicher, dass die Farm
ordnungsgemäß konfiguriert ist. 

1. Starten Sie alle Server der Farm.
2. Rufen Sie die {{ site.data.keys.mf_console }} auf. Geben Sie beispielsweise **http://Servername:Port/mfpconsole** ein oder
für HTTPS **https://Hostname:sicherer_Port/mfpconsole**.
    In der Seitenleiste der Konsole erscheint ein zusätzliches Menü
Server-Farmknoten. 
3. Wenn Sie auf
**Server-Farmknoten** klicken, können Sie auf die Liste der registrierten Farmmember und ihren Status
zugreifen. Im folgenden Beispiel wird der mit **Farmmember2** bezeichnete Knoten als inaktiv angesehen. Das bedeutet, dass ein Serverfehler vorliegen
könnte und der Server möglicherweise gewartet werden muss. 

![Status von Farmknoten in der {{ site.data.keys.mf_console }}](farm_nodes_status_list.jpg)

### Lebenszyklus eines Server-Farmknotens
{: #lifecycle-of-a-server-farm-node }
Sie können eine Signalrate und Zeitlimitwerte konfigurieren, damit mögliche Serverprobleme bei Farmmembern durch das Auslösen einer Statusänderung bei einem
betroffenen Knoten angezeigt werden.

#### Server als Farmknoten registrieren und überwachen
{: #registration-and-monitoring-servers-as-farm-nodes }
Wenn ein als Farmknoten konfigurierter Server gestartet wird, registriert der Verwaltungsservice dieses Servers den Knoten automatisch als neues Farmmember.Wenn ein
Farmmember beendet wird, wird die Registrierung dieses Members in der Farm automatisch aufgehoben.

Es gibt ein Überwachungssignalverfahren für den Fall, dass
Farmmember beispielsweise wegen eines Stromausfalls oder eines Serverfehlers nicht mehr reagieren. In diesem Überwachungssignalverfahren
senden {{ site.data.keys.product_adj }}-Laufzeiten in festgelegten regelmäßigen Abständen
ein Überwachungssignal
an die {{ site.data.keys.product_adj }}-Verwaltungsservices. Wenn der
{{ site.data.keys.product_adj }}-Verwaltungsservice registriert, dass
seit dem letzten Überwachungssignal von einem Farmmember zu viel Zeit vergangen ist, wird davon ausgegangen, dass das Farmmember
inaktiv ist.

Als inaktiv angesehene Farmmember bedienen keine Anforderungen mobiler Anwendungen.

Wenn Knoten inaktiv sind, hindert das die übrigen Member
nicht daran, Anfragen mobiler Anwendungen zu beantworten oder neue, über die {{ site.data.keys.mf_console }}
ausgelöste Verwaltungsoperationen zu akzeptieren. 

#### Signalrate und Zeitlimitwerte konfigurieren
{: #configuring-the-heartbeat-rate-and-timeout-values }
Sie können die Signalrate und Zeitlimitwerte konfigurieren, indem Sie
die folgenden JNDI-Eigenschaften definieren:

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
Weitere Informationen zu JNDI-Eigenschaften finden Sie in der
[Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

