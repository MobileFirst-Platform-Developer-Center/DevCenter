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
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance and {{ site.data.keys.mf_analytics }} instance on IBM Cloud Kubernetes Cluster (IKS) using Helm charts:

* Setup IBM Cloud Kubernetes Cluster.
* Setup your host computer with IBM Cloud Kubernetes Service CLI (`ibmcloud`).
* Download the Passport Advantage Archive (PPA Archive) of {{ site.data.keys.product_full }} for {{ site.data.keys.prod_icp }} .
* Load the PPA archive in IBM Cloud Kubernetes Cluster.
* Finally, you will configure and install the {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_server }}.

#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Download the IBM Mobile Foundation Passport Advantage Archive](#download-the-ibm-mfpf-ppa-archive)
* [Load the IBM Mobile Foundation Passport Advantage Archive](#load-the-ibm-mfpf-ppa-archive)
* [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts)
* [Verifying the Installation](#verify-install)
* [Sample application](#sample-app)
* [Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases](#upgrading-mf-helm-charts)
* [Uninstall](#uninstall)

## Prerequisites
{: #prereqs}

You should have IBM Cloud account and must have set up the Kubernetes Cluster by following the documentation in [IBM Cloud Kubernetes Cluster service](https://console.bluemix.net/docs/containers/cs_tutorials.html).

To manage containers and images, you need to install the following tools on your host machine as part of IBM Cloud CLI plugins setup:

* IBM Cloud CLI (`ibmcloud`)
* Kubernetes CLI
* IBM Cloud Container Registry plug-in (`cr`)
* IBM Cloud Container Service plug-in (`ks`)

To access IBM Cloud Kubernetes Cluster using CLI, you should configure the IBM Cloud client. [Learn more](https://console.bluemix.net/docs/cli/index.html).

## Download the IBM Mobile Foundation Passport Advantage Archive
{: #download-the-ibm-mfpf-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.product_full }} is available [here](https://www-01.ibm.com/software/passportadvantage/pao_customer.html). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## Load the IBM Mobile Foundation Passport Advantage Archive
{: #load-the-ibm-mfpf-ppa-archive}
Before you load the PPA Archive of {{ site.data.keys.product }}, you must setup Docker. See the instructions [here](https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/manage_images/using_docker_cli.html).

Follow the steps given below to load the PPA Archive into IBM Cloud Kubernetes Cluster:

  1. Log in to the cluster using IBM Cloud plugin.

      >See the [CLI Command Reference](https://console.bluemix.net/docs/cli/index.html#overview) in IBM Cloud CLI documentation.

      For example,
      ```bash
      ibmcloud login -a https://ip:port
      ```
      Optionally, if you intend to skip SSL validation use the flag `--skip-ssl-validation` in the command above. Using this option prompts for `username` and `password` of your cluster endpoint. Proceed with the steps below, on successful login.

  2. Login into the IBM Cloud Container registry & initialize the Container Service using the following commands:
      ```bash
      ibmcloud cr login
      ibmcloud ks init
      ```  
  3. Set the region of the deployment using the following command (e.g. us-south)
      ```bash
      ibmcloud cr region-set
      ```    

  4. Load the PPA Archive of {{ site.data.keys.product }} using the following command:
      ```
      ibmcloud cr ppa-archive-load --archive <archive_name> --namespace <namespace> [--clustername <cluster_name>]
      ```
      *archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage,


  The helm charts are stored in the client or local (unlike ICP helm chart stored in the IBM Cloud Private helm repository). Charts can be located within the `ppa-import/charts` directory.

## Install and configure IBM {{ site.data.keys.product }} Helm Charts
{: #configure-install-mf-helmcharts}

Before you install and configure {{ site.data.keys.mf_server }}, you should have the following:

* [**Mandatory**] a DB2 database configured and ready to use.
  You will need the database information to [configure {{ site.data.keys.mf_server }} helm](#install-hmc-icp). {{ site.data.keys.mf_server }} requires schema and tables, which will be created (if it does not exist) in this database.

* [**Optional**] a secret with your keystore and truststore.
  You can provide your own keystore and truststore to the deployment by creating a secret with your own keystore and truststore.

  Prior to the installation, follow the steps below:

  * Create a secret with `keystore.jks`, `keystore-password.txt`, `truststore.jks`, `truststore-password.txt` and provide the secret name in the field *keystores.keystoresSecretName*.

  * Keep the files `keystore.jks` and its password in a file named `keystore-password.txt` and `truststore.jks` and its password in a file named `truststore-password.jks`.

  * Go to the command line and execute:
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**Note:** The names of the files should be the same as mentioned i.e, `keystore.jks`, `keystore-password.txt`, `truststore.jks` and `truststore-password.txt`.

  * Provide the name of the secret in *keystoresSecretName* to override the default keystores.

  For more information refer to [Configuring the MobileFirst Server Keystore]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).  

### Environment variables for {{ site.data.keys.mf_analytics }}
{: #env-mf-analytics }
The table below provides the environment variables used in {{ site.data.keys.mf_analytics }} on IBM Cloud Kubernetes Cluster.

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| arch |  | Worker node architecture | Worker node architecture to which this chart should be deployed.<br/>Only **AMD64** platform is currently supported. |
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
| arch |  | Worker node architecture | Worker node architecture to which this chart should be deployed.<br/>Only **AMD64** platform is currently supported. |
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

### Installing Helm Charts
{: #install-hmc-icp}

#### Install {{ site.data.keys.mf_analytics }}
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

#### Install {{ site.data.keys.mf_server }}
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

1. Go to the [IBM Cloud Dashboard](https://console.bluemix.net/dashboard/apps/).
2. Choose the Kubernetes Cluster on which `Analytics/Server/AppCenter` has been deployed, to open the **Overview** page.
3. Locate the Ingress subdomain for the ingress hostname and access the consoles as follows.
    * Access the IBM Mobile Foundation Operational Console using:
     `<protocol>://<ingress-hostname>/mfpconsole`
    * Access the IBM Mobile Foundation Analytics Console using:
     `<protocol>://<ingress-hostname>/analytics/console`
    * Access the IBM Mobile Foundation Application Center Console using:
     `<protocol>://<ingress-hostname>/appcenter/console`

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
