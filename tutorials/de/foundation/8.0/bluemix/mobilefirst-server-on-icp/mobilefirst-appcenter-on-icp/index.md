---
layout: tutorial
title: MobileFirst Application Center in IBM Cloud Private einrichten
breadcrumb_title: Application Center on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das IBM {{ site.data.keys.mf_app_center }} kann als Store für Unternehmensanwendungen genutzt werden und bietet Teammitgliedern innerhalb einer Organisation die Möglichkeit des Informationsaustauschs. Das Konzept des {{ site.data.keys.mf_app_center_short }} ist mit dem des öffentlichen App Store von Apple oder des Play Store von Android vergleichbar, nur dass das Application Center ausschließlich zur privaten Nutzung innerhalb einer Organisation bestimmt ist. Mithilfe des {{ site.data.keys.mf_app_center_short }} können Benutzer innerhalb einer Organisation Anwendungen auf mobile Geräte herunterladen. Das Application Center dient dabei als Repository für mobile Anwendungen.
Weitere Informationen zum MobileFirst Application Center finden Sie in der [MobileFirst-Application-Center-Dokumentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/).


#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [IBM Passport-Advantage-Archiv mit dem {{ site.data.keys.mf_app_center }} herunterladen](#download-the-ibm-mac-ppa-archive)
* [IBM Passport-Advantage-Archiv mit dem {{ site.data.keys.mf_app_center }} in {{ site.data.keys.prod_icp }} laden](#load-the-ibm-mfpf-appcenter-ppa-archive)
* [Umgebungsvariablen für das {{ site.data.keys.mf_app_center }}](#env-mf-appcenter)
* [{{ site.data.keys.mf_app_center }} installieren und konfigurieren](#configure-install-mf-appcenter-helmcharts)
* [Installation überprüfen](#verify-install)
* [Zugriff auf das {{ site.data.keys.mf_app_center }}](#access-mf-appcenter-console)
* [Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases](#upgrading-mf-helm-charts)
* [Deinstallation](#uninstall)
* [Referenzinformationen](#references)

## Voraussetzungen
{: #prereqs}

Sie müssen über ein IBM Cloud-Private-Konto verfügen und den Kubernetes-Cluster gemäß der [Dokumentation in {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html) eingerichtet haben.

Sie benötigen eine vorkonfigurierte Datenbank, um MobileFirst-Application-Center-Charts in {{site.data.keys.prod_icp }} installieren und konfigurieren zu können. Beim Konfigurieren des MobileFirst-Application-Center-Charts müssen Sie die Datenbankinformationen angeben. Die für das {{ site.data.keys.mf_app_center }} erforderlichen Tabellen werden in dieser Datenbank erstellt. 

> Unterstützte Datenbanken: DB2

Für die Verwaltung von Containern und Images müssen Sie im Rahmen des IBM Cloud-Private-Setups die folgenden Tools auf Ihrer Hostmaschine installieren: 

* Docker
* IBM Cloud-CLI (`bx`)
* ICP-Plug-in ({{ site.data.keys.prod_icp }}) für die IBM Cloud-CLI ( `bx pr` )
* Kubernetes-CLI (`kubectl`)
* Helm (`helm`)

## IBM Passport-Advantage-Archiv mit dem {{ site.data.keys.mf_app_center }} herunterladen
{: #download-the-ibm-mac-ppa-archive}
Das Passport-Advantage-Archiv mit dem {{ site.data.keys.mf_app_center }} ist [hier]() verfügbar. Das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} enthält die Docker-Images und Helm-Charts für die folgenden Komponenten der {{ site.data.keys.product }}: 
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

Vorläufige Fixes für das {{ site.data.keys.mf_app_center }} können über [IBM Fix Central](http://www.ibm.com/support/fixcentral) abgerufen werden.<br/>

## IBM Passport-Advantage-Archiv mit dem {{ site.data.keys.mf_app_center }} in {{ site.data.keys.prod_icp }} laden
{: #load-the-ibm-mfpf-appcenter-ppa-archive}

Bevor Sie das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} laden, müssen Sie Docker einrichten. Anweisungen finden Sie [hier](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html).

Führen Sie die nachstehenden Schritte aus, um das Passport-Advantage-Archiv in den IBM Cloud-Private-Cluster zu laden:

  1. Melden Sie sich mit dem IBM Cloud-Private-Plug-in (`bx pr`) beim Cluster an.
      >Lesen Sie die [CLI-Befehlsreferenz](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html) in der Dokumentation zu {{ site.data.keys.prod_icp }}. 

      Beispiel: 
      ```bash
      bx pr login -a https://<IP-Adresse>:<Port>
      ```
      Falls Sie die SSL-Validierung übergehen möchten, können Sie im obigen Befehl die Option `--skip-ssl-validation` verwenden. Bei Verwendung dieser Option werden Sie zur Eingabe von `Benutzername` und `Kennwort` Ihres Clusterendpunkts aufgefordert. Fahren Sie nach erfolgreicher Anmeldung mit den nachstehenden Schritten fort. 

  2. Laden Sie mit folgendem Befehl das Passport-Advantage-Archiv mit der {{ site.data.keys.product }}: 
      ```
      bx pr load-ppa-archive --archive <Archivname> [--clustername <Clustername>] [--namespace <Namespace>]
      ```
      Der *Archivname* für die {{ site.data.keys.product }} ist der Name des Archivs, den Sie über IBM Passport Advantage heruntergeladen haben.

      Sie können `--clustername` ignorieren, wenn Sie den vorherigen Schritt ausgeführt und den Clusterendpunkt zum Standard für `bx pr` gemacht haben.

  3. Synchronisieren Sie nach dem Laden des Passport-Advantage-Archivs die Repositorys, um sicherzustellen, dass die Helm-Charts im **Katalog** aufgelistet werden. Diesen Schritt können Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} ausführen. <br/>
     * Wählen Sie **Admin > Repositories** aus.
     * Klicken Sie auf **Synch Repositories**.

  4.  Sie können die Docker-Images und Helm-Charts in der Managementkonsole von {{ site.data.keys.prod_icp }} anzeigen. <br/>
      Gehen Sie zum Anzeigen von Docker-Images wie folgt vor: 
      * Wählen Sie **Platform > Images** aus.
      * Helm-Charts werden im Katalog (**Catalog**) angezeigt.

  Nach Ausführung der obigen Schritte sehen Sie die hochgeladene Version der {{ site.data.keys.prod_adj }}-Helm-Charts im ICP-Katalog. Das {{ site.data.keys.mf_app_center }} erscheint im Katalog als **ibm-mfpf-appcenter-prod**. 

## Umgebungsvariablen für das {{ site.data.keys.mf_app_center }}
{: #env-mf-appcenter }
In der folgenden Tabelle sind die im {{ site.data.keys.mf_app_center }} in {{ site.data.keys.prod_icp }} verwendeten Umgebungsvariablen angegeben.

| Qualifikationsmerkmal | Parameter | Definition | Zulässiger Wert |
|-----------|-----------|------------|---------------|
| arch |  | Worker node architecture | Worker-Knotenarchitektur, in der dieses Chart implementiert werden soll. Derzeit wird nur die Plattform **AMD64** unterstützt. |
| image | pullPolicy | Richtlinie für Image-Übertragung per Pull-Operation | Standardeinstellung: **IfNotPresent** |
|  | name | Docker image name | Name des Docker-Image für das {{ site.data.keys.mf_app_center }} |
|  | tag | Docker image tag | Siehe [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| mobileFirstAppCenterConsole | user | Benutzername für die MobileFirst-Application-Center-Konsole |  |
|  | password | Kennwort für die MobileFirst-Application-Center-Konsole |  |
| existingDB2Details | appCenterDB2Host | IP-Adresse des DB2-Servers, auf dem die MobileFirst-Application-Center-Datenbank konfiguriert wird |  |
|  | appCenterDB2Port | Port der eingerichteten DB2-Datenbank |  |
|  | appCenterDB2Database | Name der zu verwendenden Datenbank | Die Datenbank muss zuvor erstellt worden sein. |
|  | appCenterDB2Username | DB2-Benutzername für den Zugriff auf die DB2-Datenbank | Der Benutzer sollte Zugriff haben, um Tabellen zu erstellen und ein Schema zu erstellen, falls es noch nicht vorhanden ist. |
|  | appCenterDB2Password | DB2-Kennwort für die angegebene Datenbank |  |
|  | appCenterDB2Schema | Zu erstellendes DB2-Schema für das {{ site.data.keys.mf_app_center_short }} |  |
|  | appCenterDB2ConnectionIsSSL | DB2-Verbindungstyp | Geben Sie an, ob Ihre Datenbankverbindung über **http** oder **https** erfolgen muss. Der Standardwert ist **false** (http). Stellen Sie sicher, dass der DB2-Port für denselben Verbindungsmodus konfiguriert ist. |
| keystores | keystoresSecretName | Unter [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren](../#configure-install-mf-helmcharts) sind die Schritte für die Erstellung des geheimen Schlüssels mit den Keystores und den zugehörigen Kennwörtern beschrieben. |  |
| resources | limits.cpu | Maximal zulässige CPU-Kapazität | Standardeinstellung: **1000m** <br/>Weitere Informationen finden Sie [hier](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Maximal zulässige Speicherkapazität | Standardeinstellung: **1024Mi** <br/>Weitere Informationen finden Sie [hier](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| resources.requests | requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder ein anderweitig für die Implementierung definierter Wert. | Standardeinstellung: **1000m** |
|  | requests.memory | Beschreibt die erforderliche Mindestspeicherkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder der für die Implementierung definierte Wert. | Standardeinstellung: **1024Mi** |

## {{ site.data.keys.mf_app_center }} installieren und konfigurieren
{: #configure-install-mf-appcenter-helmcharts}

Bevor Sie das {{ site.data.keys.mf_app_center }} installieren und konfigurieren, benötigen Sie Folgendes: 

* [**Obligatorisch**] eine konfigurierte und betriebsbereite DB2-Datenbank.
  Sie benötigen die Datenbankinformationen für die [Konfiguration des MobileFirst-Server-Helm-Charts](../#install-hmc-icp). {{site.data.keys.mf_server }} erfordert ein Schema und Tabellen, die in dieser Datenbank erstellt werden (falls sie nicht vorhanden sind).

* [**Optional**] einen geheimen Schlüssel mit Ihrem Keystore und Truststore.
  Sie können Ihren eigenen Keystore und Truststore für die Implementierung angeben, indem Sie mit Ihrem eigenen Keystore und Truststore einen geheimen Schlüssel erstellen.

  Führen Sie vor der Installation die folgenden Schritte aus:

  * Erstellen Sie mit den Dateien `keystore.jks`, `keystore-password.txt`, `truststore.jks`, `truststore-password.txt` einen geheimen Schlüssel und geben Sie im Feld *keystores.keystoresSecretName* den Namen des geheimen Schlüssels an.

  * Speichern Sie die Datei `keystore.jks` mit dem zugehörigen Kennwort in einer Datei mit dem Namen `keystore-password.txt` und die Datei `truststore.jks` mit dem zugehörigen Kennwort its password in einer Datei mit dem Namen `truststore-password.jks`.

  * Rufen Sie die Befehlszeile auf und führen Sie Folgendes aus: 
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**Hinweis:** Die Namen der Dateien sollten wie angegeben lauten, d. h. `keystore.jks`, `keystore-password.txt`, `truststore.jks` und `truststore-password.txt`.

  * Geben Sie den Namen des geheimen Schlüssels in *keystoresSecretName* an, um die Standard-Keystores außer Kraft zu setzen. 

  Weitere Informationen finden Sie unter [Keystore für MobileFirst Server konfigurieren]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).

Führen Sie die folgenden Schritte aus, um das IBM {{ site.data.keys.mf_app_center }} in der Managementkonsole von {{ site.data.keys.prod_icp }} zu installieren und zu konfigurieren. 

1. Navigieren Sie in der Managementkonsole zu **Catalog**. 
2. Wählen Sie das Helm-Chart **ibm-mfpf-appcenter-prod** aus. 
3. Klicken Sie auf **Configure**.
4. Geben Sie die Umgebungsvariablen an. Weitere Informationen finden Sie unter [Umgebungsvariablen für das {{ site.data.keys.mf_app_center }}](#env-mf-appcenter). 
5. Klicken Sie auf **Install**.

## Installation überprüfen
{: #verify-install}

Nachdem Sie {{ site.data.keys.mf_analytics }} (optional) und {{ site.data.keys.mf_server }} installiert und konfiguriert haben, können Sie wie folgt Ihre Installation und den Status der implementierten Pods überprüfen:

Wählen Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} **Workloads > Helm Releases** aus. Klicken Sie auf den *Releasenamen* für Ihre Installation. 

## Zugriff auf das {{site.data.keys.mf_app_center }}
{: #access-mf-appcenter-console}

Nach der erfolgreichen Installation des Helm-Charts für das MobileFirst Application Center können Sie in einem Browser mit `<Protokoll>://<externe_IP-Adresse>:<Port>/appcenterconsole` auf die MobileFirst-Application-Center-Konsole zugreifen.

Das Protokoll kann **http** oder **https** sein. Beachten Sie außerdem, dass der Port im Falle einer NodePort-Implementierung NodePort lautet. Führen Sie die folgenden Schritte aus, um die IP-Adresse und den NodePort Ihres installierten MobileFirst-Application-Center-Charts zu erhalten: 

1. Wählen Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} **Workloads > Helm Releases** aus.
2. Klicken Sie auf den *Releasenamen* für Ihre Helm-Chart-Installation. 
3. Lesen Sie die Informationen im Abschnitt **Notes**. 

> **Hinweis:** Für den Zugriff auf den mobilen MobileFirst-Application-Center-Client müssen Sie das Application-Center-Paket über Passport Advantage herunterladen. [Hier finden Sie weitere Informationen](http://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/appcenter/mobile-client/).

## Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases
{: #upgrading-mf-helm-charts}

Unter [Upgrading bundled products](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html) finden Sie Anweisungen zur Durchführung eines Upgrades für Helm-Charts bzw. Releases. 

### Beispielszenarien für Helm-Release-Upgrades

1. Für das Upgrade eines Helm-Release mit einer Änderung der Werte von `values.yaml` können Sie den Befehl `helm upgrade` mit der Option **--set** verwenden. Sie können die Option **-- set** mehrfach angeben. Priorität erhält die in der Befehlszeile ganz rechts angegebene Option "set". 
  ```bash
  helm upgrade --set <name>=<Wert> --set <name>=<Wert> <existing-helm-release-name> <Pfad_des_neuen_Helm-Charts>
  ```

2. Wenn Sie ein Upgrade für ein Helm-Release mit Angabe von Werten in einer Datei durchführen, verwenden Sie den Befehl `helm upgrade` mit der Option **-f**. Sie können die Option **--values** oder **-f** mehrfach verwenden. Priorität erhält die in der Befehlszeile ganz rechts angegebene Datei (Option "-f"). Wenn im folgenden Beispiel sowohl `myvalues.yaml` als auch `override.yaml` einen Schlüssel *Test* enthält, hat der in `override.yaml` festgelegte Wert Vorrang. 
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <Pfad_des_neuen_Helm-Charts>
  ```

3. Wenn Sie ein Uprade für ein Helm-Release durchführen und dabei die Werte des letzten Release wiederverwenden und einige der Werte überschreiben möchten, können Sie einen Befehl wie den folgenden verwenden: 
  ```bash
  helm upgrade --reuse-values --set <name>=<Wert> --set <name>=<Wert> <existing-helm-release-name> <Pfad_des_neuen_Helm-Charts>
  ```

## Deinstallation
{: #uninstall}
Verwenden Sie zum Deinstallieren des {{ site.data.keys.mf_app_center }} die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).
Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 
```bash
helm delete --purge <Releasename>
```
Hier steht *Releasename* für den implementierten Releasenamen des Helm-Charts. 

## Referenzinformationen
{: #references}

Weitere Informationen zum {{ site.data.keys.mf_app_center }} finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/appcenter/). 
