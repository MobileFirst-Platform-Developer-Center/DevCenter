---
layout: tutorial
title: Referenzinformationen zur Installations
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Referenzinformationen zu Ant-Tasks und Beispielkonfigurationsdateien für die Installation von {{ site.data.keys.mf_server_full }}, {{ site.data.keys.mf_app_center_full }} und {{ site.data.keys.mf_analytics_full }}.

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }
* [Referenzinformationen zur Ant-Task configuredatabase](#ant-configuredatabase-task-reference)
* [Ant-Tasks für die Installation der {{ site.data.keys.mf_console }}, der MobileFirst-Server-Artefakte, des MobileFirst-Server-Verwaltungsservice und des Liveaktualisierungsservice](#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Ant-Tasks für die Installation des MobileFirst-Server-Push-Service](#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
* [Ant-Tasks für die Installation des Application Center](#ant-tasks-for-installation-of-application-center)
* [Ant-Tasks für die Installation von {{ site.data.keys.mf_analytics }}](#ant-tasks-for-installation-of-mobilefirst-analytics)
* [Interne Laufzeitdatenbanken](#internal-runtime-databases)
* [Beispielkonfigurationsdateien](#list-of-sample-configuration-files)
* [Beispielkonfigurationsdateien für {{ site.data.keys.mf_analytics }}](#sample-configuration-files-for-mobilefirst-analytics)

## Referenzinformationen zur Ant-Task configuredatabase
{: #ant-configuredatabase-task-reference }
Nachfolgend finden Sie Referenzinformationen für die Ant-Task configuredatabase. Diese Referenzinformationen beziehen sich nur auf relationale Datenbanken. Sie gelten nicht für Cloudant.

Die Ant-Task **configuredatabase** erstellt die relationalen Datenbanken, die vom MobileFirst-Server-Verwaltungsservice, -Liveaktualisierungsservice und -Push-Service, sowwie von der {{ site.data.keys.product_adj }}-Laufzeit und von den Application-Center-Services verwendet werden. Diese Ant-Task konfiguriert mit folgenden Aktionen eine relationale Datenbank:

* Sie prüft, ob die {{ site.data.keys.product_adj }}-Tabellen vorhanden sind, und erstellt sie ggf.
* Wenn es Tabellen für eine ältere Version der {{ site.data.keys.product }} gibt, migriert sie die Tabellen auf die aktuelle Version.
* Wenn es Tabellen für die aktuelle Version der {{ site.data.keys.product }} gibt, unternimmt die Task nichts.

Wenn eine der folgenden Bedingungen erfüllt ist, kann die Task außerdem folgende Effekte haben:

* Der DBMS-Typ ist Derby.
* Es gibt ein inneres Element `<dba>`.
* Der DBMS-Typ ist DB2 und der angegebene Benutzer ist berechtigt, Datenbanken zu erstellen.

Hier folgen die Effekte, wenn eine der Bedingungen erfüllt ist:

* Sie erstellt, sofern erforderlich, die Datenbank (außer Oracle 12c und Cloudant).
* Sie erstellt, sofern erforderlich, einen Benutzer und erteilt diesem Benutzer Zugriffsberechtigungen für die Datenbank.

> **Hinweis:** Die Ant-Task configuredatabase hat keinerlei Auswirkungen, wenn Sie sie mit Cloudant verwenden.

### Attribute und Elemente für die Task configuredatabase
{: #attributes-and-elements-for-configuredatabase-task }

Die Task **configuredatabase** wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|-------------|----------|---------|
|kind|Typ der Datenbank. In {{ site.data.keys.mf_server }}: MobileFirstRuntime, MobileFirstConfig, MobileFirstAdmin oder push. Im Application Center: ApplicationCenter. |Ja |Keiner |
|includeConfigurationTables |Angabe, ob Datenbankoperationen für den Liveaktualisierungsservice und den Verwaltungsservice oder nur für den Verwaltungsservice ausgeführt werden sollen. Gültige Werte sind true und false. |Nein |true |
|execute |Angabe, ob die Ant-Task configuredatabase ausgeführt werden soll. Gültige Werte sind true und false. |Nein |true |

#### kind
{: #kind }
Die {{ site.data.keys.product }} unterstützt vier Arten von Datenbanken. Die {{ site.data.keys.product_adj }}-Laufzeit verwendet die Datenbank des Typs **MobileFirstRuntime**. Der MobileFirst-Server-Verwaltungsservice verwendet eine Datenbank vom Typ **MobileFirstAdmin**. Der MobileFirst-Server-Liveaktualisierungsservice verwendet eine Datenbank vom Typ **MobileFirstConfig**. Standardmäßig wird eine Datenbank vom Typ **MobileFirstAdmin** erstellt. Der MobileFirst-Server-Push-Service verwendet eine Datenbank vom Typ **push**. Das Application Center verwendet eine Datenbank vom Typ **ApplicationCenter**.

#### includeConfigurationTables
{: #includeconfigurationtables }
Das Attribut **includeConfigurationTables** kann nur verwendet werden, wenn das Attribut **kind** den Wert **MobileFirstAdmin** hat. Gültige Werte sind true und false. Wenn dieses Attribut auf true gesetzt ist, führt die Task configuredatabase** in einem Durchgang Datenbankoperationen für die Datenbank des Verwaltungsservice und die des Liveaktualisierungsservice aus. Wenn dieses Attribut auf false gesetzt ist, führt die Task **configuredatabase** nur Datenbankoperationen für die Datenbank des Verwaltungsservice aus.

#### execute
{: #execute }
Das Attribut **execute** aktiviert oder inaktiviert die Ausführung der Ant-Task **configuredatabase**. Gültige Werte sind true und false. Wenn dieses Attribut auf false gesetzt ist, führt die Task **configuredatabase** keine Konfigurations- oder Datenbankoperationen aus. 

Die Task **configuredatabase** unterstützt die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|---------------------|-----------------------------|-------|
| `<derby>`           |Parameter für Derby |0..1 |
| `<db2>`             |	Parameter für DB2 |0..1 |
| `<mysql>`           |	Parameter für MySQL |0..1 |
| `<oracle>`          |	Parameter für Oracle |0..1 |
| `<driverclasspath>` |JDBC-Treiberklassenpfad |0..1 |

Für jeden Datenbanktyp können Sie ein Element `<property>` verwenden, um eine JDBC-Verbindungseigenschaft für den Zugriff auf die Datenbank anzugeben. Das Element `<property>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------|----------|---------|
| name      |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |Ja |Keiner |   

#### Apache Derby
{: #apache-derby }
Das Element `<derby>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|--------------------------------------------|----------|------------------------------------------------------------------------------|
|database|Datenbankname |Nein |Je nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
|datadir |Verzeichnis mit den Datenbanken |Ja |Keiner |
|schema	|Schemaname |Nein |Je nach Art des Schemas MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH oder APPCENTER|

Das Element `<derby>` unterstützt das folgende Element:

|Element|Beschreibung |Anzahl |
|--------------|---------------------------------|---------|
| `<property>` |JDBC-Verbindungseigenschaft |0..∞ |

Informationen zu den verfügbaren Eigenschaften finden Sie unter [Setting attributes for the database connection URL](http://db.apache.org/derby/docs/10.11/ref/rrefattrib24612.html).

#### DB2
{: #db2 }
Das Element `<db2>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|---------|
| database  |Datenbankname |Nein |Je nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
| server    |Hostname des Datenbankservers | |Ja |Keiner |
| port      |Port des Datenbankservers |Nein | 50000 |
| user      |Benutzername für den Datenbankzugriff |Ja |Keiner |
| password  |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |
|instance |Name der DB2-Instanz |Nein |Hängt vom Server ab |
| schema    |Schemaname |Nein |Hängt vom Benutzer ab|

Weitere Informationen
zu DB2-Benutzeraccounts finden Sie im Artikel
[DB2-Sicherheitsmodell - Übersicht](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).   
Das Element `<db2>` unterstützt die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|--------------|-----------------------------------------|---------|
| `<property>` |JDBC-Verbindungseigenschaft |0..∞ |
| `<dba>`      |Berechtigungsnachweise des Datenbankadministrators | 0..1    |

Welche Eigenschaften verfügbar sind, erfahren Sie unter [Properties for the IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).  
Das innere Element `<dba>` gibt die Berechtigungsnachweise für Datenbankadministratoren an. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|---------|
| user      |Benutzername für den Datenbankzugriff |Ja |Keiner |
| password  |Kennwort für den Datenbankzugriff |Nein |Interaktiv abgefragt |

Der in einem Element `<dba>` angegebene Benutzer muss die DB2-Berechtigung SYSADM oder SYSCTRL haben. Weitere Informationen finden Sie unter [Berechtigungen - Übersicht](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0055206.html).

Das Element `<driverclasspath>` muss die JAR-Dateien für den DB2-JDBC-Treiber und für die zugehörige Lizenz enthalten. Sie können diese Dateien auf eine der folgenden Arten abrufen:

* Sie können die DB2-JDBC-Treiber von der Webseite [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866) herunterladen.
* Alternativ können Sie die Datei **db2jcc4.jar** und die zugehörigen Dateien **db2jcc_license_*.jar** aus dem Verzeichnis **DB2-INSTALLATIONSVERZEICHNIS/java** auf dem DB2-Server abrufen.

Mit der Ant-Task können Sie keine Tabellenzuordnungsdetails, z. B. den Tabellenbereich, angeben. Führen Sie für die Steuerung des Tabellenbereichs manuell die Anweisungen im Abschnitt [Datenbank- und Benutzeranforderungen für DB2](../prod-env/databases/#db2-database-and-user-requirements) aus.

#### MySQL
{: #mysql }
Das Element `<mysql>` wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|---------|
|database	 |Datenbankname|Nein |Je nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
|server	 |Hostname des Datenbankservers | |Ja |Keiner |
|port	     |Port des Datenbankservers | |Nein | 3306 |
|user	            |Benutzername für den Datenbankzugriff |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

Weitere Informationen zu MySQL-Benutzerkonten
finden Sie im Artikel
[MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).  
Das Element `<mysql>` unterstützt die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|--------------|--------------------------------------------------|-------|
| `<property>` |JDBC-Verbindungseigenschaft |0..∞  |
| `<dba>`      |Berechtigungsnachweise des Datenbankadministrators | 0..1  |
| `<client>`   |Host, der auf die Datenbank zugreifen kann |0..∞  |

Informationen zu den verfügbaren Eigenschaften finden Sie unter [Driver/Datasource Class Names, URL Syntax and Configuration Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html).  
Das innere Element `<dba>` gibt die Berechtigungsnachweise des Datenbankadministrators an. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|---------|
|user	            |Benutzername für den Datenbankzugriff |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

Der in einem Element `<dba>` angegebene Benutzer muss über ein MySQL-Superuser-Konto verfügen. Weitere Informationen finden Sie im Artikel [Securing the Initial MySQL Accounts](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html).

Jedes innere Element `<client>` gibt einen Client-Computer oder einen Platzhalter für Client-Computer an. Diese Computer dürfen eine Verbindung zur Datenbank herstellen. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|--------------------------------------------------------------------------|----------|---------|
|hostname	|Symbolischer Hostname, IP-Adresse oder Schablone mit % als Platzhalter |Ja |Keiner |

Weitere Informationen zur Syntax von hostname finden Sie im Artikel [Specifying Account Names](http://dev.mysql.com/doc/refman/5.5/en/account-names.html).

Das Element `<driverclasspath>` muss eine "MySQL-Connector/J"-JAR-Datei enthalten. Sie können diese Datei von der Webseite [Download Connector/J](http://www.mysql.com/downloads/connector/j/) herunterladen.

Alternativ können Sie das Element `<mysql>` mit folgenden Attributen verwenden:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|-----------------------|
| url       |Datenbankverbindungs-URL |Ja |Keiner |
|user	            |Benutzername für den Datenbankzugriff |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

> `Hinweis:` Wenn Sie die Datenbank mit den alternativen Attributen angeben, muss es die Datenbank und den Benutzeraccount bereits geben und der Benutzer muss Zugriff auf die Datenbank haben. In diesem Fall versucht die Task **configuredatabase** weder, die Datenbank oder den Benutzer zu erstellen, noch versucht sie, dem Benutzer Zugriff zu erteilen. Die Task **configuredatabase** stellt nur sicher, dass die Datenbank die erforderlichen Tabellen für die aktuelle Version von {{ site.data.keys.mf_server }} enthält. Sie müssen kein inneres Element `<dba>` oder `<client>` angeben.

#### Oracle
{: #oracle }
Das Element `<oracle>` wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|----------------|--------------------------------------------------------------------------|----------|---------|
| database       |Datenbankname oder Oracle-Servicename. **Hinweis:** Für die Verbindung zu einer PDB-Datenbank müssen Sie immer einen Servicenamen verwenden. |Nein |ORCL|
|server	 |Hostname des Datenbankservers |Ja |Keiner |
|port	     |Port des Datenbankservers |Nein |1521 |
|user	            |Benutzername für den Datenbankzugriff. Lesen Sie den Hinweis unter der Tabelle. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |
|sysPassword	 |Kennwort des Benutzers SYS |Nein |Interaktiv abgefragt, wenn die Datenbank noch nicht existiert |
|systemPassword |Kennwort des Benutzers SYSTEM |Nein |Interaktiv abgefragt, wenn die Datenbank oder der Benutzer noch nicht existiert |

> `Hinweis:` Geben Sie den Benutzernamen für das Attribut user bevorzugt in Großbuchstaben an. Oracle-Benutzernamen bestehen generell aus Großbuchstaben. Im Gegensatz zu anderen Datenbanktools konvertiert die Ant-Task **configuredatabase** Kleinbuchstaben von Benutzernamen nicht in Großbuchstaben. Wenn die Ant-Task **configuredatabase** keine Verbindung zu Ihrer Datenbank herstellen kann, versuchen Sie, den Wert für das Attribut **user** in Großbuchstaben anzugeben.



Weitere Informationen zu
Oracle-Benutzeraccounts finden Sie im Artikel
[Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).  
Das Element `<oracle>` unterstützt die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|--------------|--------------------------------------------------|-------|
| `<property>` |JDBC-Verbindungseigenschaft |0..∞  |
| `<dba>`      |Berechtigungsnachweise des Datenbankadministrators | 0..1  |

Informationen zu den verfügbaren Verbindungseigenschaften finden Sie unter [Class OracleDriver](http://docs.oracle.com/cd/E11882_01/appdev.112/e13995/oracle/jdbc/OracleDriver.html).  
Das innere Element `<dba>` gibt die Berechtigungsnachweise des Datenbankadministrators an. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut |Beschreibung |Erforderlich |Standardwert |
|----------------|--------------------------------------------------------------------------|----------|---------|
|user	            |Benutzername für den Datenbankzugriff. Lesen Sie den Hinweis unter der Tabelle. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

Das Element `<driverclasspath>` muss eine Oracle-JDBC-Treiber-JAR-Datei enthalten. Sie können Oracle-JDBC-Treiber von
der Webseite [JDBC, SQLJ, Oracle JPublisher and
Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) herunterladen.

Mit der Ant-Task können Sie keine Tabellenzuordnungsdetails, z. B. den Tabellenbereich, angeben. Zum Steuern des Tabellenbereichs können Sie den Benutzeraccount manuell erstellen und ihn einem Standardtabellenbereich zuordnen, bevor Sie die Ant-Task ausführen. Führen Sie für die Steuerung weiterer Aspekte manuell die Anweisungen unter [Datenbank- und Benutzeranforderungen für Oracle](../prod-env/databases/#oracle-database-and-user-requirements) aus.

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------------------|----------|-----------------------|
| url       |Datenbankverbindungs-URL |Ja |Keiner |
|user	            |Benutzername für den Datenbankzugriff. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

> **Hinweis:** Wenn Sie die Datenbank mit den alternativen Attributen angeben, muss es die Datenbank und den Benutzeraccount bereits geben und der Benutzer muss Zugriff auf die Datenbank haben. In diesem Fall versucht die Task weder, die Datenbank oder den Benutzer zu erstellen, noch versucht Sie, dem Benutzer Zugriff zu erteilen. Die Task **configuredatabase** stellt nur sicher, dass die Datenbank die erforderlichen Tabellen für die aktuelle Version von {{ site.data.keys.mf_server }} enthält. Sie müssen kein inneres Element `<dba>` angeben.



## Ant-Tasks für die Installation der {{ site.data.keys.mf_console }}, der MobileFirst-Server-Artefakte, des MobileFirst-Server-Verwaltungsservice und des Liveaktualisierungsservice
{: #ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services }
Für die Installation der {{ site.data.keys.mf_console }}, der Artefaktkomponente, des Verwaltungsservice und des Liveaktualisierungsservice stehen die Ant-Tasks **installmobilefirstadmin**, **updatemobilefirstadmin** und **uninstallmobilefirstadmin** zur Verfügung.

### Auswirkungen der Tasks
{: #task-effects }

#### installmobilefirstadmin
{: #installmobilefirstadmin }
Die Ant-Task **installmobilefirstadmin** konfiguriert einen Anwendungsserver für die Ausführung der WAR-Dateien für den Verwaltungs- und den Liveaktualisierungsservice als Webanwendung und optional für die Installation der {{ site.data.keys.mf_console }}. Diese Task hat die folgenden Auswirkungen: 

* Sie deklariert die Webanwendung für den Verwaltungsservice im angegebenen Kontextstammverzeichnis (standardmäßig in /mfpadmin).
* Sie deklariert die Webanwendung für den Liveaktualisierungsservice in einem Kontextstammverzeichnis, das aus dem angegebenen Kontextstammverzeichnis für den Verwaltungsservice abgeleitet wird und standardmäßig /mfpadminconfig lautet.
* Sie deklariert für die relationalen Datenbanken Datenquellen und in WebSphere Application Server Full Profile JDBC-Provider für den Verwaltungsservice.
* Sie implementiert den Verwaltungs- und den Liveaktualisierungsservice im Anwendungsserver.
* Sie deklariert optional die {{ site.data.keys.mf_console }} als Webanwendung im angegebenen Kontextstammverzeichnis (standardmäßig in /mfpconsole). Wenn die Instanz der {{ site.data.keys.mf_console }} angegeben wird, deklariert die Ant-Task den entsprechenden JNDI-Umgebungseintrag für die Kommunikation mit dem entsprechenden Management-Service. Beispiel:

```xml
<target name="adminstall">
  <installmobilefirstadmin servicewar="${mfp.service.war.file}">
    <console install="${mfp.admin.console.install}" warFile="${mfp.console.war.file}"/>
```

* Sie deklariert optional die Webanwendung für die MobileFirst-Server-Artefakte im angegebenen Kontextstammverzeichnis /mfp-dev-artifacts, wenn die {{ site.data.keys.mf_console }} installiert ist.
* Sie konfiguriert die Konfigurationseigenschaften für den Verwaltungsservice mithilfe von JNDI-Umgebungseinträgen. Diese JNDI-Umgebungseinträge enthalten außerdem einige zusätzliche Informationen zur Anwendungsservertopologie, z. B., ob die Topologie eine eigenständige Konfiguration, ein Cluster oder eine Server-Farm ist.
* Sie konfiguriert optional Benutzer, die sie Rollen zuordnet, die von den Webanwendungen für die {{ site.data.keys.mf_console }} sowie für den Verwaltungsservice und den Liveaktualisierungsservice verwendet werden.
* Sie konfiguriert den Anwendungsserver für die Verwendung von JMX.
* Sie konfiguriert optional die Kommunikation mit dem MobileFirst-Server-Push-Service.
* Sie legt optional die MobileFirst-JNDI-Umgebungseinträge fest, mit denen der Anwendungsserver als Server-Farmmember für die MobileFirst-Server-Verwaltungskomponente konfiguriert wird.

#### updatemobilefirstadmin
{: #updatemobilefirstadmin }
Die Ant-Task **updatemobilefirstadmin** aktualisiert eine bereits konfigurierte Webanwendung für {{ site.data.keys.mf_server }} in einem Anwendungsserver. Diese Task hat die folgenden Auswirkungen: 

* Sie aktualisiert die WAR-Datei für den Verwaltungsservice. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde.
* Sie aktualisiert die WAR-Datei für den Liveaktualisierungsservice. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde.
* Sie aktualisiert die WAR-Datei für die {{ site.data.keys.mf_console }}. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde. Die Task ändert nicht die Konfiguration des Anwendungsservers, d. h. die Konfiguration der Webanwendungen, die Datenquellen, die JNDI-Umgebungseinträge, die Benutzer-Rollen-Zuordnungen und die JMX-Konfiguration.

#### uninstallmobilefirstadmin
{: #uninstallmobilefirstadmin }
Die Ant-Task **uninstallmobilefirstadmin** macht die Auswirkungen einer vorherigen Ausführung der Task installmobilefirstadmin rückgängig. Diese Task hat die folgenden Auswirkungen: 

* Sie entfernt die Konfiguration der Webanwendung für den Verwaltungsservice mit dem angegebenen Kontextstammverzeichnis. Infolgedessen entfernt die Task auch die Einstellungen, die dieser Anwendung manuell hinzugefügt wurden.
* Sie entfernt optional die WAR-Dateien des Verwaltungs- und Liveaktualisierungsservice sow der {{ site.data.keys.mf_console }} aus dem Anwendungsserver.
* Sie entfernt für das relationale DBMS die Datenquellen und in WebSphere Application Server Full Profile die JDBC-Provider für den Verwaltungs- und Liveaktualisierungsservice.
* Sie entfernt für das relationale DBMS die Datenbanktreiber, die vom Verwaltungs- und Liveaktualisierungsservice verwendet wurden, aus dem Anwendungsserver.
* Sie entfernt die zugehörigen JNDI-Umgebungseinträge.
* In WebSphere Application Server Liberty und Apache Tomcat entfernt sie die vom installmobilefirstadmin-Aufruf konfigurierten Benutzer.
* Sie entfernt die JMX-Konfiguration.

### Attribute und Elemente
{: #attributes-and-elements }
Die Ant-Tasks **installmobilefirstadmin**, **updatemobilefirstadmin** und **uninstallmobilefirstadmin** werden mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------|--------------------------------------------------------------------------|----------|---------|
| contextroot       |Einheitliches Präfix für URLs des Verwaltungsservice, um Informationen zu {{ site.data.keys.product_adj }}-Laufzeitumgebungen, -Anwendungen und -Adaptern abzurufen |Nein |/mfpadmin |
| id                |Unterscheidung verschiedener Implementierungen|Nein |Leer |
|environmentId |Unterscheidung verschiedener {{ site.data.keys.product_adj }}-Umgebungen|Nein |Leer |
| servicewar        |WAR-Datei für den Verwaltungsservice |Nein |Die Datei mfp-admin-service.war befindet sich in demselben Verzeichnis wie die Datei mfp-ant-deployer.jar. |
| shortcutsDir      |Verzeichnis für Verknüpfungen |Nein |Keiner |
| wasStartingWeight |Startreihenfolge für WebSphere Application Server. Komponenten mit niedrigeren Werten werden zuerst gestartet. |Nein |1 |

#### contextroot und id
{: #contextroot-and-id }
Anhand der Attribute **contextroot** und **id** können die verschiedenen Implementierungen der {{ site.data.keys.mf_console }} und des Verwaltungsservice unterschieden werden.

In WebSphere-Application-Server-Liberty-Profile- und Tomcat-Umgebungen ist für diesen Zweck der Parameter contextroot ausreichend. In WebSphere-Application-Server-Full-Profile-Umgebungen wird stattdessen das Attribut id verwendet. Ohne dieses Attribut id können zwei WAR-Dateien mit denselben Kontextstammverzeichnissen miteinander in Konflikt geraten, was dazu führt, dass diese Dateien nicht implementiert werden. 

#### environmentId
{: #environmentid }
Mithilfe des Attributs **environmentId** werden mehrere Umgebungen unterschieden, die jeweils aus dem MobileFirst-Server-Verwaltungsservice und {{ site.data.keys.product_adj }}-Laufzeitwebanwendungen bestehen, die unabhängig funktionieren müssen. Wenn Sie diese Option verwenden, können Sie beispielsweise eine Testumgebung, eine Vorproduktionsumgebung und eine Produktionsumgebung in demselben Server und in derselben WebSphere-Application-Server-Network-Deployment-Zelle bereitstellen. Dieses Attribut environmentId erstellt ein Suffix, das zu Namen von MBeans hinzugefügt wird, die der Verwaltungsservice und die {{ site.data.keys.product_adj }}-Laufzeitprojekte bei der Kommunikation über Java Management Extensions (JMX) verwenden.

#### servicewar
{: #servicewar }
Mit dem Attribut **servicewar** können Sie ein anderes Verzeichnis für die WAR-Datei für den Verwaltungsservice angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

#### shortcutsDir
{: #shortcutsdir }
Das Attribut **shortcutsDir** gibt an, wo Direktaufrufe für die {{ site.data.keys.mf_console }} gespeichert werden sollen. Wenn Sie dieses Attribut definieren, können Sie diesem Verzeichnis die folgenden Dateien hinzufügen: 

* **mobilefirst-console.url**: Diese Datei ist eine Windows-Verknüpfung. Sie öffnet die {{ site.data.keys.mf_console }} in einem Browser.
* **mobilefirst-console.sh**: Diese Datei ist ein UNIX-Shell-Script und öffnet die {{ site.data.keys.mf_console }} in einem Browser.
* **mobilefirst-admin-service.url**: Diese Datei ist eine Windows-Verknüpfung. Sie wird in einem Browser geöffnet und ruft einen REST-Service auf, der eine Liste der {{ site.data.keys.product_adj }}-Projekte zurückgibt, die im JSON-Format verwaltet werden können. Für jedes aufgelistete {{ site.data.keys.product_adj }}-Projekt sind auch Details zu den zugehörigen Artefakten verfügbar, z. B. die Anzahl der Anwendungen, der Adapter, der aktiven Geräte und der stillgelegten Geräte. In der Liste ist außerdem angegeben, ob eine {{ site.data.keys.product_adj }}-Projektlaufzeit aktiv oder inaktiv ist.
* **mobilefirst-admin-service.sh**:  Diese Datei ist ein UNIX-Shell-Script, das dieselbe Ausgabe wie die Datei **mobilefirst-admin-service.url** bereitstellt.

#### wasStartingWeight
{: #wasstartingweight }
Mit dem Attribut **wasStartingWeight** geben Sie einen Wert an, der in WebSphere Application Server als Gewichtung verwendet wird, um sicherzustellen, dass eine Startreihenfolge eingehalten wird. Die Webanwendung für den Verwaltungsservice wird infolge des Wertes für die Startreihenfolge vor allen anderen {{ site.data.keys.product_adj }}-Laufzeitprojekten implementiert und gestartet. Sollten {{ site.data.keys.product_adj }}-Projekte vor der Webanwendung implementiert oder gestartet werden, wird keine JMX-Kommunikation ermöglicht, sodass die Laufzeit nicht mit der Datenbank für den Verwaltungsservice synchronisiert werden und keine Serveranforderungen handhaben kann.

Die Ant-Tasks **installmobilefirstadmin**, **updatemobilefirstadmin** und **uninstallmobilefirstadmin** unterstützen die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|-----------------------|--------------------------------------------------|-------|
| `<applicationserver>` |Anwendungsserver|1 |
| `<configuration>`     |Liveaktualisierungsservice |1 |
| `<console>`           |Administrationskonsole | 0..1  |
| `<database>`          |Datenbanken |1 |
| `<jmx>`               |Aktivierung der Java Management Extensions |1 |
| `<property>`          |Eigenschaften |0.. |
| `<push>`              |Push-Service | 0..1  |
| `<user>`              |Benutzer, der einer Sicherheitsrolle zugeordnet werden soll| 0..   |

### Vorgehensweise für die Angabe einer {{ site.data.keys.mf_console }}
{: #to-specify-a-mobilefirst-operations-console }
Das Element `<console>` erfasst Informationen zur Anpassung der Installation der {{ site.data.keys.mf_console }}. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| contextroot       |URI der {{ site.data.keys.mf_console }} |Nein |/mfpconsole |
| install           |Angabe, ob die {{ site.data.keys.mf_console }} installiert werden muss |Nein |Ja |
| warfile           |WAR-Datei für die Konsole | Nein |Die Datei mfp-admin-ui.war befindet sich in demselben Verzeichnis wie die Datei mfp-ant-deployer.jar. |

Das Element `<console>` unterstützt das folgende Element:

|Element|Beschreibung |Anzahl |
|-----------------------|--------------------------------------------------|-------|
| `<artifacts>`         |MobileFirst-Server-Artefakte | 0..1  |
| `<property>`	        |Eigenschaften | 0..   |

Das Element `<artifacts>` wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------|---------------------------------------------------------------------------|----------|-------------|
| install           |Angabe, ob die Artefaktkomponente installiert werden muss |Nein |true |
|warFile |WAR-Datei für die Artefakte |Nein |Die Datei mfp-dev-artifacts.war befindet sich in demselben Verzeichnis wie die Datei mfp-ant-deployer.jar. |

Mit diesem Element können Sie Ihre eigenen JNDI-Eigenschaften definieren oder den Standardwert der JNDI-Eigenschaften überschreiben, die von den WAR-Dateien für den Verwaltungsservice und die {{ site.data.keys.mf_console }} bereitgestellt werden. 

Das Element `<property>` gibt eine Implementierungseigenschaft an, die im Anwendungsserver definiert werden muss. Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|----------------------------|----------|---------|
| name       |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |	Ja |Keiner |

Mit diesem Element können Sie Ihre eigenen JNDI-Eigenschaften definieren oder den Standardwert der JNDI-Eigenschaften überschreiben, die von den WAR-Dateien für den Verwaltungsservice und die {{ site.data.keys.mf_console }} bereitgestellt werden. 

Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Vorgehensweise bei der Angabe eines Anwendungsservers
{: #to-specify-an-application-server }
Mit dem Element `<applicationserver>` können Sie die Parameter definieren, die vom zugrundeliegenden Anwendungsserver abhängig sind. Das Element `<applicationserver>` unterstützt die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|-------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` oder `<was>` |Parameter für WebSphere Application Server. <br/><br/>Das Element `<websphereapplicationserver>` (oder in seiner Kurzform `was>`) gibt eine WebSphere-Application-Server-Instanz an. WebSphere Application Server Full Profile (Base und Network Deployment) werden ebenso wie WebSphere Application Server Liberty Core und WebSphere Application Server Liberty Network Deployment unterstützt. | 0..1  |
| `<tomcat>`                                |Parameter für Apache Tomcat| 0..1  |

Die Attribute und inneren Elemente für diese Elemente sind in den Tabellen im Abschnitt [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) beschrieben.  
Das innere Element des Elements `<was>` für einen Liberty-Verbund ist in der folgenden Tabelle angegeben:

|Element|Beschreibung |Anzahl |
|--------------------------|----------------------------------|-------|
| `<collectiveController>` |Controller eines Liberty-Verbunds |	 0..1  |

Das Element `<collectiveController>` wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------------------|----------------------------------------|----------|---------|
| serverName               |Name des Verbundcontrollers |Ja |Keiner |
| controllerAdminName      |Name des im Verbundcontroller definierten Benutzers mit Verwaltungsaufgaben. Dieser Benutzer wird auch verwendet, wenn neue Member in den Verbund aufgenommen werden. |Ja |Keiner |
| controllerAdminPassword  |Kennwort des Benutzers mit Verwaltungsaufgaben|Ja |Keiner |
| createControllerAdmin    |Angabe, ob der Benutzer mit Verwaltungsaufgaben in der Basisregistry des Verbundcontrollers erstellt werden muss. Die gültigen Werte sind true und false. |Nein |true |

### Konfiguration des Liveaktualisierungsservice angeben
{: #to-specify-the-live-update-service-configuration }
Mit dem Element `<configuration>` können Sie die Parameter definieren, die vom Liveaktualisierungsservice abhängig sind. Das Element `<configuration>` wird mit folgenden Attributen verwendet.

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------------------|----------------------------------------------------------------|----------|---------|
| install                  |Angabe, ob der Liveaktualisierungsservice installiert werden muss |Ja |true |
|configAdminUser	       |Administrator des Liveaktualisierungsservice |Nein, außer in einer Server-Farmtopologie | Wenn kein Wert definiert ist, wird ein Benutzer generiert. In einer Server-Farmtopologie muss der Benutzername für alle Member der Farm der gleiche sein. |
|configAdminPassword |Administratorkennwort für den Liveaktualisierungsservice |Wenn für **configAdminUser** ein Benutzer angegeben ist |Keiner. In einer Server-Farmtopologie muss das Kennwort für alle Member der Farm das gleiche sein. |
|createConfigAdminUser |Angabe, ob bei fehlendem Benutzer mit Verwaltungsaufgaben in der Basisregistry ein solcher Benutzer erstellt werden soll |Nein |true |
|warFile |WAR-Datei für den Liveaktualisierungsservice |Nein |Die Datei mfp-live-update.war befindet sich in demselben Verzeichnis wie die Datei mfp-ant-deployer.jar. |

Das Element `<configuration>` unterstützt die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|--------------|---------------------------------------|-------|
| `<user>`     |Benutzer des Liveaktualisierungsservice | 0..1  |
| `<property>` |Eigenschaften | 0..   |

Das Element `<user>` erfasst die Parameter über einen Benutzer, die in eine bestimmte Sicherheitsrolle für eine Anwendung aufzunehmen sind. 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------|-------------------------------------------------------------------------|----------|---------|
|role	      |Gültige Sicherheitsrolle für die Anwendung. Gültiger Wert: configadmin. |Ja |Keiner |
|name	       |Benutzername|Ja |Keiner |
|password	 |Kennwort, falls der Benutzer erstellt werden muss |Nein |Keiner |

Nachdem Sie die Benutzer mit dem Element `<user>` definiert haben, können Sie sie jeder der folgenden Rollen für die Authentifizierung in der {{ site.data.keys.mf_console }} zuordnen: `configadmin`.

Weitere Informationen zur erforderlichen Autorisierung für die einzelnen Rollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration). 

> **Tipp:** Wenn die Benutzer in einem externen LDAP-Verzeichnis vorhanden sind, definieren Sie nur die Attribute **role** und **name**, aber keine Kennwörter. 

Das Element `<property>` gibt eine Implementierungseigenschaft an, die im Anwendungsserver definiert werden muss. Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|----------------------------|----------|---------|
| name       |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |	Ja |Keiner |

Mit diesem Element können Sie Ihre eigenen JNDI-Eigenschaften definieren oder den Standardwert der JNDI-Eigenschaften überschreiben, die von den WAR-Dateien für den Verwaltungsservice und die {{ site.data.keys.mf_console }} bereitgestellt werden. Weitere Informationen zu den JNDI-Eigenschaften finden Sie in der [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).

### Vorgehensweise bei der Angabe eines Anwendungsservers
{: #to-specify-an-application-server-1 }
Mit dem Element `<applicationserver>` können Sie die Parameter definieren, die vom zugrundeliegenden Anwendungsserver abhängig sind. Das Element `<applicationserver>` unterstützt die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|--------------|--------------------------------------------------------- |-------|
| `<websphereapplicationserver>` oder `<was>`	|Parameter für WebSphere Application Server <br/><br/>Das Element <websphereapplicationserver> (oder in seiner Kurzform <was>) gibt eine WebSphere-Application-Server-Instanz an. WebSphere Application Server Full Profile
(Base und Network Deployment) werden ebenso wie
WebSphere Application Server Liberty Core und
WebSphere Application Server Liberty Network
Deployment unterstützt. | 0..1  |
| `<tomcat>`   |Parameter für Apache Tomcat| 0..1  |

Die Attribute und inneren Elemente für diese Elemente sind in den Tabellen im Abschnitt [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) beschrieben.  
Das innere Element des Elements <was> für einen Liberty-Verbund ist in der folgenden
Tabelle angegeben. 

|Element|Beschreibung |Anzahl |
|-----------------------|----------------------------- |-------|
| `<collectiveMember>`	|Member eines Liberty-Verbunds| 0..1  |

Das Element `<collectiveMember>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------|---------------------------------------------------------|----------|---------|
| serverName  |	Name des Verbundmembers|Ja |Keiner |
|clusterName|	Name des Clusters, zu dem das Verbundmember gehört|Ja |Keiner |

> **Hinweis:** Wenn der Push-Service und die Laufzeitkomponenten im selben Verbundmember installiert sind, müssen sie den gleichen Clusternamen
haben. Sind diese Komponenten auf verschiedenen Membern desselben Verbundes installiert, können die Clusternamen verschieden sein.



### Vorgehensweise für die Angabe von Analytics
{: #to-specify-analytics }
Das Element `<analytics>` gibt an, dass vom
{{ site.data.keys.product_adj }}-Push-Service eine Verbindung zum bereits
installierten {{ site.data.keys.mf_analytics }} Service hergestellt werden soll.
Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|---------------|---------------------------------------------------------------------------|----------|---------|
|install	    |Angabe, ob der Push-Service eine Verbindung zu {{ site.data.keys.mf_analytics }} herstellen soll|Nein |false |
|analyticsURL 	|URL der {{ site.data.keys.mf_analytics }} Services|Ja |Keiner |
|username	    |Benutzername|Ja |Keiner |
|password	 |Kennwort |Ja |Keiner |
|validate	   |Prüft, ob die {{ site.data.keys.mf_analytics_console }} zugänglich ist|Nein |true |

**install**  
Mit dem Attribut "install" können Sie angeben, dass dieser
Push-Service mit {{ site.data.keys.mf_analytics }} verbunden sein und Daten senden soll.
Gültige Werte sind
true und false.

**analyticsURL**  
Mit dem Attribut analyticsURL können Sie die URL angeben,
die von der Komponente {{ site.data.keys.mf_analytics }}, die eingehende Analysedaten empfängt,
zugänglich gemacht wird. 

Beispiel: `http://<Hostname>:<Port>/analytics-service/rest` 

**username**  
Mit dem Attribut username können Sie den Benutzernamen angeben, der verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


**password**  
Mit dem Attribut password können Sie das Kennwort angeben, das verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


**validate**  
Mit dem Attribut validate kann geprüft werden, ob die {{ site.data.keys.mf_analytics_console }}
zugänglich ist. Außerdem kann die Authentifizierung des Benutzernamens mit einem Kennwort überprüft werden. Die gültigen Werte sind true und false.


### Vorgehensweise für die Angabe einer Verbindung zur Datenbank für den Push-Service
{: #to-specify-a-connection-to-the-push-service-database }

Das Element `<database>` erfasst die Parameter, die eine Datenquellendeklaration in einem Anwendungsserver angeben, um auf die Datenbank für den Push-Service zuzugreifen.

Sie müssen eine einzelne Datenbank deklarieren: `<database kind="Push">`. Abgesehen davon, dass
das Element `<database>` die Elemente `<dba>` und `<client>` nicht
hat, geben Sie das Element `<database>` ähnlich wie die Ant-Task configuredatabase an.
Das Element <database> kann jedoch `<property>`-Elemente haben.


Das Element `<database>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|---------------|-------------------------------------------------|----------|---------|
| kind          |Die Art der Datenbank (Push)|Ja |Keiner |
|validate	   |Prüft, ob die Datenbank zugänglich ist|Nein |true |

Das Element `<database>` unterstützt die folgenden Elemente. Weitere Informationen zur Konfiguration dieser Datenbankelemente für ein relationales DBMS finden Sie in den Tabellen unter [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

|Element|Beschreibung |Anzahl |
|--------------------|----------------------------------------------------------------- |-------|
|<db2>	             |Parameter für DB2-Datenbanken| 0..1  |
|<derby>	         |Parameter für Apache-Derby-Datenbanken| 0..1  |
|<mysql>	         |Parameter für MySQL-Datenbanken| 0..1  |
|<oracle>	         |Parameter für Oracle-Datenbanken| 0..1  |
|<cloudant>	     |Parameter für Cloudant-Datenbanken| 0..1  |
|<driverclasspath>	 |Parameter für den JDBC-Treiberklassenpfad (nur relationale DBMS)| 0..1  |

> **Hinweis:** Die Attribute des Elements `<cloudant>`
unterscheiden
sich geringfügig von der Laufzeit. Weitere Informationen finden Sie in der folgenden Tabelle.



|Attribut|Beschreibung |Erforderlich |Standardwert |
|---------------|-------------------------------------------------|----------|---------------------------|
| url           |URL des Cloudant-Kontos|Nein |https://user.cloudant.com|
| user          |Benutzername des Cloudant-Kontos|Ja |Keiner |
| password      |Kennwort für das Cloudant-Konto|Nein |Interaktiv abgefragt |
|dbName|Name der Cloudant-Datenbank. **Wichtiger Hinweis:** Dieser Datenbankname muss mit einem Kleinbuchstaben beginnen und darf nur Kleinbuchstaben (a-z), Ziffern (0-9) sowie die Zeichen _, $ und - enthalten.|Nein |mfp_push_db|

## Ant-Tasks für die Installation des MobileFirst-Server-Push-Service
{: #ant-tasks-for-installation-of-mobilefirst-server-push-service }
Für die Installation des Push-Service stehen die Ant-Tasks **installmobilefirstpush**, **updatemobilefirstpush**
und **uninstallmobilefirstpush** zur Verfügung. 

### Auswirkungen der Tasks
{: #task-effects-1 }
#### installmobilefirstpush
{: #installmobilefirstpush }
Mit der Ant-Task **installmobilefirstpush** wird ein Anwendungsserver so konfiguriert, dass er die WAR-Datei des
Push-Service als Webanwendung ausführt.
Diese Task hat die folgenden Auswirkungen:
Sie deklariert die Webanwendung für den Push-Service im Kontextstammverzeichnis **/imfpush**. Das Kontextstammverzeichnis kann nicht geändert werden. Sie deklariert für die relationalen Datenbanken, Datenquellen und
in WebSphere Application Server Full Profile
JDBC-Provider für den Push-Service. Sie konfiguriert die Konfigurationseigenschaften für den Push-Service mithilfe von JNDI-Umgebungseinträgen. Diese JNDI-Umgebungseinträge konfigurieren die
OAuth-Kommunikation mit dem
{{ site.data.keys.product_adj }}-Autorisierungsserver, mit
{{ site.data.keys.mf_analytics }} und mit
Cloudant, sonfern Cloudant verwendet wird. 

#### updatemobilefirstpush
{: #updatemobilefirstpush }
Die Ant-Task **updatemobilefirstpush** aktualisiert eine
bereits konfigurierte Webanwendung für {{ site.data.keys.mf_server }}
in einem Anwendungsserver. Sie aktualisiert die WAR-Datei für den Push-Service. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde.

#### uninstallmobilefirstpush
{: #uninstallmobilefirstpush }
Die Ant-Task **uninstallmobilefirstpush** macht die Auswirkungen
einer vorherigen Ausführung der Task
**installmobilefirstpush** rückgängig.
Diese Task hat die folgenden Auswirkungen:
Sie entfernt die Konfiguration der Webanwendung für den Push-Service
mit dem angegebenen Kontextstammverzeichnis. Infolgedessen entfernt die Task auch
die Einstellungen, die dieser Anwendung manuell hinzugefügt wurden. Sie entfernt optional die WAR-Datei für den Push-Service aus dem Anwendungsserver. Sie entfernt für das relationale DBMS die Datenquellen und in
WebSphere Application Server Full Profile
die JDBC-Provider für den Push-Service. Sie entfernt die zugehörigen JNDI-Umgebungseinträge.

### Attribute und Elemente
{: #attributes-and-elements-1 }
Die
Ant-Tasks **installmobilefirstpush**,
**updatemobilefirstpush** und **uninstallmobilefirstpush** werden mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|---------------------------------------|----------|-------------|
| id        |Unterscheidung verschiedener Implementierungen|Nein |Leer
|warFile	        |WAR-Datei für den Push-Service|Nein |Die Datei ../PushService/mfp-push-service.war wird bezogen auf das MobileFirst-Server-Verzeichnis mit der Datei mfp-ant-deployer.jar angegeben.|

### Id
{: #id }
Mit dem Attribut **id** können verschiedene Push-Serviceimplementierungen in einer WebSphere-Application-Server-Zelle unterschieden werden.
Ohne dieses Attribut id können zwei WAR-Dateien mit denselben Kontextstammverzeichnissen miteinander in Konflikt geraten, was dazu führt, dass diese Dateien nicht implementiert werden. 

### warFile
{: #warfile }
Mit dem Attribut **warFile** können Sie ein anderes Verzeichnis für
die WAR-Datei für den Push-Service angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

Die
Ant-Tasks **installmobilefirstpush**,
**updatemobilefirstpush** und **uninstallmobilefirstpush** unterstützen folgende Elemente: 

|Element|Beschreibung |Anzahl |
|-----------------------|-------------------------|-------|
| `<applicationserver>` |Anwendungsserver|1 |
| `<analytics>`	        |Analytics	      | 0..1  |
| `<authorization>`	    |Autorisierungsserver für die Authentifizierung der Kommunikation mit anderen MobileFirst-Server-Komponenten|1 |
| `<database>`	        |Datenbanken |1 |
| `<property>`	        |Eigenschaften |0..∞  |

### Vorgehensweise für die Angabe des Autorisierungsservers
{: #to-specify-the-authorization-server }
Das Element `<authorization>` erfasst Informationen, um den Autorisierungsserver für den Austausch von Authentifizierungsdaten mit anderen MobileFirst-Server-Komponenten zu konfigurieren.
Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------------|---------------------------------------|----------|-------------|
|auto|Angabe, ob die URL des Autorisierungsservers berechnet werden soll. Gültige Werte sind true und false.|Für einen WebSphere-Application-Server-Network-Deployment-Cluster oder -Knoten erforderlich|true |
|authorizationURL|URL des Autorisierungsservers. |Wenn der Modus nicht "auto" ist|Kontextstammverzeichnis der Laufzeit auf dem lokalen Server|
|runtimeContextRoot|Kontextstammverzeichnis der Laufzeit|Nein |/mfp|
|pushClientID	     |ID des vertraulichen Clients für den Push-Service im Autorisierungsserver|Ja |Keiner |
|pushClientSecret	 |Kennwort des vertraulichen Clients für den Push-Service im Autorisierungsserver|Ja |Keiner |

#### auto
{: #auto }
Wenn dieses Attribut auf "true" gesetzt ist, wird die für den Autorisierungsserver automatisch anhand
des Kontextstammverzeichnisses der Laufzeit im lokalen Anwendungsserver berechnet. Der automatische Modus wird nicht bei einer Implementierung in einem
WebSphere-Application-Server-Network-Deployment-Cluster unterstützt. 

#### authorizationURL
{: #authorizationurl }
URL des Autorisierungsservers. Wenn der Autorisierungsserver die
{{ site.data.keys.product_adj }}-Laufzeit ist, ist diese URL die URL der Laufzeit. Beispiel: `http://myHost:9080/mfp`

#### runtimeContextRoot
{: #runtimecontextroot }
Kontextstammverzeichnis der Laufzeit, das verwendet wird, um im automatischen Modus die URL des Autorisierungsservers zu berechnen
#### pushClientID
{: #pushclientid }
ID dieser Push-Serviceinstanz als vertraulicher Client des Autorisierungsservers. Die ID und der geheime Schlüssel müssen
beim Autorisierungsserver registriert sein. Für die Registrierung können Sie die Ant-Task **installmobilefirstadmin** oder die
{{ site.data.keys.mf_console }} verwenden.

#### pushClientSecret
{: #pushclientsecret }
Geheimer Schlüssel dieser Push-Serviceinstanz als vertraulicher Client des Autorisierungsservers. Die ID und der geheime Schlüssel müssen
beim Autorisierungsserver registriert sein. Für die Registrierung können Sie die Ant-Task **installmobilefirstadmin** oder die
{{ site.data.keys.mf_console }} verwenden.

Das Element `<property>` gibt eine Implementierungseigenschaft an, die im Anwendungsserver definiert werden muss. Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|----------------------------|----------|---------|
| name       |Name der Eigenschaft |	Ja |Keiner |
|value	     |Wert der Eigenschaft |	Ja |Keiner |

Mit diesem Element können Sie Ihre
eigenen JNDI-Eigenschaften definieren oder den Standardwert der JNDI-Eigenschaften überschreiben, die
von der WAR-Datei für den Push-Service
bereitgestellt werden. 

Weitere Informationen zu den Produktinfoen finden Sie in der
[Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

### Vorgehensweise bei der Angabe eines Anwendungsservers
{: #to-specify-an-application-server-2 }
Mit dem Element `<applicationserver>` können Sie die Parameter definieren, die vom zugrundeliegenden Anwendungsserver abhängig sind. Das Element `<applicationserver>` unterstützt die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|---------------------------------------|--------------------------------------------------|-------|
|<websphereapplicationserver> oder <was>	|Parameter für WebSphere Application Server |Das Element `<websphereapplicationserver>` (oder in seiner Kurzform `<was>`) gibt eine WebSphere-Application-Server-Instanz an. WebSphere Application Server Full Profile
(Base und Network Deployment) werden ebenso wie
WebSphere Application Server Liberty Core und
WebSphere Application Server Liberty Network
Deployment unterstützt. | 0..1  |
| `<tomcat>` |Parameter für Apache Tomcat| 0..1  |

Die Attribute und inneren Elemente für diese Elemente sind in den Tabellen im Abschnitt [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) beschrieben.

Das innere Element des Elements `<was>` für einen Liberty-Verbund ist in der folgenden Tabelle angegeben:

| Element              |Beschreibung |Anzahl |
|----------------------|------------------------------|-------|
| `<collectiveMember>` |Member eines Liberty-Verbunds|	 0..1  |

Das Element `<collectiveMember>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------|------------------------------------|----------|---------|
| serverName  |Name des Verbundmembers|Ja |Keiner |
|clusterName|	Name des Clusters, zu dem das Verbundmember gehört|Ja |Keiner |

> **Hinweis:** Wenn der Push-Service und die Laufzeitkomponenten im selben Verbundmember installiert sind, müssen sie den gleichen Clusternamen
haben. Sind diese Komponenten auf verschiedenen Membern desselben Verbundes installiert, können die Clusternamen verschieden sein.



### Vorgehensweise für die Angabe von Analytics
{: #to-specify-analytics-1 }
Das Element `<analytics>` gibt an, dass vom
{{ site.data.keys.product_adj }}-Push-Service eine Verbindung zum bereits
installierten {{ site.data.keys.mf_analytics }} Service hergestellt werden soll.
Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|------------------------------------|----------|---------|
|install	    |Angabe, ob der Push-Service eine Verbindung zu {{ site.data.keys.mf_analytics }} herstellen soll|Nein |false |
|analyticsURL|URL der {{ site.data.keys.mf_analytics }} Services|Ja |Keiner |
|username	    |Benutzername|Ja |Keiner |
|password	 |Kennwort |Ja |Keiner |
|validate	   |Prüft, ob die {{ site.data.keys.mf_analytics_console }} zugänglich ist|Nein |true |

#### install
{: #install }
Mit dem Attribut **install** können Sie angeben, dass dieser
Push-Service mit {{ site.data.keys.mf_analytics }} verbunden sein und Daten senden soll.
Gültige Werte sind
true und false.

#### analyticsURL
{: #analyticsurl }
Mit dem Attribut **analyticsURL** können Sie die URL angeben,
die von der Komponente {{ site.data.keys.mf_analytics }},  die eingehende Analysedaten empfängt,
zugänglich gemacht wird.   
Beispiel: `http://<Hostname>:<Port>/analytics-service/rest` 

#### username
{: #username }
Mit dem Attribut **username** können Sie den Benutzernamen angeben, der verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


#### password
{: #password }
Mit dem Attribut **password** können Sie das Kennwort angeben, das verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


#### validate
{: #validate }
Mit dem Attribut **validate** kann geprüft werden, ob die
{{ site.data.keys.mf_analytics_console }}
zugänglich ist. Außerdem kann die Authentifizierung des Benutzernamens mit einem Kennwort überprüft werden. Die gültigen Werte sind true und false.


### Vorgehensweise für die Angabe einer Verbindung zur Datenbank für den Push-Service
{: #to-specify-a-connection-to-the-push-service-database-1 }
Das Element `<database>` erfasst die Parameter, die eine Datenquellendeklaration in einem Anwendungsserver angeben, um auf die Datenbank für den Push-Service zuzugreifen.

Sie müssen eine einzelne Datenbank deklarieren: `<database kind="Push">`. Abgesehen davon, dass
das Element `<database>` die Elemente `<dba>` und `<client>` nicht
hat, geben Sie das Element `<database>` ähnlich wie die Ant-Task configuredatabase an.
Das Element <database> kann jedoch `<property>`-Elemente haben.


Das Element `<database>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|------------------------------|----------|---------|
| kind         |Die Art der Datenbank (Push)|Ja |Keiner |
|validate	   |Prüft, ob die Datenbank zugänglich ist|Nein |true |

Das Element `<database>` unterstützt die folgenden Elemente. Weitere Informationen zur Konfiguration dieser Datenbankelemente für ein relationales DBMS finden Sie in den Tabellen unter [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

| Element              |Beschreibung |Anzahl |
|----------------------|-------------------------------------------|-------|
| `<db2>`	           |Parameter für DB2-Datenbanken| 0..1  |
| `<derby>`	           |Parameter für Apache-Derby-Datenbanken| 0..1  |
| `<mysql>`	           |Parameter für MySQL-Datenbanken| 0..1  |
| `<oracle>`           |Parameter für Oracle-Datenbanken| 0..1  |
| `<cloudant>`	       |Parameter für Cloudant-Datenbanken| 0..1  |
| `<driverclasspath>`  |Parameter für den JDBC-Treiberklassenpfad (nur relationale DBMS)| 0..1  |

> **Hinweis:** Die Attribute des Elements `<cloudant>`
unterscheiden
sich geringfügig von der Laufzeit. Weitere Informationen finden Sie in der folgenden Tabelle.



|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|----------------------------------------|------------|---------|
|url	     |URL des Cloudant-Kontos|Nein |https://user.cloudant.com|
|user	            |Benutzername des Cloudant-Kontos|Ja |Keiner |
|password	 |Kennwort für das Cloudant-Konto|Nein |Interaktiv abgefragt |
|dbName	   |Name der Cloudant-Datenbank. **Wichtiger Hinweis:** Dieser Datenbankname muss mit einem Kleinbuchstaben beginnen und darf nur Kleinbuchstaben (a-z), Ziffern (0-9) sowie die Zeichen _, $ und - enthalten.|Nein |mfp_push_db|

## Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen
{: #ant-tasks-for-installation-of-mobilefirst-runtime-environments }
Hier finden Sie Referenzinformationen zu den Ant-Tasks **installmobilefirstruntime**,
**updatemobilefirstruntime** und **uninstallmobilefirstruntime**. 

### Auswirkungen der Tasks
{: #task-effects-2 }

#### installmobilefirstruntime
{: #installmobilefirstruntime }
Die Ant-Task **installmobilefirstruntime** konfiguriert einen Anwendungsserver so, dass er
eine {{ site.data.keys.product_adj }}-Laufzeit-WAR-Datei als Webanwendung
ausführt. Diese Task hat die folgenden Auswirkungen: 

* Sie deklariert die {{ site.data.keys.product_adj }}-Webanwendung
im angegebenen Kontextstammverzeichnis, das standardmäßig /mfp lautet.
* Sie implementiert die Laufzeit-WAR-Datei im Anwendungsserver. 
* Sie deklariert Datenquellen und in WebSphere Application Server Full Profile
JDBC-Provider für die Laufzeit. 
* Sie implementiert die Datenbanktreiber im Anwendungsserver. 
* Sie legt die Konfigurationseigenschaften des {{ site.data.keys.product_adj }} über
JNDI-Umgebungseinträge fest. 
* Sie legt optional die
{{ site.data.keys.product_adj }}-JNDI-Umgebungseinträge
fest, mit denen der Anwendungsserver als Server-Farmmember
für die Laufzeit konfiguriert wird. 

#### updatemobilefirstruntime
{: #updatemobilefirstruntime }
Die Ant-Task **updatemobilefirstruntime** aktualisiert eine
bereits in einem Anwendungsserver konfigurierte {{ site.data.keys.product_adj }}-Laufzeit. Sie aktualisiert die Laufzeit-WAR-Datei. Die Datei muss denselben Basisnamen wie die zuvor implementierte Laufzeit-WAR-Datei haben.
Davon abgesehen wird die Konfiguration des
Anwendungsservers, d. h. Webanwendungskonfiguration, Datenquellen, JNDI-Umgebungseinträge,
nicht von der Task geändert. 

#### uninstallmobilefirstruntime
{: #uninstallmobilefirstruntime }
Mit der Ant-Task **uninstallmobilefirstruntime** werden die Auswirkungen einer vorherigen Ausführung
von **installmobilefirstruntime** rückgängig gemacht.
Diese Task hat die folgenden Auswirkungen: 

* Sie entfernt die Konfiguration der {{ site.data.keys.product_adj }}-Webanwendung
mit dem angegebenen Kontextstammverzeichnis. Dabei werden auch
die manuell zu der Anwendung hinzugefügten Einstellungen entfernt. 
* Sie entfernt die Laufzeit-WAR-Datei aus dem Anwendungsserver. 
* Sie entfernt die Datenquellen und in WebSphere Application Server Full Profile
die JDBC-Provider für die Laufzeit. 
* Sie entfernt die zugehörigen JNDI-Umgebungseinträge.

### Attribute und Elemente
{: #attributes-and-elements-2 }
Die
Ant-Tasks **installmobilefirstruntime**,
**updatemobilefirstruntime** und **uninstallmobilefirstruntime** werden mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------|-----------------------------------------------------------------------------|------------|---------------------------|
| contextroot       |Allgemeines Präfix in URLs der Anwendung (Kontextstammverzeichnis)|Nein |/mfp|
|id	       |Unterscheidung verschiedener Implementierungen|Nein |Leer
|
|environmentId	    |Unterscheidung verschiedener {{ site.data.keys.product_adj }}-Umgebungen|Nein |Leer
|
|warFile	        |WAR-Datei für die {{ site.data.keys.product_adj }}-Laufzeit|Nein |Die Datei mfp-server.war befindet sich in demselben Verzeichnis wie die Datei mfp-ant-deployer.jar.|
| wasStartingWeight |Startreihenfolge für WebSphere Application Server. Komponenten mit niedrigeren Werten werden zuerst gestartet. |Nein |2|                           |

#### contextroot und id
{: #contextroot-and-id-1 }
Anhand der Attribute **contextroot** und **id** werden
verschiedene {{ site.data.keys.product_adj }}-Projekte unterschieden.


In WebSphere-Application-Server-Liberty-Profile- und Tomcat-Umgebungen ist für diesen Zweck der Parameter contextroot ausreichend. In WebSphere-Application-Server-Full-Profile-Umgebungen
wird stattdessen das Attribut id verwendet. 

#### environmentId
{: #environmentid-1 }
Mithilfe des Attributs **environmentId** werden mehrere Umgebungen unterschieden, die jeweils aus dem MobileFirst-Server-Verwaltungsservice und {{ site.data.keys.product_adj }}-Laufzeitwebanwendungen bestehen, die unabhängig funktionieren müssen. Sie müssen dieses Attribut für die Laufzeitanwendung auf denselben Wert wie den setzen, der im <installmobilefirstadmin>-Aufruf für den Verwaltungsservice angegeben wurde. 

#### warFile
{: #warfile-1 }
Mit dem Attribut **warFile** können Sie ein anderes Verzeichnis für
die WAR-Datei der {{ site.data.keys.product_adj }}-Laufzeit angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

#### wasStartingWeight
{: #wasstartingweight-1 }
Mit dem Attribut **wasStartingWeight** geben Sie einen Wert an, der in WebSphere Application Server als Gewichtung verwendet wird, um sicherzustellen, dass eine Startreihenfolge eingehalten wird. Die Webanwendung für den
MobileFirst-Server-Verwaltungsservice wird infolge des Wertes für die Startreihenfolge vor allen anderen
{{ site.data.keys.product_adj }}-Laufzeitprojekten implementiert und gestartet. Sollten
{{ site.data.keys.product_adj }}-Projekte vor der Webanwendung implementiert oder gestartet werden, wird
keine JMX-Kommunikation ermöglicht, sodass Sie Ihre
{{ site.data.keys.product_adj }}-Projekte nicht verwalten können. 

Die
Tasks **installmobilefirstruntime**,
**updatemobilefirstruntime** und **uninstallmobilefirstruntime** unterstützen folgende Elemente: 

|Element|Beschreibung |Anzahl |
|-----------------------|--------------------------------------------------|-------|
| `<property>`          |Eigenschaften | 0..   |
| `<applicationserver>` |Anwendungsserver|1 |
| `<database>`          |Datenbanken |1 |
| `<analytics>`         |Analytics| 0..1  |

Das Element `<property>` gibt eine Implementierungseigenschaft an, die im Anwendungsserver definiert werden muss. Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------------------|----------|---------|
| name      |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |Ja |Keiner |  

Das Element `<applicationserver>` beschreibt den Anwendungsserver, in dem die {{ site.data.keys.product_adj }}-Anwendung implementiert wird. Dieses Element ist ein Container
für eines der folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|--------------------------------------------|--------------------------------------------------|-------|
| `<websphereapplicationserver>` oder `<was>`  |Parameter für WebSphere Application Server. | 0..1  |
| `<tomcat>`                                 |Parameter für Apache Tomcat| 0..1  |

Das Element `<websphereapplicationserver>` (oder in seiner Kurzform `<was>`) gibt eine WebSphere-Application-Server-Instanz an. WebSphere Application Server Full Profile
(Base und Network Deployment) werden ebenso wie
WebSphere Application Server Liberty Core und
WebSphere Application Server Liberty Network
Deployment unterstützt. Das Element `<websphereapplicationserver>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------------|--------------------------------------------------------|--------------------------|---------|
|installdir|	Installationsverzeichnis von WebSphere Application Server|Ja |Keiner |
|profile|	WebSphere Application Server Full Profile oder LIberty Profile|Ja |Keiner |
|user	| Name des Administrators von WebSphere Application Server|Ja, außer für Liberty|Keiner |
| password      |Kennwort des Administrators von WebSphere Application Server|Nein | Interaktiv abgefragt         |
|libertyEncoding|	Algorithmus zum Verschlüsseln von Datenquellenkennwörtern für WebSphere Application Server Liberty. Gültige Werte sind none, xor und aes. Unabhängig davon, ob die Verschlüsselung xor oder aes verwendet wird, wird das Kennwort im Klartext als Argument an das Programm securityUtility übergeben, das über einen externen Prozess aufgerufen wird. Sie können das Kennwort mit einem ps-Befehl oder unter UNIX-Betriebssystemen im Dateisystem /proc anzeigen.|Nein |	xor|
|jeeVersion|	Liberty Profile: Angabe, ob die Features des JEE6- oder des JEE7-Webprofils installiert werden sollen. Gültige Werte: 6, 7 und auto |Nein |auto|
|configureFarm|	Für WebSphere Application Server Liberty und WebSphere Application Server Full Profile (nicht für WebSphere Application Server Network Deployment Edition und für einen Liberty-Verbund). Angabe, ob der Server ein Server-Farmmember ist. Die gültigen Werte sind true und false. |Nein |false |
|farmServerId|	Zeichenfolge, über die ein Server in einer Server-Farm eindeutig identifiziert werden kann. Die MobileFirst-Server-Verwaltungsservices und alle {{ site.data.keys.product_adj }}-Laufzeiten, die mit dem Server kommunizieren, müssen den gleichen Wert verwenden.|Ja |	Keiner |

Für Einzelserverimplementierungen wird folgendes Element
unterstützt: 

|Element|Beschreibung |Anzahl |
|-------------|------------------|-------|
| `<server>`  |Einzelserver| 0..1  |

Das Element
<server>, das in diesem Kontext verwendet wird, hat folgendes Attribut:


|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|------------------|----------|---------|
|name	       |Servername|Ja |Keiner |

Für einen Liberty-Verbund wird folgendes Element
unterstützt: 

|Element |Beschreibung |Anzahl |
|-----------------------|------------------------------|-------|
| `<collectiveMember>`  |Member eines Liberty-Verbunds|0..1|

Das Element `<collectiveMember>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------------|------------------|----------|---------|
| serverName              |	Name des Verbundmembers|Ja |Keiner |
|clusterName|	Name des Clusters, zu dem das Verbundmember gehört|Ja |Keiner |
|serverId|	Zeichenfolge, über die das Verbundmember eindeutig identifiziert werden kann|Ja |Keiner |
|controllerHost|	Name des Verbundcontrollers|Ja |Keiner |
|controllerHttpsPort|	HTTPS-Port des Verbundcontrollers|Ja |Keiner |
| controllerAdminName      |	Name des im Verbundcontroller definierten Benutzers mit Verwaltungsaufgaben. Dieser Benutzer wird auch verwendet, wenn neue Member in den Verbund aufgenommen werden.|Ja |Keiner |
| controllerAdminPassword  |	Kennwort des Benutzers mit Verwaltungsaufgaben|Ja |Keiner |
| createControllerAdmin    |	Angabe, ob der Benutzer mit Verwaltungsaufgaben in der Basisregistry des Verbundmembers erstellt werden muss. Die gültigen Werte sind true und false. |Nein |true |

Für Network Deployment wird folgendes Element
unterstützt: 

|Element|Beschreibung |Anzahl |
|-------------|-----------------------------------------------|-------|
| `<cell>`    |	Gesamte Zelle| 0..1  |
| `<cluster>` |	Alle Server eines Clusters|	 0..1  |
| `<node>`    |	Alle Server eines Knotens, Cluster ausgeschlossen| 0..1  |
| `<server>`  |	Einzelserver| 0..1  |

Das Element `<cell>` hat keine Attribute. 

Das Element `<cluster>` wird mit folgendem Attribut verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|-------------------|----------|---------|
| name      |Clustername|Ja |Keiner |

Das Element `<node>` wird mit folgendem Attribut verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|----------------|----------|---------|
| name      |Knotenname|Ja |Keiner |

Das Element `<server>`, das in einem Network-Deployment-Kontext verwendet wird, hat die folgenden Attribute:


|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|------------------|----------|---------|
|nodeName|Knotenname|Ja |Keiner |
| serverName |Servername|Ja |Keiner |

Das Element `<tomcat>` gibt einen Apache-Tomcat-Server an. Es wird mit folgendem Attribut verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|---------------|------------------|----------|---------|
|installdir|Installationsverzeichnis von Apache Tomcat. Bei einer auf die Verzeichnisse CATALINA_HOME und CATALINA_BASE verteilten Tomcat-Installation geben Sie den Wert der Umgebungsvariablen CATALINA_BASE an.|Ja |Keiner |
|configureFarm|Angabe, ob der Server ein Server-Farmmember ist. Die gültigen Werte sind true und false.|Nein |false |
|farmServerId	|Zeichenfolge, über die ein Server in einer Server-Farm eindeutig identifiziert werden kann. Die MobileFirst-Server-Verwaltungsservices und alle {{ site.data.keys.product_adj }}-Laufzeiten, die mit dem Server kommunizieren, müssen den gleichen Wert verwenden.|Ja |Keiner |

Das Element `<database>` gibt die erforderlichen Informationen für den Zugriff auf eine bestimmte Datenbank an. Abgesehen davon, dass
das Element `<database>` die Elemente `<dba>` und `<client>` nicht
hat, geben Sie das Element `<database>` ähnlich wie die Ant-Task configuredatabase an.
Das Element `<database>` kann aber `<property>`-Elemente enthalten.
Das Element `<database>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-----------|--------------------------------------------|----------|---------|
| kind      |Die Art der Datenbank ({{ site.data.keys.product_adj }}-Laufzeit)|Ja |Keiner |
|validate|Prüft, ob die Datenbank zugänglich ist. Gültige Werte sind true und false.|Nein |true |

Das Element `<database>` unterstützt die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|---------------------|-----------------------------|-------|
| `<derby>`           |Parameter für Derby | 0..1  |
| `<db2>`             |	Parameter für DB2 | 0..1  |
| `<mysql>`           |	Parameter für MySQL | 0..1  |
| `<oracle>`          |	Parameter für Oracle | 0..1  |
| `<driverclasspath>` |JDBC-Treiberklassenpfad | 0..1  |

Das Element `<analytics>` gibt an, dass von der
{{ site.data.keys.product_adj }}-Laufzeit aus eine Verbindung zu einer
bereits installierten
{{ site.data.keys.mf_analytics_console }} und zu den zugehörigen Services
hergestellt werden soll. Es wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|----------------------------------------------------------------------------------|----------|---------|
| install      |Angabe, ob die MobileFirst-Laufzeit eine Verbindung zu {{ site.data.keys.mf_analytics }} herstellen soll|Nein |false |
|analyticsURL|URL der {{ site.data.keys.mf_analytics }} Services|Ja |Keiner |
|consoleURL|URL der {{ site.data.keys.mf_analytics_console }}|Ja |Keiner |
|username|Benutzername|Ja |Keiner |
| password     |Kennwort |Ja |Keiner |
|validate|Prüft, ob die {{ site.data.keys.mf_analytics_console }} zugänglich ist|Nein |true |
|tenant|Nutzer für die Indexierung von Daten, die von einer {{ site.data.keys.product_adj }}-Laufzeit erfasst wurden|Nein |Interne Kennung|

#### install
{: #install-1 }
Mit dem Attribut **install** können Sie angeben, dass diese
{{ site.data.keys.product_adj }}-Laufzeit mit {{ site.data.keys.mf_analytics }} verbunden sein und Daten senden soll.
Gültige Werte sind
**true** und **false**.

#### analyticsURL
{: #analyticsurl-1 }
Mit dem Attribut **analyticsURL** können Sie die URL angeben,
die von der Komponente {{ site.data.keys.mf_analytics }},  die eingehende Analysedaten empfängt,
zugänglich gemacht wird.   
Beispiel: `http://<Hostname>:<Port>/analytics-service/rest` 

#### consoleURL
{: #consoleurl }
Mit dem Attribut **consoleURL** können Sie die URL angeben,
die von der Komponente {{ site.data.keys.mf_analytics }},
die mit der {{ site.data.keys.mf_analytics_console }}
verbunden ist, zugänglich gemacht wird.   
Beispiel: `http://<Hostname>:<Port>/analytics/console`

#### username
{: #username-1 }
Mit dem Attribut **username** können Sie den Benutzernamen angeben, der verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


#### password
{: #password-1 }
Mit dem Attribut **password** können Sie das Kennwort angeben, das verwendet wird, wenn der Dateneingabepunkt für
{{ site.data.keys.mf_analytics }} durch
Basisauthentifizierung geschützt ist.


#### validate
{: #validate-1 }
Mit dem Attribut **validate** kann geprüft werden, ob die
{{ site.data.keys.mf_analytics_console }}
zugänglich ist. Außerdem kann die Authentifizierung des Benutzernamens mit einem Kennwort überprüft werden. Die gültigen Werte sind **true** und **false**.


#### tenant
{: #tenant }
Weitere Informationen zu diesem Attribut finden Sie unter
[Konfigurationseigenschaften](../analytics/configuration/#configuration-properties).

### Vorgehensweise für die Angabe einer Apache-Derby-Datenbank
{: #to-specify-an-apache-derby-database }
Das Element `<derby>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
|database	 |Datenbankname|Nein |	Je nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
|datadir	 |Verzeichnis mit den Datenbanken |	Ja |Keiner |
| schema     |	Schemaname |	Nein |Je nach Art des Schemas MFPDATA, MFPCFG, MFPADMINISTRATOR, MFPPUSH oder APPCENTER|

Das Element `<derby>` unterstützt das folgende Element:

|Element|Beschreibung |Anzahl |
|---------------|-------------------------------|-------|
| `<property>`  |Datenquelleneigenschaft oder JDBC-Verbindungseigenschaft| 0..   |

Weitere Informationen
zu den verfügbaren Eigenschaften finden Sie in der Dokumentation zur Klasse [EmbeddedDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedDataSource40.html). Lesen Sie auch die Dokumentation zur
[Klasse EmbeddedConnectionPoolDataSource40](http://db.apache.org/derby/docs/10.8/publishedapi/jdbc4/org/apache/derby/jdbc/EmbeddedConnectionPoolDataSource40.html).

Weitere
Informationen zu den verfügbaren Eigenschaften für einen Liberty-Server finden Sie in der Dokumentation zu
`properties.derby.embedded` unter [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).

Wenn die Datei **mfp-ant-deployer.jar** im Installationsverzeichnis der {{ site.data.keys.product }} verwendet wird, ist kein Element `<driverclasspath>` notwendig. 

### Vorgehensweise für die Angabe einer DB2-Datenbank
{: #to-specify-a-db2-database }
Das Element `<db2>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
| database       |Datenbankname |Nein | Nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
| server    |Hostname des Datenbankservers |Ja |Keiner |
| port       |Port des Datenbankservers |Nein | 50000   |
| user       |Benutzername für den Datenbankzugriff. |Dieser Benutzer benötigt keine erweiterten Zugriffsrechte für die Datenbanken. Wenn Sie Einschränkungen für die Datenbank implementieren, können Sie einen Benutzer mit den eingeschränkten Zugriffsrechten definieren, die unter "Datenbankbenutzer und Berechtigungen" aufgelistet sind.|Ja |Keiner|
| password     |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |
| schema     |Schemaname |Nein |Hängt vom Benutzer ab|

Weitere Informationen
zu DB2-Benutzeraccounts finden Sie im Artikel
[DB2-Sicherheitsmodell - Übersicht](http://ibm.biz/knowctr#SSEPGG_10.1.0/com.ibm.db2.luw.admin.sec.doc/doc/c0021804.html).   
Das Element `<db2>` unterstützt das folgende Element: 

|Element|Beschreibung |Anzahl |
|---------------|-------------------------------|-------|
| `<property>`  |Datenquelleneigenschaft oder JDBC-Verbindungseigenschaft| 0..   |

Weitere Informationen zu den verfügbaren Eigenschaften finden Sie unter
[Properties for the IBM Data Server Driver for JDBC and SQLJ](http://ibm.biz/knowctr#SSEPGG_9.7.0/com.ibm.db2.luw.apdv.java.doc/src/tpc/imjcc_rjvdsprp.html).


Weitere Informationen zu den verfügbaren Eigenschaften für einen Liberty-Server finden Sie im Artikel
**properties.db2.jcc** unter [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).


Das Element `<driverclasspath>` muss die JAR-Dateien für den DB2-JDBC-Treiber und für die zugehörige Lizenz enthalten.
Sie können
die DB2-JDBC-Treiber
von der Webseite [DB2 JDBC Driver Versions](http://www.ibm.com/support/docview.wss?uid=swg21363866) herunterladen. 

### Vorgehensweise für die Angabe einer MySQL-Datenbank
{: #to-specify-a-mysql-database }
Das Element `<mysql>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
|database	 |Datenbankname|Nein |Je nach Art der Datenbank MFPDATA, MFPADM, MFPCFG, MFPPUSH oder APPCNTR|
|server	 |Hostname des Datenbankservers | |Ja |Keiner |
|port	     |Port des Datenbankservers |Nein | 3306    |
|user	            |Benutzername für den Datenbankzugriff. Dieser Benutzer benötigt keine erweiterten Zugriffsrechte für die Datenbanken. Wenn Sie Einschränkungen für die Datenbank implementieren, können Sie einen Benutzer mit den eingeschränkten Zugriffsrechten definieren, die unter "Datenbankbenutzer und Berechtigungen" aufgelistet sind.|Ja |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

Anstelle von
**database**, **server**
und **port** können Sie auch eine URL angeben. In diesem Fall verwenden Sie die folgenden Attribute:


|Attribut |Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
|url	     |URL für die Verbindung zur Datenbank|Ja |Keiner |
|user	     |Benutzername für den Datenbankzugriff. Dieser Benutzer benötigt keine erweiterten Zugriffsrechte für die Datenbanken. Wenn Sie Einschränkungen für die Datenbank implementieren, können Sie einen Benutzer mit den eingeschränkten Zugriffsrechten definieren, die unter "Datenbankbenutzer und Berechtigungen" aufgelistet sind. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

Weitere Informationen zu MySQL-Benutzerkonten
finden Sie im Artikel
[MySQL User Account Management](http://dev.mysql.com/doc/refman/5.5/en/user-account-management.html).

Das Element `<mysql>` unterstützt das folgende Element: 

|Element|Beschreibung |Anzahl |
|---------------|-------------------------------|-------|
| `<property>`  |Datenquelleneigenschaft oder JDBC-Verbindungseigenschaft| 0.. |

Die verfügbaren Eigenschaften sind in der Dokumentation
unter [Driver/Datasource Class Names, URL
Syntax and Configuration
Properties for Connector/J](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html) angegeben. 

Weitere Informationen zu den verfügbaren Eigenschaften für einen
Liberty-Server finden Sie im Abschnitt
"properties" unter [Liberty profile: Configuration elements in the server.xml file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html).


Das Element `<driverclasspath>` muss eine "MySQL-Connector/J"-JAR-Datei enthalten. Sie können sie
von der Webseite [Download Connector/J](http://www.mysql.com/downloads/connector/j/) herunterladen.

### Vorgehensweise für die Angabe einer Oracle-Datenbank
{: #to-specify-an-oracle-database }
Das Element `<oracle>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
| database   |Datenbankname oder Oracle-Servicename. **Hinweis:** Für die Verbindung zu einer PDB-Datenbank müssen Sie immer einen Servicenamen verwenden. |Nein |ORCL|
|server	 |Hostname des Datenbankservers | Ja | Keiner |
|port	     |Port des Datenbankservers | Nein | 1521 |
|user	            |Benutzername für den Datenbankzugriff. Dieser Benutzer benötigt keine erweiterten Zugriffsrechte für die Datenbanken. Wenn Sie Einschränkungen für die Datenbank implementieren, können Sie einen Benutzer mit den eingeschränkten Zugriffsrechten definieren, die unter "Datenbankbenutzer und Berechtigungen" aufgelistet sind. Lesen Sie den Hinweis unter der Tabelle. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

> **Hinweis:** Geben Sie den Benutzernamen für das Attribut **user** bevorzugt in Großbuchstaben an. Oracle-Benutzernamen bestehen generell aus Großbuchstaben. Im Gegensatz zu anderen
Datenbanktools konvertiert die Ant-Task **installmobilefirstruntime** Kleinbuchstaben von Benutzernamen nicht in Großbuchstaben. Wenn die Ant-Task
**installmobilefirstruntime** keine Verbindung zu Ihrer Datenbank herstellen kann, versuchen Sie, den Wert für das Attribut
**user** in Großbuchstaben anzugeben. 

Anstelle von
**database**, **server**
und **port** können Sie auch eine URL angeben. In diesem Fall verwenden Sie die folgenden Attribute:


|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
|url	     |URL für die Verbindung zur Datenbank|Ja |Keiner |
|user	            |Benutzername für den Datenbankzugriff. Dieser Benutzer benötigt keine erweiterten Zugriffsrechte für die Datenbanken. Wenn Sie Einschränkungen für die Datenbank implementieren, können Sie einen Benutzer mit den eingeschränkten Zugriffsrechten definieren, die unter "Datenbankbenutzer und Berechtigungen" aufgelistet sind. Lesen Sie den Hinweis unter der Tabelle. |Ja |Keiner |
|password	 |Kennwort für den Datenbankzugriff|Nein |Interaktiv abgefragt |

> **Hinweis:** Geben Sie den Benutzernamen für das Attribut **user** bevorzugt in Großbuchstaben an. Oracle-Benutzernamen bestehen generell aus Großbuchstaben. Im Gegensatz zu anderen
Datenbanktools konvertiert die Ant-Task **installmobilefirstruntime** Kleinbuchstaben von Benutzernamen nicht in Großbuchstaben. Wenn die Ant-Task
**installmobilefirstruntime** keine Verbindung zu Ihrer Datenbank herstellen kann, versuchen Sie, den Wert für das Attribut
**user** in Großbuchstaben anzugeben. 

Weitere Informationen zu
Oracle-Benutzeraccounts finden Sie im Artikel
[Overview of Authentication Methods](http://docs.oracle.com/cd/B28359_01/server.111/b28318/security.htm#i12374).

Weitere
Informationen zu URLs für Oracle-Datenbankverbindungen finden Sie im Abschnitt
**Database
URLs and Database Specifiers** unter
[Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Folgendes Element wird
unterstützt: 

|Element|Beschreibung |Anzahl |
|---------------|-------------------------------|-------|
| `<property>`  |Datenquelleneigenschaft oder JDBC-Verbindungseigenschaft| 0.. |

Weitere Informationen zu den
verfügbaren Eigenschaften finden Sie im Abschnitt
**Data Sources and URLs** unter
[Data Sources and URLs](http://docs.oracle.com/cd/B28359_01/java.111/b31224/urls.htm).

Weitere
Informationen zu den verfügbaren Eigenschaften für einen Liberty-Server finden Sie im Artikel
**properties.oracle** unter [Liberty profile: Configuration elements in the server.xml
file](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/autodita/rwlp_metatype_4ic.html). 

Das Element `<driverclasspath>` muss eine Oracle-JDBC-Treiber-JAR-Datei enthalten. Sie können Oracle-JDBC-Treiber von
der Webseite [JDBC, SQLJ, Oracle JPublisher and
Universal Connection
Pool (UCP)](http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html) herunterladen.

Das Element `<property>`, das in `<derby>`-, `<db2>`-, ` <mysql>`- und `<oracle>`-Elementen verwendet werden kann, hat die folgenden Attribute: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|--------------------------------------------|----------|---------|
| name       |Name der Eigenschaft |Ja |Keiner |
|type	     |Java-Typ der Eigenschaftswerte, gewöhnlich java.lang.String/Integer/Boolean|Nein |java.lang.String|
|value	     |Wert der Eigenschaft|Ja |Keiner |

## Ant-Tasks für die Installation des Application Center
{: #ant-tasks-for-installation-of-application-center }
Für die Installation der Application-Center-Konsole und -Services stehen die Ant-Tasks
`<installApplicationCenter>`, `<updateApplicationCenter>` und
`<uninstallApplicationCenter>` zur Verfügung. 

### Auswirkungen der Tasks
{: #task-effects-3 }
### installApplicationCenter
{: #installapplicationcenter }
Die Task `<installApplicationCenter>` konfiguriert einen Anwendungsserver für die Ausführung der WAR-Datei
der Application-Center-Services als Webanwendung und für die Installation der
Application-Center-Konsole. Diese Task hat die folgenden Auswirkungen: 

* Sie deklariert die Webanwendung für die Application-Center-Services im Kontextstammverzeichnis
/applicationcenter. 
* Sie deklariert Datenquellen und in
WebSphere Application Server Full Profile
auch JDBC-Provider für Application-Center-Services. 
* Sie implementiert die Webanwendung für die
Application-Center-Services im Anwendungsserver. 
* Sie deklariert die Application-Center-Konsole als Webanwendung im Kontextstammverzeichnis
/appcenterconsole. 
* Sie implementiert die WAR-Datei der Application-Center-Konsole
im Anwendungsserver. 
* Sie konfiguriert Konfigurationseigenschaften für die Application-Center-Services mithilfe von JNDI-Umgebungseinträgen. Die JNDI-Umgebungseinträge für den Endpunkt und
die Proxys sind auf Kommentar gesetzt. In einigen Fällen müssen Sie die Kommentarzeichen entfernen. 
* Sie konfiguriert Benutzer, die sie Rollen zuordnet, die von den Webanwendungen für die
Application-Center-Konsole und die
Application-Center-Services verwendet werden. 
* Sie konfiguriert in
WebSphere Application Server
die erforderliche angepasste Eigenschaft für den Web-Container. 

#### updateApplicationCenter
{: #updateApplicationCenter }
Die Task `<updateApplicationCenter>` aktualisiert eine
bereits konfigurierte Application-Center-Anwendung
in einem Anwendungsserver. Diese Task hat die folgenden Auswirkungen: 

* Sie aktualisiert die WAR-Datei für die Application-Center-Services. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde.
* Sie aktualisiert die WAR-Datei für die Application-Center-Konsole. Diese Datei muss denselben Basisnamen wie die entsprechende WAR-Datei haben, die zuvor implementiert wurde.

Die Task ändert nicht die Konfiguration des Anwendungsservers, d. h.
die Konfiguration der Webanwendungen, die Datenquellen, die JNDI-Umgebungseinträge und die Benutzer-Rollen-Zuordnungen.
Diese Task ist nur auf eine Installation anwendbar, die mit der in diesem Abschnitt beschriebenen Task
<installApplicationCenter> ausgeführt wird. 

> **Hinweis:** In
WebSphere Application Server Liberty Profile ändert die Task nicht die Features, sodass die Datei server.xml für die installierte Anwendung eine potenziell nicht minimale Liste mit Features enthält.


#### uninstallApplicationCenter
{: #uninstallApplicationCenter }
Die Ant-Task `<uninstallApplicationCenter>` macht die Auswirkungen
einer vorherigen Ausführung der Task
`<installApplicationCenter>` rückgängig. Diese Task hat die folgenden Auswirkungen: 

* Sie entfernt die Konfiguration der Webanwendung für die Application-Center-Services mit dem Kontextstammverzeichnis **/applicationcenter**. Infolgedessen entfernt die Task auch die Einstellungen, die dieser Anwendung manuell hinzugefügt wurden.
* Sie entfernt die WAR-Dateien für die Application-Center-Services und die Application-Center-Konsole vom Anwendungsserver.
* Sie entfernt die Datenquellen und in WebSphere Application Server Full Profile auch die JDBC-Provider für die Application-Center-Services.
* Sie entfernt die Datenbanktreiber, die von den Application-Center-Services verwendet wurden, aus dem Anwendungsserver.
* Sie entfernt die zugehörigen JNDI-Umgebungseinträge.
* Sie entfernt die Benutzer, die durch den Aufruf von `<installApplicationCenter>` konfiguriert werden.

### Attribute und Elemente
{: #attributes-and-elements-3 }
Die Tasks `<installApplicationCenter>`, `<updateApplicationCenter>`
und `<uninstallApplicationCenter>` werden mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|--------------------------------------------|----------|---------|
|id	       |Unterscheidet verschiedene Implementierungen in WebSphere Application Server Full Profile|Nein |Leer|
| servicewar   |WAR-Datei für die Application-Center-Services |Nein |Datei applicationcenter.war im Verzeichnis **Produktinstallationsverzeichnis/ApplicationCenter/console** für die Application-Center-Konsole |
| shortcutsDir |Verzeichnis, in das die Verknüpfungen für Direktaufrufe gestellt werden|Nein |Keiner |
|aaptDir|Verzeichnis mit dem Programm aapt aus dem Plattformtoolpaket des Android SDK|Nein |Keiner |

#### id
{: #id-1 }
In
Umgebungen mit WebSphere Application Server Full Profile
wird das Attribut **id** verwendet, um verschiedene Implementierungen der Application-Center-Konsole und der Application-Center-Services zu
unterscheiden. Ohne dieses Attribut **id**
können zwei WAR-Dateien mit denselben Kontextstammverzeichnissen miteinander in Konflikt geraten, was dazu führt, dass diese Dateien nicht implementiert werden. 

#### servicewar
{: #servicewar-1 }
Mit dem Attribut **servicewar** können Sie ein anderes Verzeichnis für
die WAR-Datei der Application-Center-Services
angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

#### shortcutsDir
{: #shortcutsdir-1 }
Das Attribut
**shortcutsDir** gibt an, wo Direktaufrufe für die
Application-Center-Konsole gespeichert werden sollen.
Wenn Sie dieses Attribut definieren, werden die folgenden Dateien zu diesem Verzeichnis hinzugefügt: 

* **appcenter-console.url**: Diese Datei ist eine Windows-Verknüpfung. Sie öffnet die
Application-Center-Konsole
in einem Browser. 
* **appcenter-console.sh**: Diese Datei ist ein
UNIX-Shell-Script. Sie öffnet die
Application-Center-Konsole
in einem Browser. 

#### aaptDir
{: #aaptdir }
Das Programm **aapt** ist Teil der Verteilung der
{{ site.data.keys.product }}
und befindet sich unter
**Produktinstallationsverzeichnis/ApplicationCenter/tools/android-sdk**.   
Wenn dieses Attribut nicht gesetzt ist, wird eine apk-Anwendung beim Hochladen vom
Application Center unter Verwendung seines eigenen
Codes analysiert, der Beschränkungen unterliegen könnte. 

Die Tasks `<installApplicationCenter>`, `<updateApplicationCenter>`
und `<uninstallApplicationCenter>` unterstützen die folgenden Elemente: 

|Element|Beschreibung |Anzahl |
|-------------------|-------------------------------------------|-------|
|applicationserver	|Anwendungsserver|1 |
|console|Application-Center-Konsole|1 |
| database          |Datenbanken |1 |
|user	            |Benutzer, der einer Sicherheitsrolle zugeordnet werden soll|0..∞  |

### Vorgehensweise für die Angabe einer Application-Center-Konsole
{: #to-specify-an-application-center-console }
Das Element `<console>` erfasst Informationen zur Anpassung der Installation der Application-Center-Konsole. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|--------------------------------------------------|----------|---------|
| warfile      |WAR-Datei für die Application-Center-Konsole|	Nein |Datei appcenterconsole.war im Verzeichnis **Produktinstallationsverzeichnis/ApplicationCenter/console** für die Application-Center-Konsole|

### Vorgehensweise bei der Angabe eines Anwendungsservers
{: #to-specify-an-application-server-3 }
Mit dem Element `<applicationserver>` können Sie die Parameter definieren, die vom zugrundeliegenden Anwendungsserver abhängig sind. Das Element `<applicationserver>` unterstützt die folgenden Elemente:

|Element|Beschreibung |Anzahl |
|-------------------|-------------------------------------------|-------|
|**websphereapplicationserver** oder **was**	|Parameter für WebSphere Application Server. Das Element `<websphereapplicationserver>` (oder in seiner Kurzform `<was>`) gibt eine WebSphere-Application-Server-Instanz an. WebSphere Application Server Full Profile (Base und Network Deployment) werden ebenso wie WebSphere Application Server Liberty Core unterstützt. Ein Liberty-Verbund wird für das Application Center nicht unterstützt.| 0..1  |
|tomcat|Parameter für Apache Tomcat| 0..1  |

Die Attribute und inneren Elemente für diese Elemente sind in den Tabellen
unter [Ant-Tasks für die Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) beschrieben.

### Vorgehensweise für die Angabe einer Verbindung zur Servicedatenbank
{: #to-specify-a-connection-to-the-services-database }
Das Element `<database>` erfasst
die Parameter, die eine Datenquellendeklaration in einem Anwendungsserver angeben, um auf die Servicedatenbank zuzugreifen.

Sie müssen eine einzelne Datenbank deklarieren: `<database kind="ApplicationCenter">`. Abgesehen davon, dass
das Element `<database>` die Elemente `<dba>` und `<client>` nicht
hat, geben Sie das Element `<database>` ähnlich wie die Ant-Task `<configuredatabase>` an.
Das Element <database> kann jedoch `<property>`-Elemente haben.


Das Element `<database>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|--------------------------------------------------------|----------|---------|
| kind         |Art der Datenbank (ApplicationCenter)|Ja |Keiner |
|validate	   |Prüft, ob die Datenbank zugänglich ist. |Nein |True|

Das Element `<database>` unterstützt die folgenden Elemente. Weitere Informationen zur Konfiguration dieser Datenbankelemente finden Sie
in den Tabellen unter [Ant-Tasks für die Installation
von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments).

|Element|Beschreibung |Anzahl |
|-------------------|-------------------------------------------|-------|
|db2	            |Parameter für DB2-Datenbanken| 0..1  |
|derby|Parameter für Apache-Derby-Datenbanken| 0..1  |
|mysql|Parameter für MySQL-Datenbanken| 0..1  |
|oracle	        |Parameter für Oracle-Datenbanken| 0..1  |
|driverclasspath|Parameter für den JDBC-Treiberklassenpfad| 0..1  |

### Benutzer und Sicherheitsrolle angeben
{: #to-specify-a-user-and-a-security-role }
Das Element `<user>` erfasst die Parameter über einen Benutzer, die in eine bestimmte Sicherheitsrolle für eine Anwendung aufzunehmen sind. 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|--------------------------------------------------------|----------|---------|
| role         |Benutzerrolle appcenteradmin |Ja |Keiner |
|name	       |Benutzername|Ja |Keiner |
|password	 |Kennwort, wenn Sie den Benutzer erstellen müssen|Nein |Keiner |

## Ant-Tasks für die Installation von {{ site.data.keys.mf_analytics }}
{: #ant-tasks-for-installation-of-mobilefirst-analytics }
Für die Installation
von {{ site.data.keys.mf_analytics }}
werden die Ant-Tasks **installanalytics**,
**updateanalytics** und **uninstallanalytics** bereitgestellt.


Der Zweck dieser Ant-Tasks ist,
die {{ site.data.keys.mf_analytics_console }} und den
{{ site.data.keys.mf_analytics }} Service mit dem entsprechenden Speicher für die Daten
in einem Anwendungsserver zu konfigurieren. Die Task installiert MobileFirst-Operational-Analytics-Knoten, die als Master- und Datenknoten agieren. Weitere Informationen
finden Sie unter
[Cluster-Management und Elasticsearch](../analytics/configuration/#cluster-management-and-elasticsearch).

### Auswirkungen der Tasks
{: #task-effects-4 }
#### installanalytics
{: #installanalytics }
Die Ant-Task **installanalytics** konfiguriert einen Anwendungsserver so, dass er
IBM {{ site.data.keys.mf_analytics }}
ausführt. Diese Task hat die folgenden Auswirkungen: 

* Sie implementiert die WAR-Dateien für den {{ site.data.keys.mf_analytics }} Service
und die {{ site.data.keys.mf_analytics_console }}
im Anwendungsserver. 
* Sie deklariert die Webanwendung für den {{ site.data.keys.mf_analytics }} Service
im angegebenen Kontextstammverzeichnis (/analytics-service). 
* Sie deklariert die Webanwendung für die {{ site.data.keys.mf_analytics_console }}
im angegebenen Kontextstammverzeichnis (/analytics). 
* Sie legt die Konfigurationseigenschaften für den {{ site.data.keys.mf_analytics_console }} Service
und die {{ site.data.keys.mf_analytics }} über
JNDI-Umgebungseinträge fest. 
* In
WebSphere Application Server Liberty Profile konfiguriert sie den Web-Container. 
* Bei Bedarf erstellt sie Benutzer für die
{{ site.data.keys.mf_analytics_console }}. 

#### updateanalytics
{: #updateanalytics }
Die Ant-Task **updateanalytics** aktualisiert
die bereits konfigurierten WAR-Dateien der Webanwendungen für den {{ site.data.keys.mf_analytics }} Service
und die {{ site.data.keys.mf_analytics_console }}
in einem Anwendungsserver. Die Dateien müssen denselben Basisnamen wie die zuvor implementierten Projekt-WAR-Dateien haben.


Die Konfiguration des Anwendungsservers, d. h. Webanwendungskonfiguration und JNDI-Umgebungseinträge,
wird von der Task nicht geändert. 

#### uninstallanalytics
{: #uninstallanalytics }
Mit der Ant-Task **uninstallanalytics** werden die Auswirkungen einer vorherigen Ausführung
von **installanalytics** rückgängig gemacht.
Diese Task hat die folgenden Auswirkungen: 

* Sie entfernt die Konfiguration der Webanwendungen für den {{ site.data.keys.mf_analytics }} Service
und die {{ site.data.keys.mf_analytics_console }}
sowie die zugehörigen Kontextstammverzeichnisse. 
* Sie entfernt die WAR-Dateien für den {{ site.data.keys.mf_analytics }} Service
und die {{ site.data.keys.mf_analytics_console }}
aus dem Anwendungsserver. 
* Sie entfernt die zugehörigen JNDI-Umgebungseinträge.

### Attribute und Elemente
{: #attributes-and-elements-4 }
Die Tasks **installanalytics**, **updateanalytics**
und **uninstallanalytics** werden mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|--------------------------------------------------------|----------|---------|
| serviceWar   |WAR-Datei für den {{ site.data.keys.mf_analytics }} Service |Nein |Datei analytics-service.war im Verzeichnis Analytics|

#### serviceWar
{: #servicewar-2 }
Mit dem Attribut **serviceWar** können Sie ein anderes Verzeichnis für
die WAR-Datei der {{ site.data.keys.mf_analytics }}  Services
angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

Die Tasks `<installanalytics>`, `<updateanalytics>`
und `<uninstallanalytics>` unterstützen die folgenden Elemente: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------------|-------------------------------------------|----------|---------|
|console	        | {{ site.data.keys.mf_analytics }}   	                |Ja |1 |
|user	            |Benutzer, der einer Sicherheitsrolle zugeordnet werden soll|Nein | 0.. |
|storage	        |Typ des Speichers|Ja |1 |
|applicationserver	|Anwendungsserver|Ja |1 |
|property|Eigenschaften |Nein | 0.. |

### Vorgehensweise für die Angabe einer {{ site.data.keys.mf_analytics_console }}
{: #to-specify-a-mobilefirst-analytics-console }
Das Element `<console>` erfasst Informationen zur Anpassung der Installation der {{ site.data.keys.mf_analytics_console }}. Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|--------------|----------------------------------------------|----------|---------|
|warfile	   |Konsolen-WAR-Datei|Nein |Datei analytics-ui.war im Verzeichnis Analytics|
|shortcutsdir|Verzeichnis, in das die Verknüpfungen für Direktaufrufe gestellt werden|Nein |Keiner |

#### warFile
{: #warfile-2 }
Mit dem Attribut **warFile** können Sie ein anderes Verzeichnis für
die WAR-Datei der {{ site.data.keys.mf_analytics_console }} angeben. Sie können den Namen dieser WAR-Datei mit einem absoluten Pfad oder
einem relativen Pfad angeben.

#### shortcutsDir
{: #shortcutsdir-2 }
Das Attribut
**shortcutsDir** gibt an, wo Direktaufrufe für die
{{ site.data.keys.mf_analytics_console }} gespeichert werden sollen.
Wenn Sie dieses Attribut definieren, können Sie diesem Verzeichnis die folgenden Dateien hinzufügen: 

* **analytics-console.url**: Diese Datei ist eine Windows-Verknüpfung. Sie öffnet die
{{ site.data.keys.mf_analytics_console }}
in einem Browser. 
* **analytics-console.sh**: Diese Datei ist ein
UNIX-Shell-Script. Sie öffnet die
{{ site.data.keys.mf_analytics_console }}
in einem Browser. 

> Hinweis: Diese Direktaufrufe enthalten nicht den Elasticsearch-Parameter "tenant". 

Das Element
`<console>` unterstützt das folgende verschachtelte Element:


|Element|Beschreibung |Anzahl |
|----------|----------------|-------|
|property|Eigenschaften | 0.. |

Mit diesem Element können Sie Ihre eigenen JNDI-Eigenschaften definieren. 

Das Element `<property>` wird mit folgenden Attributen verwendet: 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|----------------------------|----------|---------|
| name       |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |	Ja |Keiner |

### Benutzer und Sicherheitsrolle angeben
{: #to-specify-a-user-and-a-security-role-1 }
Das Element `<user>` erfasst die Parameter über einen Benutzer, die in eine bestimmte Sicherheitsrolle für eine Anwendung aufzunehmen sind. 

|Attribut|Beschreibung |Erforderlich |Standardwert |
|-------------|-----------------------------------------------|----------|---------|
|role	      |Gültige Sicherheitsrolle für die Anwendung. |Ja |Keiner |
|name	       |Benutzername|Ja |Keiner |
|password	 |Kennwort, falls der Benutzer erstellt werden muss|Nein |Keiner |

Nachdem Sie die Benutzer
mit dem Element `<user>` definiert haben, können Sie sie jeder der folgenden Rollen für die Authentifizierung in
der {{ site.data.keys.mf_console }} zuordnen: 

* **mfpmonitor**
* **mfpoperator**
* **mfpdeployer**
* **mfpadmin**

### Vorgehensweise für die Angabe eines Speichertyps für {{ site.data.keys.mf_analytics }}
{: #to-specify-a-type-of-storage-for-mobilefirst-analytics }
Das Element `<storage>` gibt an, welchen zugrunde liegenden
Speichertyp {{ site.data.keys.mf_analytics }}
verwendet, um die erfassten Informationen und Daten zu speichern. 

Folgendes Element wird
unterstützt: 

|Element|Beschreibung |Anzahl |
|---------------|---------------|---------|
|elasticsearch	|Elasticsearch-Cluster| |

Das Element `<elasticsearch>` erfasst die Parameter eines Elasticsearch-Clusters.

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------------|-----------------------------------------------|----------|-----------|
|clusterName	   |Name des Elasticsearch-Clusters|Nein |worklight |
|nodeName	       |Elasticsearch-Knotenname. Der Name muss in einem Elasticsearch-Cluster eindeutig sein.|Nein |`worklightNode_<Zufallszahl>` |
|mastersList	   |Diese Eigenschaft ist eine Zeichenfolge mit Komma als Trennzeichen und gibt den Hostnamen und die Ports von Masterknoten im Elasticsearch-Cluster an (z. B. Hostname1:Transportport1,Hostname2:Transportport2).|Nein |	Von der Topologie abhängig|
|dataPath	       |Position des Elasticsearch-Clusters|Nein |Hängt vom Anwendungsserver ab|
|shards	       |Anzahl der vom Elasticsearch-Cluster erstellten Shards. Der Wert kann nur von den im Elasticsearch-Cluster erstellten Masterknoten festgelegt werden.|Nein |5|
|replicasPerShard|Anzahl der Replikate pro Shard im Elasticsearch-Cluster. Der Wert kann nur von den im Elasticsearch-Cluster erstellten Masterknoten festgelegt werden.|Nein |1 |
|transportPort	   |Für die Knoten-zu-Knoten-Kommunikation im Elasticsearch-Cluster verwendeter Port|Nein |9600 |

#### clusterName
{: #clustername }
Mit dem Attribut **clusterName** können Sie einen Namen Ihrer Wahl für den
Elasticsearch-Cluster angeben. 

Ein Elasticsearch-Cluster besteht aus Knoten, die einen gemeinsamen Clusternamen verwenden. Wenn Sie mehrere Knoten konfigurieren, können Sie also
für das Attribut **clusterName** denselben Wert angeben. 

#### nodeName
{: #nodename }
Mit dem Attribut **nodeName** können Sie einen Namen Ihrer Wahl für den
im Elasticsearch-Cluster zu konfigurierenden Knoten angeben. Jeder Knotenname muss im Elasticsearch-Cluster
eindeutig sein, auch wenn sich der Cluster über mehrere Maschinen erstreckt. 

#### mastersList
{: #masterslist }
Mit dem Attribut **mastersList** können Sie eine Liste der Masterknoten in Ihrem
Elasticsearch-Cluster, jeweils getrennt durch ein Komma, angeben. Jeder Masterknoten muss in der Liste mit seinem Hostnamen und
dem Port für die Elasticsearch-Knoten-zu-Knoten-Kommunikation angegeben sein. Dieser Port ist standardmäßig 9600 oder die Portnummer, die Sie beim Konfigurieren des Masterknotens mit dem
Attribut **transportPort** angegeben haben. 

Beispiel: `Hostname1:Transportport1, Hostname2:Transportport2`

**Hinweis:**

* Wenn Sie für **transportPort** einen anderen als den Standardwert 9600 angeben, müssen Sie diesen
Wert auch mit dem Attribut **transportPort** definieren. Wenn das Attribut
**mastersList** weggelassen wird, wird standardmäßig versucht, den Hostnamen und den
Elasticsearch-Transportport in allen unterstützten Anwendungsservern zu finden.
* Wenn der Zielanwendungsserver ein Cluster mit
WebSphere Application Server Network Deployment ist und Sie
später einen Server zu diesem Cluster hinzufügen oder aus diesem Cluster entfernen, müssen Sie diese Liste manuell
bearbeiten, damit sie mit dem Elasticsearch-Cluster synchron ist. 

#### dataPath
{: #datapath }
Mit dem Attribut **dataPath** können Sie ein anderes Verzeichnis für
das Speichern von Elasticsearch-Daten angeben. Sie können einen absoluten oder relativen Pfad
angeben. 

Wenn das Attribut **dataPath** nicht angegeben ist, werden
Elasticsearch-Clusterdaten in einem Standardverzeichnis
**analyticsData** gespeichert, dessen Position vom Anwendungsserver abhängt: 

* WebSphere Application Server Liberty Profile: `${wlp.user.dir}/servers/Servername/analyticsData`
* Apache Tomcat: `${CATALINA_HOME}/bin/analyticsData`
* WebSphere Application Server und WebSphere Application Server Network Deployment: `${was.install.root}/profiles/<Profilname>/analyticsData`.

Das Verzeichnis
**analyticsData** und die Hierarchie der enthaltenen Unterverzeichnisse und Dateien werden
zur Laufzeit automatisch erstellt, sofern sie noch nicht vorhanden sind, wenn der
{{ site.data.keys.mf_analytics }}
Service Ereignisse empfängt. 

#### shards
{: #shards }
Mit dem Attribut **shards** können Sie die Anzahl der Shards angeben, die im
Elasticsearch-Cluster erstellt werden sollen.

#### replicasPerShard
{: #replicaspershard }
Mit dem Attribut **replicasPerShard** können Sie die Anzahl der Replikate pro Shard angeben, die im
Elasticsearch-Cluster erstellt werden sollen.

Für jedes Shard kann es null oder mehr Replikate geben. Standardmäßig hat jedes Shard ein Replikat.
Die Anzahl der Replikate kann für einen vorhandenen Index in
{{ site.data.keys.mf_analytics }} dynamisch geändert werden.
Ein Replikatshard darf nicht auf demselben Knoten wie das Originalshard ausgeführt werden. 

#### transportPort
{: #transportport }
Mit dem Attribut **transportPort** können Sie einen Port angeben, den andere Knoten im
Elasticsearch-Cluster für die Kommunikation mit diesem Knoten verwenden müssen. Wenn sich dieser Port hinter einem Proxy oder einer Firewall befindet,
stellen Sie sicher, dass er verfügbar und zugänglich ist. 

### Vorgehensweise bei der Angabe eines Anwendungsservers
{: #to-specify-an-application-server-4 }
Mit dem Element `<applicationserver>` können Sie die Parameter definieren, die vom zugrundeliegenden Anwendungsserver abhängig sind. Das Element `<applicationserver>` unterstützt die folgenden Elemente:

**Hinweis:** Die Attribute und inneren Elemente für dieses Element
sind in den Tabellen im Abschnitt [Ant-Tasks für die
Installation von {{ site.data.keys.product_adj }}-Laufzeitumgebungen](#ant-tasks-for-installation-of-mobilefirst-runtime-environments) beschrieben.

|Element|Beschreibung |Anzahl |
|-------------------------------------------|---------------|---------|
|**websphereapplicationserver** oder **was**	|Parameter für WebSphere Application Server. | 0..1  |
|tomcat	                                |Parameter für Apache Tomcat| 0..1 |

### Vorgehensweise für die Angabe angepasster JNDI-Eigenschaften
{: #to-specify-custom-jndi-properties }
Die Elemente `<installanalytics>`, `<updateanalytics>`
und `<uninstallanalytics>` unterstützen das folgende Element: 

|Element|Beschreibung |Anzahl |
|----------|-------------|-------|
|property|Eigenschaften | 0.. |

Mit diesem Element können Sie Ihre eigenen JNDI-Eigenschaften definieren. 

Dieses Element wird mit folgenden Attributen verwendet:

|Attribut|Beschreibung |Erforderlich |Standardwert |
|------------|----------------------------|----------|---------|
| name       |Name der Eigenschaft |Ja |Keiner |
|value	     |Wert der Eigenschaft |	Ja |Keiner |

## Interne Laufzeitdatenbanken
{: #internal-runtime-databases }
Hier können Sie sich über die Laufzeitdatenbanktabellen, ihren Zweck und über die Größenordnung der in den einzelnen Tabellen gespeicherten Daten
informieren. In relationalen
Datenbanken sind die Entitäten in Datenbanktabellen organisiert. 

### Von der MobileFirst-Server-Laufzeit verwendete Datenbank
{: #database-used-by-mobilefirst-server-runtime }
In der folgenden Tabelle finden Sie eine Auflistung der
Laufzeitdatenbanktabellen,
eine Beschreibung sowie
eine Angabe ihrer Verwendung in relationalen Datenbanken. 

|Name der relationalen Datenbanktabelle|Beschreibung |Größenordnung|
|--------------------------------|-------------|--------------------|
|LICENSE_TERMS	                 |Speichert die verschiedenen Lizenzmessgrößen, die bei jeder Gerätestilllegung erfasst werden. |Zig Zeilen, aber nicht mehr als der Wert der JNDI-Eigenschaft mfp.device.decommission.when. Weitere Informationen zu JNDI-Eigenschaften finden Sie in der [Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime). |
|ADDRESSABLE_DEVICE	         |Speichert täglich die Metriken der adressierbaren Geräte. Außerdem wird bei jedem Clusterstart ein Eintrag hinzugefügt.|Ungefähr 400 Zeilen. Einträge, die älter als 13 Monate sind, werden täglich gelöscht.|
|MFP_PERSISTENT_DATA|Speichert Instanzen von Clientanwendungen, die beim OAuth-Server registriert sind, sowie Informationen zum Gerät, zur Anwendung, zu dem Client zugeordneten Benutzern und zum Gerätestatus|Eine Zeile pro Paar aus Gerät und Anwendung|
|MFP_PERSISTENT_CUSTOM_ATTR|Angepasste Attribute, die Instanzen von Clientanwendungen zugeordnet sind. Angepasste Attribute sind anwendungsspezifische Attribute, die von der Anwendung für jede Clientinstanz registriert wurden.|Null oder mehr Zeilen pro Paar aus Gerät und Anwendung|
|MFP_TRANSIENT_DATA	         |Authentifizierungskontext von Clients und Geräten|Zwei Zeilen pro Paar aus Gerät und Anwendung und bei Verwendung des Geräte-SSO zusätzlich zwei Zeilen pro Gerät. Weitere Informationen zum SSO finden Sie unter [Geräte-Single-Sign-on (SSO) konfigurieren](../../../authentication-and-security/device-sso).|
|SERVER_VERSION	             |Produktversion|Eine Zeile|

### Vom MobileFirst-Server-Verwaltungsservice verwendete Datenbank
{: #database-used-by-mobilefirst-server-administration-service }
In der folgenden Tabelle finden Sie eine Auflistung der
Verwaltungsdatenbanktabellen,
eine Beschreibung sowie
eine Angabe ihrer Verwendung in relationalen Datenbanken. 

|Name der relationalen Datenbanktabelle|Beschreibung |Größenordnung|
|--------------------------------|-------------|--------------------|
|ADMIN_NODE	                 |Speichert Informationen zu den Servern, die den Verwaltungsservice ausführen. Ein einer Topologie mit einem eigenständigen Server wird diese Entität nicht verwendet. |Eine Zeile pro Server. Leer, wenn ein eigenständiger Server verwendet wird. |
|AUDIT_TRAIL	                 |Speichert ein Prüfprotokoll aller Verwaltungsaktionen, die vom Verwaltungsservice ausgeführt wurden |Tausende Zeilen|
|CONFIG_LINKS	                 |Speichert die Links zum Liveaktualisierungsservice. Konfigurationseinstellungen von Adaptern und Anwendungen können im Liveaktualisierungsservice gespeichert sein. Über die Links können diese Konfigurationseinstellungen gefunden werden.|Hunderte Zeilen. Pro Adapter werden 2-3 Zeilen verwendet. Pro Anwendung werden 4-6 Zeilen verwendet.|
|FARM_CONFIG	                 |Speichert die Konfiguration von Farmknoten, wenn eine Server-Farm verwendet wird|Zig Zeilen (leer, wenn keine Server-Farm verwendet wird)|
|GLOBAL_CONFIG	                 |Speichert einige globale Konfigurationsdaten|1 Zeile|
|PROJECT	                     |Speichert die Namen der implementierten Projekte |Zig Zeilen|
|PROJECT_LOCK	                 |Interne Clustersynchronisation|Zig Zeilen|
|TRANSACTIONS	                 |Interne Tabelle für Clustersynchronisation, in der der Zustand aller aktiven Verwaltungsaktionen gespeichert wird|Zig Zeilen|
|MFPADMIN_VERSION	             |Produktversion|Eine Zeile|

### Vom MobileFirst-Server-Liveaktualisierungsservice verwendete Datenbank
{: #database-used-by-mobilefirst-server-live-update-service }
In der folgenden Tabelle finden Sie eine Auflistung der
Datenbanktabellen für den Liveaktualisierungsservice,
eine Beschreibung sowie
eine Angabe ihrer Verwendung in relationalen Datenbanken. 

|Name der relationalen Datenbanktabelle|Beschreibung |Größenordnung|
|--------------------------------|-------------|--------------------|
|CS_SCHEMAS	                 |Speichert die versionsgesteuerten Schemata der Plattform|Eine Zeile pro Schema|
|CS_CONFIGURATIONS	             |Speichert Konfigurationsinstanzen für jedes versionsgesteuerte Schema|Eine Zeile pro Konfiguration|
|CS_TAGS	                     |Speichert die durchsuchbaren Felder und Werte für jede Konfigurationsinstanz|Eine Zeile für jeden Feldnamen und -wert pro durchsuchbarem Feld der Konfiguration. |
|CS_ATTACHMENTS	             |Speichert die Anhänge für jede Konfigurationsinstanz|Eine Zeile pro Anhang|
|CS_VERSION	                 |Speichert die Version von MFP, in der die Tabellen oder Instanzen erstellt wurden|Einzelne Zeile in der Tabelle mit der Version von MFP|

### Vom MobileFirst-Server-Push-Service verwendete Datenbank
{: #database-used-by-mobilefirst-server-push-service }
In der folgenden Tabelle finden Sie eine Auflistung der
Datenbanktabellen für den Push-Service,
eine Beschreibung sowie
eine Angabe ihrer Verwendung in relationalen Datenbanken. 

|Name der relationalen Datenbanktabelle|Beschreibung |Größenordnung|
|--------------------------------|-------------|--------------------|
|PUSH_APPS	                     |Tabelle für Push-Benachrichtigungen, in der Details von Push-Anwendungen gespeichert werden|Eine Zeile pro Anwendung|
|PUSH_ENV	                     |Tabelle für Push-Benachrichtigungen, in der Details von Push-Umgebungen gespeichert werden|Zig Zeilen|
|PUSH_TAGS	                     |Tabelle für Push-Benachrichtigungen, in der Details definierter Tags gespeichert werden|Zig Zeilen|
|PUSH_DEVICES	                 |Tabelle für Push-Benachrichtigungen. Speichert einen Datensatz pro Gerät. |Eine Zeile pro Gerät|
|PUSH_SUBSCRIPTIONS	         |Tabelle für Push-Benachrichtigungen. Speichert einen Datensatz pro Tagabonnement. |Eine Zeile pro Geräteabonnement|
|PUSH_MESSAGES	                 |Tabelle für Push-Benachrichtigungen, in der Details von Push-Benachrichtigungen gespeichert werden|Zig Zeilen|
|PUSH_MESSAGE_SEQUENCE_TABLE|Tabelle für Push-Benachrichtigungen, in der die generierte Folgen-ID gespeichert wird |Eine Zeile|
|PUSH_VERSION	                 |Produktversion|Eine Zeile|

Weitere Informationen zum Einrichten der Datenbanken finden Sie unter
[Datenbanken einrichten](../prod-env/databases). 

## Beispielkonfigurationsdateien
In
der {{ site.data.keys.product }}
gibt es einige Beispielkonfigurationsdateien, um Ihnen die ersten Schritte mit den Ant-Tasks für die Installation von {{ site.data.keys.mf_server }} zu erleichtern. 

Die einfachste Art, die Arbeit mit diesen Ant-Tasks
zu beginnen, ist die Verwendung der Beispielkonfigurationsdateien
im Verzeichnis
**MobileFirstServer/configuration-samples/** des ausgelieferten
{{ site.data.keys.mf_server }}. Weitere Informationen zur Installation von
{{ site.data.keys.mf_server }} mit Ant-Tasks finden Sie unter
[Installation mit Ant-Tasks](../prod-env/appserver/#installing-with-ant-tasks). 

### Liste der Beispielkonfigurationsdateien
{: #list-of-sample-configuration-files }
Wählen Sie die passende Beispielkonfigurationsdatei aus. Die folgenden Dateien werden bereitgestellt. 

|Task|Derby|DB2|MySQL|Oracle|
|----------------------------------------------------------|---------------------------|-------------------------|---------------------------|-----------------------------|
|Datenbanken mit Berechtigungsnachweisen des Datenbankadministrators erstellen |create-database-derby.xml|create-database-db2.xml|create-database-mysql.xml|create-database-oracle.xml|{{ site.data.keys.mf_server }} in Liberty installieren|configure-liberty-derby.xml|configure-liberty-db2.xml|configure-liberty-mysql.xml|(siehe Hinweis zu MySQL)|configure-liberty-oracle.xml|
|{{ site.data.keys.mf_server }} als Eizelserver in WebSphere Application Server Full Profile installieren|	configure-was-derby.xml|configure-was-db2.xml|configure-was-mysql.xml (siehe Hinweis zu MySQL)|configure-was-oracle.xml|
|{{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment installieren (siehe Hinweis zu den Konfigurationsdateien)|configure-wasnd-cluster-derby.xml, configure-wasnd-server-derby.xml, configure-wasnd-node-derby.xml, configure-wasnd-cell-derby.xml|configure-wasnd-cluster-db2.xml, configure-wasnd-server-db2.xml, configure-wasnd-node-db2.xml, configure-wasnd-cell-db2.xml|configure-wasnd-cluster-mysql.xml (siehe Hinweis zu MySQL), configure-wasnd-server-mysql.xml (siehe Hinweis zu MySQL), configure-wasnd-node-mysql.xml (siehe Hinweis zu MySQL), configure-wasnd-cell-mysql.xml|configure-wasnd-cluster-oracle.xml, configure-wasnd-server-oracle.xml, configure-wasnd-node-oracle.xml, configure-wasnd-cell-oracle.xml|
|{{ site.data.keys.mf_server }} in Apache Tomcat installieren|configure-tomcat-derby.xml|configure-tomcat-db2.xml|configure-tomcat-mysql.xml|configure-tomcat-oracle.xml|
|{{ site.data.keys.mf_server }} in einem Liberty-Verbund installieren|Nicht relevant|configure-libertycollective-db2.xml|configure-libertycollective-mysql.xml|configure-libertycollective-oracle.xml|

**Hinweis zu MySQL:** MySQL
in Kombination mit WebSphere Application Server Liberty
Profile oder WebSphere Application Server Full Profile ist keine unterstützte Konfiguration. Weitere Informationen finden Sie unter "WebSphere Application
Server Support Statement". Sie können IBM DB2 oder
eine andere von WebSphere Application Server unterstützte Datenbank verwenden, damit Sie von einer Konfiguration mit vollständigem IBM Support profitieren können.

**Hinweis zu den Konfigurationsdateien für WebSphere Application Server Network Deployment:** In den Konfigurationsdateien für **wasnd** kann der Geltungsbereich (scope)
auf **cluster**, **node**, **server** oder
**cell** gesetzt werden. In **configure-wasnd-cluster-derby.xml** ist der Geltungsbereich
beispielsweise **cluster**. Diese Geltungsbereiche definieren das Implementierungsziel wie folgt: 

* **cluster**: Implementierung in einem Cluster
* **server**: Implementierung auf einem Einzelserver, der von einem Deployment Manager verwaltet
wird
* **node**: Implementierung auf allen Servern, die auf einem Knoten ausgeführt werden, aber nicht zu einem Cluster gehören
* **cell**: Implementierung auf allen Servern einer Zelle

## Beispielkonfigurationsdateien für {{ site.data.keys.mf_analytics }}
{: #sample-configuration-files-for-mobilefirst-analytics }
In der {{ site.data.keys.product }}
gibt es Beispielkonfigurationsdateien, die Ihnen den Einstieg in die Verwendung der Ant-Tasks zum Installieren
der {{ site.data.keys.mf_analytics }} Services und der
{{ site.data.keys.mf_analytics_console }} erleichtern.

Die einfachste Art, die Arbeit mit den Ant-Tasks `<installanalytics>`, `<updateanalytics>` und
`<uninstallanalytics>` zu beginnen, ist die Verwendung der Beispielkonfigurationsdateien im Verzeichnis
**Analytics/configuration-samples/** des ausgelieferten
{{ site.data.keys.mf_server }}.

### Schritt 1
{: #step-1 }
Wählen Sie die passende Beispielkonfigurationsdatei aus. Die folgenden XML-Dateien werden bereitgestellt. In den nächsten Schritten sind sie
mit dem Namen **configure-file.xml** angegeben. 

|Task|Anwendungsserver |
|------|--------------------|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console in WebSphere Application Server Liberty Profile installieren|configure-liberty-analytics.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console in Apache Tomcat installieren|configure-tomcat-analytics.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console in WebSphere Application Server Full Profile installieren|configure-was-analytics.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console auf einem Einzelserver mit WebSphere Application Server Network Deployment installieren|configure-wasnd-server-analytics.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console in einer WebSphere-Application-Server-Network-Deployment-Zelle installieren|configure-wasnd-cell-analytics.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console auf einem WebSphere-Application-Server-Network-Deployment-Knoten installieren|configure-wasnd-node.xml|
|{{ site.data.keys.mf_analytics }} Services und {{ site.data.keys.mf_analytics }} Console in einem Cluster mit WebSphere Application Server Network Deployment installieren|configure-wasnd-cluster-analytics.xml|

**Hinweis zu den Konfigurationsdateien für WebSphere Application Server Network Deployment:**  
In den Konfigurationsdateien für wasnd kann der Geltungsbereich (scope) auf **cluster**, **node**, **server** oder **cell** gesetzt werden. In **configure-wasnd-cluster-analytics.xml** ist der Geltungsbereich
beispielsweise **cluster**. Diese Geltungsbereiche definieren das Implementierungsziel wie folgt: 

* **cluster**: Implementierung in einem Cluster
* **server**: Implementierung auf einem Einzelserver, der von einem Deployment Manager verwaltet
wird
* **node**: Implementierung auf allen Servern, die auf einem Knoten ausgeführt werden, aber nicht zu einem Cluster gehören
* **cell**: Implementierung auf allen Servern einer Zelle

### Schritt 2
{: #step-2 }
Ändern Sie die Dateizugriffsrechte für die Beispieldatei, indem Sie sie so weit wie möglich einschränken. Schritt 3 erfordert, dass
Sie einige Kennwörter angeben. Wenn andere Benutzer desselben Computers diese Kennwörter nicht erfahren sollen,
müssen Sie für die übrigen Benutzer
die Leseberechtigungen (read) für die Datei entfernen. Sie können einen Befehl wie in den folgenden Beispielen verwenden:

UNIX: `chmod 600 configure-file.xml`
Windows: `cacls configure-file.xml /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

### Schritt 3
{: #step-3 }
In ähnlicher Weise müssen Sie vorgehen, wenn Ihr Anwendungsserver
WebSphere Application Server Liberty Profile
oder Apache Tomcat
ist und dieser nur über Ihren Benutzeraccount gestartet werden soll.
Entfernen Sie in diesem Fall die Leseberechtigungen
(read) für alle übrigen Benutzer aus den folgenden Dateien:

* WebSphere Application Server Liberty Profile: **wlp/usr/servers/<Server>/server.xml**
* Apache Tomcat: **conf/server.xml**

### Schritt 4
{: #step-4 }
Ersetzen Sie die Platzhalterwerte für die Eigenschaften am Anfang der Datei.

**Hinweis:**  
Wenn Sie in den Werten der Ant-XML-Scripts die folgenden Sonderzeichen verwenden, müssen Sie sie mit Escapezeichen angeben:


* Das Dollarzeichen (`$`) muss mit $$ angegeben werden, sofern Sie mit der Syntax
`${variable}`, die im Abschnitt
"Properties" der Veröffentlichung
"Apache Ant Manual" beschrieben ist, nicht explizit auf eine Ant-Variable verweisen möchten.
* Das Et-Zeichen (`&`) muss mit `&amp;` angegeben werden, sofern Sie nicht explizit auf eine XML-Entität verweisen möchten.
* Anführungszeichen (`"`) müssen mit `&quot;` angegeben werden, es sei denn, sie
werden in einer Zeichenfolge verwendet, die in Hochkommata gesetzt ist.

### Schritt 5
{: #step-5 }
Führen Sie den Befehl `ant -f configure-file.xml install` aus. 

Dieser Befehl installiert die
{{ site.data.keys.mf_analytics }} Services und die
{{ site.data.keys.mf_analytics_console }}
im Anwendungsserver. Wenn Sie ein Fixpack für
{{ site.data.keys.mf_server }} anwenden und aktualisierte {{ site.data.keys.mf_analytics }} Services
und eine aktualisierte {{ site.data.keys.mf_analytics_console }}
installieren müssen, führen Sie den folgenden Befehl aus: `ant -f configure-file.xml minimal-update`.

Führen Sie den folgenden
Befehl aus, um den Installationsschritt rückgängig zu machen: `ant -f configure-file.xml uninstall`.

Dieser Befehl deinstalliert
die {{ site.data.keys.mf_analytics }} und die
{{ site.data.keys.mf_analytics_console }}. 
