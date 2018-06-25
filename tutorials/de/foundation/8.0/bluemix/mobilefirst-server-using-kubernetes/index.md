---
layout: tutorial
title: MobileFirst Server in einem IBM Cloud-Kubernetes-Cluster einrichten
breadcrumb_title: Mobile Foundation on Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um eine MobileFirst-Server-Instanz und eine Instanz von {{ site.data.keys.mf_analytics }} für IBM Cloud zu konfigurieren. Gehen Sie dazu die folgenden Schritte durch: 

* Erstellen Sie einen Kubernetes-Cluster vom Typ "Standard" (bezahlter Cluster). 
* Richten Sie Ihren Host-Computer mit den erforderlichen Tools ein (Docker, Cloud-Foundry-CLI (cf), IBM Cloud-CLI (bx), CLI des Container-Service-Plug-ins für IBM Cloud (bx cs), CLI des Container-Registry-Plug-ins für IBM Cloud (bx cr), Kubernetes-CLI (kubectl)).
* Erstellen Sie ein MobileFirst-Server-Docker-Image und stellen Sie es per Push-Operation in das IBM Cloud-Repository. 
* Abschließend werden Sie das Docker-Image in einem Kubernetes-Cluster ausführen.

>**Hinweis:**  
>
* Das Windows-Betriebssystem wird derzeit nicht für die Ausführung dieser Scripts unterstützt.   
* Die MobileFirst-Server-Konfigurationstools können nicht für die Implementierung in IBM Containern genutzt werden. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Konto in IBM Cloud registrieren](#register-an-account-on-ibmcloud)
* [Hostmaschine einrichten](#set-up-your-host-machine)
* [Kubernetes-Cluster mit dem Container-Service von IBM Cloud erstellen und einrichten](#setup-kube-cluster)
* [Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen](#download-the-ibm-mfpf-container-8000-archive)
* [Voraussetzungen](#prerequisites)
* [{{ site.data.keys.product_adj }} Server und Analytics Server im Kubernetes-Cluster mit IBM Containern einrichten](#setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers)
* [Fixes für {{ site.data.keys.mf_server }} anwenden](#applying-mobilefirst-server-fixes)
* [Kubernetes-Implementierungen aus IBM Cloud entfernen](#removing-kube-deployments)
* [Datenbankservicekonfiguration aus IBM Cloud entfernen](#removing-the-database-service-configuration-from-ibmcloud)

## Konto in IBM Cloud registrieren
{: #register-an-account-on-ibmcloud }
Falls Sie noch kein Konto haben, öffnen Sie die [IBM Cloud-Website](https://bluemix.net) und klicken Sie auf **Kostenloses Konto erstellen** oder auf **Anmeldung**. Sie müssen das Registrierungsformular ausfüllen, bevor Sie mit dem nächsten Schritt fortfahren können. 

### IBM Cloud-Dashboard
{: #the-ibmcloud-dashboard }
Nachdem Sie sich bei IBM Cloud angemeldet haben, wird das IBM Cloud-Dashboard angezeigt, das Ihnen einen Überblick über den aktiven IBM Cloud-Bereich gibt. Standardmäßig hat dieser Arbeitsbereich den Namen "dev". Bei Bedarf können Sie mehrere Arbeitsbereiche erstellen. 

## Hostmaschine einrichten
{: #set-up-your-host-machine }
Für die Verwaltung von Containern und Images müssen Sie die folgenden Tools installieren: 
* Docker
* IBM Cloud-CLI (bx)
* CLI des Container-Service-Plug-ins für IBM Cloud (bx cs)
* CLI des Container-Registry-Plug-ins für IBM Cloud (bx cr)
* Kubernetes-CLI (kubectl)

In der IBM Cloud-Dokumentation sind die [Konfigurationsschritte für die vorausgesetzten CLIs](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps) beschrieben.

## Kubernetes-Cluster mit dem Container-Service von IBM Cloud erstellen und einrichten
{: #setup-kube-cluster}
Informationen zum [Einrichten eines Kubernetes-Clusters in IBM Cloud](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli) finden Sie in der IBM Cloud-Dokumentation.

>**Hinweis:** Für die Implementierung der {{ site.data.keys.mf_bm_short }} ist ein Kubernetes-Cluster vom Typ "Stadard" (bezahlter Cluster) erforderlich.

## Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen
{: #download-the-ibm-mfpf-container-8000-archive}
Wenn Sie die {{ site.data.keys.mf_bm_short }} als Kubernetes-Cluster mit IBM Cloud-Containern einrichten möchten, müssen Sie zunächst ein Image erstellen, das später per Push-Operation in IBM Cloud übertragen wird. <br/>
Vorläufige Fixes für {{ site.data.keys.mf_server }} in IBM Containern können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.<br/>
Laden Sie den letzten vorläufigen Fix von Fix Central herunter. Ab iFix **8.0.0.0-IF201707051849** ist Kubernetes-Unterstützung verfügbar.

Die Archivdatei enthält die Dateien für die Erstellung eines Image (**dependencies** und **mfpf-libs**) sowie die Dateien für die Erstellung und Implementierung von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} in Kubernetes (bmx-kubernetes).

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Für mehr Informationen zum Inhalt der Archivdatei und zu den verfügbaren Umgebungseigenschaften hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Dateisystemstruktur der Archivdatei" style="float:right;width:570px"/>
                <h4>Ordner bmx-kubernetes</h4>
                <p>Dieser Ordner enthält die Anpassungsdateien und Scripts für die Implementierung eines Kubernetes-Clusters mit dem Container-Service von IBM Cloud. </p>

                <h4>Dockerfile-mfpf-analytics und Dockerfile-mfpf-server</h4>

                <ul>
                    <li><b>Dockerfile-mfpf-server</b>: Textdokument mit allen Befehlen, die für das Erstellen des MobileFirst-Server-Image erforderlich sind. </li>
                    <li><b>Dockerfile-mfpf-analytics</b>: Textdokument mit allen Befehlen, die für das Erstellen des MobileFirst-Analytics-Image erforderlich sind. </li>
                    <li>Ordner <b>scripts</b>: Dieser Ordner enthält den Ordner <b>args</b> mit einer Reihe von Konfigurationsdateien. Er enthält außerdem die erforderlichen Scripts für die Anmeldung bei IBM Cloud, die Erstellung eines Image für {{ site.data.keys.mf_server }} bzw. {{ site.data.keys.mf_analytics }} und die Push-Übertragung und Ausführung des Image in IBM Cloud. Sie können diese Scripts interaktiv ausführen oder die Konfigurationsdateien wie weiter unten erläutert für die Ausführung der Scripts vorkonfigurieren. Anders als bei den anpassbaren Dateien args/*.properties dürfen Sie in diesem Ordner keine Elemente modifizieren. Verwenden Sie das Befehlszeilenargument <code>-h</code> oder <code>--help</code>, um einen Hilfetext zur Scriptsyntax abzurufen (z. B. <code>Scriptname.sh --help</code>).</li>
                    <li>Ordner <b>usr-mfpf-server</b> und <b>usr-mfpf-analytics</b>:
                        <ul>
                            <li>Ordner <b>bin</b>: Enthält die Scriptdatei (mfp-init), die beim Start des Containers ausgeführt wird. Sie können eigenen Code hinzufügen, der ausgeführt werden soll.</li>
                            <li>Ordner <b>config</b>: Für {{ site.data.keys.mf_server }} bzw. {{ site.data.keys.mf_analytics }} verwendete Serverkonfigurationsfragmente (Keystore, Servereigenschaften, Benutzerregistry)</li>
                            <li><b>keystore.xml</b>: Konfiguration des Repositorys mit Sicherheitszertifikaten für die SSL-Verschlüsselung. Im Ordner ./usr/security muss auf die aufgelisteten Dateien verwiesen werden.</li>
                            <li><b>ltpa.xml</b>: Konfigurationsdatei mit der Definition des LTPA-Schlüssels und des zugehörigen Kennworts </li>
                            <li><b>mfpfproperties.xml</b>: Konfigurationseigenschaften für {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }}. Informieren Sie sich anhand der folgenden Dokumentationsabschnitte über die unterstützten Eigenschaften:<ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Sever-Verwaltungsservice</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a></li>
                                </ul>
                            </li>
                            <li><b>mfpfsqldb.xml</b>: JDBC-Datenquellendefinition für die Verbindung zur Db2- oder dashDB-Datenbank</li>
                            <li><b>registry.xml</b>: Benutzerregistrykonfiguration. Als Standardkonfiguration wird eine auf XML basierende Basisbenutzerregistrykonfiguration (basicRegistry) bereitgestellt. Sie können Namen und Kennwörter für basicRegistry konfigurieren oder ldapRegistry konfigurieren.</li>
                            <li><b>tracespec.xml</b>: Tracespezifikation, um ein Debug zu ermöglichen, sowie Protokollierungsstufen</li>
                        </ul>
                    </li>
                    <li>Ordner <b>jre-security</b>: Sie können die sicherheitsrelevanten JRE-Dateien (Truststore, JAR-Richtliniendateien usw.) aktualisieren, indem Sie sie in diesen Ordner stellen. Die Dateien aus diesem Ordner werden in den Ordner <b>JAVA_HOME/jre/lib/security/</b> des Containers kopiert.</li>
                    <li>Ordner <b>security</b>: Wird verwendet, um die Keystore-Datei, die Truststore-Datei und die LTPA-Schlüsseldatei (ltpa.keys) zu speichern.</li>
                    <li>Ordner <b>env</b>: Enthält die Umgebungseigenschaften für die Serverinitialisierung (server.env) sowie angepasste JVM-Optionen (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Für eine Liste unterstützter Serverumgebungseigenschaften hier klicken</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Eigenschaft</b></td>
                                            <td><b>Standardwert</b></td>
                                            <td><b>Beschreibung</b></td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>Port für Client-HTTP-Anforderungen. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>Port für Client-HTTP-Anforderungen, die mit SSL (HTTPS) geschützt werden. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>Kontextstammverzeichnis, in dem die MobileFirst-Server-Verwaltungsservices verfügbar gemacht werden</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>Kontextstammverzeichnis, in dem die {{ site.data.keys.mf_console }} verfügbar gemacht wird</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>mfpadmin</code> zugeordnet ist</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP</td>
                                            <td>mfpdeployergroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>mfpdeployer</code> zugeordnet ist</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>mfpmonitor</code> zugeordnet ist</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>mfpoperator</code> zugeordnet ist</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER</td>
                                            <td>WorklightRESTUser</td>
                                            <td>Liberty-Serveradministrator für die MobileFirst-Server-Verwaltungsservices</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD</td>
                                            <td>mfpadmin. Vor der Implementierung in einer Produktionsumgebung müssen Sie den Standardwert durch ein privates Kennwort ersetzen.</td>
                                            <td>Kennwort des Liberty-Serveradministrators für die MobileFirst-Server-Verwaltungsservices</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Abschnitt schließen</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Für eine Liste unterstützter Analytics-Umgebungseigenschaften hier klicken</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Eigenschaft</b></td>
                                            <td><b>Standardwert</b></td>
                                            <td><b>Beschreibung</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>Port für Client-HTTP-Anforderungen. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>Port für Client-HTTP-Anforderungen. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>Name der Benutzergruppe mit der vordefinierten Rolle <b>worklightadmin</b></td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Abschnitt schließen</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <li>Ordner <b>dependencies</b>: Enthält die Laufzeit der {{ site.data.keys.mf_bm_short }} und IBM Java JRE 8</li>
                    <li>Ordner <b>mfpf-libs</b>: Enthält die Bibliotheken für die {{ site.data.keys.product_adj }}-Produktkomponenten und die CLI</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

## Voraussetzungen
{: #prerequisites }

Sie müssen über praktische Erfahrungen mit Kubernetes verfügen. Weitere Informationen enthalten die [Kubernetes-Dokumente](https://kubernetes.io/docs/concepts/). 


## {{ site.data.keys.product_adj }} Server und Analytics Server im Kubernetes-Cluster mit IBM Containern einrichten
{: #setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers }
Wie bereits erläutert, können Sie die Scripts interaktiv oder unter Verwendung der Konfigurationsdateien ausführen. 

* **Verwendung der Konfigurationsdateien**: Führen Sie die Scripts aus und übergeben Sie die entsprechende Konfigurationsdatei als Argument. 
* **Interaktiv**: Führen Sie die Scripts ohne Argumente aus. 

>**Hinweis:** Wenn Sie sich entschließen, die Scripts interaktiv auszuführen, können Sie die Konfiguration übergehen. Wir empfehlen Ihnen jedoch, sich mit den Argumenten, die angegeben werden müssen, zu beschäftigen.



Bei interaktiver Ausführung wird eine Kopie der angegebenen Argumente im Verzeichnis `./recorded-args/` gespeichert. Sie können somit beim ersten Mal den interaktiven Modus nutzen und bei künftigen Implementierungen die Eigenschaftendateien wiederverwenden. 

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Tragen Sie die Argumentwerte in den folgenden Dateien ein:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_API_URL - </b>Zielgeografie oder -region für die Implementierung<br>
                      <blockquote>Beispiel: <i>api.ng.bluemix.net</i> für die USA oder <i>api.eu-de.bluemix.net</i> für Deutschland oder <i>api.au-syd.bluemix.net</i> für Sydney</blockquote>
                    </li>
                    <li><b>IBM_CLOUD_ACCOUNT_ID - </b>Ihre Konto-ID in Form eines alphanumerischen Wertes wie <i>a1b1b111d11e1a11d1fa1cc999999999</i><br>	Mit dem Befehl <code>bx target</code> können Sie die Konto-ID abrufen. </li>
                    <li><b>IBM_CLOUD_USER - </b>Ihr IBM Cloud-Benutzername (E-Mail-Adresse) </li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Ihr IBM Cloud-Kennwort</li>
                    <li><b>IBM_CLOUD_ORG - </b>Ihr IBM Cloud-Organisationsname</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Ihr IBM Cloud-Bereich (wie oben erläutert)</li>
                </ul><br/>
                <h4>prepareserverdbs.properties</h4>
                Der {{ site.data.keys.mf_bm_short }} Service erfordert eine externe Instanz von <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>Db2 on Cloud</i></a>. <br/>
                <blockquote><b>Hinweis:</b> Sie können auch Ihre eigene Db2-Datenbank verwenden. Der IBM Cloud-Kubernetes-Cluster muss für eine Verbindung zu der Datenbank konfiguriert werden. </blockquote>
                Wenn Sie Ihre Db2-Instanz eingerichtet haben, geben Sie die folgenden erforderlichen Argumente an:
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i> (wenn Sie Db2 on Cloud verwenden) oder <i>DB2</i> (wenn Sie Ihre eigene Db2-Datenbank verwenden)</li>
                    <li>Bei Verwendung einer eigenen Db2-Datenbank (d. h. DB_TYPE=DB2) machen Sie folgende Angaben:
                      <ul><li><b>DB2_HOST</b> - Hostname in Ihrem Db2-Setup</li>
                          <li><b>DB2_DATABASE</b> - Name der Datenbank</li>
                          <li><b>DB2_PORT</b> - Port für die Verbindung zur Datenbank</li>
                          <li><b>DB2_USERNAME</b> - Db2-Datenbankbenutzer (der berechtigt sein muss, Tabellen im bereitgestellten Schema zu erstellen oder beim Fehlen eines Schemas ein Schema zu erstellen)</li>
                          <li><b>DB2_PASSWORD</b> - Kennwort des Db2-Benutzers</li>
                      </ul>
                    </li>
                    <li>Wenn Sie Db2 on Cloud verwenden (d. h. DB_TYPE=dashDB), machen Sie folgende Angaben:
                      <ul><li><b>ADMIN_DB_SRV_NAME</b> - Name Ihrer dashDB-Serviceinstanz für das Speichern von Verwaltungsdaten </li>
                          <li><b>RUNTIME_DB_SRV_NAME</b> - Name Ihrer dashDB-Serviceinstanz für das Speichern von Laufzeitdaten. Der Standardwert ist der Name des Verwaltungsservice.</li>
                          <li><b>PUSH_DB_SRV_NAME</b> - Name Ihrer dashDB-Serviceinstanz für das Speichern von Laufzeitdaten. Der Standardwert ist der Name des Verwaltungsservice.</li>
                      </ul>
                    </li>
                    <li><b>ADMIN_SCHEMA_NAME</b> - Name Ihres Schemas für Verwaltungsdaten. Der Standardwert ist <i>MFPDATA</i>.</li>
                    <li><b>RUNTIME_SCHEMA_NAME</b> - Name Ihres Schemas für Laufzeitdaten. Der Standardwert ist <i>MFPDATA</i>.</li>
                    <li><b>PUSH_SCHEMA_NAME</b> - Name Ihres Schemas für Laufzeitdaten. Der Standardwert ist <i>MFPDATA</i>.</li>
                    <blockquote><b>Hinweis:</b> Wenn Ihr Db2-Datenbankservice von vielen Benutzern oder mehreren Mobile-Foundation-Implementierungen gemeinsam genutzt wird, stellen Sie sicher, dass eindeutige Schemanamen angegeben werden. </blockquote>
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/image:tag</em> haben.</li>
                  <li><b>ANALYTICS_IMAGE_TAG</b> - Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/image:tag</em> haben.</li>
                  <blockquote>Beispiel: <em>registry.ng.bluemix.net/myuniquenamespace/mymfpserver:v1</em><br/>Wenn Sie noch keinen Docker-Registry-Namespace erstellt haben, erstellen Sie ihn mit einem der folgenden Befehle: <br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">Scripts ausführen</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten für einen nicht interaktiven Modus wird ebenfalls bereitgestellt. </p>

            <ol>
                <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
                    Führen Sie das Script <b>initenv.sh</b> aus, um eine Umgebung für die Erstellung und Ausführung der {{ site.data.keys.mf_bm_short }} in IBM Containern zu erstellen:
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareserverdbs.sh - Erstellung der MobileFirst-Server-Datenbank</b><br />
                    Das Script <b>prepareserverdbs.sh</b> wird verwendet, um Ihren {{ site.data.keys.mf_server }} mit dem Db2-Datenbankservice zu konfigurieren. Die Instanz des Db2-Service muss in der Organisation und in dem Bereich verfügbar sein, für die Sie sich in Schritt 1 angemeldet haben.
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./prepareserverdbs.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                      Dieser Schritt ist nur erforderlich, wenn Sie Ihre Container in einer Organisation und einem Breich ohne verfügbare Db2-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei initenv.properties mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

</li>
                <li><b>prepareserver.sh - Erstellung eines MobileFirst-Server-Image</b><br />
                    Führen Sie das Script <b>prepareserver.sh</b> aus, um ein MobileFirst-Server-Image und ein MobileFirst-Analytics-Image zu erstellen und per Push-Operation in Ihr IBM Cloud-Repository zu übertragen. Wenn Sie alle verfügbaren Images in Ihrem IBM Cloud-Repository anzeigen möchten, führen Sie <code>bx cr image-list</code> aus. <br/>
                    Die Liste enthält den Image-Namen, das Erstellungsdatum und die ID.<br/>
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./prepareserver.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                </li>
                <li>Implementieren Sie {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} in Docker-Containern eines Kubernetes-Clusters mit dem Container-Service von IBM Cloud.
                <ol>
                  <li>Legen Sie Ihren Cluster als Terminalkontext fest: <br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  Führen Sie den folgenden Befehl aus, um Ihren Clusternamen zu erfahren: <br/><code>bx cs clusters</code><br/>
                  In der Ausgabe wird der Pfad zu Ihrer Konfigurationsdatei als Befehl zum Definieren einer Umgebungsvariablen angezeigt. Beispiel: <br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  Kopieren Sie den obigen Befehl. Ersetzen Sie <em>my-cluster</em> durch Ihren Clusternamen und fügen Sie den Befehl dann ein, um die Umgebungsvariable für Ihr Terminal festzulegen. Drücken Sie abschließend die <b>Eingabetaste</b>.
                  </li>
                  <li><b>[Mandatory for {{ site.data.keys.mf_analytics }}]: </b> Erstellen Sie ein <b>Persistent Volume Claim</b> (eine Anforderung für einen persistenten Datenträger) zum persistenten Speichern von Analysedaten. Dieser Schritt muss nur einmal ausgeführt werden. Falls Sie bereits ein <b>Persistent Volume Claim</b> (Anforderung für einen persistenten Datenträger) erstellt hatten, können Sie diese Anforderung wiederverwenden. Bearbeiten Sie die <em>yaml</em>-Datei <b>args/mfpf-persistent-volume-claim.yaml</b> und führen Sie den Befehl aus.
                  Alle Variablen müssen vor Ausführung des folgenden Befehls <em>kubectl</em> durch die entsprechenden Werte ersetzt werden. <br/><code>kubectl create -f ./args/mfpf-persistent-volume-claim.yaml</code><br/>
                  Notieren Sie den Namen des <b>Persistent Volume Claim</b>. Sie müssen ihn in einem nachfolgenden Schritt angeben.
                  </li>
                  <li>Führen Sie den folgenden Befehl aus, um Ihre <b>Ingress Domain</b> (Zugangsdomäne) abzurufen: <br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   Notieren Sie Ihre Zugangsdomäne. Wenn Sie TLS konfigurieren müssen, notieren Sie den geheimen Zugangsschlüssel (<b>Ingress Secret</b>).</li>
                  <li>Erstellen Sie die Kubernetes-Implementierungen. <br/>Bearbeiten Sie die yaml-Datei <b>args/mfpf-deployment-all.yaml</b>. Tragen Sie alle Details ein. Alle Variablen müssen vor Ausführung des Befehls <em>kubectl</em> durch die entsprechenden Werte ersetzt werden. <br/>
                  <b>./args/mfpf-deployment-all.yaml</b> enthält die Implementierung für Folgendes:
                  <ul>
                    <li>Kubernetes-Implementierung für {{ site.data.keys.mf_server }}, bestehend aus 3 Instanzen (Replikaten), mit einem Hauptspeicher von 1024 MB und einer CPU mit einem Kern </li>
                    <li>Kubernetes-Implementierung für {{ site.data.keys.mf_analytics }}, bestehend aus 2 Instanzen (Replikaten), mit einem Hauptspeicher von 1024 MB und einer CPU mit einem Kern </li>
                    <li>Kubernetes-Service für {{ site.data.keys.mf_server }}</li>
                    <li>Kubernetes-Service für {{ site.data.keys.mf_analytics }}</li>
                    <li>Zugang für das gesamte Setup mit allen REST-Endpunkten für {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }}</li>
                    <li>Konfigurationsübersicht (configMap), um die Umgebungsvariablen in den Instanzen von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} verfügbar zu machen</li>
                  </ul>
                  In der YAML-Datei müssen folgende Werte bearbeitet werden: <br/>
                    <ol><li>Verschiedene Vorkommen von <em>my-cluster.us-south.containers.mybluemix.net</em> mit der vom obigen Befehl <code>bx cs cluster-get</code> ausgegebenen Zugangsdomäne (<b>Ingress Domain</b>)</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpfanalytics:latest</em> und <em>registry.ng.bluemix.net/repository/mfpfserver:latest</em> - Verwenden Sie zum Hochladen der Images die gleichen Namen wie in prepareserver.sh. </li>
                    <li><b>claimName</b>: <em>mfppvc</em> - Verwenden Sie für die Anforderung für einen persistenten Datenträger (Persistent Volume Claim) den Namen, den Sie bei der Erstellung der Anforderung angegeben haben. <br/></li>
                    </ol>
                    Führen Sie den folgenden Befehl aus: <br/>
                    <code>kubectl create -f ./args/mfpf-deployment-all.yaml</code>
                    <blockquote><b>Hinweis:<br/></b>Folgende YAML-Schablonendateien werden bereitgestellt: <br/>
                    <ul><li><b>mfpf-deployment-all.yaml</b>: Implementiert {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} mit HTTP. </li>
                      <li><b>mfpf-deployment-all-tls.yaml</b>: Implementiert {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} mit HTTPS. </li>
                      <li><b>mfpf-deployment-server.yaml</b>: Implementiert {{ site.data.keys.mf_server }} mit HTTP. </li>
                      <li><b>mfpf-deployment-analytics.yaml</b>: Implementiert {{ site.data.keys.mf_analytics }} mit HTTP. </li></ul></blockquote>
                      Nach der Erstellung müssen Sie den folgenden Befehl ausführen, um das Kubernetes-Dashboard verwenden zu können: <br/>
                      <code>kubectl proxy</code><br/>Öffnen Sie <b>localhost:8001/ui</b> in Ihrem Browser.
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>

{{ site.data.keys.mf_server }} wird jetzt in IBM Cloud ausgeführt, sodass Sie mit der Anwendungsentwicklung beginnen können. Gehen Sie die {{ site.data.keys.product }} [Lernprogramme](../../all-tutorials) durch.


## Fixes für {{ site.data.keys.mf_server }} anwenden
{: #applying-mobilefirst-server-fixes }

Vorläufige Fixes für {{ site.data.keys.mf_server }} in IBM Containern können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.  
Sichern Sie Ihre vorhandenen Konfigurationsdateien, bevor Sie einen vorläufigen Fix anwenden. Die Konfigurationsdateien befinden sich in den folgenden Ordnern: 
* {{ site.data.keys.mf_analytics }}: **Paketstammverzeichnis/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} (Liberty-Cloud-Foundry-Anwendung): **Paketstammverzeichnis/bmx-kubernetes/usr-mfpf-server**

### Anwendung des iFix:

1. Laden Sie das Archiv mit dem vorläufigen Fix herunter und extrahieren Sie den Inhalt des Archivs in Ihrem vorhandenen Installationsordner. Dabei werden in dem Ordner vorhandene Dateien überschrieben.
2. Speichern Sie Ihre gesicherten Konfigurationsdateien zurück in die Ordner **Paketstammverzeichnis/bmx-kubernetes/usr-mfpf-server** und **Paketstammverzeichnis/bmx-kubernetes/usr-mfpf-analytics**. Dabei werden die neu installierten Konfigurationsdateien überschrieben.
3. Bearbeiten Sie die Datei **Paketstammverzeichnis/bmx-kubernetes/usr-mfpf-server/env/jvm.options** in Ihrem Editor. Wenn die folgende Zeile vorhanden ist, entfernen Sie sie:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    Jetzt können Sie einen aktualisierten Serverbuild erstellen und den Server implementieren.



    a. Führen Sie das Script `prepareserver.sh` aus, um das Server-Image neu zu erstellen und per Push-Operation zum Service "IBM Containers" zu übertragen.

    b. Führen Sie für ein schrittweises Update den folgenden Befehl aus: <code>kubectl rolling-update NAME -f DATEI</code>

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Kubernetes-Implementierungen aus IBM Cloud entfernen
{: #removing-kube-deployments}

Führen Sie die folgenden Befehle aus, um Ihre implementierten Instanzen aus dem IBM Cloud-Kubernetes-Cluster zu entfernen: 

`kubectl delete -f mfpf-deployment-all.yaml` (entfernt alle in der YAML-Datei definierten Kubernetes-Typen)

Führen Sie die folgenden Befehle aus, um einen Image-Namen aus der IBM Cloud-Registry zu entfernen: 
```bash
bx cr image-list (listet die Images in der Registry auf)
bx cr image-rm Image-Name (entfernt das Image aus der Registry)
```

## Datenbankservicekonfiguration aus IBM Cloud entfernen
{: #removing-the-database-service-configuration-from-ibmcloud }
Wenn Sie während der Konfiguration des MobileFirst-Server-Image das Script **prepareserverdbs.sh** ausgeführt haben,
werden die für {{ site.data.keys.mf_server }} erforderlichen Konfigurationen und Datenbanktabellen erstellt. Das Script erstellt auch das Datenbankschema für den Container. 

Sie können die Datenbankservicekonfiguration im IBM Cloud-Dashboard wie folgt entfernen.

1. Wählen Sie im IBM Cloud-Dashboard den von Ihnen verwendeten Service Db2 on Cloud aus. Wählen Sie den Db2-Servicenamen aus, den Sie für die Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
2. Starten Sie die Db2-Konsole, um mit den Schemata und Datenbankobjekten der ausgewählten Db2-Serviceinstanz arbeiten zu können. 
3. Wählen Sie Schemata für die Konfiguration von IBM {{ site.data.keys.mf_server }} aus. Die Schemanamen sind die, die Sie bei Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
4. Untersuchen Sie die Schemanamen und die zugehörigen Objekte gründlich, bevor Sie die einzelnen Schemata löschen. Die Datenbankkonfigurationen wurden aus IBM Cloud entfernt.
