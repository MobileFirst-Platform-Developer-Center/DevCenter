---
layout: tutorial
breadcrumb_title: Foundation in Red Hat OpenShift
title: Mobile Foundation auf einer vorhandenen Red-Hat-OpenShift-Containerplattform implementieren
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->

Hier erfahren Sie, wie die Mobile-Foundation-Instanz mit dem IBM Mobile Foundation Operator in einem OpenShift-Cluster installiert wird.

Die Nutzungsrechte für die Containerplattform OpenShift können Sie auf zwei Wegen erlangen.

* Sie verfügen über die Nutzungsrechte für IBM Cloud Pak for Applications. Diese schließen die Nutzungsrechte für die Containerplattform OpenShift mit ein.
* Sie haben die Containerplattform OpenShift bei Red Hat gekauft.

Die Implementierung der Mobile Foundation in OCP erfolgt unabhängig von den Nutzungsrechten für OCP immer gleich.

## Voraussetzungen
{: #prereqs}

Bevor Sie mit der Installation der Mobile-Foundation-Instanz unter Verwendung des Mobile Foundation Operator beginnen, müssen die folgenden Voraussetzungen erfüllt sein.

- Sie haben einen OpenShift-Cluster der Version 3.11 oder einer aktuelleren Version.
- Sie haben die [OpenShift-Client-Tools](https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html) (`oc`).
- Mobile Foundation erfordert eine Datenbank. Erstellen Sie eine unterstützte Datenbank und halten Sie die Details für den Datenbankzugriff bereit (siehe [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/)).
- Mobile Foundation Analytics erfordert einen angehängten Speicherdatenträger, auf dem Analytics-Daten persistent gespeichert werden können (NFS wird empfohlen).

## Architektur
{: #architecture}

Die folgende Abbildung zeigt die interne Architektur für mobile Services in Red Hat OpenShift.

![Architektur](./architecture-mf-on-openshift.png)

## IBM Mobile-Foundation-Instanz installieren

### IBM Mobile-Foundation-Paket herunterladen
{: #download-mf-package}

Laden Sie das IBM Mobile-Foundation-Paket für Openshift von [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) herunter. Entpacken Sie das Archiv in ein Verzeichnis mit dem Namen `workdir`.

  > **HINWEIS:** Wenn Sie das Passport-Advantage-Paket validieren und die Signatur überprüfen möchten, finden Sie [hier](./additional-docs/validating-ppa/) weitere Informationen.

### OpenShift-Projekt für die Mobile Foundation einrichten
{: #setup-openshift-for-mf}

1. Melden Sie sich beim OpenShift-Cluster an und erstellen Sie ein neues Projekt.   
   ```bash
   export MFOS_PROJECT=<Projektname>
   oc login -u <Benutzername> -p <Kennwort> <Cluster-URL>
   oc new-project $MFOS_PROJECT
   ```
2. Entpacken Sie das IBM Mobile-Foundation-Paket für Openshift mit folgendem Befehl:
  ```bash
  tar xzvf IBM-MobileFoundation-Openshift-Pak-<Version>.tar.gz -C <workdir>/
  ```
3. Laden Sie die Images lokal und übertragen Sie sie per Push-Operation in die OpenShift-Registry.   
   ```bash
    docker login -u <Benutzername> -p $(oc whoami -t) $(oc registry info)
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
      docker tag ${file/.tar.gz/} $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
      docker push $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
    done
   ```
4. Erstellen Sie einen geheimen Schlüssel mit Datenbankberechtigungsnachweisen.

    ```yaml
    cat <<EOF | oc apply -f -
    apiVersion: v1
    data:
      MFPF_ADMIN_DB_USERNAME: <base64-encoded-string>
      MFPF_ADMIN_DB_PASSWORD: <base64-encoded-string>
      MFPF_RUNTIME_DB_USERNAME: <base64-encoded-string>
      MFPF_RUNTIME_DB_PASSWORD: <base64-encoded-string>
      MFPF_PUSH_DB_USERNAME: <base64-encoded-string>
      MFPF_PUSH_DB_PASSWORD: <base64-encoded-string>
      MFPF_APPCNTR_DB_USERNAME: <base64-encoded-string>
      MFPF_APPCNTR_DB_PASSWORD: <base64-encoded-string>
    kind: Secret
    metadata:
    name: mobilefoundation-db-secret
    type: Opaque
    EOF
    ```
  > **HINWEIS**: Eine verschlüsselte Zeichenfolge kann mit `echo -n <zu_verschlüsselnde_Zeichenfolge> | base64` angefordert werden.

5. Konfigurieren Sie für Mobile Foundation Analytics einen persistenten Datenträger (Persistent Volume, PV).
    ```yaml
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      labels:
        name: mfanalyticspv  
      name: mfanalyticspv
    spec:
      capacity:
        storage: 20Gi
      accessModes:
        - ReadWriteMany
      persistentVolumeReclaimPolicy: Retain
      nfs:
        path: <Pfad_zum_angehängten_NFS-Datenträger>
        server: <Hostname_oder_IP-Adresse_des_NFS-Servers>
    EOF
    ```

6. Konfigurieren Sie für Mobile Foundation Analytics eine Anforderung eines persistenten Datenträgers (Persistent Volume Claim, PVC).
   ```yaml
   cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mfanalyticsvolclaim
      namespace: <Projektname_oder_Namespace>
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
      selector:
        matchLabels:
          name: mfanalyticspv
      volumeName: mfanalyticspv
    EOF
   ```

### IBM Mobile Foundation Operator implementieren
{: #deploy-mf-operator}

1. Stellen Sie sicher, das für den Operator in der Datei `deploy/operator.yaml` der Name des Operator-Image (*mf-operator*) mit Tag definiert ist (**REPO_URL**). 

    ```bash
    sed -i 's|REPO_URL|<Image-Repository-URL>:<image-tag>|g' deploy/operator.yaml
    ```

2. Stellen Sie sicher, dass in `deploy/cluster_role_binding.yaml` der Namespace für die Definition der Clusterrollenbindung definiert ist (**REPLACE_NAMESPACE**).

    ```bash
    sed -i 's|REPLACE_NAMESPACE|$MFOS_PROJECT|g' deploy/cluster_role_binding.yaml
    ```

    **Verwenden Sie ab Operator-Image-Tag 1.0.11 den folgenden Befehl.**

    ```bash
    sed -i 's|REPLACE_NAMESPACE|$MFOS_PROJECT|g' deploy/role_binding.yaml
    ```

3. Führen Sie die folgenden Befehle aus, um den die Definition für angepasste Ressourcen und den Operator zu implementieren und Einschränkungen für den Sicherheitskontext (SCC, Security Context Constraints) zu installieren.

    ```bash
    oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
    oc create -f deploy/
    oc adm policy add-scc-to-group mf-operator system:serviceaccounts:$MFOS_PROJECT
    ```
    **Verwenden Sie ab Operator-Image-Tag 1.0.11 die folgenden Befehle.**

    ```bash
    oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
    oc create -f deploy/
    oc adm policy add-scc-to-group mf-operator system:serviceaccounts:$MFOS_PROJECT
    oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:$MFOS_PROJECT:mf-operator
    ```


### IBM Mobile-Foundation-Komponenten implementieren
{: #deploy-mf-components}

1. Für die Implementierung einer Mobile-Foundation-Komponente müssen Sie die angepasste Ressourcenkonfiguration `deploy/crds/charts_v1_mfoperator_cr.yaml` gemäß Ihren Anforderungen modifizieren. Vollständige Referenzinformationen zur angepassten Konfiguration finden Sie [hier](./additional-docs/cr-configuration/).

   > **WICHTIGER HINWEIS**: Wenn Sie nach der Implementierung auf die Mobile-Foundation-Instanzen zugreifen möchten, müssen Sie den Ingress-Hostnamen konfigurieren. Stellen Sie sicher, dass Inngress in der Konfiguration für angepasste Ressourcen konfiguriert ist. Folgen Sie diesem [Link](./additional-docs/enable-ingress/) für weitere Informationen zur Konfiguration.

    ```bash
    oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
    ```
2. Führen Sie den folgenden Befehl aus und stellen Sie sicher, dass die Pods erstellt und erfolgreich ausgeführt werden. In einem Implementierungsszenario, bei dem Mobile Foundation Server und Push mit jeweils 3 Replikaten aktiviert sind (Standardeinstellung), sieht die Ausgabe wie folgt aus:

      ```bash
      $ oc get pods
      NAME                           READY     STATUS    RESTARTS   AGE
      mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
      mfpf-server-2327bbewss-3bw31   1/1       Running   0          1m 20s
      mfpf-server-29kw92mdlw-923ks   1/1       Running   0          1m 21s
      mfpf-server-5woxq30spw-3bw31   1/1       Running   0          1m 19s
      mfpf-push-2womwrjzmw-239ks     1/1       Running   0          59s
      mfpf-push-29kw92mdlw-882pa     1/1       Running   0          52s
      mfpf-push-1b2w2s973c-983lw     1/1       Running   0          52s
      ```
    > **HINWEIS:** Die Anzeige von Pods mit dem Status "Running (1/1)" bedeutet, dass auf den Service zugegriffen werden kann.
3. Überprüfen Sie, ob die Routen für den Zugriff auf die Mobile-Foundation-Endpunkte erstellt wurden. Führen Sie dazu den folgenden Befehl aus:

    ```bash
    $ oc get routes
    NAME                                      HOST/PORT               PATH        SERVICES             PORT      TERMINATION   WILDCARD
    ibm-mf-cr-1fdub-mfp-ingress-57khp   myhost.mydomain.com   /imfpush          ibm-mf-cr--mfppush     9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-8skfk   myhost.mydomain.com   /mfpconsole       ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-dqjr7   myhost.mydomain.com   /doc              ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-ncqdg   myhost.mydomain.com   /mfpadminconfig   ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-x8t2p   myhost.mydomain.com   /mfpadmin         ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-xt66r   myhost.mydomain.com   /mfp              ibm-mf-cr--mfpserver   9080                    None
    ```

### Zugriff auf die Konsole von IBM Mobile-Foundation-Komponenten

Nachfolgend sind die Endpunkte für den Zugriff auf die Konsolen von Mobile-Foundation-Komponenten angegeben.

  * **Administrationskonsole von Mobile Foundation Server**: `http://<ingress_hostname>/mfpconsole`
  * **Operational Analytics Console**: `http://<ingress_hostname>/analytics/console`
  * **Application-Center-Konsole**: `http://<ingress_hostname>/appcenterconsole`

## Deinstallation
{: #uninstall}

Verwenden Sie die folgenden Befehle, um eine Bereinigung nach der Installation durchzuführen.

```bash
oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
oc delete -f deploy/
oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
```

### Weitere Referenzinformationen

1. [Mobile-Foundation-Datenbanken einrichten](../../installation-configuration/production/prod-env/databases/)
2. [Oracle oder MySQL als IBM Mobile-Foundation-Datenbank verwenden](additional-docs/advanced-db-config/)
3. [Mobile-Foundation-Parameter für die Konfiguration angepasster Ressourcen](additional-docs/cr-configuration/)
4. [Szenarien für die Aktivierung von Ingress](additional-docs/enable-ingress/)
