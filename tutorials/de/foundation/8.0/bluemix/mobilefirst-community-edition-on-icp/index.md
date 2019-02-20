---
layout: tutorial
title: IBM Mobile Foundation for Developers 8.0 in IBM Cloud Private implementieren
breadcrumb_title: Foundation for Developers on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

IBM Mobile Foundation for Developers 8.0 für {{ site.data.keys.prod_icp }} ist eine Developer Edition der Mobile Foundation, die die Komponenten Mobile Foundation Server und Operational Analytics umfasst. Die Serverlaufzeit verfügt über eine integrierte Derby-Datenbank, in der die Mobile-Foundation-Daten gespeichert werden. Dadurch sind Benutzer auf einen Pod in der Kubernetes-Implementierung in {{ site.data.keys.prod_icp }} beschränkt. Die Community Edition ermöglicht Mobile-Foundation-Benutzern eine Anwendungsentwicklererfahrung mit minimalen Konfigurationsparametern und einer einfachen Einrichtung der Mobile-Foundation-Instanz in {{ site.data.keys.prod_icp }}.

Führen Sie die folgenden Anweisungen aus, um die Developer Edition von IBM Mobile Foundation Server mit der vorkonfigurierten Komponente Operational Analytics in {{ site.data.keys.prod_icp }} zu installieren:<br/>
* Richten Sie einen IBM Cloud-Private-Kubernetes-Cluster (IBM Cloud Private CE oder Native/Enterprise) ein.
* [Optional] Richten Sie Ihren Host-Computer mit den erforderlichen Tools ein: Docker-CLI, IBM Cloud-CLI (cloudctl), Kubernetes-CLI (kubectl) und Helm-CLI (helm).


#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [IBM Mobile Foundation for Developers 8.0 aus dem IBM Cloud-Private-Katalog installieren und konfigurieren](#install-the-ibm-mfpf-icp-catalog)
* [Installation überprüfen](#verify-install)
* [Beispielanwendung](#sample-app)
* [Deinstallation](#uninstall)
* [Beschränkungen](#limitations)

## Voraussetzungen
{: #prereqs}

IBM Cloud Private (Community Edition oder Native/Enterprise) muss eingerichtet und betriebsbereit sein. Entsprechende Anweisungen finden Sie in der Dokumentation zur [IBM Cloud-Private-Cluster-Installation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/install.html).

Für die Verwaltung von Containern und Images müssen Sie im Rahmen des IBM Cloud-Private-Setups die folgenden Tools auf Ihrer Hostmaschine installieren: 

* Docker
* IBM Cloud-CLI (`cloudctl`)
* Kubernetes-CLI (`kubectl`)
* Helm (`helm`)

Für den Zugruff auf den IBM Cloud-Private-Cluster über die CLI sollten Sie den *kubectl*-Client konfigurieren. [Hier finden Sie weitere Informationen](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html).


## Helm-Chart für IBM Mobile Foundation for Developers 8.0 installieren und konfigurieren
{: #install-the-ibm-mfpf-icp-catalog}

Gehen Sie wie unter [Helm-Diagramme im Catalog bereitstellen](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_release.html) beschrieben vor, um das Helm-Chart für IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) aus dem Katalog zu installieren. 

### Umgebungsvariablen für IBM Mobile Foundation for Developers 8.0
{: #env-mf-developers }
In der folgenden Tabelle sind die Umgebungsvariablen angegeben, die in IBM Mobile Foundation for Developers 8.0 verwendet werden.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|-----------|-----------|------------|---------------|
|arch |  |Worker node architecture |Worker-Knotenarchitektur, in der dieses Chart implementiert werden soll. <br/>Derzeit wird nur die Plattform **AMD64** unterstützt. |
|image |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation | Always, Never oder IfNotPresent. <br/>Standardeinstellung: **IfNotPresent** |
|  | repository |Docker image name | Name des {{ site.data.keys.prod_adj }}-Server-Docker-Image |
|  |tag |Docker image tag |Siehe [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).|
|  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory).|
|  |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig der Grenzwert verwendet (falls angegeben) oder der für Implementierung definierte Wert. | Der Standardwert ist 2000m. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).|
|  |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig der Grenzwert verwendet (falls angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory).|
| logs | consoleFormat | Gibt das Format der Containerprotokollausgabe an |Standardeinstellung: **json** |
|  | consoleLogLevel | Steuert den Detaillierungsgrad von Nachrichten, die in das Containerprotokoll aufgenommen werden|Standardeinstellung: **info** |
|  | consoleSource | Gibt Quellen an, die in das Containerprotokoll geschrieben werden. Mehrere Quellen sind jeweils durch ein Komma getrennt aufgelistet. | Standardeinstellung: **message**, **trace**, **accessLog**, **ffdc** |

## Installation überprüfen
{: #verify-install}

Nach der Installation von Mobile Foundation for Developers 8.0 können Sie wie folgt Ihre Instalaltion und den Status der implementierten Pods überprüfen: 

Wählen Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} **Workloads > Helm Releases** aus. Klicken Sie auf den *Releasenamen* für Ihre Installation. 


## Zugriff auf die {{site.data.keys.prod_adj }}-Konsole
{: #access-mf-console}

Nach einer erfolgreichen Installation können Sie mit `<Protokoll>://<IP-Adresse>:<Port>/mfpconsole` auf die IBM {{ site.data.keys.prod_adj }} Operational Console zugreifen. Auf die IBM {{ site.data.keys.mf_analytics }} Console können Sie mit `<Protokoll>://<IP-Adresse>:<Port>/analytics/console` zugreifen.

Das Protokoll kann `http` oder `https` sein. Beachten Sie außerdem, dass der Port im Falle einer **NodePort**-Implementierung **NodePort** lautet. Führen Sie die folgenden Schritte aus, um die IP-Adresse und den **NodePort** Ihres installierten {{ site.data.keys.prod_adj }}-Charts zu erhalten: 

1. Wählen Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} **Workloads > Helm Releases** aus.
2. Klicken Sie auf den *Releasenamen* für Ihre Helm-Chart-Installation.
3. Lesen Sie die Informationen im Abschnitt **Hinweise**.

## Beispielanwendung
{: #sample-app}
Gehen Sie die [{{ site.data.keys.prod_adj }}-Lernprogramme](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) durch, um den Beispieladapter zu implementieren und die Beispielanwendung in einem IBM {{ site.data.keys.mf_server }} in {{ site.data.keys.prod_icp }} auszuführen.

## Deinstallation
{: #uninstall}
Verwenden Sie zum Deinstallieren von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).


Klicken Sie im Dashboard auf **Workloads > Helm Releases** und suchen Sie nach dem *Releasenamen* der für die Implementierung des Charts verwendet wurde. Klicken Sie dann auf das Menü **Maßnahmen** und wählen Sie **Löschen** aus, um die installierten Charts vollständig zu löschen.

Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 
```bash
helm delete --purge <Releasename>
```
Hier steht *Releasename* für den implementierten Releasenamen des Helm-Charts. 

## Beschränkungen
{: #limitations}

Dieses Helm-Chart wird nur für Entwicklungs- und Testzwecke bereitgestellt. Daten werden in der eingebetteten Derby-Datenbank gespeichert. Das Chart funktioniert aufgrund der Datenbankeinschränkungen nur mit einem Pod.
