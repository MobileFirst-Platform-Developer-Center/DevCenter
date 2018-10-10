---
layout: tutorial
title: Setting up MobileFirst Application Center on IBM Cloud Kubernetes Cluster
breadcrumb_title: Application Center on Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
>**Note:** Helm is the recommended approach to deploy software on Kubernetes Cluster. Learn about deploying [Mobile Foundation on IBM Cloud Kubernetes Cluster using helm charts](../../mobilefirst-server-on-kubernetes-using-helm).

## Overview
{: #overview }
Follow the instructions below to configure a {{ site.data.keys.mf_app_center }} instance on IBM Cloud. To achieve this you will go through the following steps:

* Create a Kubernetes Cluster of type: Standard (paid cluster).
* Setup your host computer with the required tools (Docker, Cloud Foundry CLI ( cf ), IBM Cloud CLI ( bx ), Container Service Plugin for IBM Cloud CLI ( bx cs ), Container Registry Plugin for IBM Cloud CLI ( bx cr ), Kubernetes CLI (kubectl)).
* Build a {{ site.data.keys.mf_app_center }} Docker image and push it to the IBM Cloud repository.
* Finally, you will run the Docker image on a Kubernetes Cluster.

>**Note:**  
>
* Windows OS is currently not supported for running these scripts.  
* The {{ site.data.keys.mf_server }} Configuration tools cannot be used for deployments to IBM Containers.

#### Jump to:
{: #jump-to }
- [Overview](#overview)
        - [Jump to:](#jump-to)
- [Register an account on IBM Cloud](#register-an-account-on-ibm-cloud)
    - [IBM Cloud Dashboard](#ibm-cloud-dashboard)
- [Set up your host machine](#set-up-your-host-machine)
- [Create and setup a Kubernetes Cluster with IBM Cloud Container Service](#create-and-setup-a-kubernetes-cluster-with-ibm-cloud-container-service)
- [Download the {{ site.data.keys.mf_bm_pkg_name }} archive](#download-the--sitedatakeysmfbmpkgname--archive)
- [Prerequisites](#prerequisites)
- [Setting Up the {{ site.data.keys.mf_app_center }} on Kubernetes Cluster with IBM Containers](#setting-up-the--sitedatakeysmfappcenter--on-kubernetes-cluster-with-ibm-containers)
    - [Steps to apply the iFix:](#steps-to-apply-the-ifix)
- [Removing the Container from IBM Cloud](#removing-the-container-from-ibm-cloud)
- [Removing the Kubernetes deployments from IBM Cloud](#removing-the-kubernetes-deployments-from-ibm-cloud)
- [Removing the database service configuration from IBM Cloud](#removing-the-database-service-configuration-from-ibm-cloud)

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
Refer to the IBM Cloud documentation to [setup a Kubernetes Cluster on IBM Cloud](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli).

>**Note:** Kubernetes Cluster Type: Standard (paid cluster) is required for deploying {{ site.data.keys.mf_bm_short }}.

## Download the {{ site.data.keys.mf_bm_pkg_name }} archive
{: #download-the-ibm-mfpf-container-8000-archive}
To set up {{ site.data.keys.mf_app_center }} as a Kubernetes Cluster using IBM Cloud containers, you must first create an image that will later be pushed to IBM Cloud.<br/>
Interim fixes for the MobileFirst Server on IBM Containers can be obtained from the [IBM Fix Central](http://www.ibm.com/support/fixcentral).<br/>
Download the latest interim fix from Fix central. Kubernetes support is available from iFix **8.0.0.0-IF201708220656**.

The archive file contains the files for building an image (**dependencies** and **mfpf-libs**) and the files for building and deploying a {{ site.data.keys.mf_app_center }} on Kubernetes (bmx-kubernetes).

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Click to read more about the archive file contents and available environment properties to use</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Image showing the file system structure of the archive file" style="float:right;width:570px"/>
                <h4>bmx-kubernetes folder</h4>
                <p>Contains the customization files and scripts required to deploy to a Kubernetes Cluster with IBM Cloud Container Service.</p>

                <h4>Dockerfile-mfp-appcenter</h4>

                <ul>
                    <li><b>Dockerfile-mfp-appcenter</b>: Text document that contains all the commands that are necessary to build the {{ site.data.keys.mf_app_center }} image.</li>
                    <li><b>scripts</b> folder: This folder contains the <b>args</b> folder, which contains a set of configuration files. It also contains scripts required to log into IBM Cloud, building a {{ site.data.keys.mf_app_center }} image and for pushing and running the image on IBM Cloud. You can choose to run the scripts interactively or by pre-configuring the configuration files, explained later. Other than the customizable args /*.properties files, do not modify any elements in this folder. For script usage help, use the <code>-h</code> or <code>--help</code> command-line arguments (for example, <code>scriptname.sh --help</code>).</li>
                    <li><b>usr-mfp-appcenter</b> folder:
                        <ul>
                            <li><b>bin</b> folder: Contains the script file (mfp-appcenter-init) that gets executed when the container starts. You can add your own custom code to be executed.</li>
                            <li><b>config</b> folder: Contains the server configuration fragments (keystore, server properties, user registry) used by {{ site.data.keys.mf_app_center }}.</li>
                            <li><b>keystore.xml</b> - the configuration of the repository of security certificates used for SSL encryption. The files listed must be referenced in the ./usr/security folder.</li>
                            <li><b>ltpa.xml</b> - the configuration file defining the LTPA key and its password.</li>
                            <li><b>appcentersqldb.xml</b> - JDBC Data source definition to connect to the DB2 or dashDB database.</li>
                            <li><b>registry.xml</b> - user registry configuration. The basicRegistry (a basic XML-based user-registry configuration is provided as the default. User names and passwords can be configured for basicRegistry or you can configure ldapRegistry.</li>
                            <li><b>tracespec.xml</b> - Trace specification to enable debugging as well as logging levels.</li>
                        </ul>
                    </li>
                    <li><b>jre-security</b> folder: You can update the JRE security-related files (truststore, policy JAR files, and so on) by placing them in this folder. The files in this folder get copied to the <b>JAVA_HOME/jre/lib/security/</b> folder in the container.</li>
                    <li><b>security</b> folder: used to store the key store, trust store, and the LTPA keys files (ltpa.keys).</li>
                    <li><b>env</b> folder: Contains the environment properties used for server initialization (server.env) and custom JVM options (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Click for a list of supported server environment properties</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Property</b></td>
                                            <td><b>Default Value</b></td>
                                            <td><b>Description</b></td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>The port used for client HTTP requests. Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>The port used for client HTTP requests secured with SSL (HTTPS). Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ROOT	</td>
                                            <td>applicationcenter</td>
                                            <td>The context root at which the {{ site.data.keys.mf_app_center }} Administration Services are made available.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_CONSOLE_ROOT	</td>
                                            <td>appcenterconsole</td>
                                            <td>The context root at which the {{ site.data.keys.mf_app_center }} console is made available.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_ADMIN_GROUP</td>
                                            <td>appcenteradmingroup</td>
                                            <td>The name of the user group assigned the predefined role <code>appcenteradmin</code>.</td>
                                        </tr>
                                        <tr>
                                            <td>APPCENTER_USER_GROUP	</td>
                                            <td>appcenterusergroup</td>
                                            <td>The name of the user group assigned the predefined role <code>appcenteruser</code>.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <li><b>dependencies</b> folder: Contains the {{ site.data.keys.mf_bm_short }} runtime and IBM Java JRE 8.</li>
                    <li><b>mfpf-libs folder</b> folder: Contains {{ site.data.keys.product_adj }} product component libraries and CLI.</li>
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


## Setting Up the {{ site.data.keys.mf_app_center }} on Kubernetes Cluster with IBM Containers
{: #setting-up-the-mobilefirst-appcenter-on-kube-with-ibm-containers }
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
                <h4>prepareappcenterdbs.properties</h4>
                The {{ site.data.keys.mf_app_center }} requires an external <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 on cloud</i></a> instance.<br/>
                <blockquote><b>Note:</b> You can also use your own DB2 database. The IBM Cloud Kubernetes Cluster should be configured to connect to the database.</blockquote>
                After you have set up your DB2 instance, provide the required arguments:
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i> ( if you are using DB2 on Cloud ) or <i>DB2</i> if you are using your own DB2 database.</li>
                    <li>Provide the following if you are using your own DB2 database (i.e. DB_TYPE=DB2).
                      <ul><li><b>DB2_HOST</b> - hostname of your DB2 setup.</li>
                          <li><b>DB2_DATABASE</b> - name of the database.</li>
                          <li><b>DB2_PORT</b> - port on which you will connect to the database.</li>
                          <li><b>DB2_USERNAME</b> - the DB2 database user ( the user should have the permissions to create Tables within the schema provided or if the schema does not already exist, the user should be able to create a schema )</li>
                          <li><b>DB2_PASSWORD</b> - DB2 user's password.</li>
                      </ul>
                    </li>
                    <li>Provide the following if you are using DB2 on Cloud (i.e DB_TYPE=dashDB).
                      <ul><li><b>APPCENTER_DB_SRV_NAME</b> - Your dashDB service instance name for storing appcenter data.</li>
                      </ul>
                    </li>
                    <li><b>APPCENTER_SCHEMA_NAME</b> - Your schema name for appcenter data. The default is <i>APPCNTR</i>.</li>
                    <blockquote><b>Note:</b> If your DB2 database service instance is being shared by many users or by multiple {{ site.data.keys.mf_app_center }} deployments, make sure that you provide unique schema names.</blockquote>
                </ul><br/>
                <h4>prepareappcenter.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - A tag for the image. Should be of the form: <em>registry-url/namespace/image:tag</em>.</li>
                  <blockquote>For example: <em>registry.ng.bluemix.net/myuniquenamespace/myappcenter:v1</em><br/>If you have not yet created a docker registry namespace, create the registry namespace using one of these commands:<br/>
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
                    Run the <b>initenv.sh</b> script to create an environment for building and running {{ site.data.keys.mf_app_center }} on IBM Containers:
                    <b>Interactive Mode</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareappcenterdbs.sh - Prepare the {{ site.data.keys.mf_app_center }} database</b><br />
                    The <b>prepareappcenterdbs.sh</b> script is used to configure your {{ site.data.keys.mf_app_center }} with the DB2 database service. The service instance of the DB2 service should be available in the Organization and Space that you logged in to in step 1. Run the following:
                    <b>Interactive Mode</b>
{% highlight bash %}
./prepareappcenterdbs.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh(Optional) – Logging in to IBM Cloud </b><br />
                      This step is required only if you need to create your containers in a different Organization and Space than where the DB2 service instance is available. If yes, then update the initenv.properties with the new Organization and Space where the containers have to be created (and started), and rerun the <b>initenv.sh</b> script:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareappcenter.sh - Prepare a {{ site.data.keys.mf_app_center }} image</b><br />
                    Run the <b>prepareappcenter.sh</b> script in order to build the {{ site.data.keys.mf_app_center }} image and push it to your IBM Cloud repository. To view all available images in your IBM Cloud repository, run: <code>bx cr image-list</code><br/>
                    The list contains the image name, date of creation, and ID.<br/>
                    <b>Interactive Mode</b>
{% highlight bash %}
./prepareappcenter.sh
{% endhighlight %}
                    <b>Non-interactive Mode</b>
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}
                </li>
                <li>Deploy {{ site.data.keys.mf_app_center }} on Docker containers on a Kubernetes cluster using IBM Cloud Container Service.
                <ol>
                  <li>Set your terminal context to your cluster<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  To know your Cluster name, run the following command: <br/><code>bx cs clusters</code><br/>
                  In the output, the path to your configuration file is displayed as a command to set an environment variable, for example:<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  Copy and paste the command above, after replacing <em>my-cluster</em> with your Cluster name, to set the environment variable in your terminal and press <b>Enter</b>.
                  </li>
                  <li>To get your <b>Ingress domain</b> run the following command:<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   Note down your Ingress domain. If you need to configure TLS, note down the <b>Ingress secret</b>.</li>
                  <li>Create the Kubernetes deployments<br/>Edit the yaml file <b>args/mfp-deployment-appcenter.yaml</b>, and fill out the details. All the variables have to be substituted with their values before executing the <em>kubectl</em> command.<br/>
                  <b>./args/mfp-deployment-appcenter.yaml</b> contains the deployment for the following:
                  <ul>
                    <li>a kubernetes deployment for {{ site.data.keys.mf_app_center }} consisting of 1 instance (replica), of 1024MB memory and 1Core CPU.</li>
                    <li>a kubernetes service for {{ site.data.keys.mf_app_center }}.</li>
                    <li>an ingress for the whole setup including all the REST endpints for {{ site.data.keys.mf_app_center }}.</li>
                    <li>a configMap to make the environment variables available in the {{ site.data.keys.mf_app_center }} instance.</li>
                  </ul>
                  Following values have to be edited in the YAML file:<br/>
                    <ol><li>Different occurences of <em>my-cluster.us-south.containers.mybluemix.net</em> with the output of <b>Ingress Domain</b> from the output of <code>bx cs cluster-get</code> command as stated above.</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpappcenter:latest</em> - Use the same names that you used in prepareappcenter.sh to upload the image.</li>
                    </ol>
                    Execute the following command:<br/>
                    <code>kubectl create -f ./args/mfp-deployment-appcenter.yaml</code>
                    <blockquote><b>Note:<br/></b>The following template yaml files are supplied:<br/>
                    <ul><li><b>mfp-deployment-appcenter.yaml</b>: Deploys the {{ site.data.keys.mf_app_center }} with http.</li>
                      <li><b>mfp-deployment-appcenter-with-tls.yaml</b>: Deploys the {{ site.data.keys.mf_app_center }} with https.</li>
                    </ul></blockquote>
                      After creation, to use the Kubernetes dashboard, execute the following command:<br/>
                      <code>kubectl proxy</code><br/>Open <b>localhost:8001/ui</b>, in your browser.
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>
<!--
## Applying {{ site.data.keys.mf_server }} Fixes
{: #applying-mobilefirst-server-fixes }

Interim fixes for the {{ site.data.keys.mf_server }} on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the the following folders:
* {{ site.data.keys.mf_analytics }}: **package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/bmx-kubernetes/usr-mfpf-server**

### Steps to apply the iFix:

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **package_root/bmx-kubernetes/usr-mfpf-server** and **package_root/bmx-kubernetes/usr-mfpf-analytics** folders, overwriting the newly installed configuration files.
3. Edit **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** file in your editor and remove the following line, if it exists:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    You can now build and deploy the updated server.

    a. Run the `prepareserver.sh` script to rebuild the server image and push it to the IBM Containers service.

    b. Perform a rolling update by running the following command:
      <code>kubectl rolling-update NAME -f FILE</code>
-->
<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Removing the Container from IBM Cloud
{: #removing-the-container-from-ibmcloud }
When you remove a container from IBM Cloud, you must also remove the image name from the registry.  
Run the following commands to remove a container from IBM Cloud:

1. `cf ic ps` (Lists the containers currently running)
2. `cf ic stop container_id` (Stops the container)
3. `cf ic rm container_id` (Removes the container)

Run the following cf ic commands to remove an image name from the IBM Cloud registry:

1. `cf ic images` (Lists the images in the registry)
2. `cf ic rmi image_id` (Removes the image from the registry)

## Removing the Kubernetes deployments from IBM Cloud
{: #removing-kube-deployments}

Run the following commands to remove your deployed instances from  IBM Cloud Kubernetes cluster:

`kubectl delete -f mfp-deployment-appcenter.yaml` ( Removes all the kubernetes types defined in the yaml )

Run the following commands to remove image name from the IBM Cloud registry:
```bash
bx cr image-list (Lists the images in the registry)
bx cr image-rm image-name (Removes the image from the registry)
```

## Removing the database service configuration from IBM Cloud
{: #removing-the-database-service-configuration-from-ibmcloud }
If you ran the **prepareappcenterdbs.sh** script during the configuration of the {{ site.data.keys.mf_app_center }} image, the configurations and database tables required for {{ site.data.keys.mf_app_center }} are created. This script also creates the database schema for the container.

To remove the database service configuration from IBM Cloud, perform the following procedure using IBM Cloud dashboard.

1. From the IBM Cloud dashboard, select the DB2 on cloud service you have used. Choose the DB2 service name that you had provided as parameter while running the **prepareappcenterdbs.sh** script.
2. Launch the DB2 console to work with the schemas and database objects of the selected DB2 service instance.
3. Select the schemas related to IBM {{ site.data.keys.mf_server }} configuration. The schema names are ones that you have provided as parameters while running the **prepareappcenterdbs.sh** script.
4. Delete each of the schema after carefully inspecting the schema names and the objects under them. The database configurations are removed from IBM Cloud.
