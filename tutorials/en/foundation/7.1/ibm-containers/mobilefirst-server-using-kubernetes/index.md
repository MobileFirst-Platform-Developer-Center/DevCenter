---
layout: tutorial
title: Setting Up MobileFirst Server on IBM Cloud Kubernetes Cluster
breadcrumb_title: Foundation on Kubernetes Cluster
show_disqus: false
relevantTo: [ios,android,windows,javascript]
weight: 1
sitemap: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
This tutorial demonstrates how to take a locally developed {{ site.data.keys.v63_to_80prerebrand_product_full }} project and run it on IBM Cloud on a Kubernetes Cluster. To achieve this, complete the following steps:

* Create a Kubernetes Cluster of type: Standard (paid cluster).
* Setup your host computer with the required tools (Docker, Cloud Foundry CLI ( cf ), IBM Cloud CLI ( bx ), Container Service Plugin for IBM Cloud CLI ( bx cs ), Container Registry Plugin for IBM Cloud CLI ( bx cr ), Kubernetes CLI (kubectl)).
* Build a {{ site.data.keys.mf_server }} Docker image and push it to the IBM Cloud repository.
* Finally, you will run the Docker image on a Kubernetes Cluster.

>**Note:**  
>
* Windows OS is currently not supported for running these scripts.  
* The {{ site.data.keys.mf_server }} Configuration tools cannot be used for deployments to IBM Containers.

