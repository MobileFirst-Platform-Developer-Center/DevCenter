---
layout: tutorial
title: IBM Mobile Foundation für IBM Cloud Private installieren
breadcrumb_title: Foundation in IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Folgen Sie den nachstehenden Anweisungen, um eine MobileFirst-Server-Instanz, eine MobileFirst-Analytics-Instanz, eine MobileFirst-Push-Instanz und eine Instanz des {{ site.data.keys.mf_app_center}} für {{ site.data.keys.prod_icp }} zu konfigurieren. 

* Stellen Sie sicher, dass die Voraussetzungen erfüllt sind.
* Laden Sie das Passport-Advantage-Archiv mit {{ site.data.keys.product_full }} für {{ site.data.keys.prod_icp }} herunter.
* Laden Sie das Passport-Advantage-Archiv in den IBM Cloud-Private-Cluster.
* Installieren und konfigurieren Sie {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (optional), {{ site.data.keys.mf_push }} (optional) und das {{ site.data.keys.mf_app_center }} (optional).

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation herunterladen](#download-the-ibm-mfpf-ppa-archive)
* [Passport-Advantage-Archiv mit der IBM Mobile Foundation laden](#load-the-ibm-mfpf-ppa-archive)
* [Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts)
* [Erforderliche Ressourcen](#resources-required)
* [Installation überprüfen](#verify-install)
* [Beispielanwendung](#sample-app)
* [Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases durchführen](#upgrading-mf-helm-charts)
* [Migration auf das zertifizierte IBM Cloud Pak für die Mobile Foundation Platform](#migrate)
* [Sicherung und Wiederherstellung von MFP-Analytics-Daten](#backup-analytics)
* [Deinstallation](#uninstall)

## Voraussetzungen
{: #prereqs}

Sie müssen über ein IBM Cloud-Private-Konto verfügen und den [IBM Cloud-Private-Cluster](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup) eingerichtet haben.

Für die Verwaltung von Containern und Images müssen Sie im Rahmen des IBM Cloud-Private-Setups Folgendes auf Ihrer Hostmaschine installieren: 

* [Docker](https://docs.docker.com/install/) (installieren und konfigurieren)
* [IBM Cloud-CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started) (`cloudctl`)
* [Kubernetes-CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (`kubectl`)
* [Helm](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/app_center/create_helm_cli.html) (`helm`)

> Die unterstützte Docker-CLI-Version finden Sie [hier](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/supported_system_config/supported_docker.html). 

> Installieren Sie die gleiche Kube-CLI, IBM Cloud-CLI und Helm-Version wie in Ihrem ICP-Cluster (Download in der IBM Cloud-Private-Management-Konsole und Klick auf **Menü > Befehlszeilentools > Cloud-Private-CLI**).

Beispiel:

Für die Erstellung von Kubernetes-Artefakten wie geheimen Schlüsseln, persistenten Datenträgern und Anforderungen persistenter Datenträger in IBM Cloud Private benötigen Sie die CLI `kubectl`.

a. Installieren Sie die `kubectl`-Tools über die Managementkonsole von IBM Cloud Private. Klicken Sie auf **Menü > Befehlszeilentools > Cloud-Private-CLI**.

b. Erweitern Sie die Anzeige für **Kubernetes-CLI installieren**, um das Installationsprogramm mit einem `curl`-Befehl herunterzuladen. Kopieren Sie den curl-Befehl für Ihr Betriebssystem und führen Sie ihn aus. Fahren Sie dann mit der Installationsprozedur fort.

c. Wählen Sie den curl-Befehl für das betreffende Betriebssystem aus. Für Mac OS können Sie beispielsweise den folgenden Befehl ausführen:

   ```bash
   curl -kLo <Installationsdatei> https://<Cluster-IP-Adresse>:<Port>/api/cli/kubectl-darwin-amd64
   chmod 755 <Pfad_zum_Installationsprogramm>/<Installationsdatei>
   sudo mv <Pfad_zum_Installationsprogramm>/<Installationsdatei> /usr/local/bin/kubectl
   ```
Referenzinformationen finden Sie unter [Installing the Kubernetes CLI (kubectl)](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/manage_cluster/install_kubectl.html).

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
Bevor Sie das Passport-Advantage-Archiv mit der {{ site.data.keys.product }} laden, müssen Sie Docker einrichten. Anweisungen finden Sie [hier](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html).

Führen Sie die nachstehenden Schritte aus, um das Passport-Advantage-Archiv in den IBM Cloud-Private-Cluster zu laden:

  1. Melden Sie sich mit dem IBM Cloud-ICP-Plug-in (`cloudctl`) beim Cluster an.
      > Lesen Sie die [CLI-Befehlsreferenz](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html) in der Dokumentation zu {{ site.data.keys.prod_icp }}. 

     Beispiel: 

     ```bash
     cloudctl login -a https://ip:port
     ```
      Falls Sie die SSL-Validierung übergehen möchten, können Sie im obigen Befehl die Option `--skip-ssl-validation` verwenden. Bei Verwendung dieser Option werden Sie zur Eingabe von `Benutzername` und `Kennwort` Ihres Clusterendpunkts aufgefordert. Fahren Sie nach erfolgreicher Anmeldung mit den nachstehenden Schritten fort. 

  2. Laden Sie mit folgendem Befehl das Passport-Advantage-Archiv mit der {{ site.data.keys.product }}:
      ```
     cloudctl catalog load-ppa-archive --archive <Archivname> [--clustername <Clustername>] [--namespace <Namespace>]
     ```
     Der *Archivname* für die {{ site.data.keys.product }} ist der Name des Archivs, den Sie über IBM Passport Advantage heruntergeladen haben.

     Sie können `--clustername` ignorieren, wenn Sie den vorherigen Schritt ausgeführt und den Clusterendpunkt zum Standard für `cloudctl` gemacht haben.

  3.  Sie können die Docker-Images und Helm-Charts in der Managementkonsole von {{ site.data.keys.prod_icp }} anzeigen.
      Gehen Sie zum Anzeigen von Docker-Images wie folgt vor:
      * Wählen Sie **Platform > Container-Images** aus.
      * Helm-Charts werden im **Katalog** angezeigt.

  Nach Ausführung der obigen Schritte sehen Sie die hochgeladene Version der {{ site.data.keys.prod_adj }}-Helm-Charts im ICP-Katalog. {{ site.data.keys.mf_server }} wird als **ibm-mobilefoundation-prod** aufgelistet.

## Helm-Charts für die IBM {{ site.data.keys.product }} installieren und konfigurieren
{: #configure-install-mf-helmcharts}

Bevor Sie das {{ site.data.keys.mf_server }} installieren und konfigurieren, benötigen Sie Folgendes: 

Im folgenden Abschnitt sind die Schritte für die Erstellung geheimer Schlüssel zusammengefasst. 

Geheime Schlüsselobjekte bieten die Möglichkeit, sensible Daten wie Kennwörter, OAuth-Token, SSH-Schlüssel usw. zu speichern und zu verwalten. Die Aufnahme solcher Daten in einen geheimen Schlüssel ist sicherer und flexibler als die Aufnahme in eine Pod-Definition oder in ein Container-Image.

1. Obligatorisch: Eine vorkonfigurierte Datenbank ist erforderlich, um die technischen Daten der Komponenten Mobile Foundation Server und Application Center zu speichern.

   Sie müssen eines der folgenden unterstützten DBMS verwenden:

     1. **IBM DB2**
     2. **MySQL**
     3. **Oracle**

   Führen Sie die folgenden Schritte aus, wenn Sie die ***Oracle- oder MySQL-Datenbank*** verwenden.

   - Die JDBC-Treiber für Oracle und MySQL sind nicht im Installationsprogramm für die Mobile Foundation enthalten. Stellen Sie sicher, dass Sie den JDBC-Treiber haben (für MySQL den Connector/J-JDBC-Treiber, für Oracle den Oracle-Thin-JDBC-Treiber). Erstellen Sie einen angehängten Datenträger und platzieren Sie den JDBC-Treiber unter `/nfs/share/dbdrivers`.

   - Erstellen Sie einen persistenten Datenträger. Geben Sie dazu die NFS-Hostdetails und den Pfad an, unter dem der JDBC-Treiber gespeichert ist. Es folgt eine Beispieldatei `PersistentVolume.yaml`:
      ```
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        labels:
          name: mfppvdbdrivers
        name: mfppvdbdrivers
      spec:
        accessModes:
        - ReadWriteMany
        capacity:
          storage: 20Gi
        nfs:
          path: <NFS-Pfad>
          server: <NFS-Server>
       EOF
      ```
      > HINWEIS: Sie müssen die Einträge <NFS-Server> und <NFS-Pfad> zur obigen YAML-Datei hinzufügen.

    - Erstellen Sie eine Anforderung eines persistenten Datenträgers und geben Sie den Namen dieser Anforderung während der Implementierung im Helm-Chart an. Es folgt eine Beispieldatei `PersistentVolumeClaim.yaml`:
      ```bash
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: mfppvc
        namespace: my_namespace
      spec:
        accessModes:
        - ReadWriteMany
        resources:
          requests:
             storage: 20Gi
        selector:
          matchLabels:
            name: mfppvdbdrivers
        volumeName: mfppvdbdrivers
      status:
        accessModes:
        - ReadWriteMany
        capacity:
          storage: 20Gi
      EOF
      ```
   >HINWEIS: Sie müssen den richtigen Namespace zur obigen YAML-Datei hinzufügen.

2. Obligatorisch: Für die Anmeldung bei Server, Analytics und Application-Center-Konsole ist ein vorab erstellter **geheimer Anmeldeschlüssel** erforderlich. Beispiel:

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

3. Optional: Sie können Ihren eigenen Keystore und Truststore für die Implementierung von Server, Analytics und Application Center angeben, indem Sie mit Ihrem eigenen Keystore und Truststore einen geheimen Schlüssel erstellen.

   Erstellen Sie vorab einen geheimen Schlüssel mit `keystore.jks` und `truststore.jks` sowie ein Keystore- und Truststore-Kennwort. Verwenden Sie dafür die Literale KEYSTORE_PASSWORD und TRUSTSTORE_PASSWORD. Geben Sie den Namen des geheimen Schlüssels im Feld "keystoreSecret" für die betreffende Komponente an.

   Speichern Sie die Dateien `keystore.jks` und `truststore.jks` sowie die zugehörigen Kennwörter wie nachfolgend angegeben.  

   Beispiel:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > HINWEIS: Die Namen der Dateien und Literale müssen mit den Angaben im obigen Befehl übereinstimmen. Geben Sie diesen Namen des geheimen Schlüssels im Eingabefeld `keystoresSecretName` der jeweiligen Komponente an, um die Standard-Keystores beim Konfigurieren des Helm-Charts außer Kraft zu setzen. 

4. Optional: Mobile-Foundation-Komponenten können so konfiguriert werden, dass externe Clients unter Verwendung des Hostnamens auf die Komponenten zugreifen. Der Zugriff kann mit einem privaten TLS-Schlüssel und einem TLS-Zertifikat geschützt werden. Der private TLS-Schlüssel und das TLS-Zertifikat müssen in einem geheimen Schlüssel mit den Schlüsselnamen `tls.key` und `tls.crt` definiert werden.

   Der geheime Schlüssel **mf-tls-secret** wird in demselben Namespace wie die Zugriffsressource (Ingress) erstellt. Verwenden Sie dafür den folgenden Befehl:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```

   Der Name des geheimen Schlüssels wird dann im Feld global.ingress.secret angegeben. 

   > HINWEIS: Vermeiden Sie die Verwendung eines Hostnames für den Zugriff, wenn dieser bereits für ein anderes Helm-Release verwendet wurde. 

5. Optional: Zur Anpassung der Konfiguration (beispielsweise zur Änderung einer Protokolltraceeinstellung, zum Hinzufügen einer neuen JNDI-Eigenschaft usw.) müssen Sie eine Konfigurationszuordnung (configMap) mithilfe der XML-Konfigurationsdatei erstellen. So können Sie eine neue Konfigurationseinstellung hinzufügen oder die vorhandene Konfiguration der Mobile-Foundation-Komponenten überschreiben.

    Die Mobile-Foundation-Komponenten greifen auf die angepasste Konfiguration über eine configMap (mfpserver-custom-config) zu, die wie folgt erstellt wird:

	```bash
	kubectl create configmap mfpserver-custom-config --from-file=<Konfigurationsdatei im XML-Format>
	```

    Die mit dem obigen Befehl erstellte Konfigurationszuordnung (configMap) muss während der Mobile-Foundation-Implementierung in der **angepassten Serverkonfiguration** im Helm-Chart angegeben werden.

    Es folgt ein Beispiel für die Einstellung der Traceprotokollspezifikation auf Warnungen mithilfe der configMap mfpserver-custom-config. (Standardmäßig ist die Spezifikation auf Informationen eingestellt.)

    - XML-Beispielkonfiguration (logging.xml)

	```bash
    <server>
          <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
          maxFileSize="20" />
    </server>
	```

    - ConfigMap erstellen und während der Helm-Chart-Implementierung hinzufügen

	```bash
    kubectl create configmap mfpserver-custom-config --from-file=logging.xml
	```

    - Beachten Sie die Änderung in der Datei messages.log (von Mobile-Foundation-Komponenten): ***Property traceSpecification will be set to com.ibm.mfp.=debug:\*=warning.***

6. Optional: Mobile Foundation Server ist vorab mit vertraulichen Clients für den Verwaltungsservice definiert. Die Berechtigungsnachweise für diese Clients werden in den Feldern `mfpserver.adminClientSecret` und `mfpserver.pushClientSecret` angegeben.

   Sie können diese geheimen Schlüssel wie folgt erstellen: 

   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```

   > HINWEIS: Wenn die Werte für die Felder `mfpserver.pushClientSecret` und `mfpserver.adminClientSecret` nicht während der Implementierung des Helm-Charts für die Mobile Foundation bereitgestellt werden, werden eine Standardwerte für Authentifizierungs-ID und geheimen Schlüssel generiert und verwendet. Diese lauten `admin/nimda` für `mfpserver.adminClientSecret` und `push/hsup` für `mfpserver.pushClientSecret`.

7. Für die Analytics-Implementierung können Sie die folgenden Optionen für das persistente Speichern von Analytics-Daten auswählen:

    a) Der persistente Datenträger (`Persistent Volume (PV)`) und die Anforderung eines persistenten Datenträgers (`Persistent Volume Claim (PVC)`) sind bereit, sodass im Helm-Chart der PVC-Name angegeben werden kann.

      Beispiel:

      Beispieldatei `PersistentVolume.yaml`

      ```bash
	apiVersion: v1
	kind: PersistentVolume
	metadata:
	  labels:
	    name: mfvol
	  name: mfvol
	spec:
	  accessModes:
	  - ReadWriteMany
	  capacity:
	    storage: 20Gi
	  nfs:
	    path: <NFS-Pfad>
	    server: <NFS-Server>
      ```

    > HINWEIS: Sie müssen die Einträge <NFS-Server> und <NFS-Pfad> zur obigen YAML-Datei hinzufügen.

      Beispieldatei `PersistentVolumeClaim.yaml`

      ```bash
	apiVersion: v1
	kind: PersistentVolumeClaim
	metadata:
	  name: mfvolclaim
	  namespace: <Namespace>
	spec:
	  accessModes:
	  - ReadWriteMany
	  resources:
	    requests:
	      storage: 20Gi
	  selector:
	    matchLabels:
	      name: mfvol
	  volumeName: mfvol
	status:
	  accessModes:
	  - ReadWriteMany
	  capacity:
	    storage: 20Gi
	```

    > HINWEIS: Sie müssen den richtigen <Namespace> zur obigen YAML-Datei hinzufügen.

    b) Die dynamische Bereitstellung des Charts wird ausgewählt.

8. Obligatorisch: Sie müssen **geheime Datenbankschlüssel** für Server, Push und Application Center erstellen. In diesem Abschnitt sind die Sicherheitsmechanismen zur Steuerung des Datenbankzugriffs umrissen. Erstellen Sie mit dem angegebenen Unterbefehl einen geheimen Schlüssel und geben Sie unter den Datenbankdetails den Namen des erstellten geheimen Schlüssels an.

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

   In diesem Abschnitt sind die Sicherheitsmechanismen zur Steuerung des Datenbankzugriffs umrissen. Erstellen Sie mit dem angegebenen Unterbefehl einen geheimen Schlüssel und geben Sie unter den Datenbankdetails den Namen des erstellten geheimen Schlüssels an.

9. Optional: Ein separater geheimer Schlüssel für Datenbankverwaltung kann bereitgestellt werden. Die im geheimen Schlüssel für Datenbankverwaltung enthaltenen Benutzerdetails werden verwendet, um die Datenbankinitialisierung durchzuführen. Bei diesem Prozess werden das erforderliche Mobile-Foundation-Schema und die erforderlichen Tabellen in der Datenbank erstellt (sofern sie noch nicht vorhanden sind). Mithilfe des geheimen Schlüssels für Datenbankverwaltung können Sie die DDL-Operationen für Ihre Datenbankinstanz steuern.

    Wenn der geheime Schlüssel für MFP-Server-Datenbankverwaltung und MFP-Application-Center-Datenbankverwaltung (`MFP Server DB Admin Secret` und `MFP Appcenter DB Admin Secret`) nicht angegeben ist, wird für die Datenbankinitialisierung der Standardname für den geheimen Datenbankschlüssel (`Database Secret Name`) verwendet. 

    Führen Sie das folgende Code-Snippet aus, um einen geheimen Schlüssel für MFP-Server-Datenbankverwaltung (`MFP Server DB Admin Secret`) zu erstellen:

      ```bash
      # Geheimen Schlüssel für MFP-Server-DB-Verwaltung erstellen und Wert im Helm-Chart bei der Implementierung von Mobile Foundation Server aktualisieren
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      data:
        MFPF_ADMIN_DB_ADMIN_USERNAME: encoded_uname
        MFPF_ADMIN_DB_ADMIN_PASSWORD: encoded_password
        MFPF_RUNTIME_DB_ADMIN_USERNAME: encoded_uname
        MFPF_RUNTIME_DB_ADMIN_PASSWORD: encoded_password
        MFPF_PUSH_DB_ADMIN_USERNAME: encoded_uname
        MFPF_PUSH_DB_ADMIN_PASSWORD: encoded_password
      kind: Secret
      metadata:
        name: mfpserver-dbadminsecret
      type: Opaque
      EOF
      ```

    Führen Sie das folgende Code-Snippet aus, um einen geheimen Schlüssel für MFP-Application-Center-Datenbankverwaltung (`MFP Appcenter DB Admin Secret`) zu erstellen:      

      ```bash
      # Geheimen Schlüssel für Application-Center-Datenbankverwaltung erstellen und Wert im Helm-Chart bei der Implementierung des Mobile Foundation Application Center aktualisieren
      cat <<EOF | kubectl apply -f -
      apiVersion: v1
      data:
        APPCNTR_DB_ADMIN_USERNAME: encoded_uname
        APPCNTR_DB_ADMIN_PASSWORD: encoded_password
      kind: Secret
      metadata:
      name: appcenter-dbadminsecret
      type: Opaque
      EOF
      ```

10. Optional: Erstellen Sie die Container für Image-Richtlinien (**Image Policy**) und für geheime Image-Pull-Schlüssel (**Image pull secrets**) wenn die Container-Images per Pull-Operation aus einer Registry übertragen werden, die sich außerhalb der Container-Registry von IBM Cloud Private befindet (DockerHub, private Docker-Registry usw.).

   ```bash
	# Image-Richtlinie erstellen
	cat <<EOF | kubectl apply -f -
	apiVersion: securityenforcement.admission.cloud.ibm.com/v1beta1
	kind: ImagePolicy
	metadata:
	 name: image-policy
	 namespace: <Namespace>
	spec:
	 repositories:
	 - name: docker.io/*
	   policy: null
	 - name: <Name_des_Container-Image-Registry-Hosts>/*
	   policy: null
	EOF
   ```

   ```bash
   kubectl create secret docker-registry -n <Namespace> <Name_des_Container-Image-Registry-Hosts> --docker-username=<Docker-Registry-Benutzername> --docker-password=<Docker-Registry-Kennwort>
   ```

   > HINWEIS: Die Angaben in spitzen Klammern müssen durch tatsächliche Werte ersetzt werden. 


   Weitere Informationen finden Sie unter [Keystore für MobileFirst Server konfigurieren]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).

### Voraussetzungen für eine Pod-Sicherheitsrichtlinie

Dieses Chart erfordert eine Pod-Sicherheitsrichtlinie (PodSecurityPolicy), die vor der Implementierung an den Ziel-Namespace gebunden wird. Wählen Sie eine vordefinierte Pod-Sicherheitsrichtlinie aus oder lassen Sie einen Clusteradministrator eine angepasste Pod-Sicherheitsrichtlinie für Sie erstellen:

* Name der vordefinierten Pod-Sicherheitsrichtlinie: [`ibm-restricted-psp`](https://ibm.biz/cpkspec-psp)
* Definition einer angepassten Pod-Sicherheitsrichtlinie:

    ```bash
	apiVersion: extensions/v1beta1
	kind: PodSecurityPolicy
	metadata:
	  name: ibm-mobilefoundation-prod-psp
	  annotations:
	    apparmor.security.beta.kubernetes.io/allowedProfileNames: runtime/default
	    apparmor.security.beta.kubernetes.io/defaultProfileName: runtime/default
	    seccomp.security.alpha.kubernetes.io/allowedProfileNames: docker/default
	    seccomp.security.alpha.kubernetes.io/defaultProfileName: docker/default
	spec:
	  requiredDropCapabilities:
	  - ALL
	  volumes:
	  - configMap
	  - emptyDir
	  - projected
	  - secret
	  - downwardAPI
	  - persistentVolumeClaim
	  seLinux:
	    rule: RunAsAny
	  runAsUser:
	    rule: MustRunAsNonRoot
	  supplementalGroups:
	    rule: MustRunAs
	    ranges:
	    - min: 1
	      max: 65535
	  fsGroup:
	    rule: MustRunAs
	    ranges:
	    - min: 1
	      max: 65535
	  allowPrivilegeEscalation: false
	  forbiddenSysctls:
	  - "*"
    ```

   * Angepasste Clusterrolle (ClusterRole) für die angepasste Pod-Sicherheitsrichtlinie:

    ```bash
	apiVersion: rbac.authorization.k8s.io/v1
	kind: ClusterRole
	metadata:
	  name: ibm-mobilefoundation-prod-psp-clusterrole
	rules:
	- apiGroups:
	  - extensions
	  resourceNames:
	  - ibm-mobilefoundation-prod-psp
	  resources:
	  - podsecuritypolicies
	  verbs:
	  - use
    ```
    > HINWEIS: Die Pod-Sicherheitsrichtlinie muss nur einmal erstellt werden. Sollte sie bereits vorhanden sein, können Sie diesen Schritt überspringen.

   Der Clusteradministrator kann die obigen Definitionen für die Pod-Sicherheitsrichtlinie und die Clusterrolle in der Anzeige für Ressourcenerstellung auf der Benutzerschnittstelle einfügen oder die beiden folgenden Befehle ausführen:

```bash
    kubectl create -f <PSP-YAML-Datei>
    kubectl create clusterrole ibm-mobilefoundation-prod-psp-clusterrole --verb=use --resource=podsecuritypolicy --resource-name=ibm-mobilefoundation-prod-psp
```

   Außerdem müssen Sie die Rollenbindung (`RoleBinding`) erstellen:

```bash
    kubectl create rolebinding ibm-mobilefoundation-prod-psp-rolebinding --clusterrole=ibm-mobilefoundation-prod-psp-clusterrole --serviceaccount=<Namespace>:default --namespace=<Namespace>
```

## Erforderliche Ressourcen
{: #resources-required}

Dieses Chart verwendet standardmäßig die folgenden Ressourcen:

| Komponente | CPU  |Hauptspeicher| Datenspeicherung
|---|---|---|---|
| Mobile Foundation Server | **Mindstanforderung: ** 1000m CPU, **Oberer Grenzwert: ** 2000m CPU | **Mindestanforderung:** 2048 Mi Hauptspeicher, **Oberer Grenzwert:** 4096 Mi Hauptspeicher| Datenbankanforderungen finden Sie unter [Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts).
| Mobile Foundation Push | **Mindstanforderung: ** 1000m CPU, **Oberer Grenzwert: ** 2000m CPU | **Mindestanforderung:** 2048 Mi Hauptspeicher, **Oberer Grenzwert:** 4096 Mi Hauptspeicher| Datenbankanforderungen finden Sie unter [Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts).
| Mobile Foundation Analytics | **Mindstanforderung: ** 1000m CPU, **Oberer Grenzwert: ** 2000m CPU | **Mindestanforderung:** 2048 Mi Hauptspeicher, **Oberer Grenzwert:** 4096 Mi Hauptspeicher| Persistenter Datenträger. Weitere Informationen finden Sie unter [Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts).
| Mobile Foundation Application Center | **Mindstanforderung: ** 1000m CPU, **Oberer Grenzwert: ** 2000m CPU | **Mindestanforderung:** 2048 Mi Hauptspeicher, **Oberer Grenzwert:** 4096 Mi Hauptspeicher| Datenbankanforderungen finden Sie unter [Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts).

## Konfiguration
{: #configuration}

### Parameter
In der folgenden Tabelle sind die in der Mobile-Foundation-Server-Instanz, der Mobile-Foundation-Analytics-Instanz, der Mobile-Foundation-Push-Instanz und der Mobile-Foundation-Application-Center-Instanz für {{ site.data.keys.prod_icp }} verwendeten Umgebungsvariablen angegeben.

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|---|---|---|---|
| global.arch | amd64 | Planervorgabe für einen amd64-Worker-Knoten in einem Hybridcluster | 3 - Vorgabe (Standardwert) |
|      | ppcle64 | Planervorgabe für einen ppc64le-Worker-Knoten in einem Hybridcluster | 2 - Keine Vorgabe (Standardwert) |
|      | s390x | Planervorgabe für einen S390x-Worker-Knoten in einem Hybridcluster | 2 - Keine Vorgabe (Standardwert) |
| global.image     |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation | Always, Never oder IfNotPresent. Standardwert: IfNotPresent |
|      |  pullSecret    | Geheimer Image-Pull-Schlüssel | Nur erforderlich, wenn Images nicht von der ICP-Image-Registry bereitgestellt werden |
| global.ingress | hostname |Externer Hostname oder IP-Adresse für externe Clients | Lassen Sie das Parameterfeld leer, um standardmäßig die IP-Adresse des Cluster-Proxy-Knotens zu verwenden. |
|         | secret | Name des geheimen TLS-Schlüssels | Gibt den Namen des geheimen Schlüssels für das Zertifikat an, der in der Zugriffsdefinition (Ingress) verwendet werden muss. Der geheime Schlüssel muss vorab mit dem relevanten Zertifikat und Schlüssel erstellt worden sein. Obligatorisch, wenn SSL/TLS aktiviert ist. Erstellen Sie den geheimen Schlüssel mit dem Zertifikat und dem geheimen Schlüssel, bevor Sie hier den Namen angeben. |
|         | sslPassThrough | SSL-Durchgriff aktivieren | Gibt an, dass die SSL-Anforderung an den Mobile Foundation Servie übergeben werden soll. Der SSL-Abschluss erfolgt im Mobile Foundation-Service. Standardwert: false |
| global.dbinit | enabled | Initialisierung von Server-, Push- und Application-Center-Datenbank aktivieren | Initialisiert Datenbanken und erstellt Schemata/Tabellen für die Server-, Push- und Application-Center-Implementierung. (Für Analytics nicht erforderlich.) Standardwert: true |
|  | repository | Docker-Image-Repository für die Datenbankinitialisierung | Repository des Docker-Image für die Mobile-Foundation-Datenbank |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
| mfpserver | enabled          | Flag zum Aktivieren des Servers | true (Standardwert) oder false |
| mfpserver.image | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Server |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
|  mfpserver.db | host | IP-Adresse oder Hostname der Datenbank, für die Mobile-Foundation-Server-Tabellen konfiguriert werden müssen | IBM DB2® (Standardwert) |
|                       | port | 	Port, der für die Datenbank eingerichtet ist | |
|                       | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
|                       |name | Name der Mobile-Foundation-Server-Datenbank | |
|                       | schema |Zu erstellendes Server-DB2-Schema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|                       | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist false (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
|                       | driverPvc | Anforderung eines persistenten Datenträgers für den Zugriff auf den JDBC-Datenbanktreiber | Geben Sie der Anforderung eines persistenten Datenträgers für den JDBC-Datenbanktreiber an. Erforderlich, wenn der ausgewählte Datenbanktyp nicht DB2 ist. |
|                       | adminCredentialsSecret | Geheimer Schlüssel für MFP-Server-Datenbankverwaltung | Wenn Sie die Datenbankinitialisierung aktiviert haben, geben Sie den geheimen Schlüssel an, um Datenbanktabellen und Schemata für Mobile-Foundation-Komponenten zu erstellen. |
| mfpserver | adminClientSecret | Geheimer Clientschlüssel für Verwaltung | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. Informationen dazu finden Sie unter Punkt 6 im Abschnitt [Voraussetzungen](#Prerequisites). |
|  | pushClientSecret | Geheimer Clientschlüssel für Push | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. Informationen dazu finden Sie unter Punkt 6 im Abschnitt [Voraussetzungen](#Prerequisites). |
| mfpserver.replicas |  | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: 3) |
| mfpserver.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicas" inaktiviert. | false (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "min" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| mfpserver.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|    mfpserver.customConfiguration |  |  Angepasste Serverkonfiguration (optional)  | Geben Sie einen zusätzlichen serverspezifische Verweis auf eine vorab erstellte configMap an. |
| mfpserver.jndiConfigurations |mfpfProperties |JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfpserver | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpserver.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | enabled          | Flag zur Aktivierung von Mobile Foundation Push | true (Standardwert) oder false |
|           | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Push|
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
| mfppush.replicas | | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: 3) |
| mfppush.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| mfppush.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
| mfppush.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Push-spezifischen Verweis auf eine vorab erstellte configMap an. |
| mfppush.jndiConfigurations |mfpfProperties |JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfppush |keystoresSecretName | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfppush.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics | enabled          | Flag zum Aktivieren von Analytics | false (Standardwert) oder true |
| mfpanalytics.image | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Operational Analytics |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
| mfpanalytics.replicas |  | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Operational Analytics | Positive ganze Zahl (Standardwert: 2) |
| mfpanalytics.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
|  mfpanalytics.shards|  | Anzahl der Elasticsearch-Shards für Mobile Foundation Analytics | Standardwert: 2|             
|  mfpanalytics.replicasPerShard|  | Anzahl der pro Shard für Mobile Foundation Analytics zu verwaltenden Elasticsearch-Replikate | Standardwert: 2|
| mfpanalytics.persistence | enabled         | Verwenden Sie eine Anforderung eines persistenten Datenträgers zum persistenten Speichern von Daten. | true |                                                 |
|            |useDynamicProvisioning | Geben Sie eine Speicherklasse an oder lassen Sie das Feld leer. | false  |                                                  |
|           |volumeName| Geben Sie einen Datenträgernamen an.  | data-stor (Standardwert) |
|           |claimName|Geben Sie eine vorhandene Anforderung eines persistenten Datenträgers an. | nil |
|           |storageClassName     | Speicherklasse der unterstützenden Anforderung eines persistenten Datenträgers | nil |
|           |size    | Größe des Datenträgers | 20Gi |
| mfpanalytics.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|    mfpanalytics.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Analytics-spezifischen Verweis auf eine vorab erstellte configMap an. |
| mfpanalytics.jndiConfigurations |mfpfProperties | Mobile-Foundation-JNDI-Eigenschaften, die für die Anpassung von Operational Analytics angegeben werden müssen | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfpanalytics | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpanalytics.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 2000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 4096Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 2048Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpappcenter | enabled          | Flag zum Aktivieren des Application Center | false (Standardwert) oder true |  
| mfpappcenter.image | repository | Docker-Image-Repository | Repository des Docker-Image für das Mobile Foundation Application Center |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Siehe Abschnitt zu den Voraussetzungen |
|  mfpappcenter.db | host | IP-Adresse oder Hostname für die Konfiguration der Application-Center-Datenbank | |
|                       | port | 	Port der Datenbank  | |             
|                       |name |Name der zu verwendenden Datenbank |Die Datenbank muss zuvor erstellt worden sein. |
|                       | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
|                       | schema | Zu erstellendes Application-Center-Datenbankschema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|                       | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist false (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
|                       | driverPvc | 	 Anforderung eines persistenten Datenträgers für den Zugriff auf den JDBC-Datenbanktreiber | Geben Sie der Anforderung eines persistenten Datenträgers für den JDBC-Datenbanktreiber an. Erforderlich, wenn der ausgewählte Datenbanktyp nicht DB2 ist. |
|                       | adminCredentialsSecret | Geheimer Schlüssel für Application-Center-Datenbankverwaltung | Wenn Sie die Datenbankinitialisierung aktiviert haben, geben Sie den geheimen Schlüssel an, um Datenbanktabellen und Schemata für Mobile-Foundation-Komponenten zu erstellen. |
| mfpappcenter.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | false (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: 1) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: 10) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
| mfpappcenter.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | true (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
| mfpappcenter.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Application-Center-spezifischen Verweis auf eine vorab erstellte configMap an. |
| mfpappcenter | keystoreSecret | Im Konfigurationsabschnitt ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpappcenter.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität | Der Standardwert ist 1024Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1000m. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1024Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

> Das Lernprogramm zur Analyse von {{ site.data.keys.prod_adj }}-Protokollen mit Kibana finden Sie [hier](analyzing-mobilefirst-logs-on-icp/).

### {{ site.data.keys.prod_adj }}-Helm-Charts aus dem ICP-Katalog installieren
{: #install-hmc-icp}

#### {{ site.data.keys.mf_server }} installieren
{: #install-mf-server}

Neben {{ site.data.keys.mf_server }} können Sie mit dem Chart {{ site.data.keys.mf_analytics }} und das {{ site.data.keys.mf_app_center }} implementieren. Die Implementierung von {{ site.data.keys.mf_analytics }} und des {{ site.data.keys.mf_app_center }} ist jedoch optional.

Hinweis:

1. Bevor Sie mit der Installation von {{ site.data.keys.mf_server }} beginnen, benötigen Sie eine vorkonfigurierte DB2-Datenbank. 
2. Bevor Sie mit der Installation des MobileFirst-Analytics-Charts beginnen, müssen Sie den **persistenten Datenträger** konfigurieren. Geben Sie den **persistenten Datenträger** für die Konfiguration von {{site.data.keys.mf_analytics }} an. Führen Sie für die Erstellung des **persistenten Datenträgers** die Schritte in der [IBM Cloud-Private-Dokumentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_cluster/create_volume.html) aus. Die YAML-Beispieldatei finden Sie unter **Punkt 6** im Abschnitt [Helm-Charts für IBM {{ site.data.keys.product }} installieren und konfigurieren](#configure-install-mf-helmcharts).

Führen Sie die folgenden Schritte aus, um die IBM Mobile Foundation in der Managementkonsole von {{ site.data.keys.prod_icp }} zu installieren und zu konfigurieren. 

1. Navigieren Sie in der Managementkonsole zum **Katalog**.
2. Wählen Sie das Helm-Chart **ibm-mobilefoundation-prod** aus.
3. Klicken Sie auf **Konfigurieren**.
4. Geben Sie die Umgebungsvariablen an. Weitere Informationen finden Sie unter [Konfiguration](#configuration).
5. Akzeptieren Sie die  ** Lizenzvereinbarung **.
6. Klicken Sie auf **Installieren**.

> HINWEIS: Das neueste Paket mit Mobile Foundation für ICP enthält die folgende unterstützte Software:
> 1. IBM JRE8 SR5 FP37 (8.0.5.37)
> 2. IBM WebSphere Liberty Version 18.0.0.5

## Installation überprüfen
{: #verify-install}

Nachdem Sie {{ site.data.keys.mf_analytics }} (optional) und {{ site.data.keys.mf_server }} installiert und konfiguriert haben, können Sie wie folgt Ihre Installation und den Status der implementierten Pods überprüfen:

Wählen Sie in der Managementkonsole von {{ site.data.keys.prod_icp }} **Workloads > Helm Releases** aus. Klicken Sie auf den *Releasenamen* für Ihre Installation. 

## Zugriff auf die {{site.data.keys.prod_adj }}-Konsole
{: #access-mf-console}

Die Implementierung nach einer erfolgreichen Installation kann einige Minuten dauern. 

Rufen Sie in einem Web-Browser die Seite mit der Konsole von IBM Cloud Private auf und navigieren Sie wie folgt zur Seite mit den Helm-Releases:
1. Klicken Sie oben links auf der Seite auf "Menü".
2. Wählen Sie "Workloads" > "Helm-Releases" aus.
3. Klicken Sie auf das implementierte Helm-Release für IBM Mobile Foundation.
4. Lesen Sie die [HINWEISE](https://github.ibm.com/MobileFirst/ibm-mobilefoundation-prod/blob/development/stable/ibm-mobilefoundation-prod/templates/NOTES.txt), um zu erfahren, wie auf die Mobile Foundation Server Operations Console zugegriffen wird.

## Beispielanwendung
{: #sample-app}
Gehen Sie die [{{ site.data.keys.prod_adj }}-Lernprogramme](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/) durch, um den Beispieladapter zu implementieren und die Beispielanwendung in einem IBM {{ site.data.keys.mf_server }} in {{ site.data.keys.prod_icp }} auszuführen.

## Upgrade für {{ site.data.keys.prod_adj }}-Helm-Charts und -Releases
{: #upgrading-mf-helm-charts}

Unter [Upgrading bundled products](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html) finden Sie Anweisungen zur Durchführung eines Upgrades für Helm-Charts bzw. Releases. 

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

## Migration auf das zertifizierte IBM Cloud Pak für die Mobile Foundation Platform
{: #migrate}

Das [zertifizierte IBM Cloud Pak](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/app_center/cloud_paks_over.html) ermöglicht die Implementierung der Mobile Foundation als einzelnes Helm-Chart. Dieser Ansatz ersetzt die bisherige Vorgehensweise mit drei verschiedenen Helm-Charts (ibm-mfpf-server-prod, ibm-mfpf-analytics-prod und ibm-mfpf-appcenter-prod) für die Implementierung der Mobile-Foundation-Komponenten.

Die Migration der alten, als separate Helm-Releases in der ICP-Implementierung installierten Mobile-Foundation-Komponenten auf das neue konsolidierte Helm-Chart mit zertifiziertem IBM Cloud Pak ist einfach. 

1. Sie können alle Konfigurationsparameter für Server, Push, Application Center und Analytics beibehalten.
2. Wenn die gleichen Datenbankdetails wie für die alte Implementierung verwendet werden, enthält Ihre neue Mobile-Foundation-Implementierung (Server, Push und Application Center) die gleichen Daten wie die alte Implementierung.
3. Beachten Sie die Änderung bei den einzugebenden Datenbankwerten. Der Zugriff auf die Datenbank wird jetzt mit geheimen Schlüsseln gesteuert. Unter Punkt 4 des Abschnitts [Voraussetzungen](#Prerequisites) erfahren Sie, wie geheime Schlüssel für Berechtigungsnachweise (unter anderem für die Konsolenanmeldung, für Datenbankkonten usw.) erstellt werden.
4. Die Daten von Mobile Foundation Analytics können Sie erhalten, wenn Sie die Anforderung eines persistenten Datenträgers aus der alten Implementierung verwenden.

## Sicherung und Wiederherstellung von MFP-Analytics-Daten
{: #backup-analytics}

Die MFP-Analytics-Daten sind im Rahmen eines Kubernetes-[PV oder -PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) verfügbar. Möglicherweise verwenden Sie eines der von [Kubernetes angebotenen Volume-Plug-ins](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes).

Sicherung und Wiederherstellung sind von den verwendeten Volume-Plug-ins abhängig. Es gibt diverse Möglichkeiten/Tools für die Sicherung oder Wiederherstellung des Dateträgers (Volume).

Kuberenetes bietet die Optionen [**VolumeSnapshot, VolumeSnapshotContent und Restore**](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature) an. Sie können eine Kopie des [Clusterdatenträgers](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) erstellen, der von einem Administrator bereitgestellt wurde.

Verwenden Sie die folgenden [YAML-Beispieldateien](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes), um das Feature für Momentaufnahmen zu testen.

Sie können auch andere Tools für die Sicherung und Wiederherstellung des Datenträgers nutzen.

- IBM Cloud Automation Manager (CAM) für ICP

    Nutzen Sie die Möglichkeiten und Stategien für [Sicherung/Wiederherstellung, Hohe Verfügbarkeit und Disaster Recovery für CAM-Instanzen](https://developer.ibm.com/cloudautomation/2018/05/08/backup-ha-dr/).

- [Portworx](https://portworx.com) für ICP

    Diese Speicherlösung wurde für Anwendungen entwickelt, die als Container oder über einen Containerkoordinator wie Kubernetes implementiert werden.

- Stash von [AppsCode](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/)

    Mithilfe von Stash können Sie die Datenträger in Kubernetes sichern.

## Deinstallation
{: #uninstall}
Verwenden Sie zum Deinstallieren von {{ site.data.keys.mf_server }} und {{ site.data.keys.mf_analytics }} die [Helm-CLI](https://docs.helm.sh/using_helm/#installing-helm).
Mit dem folgenden Befehl werden die installierten Charts und die zugehörigen Implementierungen vollständig gelöscht: 

```bash
helm delete <Release> --purge --tls
```
Hier steht *Release* für den Namen des implementierten Release des Helm-Charts.

Dieser Befehl entfernt alle Kubernetes-Komponenten des Charts (mit Ausnahme von Anforderungen persistenter Datenträger). Dieses Standardverhalten von Kubernetes stellt sicher, dass die geschäftskritischen Daten nicht gelöscht werden.
