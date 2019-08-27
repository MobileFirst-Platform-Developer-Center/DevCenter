---
layout: tutorial
breadcrumb_title: Install Mobile Foundation in ICP4A
title: Install Mobile Foundation in IBM Cloud Pak for Applications
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->

Learn how to install the Mobile Foundation instance on an Openshift cluster using the IBM Mobile Foundation Operator.

### Prerequisites
{: #prereqs}

Following are the prerequisites before you begin the process of installing Mobile Foundation instance using the Mobile Foundation Operator.

* Docker
* Openshift cluster (preferably multi-node) v3.11
* Openshift client tools (`oc`)

## Installing an IBM Mobile Foundation instance

### Unpack the IBM Mobile Foundation package
{: #unpack-mf-package}

Download the IBM Mobile Foundation package for Openshift from [Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). For internal or development use, obtain the package from [here](https://na.artifactory.swg-devops.com/artifactory/list/hyc-mobilefoundation-dev-generic-local/IBM-MobileFoundation-Openshift-Pak-1.0.0.tar.gz

Unpack the package using the following command.

```bash
mkdir mfospkg
tar xzvf IBM-MobileFoundation-Openshift-Pak-1.0.0.tar.gz -C mfospkg/
```

### Load the IBM Mobile Foundation images to the local docker registry
{: #load-mf-local-registry}

Use the following command to load the IBM Mobile Foundation images to your local docker registry.

```bash
cd mfospkg/images
ls * | xargs -I{} docker load --input {}
```

### Initialize the Openshift cluster
{: #initialize-oc-cluster}

>**Note**: Install the Openshift cluster and the Openshift client tools (oc) before proceeding with this step.

Use the Openshift client tool (`oc`) to execute the following command to initialize the Openshift cluster.

```bash
oc login -u <username> -p <password> <openshift cluster url>
oc new-project <project-name>
```

### Make the IBM Mobile Foundation images available to Openshift cluster
{: #make-mf-available-to-oc}

Follow the steps below to make the IBM Mobile Foundation images available to your Openshift cluster.

1.  Log in to the Docker registry by using your access token.
    ```bash
    oc project <project-name>
    docker login -u <username> -p $(oc whoami -t) $(oc registry info)
    ```

2.  List the Mobile Foundation component images from the local docker registry.
    ```bash
    docker images | grep mf
    ```

3.  Tag and push the Mobile Foundation images to the registry. Repeat the below commands for all the Mobile Foundation images (including the `ibm-mf-operator`).
    ```bash
    docker tag <image-id-from-local-docker-registry> ${REGISTRY_INFO}/<project-name>/<mf-image-name>:<image-version>
    docker push ${REGISTRY_INFO}/<project-name>/<mf-image-name>:<image-version>
    ```

4.  Modify the image value and the tag version in the `deploy/crds/charts_v1alpha1_ibmmf_cr.yaml` to point to `${REGISTRY_INFO}/<project-name>/<mf-image-name>` and `<image-version>`.

5.  Provide the valid database details under the DB section, of each component to be installed, in the file `deploy/crds/charts_v1alpha1_ibmmf_cr.yaml`.

6.  Set the Mobile Foundation Operator image name in the `deploy/operator.yaml`, optionally you can use `sed` utility as follows.
    ```bash
    sed -i "" 's|REPLACE_IMAGE|docker-registry.default.svc:5000/mf/mf-operator:v1.0.0|g' deploy/operator.yaml
    ```

### Deploy the IBM Mobile Foundation Operator
{: #deploy-mf-operator}

Use the following commands in the Openshift client to deploy the Mobile Foundation Operator.

```bash
oc create -f deploy/crds/charts_v1alpha1_ibmmf_crd.yaml
oc create -f deploy/operator.yaml
```

### Install the Mobile Foundation instance
{: #install-mf}

1.  Create the Persistent Volume (PV) resource for analytics.
    ```yaml
    cat <<EOF | oc apply -f -
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      labels:
        app: mfpanalytics
      name: analyticsclaim
      namespace: <your-namespace>
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 8Gi
    EOF
    ```

2. Create a secret with the database credentials.
   ```yaml
    cat <<EOF | oc apply -f -
    apiVersion: v1
    data:
     MFPF_ADMIN_DB_USERNAME: Ymx1YWRtaW4=
     MFPF_ADMIN_DB_PASSWORD: TkdZeE9UTmhNV0V5WkRJeQ==
     MFPF_RUNTIME_DB_USERNAME: Ymx1YWRtaW4=
     MFPF_RUNTIME_DB_PASSWORD: TkdZeE9UTmhNV0V5WkRJeQ==
     MFPF_PUSH_DB_USERNAME: Ymx1YWRtaW4=
     MFPF_PUSH_DB_PASSWORD: TkdZeE9UTmhNV0V5WkRJeQ==
     MFPF_APPCNTR_DB_USERNAME: Ymx1YWRtaW4=
     MFPF_APPCNTR_DB_PASSWORD: TkdZeE9UTmhNV0V5WkRJeQ==
    kind: Secret
    metadata:
     name: mobilefoundation-db
    type: Opaque
    EOF
   ```  

3. **[OPTIONAL]**: Create the secrets below if you need to install the Application Center.
   ```yaml
   cat <<EOF | oc apply -f -
   apiVersion: v1
   data:
    MFPF_APPCNTR_ADMIN_USER: YWRtaW4=
    MFPF_APPCNTR_ADMIN_PASSWORD: YWRtaW4=
   kind: Secret
   metadata:
    name: appcntrlogin
   type: Opaque
   EOF
   ```

   ```yaml
    cat <<EOF | oc apply -f -
    apiVersion: v1
    data:
     MFPF_APPCNTR_DB_USERNAME: Ymx1YWRtaW4=
     MFPF_APPCNTR_DB_PASSWORD: TkdZeE9UTmhNV0V5WkRJeQ==
    kind: Secret
    metadata:
     name: appcenter-dbsecret
    type: Opaque
    EOF
    ```

4.  Create the TLS secret for Ingress.
    ```bash
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=hears1.fyre.ibm.com/O=hears1.fyre.ibm.com"
    kubectl create secret tls mf-tls-secret --key=tls.key --cert=tls.crt
    ```

5.  To add details like database hostname, port, secret, ingress hostname and more, customize the Custom Resource (CR) with the configuration of the Mobile Foundation instance and create the Custom Resource.
    ```yaml
    oc apply -f deploy/crds/charts_v1alpha1_ibmmf_cr.yaml
    ```

The properties that can be customized can be found [here]().

### Clean-up
{: #clean-up}

Use the following commands to perform a post installation clean up.
```bash
oc delete -f deploy/crds/charts_v1alpha1_ibmmf_cr.yaml
oc delete -f deploy/operator.yaml
oc delete -f deploy/crds/charts_v1alpha1_ibmmf_crd.yaml
```

## Known issues and work arounds
{: #known-issues}

* https:true does not work. We are working on [this issue](https://github.ibm.com/MobileFirst/mfp-cloud-planning/issues/212).     

* Deleting CRs/CRDs hangs at times. We're investigating the [issue](https://github.ibm.com/MobileFirst/mfp-cloud-planning/issues/214). Meanwhile, the work around is to patch the CR/CD as follows and then delete.
  ```bash
  oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
  ```
