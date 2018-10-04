---
layout: tutorial
title: IBM Installation Manager für Aktualisierungen ausführen
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Installation Manager im Grafikmodus ausführen
{: #graphical-mode}

* Verwenden Sie für die Ausführung des Installation Manager den Benutzeraccount, der für die Erstinstallation verwendet wurde.
  Für die Anwendung eines Updates muss Installation Manager mit der bei der Erstintallation verwendeten Liste von Registry-Dateien ausgeführt werden. In diesen Registry-Dateien sind die Liste der installierten Software und die während der Installation verwendeten Optionen gespeichert. Wenn Sie den Installation Manager im Administratormodus ausführen, werden die Registry-Dateien auf Systemebene installiert (im Ordner `/var` unter UNIX oder Linux und im Ordner `c:\ProgramData` uner Windows). Die Position ist unabhängig von dem Benutzer, der den Installation Manager ausführt (obwohl unter UNIX und Linux Rootberechtigung erforderlich ist). Wenn Sie den Installation Manager dagegen im Einzelbenutzermodus ausführen, werden die Registry-Dateien standardmäßig im Ausgangsverzeichnis des Benutzers gespeichert. 

* Wählen Sie **Datei > Benutzervorgaben** aus.
  Falls Sie IBM MobileFirst Platform Foundation Version 8.0.0 aktualisieren (d. h. ein Fixpack oder einen vorläufigen Fix anwenden) möchten, wird das Produktrepository nicht benötigt.

* Klicken Sie auf **OK**, um die Anzeige **Benutzervorgaben** zu schließen.

* Klicken Sie auf **Aktualisieren** und wählen Sie das Paket aus, das aktualisiert werden muss. Der Installation Manager zeigt eine Liste mit Paketen an. Standardmäßig hat das zu aktualisierende Paket den Namen "IBM MobileFirst Platform Server".

* Akzeptieren Sie die Lizenzbedingungen und klicken Sie auf **Weiter**.

* Klicken Sie in der Anzeige **Thank You** auf **Weiter**. Eine Zusammenfassung wird angezeigt. 

* Klicken Sie auf **Aktualisieren**, um mit der Updateprozedur zu beginnen.

## Installation Manager im Befehlszeilenmodus ausführen
{: #cli-mode}

1. Laden Sie [hier](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip) die Dateien für eine unbeaufsichtigte Installation herunter.

2. Entpacken Sie die Datei und wählen Sie die Datei `8.0/upgrade-initially-mfpserver.xml` aus.
  - Wenn Sie bei der Erstinstallation Version 6.0.0, 6.1.0 oder 6.2.0 des Produkts installiert haben, wählen Sie stattdessen die Datei `8.0/upgrade-initially-worklightv6.xml` aus.
  - Wenn Sie bei der Erstinstallation Version 5.x des Produkts installiert haben, wählen Sie stattdessen die Datei `8.0/upgrade-initially-worklightv5.xml` aus. Die Datei enthält die Profilidentität des Produkts. Der Standardwert dieser Identität ändert sich einem Produktrelease zum anderen. In Version 5.x ist die Identität "Worklight". In den Versionen 6.0.0, 6.1.0 und 6.2.0 ist die Identität "IBM Worklight". In den Versionen 6.3.0, 7.0.0, 7.1.0 und 8.0.0 ist die Identität "IBM MobileFirst Platform Server".

3. Erstelen Sie eine Kopie der ausgewählten Datei.

4. Öffnen Sie die kopierte XML-Datei in einem Text- oder XML-Editor. Mdifizieren Sie die folgenden Elemente:

   a. Das Repositoryelement, das die Repositoryliste definiert. Da Sie IBM MobileFirst Platform Foundation Version 8.0.0 aktualisieren (d. h. ein Fixpack oder einen vorläufigen Fix anwenden), wird das Produktrepository nicht benötigt.

   b. **Optional:** Aktualisieren Sie die Kennwörter für die Datenbank und den Anwendungsserver.
      Wenn das Application Center bei der Erstinstallation mit dem Installation Manager installiert wurde und das Kennwort für die Datenbank oder den Anwendungsserver geändert wurde, können Sie den Wert in der XML-Datei modifizieren. Mithilfe dieser Kennwörter wird geprüft, ob die Datenbank die richtige Schemaversion verwendet. Falls es eine Vorversion von Version 8.0.0 ist, wird ein Upgrade durchgeführt. Die Kennwörter werden auch verwendet, um **wsadmin** für eine Installation des Application Center in WebSphere Application Server Full Profile auszuführen. Entfernen Sie das Kommentarzeichen in den entsprechenden Zeilen der XML-Datei:
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. Wenn Sie sich bisher noch nicht entschieden haben, die mit einem vorläufigen Fix vom 15. September 2015 freigegebene Tokenlizenzierung zu aktivieren, entfernen Sie das Kommentarzeichen in der Zeile `<data key=’user.licensed.by.tokens’ value=’false’/>`. Setzen Sie die Eigenschaft auf **true**, wenn Sie über einen Vertrag zur Verwendung der Tokenlizenzierung mit dem Rational License Key Server verfügen. Übenehmen Sie anderfalls den Wert **false**.
      Wenn Sie die Tokenlizenzierung aktivieren, muss Rational License Key Server konfiguriert sein. Außerdem benötigen Sie genug Token für die Ausführung von MobileFirst Server und die vom Server bereitgestellten Anwendungen. Andernfalls können Sie die MobileFirst-Server-Verwaltungsanwendung und die Laufzeitumgebung nicht ausführen.
      > **Einschränkung:** Eine einmal getroffene Entscheidung, die Tokenlizenzierung zu verwenden oder nicht zu verwenden, kann revidiert werden. Wenn Sie ein Upgrade mit dem Wert **true** durchführen und später ein anderes Upgrade mit dem Wert **false**, schlägt das zweite Upgrade fehl.

    d. Überprüfen Sie die Profilidentität und die Installationsposition. Die beiden folgenden Angaben müssen der Installation entsprechen:
      * `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Mit dem folgenden Befehl können Sie die Profilidentität und die Installationsverzeichnise überprüfen, die dem Installation Manager bekannt sind:
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. Aktualisieren Sie das Versionsattribut. Setzen Sie es auf die Version des vorläufigen Fix.
       Wenn Sie beispielsweise den vorläufigen Fix 8.0.0.0-MFPF-IF20171006-1725 installieren, müssen Sie die folgende Zeile ersetzen:

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Ersetzen Sie sie durch diese Zeile

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Der Installation Manager verwendet nicht nur die in der Installationsdatei aufgelisteten Repositorys, sondern auch die in seinen Vorgaben definierten Repositorys. Die Angabe des Versionsattributs im Element "offering" ist optional. Wenn Sie das Attribut angeben, stellen Sie jedoch sicher, dass die Version des definierten vorläufigen Fix diejenige ist, die Sie installieren möchten. Diese Angabe setzt die anderen, in den Vorgaben des Installation Manager aufgelisteten Repositorys mit vorläufigen Fixes außer Kraft. 

5. Öffnen Sie eine Sitzung mit dem Benutzeraccount, der für die Erstinstallation verwendet wurde.
    Für die Anwendung eines Updates muss Installation Manager mit der bei der Erstintallation verwendeten Liste von Registry-Dateien ausgeführt werden. In diesen Registry-Dateien sind die Liste der installierten Software und die während der Installation verwendeten Optionen gespeichert. Wenn Sie den Installation Manager im Administratormodus ausführen, werden die Registry-Dateien auf Systemebene installiert (im Ordner `/var` unter UNIX oder Linux und im Ordner `c:\ProgramData` uner Windows). Die Position ist unabhängig von dem Benutzer, der den Installation Manager ausführt (obwohl unter UNIX und Linux Rootberechtigung erforderlich ist). Wenn Sie den Installation Manager dagegen im Einzelbenutzermodus ausführen, werden die Registry-Dateien standardmäßig im Ausgangsverzeichnis des Benutzers gespeichert. 

6. Führen Sie den folgenden Befehl aus:
  ```bash
   installation_manager_path/eclipse/tools/imcl input <Antwortdatei> -log /tmp/installwl.log -acceptLicense
  ```
   Für diesen Befehl gilt Folgendes:
   * <Antwortdatei> ist die XML-Datei, die Sie in Schritt 4 bearbeitet haben.
   * *-log /tmp/installwl.log* ist optional. Es ist die Angabe einer Protokolldatei für die Ausgabe des Installation Manager.
   * *-acceptLicense* ist obligatorisch. Es bedeutet, Sie akzeptieren die Lizenzbedingungen für IBM MobileFirst Platform Foundation Version 8.0.0. Ohne diese Option kann der Installation Manager die Aktualisierung nicht fortsetzen.

## Nächste Schritte
{: #next-steps }

[Anwendungsserver aktualisieren](../appserver-update)
