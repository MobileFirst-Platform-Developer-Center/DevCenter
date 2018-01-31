---
layout: tutorial
title: Setting up MobileFirst Application Center on IBM Cloud Private
breadcrumb_title: Application Center on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
IBM {{ site.data.keys.mf_app_center }} can be used as an Enterprise application store and is a way to share information among different team members within an organization. The concept of {{ site.data.keys.mf_app_center_short }} is similar to Apple’s public App Store or Android's  Play Store, except that it targets only private usage within an organization. By using {{ site.data.keys.mf_app_center_short }}, users within the same organization can download applications to mobile devices from a single place that serves as a repository of mobile applications.
For more information on MobileFirst Application Center, see [MobileFirst Application Center documentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/).


#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Download the IBM {{ site.data.keys.mf_app_center }} Passport Advantage Archive](#download-the-ibm-mac-ppa-archive)
* [Load the IBM {{ site.data.keys.mf_app_center }} PPA Archive in {{ site.data.keys.prod_icp }}](#load-the-ibm-mfpf-appcenter-ppa-archive)
* [Environment variables for {{ site.data.keys.mf_app_center }}](#env-mf-appcenter)
* [Install and Configure {{ site.data.keys.mf_app_center }}](#configure-install-mf-appcenter-helmcharts)
* [Verifying the Installation](#verify-install)
* [Accessing {{ site.data.keys.mf_app_center }}](#access-mf-appcenter-console)
* [Upgrading {{ site.data.keys.prod_adj }} Helm Charts and Releases](#upgrading-mf-helm-charts)
* [Uninstall](#uninstall)
* [References](#references)

## Prerequisites
{: #prereqs}

You should have {{ site.data.keys.prod_icp }} account and must have set up the Kubernetes Cluster by following the [documentation in {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html).

You require a pre-configured database to install and configure {{ site.data.keys.mf_app_center }} Charts in {{ site.data.keys.prod_icp }}. You will need to provide the database information to configure {{ site.data.keys.mf_app_center }} helm chart. The tables required for {{ site.data.keys.mf_app_center }} will be created in this database.

> Supported Databases: DB2.

To manage containers and images, you need to install the following tools on your host machine as part of {{ site.data.keys.prod_icp }} setup:

* Docker
* IBM Cloud CLI (`bx`)
* {{ site.data.keys.prod_icp }} (ICP) plugin for IBM Cloud CLI ( `bx pr` )
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

## Download the IBM {{ site.data.keys.mf_app_center }} Passport Advantage Archive
{: #download-the-ibm-mac-ppa-archive}
The Passport Advantage Archive (PPA) of {{ site.data.keys.mf_app_center }} is available [here](). The PPA archive of {{ site.data.keys.product }} will contain the docker images and Helm Charts of the following {{ site.data.keys.product }} components:
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

Interim fixes for the {{ site.data.keys.mf_app_center }} can be obtained from the [IBM Fix Central](http://www.ibm.com/support/fixcentral).<br/>

## Load the IBM {{ site.data.keys.mf_app_center }} PPA Archive in {{ site.data.keys.prod_icp }}
{: #load-the-ibm-mfpf-appcenter-ppa-archive}

Before you load the PPA Archive of {{ site.data.keys.product }}, you must set up Docker. See the instructions [here](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html).

Follow the steps given below to load the PPA Archive into {{ site.data.keys.prod_icp }} cluster:

  1. Log in to the cluster using IBM Cloud ICP plugin (`bx pr`).
      >See the [CLI Command Reference](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html) in {{ site.data.keys.prod_icp }} documentation.

      For example,
      ```bash
      bx pr login -a https://<ip>:<port>
      ```
      Optionally, if you intend to skip SSL validation use the flag `--skip-ssl-validation` in the command above. Using this option prompts for `username` and `password` of your cluster endpoint. Proceed with the steps below, on successful login.

  2. Load the PPA Archive of {{ site.data.keys.product }} using the following command:
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      *archive_name* of {{ site.data.keys.product }} is the name of the PPA archive downloaded from IBM Passport Advantage (part number CNQM3EN),

      `--clustername` can be ignored if you had followed the previous step and made the cluster endpoint as default for `bx pr`.

  3. After you load the PPA Archive, synch the repositories, this ensures that the Helm Charts are listed in the **Catalog**. You can do this in {{ site.data.keys.prod_icp }} management console.<br/>
     * Select **Admin > Repositories**.
     * Click **Synch Repositories**.

  4.  You can then view the Docker images and Helm Charts in the {{ site.data.keys.prod_icp }} management console.<br/>
      To view Docker images,
      * Select **Platform > Images**.
      * Helm Charts are shown in the **Catalog**.

  On completing the above steps, you will see the uploaded version of {{ site.data.keys.prod_adj }} Helm Charts appearing in the ICP Catalog. The {{ site.data.keys.mf_app_center }} appears as **ibm-mfpf-appcenter-prod** in the Catalog.

## Environment variables for {{ site.data.keys.mf_app_center }}
{: #env-mf-appcenter }
The table below provides the environment variables used in {{ site.data.keys.mf_app_center }} on {{ site.data.keys.prod_icp }}.

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| arch |  | Worker node architecture | Worker node architecture to which this chart should be deployed. Only **AMD64** platform is currently supported. |
| image | pullPolicy | Image Pull Policy | Default is  **IfNotPresent**. |
|  | name | Docker image name | Name of the {{ site.data.keys.mf_app_center }} docker image. |
|  | tag | Docker image tag | See [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| mobileFirstAppCenterConsole | user | Username of the  {{ site.data.keys.mf_app_center }} console |  |
|  | password | Password of the  {{ site.data.keys.mf_app_center }} console |  |
| existingDB2Details | appCenterDB2Host | IP address of the DB2 server where {{ site.data.keys.mf_app_center_short }} database will be configured |  |
|  | appCenterDB2Port | Port of the DB2 database that is setup |  |
|  | appCenterDB2Database | Name of the database to be used | The database has to be created prior. |
|  | appCenterDB2Username | DB2 user name to access the DB2 database | User should have access to create tables and create schema if it does not already exist. |
|  | appCenterDB2Password | DB2 password for the database provided |  |
|  | appCenterDB2Schema | {{ site.data.keys.mf_app_center_short }} DB2 schema to be created  |  |
|  | appCenterDB2ConnectionIsSSL | DB2 connection type | Specify if your database connection has to be **http** or **https**. Default value is **false** (http). Make sure that the DB2 port is also configured for the same connection mode. |
| keystores | keystoresSecretName | Refer to [Install and configure IBM {{ site.data.keys.product }} Helm Charts](#configure-install-mf-helmcharts), describing the steps to create the secret with the keystores and their passwords. |  |
| resources | limits.cpu | Maximum amount of CPU allowed | Default is **1000m**<br/>See [here](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) for more information. |
|  | limits.memory | Maximum amount of memory allowed | Default is **1024Mi**<br/>See [here](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) for more information. |
| resources.requests | requests.cpu | Describes the minimum amount of CPU required. If not specified, this defaults to *limits* (if specified) or otherwise implementation-defined value. | Default is **1000m**. |
|  | requests.memory | Describes the minimum memory required. If not specified, the memory will default to the *limits* (if specified) or the implementation-defined value. | Default is **1024Mi**. |

## Install and Configure {{ site.data.keys.mf_app_center }}
{: #configure-install-mf-appcenter-helmcharts}

Before you install and configure {{ site.data.keys.mf_app_center }}, you should have the following:

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

Follow the steps below to install and configure IBM {{ site.data.keys.mf_app_center }} from {{ site.data.keys.prod_icp }} management console.

1. Go to **Catalog** in management console.
2. Select **ibm-mfpf-appcenter-prod** helm chart.
3. Click **Configure**.
4. Provide the environment variables. Refer to [Environment Variables for {{ site.data.keys.mf_app_center }}](#env-mf-appcenter) for more information.
5. Click **Install**.

## Verifying the Installation
{: #verify-install}

After you have installed and configured {{ site.data.keys.mf_analytics }} (optional) and {{ site.data.keys.mf_server }}, you can verify your installation and the status of the deployed pods by doing the following:

In the {{ site.data.keys.prod_icp }} Management Console. Select **Workloads > Helm Releases**. Click on the *release name* of your installation.

## Accessing {{ site.data.keys.mf_app_center }}
{: #access-mf-appcenter-console}

After successful installation of {{ site.data.keys.mf_app_center }} Helm Chart you can access, {{ site.data.keys.mf_app_center }} Console from the browser using `<protocol>://<external_ip>:<port>/appcenterconsole`.

The protocol can either be **http** or **https**. Also, note that the port will be NodePort in case of NodePort deployment. To get the ip_address and NodePort of your installed {{ site.data.keys.mf_app_center }} Charts, follow the steps below:

1. In {{ site.data.keys.prod_icp }} Management Console, select **Workloads > Helm Releases**.
2. Click on the *release name* of your helm chart installation.
3. See the **Notes** section.

> **Note:** To access the {{ site.data.keys.mf_app_center }} mobile client, download the application center package from Passport Advantage. [Learn more](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/mobile-client/).

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
To uninstall {{ site.data.keys.mf_app_center }}, use the [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).
Use the following command to completely delete the installed charts and the associated deployments:
```bash
helm delete --purge <release_name>
```
*release_name* is the deployed release name of the Helm Chart.

## References
{: #references}

See [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/) for more information on {{ site.data.keys.mf_app_center }}.
