---
layout: tutorial
breadcrumb_title: Foundation on IBM Cloud OpenShift
title: Mobile Foundation für die Containerplattform Red Hat OpenShift in IBM Cloud implementieren
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->

### Voraussetzungen
{: #prereqs}

Bevor Sie mit der Installation der Mobile-Foundation-Instanz beginnen, müssen die folgenden Voraussetzungen erfüllt sein.

- [Erstellen Sie einen OpenShift-Cluster](https://cloud.ibm.com/kubernetes/registry/main/namespaces?platformType=openshift) in IBM Cloud mit Ihrem [IBM Konto](https://myibm.ibm.com).
- Laden Sie die [IBM Cloud-CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-install-ibmcloud-cli) (`ibmcloud`) herunter.
- Laden Sie das IBM Mobile-Foundation-Paket für Openshift von [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html) herunter.
- Mobile Foundation erfordert eine Datenbank. Erstellen Sie eine unterstützte Datenbank und halten Sie die Details für den Datenbankzugriff bereit (siehe [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/)).
- Erstellen Sie optional einen angehängten NFS-Datenträger oder einen [Dateispeicher](https://cloud.ibm.com/docs/containers?topic=containers-file_storage) für Mobile Foundation Analytics.

### Schritte für die Implementierung der Mobile Foundation in einem Red-Hat-OpenShift-Cluster in IBM Cloud
{: #steps-deployment}

Führen Sie die hier beschriebenen Schritte aus, um das Paket mit der Mobile Foundation für OCP (OpenShift Container Platform) in einem Red-Hat-OpenShift-Cluster in IBM Cloud zu implementieren.

1.  Übertragen Sie das Image per Push-Operation in Ihre private Registry und erstellen Sie einen geheimen Schlüssel, der verwendet wird, wenn das Image per Pull-Operation übertragen werden muss.

    a. Melden Sie sich bei IBM Cloud an.

    ```bash
    ibmcloud login
    ```

    b. Melden Sie sich bei der internen Docker-Registry von OpenShift an. Führen Sie dazu die folgenden Befehle aus:

    ```bash
    # Route vom Terminal zur Docker-Registry erstellen
    oc create route reencrypt --service=docker-registry -n default
    oc get route docker-registry -n default

    # Anmeldung bei der internen Container-Registry von OpenShift
    docker login -u $(oc whoami) -p $(oc whoami -t) <Docker-Registry-URL>
    ```

    Beispiel:

    ```bash
    $ oc get route docker-registry -n default
    NAME              HOST/PORT                                              PATH      SERVICES          PORT       TERMINATION   WILDCARD
    docker-registry   docker-registry-default.-xxxx.appdomain.cloud    docker-registry                   5000-tcp   reencrypt     None

    $ docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.-xxxx.appdomain.cloud
    Login Succeeded
    ``>


    c. Entpacken Sie das Passport-Advantage-Archiv in einem Arbeitsverzeichnis (z. B. `mfoskpg`) und laden Sie die IBM Mobile-Foundation-Images lokal.

    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<Version>.tar.gz -C mfospkg/

    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    export MFOS_PROJECT=<Namespace>
    export CONTAINER_REGISTRY_URL=<Docker-Registry-URL>    # z. B. docker-registry-default.-xxxx.appdomain.cloud
    ```

    d. Laden Sie die Images von der lokalen Maschine und übertragen Sie sie per Push-Operation in die OpenShift-Registry.

    ```bash
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
    docker tag ${file/.tar.gz/} $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    docker push $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    done
    ```

    > **WICHTIGER HINWEIS:** Wenn Sie anschließend auf die Container-Images in der internen Container-Registry von OpenShift zugreifen möchten, verwenden Sie `docker-registry.default.svc:5000/<Projektname>/<Image-Name>:<Image-Tag>` als Image-URL.

2. Erstellen Sie ein OpenShift-Projekt.

    a. Öffnen Sie das OpenShift-Cluster-Dashboard in [IBM Cloud](https://cloud.ibm.com/kubernetes/clusters?platformType=openshift).

    b. Rufen Sie die Registerkarte **Zugriff** auf und befolgen Sie die Anweisungen für den Zugriff auf die OpenShift-Konsole.

    c. Klicken Sie auf der Clusterseite auf die Schaltfläche **OpenShift-Webkonsole**, um die OpenShift-Konsole zu öffnen.

    d. Erstellen Sie in der Webkonsole ein OpenShift-Projekt. (Alternativ können Sie die `oc`-CLI verwenden, um das Projekt zu erstellen. Weitere Informationen finden Sie in der [Dokumentation](https://docs.openshift.com/container-platform/3.11/dev_guide/projects.html#create-a-project-using-the-cli).)

3. Implementieren Sie den Operator.

    a. Stellen Sie sicher, das für den Operator in der Datei `deploy/operator.yaml` das MF-Operator-Image (**mf-operator**) mit Tag definiert ist. (Ersetzen Sie den Platzhalter REPO_URL durch die interne Registry-URL des OpenShift-Containers, z. B. `docker-registry.default.svc:5000/myprojectname/mf-operator:1.0.1`.)

    b. Stellen Sie sicher, dass in `deploy/cluster_role_binding.yaml` der OpenShift-Projektname für die Definition der Clusterrollenbindung definiert ist. (Ersetzen Sie den Platzhalter REPLACE_NAMESPACE.)

    c. Führen Sie die folgenden Befehle aus, um den Operator zu implementieren und Einschränkungen für den Sicherheitskontext (SCC, Security Context Constraints) zu installieren.

    ```bash
     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # Verwenden Sie den Befehl mit Ihrem eigenen <Projektnamen>
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<Projektname>
    ```

     Der Befehl erstellt den Pod mf-operator und führt ihn aus. Listen Sie die Pods auf und vergewissern Sie sich, dass der Pod erfolgreich erstellt wurde. Die Ausgabe sieht wie folgt aus:

    ```bash
    $ oc get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

4.  Erstellen Sie einen geheimen Schlüssel, damit die IBM Mobile-Foundation-Implementierung auf die Datenbank zugreifen kann.
    > Weitere Informationen finden Sie [hier](../mobilefoundation-on-openshift/#setup-openshift-for-mf) in der Dokumentation.

5.  Erstellen Sie für Analytics einen persistenten Datenträger und eine Anforderung eines persistenten Datenträgers.
    > Weitere Informationen finden Sie [hier](../mobilefoundation-on-openshift/#setup-openshift-for-mf) in der Dokumentation.

6.  Implementieren Sie die IBM Mobile-Foundation-Komponenten.

    Für die Implementierung einer Mobile-Foundation-Komponente müssen Sie die entsprechenden angepassten Ressourcenwerte in der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` modifizieren.

    a.  Definieren Sie die Docker-Repository-URL in der Datei `deploy/crds/charts_v1_mfoperator_cr.yaml`. Ersetzen Sie den Platzhalter REPO_URL (z. B. durch `docker-registry.default.svc:5000/myprojectname/mfpf-server:2.0.1`).

    b.  OPTIONAL: Wenn sich die Image-Registry außerhalb des OpenShift-Clusters befindet, fügen Sie die den geheimen Pull-Schlüssel (**pullSecret**) zur Datei `deploy/crds/charts_v1_mfoperator_cr.yaml` hinzu. Die Definition des geheimen Schlüssels könnte in etwa wie der folgende Beispielausschnitt aussehen:

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: pull-secret-name
    ```

    Wie die Konfiguration vervollständigt wird (z. B. in den Bereichen Replikate, Skalierung, DB-Eigenschaften usw.), erfahren Sie [hier](../mobilefoundation-on-openshift/#deploy-mf-operator) in der Dokumentation.

7. Erstellen oder aktualisieren Sie die angepasste Ressource. Mit diesem Schritt erstellen Sie die Pods für alle in der YAML-Datei der angepassten Ressource aktivierten Mobile-Foundation-Komponenten und führen sie aus.

	```bash
	oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
	```

    Führen Sie den folgenden Befehl aus und stellen Sie sicher, dass die Pods erstellt und erfolgreich ausgeführt werden. In einem Implementierungsszenario, bei dem Mobile Foundation Server und Push mit jeweils 3 Replikaten aktiviert sind (Standardeinstellung), sieht die Ausgabe wie folgt aus:

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

8. Überprüfen Sie, ob die Routen für den Zugriff auf die Mobile-Foundation-Endpunkte erstellt wurden. Führen Sie dazu den folgenden Befehl aus:

    ```bash
    $ oc get routes
    NAME                                      HOST/PORT               PATH        SERVICES             PORT      TERMINATION   WILDCARD
    ibm-mf-cr-1fdub-mfp-ingress-57khp   myhost.mydomain.cloud   /imfpush          ibm-mf-cr--mfppush     9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-8skfk   myhost.mydomain.cloud   /mfpconsole       ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-dqjr7   myhost.mydomain.cloud   /doc              ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-ncqdg   myhost.mydomain.cloud   /mfpadminconfig   ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-x8t2p   myhost.mydomain.cloud   /mfpadmin         ibm-mf-cr--mfpserver   9080                    None
    ibm-mf-cr-1fdub-mfp-ingress-xt66r   myhost.mydomain.cloud   /mfp              ibm-mf-cr--mfpserver   9080                    None
    ```

### Zugriff auf die Konsole von IBM Mobile-Foundation-Komponenten

Nachfolgend sind die Endpunkte für den Zugriff auf die Konsolen von Mobile-Foundation-Komponenten angegeben.

  * **Administrationskonsole von Mobile Foundation Server**: `http://<ingress_subdomain>/mfpconsole`
  * **Operational Analytics Console**: `http://<ingress_subdomain>/analytics/console`
  * **Application-Center-Konsole**: `http://<ingress_subdomain>/appcenterconsole`

### Deinstallation

Mit den folgenden Schritten können Sie die Implementierung bereinigen.

* Löschen Sie die angepasste Ressource und die zugehörige Definition. Führen Sie dazu die folgenden Schritte aus:

	```bash
	oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
	oc delete -f deploy/
	oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
	oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
	```

### Weitere Informationen

Wenn Sie das Berechtigungsproblem beim Schreiben von Analytics-Daten auf den persistenten Datenträger umgehen möchten, führen Sie für Mobile Foundation Analytics mit Dateispeicher in IBM Cloud den folgenden Befehl aus:

```bash
oc run perms-pod --overrides='
{
        "spec": {
            "containers": [
                {
                    "command": [
                        "/bin/sh",
                        "-c",
                        "mkdir -p /usr/ibm/wlp/usr/servers/mfpf-analytics/analyticsData && chown -R 1001:0 /usr/ibm/wlp/usr/servers/mfpf-analytics/analyticsData"
                    ],
                    "image": "alpine:3.2",
                    "name": "perms-pod",
                    "volumeMounts": [{
                        "mountPath": "/opt/ibm/wlp/usr/servers/mfpf-analytics/analyticsData",
                        "name": "pvc-data"
                    }]
                }
            ],        
            "volumes": [
                {
                    "name": "pvc-data",
                    "persistentVolumeClaim": {
                        "claimName": "<pvc-name>"
                    }
                }
            ]
        }
}
'  --image=notused --restart=Never
```
