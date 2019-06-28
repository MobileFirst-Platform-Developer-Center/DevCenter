---
layout: tutorial
title: Setting up MobileFirst Server on IBM Cloud Private
breadcrumb_title: Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} and {{ site.data.keys.mf_app_center}} instance on {{ site.data.keys.prod_icp }}:

* Setup IBM Cloud Private Kubernetes Cluster.
* Setup your host computer with the required tools (Docker CLI, IBM Cloud CLI (`cloudctl`), Kubernetes CLI (`kubectl`), and Helm CLI (`helm`)).
* Download the Passport Advantage Archive (PPA Archive) of {{ site.data.keys.product_full }} for {{ site.data.keys.prod_icp }} .
* Load the PPA archive in the {{ site.data.keys.prod_icp }} Cluster.
* Finally, you will configure and install the {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} (optional), {{ site.data.keys.mf_push }} (optional) and {{ site.data.keys.mf_app_center }} (optional).

#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Download the IBM Mobile Foundation Passport Advantage Archive](#download-the-ibm-mfpf-ppa-archive)
* [Load the IBM Mobile Foundation Passport Advantage Archive](#load-the-ibm-mfpf-ppa-archive)
* [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
* [Resources Required](#resources-required)
* [Verifying the Installation](#verify-install)
* [Sample application](#sample-app)
* [Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases](#upgrading-mf-helm-charts)
* [Migrate to IBM Certified Cloud Pak for Mobile Foundation Platform](#migrate)
* [Uninstall](#uninstall)
* [Limitations](#limitations)

## Prerequisites
{: #prereqs}

You should have {{ site.data.keys.prod_icp }} account and must have set up the Kubernetes Cluster by following the documentation in [{{ site.data.keys.prod_icp }} Cluster installation](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/installing/install_containers.html#setup).

To manage containers and images, you need to install the following tools on your host machine as part of {{ site.data.keys.prod_icp }} setup:

* Docker
* IBM Cloud CLI (`cloudctl`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

To access {{ site.data.keys.prod_icp }} Cluster using CLI, you should configure the *kubectl* client. [Learn more](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.0/manage_cluster/cfc_cli.html).

In order to create Kubernetes artifacts like Secrets, Persistent Volumes (PV) and Persistent Volume Claims (PVC) on IBM Cloud Private, `kubectl` cli is required. 

a. Install `kubectl` tooling from the IBM Cloud Private management console, click **Menu > Command Line Tools > Cloud Private CLI**.
b. Expand **Install Kubernetes CLI** to download the installer by using a `curl` command. Copy and run the curl command for your operating system, then continue the installation procedure:
c. Choose the curl command for the applicable operating system. For example, you can run the following command for macOS:
   ```bash
   curl -kLo <install_file> https://<cluster ip>:<port>/api/cli/kubectl-darwin-amd64
   chmod 755 <path_to_installer>/<install_file>
   sudo mv <path_to_installer>/<install_file> /usr/local/bin/kubectl
   ```
Reference : [Installing the Kubernetes CLI (kubectl)](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/manage_cluster/install_kubectl.html)

## Download the IBM Mobile Foundation Passport Advantage Archive
{: #download-the-ibm-mfpf-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.product_full }} is available [here](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center
* {{ site.data.keys.product_adj }} Push

## Load the IBM Mobile Foundation Passport Advantage Archive
{: #load-the-ibm-mfpf-ppa-archive}
Before you load the PPA Archive of {{ site.data.keys.product }}, you must setup Docker. See the instructions [here](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_images/using_docker_cli.html).

Follow the steps given below to load the PPA Archive into {{ site.data.keys.prod_icp }} cluster:

  1. Log in to the cluster using IBM Cloud ICP plugin (`cloudctl`).
      >See the [CLI Command Reference](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_cluster/cli_commands.html) in {{ site.data.keys.prod_icp }} documentation.

     For example,
     ```bash
     cloudctl login -a https://ip:port
     ```
      Optionally, if you intend to skip SSL validation use the flag `--skip-ssl-validation` in the command above. Using this option prompts for `username` and `password` of your cluster endpoint. Proceed with the steps below, on successful login.

  2. Load the PPA Archive of {{ site.data.keys.product }} using the following command:
     ```
     cloudctl catalog load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
     ```
     *archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage,

     `--clustername` can be ignored if you had followed the previous step and made the cluster endpoint as default for `cloudctl`.

  3.  View the Docker images and Helm Charts in the {{ site.data.keys.prod_icp }} management console.
      To view Docker images,
      * Select **Platform > Container Images**.
      * Helm Charts are shown in the **Catalog**.

  On completing the above steps, you will see the uploaded version of {{ site.data.keys.prod_adj }} Helm Charts appearing in the ICP Catalog. The {{ site.data.keys.mf_server }} is listed as **ibm-mfpf-server-prod** and {{ site.data.keys.mf_analytics }} is listed as **ibm-mfpf-analytics-prod**.

## Install and configure IBM {{ site.data.keys.product }} Helm Charts
{: #configure-install-mf-helmcharts}

Before you install and configure {{ site.data.keys.mf_server }}, you should have the following:

This section summarizes the steps for creating secrets.

Secret objects let you store and manage sensitive information, such as passwords, OAuth tokens, ssh keys and so on. Putting this information in a secret is safer and more flexible than putting it in a Pod definition or in a container image. 

1. (Mandatory) A pre-configured IBM DB2® database is required for Server and Application Center components and this information will be supplied to helm chart to create appropriate tables for Server and Application Center.  For Oracle, MySQL or PostgreSQL databases, the Mobile Foundation Server database tables has to be created [manually](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/databases/) before the deployment of MFP Components.

  > NOTE: The base Docker image needs to be extended/customized for using databases other than IBM DB2®.
	
2. (Mandatory) A pre-created **Login Secret** is required for Server, Analytics and Application Center console login. For example:
	
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

   > NOTE: If these secrets are not provided, they are created with default username and password of admin/admin during the installation of Mobile Foundation helm chart

3. (Optional) You can provide your own keystore and truststore to Server, Push, Analytics and Application Center deployment by creating a secret with your own keystore and truststore.

   Pre-create a secret with `keystore.jks` and `truststore.jks` along with keystore and trustore password using the literals KEYSTORE_PASSWORD and TRUSTSTORE_PASSWORD  provide the secret name in the field keystoreSecret of respective component

   Keep the files `keystore.jks`, `truststore.jks` and its passwords as below  

   For example:

   ```bash
   kubectl create secret generic server --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
   ```

   > NOTE: The names of the files and literals should be the same as mentioned in command above.	Provide this secret name in `keystoresSecretName` input field of respective component to override the default keystores when configuring the helm chart.

4. (Optional) Mobile Foundation components can be configured with hostname based Ingress for external clients to reach them using hostname. The Ingress can be secured by using a TLS private key and certificate. The TLS private key and certificate must be defined in a secret with key names `tls.key` and `tls.crt`. 

   The secret **mf-tls-secret** is created in the same namespace as the Ingress resource by using the following command:

   ```bash
   kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
   ```
	
   The name of the secret is then provided in the field global.ingress.secret

5. (Optional) Mobile Foundation Server is predefined with confidential clients for Admin Service. The credentials for these clients are provided in the `mfpserver.adminClientSecret` and `mfpserver.pushClientSecret` fields. 

   These secrets can be created as follows: 
	
   ```bash
   kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin
   kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
   ```
	
   > NOTE: If the values for these fields `mfpserver.pushClientSecret` and `mfpserver.adminClientSecret` are not provided during Mobile Foundation helm chart installation, default auth ID / client Secret of `admin / nimda` for `mfpserver.adminClientSecret` and `push / hsup` for `mfpserver.pushClientSecret` are generated and utilized.

6. For Analytics deployment, one can choose below options for persisting analytics data

   a) To have `Persistent Volume (PV)`  and `Persistent Volume Claim (PVC)` ready and provide PVC name in the helm chart, 
	
      For example: 
	
      Sample `PersistentVolume.yaml`
	
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
	    path: <nfs_path>
	    server: <nfs_server>
      ```

      > NOTE: Make sure you add the <nfs_server> and <nfs_path> entries in the above yaml.

      Sample `PersistentVolumeClaim.yaml`
		
      ```bash
	apiVersion: v1
	kind: PersistentVolumeClaim
	metadata:
	  name: mfvolclaim
	  namespace: <namespace>
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
	
	> NOTE: Make sure you add the right <namespace> in the above yaml.

	b) To choose dynamic provisioning in the chart.

7. (Mandatory) Creating **database secrets** for Server, Push and Application Center.
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
	  APPCNTR_DB_USERNAME: Ymx1YWRtaW4=
	  APPCNTR_DB_PASSWORD: TlRaallXSmtZamRqTm1RMw==
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

This section outlines the security mechanisms for controlling access to the database. Create a secret using specified subcommand and provide the created secret name under the database details.

	
8. (Optional) Create container **Image Policy** and **Image pull secrets** when the container images are pulled from a registry that is outside the IBM Cloud Private setup's container registry (DockerHub, private docker registry, etc.)
  
   ```bash
	# Create image policy
	cat <<EOF | kubectl apply -f -
	apiVersion: securityenforcement.admission.cloud.ibm.com/v1beta1
	kind: ImagePolicy
	metadata:
	 name: image-policy
	 namespace: <namespace>
	spec:
	 repositories:
	 - name: docker.io/*
	   policy: null
	 - name: <container-image-registry-hostname>/*
	   policy: null
	EOF
  ```	
	
  ```bash	
	kubectl create secret docker-registry -n <namespace> <container-image-registry-hostname> --docker-username=<docker-registry-username> --docker-password=<docker-registry-password>
  ```
	
> NOTE: text inside < > needs to be updated with right values.


  For more information refer to [Configuring the MobileFirst Server Keystore]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).  
  
## Resources Required
{: #resources-required}

This chart uses the following resources by default:

| Component | Requested CPU  | Requested Memory | Storage
|---|---|---|---|
| Mobile Foundation Server | 1 CPU core | 2 Gi memory | For database requirements, refer [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
| Mobile Foundation Push | 1 CPU core | 2 Gi memory | For database requirements, refer [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
| Mobile Foundation Analytics | 1 CPU core | 2 Gi memory | A Persistent Volume. Refer [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts) for more information
| Mobile Foundation Application Center | 1 CPU core | 2 Gi memory | For database requirements, refer [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)

## Configuration
{: #configuration}

### Parameters
The table below provides the environment variables used in {{ site.data.keys.mf_server }} instance, {{ site.data.keys.mf_analytics }}, {{ site.data.keys.mf_push }} and {{ site.data.keys.mf_appcenter }} on {{ site.data.keys.prod_icp }}.

| Qualifier | Parameter  | Definition | Allowed Value |
|---|---|---|---|
| global.arch |  amd64    | amd64 worker node scheduler preference in a hybrid cluster | 3 - Most preferred (Default) |
|      |  ppcle64  | ppc64le worker node scheduler preference in a hybrid cluster | 2 - No preference (Default) |
|      |  s390x    | S390x worker node scheduler preference in a hybrid cluster | 2 - No preference (Default) |
| global.image     | pullPolicy | Image Pull Policy | Always, Never, or IfNotPresent. Default: IfNotPresent |
|      |  pullSecret    | Image pull secret | Required only if images are not hosted on ICP image registry |
| global.ingress | hostname | The external hostname or IP address to be used by external clients | Leave blank to default to the IP address of the cluster proxy node|
|         | secret | TLS secret name| Specifies the name of the secret for the certificate that has to be used in the Ingress definition. The secret has to be pre-created using the relevant certificate and key. Mandatory if SSL/TLS is enabled. Pre-create the secret with Certificate & Key before supplying the name here |
|         | sslPassThrough | Enable SSL passthrough | Specifies is the SSL request should be passed through to the Mobile Foundation service - SSL termination occurs in the Mobile Foundation service. Default: false |
| global.dbinit | enabled | Enable initialization of Server, Push and Application Center databases | Initializes databases and create schemas / tables for Server, Push and Application Center deployment.(Not required for Analytics). Default: true |
|  | repository | Docker image repository for database initialization | Repository of the Mobile Foundation database docker image |
|           | tag          | Docker image tag | See Docker tag description |
| mfpserver | enabled          | Flag to enable Server | true (default) or false |
| mfpserver.image | repository | Docker image repository | Repository of the Mobile Foundation Server docker image |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Check Prerequisites section|
|  mfpserver.db | host | IP address or hostname of the database where Mobile Foundation Server tables need to be configured. | IBM DB2® (default). |
|                       | port | 	Port where database is setup | |
|                       | secret | A precreated secret which has database credentials| |
|                       | name | Name of the Mobile Foundation Server database | |
|                       | schema | Server db schema to be created. | If the schema already present, it will be used. Otherwise, it will be created. |
|                       | ssl | Database connection type  | Specify if you database connection has to be http or https. Default value is false (http). Make sure that the database port is also configured for the same connection mode |
| mfpserver | adminClientSecret | Admin client secret | Specify the Client Secret name created. Refer #6 in [Prerequisites](#Prerequisites) |
|  | pushClientSecret | Push client secret | Specify the Client Secret name created. Refer #6 in [Prerequisites](#Prerequisites) |
| mfpserver.replicas |  | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: 3) |
| mfpserver.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicas field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than min. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| mfpserver.pdb     | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| mfpserver.jndiConfigurations | mfpfProperties | Mobile Foundation Server JNDI properties to customize deployment | Supply comma separated name value pairs |
| mfpserver | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| mfpserver.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | enabled          | Flag to enable Mobile Foundation Push | true (default) or false |
|           | repository   | Docker image repository |Repository of the Mobile Foundation Push docker image |
|           | tag          | Docker image tag | See Docker tag description |
| mfppush.replicas | | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: 3) |
| mfppush.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| mfppush.pdb     | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| mfppush.jndiConfigurations | mfpfProperties | Mobile Foundation Server JNDI properties to customize deployment | Supply comma separated name value pairs |
| mfppush | keystoresSecretName | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| mfppush.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics | enabled          | Flag to enable analytics | false (default) or true |
| mfpanalytics.image | repository          | Docker image repository | Repository of the Mobile Foundation Operational Analytics docker image |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Check Prerequisites section|
| mfpanalytics.replicas |  | The number of instances (pods) of Mobile Foundation Operational Analytics that need to be created | Positive integer (Default: 2) |
| mfpanalytics.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
|  mfpanalytics.shards|  | Number of Elasticsearch shards for Mobile Foundation Analytics | default to 2|             
|  mfpanalytics.replicasPerShard|  | Number of Elasticsearch replicas to be maintained per each shard for Mobile Foundation Analytics | default to 2|
| mfpanalytics.persistence | enabled         | Use a PersistentVolumeClaim to persist data                        | true |                                                 |
|            |useDynamicProvisioning      | Specify a storageclass or leave empty  | false  |                                                  |
|           |volumeName| Provide an volume name  | data-stor (default) |
|           |claimName| Provide an existing PersistentVolumeClaim  | nil |
|           |storageClassName     | Storage class of backing PersistentVolumeClaim | nil |
|           |size             | Size of data volume      | 20Gi |
| mfpanalytics.pdb     | enabled | Specify whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| mfpanalytics.jndiConfigurations | mfpfProperties | Mobile Foundation JNDI properties to be specified to customize operational analytics| Supply comma separated name value pairs  |
| mfpanalytics | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| mfpanalytics.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 2000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 4096Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 2048Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpappcenter | enabled          | Flag to enable Application Center | false (default) or true |  
| mfpappcenter.image | repository          | Docker image repository | Repository of the Mobile Foundation Application Center docker image |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Check Prerequisites section|
|  mfpappcenter.db | host | IP address or hostname of the database where Appcenter database needs to be configured	| |
|                       | port | 	Port of the database  | |             
|                       | name | Name of the database to be used | The database has to be precreated.|
|                       | secret | A precreated secret which has database credentials| |
|                       | schema | Application Center database schema to be created. | If the schema already exists, it will be used. If not, one will be created. |
|                       | ssl |Database connection type  | Specify if you database connection has to be http or https. Default value is false (http). Make sure that the database port is also configured for the same connection mode |
| mfpappcenter.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | false (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to 1) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to 10) |
|           | targetcpu | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
| mfpappcenter.pdb     | enabled | Specifu whether to enable/disable PDB. | true (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| mfpappcenter | keystoreSecret | Refer the configuration section to pre-create the secret with keystores and their passwords.|
| mfpappcenter.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

> For the tutorial on analyzing {{ site.data.keys.prod_adj }} logs using Kibana, see [here](analyzing-mobilefirst-logs-on-icp/).

### Installing {{ site.data.keys.prod_adj }} Helm Charts from ICP Catalog
{: #install-hmc-icp}

#### Install {{ site.data.keys.mf_server }}
{: #install-mf-server}

Along with the {{ site.data.keys.mf_server }}, you may also deploy {{ site.data.keys.mf_analytics }} and {{ site.data.keys.mf_app_center }} from the same chart. However, deploying  {{ site.data.keys.mf_analytics }} and {{ site.data.keys.mf_app_center }}  is optional.

Note : 

1. Before you begin the installation of {{ site.data.keys.mf_server }} ensure that you have pre-configured a DB2 database.
2. Before you begin the installation of {{ site.data.keys.mf_analytics }} Chart, configure the **Persistent Volume**. Provide the **Persistent Volume** to configure {{ site.data.keys.mf_analytics }}. Follow the steps detailed in [{{ site.data.keys.prod_icp }} documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.2/manage_cluster/create_volume.html) to create **Persistent Volume**. You may also refer the **section-6** in [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)for the sample yaml file.

Follow the steps below to install and configure IBM Mobile Foundation from {{ site.data.keys.prod_icp }} management console.

1. Go to **Catalog** in the management console.
2. Select **ibm-mobilefoundation-prod** helm chart.
3. Click **Configure**.
4. Provide the environment variables. Refer to [Configuration](#configuration) for more information.
5. Accept the **License Agreement**.
6. Click **Install**.

## Verifying the Installation
{: #verify-install}

After you have installed and configured {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_server }}, you can verify your installation and the status of the deployed pods by doing the following:

In the {{ site.data.keys.prod_icp }} Management Console. Select **Workloads > Helm Releases**. Click on the *release name* of your installation.

## Accessing {{ site.data.keys.prod_adj }} console
{: #access-mf-console}

After successful installation, the deployment may take a few minutes to complete. 

From a web browser, go to the IBM Cloud Private console page and navigate to the helm releases page as follows
1. Click Menu on the Left Top of the Page.
2. Select Workloads > Helm Releases.
3. Click on the deployed IBM Mobile Foundation helm release.
4. Refer the [NOTES](https://github.ibm.com/MobileFirst/ibm-mobilefoundation-prod/blob/development/stable/ibm-mobilefoundation-prod/templates/NOTES.txt) section for the procedure to access the Mobile Foundation Server Operations Console.

## Sample application
{: #sample-app}
See the [{{ site.data.keys.prod_adj }} tutorials](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/), to deploy the sample adapter and to run the sample application on IBM {{ site.data.keys.mf_server }} running on {{ site.data.keys.prod_icp }},

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

## Migrate to IBM Certified Cloud Pak for Mobile Foundation Platform
{: #migrate}

With [IBM Certified Cloud Pak](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/app_center/cloud_paks_over.html), the Mobile Foundation is now available for deployment as a single helm chart. This replaces the earlier approach of using three different helm charts (viz. ibm-mfpf-server-prod, ibm-mfpf-analytics-prod and ibm-mfpf-appcenter-prod) for deploying the Mobile Foundation components.

Migrating from the old Mobile Foundation components installed as separate helm releases on ICP deployment to the new consolidated single helm chart with IBM Certified Cloud Pak is simple,

1. You may retain all the configuration parameters for Server, Push, Application Center and Analytics.
2. If the Database details are used the same as old deployment, then your new Mobile Foundation deployment (Server, Push and Application Center) will have the same data as that of the old one.
3. Notice the change in the database values to be entered. Access to the database is now controlled through secrets. Refer section-4 under [Prerequisites](#Prerequisites) to create secrets for any credentials (including Console logins, Database accounts, etc).
4. Mobile Foundation Analytics data can be retained by re-using the same Persistence Volume Claim used in the old deployment.

## Uninstall
{: #uninstall}
To uninstall {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }}, use the [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Use the following command to completely delete the installed charts and the associated deployments:
```bash
helm delete --purge <release_name>
```
*release_name* is the deployed release name of the Helm Chart.

## Limitations
{: #limitations}
For databases other than IBM DB2® following are mandatory requirements

1. The database and the relevant tables to be created before configuring/deploying the helm chart.
2. Make sure the Docker image loaded via the PPA package (downloaded from IBM Passport Advantage) is extended to use the suitable database artifacts and the new docker tag is used to configure & deploy the helm chart.
