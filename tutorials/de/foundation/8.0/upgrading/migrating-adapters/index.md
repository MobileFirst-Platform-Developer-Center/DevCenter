---
layout: tutorial
title: Vorhandene Adapter auf MobileFirst Server Version 8.0.0 umstellen
breadcrumb_title: Vorhandene Adapter migrieren
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Ab {{ site.data.keys.mf_server }} Version 8.0 sind Adapter
Maven-Projekte. Hier erfahren Sie, wie ein Upgrade für in früheren Versionen von
{{ site.data.keys.mf_server }} entwickelte Adapter durchgeführt wird. 

Hier sind die Migrationsschritte beschrieben, die für Adapter ausgeführt werden müssen, die für
MobileFirst Server ab Version 6.2 entwickelt wurden,
damit diese auch in {{ site.data.keys.mf_server }} Version 8.0 funktionieren.   
Sehen Sie sich zunächst die Änderungen an den Adapter-APIs an (siehe
[Nicht mehr verwendete Features und API-Elemente
sowie Änderungen der serverseitigen API in Version 8.0](../../product-overview/release-notes/deprecated-discontinued/)). 

* Unter bestimmten Bedingungen funktionieren Adapter ohne Änderung mit
{{ site.data.keys.mf_server }} Version 8.0 (siehe
[Ältere Adapter unverändert in {{ site.data.keys.mf_server }} Version 8.0 verwenden](#using-older-adapters-as-is-under-mobilefirst-server-v-80)). 
* In den meisten Fällen müssen Sie für die Adapter ein Upgrade durchführen. Lesen Sie für Java™-Adapter die Informationen unter
[Java-Adapter auf Maven-Projekte
in {{ site.data.keys.mf_server }} Version 8.0 umstellen](#migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80). Lesen Sie für JavaScript™-Adapter die Informationen unter
[JavaScript-Adapter auf Maven-Projekte
in {{ site.data.keys.mf_server }} Version 8.0 umstellen](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80). 

## Ältere Adapter unverändert in {{ site.data.keys.mf_server }} Version 8.0 verwenden
{: #using-older-adapters-as-is-under-mobilefirst-server-v-80 }
Ein vorhandener Adapter kann ohne Änderung in {{ site.data.keys.mf_server }} Version 8.0 implementiert werden,
solange sie nicht die folgenden Bedingungen erfüllen: 

| Adaptertyp | Bedingung| 
|--------------|-----------|
| Java| Verwendet die Schnittstelle PushAPI oder SecurityAPI| 
| JavaScript| {::nomarkdown}<ul><li>Wurde in IBM Worklight bis Version 6.2 erstellt</li><li>Verwendet einen anderen Verbindungstyp als HTTP oder SQL</li><li>Enthält Prozeduren mit securityTest-Anpassung</li><li>Enthält Prozeduren, die für die Verbindung zum Back-End die Benutzeridentität verwenden</li><li>Verwendet eine der folgenden APIs: <ul><li>WL.Device.*</li><li>WL.Geo.\*</li><li>WL.Server.readSingleJMSMessage</li><li>WL.Server.readAllJMSMessages</li><li>WL.Server.writeJMSMessage</li><li>WL.Server.requestReplyJMSMessage</li><li>WL.Server.getActiveUser</li><li>WL.Server.setActiveUser</li><li>WL.Server.getCurrentUserIdentity</li><li>WL.Server.getCurrentDeviceIdentity</li><li>WL.Server.createEventSource</li><li>WL.Server.createDefaultNotification</li><li>WL.Server.getUserNotificationSubscription</li><li>WL.Server.notifyAllDevices</li><li>WL.Server.notifyDeviceToken</li><li>WL.Server.notifyDeviceSubscription</li><li>WL.Server.sendMessage</li><li>WL.Server.createEventHandler</li><li>WL.Server.setEventHandlers</li><li>WL.Server.setApplicationContext</li><li>WL.Server.fetchNWBusinessObject</li><li>WL.Server.createNWBusinessObject</li><li>WL.Server.deleteNWBusinessObject</li><li>WL.Server.updateNWBusinessObject</li><li>WL.Server.getBeaconsAndTriggers</li><li>WL.Server.signSoapMessage</li><li>WL.Server.createSQLStatement</li></ul></li></ul>{:/} |

## Java-Adapter
auf Maven-Projekte in {{ site.data.keys.mf_server }} Version 8.0 umstellen
{: #migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80}
1. Erstellen Sie ein Adapter-Maven-Projekt mit dem Archetyp
**adapter-maven-archetype-java**. Wenn Sie den Parameter
**artifactId** setzen, verwenden Sie den Adapternamen. Für den Parameter **package** müssen Sie dasselbe Paket wie beim vorhandenen Java-Adapter verwenden. Weitere Informationen finden Sie unter
[Java-Adapter erstellen](../../adapters/creating-adapters).
2. Überschreiben Sie die Adapterdeskriptordatei (**adapter.xml**) im Ordner **src/main/adapter-resources** des neuen Adapterprojekts, das Sie in
Schritt 1 erstellt haben. Weitere Einzelheiten
zum Deskriptor finden Sie unter
[Deskriptordatei für Java-Adapter](../../adapters/java-adapters/#the-adapter-resources-folder).
3. Entfernen Sie alle Dateien aus dem Ordner **src/main/java** Ihres neuen Adapterprojekts. Kopieren Sie dann alle Java-Dateien aus dem Ordner
**src/** Ihres alten Java-Adapterprojekts. Behalten Sie die Ordnerstruktur bei. Kopieren Sie alle Nicht-Jva-Dateien des alten Adapters aus dem Ordner
**src** in den Ordner
**src/main/resources** des neuen Adapters. Das Verzeichnis **src/main/resources** ist standardmäßig nicht vorhanden. Wenn der Adapter
Nicht-Java-Dateien enthält, müssen Sie das Verzeichnis erstellen. Lesen Sie bezüglich der Änderungen an Java-Adpater-APIs
die Informationen unter
[Änderungen an der serverseitigen API in Version 8.0](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80).

   Die folgenden Diagramme veranschaulichen die Struktur von Adaptern bis Version
7.1 und von Maven-Adaptern ab Version 8.0.


   ```xml
├── adapters
    │   └── RSSAdapter
    │       ├── RSSAdapter.xml
    │       ├── lib
    │       └── src
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```
    
   Neue Struktur eines Java-Adapters:

   ```xml
├── pom.xml
    ├── src
    │   └── main
    │       ├── adapter-resources
    │       │   └── adapter.xml
    │       └── java
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```

4. Fügen Sie mit einem der folgenden Schritte alle nicht im Maven-Repository enthaltenen JAR-Dateien hinzu: 
    * Fügen Sie die JAR-Dateien zu einem lokalen Repository hinzu. Lesen Sie dazu
die Beschreibung
in der Veröffentlichung [Guide to installing third-party party JARs](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html).
Fügen Sie die Dateien dann zum Element
**dependencies** hinzu. 
    * Fügen Sie die JAR-Dateien unter Verwendung des Elements **systemPath** zum Element
"dependencies" hinzu. Weitere Informationen finden Sie unter
[Introduction
to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html).

## JavaScript-Adapter
auf Maven-Projekte in {{ site.data.keys.mf_server }} Version 8.0 umstellen
{: #migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80 }
1. Erstellen Sie ein Adapter-Maven-Projekt mit dem Archetyp
**adapter-maven-archetype-http** oder **adapter-maven-archetype-sql**. Wenn Sie den Parameter
**artifactId** setzen, verwenden Sie den Adapternamen. Weitere Informationen finden Sie unter
[JavaScript-Adapter erstellen](../../adapters/creating-adapters).
2. Überschreiben Sie die Adapterdeskriptordatei (**adapter.xml**) im Ordner **src/main/adapter-resources** des neuen Adapterprojekts, das Sie in
Schritt 1 erstellt haben. Einzelheiten
zum Deskriptor finden Sie unter
[Deskriptordatei für JavaScript-Adapter](../../adapters/javascript-adapters/#the-adapter-resources-folder).
3. Überschreiben Sie die JavaScript-Dateien im Ordner **src/main/adapter-resources/js** Ihres neuen Adapterprojekts. 
