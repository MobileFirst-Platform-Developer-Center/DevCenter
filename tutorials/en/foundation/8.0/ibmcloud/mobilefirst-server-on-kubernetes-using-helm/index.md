---
layout: tutorial
title: Setting up Mobile Foundation on IBM Cloud Kubernetes Cluster using Helm
breadcrumb_title: Foundation on Kubernetes Cluster using Helm
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance, {{ site.data.keys.mf_push }},  {{ site.data.keys.mf_analytics }} instance and {{ site.data.keys.mf_app_center}} instance on IBM Cloud Kubernetes Cluster (IKS) using Helm charts.

Below are the basic steps that will get you started:<br/>
* Complete the prerequisites
* Download the Passport Advantage Archive (PPA Archive) of {{ site.data.keys.product_full }} for {{ site.data.keys.prod_icp }} 
* Load the PPA archive in IBM Cloud Kubernetes Cluster
* Configure and install the {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_app_center}} (optional) 

#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Download the IBM Mobile Foundation Passport Advantage Archive](#download-the-ibm-mfpf-ppa-archive)
* [Load the IBM Mobile Foundation Passport Advantage Archive](#load-the-ibm-mfpf-ppa-archive)
* [Environment variables](#env-variables)
* [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
* [Installing Helm Charts](#install-hmc-icp)
* [Verifying the Installation](#verify-install)
* [Sample application](#sample-app)
* [Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases](#upgrading-mf-helm-charts)
* [Uninstall](#uninstall)
* [Troubleshooting](#troubleshooting)

## Prerequisites
{: #prereqs}

You should have an [**IBM Cloud account**](http://cloud.ibm.com/) and must have set up the [**IBM Cloud Kubernetes Cluster**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial).

To manage the containers and images, install the following on your host machine as part of IBM Cloud CLI plugins setup:

* IBM Cloud CLI (`ibmcloud`)
* Kubernetes CLI (`kubectl`)
* IBM Cloud Container Registry plug-in (`cr`)
* IBM Cloud Container Service plug-in (`ks`)
* Install and setup [Docker](https://docs.docker.com/install/)
* Helm (`helm`)
To work with Kubernetes cluster using CLI, you should configure the *ibmcloud* client.
1. Make sure you log in to the [Clusters page](https://cloud.ibm.com/kubernetes/clusters). (Note: [IBMid account](https://myibm.ibm.com/) is required.)
2. Click the Kubernetes cluster to which IBM Mobile Foundation Chart needs to be deployed.
3. Follow the instructions in **Access** tab once the cluster is created.
>**Note:** Cluster creation takes few minutes. After the cluster is successfully created, click **Worker Nodes** tab and make a note of the *Public IP*.

To access IBM Cloud Kubernetes Cluster using CLI, you should configure the IBM Cloud client. [Learn more](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).

## Download the IBM Mobile Foundation Passport Advantage Archive
{: #download-the-ibm-mfpf-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.product_full }} is available [here](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

A {{ site.data.keys.product_adj }} *DB Initialization* component is used or facilitating the database intialization tasks. This takes care of creating Mobile Foundation Schema and Tables (if  required) in the database (if it does not exist).

## Load the IBM Mobile Foundation Passport Advantage Archive
{: #load-the-ibm-mfpf-ppa-archive}

Follow the steps given below to load the PPA Archive into IBM Cloud Kubernetes Cluster:

  1. Log in to the cluster using IBM Cloud plugin. Refer the [IBM Cloud CLI documentation] (https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview) for Command Reference.

      For example,
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
      Include the `--sso` option if using a federated ID. Optionally, you may intend to skip SSL validation use the flag `--skip-ssl-validation` in the above command. This would bypass SSL validation of HTTP requests. Using this parameter might cause security problems.

  2. Login into the IBM Cloud Container registry & initialize the Container Service using the following commands:
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. Set the region of the deployment using the following command (e.g. us-south)
      ```bash
      ibmcloud cr region-set
      ```  
  
  4. Follow the below steps to Gain access to your cluster -
  
      1. Download and install a few CLI tools and the Kubernetes Service plug-in.
      ```bash
      curl -sL https://ibm.biz/idt-installer | bash
      ```
      
      2. Download the kubeconfig files for your cluster.
      ```bash
      ibmcloud ks cluster-config --cluster my_cluster_name
      ```
      
      3. Set the *KUBECONFIG* environment variable. Copy the output from the previous command and paste it in your terminal. The command output looks similar to the following example:
      ```bash
      export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/my_namespace/kube-config-dal10-my_namespace.yml
      ```
      
      4. Verify that you can connect to your cluster by listing your worker nodes.
      ```bash
      kubectl get nodes
      ```
      
  5. Load the PPA Archive of {{ site.data.keys.product }} using the following steps:
       1. **Extract** the PPA archive
       2. **Tag** the loaded images with the IBM Cloud Container registry namespace and with the right version
       3. **Push** the image
       4. [Optional] Create and **Push the manifests**, if the worker nodes are based on a combination of architectures (such as amd64, ppc64le, s390x).

      Below is an example for loading the **mfpf-server** and **mfpf-push** images to the Worker Nodes based on **amd64** architecture. You should follow the same process for **mfpf-appcenter** and **mfpf-analytics**.
      
      ```bash
      
      # 1. Extract the PPA archive
      
      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Tag the loaded images with the IBM Cloud Container registry namespace and with the right version
      
      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0

      # 3. Push all the images
      
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0

      # 4. Cleanup the extracted archive
     
      rm -rf ppatmp
      ```
      
Below is an example for loading the **mfpf-server** and **mfpf-push** images to the Worker Nodes based on **multi-architecture**. You should follow the same process for **mfpf-appcenter** and **mfpf-analytics**.

   ```bash
      # 1. Extract the PPA archive
      
      mkdir -p ppatmp ; cd ppatmp
      tar -xvzf ibm-mobilefirst-foundation-icp.tar.gz
      cd ./images
      for i in *; do docker load -i $i;done

      # 2. Tag the loaded images with the IBM Cloud Container registry namespace and with the right version
      
      ## 2.1 Tagging mfpf-server
      
      docker tag mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker tag mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker tag mfpf-server:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le
    
      ## 2.2 Tagging mfpf-dbinit
     
      docker tag mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker tag mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker tag mfpf-dbinit:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le
      
      ## 2.3 Tagging mfpf-push
      
      docker tag mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker tag mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker tag mfpf-push:1.1.0-ppc64le us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 3. Push all the images
      
      ## 3.1 Pushing mfpf-server images
      
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le
      
      ## 3.3 Pushing mfpf-dbinit images
 
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le
      
      ## 3.3 Pushing mfpf-push images

      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 4. [Optional] Create and Push the manifests
      
      ## 4.1 Create manifest-lists
      
      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      ## 4.2 Annotate the manifests
      
      ### mfpf-server
      
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le --os linux --arch ppc64le


      ### mfpf-dbinit
      
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le --os linux --arch ppc64le


      ### mfpf-push
      
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le --os linux --arch ppc64le

      ## 4.3 Push the manifest list
      
      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0
      
      # 5. Cleanup the extracted archive
     
      rm -rf ppatmp
   ```
      
>**Note:** 
> 1. The `ibmcloud cr ppa-archive load` command approach doesn’t support the PPA package with multi-arch support. Hence one has to extract and push the package manually to the IBM Cloud Container repository (users using older PPA versions need to use following command to load). 
      
> 2. Multi-architecture refers to architectures including intel (amd64), power64 (ppc64le) and s390x. Multi-arch is supported from ICP 3.1.1 only.

  ```bash
  ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
  ```
*archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage,

The helm charts are stored in the client or local (unlike ICP helm chart stored in the IBM Cloud Private helm repository). Charts can be located within the `ppa-import/charts` (or charts) directory.

## Install and configure IBM {{ site.data.keys.product }} Helm Charts
{: #configure-install-mf-helmcharts}

Before you install and configure {{ site.data.keys.mf_server }}, you should have the following:

This section summarizes the steps for creating secrets.

Secret objects let you store and manage sensitive information, such as passwords, OAuth tokens, ssh keys and so on. Putting this information in a secret is safer and more flexible than putting it in a Pod definition or in a container image. 

* [**Mandatory**] A DB2 database instance should be configured and has to be ready to use. You will need the database information to [configure {{ site.data.keys.mf_server }} helm](#install-hmc-icp). {{ site.data.keys.mf_server }} requires schema and tables, which will be created (if it does not exist) in this database.

* [**Mandatory**] Creating **database secrets** for Server, Push and Application Center.
This section outlines the security mechanisms for controlling access to the database. Create a secret using specified subcommand and provide the created secret name under the database details.

Run the code snippet below to create a database secret for Mobile Foundation server:

   ```bash
	# Create mfpserver secret
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
		
Run the below code snippet to create a database secret for Application Center
	
   ```bash
	# create appcenter secret
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
   > NOTE: You may encode the username and password details using the below command - 
	
   ```bash
	export $MY_USER_NAME=<myuser>
	export $MY_PASSWORD=<mypassword>
	
	echo -n $MY_USER_NAME | base64
	echo -n $MY_PASSWORD | base64
   ```

   
* [**Mandatory**] A pre-created **Login Secret** is required for Server, Analytics and Application Center console login. For example:
	
   ```bash
   kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
   ```

   For Analytics.

   ```bash
   kubectl create secret generic analyticslogin --from-literal=ANALYTICS_ADMIN_USER=admin --from-literal=ANALYTICS_ADMIN_PASSWORD=admin
   ```

   For Application Center.

   ```bash
   kubectl create secret generic appcenterlogin --from-literal=APPCENTER_ADMIN_USER=admin --from-literal=APPCENTER_ADMIN_PASSWORD=admin
   ```

   > NOTE: If these secrets are not provided, they are created with default username and password of admin/admin during the deployment of Mobile Foundation helm chart
   
* [**Optional**] You can provide your own keystore and truststore to Server, Push, Analytics and Application Center deployment by creating a secret with your own keystore and truststore.

   Pre-create a secret with `keystore.jks` and `truststore.jks` along with keystore and trustore password using the literals KEYSTORE_PASSWORD and TRUSTSTORE_PASSWORD  provide the secret name in the field keystoreSecret of respective component

   Keep the files `keystore.jks`, `truststore.jks` and its passwords as below  

   For example:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > NOTE: The names of the files and literals should be the same as mentioned in command above. Provide this secret name in `keystoresSecretName` input field of respective component to override the default keystores when configuring the helm chart.
   
* [**Optional**] Mobile Foundation components can be configured with hostname based Ingress for external clients to reach them using hostname. The Ingress can be secured by using a TLS private key and certificate. The TLS private key and certificate must be defined in a secret with key names `tls.key` and `tls.crt`. 

   The secret **mf-tls-secret** has to be created in the same namespace as the Ingress resource by using the following command:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```
	
   The ingress hostname and the name of the secret is then provided in the field global.ingress.secret. Modify the **values.yaml** to add appropriate ingress hostname and the ingress secret name while deploying the helm chart.
   
   > NOTE: Avoid using same ingress hostname if it was already used for any other helm releases.
   
* [**Optional**] Mobile Foundation Server is predefined with confidential clients for Admin Service. The credentials for these clients are provided in the `mfpserver.adminClientSecret` and `mfpserver.pushClientSecret` fields. 

   These secrets can be created as follows: 
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```
		
   > NOTE: If the values for these fields `mfpserver.pushClientSecret` and `mfpserver.adminClientSecret` are not provided during Mobile Foundation helm chart deployment, default auth ID / client Secret of `admin / nimda` for `mfpserver.adminClientSecret` and `push / hsup` for `mfpserver.pushClientSecret` are generated and utilized.
   
* [**Mandatory**] Before you begin the installation of Mobile Foundation Analytics Chart, configure the Persistent Volume and Persistent Volume Claim accordingly. Provide the Persistent Volume to configure Mobile Foundation Analytics. Follow the steps detailed in [IBM Cloud Kubernetes documentation to create Persistent Volume](https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_storage).


## Environment variables
{: #env-variables }
The table below provides the environment variables used in the {{ site.data.keys.mf_server }} instance, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} and {{ site.data.keys.mf_app_center }}

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| ***`Global Configuration`*** | |  |  |
| arch | amd64 | amd64 worker node scheduler preference in a hybrid cluster | 3 - Most preferred (Default). |
|  | ppcle64 | ppc64le worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
|  | s390x | S390x worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
| image | pullPolicy | Image Pull Policy | Defaults to **IfNotPresent**. |
|  | pullSecret | Image Pull Secret |  |
| ingress | hostname | The external hostname or IP address to be used by external clients | Balances network traffic workloads in your cluster by forwarding public or private requests to your apps |
|  | secret | TLS secret name | Specifies the name of the secret for the certificate that has to be used in the Ingress definition. The secret has to be pre-created using the relevant certificate and key. Mandatory if SSL/TLS is enabled. Pre-create the secret with Certificate & Key before supplying the name here |
|  | sslPassThrough | Enable SSL passthrough | Specifies is the SSL request should be passed through to the Mobile Foundation service - SSL termination occurs in the Mobile Foundation service. Default: false |
| https | true |  |  |
| dbinit | enabled | Enable initialization of Server, Push and Application Center databases | Initializes databases and create schemas / tables for Server, Push and Application Center deployment.(Not required for Analytics). Default: true |
| | repository | Docker image repository for database initialization | Repository of the Mobile Foundation database docker image |
|  | tag | Docker image tag | See Docker tag description |
|  | replicas | The number of instances (pods) of Mobile Foundation DBinit that need to be created | Positive integer (Default: 1) |
| ***`MFP Server Configuration`*** | | | |
| mfpserver | enabled | Flag to enable Server | true (default) or false |
|  | repository | Docker image repository | Repository of the Mobile Foundation Server docker image |
|  | tag | Docker image tag | See Docker tag description |
|  | consoleSecret | A pre-created secret for login | Check Prerequisites section |
|  db | host | IP address or hostname of the database where Mobile Foundation Server tables need to be configured. | IBM DB2® (default). |
| | port | Port where database is setup | |
| | secret | A precreated secret which has database credentials| |
| | name | Name of the Mobile Foundation Server database | |
|  | schema | Server db schema to be created. | If the schema already present, it will be used. Otherwise, it will be created. |
|  | ssl | Database connection type  | Specify if you database connection has to be http or https. Default value is false (http). Make sure that the database port is also configured for the same connection mode |
| adminClientSecret | Secify the name of the secret | Admin client secret | Specify the Client Secret name created. [Refer](#configure-install-mf-helmcharts) |
| pushClientSecret | Secify the name of the secret | Push client secret | Specify the Client Secret name created. [Refer](#configure-install-mf-helmcharts) |
| internalConsoleSecretDetails | consoleUser: "admin" |  |  |
|  | consolePassword: "admin" |  |  |
| internalClientSecretDetails | adminClientSecretId: admin |  |  |
| | adminClientSecretPassword: nimda |  |  |
| | pushClientSecretId: push |  |  |
| | pushClientSecretPassword: hsup |  |  |
| replicas | 3 | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: 3) |
| autoscaling | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicas field. | false (default) or true |
| | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
| | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than min. | Positive integer (default to 10) |
| | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| pdb | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
| | min  | minimum available pods | Positive integer (default to 1) |
| jndiConfigurations | mfpfProperties | Mobile Foundation Server JNDI properties to customize deployment | Supply comma separated name value pairs |
| | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP Push Configuration`*** | | | |
| mfppush | enabled | Flag to enable Mobile Foundation Push | true (default) or false |
|           | repository | Docker image repository |Repository of the Mobile Foundation Push docker image |
|           | tag | Docker image tag | See Docker tag description |
| replicas | | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: 3) |
| autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| pdb     | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| jndiConfigurations | mfpfProperties | Mobile Foundation Server JNDI properties to customize deployment | Supply comma separated name value pairs |
| | keystoresSecretName | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP Analytics Configuration`*** | | | |
| mfpanalytics | enabled          | Flag to enable analytics | false (default) or true |
| image | repository          | Docker image repository | Repository of the Mobile Foundation Operational Analytics docker image |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Check Prerequisites section|
| replicas |  | The number of instances (pods) of Mobile Foundation Operational Analytics that need to be created | Positive integer (Default: 2) |
| autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
|  shards|  | Number of Elasticsearch shards for Mobile Foundation Analytics | default to 2|             
|  replicasPerShard|  | Number of Elasticsearch replicas to be maintained per each shard for Mobile Foundation Analytics | default to 2|
| persistence | enabled | Use a PersistentVolumeClaim to persist data                        | true |                                                 |
|  |useDynamicProvisioning | Specify a storageclass or leave empty  | false  |                                                  |
| |volumeName| Provide an volume name  | data-stor (default) |
|   |claimName| Provide an existing PersistentVolumeClaim  | nil |
|   |storageClassName     | Storage class of backing PersistentVolumeClaim | nil |
|   |size    | Size of data volume      | 20Gi |
| pdb  | enabled | Specify whether to enable/disable PDB. | true (default) or false |
|   | min  | minimum available pods | Positive integer (default to 1) |
| jndiConfigurations | mfpfProperties | Mobile Foundation JNDI properties to be specified to customize operational analytics| Supply comma separated name value pairs  |
|  | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|   | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|   | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| ***`MFP Application center Configuration`*** | | | |
| mfpappcenter | enabled          | Flag to enable Application Center | false (default) or true |  
| image | repository          | Docker image repository | Repository of the Mobile Foundation Application Center docker image |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Check Prerequisites section|
| db | host | IP address or hostname of the database where Appcenter database needs to be configured	| |
|   | port | 	Port of the database  | |             
| | name | Name of the database to be used | The database has to be precreated.|
|   | secret | A precreated secret which has database credentials| |
|   | schema | Application Center database schema to be created. | If the schema already exists, it will be used. If not, one will be created. |
|   | ssl |Database connection type  | Specify if you database connection has to be http or https. Default value is false (http). Make sure that the database port is also configured for the same connection mode |
| autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| pdb     | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
|  | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |


> For the tutorial on analyzing {{ site.data.keys.prod_adj }} logs using Kibana, see [here](analyzing-mobilefirst-logs-on-icp/).

## Installing Helm Charts
{: #install-hmc-icp}

### Install {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

Installation of {{ site.data.keys.mf_analytics }} is optional. If you wish to enable analytics in {{ site.data.keys.mf_server }}, you should configure and install {{ site.data.keys.mf_analytics }} first, before installing {{ site.data.keys.mf_server }}.

Before you begin the installation, ensure that you have covered all the **Mandatory** sections under ***[Install and configure IBM {{ site.data.keys.product }} Helm Charts]***(#configure-install-mf-helmcharts).

Follow the below steps to install and configure IBM {{ site.data.keys.mf_analytics }} on IBM Cloud Kubernetes Cluster.

1. To configure the Kubernetes Cluster execute the command below:
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```
2. Get the default helm chart values using the following command.
    ```bash
    helm inspect values <mfp-analytics-helm-chart.tgz>  > values.yaml
    ```
    Example for {{ site.data.keys.mf_analytics }}:
    ```bash
    helm inspect values ibm-mfpf-analytics-prod-2.0.0.tgz > values.yaml
    ```    

3. Modify the **values.yaml** to add appropriate values before deploying the helm chart. Make sure database details, ingress hostname, secrets, etc. are added and save the values.yaml.

Refer the section [Environment variables](#env-variables) for more details.

4. To deploy the helm chart run the following command:
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Example for deploying analytics server:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-2.0.0.tgz
    ```    

### Install {{ site.data.keys.mf_server }}
{: #install-mf-server}

Before you begin the installation of {{ site.data.keys.mf_server }} ensure that you have pre-configured a DB2 database.

Follow the steps below to install and configure IBM {{ site.data.keys.mf_server }} on IBM Cloud Kubernetes Cluster.

1. Configure the Kube Cluster:
    ```bash
    ibmcloud cs cluster-config <iks-cluster-name>
    ```   

2. Get the default helm chart values using the following command:
    ```bash
    helm inspect values <mfp-server-helm-chart.tgz>  > values.yaml
    ```   
    Example for {{ site.data.keys.mf_server }}:
    ```bash
    helm inspect values ibm-mfpf-server-prod-2.0.0.tgz > values.yaml
    ``` 

3. Modify the **values.yaml** to add appropriate values for deploying the helm chart. Make sure the database details, ingress, scaling etc. are added and save the values.yaml.

4. To deploy the helm chart run the following command.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    Example for deploying server:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-2.0.0.tgz
    ```

>**Note:** For installing the AppCenter the above steps are to be followed with the corresponding helm chart (e.g. ibm-mfpf-appcenter-prod-2.0.0.tgz.tgz).

## Verifying the Installation
{: #verify-install}

After you have installed and configured the Mobile Foundation components, you can verify your installation and the status of the deployed pods by using IBM Cloud CLI, Kubernetes CLI and helm commands.

See the [CLI Command Reference](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) in IBM Cloud CLI documentation and Helm CLI from [Helm documentation](https://docs.helm.sh/helm/).

From the IBM Cloud Kubernetes Cluster page on IBM Cloud Portal, one can use the **Kubernetes Dashboard** button to open the Kubernetes console to manage the cluster artifacts.

## Accessing {{ site.data.keys.prod_adj }} console
{: #access-mf-console}

After successful installation you can access, IBM {{ site.data.keys.prod_adj }} Operational Console using `<protocol>://<public_ip>:<node_port>/mfpconsole`.<br/>
IBM {{ site.data.keys.mf_analytics }} console can be accessed using `<protocol>://<public_ip>:<port>/analytics/console`.
The protocol can be `http` or `https`. Also, note that the port will be **NodePort** in the case of **NodePort** deployment. To get the ip address and **NodePort** of your installed {{ site.data.keys.prod_adj }} Charts, follow the steps below from the Kubernetes Dashboard.
* To get **Public IP** - Select **Kubernetes** > **Worker Nodes** > Under Public IP - note the IP address.
* **Node port** can be found in **Kubernetes Dashboard** > Select **Services** > Under the **internal endpoints**, note the entry for *TCP Node Port* (a five digit port).

In addition to the *NodePort* approach to access the Console, the service can also be accessed via [Ingress](https://console.bluemix.net/docs/containers/cs_ingress.html) host.

Follow the steps below to access the console:

1. Go to the [**IBM Cloud Dashboard**](https://console.bluemix.net/dashboard/apps/).
2. Choose the **Kubernetes Cluster** on which `Analytics/Server/AppCenter` has been deployed and open the **Overview** page.
3. Locate the Ingress subdomain for the ingress hostname and access the consoles as follows.
    * Access the IBM Mobile Foundation Operational Console using:
     `<protocol>://<ingress-hostname>/mfpconsole`
    * Access the IBM Mobile Foundation Analytics Console using:
     `<protocol>://<ingress-hostname>/analytics/console`
    * Access the IBM Mobile Foundation Application Center Console using:
     `<protocol>://<ingress-hostname>/appcenterconsole`
4. The SSL services support is disabled by default on nginx ingress. You may notice connectivity while accessing the console through https. Follow the below steps to enable SSL services on ingress -
    1. From IBM Cloud Kubernetes Cluster page, launch the Kubernetes dashboard
    2. On the Left hand side panel, click on the option Ingresses
    3. Select the Ingress name
    4. Click on the Edit button on your top right
    5. Modify the yaml file and add the ssl-services annotation 
    Example :

    ```bash
    "annotations": {
      "ingress.bluemix.net/ssl-services": "ssl-service=my_service_name1;ssl-service=my_service_name2",
      .....
      ....
      ...
      ...
    }
    ```
   6. Click Update 

>**Note:** The port 9600 is exposed internally in the Kubernetes service and is used by the {{ site.data.keys.prod_adj }} Analytics instances as the transport port.

## Sample application
{: #sample-app}
See the [{{ site.data.keys.prod_adj }} tutorials](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/), to deploy the sample adapter and to run the sample application on IBM {{ site.data.keys.mf_server }} running on IBM Cloud Kubernetes Cluster.

## Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases
{: #upgrading-mf-helm-charts}

Please refer to [Upgrading bundled products](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/upgrade_helm.html) for instructions on how-to upgrade helm charts/releases.

### Sample scenarios for Helm release upgrades

1. To upgrade helm release with changes in values of `values.yaml`, use the `helm upgrade` command with **--set** flag. You can specify **--set** flag multiple times. The priority will be given to the right most set specified in the command line.
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. To upgrade helm release by providing values in a file, use the `helm upgrade` command with **-f** flag. You can use **--values** or **-f** flag multiple times. The priority will be given to the right most file specified in the command line. In the following example, if both `myvalues.yaml` and `override.yaml` contain a key called *Test*, the value set in `override.yaml` would take precedence.
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. To upgrade helm release by reusing the values from the last release and overriding some of them, a command such as below can be used:
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## Uninstall
{: #uninstall}
To uninstall {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }}, use the [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Use the following command to completely delete the installed charts and the associated deployments:
```bash
helm delete --purge <release_name>
```
*release_name* is the deployed release name of the Helm Chart.

## Troubleshooting
{: #troubleshooting}

This section guides you in identifying and resolving the likely error scenarios you might encounter while deploying Mobile Foundation

1. Helm install failed. `Error: could not find a ready tiller pod`

 - Run the below set of commands as it is and re-try helm install
  ```bash
  helm init
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm init --service-account tiller --upgrade
  ```
  
  2. Unable to pull images while deploying the Helm chart - `Failed to pull image, Error: ErrImagePull`
  
  - Make sure the image pullSecret has been added to the values.yaml before helm deployment. If image pull secret doesn't exist, create a pull secret and assign it to `image.pullSecret` in the *values.yaml* file.
 
 Example for creating a pull secret:
   
  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  ```

  > Note: Keep the value of `--docker-username=iamapikey` as it is, if you are using the IBM Cloud API key for authentication.
  
   
   
   
   




