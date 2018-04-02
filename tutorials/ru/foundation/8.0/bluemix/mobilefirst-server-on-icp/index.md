---
layout: tutorial
title: Setting up MobileFirst Server on IBM Cloud Private
breadcrumb_title: Mobile Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance and {{ site.data.keys.mf_analytics }} instance on {{ site.data.keys.prod_icp }}:

* Setup IBM Cloud Private Kubernetes Cluster.
* Setup your host computer with the required tools (Docker, IBM Cloud CLI ( bx ), {{ site.data.keys.prod_icp }} (icp) Plugin for IBM Cloud CLI (bx pr), Kubernetes CLI (kubectl)), and Helm CLI (helm)).
* Download the Passport Advantage Archive (PPA Archive) of {{ site.data.keys.product_full }} for {{ site.data.keys.prod_icp }} .
* Load the PPA archive in the {{ site.data.keys.prod_icp }} Cluster.
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

You should have {{ site.data.keys.prod_icp }} account and must have set up the Kubernetes Cluster by following the documentation in [{{ site.data.keys.prod_icp }} Cluster installation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html).

To manage containers and images, you need to install the following tools on your host machine as part of {{ site.data.keys.prod_icp }} setup:

* Docker
* IBM Cloud CLI (`bx`)
* {{ site.data.keys.prod_icp }} (ICP) plugin for IBM Cloud CLI ( `bx pr` )
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

To access {{ site.data.keys.prod_icp }} Cluster using CLI, you should configure the *kubectl* client. [Learn more](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html).

## Download the IBM Mobile Foundation Passport Advantage Archive
{: #download-the-ibm-mfpf-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.product_full }} is available [here](). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## Load the IBM Mobile Foundation Passport Advantage Archive
{: #load-the-ibm-mfpf-ppa-archive}
Before you load the PPA Archive of {{ site.data.keys.product }}, you must setup Docker. See the instructions [here](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html).

Follow the steps given below to load the PPA Archive into {{ site.data.keys.prod_icp }} cluster:

  1. Log in to the cluster using IBM Cloud ICP plugin (`bx pr`).
      >See the [CLI Command Reference](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html) in {{ site.data.keys.prod_icp }} documentation.

      For example,
      ```bash
      bx pr login -a https://ip:port
      ```
      Optionally, if you intend to skip SSL validation use the flag `--skip-ssl-validation` in the command above. Using this option prompts for `username` and `password` of your cluster endpoint. Proceed with the steps below, on successful login.

  2. Load the PPA Archive of {{ site.data.keys.product }} using the following command:
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      *archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage,

      `--clustername` can be ignored if you had followed the previous step and made the cluster endpoint as default for `bx pr`.

  3. After you load the PPA Archive, synch the repositories, which ensures the listing of Helm Charts in the **Catalog**. You can do this in {{ site.data.keys.prod_icp }} management console.
      * Select **Admin > Repositories**.
      * Click **Synch Repositories**.

  4.  View the Docker images and Helm Charts in the {{ site.data.keys.prod_icp }} management console.
      To view Docker images,
      * Select **Platform > Images**.
      * Helm Charts are shown in the **Catalog**.

  On completing the above steps, you will see the uploaded version of {{ site.data.keys.prod_adj }} Helm Charts appearing in the ICP Catalog. The {{ site.data.keys.mf_server }} is listed as **ibm-mfpf-server-prod** and {{ site.data.keys.mf_analytics }} is listed as **ibm-mfpf-analytics-prod**.

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
The table below provides the environment variables used in {{ site.data.keys.mf_analytics }} on {{ site.data.keys.prod_icp }}.

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


### Environment variables for {{ site.data.keys.mf_server }}
{: #env-mf-server }
The table below provides the environment variables used in {{ site.data.keys.mf_server }} on {{ site.data.keys.prod_icp }}.

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

### Installing {{ site.data.keys.prod_adj }} Helm Charts from ICP Catalog
{: #install-hmc-icp}

#### Install {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

Installation of {{ site.data.keys.mf_analytics }} is optional. If you wish to enable analytics in {{ site.data.keys.mf_server }}, you should configure and install {{ site.data.keys.mf_analytics }} first, before installing {{ site.data.keys.mf_server }}.

Before you begin the installation of {{ site.data.keys.mf_analytics }} Chart, configure the **Persistent Volume**. Provide the **Persistent Volume** to configure {{ site.data.keys.mf_analytics }}. Follow the steps detailed in [{{ site.data.keys.prod_icp }} documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/create_volume.html) to create **Persistent Volume**.

Follow the steps below to install and configure IBM {{ site.data.keys.mf_analytics }} from {{ site.data.keys.prod_icp }} management console.

1. Go to **Catalog** in the management console.
2. Select **ibm-mfpf-analytics-prod** helm chart.
3. Click **Configure**.
4. Provide the environment variables. Refer to [Environment Variables for {{ site.data.keys.mf_analytics }}](#env-mf-analytics) for more information.
5. Accept the **License Agreement**.
6. Click **Install**.

#### Install {{ site.data.keys.mf_server }}
{: #install-mf-server}

Before you begin the installation of {{ site.data.keys.mf_server }} ensure that you have pre-configured a DB2 database.


Follow the steps below to install and configure IBM {{ site.data.keys.mf_server }} from {{ site.data.keys.prod_icp }} management console.

1. Go to **Catalog** in the management console.
2. Select **ibm-mfpf-server-prod** helm chart.
3. Click **Configure**.
4. Provide the environment variables. Refer to [Environment Variables for {{ site.data.keys.mf_server }}](#env-mf-server) for more information.
5. Accept the **License Agreement**.
6. Click **Install**.

## Verifying the Installation
{: #verify-install}

After you have installed and configured {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_server }}, you can verify your installation and the status of the deployed pods by doing the following:

In the {{ site.data.keys.prod_icp }} Management Console. Select **Workloads > Helm Releases**. Click on the *release name* of your installation.


## Accessing {{ site.data.keys.prod_adj }} console
{: #access-mf-console}

After successful installation you can access, IBM {{ site.data.keys.prod_adj }} Operational Console using `<protocol>://<ip_address>:<port>/mfpconsole`.
IBM {{ site.data.keys.mf_analytics }} Console can be accessed using `<protocol>://<ip_address>:<port>/analytics/console`.

The protocol can be `http` or `https`. Also, note that, the port will be **NodePort** in the case of **NodePort** deployment. To get the ip_address and **NodePort** of your installed {{ site.data.keys.prod_adj }} Charts, follow the steps below:

1. In {{ site.data.keys.prod_icp }} Management Console, select **Workloads > Helm Releases**.
2. Click on the *release name* of your helm chart installation.
3. See the **Notes** section.

>**Note:** The port 9600 is exposed internally in the Kubernetes service and is used by the {{ site.data.keys.prod_adj }} Analytics instances as the transport port.


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

## Uninstall
{: #uninstall}
To uninstall {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }}, use the [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Use the following command to completely delete the installed charts and the associated deployments:
```bash
helm delete --purge <release_name>
```
*release_name* is the deployed release name of the Helm Chart.
