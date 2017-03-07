---
layout: tutorial
title: Java- und JavaScript-Adapter erstellen
breadcrumb_title: Adapter erstellen
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Einen Adapter können Sie mit Maven-Befehlen erstellen oder über die {{ site.data.keys.mf_cli }} (die allerdings voraussetzt, dass Maven installiert und konfiguriert ist). Der Adaptercode kann dann in einer IDE Ihrer Wahl bearbeitet und erstellt
werden, z. B. in Eclipse und IntelliJ. In diesem Lernprogramm wird die Erstellung und Implementierung von
**Java- oder JavaScript-Adaptern** mit Maven und mithilfe der {{ site.data.keys.mf_cli }} erläutert. Wenn Sie erfahren möchten, wie
Sie die Eclipse- oder IntelliJ-IDE für die Erstellung von Adaptern nutzen können,
arbeiten Sie das Lernprogramm [Adapter in Eclipse entwickeln](../developing-adapters) durch. 

**Voraussetzung:** Lesen Sie zuerst die [Adapterübersicht](../). 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Maven installieren](#install-maven)
* [Adapter über die {{ site.data.keys.mf_cli }} erstellen](#creating-adapters-using-mobilefirst-cli)
* [{{ site.data.keys.mf_cli }} installieren](#install-mobilefirst-cli)
* [Adapter erstellen](#creating-an-adapter)
* [Adapter mit einem Maven-Archetyp erstellen](#creating-adapters-using-maven-archetype-adapter-maven-archetype)
* [Dateistruktur](#file-structure)
* [Adapter erstellen und implementieren](#build-and-deploy-adapters)
* [Abhängigkeiten](#dependencies)
* [Adapter in einem Maven-Projekt zusammenfassen](#grouping-adapters-in-a-single-maven-project)
* [Adapter über die {{ site.data.keys.mf_console }} herunterladen oder implementieren](#downloading-or-deploying-adapters-using-mobilefirst-operations-console)
* [Maven-Adapterprojekt aktualisieren](#updating-the-adapter-maven-project)
* [Offline arbeiten](#working-offline)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Maven installieren
{: #install-maven }
Für die Erstellung eines Adapters müssen Sie zunächst Maven herunterladen und installieren. Rufen Sie die [Apache-Maven-Website](https://maven.apache.org/) auf und folgen Sie den Anweisungen für das Herunterladen
und Installieren von Maven.

## Adapter über die {{ site.data.keys.mf_cli }} erstellen
{: #creating-adapters-using-mobilefirst-cli }

### {{ site.data.keys.mf_cli }} installieren
{: #install-mobilefirst-cli }
Folgen Sie den Anweisungen auf der Seite [Downloads]({{site.baseurl}}/downloads/), um die {{ site.data.keys.mf_cli }} zu installieren.  
**Voraussetzung:** Maven muss installiert sein, wenn Sie Adapter mit der CLI für Entwickler erstellen möchten. 

### Adapter erstellen
{: #creating-an-adapter }
Verwenden Sie den Befehl `mfpdev adapter create`, um ein Maven-Adapterprojekt zu erstellen.
Sie können wählen, ob Sie den Befehl interaktiv oder direkt ausführen möchten. 

#### Interaktiver Modus
{: #interactive-mode }
1. Öffnen Sie ein **Befehlszeilenfenster** und führen Sie Folgendes aus: 

   ```bash
   mfpdev adapter create
   ```

2. Geben Sie einen Adapternamen ein. Beispiel: 

   ```bash
   ? Enter Adapter Name: SampleAdapter
   ```

3. Verwenden Sie die Pfeiltasten und die Eingabetaste, um einen Adaptertyp auszuwählen: 

   ```bash
   ? Select Adapter Type:
      HTTP
      SQL
   ❯ Java
   ```
  * Wählen Sie `HTTP` aus, um einen JavaScript-HTTP-Adapter zu erstellen. 
  * Wählen Sie `SQL` aus, um einen JavaScript-SQL-Adapter zu erstellen.   
  * Wählen Sie `Java` aus, um einen Java-Adapter zu erstellen. 

4. Geben Sie ein Adapterpaket ein. (Diese Option ist nur für Java-Adapter gültig.) Beispiel: 

   ```bash
   ? Enter Package: com.mypackage
   ```

5. Geben Sie eine Gruppen-ID ([Group Id](https://maven.apache.org/guides/mini/guide-naming-conventions.html)) für das zu erstellende Maven-Projekt ein. Beispiel: 

   ```bash
   ? Enter Group ID: com.mycompany
   ```

#### Direktmodus
{: #direct-mode }
Ersetzen Sie die Platzhalter durch tatsächliche Werte und führen Sie den Befehl dann aus: 

```bash
mfpdev adapter create <Adaptername> -t <Adaptertyp> -p <Adapterpaketname> -g <Gruppen-ID_des_Maven-Projekts>
```

## Adapter mit dem Maven-Archetyp 'adapter-maven-archetype' erstellen
{: #creating-adapters-using-maven-archetype-adapter-maven-archetype }

Der Archetyp "adapter-maven-archetype" ist ein Archetyp der {{ site.data.keys.product }} und basiert
auf dem [Maven-Toolkit für Archetypen](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html).
Er wird von Maven für die Erstellung des Maven-Adapterprojekts verwendet. 

Verwenden Sie den Maven-Befehl `archetype:generate`, um ein Maven-Adapterprojekt zu erstellen.
Wenn der Befehl ausgeführt wird, lädt Maven
Dateien herunter (oder verwendet Maven Dateien aus den oben erwähnten lokalen Repositorys), die für die Generierung des Maven-Adapterprojekts erforderlich sind. 

Sie können wählen, ob Sie den Befehl interaktiv oder direkt ausführen möchten. 

#### Interaktiver Modus
{: #interactive-mode-archetype }

1. Navigieren Sie in einem **Befehlszeilenfenster** zu einer Position Ihrer Wahl.   
An dieser Position wird das Maven-Projekt generiert. 

2. Ersetzen Sie den Platzhalter für den Wert von **DarchetypeArtifactId** durch den tatsächlichen Wert und führen Sie dann den Befehl aus: 

   ```bash
   mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=durch-Archetypartefakt-ID-ersetzen
   ```
   
  * Die Archetypgruppen-ID (`archetypeGroupId`) und die Archetypversion sind erforderliche Parameter für die Identifizierung des Archetyps. 
  * Die Archetypartefakt-ID (`archetypeArtifactId`) ist ein erforderlicher Parameter für die Identifizierung des Adaptertyps: 
     * Verwenden Sie `adapter-maven-archetype-java`, um einen Java-Adapter zu erstellen. 
     * Verwenden Sie `adapter-maven-archetype-http`, um einen JavaScript-HTTP-Adapter zu erstellen. 
     * Verwenden Sie `adapter-maven-archetype-sql`, um einen JavaScript-SQL-Adapter zu erstellen.   

3. Geben Sie eine Gruppen-ID ([Group Id](https://maven.apache.org/guides/mini/guide-naming-conventions.html)) für das zu erstellende Maven-Projekt ein. Beispiel: 

   ```bash
   Define value for property 'groupId': : com.mycompany
   ```

4. Geben Sie eine Artefakt-ID für das Maven-Projekt ein. Diese ID **wird später auch als Adaptername verwendet**. Beispiel: 

   ```bash
   Define value for property 'artifactId': : SampleAdapter
   ```

5. Geben Sie eine Maven-Projektversion ein. (Die Standardversion ist `1.0-SNAPSHOT`.) Beispiel: 

   ```bash
   Define value for property 'version':  1.0-SNAPSHOT: : 1.0
   ```

6. Geben Sie einen Adapterpaketnamen ein. (Der Standardname ist die `groupId`.) Beispiel: 

   ```bash
   Define value for property 'package':  com.mycompany: : com.mypackage
   ```

7. Geben Sie zur Bestätigung `y` ein: 

   ```bash
   Confirm properties configuration:
   groupId: com.mycompany
   artifactId: SampleAdapter
   version: 1.0
   package: com.mypackage
   archetypeVersion: 8.0.0
   Y: : y
   ```

#### Direktmodus
{: #direct-mode-archetype }
Ersetzen Sie die Platzhalter durch tatsächliche Werte und führen Sie den Befehl dann aus: 

```bash
mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=<Archetypartefakt-ID> -DgroupId=<Gruppen-ID_des_Maven-Projekts> -DartifactId=<Artefakt-ID_des_Maven-Projekts>  -Dpackage=<Adapterpaketname>
```

> Informationen zum Befehl `archetype:generate` finden Sie in der [Maven-Dokumentation](http://maven.apache.org/).

## Dateistruktur
{: #file-structure }
Das Ergebnis der Adaptererstellung ist ein Maven-Projekt mit einem Ordner **src** und einer Datei **pom.xml**: 

![mvn-adapter](adapter-fs.png)

## Adapter erstellen und implementieren
{: #build-and-deploy-adapters }

### Build erstellen
{: #build }

* Verwenden Sie die **{{ site.data.keys.mf_cli }}**, um im Projektstammverzeichnis den Befehl `adapter build` auszuführen. 
    
  ```bash
  mfpdev adapter build
  ```
    
* **Maven**: Jedes Mal, wenn Sie den Befehl `install` ausführen, um das Maven-Projekt zu ersgtellen, wird ein Adapterbuild erstellt. 

  ```bash
  mvn install
  ```

### Alle Builds erstellen
{: #build-all }
Wenn es in einem Dateisystemordner mehrere Adapter gibt, können Sie wie folgt einen Build für alle diese Adapter erstellen: 

```bash
mfpdev adapter build all
```

Das Ergebnis ist eine Archivdatei **.adapter** im Ordner **target** jedes Adapters: 

![java-adapter-result](adapter-result.png)

### Implementierung
{: #deploy }

1. Die Datei **pom.xml** enthält die folgenden Eigenschaften (`properties`):

   ```xml
   <properties>
    	<!-- parameters for deploy mfpf adapter -->
    	<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    	<mfpfUser>admin</mfpfUser>
    	<mfpfPassword>admin</mfpfPassword>
    	<mfpfRuntime>mfp</mfpfRuntime>
   </properties>
   ```
   
   * Ersetzen Sie **localhost:9080** durch die IP-Adresse und die Portnummer Ihres {{ site.data.keys.mf_server }}. 
   * Ersetzen Sie die Standardwerte **mfpfUser** und **mfpfPassword** durch Ihren Administratorbenutzernamen und Ihr Administratorkennwort (**optional**). 
   * Ersetzen Sie den Standardwert **mfpfRuntime** durch Ihren Laufzeitnamen (**optional**). 
2. Führen Sie den Implementierungsbefehl im Projektstammverzeichnis aus. 
 * **{{ site.data.keys.mf_cli }}**:

   ```bash
   mfpdev adapter deploy -x
   ```
   
   Mit der Option `-x` wird der Adapter in dem {{ site.data.keys.mf_server }} implementiert, der in der Datei **pom.xml** des Adapters angegeben ist.
  
   Wenn die Option nicht angegeben ist, verwendet die CLI den in den CLI-Einstellungen angegebenen Standardserver. 
    
   > Weitere CLI-Implementierungsoptionen können Sie mit dem Befehl
`mfpdev help adapter deploy` abrufen.
   
 * **Maven**:

   ```bash
   mvn adapter:deploy
   ```

### Alle implementieren
{:# deploy-all }
Wenn es in einem Dateisystemordner mehrere Adapter gibt, können Sie wie folgt alle diese Adapter implementieren: 

```bash
mfpdev adapter deploy all
```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können den Adapter auch mit nur einem Befehl `mvn install adapter:deploy` erstellen und implementieren.

### Implementierung in verschiedenen Laufzeiten
{: #deploying-to-different-runtimes }
Wenn Sie mehrere Laufzeiten verwenden, lesen Sie die Informationen unter
[In verschiedenen Laufzeiten Anwendungen registrieren und Adapter implementieren](../../installation-configuration/production/server-configuration/#registering-applications-and-deploying-adapters-to-different-runtimes).

## Abhängigkeiten
{: #dependencies }
Folgen Sie einer der folgenden Empfehlungen, wenn Sie in Ihrem Adapter eine externe Bibliothek verwenden möchten. 

#### Lokale Abhängigkeit hinzufügen
{: #adding-a-local-dependency }

1. Fügen Sie im Stammverzeichnis des Maven-Projekts einen Ordner **lib** hinzu und stellen Sie die externe Bibliothek in diesen Ordner. 
2. Fügen Sie in der Datei **pom.xml** des Maven-Projekts im Element `dependencies` den Bibliothekspfad hinzu.   

Beispiel: 

```xml
<dependency>
<groupId>sample</groupId>
<artifactId>com.sample</artifactId>
<version>1.0</version>
<scope>system</scope>
<systemPath>${project.basedir}/lib/</systemPath>
</dependency>
```

#### Externe Abhängigkeit hinzufügen
{: #adding-an-external-dependency }

1. Durchsuchen Sie Onlinerepositorys, z. B. das [Central Repository](http://search.maven.org/), nach der Abhängigkeit. 
2. Kopieren Sie die POM-Abhängigkeitsinformationen und fügen Sie sie in der Datei **pom.xml** des Maven-Projekts im Element `dependencies` ein. 

Im folgenden Beispiel wird die Artefakt-ID `cloudant-client` verwendet:

```xml
<dependency>
  <groupId>com.cloudant</groupId>
  <artifactId>cloudant-client</artifactId>
  <version>1.2.3</version>
</dependency>
```

> Weitere Informationen zu Abhängigkeiten finden Sie in der Maven-Dokumentation.

## Adapter in einem Maven-Projekt zusammenfassen
{: #grouping-adapters-in-a-single-maven-project }

Wenn Ihr Projekt mehrere Adapter enthält, können Sie sie in nur einem Maven-Projekt zusammenfassen. Durch das Zusammenfassen von Adaptern ergeben sich Vorteile. Sie können dann beispielsweise in einem Schritt
alle Adapterbuilds erstellen, alle Adapter implementieren und Abhängigkeiten gemeinsam nutzen. Die Erstellung aller Adapterbuilds und die Implementierung aller Adapter mit den CLI-Befehlen
`mfpdev adapter build all` und
`mfpdev adapter deploy all` sind auch möglich, wenn die Adapter nicht in einem Maven-Projekt zusammengefasst sind. 

Für die Zusammenfassung von Adaptern sind folgende Schritte erforderlich: 

1. Erstellen Sie einen Stammordner und nennen Sie ihn beispielsweise "GroupAdapters".
2. Stellen Sie die Maven-Adapterprojekte in den Ordner. 
3. Erstellen Sie eine Datei **pom.xml**. 

   ```xml
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    	<modelVersion>4.0.0</modelVersion>
    	<groupId>com.sample</groupId>
    	<artifactId>GroupAdapters</artifactId>
    	<version>1.0-SNAPSHOT</version>
    	<packaging>pom</packaging>

    	<modules>
				<module>Adapter1</module>
				<module>Adapter2</module>
    	</modules>

    	<properties>
    		<!-- parameters for deploy mfpf adapter -->
    		<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    		<mfpfUser>admin</mfpfUser>
    		<mfpfPassword>admin</mfpfPassword>
        <mfpfRuntime>mfp</mfpfRuntime>
    	</properties>

   <build>
        <plugins>
			<plugin>
				<groupId>com.ibm.mfp</groupId>
				<artifactId>adapter-maven-plugin</artifactId>
				<extensions>true</extensions>
			</plugin>
		</plugins>
   </build>

   </project>
   ```
   
  1. Definieren Sie ein Element **`groupId`** Ihrer Wahl. 
  2. Fügen Sie ein Element **`artifactId`** hinzu. Dies ist der Name des Stammverzeichnisses. 
  3. Fügen Sie für jeden Adapter ein Element **`module`** hinzu. 
  4. Fügen Sie das Element **`build`** hinzu. 
  5. Ersetzen Sie **localhost:9080** durch die IP-Adresse und die Portnummer Ihres {{ site.data.keys.mf_server }} (**optional**). 
  6. Ersetzen Sie die Standardwerte **`mfpfUser`** und **`mfpfPassword`** durch Ihren Administratorbenutzernamen und Ihr Administratorkennwort (**optional**). 
  7. Ersetzen Sie den Standardwert **`mfpfRuntime`** durch Ihren Laufzeitnamen (**optional**). 

4. Für die [Erstellung oder Implementierung](#build-and-deploy-adapters) aller Adapter müssen Sie die Maven-Befehle im Stammordner "GroupAdapters" des Projekts ausführen. 

## Adapter über die {{ site.data.keys.mf_console }} herunterladen oder implementieren
{: #downloading-or-deploying-adapters-using-mobilefirst-operations-console}

1. Öffnen Sie einen Browser Ihrer Wahl und laden Sie die {{ site.data.keys.mf_console }}. Verwenden Sie die
Adresse `http://<IP-Adresse>:<PORT>/mfpconsole/`.  
2. Klicken Sie neben "Adapter" auf die Schaltfläche "Neu". Sie haben zwei Möglichkeiten, einen Adapter zu erstellen: 
 * Sie können Maven oder die {{ site.data.keys.mf_cli }} wie oben beschrieben verwenden. 
 * Laden Sie ein Schablonenadapterprojekt herunter (Schritt 2). 
3. Erstellen Sie den Adapter mit Maven oder über die {{ site.data.keys.mf_cli }}.
4. Wählen Sie eine der folgenden Optionen für das Hochladen der generierten Datei **.adapter** aus, die Sie im Zielordner des Adapterprojekts finden: 
 * Klicken Sie auf die Schaltfläche "Adapter implementieren" (Schritt 5). 
 * Ziehen Sie die Datei mit der Maus in die Anzeige für die Erstellung eines neuen Adapters und legen Sie sie dort ab. 

    ![Adapter in der Konsole erstellen](Create_adapter_console.png)

5. Nach der erfolgreichen Implementierung des Adapters wird die Detailseite mit folgenden Registern angezeigt: 
 * Konfigurationen: In der Adapter-XML-Datei definierte Eigenschaften. Auf dieser Registerkarte können Sie die Konfigurationen ändern, ohne sie erneut implementieren zu müssen. 
 * Ressourcen: Liste der Adapterressourcen
 * Konfigurationsdateien: Adapterkonfigurationsdaten für DevOps-Umgebungen

## Maven-Adapterprojekt aktualisieren
{: #updating-the-adapter-maven-project }

Wenn Sie das Maven-Adapterprojekt auf den neuesten Releasestand bringen möchten,
benötigen Sie die **Versionsnummer** der API und der Plug-in-Artefakte
aus dem [Maven Central Repository](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation).
Suchen Sie nach "IBM MobileFirst Platform" und aktualisieren Sie die folgenden Eigenschaften in der Datei **pom.xml** des Maven-Adapterprojekts: 

1. Version von `adapter-maven-api`

   ```xml
   <dependency>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-api</artifactId>
      <scope>provided</scope>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
   </dependency>
   ```
   
2. Version von `adapter-maven-plugin`

   ```xml
   <plugin>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-plugin</artifactId>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
      <extensions>true</extensions>
   </plugin>
   ```

## Offline arbeiten
{: #working-offline }

Wenn Sie keinen Onlinezugriff auf das Maven Central Repository haben, können Sie Maven-Artefakte der
{{ site.data.keys.product }} über das interne Repository Ihrer Organisation
gemeinsam nutzen. 

1. [Rufen Sie die Seite 'Downloads' auf]({{site.baseurl}}/downloads/) und laden Sie
das Installationsprogramm für das {{ site.data.keys.mf_dev_kit_full }} herunter. 
2. Starten Sie {{ site.data.keys.mf_server }} und laden Sie in einem Browser die
{{ site.data.keys.mf_console }} mit folgender
URL:
`http://<Ihr_Serverhost:Serverport>/mfpconsole`.
3. Klicken Sie auf **Download-Center**. Klicken Sie unter **Tools → Adapterarchetypen** auf
**Herunterladen**. Das Archiv **mfp-maven-central-artifacts-adapter.zip** wird
heruntergeladen. 
4. Fügen Sie die Adapterarchetypen und Sicherheitsüberprüfungen zum internen Maven-Repository hinzu. Führen Sie dazu das Script **install.sh** (für Linux und Mac) oder das Script **install.bat** (für Windows) aus. 
5. Die folgenden JAR-Dateien sind für adapter-maven-api erforderlich. Sie müssen sich im lokalen Ordner **.m2** des Entwicklers oder im Maven-Repository Ihrer Organisation befinden. Sie können sie aus dem Central Repository herunterladen. 
    * javax.ws.rs:javax.ws.rs-api:2.0
    * javax:javaee-web-api:6.0
    * org.apache.httpcomponents:httpclient:4.3.4
    * org.apache.httpcomponents:httpcore:4.3.2
    * commons-logging:commons-logging:1.1.3
    * javax.xml:jaxp-api:1.4.2
    * org.mozilla:rhino:1.7.7
    * io.swagger:swagger-annotations:1.5.6
    * com.ibm.websphere.appserver.api:com.ibm.websphere.appserver.api.json:1.0
    * javax.servlet:javax.servlet-api:3.0.1

## Nächste Lernprogramme
{: #tutorials-to-follow-next }

* [Informationen zu Java-Adaptern](../java-adapters/)
* [Informationen zu JavaScript-Adaptern](../javascript-adapters/)
* [Adapter in IDEs entwickeln](../developing-adapters/)
* [Adapter testen und debuggen](../testing-and-debugging-adapters/)
* [Alle Adapterlernprogramme durcharbeiten](../#tutorials-to-follow-next)
