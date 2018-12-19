---
layout: tutorial
title: Mobile Foundation mit Helm in einem IBM Cloud-Kubernetes-Cluster einrichten
breadcrumb_title: Foundation on Kubernetes Cluster using Helm
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um mit Helm-Charts eine MobileFirst-Server-Instanz und eine MobileFirst-Analytics-Instanz in einem IBM Cloud-Kubernetes-Cluster zu konfigurieren:

* Richten Sie einen IBM Cloud-Kubernetes-Cluster ein.
* Riden Sie Ihren Host-Computer mit der IBM Cloud-CLI ein.
* Laden Sie das Passport-Advantage-Archiv mit der {{ site.data.keys.product_full }} für {{ site.data.keys.prod_icp }} herunter.
* Laden Sie das PPA-Archiv in den IBM Cloud-Kubernetes-Cluster.
* Abschließend werden Sie {{ site.data.keys.mf_analytics }} (optional) und {{ site.data.keys.mf_server }} installieren und konfigurieren.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation herunterladen](#download-the-ibm-mfpf-ppa-archive)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation laden](#load-the-ibm-mfpf-ppa-archive)
* [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigrieren](#configure-install-mf-helmcharts)
* [Installation überprüfen](#verify-install)
* [Beispielanwendung](#sample-app)
* [Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases durchführen](#upgrading-mf-helm-charts)
* [Deinstallation](#uninstall)

## Voraussetzungen
{: #prereqs}

Sie müssen über ein IBM Cloud-Konto verfügen und den Kubernetes-Cluster wie unter [IBM Cloud Kubernetes Cluster service](https://console.bluemix.net/docs/containers/cs_tutorials.html) dokumentiert eingerichtet haben.

Für die Verwaltung von Containern und Images müssen Sie im Rahmen der Einrichtung der IBM Cloud-CLI-Plug-ins die folgenden Tools auf Ihrer Hostmaschine installieren: 

* IBM Cloud-CLI 
* Kubernetes-CLI
* IBM Cloud-Container-Registry-Plug-in
* IBM Cloud-Container-Service-Plug-in

Für den Zugruff auf den IBM Cloud-Kubernetes-Cluster über die CLI sollten Sie den IBM Cloud-Client konfigurieren. [Hier finden Sie weitere Informationen](https://console.bluemix.net/docs/cli/index.html).

## Passport-Advantage-Archiv mit der IBM Mobile Foundation herunterladen
{: #download-the-ibm-mfpf-ppa-archive}
Das Passport-Advantage-Archiv mit dem {{ site.data.keys.product_full }} ist [hier](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) verfügbar. Das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} enthält die Docker-Images und Helm-Charts für die folgenden Komponenten der {{ site.data.keys.product }}: 
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## Passport-Advantage-Archiv mit der IBM Mobile Foundation laden
{: #load-the-ibm-mfpf-ppa-archive}
Bevor Sie das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} laden, müssen Sie Docker einrichten. Anweisungen finden Sie [hier](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html).

Führen Sie die nachstehenden Schritte aus, um das Passport-Advantage-Archiv in den IBM Cloud-Kubernetes-Cluster zu laden:

  1. Melden Sie sich mit dem IBM Cloud-Plug-in beim Cluster an.

      Lesen Sie die [CLI-Befehlsreferenz](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) in der Dokumentation zur IBM Cloud-CLI.

      Beispiel:
      ```bash
      ibmcloud login -a https://IP-Adresse:Port
      ```
      Falls Sie die SSL-Validierung übergehen möchten, können Sie im obigen Befehl die Option `--skip-ssl-validation` verwenden. Bei Verwendung dieser Option werden Sie zur Eingabe von `Benutzername` und `Kennwort` Ihres Clusterendpunkts aufgefordert. Fahren Sie nach erfolgreicher Anmeldung mit den nachstehenden Schritten fort. 
      
  2. Melden Sie sich bei der IBM Cloud-Container-Registry an und initialisieren Sie den Containerservice mit folgenden Befehlen:
      ```bash
      ibmcloud cr login
      ibmcloud cs init
      ```  
  3. Definieren Sie die Implementierungsregion (z. B. us-south) mit folgendem Befehl:
      ```bash
      ibmcloud cr region-set
      ```    

  4. Laden Sie mit folgendem Befehl das Passport-Advantage-Archiv mit der {{ site.data.keys.product }}:
      ```
      bx pr load-ppa-archive --archive <Archivname> [--clustername <Clustername>] [--namespace <Namespace>]
      ```
      Der *Archivname* für die {{ site.data.keys.product }} ist der Name des Archivs, den Sie über IBM Passport Advantage heruntergeladen haben.


  Die Helm-Charts werden im Client oder lokal gespeichert (im Gegensatz zum Helm-Chart für ICP, das im Helm-Repository für IBM Cloud Private gespeichert wird). Die Charts finden Sie im Verzeichnis `ppa-import/charts`. 

## Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigrieren
{: #configure-install-mf-helmcharts}

Bevor Sie das {{ site.data.keys.mf_server }} installieren und konfigurieren, benötigen Sie Folgendes: 

* [**Obligatorisch**] eine konfigurierte und betriebsbereite DB2-Datenbank.
  Sie benötigen die Datenbankinformationen für die [Konfiguration des MobileFirst-Server-Helm-Charts](#install-hmc-icp). {{site.data.keys.mf_server }} erfordert ein Schema und Tabellen, die in dieser Datenbank erstellt werden (falls sie nicht vorhanden sind).

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

### Umgebungsvariablen für {{ site.data.keys.mf_analytics }}
{: #env-mf-analytics }
In der folgenden Tabelle sind die in {{ site.data.keys.mf_analytics }} in einen IBM Cloud-Kubernetes-Cluster verwendeten Umgebungsvariablen angegeben.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|-----------|-----------|------------|---------------|
|arch |  |Worker node architecture |Worker-Knotenarchitektur, in der dieses Chart implementiert werden soll. <br/>Derzeit wird nur die Plattform **AMD64** unterstützt. |
|image |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation |Standardeinstellung: **IfNotPresent** |
|  |tag |Docker image tag |Siehe [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  |name |Docker image name |Name des Docker-Image für {{ site.data.keys.prod_adj }} Operational Analytics |
|scaling |replicaCount |Anzahl der Instanzen (Pods) von {{ site.data.keys.prod_adj }} Operational Analytics, die erstellt werden müssen |Positive ganze Zahl<br/>Standardeinstellung: **2** |
|mobileFirstAnalyticsConsole |user |Benutzername für {{ site.data.keys.prod_adj }} Operational Analytics |Standardeinstellung: **admin** |
|  |password |Kennwort für {{ site.data.keys.prod_adj }} Operational Analytics |Standardeinstellung: **admin** |
|analyticsConfiguration |clusterName |Name des {{ site.data.keys.prod_adj }}-Analytics-Clusters |Standardeinstellung: **mobilefirst** |
|  |analyticsDataDirectory |Pfad für die Speicherung von Analytics-Daten. *Unter diesem Pfad wird auch die Forderung nach einem persistenten Datenträger innerhalb des Containers angehängt*. |Standardeinstellung: `/analyticsData` |
|  |numberOfShards |Anzahl der Elasticsearch-Shards für {{ site.data.keys.prod_adj }} Analytics |Positive ganze Zahl<br/>Standardeinstellung: **2** |
|  |replicasPerShard |Anzahl der Elasticsearch-Replikate, die pro Shard für {{site.data.keys.prod_adj }}  Analytics verwaltet werden sollen |Positive ganze Zahl<br/>Standardeinstellung: **2** |
|keystores |keystoresSecretName |Unter [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts) sind die Schritte für die Erstellung des geheimen Schlüssels mit den Keystores und den zugehörigen Kennwörtern beschrieben. |  |
|jndiConfigurations |mfpfProperties |Für die Anpassung von Operational Analytics anzugebende {{ site.data.keys.prod_adj }}-JNDI-Eigenschaften |Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma angegeben |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität |Standardeinstellung: **2000m** <br/>Informieren Sie sich über die Bedeutung der CPU-Kapazität unter [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **4096Mi** <br/>Informieren Sie sich über die Bedeutung der CPU-Kapazität unter [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  |requests.cpu |Beschreibt die erforderliche CPU-Mindestkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder ein anderweitig für die Implementierung definierter Wert. |Standardeinstellung: **1000m** |
|  |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder der für die Implementierung definierte Wert. |Standardeinstellung: **2048Mi** |
|persistence |existingClaimName |Name der vorhandenen Forderung nach einem persistenten Datenträger |  |
| logs | consoleFormat | Gibt das Format der Containerprotokollausgabe an |Standardeinstellung: **json** |
|  | consoleLogLevel | Steuert den Detaillierungsgrad von Nachrichten, die in das Containerprotokoll aufgenommen werden|Standardeinstellung: **info** |
|  | consoleSource | Gibt Quellen an, die in das Containerprotokoll geschrieben werden. Mehrere Quellen sind jeweils durch ein Komma getrennt aufgelistet. | Standardeinstellung: **message**, **trace**, **accessLog**, **ffdc** |


### Umgebungsvariablen für {{ site.data.keys.mf_server }}
{: #env-mf-server }
In der folgenden Tabelle sind die in {{ site.data.keys.mf_server }} in einen IBM Cloud-Kubernetes-Cluster verwendeten Umgebungsvariablen angegeben.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|-----------|-----------|------------|---------------|
|arch |  |Worker node architecture |Worker-Knotenarchitektur, in der dieses Chart implementiert werden soll. <br/>Derzeit wird nur die Plattform **AMD64** unterstützt. |
|image |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation |Standardwert: **IfNotPresent** |
|  |tag |Docker image tag |Siehe [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  |name |Docker image name |Name des {{ site.data.keys.prod_adj }}-Server-Docker-Image |
|scaling |replicaCount |Anzahl der {{ site.data.keys.prod_adj }}-Server-Instanzen (Pods), die erstellt werden müssen |Positive ganze Zahl<br/>Standardeinstellung: **3** |
|mobileFirstOperationsConsole |user |Benutzername für {{ site.data.keys.prod_adj }} Server |Standardeinstellung: **admin** |
|  |password |Kennwort für den Benutzer von {{site.data.keys.prod_adj }} Server |Standardeinstellung: **admin** |
|existingDB2Details |db2Host |IP-Adresse oder Host der DB2-Datenbank, in der die {{site.data.keys.prod_adj }}-Server-Tabellen konfiguriert werden müssen |Derzeit wird nur DB2 unterstützt. |
|  |db2Port |Port, der für die DB2-Datenbank eingerichtet ist |  |
|  |db2Database |Name der Datenbank, die in DB2 für die Verwendung vorkonfiguriert ist |  |
|  |db2Username |DB2-Benutzername für den Zugriff auf die DB2-Datenbank |Der Benutzer sollte Zugriff haben, um Tabellen zu erstellen und ein Schema zu erstellen, falls es noch nicht vorhanden ist. |
|  |db2Password |DB2-Kennwort für die angegebene Datenbank |  |
|  |db2Schema |Zu erstellendes Server-DB2-Schema |  |
|  |db2ConnectionIsSSL |DB2-Verbindungstyp |Geben Sie an, ob Ihre Datenbankverbindung über **http** oder **https** erfolgen muss. Der Standardwert ist **false** (http). <br/>Stellen Sie sicher, dass der DB2-Port für denselben Verbindungsmodus konfiguriert ist. |
|existingMobileFirstAnalytics |analyticsEndPoint |URL des Analytics Server |Beispiel: `http://9.9.9.9:30400`<br/> Geben Sie nicht den Pfad zur Konsole an. Dieser wird während der Implementierung hinzugefügt.  |
|  |analyticsAdminUser |Benutzername des Analytics-Benutzers mit Verwaltungsaufgaben |  |
|  |analyticsAdminPassword |Kennwort des Analytics-Benutzers mit Verwaltungsaufgaben |  |
|keystores |keystoresSecretName |Unter [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts) sind die Schritte für die Erstellung des geheimen Schlüssels mit den Keystores und den zugehörigen Kennwörtern beschrieben. |  |
|jndiConfigurations |mfpfProperties |{{ site.data.keys.prod_adj }}-Server-JNDI-Eigenschaften für die Anpassung der Implementierung |Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma angegeben |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität |Standardeinstellung: **2000m** <br/>Informieren Sie sich über die Bedeutung der CPU-Kapazität unter [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **4096Mi** <br/>Informieren Sie sich über die Bedeutung der CPU-Kapazität unter [Meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  |requests.cpu |Beschreibt die erforderliche CPU-Mindestkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder ein anderweitig für die Implementierung definierter Wert. |Standardeinstellung: **1000m** |
|  |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig *limits* verwendet (falls angegeben) oder der für die Implementierung definierte Wert. |Standardeinstellung: **2048Mi** |
| logs | consoleFormat | Gibt das Format der Containerprotokollausgabe an |Standardeinstellung: **json** |
|  | consoleLogLevel | Steuert den Detaillierungsgrad von Nachrichten, die in das Containerprotokoll aufgenommen werden|Standardeinstellung: **info** |
|  | consoleSource | Gibt Quellen an, die in das Containerprotokoll geschrieben werden. Mehrere Quellen sind jeweils durch ein Komma getrennt aufgelistet. | Standardeinstellung: **message**, **trace**, **accessLog**, **ffdc** |

> Das Lernprogramm zur Analyse von {{ site.data.keys.prod_adj }}-Protokollen mit Kibana finden Sie [hier](analyzing-mobilefirst-logs-on-icp/).

### Helm-Charts installieren
{: #install-hmc-icp}

#### {{ site.data.keys.mf_analytics }} installieren
{: #install-mf-analytics}

Die Installation von {{site.data.keys.mf_analytics }} ist optional. Wenn Sie Analysen in {{site.data.keys.mf_server }} aktivieren möchten, sollten Sie {{site.data.keys.mf_analytics }} installieren und konfigurieren und installieren, bevor Sie {{site.data.keys.mf_server }} installieren.

Bevor Sie mit der Installation des MobileFirst-Analytics-Charts beginnen, müssen Sie den **persistenten Datenträger** konfigurieren. Geben Sie den **persistenten Datenträger** für die Konfiguration von {{site.data.keys.mf_analytics }} an. Führen Sie für die Erstellung des **persistenten Datenträgers** die Schritte in der [IBM Cloud-Kubernetes-Dokumentation](https://console.bluemix.net/docs/containers/cs_storage_file.html#file_storage) aus. 

Führen Sie die folgenden Schritte aus, um IBM {{ site.data.keys.mf_analytics }} in einem IBM Cloud-Kubernetes-Cluster zu installieren und zu konfigurieren. 

1. Führen Sie den folgenden Befehl aus, um den Kubernetes-Cluster zu konfigurieren:
    ```bash
    ibmcloud cs cluster-config <Name_des_IBM_Cloud-Kubernetes-Clusters>
    ```
2. Rufen Sie mit dem folgenden Befehl die Helm-Chart-Standardwerte ab:
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    Beispiel für {{ site.data.keys.mf_analytics }}:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-1.0.17.tgz > values.yaml
    ```    

3. Modifizieren Sie die Datei **values.yaml**. Fügen Sie die entsprechenden Werte für die Implmentierung des Helm-Charts hinzu. Vergewissern Sie sich, dass die Hostdetails für [Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html), die Skalierung usw. hinzugefügt wurden, und speichern Sie die Datei values.yaml.

4. Führen Sie zum Implementieren des Helm-Charts den folgenden Befehl aus:
    ```bash
    helm install -n <Name_des_IBM_Cloud-Kubernetes-Clusters> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Beispiel für die Implementierung von Analytics Server:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-1.0.17.tgz
    ```    

#### {{ site.data.keys.mf_server }} installieren
{: #install-mf-server}

Bevor Sie mit der Installation von {{ site.data.keys.mf_server }} beginnen, benötigen Sie eine vorkonfigurierte DB2-Datenbank. 

Führen Sie die folgenden Schritte aus, um IBM {{ site.data.keys.mf_server }} in einem IBM Cloud-Kubernetes-Cluster zu installieren und zu konfigurieren. 

1. Konfigurieren Sie wie folgt den Kubernetes-Cluster:
    ```bash
    ibmcloud cs cluster-config <Name_des_IBM_Cloud-Kubernetes-Clusters>
    ```   

2. Rufen Sie mit dem folgenden Befehl die Helm-Chart-Standardwerte ab:
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    Beispiel für {{ site.data.keys.mf_server }}:
    ```bash
    helm inspect values ibm-mfpf-server-prod-1.0.17.tgz > values.yaml
    ```   

3. Modifizieren Sie die Datei **values.yaml**. Fügen Sie die entsprechenden Werte für die Implmentierung des Helm-Charts hinzu. Vergewissern Sie sich, dass die Datenbankdetails, Ingress, die Skalierung usw. hinzugefügt wurden, und speichern Sie die Datei values.yaml.

4. Führen Sie zum Implementieren des Helm-Charts den folgenden Befehl aus:
    ```bash
    helm install -n <Name_des_IBM_Cloud-Kubernetes-Clusters> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    Beispiel für die Serverimplementierung:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-1.0.17.tgz
    ``` 

>**Hinweis:** Für die Installation des Application Center müssen Sie das entsprechende Helm-Chart verwenden (z. B. ibm-mfpf-appcenter-prod-1.0.17.tgz), wenn sie die obigen Schritte ausführen.

## Installation überprüfen
{: #verify-install}

Nachdem Sie {{ site.data.keys.mf_analytics }} (optional) und {{ site.data.keys.mf_server }} installiert und konfiguriert haben, können Sie die IBM Cloud-CLI, die Kubernetes-CLI und Helm-Befehle verwenden, um Ihre Installation und den Status der implementierten Pods zu überprüfen.

Lesen Sie die [CLI-Befehlsreferenz](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) in der Dokumentation zur IBM Cloud-CLI und die Informationen zur Helm-CLI in der [Helm-Dokumentation](https://docs.helm.sh/helm/).

Auf der Seite "IBM Cloud Kubernetes Cluster" von IBM Cloud Portal können Sie die Schaltfläche **Launch** verwenden, um die Kubernetes-Konsole zu öffnen und die Clusterartefakte zu verwalten. 

## Zugriff auf die {{site.data.keys.prod_adj }}-Konsole
{: #access-mf-console}

Bei einer erfolgreichen Implementierung werden die Hinweise als Ausgabe auf dem Terminal angezeigt. Sie können die Befehle direkt ausführen, um die Konsolen-URL über *NodePort* abzurufen.

Die Hinweise zu Mobile Foundation Server werden beispielsweise wie folgt angezeigt: 

```text
The Notes displayed as follows as the result of the helm deployment
Get the Server URL by running these commands:
1. For http endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[0].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo http://$NODE_IP:$NODE_PORT/mfpconsole
2. For https endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[1].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo https://$NODE_IP:$NODE_PORT/mfpconsole
```

Bei Verwendung einer ähnlichen Installationsmethode können Sie auf die IBM MobileFirst Analytics Console mit `<Protokoll>://<IP-Adresse>:<NodePort>/analytics/console` und auf das IBM Mobile Foundation Application Center mit <`Protokoll>://<IP-Adresse>:<NodePort>/appcenter/console` zugreifen.
Neben der *NodePort*-Methode für den Zugriff auf die Konsole können Sie auch den [Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html)-Host nutzen, um auf den Service zuzugreifen. 

Führen Sie für den Zugriff auf die Konsole die folgenden Schritte aus: 

1. Öffnen Sie das [IBM Cloud-Dashboard](https://console.bluemix.net/dashboard/apps/).
2. Wählen Sie den Kubernetes-Cluster aus, in dem `Analytics/Server/AppCenter` implementiert wurde, um die Seite **Overview** zu öffnen.
3. Suchen Sie die Ingress-Unterdomäne für den Ingress-Hostnamen und greifen Sie wie folgt auf die Konsole zu:
    * Verwenden Sie für den Zugriff auf die IBM Mobile Foundation Operational Console Folgendes:
     `<Protokoll>://<Ingress-Hostname>/mfpconsole`
    * Verwenden Sie für den Zugriff auf die IBM Mobile Foundation Analytics Console Folgendes:
     `<Protokoll>://<Ingress-Hostname>/analytics/console`
    * Verwenden Sie für den Zugriff auf die IBM Mobile-Foundation-Application-Center-Konsole Folgendes:
     `<Protokoll>://<Ingress-Hostname>/appcenter/console`

>**Hinweis:** Der Port 9600 wird intern im Kubernetes-Service zugänglich gemacht und von den {{ site.data.keys.prod_adj }}-Analytics-Instanzen als Transportport verwendet. 


## Beispielanwendung
{: #sample-app}
Gehen Sie die [{{ site.data.keys.prod_adj }}-Lernprogramme](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) durch, um den Beispieladapter zu implementieren und die Beispielanwendung in einem IBM {{ site.data.keys.mf_server }} in einem IBM Cloud-Kubernetes-Cluster auszuführen.

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
Verwenden Sie zum Deinstallieren von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).
Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 
```bash
helm delete --purge <Releasename>
```
Hier steht *Releasename* für den implementierten Releasenamen des Helm-Charts. 
