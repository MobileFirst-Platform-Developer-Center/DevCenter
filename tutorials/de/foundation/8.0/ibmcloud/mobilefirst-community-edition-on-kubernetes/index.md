---
layout: tutorial
title: IBM Mobile Foundation for Developers 8.0 in einem IBM Cloud-Kubernetes-Cluster implementieren
breadcrumb_title: Foundation for Developers in einem IBM Cloud-Kubernetes-Cluster
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

IBM Mobile Foundation for Developers 8.0 ist eine Developer Edition, die die Komponenten Server und Operational Analytics umfasst. 

Die Mobile-Foundation-Server-Laufzeit verfügt über eine integrierte Derby-Datenbank, in der die Mobile-Foundation-Daten gespeichert werden. Dadurch sind Benutzer auf einen Pod bei der Implementierung in IBM Cloud-Kubernetes beschränkt. Die Community Edition ermöglicht Mobile-Foundation-Benutzern eine Anwendungsentwicklererfahrung mit minimalen Konfigurationsparametern und einer einfachen Einrichtung der Mobile-Foundation-Instanz im IBM Cloud Kubernetes Service. 

Führen Sie die folgenden Anweisungen aus, um die Developer Edition von IBM Mobile Foundation Server mit der vorkonfigurierten Komponente Operational Analytics für den IBM Cloud Kubernetes Service zu installieren:<br/>
* Von [hier](https://cloud.ibm.com/kubernetes/clusters) aus können Sie den Kubernetes-Cluster erstellen und konfigurieren.
* Optional: Richten Sie Ihren Host-Computer mit den erforderlichen Tools ein: Docker-CLI, Kubernetes-CLI (kubectl) und Helm-CLI (helm).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Voraussetzungen](#prereqs)
* [IBM Mobile Foundation for Developers 8.0 aus dem Helm-Chart-Katalog installieren und konfigurieren](#install-the-ibm-mfpf-iks-catalog)
* [Installation überprüfen](#verify-install)
* [Beispielanwendung](#sample-app)
* [Deinstallation](#uninstall)
* [Beschränkungen](#limitations)

## Voraussetzungen
{: #prereqs}

Sie müssen den IBM Cloud Kubernetes Service (Plan "Free") über das [IBM Cloud](https://cloud.ibm.com/)-Portal erstellt haben. Konfigurationsanweisungen finden Sie in der [Dokumentation](https://cloud.ibm.com/docs/containers?topic=containers-getting-started). Für die Verwaltung von Kube-Pods und die Helm-Implementierung müssen Sie die folgenden Tools auf Ihrer Hostmaschine installieren:
* IBM Cloud-CLI (`ibmcloud`)
* Kubernetes-CLI (`kubectl`)
* Helm (`helm`). Wenn Sie die CLI für Ihre Arbeit mit dem Kubernetes-Cluster nutzen möchten, müssen Sie den Client *ibmcloud* konfigurieren.
1. Melden Sie sich bei der Seite [Cluster](https://cloud.ibm.com/kubernetes/clusters) an. (Hinweis: Sie benötigen ein [IBMid-Konto](https://myibm.ibm.com/).)
2. Klicken Sie auf den Kubernetes-Cluster, in dem das IBM Mobile-Foundation-Chart implementiert werden soll.
3. Wenn der Cluster erstellt ist, folgen Sie den Anweisungen auf der Registerkarte **Access**.
>**Hinweis:** Die Clustererstellung dauert einige Minuten. Klicken Sie nach erfolgreicher Erstellung des Clusters auf die Registerkarte **Worker Nodes** und notieren Sie den Eintrag im Feld *Public IP*.

## Helm-Chart für IBM Mobile Foundation for Developers 8.0 installieren und konfigurieren
{: #install-the-ibm-mfpf-iks-catalog}

Führen Sie am IBM Cloud-Client-Terminal (CLI *ibmcloud*) die im Abschnitt **INSTALL CHART** unter [Deploying charts from the Helm Catalog](https://cloud.ibm.com/kubernetes/helm/ibm-charts/ibm-mobilefoundation-dev) beschriebene Prozedur aus, um aus dem Katalog das Helm-Chart für IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) zu installieren. 

### Umgebungsvariablen für IBM Mobile Foundation for Developers 8.0
{: #env-mf-developers }

In der folgenden Tabelle sind die Umgebungsvariablen angegeben, die in IBM Mobile Foundation for Developers 8.0 verwendet werden.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|-----------|-----------|------------|---------------|
|arch |  |Worker node architecture |Worker-Knotenarchitektur, in der dieses Chart implementiert werden soll. <br/>Derzeit wird nur die Plattform **AMD64** unterstützt. |
|image |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation | Always, Never oder IfNotPresent. <br/>Standardeinstellung: **IfNotPresent** |
|  | repository |Docker image name | Name des {{ site.data.keys.prod_adj }}-Server-Docker-Image |
|  |tag |Docker image tag |Siehe [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 1000m. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).|
|  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 2048Mi. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory).|
|  |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig der Grenzwert verwendet (falls angegeben) oder der für Implementierung definierte Wert. | Der Standardwert ist 750m. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu).|
|  |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Wenn keine Angabe gemacht wird, wird standardmäßig der Grenzwert verwendet (falls in values.yaml angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1024Mi. Weitere Informationen finden Sie auf der Kubernetes-Seite unter [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory).|
| logs | consoleFormat | Gibt das Format der Containerprotokollausgabe an |Standardeinstellung: **json** |
|  | consoleLogLevel | Steuert den Detaillierungsgrad von Nachrichten, die in das Containerprotokoll aufgenommen werden|Standardeinstellung: **info** |
|  | consoleSource | Gibt Quellen an, die in das Containerprotokoll geschrieben werden. Mehrere Quellen sind jeweils durch ein Komma getrennt aufgelistet. | Standardeinstellung: **message**, **trace**, **accessLog**, **ffdc** |

## Installation überprüfen
{: #verify-install}

Nach der Installation von Mobile Foundation for Developers 8.0 können Sie wie folgt Ihre Installation und den Status der implementierten Pods überprüfen: 
1. Klicken Sie auf der Seite [Cluster](https://cloud.ibm.com/kubernetes/clusters) auf den Kubernetes-Cluster, in dem das Chart für die IBM Mobile Foundation implementiert wurde.
2. Klicken Sie auf die Schaltfläche **Kubernetes-Dashboard**, um das Kube-Dashboard aufzurufen.
3. Überprüfen Sie im Dashboard **Deployments** und **Pods**. Diese sollten den Status **DEPLOYED** und **RUNNING** haben.
4. Jetzt benötigen Sie die öffentliche IP-Adresse (*Public IP*) und den Knotenport (*Node Port*) der Implementierung, um auf die Services zugreifen zu können.
    - Die öffentliche IP-Adresse (**Public IP**) können Sie abrufen, indem Sie **Kubernetes** **>** **Worker Nodes** auswählen. Notieren Sie die Adresse im Feld *Public IP*.
    - Den Knotenport (**Node port**) finden Sie im **Kubernetes-Dashboard**. Wählen Sie **Services** aus. Notieren Sie den Eintrag für *TCP Node Port* unter den internen Endpunkten (eine fünfstellige Portnummer).
5. Öffnen Sie einen Browser und geben Sie `http://[öffentliche IP-Adresse]:[Knotenport]/mfpconsole` ein, um die Administrationskonsole aufzurufen.
6. Geben Sie die Standardberechtigungsnachweise ein (Benutzer `admin`, Kennwort `admin`), um sich bei der Administrationskonsole von Mobile Foundation Server anzumelden.
7. Stellen Sie sicher, dass die Serververwaltung, Push-Operationen und Analytics verfügbar sind.

### Befehlszeile verwenden [optional]

Alternativ können Sie die Befehlszeile verwenden und die folgende Prozedur ausführen. Stellen Sie sicher, dass der folgende Befehl den Status (**state**) *DEPLOYED* hat. 
```bash
helm list
```
Führen Sie `kubectl`-Befehle aus, um sich zu vergewissern, dass die Pods den Status **RUNNING** haben.
1. Rufen Sie die Liste aller Implementierungen im Kubernetes-Cluster ab und notieren Sie den Namen der Mobile-Foundation-Implementierung.
    ```bash
    kubectl get deployments
    ```
2. Führen Sie die folgenden Befehle aus, um die Verfügbarkeit der Implementierungen und ihren Status im Detail zu überprüfen. Für die Kube-Pods sollte für Verfügbarkeit und Status `(1/1) RUNNING` angezeigt werden.
    ```bash
    kubectl describe deployment <Name_der_Implementierung>
    kubectl get pods
    ```
## Zugriff auf die {{site.data.keys.prod_adj }}-Konsole
{: #access-mf-console}

Nach einer erfolgreichen Installation können Sie auf die IBM {{ site.data.keys.prod_adj }} Operational Console zugreifen. Verwenden Sie `<Protokoll>://<öffentliche_IP-Adresse>:<Knotenport>/mfpconsole`.<br/>
Die IBM {{ site.data.keys.mf_analytics }} Console kann mit `<Protokoll>://<öffentliche_IP-Adresse>:<Port>/analytics/console` aufgerufen werden.
Das Protokoll kann `http` oder `https` sein. Beachten Sie außerdem, dass der Port im Falle einer **NodePort**-Implementierung **NodePort** lautet. Führen Sie im Kubernetes-Dashboard die folgenden Schritte aus, um die IP-Adresse und den **NodePort** Ihres installierten {{ site.data.keys.prod_adj }}-Charts zu erhalten: 
* Die öffentliche IP-Adresse (**Public IP**) können Sie abrufen, indem Sie **Kubernetes** > **Worker Nodes** auswählen. Notieren Sie die Adresse im Feld "Public IP".
* Den Knotenport (**Node port**) finden Sie im **Kubernetes-Dashboard**. Wählen Sie **Services** aus. Notieren Sie den Eintrag für *TCP Node Port* (eine fünfstellige Portnummer) unter den internen Endpunkten (**internal endpoints**).

## Beispielanwendung
{: #sample-app}

Gehen Sie die [{{ site.data.keys.prod_adj }}-Lernprogramme](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) durch, um den Beispieladapter zu implementieren und die Beispielanwendung in einem IBM {{ site.data.keys.mf_server }} in einem IBM Cloud-Kubernetes-Cluster auszuführen.

## Deinstallation
{: #uninstall}

Verwenden Sie für die Deinstallation des Helm-Charts `ibm-mobilefoundation-dev` die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).
Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 
```bash
helm delete --purge <Releasename>
```
Hier steht *Releasename* für den implementierten Releasenamen des Helm-Charts. 

## Beschränkungen
{: #limitations}

Dieses Helm-Chart wird nur für Entwicklungs- und Testzwecke bereitgestellt. Daten werden nicht persistent in der eingebetteten Derby-Datenbank gespeichert. Die Chart-Implementierung funktioniert aufgrund der Datenbankeinschränkungen nur mit einem Pod.
