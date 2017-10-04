---
layout: tutorial
title: Lernprogramm zur Installation von MobileFirst Server über die Befehlszeile
weight: 0
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Verwenden Sie IBM Installation
Manager im Befehlszeilenmodus und Ant-Tasks, um
{{ site.data.keys.mf_server }} zu installieren.

#### Vorbereitungen
{: #before-you-begin }
* Stellen Sie sicher, das eine der folgenden Datenbanken und eine unterstützte Java-Version installiert sind. Auf Ihrem Computer
muss außerdem der entsprechende JDBC-Treiber für die Datenbank verfügbar sein. 
    * Database Management System (DBMS) aus der Liste der unterstützten Datenbanken: 
        * DB2 
        * MySQL
        * Oracle

        > **Wichtiger Hinweis:** Sie benötigen eine Datenbank, in der Sie die für das Produkt erforderlichen Tabellen erstellen können, und einen Datenbankbenutzer zum Erstellen der Tabellen.         Im Lernprogramm beziehen sich die Schritte für die Erstellung der Tabellen auf
DB2.
Das DB2-Installationsprogramm wird über IBM Passport
Advantage als Paket in der eAssembly für die
{{ site.data.keys.product }} bereitgestellt. 

* JDBC-Treiber für Ihre Datenbank
    * Verwenden Sie für DB2 den DB2-JDBC-Treibertyp 4.
    * Verwenden Sie für MySQL den Connector/J-JDBC-Treiber. 
    * Verwenden Sie für Oracle den Oracle-Thin-JDBC-Treiber. 
* Java ab Version 7

* Laden Sie das Installationsprogramm für
IBM Installation
Manager ab Version 1.8.4
über die [Installation Manager and Packaging Utility Download
Links herunter](http://www.ibm.com/support/docview.wss?uid=swg27025142). 
* Sie benötigen außerdem das Installationsrepository für {{ site.data.keys.mf_server }} und das
Installationsprogramm für WebSphere Application Server Liberty Core
ab Version 8.5.5.3. Laden Sie diese Pakete mit der eAssembly für die {{ site.data.keys.product }} über
Passport Advantage herunter. 

**Installationsrepository für {{ site.data.keys.mf_server }}**  
ZIP-Datei von {{ site.data.keys.product }} Version 8.0 mit dem Installation-Manager-Repository {{ site.data.keys.mf_server }}

**WebSphere Application Server Liberty Profile**  
IBM WebSphere Application Server Liberty
Core ab Version 8.5.5.3
    
#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [IBM Installation Manager installieren](#installing-ibm-installation-manager)
* [WebSphere Application Server Liberty Core installieren](#installing-websphere-application-server-liberty-core)
* [{{ site.data.keys.mf_server }} installieren](#installing-mobilefirst-server)
* [Datenbank erstellen](#creating-a-database)
* [{{ site.data.keys.mf_server }} mit Ant-Tasks in Liberty implementieren](#deploying-mobilefirst-server-to-liberty-with-ant-tasks)
* [Installation testen](#testing-the-installation)
* [Farm mit zwei Liberty-Servern für {{ site.data.keys.mf_server }} erstellen](#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server)
* [Farm testen und Änderungen in der {{ site.data.keys.mf_console }} anzeigen](#testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console)

## IBM Installation Manager installieren
{: #installing-ibm-installation-manager }
Sie müssen Installation Manager ab Version 1.8.4 installieren. Die älteren Versionen des
Installation Manager sind nicht in der Lage, {{ site.data.keys.product }} Version 8.0
zu installieren, da für den Installationsabschluss für das Produkt
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6. 

1. Entpacken Sie die heruntergeladene IBM Installation-Manager-Archivdatei. Sie können das Installationsprogramm über die
[Installation Manager and Packaging Utility Download
Links](http://www.ibm.com/support/docview.wss?uid=swg27025142) abrufen.
2. Lesen Sie die Lizenzvereinbarung für
IBM Installation Manager im Verzeichnis **Unzip-Verzeichnis_für_IM_1.8.x/license**. 
3. Wenn Sie nach der Überprüfung die Lizenzvereinbarung akzeptieren, installieren Sie Installation Manager.  
    * Führen Sie **installc.exe** aus, um den Installation
Manager als Administrator zu installieren. Unter Linux oder UNIX muss dieser Schritt vom Benutzer root ausgeführt werden.
Unter Windows ist die Administratorberechtigung erforderlich. In diesem Modus werden Informationen zu den installierten Paketen
an einer gemeinsam genutzten Plattenposition gespeichert, sodass jeder Benutzer, der berechtigt ist, den Installation Manager auszuführen, die Anwendungen aktualisieren kann. Der Name der
ausführbaren Datei für eine Befehlszeileninstallation ohne grafische Benutzerschnittstelle
endet mit "c" (**installc**).
Geben Sie für die Installation des Installation Manager **installc.exe -acceptLicence** ein.
    * Führen Sie **userinstc.exe** aus, um den Installation Manager im Benutzermodus
zu installieren. Es sind keine besonderen Berechtigungen erforderlich. In diesem Modus werden die Informationen zu
installierten Paketen allerdings im Ausgangsverzeichnis des Benutzers abgelegt. Die mit dem Installation Manager installierten Anwendungen können nur von diesem
Benutzer aktualisiert werden. Der Name der
ausführbaren Datei für eine Befehlszeileninstallation ohne grafische Benutzerschnittstelle
endet mit "c" (**userinstc**).
Geben Sie für die Installation des Installation Manager **userinstc.exe -acceptLicence** ein.
    
## WebSphere Application Server Liberty Core installieren
{: #installing-websphere-application-server-liberty-core }
Das Installationsprogramm für WebSphere Application Server Liberty Core wird mit dem Paket für die
{{ site.data.keys.product }}
bereitgestellt.
Mit den folgenden Schritten wird Liberty Profile installiert und eine Serverinstanz erstellt, in der Sie
{{ site.data.keys.mf_server }} installieren
können. 

1. Lesen Sie die Lizenzvereinbarung für WebSphere Application Server Liberty Core durch. Sie können die Lizenzdateien anzeigen, wenn Sie das Installationsprogramm über
Passport
Advantage heruntergeladen haben.
2. Entpacken Sie die heruntergeladene komprimierte Datei für WebSphere Application Server Liberty Core
in einem Ordner. 

    In den folgenden Schritten wird für das Verzeichnis, in das Sie das Installationsprogramm extrahieren, die Bezeichnung
**Liberty-Repositoryverzeichnis** verwendet.
Es enthält unter anderem eine Datei **repository.config** oder **diskTag.inf**. 

3. Entscheiden Sie, in welchem Verzeichnis Liberty Profile installiert werden soll. In den nächsten Schritten wird dieses Verzeichnis Liberty-Installationsverzeichnis genannt. 
4. Öffnen Sie eine Befehlszeile und navigieren Sie zu dem Verzeichnis **Installation-Manager-Installationsverzeichnis/tools/eclipse/**. 
5. Wenn Sie nach der Überprüfung die Lizenzvereinbarung akzeptieren, installieren Sie Liberty. 
    
    Geben Sie den folgenden Befehl ein:
**imcl
install com.ibm.websphere.liberty.v85 -repositories Liberty-Repositoryverzeichnis
-installationDirectory Liberty-Installationsverzeichnis -acceptLicense**

    Mit diesem Befehl wird Liberty im Verzeichnis **Liberty-Installationsverzeichnis** installiert.
Die Option **-acceptLicense** bedeutet, dass Sie die Lizenzbedingungen für das Produkt akzeptieren. 

6. Verschieben Sie das Verzeichnis mit den Servern an eine Position, für die keine besonderen Berechtigungen
erforderlich sind. 

Verschieben sie in diesem Lernprogramm das Verzeichnis
mit den Servern an eine Position, für die keine besonderen Berechtigungen
erforderlich sind, wenn **Liberty-Installationsverzeichnis** auf eine Position zeigt, an der nur Administratoren oder Rootbenutzer Dateien modifizieren können. So können die Installationsoperationen ohne spezielle Berechtigungen ausgeführt werden.
    * Wechseln Sie zum Installationsverzeichnis von Liberty.
    * Erstellen Sie ein Verzeichnis "etc". Sie benötigen Administrator- oder Rootberechtigung. 
    * Erstellen Sie im Verzeichnis **etc** eine Datei **server.env** mit folgendem Inhalt: `WLP_USER_DIR=<Pfad_zu_einem_Verzeichnis_mit_globaler_Schreibberechtigung>`. Beispiel für Windows: `WLP_USER_DIR=C:\LibertyServers\usr`
7.  Erstellen Sie einen Liberty-Server, in dem später in diesem Lernprogramm der erste MobileFirst-Server-Knoten installiert wird.
    * Starten Sie eine Befehlszeile.
    * Navigieren Sie zu **Liberty-Installationsverzeichnis/bin** und geben Sie **server create mfp1** ein.
    
    Dieser Befehl erstellt eine Liberty-Serverinstanz mit dem Namen **mfp1**. Sie sehen die Definition der Instanz
unter **Liberty-Installationsverzeichnis/usr/servers/mfp1**
oder, wenn Sie das Verzeichnis wie in Schritt 6 beschrieben
modifiziert haben, unter **WLP\_USER\_DIR/servers/mfp1**. 
    
Nach der Erstellung des Servers können Sie den Server druch Ausführung von
`server start mfp1` im Verzeichnis
**Liberty-Installationsverzeichnis/bin/** starten.   
Wenn Sie den Server stoppen wollen, geben Sie im Verzeichnis
**Liberty-Installationsverzeichnis/bin/** den Befehl `server stop mfp1` ein. 

Die Standardhomepage
können Sie über [http://localhost:9080](http://localhost:9080) anzeigen. 

> **Hinweis:** In der Produktion müssen Sie sicherstellen, dass der Liberty-Server beim Start des Hostcomputers
als Dienst gestartet wird. Der Start des Liberty-Servers als Dienst ist nicht in diesem Lernprogramm beschrieben. ## {{ site.data.keys.mf_server }} installieren
{: #installing-mobilefirst-server }
Vergewissern Sie sich, dass Installation Manager ab Version 1.8.4 installiert ist. Die Installation von
{{ site.data.keys.mf_server }} mit einer älteren Installation-Manager-Version
könnte fehlschlagen, weil für den Installationsabschluss
Java 7 erforderlich ist. Die älteren Versionen des Installation
Manager arbeiten mit Java 6.


Führen Sie den Installation Manager aus, um die Binärdateien von
{{ site.data.keys.mf_server }} auf Ihrer Platte zu installieren, bevor Sie die Datenbanken erstellen und
{{ site.data.keys.mf_server }} in Liberty Profile implementieren. Während der Installation von
{{ site.data.keys.mf_server }} mit dem
Installation Manager werden Sie gefragt, ob Sie das {{ site.data.keys.mf_app_center }} installieren möchten. Das
Application Center ist eine gesonderte
Produktkomponente. Im Rahmen dieses Lernprogramms wird diese Komponente nicht mit
{{ site.data.keys.mf_server }} installiert.


Außerdem müssen Sie eine Eigenschaft angeben, mit der entschieden wird, ob die
Tokenlizenzierung aktiviert werden soll. In diesem Lernprogramm wird davon ausgegangen, dass keine Tokenlizenzierung erforderlich ist. Daher finden Sie hier keine Schritte, um
{{ site.data.keys.mf_server }} für die Tokenlizenzierung
zu konfigurieren. In einer Produktionsumgebung müssen Sie jedoch festlegen, ob die Tokenlizenzierung aktiviert werden soll. Wenn in Ihrem Vertrag keine Tokenlizenzierung mit
Rational License
Key Server vereinbart ist, müssen Sie die Tokenlizenzierung nicht aktivieren. Wenn Sie die Tokenlizenzierung aktivieren, müssen Sie
{{ site.data.keys.mf_server }} für die Tokenlizenzierung konfigurieren.  

In diesem Lernprogramm geben Sie die Eigenschaften als Parameter in der **imcl**-Befehlszeile an. Sie können diese Angaben auch in einer
Antwortdatei machen. 

1. Lesen Sie die Lizenzvereinbarung für {{ site.data.keys.mf_server }} durch. Sie können die Lizenzdateien anzeigen, wenn Sie das Installationsrepository über
Passport
Advantage heruntergeladen haben.
2. Entpacken Sie die heruntergeladene komprimierte Datei für das MobileFirst-Server-Installationsprogramm
in einem Ordner. 

In den folgenden Schritten wird für das Verzeichnis, in das Sie das Installationsprogramm extrahieren, die Bezeichnung
**MFP-Repositoryverzeichnis** verwendet.
Es enthält einen Ordner **MobileFirst_Platform_Server/disk1**.
3. Öffnen Sie eine Befehlszeile und navigieren Sie zu dem Verzeichnis **Installation-Manager-Installationsverzeichnis/tools/eclipse/**. 
4. Wenn Sie die in Schritt 1
durchgelesene Lizenzvereinbarung akzeprtiert haben,
können Sie {{ site.data.keys.mf_server }} installieren.

    Geben Sie den folgenden Befehl ein: `imcl install com.ibm.mobilefirst.foundation.server -repositories MFP-Repositoryverzeichnis/MobileFirst_Platform_Server/disk1 -properties user.appserver.selection2=none,user.database.selection2=none,user.database.preinstalled=false,user.licensed.by.tokens=false,user.use.ios.edition=false -acceptLicense`

    Die folgenden Eigenschaften müssen für eine Installation ohne Application Center definiert werden: 
    * **user.appserver.selection2=none**
    * **user.database.selection2=none**
    * **user.database.preinstalled=false**

    Die folgende
Eigenschaft zeigt an, dass die Tokenlizenzierung nicht aktiviert ist: **user.licensed.by.tokens=false**.  
Setzen Sie die Eigenschaft **user.use.ios.edition** für die Installation der {{ site.data.keys.product }} auf "false". 

Ein Installationsverzeichnis mit den Ressourcen für die Installation der
{{ site.data.keys.product_adj }}-Komponenten wurde erstellt.   
Sie finden die Ressourcen in folgenden Ordnern: 

* Ordner **MobileFirstServer** für {{ site.data.keys.mf_server }}
* Ordner **PushService** für den MobileFirst-Server-Push-Service 
* Ordner **ApplicationCenter** für das Application Center
* Ordner **Analytics** für {{ site.data.keys.mf_analytics }}

Ziel dieses Lernprogramms ist es,
{{ site.data.keys.mf_server }} mit den Ressourcen im Ordner
**MobileFirstServer** zu installieren.   
Im Ordner **shortcuts** finden Sie einige Verknüpfungen für den Direktaufruf des
Server Configuration Tool,
von Ant und des Programms **mfpadm**. 

## Datenbank erstellen
{: #creating-a-database }
Mit diesem Schritt wird sichergestellt, dass es in Ihrem
DBMS eine Datenbank gibt und dass ein Benutzer berechtigt ist, die Datenbank zu verwenden sowie
Datenbanktabellen zu erstellen und zu verwenden. Sie können diesen Schritt überspringen, wenn Sie planen, eine Derby-Datenbank zu verwenden.

In der Datenbank werden die technischen Daten gespeichert, die von den verschiedenen
{{ site.data.keys.product_adj }}-Komponenten verwendet werden. 

* MobileFirst-Server-Verwaltungsservice
* MobileFirst-Server-Liveaktualisierungsservice
* Push-Service von {{ site.data.keys.mf_server }}
* {{ site.data.keys.product_adj }}-Laufzeit

In diesem Lernprogramm werden die Tabellen für alle Komponenten
unter demselben Schema angeordnet.   
**Hinweis:** Die hier beschriebenen Schritte beziehen sich auf
DB2. Wenn Sie
MySQL oder Oracle verwenden möchten, lesen Sie die
[Datenbankvoraussetzungen](../../databases/#database-requirements).


1. Melden Sie sich bei dem Computer an, auf dem der DB2 Server ausgeführt wird. Es wird vorausgesetzt, dass es einen DB2-Benutzer gibt, der beispielsweise den Namen **mfpuser** haben könnte. 
2. Vergewissern Sie sich, dass dieser DB2-Benutzer Zugriff auf eine Datenbank mit einer Seitengröße
von mindestens 32768 hat und berechtigt ist, implizit Schemata und Tabellen in dieser Datenbank zu erstellen. 

    Standardmäßig ist dieser Benutzer im Betriebssystem des Computers deklariert, auf dem DB2 ausgeführt wird, also ein Benutzer, der sich auf diesem Computer anmelden kann. Wenn es einen solchen Benutzer gibt, ist Schritt 3 nicht erforderlich.
3. Wenn Sie noch keine Datenbank haben, erstellen Sie für diese Installation eine Datenbank mit der richtigen Seitengröße.
    * Öffnen Sie als Benutzer mit der Berechtigung **SYSADM** oder **SYSCTRL** eine Sitzung. Verwenden Sie beispielsweise den Benutzer **db2inst1**, der vom DB2-Installationsprogramm als Standardbenutzer mit Administratorberechtigung erstellt wird.
    * Öffnen Sie einen DB2-Befehlszeilenprozessor:
        * Klicken Sie auf Windows-Systemen auf **Start → IBM DB2 → Befehlszeilenprozessor**.
        * Navigieren Sie auf Linux- oder UNIX-Systemen zu **~/sqllib/bin** (oder, wenn sqllib nicht im Ausgangsverzeichnis des Administrators erstellt wurde, zum Verzeichnis **DB2-Installationsverzeichnis/bin**) und geben Sie `./db2` ein.
    * Geben Sie die folgenden SQL-Anweisungen ein, um eine Datenbank mit dem Namen **MFPDATA** zu erstellen:
    
        ```sql
        CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
        CONNECT TO MFPDATA
        GRANT CONNECT ON DATABASE TO USER mfpuser
        GRANT CREATETAB ON DATABASE TO USER mfpuser
        GRANT IMPLICIT_SCHEMA ON DATABASE TO USER mfpuser
        DISCONNECT MFPDATA
        QUIT
        ```

    Wenn Sie einen anderen Benutzernamen definiert haben,
ersetzen Sie **mfpuser** durch den entsprechenden Benutzernamen. 
    
    > **Hinweis:** Mit der Anweisung werden nicht die Standardberechtigungen entfernt,
die PUBLIC für eine DB2-Standarddatenbank gewährt werden. In der Produktion müssen Sie die Berechtigungen dieser Datenbank
ggf. auf die für das Produkt erforderlichen Mindestberechtigungen reduzieren. Weitere Informationen zur
DB2-Sicherheit und ein Beispiel für bewährte Sicherheitsverfahren finden Sie unter
[DB2 Security,
Part 8: Twelve DB2 Security
Best Practices](http://www.ibm.com/developerworks/data/library/techarticle/dm-0607wasserman/).
## {{ site.data.keys.mf_server }} mit
Ant-Tasks in Liberty implementieren
{: #deploying-mobilefirst-server-to-liberty-with-ant-tasks }
Mit den Ant-Tasks können Sie die folgenden Operationen ausführen: 

* Für die {{ site.data.keys.product_adj }}-Anwendungen erforderliche Tabellen in der Datenbank erstellen
* MobileFirst-Server-Webanwendungen (Laufzeit, Verwaltungsservice, Liveaktualisierungsservice, Push-Service und
{{ site.data.keys.mf_console }}) im Liberty-Server
implementieren 

Die folgenden {{ site.data.keys.product_adj }}-Anwendungen
werden nicht mit Ant-Tasks implementiert: 

#### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.mf_analytics }} wird wegen des hohen Speicherbedarfs normalerweise nicht in denselben Servern wie
{{ site.data.keys.mf_server }} implementiert. {{ site.data.keys.mf_analytics }} kann
manuell oder mit Ant-Tasks installiert werden. Wenn die Anwendung bereits installiert ist, können Sie die URL, den Benutzernamen und das Kennwort im
eingeben, damit Daten
an
das Server Configuration Tool gesendet werden können.
Das Server Configuration Tool konfiguriert dann die
{{ site.data.keys.product_adj }}-Apps so, dass sie Daten an
{{ site.data.keys.mf_analytics }} senden.
 

#### Application Center
{: #application-center }
Mit dieser Anwendung können mobile Apps intern an Mitarbeiter zur Verwendung oder zu Testzwecken verteilt werden. Das Application Center
ist von {{ site.data.keys.mf_server }} abhängig, muss aber nicht zusammen mit
{{ site.data.keys.mf_server }} installiert werden.
 

Wählen Sie die entsprechende XML-Datei mit den Ant-Tasks aus und konfigurieren Sie die Eigenschaften.

* Erstellen Sie in einem Arbeitsverzeichnis eine Kopie der Datei
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples/configure-liberty-db2.xml**. Diese Datei enthält die Ant-Tasks für die Installation von
{{ site.data.keys.mf_server }} in
Liberty mit DB2 als Datenbank.
Bevor Sie die Datei verwenden, müssen Sie Eigenschaften definieren, um anzugeben, wo die MobileFirst-Server-Anwendungen
implementiert werden sollen. 
* Bearbeiten Sie die Kopie der XML-Datei und legen Sie die Werte der folgenden Eigenschaften fest: 
    * Setzen Sie **mfp.admin.contextroot** auf **/mfpadmin**. 
    * Setzen Sie **mfp.runtime.contextroot** auf **/mfp**. 
    * Setzen Sie **database.db2.host** auf den Hostnamen des Computers, auf dem Ihre
DB2-Datenbank ausgeführt wird.
Wenn sich die Datenbank auf demselben Computer wie Liberty befindet, verwenden Sie **localhost**.
    * Setzen Sie **database.db2.port** auf den Port,
von dem die DB2-Instanz Daten erwartet. Standardmäßig ist die Portnummer
**50000**.
    * Setzen Sie **database.db2.driver.dir** auf das Verzeichnis mit Ihrem
DB2-Treiber (**db2jcc4.jar** und **db2jcc\_license\_cu.jar**).
In einer DB2-Standarddistribution befinden sich diese Dateien
unter **DB2-Installationsverzeichnis/java**.
    * Setzen Sie **database.db2.mfp.dbname** auf **MFPDATA** (den Datenbanknamen, den
Sie beim Durcharbeiten des Abschnitts "Datenbank erstellen" erstellt haben). 
    * Setzen Sie **database.db2.mfp.schema** auf **MFPDATA** (das
Schema, gemäß dem die Tabellen für {{ site.data.keys.mf_server }} erstellt
werden sollen). Wenn Ihr Datenbankbenutzer kein Schema erstellen kann, legen Sie als Wert eine leere Zeichenfolge fest. Beispiel: **database.db2.mfp.schema=""**
    * Setzen Sie **database.db2.mfp.username** auf den DB2-Benutzer, der die Tabellen erstellt.
Dieser Benutzer verwendet die Tabellen auch in der Laufzeit. Verwenden Sie für dieses Lernprogramm **mfpuser**.
    * Setzen Sie **appserver.was.installdir** auf das Liberty-Installationsverzeichnis. 
    * Setzen Sie **appserver.was85liberty.serverInstance** auf **mfp1** (den Namen des
Liberty-Servers, in dem
{{ site.data.keys.mf_server }} installiert
werden soll). 
    * Setzen Sie **mfp.farm.configure** auf **false**, um
{{ site.data.keys.mf_server }} im eigenständigen Modus zu
installieren. 
    * Setzen Sie **mfp.analytics.configure** auf **false**.
Die Verbindung zu {{ site.data.keys.mf_analytics }} ist
nicht Bestandteil dieses Lernprogramms. Sie können die übrigen Eigenschaften mfp.analytics.**** ignorieren.
    * Setzen Sie **mfp.admin.client.id** auf **admin-client-id**. 
    * Setzen Sie **mfp.admin.client.secret** auf **adminSecret** (oder ein anderes geheimes
Kennwort). 
    * Setzen Sie **mfp.push.client.id** auf **push-client-id**. 
    * Setzen Sie **mfp.push.client.secret** auf **pushSecret** (oder ein anderes geheimes
Kennwort). 
    * Setzen Sie **mfp.config.admin.user** auf den Benutzernamen für den
MobileFirst-Server-Liveaktualisierungsservice. In einer Server-Farmtopologie muss der Benutzername für alle Member der Farm der gleiche sein. 
    * Setzen **Sie mfp.config.admin.password** auf das Kennwort für den
MobileFirst-Server-Liveaktualisierungsservice. In einer Server-Farmtopologie muss das Kennwort für alle Member der Farm das gleiche sein. 
* Übernehmen Sie für die folgenden Eigenschaften die Standardwerte: 
    * **mfp.admin.console.install**: true
    * **mfp.admin.default.user**: **admin** (Name des Standardbenutzers, der für die Anmeldung bei der
{{ site.data.keys.mf_console }} erstellt wird)
    * **mfp.admin.default.user.initialpassword**: **admin** (Kennwort des Standardbenutzers, der für die Anmeldung bei der
Administrationskonsole erstellt wird)
    * **appserver.was.profile**: **Liberty**.
Bei einem anderen Wert geht die Ant-Task davon aus, dass die Installation in einem
WebSphere Application Server erfolgt. 
* Speichern Sie die Datei, wenn Sie die Eigenschaften definiert haben. 
* Führen Sie `MFP-Server-Installationsverzeichnis/shortcuts/ant -f configure-liberty-db2.xml` aus, um eine Liste möglicher Ziele für die Ant-Datei anzuzeigen. 
* Führen Sie den Befehl `MFP-Server-Installationsverzeichnis/shortcuts/ant
-f configure-liberty-db2.xml databases` aus, um die Datenbanktabellen
zu erstellen. 
* Führen Sie den Befehl `MFP-Server-Installationsverzeichnis/shortcuts/ant
-f configure-liberty-db2.xml install` aus, um {{ site.data.keys.mf_server }}
zu installieren. 

> **Hinweis:** Wenn Sie nicht DB2 verwenden und die Installation mit einer eingebetteten Derby-Datenbank
testen möchten, verwenden Sie die Datei
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples/configure-liberty-derby.xml**.
Den letzten Schritt dieses Lernprogramms ("Farm mit zwei Liberty-Servern für {{ site.data.keys.mf_server }} erstellen") können Sie dann aber nicht ausführen, weil es nicht möglich ist, dass mehrere Liberty-Server auf die Derby-Datenbank
zugreifen. Sie müssen die Eigenschaften bis auf die
DB2-bezogenen
(**database.db2**...) definieren. Setzen Sie die Eigenschaft
**database.derby.datadir** für Derby auf das Verzeichnis, in dem die Derby-Datenbank erstellt werden kann. Setzen Sie die Eigenschaft
**database.derby.mfp.dbname** auf den Wert **MFPDATA**.Die Ant-Tasks führen die folgenden
Operationen aus: 

1. Tabellen für die folgenden Komponenten werden in der Datenbank erstellt: 
    * Für den Verwaltungsservice und den Liveaktualisierungsservice vom Ant-Ziel
`admdatabases`
    * Für die Laufzeitkomponente vom Ant-Ziel `rtmdatabases` 
    * Für den Push-Service vom Ant-Ziel `pushdatabases` 
2. Die WAR-Dateien der verschiedenen Komponenten werden im Liberty-Server implementiert. Die Details der Operationen sehen Sie im Protokoll unter den Zielen
`adminstall`, `rtminstall` und
`pushinstall`. 

Wenn Sie Zugriff auf den DB2 Server haben, können Sie mit folgenden
Anweisungen die erstellten Tabellen auflisten: 

1. Öffnen Sie als mfpuser einen DB2-Befehlszeilenprozessor (siehe
"Datenbank erstellen", Schritt
3). 
2. Geben Sie folgende SQL-Anweisungen ein: 

```sql
CONNECT TO MFPDATA USER mfpuser USING mfpuser-Kennwort
LIST TABLES FOR SCHEMA MFPDATA
DISCONNECT MFPDATA
QUIT
```

Beachten Sie die folgenden Datenbankfaktoren: 

#### Hinweis zum Datenbankbenutzer
{: #database-user-consideration }
Im Server Configuration Tool ist nur
ein Datenbankbenutzer erforderlich. Dieser Benutzer wird verwendet, um die Tabellen zu erstellen, aber auch in der Laufzeit als Datenquellenbenutzer
im Anwendungsserver. In einer Produktionsumgebung werden Sie die Zugriffsrechte des in der Laufzeit verwendeten Benutzers
auf ein Minimum
(`SELECT / INSERT / DELETE / UPDATE`) beschränken wollen. Geben Sie daher für die Implementierung im
Anwendungsserver einen anderen Benutzer an. Die als Beispiel bereitgestellten Ant-Dateien verwenden in beiden Fällen denselben Benutzer. Wenn Sie mit
DB2 arbeiten, können Sie aber eine eigene Version der Ant-Dateien erstellen, um den Benutzer, der die Datenbanken erstellt, von dem Benutzer zu trennen,
der für die Datenquelle im Anwendungsserver verwendet wird. 

#### Erstellung der Datenbanktabellen
{: #database-tables-creation }
Für Produktion werden Sie die Tabellen vielleicht manuell erstellen wollen, z. B., wenn Ihr Datenbankadministrator einige Standardeinstellungen überschreiben oder bestimmte
Tabellenbereiche zuordnen möchte. Die für die Erstellung der Tabellen verwendeten Datenbankscripts befinden sich
in den Verzeichnissen **MFP-Server-Installationsverzeichnis/MobileFirstServer/databases**
und **MFP-Server-Installationsverzeichnis/PushService/databases**.
Weitere Informationen finden Sie unter [Datenbanktabellen manuell erstellen](../../databases/#create-the-database-tables-manually).

Die Datei
**server.xml** und einige Anwendungsservereinstellungen werden während der Installation modifiziert.
Vor jeder Modifikation wird eine Kopie der Datei **server.xml** erstellt, z. B. mit dem
Namen **server.xml.bak**, **server.xml.bak1** und
**server.xml.bak2**. Wenn Sie alle hinzugefügten Elemente sehen möchten, können Sie die Datei
**server.xml** mit der ältesten Sicherungskopie
(server.xml.bak) vergleichen. Unter Linux können Sie den Befehl
`diff --strip-trailing-cr server.xml server.xml.bak` verwenden, um die Unterschiede zu sehen. Verwenden Sie unter
AIX den Befehl
`diff server.xml server.xml.bak`, um die Unterschiede zu finden. 

#### Modifikation der Anwendungsservereinstellungen (für Liberty):
{: #modification-of-the-application-server-settings-specific-to-liberty }
1. Die Liberty-Features werden hinzugefügt. 

    Die Features
werden für jede Anwendung hinzugefügt und können dupliziert werden. Das JDBC-Feature wird beispielsweise für den Verwaltungsservice und für die Laufzeitkomponente
verwendet.
Diese Duplizierung ermöglicht das Entfernen von Features einer Anwendung,
die deinstalliert wird, ohne die anderen Anwendungen zu unterbrechen. Sie könnten beispielsweise zu einem bestimmten Zeitpunkt entscheiden, dass der
Push-Service auf einem
Server deinstalliert und auf einem anderen Server installiert werden soll. Dies ist jedoch nicht in allen Topologien möglich. Der Verwaltungsservice, der Liveaktualisierungsservice und die Laufzeitkomponente müssen sich auf demselben
Anwendungsserver mit Liberty Profile befinden. Weitere Informationen finden Sie unter
[Einschränkungen
für den MobileFirst-Server-Verwaltungsservice und -Liveaktualisierungsservice sowie für die
{{ site.data.keys.product_adj }}-Laufzeit](../../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime). Die Duplizierung von Features schafft keine Probleme, solange die Features, die hinzugefügt werden, keinen Konflikt erzeugen. Wenn Sie die Features
jdbc-40 und jdbc-41 hinzufügen, kommt es zu einem Problem. Fügen Sie dagegen zweimal das gleiche Feature hinzu, ist das problemlos möglich. 
    
2. Die Einstellung `host='*'` wird zur Deklaration von `httpEndPoint` hinzugefügt.

    Diese Einstellung ermöglicht die Verbindung zum Server über alle Netzschnittstellen. In der Produktion können Sie den Hostwert auf den HTTP-Endpunkt beschränken.
3. Das Element **tcpOptions** (**tcpOptions soReuseAddr="true"**) wird zur Serverkonfiguration hinzugefügt, um die sofortige Neubindung eines Ports ohne aktiven Listener zu ermöglichen und den Serverdurchsatz zu verbessern.
4. Ein Keystore mit der ID **defaultKeyStore** wird erstellt, sofern er noch nicht vorhanden ist.

    Der Keystore soll die Verwendung des HTTPS-Ports für die JMX-Kommunikation zwischen dem Verwaltungsservice (mfp-admin-service.war) und der Laufzeitkomponente (mfp-server.war) ermöglichen. Die beiden Anwendungen kommunizieren über JMX. Bei Verwendung von Liberty Profile wird restConnector für die Kommunikation zwischen den Anwendungen innerhalb eines Servers und zwischen den Servern einer Liberty-Farm verwendet, was die Verwendung von HTTPS erfordert. Für den standardmäßig erstellten Keystore erstellt Liberty Profile ein Zertifikat mit einem Gültigkeitszeitraum von 365 Tagen. Diese Konfiguration ist nicht für den Produktionseinsatz vorgesehen. In der Produktion sollten Sie ein eigenes Zertifikat verwenden.    

    Für die Aktivierung von JMX wird in der Basisregistry ein Benutzer mit Administratorrolle (MfpRESTUser) erstellt. Der Name und das Kennwort des Benutzers werden als JNDI-Eigenschaften (mfp.admin.jmx.user und mfp.admin.jmx.pwd) angegeben und von der Laufzeitkomponente sowie dem Verwaltungsservice für die Ausführung von JMX-Abfragen verwendet. Mit einigen der globalen JMX-Eigenschaften wird der Clustermodus (eigenständiger Server oder Farm) definiert. Das Server Configuration Tool setzt die Eigenschaft mfp.topology.clustermode des Liberty-Servers auf Standalone. In einem späteren Abschnitt dieses Lernprogramms wird diese Eigenschaft für die Erstelllung einer Farm auf Cluster gesetzt.
5. Erstellung von Benutzern (auch zutreffend für Apache Tomcat und WebSphere Application Server)
    * Optionale Benutzer: Das Server Configuration Tool erstellt einen Testbenutzer (admin/admin), den Sie nach der Installation für die Anmeldung bei der Konsole verwenden können.
    * Obligatorische Benutzer: Das Server Configuration Tool erstellt außerdem einen Benutzer configUser_mfpadmin mit generiertem Zufallskennwort, den der Verwaltungsservice verwendet, um Kontakt zum lolaken Liveaktualisierungsservice aufzunehmen. Für den Liberty-Server wird der Benutzer MfpRESTUser erstellt. Wenn Ihr Anwendungsserver nicht für die Verwendung einer Basisregistry konfiguriert ist (sondern beispielsweise für eine LDAP-Registry), kann das Server Configuration Tool nicht den Namen eines vorhandenen Benutzers abfragen. In dem Fall müssen Sie Ant-Tasks verwenden.
6. Das Element **webContainer** wird modifiziert.

    Die angepasste Web-Containereigenschaft `deferServletLoad` wird auf "false" gesetzt. Die Laufzeitkomponente und der Verwaltungsservice müssen gestartet werden, wenn der Server gestartet wird. Diese Komponenten können so die JMX-Beans registrieren und die Synchronisation starten, die es der Laufzeitkomponente ermöglicht, alle Anwendungen und Adapter herunterzuladen, für die sie Services bereitstellen muss.
7. Das Standardsteuerprogramm wird so angepasst, dass für `coreThreads` und `maxThreads` hohe Werte festgelegt werden, wenn Sie Liberty bis Version 8.5.5.5 verwenden. Ab Liberty Version 8.5.5.6 wird das Standardsteuerprogramm automatisch optimiert.

    Durch diese Einstellung werden Probleme durch Zeitlimitüberschreitungen
vermieden, die
in einigen Liberty-Versionen die Startsequenz für die Laufzeitkomponente und den Verwaltungsservice unterbrechen. Fehlt diese Anweisung, können folgende Fehler in der
Serverprotokolldatei enthalten sein: 
    
    > Das Abrufen einer JMX-Verbindung für den Zugriff auf eine
MBean ist fehlgeschlagen. Es könnte ein JMX-Konfigurationsfehler vorliegen. Das zulässige Lesezeitlimit
wurde überschritten.
FWLSE3000E: Ein Serverfehler wurde festgestellt.
    > FWLSE3012E: JMX-Verbindungsfehler. Es können keine
MBeans angefordert werden. Ursache: Das zulässige Lesezeitlimit wurde überschritten. 

#### Deklaration von Anwendungen
{: #declaration-of-applications }
Die folgenden Anwendungen werden installiert: 

* **mfpadmin**: Verwaltungsservice
* **mfpadminconfig**: Liveaktualisierungsservice
* **mfpconsole**: {{ site.data.keys.mf_console }}
* **mobilefirst**: {{ site.data.keys.product_adj }}-Laufzeitkomponente
* **imfpush**: Push-Service

Das
Server Configuration Tool installiert die Anwendungen in demselben Server. Sie können die Anwendungen auch in verschiedenen
Anwendungsservern installieren, allerdings gelten dafür bestimmte Einschränkungen (siehe
[Topologien und Netzabläufe](../../topologies)).   
Für eine Installation auf unterschiedlichen Servern können Sie nicht das
Server Configuration Tool verwenden.
Installieren Sie das Produkt manuell oder mit Ant-Tasks. 

#### Verwaltungsservice
{: #administration-service }
Mit dem Verwaltungsservice
werden {{ site.data.keys.product_adj }}-Anwendungen und -Adapter und deren Konfiguration
verwaltet. Der Service ist durch Sicherheitsrollen geschützt.
Das Server Configuration Tool fügt standardmäßig einen Benutzer
(admin) mit Administratorrolle hinzu, der zu Testzwecken für die Anmeldung bei der Konsole
verwendet werden kann. Die Konfiguration der Sicherheitsrolle muss nach der Installation
mit dem Server Configuration Tool (oder
mit Ant-Tasks) erfolgen.
Sie können den einzelnen Sicherheitsrollen die Benutzer oder Gruppen aus der Basisregistry oder aus einer von Ihnen in Ihrem Anwendungsserver konfigurierten
LDAP-Registry zuordnen. 

Das Klassenladeprogramm wird mit der Delegierung "übergeordneter zuletzt" für
Liberty Profile und  WebSphere Application Server
und alle {{ site.data.keys.product_adj }}-Anwendungen konfiguriert.
Durch diese Einstellung werden Konflickte zwischen den Klassen der
{{ site.data.keys.product_adj }}-Anwendungen und
den Klassen des Anwendungsservers vermieden. Eine häufige Fehlerquelle bei der manuellen Installation ist, dass vergessen wird, die Delegierung des
Klassenladeprogramms auf "übergeordneter zuletzt" zu setzen. Für Apache Tomcat ist diese Deklaration nicht erforderlich. 

In
Liberty Profile wird zu der Anwendung eine allgemeine Bibliothek für die Entschlüsselung von Kennwörtern, die als JNDI-Eigenschaften übergeben werden,
hinzugefügt. Das Server Configuration Tool definiert zwei
obligatorische JNDI-Eigenschaften für den Verwaltungsservice (**mfp.config.service.user** und **mfp.config.service.password**).
Der Verwaltungsservice verwendet diese Eigenschaften, um über die REST-API eine Verbindung zum Liveaktualisierungsservice
herzustellen. Sie können weitere JNDI-Eigenschaften definieren, um die Anwendung zu optimieren oder an die Spezifik Ihrer Installation
anzupassen.
Weitere Informationen finden Sie unter
[Liste der JNDI-Eigenschaften für den
MobileFirst-Server-Verwaltungsservice](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

Das Server Configuration Tool definiert darüber hinaus
die JNDI-Eigenschaften für die Kommunikation mit dem Push-Service (URL und OAuth-Parameter für die Registrierung
der vertraulichen Clients).   
Die Datenquelle für die Datenbank mit den Tabellen für den Verwaltungsservice wird deklariert und auch eine Bibliothek für den
zugehörigen JDBC-Treiber. 

#### Liveaktualisierungsservice
{: #live-update-service }
Der Liveaktualisierungsservice speichert Informationen zur Laufzeit und zu Anwendungskonfigurationen. Er wird vom
Verwaltungsservice gesteuert und muss immer auf demselben Server wie der Verwaltungsservice ausgeführt werden. Das Kontextstammverzeichnis
ist "**Kontextstammverzeichnis_des_Verwaltungsservice**config", d. h.
**mfpadminconfig**. Der Verwaltungsservice erwartet, dass diese Konvention eingehalten wird, wenn die URL für die Anforderungen an die REST-Services des
Liveaktualisierungsservice erstellt wird. 

Das Klassenladeprogramm wird - wie bereits im Abschnitt zum Verwaltungsservice erläutert -
mit der Delegierung "übergeordneter zuletzt" konfiguriert.


Der Liveaktualisierungsservice hat nur eine Sicherheitsrolle
(**admin_config**). Dieser Rolle muss ein Benutzer zugeordnet werden. Das Kennwort und der Anmeldename des Benutzers müssen mit den
JNDI-Eigenschaften
**mfp.config.service.user** und
**mfp.config.service.password** an den Verwaltungsservice übergeben werden.
Weitere Informationen zu den JNDI-Eigenschaften enthalten die
[Liste der JNDI-Eigenschaften
für den MobileFirst-Server-Verwaltungsservice](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
und die [Liste der JNDI-Eigenschaften
für den MobileFirst-Server-Liveaktualisierungsservice](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-live-update-service).

In Liberty Profile wird zusätzlich eine Datenquelle mit JNDI-Namen
benötigt. Die Konvention ist **Kontextstammverzeichnis_des_Konfigurationsservice/jdbc/ConfigDS**.
In diesem Lernprogramm ist die Quelle als **mfpadminconfig/jdbc/ConfigDS** definiert.
Bei einer Installation mit dem
Server Configuration Tool oder
mit Ant-Tasks befinden sich die Tabellen des Liveaktualisierungsservice in derselben Datenbank und entsprechen demselben Schema wie die Tabellen des
Verwaltungsservice. Der Benutzerzugriff auf diese Tabellen ist auch der gleiche. 

#### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
Die {{ site.data.keys.mf_console }} wird mit den gleichen
Sicherheitsrollen wie der Verwaltungsservice deklariert.
Die den Sicherheitsrollen der
{{ site.data.keys.mf_console }} zugeordneten Benutzer müssen den gleichen Sicherheitsrollen
des Verwaltungsservice zugeordnet werden.
Die {{ site.data.keys.mf_console }} führt für den Konsolenbenutzer an den Verwaltungsservice
gerichtete Abfragen aus. 

Das Server Configuration Tool
gibt eine JNDI-Eigenschaft an
(**mfp.admin.endpoint**), die festlegt, wie die Konsole eine Verbindung zum Verwaltungsservice herstellt. Als Standardwert legt das
Server Configuration Tool
`*://*:*/mfpadmin` fest.
Diese Einstellung bedeutet, dass die Konsole dasselbe Protokoll, denselben Hostnamen und denselben Port wie die bei der Konsole eingehende
HTTP-Anforderung verwenden muss und dass das Kontextstammverzeichnis des Verwaltungsservice
/mfpadmin ist.
Wenn Sie die Anforderung durch einen Web-Proxy leiten möchten, ändern Sie den Standardwert. Weitere Informationen zu gültigen Werten für diese URL oder
zu anderen möglichen JNDI-Eigenschaften finden Sie in der
[Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service). 

Das Klassenladeprogramm wird - wie bereits im Abschnitt zum Verwaltungsservice erläutert -
mit der Delegierung "übergeordneter zuletzt" konfiguriert.


#### {{ site.data.keys.product_adj }}-Laufzeit
{: #mobilefirst-runtime }
Diese Anwendung wird nicht mit einer Sicherheitsrolle geschützt. Für den Zugriff auf diese Anwendung ist keine Anmeldung
mit einem dem Liberty-Server bekannten Benutzernamen erforderlich. Die Anforderungen mobiler Geräte werden zur Laufzeit weitergeleitet. Sie werden von anderen,
produktspezifischen Mechanismen (z. B. OAuth)
und über die Konfiguration der
{{ site.data.keys.product_adj }}-Anwendungen authentifiziert. 

Das Klassenladeprogramm wird - wie bereits im Abschnitt zum Verwaltungsservice erläutert -
mit der Delegierung "übergeordneter zuletzt" konfiguriert.


In Liberty Profile wird zusätzlich eine Datenquelle mit JNDI-Namen
benötigt. Die Konvention ist **Kontextstammverzeichnis_der_Laufzeit/jdbc/mfpDS**.
In diesem Lernprogramm ist die Quelle als **mobilefirst/jdbc/mfpDS** definiert.
Bei einer Installation mit dem
Server Configuration Tool oder
mit Ant-Tasks befinden sich die Tabellen der Laufzeit in derselben Datenbank und entsprechen demselben Schema wie die Tabellen des
Verwaltungsservice. Der Benutzerzugriff auf diese Tabellen ist auch der gleiche. 

#### Push-Service
{: #push-service }
Diese Anwendung wird mit OAuth geschützt. Die gültigen OAuth-Token müssen in jede an den Service gerichtete
HTTP-Anforderung aufgenommen werden. 

Die OAuth-Konfiguration erfolgt mit
JNDI-Eigenschaften (z. B. für die URL des Autorisierungsservers, die Client-ID und das Kennwort des Push-Service). Die JNDI-Eigenschaften geben auch
das Sicherheits-Plug-in (**mfp.push.services.ext.security**) an und legen fest, dass eine
relationale Datenbank verwendet wird (**mfp.push.db.type**).
An den Push-Service gerichette Anforderungen von mobilen Geräten werden zu diesem Service weitergeleitet. Das Kontextstammverzeichnis des Push-Service
muss /imfpush sein. Das Client-SDK berechnet die URL des Push-Service ausgehend von der URL der Laufzeit mit dem
Kontextstammverzeichnis (**/imfpush**).
Wenn Sie den Push-Service und die Laufzeit auf verschiedenen Servern installieren möchten, benötigen Sie einen HTTP-Router, der die Geräteanforderungen an den
betreffenden Anwendungsserver weiterleiten kann. 

Das Klassenladeprogramm wird - wie bereits im Abschnitt zum Verwaltungsservice erläutert -
mit der Delegierung "übergeordneter zuletzt" konfiguriert.


In Liberty Profile wird zusätzlich eine Datenquelle mit JNDI-Namen
benötigt. Der JNDI-Name ist **imfpush/jdbc/imfPushDS**.
Bei einer Installation mit dem
Server Configuration Tool oder
mit Ant-Tasks befinden sich die Tabellen des Push-Service in derselben Datenbank und entsprechen demselben Schema wie die Tabellen des
Verwaltungsservice. Der Benutzerzugriff auf diese Tabellen ist auch der gleiche. 

#### Modifikation anderer Dateien
{: #other-files-modification }
Die Liberty-Profile-Datei **jvm.options** wird modifiziert. Eine Eigenschaft wird definiert (**com.ibm.ws.jmx.connector.client.rest.readTimeout**),
um Probleme durch eine JMX-Zeitlimitüberschreitung zu vermeiden, wenn die Laufzeit mit dem Verwaltungsservice synchronisiert wird. 

### Installation testen
{: #testing-the-installation }
Nach
Abschluss der Installation können Sie wie folgt vorgehen, um die installierten Komponenten zu testen. 

1. Starten Sie den Server mithilfe des Befehls **server-Start mfp1**. Die Binärdatei für den Server befindet sich im Verzeichnis
**Liberty-Installationsverzeichnis/bin**.
2. Testen Sie die {{ site.data.keys.mf_console }} mit einem
Web-Browser. Rufen Sie [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) auf.
Der Server wird standardmäßig am Port 9080 ausgeführt. Sie können den Wert anhand des Elements `<httpEndpoint>` in der Datei **server.xml** überprüfen. Eine Anmeldeanzeige erscheint.



![Anmeldeanzeige der Konsole](mfpconsole_signin.jpg)

3. Melden Sie sich mit **admin/admin** an. Dieser Benutzer wird standardmäßig vom
Server Configuration Tool erstellt. 

    > **Hinweis:** Wenn Sie die Verbindung mit
HTTP herstellen, werden die Anmelde-ID und das Kennwort im Klartext über das Netz gesendet. Verwenden Sie für eine sichere Serveranmeldung HTTPS.
Den HTTPS-Port des Liberty-Servers enthält das Attribut httpsPort des Elements `<httpEndpoint>` in der Datei **server.xml**. Der Standardwert ist 9443.

4. Melden Sie sich über **Hallo
Admin → Abmelden** bei der Konsole ab.
5. Geben Sie im Web-Browser die URL [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole) ein und akzeptieren Sie das
Zertifikat. Standardmäßig generiert der Liberty-Server ein Standardzertifikat, das Ihrem Web-Browser unbekannt ist.
Sie müssen das Zertifikat akzeptieren. Mozilla Firefox stellt diese Zertifizierung als eine Sicherheitsausnahme dar. 
6. Melden Sie sich erneut mit **admin/admin** an. Der Anmeldename und das Kennwort werden vom Web-Browser verschlüsselt an
{{ site.data.keys.mf_server }} gesendet.
In der Produktion sollten Sie den HTTP-Port schließen. 

## Farm mit zwei Liberty-Servern für {{ site.data.keys.mf_server }} erstellen
{: #creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server }
Mit den folgenden Schritten werden Sie einen zweiten Liberty-Server erstellen, der denselben
{{ site.data.keys.mf_server }} ausführt und mit derselben
Datenbank verbunden ist. In der Produktion sollten Sie aus Leistungsgründen mehr als einen Server verwenden, damit die in Stoßzeiten für Ihre mobilen Anwendungen
erforderliche
Anzahl Transaktionen ausgeführt werden kann. Die Verwendung von mehr als einem Server ist auch aus Gründen der hohen Verfügbarkeit zu empfehlen. So können Sie einen Single Point of Failure
vermeiden. 

Wenn
{{ site.data.keys.mf_server }} auf mehr als einem Server ausgeführt wird, müssen die Server
als Farm konfiguriert werden. Diese Konfiguration ermöglicht jedem Verwaltungsservice, Kontakt zu allen Laufzeiten der Farm
aufzunehmen.
Wenn der Cluster nicht als Farm konfiguriert wird, wird nur die Laufzeit benachrichtigt, die in demselben Anwendungsserver wie die Verwaltungsoperationen
ausgeführt wird. Andere Laufzeiten erlangen keine Kenntnis von einer Änderung. Wenn Sie in einem nicht als Farm konfigurierten Cluster beispielsweise
eine neue Version eines Adapters implementieren, würde nur ein Server Services für den neuen Adapter
bereitstellen. Die übrigen Server würden weiter Services für den alten Adapter bereitstellen. Die Installation Ihrer Server in
WebSphere Application Server Network Deployment ist die einzige Situation, in der Sie einen Cluster verwenden können, der nicht als Farm konfiguiert werden muss.
Der Verwaltungsservice kann alle Server finden, indem er die JMX-Beans mit dem Deployment Manager abfragt. Der Deployment Manager stellt die Liste der MobileFirst-JMX-Beans der Zelle bereit und
muss daher aktiv sein, damit Verwaltungsoperationen ausgeführt werden können. 

Wenn Sie eine Farm erstellen, müssen Sie auch einen HTTP-Server konfigurieren, der Abfragen an alle Member der
Farm sendet. Die Konfiguration eines HTTP-Servers ist nicht Teil dieses Lernprogramms. Hier geht es nur darum, die Farm so zu konfigurieren,
dass Verwaltungsoperationen in allen Laufzeitkomponenten des Clusters repliziert werden. 

1. Erstellen Sie auf demselben Computer einen zweiten Liberty-Server. 
    * Starten Sie eine Befehlszeile.
    * Navigieren Sie zu **Liberty-Installationsverzeichnis/bin** und geben Sie
**server create mfp2** ein.

2. Modifizieren Sie den HTTP- und den HTTPS-Port des Servers **mfp2** so, dass kein Konflikt mit den Ports
von Server **mfp1** entsteht.
    * Navigieren Sie zum Serververzeichnis des zweiten Servers. 

        Das Verzeichnis ist
**Liberty-Installationsverzeichnis/usr/servers/mfp2**
oder **WLP_USER_DIR/servers/mfp2** (falls Sie das Verzeichnis wie unter "WebSphere Application Server Liberty Core installieren"
in Schritt 6 modifiziert
haben). 
    * Bearbeiten Sie die Datei
**server.xml**. Ersetzen Sie die folgenden Zeilen:


      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9080"
        httpsPort="9443" />
      ```
        
      durch diese Zeilen: 
        
      ```xml
      <httpEndpoint id="defaultHttpEndpoint"
        httpPort="9081"
        httpsPort="9444" />
      ```
        
      Bei dieser Änderung erzeugen der HTTP- und HTTPS-Port des Servers mfp2 keinen Konflikt mit den Ports von Server mfp1. Sie müssen die Ports modifizieren, bevor Sie {{ site.data.keys.mf_server }} installieren. Wenn Sie den Port nach der Installation modifizieren, muss sich die Portänderung auch in der JNDI-Eigenschaft **mfp.admin.jmx.port** widerspiegeln.

3. Kopieren Sie die Ant-Datei, die Sie beim Durcharbeiten des Abschnitts [{{ site.data.keys.mf_server }} mit Ant-Tasks in LIberty implementieren](#deploying-mobilefirst-server-to-liberty-with-ant-tasks) verwendet haben, und ändern Sie den Wert der Eigenschaft **appserver.was85liberty.serverInstance** in **mfp2**. Die Ant-Tasks erkennen, dass die Datenbank vorhanden ist, und erstellen keine Tabellen (siehe folgenden Protokollauszug). Dann werden die Anwendungen im Server implementiert.

   ```bash
   [configuredatabase] Checking connectivity to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser'...
   [configuredatabase] Database MFPDATA exists.
   [configuredatabase] Connection to MobileFirstAdmin database MFPDATA with schema 'MFPDATA' and user 'mfpuser' succeeded.
   [configuredatabase] Getting the version of MobileFirstAdmin database MFPDATA...
   [configuredatabase] Table MFPADMIN_VERSION exists, checking its value...
   [configuredatabase] GetSQLQueryResult => MFPADMIN_VERSION = 8.0.0
   [configuredatabase] Configuring MobileFirstAdmin database MFPDATA...
   [configuredatabase] The database is in latest version (8.0.0), no upgrade required.
   [configuredatabase] Configuration of MobileFirstAdmin database MFPDATA succeeded.
   ```

4. Testen Sie die beiden Server mit einer HTTP-Verbindung. 
    * Öffnen Sie einen Web-Browser.
    * Geben Sie die URL [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) ein.Die Services für die Konsole werden von Server mfp1 bereitgestellt.
    * Melden Sie sich mit **admin/admin** an. 
    * Öffnen Sie in demselben Web-Browser eine Registerkarte und geben Sie die URL [http://localhost:9081/mfpconsole](http://localhost:9081/mfpconsole) ein.Die Services für die Konsole werden von Server mfp2 bereitgestellt.
    * Melden Sie sich mit admin/admin an. Wenn die Installation ordnungsgemäß ausgeführt wurde,
sehen Sie nach der Anmeldung auf beiden Registerkarten die gleiche Begrüßungsseite. 
    * Kehren Sie zur ersten Browserregisterkarte zurück und klicken Sie auf
**Hallo admin → Prüfprotokoll herunterladen**. Sie werden bei der Konsole abgemeldet und sehen erneut die Anmeldeanzeige.
Dieses Abmeldeverhalten ist ein Problem, das auftritt, weil bei der Anmeldung bei
Server mfp2 ein LTPA-Token erstellt und in Ihrem Browser als Cookie gespeichert wird. Dieses LTPA-Token wird von Server
mfp1 jedoch nicht erkannt. Da in einer Produktionsumgebung mit einem dem Cluster vorgeschalteten HTTP Load Balancer ein Wechsel des Servers wahrscheinlich ist,
müssen Sie dieses Problem lösen. Stellen Sie sicher, dass beide Server
(mfp1 und
mfp2) ihre LTPA-Token mit den gleichen geheimen Schlüsseln generieren. Kopieren Sie die
LTPA-Schlüssel von Server mfp1 in Server mfp2.
    
        * Stoppen Sie beide Server mit folgenden Befehlen: 
        
          ```bash
          server stop mfp1
          server stop mfp2
          ```
        
        * Kopieren Sie die
LTPA-Schlüssel von Server mfp1 in Server mfp2. Führen Sie im Verzeichnis
**Liberty-Installationsverzeichnis/usr/servers**
oder **WLP_USER_DIR/servers** den für Ihr Betriebssystem zutreffenden Befehl aus:  
            * UNIX: `cp mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
            * Windows: `copy mfp1/resources/security/ltpa.keys mfp2/resources/security/ltpa.keys`
        * Starten Sie die Server neu. Wechseln Sie von einer Browserregisterkarte zur anderen. Sie werden nicht aufgefordert, sich erneut
anzumelden. In einer Liberty-Server-Farm müssen alle Server dieselben LTPA-Schlüssel verwenden. 
    
5. Aktivieren Sie die JMX-Kommunikation zwischen den Liberty-Servern. 

    In Liberty erfolgt die JMX-Kommunikation über den
Liberty-REST-Connector mit dem Protokoll HTTPS. Für diese Kommunikation muss jeder Server der Farm das SSL-Zertifikat der anderen Member
anerkennen. Tauschen Sie die HTTPS-Zertifikate zwischen den Truststores aus. Verwenden Sie zum Konfigurieren des Truststore
IBM Dienstprogramme wie das Program Keytool,
das sich im Verzeichnis **java/bin** der IBM JRE-Distribution befindet.
Die Keystore- und Truststore-Position
ist in der Datei **server.xml** definiert.
Der
Keystore von Liberty Profile befindet sich standardmäßig
unter **WLP\_USER\_DIR/servers/Servername/resources/security/key.jks**.
Das Kennwort für diesen Standard-Keystore ist
**mobilefirst** (wie in der Datei **server.xml** angegeben). 
        
    > **Tipp:** Sie können es mit dem Dienstprogramm
Keytool ändern, müssen das Kennwort dann aber auch in der Datei
server.xml ändern, damit der Liberty-Server den Keystore lesen kann. In diesem Lernprogramm wird das Standardkennwort verwendet.     
    * Geben Sie im Verzeichnis **WLP\_USER\_DIR/servers/mfp1/resources/security** den Befehl
`keytool -list -keystore key.jks` ein. Der Befehl zeigt die Zertifikate im Keystore an. Es gibt nur ein Zertifikat mit dem Namen
**default**. Sie werden aufgefordert, das Kennwort für den Keystore einzugeben
(mobilefirst), bevor Sie die Schlüssel sehen können. Dasselbe gilt für alle weitere Befehle, die Sie mit dem Dienstprogramm Keytool ausführen. 
    * Exportieren Sie das Standardzertifikat von Server mfp1 mit dem Befehl
`keytool -exportcert -keystore key.jks -alias default
-file mfp1.cert`.
    * Geben Sie im Verzeichnis **WLP\_USER\_DIR/servers/mfp2/resources/security** den folgenden Befehl ein, um das Standardzertifikat von
Server mfp2 zu exportieren: `keytool
-exportcert -keystore key.jks -alias default -file mfp2.cert`.
    * Geben Sie vom selben Verzeichnis aus den folgenden Befehl ein, um das Zertifikat von
Server mfp1 zu importieren: `keytool -import -file ../../../mfp1/resources/security/mfp1.cert
-keystore key.jks`. Das Zertifikat von Server
mfp1 wurde in den Keystore von Server mfp2 importiert, sodass Server mfp2
den HTTPS-Verbindungen zu Server mfp1 vertrauen kann. Sie werden aufgefordert zu bestätigen, dass Sie das Zertifikat anerkennen. 
    * Geben Sie im Verzeichnis **WLP\_USER\_DIR/servers/mfp1/resources/security** den folgenden Befehl ein, um das Zertifkat von
Server mfp2 zu importieren: `keytool
-import -file ../../../mfp2/resources/security/mfp2.cert -keystore
key.jks`. Nach diesem Schritt sind HTTPS-Verbindungen zwischen den beiden Servern möglich. 

## Farm testen und Änderungen in der {{ site.data.keys.mf_console }} anzeigen
{: #testing-the-farm-and-see-the-changes-in-mobilefirst-operations-console }

1. Starten Sie wie folgt die beiden Server: 

   ```bash
   server start mfp1
   server start mfp2
   ```
        
2. Öffnen Sie die Konsole. Geben Sie beispielsweise [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) ein oder
für HTTPS [https://localhost:9443/mfpconsole](https://localhost:9443/mfpconsole). In der linken Seitenleiste erscheint ein zusätzliches Menü
**Server-Farmknoten**. Wenn Sie auf **Server-Farmknoten** klicken, sehen Sie den Status der einzelnen Knoten. Möglicherweise müssen Sie etwas warten, bis beide Knoten
gestartet sind. 
