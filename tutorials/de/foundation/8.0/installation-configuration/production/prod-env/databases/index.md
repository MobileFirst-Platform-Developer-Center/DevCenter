---
layout: tutorial
title: Datenbanken einrichten
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die folgenden Komponenten von  {{ site.data.keys.mf_server_full }} müssen technische Daten in einer Datenbank speichern: 

* MobileFirst-Server-Verwaltungsservice
* MobileFirst-Server-Liveaktualisierungsservice
* Push-Service von {{ site.data.keys.mf_server }}
* MobileFirst-Foundation-Laufzeit

> **Hinweis:** Wenn mehrere Laufzeitinstanzen mit unterschiedlichen
Kontextstammverzeichnissen installiert sind, werden für jede Instanz eigene Tabellen benötigt.
> Die Datenbank kann eine relationale Datenbank wie IBM DB2, Oracle oder MySQL sein. 

#### Relationale Datenbanken (DB2, Oracle oder MySQL)
{: #relational-databases-db2-oracle-or-mysql }
Jede Komponente benötigt eine eigene Gruppe von Tabellen. Die Tabellen können manuell erstellt werden, indem das für jede Komponente spezifische
SQL-Script ausgeführt wird
(siehe [Datenbanktabellen manuell erstellen](#create-the-database-tables-manually)). Für die Erstellung können Sie aber auch
Ant-Tasks oder das Server Configuration Tool verwenden. Bei den Tabellennamen der einzelnen Komponenten gibt es keine Überschneidungen. So können alle Tabellen dieser Komponenten
einem Schema zugeordnet werden. 

Wenn Sie jedoch mehrere Instanzen der
{{ site.data.keys.product }}-Laufzeit mit jeweils einem eigenen Kontextstammverzeichnis im Anwendungsserver installieren wollen,
wird für jede Instanz eine eigene Gruppe von Tabellen benötigt. Die Tabellen müssen in dem Fall verschiedenen Schemata zugeordnet sein. 

> **Hinweis zu DB2:** {{ site.data.keys.product_adj }}-Lizenzen erlauben die Nutzung von DB2 als unterstützendes System für die MobileFirst Foundation. Wenn Sie davon profitieren möchten, führen Sie nach der Installation
der DB2-Software folgende Schritte aus:

>
> * Laden Sie das Image zur Aktivierung für eine eingeschränkte Verwendung direkt von der Website [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) herunter.
> * Wenden Sie die Datei zur Aktivierung für eine eingeschränkte Verwendung (**db2xxxx.lic**) an. Führen Sie dazu den Befehl **db2licm** aus. 
>
> Weitere Informatinen finden Sie im [DB2 IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/SSEPGG_10.5.0/com.ibm.db2.luw.kc.doc/welcome.html).

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Datenbankbenutzer und Berechtigungen](#database-users-and-privileges)
* [Datenbankvoraussetzungen](#database-requirements)
* [Datenbanktabellen manuell erstellen](#create-the-database-tables-manually)
* [Datenbanktabellen mit dem Server Configuration Tool erstellen](#create-the-database-tables-with-the-server-configuration-tool)
* [Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks)

## Datenbankbenutzer und Berechtigungen
{: #database-users-and-privileges }
Die MobileFirst-Server-Anwendungen im Anwendungsserver nutzen in der Laufzeit Datenquellen als Rressourcen, um eine Verbindung
zu relationalen Datenbanken herstellen zu können. Der Datenquelle muss ein Benutzer mit bestimmten Zugriffsrechten zugeordnet sein, damit der Zugriff auf die Datenbank
möglich ist. 

Sie müssen für jede
im Anwendungsserver implementierte MobileFirst-Server-Anwendung
eine Datenquelle für den Zugriff auf die relationale Datenbank konfigurieren. Der Datenquelle muss ein Benutzer mit bestimmten Zugriffsrechten zugeordnet sein, damit der Zugriff auf die Datenbank
möglich ist. Wie viele Benutzer Sie erstellen müssen, hängt von dem Installationsverfahren ab, mit dem Sie
die MobileFirst-Server-Anwendungen im Anwendungsserver implementiert haben. 

### Installation mit dem Server Configuration Tool
{: #installation-with-the-server-configuration-tool }
Für alle Komponenten
(MobileFirst-Server-Verwaltungsservice, -Konfigurationsservice und -Push-Service sowie
MobileFirst-Foundation-Laufzeit) wird der gleiche Benutzer verwendet. 

### Installation mit Ant-Tasks
{: #installation-with-ant-tasks }
Die Ant-Beispieldateien, die in der Produktdistribution bereitgestellt werden, verwenden den gleichen Benutzer für alle Komponenten. Allerdings ist es möglich,
die Ant-Dateien zu ändern, wenn verschiedene Benutzer verwendet werden sollen. 

* Gleicher Benutzer für Verwaltungsservice und Konfigurationsservice, da diese mit Ant-Tasks nicht getrennt voneinander installiert werden können 
* Anderer Benutzer für die Laufzeit
* Anderer Benutzer für den Push-Service

### Manuelle Installation
{: #manual-installation }
Jeder der MobileFirst-Server-Komponenten kann eine andere Datenquelle und damit auch ein anderer Benutzer
zugeordnet werden. In der Laufzeit müssen die Benutzer die folgenden Zugriffsrechte für die Datentabellen und -sequenzen haben: 

* SELECT TABLE
* INSERT TABLE
* UPDATE TABLE
* DELETE TABLE
* SELECT SEQUENCE

Falls Sie die Tabellen nicht manuell vor der Installation mit Ant-Tasks oder mit dem
Server Configuration Tool erstellt haben,
muss es einen Benutzer geben, der berechtigt ist, die Tabellen zu erstellen. Dieser Benutzer benötigt außerdem die folgenden Zugriffsrechte: 

* CREATE INDEX
* CREATE SEQUENCE
* CREATE TABLE

Für einen Upgrade des Produkts benötigt er die folgenden zusätzlichen Zugriffsrechte: 

* ALTER TABLE
* CREATE VIEW
* DROP INDEX
* DROP SEQUENCE
* DROP TABLE
* DROP VIEW

## Datenbankvoraussetzungen
{: #database-requirements }
In der Datenbank werden alle Daten von MobileFirst-Server-Anwendungen
gespeichert. Stellen Sie vor der Installation der MobileFirst-Server-Komponenten sicher, dass die Datenbankvoraussetzungen
erfüllt sind. 

* [Datenbank- und Benutzeranforderungen für DB2](#db2-database-and-user-requirements)
* [Datenbank- und Benutzeranforderungen für Oracle](#oracle-database-and-user-requirements)
* [Datenbank- und Benutzeranforderungen für MySQL](#mysql-database-and-user-requirements)

> Eine aktuelle Liste der unterstützten Datenbanksoftwareversionen finden Sie auf der Seite mit den [Systemvoraussetzungen](../../../../product-overview/requirements/).



### Datenbank- und Benutzeranforderungen für DB2
{: #db2-database-and-user-requirements }
Lesen Sie sich die Datenbankanforderungen für DB2 durch. Führen Sie die Schritte für die Benutzer- und Datenbankerstellung aus und richten
Sie Ihre Datenbank gemäß den konkreten Anforderungen ein. 

Sie müssen als Datenbankzeichensatz UTF-8 festlegen.

Die Seitengröße der Datenbank muss mindestens bei 32768 liegen. Mit der folgenden Prozedur wird eine Datenbank mit einer Seitengröße
von 32768 erstellt. Außerdem wird ein Benutzer
(**mfpuser**) erstellt, dem der Zugriff auf die Datenbank gewährt wird. Dieser Benutzer kann vom Server Configuration Tool oder
von den Ant-Tasks für die Erstellung der Tabellen verwendet werden. 

1. Erstellen Sie mit den entsprechenden Befehlen Ihres Betriebssystems einen Systembenutzernamen, z. B.
**mfpuser**, in einer DB2-Admin-Gruppe wie z. B.
**DB2USERS**. Legen Sie dafür ein Kennwort fest, z. B.
**mfpuser**.
2. Öffnen Sie wie folgt einen
DB2-Befehlszeilenprozessor. Verwenden Sie dabei einen
Benutzer mit der Berechtigung **SYSADM** oder **SYSCTRL**. 
    * Klicken Sie auf Windows-Systemen auf **Start → IBM DB2 → Befehlszeilenprozessor**.
    * Navigieren Sie auf Linux- oder UNIX-Systemen zu **~/sqllib/bin** und geben Sie `./db2` ein.
3. Geben Sie für die Erstellung der MobileFirst-Server-Datenbank SQL-Anweisungen ähnlich denen im folgenden Beispiel ein. 

Ersetzen Sie den
Benutzernamen **mfpuser** durch Ihren Benutzernamen.

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
CONNECT TO MFPDATA
GRANT CONNECT ON DATABASE TO USER mfpuser
DISCONNECT MFPDATA
QUIT
```

### Datenbank- und Benutzeranforderungen für Oracle
{: #oracle-database-and-user-requirements }
Lesen Sie sich die Datenbankanforderungen für Oracle durch. Führen Sie die Schritte für die Benutzer- und Datenbankerstellung aus und richten
Sie Ihre Datenbank gemäß den konkreten Anforderungen ein. 

Sie müssen als Datenbankzeichensatz
Unicode Character Set
(AL32UTF8) und als nationalen Zeichensatz UTF8
- Unicode 3.0 UTF-8 festlegen.   

Dem Laufzeitbenutzer (siehe [Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)) muss ein Tabellenbereich und ein ausreichendes Kontingent für das Schreiben der für die
{{ site.data.keys.product }}-Services erforderlichen Daten zugeordnet sein.
Weitere Informationen zu den vom Produkt verwendeten Tabellen finden Sie unter
[Interne Laufzeitdatenbanken](../../installation-reference/#internal-runtime-databases). 

Die Tabellen müssen im Standardschema des Laufzeitbenutzers
erstellt werden. Die Ant-Tasks und das
Server Configuration Tool erstellen die Tabellen im Standardschema des als Argument übergebenen Benutzers. Weitere Informationen
zur Erstellung von Tabellen finden Sie unter
[Oracle-Datenbanktabellen manuell erstellen](#creating-the-oracle-database-tables-manually). 

Während der Prozedur wird eine Datenbank erstellt, sofern dies erforderlich ist. Hinzugefügt wird ein Benutzer, der Tabellen und Indizes in dieser Datenbank erstellen kann. Dieser Benutzer wird als ein
Laufzeitbenutzer verwendet. 

1. Falls noch keine Datenbank
existiert, können Sie den
Oracle Database Configuration Assistant (DBCA) verwenden und die Schritte in diesem Assistenten befolgen,
um eine neue Universaldatenbank zu erstellen. In unserem Beispiel hat diese den Namen ORCL. 
    * Verwenden Sie den globalen Datenbanknamen **ORCL\_Ihre\_Domäne** und die System-ID (SID) **ORCL**.
    * Führen Sie auf der Registerkarte
**Custom Scripts**
des Schritts
**Database Content** nicht die SQL-Scripts aus, da Sie zunächst einen Benutzeraccount erstellen müssen.
    * Wählen Sie auf der Registerkarte **Character Sets**
beim Schritt **Initialization Parameters** die Option
**Use Unicode (AL32UTF8) character set and UTF8 - Unicode 3.0 UTF-8 national character set** aus.
    * Schließen Sie das Verfahren ab, indem Sie die Standardwerte übernehmen.
2. Erstellen Sie mit
Oracle
Database Control oder mit dem Befehlszeileninterpreter
Oracle SQLPlus eine Datenbank. 
3. Oracle Database Control: 
    * Stellen Sie eine Verbindung als **SYSDBA** her.
    * Rufen Sie wie folgt die Seite
**Users** auf, klicken Sie auf **Server** und anschließend im Abschnitt
**Security** auf **Users**.
    * Erstellen Sie einen Benutzer, z. B. **MFPUSER**.
    * Weisen Sie die folgenden Attribute zu:
        * **Profile**: DEFAULT
        * **Authentication**: password
        * **Default tablespace**: USERS
        * **Temporary tablespace**: TEMP
        * **Status**: Unlocked
        * Add system privilege: CREATE SESSION
        * Add system privilege: CREATE SEQUENCE
        * Add system privilege: CREATE TABLE
        * Add quota: Unlimited for tablespace USERS
    * Using the Oracle SQLPlus command line interpreter:

Die Befehle im folgenden Beispiel erstellen einen Benutzer mit dem Namen
**MFPUSER** für die Datenbank:

```sql
CONNECT SYSTEM/<SYSTEM-Kennwort>@ORCL
CREATE USER MFPUSER IDENTIFIED BY MFPUSER-Kennwort DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION, CREATE SEQUENCE, CREATE TABLE TO MFPUSER;
DISCONNECT;
```

### Datenbank- und Benutzeranforderungen für MySQL
{: #mysql-database-and-user-requirements }
Lesen Sie sich die Datenbankanforderungen für MySQL durch. Führen Sie die Schritte für die Benutzer- und Datenbankerstellung aus und konfigurieren
Sie Ihre Datenbank gemäß den konkreten Anforderungen. 

Sie müssen den Zeichensatz UTF-8 verwenden. 

Für die folgenden Eigenschaften
müssen passende Werten definiert werden: 

* max_allowed_packet: 256 M (oder mehr)
* innodb_log_file_size: 250 M (oder mehr)

Weitere Informationen zum Festlegen der Eigenschaften finden Sie in der
[MySQL-Dokumentation](http://dev.mysql.com/doc/).  
Mit der folgenden Prozedur wird eine Datenbank (MFPDATA)
erstellt und ein Benutzer (mfpuser), der eine mit allen Zugriffsrechten von einem Host
(mfp-host) aus eine Verbindung zu der Datenbank herstellen kann.

1. Führen Sie einen MySQL-Befehlszeilenclient mit der Option `-u
root` aus.
2. Geben Sie die folgenden Befehle ein:

   ```sql
   CREATE DATABASE MFPDATA CHARACTER SET utf8 COLLATE utf8_general_ci;
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'MFP-Host' IDENTIFIED BY 'mfpuser-Kennwort';
   GRANT ALL PRIVILEGES ON MFPDATA.* TO 'mfpuser'@'localhost' IDENTIFIED BY 'mfpuser-Kennwort';
   FLUSH PRIVILEGES;
   ```

    Die Angabe mfpuser vor dem
Zeichen "@" ist der Benutzername, die Angabe **mfpuser-Kennwort** hinter **IDENTIFIED
BY** ist das zugehörige Kennwort und die Angabe **MFP-Host** ist der Name des Hosts, auf dem
{{ site.data.keys.product_adj }} ausgeführt wird.

    Der Benutzer muss von den Hosts aus, auf denen der
Java-Anwendungsserver mit den MobileFirst-Server-Anwendungen installiert ist,
eine Verbindung zum MySQL-Server herstellen können. 

## Datenbanktabellen manuell erstellen
{: #create-the-database-tables-manually }
Die Datenbanktabellen für die MobileFirst-Server-Anwendungen können manuell, mit Ant-Tasks oder mit dem
Server Configuration Tool erstellt werden. In den folgenden Abschnitten ist die manuelle Erstellung ausführlich erläutert. 

* [DB2-Datenbanktabellen manuell erstellen](#creating-the-db2-database-tables-manually)
* [Oracle-Datenbanktabellen manuell erstellen](#creating-the-oracle-database-tables-manually)
* [MySQL-Datenbanktabellen manuell erstellen](#creating-the-mysql-database-tables-manually)

### DB2-Datenbanktabellen manuell erstellen
{: #creating-the-db2-database-tables-manually }
Verwenden Sie für die Erstellung der DB2-Datenbanktabellen die mit der MobileFirst-Server-Installation bereitgestellten SQL-Scripts. 

Für alle vier
MobileFirst-Server-Komponenten sind Tabellen
erforderlich (siehe Beschreibung im Übersichtsabschnitt). Sie können gemäß demselben Schema oder anderen Schemata erstellt werden. Einige Einschränkungen gelten jedoch unabhängig
dvaon, wie die MobileFirst-Server-Anwendungen im
Java-Anwendungsserver implementiert sind. Vergleichen Sie hierzu den Abschnitt zu den möglichen Benutzern für
DB2 (siehe [Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)).

#### Installation mit dem Server Configuration Tool
{: #installation-with-the-server-configuration-tool-1 }
Für alle Komponenten
(MobileFirst-Server-Verwaltungsservice, -Liveaktualisierungsservice und -Push-Service sowie
MobileFirst-Foundation-Laufzeit) wird das gleiche Schema verwendet. 

#### Installation mit Ant-Tasks
{: #installation-with-ant-tasks-1 }
Die Ant-Beispieldateien, die in der Produktdistribution bereitgestellt werden, verwenden dasselbe Schema für alle Komponenten. Allerdings ist es möglich,
die Ant-Dateien zu ändern, wenn verschiedene Schemata verwendet werden sollen. 

* Selbes Schema für Verwaltungsservice und Liveaktualisierungsservice, da diese mit Ant-Tasks nicht getrennt voneinander installiert werden können 
* Anderes Schema für die Laufzeit
* Anderes Schema für den Push-Service

#### Manuelle Installation
{: #manual-installation-1 }
Jeder der MobileFirst-Server-Komponenten kann eine andere Datenquelle und damit auch ein anderes Schema
zugeordnet werden.   
Folgende Scripts werden für die Erstellung der Tabellen verwendet: 

* Verwaltungsservice: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-db2.sql**
* Liveaktualisierungsservice:
**MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-db2.sql**
* Laufzeitkomponente: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-db2.sql**
* Push-Service: **MFP-Installationsverzeichnis/PushService/databases/create-push-db2.sql**

Mit der folgenden Prozedur werden die Tabellen aller Anwendungen gemäß
demselben Schema (MFPSCM) erstellt. Es wird davon ausgegangen, dass bereits eine Datenbank und ein Benutzer erstellt wurden. Weitere Informationen finden Sie unter
[Datenbank- und Benutzeranforderungen für DB2](#db2-database-and-user-requirements).

Führen Sie die folgenden DB2-Befehle als Benutzer mfpuser aus: 

```sql
db2 CONNECT TO MFPDATA
db2 SET CURRENT SCHEMA = 'MFPSCM'
db2 -vf MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-db2.sql -t
db2 -vf MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-db2.sql -t
db2 -vf MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-db2.sql -t
db2 -vf MFP-Installationsverzeichnis/PushService/databases/create-push-db2.sql -t
```

Wenn die Tabellen von mfpuser erstellt werden, hat dieser Benutzer automatisch die
Zugriffsrechte für die Tabellen und kann sie in der Laufzeit verwenden. Wenn Sie die Zugriffsrechte des Laufzeitbenutzers einschränken möchten (siehe
[Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)) oder eine detailliertere Steuerung der Zugriffsrechte wünschen, lesen Sie die entsprechenden Abschnitte in der
DB2-Documentation.

### Oracle-Datenbanktabellen manuell erstellen
{: #creating-the-oracle-database-tables-manually }
Verwenden Sie für die Erstellung der Oracle-Datenbanktabellen die mit der MobileFirst-Server-Installation bereitgestellten SQL-Scripts. 

Für alle vier
MobileFirst-Server-Komponenten sind Tabellen
erforderlich (siehe Beschreibung im Übersichtsabschnitt). Sie können gemäß demselben Schema oder anderen Schemata erstellt werden. Einige Einschränkungen gelten jedoch unabhängig
dvaon, wie die MobileFirst-Server-Anwendungen im
Java-Anwendungsserver implementiert sind. Die Einzelheiten finden Sie unter
[Datenbankbenutzer und -berechtigungen](#database-users-and-privileges). 

Die Tabellen müssen gemäß dem Standardschema des Laufzeitbenutzers
erstellt werden. Folgende Scripts werden für die Erstellung der Tabellen verwendet: 

* Verwaltungsservice: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-oracle.sql**
* Liveaktualisierungsservice:
**MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-oracle.sql**
* Laufzeitkomponente: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-oracle.sql**
* Push-Service: **MFP-Installationsverzeichnis/PushService/databases/create-push-oracle.sql**

Mit der folgenden Prozedur werden die Tabellen aller Anwendungen für
denselben Benutzer (**MFPUSER**) erstellt. Es wird davon ausgegangen, dass bereits eine Datenbank und ein Benutzer erstellt wurden. Weitere Informationen finden Sie unter
[Datenbank- und Benutzeranforderungen für Oracle](#oracle-database-and-user-requirements).

Führen Sie in Oracle SQLPlus die folgenden Befehle aus:

```sql
CONNECT MFPUSER/MFPUSER-Kennwort@ORCL
@MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-oracle.sql
@MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-oracle.sql
@MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-oracle.sql
@MFP-Installationsverzeichnis/PushService/databases/create-push-oracle.sql
DISCONNECT;
```

Wenn die Tabellen von MFPUSER erstellt werden, hat dieser Benutzer automatisch die
Zugriffsrechte für die Tabellen und kann sie in der Laufzeit verwenden. Die Tabellen werden gemäß dem Standardschema des Benutzers erstellt.
Wenn Sie die Zugriffsrechte des Laufzeitbenutzers einschränken möchten (siehe
[Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)) oder eine detailliertere Steuerung der Zugriffsrechte wünschen, lesen Sie die entsprechenden Abschnitte in der
Oracle-Documentation.

### MySQL-Datenbanktabellen manuell erstellen
{: #creating-the-mysql-database-tables-manually }
Verwenden Sie für die Erstellung der MySQL-Datenbanktabellen die mit der MobileFirst-Server-Installation bereitgestellten SQL-Scripts. 

Für alle vier
MobileFirst-Server-Komponenten sind Tabellen
erforderlich (siehe Beschreibung im Übersichtsabschnitt). Sie können gemäß demselben Schema oder anderen Schemata erstellt werden. Einige Einschränkungen gelten jedoch unabhängig
dvaon, wie die MobileFirst-Server-Anwendungen im
Java-Anwendungsserver implementiert sind. Vergleichen Sie hierzu den Abschnitt zu den möglichen Benutzern für
MySQL (siehe [Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)).

#### Installation mit dem Server Configuration Tool
{: #installation-with-the-server-configuration-tool-2 }
Für alle Komponenten
(MobileFirst-Server-Verwaltungsservice, -Liveaktualisierungsservice und -Push-Service sowie
MobileFirst-Foundation-Laufzeit) wird die gleiche Datenbank verwendet. 

#### Installation mit Ant-Tasks
{: #installation-with-ant-tasks-2 }
Die Ant-Beispieldateien, die in der Produktdistribution bereitgestellt werden, verwenden dieselbe Datenbank für alle Komponenten. Allerdings ist es möglich,
die Ant-Dateien zu ändern, wenn verschiedene Datenbanken verwendet werden sollen. 

* Selbe Datenbank für Verwaltungsservice und Liveaktualisierungsservice, da diese mit Ant-Tasks nicht getrennt voneinander installiert werden können 
* Andere Datenbank für die Laufzeit
* Andere Datenbank für den Push-Service

#### Manuelle Installation
{: #manual-installation-2 }
Jeder der MobileFirst-Server-Komponenten kann eine andere Datenquelle und damit auch eine andere Datenbank
zugeordnet werden.   
Folgende Scripts werden für die Erstellung der Tabellen verwendet: 

* Verwaltungsservice: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-mysql.sql**
* Liveaktualisierungsservice:
**MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-mysql.sql**
* Laufzeitkomponente: **MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-mysql.sql**
* Push-Service: **MFP-Installationsverzeichnis/PushService/databases/create-push-mysql.sql**

Im folgenden Beispiel werden die Tabellen aller Anwendungen für
denselben Benutzer und dieselbe Datenbank erstellt. Es wird davon ausgegangen, dass bereits eine Datenbank und ein Benutzer erstellt sind
(siehe [Anforderungen an MySQL-Datenbanken](#database-requirements)). 

Mit der folgenden Prozedur werden die Tabellen aller Anwendungen für
denselben Benutzer (mfpuser) und dieselbe Datenbank (MFPDATA) erstellt. Es wird davon ausgegangen, dass bereits eine Datenbank und ein Benutzer erstellt wurden. 

1. Führen Sie einen MySQL.Befehlszeilenclient mit der Option `-u
mfpuser` aus.
2. Geben Sie die folgenden Befehle ein:

```sql
USE MFPDATA;
SOURCE MFP-Installationsverzeichnis/MobileFirstServer/databases/create-mfp-admin-mysql.sql;
SOURCE MFP-Installationsverzeichnis/MobileFirstServer/databases/create-configservice-mysql.sql;
SOURCE MFP-Installationsverzeichnis/MobileFirstServer/databases/create-runtime-mysql.sql;
SOURCE MFP-Installationsverzeichnis/PushService/databases/create-push-mysql.sql;
```

## Datenbanktabellen mit dem Server Configuration Tool erstellen
{: #create-the-database-tables-with-the-server-configuration-tool }
Die Datenbanktabellen für die MobileFirst-Server-Anwendungen können manuell, mit Ant-Tasks oder mit dem
Server Configuration Tool erstellt werden. In den folgenden
Abschnitten sind die Schritte für die Einrichtung der Datenbank beschrieben, die erforderlich sind, wenn Sie
{{ site.data.keys.mf_server }} mit dem
Server Configuration Tool installieren. 

Das
Server Configuration Tool kann die Datenbanktabellen
im Rahmen des Installationsprozesses erstellen. In einigen Fällen kann es sogar eine Datenbank und einen Benutzer für die
MobileFirst-Server-Komponenten erstellen. Eine Übersicht über den Installationsprozess mit dem Server Configuration Tool finden Sie unter [{{ site.data.keys.mf_server }} im Grafikmodus installieren](../../simple-install/tutorials/graphical-mode).

Wenn Sie die Berechtigungsnachweise für die Konfiguration angegeben und
im Fenster des Server Configuration Tool
auf
**Deploy** geklickt haben, werden die folgenden Schritte ausgeführt: 

* Das Tool erstellt die Datenbank und den Benutzer, sofern erforderlich. 
* Das Tool überprüft, ob es in der Datenbank die MobileFirst-Server-Tabellen
gibt. Wenn nicht, erstellt es die Tabellen. 
* Das Tool implementiert die MobileFirst-Server-Anwendungen im
Anwendungsserver. 

Wenn die Datenbanktabellen
manuell erstellt wurden, bevor Sie das
Server Configuration Tool ausführen,
kann das Tool sie erkennen. Der Schritt für die Einrichtung der Tabellen wird dann übersprungen. 

Wählen Sie den Abschnitt aus, der zu Ihrem unterstüzten Datenbankmanagementsystem (DBMS) passt, um detaillierte Informationen zur
Erstellung der Datenbanktabellen
mit dem Tool zu erhalten. 

* [DB2-Datenbanktabellen mit dem Server Configuration Tool erstellen](#creating-the-db2-database-tables-with-the-server-configuration-tool)
* [Oracle-Datenbanktabellen mit dem Server Configuration Tool erstellen](#creating-the-oracle-database-tables-with-the-server-configuration-tool)
* [MySQL-Datenbanktabellen mit dem Server Configuration Tool erstellen](#creating-the-mysql-database-tables-with-the-server-configuration-tool)

### DB2-Datenbanktabellen mit dem Server Configuration Tool erstellen
{: #creating-the-db2-database-tables-with-the-server-configuration-tool }
Verwenden Sie das mit der MobileFirst-Server-Installation bereitgestellte
Server Configuration Tool, um die DB2-Datenbanktabellen
zu erstellen. 

Das Server Configuration Tool kann
eine Datenbank in der DB2-Standardinstanz erstellen.
Wählen Sie im Fenster **Database Selection** des
Server Configuration Tool die Option
"IBM DB2" aus. Geben Sie in den nächsten drei Teilfenstern die Datenbankberechtigungsnachweise ein. Wenn der im Fenster
**Database Additional Settings** eingegebene Datenbankname nicht in der DB2-Instanz vorhanden ist,
können Sie zusätzliche Angaben machen, damit das Tool eine Datenbank für Sie erstellen kann. 

Das Server Configuration Tool führt die folgende SQL-Anweisung aus, um die
Datenbanktabellen mit Standardeinstellungen zu erstellen: 
```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Diese Datenbank ist nicht für die Produktion geeignet, da bei einer
DB2-Standardinstallation viele Berechtigungen für PUBLIC erteilt werden. 

### Oracle-Datenbanktabellen mit dem Server Configuration Tool erstellen
{: #creating-the-oracle-database-tables-with-the-server-configuration-tool }
Verwenden Sie das mit der MobileFirst-Server-Installation bereitgestellte
Server Configuration Tool, um die Oracle-Datenbanktabellen
zu erstellen. 

Wählen Sie im Fenster "Database Selection" des
Server Configuration Tool die Option
**Oracle Standard or Enterprise Editions, 11g or
12c** aus. Geben Sie in den nächsten drei Teilfenstern die Datenbankberechtigungsnachweise ein. 

Im Fenster
**Database Additional Settings** müssen Sie den Oracle-Benutzernamen in Großbuchstaben eingeben. Wenn Sie einen Oracle-Datenbankbenutzer (FOO) haben, den Benutzernamen aber
in Kleinbuchstaben eingeben (foo),
interpretiert das Server Configuration Tool die Eingabe als einen anderen
Benutzer. Im Gegensatz zu anderen Tools für Oracle-Datenbanken schützt das
Server Configuration Tool den Benutzernamen vor einer
automatischen Konvertierung in Großbuchstaben. 

Das Server Configuration Tool verwendet für
die Identifizierung einer Datenbank einen Servicenamen oder eine Oracle-System-ID (SID).
Wenn Sie jedoch eine Verbindung zu Oracle RAC herstellen möchten, müssen Sie eine komplexe JDBC-URL eingeben. Wählen Sie in dem Fall im Fenster
**Database
Settings** die Option **Connect using generic
Oracle JDBC URLs** aus und geben Sie eine URL für den Oracle-Thin-Treiber ein. 

Wenn Sie die Datenbank und den Benutzer für Oracle erstellen,
verwenden Sie das Tool DBCA (Oracle Database Creation Assistant). Weitere Informationen finden Sie unter
[Datenbank- und Benutzeranforderungen für Oracle](#oracle-database-and-user-requirements).

Das Server Configuration Tool kann dieselben Schritte ausführen, allerdings mit
einer Einschränkung. Das Tool kann einen Benutzer für
Oracle 11g oder Oracle 12g erstellen, aber eine Datenbank nur für
Oracle 11g und nicht für Oracle 12c. 

Wenn der im Fenster
**Database Additional Settings** eingegebene Datenbank- oder Benutzername nicht vorhanden ist, sind zusätzliche Schritte erforderlich, um die Datenbank oder den
Benutzer zu erstellen. Diese Schritte sind in den beiden folgenden Abschnitten beschrieben. 

#### Datenbank erstellen
{: #creating-the-database }

1. Führen Sie auf dem Computer mit der Oracle-Datenbank einen SSH-Server aus. 

    Das Server Configuration Tool öffnet eine
SSH-Sitzung mit dem Oracle-Host, um die Datenbank zu erstellen. Der SSH-Server ist außer für Linux-Systeme
und einige UNIX-Systemversionen auch dann erforderlich, wenn die
Oracle-Datenbank auf demselben
Computer wie das
Server Configuration Tool ausgeführt wird.

2. Geben Sie im Fenster **Database creation request** die Anmelde-ID und das Kennwort für einen Oracle-Datenbankbenutzer mit der Berechtigung zur Erstellung einer
Datenbank ein. 
3. Geben Sie in diesem Fenster außerdem das Kennwort für den Benutzer **SYS** und den Benutzer
**SYSTEM** der zu erstellenden Datenbank ein. 

Eine Datenbank mit dem im Fenster
**Database Additional Settings** eingegebenen SID-Namen wird erstellt. Diese Datenbank ist nicht für die Produktion bestimmt. 

#### Benutzer erstellen
{: #creating-the-user }

1. Führen Sie auf dem Computer mit der Oracle-Datenbank einen SSH-Server aus. 

    Das Server Configuration Tool öffnet eine
SSH-Sitzung mit dem Oracle-Host, um die Datenbank zu erstellen. Der SSH-Server ist außer für Linux-Systeme
und einige UNIX-Systemversionen auch dann erforderlich, wenn die
Oracle-Datenbank auf demselben
Computer wie das
Server Configuration Tool ausgeführt wird.

2. Geben Sie im Fenster **Database Additional Settings** die Anmelde-ID und das Kennwort des zu erstellenden Datenbankbenutzers ein. 
3. Geben Sie im Fenster **Database creation request** die Anmelde-ID und das Kennwort für einen Oracle-Datenbankbenutzer mit der Berechtigung zur Erstellung eines
Datenbankbenutzers ein. 
4. Geben Sie in diesem Fenster außerdem das Kennwort für den Benutzer **SYSTEM** der Datenbank ein. 

### MySQL-Datenbanktabellen mit dem Server Configuration Tool erstellen
{: #creating-the-mysql-database-tables-with-the-server-configuration-tool }
Verwenden Sie das mit der MobileFirst-Server-Installation bereitgestellte
Server Configuration Tool, um die MySQL-Datenbanktabellen
zu erstellen. 

Das Server Configuration Tool kann eine MySQL-Datenbank für Sie erstellen. Wählen Sie im Fenster **Database Selection** des
Server Configuration Tool die Option
**MySQL 5.5.x, 5.6.x or
5.7.x** aus. Geben Sie in den nächsten drei Teilfenstern die Datenbankberechtigungsnachweise ein. Wenn der im Fenster
Database Additional Settings eingegebene Datenbank- oder Benutzername nicht vorhanden ist,
kann das Tool die Datenbank oder den Benutzer erstellen. 

Wenn der MySQL-Server nicht mit den unter
[Datenbank- und Benutzeranforderungen für MySQL](#mysql-database-and-user-requirements) empfohlenen Einstellungen konfiguriert ist,
zeigt das Server Configuration Tool
eine Warnung an. Vergewissern Sie sich, dass die Anforderungen erfüllt sind,
bevor Sie das Server Configuration Tool ausführen. 

Nachfolgend sind einige zusätzliche Schritte angegeben, die Sie ausführen müssen,
wenn Sie die Datenbanktabellen mit dem Tool erstellen möchten. 

1. Im Fenster **Database Additional Settings** müssen Sie neben den Verbindungseinstellungen
alle Hosts eingeben, von denen der Benutzer eine Verbindung zur Datenbank herstellen darf.
Sie müssen also alle Hosts angeben,
auf denen {{ site.data.keys.mf_server }} ausgeführt wird. 
2. Geben Sie im Fenster **Database creation request** die Anmelde-ID und das Kennwort eines
MySQL-Administrators ein. Standardmäßig ist root der Administrator. 

## Datenbanktabellen mit Ant-Tasks erstellen
{: #create-the-database-tables-with-ant-tasks }
Die Datenbanktabellen für die MobileFirst-Server-Anwendungen können manuell, mit Ant-Tasks oder mit dem
Server Configuration Tool erstellt werden. In den folgenden Abschnitten ist die Erstellung mit Ant-Tasks ausführlich erläutert. 

In diesem Abschnitt finden Sie relevante Informationen zum Einrichten der Datenbank bei Installation von
{{ site.data.keys.mf_server }} mit Ant-Tasks.  

Sie können die MobileFirst-Server-Datenbanktabellen mit Ant-Tasks einrichten. In einigen Fällen können Sie auch eine Datenbank und einen Benutzer mit diesen Tasks erstellen. Eine Übersicht über den Installationsprozess mit Ant-Tasks finden Sie unter [{{ site.data.keys.mf_server }} im Befehlszeilenmodus installieren](../../simple-install/tutorials/command-line).

Mit der Installation werden eine Reihe von Ant-Beispieldateien bereitgestellt, die Ihnen den Einstieg in das Arbeiten mit Ant-Tasks erleichtern sollen. Sie finden diese Dateien unter **MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples**. Die Dateien sind nach folgendem Muster benannt:

#### configure-appserver-dbms.xml
{: #configure-appserver-dbmsxml }
Mit den Ant-Dateien können Sie folgende Schritte ausführen: 

* Tabellen in einer Datenbank erstellen, wenn die Datenbank und der Datenbankbenutzer bereits vorhanden sind. Die Anforderungen an die Datenbank sind in den
[Datenbankvoraussetzungen](#database-requirements) aufgelistet.
* WAR-Dateien der MobileFirst-Server-Komponenten im Anwendungsserver implementieren. Diese Ant-Dateien verwenden denselben
Datenbankbenutzer, um die Tabellen zu erstellen und den in der Laufzeit den Laufzeitdatenbankbenutzer für die Anwendungen zu installieren. Außerdem verwenden die Dateien
für alle MobileFirst-Server-Anwendungen denselben Datenbankbenutzer. 

#### create-database-dbms.xml
{: #create-database-dbmsxml }
Die Ant-Dateien können eine Datenbank für das unterstützte Datenbankmanagementsystem (DBMS) erstellen, sofern erforderlich, und dann die Tabellen in der Datenbank. Da die Datenbank mit Standardeinstellungen erstellt wird, ist sie nicht für die
Produktion geeignet. 

In den Ant-Dateien können Sie die vordefinierten Ziele finden, die die Ant-Task **configureDatabase** zum Einrichten der Datenbank verwenden. Lesen Sie hierzu die Referenzinformationen zur
[Ant-Task 'configuredatabase'](../../installation-reference/#ant-configuredatabase-task-reference). 

### Ant-Beispieldateien verwenden
{: #using-the-sample-ant-files }
Die Ant-Beispieldateien haben vordefinierte Ziele. Gehen Sie bei der Verwendung der Dateien wie nachfolgend beschrieben vor. 

1. Kopieren Sie die Ant-Datei für Ihre Anwendungsserver- und Datenbankkonfiguration in ein Arbeitsverzeichnis.
2. Bearbeiten Sie die Datei. Geben Sie die Werte fr Ihre Konfiguration im Abschnitt `<! -- Eigenschaftsparameter Anfang -->` der Ant-Datei ein. 
3. Führen Sie die Ant-Datei wie folgt mit dem Ziel databases aus: `MFP-Installationsverzeichnis/shortcuts/ant -f Ihre_Ant-Datei
databases`. 

Mit diesem Befehl werden die Tabellen in der angegebenen Datenbank mit dem angegebenen Schema
für alle MobileFirst-Server-Anwendungen
(den MobileFirst-Server-Verwaltungsservice, -Liveaktualisierungsservice und -Push-Service sowie die
MobileFirst-Server-Laufzeit) erstellt. Ein Protokoll für die Operationen wird erzeugt und auf Ihrer Platte gespeichert.

* Unter Windows befindet es sich im Verzeichnis **{{ site.data.keys.prod_server_data_dir_win }}\\Configuration Logs\\**. 
* Unter UNIX befindet es sich im Verzeichnis **{{ site.data.keys.prod_server_data_dir_unix }}/configuration-logs/**. 

### Verschiedene Benutzer für Erstellung der Datenbanktabellen und Laufzeit
{: #different-users-for-the-database-tables-creation-and-for-run-time }
Die Ant-Beispieldateien
unter **MFP-Installationsverzeichnis/MobileFirstServer/configurations-samples** verwenden
für Folgendes denselben Datenbankbenutzer: 

* Alle MobileFirst-Server-Anwendungen (Verwaltungsservice, Liveaktualisierungsservice, Push-Service und Laufzeit)
* Benutzer für die Erstellung der Datenbank und Laufzeitbenutzer für die Datenquelle im Anwendungsserver

Wenn Sie
verschiedene Benutzer verwenden möchten (siehe Beschreibung unter [Datenbankbenutzer und -berechtigungen](#database-users-and-privileges)),
müssen Sie Ihre eigene Ant-Datei erstellen oder die Ant-Beispieldateien so modifizieren, dass es für jedes Datenbankziel einen anderen Benutzer gibt. Lesen Sie hierzu die [Referenzinformatinen zur Installation](../../installation-reference). 

In DB2 und MySQL ist es möglich, für die Datenbankerstellung einen anderen Benutzer als für die Laufzeit
zu verwenden.
Die Berechtigungen für jeden Benutzertyp sind unter [Datenbankbenutzer und -berechtigungen](#database-users-and-privileges) aufgelistet. In Oracle können Sie für die Datenbankerstellung und die Laufzeit keine unterschiedlichen Benutzer
angeben. Die Ant-Tasks sind für die Erstellung der Tabellen gemäß dem Standardschema
eines Benutzers ausgelegt. Wenn Sie die Zugriffsrechte für den Laufzeitbenutzer einschränken möchten, müssen Sie die Tabellen manuell gemäß dem Standardschema des Benutzers erstellen, der in der Laufzeit
verwendet wird. Weitere Informationen finden Sie unter [Oracle-Datenbanktabellen manuell erstellen](#creating-the-oracle-database-tables-manually).

Wählen Sie den Abschnitt über die Erstellung
der Datenbanktabellen mit Ant-Tasks aus, der zu Ihrem unterstüzten Datenbankmanagementsystem (DBMS) passt. 

### DB2-Datenbanktabellen mit Ant-Tasks erstellen
{: #creating-the-db2-database-tables-with-ant-tasks }
Verwenden Sie für die Erstellung der DB2-Datenbank die mit der MobileFirst-Server-Installation bereitgestellten Ant-Tasks. 

Wie Sie Datenbanktabellen in einer bereits vorhandenen Datenbank erstellen können, erfahren Sie unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks).

Sie können eine Datenbank und die Datenbanktabellen mit Ant-Tasks erstellen. Die Ant-Tasks erstellen eine Datenbank in der Standardinstanz von
DB2, wenn Sie eine Ant-Datei mit dem Element
**dba** verwenden. Sie finden dieses Element in den Ant-Beispieldateien mit dem Namen
**create-database-<DBMS>.xml**.

Vergewissern Sie sich vor der Ausführung der Ant-Tasks, dass auf dem Computer, auf dem die DB2-Datenbank ausgeführt wird, ein SSH-Server verfügbar ist. Die Ant-Task
**configureDatabase** öffnet eine SSH-Sitzung mit dem
DB2-Host, um die Datenbank zu erstellen. Der SSH-Server wird auch dann benötigt, wenn die
DB2-Datenbank sich auf dem Computer befindet, auf dem Sie die Ant-Tasks ausführen.
(Eine Ausnahme hiervon bilden Linux-Systeme und einige
Arten von UNIX-Systemen.) 

Bearbeiten Sie die Kopie der Datei **create-database-db2.xml** gemäß den allgemeinen Richtlinien unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks). 

Im Element **dba** müssen Sie auch die Anmelde-ID und das Kennwort eines
DB2-Benutzers mit Administratorberechtigung (Berechtigung **SYSADM** oder **SYSCTRL**)
angeben. In der Ant-Beispieldatei für DB2 (**create-database-db2.xml**) müssen die Eigenschaften
**database.db2.admin.username** und **database.db2.admin.password** definiert werden. 

Wenn das Ant-Ziel **databases** aufgerufen wird, erstellt die Ant-Task
**configureDatabase** mit der folgenden SQL-Anweisung eine Datenbank mit Standardeinstellungen: 

```sql
CREATE DATABASE MFPDATA COLLATE USING SYSTEM PAGESIZE 32768
```

Diese Datenbank ist nicht für die Produktion geeignet, da bei einer
DB2-Standardinstallation viele Berechtigungen für PUBLIC erteilt werden. 

### Oracle-Datenbanktabellen mit Ant-Tasks erstellen
{: #creating-the-oracle-database-tables-with-ant-tasks }
Verwenden Sie für die Erstellung der Oracle-Datenbanktabellen die mit der MobileFirst-Server-Installation bereitgestellten Ant-Tasks. 

Wenn Sie den Oracle-Benutzernamen in der Ant-Datei eingeben, verwenden Sie Großbuchstaben. Wenn Sie einen
Oracle-Datenbankbenutzer (FOO) haben, den Benutzernamen aber
in Kleinbuchstaben eingeben (foo),
interpretiert die Ant-Task **configureDatabase** die Eingabe als einen anderen
Benutzer. Im Gegensatz zu anderen Tools für Oracle-Datenbanken schützt die Ant-Task
**configureDatabase** den Benutzernamen vor einer
automatischen Konvertierung in Großbuchstaben. 

Die Ant-Task **configureDatabase** verwendet für
die Identifizierung einer Datenbank einen Servicenamen oder eine Oracle-System-ID (SID).
Wenn Sie jedoch eine Verbindung zu Oracle RAC herstellen möchten, müssen Sie eine komplexe JDBC-URL eingeben. In dem Fall
muss das Element **oracle** der Ant-Task
**configureDatabase** die Attribute
**url**, **user**
und **password** anstelle der Attribute
**database**, **server**, **port**, **user**
und **password** verwenden. Sehen Sie sich hierzu die Tabelle in den Referenzinformationen zur [Ant-Task **configuredatabase**](../../installation-reference/#ant-configuredatabase-task-reference) an. Die Ant-Beispieldateien im Verzeichnis **MFP-Installationsverzeichnis/MobileFirstServer/configurations-samples** verwenden die Attribute
**database**, **server**, **port**, **user**
und **password** im Element **oracle**.
Sie müssen modifiziert werden, wenn Sie die Verbindung zu Oracle über eine JDBC-URL herstellen. 

Wie Sie Datenbanktabellen in einer bereits vorhandenen Datenbank erstellen können, erfahren Sie unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks).

Verwenden Sie zum Erstellen
einer Datenbank, eines Benutzers oder der Datenbanktabellen
das Tool DBCA (Oracle Database Creation Assistant). Weitere Informationen finden Sie unter
[Datenbank- und Benutzeranforderungen für Oracle](#oracle-database-and-user-requirements).

Die Ant-Task **configureDatabase** kann dieselben Schritte ausführen, allerdings mit
einer Einschränkung. Die Task kann einen Datenbankbenutzer für
Oracle 11g oder Oracle 12g erstellen, aber eine Datenbank nur für
Oracle 11g und nicht für Oracle 12c. Weitere Schritte, die Sie für die Erstellung der Datenbank oder des Benutzers ausführen müssen, sind in den folgenden
Abschnitten beschrieben. 

#### Datenbank erstellen
{: #creating-the-database-1 }
Bearbeiten Sie die Kopie der Datei **create-database-oracle.xml** gemäß den allgemeinen Richtlinien unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks). 

1. Führen Sie auf dem Computer mit der Oracle-Datenbank einen SSH-Server aus. 

    Die Ant-Task
**configureDatabase** öffnet eine SSH-Sitzung mit dem
Oracle-Host, um die Datenbank zu erstellen. Der SSH-Server ist außer für Linux-Systeme
und einige UNIX-Systemversionen auch dann erforderlich, wenn die
Oracle-Datenbank auf demselben
Computer wie die Ant-Tasks
ausgeführt wird.

2. Geben Sie im Element **dba** in der Datei
**create-database-oracle.xml** die Anmelde-ID und das Kennwort eines Oracle-Datenbankbenutzers ein, der über SSH eine Verbindung zum Oracle-Server herstellen kann und berechtigt ist, eine Datenbank zu erstellen. Sie können die Werte mit folgenden Eigenschaften zuweisen:

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
3. Geben Sie im Element **oracle** den Namen der zu erstellenden Datenbank ein. Das Attribut ist **database**.
Den Wert können Sie mit der Eigenschaft **database.oracle.mfp.dbname** zuweisen. 
4. Geben Sie in demselben Element **oracle** das Kennwort für den Benutzer **SYS** und den Benutzer
**SYSTEM** der zu erstellenden Datenbank ein. Die Attribute sind **sysPassword** und **systemPassword**. Die Werte können Sie mit den entsprechenden Eigenschaften
zuweisen:

    * **database.oracle.sysPassword**
    * **database.oracle.systemPassword**
5. Wenn Sie in der Ant-Datei alle Datenbankberechtigungsnachweise eingegeben haben, speichern Sie die Datei und führen Sie das Ant-Ziel
**databases** aus. 

Eine Datenbank mit dem im Attribut database des Elements **oracle**
eingegebenen SID-Namen wird erstellt. Diese Datenbank ist nicht für die Produktion bestimmt. 

#### Benutzer erstellen
{: #creating-the-user-1 }
Bearbeiten Sie die Kopie der Datei **create-database-oracle.xml** gemäß den allgemeinen Richtlinien unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks). 

1. Führen Sie auf dem Computer mit der Oracle-Datenbank einen SSH-Server aus. 

    Die Ant-Task
**configureDatabase** öffnet eine SSH-Sitzung mit dem
Oracle-Host, um die Datenbank zu erstellen. Der SSH-Server ist außer für Linux-Systeme
und einige UNIX-Systemversionen auch dann erforderlich, wenn die
Oracle-Datenbank auf demselben
Computer wie die Ant-Tasks
ausgeführt wird.

2. Geben Sie im Element oracle in der Datei
**create-database-oracle.xml** die Anmelde-ID und das Kennwort für die zu erstellende Oracle-Datenbank ein. Die Attribute sind **user** und **password**. Die Werte können Sie mit den entsprechenden Eigenschaften
zuweisen:

    * database.oracle.mfp.username
    * database.oracle.mfp.password
3. Geben Sie in demselben Element **oracle** das Kennwort für den Benutzer **SYSTEM** der Datenbank ein. Das Attribut ist **systemPassword**.
Den Wert können Sie mit der Eigenschaft **database.oracle.systemPassword** zuweisen. 
4. Geben Sie im Element **dba** die Anmelde-ID und das Kennwort für einen Oracle-Datenbankbenutzer mit der Berechtigung zur Erstellung eines
Benutzers ein. Sie können die Werte mit folgenden Eigenschaften zuweisen:

    * **database.oracle.admin.username**
    * **database.oracle.admin.password**
5. Wenn Sie in der Ant-Datei alle Datenbankberechtigungsnachweise eingegeben haben, speichern Sie die Datei und führen Sie das Ant-Ziel
**databases** aus. 

Ein Datenbankbenutzer mit dem im Element
**oracle** eingegebenen Namen und Kennwort wird erstellt. Dieser Benutzer ist berechtigt, die MobileFirst-Server-Tabellen zu erstellen, zu aktualisieren und in der Laufzeit
zu verwenden. 

### MySQL-Datenbanktabellen mit Ant-Tasks erstellen
{: #creating-the-mysql-database-tables-with-ant-tasks }
Verwenden Sie für die Erstellung der MySQL-Datenbanktabellen die mit der MobileFirst-Server-Installation bereitgestellten Ant-Tasks. 

Wie Sie Datenbanktabellen in einer bereits vorhandenen Datenbank erstellen können, erfahren Sie unter
[Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks).

Wenn der MySQL-Server nicht mit den unter
[Datenbank- und Benutzeranforderungen für MySQL](#mysql-database-and-user-requirements) empfohlenen Einstellungen konfiguriert ist,
zeigt die Ant-Task
eine Warnung an. Vergewissern Sie sich, dass die Anforderungen erfüllt sind,
bevor Sie die Ant-Task ausführen. 

Folgen Sie beim Erstellen einer Datenbank und der Datenbanktabellen
den allgemeinen Anweisungen
unter [Datenbanktabellen mit Ant-Tasks erstellen](#create-the-database-tables-with-ant-tasks) für die Bearbeitung einer Kopie der Datei **create-database-mysql.xml**. 

Nachfolgend sind einige zusätzliche Schritte angegeben, die Sie ausführen müssen,
wenn Sie die Datenbanktabellen mit der Ant-Task **configureDatabase** erstellen möchten. 

1. Geben Sie im Element **dba** in der Datei
**create-database-mysql.xml** die Anmelde-ID und das Kennwort eines MySQL-Administrators ein. Standardmäßig ist **root** der Administrator. Sie können die Werte mit folgenden Eigenschaften zuweisen:

    * **database.mysql.admin.username**
    * **database.mysql.admin.password**
2. Fügen Sie zum Element **mysql** ein Element **client** für jeden Host hinzu, von dem aus der Benutzer eine Verbindung zu der Datenbank
herstellen darf. Sie müssen also alle Hosts angeben,
auf denen {{ site.data.keys.mf_server }} ausgeführt wird. Wenn Sie in der Ant-Datei alle Datenbankberechtigungsnachweise eingegeben haben, speichern Sie die Datei und führen Sie das Ant-Ziel
**databases** aus. 
