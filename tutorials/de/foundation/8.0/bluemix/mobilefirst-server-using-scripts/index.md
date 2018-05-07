---
layout: redirect
new_url: /404/
#layout: tutorial
#title: Setting Up MobileFirst Server on IBM Cloud using Scripts for IBM Containers
#breadcrumb_title: IBM Containers
#relevantTo: [ios,android,windows,javascript]
#weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um eine MobileFirst-Server-Instanz und eine Instanz von {{ site.data.keys.mf_analytics }} für IBM Cloud zu konfigurieren. Gehen Sie dazu die folgenden Schritte durch: 

* Statten Sie Ihren Host-Computer mit den erforderlichen Tools aus (Cloud-Foundry-CLI, Docker und Plug-in "IBM Containers Extension" (cf ic)). 
* Richten Sie Ihr IBM Cloud-Konto ein.
* Erstellen Sie ein MobileFirst-Server-Image und stellen Sie es per Push-Operation in das IBM Cloud-Repository. 

Abschließend werden Sie das Image als Einzelcontainer oder Containergruppe in IBM Containern ausführen und Ihre Anwendung registrieren sowie Ihre Adapter implementieren. 

**Hinweise:**  

* Das Windows-Betriebssystem wird derzeit nicht für die Ausführung dieser Scripts unterstützt.   
* Die MobileFirst-Server-Konfigurationstools können nicht für die Implementierung in IBM Containern genutzt werden. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Konto in IBM Cloud registrieren](#register-an-account-at-bluemix)
* [Hostmaschine einrichten](#set-up-your-host-machine)
* [Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen](#download-the-ibm-mfpf-container-8000-archive)
* [Voraussetzungen](#prerequisites)
* [{{ site.data.keys.product_adj }} Server und Analytics Server in IBM Containern einrichten](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [Fixes für {{ site.data.keys.mf_server }} anwenden](#applying-mobilefirst-server-fixes)
* [Container in IBM Cloud entfernen](#removing-a-container-from-bluemix)
* [Datenbankservicekonfiguration aus IBM Cloud entfernen](#removing-the-database-service-configuration-from-bluemix)

## Konto in IBM Cloud registrieren
{: #register-an-account-at-bluemix }
Falls Sie noch kein Konto haben, öffnen Sie die [IBM Cloud-Website](https://bluemix.net) und klicken Sie auf **Kostenloses Konto erstellen** oder auf **Anmeldung**. Sie müssen das Registrierungsformular ausfüllen, bevor Sie mit dem nächsten Schritt fortfahren können. 

### IBM Cloud-Dashboard
{: #the-bluemix-dashboard }
Nachdem Sie sich bei IBM Cloud angemeldet haben, wird das IBM Cloud-Dashboard angezeigt, das Ihnen einen Überblick über den aktiven IBM Cloud-Bereich gibt. Standardmäßig hat dieser Arbeitsbereich den Namen "dev". Bei Bedarf können Sie mehrere Arbeitsbereiche erstellen. 

## Hostmaschine einrichten
{: #set-up-your-host-machine }
Für die Verwaltung von Containern und Images müssen Sie die folgenden Tools installieren: Docker, die Cloud-Foundry-CLI und das IBM Container-Plug-in (cf ic). 

### Docker
{: #docker }
Wählen Sie auf der Seite [Docker Documentation](https://docs.docker.com/) im linken Menü **Docker Engine → Install** aus. Wählen Sie Ihren Betriebssystemtyp aus und folgen Sie den Anweisungen für die Installation der Docker Toolbox.

**Hinweis:** IBM bietet keine Unterstützung für Docker Kitematic.

Unter macOS gibt es zwei Optionen für die Ausführung von Docker-Befehlen: 

* macOS-Terminal.app: Die App reicht zum Arbeiten aus. Ein weiteres Setup ist nicht erforderlich. 
* Docker Quickstart Terminal: Gehen Sie wie nachfolgend beschrieben vor: 

* Führen Sie den folgenden Befehl aus: 

  ```bash
  docker-machine env default
  ```

* Definieren Sie das Ergebnis in Form von Umgebungsvariablen. Beispiel:

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> Weitere Informationen entnehmen Sie bitte der Docker-Dokumentation.

### Cloud-Foundry-Plug-in und IBM Container-Plug-in
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. Installieren Sie die [Cloud-Foundry-CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).
2. Installieren Sie das [IBM Container-Plug-in (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html).

## Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen
{: #download-the-ibm-mfpf-container-8000-archive}
Wenn Sie die {{ site.data.keys.product }} in IBM Containern einrichten möchten, müssen Sie zunächst ein Image erstellen, das später per Push-Operation in IBM Cloud übertragen wird.   
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Folgen Sie den Anweisungen auf dieser Seite</a>, um das Archiv mit {{ site.data.keys.mf_server }} für IBM Container (ZIP-Datei) herunterzuladen (suchen Sie nach *CNBL0EN*).



Die Archivdatei enthält die Dateien für die Erstellung eines Image (**dependencies** und **mfpf-libs**), die Dateien für die Erstellung und Implementierung eines Containers mit {{ site.data.keys.mf_analytics }} (**mfpf-analytics**) und Dateien zum Konfigurieren eines MobileFirst-Server-Containers (**mfpf-server**).

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>Für mehr Informationen zum Inhalt der Archivdatei und zu den verfügbaren Umgebungseigenschaften hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Dateisystemstruktur der Archivdatei" style="float:right;width:570px"/>
                <h4>Ordner 'dependencies'</h4>
                <p>Enthält die Laufzeit der {{ site.data.keys.product }} und IBM Java JRE 8</p>

                <h4>Ordner 'mfpf-libs'</h4>
                <p>Enthält die Bibliotheken für die {{ site.data.keys.product_adj }}-Produktkomponenten und die CLI</p>

                <h4>Ordner 'mfpf-server' und 'mfpf-analytics'</h4>

                <ul>
                    <li><b>Dockerfile</b>: Textdokument mit allen Befehlen, die für das Erstellen eines Image erforderlich sind. </li>
                    <li>Ordner <b>scripts</b>: Dieser Ordner enthält den Ordner <b>args</b> mit einer Reihe von Konfigurationsdateien. Er enthält außerdem die Scripts für die Anmeldung bei IBM Cloud, die Erstellung eines Image für {{ site.data.keys.mf_server }} bzw. {{ site.data.keys.mf_analytics }} und die Push-Übertragung und Ausführung des Image in IBM Cloud. Sie können diese Scripts interaktiv ausführen oder die Konfigurationsdateien wie nachfolgend erläutert für die Ausführung der Scripts vorkonfigurieren. Anders als bei den anpassbaren Dateien args/*.properties dürfen Sie in diesem Ordner keine Elemente modifizieren. Verwenden Sie das Befehlszeilenargument <code>-h</code> oder <code>--help</code>, um einen Hilfetext zur Scriptsyntax abzurufen (z. B. <code>Scriptname.sh --help</code>).</li>
                    <li>Ordner <b>usr</b>:
                        <ul>
                            <li>Ordner <b>bin</b>: Enthält die Scriptdatei, die beim Start des Containers ausgeführt wird. Sie können eigenen Code hinzufügen, der ausgeführt werden soll.</li>
                            <li>Ordner <b>config</b>: Für {{ site.data.keys.mf_server }} bzw. {{ site.data.keys.mf_analytics }} verwendete Serverkonfigurationsfragmente (Keystore, Servereigenschaften, Benutzerregistry)</li>
                            <li><b>keystore.xml</b>: Konfiguration des Repositorys mit Sicherheitszertifikaten für die SSL-Verschlüsselung. Im Ordner ./usr/security muss auf die aufgelisteten Dateien verwiesen werden.</li>
                            <li><b>mfpfproperties.xml</b> - Konfigurationseigenschaften für {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }}. Informieren Sie sich anhand der folgenden Dokumentationsabschnitte über die unterstützten Eigenschaften:<ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Sever-Verwaltungsservice</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b>: Benutzerregistrykonfiguration. Als Standardkonfiguration wird eine auf XML basierende Basisbenutzerregistrykonfiguration (basicRegistry) bereitgestellt. Sie können Namen und Kennwörter für basicRegistry konfigurieren oder ldapRegistry konfigurieren.</li>
                        </ul>
                    </li>
                    <li>Ordner <b>env</b>: Enthält die Umgebungseigenschaften für die Serverinitialisierung (server.env) sowie angepasste JVM-Optionen (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology-server-env" role="tablist">
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
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>Es ist keine Konfiguration erforderlich. Gültige Werte sind <code>Standalone</code> und <code>Farm</code>. Der Wert <code>Farm</code> wird automatisch gesetzt, wenn der Container in einer Containergruppe ausgeführt wird.</td>
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
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>Administrator</td>
                                            <td>Benutzername für die Administratorrolle für MobileFirst-Server-Operationen</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD	</td>
                                            <td>Administrator</td>
                                            <td>Kennwort für die Administratorrolle für MobileFirst-Server-Operationen</td>
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


                    </li>
                    <li>Ordner <b>jre-security</b>: Sie können die sicherheitsrelevanten JRE-Dateien (Truststore, JAR-Richtliniendateien usw.) aktualisieren, indem Sie sie in diesen Ordner stellen. Die Dateien aus diesem Ordner werden in den Ordner JAVA_HOME/jre/lib/security/ des Containers kopiert.</li>
                    <li>Ordner <b>security</b>: Wird verwendet, um die Keystore-Datei, die Truststore-Datei und die LTPA-Schlüsseldatei (ltpa.keys) zu speichern.</li>
                    <li>Ordner <b>ssh</b>: Wird verwendet, um die Datei mit dem öffentlichen SSH-Schlüssel (id_rsa.pub), die den SSH-Zugriff auf den Container ermöglicht, zu speichern.</li>
                    <li>Ordner <b>wxs</b> (nur für {{ site.data.keys.mf_server }}): Enthält die Datencache- bzw. eXtreme-Scale-Clientbibliothek, wenn für den Server der Datencache als Attribut-Store verwendet wird.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

## Voraussetzungen
{: #prerequisites }
Die folgenden Schritte sind obligatorisch. Im folgenden Abschnitt werden Sie Befehle des Service "IBM Containers" ausführen. 

1. Melden Sie sich bei der IBM Cloud-Umgebung an.   

    Führen Sie `cf login` aus.  
    Machen Sie die folgenden Angaben, wenn Sie dazu aufgefordert werden: 
      * IBM Cloud-API-Endpunkt
      * E-Mail-Adresse
      * Kennwort
      * Organisation, falls es mehrere gibt
      * Bereich, falls es mehrere gibt

2. Für die Ausführung von Befehlen des Service "IBM Containers" müssen Sie sich zunöchst beim Cloud-Service für IBM Container anmelden.
  
Führen Sie `cf ic login` aus.

3. Stellen Sie sicher, dass der `namespace` für die Container-Registry definiert ist. Der `namespace` gibt einen eindeutigen Namen für Ihr privates Repository in der IBM Cloud-Registry an. Der Namespace wird einer Organisation einmal zugeordnet und kann nicht geändert werden. Beachten Sie bei der Auswahl des Namespace die folgenden Regeln: 
     * Der Name darf nur aus Kleinbuchstaben, Zahlen und Unterstreichungszeichen bestehen. 
     * Der Name kann 4 bis 30 Zeichen umfassen. Wenn Sie Container über die Befehlszeile verwalten möchten, sollten Sie dem Namensbereich einen kurzen Namen zuordnen, der schnell eingegeben werden kann.
     * Innerhalb der IBM Cloud-Registry muss der Name eindeutig sein. 

    Führen Sie zum Definieren eines Namespace den Befehl `cf ic namespace set <neuer_Name>` aus.  
    Wenn Sie einen bereits definierten Namespace abrufen möchten, führen Sie den Befehl `cf ic namespace get` aus.

> Weitere Informationen zu IC-Befehlen können Sie über den Befehl `ic help` abrufen. 

## {{ site.data.keys.product_adj }} Server, Analytics Server und {{ site.data.keys.mf_app_center_short }} in IBM Containern einrichten
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
Wie bereits erläutert, können Sie die Scripts interaktiv oder unter Verwendung der Konfigurationsdateien ausführen. 

* Verwendung der Konfigurationsdateien: Führen Sie die Scripts aus und übergeben Sie die entsprechende Konfigurationsdatei als Argument. 
* Interaktiv: Führen Sie die Scripts ohne Argumente aus. 

**Hinweis:** Wenn Sie sich entschließen, die Scripts interaktiv auszuführen, können Sie die Konfiguration übergehen. Wir empfehlen Ihnen jedoch, sich wenigstens mit den Argumenten, die angegeben werden müssen, zu beschäftigen. 


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }
Wenn Sie das {{ site.data.keys.mf_app_center }} verwenden möchten, beginnen Sie hier. 

>**Hinweis:** Sie können Installationsprogramme und Datenbanktools aus den lokalen Installationsordnern des {{ site.data.keys.mf_app_center }} (`installer` und `tools`) herunterladen.



<div class="panel-group accordion" id="scripts" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1appcenter" aria-expanded="false" aria-controls="collapseStep1appcenter">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapseStep1appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Tragen Sie die Argumentwerte in den folgenden Dateien ein.<br/>
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Ihr IBM Cloud-Benutzername (E-Mail-Adresse) </li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Ihr IBM Cloud-Kennwort</li>
                  <li><b>IBM_CLOUD_ORG - </b>Ihr IBM Cloud-Organisationsname</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Ihr IBM Cloud-Bereich (wie oben erläutert)</li>
              </ul>
              <h4>prepareappcenterdbs.properties</h4>
              Das {{ site.data.keys.mf_app_center }} erfordert eine externe <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="_blank">Instanz der dashDB-Enterprise-Transactional-Datenbank</a> (Enterprise Transactional 2.8.500 oder Enterprise Transactional 12.128.1400).
              <blockquote><p><b>Hinweis:</b> Die Implementierung der dashDB-Enterprise-Transactional-Pläne erfolgt unter Umständen nicht sofort. Es kann sein, dass das Vertriebsteam vorher Kontakt mit Ihnen aufnimmt. </p></blockquote>

              Wenn Sie Ihre dashDB-Instanz eingerichtet haben, geben Sie die folgenden erforderlichen Argumente an:
              <ul>
                  <li><b>APPCENTER_DB_SRV_NAME - </b>Name Ihrer dashDB-Serviceinstanz für das Speichern von Application-Center-Daten</li>
                  <li><b>APPCENTER_SCHEMA_NAME - </b>Name Ihres Datenbankschmeas für das Speichern von Application-Center-Daten</li>
                  <blockquote><b>Hinweis:</b> Wenn Ihre dashDB-Serviceinstanz von mehreren Benutzern gemeinsam genutzt wird, stellen Sie sicher, dass eindeutige Schemanamen angegeben werden.</blockquote>

              </ul>
              <h4>prepareappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/your-tag</em> haben.</li>
              </ul>
              <h4>startappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Wie in <em>prepareappcenter.sh</em></li>
                  <li><b>SERVER_CONTAINER_NAME - </b>Name für Ihren IBM Cloud-Container</li>
                  <li><b>SERVER_IP - </b>IP-Adresse, an die der IBM Cloud-Container gebunden werden soll</li>
                  <blockquote>                    Führen Sie zum Zuweisen einer IP-Adresse <code>cf ic ip request</code> aus. IP-Adressen können in mehreren Containern eines gegebenen IBM Cloud-Bereichs wiederverwendet werden.
                  Wenn Sie bereits eine IP-Adresse zugewiesen haben, können Sie <code>cf ic ip list</code> ausführen.</blockquote>
              </ul>
              <h4>startappcentergroup.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Wie in <em>prepareappcenter.sh</em></li>
                  <li><b>SERVER_CONTAINER_GROUP_NAME - </b>Name für Ihre IBM Cloud-Containergruppe</li>
                  <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Ihr Hostname</li>
                  <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>Ihr Domänenname. Der Standardwert ist <code>mybluemix.net</code>.</li>
              </ul>    
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="appcenterstep2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2appcenter" aria-expanded="false" aria-controls="collapseStep2appcenter">Scripts ausführen</a>
            </h4>
        </div>

        <div id="collapseStep2appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten, die Sie für die Ausführung in einem nicht interaktiven Modus auswählen sollten, wird ebenfalls bereitgestellt. </p>
                <ol>
                    <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
Führen Sie das Script <b>initenv.sh</b> aus, um eine Umgebung für die Erstellung und Ausführung von {{ site.data.keys.product }} in IBM Containern zu erstellen:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                        <div class="panel-group accordion" id="terminology-appcenter-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud-Benutzer-ID oder E-Mail-Adresse</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud-Kennwort</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud-Organisationsname</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud-Bereichsname</td>
                                            </tr>
                                            <tr>
                                                <td>[-a|--api] IBM_CLOUD_API_URL (optional)</td>
                                                <td>IBM Cloud-API-Endpunkt. (Standardwert ist https://api.ng.bluemix.net.)</td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
initenv.sh --user IBM_Cloud-Benutzer-ID --password IBM_Cloud-Kennwort --org IBM_Cloud-Organisationsname --space IBM_Cloud-Bereichsname
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareappcenterdbs.sh - Erstellung der MobileFirst-Application-Center-Datenbank</b><br/>
                    Das Script <b>prepareappcenterdbs.sh</b> wird verwendet, um Ihren {{ site.data.keys.mf_app_center }} mit dem dashDB-Datenbankservice zu konfigurieren. Die Instanz des dashDB-Service muss in der Organisation und dem Bereich verfügbar sein, bei denen Sie sich in Schritt 1 angemeldet haben. Führen Sie Folgendes aus: 

{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenterdbs" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenterdbs">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenterdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenterdbs">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Befehlszeilenargument</b></td>
                                              <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-db | --acdb ] NAME_DES_APPLICATION-CENTER-DATENBANKSERVERS</td>
                                              <td>IBM Cloud-dashDB-Service (mit dem IBM Cloud-Serviceplan Enterprise Transactional)</td>
                                            </tr>    
                                            <tr>
                                              <td>Optional: [-ds | --acds ] NAME-DES-APPLICATION-CENTER-SCHEMAS</td>
                                              <td>Name des Datenbankschemas für den Application-Center-Sservice. Standardwert: <i>APPCNTR</i>.</td>
                                            </tr>    
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
prepareappcenterdbs.sh --acdb AppCenterDashDBService
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Abschnitt schließen</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                    Dieser Schritt ist nur erforderlich, wenn Sie Ihre Container in einer Organisation und einem Breich ohne verfügbare dashDB-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei <b>initenv.properties</b> mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus: </li>

{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}


                    <li><b>prepareappcenter.sh - Erstellung eines MobileFirst-Application-Center-Image</b><br />
                    Führen Sie das Script <b>prepareappcenter.sh</b> aus, um ein MobileFirst-Application-Center-Image zu erstellen und per Push-Operation in Ihr IBM Cloud-Repository zu stellen. Wenn Sie alle verfügbaren Images in Ihrem IBM Cloud-Repository anzeigen möchten, führen Sie <code>cf ic images</code> aus.
                    Die Liste enthält den Image-Namen, das Erstellungsdatum und die ID. 

Führen Sie Folgendes aus:
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                                <td>Name, der für das angepasste MobileFirst-Application-Center-Image verwendet werden soll. Format: <em>Registry-URL/Namespace/Image-Name</em></td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
prepareappcenter.sh --tag NAME_DES_SERVER-IMAGE registryUrl/namespace/imagename
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcenter.sh - Ausführung des Image in einem IBM Container</b><br/>
                    Mit dem Script <b>startappcenter.sh</b> wird das MobileFirst-Application-Center-Image in einem IBM Container ausgeführt. Außerdem bindet das Script Ihr Image an die öffentliche IP-Adresse, die Sie mit der Eigenschaft <b>SERVER_IP</b> konfiguriert haben. 

Führen Sie Folgendes aus:
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Name des MobileFirst-Application-Center-Image</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] SERVER_IP	</td>
                                                <td>IP-Adresse, an die der MobileFirst-Application-Center-Container gebunden werden soll. (Sie können eine verfügbare öffentliche IP-Adresse angeben oder mit dem Befehl <code>cf ic ip request</code> eine IP-Adresse anfordern.)</td>
                                            </tr>
                                            <tr>
                                                <td>[-si|--services] SERVICE_INSTANCES (optional)</td>
                                                <td>Jeweils durch ein Komma getrennte IBM Cloud-Serviceinstanzen, die an den Container gebunden werden sollen </td>
                                            </tr>
                                            <tr>
                                                <td>[-h|--http] EXPOSE_HTTP (optional)</td>
                                                <td>Offenlegung des HTTP-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--https] EXPOSE_HTTPS (optional)</td>
                                                <td>Offenlegung des HTTPS-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-m|--memory] SERVER_MEM (optional)</td>
                                                <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-se|--ssh] SSH_ENABLE (optional)</td>
                                                <td>Aktivierung von SSH für den Container. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-sk|--sshkey] SSH_KEY (optional)</td>
                                                <td>SSH-Schlüssel, der in den Container injiziert werden soll. (Geben Sie den Inhalt Ihrer Datei id_rsa.pub an.) </td>
                                            </tr>
                                            <tr>
                                                <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                                <td>Anzuwendende Tracespezifikation. Standardwert: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>[-ml|--maxlog] MAX_LOG_FILES (optional)</td>
                                                <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                                <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>

                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
startappcenter.sh --tag Image-Tagname --name Containername --ip Container-IP-Adresse
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcentergroup.sh - Ausführung des Image in einer IBM Containergruppe</b><br/>
                    Das Script <b>startappcentergroup.sh</b> wird verwendet, um das MobileFirst-Application-Center-Image in einer IBM Containergruppe auszuführen. Außerdem bindet das Script Ihr Image an den Hostnamen, den Sie mit der Eigenschaft <b>SERVER_CONTAINER_GROUP_HOST</b> konfiguriert haben. 

Führen Sie Folgendes aus:
{% highlight bash %}
./startappcentergroup.sh args/startappcentergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcentergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcentergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcentergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcentergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Name des MobileFirst-Application-Center-Container-Image in der IBM Cloud-Registry</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>Name der MobileFirst-Application-Center-Containergruppe</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>Hostname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN </td>
                                                <td>Domänenname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gm|--min] SERVERS_CONTAINER_GROUP_MIN (optional)</td>
                                                <td>Mindestanzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gx|--max] SERVER_CONTAINER_GROUP_MAX (optional)</td>
                                                <td>Maximale Anzahl Containerinstanzen. Der Standardwert ist 2.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED (optional)</td>
                                                <td>Gewünschte Anzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-a|--auto] ENABLE_AUTORECOVERY (optional)</td>
                                                <td>Aktivieren der automatischen Wiederherstellungsoption für die Containerinstanzen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>
                                            <tr>
                                                <td>[-si|--services] SERVICES (optional)</td>
                                                <td>Jeweils durch ein Komma getrennte Namen von IBM Cloud-Serviceinstanzen, die an den Container gebunden werden sollen </td>
                                            </tr>
                                            <tr>
                                                <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                                <td>Anzuwendende Tracespezifikation. Standardwert: </code>*=info</code>.</td>
                                            </tr>
                                            <tr>
                                                <td>[-ml|--maxlog] MAX_LOG_FILESC (optional)</td>
                                                <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                                <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-m|--memory] SERVER_MEM (optional)</td>
                                                <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>

                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
startappcentergroup.sh --tag Image-Name --name Containergruppenname --host Hostname_der_Containergruppe --domain Domänenname_der_Containergruppe
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
Wenn Sie Analytics zusammen mit Ihrem {{ site.data.keys.mf_server }} verwenden möchten, beginnen Sie hier. 

<div class="panel-group accordion" id="scripts-analytics" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1-analytics">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Tragen Sie die Argumentwerte in den folgenden Dateien ein.<br/>
            <b>Hinweis:</b> Hier sind nur die erforderlichen Argumente aufgeführt. Wenn Sie etwas zu den übrigen Argumenten erfahren möchten, sehen Sie sich die Dokumentation in den Eigenschaftendateien an.
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Ihr IBM Cloud-Benutzername (E-Mail-Adresse) </li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Ihr IBM Cloud-Kennwort</li>
                  <li><b>IBM_CLOUD_ORG - </b>Ihr IBM Cloud-Organisationsname</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Ihr IBM Cloud-Bereich (wie oben erläutert)</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/your-tag</em> haben.</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Wie in <em>prepareserver.sh</em></li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>Name für Ihren IBM Cloud-Container</li>
                  <li><b>ANALYTICS_IP - </b>IP-Adresse, an die der IBM Cloud-Container gebunden werden soll<br/>
                  Führen Sie zum Zuweisen einer IP-Adresse <code>cf ic ip request</code> aus.<br/>
                  IP-Adressen können in mehreren Containern eines Bereichs wiederverwendet werden. <br/>
                  Wenn Sie bereits eine Adresse zugewiesen haben, können Sie <code>cf ic ip list</code> ausführen.</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Wie in <em>prepareserver.sh</em></li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>Name für Ihre IBM Cloud-Containergruppe</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>Ihr Hostname</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>Ihr Domänenname. Der Standardwert ist <code>mybluemix.net</code>.</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">Scripts ausführen</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten, die Sie für die Ausführung in einem nicht interaktiven Modus auswählen sollten, wird ebenfalls bereitgestellt. </p>
                <ol>
                    <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
Führen Sie das Script <b>initenv.sh</b> aus, um eine Umgebung für die Erstellung und Ausführung von {{ site.data.keys.mf_analytics }} in IBM Containern zu erstellen:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                        <div class="panel-group accordion" id="terminology-analytics-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud-Benutzer-ID oder E-Mail-Adresse</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud-Kennwort</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud-Organisationsname</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud-Bereichsname</td>
                                            </tr>
                                            <tr>
                                                <td>[-a|--api] IBM_CLOUD_API_URL (optional)</td>
                                                <td>IBM Cloud-API-Endpunkt. (Standardwert ist https://api.ng.bluemix.net.)</td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
initenv.sh --user IBM_Cloud-Benutzer-ID --password IBM_Cloud-Kennwort --org IBM_Cloud-Organisationsname --space IBM_Cloud-Bereichsname
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - Erstellung eines MobileFirst-Analytics-Image</b><br />
                        Führen Sie das Script <b>prepareanalytics.sh</b> aus, um ein MobileFirst-Analytics-Image zu erstellen und per Push-Operation in Ihr IBM Cloud-Repository zu übertragen. 

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        Wenn Sie alle verfügbaren Images in Ihrem IBM Cloud-Repository anzeigen möchten, führen Sie <code>cf ic images</code> aus. <br/>
                    Die Liste enthält den Image-Namen, das Erstellungsdatum und die ID.

                        <div class="panel-group accordion" id="terminology-analytics-prepareanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Befehlszeilenargument</b></td>
                                              <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>Name, der für das angepasste Analytics-Image verwendet werden soll. Format: IBM_Cloud-Registry-URL/privater_Namespace/Image-Name</td>
                                            </tr>      
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Abschnitt schließen</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - Ausführung des Image in einem IBM Container</b><br />
                    Das Script <b>startanalytics.sh</b> wird verwendet, um das MobileFirst-Analytics-Image in einem IBM Container auszuführen. Außerdem bindet das Script Ihr Image an die öffentliche IP-Adresse, die Sie mit der Eigenschaft <b>ANALYTICS_IP</b> konfiguriert haben. </li>

Führen Sie Folgendes aus:
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>Name des Analytics-Container-Image, das in die Registry des Service "IBM Containers" geladen wurde. Format: IBM_Cloud-Registry/privater_Namespace/Image-Name:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>Name des Analytics-Containers</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>IP-Adresse, an die der Container gebunden werden soll. (Sie können eine verfügbare öffentliche IP-Adresse angeben oder mit dem Befehl <code>cf ic ip request</code> eine IP-Adresse anfordern.)</td>
                                            </tr>
                                            <tr>
                                                <td>[-h|--http] EXPOSE_HTTP (optional)</td>
                                                <td>Offenlegung des HTTP-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--https] EXPOSE_HTTPS (optional)</td>
                                                <td>Offenlegung des HTTPS-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-m|--memory] SERVER_MEM (optional)</td>
                                                <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-se|--ssh] SSH_ENABLE (optional)</td>
                                                <td>Aktivierung von SSH für den Container. Gültige Werte sind Y (Standard) und N. </td>
                                            </tr>
                                            <tr>
                                                <td>[-sk|--sshkey] SSH_KEY (optional)</td>
                                                <td>SSH-Schlüssel, der in den Container injiziert werden soll. (Geben Sie den Inhalt Ihrer Datei id_rsa.pub an.) </td>
                                            </tr>
                                            <tr>
                                                <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                                <td>Anzuwendende Tracespezifikation. Standardwert: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>[-ml|--maxlog] MAX_LOG_FILES (optional)</td>
                                                <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                                <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>
                                            <tr>
                                                <td>[-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Analysedaten ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>
                                            <tr>
                                                <td>[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME (optional)</td>
                                                <td>Geben Sie den Namen des Datenträgers für Analysedaten an, der erstellt und angehängt werden soll. Der Standardname ist <b>mfpf_analytics_container_name</b>.</td>
                                            </tr>
                                            <tr>
                                                <td>[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY (optional)</td>
                                                <td>Geben Sie die Position an, an der die Daten gespeichert werden sollen. Der Name des Standardordners ist <b>/analyticsData</b>.</td>
                                            </tr>
                                            <tr>
                                                <td>[-e|--env] MFPF_PROPERTIES (optional)</td>
                                                <td>Geben Sie jeweils durch ein Komma getrennte Eigenschaften von {{ site.data.keys.mf_analytics }} als Schlüssel-Wert-Paare an. Hinweis: Wenn Sie mit diesem Script Eigenschaften angeben, dürfen diese Eigenschaften nicht in den Konfigurationsdateien im Ordner usr/config definiert sein.</td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
                        {% highlight bash %}
                        startanalytics.sh --tag Image-Tagname --name Containername --ip Container-IP-Adresse
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - Ausführung des Image in einer IBM Containergruppe</b><br />
                    Das Script <b>startanalyticsgroup.sh</b> wird verwendet, um das MobileFirst-Analytics-Image in einer IBM Containergruppe auszuführen. Außerdem bindet das Script Ihr Image an den Hostnamen, den Sie mit der Eigenschaft <b>ANALYTICS_CONTAINER_GROUP_HOST</b> konfiguriert haben. 

Führen Sie Folgendes aus:
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}
                        <div class="panel-group accordion" id="terminology-analytics-startanalyticsgroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>Name des Analytics-Container-Image, das in die Registry des Service "IBM Containers" geladen wurde. Format: IBM_Cloud-Registry/privater_Namespace/Image-Name:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>Name der Analytics-Containergruppe</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>Hostname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>Domänenname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN (optional)</td>
                                                <td>Mindestanzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX (optional)</td>
                                                <td>Maximale Anzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED (optional)</td>
                                                <td>Gewünschte Anzahl Containerinstanzen. Der Standardwert ist 2.</td>
                                            </tr>
                                            <tr>
                                                <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                                <td>Anzuwendende Tracespezifikation. Standardwert: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>[-ml|--maxlog] MAX_LOG_FILES (optional)</td>
                                                <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                                <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-e|--env] MFPF_PROPERTIES (optional)</td>
                                                <td>Geben Sie jeweils durch ein Komma getrennte {{ site.data.keys.product_adj }}-Eigenschaften als Schlüssel-Wert-Paare an. Beispiel: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>[-m|--memory] SERVER_MEM (optional)</td>
                                                <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>
                                            <tr>
                                                <td>[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME (optional)</td>
                                                <td>Geben Sie den Namen des Datenträgers für Analysedaten an, der erstellt und angehängt werden soll. Der Standardwert ist <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b>.</td>
                                            </tr>
                                            <tr>
                                                <td>[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY (optional)</td>
                                                <td>Geben Sie das Verzeichnis an, in dem Analysedaten gespeichert werden sollen. Der Standardwert ist <b>/analyticsData</b>.</td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
startanalyticsgroup.sh --tag Image-Name --name Containergruppenname --host Hostname_der_Containergruppe --domain Domänenname_der_Containergruppe
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                Starten Sie die Analytics Console, indem Sie die URL http://ANALYTICS-CONTAINER-HOST/analytics/console laden. (Der Start kann eine Weile dauern.)   
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Tragen Sie die Argumentwerte in den folgenden Dateien ein:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_USER - </b>Ihr IBM Cloud-Benutzername (E-Mail-Adresse) </li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Ihr IBM Cloud-Kennwort</li>
                    <li><b>IBM_CLOUD_ORG - </b>Ihr IBM Cloud-Organisationsname</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Ihr IBM Cloud-Bereich (wie oben erläutert)</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                Der {{ site.data.keys.mf_bm_short }} Service erfordert eine externe <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">Instanz der <i>dashDB-Enterprise-Transactional-Datenbank</i></a> (<i>Enterprise Transactional 2.8.500</i> oder <i>Enterprise Transactional 12.128.1400</i>).<br/>
                <b>Hinweis:</b> Die Implementierung der dashDB-Enterprise-Transactional-Pläne erfolgt unter Umständen nicht sofort. Es kann sein, dass das Vertriebsteam vorher Kontakt mit Ihnen aufnimmt. <br/><br/>
                Wenn Sie Ihre dashDB-Instanz eingerichtet haben, geben Sie die folgenden erforderlichen Argumente an:
                <ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>Name Ihrer dashDB-Serviceinstanz für das Speichern von Verwaltungsdaten</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>Name Ihres Schemas für Verwaltungsdaten. Der Standardwert ist MFPDATA.</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>Name Ihrer dashDB-Serviceinstanz für das Speichern von Laufzeitdaten. Der Standardwert ist der Name des Verwaltungsservice.</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>Name Ihres Schemas für Laufzeitdaten. Der Standardwert ist MFPDATA.</li>
                    <b>Hinweis:</b> Wenn Ihre dashDB-Serviceinstanz von vielen Benutzern gemeinsam genutzt wird, stellen Sie sicher, dass eindeutige Schemanamen angegeben werden.
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Ein Tag für das Image. Der Tag sollte das Format <em>registry-url/namespace/your-tag</em> haben.</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Wie in <em>prepareserver.sh</em></li>
                    <li><b>SERVER_CONTAINER_NAME - </b>Name für Ihren IBM Cloud-Container</li>
                    <li><b>SERVER_IP - </b>IP-Adresse, an die der IBM Cloud-Container gebunden werden soll<br/>
                    Führen Sie zum Zuweisen einer IP-Adresse <code>cf ic ip request</code> aus.<br/>
                    IP-Adressen können in mehreren Containern eines Bereichs wiederverwendet werden. <br/>
                    Wenn Sie bereits eine Adresse zugewiesen haben, können Sie <code>cf ic ip list</code> ausführen.</li>
                    <li><b>MFPF_PROPERTIES - </b>Jeweils durch ein Komma (<b>ohne Leerzeichen</b>) getrennte JNDI-Eigenschaften von {{ site.data.keys.mf_server }}. Die für Analysen relevanten Eigenschaften werden wie folgt definiert: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Wie in <em>prepareserver.sh</em></li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>Name für Ihre IBM Cloud-Containergruppe</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Ihr Hostname</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>Ihr Domänenname. Der Standardwert ist <code>mybluemix.net</code>.</li>
                    <li><b>MFPF_PROPERTIES - </b>Jeweils durch ein Komma (<b>ohne Leerzeichen</b>) getrennte JNDI-Eigenschaften von {{ site.data.keys.mf_server }}. Die für Analysen relevanten Eigenschaften werden wie folgt definiert: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
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

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten, die Sie für die Ausführung in einem nicht interaktiven Modus auswählen sollten, wird ebenfalls bereitgestellt. </p>

            <ol>
                <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
Führen Sie das Script <b>initenv.sh</b> aus, um eine Umgebung für die Erstellung und Ausführung von {{ site.data.keys.product }} in IBM Containern zu erstellen:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-initenv" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Befehlszeilenargument</b></td>
                                            <td><b>Beschreibung</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] IBM_CLOUD_USER</td>
                                            <td>IBM Cloud-Benutzer-ID oder E-Mail-Adresse</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                            <td>IBM Cloud-Kennwort</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                            <td>IBM Cloud-Organisationsname</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                            <td>IBM Cloud-Bereichsname</td>
                                        </tr>
                                        <tr>
                                            <td>[-a|--api] IBM_CLOUD_API_URL (optional)</td>
                                            <td>IBM Cloud-API-Endpunkt. (Standardwert ist https://api.ng.bluemix.net.)</td>
                                        </tr>
                                    </table>

                                    <p>Beispiel: </p>
{% highlight bash %}
initenv.sh --user IBM_Cloud-Benutzer-ID --password IBM_Cloud-Kennwort --org IBM_Cloud-Organisationsname --space IBM_Cloud-Bereichsname
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Abschnitt schließen</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - Erstellung der MobileFirst-Server-Datenbank</b><br />
                    Das Script <b>prepareserverdbs.sh</b> wird verwendet, um Ihren {{ site.data.keys.mf_server }} mit dem dashDB-Datenbankservice zu konfigurieren. Die Instanz des dashDB-Service muss in der Organisation und dem Bereich verfügbar sein, bei denen Sie sich in Schritt 1 angemeldet haben. Führen Sie Folgendes aus:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserverdbs" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Befehlszeilenargument</b></td>
                                            <td><b>Beschreibung</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>IBM Cloud-dashDB-Service (mit dem IBM Cloud-Serviceplan Enterprise Transactional)</td>
                                        </tr>
                                        <tr>
                                            <td>[-as |--adminschema ] ADMIN_SCHEMA_NAME (optional)	</td>
                                            <td>Name des Datenbankschemas für den Verwaltungsservice. Standrdwert: MFPDATA</td>
                                        </tr>
                                        <tr>
                                            <td>[-rd |--runtimedb ] RUNTIME_DB_SRV_NAME (optional)	</td>
                                            <td>Name der IBM Cloud-Datenbankserviceinstanz für das Speichern der Laufzeitdaten. Standardmäßig der Service, der für die Verwaltungsdaten angegeben wird.</td>
                                        </tr>
                                        <tr>
                                            <td>[-p |--push ] ENABLE_PUSH (optional)	</td>
                                            <td>Konfiguration der Datenbank für den Push-Service ermöglichen. Gültige Werte sind Y (Standard) und N. </td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>Name der IBM Cloud-Datenbankserviceinstanz für das Speichern der Push-Daten. Standardmäßig der Service, der für die Laufzeitdaten angegeben wird.</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>Name des Datenbankschemas für den Push-Service. Stndardmäßig der Name des Laufzeitschemas. </td>
                                        </tr>
                                    </table>

                                    <p>Beispiel: </p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>Abschnitt schließen</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                      Dieser Schritt ist nur erforderlich, wenn Sie Ihre Container in einer Organisation und einem Breich ohne verfügbare dashDB-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei initenv.properties mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - Erstellung eines MobileFirst-Server-Image</b><br />
                    Führen Sie das Script <b>prepareserver.sh</b> aus, um ein MobileFirst-Server-Image zu erstellen und per Push-Operation in Ihr IBM Cloud-Repository zu übertragen. Wenn Sie alle verfügbaren Images in Ihrem IBM Cloud-Repository anzeigen möchten, führen Sie <code>cf ic images</code> aus. <br/>
                    Die Liste enthält den Image-Namen, das Erstellungsdatum und die ID.<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Befehlszeilenargument</b></td>
                                            <td><b>Beschreibung</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>Name, der für das angepasste MobileFirst-Server-Image verwendet werden soll. Format: Registry-URL/Namespace/Image-Name</td>
                                        </tr>
                                    </table>

                                    <p>Beispiel: </p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}
<br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Abschnitt schließen</b></a>
                              </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - Ausführung des Image in einem IBM Container</b><br />
                    Das Script <b>startserver.sh</b> wird verwendet, um das MobileFirst-Server-Image in einem IBM Container auszuführen. Außerdem bindet das Script Ihr Image an die öffentliche IP-Adresse, die Sie mit der Eigenschaft <b>SERVER_IP</b> konfiguriert haben. Führen Sie Folgendes aus:</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-startserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>Befehlszeilenargument</b></td>
                                        <td><b>Beschreibung</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>Name des MobileFirst-Server-Image</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>IP-Adresse, an die der MoibleFirst-Server-Container gebunden werden soll. (Sie können eine verfügbare öffentliche IP-Adresse angeben oder mit dem Befehl <code>cf ic ip request</code> eine IP-Adresse anfordern.)</td>
                                    </tr>
                                    <tr>
                                        <td>[-si|--services] SERVICE_INSTANCES (optional)</td>
                                        <td>Jeweils durch ein Komma getrennte IBM Cloud-Serviceinstanzen, die an den Container gebunden werden sollen </td>
                                    </tr>
                                    <tr>
                                        <td>[-h|--http] EXPOSE_HTTP (optional)</td>
                                        <td>Offenlegung des HTTP-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                    </tr>
                                    <tr>
                                        <td>[-s|--https] EXPOSE_HTTPS (optional)</td>
                                        <td>Offenlegung des HTTPS-Ports. Gültige Werte sind Y (Standard) und N. </td>
                                    </tr>
                                    <tr>
                                        <td>[-m|--memory] SERVER_MEM (optional)</td>
                                        <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>[-se|--ssh] SSH_ENABLE (optional)</td>
                                        <td>Aktivierung von SSH für den Container. Gültige Werte sind Y (Standard) und N. </td>
                                    </tr>
                                    <tr>
                                        <td>[-sk|--sshkey] SSH_KEY (optional)</td>
                                        <td>SSH-Schlüssel, der in den Container injiziert werden soll. (Geben Sie den Inhalt Ihrer Datei id_rsa.pub an.) </td>
                                    </tr>
                                    <tr>
                                        <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                        <td>Anzuwendende Tracespezifikation. Standardwert: <code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>[-ml|--maxlog] MAX_LOG_FILES (optional)</td>
                                        <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                    </tr>
                                    <tr>
                                        <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                        <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                        <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                    </tr>
                                    <tr>
                                        <td>[-e|--env] MFPF_PROPERTIES (optional)</td>
                                        <td>Geben Sie jeweils durch ein Komma getrennte {{ site.data.keys.product_adj }}-Eigenschaften als Schlüssel-Wert-Paare an. Beispiel: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>. <b>Hinweis:</b> Wenn Sie mit diesem Script Eigenschaften angeben, dürfen diese Eigenschaften nicht in den Konfigurationsdateien im Ordner usr/config definiert sein.</td>
                                    </tr>
                                </table>

                                <p>Beispiel: </p>
{% highlight bash %}
startserver.sh --tag Image-Tagname --name Containername --ip Container-IP-Adresse
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Abschnitt schließen</b></a>
                            </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - Ausführung des Image in einer IBM Containergruppe</b><br />
                    Das Script <b>startservergroup.sh</b> wird verwendet, um das MobileFirst-Server-Image in einer IBM Containergruppe auszuführen. Außerdem bindet das Script Ihr Image an den Hostnamen, den Sie mit der Eigenschaft <b>SERVER_CONTAINER_GROUP_HOST</b> konfiguriert haben. </li>
Führen Sie Folgendes aus:
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-startservergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Für eine Liste mit Befehlszeilenargumenten hier klicken</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Befehlszeilenargument</b></td>
                                                <td><b>Beschreibung</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Name des MobileFirst-Server-Container-Image in der IBM Cloud-Registry</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>Name der MobileFirst-Server-Containergruppe</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>Hostname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN </td>
                                                <td>Domänenname der Route</td>
                                            </tr>
                                            <tr>
                                                <td>[-gm|--min] SERVERS_CONTAINER_GROUP_MIN (optional)</td>
                                                <td>Mindestanzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gx|--max] SERVER_CONTAINER_GROUP_MAX (optional)</td>
                                                <td>Maximale Anzahl Containerinstanzen. Der Standardwert ist 1.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED (optional)</td>
                                                <td>Gewünschte Anzahl Containerinstanzen. Der Standardwert ist 2.</td>
                                            </tr>
                                            <tr>
                                                <td>[-a|--auto] ENABLE_AUTORECOVERY (optional)</td>
                                                <td>Aktivieren der automatischen Wiederherstellungsoption für die Containerinstanzen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>

                                            <tr>
                                                <td>[-si|--services] SERVICES (optional)</td>
                                                <td>Jeweils durch ein Komma getrennte Namen von IBM Cloud-Serviceinstanzen, die an den Container gebunden werden sollen </td>
                                            </tr>
                                            <tr>
                                                <td>[-tr|--trace] TRACE_SPEC (optional)</td>
                                                <td>Anzuwendende Tracespezifikation. Der Standarwert ist <code>*=info</code>. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ml|--maxlog] MAX_LOG_FILES (optional)</td>
                                                <td>Maximale Anzahl Protokolldateien, nach deren Erreichen die Protokolle überschrieben werden. Standard: 5 Dateien. </td>
                                            </tr>
                                            <tr>
                                                <td>[-ms|--maxlogsize] MAX_LOG_FILE_SIZE (optional)</td>
                                                <td>Maximale Größe einer Protokolldatei. Die Standardgröße liegt bei 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-e|--env] MFPF_PROPERTIES (optional)</td>
                                                <td>Geben Sie jeweils durch ein Komma getrennte {{ site.data.keys.product_adj }}-Eigenschaften als Schlüssel-Wert-Paare an. Beispiel:
<code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>Hinweis:</b> Wenn Sie mit diesem Script Eigenschaften angeben, dürfen die Eigenschaften nicht in den Konfigurationsdateien im Ordner usr/config definiert sein.</td>
                                            </tr>
                                            <tr>
                                                <td>[-m|--memory] SERVER_MEM (optional)</td>
                                                <td>Dem Container zugewiesene Speicherkapazität in Megabytes (MB). Gültige Werte sind 1024 MB (Standard) und 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>[-v|--volume] ENABLE_VOLUME (optional)</td>
                                                <td>Anhängen des Datenträgers für Containerprotokolle ermöglichen. Gültige Werte sind Y und N (Standard).</td>
                                            </tr>
                                        </table>

                                        <p>Beispiel: </p>
{% highlight bash %}
startservergroup.sh --tag Image-Name --name Containergruppenname --host Hostname_der_Containergruppe --domain Domänenname_der_Containergruppe
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Abschnitt schließen</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **Hinweis:** Container müssen nach jeder Konfigurationsänderung neu gestartet werden (`cf ic restart Container-ID`). Bei Containergruppen müssen Sie jede Containerinstanz innerhalb einer Gruppe
neu starten.
Wenn sich beispielsweise ein Stammzertifikat ändert, muss nach dem Hinzufügen des neuen Zertifikats jede Containerinstanz neu
gestartet werden. 

Starten Sie die {{ site.data.keys.mf_console }} über die URL http://MF\_CONTAINER\_HOST/mfpconsole. (Der Start kann eine Weile dauern.)   
Fügen Sie den fernen Server hinzu. Folgen Sie dfür den Anweisungen
im Lernprogramm [{{ site.data.keys.mf_cli }} für die Verwaltung
von {{ site.data.keys.product_adj }}-Artefakten verwenden](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance). 

{{ site.data.keys.mf_server }} wird jetzt in IBM Cloud ausgeführt, sodass Sie mit der Anwendungsentwicklung beginnen können. Gehen Sie die {{ site.data.keys.product }} [Lernprogramme](../../all-tutorials) durch.

#### Portnummernbeschränkung
{: #port-number-limitation }
Für IBM Container gilt zurzeit eine Beschränkung
hinsichtlich der Portnummern, die für die öffentliche Domäne verfügbar sind. Daher können die für den Container mit {{ site.data.keys.mf_analytics }}
und den MobileFirst-Server-Container angegebenen Standardportnummern (9080 für HTTP und 9443 für HTTPS) nicht geändert werden. Container in einer Containergruppe müssen den HTTP-Port 9080 verwenden. Containergruppen bieten keine Unterstützung für die Verwendung von mehreren Portnummern oder HTTPS-Anforderungen.


## Fixes für {{ site.data.keys.mf_server }} anwenden
{: #applying-mobilefirst-server-fixes }

Vorläufige Fixes für {{ site.data.keys.mf_server }} in IBM Containern können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.  
Sichern Sie Ihre vorhandenen Konfigurationsdateien, bevor Sie einen vorläufigen Fix anwenden. Die Konfigurationsdateien befinden sich in den folgenden Ordnern: 
* {{ site.data.keys.mf_analytics }}: **Paketstammverzeichnis/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} (Liberty-Cloud-Foundry-Anwendung): **Paketstammverzeichnis/mfpf-server/usr**
* {{ site.data.keys.mf_app_center_short }}: **Paketstammverzeichnis/mfp-appcenter/usr**

### Anwendung des iFix:

1. Laden Sie das Archiv mit dem vorläufigen Fix herunter und extrahieren Sie den Inhalt des Archivs in Ihrem vorhandenen Installationsordner. Dabei werden in dem Ordner vorhandene Dateien überschrieben.
2. Speichern Sie Ihre gesicherten Konfigurationsdateien zurück in die Ordner **Paketstammverzeichnis/mfpf-analytics/usr**, **Paketstammverzeichnis/mfpf-server/usr** und **Paketstammverzeichnis/mfp-appcenter/usr**. Dabei werden die neu installierten Konfigurationsdateien überschrieben.
3. Bearbeiten Sie die Datei **Paketstammverzeichnis/mfpf-server/usr/env/jvm.options** in Ihrem Editor. Wenn die folgende Zeile vorhanden ist, entfernen Sie sie:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    Jetzt können Sie einen aktualisierten Serverbuild erstellen und den Server implementieren. 

    a. Führen Sie das Script `prepareserver.sh` aus, um das Server-Image neu zu erstellen und per Push-Operation zum Service "IBM Containers" zu übertragen.

    b. Führen Sie das Script `startserver.sh` aus, um das Server-Image als eigenständigen Container auszuführen, oder das Script `startservergroup.sh`, um das Server-Image als Containergruppe auszuführen.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Container in IBM Cloud entfernen
{: #removing-a-container-from-bluemix }
Wenn Sie in IBM Cloud einen Container entfernen, müssen Sie auch den Image-Namen aus der Registry entfernen.   
Führen Sie die folgenden Befehle aus, um einen Container in IBM Cloud zu entfernen: 

1. `cf ic ps` (Listet die zurzeit aktiven Container auf) 
2. `cf ic stop container_id` (Stoppt den Container)
3. `cf ic rm container_id` (Entfernt den Container)

Führen Sie die folgenden cf ic-Befehle aus, um einen Image-Namen aus der IBM Cloud-Registry zu entfernen: 

1. `cf ic images` (Listet die Images in der Registry auf)
2. `cf ic rmi image_id` (Entfernt ein Image aus der Registry)

## Datenbankservicekonfiguration aus IBM Cloud entfernen
{: #removing-the-database-service-configuration-from-bluemix }
Wenn Sie während der Konfiguration des MobileFirst-Server-Image das Script **prepareserverdbs.sh** ausgeführt haben,
werden die für {{ site.data.keys.mf_server }} erforderlichen Konfigurationen und Datenbanktabellen erstellt. Das Script erstellt auch das Datenbankschema für den Container. 

Sie können die Datenbankservicekonfiguration im IBM Cloud-Dashboard wie folgt entfernen.

1. Wählen Sie im IBM Cloud-Dashboard den dashDB-Service aus, den Sie verwendet haben. Wählen Sie den dashDB-Servicenamen aus, den Sie für die Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
2. Starten Sie die dashDB-Konsole, um mit den Schemata und Datenbankobjekten der ausgewählten dashDB-Serviceinstanz arbeiten zu können. 
3. Wählen Sie Schemata für die Konfiguration von IBM {{ site.data.keys.mf_server }} aus. Die Schemanamen sind die, die Sie bei Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
4. Untersuchen Sie die Schemanamen und die zugehörigen Objekte gründlich, bevor Sie die einzelnen Schemata löschen. Die Datenbankkonfigurationen wurden aus IBM Cloud entfernt.

Wenn Sie während des Konfigurierens des {{ site.data.keys.mf_app_center }} das Script **prepareappcenterdbs.sh** ausführen, folgen Sie den oben beschriebenen Schritten, um die Datenbankservicekonfiguration aus IBM Cloud zu entfernen. 
