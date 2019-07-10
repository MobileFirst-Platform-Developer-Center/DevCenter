---
layout: tutorial
title: Deploying IBM Mobile Foundation for Developers 8.0 on IBM Cloud Kubernetes Cluster
breadcrumb_title: Foundation for Developers on IBM Cloud Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

IBM Mobile Foundation for Developers 8.0 is a developer edition comprises of Server and Operational Analytics components.  

The server runtime has an in-built Derby database to store the Mobile Foundation data. This restricts the users to one pod in the IBM Cloud Kubernetes deployment. Community Edition provides Mobile Foundation users a developer experience with minimal configuration parameters and ease of setting up of the Mobile Foundation instance on IBM Cloud Kubernetes Service.

Follow the instructions below to install the developer edition of IBM Mobile Foundation server with pre-configured Operational Analytics on IBM Cloud Kubernetes Service:<br/>
* Create and configure Kubernetes cluster from [here](https://cloud.ibm.com/kubernetes/clusters).
* [Optional] Setup your host computer with the required tools – Docker CLI, Kubernetes CLI (kubectl), and Helm CLI (helm).

#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Install and configure IBM Mobile Foundation for Developers 8.0 from Helm Chart Catalog](#install-the-ibm-mfpf-iks-catalog)
* [Verifying the Installation](#verify-install)
* [Sample application](#sample-app)
* [Uninstall](#uninstall)
* [Limitations](#limitations)

## Prerequisites
{: #prereqs}

You should have IBM Cloud Kubernetes Service (Free plan) created using the [IBM Cloud](https://cloud.ibm.com/) portal. Refer to the  [documentation](https://cloud.ibm.com/docs/containers?topic=containers-getting-started) for setup instructions.

To manage kube pods and helm deployment, you need to install the following tools on your host machine:

* ibmcloud CLI (`ibmcloud`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

To work with Kubernetes cluster using CLI, you should configure the *ibmcloud* client.

1. Make sure you log in to the [Clusters page](https://cloud.ibm.com/kubernetes/clusters).(Note: [IBMid account](https://myibm.ibm.com/) is required)
2. Click the Kubernetes cluster to which IBM Mobile Foundation Chart needs to be deployed.
3. Follow the instructions in **Access** tab once the cluster is created.

>**Note:** Cluster creation takes few minutes. After the cluster is successfully created, click **Worker Nodes** tab and make a note of the *Public IP*.


## Install and configure IBM Mobile Foundation for Developers 8.0 Helm Chart
{: #install-the-ibm-mfpf-iks-catalog}

From the IBM Cloud client terminal (*ibmcloud* CLI), follow  the procedure under **INSTALL CHART** section in [Deploying charts from the Helm Catalog](https://cloud.ibm.com/kubernetes/helm/ibm-charts/ibm-mobilefoundation-dev), to install IBM Mobile Foundation for Developers 8.0 (**ibm-mobilefoundation-dev**) helm chart from the Catalog.

### Environment variables for IBM Mobile Foundation for Developers 8.0
{: #env-mf-developers }
The table below provides the environment variables used in IBM Mobile Foundation for Developers 8.0.

| Qualifier | Parameter | Definition | Allowed Value |
|-----------|-----------|------------|---------------|
| arch |  | Worker node architecture | Worker node architecture to which this chart should be deployed.<br/>Only **AMD64** platform is currently supported. |
| image | pullPolicy | Image Pull Policy | Always, Never, or IfNotPresent. <br/>Default is **IfNotPresent**. |
|  | repository | Docker image name | Name of the {{ site.data.keys.prod_adj }} server docker image. |
|  | tag | Docker image tag | See [Docker tag description](https://docs.docker.com/engine/reference/commandline/image_tag/) |
| resources | limits.cpu | Describes the maximum amount of CPU allowed | Default is 1000m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory | Describes the maximum amount of memory allowed | Default is 2048Mi. See Kubernetes - [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value | Default is 750m. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified via values.yaml) or the implementation-defined value | Default is 1024Mi. See Kubernetes - [meaning of memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| logs | consoleFormat | Specifies container log output format. | Default is **json**. |
|  | consoleLogLevel | Controls the granularity of messages that go to the container log. | Default is **info**. |
|  | consoleSource | Specify sources that are written to the container log. Use a comma separated list for multiple sources. | Default is **message**, **trace**, **accessLog**, **ffdc**. |

## Verifying the Installation
{: #verify-install}

After you have installed Mobile Foundation for Developers 8.0, you can verify your installation and the status of the deployed pods by doing the following:

1. From the [Clusters page](https://cloud.ibm.com/kubernetes/clusters), click on the Kubernetes Cluster on which IBM Mobile Foundation Chart has been deployed.
2. Go to the Kube dashboard by clicking on the **Kubernetes dashboard** button.
3. From the dashboard, check **Deployments** and **Pods**, they should be in **DEPLOYED** and **RUNNING** states respectively.
4. Now you need *Public IP* and *Node Port* of the deployment to access the services
	- To get **Public IP** - Select **Kubernetes** **>** **Worker Nodes**, note the IP address provided in *Public IP*.
	- **Node port** can be found in **Kubernetes Dashboard** **>** **Select Services** under the internal endpoints, note the entry for *TCP Node Port* (a five digit port).
5. Open a browser and enter `http://[public ip]:[node port]/mfpconsole` this should get you to Admin console.
6. Enter default credentials user as `admin` and password as `admin` to log in to the Mobile Foundation Server Admin console.
7. Ensure the Server Admin, Push, and Analytics operations are available.

### [OPTIONAL] Using Command Line

Alternatively, using command line one can follow the below procedure. Make sure the following command shows the **status** as *DEPLOYED*.

```bash
helm list
```
Run `kubectl` commands to check if the pods are in **RUNNING** state.

1. Get the list of all deployments on the Kubernetes cluster, and note down the Mobile Foundation deployment name.

	```bash
	kubectl get deployments
	```
2. Run the following commands to check the availability of the deployments and their status in detail. The kube pods should show availability with `(1/1) RUNNING` as their status.

	```bash
	kubectl describe deployment <deployment_name>
	kubectl get pods
	```

## Accessing {{ site.data.keys.prod_adj }} console
{: #access-mf-console}

After successful installation you can access, IBM {{ site.data.keys.prod_adj }} Operational Console using `<protocol>://<public_ip>:<node_port>/mfpconsole`.
IBM {{ site.data.keys.mf_analytics }} console can be accessed using `<protocol>://<public_ip>:<port>/analytics/console`.

The protocol can be `http` or `https`. Also, note that the port will be **NodePort** in the case of **NodePort** deployment. To get the ip address and **NodePort** of your installed {{ site.data.keys.prod_adj }} Charts, follow the steps below from the Kubernetes Dashboard.
	- To get **Public IP** - Select **Kubernetes** > **Worker Nodes** > Under Public IP - note the IP address.
	- **Node port** can be found in **Kubernetes Dashboard** > Select **Services** > Under the **internal endpoints**, note the entry for *TCP Node Port* (a five digit port).

## Sample application
{: #sample-app}
See the [{{ site.data.keys.prod_adj }} tutorials](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/), to deploy the sample adapter and to run the sample application on IBM {{ site.data.keys.mf_server }} running on IBM Cloud Kubernetes cluster.

## Uninstall
{: #uninstall}
To uninstall the `ibm-mobilefoundation-dev` helm chart, use the [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm).

Use the following command to completely delete the installed charts and the associated deployments:

```bash
helm delete --purge <release_name>
```
*release_name* is the deployed release name of the Helm Chart.

## Limitations
{: #limitations}

This Helm chart is provided only for development and testing purposes. Data is stored in the embedded Derby database and it is not persisted. The chart deployment works with only one pod due to the database restrictions.
