---
layout: tutorial
title: MobileFirst Application Center mit Scripts in einem IBM Cloud-Kubernetes-Cluster einrichten
breadcrumb_title: AppCenter on Kubernetes Cluster using scripts
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
>**Hinweis:** Für die Softwareimplementierung in einem Kubernetes-Cluster sollten Sie Helm nutzen. Informieren Sie sich über die Implementierung der [Mobile Foundation in einem IBM Cloud-Kubernetes-Cluster unter Verwendung von Helm-Charts](../../mobilefirst-server-on-kubernetes-using-helm).

## Übersicht
{: #overview }
Folgen Sie den Anweisungen in diesem Abschnitt, um eine MobileFirst-Application-Center-Instanz in IBM Cloud zu konfigurieren. Gehen Sie dazu die folgenden Schritte durch: 

* Erstellen Sie einen Kubernetes-Cluster vom Typ "Standard" (bezahlter Cluster). 
* Richten Sie Ihren Host-Computer mit den erforderlichen Tools ein (Docker, Cloud-Foundry-CLI (cf), IBM Cloud-CLI (bx), CLI des Container-Service-Plug-ins für IBM Cloud (bx cs), CLI des Container-Registry-Plug-ins für IBM Cloud (bx cr), Kubernetes-CLI (kubectl)).
* Erstellen Sie ein Docker-Image des {{ site.data.keys.mf_app_center }} und stellen Sie es per Push-Operation in das IBM Cloud-Repository. 
* Abschließend werden Sie das Docker-Image in einem Kubernetes-Cluster ausführen.

>**Hinweis:**  
>
* Das Windows-Betriebssystem wird derzeit nicht für die Ausführung dieser Scripts unterstützt.  
* Die MobileFirst-Server-Konfigurationstools können nicht für die Implementierung in IBM Containern genutzt werden.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Übersicht](#overview)
        - [Fahren Sie mit folgenden Abschnitten fort: ](#jump-to)
- [Konto in IBM Cloud registrieren](#register-an-account-on-ibm-cloud)
    - [IBM Cloud-Dashboard](#ibm-cloud-dashboard)
- [Hostmaschine einrichten](#set-up-your-host-machine)
- [Kubernetes-Cluster mit dem Container-Service von IBM Cloud erstellen und einrichten](#create-and-setup-a-kubernetes-cluster-with-ibm-cloud-container-service)
- [Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen](#download-the--sitedatakeysmfbmpkgname--archive)
- [Voraussetzungen](#prerequisites)
- [{{ site.data.keys.mf_app_center }} in einem Kubernetes-Cluster mit IBM Containern einrichten](#setting-up-the--sitedatakeysmfappcenter--on-kubernetes-cluster-with-ibm-containers)
    - [Anwendung des iFix:](#steps-to-apply-the-ifix)
- [Container in IBM Cloud entfernen](#removing-the-container-from-ibm-cloud)
- [Kubernetes-Implementierungen aus IBM Cloud entfernen](#removing-the-kubernetes-deployments-from-ibm-cloud)
- [Datenbankservicekonfiguration aus IBM Cloud entfernen](#removing-the-database-service-configuration-from-ibm-cloud)

## Konto in IBM Cloud registrieren
{: #register-an-account-on-ibmcloud }
Falls Sie noch kein Konto haben, öffnen Sie die [IBM Cloud-Website](https://bluemix.net) und klicken Sie auf **Kostenloses Konto erstellen** oder auf **Anmeldung**. Sie müssen das Registrierungsformular ausfüllen, bevor Sie mit dem nächsten Schritt fortfahren können. 

### IBM Cloud-Dashboard
{: #the-ibmcloud-dashboard }
Nachdem Sie sich bei IBM Cloud angemeldet haben, wird das IBM Cloud-Dashboard angezeigt, das Ihnen einen Überblick über den aktiven IBM Cloud-Bereich gibt. Standardmäßig hat dieser Arbeitsbereich den Namen *dev*. Bei Bedarf können Sie mehrere Arbeitsbereiche erstellen. 

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
Wenn Sie das {{ site.data.keys.mf_app_center }} als Kubernetes-Cluster mit IBM Cloud-Containern einrichten möchten, müssen Sie zunächst ein Image erstellen, das später per Push-Operation in IBM Cloud übertragen wird. <br/>
Vorläufige Fixes für {{ site.data.keys.mf_server }} in IBM Containern können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.<br/>
Laden Sie den letzten vorläufigen Fix von Fix Central herunter. Ab iFix **8.0.0.0-IF201708220656** ist Kubernetes-Unterstützung verfügbar.

Die Archivdatei enthält die Dateien für die Erstellung eines Image (**dependencies** und **mfpf-libs**) sowie die Dateien für die Erstellung und Implementierung eines {{ site.data.keys.mf_app_center }} in Kubernetes (bmx-kubernetes).

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

                <h4>Dockerfile-mfp-appcenter</h4>

                <ul>
                    <li><b>Dockerfile-mfp-appcenter</b>: Textdokument mit allen Befehlen, die für das Erstellen des MobileFirst-Application-Center-Image erforderlich sind. </li>
                    <li>Ordner <b>scripts</b>: Dieser Ordner enthält den Ordner <b>args</b> mit einer Reihe von Konfigurationsdateien. Er enthält außerdem die erforderlichen Scripts für die Anmeldung bei IBM Cloud, die Erstellung eines Image für das {{ site.data.keys.mf_app_center }} und die Push-Übertragung und Ausführung des Image in IBM Cloud. Sie können diese Scripts interaktiv ausführen oder die Konfigurationsdateien wie weiter unten erläutert für die Ausführung der Scripts vorkonfigurieren. Anders als bei den anpassbaren Dateien args/*.properties dürfen Sie in diesem Ordner keine Elemente modifizieren. Verwenden Sie das Befehlszeilenargument <code>-h</code> oder <code>--help</code>, um einen Hilfetext zur Scriptsyntax abzurufen (z. B. <code>Scriptname.sh --help</code>).</li>
                    <li>Ordner <b>usr-mfp-appcenter</b>:
                        <ul>
                            <li>Ordner <b>bin</b>: Enthält die Scriptdatei (mfp-appcenter-init), die beim Start des Containers ausgeführt wird. Sie können eigenen Code hinzufügen, der ausgeführt werden soll.</li>
                            <li>Ordner <b>config</b>: Für {{ site.data.keys.mf_app_center }} verwendete Serverkonfigurationsfragmente (Keystore, Servereigenschaften, Benutzerregistry)</li>
                            <li><b>keystore.xml</b>: Konfiguration des Repositorys mit Sicherheitszertifikaten für die SSL-Verschlüsselung. Im Ordner ./usr/security muss auf die aufgelisteten Dateien verwiesen werden.</li>
                            <li><b>ltpa.xml</b>: Konfigurationsdatei mit der Definition des LTPA-Schlüssels und des zugehörigen Kennworts </li>
                            <li><b>appcentersqldb.xml</b>: JDBC-Datenquellendefinition für die Verbindung zur Db2- oder dashDB-Datenbank</li>
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
                                            <td>APPCENTER_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>Port für Client-HTTP-Anforderungen. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>Port für Client-HTTP-Anforderungen, die mit SSL (HTTPS) geschützt werden. Mit -1 können Sie diesen Port inaktivieren.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ROOT	</td>
                                            <td>applicationcenter</td>
                                            <td>Kontextstammverzeichnis, in dem die Verwaltungsservices für das {{ site.data.keys.mf_app_center }} verfügbar gemacht werden</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_CONSOLE_ROOT	</td>
                                            <td>appcenterconsole</td>
                                            <td>Kontextstammverzeichnis, in dem die MobileFirst-Application-Center-Konsole verfügbar gemacht wird</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ADMIN_GROUP</td>
                                            <td>appcenteradmingroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>appcenteradmin</code> zugeordnet ist</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_USER_GROUP	</td>
                                            <td>appcenterusergroup</td>
                                            <td>Name der Benutzergruppe, der die vordefinierte Rolle <code>appcenteruser</code> zugeordnet ist</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Abschnitt schließen</b></a>
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


## {{ site.data.keys.mf_app_center }} in einem Kubernetes-Cluster mit IBM Containern einrichten
{: #setting-up-the-mobilefirst-appcenter-on-kube-with-ibm-containers }
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
                <h4>prepareappcenterdbs.properties</h4>
                Das {{ site.data.keys.mf_app_center }} erfordert eine externe Instanz von <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>Db2 on Cloud</i></a>. <br/>
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
                      <ul><li><b>APPCENTER_DB_SRV_NAME</b> - Name Ihrer dashDB-Serviceinstanz für das Speichern von Application-Center-Daten</li>
                      </ul>
                    </li>
                    <li><b>APPCENTER_SCHEMA_NAME</b> - Name Ihres Schemas für Application-Center-Daten. Der Standardwert ist <i>APPCNTR</i>.</li>
                    <blockquote><b>Hinweis:</b> Wenn Ihr Db2-Datenbankservice von vielen Benutzern oder mehreren MobileFirst-Application-Center-Implementierungen gemeinsam genutzt wird, stellen Sie sicher, dass eindeutige Schemanamen angegeben werden. </blockquote>
                </ul><br/>
                <h4>prepareappcenter.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/image:tag</em> haben.</li>
                  <blockquote>Beispiel: <em>registry.ng.bluemix.net/myuniquenamespace/myappcenter:v1</em><br/>Wenn Sie noch keinen Docker-Registry-Namespace erstellt haben, erstellen Sie ihn mit einem der folgenden Befehle: <br/>
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
Führen Sie das Script <b>initenv.sh</b> aus, um eine Umgebung für die Erstellung und Ausführung der {{ site.data.keys.mf_app_center }} in IBM Containern zu erstellen:
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareappcenterdbs.sh - Erstellung der MobileFirst-Application-Center-Datenbank</b><br />
                    Das Script <b>prepareappcenterdbs.sh</b> wird verwendet, um Ihren {{ site.data.keys.mf_app_center }} mit dem Db2-Datenbankservice zu konfigurieren. Die Instanz des Db2-Service muss in der Organisation und in dem Bereich verfügbar sein, für die Sie sich in Schritt 1 angemeldet haben.
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./prepareappcenterdbs.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                      Dieser Schritt ist nur erforderlich, wenn Sie Ihre Container in einer Organisation und einem Breich ohne verfügbare Db2-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei initenv.properties mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

</li>
                <li><b>prepareappcenter.sh - Erstellung eines MobileFirst-Application-Center-Image</b><br />
                    Führen Sie das Script <b>prepareappcenter.sh</b> aus, um das MobileFirst-Application-Center-Image zu erstellen und per Push-Operation in Ihr IBM Cloud-Repository zu stellen. Wenn Sie alle verfügbaren Images in Ihrem IBM Cloud-Repository anzeigen möchten, führen Sie <code>bx cr image-list</code> aus. <br/>
                    Die Liste enthält den Image-Namen, das Erstellungsdatum und die ID.<br/>
                    <b>Interaktiver Modus</b>
{% highlight bash %}
./prepareappcenter.sh
{% endhighlight %}
                    <b>Nicht interaktiver Modus</b>
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}
                </li>
                <li>Implementieren Sie das {{ site.data.keys.mf_app_center }} in Docker-Containern eines Kubernetes-Clusters mit dem Container-Service von IBM Cloud.
                <ol>
                  <li>Legen Sie Ihren Cluster als Terminalkontext fest: <br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  Führen Sie den folgenden Befehl aus, um Ihren Clusternamen zu erfahren: <br/><code>bx cs clusters</code><br/>
                  In der Ausgabe wird der Pfad zu Ihrer Konfigurationsdatei als Befehl zum Definieren einer Umgebungsvariablen angezeigt. Beispiel: <br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  Kopieren Sie den obigen Befehl. Ersetzen Sie <em>my-cluster</em> durch Ihren Clusternamen und fügen Sie den Befehl dann ein, um die Umgebungsvariable für Ihr Terminal festzulegen. Drücken Sie abschließend die <b>Eingabetaste</b>.
                  </li>
                  <li>Führen Sie den folgenden Befehl aus, um Ihre <b>Ingress Domain</b> (Zugangsdomäne) abzurufen: <br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   Notieren Sie Ihre Zugangsdomäne. Wenn Sie TLS konfigurieren müssen, notieren Sie den geheimen Zugangsschlüssel (<b>Ingress Secret</b>).</li>
                  <li>Erstellen Sie die Kubernetes-Implementierungen. <br/>Bearbeiten Sie die yaml-Datei <b>args/mfp-deployment-appcenter.yaml</b>. Tragen Sie alle Details ein. Alle Variablen müssen vor Ausführung des Befehls <em>kubectl</em> durch die entsprechenden Werte ersetzt werden. <br/>
                  <b>./args/mfp-deployment-appcenter.yaml</b> enthält die Implementierung für Folgendes:
                  <ul>
                    <li>Kubernetes-Implementierung für das {{ site.data.keys.mf_app_center }}, bestehend aus einer Instanz (1 Replikat), mit einem Hauptspeicher von 1024 MB und einer CPU mit einem Kern </li>
                    <li>Kubernetes-Service für {{ site.data.keys.mf_app_center }}</li>
                    <li>Zugang für das gesamte Setup mit allen REST-Endpunkten für das {{ site.data.keys.mf_app_center }}</li>
                    <li>Konfigurationsübersicht (configMap), um die Umgebungsvariablen in der MobileFirst-Application-Center-Instanz verfügbar zu machen</li>
                  </ul>
                  In der YAML-Datei müssen folgende Werte bearbeitet werden: <br/>
                    <ol><li>Verschiedene Vorkommen von <em>my-cluster.us-south.containers.mybluemix.net</em> mit der vom obigen Befehl <code>bx cs cluster-get</code> ausgegebenen Zugangsdomäne (<b>Ingress Domain</b>)</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpappcenter:latest</em> - Verwenden Sie zum Hochladen des Image die gleichen Namen wie in prepareappcenter.sh. </li>
                    </ol>
                    Führen Sie den folgenden Befehl aus: <br/>
                    <code>kubectl create -f ./args/mfp-deployment-appcenter.yaml</code>
                    <blockquote><b>Hinweis:<br/></b>Folgende YAML-Schablonendateien werden bereitgestellt:<br/>
                    <ul><li><b>mfp-deployment-appcenter.yaml</b>: Implementiert das {{ site.data.keys.mf_app_center }} mit HTTP. </li>
                      <li><b>mfp-deployment-appcenter-with-tls.yaml</b>: Implementiert das {{ site.data.keys.mf_app_center }} mit HTTPS. </li>
                    </ul></blockquote>
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
<!--
## Applying {{ site.data.keys.mf_server }} Fixes
{: #applying-mobilefirst-server-fixes }

Interim fixes for the {{ site.data.keys.mf_server }} on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the the following folders:
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/bmx-kubernetes/usr-mfpf-server**

### Steps to apply the iFix:

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **package_root/bmx-kubernetes/usr-mfpf-server** and **package_root/bmx-kubernetes/usr-mfpf-analytics** folders, overwriting the newly installed configuration files.
3. Edit **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** file in your editor and remove the following line, if it exists:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    You can now build and deploy the updated server.

    a. Run the `prepareserver.sh` script to rebuild the server image and push it to the IBM Containers service.

    b. Perform a rolling update by running the following command:
      <code>kubectl rolling-update NAME -f FILE</code>
-->
<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Container in IBM Cloud entfernen
{: #removing-the-container-from-ibmcloud }
Wenn Sie in IBM Cloud einen Container entfernen, müssen Sie auch den Image-Namen aus der Registry entfernen.   
Führen Sie die folgenden Befehle aus, um einen Container in IBM Cloud zu entfernen: 

1. `cf ic ps` (Listet die zurzeit aktiven Container auf) 
2. `cf ic stop container_id` (Stoppt den Container)
3. `cf ic rm container_id` (Entfernt den Container)

Führen Sie die folgenden cf ic-Befehle aus, um einen Image-Namen aus der IBM Cloud-Registry zu entfernen: 

1. `cf ic images` (Listet die Images in der Registry auf)
2. `cf ic rmi image_id` (Entfernt ein Image aus der Registry)

## Kubernetes-Implementierungen aus IBM Cloud entfernen
{: #removing-kube-deployments}

Führen Sie die folgenden Befehle aus, um Ihre implementierten Instanzen aus dem IBM Cloud-Kubernetes-Cluster zu entfernen: 

`kubectl delete -f mfp-deployment-appcenter.yaml` (entfernt alle in der YAML-Datei definierten Kubernetes-Typen)

Führen Sie die folgenden Befehle aus, um einen Image-Namen aus der IBM Cloud-Registry zu entfernen: 
```bash
bx cr image-list (listet die Images in der Registry auf)
bx cr image-rm Image-Name (entfernt das Image aus der Registry)
```

## Datenbankservicekonfiguration aus IBM Cloud entfernen
{: #removing-the-database-service-configuration-from-ibmcloud }
Wenn Sie während der Konfiguration des MobileFirst-Application-Center-Image das Script **prepareappcenterdbs.sh** ausgeführt haben, werden die für das {{ site.data.keys.mf_app_center }} erforderlichen Konfigurationen und Datenbanktabellen erstellt. Das Script erstellt auch das Datenbankschema für den Container. 

Sie können die Datenbankservicekonfiguration im IBM Cloud-Dashboard wie folgt entfernen.

1. Wählen Sie im IBM Cloud-Dashboard den von Ihnen verwendeten Service Db2 on Cloud aus. Wählen Sie den Db2-Servicenamen aus, den Sie für die Ausführung des Scripts **prepareappcenterdbs.sh** als Parameter angegeben haben. 
2. Starten Sie die Db2-Konsole, um mit den Schemata und Datenbankobjekten der ausgewählten Db2-Serviceinstanz arbeiten zu können. 
3. Wählen Sie Schemata für die Konfiguration von IBM {{ site.data.keys.mf_server }} aus. Die Schemanamen sind die, die Sie bei Ausführung des Scripts **prepareappcenterdbs.sh** als Parameter angegeben haben. 
4. Untersuchen Sie die Schemanamen und die zugehörigen Objekte gründlich, bevor Sie die einzelnen Schemata löschen. Die Datenbankkonfigurationen wurden aus IBM Cloud entfernt.
