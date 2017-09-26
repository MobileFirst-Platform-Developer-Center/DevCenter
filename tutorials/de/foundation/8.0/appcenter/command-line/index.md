---
layout: tutorial
title: Befehlszeilentool für das Hochladen oder Löschen einer Anwendung
breadcrumb_title: App hochladen oder löschen
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Verwenden Sie das Befehlszeilentool, wenn Sie Anwendungen über einen Build-Prozess im Application Center
implementieren möchten.

Sie können eine Anwendung über die Webschnittstelle
der Application-Center-Konsole in das Application Center hochladen. Sie können eine neue Anwendung auch mit einem Befehlszeilentool hochladen.

Dies ist besonders nützlich, wenn Sie die Implementierung einer Anwendung im Application Center in einen Build-Prozess integrieren möchten.
Das Tool ist in **Installationsverzeichnis/ApplicationCenter/tools/applicationcenterdeploytool.jar** enthalten.

Das Tool kann für Anwendungsdateien mit der Erweiterung APK oder IPA verwendet werden. Es kann eigenständig oder als Ant-Task verwendet werden. 

Das Verzeichnis "tools" enthält alle Dateien, die zur Unterstützung der Toolverwendung erforderlich sind.

* **applicationcenterdeploytool.jar**: Uploadtool
* **json4j.jar**: Bibliothek für das vom Uploadtool benötigte JSON-Format
* **build.xml**: Ant-Beispiel-Script, mit dem Sie eine einzelne Datei oder eine Reihe von Dateien in das Application Center hochladen können
* **acdeploytool.sh** und **acdeploytool.bat**:
Beispiel-Scripts zum Aufrufen von Java mit **applicationcenterdeploytool.jar**

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Anwendung mit dem eigenständigen Tool hochladen](#using-the-stand-alone-tool-to-upload-an-application)
* [Anwendung mit dem eigenständigen Tool löschen](#using-the-stand-alone-tool-to-delete-an-application)
* [Inhalt des LDAP-Cache mit eigenständigem Tool löschen](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [Ant-Task zum Hochladen oder Löschen einer Anwendung](#ant-task-for-uploading-or-deleting-an-application)

### Anwendung mit dem eigenständigen Tool hochladen
{: #using-the-stand-alone-tool-to-upload-an-application }
Rufen Sie das eigenständige Tool über die Befehlszeile auf, um eine Anwendung hochzuladen.  
Führen Sie für die Verwendung des eigenständigen Tools die folgenden Schritte aus.

1. Fügen Sie **applicationcenterdeploytool.jar** und **json4j.jar** zur Java-Umgebungsvariablen CLASSPATH hinzu.
2. Rufen Sie das Aktualisierungstool wie folgt in der Befehlszeile auf:

   ```bash
   java com.ibm.appcenter.Upload [Optionen] [Dateien]
   ```

Sie können jede der verfügbaren Optionen in der Befehlszeile übergeben.

| Option| Inhalt angegeben mit| Beschreibung|
|--------|----------------------|-------------|
| -s| serverpath| Pfad zum Application-Center-Server|
| -c| context| Kontext der Application-Center-Webanwendung|
| -u| user| Benutzerberechtigungsnachweise für den Zugriff auf das Application Center|
| -p| password| Kennwort des Benutzers|
| -d| description| Beschreibung der hochzuladenden Anwendung|
| -l| label| Alternative Bezeichnung. Normalerweise wird die Bezeichnung aus dem Anwendungsdeskriptor übernommen, der in der hochzuladenden Datei gespeichert ist. Wenn der Anwendungsdeskriptor keine Bezeichnung enthält, wird die alternative Bezeichnung verwendet.|
| -isActive| true oder false| Die Anwendung wird im Application Center als aktive oder inaktive Anwendung gespeichert.|
| -isInstaller| true oder false| Die Anwendung wird im Application Center mit der entsprechend gesetzten Option "installer" gespeichert.|
| -isReadyForProduction| true oder false| Die Anwendung wird im Application Center mit der entsprechend gesetzten Option "ready-for-production" gespeichert.|
| -isRecommended| true oder false| Die Anwendung wird im Application Center mit der entsprechend gesetzten Option "recommended" gespeichert.|
| -e	  |  | Zeigt bei einer Störung den vollständigen Stack-Trace für Ausnahmen an|
| -f	  |  | Erzwingt das Hochladen von Anwendungen, auch wenn diese bereits vorhanden sind|
| -y	  |  | Inaktiviert die SSL-Sicherheitsprüfung, sodass auf geschützten Hosts Veröffentlichungen ohne Prüfung des SSL-Zertifikats möglich sind. |  Die Verwendung dieser Option ist ein Sicherheitsrisiko, kann aber für das Testen von localhost mit temporären selbst signierten SSL-Zertifikaten geeignet sein.|

Mit dem Parameter "Dateien" können Dateien mit Android-Anwendungspaketen
(.apk) oder iOS-Anwendungsdateien
(.ipa) angegeben werden.  
In diesem Beispiel hat der Benutzer demo das Kennwort demopassword. Verwenden Sie die folgende Befehlszeile.

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### Anwendung mit dem eigenständigen Tool löschen
{: #using-the-stand-alone-tool-to-delete-an-application }
Rufen Sie das eigenständige Tool über die Befehlszeile auf, um eine Anwendung aus dem Application Center zu löschen.  
Führen Sie für die Verwendung des eigenständigen Tools die folgenden Schritte aus.

1. Fügen Sie **applicationcenterdeploytool.jar** und **json4j.jar** zur Java-Umgebungsvariablen CLASSPATH hinzu.
2. Rufen Sie das Aktualisierungstool wie folgt in der Befehlszeile auf:

   ```bash
   java com.ibm.appcenter.Upload -delete [Optionen] [Dateien oder Anwendungen]
   ```

Sie können jede der verfügbaren Optionen in der Befehlszeile übergeben.

| Option| Inhalt angegeben mit| Beschreibung|
|--------|----------------------|-------------|
| -s|serverpath| Pfad zum Application-Center-Server|
| -c| context| Kontext der Application-Center-Webanwendung|
| -u| user| Benutzerberechtigungsnachweise für den Zugriff auf das Application Center|
| -p| password| Kennwort des Benutzers|
| -y| | Inaktiviert die SSL-Sicherheitsprüfung, sodass auf geschützten Hosts Veröffentlichungen ohne Prüfung des SSL-Zertifikats möglich sind. Die Verwendung dieser Option ist ein Sicherheitsrisiko, kann aber für das Testen von localhost mit temporären selbst signierten SSL-Zertifikaten geeignet sein.|

Sie können Dateien oder das Anwendungspaket, das Betriebssystem und die Version angeben. Wenn Dateien angegeben werden,
werden das Paket, das Betriebssystem und die Version anhand der Datei bestimmt. Dann wird die entsprechende Anwendung aus dem Application Center gelöscht. Wenn Anwendungen angegeben werden,
müssen sie eines der folgenden Formate haben: 

* `Paket@Betriebssystem@Version` zum Löschen genau dieser Version aus
dem Application Center. Im Versionsabschnitt muss die
"interne Version" und nicht die "kommerzielle Version" der Anwendung angegeben werden.
* `Paket@Betriebssystem` zum Löschen aller Versionen dieser Anwendung aus dem
Application Center
* `Paket` zum Löschen aller Versionen dieser Anwendung für alle Betriebssysteme aus dem
Application Center

#### Beispiel
{: #example-delete }
In diesem Beispiel hat der Benutzer demo das Kennwort demopassword. Verwenden Sie die folgende
Befehlszeile, um die iOS-Anwendung demo.HelloWorld mit der internen Version 3.0 zu löschen.

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### Inhalt des LDAP-Cache mit eigenständigem Tool löschen
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
Mit dem eigenständigen Tool können Sie den Inhalt des LDAP-Cache löschen und Änderungen für LDAP-Benutzer und -Gruppen sofort im
Application
Center sichtbar machen.

Wenn das Application Center mit LDAP konfiguriert ist, werden Änderungen für Benutzer und Gruppen auf dem LDAP-Server erst nach einer Verzögerung
im Application
Center sichtbar. Das Application Center verwaltet einen Cache mit
LDAP-Daten, und Änderungen werden erst sichtbar, wenn der Cache abgelaufen ist.
Standardmäßig liegt die Verzögerung bei 24 Stunden. Wenn Sie nach Änderungen für Benutzer und Gruppen nicht die gesamte Verzögerungszeit warten möchten,
können Sie das eigenständige Tool in der Befehlszeile aufrufen, um die LDAP-Daten aus dem Cache zu löschen. Wenn Sie den
Cacheinhalt mit dem eigenständigen Tool gelöscht haben, werden die Änderungen sofort sichtbar.

Führen Sie für die Verwendung des eigenständigen Tools die folgenden Schritte aus.

1. Fügen Sie applicationcenterdeploytool.jar und json4j.jar zur Java-Umgebungsvariablen classpath hinzu.
2. Rufen Sie das Aktualisierungstool wie folgt in der Befehlszeile auf:

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [Optionen]
   ```

Sie können jede der verfügbaren Optionen in der Befehlszeile übergeben.

| Option| Inhalt angegeben mit| Beschreibung|
|--------|----------------------|-------------|
| -s| serverpath| Pfad zum Application-Center-Server|
| -c| context| Kontext der Application-Center-Webanwendung|
| -u| user| Benutzerberechtigungsnachweise für den Zugriff auf das Application Center|
| -p| password| Kennwort des Benutzers|
| -y| | Inaktiviert die SSL-Sicherheitsprüfung, sodass auf geschützten Hosts Veröffentlichungen ohne Prüfung des SSL-Zertifikats möglich sind. Die Verwendung dieser Option ist ein Sicherheitsrisiko, kann aber für das Testen von localhost mit temporären selbst signierten SSL-Zertifikaten geeignet sein.|

#### Beispiel
{: #example-cache }
In diesem Beispiel hat der Benutzer demo das Kennwort demopassword. 

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### Ant-Task zum Hochladen oder Löschen einer Anwendung
{: #ant-task-for-uploading-or-deleting-an-application}
Sie können die Tools zum Hochladen und Löschen als Ant-Task verwenden und die Ant-Task in Ihrem eigenen
Ant-Script ausführen.  
Für die Ausführung dieser Tasks ist Apache Ant erforderlich. Die unterstützte
Mindestversion von Apache Ant ist in den
[Systemvoraussetzungen](../../product-overview/requirements) angegeben.

Für Ihren Komfort ist Apache Ant 1.8.4
im Lieferumfang von {{ site.data.keys.mf_server }} enthalten. Im
Verzeichnis Produktinstallationsverzeichnis/shortcuts/ stehen die folgenden Scripts
zur Verfügung:

* ant für UNIX/Linux
* ant.bat für Windows

Diese Scripts können sofort ausgeführt werden. Sie erfordern keine bestimmten
Umgebungsvariablen. Wenn die Umgebungsvariable JAVA_HOME gesetzt ist, wird sie von den Scripts akzeptiert.

Wenn Sie das Tool zum Hochladen als eine Ant-Task verwenden,
lautet der "classname" der Ant-Task "upload"
**com.ibm.appcenter.ant.UploadApps**. Der "classname" der Ant-Task "delete" ist **com.ibm.appcenter.ant.DeleteApps**.

| Parameter der Ant-Task| Beschreibung|
|------------------------|-------------|
| serverPath| Verbindung zum Application Center herstellen. Der Standardwert ist http://localhost:9080.|
| context| Kontext des Application Center. Der Standardwert ist /applicationcenter.|
| loginUser| Name des Benutzers mit der Berechtigung, eine Anwendung hochzuladen|
| loginPass| Kennwort des Benutzers mit der Berechtigung, eine Anwendung hochzuladen|
| forceOverwrite| Wenn dieser Parameter auf "true" gesetzt ist, versucht die Ant-Task beim Hochladen einer bereits im Application Center vorhandenen Anwendung, die vorhandene Anwendung zu überschreiben. Dieser Parameter ist nur für die Ant-Task "upload" verfügbar.
| file| Die .apk- oder .ipa-Datei, die in das Application Center hochgeladen oder aus dem Application Center gelöscht werden soll. Dieser Parameter hat keinen Standardwert.|
| fileset| Hochladen oder Löschen mehrerer Dateien|
| application| Paketname der Anwendung. Dieser Parameter ist nur für die Ant-Task "delete" verfügbar.|
| os| Betriebssystem der Anwendung (z. B. Android oder iOS). Dieser Parameter ist nur für die Ant-Task "delete" verfügbar.|
| version| Interne Version der Anwendung. Dieser Parameter ist nur für die Ant-Task "delete" verfügbar. Verwenden Sie hier nicht die kommerzielle Version, die nicht zum genauen Identifizieren der Version geeignet ist.|

#### Beispiel
{: #example-ant }
Ein ausführliches Beispiel finden Sie im Verzeichnis
**ApplicationCenter/tools/build.xml**.   
Das
folgende Beispiel zeigt, wie Sie die Ant-Task in Ihrem eigenen Ant-Script verwenden können.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Servereigenschaften -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" />
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!-- Authentifizierungseigenschaften -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps">
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

Dieses Ant-Beispiel-Script finden Sie im Verzeichnis **tools**.
Sie können es verwenden, um eine
einzelne Anwendung in das Application Center hochzuladen.

```bash
ant upload.App -Dupload.file=sample.ipa
```

Sie können es auch verwenden, um
alle in einer Verzeichnishierarchie gefundenen Anwendungen hochzuladen.

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### Eigenschaften des Ant-Beispiel-Scripts
{: #properties-of-the-sample-ant-script }
| Eigenschaft| Kommentar|
|----------|---------|
| install.dir| Standardmäßig ../../|
| server.path| Der Standardwert ist http://localhost:9080.|
| context.path| Der Standardwert ist applicationcenter.|
| upload.file| Diese Eigenschaft hat keinen Standardwert. Sie muss den genauen Dateipfad enthalten.|
| workspace.root| Standardmäßig ../../|
| login.user| Der Standardwert ist appcenteradmin.|
| login.pass| Der Standardwert ist admin.|
| force	| Der Standardwert ist true.|

Wenn Sie
diese Parameter beim Aufrufen von Ant in der Befehlszeile angeben möchten,
fügen Sie vor dem Eigenschaftsnamen -D hinzu. Beispiel: 

```xml
-Dserver.path=http://localhost:8888/
```
