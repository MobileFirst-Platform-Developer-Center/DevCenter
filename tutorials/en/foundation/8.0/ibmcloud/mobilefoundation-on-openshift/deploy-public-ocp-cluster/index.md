---
layout: tutorial
breadcrumb_title: Foundation on IBM Cloud OpenShift
title: Deploy Mobile Foundation on Red Hat OpenShift Container Platform on IBM Cloud
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->

### Prerequisites
{: #prereqs}

Following are the prerequisites before you begin the process of installing Mobile Foundation instance.

- IBM Cloud CLI (`ibmcloud`)

### Steps to deploy Mobile Foundation to Red Hat OpenShift cluster on IBM Cloud
{: #steps-deployment}

Follow the steps outlined in this section to deploy the Mobile Foundation OpenShift Container Platform (OCP) package to Red Hat OpenShift cluster on IBM Cloud.

1.  Create an OpenShift cluster on IBM Cloud.

2.  Push the image into your private registry and create a secret which can be used at the time of pulling the image.

    a.  Log in to your account on IBM Cloud.
    ```bash
    ibmcloud login
    ```

    b.  Log in to the container registry.
    ```bash
    ibmcloud cr login
    ```

    c.  Create a namespace.
    ```bash
    ibmcloud cr namespace-add <namespace name>
    ```

    d.  Unpack the PPA archive and load the IBM Mobile Foundation images locally.
    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C mfospkg/
    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    ```

    e.  Ensure the images are loaded into the local by listing them.
    ```bash
    docker images
    ```
    The output should list mf-operator, mfpf-dbinit, mfpf-server, mfpf-push, mfpf-analytics, and mfpf-appcenter.

    f.  Tag and Push all the images.
    ```bash
    docker tag mf-operator:<image_tag> <registry_info>/<namespace name>/mf-operator:<image_tag>
    docker tag mfpf-server:<image_tag> <registry_info>/<namespace name>/mfpf-server:<image_tag>
    docker tag mfpf-push:<image_tag> <registry_info>/<namespace name>/mfpf-push:<image_tag>
    docker tag mfpf-appcenter:<image_tag> <registry_info>/<namespace name>/mfpf-appcenter:<image_tag>
    docker tag mfpf-dbinit:<image_tag> <registry_info>/<namespace name>/mfpf-dbinit:<image_tag>
    docker tag mfpf-analytics:<image_tag> <registry_info>/<namespace name>/mfpf-analytics:<image_tag>

    docker push <registry_info>/<namespace name>/mf-operator:<image_tag>
    docker push <registry_info>/<namespace name>/mfpf-server:<image_tag>
    docker push <registry_info>/<namespace name>/mfpf-push:<image_tag>
    docker push <registry_info>/<namespace name>/mfpf-appcenter:<image_tag>
    docker push <registry_info>/<namespace name>/mfpf-dbinit:<image_tag>
    docker push <registry_info>/<namespace name>/mfpf-analytics:<image_tag>
    ```

    For example,
    ```bash
    docker tag mf-operator:<version> us.icr.io/mofo/mf-operator:<version>
    docker push us.icr.io/mofo/mf-operator:<version>
    ```

    g.  Create a secret to pull the images from the registry.
    ```bash
    ibmcloud iam api-key-create <api key name>
    ```
    save the iam apikey from the output of the command above to create a secret that is to be used as the docker-password in the command below.

    ```bash
    oc create secret docker-registry push-secret --docker-username=iamapikey --docker-password= --docker-server=us.icr.io
    ```

3.  Access the OpenShift cluster via CLI.
    a.  Install all the command-line tools.
    ```bash
    curl -sL https://ibm.biz/idt-installer | bash
    ```

    b.  Login to your IBM Cloud account.
    ```bash
    ic login --apikey
    ```

    c.  Get the cluster config details.
    ```bash
    ibmcloud oc cluster-config --cluster
    ```

    d.  Set the cluster config details, which is the output of the following command.
    ```bash
    ibmcloud oc cluster-config --cluster
    ```

    e.  Log in using `oc`.
    ```bash
    oc login -u apikey -p
    ```

    f.  Run the following command to make sure it connects.
    ```bash
    oc get pods
    ```

4.  Deploy the Operator.

    a.  Create an **imagePullSecret** to be able to pull the images from the container registry.
    ```bash
    oc create secret docker-registry <secret-name> --docker-username = <iamapikey> --docker-password = <output of the api-key-create which was saved earlier> --docker-server=us.icr.io
    ```

    b.  Go to the folder where the PPA images are extracted.
    ```bash
    cd mfospkg # directory where PPA was extracted
    ```

    c.  Set the **imagePullSecret** name for the Operator's Service Account definition in `deploy/operator.yaml`.
    ```yaml
    imagePullSecrets:
     	- name: <image_pull_secret_name>
    ```

    d.  Ensure the Operator image name (mf-operator) with tag is set for the operator in `deploy/operator.yaml`.
    ```bash
    sed -i 's|REPO_URL|<repo_url_with_project_name>|g' deploy/operator.yaml
    ```

    For example,
    ```bash
    sed -i 's|REPO_URL|us.icr.io/mofo|g' deploy/operator.yaml
    ```

    e.  Ensure the namespace is set for the cluster role binding definition in `deploy/operator.yaml`.
    ```bash
    sed -i 's|REPLACE_NAMESPACE|<project_or_namespace>|g' deploy/cluster_role_binding.yaml
    ```

    For example,
    ```bash
    sed -i 's|REPLACE_NAMESPACE|mofo|g' deploy/cluster_role_binding.yaml
    ```

    f.  Run the following commands to deploy the operator and install Security Context Constraints (SCC).
    ```bash
     cd mfospkg  # directory where PPA was extracted

     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # Use your own <project_name> while running the command
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<project_name>
     This creates and runs the mf-operator pod. List the pods and ensure the pod is created successfully. The output looks as follows

     $ oc get pods
     	NAME                           READY     STATUS    RESTARTS   AGE
     	mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

5.  Create secret for the IBM Mobile Foundation deployment to access the database.
    >Refer to the documentation [here](../install-mf/#install-mf).

6.  Create Persistent Volume and Volume Claim for Analytics.
    >Refer to the documentation [here](../install-mf/#install-mf).

7.  Deploy IBM Mobile Foundation components.
    To deploy any of the Mobile Foundation components, modify the appropriate custom resource values in the `deploy/crds/charts_v1_mfoperator_cr.yaml`.

    a.  Set the docker repository url in `deploy/crds/charts_v1_mfoperator_cr.yaml` by replacing the placeholder REPO_URL. Following sed command can also be used.
    ```bash
    cd mfospkg # directory where PPA was extracted
    sed -i 's|REPO_URL|<docker_registry_url>|g' deploy/crds/charts_v1_mfoperator_cr.yaml
    ```
    >**NOTE**: <docker_registry_url> is project_name or namespace appended to the docker registry info.

    For example,
    ```bash
    sed -i 's|REPO_URL|us.icr.io/mofo|g' deploy/crds/charts_v1_mfoperator_cr.yaml  
    ```

    b.  To access the image registry add the **pullSecret** in `deploy/crds/charts_v1_mfoperator_cr.yaml` file.

    Modify the `deploy/crds/charts_v1_mfoperator_cr.yaml` to add the required details. The secret definition may look similar to the following snippet.

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: push-secret
    ```

    Refer to the documentation [here](../install-mf/#deploy-mf-operator) to complete the rest of the configurations.
