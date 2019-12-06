---
layout: tutorial
title: Mobile Foundation mit Helm in einem IBM Cloud-Kubernetes-Cluster einrichten
breadcrumb_title: Foundation on Kubernetes using Helm
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um mit Helm-Charts eine MobileFirst-Server-Instanz, eine MobileFirst-Push-Instanz, eine MobileFirst-Analytics-Instanz und eine MobileFirst-Application-Center-Instanz in einem IBM Cloud-Kubernetes-Cluster zu konfigurieren.

Nachfolgend finden Sie die grundlegenden Schritte für den Start: <br/>
* Stellen Sie sicher, dass die Voraussetzungen erfüllt sind.
* Laden Sie das Passport-Advantage-Archiv mit {{ site.data.keys.product_full }} für {{ site.data.keys.prod_icp }} herunter.
* Laden Sie das Passport-Advantage-Archiv in den IBM Cloud-Kubernetes-Cluster.
* Installieren und konfigurieren Sie {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (optional) und das {{ site.data.keys.mf_app_center}} (optional).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation herunterladen](#download-the-ibm-mfpf-ppa-archive)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation laden](#load-the-ibm-mfpf-ppa-archive)
* [Umgebungsvariablen](#env-variables)
* [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts)
* [Helm-Charts installieren](#install-hmc-icp)
* [Installation überprüfen](#verify-install)
* [Beispielanwendung](#sample-app)
* [Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases durchführen](#upgrading-mf-helm-charts)
* [Deinstallation](#uninstall)
* [Fehlerbehebung](#troubleshooting)

## Voraussetzungen
{: #prereqs}

Sie müssen über ein [**IBM Cloud-Konto**](http://cloud.ibm.com/) verfügen und den [**IBM Cloud-Kubernetes-Cluster**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial) eingerichtet haben.

Für die Verwaltung der Container und Images müssen Sie im Rahmen der Einrichtung der IBM Cloud-CLI-Plug-ins Folgendes auf Ihrer Hostmaschine installieren: 

* IBM Cloud-CLI (`ibmcloud`)
* Kubernetes-CLI (`kubectl`)
* IBM Cloud-Container-Registry-Plug-in (`cr`)
* IBM Cloud-Container-Service-Plug-in (`ks`)
* [Docker](https://docs.docker.com/install/) (installieren und konfigurieren)
* Helm (`helm`). Wenn Sie die CLI für Ihre Arbeit mit dem Kubernetes-Cluster nutzen möchten, müssen Sie den Client *ibmcloud* konfigurieren.
1. Melden Sie sich bei der Seite [Cluster](https://cloud.ibm.com/kubernetes/clusters) an. (Hinweis: Sie benötigen ein [IBMid-Konto](https://myibm.ibm.com/).)
2. Klicken Sie auf den Kubernetes-Cluster, in dem das IBM Mobile-Foundation-Chart implementiert werden soll.
3. Wenn der Cluster erstellt ist, folgen Sie den Anweisungen auf der Registerkarte **Access**.
>**Hinweis:** Die Clustererstellung dauert einige Minuten. Klicken Sie nach erfolgreicher Erstellung des Clusters auf die Registerkarte **Worker Nodes** und notieren Sie den Eintrag im Feld *Public IP*.

Für den Zugriff auf den IBM Cloud-Kubernetes-Cluster über die CLI sollten Sie den IBM Cloud-Client konfigurieren. [Hier finden Sie weitere Informationen](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).

## Passport-Advantage-Archiv mit der IBM Mobile Foundation herunterladen
{: #download-the-ibm-mfpf-ppa-archive}
Das Passport-Advantage-Archiv mit dem {{ site.data.keys.product_full }} ist [hier](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) verfügbar. Das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} enthält die Docker-Images und Helm-Charts für die folgenden Komponenten der {{ site.data.keys.product }}: 
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

Zur Vereinfachung der Datenbankinitialisierung gibt es die {{ site.data.keys.product_adj }}-Komponente *DB-Initialisierung*. Im Rahmen der Initialisierungsschritte werden das Mobile-Foundation-Schema und die Mobile-Foundation-Tabellen in der Datenbank erstellt (sofern sie nicht vorhanden sind).

## Passport-Advantage-Archiv mit der IBM Mobile Foundation laden
{: #load-the-ibm-mfpf-ppa-archive}

Führen Sie die nachstehenden Schritte aus, um das Passport-Advantage-Archiv in den IBM Cloud-Kubernetes-Cluster zu laden:

  1. Melden Sie sich mit dem IBM Cloud-Plug-in beim Cluster an. In der [Dokumentation zur IBM Cloud-CLI] (unter https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview) finden Sie eine Befehlsreferenz.

      Beispiel:
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
      Nehmen Sie die Option `--sso` auf, falls Sie eine eingebundene ID verwenden. Falls Sie die SSL-Validierung übergehen möchten, können Sie im obigen Befehl die Option `--skip-ssl-validation` verwenden. Damit würde die SSL-Validierung von HTTP-Anforderungen umgangen werden. Die Verwendung dieses Parameters kann zu Sicherheitsproblemen führen.

  2. Melden Sie sich bei der IBM Cloud-Container-Registry an und initialisieren Sie den Containerservice mit folgenden Befehlen:
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. Definieren Sie die Implementierungsregion (z. B. us-south) mit folgendem Befehl:
      ```bash
      ibmcloud cr region-set
      ```  

  4. Führen Sie die folgenden Schritte aus, um Zugriff auf Ihren Cluster zu erhalten:

      1. Laden Sie einige CLI-Tools und das Kubernetes-Service-Plug-in herunter und installieren Sie die Tools und das Plug-in.
      ```bash
      curl -sL https://ibm.biz/idt-installer | bash
      ```

      2. Laden Sie die KUBECONFIG-Dateien für Ihren Cluster herunter.
      ```bash
      ibmcloud ks cluster-config --cluster Clustername
      ```

      3. Setzen Sie die Umgebungsvariable *KUBECONFIG*. Kopieren Sie die Ausgabe des vorherigen Befehls und fügen Sie sie an Ihrem Terminal ein. Die Befehlsausgabe sieht ähnlich wie im folgenden Beispiel aus:
      ```bash
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/my_namespace/kube-config-dal10-my_namespace.yml
      ```

      4. Prüfen Sie, ob Sie eine Verbindung zu Ihrem Cluster herstellen können, indem Sie Ihre Workerknoten auflisten.
      ```bash
      kubectl get nodes
      ```

  5. Laden Sie mit folgenden Schritten das Passport-Advantage-Archiv mit der {{ site.data.keys.product }}:
       1. **Extrahieren** Sie das Passport-Advantage-Archiv.
       2. **Kennzeichnen** Sie die geladenen Images mit dem Registry-Namespace von IBM Cloud Container und mit der richtigen Version.
       3. **Übertragen** Sie das Image per Push-Operation.
       4. Optional: Erstellen Sie die Manifeste und **übertragen Sie sie per Push-Operation)**, wenn die Workerknoten auf einer Kombination von Architekturen basieren (z. B. amd64, ppc64le, s390x).

      Nachfolgend sehen Sie ein Beispiel für das Laden der Images **mfpf-server** und **mfpf-push** auf die Workerknoten, die auf der Architektur **amd64** basieren. Der gleiche Prozess gilt für **mfpf-appcenter** und **mfpf-analytics**.

      ```bash

      1. Extrahieren Sie das PPA-Archiv.

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      2. Kennzeichnen Sie die geladenen Images mit dem Registry-Namespace von IBM Cloud Container und mit der richtigen Version.

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0

      3. Übertragen Sie alle Images per Push-Operation.

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0

      4. Bereinigen Sie das extrahierte Archiv.

      rm -rf ppatmp
      ```

      Nachfolgend sehen Sie ein Beispiel für das Laden der Images **mfpf-server** und **mfpf-push** auf die Workerknoten, die auf einer **Multiarchitektur** basieren. Der gleiche Prozess gilt für **mfpf-appcenter** und **mfpf-analytics**.

      ```bash
      1. Extrahieren Sie das PPA-Archiv.

      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      2. Kennzeichnen Sie die geladenen Images mit dem Registry-Namespace von IBM Cloud Container und mit der richtigen Version.

      2.1 Kennzeichnen Sie mfpf-server.

      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker tag mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker tag mfpf-server:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      2.2 Kennzeichnen Sie mfpf-dbinit.

      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker tag mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker tag mfpf-dbinit:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      2.3 Kennzeichnen Sie mfpf-push.

      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker tag mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker tag mfpf-push:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      3. Übertragen Sie alle Images per Push-Operation.

      3.1 Übertragen Sie mfpf-server-Images per Push-Operation.

      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le

      3.3 Übertragen Sie mfpf-dbinit-Images per Push-Operation.

      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le

      3.3 Übertragen Sie mfpf-push-Images per Push-Operation.

      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      4. Erstellen Sie die Manifeste und übertragen Sie sie per Push-Operation (optional).

      4.1 Erstellen Sie Manifestlisten.

      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      4.2 Versehen Sie die Manifeste mit Annotationen.

      mfpf-server

      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le --os linux --arch ppc64le


      mfpf-dbinit

      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le --os linux --arch ppc64le


      mfpf-push

      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le --os linux --arch ppc64le

      4.3 Übertragen Sie die Manifestliste per Push-Operation.

      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0

      5. Bereinigen Sie das extrahierte Archiv.

      rm -rf ppatmp
      ```

   >**Hinweis:**
   > 1. Der Befehl `ibmcloud cr ppa-archive load` bietet keine Unterstützung für das PPA-Paket mit Multiarchitekturunterstützung. Daher muss das Paket manuell extrahiert und per Push-Operation in das IBM Cloud-Container-Repository übertragen werden. (Benutzer, die ältere PPA-Versionen verwenden, müssen zum Laden den folgenden Befehl verwenden.)

   > 2. Multiarchitektur bezieht sich auf mehrere Architekturen, einschließlich intel (amd64), power64 (ppc64le) und s390x. Mehrere Architekturen werden nur von ICP 3.1.1 unterstützt.

  ```bash
      ibmcloud cr ppa-archive-load --archive <Archivname> --namespace <Namespace> [--clustername <Clustername>]
      ```
   Der *Archivname* für die {{ site.data.keys.product }} ist der Name des Archivs, den Sie über IBM Passport Advantage heruntergeladen haben.

   Die Helm-Charts werden im Client oder lokal gespeichert (im Gegensatz zum Helm-Chart für ICP, das im Helm-Repository für IBM Cloud Private gespeichert wird). Die Charts finden Sie im Verzeichnis `ppa-import/charts` (oder "charts"). 

## Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren
{: #configure-install-mf-helmcharts}

Bevor Sie das {{ site.data.keys.mf_server }} installieren und konfigurieren, benötigen Sie Folgendes: 

Im folgenden Abschnitt sind die Schritte für die Erstellung geheimer Schlüssel zusammengefasst. 

Geheime Schlüsselobjekte bieten die Möglichkeit, sensible Daten wie Kennwörter, OAuth-Token, SSH-Schlüssel usw. zu speichern und zu verwalten. Die Aufnahme solcher Daten in einen geheimen Schlüssel ist sicherer und flexibler als die Aufnahme in eine Pod-Definition oder in ein Container-Image.

* [**Obligatorisch**] Sie benötigen eine konfigurierte und betriebsbereite DB2-Datenbankinstanz. Sie benötigen außerdem die Datenbankinformationen für die [Konfiguration des MobileFirst-Server-Helm-Charts](#install-hmc-icp). {{site.data.keys.mf_server }} erfordert ein Schema und Tabellen, die in dieser Datenbank erstellt werden (falls sie nicht vorhanden sind).

* [**Obligatorisch**] Sie müssen **geheime Datenbankschlüssel** für Server, Push und Application Center erstellen.
In diesem Abschnitt sind die Sicherheitsmechanismen zur Steuerung des Datenbankzugriffs umrissen. Erstellen Sie mit dem angegebenen Unterbefehl einen geheimen Schlüssel und geben Sie unter den Datenbankdetails den Namen des erstellten geheimen Schlüssels an.

Führen Sie das folgende Code-Snippet aus, um einen geheimen Datenbankschlüssel für Mobile Foundation Server zu erstellen:

   ```bash
	# Geheimen mfpserver-Schlüssel erstellen
	cat <<EOF | kubectl apply -f -
	apiVersion: v1
	data:
	  MFPF_ADMIN_DB_USERNAME: encoded_uname
	  MFPF_ADMIN_DB_PASSWORD: encoded_password
	  MFPF_RUNTIME_DB_USERNAME: encoded_uname
	  MFPF_RUNTIME_DB_PASSWORD: encoded_password
	  MFPF_PUSH_DB_USERNAME: encoded_uname
	  MFPF_PUSH_DB_PASSWORD: encoded_password
	kind: Secret
	metadata:
	  name: mfpserver-dbsecret
	type: Opaque
	EOF
   ```

Führen Sie das folgende Code-Snippet aus, um einen geheimen Datenbankschlüssel für das Application Center zu erstellen:

   ```bash
	# Geheimen appcenter-Schlüssel erstellen
	cat <<EOF | kubectl apply -f -
	apiVersion: v1
	data:
	  APPCNTR_DB_USERNAME: encoded_uname
	  APPCNTR_DB_PASSWORD: encoded_password
	kind: Secret
	metadata:
	  name: appcenter-dbsecret
	type: Opaque
	EOF
   ```
   > HINWEIS: Sie können den Benutzernamen und das Kennwort mit dem folgenden Befehl verschlüsseln:

   ```bash
	export $MY_USER_NAME=<Benutzer>
	export $MY_PASSWORD=<Kennwort>

	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```


* [**Obligatorisch**] Für die Anmeldung bei Server, Analytics und Application-Center-Konsole ist ein vorab erstellter **geheimer Anmeldeschlüssel** erforderlich. Beispiel: 

   ```bash
   kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
   ```

   Analytics:

   ```bash
   kubectl create secret generic analyticslogin --from-literal=ANALYTICS_ADMIN_USER=admin --from-literal=ANALYTICS_ADMIN_PASSWORD=admin
   ```

   Application Center:

   ```bash
   kubectl create secret generic appcenterlogin --from-literal=APPCENTER_ADMIN_USER=admin --from-literal=APPCENTER_ADMIN_PASSWORD=admin
   ```

   > HINWEIS: Wenn diese geheimen Schlüssel nicht zur Verfügung gestellt werden, werden sie während der Implementierung des Helm-Charts für die Mobile Foundation mit dem Standardbenutzernamen admin und dem Kennwort admin erstellt.

* [**Optional**] Sie können Ihren eigenen Keystore und Truststore für die Implementierung von Server, Analytics und Application Center angeben, indem Sie mit Ihrem eigenen Keystore und Truststore einen geheimen Schlüssel erstellen.

   Erstellen Sie vorab einen geheimen Schlüssel mit `keystore.jks` und `truststore.jks` sowie ein Keystore- und Truststore-Kennwort. Verwenden Sie dafür die Literale KEYSTORE_PASSWORD und TRUSTSTORE_PASSWORD. Geben Sie den Namen des geheimen Schlüssels im Feld "keystoreSecret" für die betreffende Komponente an.

   Speichern Sie die Dateien `keystore.jks` und `truststore.jks` sowie die zugehörigen Kennwörter wie nachfolgend angegeben.  

   Beispiel: 

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > HINWEIS: Die Namen der Dateien und Literale müssen mit den Angaben im obigen Befehl übereinstimmen. Geben Sie diesen Namen des geheimen Schlüssels im Eingabefeld `keystoresSecretName` der jeweiligen Komponente an, um die Standard-Keystores beim Konfigurieren des Helm-Charts außer Kraft zu setzen. 

* [**Optional**] Mobile-Foundation-Komponenten können so konfiguriert werden, dass externe Clients unter Verwendung des Hostnamens auf die Komponenten zugreifen. Der Zugriff kann mit einem privaten TLS-Schlüssel und einem TLS-Zertifikat geschützt werden. Der private TLS-Schlüssel und das TLS-Zertifikat müssen in einem geheimen Schlüssel mit den Schlüsselnamen `tls.key` und `tls.crt` definiert werden.

   Der geheime Schlüssel **mf-tls-secret** muss in demselben Namespace wie die Zugriffsressource (Ingress) erstellt werden. Verwenden Sie dafür den folgenden Befehl:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   Der Hostname für den Zugriff und der Name des geheimen Schlüssels werden dann im Feld global.ingress.secret angegeben. Modifizieren Sie die Datei **values.yaml**. Fügen Sie einen passenden Hostnamen und den geheimen Schlüssel für den Zugriff beim Implementieren des Helm-Charts hinzu. 

   > HINWEIS: Vermeiden Sie die Verwendung eines Hostnames für den Zugriff, wenn dieser bereits für ein anderes Helm-Release verwendet wurde. 

* [**Optional**] Mobile Foundation Server ist vorab mit vertraulichen Clients für den Verwaltungsservice definiert. Die Berechtigungsnachweise für diese Clients werden in den Feldern `mfpserver.adminClientSecret` und `mfpserver.pushClientSecret` angegeben.

   Sie können diese geheimen Schlüssel wie folgt erstellen: 
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > HINWEIS: Wenn die Werte für die Felder `mfpserver.pushClientSecret` und `mfpserver.adminClientSecret` nicht während der Implementierung des Helm-Charts für die Mobile Foundation bereitgestellt werden, werden eine Standardwerte für Authentifizierungs-ID und geheimen Schlüssel generiert und verwendet. Diese lauten `admin/nimda` für `mfpserver.adminClientSecret` und `push/hsup` für `mfpserver.pushClientSecret`.

* [**Obligatorisch**] Bevor Sie mit der Installation des Charts für Mobile Foundation Analytics beginnen, konfigurieren Sie den persistenten Datenträger und die Anforderung eines persistenten Datenträgers entsprechend. Geben Sie den persistenten Datenträger für die Konfiguration von Mobile Foundation Analytics an. Führen Sie die Schritte aus, die in der [IBM Cloud-Kubernetes-Dokumentation](https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_storage) für die Erstellung eines persistenten Datenträgers beschrieben sind.


## Umgebungsvariablen
{: #env-variables }
In der folgenden Tabelle sind die in der Mobile-Foundation-Server-Instanz, der Mobile-Foundation-Analytics-Instanz, der Mobile-Foundation-Push-Instanz und der Mobile-Foundation-Application-Center-Instanz verwendeten Umgebungsvariablen angegeben.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|-----------|-----------|------------|---------------|
| ***`Globale Konfiguration`*** | |  |  |
|arch | amd64 | Planervorgabe für einen amd64-Worker-Knoten in einem Hybridcluster | 3 - Vorgabe (Standardwert) |
|  | ppcle64 | Planervorgabe für einen ppc64le-Worker-Knoten in einem Hybridcluster | 2 - Keine Vorgabe (Standardwert) |
|  | s390x | Planervorgabe für einen S390x-Worker-Knoten in einem Hybridcluster | 2 - Keine Vorgabe (Standardwert) |
|image |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation |Standardwert: **IfNotPresent** |
|  | pullSecret |Geheimer Schlüssel für die Image-Übertragung per Pull-Operation |  |
| ingress | hostname |Externer Hostname oder IP-Adresse für externe Clients | Gleicht die Arbeitslast des Netzdatenverkehrs in Ihrem Cluster durch Weiterleitung öffentlicher oder privater Anforderungen an Ihre Apps aus |
|  | secret | Name des geheimen TLS-Schlüssels | Gibt den Namen des geheimen Schlüssels für das Zertifikat an, der in der Zugriffsdefinition (Ingress) verwendet werden muss. Der geheime Schlüssel muss vorab mit dem relevanten Zertifikat und Schlüssel erstellt worden sein. Obligatorisch, wenn SSL/TLS aktiviert ist. Erstellen Sie den geheimen Schlüssel mit dem Zertifikat und dem geheimen Schlüssel, bevor Sie hier den Namen angeben. |
|  | sslPassThrough | SSL-Durchgriff aktivieren | Gibt an, dass die SSL-Anforderung an den Mobile Foundation Servie übergeben werden soll. Der SSL-Abschluss erfolgt im Mobile Foundation-Service. Standardwert: false |
| https | true |  |  |
| dbinit | enabled | Initialisierung von Server-, Push- und Application-Center-Datenbank aktivieren | Initialisiert Datenbanken und erstellt Schemata/Tabellen für die Server-, Push- und Application-Center-Implementierung. (Für Analytics nicht erforderlich.) Standardwert: true |
| | repository | Docker-Image-Repository für die Datenbankinitialisierung | Repository des Docker-Image für die Mobile-Foundation-Datenbank |
|  |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|  | replicas | Die Anzahl der zu erstellenden Instanzen (Pods) von Mobile-Foundation-DBinit | Positive ganze Zahl (Standardwert: 1) |
| ***`MFP-Server-Konfiguration`*** | | | |
| mfpserver | enabled | Flag zum Aktivieren des Servers | true (Standardwert) oder false |
|  | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Server |
|  |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|  | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
|  db | host | IP-Adresse oder Hostname der Datenbank, für die Mobile-Foundation-Server-Tabellen konfiguriert werden müssen | IBM DB2® (Standardwert) |
| | port |Port, der für die Datenbank eingerichtet ist | |
| | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
| |name | Name der Mobile-Foundation-Server-Datenbank | |
|  | schema |Zu erstellendes Server-DB2-Schema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|  | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist false (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
| adminClientSecret | Geben Sie den Namen des geheimen Schlüssels an. | Geheimer Clientschlüssel für Verwaltung | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. [Weitere Informationen](#configure-install-mf-helmcharts) |
| pushClientSecret | Geben Sie den Namen des geheimen Schlüssels an. | Geheimer Clientschlüssel für Push | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. [Weitere Informationen](#configure-install-mf-helmcharts) |
| internalConsoleSecretDetails | consoleUser: "admin" |  |  |
|  | consolePassword: "admin" |  |  |
| internalClientSecretDetails | adminClientSecretId: admin |  |  |
| | adminClientSecretPassword: nimda |  |  |
| | pushClientSecretId: push |  |  |
| | pushClientSecretPassword: hsup |  |  |
| replicas | 3 | Die Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: 3) |
| autoscaling | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicas" inaktiviert. | false (Standardwert) oder true |
| | min  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
| | max | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "min" sein. | Positive ganze Zahl (Standardwert: 10) |
| | targetcpu | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| pdb | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
| | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|jndiConfigurations |mfpfProperties | JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP-Push-Konfiguration`*** | | | |
| mfppush | enabled | Flag zur Aktivierung von Mobile Foundation Push | true (Standardwert) oder false |
|           | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Push|
|           |tag |Docker image tag | Siehe Docker-Tag-Beschreibung |
| replicas | | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: 3) |
| autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | min  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | max | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetcpu | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| pdb | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|jndiConfigurations |mfpfProperties |JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| |keystoresSecretName | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP-Analytics-Konfiguration`*** | | | |
| mfpanalytics | enabled          | Flag zum Aktivieren von Analytics | false (Standardwert) oder true |
|image | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Operational Analytics |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
| replicas |  | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Operational Analytics | Positive ganze Zahl (Standardwert: 2) |
| autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | min  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | max | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetcpu | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
|  shards|  | Anzahl der Elasticsearch-Shards für Mobile Foundation Analytics | Standardwert: 2|             
|replicasPerShard |  | Anzahl der pro Shard für Mobile Foundation Analytics zu verwaltenden Elasticsearch-Replikate | Standardwert: 2|
|persistence | enabled | Verwenden Sie eine Anforderung eines persistenten Datenträgers zum persistenten Speichern von Daten. | true |                                                 |
|  |useDynamicProvisioning | Geben Sie eine Speicherklasse an oder lassen Sie das Feld leer. | false  |                                                  |
| |volumeName| Geben Sie einen Datenträgernamen an.  | data-stor (Standardwert) |
|   |claimName|Geben Sie eine vorhandene Anforderung eines persistenten Datenträgers an. | nil |
|   |storageClassName     | Speicherklasse der unterstützenden Anforderung eines persistenten Datenträgers | nil |
|   |size    | Größe des Datenträgers | 20Gi |
| pdb  | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|   | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|jndiConfigurations |mfpfProperties | Mobile-Foundation-JNDI-Eigenschaften, die für die Anpassung von Operational Analytics angegeben werden müssen | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
|  | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|   |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP-Application-Center-Konfiguration`*** | | | |
| mfpappcenter | enabled          | Flag zum Aktivieren des Application Center | false (Standardwert) oder true |  
|image | repository | Docker-Image-Repository | Repository des Docker-Image für das Mobile Foundation Application Center |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
|  db | host | IP-Adresse oder Hostname für die Konfiguration der Application-Center-Datenbank | |
|   | port | 	Port der Datenbank  | |             
| |name |Name der zu verwendenden Datenbank |Die Datenbank muss zuvor erstellt worden sein. |
|   | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
|   | schema | Zu erstellendes Application-Center-Datenbankschema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|   | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist false (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
| autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | min  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | max | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetcpu | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| pdb | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|  | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
|resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 1024Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1024Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |


> Das Lernprogramm zur Analyse von {{ site.data.keys.prod_adj }}-Protokollen mit Kibana finden Sie [hier](analyzing-mobilefirst-logs-on-icp/).

## Helm-Charts installieren
{: #install-hmc-icp}

### {{ site.data.keys.mf_analytics }} installieren
{: #install-mf-analytics}

Die Installation von {{site.data.keys.mf_analytics }} ist optional. Wenn Sie Analysen in {{site.data.keys.mf_server }} aktivieren möchten, sollten Sie {{site.data.keys.mf_analytics }} installieren und konfigurieren und installieren, bevor Sie {{site.data.keys.mf_server }} installieren.

Stellen Sie vor Beginn der Installation sicher, dass Sie alle **obligatorischen** Abschnitte unter ***[Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren]*** (#configure-install-mf-helmcharts) berücksichtigt haben.

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
    helm inspect values ibm-mfpf-analytics-prod-2.0.0.tgz > values.yaml
    ```    

3. Modifizieren Sie die Datei **values.yaml**. Fügen Sie die entsprechenden Werte vor der Implementierung des Helm-Charts hinzu. Vergewissern Sie sich, dass die Datenbankdetails, der Hostname für den Zugriff, die geheimen Schlüssel usw. hinzugefügt wurden, und speichern Sie die Datei values.yaml.

Weitere Einzelheiten enthält der Abschnitt [Umgebungsvariablen](#env-variables). 

4. Führen Sie zum Implementieren des Helm-Charts den folgenden Befehl aus:
    ```bash
    helm install -n <Name_des_IBM_Cloud-Kubernetes-Clusters> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Beispiel für die Implementierung von Analytics Server:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-2.0.0.tgz
    ```    

### {{ site.data.keys.mf_server }} installieren
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
    helm inspect values ibm-mfpf-server-prod-2.0.0.tgz > values.yaml
    ```

3. Modifizieren Sie die Datei **values.yaml**. Fügen Sie die entsprechenden Werte für die Implementierung des Helm-Charts hinzu. Vergewissern Sie sich, dass die Datenbankdetails, Ingress, die Skalierung usw. hinzugefügt wurden, und speichern Sie die Datei values.yaml.

4. Führen Sie zum Implementieren des Helm-Charts den folgenden Befehl aus:
    ```bash
    helm install -n <Name_des_IBM_Cloud-Kubernetes-Clusters> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    Beispiel für die Serverimplementierung:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-2.0.0.tgz
    ```

>**Hinweis:** Für die Installation des Application Center müssen Sie das entsprechende Helm-Chart verwenden (z. B. ibm-mfpf-appcenter-prod-2.0.0.tgz.tgz), wenn sie die obigen Schritte ausführen.

## Installation überprüfen
{: #verify-install}

Nachdem Sie die Mobile-Foundation-Komponenten installiert und konfiguriert haben, können Sie die IBM Cloud-CLI, die Kubernetes-CLI und Helm-Befehle verwenden, um Ihre Installation und den Status der implementierten Pods zu überprüfen.

Lesen Sie die [CLI-Befehlsreferenz](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) in der Dokumentation zur IBM Cloud-CLI und die Informationen zur Helm-CLI in der [Helm-Dokumentation](https://docs.helm.sh/helm/).

Auf der Seite "IBM Cloud Kubernetes Cluster" von IBM Cloud Portal können Sie die Schaltfläche **Kubernetes-Dashboard** verwenden, um die Kubernetes-Konsole zu öffnen und die Clusterartefakte zu verwalten. 

## Zugriff auf die {{site.data.keys.prod_adj }}-Konsole
{: #access-mf-console}

Nach einer erfolgreichen Installation können Sie auf die IBM {{ site.data.keys.prod_adj }} Operational Console zugreifen. Verwenden Sie `<Protokoll>://<öffentliche_IP-Adresse>:<Knotenport>/mfpconsole`.<br/>
Die IBM {{ site.data.keys.mf_analytics }} Console kann mit `<Protokoll>://<öffentliche_IP-Adresse>:<Port>/analytics/console` aufgerufen werden.
Das Protokoll kann `http` oder `https` sein. Beachten Sie außerdem, dass der Port im Falle einer **NodePort**-Implementierung **NodePort** lautet. Führen Sie im Kubernetes-Dashboard die folgenden Schritte aus, um die IP-Adresse und den **NodePort** Ihres installierten {{ site.data.keys.prod_adj }}-Charts zu erhalten: 
* Die öffentliche IP-Adresse (**Public IP**) können Sie abrufen, indem Sie **Kubernetes** > **Worker Nodes** auswählen. Notieren Sie die Adresse im Feld "Public IP".
* Den Knotenport (**Node port**) finden Sie im **Kubernetes-Dashboard**. Wählen Sie **Services** aus. Notieren Sie den Eintrag für *TCP Node Port* (eine fünfstellige Portnummer) unter den internen Endpunkten (**internal endpoints**).

Neben der *NodePort*-Methode für den Zugriff auf die Konsole können Sie auch den [Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html)-Host nutzen, um auf den Service zuzugreifen. 

Führen Sie für den Zugriff auf die Konsole die folgenden Schritte aus: 

1. Öffnen Sie das [**IBM Cloud-Dashboard**](https://console.bluemix.net/dashboard/apps/).
2. Wählen Sie den **Kubernetes-Cluster** aus, in dem `Analytics/Server/AppCenter` implementiert wurde, und öffnen Sie die Seite **Übersicht**.
3. Suchen Sie die Ingress-Unterdomäne für den Ingress-Hostnamen und greifen Sie wie folgt auf die Konsole zu:
    * Verwenden Sie für den Zugriff auf die IBM Mobile Foundation Operational Console Folgendes:
     `<Protokoll>://<Ingress-Hostname>/mfpconsole`
    * Verwenden Sie für den Zugriff auf die IBM Mobile Foundation Analytics Console Folgendes:
     `<Protokoll>://<Ingress-Hostname>/analytics/console`
    * Verwenden Sie für den Zugriff auf die IBM Mobile-Foundation-Application-Center-Konsole Folgendes:
     `<Protokoll>://<Ingress-Hostname>/appcenterconsole`
4. In Nginx Ingress ist die Unterstützung für SSL-Services standardmäßig inaktiviert. Beachten Sie die Konnektivität, während Sie über https auf die Konsole zugreifen. Führen Sie die folgenden Schritte aus, um SSL-Services für Ingress zu aktivieren.
    1. Starten Sie auf der Seite "IBM Cloud-Kubernetes-Cluster" das Kubernetes-Dashboard.
    2. Klicken Sie auf der linken Seite auf die Option "Ingresses".
    3. Wählen Sie den Ingress-Namen aus.
    4. Klicken Sie oben rechts auf die Schaltfläche "Bearbeiten".
    5. Modifizieren Sie die YAML-Datei. Fügen Sie eine Annotation für die SSL-Services hinzu.
    Beispiel:

    ```bash
    "annotations": {
      "ingress.bluemix.net/ssl-services": "ssl-service=my_service_name1;ssl-service=my_service_name2",
      .....
      ....
      ...
      ...
    }
    ```
   6. Klicken Sie auf "Aktualisieren".

>**Hinweis:** Der Port 9600 wird intern im Kubernetes-Service zugänglich gemacht und von den {{ site.data.keys.prod_adj }}-Analytics-Instanzen als Transportport verwendet. 

## Beispielanwendung
{: #sample-app}
Gehen Sie die [{{ site.data.keys.prod_adj }}-Lernprogramme](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) durch, um den Beispieladapter zu implementieren und die Beispielanwendung in einem IBM {{ site.data.keys.mf_server }} in einem IBM Cloud-Kubernetes-Cluster auszuführen.

## Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases
{: #upgrading-mf-helm-charts}

Unter [Upgrading bundled products](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/upgrade_helm.html) finden Sie Anweisungen zur Durchführung eines Upgrades für Helm-Charts bzw. Releases. 

### Beispielszenarien für Helm-Release-Upgrades

1. Für das Upgrade eines Helm-Release mit einer Änderung der Werte von `values.yaml` können Sie den Befehl `helm upgrade` mit der Option **--set** verwenden. Sie können die Option **-- set** mehrfach angeben. Priorität erhält die in der Befehlszeile ganz rechts angegebene Option "set". 
  ```bash
  helm upgrade --set <Name>=<Wert> --set <Name>=<Wert> <Name_des_vorhandenen_Helm-Release> <Pfad_des_neuen_Helm-Charts>
  ```

2. Wenn Sie ein Upgrade für ein Helm-Release mit Angabe von Werten in einer Datei durchführen, verwenden Sie den Befehl `helm upgrade` mit der Option **-f**. Sie können die Option **--values** oder **-f** mehrfach verwenden. Priorität erhält die in der Befehlszeile ganz rechts angegebene Datei (Option "-f"). Wenn im folgenden Beispiel sowohl `myvalues.yaml` als auch `override.yaml` einen Schlüssel *Test* enthält, hat der in `override.yaml` festgelegte Wert Vorrang. 
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <Name_des_vorhandenen_Helm-Release> <Pfad_des_neuen_Helm-Charts>
  ```

3. Wenn Sie ein Upgrade für ein Helm-Release durchführen und dabei die Werte des letzten Release wiederverwenden und einige der Werte überschreiben möchten, können Sie einen Befehl wie den folgenden verwenden: 
  ```bash
  helm upgrade --reuse-values --set <Name>=<Wert> --set <Name>=<Wert> <Name_des_vorhandenen_Helm-Release> <Pfad_des_neuen_Helm-Charts>
  ```

## Deinstallation
{: #uninstall}
Verwenden Sie zum Deinstallieren von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).
Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 
```bash
helm delete --purge <Releasename>
```
Hier steht *Releasename* für den implementierten Releasenamen des Helm-Charts. 

## Fehlerbehebung
{: #troubleshooting}

Im folgenden Abschnitt ist die Identifizierung und Lösung wahrscheinlicher Fehlerszenarien beschrieben, die während der Mobile-Foundation-Implementierung eintreten können.

1. Die Helm-Installation ist fehlgeschlagen (`Error: could not find a ready tiller pod`).

 - Führen Sie die folgende Befehlsgruppe wie angegeben aus und versuchen Sie, die Helm-Installation zu wiederholen.
  ```bash
  helm init
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm init --service-account tiller --upgrade
  ```

2. Während der Implementierung des Helm-Charts konnten keine Images per Pull-Operation übertragen werden (`Failed to pull image, Error: ErrImagePull`).

 - Vergewissern Sie sich, dass der geheime Pull-Schlüssel (pullSecret) für Images vor der Helm-Implementierung zur Datei values.yaml hinzgefügt wurde. Falls es keinen geheimen Schlüssel für die Pull-Übertragung von Images gibt, erstellen Sie ihn und weisen Sie ihn in der Datei *values.yaml* dem Parameter `image.pullSecret` zu.

 Beispiel für die Erstellung eines geheimen Pull-Schlüssels:

  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  ```

  > Hinweis: Übernehmen Sie den Wert `--docker-username=iamapikey` unverändert, wenn Sie die IBM Cloud-API für die Authentifizierung verwenden.

3. Konnektivitätsprobleme beim Zugriff auf die Konsole über Ingress.

 - Lösen Sie das Problem, indem Sie das Kubernetes-Dashboard starten und die Option 'Ingresses' auswählen. Bearbeiten Sie die Ingress-YAML-Datei. Fügen Sie die Ingress-Hostdetails wie unten angegeben hinzu.

    Beispiel:
    ```

   "spec": {
       "tls": [
         {
           "hosts": [
             “ingress_host_name”
           ],
           "secretName": "ingress-secret-name"
         }
       ],
       "rules": [
         {
        ….
	….
     ```
