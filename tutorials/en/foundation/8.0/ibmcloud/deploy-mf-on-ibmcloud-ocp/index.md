---
layout: tutorial
breadcrumb_title: Foundation on IBM Cloud OpenShift
title: Deploy Mobile Foundation on Red Hat OpenShift Container Platform on IBM Cloud
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->

### Prerequisites
{: #prereqs}

Following are the prerequisites before you begin the process of installing Mobile Foundation instance.

- [Create an OpenShift cluster](https://cloud.ibm.com/kubernetes/registry/main/namespaces?platformType=openshift) on IBM Cloud using your [IBM Account](https://myibm.ibm.com).
- [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-install-ibmcloud-cli) (`ibmcloud`).
- Download the IBM Mobile Foundation package for Openshift from [IBM Passport Advantage (PPA)](https://www-01.ibm.com/software/passportadvantage/pao_customer.html).
- Mobile Foundation requires a database. Create a supported database and keep the database access details handy for further use. See [here](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/databases/).
- [Optional] NFS mounted volume (or) [File Storage](https://cloud.ibm.com/docs/containers?topic=containers-file_storage) for Mobile Foundation Analytics.

### Steps to deploy Mobile Foundation to Red Hat OpenShift cluster on IBM Cloud
{: #steps-deployment}

Follow the steps outlined in this section to deploy the Mobile Foundation OpenShift Container Platform (OCP) package to Red Hat OpenShift cluster on IBM Cloud.

1.  Push the image into your private registry and create a secret which can be used at the time of pulling the image.

    a. Log in to IBM Cloud.

    ```bash
    ibmcloud login
    ```

    b. Login into OpenShift's internal docker registry by running the following commands.

    ```bash
    # Create a route from the terminal to the docker registry
    oc create route reencrypt --service=docker-registry -n default
    oc get route docker-registry -n default

    # login into the OpenShift internal container registry
    docker login -u $(oc whoami) -p $(oc whoami -t) <docker-registry-url>
    ```

    For example,

    ```bash
    $ oc get route docker-registry -n default
    NAME              HOST/PORT                                              PATH      SERVICES          PORT       TERMINATION   WILDCARD
    docker-registry   docker-registry-default.-xxxx.appdomain.cloud    docker-registry                   5000-tcp   reencrypt     None

    $ docker login -u $(oc whoami) -p $(oc whoami -t) docker-registry-default.-xxxx.appdomain.cloud
    Login Succeeded
    ````


    c. Unpack the PPA archive into a work directory (say `mfoskpg`) and load the IBM Mobile Foundation images locally.

    ```bash
    mkdir mfospkg
    tar xzvf IBM-MobileFoundation-Openshift-Pak-<version>.tar.gz -C mfospkg/

    cd mfospkg/images
    ls * | xargs -I{} docker load --input {}
    export MFOS_PROJECT=<my_namespace>
    export CONTAINER_REGISTRY_URL=<docker-registry-url>    # e.g. docker-registry-default.-xxxx.appdomain.cloud
    ```

    d. Load and push the images to OpenShift registry from local machine.

    ```bash
    cd <workdir>/images
    ls * | xargs -I{} docker load --input {}

    for file in * ; do
    docker tag ${file/.tar.gz/} $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    docker push $CONTAINER_REGISTRY_URL/$MFOS_PROJECT/${file/.tar.gz/}
    done
    ```

    > **IMPORTANT NOTE:** Here after, to access the container images from the OpenShift's internal container registry use the image url as `docker-registry.default.svc:5000/<project_name>/<image_name>:<image_tag>`.

2. Create an OpenShift project.

    a. Open the OpenShift cluster dashboard from the [IBM Cloud](https://cloud.ibm.com/kubernetes/clusters?platformType=openshift).

    b. Go the **Access** tab and follow the quick set of instructions to access the OpenShift Console.

    c. Click on the **OpenShift Web Console** button on the cluster page to open the openshift console.

    d. Create an OpenShift project on the webconsole. (Alternatively you may create a project using `oc` CLI. Refer to the [documentation](https://docs.openshift.com/container-platform/3.11/dev_guide/projects.html#create-a-project-using-the-cli).

3. Deploy the Operator.

    a. Ensure the MF operator image (**mf-operator**) with tag is set for the operator in `deploy/operator.yaml`. (Replace the placeholder REPO_URL with openshift container internal registry url. e.g. `docker-registry.default.svc:5000/myprojectname/mf-operator:1.0.1`)

    b. Ensure the OpenShift Project name is set for the cluster role binding definition in `deploy/cluster_role_binding.yaml`. (Replace the placeholder REPLACE_NAMESPACE.)

    c. Run the below commands to deploy the operator and install Security Context Constraints (SCC).

    ```bash
     oc create -f deploy/crds/charts_v1_mfoperator_crd.yaml
     oc create -f deploy/

     # Use your own <project_name> while running the command
     oc adm policy add-scc-to-group mf-operator system:serviceaccounts:<project_name>
    ```

     This creates and runs the mf-operator pod. List the pods and ensure the pod is created successfully. The output looks as follows.

    ```bash
    $ oc get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    mf-operator-5db7bb7w5d-b29j7   1/1       Running   0          1m
    ```

4.  Create secret for the IBM Mobile Foundation deployment to access the database.
    >Refer to the documentation [here](../mobilefoundation-on-openshift/#setup-openshift-for-mf).

5.  Create Persistent Volume and Volume Claim for Analytics.
    >Refer to the documentation [here](../mobilefoundation-on-openshift/#setup-openshift-for-mf).

6.  Deploy IBM Mobile Foundation components.

    To deploy any of the Mobile Foundation components, modify the appropriate custom resource values in the `deploy/crds/charts_v1_mfoperator_cr.yaml`.

    a.  Set the docker repository url in `deploy/crds/charts_v1_mfoperator_cr.yaml` by replacing the placeholder REPO_URL (e.g. `docker-registry.default.svc:5000/myprojectname/mfpf-server:2.0.1` ).

    b.  [OPTIONAL] If the image registry is outside OpenShift cluster, add the **pullSecret** in `deploy/crds/charts_v1_mfoperator_cr.yaml` file. The secret definition may look similar to the following sample snippet.

    ```yaml
    image:
      pullPolicy: IfNotPresent
      pullSecret: pull-secret-name
    ```

    Refer to the documentation [here](../mobilefoundation-on-openshift/#deploy-mf-operator) to complete the rest of the configurations (like replicas, scaling, DB properties etc.)

7. Create or update the custom resource. This step creates and runs the pods for all the mobile foundation component enabled in the CR yaml.

	```bash
	oc apply -f deploy/crds/charts_v1_mfoperator_cr.yaml
	```

    Run the following command and ensure the pods are created and running successfully. In a deployment scenario where Mobile Foundation Server and push are enabled with 3 replicas each (default), the output looks as shown below.

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

	> **NOTE:** Pods in Running (1/1) status shows the service is available for access.

8. Check if the routes are created for accessing the Mobile Foundation endpoints by running the following command.

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

### Accessing the console of IBM Mobile Foundation components

Following are the endpoints for accessing the consoles of Mobile Foundation components

  * **Mobile Foundation Server Administration Console** - `http://<ingress_subdomain>/mfpconsole`
  * **Operational Analytics Console** - `http://<ingress_subdomain>/analytics/console`
  * **Application Center Console** - `http://<ingress_subdomain>/appcenterconsole`

### Uninstall

Following steps can be used to cleanup the deployment.

* Delete the Custom Resource(CR) and Custom Resource Definition(CRD) using following steps.

	```bash
	oc delete -f deploy/crds/charts_v1_mfoperator_cr.yaml
	oc delete -f deploy/
	oc delete -f deploy/crds/charts_v1_mfoperator_crd.yaml
	oc patch crd/ibmmf.charts.helm.k8s.io -p '{"metadata":{"finalizers":[]}}' --type=merge
	```

### Additional information

To work around the permission issue to write the analytics data into the persistent volume, for Mobile Foundation Analytics using File Storage on IBM Cloud, please run the following command.

```bash
oc run perms-pod --overrides='
{
        "spec": {
            "containers": [
                {
                    "command": [
                        "/bin/sh",
                        "-c",
                        "mkdir -p /opt/ibm/wlp/usr/servers/mfpf-analytics/analyticsData && chown -R 1001:0 /usr/ibm/wlp/usr/servers/mfpf-analytics/analyticsData"
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
