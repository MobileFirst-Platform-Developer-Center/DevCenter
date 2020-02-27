---
layout: tutorial
title: MobileFirst Server aktualisieren
breadcrumb_title: MobileFirst Server aktualisieren
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die IBM MobileFirst Platform Foundation stellt mehrere Komponenten bereit, die Sie möglicherweise installiert haben. 

Nachfolgend ist beschrieben, wovon eine Aktualisierung der Komponenten abhängig ist:

### MobileFirst-Server-Verwaltungsservice, MobileFirst Operations Console und MobileFirst-Laufzeitumgebung
{: #server-console }

Diese drei Komponenten bilden den MobileFirst Server. Sie müssen zusammen aktualisiert werden. 

### Application Center
{: #appenter}

Die Installation dieser Komponente ist optional. Diese Komponente ist von den anderen Komponenten unabhängig. Wenn es notwendig ist, kann sie mit einem anderen iFix-Stand (vorläufige Fixes) als die anderen Komponenten ausgeführt werden. 

### MobileFirst Operational Analytics
{: #analytics}

Die Installation dieser Komponente ist optional. Die MobileFirst-Komponenten senden Daten über eine REST-API an MobileFirst Operational Analytics. Sie sollten MobileFirst Operational Analytics bevorzugt mit demselben iFix-Stand (vorläufige Fixes) wie die anderen Komponenten von MobileFirst Server ausführen. 


## MobileFirst-Server-Verwaltungsservice, MobileFirst Operations Console und MobileFirst-Laufzeitumgebung aktualisieren
{: #updating-server}

Für die Aktualisierung dieser Komponenten haben Sie zwei Optionen: 
* Server Configuration Tool
* Ant-Tasks

Die Aktualisierungsprozedur richtet sich nach der Methode, die Sie bei der Erstinstallation angewendet haben. 

>**Hinweis:** Es wird empfohlen, das vorhandene MFP-Installationsverzeichnis zu sichern, bevor Sie MobileFirst Server aktualisieren.
> Für die Sicherung dieser Dateien ist keine spezielles Vorgehen erforderlich. Sie müssen lediglich sicherstellen, dass Sie MobileFirst Server gestoppt haben. Andernfalls könnten sich Daten während der Sicherung ändern, was bedeuten würde, dass Speicher abgelegte Daten nicht in das Dateisystem
geschrieben werden würden. Stoppen Sie MobileFirst Server vor Beginn der Sicherung, um inkonsistente Daten zu vermeiden. 
>
MFP unterstützt nicht das Rückgängigmachen einer Aktualisierung bzw. eines vorläufigen Fix mit Installation Manager(IM). Mit Ant-Tasks oder dem Server Configuration Tool ist dies jedoch möglich, sofern Sie die vor der Aktualisierung gesicherten MFP-WAR-Dateien verwenden. 
>

<!-- **Note:** Installation Manager(IM) does not support rolling back of an update/iFix. However, rollback is possible using Ant or Server Configuration Tool, if you have the old war files. -->

### Fixpack mit dem Server Configuration Tool anwenden
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Wenn {{ site.data.keys.mf_server }} mit dem Server Configuration Tool installiert wurde und Sie die
Konfigurationsdatei aufbewahrt haben,
können Sie beim Anwenden eines Fixpacks oder eines vorläufigen Fix die Konfigurationsdatei wiederverwenden. 

1. Starten Sie das Server Configuration Tool.
    * Nutzen Sie unter Linux den Direktaufruf **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Klicken Sie unter Windows auf **Start → Programme → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Öffnen Sie unter macOS eine Shell-Konsole. Navigieren Sie zu **MFP-Server-Installationsverzeichnis/shortcuts** und geben Sie **./configuration-tool.sh** ein.
    * **MFP-Server-Installationsverzeichnis** ist das Verzeichnis, in dem Sie {{ site.data.keys.mf_server }} installiert haben.

2. Klicken Sie auf **Configurations → Replace the deployed WAR files** und wählen Sie eine vorhandene Konfiguration aus, um das Fixpack oder einen vorläufigen Fix anzuwenden.

### Fixpack mit dem Server Configuration Tool rückgängig machen
{: #rollback-a-fix-pack-by-using-the-server-configuration-tool }

Wenn {{ site.data.keys.mf_server }} mit dem Server Configuration Tool installiert wurde und Sie die
Konfigurationsdatei aufbewahrt haben, können Sie die Konfigurationsdatei wiederverwenden, um ein Fixpack oder einen vorläufigen Fix rückgängig zu machen. 

1.  Starten Sie das Server Configuration Tool.
    * Ersetzen Sie die MFP-WAR-Dateien manuell, indem Sie sie von der gesicherten Position des MFP-Installationsverzeichnisses kopieren (`MFP-Server-Installationsverzeichnis/MobileFirstServer`).
    * Nutzen Sie unter Linux den Direktaufruf **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Klicken Sie unter Windows auf **Start → Programme → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Öffnen Sie unter Mac OS eine Shell-Konsole. Wechseln Sie in das Verzeichnis `MFP-Server-Installationsverzeichnis/shortcuts` und geben Sie `./configuration-tool.sh` ein.
    * `MFP-Server-Installationsverzeichnis` ist das Verzeichnis, in dem Sie {{ site.data.keys.mf_server }} installiert haben.

2.  Wählen Sie die Konfiguration aus, für die ein Rollback durchgeführt werden muss. Klicken Sie auf **Configurations** und wählen Sie die Option **Edit and redeploy configuration** aus.

3.  Klicken Sie bis zum Ende auf jeder Seite auf **Next**. Klicke Sie schließlich auf **Update**.


### Fixpack mit Ant-Dateien anwenden
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Aktualisierung mit der Ant-Beispieldatei
{: #updating-with-the-sample-ant-file }
Wenn Sie eine der Ant-Beispieldateien aus dem Verzeichnis
**MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples**
für die Installation von {{ site.data.keys.mf_server }} verwendet haben, können Sie eine
Kopie dieser Ant-Datei für die Anwendung eines Fixpacks nutzen. Als Kennwort können Sie
12 Sterne (\*) anstelle des tatsächlichen Wertes angeben. Sie werden dann zur Eingabe des Kennworts aufgefordert, wenn die Ant-Datei
ausgeführt wird. 

1. Überprüfen Sie den Wert der Eigenschaft **mfp.server.install.dir** in der Ant-Datei. Er muss auf das Verzeichnis zeigen, das das Produkt mit dem angewendeten Fixpack enthält. Aus diesem Verzeichnis werden
die aktualisierten MobileFirst-Server-WAR-Dateien
verwendet. 
2. Führen Sie den Befehl `MFP-Installationsverzeichnis/shortcuts/ant -f Ihre_Ant-Datei update` aus. 

#### Aktualisierung mit eigener Ant-Datei
{: #updating-with-own-ant-file }
Wenn Sie Ihre eigene Ant-Datei verwenden, muss sie für alle Installations-Tasks
(**installmobilefirstadmin**, **installmobilefirstruntime** und
**installmobilefirstpush**) eine entsprechende Aktualisierungs-Task mit den gleichen Parametern enthalten. Die zugehörigen Aktualisierungs-Tasks
sind **updatemobilefirstadmin**, **updatemobilefirstruntime** und
**updatemobilefirstpush**. 

1. Überprüfen Sie den Klassenpfad des Elements **taskdef** für die Datei
**mfp-ant-deployer.jar**. Der Pfad muss auf die Datei
**mfp-ant-deployer.jar** einer MobileFirst-Server-Installation mit angewendetem Fixpack
zeigen. Die aktualisierten MobileFirst-Server-WAR-Dateien werden standardmäßig von der Position der Datei
**mfp-ant-deployer.jar** verwendet.
2. Führen Sie die Aktualisierungs-Tasks (**updatemobilefirstadmin**,
**updatemobilefirstruntime** und **updatemobilefirstpush**) in Ihrer Ant-Datei aus. 

### Fixpack mit Ant-Dateien rückgängig machen
{: #rollback-a-fix-pack-by-using-the-ant-files }

#### Rollback mit der Ant-Beispieldatei
{: #rollback-with-the-sample-ant-file }

Wenn Sie eine der Ant-Beispieldateien aus dem Verzeichnis
`MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples`
für die Installation von {{ site.data.keys.mf_server }} verwendet haben, können Sie eine
Kopie dieser Ant-Datei nutzen, um die Anwendung eines Fixpacks rückgängig zu machen. Als Kennwort können Sie
12 Sterne (`*`) anstelle des tatsächlichen Wertes angeben. Sie werden dann zur Eingabe des Kennworts aufgefordert, wenn die Ant-Datei
ausgeführt wird. 

1.  Ersetzen Sie die MFP-WAR-Dateien manuell, indem Sie sie von der gesicherten Position des MFP-Installationsverzeichnisses kopieren (`MFP-Server-Installationsverzeichnis/MobileFirstServer`).
2.  Überprüfen Sie den Wert der Eigenschaft **mfp.server.install.dir** in der Ant-Datei. Aus diesem Verzeichnis werden die aktualisierten MobileFirst-Server-WAR-Dateien verwendet.
3.  Führen Sie den folgenden Befehl aus:
    ```bash
    MFP-Installationsverzeichnis/shortcuts/ant -f <Ihre_Ant-Datei update>
    ```

#### Rollback mit eigener Ant-Datei
{: #rollback-with-own-ant-file }

Wenn Sie Ihre eigene Ant-Datei verwenden, muss sie für alle Aktualisierungs- bzw. Rollback-Tasks
(*installmobilefirstadmin*, *installmobilefirstruntime* und
*installmobilefirstpush*) eine entsprechende Aktualisierungs-Task mit den gleichen Parametern enthalten. Die zugehörigen Aktualisierungs-Tasks
sind *updatemobilefirstadmin*, *updatemobilefirstruntime* und
*updatemobilefirstpush*. 

1.  Ersetzen Sie die MFP-WAR-Dateien manuell, indem Sie sie von der gesicherten Position des MFP-Installationsverzeichnisses kopieren (`MFP-Server-Installationsverzeichnis/MobileFirstServer`).
2.  Überprüfen Sie den Klassenpfad des Elements **taskdef** für die Datei
`mfp-ant-deployer.jar`. Der Pfad muss auf die Datei mfp-ant-deployer.jar einer MobileFirst-Server-Installation mit angewendetem Fixpack
zeigen. Die aktualisierten MobileFirst-Server-WAR-Dateien werden standardmäßig von der Position der Datei mfp-ant-deployer.jar verwendet.
3.  Führen Sie die Aktualisierungs-Tasks (*updatemobilefirstadmin*,
*updatemobilefirstruntime* und *updatemobilefirstpush*) in Ihrer Ant-Datei aus.
