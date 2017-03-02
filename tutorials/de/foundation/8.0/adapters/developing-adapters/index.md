---
layout: tutorial
title: Adapter in Eclipse entwickeln
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Wie Sie aus den bisherigen [Adapterlernprogrammen](../) wissen, sind Adapter Maven-Projekte, die direkt
in Maven oder mithilfe der {{ site.data.keys.mf_cli }} erstellt werden. Der Adaptercode kann dann in jeder IDE bearbeitet werden. Später kann mit Maven oder mithilfe der {{ site.data.keys.mf_cli }} ein Adapterbuild erstellt und implementiert werden. Ein Entwickler kann Adapter auch in unterstützten IDEs wie Eclipse oder IntelliJ entwickeln, erstellen und implementieren. In diesem Lernprogramm wird ein Adapter in der Eclipse-IDE erstellt. 

> Anweisungen für die Nutzung von IntelliJ finden Sie im Blogbeitrag [Using IntelliJ to Develop MobileFirst Java Adapters]({{site.baseurl}}/blog/2016/03/31/using-intellij-to-develop-adapters).

**Voraussetzungen:**

* Gehen Sie zunächst die [Adapterlernprogramme](../) durch, um sich mit Adaptern vertraut zu machen. 
* Integration von Maven in Eclipse. Ab Eclipse Kepler (Version 4.3) ist Maven-Unterstützung in Eclipse integriert. Falls Ihre Eclipse-Instanz keine Unterstützung für Maven bietet,
folgen Sie den Anweisungen unter [M2Eclipse](http://www.eclipse.org/m2e/), um Maven-Unterstützung hinzuzufügen. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Neues Maven-Adapterprojekt erstellen](#creating-a-new-adapter-maven-project)
* [Vorhandenes Maven-Adapterprojekt importieren](#importing-an-existing-adapter-maven-project)
* [Maven-Adapterprojekt erstellen und implementieren](#building-and-deploying-an-adapter-maven-project)
* [Weiterführende Informationen](#further-reading)

## Maven-Adapterprojekt erstellen oder importieren
{: #create-or-import-an-adapter-maven-project }

Folgen Sie den nachstehenden Anweisungen, um ein neues Maven-Adapterprojekt zu erstellen oder ein vorhandenes zu importieren. 

### Neues Maven-Adapterprojekt erstellen
{: #creating-a-new-adapter-maven-project }

1. Wählen Sie für die Erstellung eines neuen Maven-Adapterprojekts **Datei → Neu → Andere... → Maven → Maven-Projekt** aus und
klicken Sie auf **Weiter**.

    ![Erstellung eines Maven-Adapterprojekts in Eclipse](new-maven-project.png)

2. Geben Sie den Projektnamen und die Projektposition an.   
    - Vergewissern Sie sich, dass die Option für die Erstellung eines einfachen Projekts **abgewählt** ist, und klicken Sie auf **Weiter**.

    ![Erstellung eines Maven-Adapterprojekts in Eclipse](select-project-name-and-location.png)

3. Wählen Sie den Archetyp aus oder fügen Sie ihn hinzu. 
    - Wenn Sie die [Archetypen lokal installiert haben](../creating-adapters/#install-maven) und sie nicht in der Liste der Archetypen angezeigt werden, wählen Sie **Konfigurieren → Lokalen Katalog hinzufügen → Durchsuchen** aus und navigieren Sie im Ausgangsverzeichnis zur Datei /.m2/repository/archetype-catalog.xml. 
    - Klicken Sie auf **Archetyp hinzufügen** und machen Sie die folgenden Angaben: 
        - **Gruppen-ID für Archetyp**: `com.ibm.mfp`
        - **Artefakt-ID für Archetyp**: `adapter-maven-archetype-java`, `adapter-maven-archetype-http` oder `adapter-maven-archetype-sql`
        - **Archetypversion**: `8.0.2016061011` (Die aktuell verfügbare Version finden Sie
in [Maven Central](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation).)

    ![Erstellung eines Maven-Adapterprojekts in Eclipse](create-an-archetype.png)

4. Geben Sie Maven-Projektparameter an.   
    - Geben Sie die erforderlichen Parameter
**Gruppen-ID**, **Artefakt-ID**, **Version** und **Paket** an und klicken
Sie auf **Fertigstellen**.

    ![Erstellung eines Maven-Adapterprojekts in Eclipse](project-parameters.png)

### Vorhandenes Maven-Adapterprojekt importieren
{: #importing-an-existing-adapter-maven-project }

Wählen Sie für den Import des Maven-Adapterprojekts **Datei → Importieren... → Maven → Vorhandene Maven-Projekte** aus.

![Import eines Maven-Adapterprojekts in Eclipse](import-adapter-maven-project.png)

## Maven-Adapterprojekt erstellen und implementieren
{: #building-and-deploying-an-adapter-maven-project }

Ein Adapterprojekt kann mit Befehlen in der Maven-Befehlszeile, mit der {{ site.data.keys.mf_cli }} oder in Eclipse erstellt und implementiert werden.   
[Hier erfahren Sie, wie Adapter erstellt und implementiert werden](../creating-adapters/#build-and-deploy-adapters).

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Eclipse kann auch erweitert werden,
um den Implementierungsschritt zu erleichtern.
Integrieren Sie dazu mit einem Plug-in ein **Befehlszeilenfenster**. Sie erhalten so eine konsistente Entwicklungsumgebung. In diesem Fenster können Maven-Befehle oder
Befehle der {{ site.data.keys.mf_cli }} ausgeführt werden.

### Adapterbuild erstellen
{: #building-an-adapter }

Klicken Sie zum Erstellen eines Adapterbuilds mit der rechten Maustaste auf den Adapterordner und wählen Sie
**Ausführen als → Maven-Installation** aus.  

### Adapter implementieren
{: #deploying-an-adapter }

Für die Implementierung eines Adapters müssen Sie zunächst den Maven-Implementierungsbefehl (deploy) hinzufügen. 

1. Wählen Sie **Ausführen → Konfigurationen ausführen...** aus, klicken Sie mit der rechten Maustaste auf
**Maven-Build** und wählen Sie **Neu** aus.
2. Geben Sie einen Namen an ("Maven deploy").
2. Geben Sie als Ziel "adapter:deploy" an.
3. Klicken Sie für eine Erstimplementierung auf **Anwenden** und dann auf **Ausführen**. 

Jetzt können Sie mit der rechten Maustaste auf den Adapterordner klicken und
**Ausführen als → Maven-Implementierung** auswählen.

### Adapter erstellen und implementieren
{: #building-and-deploying-an-adapter }

Sie können die Maven-Ziele "build" und "deploy" auch zu einem Ziel zusammenfassen: "clean install adapter:deploy".

## Weiterführende Informationen
{: #further-reading }

Informieren Sie sich im Lernprogramm [Adapter testen und debuggen](../testing-and-debugging-adapters) über das Debuggen von Java-Code in Adaptern. 
