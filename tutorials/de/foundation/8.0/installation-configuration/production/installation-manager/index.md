---
layout: tutorial
title: IBM Installation Manager ausführen
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
IBM Installation
Manager installiert
die Dateien und Tools von {{ site.data.keys.mf_server_full }} auf Ihrem Computer.

Sie können den Installation Manager ausführen, um die Binärdateien von {{ site.data.keys.mf_server }} zu installieren und die
MobileFirst-Server-Anwendungen in einem Anwendungsserver auf Ihrem Computer zu implementieren. Die Dateien und Tools, die vom Installationsprogramm installiert werden, sind unter [Verteilerweg von {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server) beschrieben. 

Für die Ausführung des Installationsprogramms für {{ site.data.keys.mf_server }} benötigen
Sie IBM Installation
Manager ab Version 1.8.4.
Sie können das Programm im grafischen Modus oder im Befehlszeilenmodus ausführen.   
Zwei Hauptoptionen werden während des Installationsprozesses vorgeschlagen:

* Aktivierung der Tokenlizenzierung
* Installation und Implementierung des {{ site.data.keys.mf_app_center }}

### Tokenlizenzierung
{: #token-licensing }
Die Tokenlizenzierung ist eine der beiden von
{{ site.data.keys.mf_server }} unterstützten Lizenzierungsmethoden.
Sie müssen festlegen, ob die Tokenlizenzierung aktiviert werden soll. Wenn in Ihrem Vertrag keine Tokenlizenzierung mit
Rational License
Key Server vereinbart ist, aktivieren Sie die Tokenlizenzierung nicht. Wenn Sie die Tokenlizenzierung aktivieren, müssen Sie
{{ site.data.keys.mf_server }} für die Tokenlizenzierung konfigurieren. Weitere Informationen finden Sie unter
[Installation und
Konfiguration für die Tokenlizenzierung](../token-licensing).

### {{ site.data.keys.mf_app_center_full }}
{: #ibm-mobilefirst-foundation-application-center }
Das Application Center ist eine Komponente der {{ site.data.keys.product }}.
Das Application
Center ist ein Repository mit mobilen Anwendungen, über das Sie mobile Anwendungen, die gerade entwickelt werden, gemeinsam
nutzen können.


Wenn Sie das
Application Center mit dem
Installation Manager installieren, müssen Sie die Datenbank- und Anwendungsserverparameter angeben, die der
Installation Manager zum Konfigurieren der Datenbanken und zum Implementieren des
Application Center im Anwendungsserver
benötigt. Wenn Sie das Application Center nicht mit dem
Installation Manager installieren, speichert der Installation Manager die WAR-Datei und die Ressourcen für das
Application Center auf der Festplatte. Er richtet weder die Datenbanken ein, noch implementiert
er die WAR-Datei des Application Center in Ihrem Anwendungsserver. Diese Schritte können Sie später mit Ant-Tasks oder
manuell ausführen. Wenn Sie die Installationsoption für das Application Center nutzen,
werden Sie vom grafischen Installationsassistenten durch den Installationsprozess geführt und haben ohne großen Aufwand die Möglichkeit,
das Application Center zu erkunden. 

Für eine Produktionsinstallation sollten Sie das
Application Center allerdings mit Ant-Tasks installieren.
Bei der Installation mit Ant-Tasks können Sie die Aktualisierungen für
{{ site.data.keys.mf_server }} von den Aktualisierungen für das
Application Center entkoppeln. 

* Vorteile bei Installation des Application Center mit dem
Installation Manager: 
    * Ein grafischer Assistent führt Sie durch den Installations- und Implementierungsprozess. 
* Nachteile bei Installation des Application Center mit dem
Installation Manager: 
    * Wenn der Installation Manager unter UNIX oder Linux vom Benutzer root ausgeführt wird,
erstellt er im Verzeichnis des Anwendungsservers, in dem das
Application Center implementiert ist, Dateien, deren Eigner root ist. Aus dem Grunde müssen Sie den Anwendungsserver
als root ausführen. 
    * Sie haben keinen Zugriff auf die Datenbankscripts
und können sie nicht Ihrem Datenbankadministrator zur Verfügung stellen, damit er
die Tabellen erstellen kann, bevor Sie das Installationsverfahren ausführen. Der Installation Manager erstellt für Sie die Datenbanktabellen mit Standardeinstellungen.
    * Jedes Mal, wenn Sie ein Upgrade für das Produkt durchführen (wenn Sie beispielsweise einen vorläufigen Fix installieren),
wird zuerst ein Upgrade für das Application Center durchgeführt. Während des Upgrades für das
Application Center werden Operationen für die Datenbank und den Anwendungsserver
ausgeführt. Wenn das Upgrade für das
Application Center fehlschlägt, hindert es den Installation Manager daran, das Upgrade fortzusetzen, sodass
kein Upgrade für die übrigen MobileFirst-Server-Komponenten durchgeführt werden kann.
Implementieren Sie das Application Center für eine Produktionsinstallation nicht mit dem
Installation Manager. Installieren Sie das Application Center separat mit Ant-Tasks, nachdem
der Installation Manager {{ site.data.keys.mf_server }} installiert hat.
Weitere Informationen zum Application Center finden Sie unter [Application Center installieren und konfigurieren](../../../appcenter).

> **Wichtiger Hinweis:** Das Installationsprogramm für {{ site.data.keys.mf_server }} installiert nur die
Binärdateien und Tools für {{ site.data.keys.mf_server }} auf der Platte. Es implementiert nicht die
MobileFirst-Server-Anwendungen in Ihrem Anwendungsserver. Wenn Sie die Installation mit dem Installation
Manager ausgeführt haben, müssen Sie die Datenbanken einrichten und
die MobileFirst-Server-Anwendungen in Ihrem Anwendungsserver implementieren.   
> Wenn Sie für eine vorhandene Installation ein Update mit dem Installation Manager durchführen, werden auch nur die Dateien auf der Platte aktualisiert. Für die Aktualisierung der in Ihren Anwendungsservern implementierten Anwendungen sind weitere Schritte erforderlich.

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }
* [Administratormodus und Benutzermodus im Vergleich](#administrator-versus-user-mode)
* [Installation mit dem Installationsassistenten von IBM Installation Manager](#installing-by-using-ibm-installation-manager-install-wizard)
* [Installation mit IBM Installation Manager über die Befehlszeile](#installing-by-running-ibm-installation-manager-in-command-line)
* [Installation mit XML-Antwortdateien - Unbeaufsichtigte Installation](#installing-by-using-xml-response-files---silent-installation)
* [Verteilerweg von {{ site.data.keys.mf_server }}](#distribution-structure-of-mobilefirst-server)

## Administratormodus und Benutzermodus im Vergleich
{: #administrator-versus-user-mode }
Sie können {{ site.data.keys.mf_server }}
in zwei verschiedenen IBM Installation-Manager-Modi installieren. Der Modus hängt davon ab, wie IBM Installation
Manager selbst installiert wurde. Durch den Modus werden die Verzeichnisse und Befehle bestimmt, die Sie für den
Installation Manager und für Pakete verwenden. 

Die {{ site.data.keys.product }} unterstützt die folgenden
Installation-Manager-Modi: 

* Administratormodus
* Benutzermodus (Benutzer ohne Administratorberechtigung)

Der unter
Linux oder UNIX verfügbare Gruppenmodus wird nicht vom Produkt unterstützt. 

### Administratormodus
{: #administrator-mode }
Im Administratormodus muss der Installation Manager unter
Linux oder UNIX als root
und unter Windows mit Administratorberechtigung ausgeführt werden. Die Repository-Dateien des
Installation Manager (d. h. die Liste der installierten Software mit den jeweiligen Versionen) werden in einem Systemverzeichnis
installiert: /var/ibm unter
Linux oder UNIX
und ProgramData unter Windows. Implementieren Sie das
Application Center nicht mit dem
Installation Manager, wenn Sie den Installation Manager im Administratormodus ausführen. 

### Benutzermodus (Benutzer ohne Administratorberechtigung)
{: #user-nonadministrator-mode }
Im Benutzermodus kann der Installation Manager von jedem Benutzer ohne besondere Berechtigungen ausgeführt
werden. Die Repository-Dateien des Installation
Manager werden allerdings im Ausgangsverzeichnis des Benutzers gespeichert. Daher kann nur dieser Benutzer ein Upgrade für die Produktinstallation
durchführen. Wenn Sie den
Installation Manager nicht als root ausführen, benötigen Sie ein Benutzerkonto, das später verfügbar ist, um ein Upgrade für die Produktinstallation
durchzuführen oder einen vorläufigen Fix anzuwenden. 

Weitere Informationen zu den Installation-Manager-Modi
finden Sie in der Dokumentation zu IBM Installation
Manager unter [Installing as an administrator, nonadministrator,
or group](http://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_admin_nonadmin.html?lang=en&view=kc). 

## Installation mit dem Installationsassistenten von IBM Installation Manager
{: #installing-by-using-ibm-installation-manager-install-wizard }
Führen Sie die beschriebenen Schritte aus, um die Ressourcen von
{{ site.data.keys.mf_server }}
und die Tools (z. B. das Server Configuration Tool,
Ant und das Programm mfpadm) zu installieren.   
Die Entscheidungen in den beiden folgenden Teilfenstern des
Installationsassistenten sind obligatorisch. 

* Fenster **Allgemeine Einstellungen**
* Fenster **Konfiguration wählen** für die Installation des Application Center

1. Starten Sie den Installation Manager. 
2. Fügen Sie das MobileFirst-Server-Repository im
Installation Manager hinzu. 
    * Navigieren Sie zu **Datei → Benutzervorgaben** und klicken Sie auf **Repositorys hinzufügen...**
    * Navigieren Sie in dem Verzeichnis, in dem Sie das Installationsprogramm entpackt haben, zur Repository-Datei. 

        Wenn Sie die ZIP-Datei für {{ site.data.keys.mf_server }} von
{{ site.data.keys.product }} Version 8.0 im Ordner
**Verzeichnis_mit_dem_MFP-Installationsprogramm** enptpackt haben, befindet sich die Repository-Datei unter
**Verzeichnis_mit_dem_MFP-Installationsprogramm/MobileFirst\_Platform\_Server/disk1/diskTag.inf**. 

        Vielleicht möchten Sie ja auch das neueste Fixpack anwenden, das vom
[IBM Support Portal](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation) heruntergeladen werden kann. Vergessen Sie nicht, das Repository für das Fixpack einzugeben.
Wenn Sie das Fixpack im Ordner **Fixpackverzeichnis** entpackt haben, befindet sich die Repository-Datei unter **Fixpackverzeichnis/MobileFirst\_Platform\_Server/disk1/diskTag.inf**. 

        **Hinweis:** Sie können das Fixpack nur installieren, wenn
sich das Repository der Basisversion unter den Installation-Manager-Repositorys befindet. Die Fixpacks sind inkrementelle Installationsprogramme, für die das Repository der Basisversion installiert sein muss.     * Wählen Sie die Datei aus und klicken Sie auf **OK**.
    * Klicken Sie auf
**OK**, um
das Fenster
**Benutzervorgaben** zu schließen.
3. Wenn Sie die Lizenzbedingungen für das Produkt akzeptiert haben, klicken Sie auf **Weiter**.
4. Wählen Sie die Paketgruppe für die Produktinstallation aus. 

    {{ site.data.keys.product }} Version 8.0
ist ein Ersatz für die Vorgängerreleases, die einen anderen Installationsnamen haben: 
    * Worklight für Version 5.0.6 
    * IBM Worklight für Version 6.0 bis 6.3
    
    Wenn eine dieser älteren Produktversionen auf Ihrem Computer installiert ist,
bietet der Installation Manager zu beginn des Installationsprozesses die Option
Vorhandene Paketgruppe verwenden an. Bei Auswahl dieser Option wird die ältere Version des Produkts deinstalliert.
Falls das {{ site.data.keys.mf_app_center_full }} installiert war,
werden die Installationsoptionen der bisherigen Installation verwendet, um ein Upgrade für das Application Center durchzuführen. 
    
    Wählen Sie für eine separate Installation die Option
Neue Paketgruppe erstellen aus. In dem Fall können Sie die neue Version installieren und die ältere Version beibehalten.   
Wenn Sie das Produkt in einer neuen Paketgruppe installieren möchten und auf Ihrem Computer keine andere Version des Produkts installiert
ist, wählen Sie die Option
Neue Paketgruppe erstellen aus. 
    
5. Klicken Sie auf **Weiter**.
6. Entscheiden Sie im Fenster **Allgemeine Einstellungen** im Abschnitt **Activate Token Licensing**,
ob die Tokenlizenzierung aktiviert werden soll. 

Wenn Sie die Tokenlizenzierung mit
Rational License Key Server vertraglich vereinbart haben, wählen Sie die Option **Activate token licensing with the Rational License Key Server** aus.
Nach dem Aktivieren der Tokenlizenzierung müssen Sie zusätzliche Konfigurationsschritte für
{{ site.data.keys.mf_server }} ausführen.
Fahren Sie andernfalls mit der Auswahl der Option
**Do not activate token licensing with the Rational License Key Server** fort.
7. Übernehmen Sie im Fenster **Allgemeine Einstellungen** im Abschnitt
**{{ site.data.keys.product }} für iOS installieren** die Standardoption (Nein). 
8. Entscheiden Sie im Fenster
**Konfiguration wählen**, ob
das Application Center installiert werden soll. 

    Für eine Produktionsinstallation sollten Sie das
Application Center mit Ant-Tasks installieren.
Bei der Installation mit Ant-Tasks können Sie die Aktualisierungen für
{{ site.data.keys.mf_server }} von den Aktualisierungen für das
Application Center entkoppeln. Wählen Sie in dem Fall
im Auswahlfenster für die Konfiguration
die Option Nein aus, damit das
Application Center nicht installiert wird. 

Wenn Sie Ja auswählen, müssen Sie in den folgenden Fenstern Angaben zur geplanten Datenbank und zu dem für die Implementierung des Application Center geplanten Anwendungsserver machen. Außerdem muss der JDBC-Treiber für Ihre Datenbank verfügbar sein. 9. Klicken Sie auf **Weiter**, bis die Anzeige **Thank
You** erscheint. Führen Sie dann die Installation aus. 

Ein Installationsverzeichnis mit den Ressourcen für die Installation der
{{ site.data.keys.product_adj }}-Komponenten wurde erstellt. 

Sie finden die Ressourcen in folgenden Ordnern: 

* Ordner **MobileFirstServer** für {{ site.data.keys.mf_server }}
* Ordner **PushService** für den MobileFirst-Server-Push-Service 
* Ordner **ApplicationCenter** für das Application Center
* Ordner **Analytics** für {{ site.data.keys.mf_analytics }}

Im Ordner **shortcuts** finden Sie einige Verknüpfungen für den Direktaufruf des
Server Configuration Tool,
von Ant und des Programms mfpadm. 

## Installation mit IBM Installation Manager über die Befehlszeile
{: #installing-by-running-ibm-installation-manager-in-command-line }

1. Lesen Sie die Lizenzvereinbarung für {{ site.data.keys.mf_server }} durch. Sie können die Lizenzdateien anzeigen, wenn Sie das Installationsrepository über
Passport
Advantage heruntergeladen haben.
2. Entpacken Sie die komprimierte Datei mit dem heruntergeladenen MobileFirst-Server-Repository
in einem Ordner. 

    Sie können das Repository über [IBM
Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm) aus der eAssembly für
die {{ site.data.keys.product }}
herunterladen.
Das Paket hat den Namen **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} .zip file of Installation Manager Repository for IBM MobileFirst Platform Server**.

In den folgenden Schritten wird für das Verzeichnis, in das Sie das Installationsprogramm extrahieren, die Bezeichnung
**MFP-Repositoryverzeichnis** verwendet.
Es enthält einen Ordner **MobileFirst_Platform_Server/disk1**.
3. Öffnen Sie eine Befehlszeile und navigieren Sie zu dem Verzeichnis **Installation-Manager-Installationsverzeichnis/tools/eclipse/**. 

    Wenn Sie die in Schritt 1
durchgelesene Lizenzvereinbarung akzeprtiert haben,
können Sie {{ site.data.keys.mf_server }} installieren.
    * Wenn in Ihrem Vertrag keine Tokenlizenzierung vereinbart wurde und Sie also
eine Installation ohne Durchsetzung der Tokenlizenzierung ausführen, geben Sie den folgenden Befehl ein: 

      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories MFP-Repositoryverzeichnis/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense
      ```
    * Für eine Installation mit Durchsetzung der Tokenlizenzierung müssten Sie den folgenden Befehl eingeben: 
    
      ```bash
      imcl install com.ibm.mobilefirst.foundation.server -repositories MFP-Repositoryverzeichnis/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=true,user.use.ios.edition=false -acceptLicense
      ```
    
        Die
Eigenschaft
**user.licensed.by.tokens** ist auf den Wert
**true** gesetzt. Sie müssen {{ site.data.keys.mf_server }} für die
[Tokenlizenzierung](../token-licensing) konfigurieren. 
        
        Die folgenden Eigenschaften sind
für eine Installation von
{{ site.data.keys.mf_server }}
ohne das Application Center definiert: 
        * **user.appserver.selection2**=none
        * **user.database.selection2**=none
        * **user.database.preinstalled**=false
        
        Die folgende Eigenschaft gibt an, ob die Tokenlizenzierung aktiviert ist:
**user.licensed.by.tokens=true/false**.
        
        Setzen Sie die Eigenschaft user.use.ios.edition für die Installation der {{ site.data.keys.product }} auf "false". 
        
5. Wenn Sie mit den neuesten vorläufigen Fix installieren wollen, fügen Sie das Repository für den vorläufigen Fix mit dem Parameter
**-repositories** hinzu. Der Parameter **-repositories** akzeptiert eine Liste mit Repositorys, die jeweils durch ein Komma getrennt angegeben werden müssen. 

    Fügen Sie die Version des vorläufigen Fix hinzu.
Ersetzen Sie dazu **com.ibm.mobilefirst.foundation.server** durch **com.ibm.mobilefirst.foundation.server_Version**. **Version** hat das Format **8.0.0.0-Buildnummer**. Wenn Sie beispielsweise den vorläufigen Fix **8.0.0.0-IF201601031015** installieren möchten, geben Sie den
folgenden Befehl ein: `imcl install com.ibm.mobilefirst.foundation.server_8.0.0.00-201601031015 -repositories...`
    
    Weitere Informationen zu dem imcl-Befehl finden Sie unter
[Installation Manager: Installing packages by using `imcl` commands](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.8.4/com.ibm.cic.commandline.doc/topics/t_imcl_install.html?lang=en).
    
Ein Installationsverzeichnis mit den Ressourcen für die Installation der
{{ site.data.keys.product_adj }}-Komponenten wurde erstellt. 

Sie finden die Ressourcen in folgenden Ordnern: 

* Ordner **MobileFirstServer** für {{ site.data.keys.mf_server }}
* Ordner **PushService** für den MobileFirst-Server-Push-Service 
* Ordner **ApplicationCenter** für das Application Center
* Ordner **Analytics** für {{ site.data.keys.mf_analytics }}    

Im Ordner **shortcuts** finden Sie einige Verknüpfungen für den Direktaufruf des
Server Configuration Tool,
von Ant und des Programms mfpadm. 

## Installation mit XML-Antwortdateien - Unbeaufsichtigte Installation
{: #installing-by-using-xml-response-files---silent-installation }
Wenn Sie das
{{ site.data.keys.mf_app_center_full }}
mit IBM Installation Manager über die Befehlszeile installieren möchten, müssen Sie eine lange Liste von Argumenten
angeben. Stellen Sie diese Argumente mit XML-Antwortdateien bereit. 

Unbeaufsichtigte Installationen werden in einer XML-Datei definiert, die Antwortdatei genannt wird. Diese Datei enthält die erforderlichen Daten, um die
Installationsoperationen im unbeaufsichtigten Modus erfolgreich auszuführen. Unbeaufsichtigte Installationen werden über die Befehlszeile oder über eine Stapeldatei gestartet. 

Mit dem Installation
Manager können Sie bestimmte Vorgaben und Installationsaktionen für Ihre Antwortdatei im Benutzerschnittstellenmodus aufzeichnen. Alternativ dazu können Sie anhand der dokumentierten Liste der Antwortdateibefehle und
-vorgaben eine Antwortdatei manuell erstellen.

Die unbeaufsichtigte Installation
ist in der Benutzerdokumentation zum
Installation Manager unter [Im unbeaufsichtigten Modus arbeiten](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silentinstall_overview.html)
beschrieben. 

Es gibt zwei Methoden für die Erstellung einer geeigneten Antwortdatei:

* Sie können mit den in der {{ site.data.keys.product_adj }}-Benutzerdokumentation
bereitgestellten Beispielantwortdateien arbeiten.
* Sie können mit einer Antwortdatei arbeiten, die auf einem anderen Computer aufgezeichnet wurde.

Beide Methoden sind in den folgenden Abschnitten dokumentiert.

### Mit Beispielantwortdateien für IBM Installation Manager arbeiten
{: #working-with-sample-response-files-for-ibm-installation-manager }
Beispielantwortdateien für IBM Installation Manager werden in der komprimierten Datei
**Silent\_Install\_Sample_Files.zip** bereitgestellt.
Die folgenden Prozeduren beschreiben die Verwendung dieser Dateien. 

1. Wählen Sie die geeignete Beispielantwortdatei aus der komprimierten Datei aus. Die Datei Silent_Install_Sample_Files.zip enthält ein Unterverzeichnis für jedes Release.

    > **Wichtiger Hinweis:**  
    > 
    > * Für eine Installation, bei der das Application Center nicht in einem Anwendungsserver installiert wird, verwenden Sie die Datei **install-no-appcenter.xml**.
    > * Für eine Installation, bei der das Application Center installiert wird, wählen Sie die Beispielantwortdatei basierend auf Ihrem Anwendungsserver und Ihrer Datenbank in der folgenden Tabelle aus.

   #### Beispielantwortdateien für die Installation des Application Center in der Datei **Silent\_Install\_Sample_Files.zip**
    
    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Anwendungsserver, in dem das Application Center installiert wird</th>
            <th>Derby</th>
            <th>IBM DB2</th>
            <th>MySQL</th>
            <th>Oracle</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Liberty Profile</td>
            <td>install-liberty-derby.xml</td>
            <td>install-liberty-db2.xml</td>
            <td>install-liberty-mysql.xml (siehe Hinweis)</td>
            <td>install-liberty-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Full Profile, eigenständiger Server</td>
            <td>install-was-derby.xml</td>
            <td>install-was-db2.xml</td>
            <td>install-was-mysql.xml (siehe Hinweis)</td>
            <td>install-was-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>WebSphere Application Server Network Deployment</td>
            <td>nicht zutreffend</td>
            <td>install-wasnd-cluster-db2.xml, install-wasnd-server-db2.xml, install-wasnd-node-db2.xml, install-wasnd-cell-db2.xml</td>
            <td>install-wasnd-cluster-mysql.xml (siehe Hinweis), install-wasnd-server-mysql.xml (siehe Hinweis), install-wasnd-node-mysql.xml, install-wasnd-cell-mysql.xml (siehe Hinweis)</td>
            <td>install-wasnd-cluster-oracle.xml, install-wasnd-server-oracle.xml, install-wasnd-node-oracle.xml, install-wasnd-cell-oracle.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Apache Tomcat</td>
            <td>install-tomcat-derby.xml</td>
            <td>install-tomcat-db2.xml</td>
            <td>install-tomcat-mysql.xml</td>
            <td>install-tomcat-oracle.xml</td>
        </tr>
    </table>
    
    > **Hinweis:** MySQL
in Kombination mit WebSphere Application Server Liberty
Profile oder WebSphere Application Server Full Profile ist keine unterstützte Konfiguration. Weitere Informationen finden Sie unter [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Sie können IBM DB2 oder ein anderes von WebSphere Application Server unterstütztes Datenbankmanagementsystem (DBMS) verwenden, um die Vorteile einer Konfiguration zu nutzen, die vollständig vom IBM Support unterstützt wird.

    Für die Deinstallation müssen Sie eine Beispieldatei verwenden, die von der Version von {{ site.data.keys.mf_server }} oder Worklight Server abhängt, die Sie ursprünglich in der entsprechenden Paketgruppe installiert haben:
    
    * {{ site.data.keys.mf_server }} verwendet die Paketgruppe {{ site.data.keys.mf_server }}.
    * Worklight Server ab Version 6.x verwendet die Paketgruppe IBM Worklight.
    * Worklight Server Version 5.x verwendet die Paketgruppe Worklight.

    <table>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <th>Erste Version von {{ site.data.keys.mf_server }}</th>
            <th>Beispieldatei</th>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server Version 5.x</td>
            <td>uninstall-initially-worklightv5.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>Worklight Server Version 6.x</td>
            <td>uninstall-initially-worklightv6.xml</td>
        </tr>
        <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
            <td>IBM MobileFirst Server ab Version 6.x</td>
            <td>uninstall-initially-mfpserver.xml</td>
        </tr>
    </table>

2. Ändern Sie die Dateizugriffsrechte für die Beispieldatei, indem Sie sie so weit wie möglich einschränken. In Schritt 4 müssen Sie einige Kennwörter eingeben.
Wenn andere Benutzer desselben Computers diese Kennwörter nicht erfahren sollen,
müssen Sie für die übrigen Benutzer
die Leseberechtigungen (read) für die Datei entfernen. Sie können einen Befehl wie in den folgenden Beispielen verwenden:
    * UNIX: `chmod 600 <Zieldatei>.xml`
    * Windows: `cacls <Zieldatei>.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. In ähnlicher Weise müssen Sie vorgehen, wenn Sie
einen Server mit WebSphere Application Server Liberty Profile
oder Apache Tomcat
verwenden und dieser nur über Ihren Benutzeraccount gestartet werden soll.
Entfernen Sie in diesem Fall die Leseberechtigungen
(read) für alle übrigen Benutzer aus der folgenden Datei:

    * WebSphere Application Server Liberty Profile: `wlp/usr/servers/<Server>/server.xml`
    * Apache Tomcat: `conf/server.xml`
4. Passen Sie die Liste der Repositorys im Element <server> an.
Informationen zu diesem Schritt finden Sie in der
Dokumentation zu IBM Installation Manager
unter [Repositorys](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/r_repository_types.html). 

Passen Sie die Werte für alle Schlüssel-Wert-Paare im Element `<profile>` an.  
Setzen Sie das Versionsattribut im Element `<offering>` im Element `<install>` auf das zu installierende Release oder entfernen Sie das Versionsattribut, wenn Sie die neueste verfügbare Version in den Repositorys installieren möchten.

5. Geben Sie den folgenden Befehl ein: `<Installation-Manager-Pfad>/eclipse/tools/imcl input <Antwortdatei>  -log /tmp/installwl.log -acceptLicense`

    Für diese Angabe gilt Folgendes: 
    * `<Installation-Manager-Pfad>` steht für das Installationsverzeichnis von IBM Installation Manager.
    * `<Antwortdatei>` steht für den Namen der Datei, die Sie in Schritt 1 ausgewählt und aktualisiert haben.

> Weitere Informationen finden Sie in der Dokumentation zu IBM Installation
Manager im Abschnitt [Pakete unbeaufsichtigt mithilfe einer Antwortdatei installieren](http://ibm.biz/knowctr#SSDV2W_1.8.4/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).
    

### Mit einer Antwortdatei arbeiten, die auf einer anderen Maschine aufgezeichnet wurde
{: #working-with-a-response-file-recorded-on-a-different-machine }

1. Zum Aufzeichnen einer Antwortdatei
führen Sie
IBM Installation
Manager auf einer Maschine mit grafischer Benutzerschnittstelle im Assistentenmodus mit der Option
`-record Antwortdatei` aus. Ausführliche Informationen hierzu finden Sie unter
[Antwortdatei mit Installation Manager aufzeichnen](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html).

2. Ändern Sie die Dateizugriffsrechte für die Antwortdatei, indem Sie sie so weit wie möglich einschränken. In Schritt 4 müssen Sie einige Kennwörter eingeben.
Wenn andere Benutzer desselben Computers diese Kennwörter nicht erfahren sollen,
müssen Sie für die übrigen Benutzer
die Leseberechtigungen (**read**) für die Datei entfernen. Sie können einen Befehl wie in den folgenden Beispielen verwenden:
    * UNIX: `chmod 600 Antwortdatei.xml`
    * Windows: `cacls Antwortdatei.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`
3. In ähnlicher Weise müssen Sie vorgehen, wenn Sie
einen Server mit WebSphere Application Server Liberty
oder Apache Tomcat
verwenden und dieser nur über Ihren Benutzeraccount gestartet werden soll.
Entfernen Sie in diesem Fall die Leseberechtigungen
(read) für alle übrigen Benutzer aus der folgenden Datei:

    * WebSphere Application Server Liberty: `wlp/usr/servers/<Server>/server.xml`
    * Apache Tomcat: `conf/server.xml`
4. Ändern Sie die Antwortdatei, um die Unterschiede zwischen der Maschine, auf der die Antwortdatei erstellt wurde, und der Zielmaschine
zu berücksichtigen. 
5. Installieren Sie {{ site.data.keys.mf_server }} unter Verwendung
der Antwortdatei auf der Zielmaschine gemäß der Beschreibung im Abschnitt
[Pakete unbeaufsichtigt mithilfe einer Antwortdatei installieren](http://ibm.biz/knowctr#SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html).

### Befehlszeilenparameter (unbeaufsichtigte Installation)
{: #command-line-silent-installation-parameters }
<table style="word-break:break-all">
    <tr>
        <th>Parameter</th>
        <th>Wann erforderlich</th>
        <th>Beschreibung</th>
        <th>Zulässige Werte</th>
    </tr>
    <tr>
        <td>user.use.ios.edition</td>
        <td>Immer</td>
        <td>Legen Sie den Wert <code>false</code> fest, wenn Sie die {{ site.data.keys.product }} installieren möchten. Falls Sie die Produktedition für iOS installieren möchten, müssen Sie den Parameter auf den Wert
<code>true</code> setzen.</td>
        <td><code>true</code> oder <code>false</code></td>
    </tr>
    <tr>
        <td>user.licensed.by.tokens</td>
        <td>Immer</td>
        <td>Aktivierung der Tokenlizenzierung. Wenn Sie das Produkt mit
Rational License
Key Server verwenden möchten, müssen Sie die Tokenlizenzierung aktivieren. <br/><br/>Setzen Sie den Parameter in diesem Fall auf
<code>true</code>. Wenn Sie das Produkt mit dem Rational
License Key Server verwenden wollen, setzen Sie den Parameter auf <code>false</code>. <br/><br/>Wenn Sie Lizenztoken aktivieren, sind nach der Implementierung des Produkts in einem
Anwendungsserver bestimmte Konfigurationsschritte erforderlich. </td>
        <td><code>true</code> oder <code>false</code></td>    
    </tr>
    <tr>
        <td>user.appserver.selection2</td>
        <td>Immer</td>
        <td>Typ des Anwendungsservers. Der Wert was bedeutet, dass
WebSphere Application Server 8.5.5 vorinstalliert ist. Der Wert
tomcat bedeutet Tomcat
7.0. </td>
        <td></td>
    </tr>
    <tr>
        <td>user.appserver.was.installdir</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Installationsverzeichnis von WebSphere Application Server</td>
        <td>Ein absoluter Verzeichnisname</td>
    </tr>
    <tr>
        <td>user.appserver.was.profile</td>
        <td>${user.appserver.selection2} == was</td>
        <td>Profil, in dem die Anwendungen installiert werden sollen.
Geben Sie für
WebSphere Application Server Network Deployment das Deployment-Manager-Profil an. Liberty steht für
Liberty Profile (Unterverzeichnis wlp).</td>
        <td>Der Name eines der WebSphere-Application-Server-Profile</td>
    </tr>
    <tr>
        <td>user.appserver.was.cell</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>WebSphere-Application-Server-Zelle, in der die Anwendungen installiert werden sollen</td>
        <td>Name der WebSphere-Application-Server-Zelle</td>
    </tr>
    <tr>
        <td>user.appserver.was.node</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>WebSphere-Application-Server-Knoten, auf dem die Anwendungen installiert werden sollen. Dieser Knoten entspricht der aktuellen Maschine.</td>
        <td>Name des WebSphere-Application-Server-Knotens der aktuellen Maschine</td>
    </tr>
    <tr>
        <td>user.appserver.was.scope</td>
        <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
        <td>Der Typ der Server, in denen die Anwendungen installiert werden sollen. <br/><br/>Der Wert <code>server</code> bedeutet eigenständiger Server. <br/><br/>Der Wert
<code>nd-cell</code> bedeutet
WebSphere-Application-Server-Network-Deployment-Zelle. Der Wert <code>nd-cluster</code> bedeutet WebSphere-Application-Server-Network-Deployment-Cluster. <br/><br/>Der Wert <code>nd-node</code> beduetet WebSphere-Application-Server-Network-Deployment-Knoten
(ausgenommen Cluster). <br/><br/>Der Wert <code>nd-server</code> bedeutet verwalteter
Server mit WebSphere Application Server Network Deployment. </td>
        <td><code>server</code>, <code>nd-cell</code>, <code>nd-cluster</code>, <code>nd-node</code>, <code>nd-server</code></td>
    </tr>
    <tr>
      <td>user.appserver.was.serverInstance</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== server</td>
      <td>Name des WebSphere Application Server, in dem die Anwendungen installiert werden sollen</td>
      <td>Name eines WebSphere Application Server auf der aktuellen
Maschine</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.cluster</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-cluster</td>
      <td>Name des WebSphere-Application-Server-Network-Deployment-Clusters, in dem die Anwendungen installiert werden sollen</td>
      <td>Name des WebSphere-Application-Server-Network-Deployment-Clusters in der WebSphere-Application-Server-Zelle</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.node</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && (${user.appserver.was.scope}
== nd-node || ${user.appserver.was.scope} == nd-server)</td>
      <td>Name des WebSphere-Application-Server-Network-Deployment-Knotens, auf dem die Anwendungen installiert werden sollen</td>
      <td>Name des WebSphere-Application-Server-Network-Deployment-Knotens in der WebSphere-Application-Server-Zelle</td>
    </tr>
    <tr>
      <td>user.appserver.was.nd.server</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty && ${user.appserver.was.scope}
== nd-server</td>
      <td>Name des Servers mit WebSphere Application Server Network Deployment, auf dem die Anwendungen installiert werden sollen</td>
      <td>Name Servers mit WebSphere Application Server Network Deployment auf dem gegebenen WebSphere-Application-Server-Network-Deployment-Knoten</td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.name</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>Name eines WebSphere-Application-Server-Administrators</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.admin.password2</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>Kennwort des WebSphere-Application-Server-Administrators, das optional in einer bestimmten Art und Weise verschlüsselt ist</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.appcenteradmin.password</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>Kennwort des Benutzers <code>appcenteradmin</code>, der der Liste
der WebSphere-Application-Server-Benutzer hinzugefügt werden soll, optional in einer bestimmten Art und Weise verschlüsselt</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.was.serial</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} != Liberty</td>
      <td>Suffix, das die zu installierenden Anwendungen von anderen
MobileFirst-Server-Installationen unterscheidet</td>
      <td>Zeichenfolge aus 10 Dezimalziffern</td>
    </tr>
    <tr>
      <td>user.appserver.was85liberty.serverInstance_</td>
      <td>${user.appserver.selection2} == was &&
${user.appserver.was.profile} == Liberty</td>
      <td>Name des Servers mit WebSphere Application Server Liberty, auf dem die Anwendungen installiert werden sollen</td>
      <td></td>
    </tr>
    <tr>
      <td>user.appserver.tomcat.installdir</td>
      <td>${user.appserver.selection2} == tomcat</td>
      <td>Apache Tomcat-Installationsverzeichnis. Für eine
Tomcat-Installation, die auf das Ausgangsverzeichnis
<b>CATALINA_HOME</b> und das Basisverzeichnis <b>CATALINA_BASE</b> aufgeteilt ist,
müssen Sie hier den Wert der Umgebungsvariablen
<b>CATALINA_BASE</b> angeben.</td>
      <td>Ein absoluter Verzeichnisname</td>
    </tr>
    <tr>
      <td>user.database.selection2</td>
      <td>Immer</td>
      <td>Typ des Datenbankmanagementsystems, das zum Speichern der Datenbanken verwendet wird</td>
      <td><code>derby</code>, <code>db2</code>, <code>mysql</code>, <code>oracle</code>, <code>none</code>. Der Wert
"none" bedeutet, dass das Installationsprogramm
das Application Center nicht installiert. Wenn dieser Wert angegeben wird, müssen sowohl der Parameter
<b>user.appserver.selection2</b> als auch der Parameter <b>user.database.selection2</b> den Wert none verwenden.</td>
    </tr>
    <tr>
      <td>user.database.preinstalled</td>
      <td>Immer</td>
      <td><code>true</code> bedeutet ein vorinstalliertes Datenbankmanagementsystem,
<code>false</code> bedeutet, dass Apache Derby installiert werden soll.</td>
      <td><code>true</code>, <code>false</code></td>
    </tr>
    <tr>
      <td>user.database.derby.datadir</td>
      <td>${user.database.selection2} == derby</td>
      <td>Das Verzeichnis, in dem die Derby-Datenbanken erstellt werden sollen oder bereits vorhanden sind</td>
      <td>Ein absoluter Verzeichnisname</td>
    </tr>
    <tr>
      <td>user.database.db2.host</td>
      <td>${user.database.selection2} == db2</td>
      <td>Der Hostname oder die IP-Adresse des DB2-Datenbankservers</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.db2.port</td>
      <td>${user.database.selection2} == db2</td>
      <td>Der Port, den
der DB2-Datenbankserver auf JDBC-Verbindungen überwacht.
Normalerweise 50000.</td>
      <td>Eine Zahl zwischen 1 und 65535</td>
    </tr>
    <tr>
      <td>user.database.db2.driver</td>
      <td>${user.database.selection2} == db2</td>
      <td>Der absolute Dateiname von db2jcc4.jar</td>
      <td>Ein absoluter Dateiname</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.username</td>
      <td>${user.database.selection2} == db2</td>
      <td>Benutzername für den Zugriff auf die DB2-Datenbank für das Application Center</td>
      <td>Nicht leer</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.password</td>
      <td>${user.database.selection2} == db2</td>
      <td>Optional in einer bestimmten Art und Weise verschlüsseltes Kennwort für den Zugriff auf die DB2-Datenbank für das Application Center</td>
      <td>Ein Kennwort, das nicht leer ist</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.dbname</td>
      <td>${user.database.selection2} == db2</td>
      <td>Name der DB2-Datenbank für das Application Center</td>
      <td>Ein gültiger, nicht leerer DB2-Datenbankname</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Gibt an, ob <b>user.database.mysql.appcenter.dbname</b> ein Sevicename oder SID-Name ist. Fehlt der Parameter, wird
<b>user.database.mysql.appcenter.dbname</b> als SID-Name
betrachtet. </td>
      <td><code>true</code> (für einen Servicenamen)
oder <code>false</code> (für einen SID-Namen)</td>
    </tr>
    <tr>
      <td>user.database.db2.appcenter.schema</td>
      <td>${user.database.selection2} == db2</td>
      <td>Name des Schemas für das Application Center
in der DB2-Datenbank</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.host</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Der Hostname oder die IP-Adresse
des MySQL-Datenbankservers</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.mysql.port</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Der Port, den der MySQL-Datenbankserver auf JDBC-Verbindungen überwacht.
Normalerweise 3306.</td>
      <td>Eine Zahl zwischen 1 und 65535</td>
    </tr>
    <tr>
      <td>user.database.mysql.driver</td>
      <td>${user.database.selection2} == mysql</td>
      <td>Der absolute Dateiname von <b>mysql-connector-java-5.*-bin.jar</b></td>
      <td>Ein absoluter Dateiname</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Benutzername für den Zugriff auf die Oracle-Datenbank für das Application Center</td>
      <td>Eine aus 1 bis 30 Zeichen bestehende Zeichenfolge:
ASCII-Ziffern, ASCII-Buchstaben in Großschreibung und Kleinschreibung, '_', '#', '$' sind zulässig.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Optional in einer bestimmten Art und Weise verschlüsseltes Kennwort für den Zugriff auf
die Oracle-Datenbank für das Application Center
</td>
      <td>Das Kennwort muss eine aus 1 bis 30 Zeichen bestehende Zeichenfolge sein: ASCII-Ziffern, ASCII-Buchstaben in Großschreibung und Kleinschreibung, '_', '#', '$' sind zulässig.</td>
    </tr>
    <tr>
      <td>user.database.mysql.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, sofern nicht
${user.database.oracle.appcenter.jdbc.url} angegeben ist</td>
      <td>Name der Oracle-Datenbank für das Application Center</td>
      <td>Ein gültiger, nicht leerer Oracle-Datenbankname</td>
    </tr>
    <tr>
      <td>user.database.oracle.host</td>
      <td>${user.database.selection2} == oracle, sofern nicht
${user.database.oracle.appcenter.jdbc.url} angegeben ist</td>
      <td>Der Hostname oder die IP-Adresse des Oracle-Datenbankservers</td>
      <td></td>
    </tr>
    <tr>
      <td>user.database.oracle.port</td>
      <td>${user.database.selection2} == oracle, sofern nicht
${user.database.oracle.appcenter.jdbc.url} angegeben ist</td>
      <td>Der Port, den der Oracle-Datenbankserver auf JDBC-Verbindungen überwacht.
Normalerweise 1521.</td>
      <td>Eine Zahl zwischen 1 und 65535</td>
    </tr>
    <tr>
      <td>user.database.oracle.driver</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Der absolute Dateiname der Oracle-Thin-Driver-JAR-Datei (<b>ojdbc6.jar oder ojdbc7.jar</b>)</td>
      <td>Ein absoluter Dateiname</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Benutzername für den Zugriff auf die Oracle-Datenbank für das Application Center</td>
      <td>Eine aus 1 bis 30 Zeichen bestehende Zeichenfolge:
ASCII-Ziffern, ASCII-Buchstaben in Großschreibung und Kleinschreibung, '_', '#', '$' sind zulässig.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.username.jdbc</td>
      <td>	${user.database.selection2} == oracle</td>
      <td>Benutzername für den Zugriff auf die Oracle-Datenbank für
das Application Center in einer für JDBC geeigneten Syntax</td>
      <td>Wie ${user.database.oracle.appcenter.username}, wenn
der Name mit einem alphabetischen Zeichen beginnt und keine Kleinbuchstaben enthält. Andernfalls
${user.database.oracle.appcenter.username} in Anführungszeichen.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.password</td>
      <td>${user.database.selection2} == oracle</td>
      <td>Optional in einer bestimmten Art und Weise verschlüsseltes Kennwort für den Zugriff auf
die Oracle-Datenbank für das Application Center
</td>
      <td>Das Kennwort muss eine aus 1 bis 30 Zeichen bestehende Zeichenfolge sein: ASCII-Ziffern, ASCII-Buchstaben in Großschreibung und Kleinschreibung, '_', '#', '$' sind zulässig.</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.dbname</td>
      <td>${user.database.selection2} == oracle, sofern nicht
${user.database.oracle.appcenter.jdbc.url} angegeben ist</td>
      <td>Name der Oracle-Datenbank für das Application Center</td>
      <td>Ein gültiger, nicht leerer Oracle-Datenbankname</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.isservicename.jdbc.url</td>
      <td>Optional</td>
      <td>Gibt an, ob <code>user.database.oracle.appcenter.dbname</code> ein Sevicename oder SID-Name ist. Fehlt der Parameter, wird
<code>user.database.oracle.appcenter.dbname</code> als SID-Name
betrachtet. </td>
      <td><code>true</code> (für einen Servicenamen)
oder <code>false</code> (für einen SID-Namen)</td>
    </tr>
    <tr>
      <td>user.database.oracle.appcenter.jdbc.url</td>
      <td>${user.database.selection2} == oracle, sofern nicht
${user.database.oracle.host}, ${user.database.oracle.port} und ${user.database.oracle.appcenter.dbname} angegeben sind.</td>
      <td>JDBC-URL der Oracle-Datenbank für das
Application Center</td>
      <td>Eine gültige Oracle-JDBC-URL. Beginnt mit "jdbc:oracle:".</td>
    </tr>
    <tr>
      <td>user.writable.data.user</td>
      <td>Immer</td>
      <td>Der Betriebssystembenutzer, der den installierten Server ausführen darf.</td>
      <td>Ein Betriebssystembenutzername oder leer.</td>
    </tr>
    <tr>
      <td>user.writable.data.group2</td>
      <td>Immer</td>
      <td>Die Betriebssystembenutzergruppe, die den installierten Server ausführen darf.</td>
      <td>Der Name einer Betriebssystembenutzergruppe oder leer.</td>
    </tr>
</table>

## Verteilerweg von {{ site.data.keys.mf_server }}
{: #distribution-structure-of-mobilefirst-server }
Die Dateien und Tools für {{ site.data.keys.mf_server }} werden im Installationsverzeichnis von {{ site.data.keys.mf_server }} installiert.

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'Analytics'
{: #files-and-subdirectories-in-the-analytics-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **analytics.ear** und **analytics-*.war** | EAR- und WAR-Dateien für die Installation von {{ site.data.keys.mf_analytics }}|
| **configuration-samples** | Ant-Beispieldateien für die Installation von {{ site.data.keys.mf_analytics }} mit Ant-Tasks|

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'ApplicationCenter'
{: #files-and-subdirectories-in-the-applicationcenter-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **configuration-samples** | Ant-Beispieldateien für die Installation des Application Center. Die Ant-Tasks erstellen die Datenbanktabelle und implementieren WAR-Dateien in einem Anwendungsserver.| 
| **console** | EAR- und WAR-Dateien für die Installation des Application Center. Die EAR-Datei ist für IBM PureApplication System bestimmt.| 
| **databases** | SQL-Scripts zum manuellen Erstellen von Tabellen für das Application Center|
| **installer** | Ressourcen für die Erstellung des Application-Center-Clients | 
| **tools** | Tools des Application Center| 

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'MobileFirstServer'
{: #files-and-subdirectories-in-the-mobilefirst-server-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **mfp-ant-deployer.jar** | Reihe von Ant-Tasks für {{ site.data.keys.mf_server }}|
| **mfp-*.war** | WAR-Dateien der MobileFirst-Server-Komponenten|
| **configuration-samples** | Ant-Beispieldateien für die Installation der MobileFirst-Server-Komponenten mit Ant-Tasks| 
| **ConfigurationTool** | Binärdateien des Server Configuration Tool. Das Tool wird im Verzeichnis **MFP-Server-Installationsverzeichnis/shortcuts** gestartet.|
| **databases** | SQL-Scripts zum manuellen Erstellen von Tabellen für die MobileFirst-Server-Komponenten (MobileFirst-Server-Verwaltungsservice und -Konfigurationsservice und {{ site.data.keys.product_adj }}-Laufzeit)| 
| **external-server-libraries** |  JAR-Dateien, die von verschiedenen Tools verwendet werden (z. B. dem Authentizitätstool und dem OAuth-Sicherheitstool)|

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'PushService'
{: #files-and-subdirectories-in-the-pushservice-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **mfp-push-service.war** | WAR-Datei für die Installation des MobileFirst-Server-Push-Service|
| **databases** | SQL-Scripts zum manuellen Erstellen von Tabellen für den MobileFirst-Server-Push-Service| 

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'License'
{: #files-and-subdirectories-in-the-license-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **Text** | Lizenz für die {{ site.data.keys.product }}| 

#### Dateien und Unterverzeichnisse im Installationsverzeichnis von {{ site.data.keys.mf_server }}
{: #files-and-subdirectories-in-the-mobilefirst-server-installation-directory }

| Element| Beschreibung |
|------|-------------|
| **shortcuts** | Starterscripts für Apache Ant, das Server Configuration Tool von und den Befehl mfpadmin, die mit {{ site.data.keys.mf_server }} bereitgestellt werden.| 

#### Dateien und Unterverzeichnisse im Unterverzeichnis 'tools'
{: #files-and-subdirectories-in-the-tools-subdirectory }

| Element| Beschreibung |
|------|-------------|
| **tools/apache-ant-version-number** | Vom Server Configuration Tool verwendete Binärdatei für die Installation von Apache Ant, mit der auch die Ant-Tasks ausgeführt werden können| 
