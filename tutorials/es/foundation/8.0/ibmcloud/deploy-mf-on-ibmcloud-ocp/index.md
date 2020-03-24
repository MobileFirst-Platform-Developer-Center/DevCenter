---
layout: tutorial
breadcrumb_title: Foundation en IBM Cloud OpenShift
title: Despliegue de Mobile Foundation en Red Hat OpenShift Container Platform en IBM Cloud
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->

### Requisitos previos
{: #prereqs}

A continuación se muestran los requisitos previos antes de iniciar el proceso de instalación de la instancia de Mobile Foundation.

- [Cree un clúster de OpenShift](https://cloud.ibm.com/kubernetes/registry/main/namespaces?platformType=openshift) en IBM Cloud utilizando su [cuenta de IBM](https://myibm.ibm.com).
- [CLI de IBM Cloud](https://cloud.ibm.com/docs/cli?topic=cloud-cli-install-ibmcloud-cli) (`ibmcloud`).
- Descargue el paquete de IBM Mobile Foundation para Openshift desde [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). 
- Mobile Foundation requiere una base de datos. Cree una base de datos soportada y conserve los detalles de acceso a la base de datos para utilizarlos más adelante. Consulte [aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/).
- [Opcional] Volumen montado en NFS (o) [Almacenamiento de archivos](https://cloud.ibm.com/docs/containers?topic=containers-file_storage) para Mobile Foundation Analytics.

### Pasos para el despliegue de Mobile Foundation en el clúster de Red Hat OpenShift en IBM Cloud
{: #steps-deployment}

Siga los pasos que se describen en esta sección para desplegar el paquete de Mobile Foundation OpenShift Container Platform (OCP) en el clúster de Red Hat OpenShift en IBM Cloud. 

1.  Envíela imagen a su registro privado y cree un secreto que se puede utilizar en el momento de la extracción de la imagen.

    a. Inicie sesión en IBM Cloud.

    ```bash
    ibmcloud login
    ```

    b. Inicie sesión en el registro de Docker interno de OpenShift ejecutando los mandatos siguientes. 

    ```bash
    # Create a route from the terminal to the docker registry
    oc create route reencrypt --service=docker-registry -n default
    oc get route docker-registry -n default

    # login into the OpenShift internal container registry
    docker login -u $(oc whoami) -p $(oc whoami -t) <docker-registry-url>
    ```

    Por ejemplo:

    ```bash
    $ oc get route docker-registry -n default
    NAME              HOST/PORT                                              PATH      SERVICES          PORT       TERMINATION   WILDCARD
    docker-registry   docker-registry-default.-xxxx.appdomain.cloud    docker-registry                   5000-tcp   reencrypt     None

    $ docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.-xxxx.appdomain.cloud
    Login Succeeded
    ````


    c. Desempaquete el archivo PPA en un directorio de trabajo (por ejemplo, `mfoskpg`) y cargue las imágenes de IBM Mobile Foundation localmente.

    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C mfospkg/

    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    export MFOS_PROJECT=<my_namespace>
    export CONTAINER_REGISTRY_URL=<docker-registry-url>    # e.g. docker-registry-default.-xxxx.appdomain.cloud
    ```

    d. Cargue y envíe las imágenes al registro de OpenShift desde la máquina local.

    ```bash
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
    docker tag ${file/.tar.gz/} $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    docker push $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    done
    ```

    > **NOTA IMPORTANTE:** A partir de aquí, para acceder a las imágenes del contenedor desde el registro interno de OpenShift utilice el url de imagen como `docker-registry.default.svc:5000/<project_name>/<image_name>:<image_tag>`.

2. Cree un proyecto de OpenShift.

    a. Abra el panel de control de clúster de OpenShift desde [IBM Cloud](https://cloud.ibm.com/kubernetes/clusters?platformType=openshift).

    b. Vaya al separador **Acceso** y siga el conjunto de instrucciones rápidas para acceder a la consola de OpenShift. 

    c. Pulse el botón **Consola web de OpenShift** en la página del clúster para abrir la consola de OpenShift. 

    d. Cree un proyecto de OpenShift en la consola web. (Alternativamente, puede crear un proyecto utilizando la CLI de `oc`. Consulte la [documentación](https://docs.openshift.com/container-platform/3.11/dev_guide/projects.html#create-a-project-using-the-cli).

3. Despliegue el operador.

    a. Asegúrese de que la imagen del operador de MF (**mf-operator**) etiquetada esté establecida para el operador en `deploy/operator.yaml`. (Sustituya el marcador REPO_URL por el URL del registro interno del contenedor openshift. Por ejemplo, `docker-registry.default.svc:5000/myprojectname/mf-operator:1.0.1`)

    b. Asegúrese de que el nombre del proyecto OpenShift esté establecido para la definición del enlace de rol de clúster en `deploy/cluster_role_binding.yaml`. (Sustituya el marcador REPLACE_NAMESPACE). 

    c. Ejecute los mandatos siguientes para desplegar el operador e instalar las Restricciones de contexto de seguridad (SCC).

    ```bash
     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # Use your own <project_name> while running the command
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<project_name>
    ```

     Esto crea y ejecuta el pod mf-operator. Liste los pods y asegúrese de que el pod se ha creado correctamente. La salida es similar a la siguiente. 

    ```bash
    $ oc get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

4.  Cree el secreto del despliegue de IBM Mobile Foundation para acceder a la base de datos.
    >Consulte la documentación [aquí](../mobilefoundation-on-openshift/#setup-openshift-for-mf).

5.  Cree el volumen persistente y la reclamación de volumen para Analytics.
    >Consulte la documentación [aquí](../mobilefoundation-on-openshift/#setup-openshift-for-mf).

6.  Despliegue los componentes de IBM Mobile Foundation.

    Para desplegar cualquiera de los componentes de Mobile Foundation, modifique los valores de los recursos personalizados adecuados en `deploy/crds/charts_v1_mfoperator_cr.yaml`.

    a.  Establezca el url del repositorio en `deploy/crds/charts_v1_mfoperator_cr.yaml` sustituyendo el marcador REPO_URL, por ejemplo, `docker-registry.default.svc:5000/myprojectname/mfpf-server:2.0.1`.

    b.  [OPCIONAL] Si el registro de imágenes está fuera del clúster OpenShift, añada el **pullSecret** al archivo `deploy/crds/charts_v1_mfoperator_cr.yaml`. La definición del secreto puede ser similar al siguiente fragmento de código de ejemplo.

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: pull-secret-name
    ```

    Consulte la documentación [aquí](../mobilefoundation-on-openshift/#deploy-mf-operator) para completar el resto de las configuraciones, tal como réplicas, escalado, propiedades de BD, etc.

7. Cree o actualice el recurso personalizado. Este paso crea y ejecuta los pods para el componente Mobile Foundation completo en el archivo CR yaml.

	```bash
	oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
	```

    Ejecute el mandato siguiente y asegúrese de que los pods se crean y ejecutan correctamente. En un escenario de despliegue donde Mobile Foundation Server y Push están habilitados con 3 réplicas cada uno (valor predeterminado), la salida es similar a la siguiente. 

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

	> **NOTA:** Si el estado de ejecución de los pods es (1/1) significa que están disponibles para su acceso.

8. Compruebe si se han creado las rutas para acceder a los puntos finales de Mobile Foundation ejecutando el mandato siguiente.

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

### Acceso a la consola de los componentes de IBM Mobile Foundation

Los siguientes son los puntos finales para acceder a las consolas de los componentes de Mobile Foundation

  * **Mobile Foundation Server Administration Console** - `http://<ingress_subdomain>/mfpconsole`
  * **Operational Analytics Console** - `http://<ingress_subdomain>/analytics/console`
  * **Application Center Console** - `http://<ingress_subdomain>/appcenterconsole`

### Desinstalar

Se puede utilizar los pasos siguientes para la limpieza del despliegue.  

* Suprima el recurso personalizado (CR) y la definición de recurso personalizado (CRD) utilizando los pasos siguientes.

	```bash
	oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
	oc delete -f deploy/
	oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
	oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
	```

### Información adicional 

Para solucionar de forma alternativa un problema de escritura de datos de analítica en el volumen persistente, para Mobile Foundation Analytics utilizando File Storage en IBM Cloud, ejecute el mandato siguiente.

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
