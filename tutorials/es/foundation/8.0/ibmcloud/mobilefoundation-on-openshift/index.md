---
layout: tutorial
breadcrumb_title: Foundation on Red Hat OpenShift
title: Despliegue de Mobile Foundation en Red Hat OpenShift Container Platform existente 
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->

Obtenga información sobre cómo instalar la instancia de Mobile Foundation en un clúster de OpenShift utilizando IBM Mobile Foundation Operator. 

Hay dos formas de obtener la titularidad para OpenShift Container Platform.

* Tiene la titularidad para IBM Cloud Pak for Applications, que incluye la titularidad de OpenShift Container Platform.
* Tiene una plataforma OpenShift Container existente (adquirida desde Red Hat).

Los pasos para desplegar Mobile Foundation en OCP son los mismos independientemente de cómo haya obtenido la titularidad de OCP.

## Requisitos previos
{: #prereqs}

A continuación se muestran los requisitos previos antes de iniciar el proceso de instalación de la instancia de Mobile Foundation Operator. 

- Clúster de OpenShift v3.11 o superior.
- [Herramientas del cliente de OpenShift](https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html) (`oc`).
- Mobile Foundation requiere una base de datos. Cree una base de datos soportada y conserve los detalles de acceso a la base de datos para utilizarlos más adelante. Consulte [aquí](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/).
- Mobile Foundation Analytics requiere que el volumen de almacenamiento esté montado para los datos de Analytics persistentes (se recomienda NFS).

## Arquitectura
{: #architecture}

La imagen siguiente muestra la arquitectura interna de los servicios móviles en Red Hat OpenShift.

![Arquitectura](./architecture-mf-on-openshift.png)

## Instalación de una instancia de IBM Mobile Foundation

### Descargue el paquete de IBM Mobile Foundation
{: #download-mf-package}

Descargue el paquete de IBM Mobile Foundation para Openshift desde [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). Desempaquete el archivo en un directorio denominado `workdir`.

  > **NOTA:** Consulte [aquí](./additional-docs/validating-ppa/) si desea validar el paquete PPA y verificar la firma.

### Configure el proyecto OpenShift para Mobile Foundation
{: #setup-openshift-for-mf}

1. Inicie sesión en el clúster de OpenShift y cree un nuevo proyecto.   
   ```bash
   export MFOS_PROJECT=<project-name>
   oc login -u <username> -p <password> <cluster-url>
   oc new-project $MFOS_PROJECT
   ```
2. Desempaquete el paquete de IBM Mobile Foundation para Openshift utilizando el mandato siguiente. 
  ```bash
  tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C <workdir>/
  ```
3. Cargue y envíe las imágenes al registro de OpenShift desde el sistema local.   
   ```bash
    docker login -u <username> -p $(oc whoami -t) $(oc registry info)
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
      docker tag ${file/.tar.gz/} $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
      docker push $(oc registry info)/$MFOS_PROJECT/${file/.tar.gz/}
    done
   ```
4. Cree un secreto con credenciales de base de datos. 

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
  > **NOTA**: Se puede obtener una serie codificada utilizando `echo -n <string-to-encode> | base64`.

5. Para Mobile Foundation Analytics, configure un volumen persistente (PV).
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
        path: <nfs-mount-volume-path>
        server: <nfs-server-hostname-or-ip>
    EOF
    ```

6. Para Mobile Foundation Analytics, configure una reclamación de volumen persistente (PVC).
    
   ```yaml
   cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mfanalyticsvolclaim
      namespace: <projectname-or-namespace>
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

### Despliegue IBM Mobile Foundation Operator
{: #deploy-mf-operator}

1. Asegúrese de que el nombre de la imagen de Operator (*mf-operator*) etiquetado esté establecido para el operador en `deploy/operator.yaml` (**REPO_URL**).

    ```bash
    sed -i 's|REPO_URL|<image-repo-url>:<image-tag>|g' deploy/operator.yaml
    ```

2. Asegúrese de que el espacio de nombres esté establecido para la definición de enlace de rol del clúster en `deploy/cluster_role_binding.yaml` (**REPLACE_NAMESPACE**).

    ```bash
    sed -i 's|REPLACE_NAMESPACE|$MFOS_PROJECT|g' deploy/cluster_role_binding.yaml
    ```

3. Ejecute los mandatos siguientes para desplegar CRD, el operador y para instalar las Restricciones de contexto de seguridad (SCC).

    ```bash
    oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
    oc create -f deploy/
    oc adm policy add-scc-to-group mf-operator system:serviceaccounts:$MFOS_PROJECT
    ```

### Despliegue los componentes de IBM Mobile Foundation 
{: #deploy-mf-components}

1. Para desplegar cualquiera de los componentes de Mobile Foundation, modifique la configuración de los recursos personalizados `deploy/crds/charts_v1_mfoperator_cr.yaml`, en función de sus requisitos. Puede encontrar referencias completas sobre la configuración personalizada [aquí](./additional-docs/cr-configuration/).

   > **NOTA IMPORTANTE**: Para acceder a las instancias de Mobile Foundation después del despliegue, es necesario configurar el nombre de host de ingress. Asegúrese de que ingress esté configurado en la configuración de recursos personalizados. Consulte este [enlace](./additional-docs/enable-ingress/) sobre la configuración del mismo..

    ```bash
    oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
    ```
2. Ejecute el mandato siguiente y asegúrese de que los pods se crean y ejecutan correctamente. En un escenario de despliegue donde Mobile Foundation Server y Push están habilitados con 3 réplicas cada uno (valor predeterminado), la salida es similar a la siguiente. 

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
3. Compruebe si se han creado las rutas para acceder a los puntos finales de Mobile Foundation ejecutando el mandato siguiente.

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

### Acceso a la consola de los componentes de IBM Mobile Foundation

Los siguientes son los puntos finales para acceder a las consolas de los componentes de Mobile Foundation

  * **Mobile Foundation Server Administration Console** - `http://<ingress_hostname>/mfpconsole`
  * **Operational Analytics Console** - `http://<ingress_hostname>/analytics/console`
  * **Application Center Console** - `http://<ingress_hostname>/appcenterconsole`

## Desinstalar
{: #uninstall}

Utilice los mandatos siguientes para realizar una limpieza posterior a la instalación. 

```bash
oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
oc delete -f deploy/
oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
```

### Referencias adicionales

1. [Configuración de las bases de datos de Mobile Foundation](../../installation-configuration/production/prod-env/databases/)
2. [Utilización de Oracle (o) MySQL como base de datos de IBM Mobile Foundation](additional-docs/advanced-db-config/)
3. [Parámetros de configuración de recursos para Mobile Foundation](additional-docs/cr-configuration/)
4. [Casos de ejemplo para habilitar Ingress](additional-docs/enable-ingress/)