#### Jump to:
{: #jump-to }
* [Register an account on IBM Cloud](#register-an-account-on-ibmcloud)
* [Set up your host machine](#set-up-your-host-machine)
* [Create and setup a Kubernetes Cluster with IBM Cloud Container Service](#setup-kube-cluster)
* [Download the {{ site.data.keys.mf_bm_v71_pkg_name }} archive](#download-the-ibm-mfpf-container-7100-archive)
* [Prerequisites](#prerequisites)
* [Setting Up the {{ site.data.keys.product_adj }} and Analytics Servers on Kubernetes Cluster with IBM Containers](#setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers)
* [Applying {{ site.data.keys.mf_server }} Fixes](#applying-mobilefirst-server-fixes)
* [Removing the container from IBM Cloud](#removing-the-container-from-ibmcloud)
* [Removing the Kubernetes deployments from IBM Cloud](#removing-kube-deployments)
* [Removing the database service configuration from IBM Cloud](#removing-the-database-service-configuration-from-ibmcloud)

## Register an account on IBM Cloud
{: #register-an-account-on-ibmcloud }
If you do not have an account yet, visit the [IBM Cloud website](https://bluemix.net) and click **Get Started Free** or **Sign Up**. You need to fill up a registration form before you can move on to the next step.

### IBM Cloud Dashboard
{: #the-ibmcloud-dashboard }
After signing in to IBM Cloud, you are presented with the IBM Cloud Dashboard, which provides an overview of the active IBM Cloud **space**. By default, this work area receives the name *dev*. You can create multiple work areas/spaces if needed.

## Set up your host machine
{: #set-up-your-host-machine }
To manage containers and images, you need to install the following tools:
* Docker
* IBM Cloud CLI (bx)
* Container Service Plugin for IBM Cloud CLI ( bx cs )
* Container Registry Plugin for IBM Cloud CLI ( bx cr )
* Kubernetes CLI (kubectl)

Refer to the IBM Cloud documentation for [steps to setup the prerequisite CLIs](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps).

## Create and setup a Kubernetes Cluster with IBM Cloud Container Service
{: #setup-kube-cluster}
Follow the steps in the IBM Cloud documentation to [setup a Kubernetes Cluster on IBM Cloud](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli).

>**Note:** Paid Kubernetes Cluster Type is required for deploying {{ site.data.keys.mf_bm_short }}.

## Download the {{ site.data.keys.mf_bm_v71_pkg_name }} archive
{: #download-the-ibm-mfpf-container-7100-archive}
To set up {{ site.data.keys.mf_bm_short }} as a Kubernetes Cluster using IBM Cloud containers, you must first create an image that will later be pushed to IBM Cloud.<br/>
Interim fixes for the MobileFirst Server on IBM Containers can be obtained from the [IBM Fix Central](http://www.ibm.com/support/fixcentral).<br/>
The latest iFix from Fix Central has support for deploying {{ site.data.keys.mf_bm_short }} to Kubernetes Cluster. Download the latest interim fix from Fix central by searching for *{{ site.data.keys.v63_to_80prerebrand_product_full }}* and version *7.1.0.0*.

The archive file contains the files for building an image (**dependencies** and **mfpf-libs**) and the files for building and deploying a {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} on Kubernetes (**bmx-kubenetes**).

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Click to read more about the archive file contents and available environment properties to use</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <p>The extracted ZIP file contains the files for building an image (<b>dependencies</b> and <b>mfpf-libs</b>), the files for building and deploying an {{ site.data.keys.mf_analytics_full }} Container (bmx-kubernetes/usr-mfpf-analytics),and the files for configuring an {{ site.data.keys.mf_server_full }} Container (bmx-kubernetes/usr-mfpf-server).  
                </p>
                <h4>bmx-kubernetes folder</h4>
                <p>Contains the customization files and scripts required to deploy to a Kubernetes Cluster with IBM Cloud Container Service.</p>
                <ul>
                    <li><b>Dockerfile-mfpf-server</b>: Text document that contains all the commands that are necessary to build the {{ site.data.keys.mf_server }} image.</li>
                    <li><b>Dockerfile-mfpf-analytics</b>: Text document that contains all the commands that are necessary to build the {{ site.data.keys.mf_analytics }} image.</li>
                    <li><b>usr-mfpf-server</b> folder:
                        <ul>
                            <li><b>bin</b> folder: Contains the script file that gets executed when the container starts. You can add your own custom code to be executed.</li>
                            <li><b>config</b> folder: Contains server key store configuration, user registry configuration, and {{ site.data.keys.v63_to_80prerebrand_product }} server properties (which includes runtime configuration, analytics, attribute store etc).</li>
                            <li><b>env</b> folder:  Contains server environment configuration (ports, application root names etc).</li>
                            <li><b>jre-security</b> folder: You can update the JRE security related files (truststore, policy jars etc) by placing them in this folder</li>
                            <li><b>projects</b> folder: The location of your {{ site.data.keys.v63_to_80prerebrand_product }} project runtime (<b>.war</b> file). You will place the project runtime files here.</li>
                            <li><b>security</b> folder: The key store, trust store and the LTPA keys files (<b>ltpa.keys</b>) should be placed here.</li>
                            <li><b>wxs</b> folder: Contains the data cache/extreme scale client library when Data Cache is used as attribute store for the server.</li>
                        </ul>
                    </li>
                    <li><b>usr-mfpf-analytics</b> folder:
                    <ul>
                        <li><b>bin</b> folder: Contains the script file that gets executed when the container starts. You can add your own custom code to be executed.</li>
                        <li><b>config</b> folder: Contains server key store configuration, user registry configuration, and {{ site.data.keys.v63_to_80prerebrand_product }} server properties (which includes runtime configuration, analytics, attribute store etc).</li>
                        <li><b>env</b> folder:  Contains server environment configuration (ports, application root names etc).</li>
                        <li><b>jre-security</b> folder: You can update the JRE security related files (truststore, policy jars etc) by placing them in this folder</li>
                        <li><b>security</b> folder: The key store, trust store and the LTPA keys files (<b>ltpa.keys</b>) should be placed here.</li>
                    </ul>
                    </li>  
                    <li><b>scripts</b> folder: This folder contains the scripts required to log into IBM Cloud, build a {{ site.data.keys.mf_server }} image, deploy the project runtime and to push and run the image on IBM Cloud. This folder also contains the <i>args</i> folder, which contains a set of configuration and yaml files for deploying the uploaded images to Kubernetes Cluster.</li>

                    <br/>
                </ul>
				         <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>

## Prerequisites
{: #prerequisites }

You need to have a working knowledge of Kubernetes. Refer to [Kubernetes docs](https://kubernetes.io/docs/concepts/), to learn more.

We will use the IBM Container registry to upload the Docker images. If you have not already done so, you need to create your own private namespace in the container registry.
The namespace is a unique name to identify your private repository on the IBM Cloud registry. Choose a namespace according to following rules:
* It can contain only lowercase letters, numbers, or underscores (\_).
* It can be 4 - 30 characters. If you plan to manage containers from the command line, you might prefer to have a short namespace that can be typed quickly.
* It must be unique in the IBM Cloud registry.

To set a namespace, run the command:

<code>bx cr namespace-add <i>new_name</i></code>

To get  namespaces that you have reserved in your account, run the command:

<code>bx cr namespace-list</code>

As we will see further in this tutorial, the eventual Docker images that you will upload will be of the format <i>registry-prefix/namespace/image-name:tag</i>. (For example: registry.ng.bluemix.net/mymfpnamespace/mymfp71server:v1)

### Create an IBM MobileFirst Platform Foundation project
{: #create-mfp-project}

Create a new {{ site.data.keys.product_adj }} project or use an existing one. You can find tutorials on how to create a new project, and their associated sample projects, in the [Getting Started with Foundation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/) page.


## Setting Up the {{ site.data.keys.product_adj }} and Analytics Servers on Kubernetes Cluster with IBM Containers
{: #setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers }
As explained above, you can choose to run the scripts interactively or by using the configuration files:

* **Using the configuration files** - run the scripts and pass the respective configuration file as an argument.
* **Interactively** - run the scripts without any arguments.

>**Note:** If you choose to run the scripts interactively, you can skip the configuration, but it is strongly suggested to read and understand the arguments that you will need to provide.

When you run interactively, a copy of the arguments provided is saved in a directory: `./recorded-args/`. So you can use the interactive mode for the first time and reuse the property files as a reference for future deployments.

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                The <b>args</b> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_API_URL - </b>The geo or region where you want your deployment.<br>
                      <blockquote>For example: <i>api.ng.bluemix.net</i> for US region or <i>api.eu-de.bluemix.net</i> for Germany or <i>api.au-syd.bluemix.net</i> for Sydney</blockquote>
                    </li>
                    <li><b>IBM_CLOUD_ACCOUNT_ID - </b>Your account id, which is an alpha-numeric value such as <i>a1b1b111d11e1a11d1fa1cc999999999</i><br>	Use the command <code>bx target</code> to get the Account id.</li>
                    <li><b>IBM_CLOUD_USER - </b>Your IBM Cloud username (email).</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Your IBM Cloud password.</li>
                    <li><b>IBM_CLOUD_ORG - </b>Your IBM Cloud organization name.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Your IBM Cloud space (as explained previously).</li>
                </ul><br/>
                <h4>prepareserverdbs.properties</h4>
                The {{ site.data.keys.mf_bm_short }} service requires an external <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 on cloud</i></a> instance.<br/>

                After you have set up your DB2 on Cloud instance, provide the required arguments:
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i> ( if you are using DB2 on Cloud ) or <i>DB2</i> if you are using your own DB2 database.</li>
                    <li>Provide the following if you are using your own DB2 database (i.e. DB_TYPE=DB2).
                      <ul><li><b>DB_SRV_NAME</b> - the dashDB service instance name for storing admin data.</li>
                          <li><b>ADMIN_SCHEMA_NAME</b> - the schema name for admin data. The default is <i>MFPDATA</i>.</li>
                          <li><b>RUNTIME_ NAME</b> - name of the MobileFirst Project Runtime. If you keep it empty, the script <b>prepareserverdbs.sh</b> will configure the MFP Admin database.</li>
                          <li><b>SCHEMA_NAME</b> - the schema name for runtime data. The default is name of the MobileFirst Project runtime</li>
                      </ul>
                    </li>
                    <blockquote><b>Note:</b> If your DB2 database service instance is being shared by many users or by multiple {{ site.data.keys.mf_bm_short }} deployments, make sure that you provide unique schema names.</blockquote>
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - A tag for the image. Should be of the form: <em>registry-url/namespace/image:tag</em>.</li>
                  <li><b>PROJECT_LOC</b> (Optional) - This argument allows you to directly supply your Eclipse project location. This is an alternative to dropping the MobileFirst Project runtime <b>.war</b> in the <b>usr-mfpf-server/projects/</b> folder. Mutiple projects can be delimited by comma.</li>
                  <li><b>ANALYTICS_IMAGE_TAG</b> - A tag for the image. Should be of the form: <em>registry-url/namespace/image:tag</em>.</li>
                  <blockquote>For example: <em>registry.ng.bluemix.net/myuniquenamespace/mymfpserver:v1</em><br/>If you have not yet created a docker registry namespace, create the registry namespace using one of these commands:<br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">Running the scripts</a>
            </h4>
        </div>
        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to in a non-interactive mode:</p>
            <ol>
                <li><b>initenv.sh – Logging in to IBM Cloud </b><br />
                    Run the <b>initenv.sh</b> script to create an environment for building and running {{ site.data.keys.mf_bm_short }} on IBM Containers:
                    <b>Interactive Mode</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareserverdbs.sh - Prepare the {{ site.data.keys.mf_server }} database</b><br />
                    The <b>prepareserverdbs.sh</b> script is used to configure your {{ site.data.keys.product_adj }} project database  with the DB2 on Cloud service. You will need to run it separately, once for the admin database and once for every {{ site.data.keys.product_adj }} project runtime database. The service instance of the dashDB service should be available in the Organization and Space that you logged in to in step 1.
                    Run the following:
                    <b>Interactive Mode</b>
                    For the admin database run the following once for the admin database (provide an empty value for the Runtime name) and then once for each {{ site.data.keys.product_adj }} runtime.
{% highlight bash %}
./prepareserverdbs.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
                    For the admin database make sure to comment out the RUNTIME_NAME argument and run:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                    For each MobileFirst project runtime database - first uncomment the project RUNTIME_NAME argument, change its value to match the specific project war file and run:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}                    
                </li>
                <li><b>initenv.sh(Optional) – Logging in to IBM Cloud </b><br />
                      This step is required only if you need to create your containers in a different Organization and Space than where the DB2 service instance is available. If yes, then update the initenv.properties with the new Organization and Space where the containers have to be created (and started), and rerun the <b>initenv.sh</b> script:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - Prepare the {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} images</b><br />
                    Run the <b>prepareserver.sh</b> script in order to build the {{ site.data.keys.mf_server }} and  {{ site.data.keys.mf_analytics }} images and push it to your IBM Cloud repository. To view all available images in your IBM Cloud repository, run: <code>bx cr image-list</code><br/>
                    The list contains the image name, date of creation, and ID.<br/>
                    <b>Interactive Mode</b>
{% highlight bash %}
./prepareserver.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                </li>
                <li>Deploy {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} on Docker containers on a Kubernetes cluster using IBM Cloud Container Service.
                <ol>
                  <li>Set your terminal context to your cluster<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  To know your Cluster name, run the following command: <br/><code>bx cs clusters</code><br/>
                  In the output, the path to your configuration file is displayed as a command to set an environment variable, for example:<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  Copy and paste the command above, after replacing <em>my-cluster</em> with your Cluster name, to set the environment variable in your terminal and press <b>Enter</b>.
                  </li>
                  <li><b>[Mandatory for {{ site.data.keys.mf_analytics }}]:</b> Create a <b>Persistent Volume Claim</b>. This will be used to persist analytics data. This is a one time step. You can reuse the <b>PVC</b> if you have already created it prior. Edit the <em>yaml</em> file <b>args/mfpf-persistent-volume-claim.yaml</b> and then run the command.
                  All the variables have to be substituted with their values before executing the following <em>kubectl</em> command.<br/><code>kubectl create -f ./args/mfpf-persistent-volume-claim.yaml</code><br/>
                  Note down the name of the <b>Persistent Volume Claim</b>, as you have to provide it in the subsequent step.
                  </li>
                  <li>To get your <b>Ingress domain</b> run the following command:<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   Note down your Ingress domain. If you need to configure TLS, note down the <b>Ingress secret</b>.</li>
                  <li>Create the Kubernetes deployments<br/>Edit the yaml file <b>args/mfpf-deployment-all.yaml</b>, and fill out the details. All the variables have to be substituted with their values before executing the <em>kubectl</em> command.<br/>
                  <b>./args/mfpf-deployment-all.yaml</b> contains the deployment for the following:
                  <ul>
                    <li>a kubernetes deployment for {{ site.data.keys.mf_server }} consisting of 3 instances (replicas), of 2048MB memory and 1Core CPU.</li>
                    <li>a kubernetes deployment for {{ site.data.keys.mf_analytics }} consisting of 2 instances (replicas), of 2048MB memory and 1Core CPU.</li>
                    <li>a kubernetes service for {{ site.data.keys.mf_server }}.</li>
                    <li>a kubernetes service for {{ site.data.keys.mf_analytics }}.</li>
                    <li>an ingress for the whole setup including all the REST endpints for {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }}.</li>
                    <li>a configMap to make the environment variables available in the {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} instances.</li>
                  </ul>
                  Following values have to be edited in the YAML file:<br/>
                    <ol><li>Cluster End point: All occurences of <em>my-cluster.us-south.containers.mybluemix.net</em> with the output of <b>Ingress Domain</b> from the output of <code>bx cs cluster-get</code> command as stated above.</li>
                    <li>Project path in the Ingress: This is the path that will be exposed via the Ingres. You have to create an entry for each {{ site.data.keys.product_adj }} runtime here</li>
                    <li>Image name: <em>registry.ng.bluemix.net/repository/mfpfanalytics:latest</em> and <em>registry.ng.bluemix.net/repository/mfpfserver:latest</em> - Use the same names that you used in prepareserver.sh to upload the images.</li>
                    <li><b>claimName</b>: <em>mfppvc</em> - Use the name Persistent Volume Claim name as you have used above to create the PVC.<br/></li>
                    </ol>
                    Execute the following command:<br/>
                    <code>kubectl create -f ./args/mfpf-deployment-all.yaml</code>
                    <blockquote><b>Note:<br/></b>The following template yaml files are supplied:<br/>
                    <ul><li><b>mfpf-deployment-all.yaml</b>: Deploys the {{ site.data.keys.mf_server }} and the {{ site.data.keys.mf_analytics }} with http.</li>
                      <li><b>mfpf-deployment-all-tls.yaml</b>: Deploys the {{ site.data.keys.mf_server }} and the {{ site.data.keys.mf_analytics }} with https.</li>
                      <li><b>mfpf-deployment-server.yaml</b>: Deploys the {{ site.data.keys.mf_server }} with http.</li>
                      <li><b>mfpf-deployment-analytics.yaml</b>: Deploys the {{ site.data.keys.mf_analytics }} with http.</li>
                      <li><b>mfpf-ingress.yaml</b>: Creates just the ingress definition for MFP.</li></ul></blockquote>
                      <br/>
                      <h4>Non-production deployment using Lite Cluster</h4>
                      <p>If you have a Lite cluster, then you can use the following yaml files.</p>
                        <ul>
                          <li><b>mfpf-deployment-lite-server.yaml</b>: Deploys the {{ site.data.keys.mf_server }} meant for a Lite Cluster.</li>
                          <li><b>mfpf-deployment-lite-analytics.yaml</b>: Deploys the {{ site.data.keys.mf_analytics }} meant for a Lite Cluster.</li>
                        </ul>

                      <p>Lite clusters do not come with Persistent volume and Ingress. Lite Cluster will use the NodePort based deployment (Worker node, Public IP and Kubernetes Service Port ) instead of Ingress.
                      Since Persistent volumes are not available for Lite cluster, Analytics data cannot be persisted across deployments.
                      </p>
                  </li>
                </ol>
                </li>
                <li>After creation, to use the Kubernetes dashboard, execute the following command:<br/>
                <code>kubectl proxy</code><br/>Open <b>localhost:8001/ui</b>, in your browser.</li>
                </ol>
            </div>
        </div>    
    </div>    
</div>
With {{ site.data.keys.mf_server }} running on IBM Cloud, you can now start your application development. Review the {{ site.data.keys.product }} [tutorials](../../all-tutorials).


## Applying {{ site.data.keys.mf_server }} Fixes
{: #applying-mobilefirst-server-fixes }

Interim fixes for the {{ site.data.keys.mf_server }} on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the the following folders:
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/bmx-kubernetes/usr-mfpf-server**

### Steps to apply the iFix:

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **package_root/bmx-kubernetes/usr-mfpf-server** and **package_root/bmx-kubernetes/usr-mfpf-analytics** folders, overwriting the newly installed configuration files.
3. You can now build and deploy the updated server.

    a. Run the `prepareserver.sh` script to rebuild the server image and push it to the IBM Containers service.

    b. Run the <code>kubectl create –f <em>my-deployment-yaml</em></code> to deploy {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} to the Kubernetes Cluster.

    You can also do a rolling update by running the command: <code>kubectl rolling-update NAME -f FILE</code>


## Removing the Container from IBM Cloud
{: #removing-the-container-from-ibmcloud }
When you remove a container from IBM Cloud, you must also remove the image name from the registry.  

Run the following commands to remove a container from IBM Cloud:

1. `kubectl get pods –o wide` (Lists the kubernetes pods currently running)
2. `kubectl describe pod <pod-name>` (Get details of each running pod)
3. `kubectl delete –f <FILE>` (Deletes all the kubernetes resources defined in the FILE)


Run the following commands to remove a container from IBM Cloud:

1. `cf ic ps` (Lists the containers currently running)
2. `cf ic stop <container_id>` (Stops the container)
3. `cf ic rm <container_id>` (Removes the container)

Run the following cf ic commands to remove an image name from the IBM Cloud registry:

1. `cf ic images` (Lists the images in the registry)
2. `cf ic rmi <image_id>` (Removes the image from the registry)

## Removing the Kubernetes deployments from IBM Cloud
{: #removing-kube-deployments}

Run the following commands to remove your deployed instances from  IBM Cloud Kubernetes cluster:

`kubectl delete -f mfpf-deployment-all.yaml` ( Removes all the kubernetes types defined in the yaml )

Run the following commands to remove image name from the IBM Cloud registry:
```bash
bx cr image-list (Lists the images in the registry)
bx cr image-rm <image-name> (Removes the image from the registry)
```

## Removing the database service configuration from IBM Cloud
{: #removing-the-database-service-configuration-from-ibmcloud }
If you ran the **prepareserverdbs.sh** script during the configuration of the {{ site.data.keys.mf_server }} image, the configurations and database tables required for {{ site.data.keys.mf_server }} are created. This script also creates the database schema for the container.

To remove the database service configuration from IBM Cloud, perform the following procedure using IBM Cloud dashboard.

1. From the IBM Cloud dashboard, select the DB2 on cloud service you have used. Choose the DB2 service name that you had provided as parameter while running the **prepareserverdbs.sh** script.
2. Launch the DB2 console to work with the schemas and database objects of the selected DB2 service instance.
3. Select the schemas related to IBM {{ site.data.keys.mf_server }} configuration. The schema names are ones that you have provided as parameters while running the **prepareserverdbs.sh** script.
4. Delete each of the schema after carefully inspecting the schema names and the objects under them. The database configurations are removed from IBM Cloud.
