---
layout: tutorial
title: MobileFirst Server mit Scripts für Liberty for Java in IBM Cloud einrichten
breadcrumb_title: Foundation on Liberty for Java
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um eine MobileFirst-Server-Instanz in einer Liberty-for-Java-Laufzeit für IBM Cloud zu konfigurieren. <!--({{ site.data.keys.mf_analytics }} instances can be run on IBM containers only.)--> Gehen Sie dazu die folgenden Schritte durch: 

* Statten Sie Ihren Host-Computer mit den erforderlichen Tools aus (Cloud-Foundry-CLI). 
* Richten Sie Ihr IBM Cloud-Konto ein.
* Erstellen Sie einen {{ site.data.keys.mf_server }} und übertragen Sie ihn als Cloud-Foundry-Anwendung in IBM Cloud. 

Abschließend werden Sie Ihre mobilen Apps registrieren und Ihre Adapter implementieren. 

**Hinweise:**  

* Das Windows-Betriebssystem wird derzeit nicht für die Ausführung dieser Scripts unterstützt.  
* Die MobileFirst-Server-Konfigurationstools können nicht für die Implementierung in IBM Cloud genutzt werden.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Konto in IBM Cloud registrieren](#register-an-account-at-ibmcloud)
* [Hostmaschine einrichten](#set-up-your-host-machine)
* [Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen](#download-the-ibm-mfpf-container-8000-archive)
* [Informationen zum Analytics-Server hinzufügen](#adding-analytics-server-configuration-to-mobilefirst-server)
* [Fixes für {{ site.data.keys.mf_server }} anwenden](#applying-mobilefirst-server-fixes)
* [Datenbankservicekonfiguration aus IBM Cloud entfernen](#removing-the-database-service-configuration-from-ibmcloud)

## Konto in IBM Cloud registrieren
{: #register-an-account-at-ibmcloud }
Falls Sie noch kein Konto haben, öffnen Sie die [IBM Cloud-Website](https://bluemix.net) und klicken Sie auf **Kostenloses Konto erstellen** oder auf **Anmeldung**. Sie müssen das Registrierungsformular ausfüllen, bevor Sie mit dem nächsten Schritt fortfahren können. 

### IBM Cloud-Dashboard
{: #the-ibmcloud-dashboard }
Nachdem Sie sich bei IBM Cloud angemeldet haben, wird das IBM Cloud-Dashboard angezeigt, das Ihnen einen Überblick über den aktiven IBM Cloud-Bereich gibt. Standardmäßig hat dieser Arbeitsbereich den Namen "dev". Bei Bedarf können Sie mehrere Arbeitsbereiche erstellen. 

## Hostmaschine einrichten
{: #set-up-your-host-machine }
Für die Verwaltung der IBM Cloud-Cloud-Foundry-App müssen Sie die Cloud-Foundry-CLI installieren.  
Die Scripts können Sie mit der Terminal.app unter macOS oder einer Linux-Bash-Shell ausführen. 

Installieren Sie die [Cloud-Foundry-CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).

## Archiv {{ site.data.keys.mf_bm_pkg_name }} herunterladen
{: #download-the-ibm-mfpf-container-8000-archive}
Wenn Sie die {{ site.data.keys.product }} in Liberty on Java einrichten möchten, müssen Sie zunächst ein Dateilayout erstellen, das später per Push-Operation in IBM Cloud übertragen wird.   
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Folgen Sie den Anweisungen auf dieser Seite</a>, um das Archiv mit {{ site.data.keys.mf_server }} 8.0 für IBM Container (ZIP-Datei) herunterzuladen (suchen Sie nach *CNBL0EN*).



Die Archivdatei enthält die Dateien für die Erstellung eines Dateilayouts (**dependencies** und **mfpf-libs**), die Dateien für die Erstellung und Implementierung eines Containers mit {{ site.data.keys.mf_analytics }} (**mfpf-analytics**) und Dateien zum Konfigurieren einer MobileFirst-Server-Cloud-Foundry-App (**mfpf-server-libertyapp**).

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>Für mehr Informationen zum Inhalt der Archivdatei hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Dateisystemstruktur der Archivdatei" style="float:right;width:570px"/>
                <h4>Ordner 'dependencies'</h4>
                <p>Enthält die Laufzeit der {{ site.data.keys.product }} und IBM Java JRE 8</p>

                <h4>Ordner 'mfpf-libs'</h4>
                <p>Enthält die Bibliotheken für die {{ site.data.keys.product_adj }}-Produktkomponenten und die CLI</p>

                <h4>Ordner 'mfpf-server-libertyapp'</h4>

                <ul>

                    <li>Ordner <b>scripts</b>: Dieser Ordner enthält den Ordner <b>args</b> mit einer Reihe von Konfigurationsdateien. Er enthält außerdem die Scripts für die Anmeldung bei IBM Cloud, die Erstellung einer MobileFirst-Foundation-App für die Push-Übertragung in IBM Cloud und die Ausführung in IBM Cloud. Sie können diese Scripts interaktiv ausführen oder die Konfigurationsdateien wie nachfolgend erläutert für die Ausführung der Scripts vorkonfigurieren. Anders als bei den anpassbaren Dateien args/*.properties dürfen Sie in diesem Ordner keine Elemente modifizieren. Verwenden Sie das Befehlszeilenargument <code>-h</code> oder <code>--help</code>, um einen Hilfetext zur Scriptsyntax abzurufen (z. B. <code>Scriptname.sh --help</code>).</li>
                    <li>Ordner <b>usr</b>:
                        <ul>
                            <li>Ordner <b>config</b>: Für {{ site.data.keys.mf_server }} verwendete Serverkonfigurationsfragmente (Keystore, Servereigenschaften, Benutzerregistry)</li>
                            <li><b>keystore.xml</b>: Konfiguration des Repositorys mit Sicherheitszertifikaten für die SSL-Verschlüsselung. Im Ordner ./usr/security muss auf die aufgelisteten Dateien verwiesen werden.</li>
                            <li><b>mfpfproperties.xml</b> - Konfigurationseigenschaften für {{ site.data.keys.mf_server }}. Informieren Sie sich anhand der folgenden Dokumentationsabschnitte über die unterstützten Eigenschaften:<ul>
                                <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste der JNDI-Eigenschaften für den MobileFirst-Sever-Verwaltungsservice</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b>: Benutzerregistrykonfiguration. Als Standardkonfiguration wird eine auf XML basierende Basisbenutzerregistrykonfiguration (basicRegistry) bereitgestellt. Sie können Namen und Kennwörter für basicRegistry konfigurieren oder ldapRegistry konfigurieren.</li>
                        </ul>
                    </li>
                    <li>Ordner <b>env</b>: Enthält die Umgebungseigenschaften für die Serverinitialisierung (server.env) sowie angepasste JVM-Optionen (jvm.options).<br/>
                    </li>

                    <li>Ordner <b>security</b>: Wird verwendet, um die Keystore-Datei, die Truststore-Datei und die LTPA-Schlüsseldatei (ltpa.keys) zu speichern.</li>

                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>


## {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_app_center }} einrichten
{: #setting-up-the-mobilefirst-server }
Sie können die Scripts interaktiv ausführen oder die Konfigurationsdateien verwenden.
Ein guter Ausgangspunkt ist die einmalige interaktive Ausführung der Scripts, wobei auch die Argumente erfasst werden (**recorded-args**). Später können Sie die Dateien mit den Argumenten verwenden, um die Scripts in einem nicht interkativen Modus auszuführen. 

> **Hinweis:** Kennwörter werden nicht aufgezeichnet. Sie müssen die Kennwörter manuell zu den Dateien mit Argumenten hinzufügen. 

* Verwendung der Konfigurationsdateien: Führen Sie die Scripts aus und übergeben Sie die entsprechende Konfigurationsdatei als Argument. 
* Interaktiv: Führen Sie die Scripts ohne Argumente aus. 

Wenn Sie sich entschließen, die Scripts interaktiv auszuführen, können Sie die Konfiguration übergehen. Wir empfehlen Ihnen jedoch, sich wenigstens mit den Argumenten, die angegeben werden müssen, zu beschäftigen. 


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }

>**Hinweis:** Sie können Installationsprogramme und Datenbanktools aus den lokalen Installationsordnern des {{ site.data.keys.mf_app_center }} (`installer` und `tools`) herunterladen.



<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-1" aria-expanded="false" aria-controls="collapse-step-appcenter-1">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Die leeren Schablonendateien und eine Erläuterung der Argumente finden Sie im Ordner <b>args</b> oder nach einer interaktiven Ausführung der Scripts im Ordner <b>recorded-args</b>. Es handelt sich um folgende Dateien:<br/>

              <h4>initenv.properties</h4>
              Diese Datei enhält Eigenschaften zum Ausführen der Umgebungsinitialisierung.
              <h4>prepareappcenterdbs.properties</h4>
Das {{ site.data.keys.mf_app_center }} erfordert eine externe <a href="https://console.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB-Enterprise-Transactional-Datenbankinstanz</a> (einen mit "OLTP" oder "Transactional" bezeichneten Plan).<br/>
              <b>Hinweis:</b> Die Implementierung der dashDB-Enterprise-Transactional-Pläne erfolgt sofort, wenn die Pläne mit "pay as you go" gekennzeichnet sind. Vergewissern Sie sich, dass Sie einen passenden Plan ausgewählt haben, z. B. <i>Enterprise for Transactions High Availability 2.8.500 (Pay per use)</i>. <br/><br/>
              Wenn Sie Ihre dashDB-Instanz eingerichtet haben, geben Sie die erforderlichen Argumente an. 

              <h4>prepareappcenter.properties</h4>
              Diese Datei wird für das Script prepareappcenter.sh verwendet. Sie erstellt das Application-Center-Dateilayout und überträgt es per Push-Operation als Cloud-Foundry-App in IBM Cloud.
              <h4>startappcenter.properties</h4>
              Diese Datei konfiguriert die Laufzeitattribute des Servers und startet den Server. Es wird dringend empfohlen, für die hohe Verfügbarkeit mindestens 1024 MB (<b>SERVER_MEM=1024</b>) und 3 Knoten (<b>INSTANCES=3</b>) zu verwenden. 

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-appcenter-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-appcenter-2" aria-expanded="false" aria-controls="collapse-step-appcenter-2">Scripts ausführen</a>
            </h4>
        </div>

        <div id="collapse-step-appcenter-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten, die Sie für die Ausführung in einem nicht interaktiven Modus auswählen sollten, wird ebenfalls bereitgestellt. </p>
              <ol>
                  <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
                      Führen Sie das Script <b>initenv.sh</b> für die Anmeldung bei IBM Cloud aus. Führen Sie das Script für die Organisation und den Bereich aus, an die Ihr dashDB-Service gebunden ist:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
initenv.sh --user IBM_Cloud-Benutzer-ID --password IBM_Cloud-Kennwort --org IBM_Cloud-Organisationsname --space IBM_Cloud-Bereichsname
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenterdbs.sh - Erstellung der MobileFirst-Application-Center-Datenbank</b><br />
                  Das Script <b>prepareappcenterdbs.sh</b> wird verwendet, um Ihr {{ site.data.keys.mf_app_center }} mit dem dashDB-Datenbankservice oder einem zugänglichen DB2-Datenbankserver zu konfigurieren. Die DB2-Option kommt insbesondere infrage, wenn Sie IBM Cloud lokal in dem Rechenzentrum ausführen, in dem der DB2-Server installiert ist. Wenn Sie den dashDB-Service verwenden, muss die Instanz des dashDB-Service in der Organisation und dem Bereich verfügbar sein, bei denen Sie sich in Schritt 1 angemeldet haben. Führen Sie Folgendes aus:
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
prepareappcenterdbs.sh --acdb MFPAppCenterDashDBService
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./prepareappcenterdbs.sh --help
{% endhighlight %}

                  </li>
                  <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                      Dieser Schritt ist nur erforderlich, wenn Sie Ihren Server in einer Organisation und einem Breich ohne verfügbare dashDB-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei initenv.properties mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareappcenter.sh - Erstellung des {{ site.data.keys.mf_app_center }}</b><br />
                    Führen Sie das Script <b>prepareappcenter.sh</b> aus, um ein {{ site.data.keys.mf_app_center }} zu erstellen und per Push-Operation als Cloud-Foundry-Anwendung in IBM Cloud zu übertragen. Führen Sie <code>cf apps</code> aus, um alle Cloud-Foundry-Anwendungen mit ihren URLs in der Organisation und in dem Bereich zu sehen, für die Sie sich angemeldet haben. <br/>


{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
prepareappcenter.sh --name APP_NAME
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./prepareappcenter.sh --help
{% endhighlight %}                  

                  </li>
                  <li><b>startappcenter.sh - Starten des {{ site.data.keys.mf_app_center }}</b><br />
                  Das Script <b>startappcenter.sh</b> wird zum Starten von {{ site.data.keys.mf_app_center }} in der Cloud-Foundry-Anwendung für Liberty for Java zu starten. Führen Sie Folgendes aus: <p/>
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
./startappcenter.sh --name APP_NAME
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./startappcenter.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>
Starten Sie die MobileFirst-Application-Center-Konsole über die URL `http://APP_HOST.mybluemix.net/appcenterconsole`. (Der Start kann eine Weile dauern.)    

Mit dem in IBM Cloud ausgeführten {{ site.data.keys.mf_app_center }} können Sie nun Ihre mobilen Apps in das Application Center hochladen. 


### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
<div class="panel-group accordion" id="scripts2-mf" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1-mf">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-1-mf" aria-expanded="false" aria-controls="collapse-step-foundation-1-mf">Konfigurationsdateien verwenden</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1-mf" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            Der Ordner <b>args</b> enthält Konfigurationsdateien mit den Argumenten, die zum Ausführen der Scripts erforderlich sind. Die leeren Schablonendateien und eine Erläuterung der Argumente finden Sie im Ordner <b>args</b> oder nach einer interaktiven Ausführung der Scripts im Ordner <b>recorded-args</b>. Es handelt sich um folgende Dateien:<br/>

              <h4>initenv.properties</h4>
              Diese Datei enhält Eigenschaften zum Ausführen der Umgebungsinitialisierung.
              <h4>prepareserverdbs.properties</h4>
              Der {{ site.data.keys.mf_bm_short }} Service erfordert eine externe <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB-Enterprise-Transactional-Datenbankinstanz</a> (einen mit "OLTP" oder "Transactional" bezeichneten Plan).<br/>
              <b>Hinweis:</b> Die Implementierung der dashDB-Enterprise-Transactional-Pläne erfolgt sofort, wenn die Pläne mit "pay as you go" gekennzeichnet sind. Vergewissern Sie sich, dass Sie einen passenden Plan ausgewählt haben, z. B. <i>Enterprise for Transactions High Availability 2.8.500 (Pay per use)</i>. <br/><br/>
              Wenn Sie Ihre dashDB-Instanz eingerichtet haben, geben Sie die erforderlichen Argumente an. 

              <h4>prepareserver.properties</h4>
              Diese Datei wird für das Script prepareserver.sh verwendet. Sie erstellt das Serverdateilayout und überträgt es per Push-Operation als Cloud-Foundry-App in IBM Cloud.
              <h4>startserver.properties</h4>
              Diese Datei konfiguriert die Laufzeitattribute des Servers und startet den Server. Es wird dringend empfohlen, für die hohe Verfügbarkeit mindestens 1024 MB (<b>SERVER_MEM=1024</b>) und 3 Knoten (<b>INSTANCES=3</b>) zu verwenden. 

            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2-mf" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">Scripts ausführen</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
              <p>Die folgenden Anweisungen demonstrieren die Ausführung der Scripts unter Verwendung der Konfigurationsdateien. Eine Liste mit Befehlszeilenargumenten, die Sie für die Ausführung in einem nicht interaktiven Modus auswählen sollten, wird ebenfalls bereitgestellt. </p>
              <ol>
                  <li><b>initenv.sh – Anmeldung bei IBM Cloud</b><br />
                      Führen Sie das Script <b>initenv.sh</b> für die Anmeldung bei IBM Cloud aus. Führen Sie das Script für die Organisation und den Bereich aus, an die Ihr dashDB-Service gebunden ist:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
initenv.sh --user IBM_Cloud-Benutzer-ID --password IBM_Cloud-Kennwort --org IBM_Cloud-Organisationsname --space IBM_Cloud-Bereichsname
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareserverdbs.sh - Erstellung der MobileFirst-Server-Datenbank</b><br />
                  Das Script <b>prepareserverdbs.sh</b> wird verwendet, um Ihren {{ site.data.keys.mf_server }} mit dem dashDB-Datenbankservice
oder einem zugänglichen DB2-Datenbankserver zu konfigurieren. Die DB2-Option kommt insbesondere infrage, wenn Sie IBM Cloud lokal in dem Rechenzentrum ausführen, in dem der DB2-Server installiert ist. Wenn Sie den dashDB-Service verwenden, muss die Instanz des dashDB-Service in der Organisation und dem Bereich verfügbar sein, bei denen Sie sich in Schritt 1 angemeldet haben. Führen Sie Folgendes aus:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./prepareserverdbs.sh --help
{% endhighlight %}
</li>
                  <li><b>initenv.sh (optional) – Anmeldung bei IBM Cloud</b><br />
                      Dieser Schritt ist nur erforderlich, wenn Sie Ihren Server in einer Organisation und einem Breich ohne verfügbare dashDB-Serviceinstanz erstellen müssen. Wenn das der Fall ist, aktualisieren Sie die Datei initenv.properties mit der neuen Organisation und dem neuen Bereich, in denen die Container erstellt (und gestartet) werden müssen. Führen Sie dann erneut das Script <b>initenv.sh</b> aus:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><b>prepareserver.sh - Erstellung eines {{ site.data.keys.mf_server }}</b><br />
                    Führen Sie das Script <b>prepareserver.sh</b> aus, um einen {{ site.data.keys.mf_server }} zu erstellen und per Push-Operation als Cloud-Foundry-Anwendung in IBM Cloud zu übertragen. Führen Sie <code>cf apps</code> aus, um alle Cloud-Foundry-Anwendungen mit ihren URLs in der Organisation und in dem Bereich zu sehen, für die Sie sich angemeldet haben.<br/>


{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
prepareserver.sh --name APP_NAME
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./prepareserver.sh --help
{% endhighlight %}                  
</li>
                  <li><b>startserver.sh - Starten des Servers</b><br />
                  Das Script <b>startserver.sh</b> wird zum Starten von {{ site.data.keys.mf_server }} in der Cloud-Foundry-Anwendung für Liberty for Java zu starten. Führen Sie Folgendes aus: <p/>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                        Sie können die Parameter auch in der Befehlszeile übergeben.

{% highlight bash %}
./startserver.sh --name APP_NAME 
{% endhighlight %}

                        Wenn Sie sich über alle unterstützten Parameter und ihre Dokumentation informieren möchten, füren Sie die Option "help" aus. 

{% highlight bash %}
./startserver.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>


Starten Sie die {{ site.data.keys.mf_console }} über die URL `http://APP_HOST.mybluemix.net/mfpconsole`. (Der Start kann eine Weile dauern.)   
Fügen Sie den fernen Server hinzu. Folgen Sie dfür den Anweisungen
im Lernprogramm [{{ site.data.keys.mf_cli }} für die Verwaltung
von {{ site.data.keys.product_adj }}-Artefakten verwenden](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance). 

{{ site.data.keys.mf_server }} wird jetzt in IBM Cloud ausgeführt, sodass Sie mit der Anwendungsentwicklung beginnen können. 

#### Änderungen anwenden
{: #applying-changes }
Nachdem Sie den Server implementiert haben, sind möglicherweise Änderungen am Serverlayout erforderlich. Es könnte beispielsweise sein,
dass Sie die Analytics-URL in **/usr/config/mfpfproperties.xml** aktualisieren möchten. Nehmen Sie die Änderungen vor und führen Sie dann die folgenden Scripts mit den gleichen Parametern erneut aus. 

1. ./prepareserver.sh
2. ./startserver.sh

### Analytics-Server-Konfiguration zu {{ site.data.keys.mf_server }} hinzufügen
{: #adding-analytics-server-configuration-to-mobilefirst-server }
Wenn Sie einen Analytics-Server eingerichtet haben und möchten, dass dieser Server eine Verbindung zu diesem {{ site.data.keys.mf_server }}
herstellen können soll, bearbeiten Sie die Datei **mfpfproperties.xml** im Ordner **Paketstammverzeichnis/mfpf-server-libertyapp/usr/config** wie unten angegeben. Ersetzen Sie die mit `<>` gekennzeichneten Token durch reale Werte Ihrer Implementierung. 

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value='"https://<AnalyticsContainerPublicRoute>:443/analytics/console"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.username" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.password" value='"<AnalyticsPassword>"'/>


<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.endpoint" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.services.ext.analytics" value="com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.user" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.password" value='"<AnalyticsPassword>"'/>
```

## Fixes für {{ site.data.keys.mf_server }} anwenden
{: #applying-mobilefirst-server-fixes }

Vorläufige Fixes für {{ site.data.keys.mf_server }} in IBM Cloud können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.  
Sichern Sie Ihre vorhandenen Konfigurationsdateien, bevor Sie einen vorläufigen Fix anwenden. Die Konfigurationsdateien befinden sich in den
folgenden Ordnern: 
* {{ site.data.keys.mf_analytics }}: **Paketstammverzeichnis/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} (Liberty-Cloud-Foundry-Anwendung): **Paketstammverzeichnis/mfpf-server-libertyapp/usr**
* {{ site.data.keys.mf_app_center_short }}: **Paketstammverzeichnis/mfp-appcenter-libertyapp/usr**

### Anwendung des iFix:

1. Laden Sie das Archiv mit dem vorläufigen Fix herunter und extrahieren Sie den Inhalt des Archivs in Ihrem vorhandenen Installationsordner. Dabei werden in dem Ordner vorhandene Dateien überschrieben.
2. Speichern Sie Ihre gesicherten Konfigurationsdateien zurück in die Ordner **Paketstammverzeichnis/mfpf-analytics/usr**, **Paketstammverzeichnis/mfpf-server-libertyapp/usr** und **Paketstammverzeichnis/mfp-appcenter-libertyapp/usr**. Dabei werden die neu installierten Konfigurationsdateien überschrieben.
3. Bearbeiten Sie die Datei **Paketstammverzeichnis/mfpf-server/usr/env/jvm.options** in Ihrem Editor. Wenn die folgende Zeile vorhanden ist, entfernen Sie sie:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar
```
    Jetzt können Sie einen aktualisierten Serverbuild erstellen und den Server implementieren. Führen Sie die folgenden Scripts erneut mit den gleichen Parametern aus.



    a. `./prepareserver.sh` zum Hochladen der aktualisierten Artefakte in IBM Cloud

    b. `./startserver.sh` zum Starten des aktualisierten Servers

    Eine Kopie der für die vorherige Implementierung verwendeten Argumente wurde im Verzeichnis `recorded-args/` gespeichert. Sie können diese Eigenschaften für Ihre Implementierung verwenden.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Datenbankservicekonfiguration aus IBM Cloud entfernen
{: #removing-the-database-service-configuration-from-ibmcloud }
Wenn Sie während der Konfiguration des MobileFirst-Server-Image das Script **prepareserverdbs.sh** ausgeführt haben,
werden die für {{ site.data.keys.mf_server }} erforderlichen Konfigurationen und Datenbanktabellen erstellt. Das Script erstellt auch das Datenbankschema für {{ site.data.keys.mf_server }}. 

Sie können die Datenbankservicekonfiguration im IBM Cloud-Dashboard wie folgt entfernen.

1. Wählen Sie im IBM Cloud-Dashboard den dashDB-Service aus, den Sie verwendet haben. Wählen Sie den dashDB-Servicenamen aus, den Sie für die Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
2. Starten Sie die dashDB-Konsole, um mit den Schemata und Datenbankobjekten der ausgewählten dashDB-Serviceinstanz arbeiten zu können. 
3. Wählen Sie Schemata für die Konfiguration von IBM {{ site.data.keys.mf_server }} aus. Die Schemanamen sind die, die Sie bei Ausführung des Scripts **prepareserverdbs.sh** als Parameter angegeben haben. 
4. Untersuchen Sie die Schemanamen und die zugehörigen Objekte gründlich, bevor Sie die einzelnen Schemata löschen. Die Datenbankkonfigurationen wurden aus IBM Cloud entfernt.

Wenn Sie während des Konfigurierens des {{ site.data.keys.mf_app_center }} das Script **prepareappcenterdbs.sh** ausführen, folgen Sie den oben beschriebenen Schritten, um die Datenbankservicekonfiguration aus IBM Cloud zu entfernen. 
