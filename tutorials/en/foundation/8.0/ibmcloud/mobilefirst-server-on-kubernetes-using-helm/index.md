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
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance, {{ site.data.keys.mf_push }},  {{ site.data.keys.mf_analytics }} instance and {{ site.data.keys.mf_app_center}} instance on IBM Cloud Kubernetes Cluster (IKS) using Helm charts:

* Setup IBM Cloud Kubernetes Cluster
* Setup your host computer with IBM Cloud Kubernetes Service CLI (`ibmcloud`)
* Download the Passport Advantage Archive (PPA Archive) of {{ site.data.keys.product_full }} for {{ site.data.keys.prod_icp }} 
* Load the PPA archive in IBM Cloud Kubernetes Cluster
* Configure and install the {{ site.data.keys.mf_analytics }} (optional), {{ site.data.keys.mf_app_center}} (optional) and {{ site.data.keys.mf_server }}

#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Download the IBM Mobile Foundation Passport Advantage Archive](#download-the-ibm-mfpf-ppa-archive)
* [Load the IBM Mobile Foundation Passport Advantage Archive](#load-the-ibm-mfpf-ppa-archive)
* [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
* [Installing Helm Charts](#install-hmc-icp)
* [Verifying the Installation](#verify-install)
* [Sample application](#sample-app)
* [Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases](#upgrading-mf-helm-charts)
* [Uninstall](#uninstall)
* [Troubleshooting](#troubleshooting)

## Prerequisites
{: #prereqs}

You should have an **IBM Cloud account** and must have set up the [**IBM Cloud Kubernetes Cluster**](https://cloud.ibm.com/docs/containers?topic=containers-cs_cluster_tutorial).

To manage the containers and images, install the following tools on your host machine as part of IBM Cloud CLI plugins setup:

* IBM Cloud CLI (`ibmcloud`)
* Kubernetes CLI
* IBM Cloud Container Registry plug-in (`cr`)
* IBM Cloud Container Service plug-in (`ks`)

To access IBM Cloud Kubernetes Cluster using CLI, you should configure the IBM Cloud client. [Learn more](https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started).

## Download the IBM Mobile Foundation Passport Advantage Archive
{: #download-the-ibm-mfpf-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.product_full }} is available [here](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Push
* {{ site.data.keys.product_adj }} DB Initialization 
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## Load the IBM Mobile Foundation Passport Advantage Archive
{: #load-the-ibm-mfpf-ppa-archive}
Before you load the PPA Archive of {{ site.data.keys.product }}, you must setup Docker. See the instructions [here](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html).

Follow the steps given below to load the PPA Archive into IBM Cloud Kubernetes Cluster:

  1. Log in to the cluster using IBM Cloud plugin. Refer the [IBM Cloud CLI documentation] (https://cloud.ibm.com/docs/cli?topic=cloud-cli-getting-started#overview) for Command Reference.

      For example,
      ```bash
      ibmcloud login -a cloud.ibm.com
      ```
      Include the --sso option if using a federated ID. Optionally, you may intend to skip SSL validation use the flag `--skip-ssl-validation` in the above command. This would bypass SSL validation of HTTP requests. Using this parameter might cause security problems.

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
      
      3. Set the KUBECONFIG environment variable. Copy the output from the previous command and paste it in your terminal. The command output looks similar to the following example:
      
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
       4. Create and Push the **manifests**

      Below is the example for the **mfpf-server**
      
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
      
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-server:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le
      
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le
      
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-amd64
      docker push us.icr.io/my_namespace/mfpf-push:1.1.0-s390x
      docker push us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le

      # 4. Create and Push the manifests
      
      ## 4.1 Create manifest-lists
      
      docker manifest create us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le  --amend
      docker manifest create us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le  --amend

      ## 4.2 Annotate the manifests
      
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-server:1.1.0 us.icr.io/my_namespace/mfpf-server/mfpf-server:1.1.0-ppc64le --os linux --arch ppc64le


      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-dbinit:1.1.0 us.icr.io/my_namespace/mfpf-dbinit/mfpf-dbinit:1.1.0-ppc64le --os linux --arch ppc64le


      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-amd64 --os linux --arch amd64
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push:1.1.0-s390x --os linux --arch s390x
      docker manifest annotate us.icr.io/my_namespace/mfpf-push:1.1.0 us.icr.io/my_namespace/mfpf-push/mfpf-push:1.1.0-ppc64le --os linux --arch ppc64le
      
      

      ## 4.3 Push the manifest list
      
      docker manifest push us.icr.io/my_namespace/mfpf-server:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-dbinit:1.1.0
      docker manifest push us.icr.io/my_namespace/mfpf-push:1.1.0

      rm -rf ppatmp
      ```

      >**Note:** The `ibmcloud cr ppa-archive load` command approach doesn’t support the PPA package with multi-arch support. Hence one has to extract and push the package manually to the IBM Cloud Container repository (users using older PPA versions need to use following command to load).

      ```bash
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
      ```
      *archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage,

  >**Note:** Multi-architecture refers to architectures including intel (amd64), power64 (ppc64le) and s390x. Multi-arch is supported from ICP 3.1.1 only.

  The helm charts are stored in the client or local (unlike ICP helm chart stored in the IBM Cloud Private helm repository). Charts can be located within the `ppa-import/charts` (or charts) directory.

## Install and configure IBM {{ site.data.keys.product }} Helm Charts
{: #configure-install-mf-helmcharts}

Before you install and configure {{ site.data.keys.mf_server }}, you should have the following:

This section also summarizes the steps for creating secrets.

Secret objects let you store and manage sensitive information, such as passwords, OAuth tokens, ssh keys and so on. Putting this information in a secret is safer and more flexible than putting it in a Pod definition or in a container image. 

* [**Mandatory**] A DB2 database configured and ready to use. You will need the database information to [configure {{ site.data.keys.mf_server }} helm](#install-hmc-icp). {{ site.data.keys.mf_server }} requires schema and tables, which will be created (if it does not exist) in this database.

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

   The secret **mf-tls-secret** is created in the same namespace as the Ingress resource by using the following command:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```
	
   The name of the secret is then provided in the field global.ingress.secret
   
   > NOTE: Avoid using same ingress hostname if it was already used for any other helm releases.
   
* [**Optional**] Mobile Foundation Server is predefined with confidential clients for Admin Service. The credentials for these clients are provided in the `mfpserver.adminClientSecret` and `mfpserver.pushClientSecret` fields. 

   These secrets can be created as follows: 
	
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```
		
   > NOTE: If the values for these fields `mfpserver.pushClientSecret` and `mfpserver.adminClientSecret` are not provided during Mobile Foundation helm chart deployment, default auth ID / client Secret of `admin / nimda` for `mfpserver.adminClientSecret` and `push / hsup` for `mfpserver.pushClientSecret` are generated and utilized.


### Environment variables for {{ site.data.keys.mf_analytics }}
{: #env-mf-analytics }
The table below provides the environment variables used in {{ site.data.keys.mf_analytics }} on IBM Cloud Kubernetes Cluster.

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| arch | amd64 | amd64 worker node scheduler preference in a hybrid cluster | 3 - Most preferred (Default). |
|  | ppcle64 | ppc64le worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
|  | s390x | S390x worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
| image | pullPolicy | Image Pull Policy | Default is **IfNotPresent**. |
|  | tag | Docker image tag | See [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Docker image name | Name of the {{ site.data.keys.prod_adj }} Operational Analytics docker image. |
| scaling | replicaCount | Number of instances (pods) of {{ site.data.keys.prod_adj }} Operational Analytics that need to be created | Positive integer<br/>Default is **2** |
| mobileFirstAnalyticsConsole | user | Username for {{ site.data.keys.prod_adj }} Operational Analytics | Default is **admin**. |
|  | password | Password for {{ site.data.keys.prod_adj }} Operational Analytics | Default is **admin**. |
| analyticsConfiguration | clusterName | Name of the {{ site.data.keys.prod_adj }} Analytics cluster | Default is **mobilefirst** |
|  | analyticsDataDirectory | Path where analytics data is stored. *It will also be the same path where the persistent volume claim is mounted inside the container*. | Defaults to `/analyticsData` |
|  | numberOfShards | Number of Elasticsearch shards for {{ site.data.keys.prod_adj }} Analytics | Positive integer<br/>Default is **2** |
|  | replicasPerShard | Number of Elasticsearch replicas to be maintained per each shard for {{ site.data.keys.prod_adj }} Analytics | Positive integer<br/>Default is **2** |
| keystores | keystoresSecretName | Refer to [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts), describing the steps to create the secret with the keystores and their passwords. |  |
| jndiConfigurations | mfpfProperties | {{ site.data.keys.prod_adj }} JNDI properties to be specified to customize Operational Analytics | Provide comma separated name value pairs. |
| resources | limits.cpu | Describes the maximum amount of CPU allowed | Default is **2000m**<br/>Read the [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describes the maximum amount of memory allowed | Default is **4096Mi**<br/>Read the [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describes the minimum amount of CPU required. If not specified, this will default to *limits* (if specified) or otherwise implementation-defined value | Default is **1000m**. |
|  | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the *limits* (if specified) or the implementation-defined value | Default is **2048Mi**. |
| persistence | existingClaimName | The name of existing persistence volume claim (PVC) |  |
| logs | consoleFormat | Specifies container log output format. | Default is **json**. |
|  | consoleLogLevel | Controls the granularity of messages that go to the container log. | Default is **info**. |
|  | consoleSource | Specify sources that are written to the container log. Use a comma separated list for multiple sources. | Default is **message**, **trace**, **accessLog**, **ffdc**. |


### Environment variables for {{ site.data.keys.mf_server }}
{: #env-mf-server }
The table below provides the environment variables used in {{ site.data.keys.mf_server }} on IBM Cloud Kubernetes Cluster.

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| arch | amd64 | amd64 worker node scheduler preference in a hybrid cluster | 3 - Most preferred (Default). |
|  | ppcle64 | ppc64le worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
|  | s390x | S390x worker node scheduler preference in a hybrid cluster | 2 - No preference (Default). |
| image | pullPolicy | Image Pull Policy | Defaults to **IfNotPresent**. |
|  | tag | Docker image tag | See [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Docker image name | Name of the {{ site.data.keys.prod_adj }} Server Docker image. |
| scaling | replicaCount | Number of instances (pods) of {{ site.data.keys.prod_adj }} Server that need to be created | Positive integer<br/>Default is **3** |
| mobileFirstOperationsConsole | user | Username of the {{ site.data.keys.prod_adj }} Server | Default is **admin**. |
|  | password | Password for the user of {{ site.data.keys.prod_adj }} Server | Default is **admin**. |
| existingDB2Details | db2Host | IP address or HOST of the DB2 Database where {{ site.data.keys.prod_adj }} Server tables need to be configured | Currently only DB2 is supported. |
|  | db2Port | Port where DB2 database is setup |  |
|  | db2Database | Name of the database that is pre-configured in DB2 for use |  |
|  | db2Username | DB2 user name to access DB2 database | User should have access to create tables and create schema if it does not already exist. |
|  | db2Password | DB2 password for the provided database  |  |
|  | db2Schema | Server DB2 schema to be created |  |
|  | db2ConnectionIsSSL | DB2 connection type | Specify if your Database connection has to be **http** or **https**. Default value is **false** (http).<br/>Make sure that the DB2 port is also configured for the same connection mode. |
| existingMobileFirstAnalytics | analyticsEndPoint | URL of the analytics server | For example: `http://9.9.9.9:30400`.<br/> Do not specify the path to the console, this will be added during the deployment.
 |
|  | analyticsAdminUser | Username of the analytics admin user |  |
|  | analyticsAdminPassword | Password of the analytics admin user |  |
| keystores | keystoresSecretName | Refer to [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts), describing the steps to create the secret with the keystores and their passwords. |  |
| jndiConfigurations | mfpfProperties | {{ site.data.keys.prod_adj }} Server JNDI properties to customize deployment | Comma separated name value pairs. |
| resources | limits.cpu | Describes the maximum amount of CPU allowed | Default is **2000m**<br/>Read the [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describes the maximum amount of memory allowed | Default is **4096Mi**<br/>Read the [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describes the minimum amount of CPU required. If not specified, this defaults to *limits* (if specified) or otherwise implementation-defined value. | Default is **1000m**. |
|  | requests.memory | Describes the minimum amount of memory required. If not specified, this defaults to the *limits* (if specified) or the implementation-defined value | Default is **2048Mi**. |
| logs | consoleFormat | Specifies container log output format. | Default is **json**. |
|  | consoleLogLevel | Controls the granularity of messages that go to the container log. | Default is **info**. |
|  | consoleSource | Specify sources that are written to the container log. Use a comma separated list for multiple sources. | Default is **message**, **trace**, **accessLog**, **ffdc**. |

> For the tutorial on analyzing {{ site.data.keys.prod_adj }} logs using Kibana, see [here](analyzing-mobilefirst-logs-on-icp/).

## Installing Helm Charts
{: #install-hmc-icp}

### Install {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

Installation of {{ site.data.keys.mf_analytics }} is optional. If you wish to enable analytics in {{ site.data.keys.mf_server }}, you should configure and install {{ site.data.keys.mf_analytics }} first, before installing {{ site.data.keys.mf_server }}.

Before you begin the installation of {{ site.data.keys.mf_analytics }} Chart, configure the **Persistent Volume**. Provide the **Persistent Volume** to configure {{ site.data.keys.mf_analytics }}. Follow the steps detailed in [IBM Cloud Kubernetes documentation](https://console.bluemix.net/docs/containers/cs_storage_file.html#file_storage) to create **Persistent Volume**.

Follow the steps below to install and configure IBM {{ site.data.keys.mf_analytics }} on IBM Cloud Kubernetes Cluster.

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
    helm inspect values ibm-mfpf-analytics-prod-1.0.17.tgz > values.yaml
    ```    

3. Modify the **values.yaml** to add appropriate values for deploying the helm chart. Make sure the [ingress](https://console.bluemix.net/docs/containers/cs_ingress.html).hostname details, scaling etc. are added and save the values.yaml.

4. To deploy the helm chart run the following command:
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-analytics-helm-chart.tgz>
    ```
    Example for deploying analytics server:
    ```bash
    helm install -n mfpanalyticsonkubecluster -f analytics-values.yaml ./ibm-mfpf-analytics-prod-1.0.17.tgz
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
    helm inspect values ibm-mfpf-server-prod-1.0.17.tgz > values.yaml
    ```   

3. Modify the **values.yaml** to add appropriate values for deploying the helm chart. Make sure the database details, ingress, scaling etc. are added and save the values.yaml.

4. To deploy the helm chart run the following command.
    ```bash
    helm install -n <iks-cluster-name> -f values.yaml <mfp-server-helm-chart.tgz>
    ```   
    Example for deploying server:
    ```bash
    helm install -n mfpserveronkubecluster -f server-values.yaml ./ibm-mfpf-server-prod-1.0.17.tgz
    ```

>**Note:** For installing the AppCenter the above steps are to be followed with the corresponding helm chart (e.g. ibm-mfpf-appcenter-prod-1.0.17.tgz).

## Verifying the Installation
{: #verify-install}

After you have installed and configured {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_server }}, you can verify your installation and the status of the deployed pods by using IBM Cloud CLI, Kubernetes CLI and helm commands.

See the [CLI Command Reference](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_cli) in IBM Cloud CLI documentation and Helm CLI from [Helm documentation](https://docs.helm.sh/helm/).

From the IBM Cloud Kubernetes Cluster page on IBM Cloud Portal, one can use the **Launch** button to open the Kubernetes console to manage the cluster artifacts.

## Accessing {{ site.data.keys.prod_adj }} console
{: #access-mf-console}

On successful deployment, the notes will be shown as output on the terminal. You can run the commands directly to get the console URL via *NodePort*.

Example, for Mobile Foundation Server notes displayed is as follows:

```text
The Notes displayed as follows as the result of the helm deployment
Get the Server URL by running these commands:
1. For http endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[0].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo http://$NODE_IP:$NODE_PORT/mfpconsole
2. For https endpoint:
 export NODE_PORT=$(kubectl get --namespace default -o jsonpath=“{.spec.ports[1].nodePort}” services monitor-mfp-ibm-mfpf-server-prod)
 export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath=“{.items[0].status.addresses[0].address}“)
 echo https://$NODE_IP:$NODE_PORT/mfpconsole
```

Using similar installation method, you can access IBM MobileFirst Analytics Console using `<protocol>://<ip_address>:<node_port>/analytics/console`  and  IBM Mobile Foundation Application Center using <`protocol>://<ip_address>:<node_port>/appcenter/console`
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

>**Note:** The port 9600 is exposed internally in the Kubernetes service and is used by the {{ site.data.keys.prod_adj }} Analytics instances as the transport port.


## Sample application
{: #sample-app}
See the [{{ site.data.keys.prod_adj }} tutorials](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/), to deploy the sample adapter and to run the sample application on IBM {{ site.data.keys.mf_server }} running on IBM Cloud Kubernetes Cluster.

## Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases
{: #upgrading-mf-helm-charts}

Please refer to [Upgrading bundled products](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html) for instructions on how-to upgrade helm charts/releases.

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
  
   - To resolve the issue, create a pull secret and provide this secret name under the input field `pullSecret` of the values.yaml file.
 
 Example for creating a pull secret:
   
  ```bash
 kubectl create secret docker-registry iks-secret-name --docker-server=us.icr.io --docker-username=iamapikey --docker-password=Your_IBM_Cloud_API_key --docker-email=your_email_id
  
  ```

  > Note: Keep the value of `--docker-username=iamapikey` as it is, if you are using the IBM Cloud API key for authentication.
  
   
   
   
   




