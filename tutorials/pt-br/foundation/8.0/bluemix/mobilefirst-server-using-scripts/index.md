---
layout: redirect
new_url: /404/
#layout: tutorial
#title: Setting Up MobileFirst Server on IBM Cloud using Scripts for IBM Containers
#breadcrumb_title: IBM Containers
#relevantTo: [ios,android,windows,javascript]
#weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Follow the instructions below to configure a {{ site.data.keys.mf_server }} instance as well as {{ site.data.keys.mf_analytics }} instance on IBM Cloud. To achieve this you will go through the following steps:

* Setup your host computer with the required tools (Cloud Foundry CLI, Docker, and IBM Containers Extension (cf ic) Plug-in)
* Setup your IBM Cloud account
* Build a {{ site.data.keys.mf_server }} image and push it to the IBM Cloud repository.

Finally, you will run the image on IBM Containers as a single Container or a Container group, and register your applications as well as deploy your adapters.

**Notes:**  

* Windows OS is currently not supported for running these scripts.  
* The {{ site.data.keys.mf_server }} Configuration tools cannot be used for deployments to IBM Containers.

#### Jump to:
{: #jump-to }
* [Register an account at IBM Cloud](#register-an-account-at-bluemix)
* [Set up your host machine](#set-up-your-host-machine)
* [Download the {{ site.data.keys.mf_bm_pkg_name }} archive](#download-the-ibm-mfpf-container-8000-archive)
* [Prerequisites](#prerequisites)
* [Setting Up the {{ site.data.keys.product_adj }} and Analytics Servers on IBM Containers](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [Applying {{ site.data.keys.mf_server }} Fixes](#applying-mobilefirst-server-fixes)
* [Removing a Container from IBM Cloud](#removing-a-container-from-bluemix)
* [Removing the database service configuration from IBM Cloud](#removing-the-database-service-configuration-from-bluemix)

## Register an account at IBM Cloud
{: #register-an-account-at-bluemix }
If you do not have an account yet, visit the [IBM Cloud website](https://bluemix.net) and click **Get Started Free** or **Sign Up**. You need to fill up a registration form before you can move on to the next step.

### The IBM Cloud Dashboard
{: #the-bluemix-dashboard }
After signing in to IBM Cloud, you are presented with the IBM Cloud Dashboard, which provides an overview of the active IBM Cloud **space**. By default, this work area receives the name "dev". You can create multiple work areas/spaces if needed.

## Set up your host machine
{: #set-up-your-host-machine }
To manage containers and images, you need to install the following tools: Docker, Cloud Foundry CLI, and IBM Containers (cf ic) Plug-in.

### Docker
{: #docker }
Go to the [Docker Documentation](https://docs.docker.com/) on the left menu, select **Install → Docker Engine**, select your OS type, and follow the instructions to install the Docker Toolbox.

**Note:** IBM does not support Docker's Kitematic.

In macOS, two options are available to run Docker commands:

* From the macOS Terminal.app: No further setup is needed. You can work only from it.
* From the Docker Quickstart Terminal: proceed as follows.

* Run the command:

  ```bash
  docker-machine env default
  ```

* Set the result as environment variables, for example:

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> For further information consult the Docker documentation.

### Cloud Foundry Plug-in and IBM Containers plug-in
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. Install the [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).
2. Install the [IBM Containers Plugin (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html).

## Download the {{ site.data.keys.mf_bm_pkg_name }} archive
{: #download-the-ibm-mfpf-container-8000-archive}
To set up {{ site.data.keys.product }} on IBM Containers, you must first create an image that will later be pushed to IBM Cloud.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Follow the instructions in this page</a> to download {{ site.data.keys.mf_server }} for IBM Containers archive (.zip file, search for: *CNBL0EN*).

The archive file contains the files for building an image (**dependencies** and **mfpf-libs**), the files for building and deploying a {{ site.data.keys.mf_analytics }} Container (**mfpf-analytics**) and files for configuring a {{ site.data.keys.mf_server }} Container (**mfpf-server**).

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false"><b>Click to read more about the archive file contents and available environment properties to use</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="Image showing the file system structure of the archive file" style="float:right;width:570px"/>
                <h4>dependencies folder</h4>
                <p>Contains the {{ site.data.keys.product }} runtime and IBM Java JRE 8.</p>

                <h4>mfpf-libs folder</h4>
                <p>Contains {{ site.data.keys.product_adj }} product component libraries and CLI.</p>

                <h4>mfpf-server and mfpf-analytics folders</h4>

                <ul>
                    <li><b>Dockerfile</b>: Text document that contains all the commands that are necessary to build an image.</li>
                    <li><b>scripts</b> folder: This folder contains the <b>args</b> folder, which contains a set of configuration files. It also contains scripts to run for logging into IBM Cloud, building a {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} image and for pushing and running the image on IBM Cloud. You can choose to run the scripts interactively or by preconfiguring the configuration files as is further explained later. Other than the customizable args/*.properties files, do not modify any elements in this folder. For script usage help, use the <code>-h</code> or <code>--help</code> command-line arguments (for example, <code>scriptname.sh --help</code>).</li>
                    <li><b>usr</b> folder:
                        <ul>
                            <li><b>bin</b> folder: Contains the script file that gets executed when the container starts. You can add your own custom code to be executed.</li>
                            <li><b>config</b> folder: Contains the server configuration fragments (keystore, server properties, user registry) used by {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }}.</li>
                            <li><b>keystore.xml</b> - the configuration of the repository of security certificates used for SSL encryption. The files listed must be referenced in the ./usr/security folder.</li>
                            <li><b>mfpfproperties.xml</b> - configuration properties for {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }}. See the supported properties listed in these documentation topics:
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for {{ site.data.keys.mf_server }} administration service</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for {{ site.data.keys.product_adj }} runtime</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - user registry configuration. The basicRegistry (a basic XML-based user-registry configuration is provided as the default. User names and passwords can be configured for basicRegistry or you can configure ldapRegistry.</li>
                        </ul>
                    </li>
                    <li><b>env</b> folder: Contains the environment properties used for server initialization (server.env) and custom JVM options (jvm.options).</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology-server-env" role="tablist">
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
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>The port used for client HTTP requests. Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>The port used for client HTTP requests secured with SSL (HTTPS). Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>Configuration not required. Valid values are <code>Standalone</code> or <code>Farm</code>. The <code>Farm</code> value is automatically set when the container is run as a container group.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>The context root at which the {{ site.data.keys.mf_server }} Administration Services are made available.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>The context root at which the {{ site.data.keys.mf_console }} is made available.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>The name of the user group assigned the predefined role <code>mfpadmin</code>.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP	</td>
                                            <td>mfpdeployergroup</td>
                                            <td>The name of the user group assigned the predefined role <code>mfpdeployer</code>.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>The name of the user group assigned the predefined role <code>mfpmonitor</code>.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP	</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>The name of the user group assigned the predefined role <code>mfpoperator</code>.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER	</td>
                                            <td>WorklightRESTUser</td>
                                            <td>The Liberty server administrator user for {{ site.data.keys.mf_server }} Administration Services.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin. Ensure that you change the default value to a private password before deploying to a production environment.</td>
                                            <td>The password of the Liberty server administrator user for {{ site.data.keys.mf_server }} Administration Services.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>The user name for the administrator role for {{ site.data.keys.mf_server }} operations.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD	</td>
                                            <td>admin</td>
                                            <td>The password for the administrator role for {{ site.data.keys.mf_server }} operations.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Click for a list of supported analytics environment properties</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Property</b></td>
                                            <td><b>Default Value</b></td>
                                            <td><b>Description</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>The port used for client HTTP requests. Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>The port used for client HTTP requests. Use -1 to disable this port.</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>The name of the user group possessing the predefined role <b>worklightadmin</b>.</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>


                    </li>
                    <li><b>jre-security</b> folder: You can update the JRE security-related files (truststore, policy JAR files, and so on) by placing them in this folder. The files in this folder get copied to the JAVA_HOME/jre/lib/security/ folder in the container.</li>
                    <li><b>security</b> folder: used to store the key store, trust store, and the LTPA keys files (ltpa.keys).</li>
                    <li><b>ssh</b> folder: used to store the SSH public key file (id_rsa.pub), which is used to enable SSH access to the container.</li>
                    <li><b>wxs</b> folder (only for {{ site.data.keys.mf_server }}): Contains the data cache / extreme-scale client library when Data Cache is used as an attribute store for the server.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>

## Prerequisites
{: #prerequisites }
The below steps are mandatory as you will be running IBM Containers commands during the following section.

1. Login to the IBM Cloud environment.  

    Run: `cf login`.  
    When prompted, enter the following information:
      * IBM Cloud API endpoint
      * Email
      * Password
      * Organization, if you have more than one
      * Space, if you have more than one

2. To run IBM Containers commands, you must first log in to the IBM Container Cloud Service.  
Run: `cf ic login`.

3. Make sure that the `namespace` for container registry is set. The `namespace` is a unique name to identify your private repository on the IBM Cloud registry. The namespace is assigned once for an organization and cannot be changed. Choose a namespace according to following rules:
     * It can contain only lowercase letters, numbers, or underscores.
     * It can be 4 - 30 characters. If you plan to manage containers from the command line, you might prefer to have a short namespace that can be typed quickly.
     * It must be unique in the IBM Cloud registry.

    To set a namespace, run the command: `cf ic namespace set <new_name>`.  
    To get the namespace that you have set, run the command: `cf ic namespace get`.

> To learn more about IC commands, use the `ic help` command.

## Setting Up the {{ site.data.keys.product_adj }}, Analytics Servers and {{ site.data.keys.mf_app_center_short }} on IBM Containers
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
As explained above, you can choose to run the scripts interactively or by using the configuration files:

* Using the configuration files - run the scripts and pass the respective configuration file as an argument.
* Interactively - run the scripts without any arguments.

**Note:** If you choose to run the scripts interactively, you can skip the configuration but it is strongly suggested to at least read and understand the arguments that you will need to provide.


### {{ site.data.keys.mf_app_center }}
{: #mobilefirst-appcenter }
If you intend to use {{ site.data.keys.mf_app_center }} start here.

>**Note:** You can download installers and DB tools from the on-premise {{ site.data.keys.mf_app_center }} installation folders (`installer` and `tools` folders).

<div class="panel-group accordion" id="scripts" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1appcenter" aria-expanded="false" aria-controls="collapseStep1appcenter">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapseStep1appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            The <b>args</b> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files.<br/>
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Your IBM Cloud username (email).</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Your IBM Cloud password.</li>
                  <li><b>IBM_CLOUD_ORG - </b>Your IBM Cloud organization name.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Your IBM Cloud space (as explained previously).</li>
              </ul>
              <h4>prepareappcenterdbs.properties</h4>
              The {{ site.data.keys.mf_app_center }} requires an external <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="_blank">dashDB Enterprise Transactional database instance</a> (Enterprise Transactional 2.8.500 or Enterprise Transactional 12.128.1400).
              <blockquote><p><b>Note:</b> The deployment of the dashDB Enterprise Transactional plans may not be immediate. You might be contacted by the Sales team before the deployment of the service.</p></blockquote>

              After you have set up your dashDB instance, provide the following required arguments:
              <ul>
                  <li><b>APPCENTER_DB_SRV_NAME - </b>Your dashDB service instance name, for storing application center data</li>
                  <li><b>APPCENTER_SCHEMA_NAME - </b>Your database schema name, used to store application center data.</li>
                  <blockquote><b>Note:</b> If your dashDB service instance is being shared by multiple users, ensure you provide unique schema names.</blockquote>

              </ul>
              <h4>prepareappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startappcenter.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Same as in <em>prepareappcenter.sh</em>.</li>
                  <li><b>SERVER_CONTAINER_NAME - </b>A name for your IBM Cloud container.</li>
                  <li><b>SERVER_IP - </b>An IP address that the IBM Cloud container should be bound to.</li>
                  <blockquote>To assign an IP address, run: <code>cf ic ip request</code>.
                  IP addresses can be reused in multiple containers in a given IBM Cloud space.
                  If you have already assigned an IP, you can run: <code>cf ic ip list</code>.</blockquote>
              </ul>
              <h4>startappcentergroup.properties</h4>
              <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>Same as in <em>prepareappcenter.sh</em>.</li>
                  <li><b>SERVER_CONTAINER_GROUP_NAME - </b>A name for your IBM Cloud container group.</li>
                  <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Your host name.</li>
                  <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>Your domain name. The default is: <code>mybluemix.net</code>.</li>
              </ul>    
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="appcenterstep2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2appcenter" aria-expanded="false" aria-controls="collapseStep2appcenter">Running the scripts</a>
            </h4>
        </div>

        <div id="collapseStep2appcenter" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to run without in interactive mode:</p>
                <ol>
                    <li><b>initenv.sh – Logging in to IBM Cloud </b><br />
                    Run the <b>initenv.sh</b> script to create an environment for building and running {{ site.data.keys.product }} on the IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud user ID or email address</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud password</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud organization name</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud space name</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>IBM Cloud API endpoint. (Defaults to https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-initenv" data-target="#collapse-script-appcenter-initenv" aria-expanded="false" aria-controls="collapse-script-appcenter-initenv"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareappcenterdbs.sh - Prepare the {{ site.data.keys.mf_app_center }} database</b><br/>
                    The <b>prepareappcenterdbs.sh</b> script is used to configure your {{ site.data.keys.mf_app_center }} with the dashDB database service. The service instance of the dashDB service should be available in the Organization and Space that you logged in to in step 1.
                    Run the following:

{% highlight bash %}
./prepareappcenterdbs.sh args/prepareappcenterdbs.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenterdbs" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenterdbs">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenterdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenterdbs">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Command-line argument</b></td>
                                              <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-db | --acdb ] APPCENTER_DB_SRV_NAME	</td>
                                              <td>IBM Cloud dashDB service (with IBM Cloud service plan of Enterprise Transactional).</td>
                                            </tr>    
                                            <tr>
                                              <td>Optional: [-ds | --acds ] APPCENTER_SCHEMA_NAME	</td>
                                              <td>Database schema name for Application Center service. Defaults to <i>APPCNTR</i>.</td>
                                            </tr>    
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
prepareappcenterdbs.sh --acdb AppCenterDashDBService
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenterdbs" data-target="#collapse-script-appcenter-prepareappcenterdbs" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenterdbs"><b>Close section</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>initenv.sh (Optional) – Logging in to IBM Cloud</b><br />
                    This step is required only if you need to create your containers in an Organization and Space different from where the dashDB service instance is available. If yes, then update the <b>initenv.properties</b> with the new Organization and Space where the containers have to be created (and started), rerun the <b>initenv.sh</b> script:</li>

{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}


                    <li><b>prepareappcenter.sh - Prepare a {{ site.data.keys.mf_app_center }} image</b><br />
                    Run the <b>prepareappcenter.sh</b> script in order to build a {{ site.data.keys.mf_app_center }} image and push it to your IBM Cloud repository. To view all available images in your IBM Cloud repository, run: <code>cf ic images</code>
                    The list contains the image name, date of creation, and ID.

                        Run:
{% highlight bash %}
./prepareappcenter.sh args/prepareappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-prepareappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-prepareappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-prepareappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-prepareappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                                <td>Name to be used for the customized MobileFirst Application Center image. Format: <em>registryUrl/namespace/imagename</em></td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
prepareappcenter.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-prepareappcenter" data-target="#collapse-script-appcenter-prepareappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-prepareappcenter"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcenter.sh - Running the image in an IBM Container</b><br/>
                    The <b>startappcenter.sh</b> script in used in order to run the {{ site.data.keys.mf_app_center }} image in an IBM Container. It also binds your image to the public IP that you configured in the <b>SERVER_IP</b> property.

                        Run:
{% highlight bash %}
./startappcenter.sh args/startappcenter.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcenter" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcenter">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcenter">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Name of the {{ site.data.keys.mf_app_center }} image.</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] SERVER_IP	</td>
                                                <td>IP address that the {{ site.data.keys.mf_app_center }} container should be bound to. (You can provide an available public IP or request one using the <code>cf ic ip request</code> command.)</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-si|--services] SERVICE_INSTANCES	</td>
                                                <td>Comma-separated IBM Cloud service instances that you want to bind to the container.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-h|--http] EXPOSE_HTTP </td>
                                                <td>Expose HTTP Port. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-s|--https] EXPOSE_HTTPS </td>
                                                <td>Expose HTTPS Port. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-m|--memory] SERVER_MEM </td>
                                                <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-se|--ssh] SSH_ENABLE </td>
                                                <td>Enable SSH for the container. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-sk|--sshkey] SSH_KEY </td>
                                                <td>The SSH Key to be injected into the container. (Provide the contents of your id_rsa.pub file.)</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-tr|--trace] TRACE_SPEC </td>
                                                <td>The trace specification to be applied. Default: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ml|--maxlog] MAX_LOG_FILES </td>
                                                <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>The maximum size of a log file. The default size is 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional:  [-v|--volume] ENABLE_VOLUME </td>
                                                <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                            </tr>

                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
startappcenter.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcenter" data-target="#collapse-script-appcenter-startappcenter" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcenter"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                    <li><b>startappcentergroup.sh - Running the image on an IBM Container group</b><br/>
                    The <b>startappcentergroup.sh</b> script is used to run the {{ site.data.keys.mf_app_center }} image on an IBM Container group. It also binds your image to the host name that you configured in the <b>SERVER_CONTAINER_GROUP_HOST</b> property.

                        Run:
{% highlight bash %}
./startappcentergroup.sh args/startappcentergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-appcenter-startappcentergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-appcenter-startappcentergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-appcenter-startappcentergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-appcenter-startappcentergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>The name of the {{ site.data.keys.mf_app_center }} container image in the IBM Cloud registry.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>The name of the {{ site.data.keys.mf_app_center }} container group.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>The host name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN </td>
                                                <td>The domain name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-gm|--min] SERVERS_CONTAINER_GROUP_MIN </td>
                                                <td>The minimum number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-gx|--max] SERVER_CONTAINER_GROUP_MAX </td>
                                                <td>The maximum number of container instances. The default value is 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED </td>
                                                <td>The desired number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-a|--auto] ENABLE_AUTORECOVERY </td>
                                                <td>Enable the automatic recovery option for the container instances. Accepted values are Y or N (default).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-si|--services] SERVICES </td>
                                                <td>Comma-separated IBM Cloud service instance names that you want to bind to the container.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-tr|--trace] TRACE_SPEC </td>
                                                <td>The trace specification to be applied. Default </code>*=info</code>.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ml|--maxlog] MAX_LOG_FILESC </td>
                                                <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-ms|--maxlogsize] MAX_LOG_FILE_SIZE </td>
                                                <td>The maximum size of a log file. The default size is 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-m|--memory] SERVER_MEM </td>
                                                <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional: [-v|--volume] ENABLE_VOLUME </td>
                                                <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                            </tr>

                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
startappcentergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-appcenter-startappcentergroup" data-target="#collapse-script-appcenter-startappcentergroup" aria-expanded="false" aria-controls="collapse-script-appcenter-startappcentergroup"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
If you intend to use analytics with your {{ site.data.keys.mf_server }} start here.

<div class="panel-group accordion" id="scripts-analytics" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1-analytics">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            The <b>args</b> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files.<br/>
            <b>Note:</b> We only include the required arguments. To learn about the additional arguments, see the documentation inside the properties files.
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>IBM_CLOUD_USER - </b>Your IBM Cloud username (email).</li>
                  <li><b>IBM_CLOUD_PASSWORD - </b>Your IBM Cloud password.</li>
                  <li><b>IBM_CLOUD_ORG - </b>Your IBM Cloud organization name.</li>
                  <li><b>IBM_CLOUD_SPACE - </b>Your IBM Cloud space (as explained previously).</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Same as in <em>prepareserver.sh</em>.</li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>A name for your IBM Cloud Container.</li>
                  <li><b>ANALYTICS_IP - </b>An IP address that the IBM Cloud Container should be bound to.<br/>
                  To assign an IP address, run: <code>cf ic ip request</code>.<br/>
                  IP addresses can be reused in multiple containers in a space.<br/>
                  If you've already assigned one, you can run: <code>cf ic ip list</code>.</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>Same as in <em>prepareserver.sh</em>.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>A name for your IBM Cloud Container group.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>Your host name.</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>Your domain name. The default is: <code>mybluemix.net</code>.</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">Running the scripts</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to run without in interactive mode:</p>
                <ol>
                    <li><b>initenv.sh – Logging in to IBM Cloud </b><br />
                    Run the <b>initenv.sh</b> script to create an environment for building and running {{ site.data.keys.mf_analytics }} on the IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-initenv" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] IBM_CLOUD_USER</td>
                                                <td>IBM Cloud user ID or email address</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                                <td>IBM Cloud password</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                                <td>IBM Cloud organization name</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                                <td>IBM Cloud space name</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                                <td>IBM Cloud API endpoint. (Defaults to https://api.ng.bluemix.net)</td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - Prepare a {{ site.data.keys.mf_analytics }} image</b><br />
                        Run the <b>prepareanalytics.sh</b> script to build a {{ site.data.keys.mf_analytics }} image and push it to your IBM Cloud repository:

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        To view all available images in your IBM Cloud repository run: <code>cf ic images</code><br/>
                        The list contains the image name, date of creation, and ID.

                        <div class="panel-group accordion" id="terminology-analytics-prepareanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>Command-line argument</b></td>
                                              <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>Name to be used for the customized analytics image. Format: IBM Cloud registry URL/private namespace/image name</td>
                                            </tr>      
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>Close section</b></a>
                                  </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - Running the image on an IBM Container</b><br />
                    The <b>startanalytics.sh</b> script is used to run the {{ site.data.keys.mf_analytics }} image on an IBM Container. It also binds your image to the public IP that you configured in the <b>ANALYTICS_IP</b> property.</li>

                    Run:
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalytics" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>Name of the analytics container image that has been loaded into the IBM Containers registry. Format: IBMCloudRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>Name of the analytics container</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>IP address that the container should be bound to. (You can provide an available public IP or request one using the <code>cf ic ip request</code> command.)</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-h|--http] EXPOSE_HTTP	</td>
                                                <td>Expose HTTP port. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-s|--https] EXPOSE_HTTPS	</td>
                                                <td>Expose HTTPS port. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-se|--ssh] SSH_ENABLE	</td>
                                                <td>Enable SSH for the container. Accepted values are Y (default) or N.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-sk|--sshkey] SSH_KEY	</td>
                                                <td>The SSH Key to be injected into the container. (Provide the contents of your id_rsa.pub file.)</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>The trace specification to be applied. Default: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>The maximum size of a log file. The default size is 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME	</td>
                                                <td>Enable mounting volume for analytics data. Accepted values are Y or N (default).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Specify the name of the volume to be created and mounted for the analytic data. The default name is <b>mfpf_analytics_container_name</b>.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>Specify the location to store the data. The default folder name is <b>/analyticsData.</b></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Provide {{ site.data.keys.mf_analytics }} properties as comma-separated key:value pairs. Note: If you specify properties using this script, ensure that these same properties have not been set in the configuration files in the usr/config folder.</td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
                        {% highlight bash %}
                        startanalytics.sh --tag image_tag_name --name container_name --ip container_ip_address
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - Running the image on an IBM Container group</b><br />
                        The <b>startanalyticsgroup.sh</b> script is used to run the {{ site.data.keys.mf_analytics }} image on an IBM Container group. It also binds your image to the host name that you configured in the <b>ANALYTICS_CONTAINER_GROUP_HOST</b> property.

                        Run:
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-analytics-startanalyticsgroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>Name of the analytics container image that has been loaded into the IBM Containers registry. Format: IBMCloudRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>The name of the analytics container group.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>The host name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>The domain name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN</td>
                                                <td>The minimum number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX	</td>
                                                <td>The maximum number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED	</td>
                                                <td>The desired number of container instances. The default value is 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>The trace specification to be applied. Default: <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>The maximum size of a log file. The default size is 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Specify {{ site.data.keys.product_adj }} properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>Specify name of the volume to be created and mounted for analytics data. Default value is <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>Specify the directory to be used for storing analytics data. Default value is <b>/analyticsData</b></td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
startanalyticsgroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                Launch the Analytics Console by loading the following URL: http://ANALYTICS-CONTAINER-HOST/analytics/console (it may take a few moments).  
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                The <b>args</b> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files:<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>IBM_CLOUD_USER - </b>Your IBM Cloud username (email).</li>
                    <li><b>IBM_CLOUD_PASSWORD - </b>Your IBM Cloud password.</li>
                    <li><b>IBM_CLOUD_ORG - </b>Your IBM Cloud organization name.</li>
                    <li><b>IBM_CLOUD_SPACE - </b>Your IBM Cloud space (as explained previously).</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                The {{ site.data.keys.mf_bm_short }} service requires an external <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>dashDB Enterprise Transactional database</i> instance</a> (<i>Enterprise Transactional 2.8.500</i> or <i>Enterprise Transactional 12.128.1400</i>).<br/>
                <b>Note:</b> The deployment of the dashDB Enterprise Transactional plans may not be immediate. You might be contacted by the Sales team before the deployment of the service.<br/><br/>
                After you have set up your dashDB instance, provide the required arguments:
                <ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>Your dashDB service instance name for storing admin data.</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>Your schema name for admin data. The default is MFPDATA.</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>Your dashDB service instance name for storing runtime data. The default is the admin service name.</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>Your schema name for runtime data. The default is MFPDATA.</li>
                    <b>Note:</b> If your dashDB service instance is being shared by many users, make sure that you provide unique schema names.
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Same as in <em>prepareserver.sh</em>.</li>
                    <li><b>SERVER_CONTAINER_NAME - </b>A name for your IBM Cloud Container.</li>
                    <li><b>SERVER_IP - </b>An IP address that the IBM Cloud Container should be bound to.<br/>
                    To assign an IP address, run: <code>cf ic ip request</code>.<br/>
                    IP addresses can be reused in multiple containers in a space.<br/>
                    If you've already assigned one, you can run: <code>cf ic ip list</code>.</li>
                    <li><b>MFPF_PROPERTIES - </b>{{ site.data.keys.mf_server }} JNDI properties separated by comma (<b>without spaces</b>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>Same as in <em>prepareserver.sh</em>.</li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>A name for your IBM Cloud Container group.</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>Your host name.</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>Your domain name. The default is: <code>mybluemix.net</code>.</li>
                    <li><b>MFPF_PROPERTIES - </b>{{ site.data.keys.mf_server }} JNDI properties, separated by commas (<b>without spaces</b>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
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

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
            <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to run without in interactive mode:</p>

            <ol>
                <li><b>initenv.sh – Logging in to IBM Cloud </b><br />
                    Run the <b>initenv.sh</b> script to create an environment for building and running {{ site.data.keys.product }} on IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-initenv" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Click for a list of command-line arguments</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Command-line argument</b></td>
                                            <td><b>Description</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] IBM_CLOUD_USER</td>
                                            <td>IBM Cloud user ID or email address</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] IBM_CLOUD_PASSWORD	</td>
                                            <td>IBM Cloud password</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] IBM_CLOUD_ORG	</td>
                                            <td>IBM Cloud organization name</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] IBM_CLOUD_SPACE	</td>
                                            <td>IBM Cloud space name</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-a|--api] IBM_CLOUD_API_URL	</td>
                                            <td>IBM Cloud API endpoint. (Defaults to https://api.ng.bluemix.net)</td>
                                        </tr>
                                    </table>

                                    <p>For example:</p>
{% highlight bash %}
initenv.sh --user IBM_CLOUD_user_ID --password IBM_CLOUD_password --org IBM_CLOUD_organization_name --space IBM_CLOUD_space_name
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - Prepare the {{ site.data.keys.mf_server }} database</b><br />
                    The <b>prepareserverdbs.sh</b> script is used to configure your {{ site.data.keys.mf_server }} with the dashDB database service. The service instance of the dashDB service should be available in the Organization and Space that you logged in to in step 1. Run the following:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserverdbs" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>Click for a list of command-line arguments</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Command-line argument</b></td>
                                            <td><b>Description</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>IBM Cloud dashDB™ service (with IBM Cloud service plan of Enterprise Transactional)</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>Database schema name for administration service. Defaults to MFPDATA</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>IBM Cloud database service instance name for storing runtime data. Defaults to the same service as given for admin data.</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-p |--push ] ENABLE_PUSH	</td>
                                            <td>Enable configuring database for push service. Accepted values are Y (default) or N.</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>IBM Cloud database service instance name for storing push data. Defaults to the same service as given for runtime data.</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>Database schema name for push service. Defaults to the runtime schema name.</td>
                                        </tr>
                                    </table>

                                    <p>For example:</p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh(Optional) – Logging in to IBM Cloud </b><br />
                      This step is required only if you need to create your containers in a different Organization and Space than where the dashDB service instance is available. If yes, then update the initenv.properties with the new Organization and Space where the containers have to be created (and started), and rerun the <b>initenv.sh</b> script:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - Prepare a {{ site.data.keys.mf_server }} image</b><br />
                    Run the <b>prepareserver.sh</b> script in order to build a {{ site.data.keys.mf_server }} image and push it to your IBM Cloud repository. To view all available images in your IBM Cloud repository, run: <code>cf ic images</code><br/>
                    The list contains the image name, date of creation, and ID.<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-prepareserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Click for a list of command-line arguments</b></a>
                                </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>Command-line argument</b></td>
                                            <td><b>Description</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>Name to be used for the customized {{ site.data.keys.mf_server }} image. Format: registryUrl/namespace/imagename</td>
                                        </tr>
                                    </table>

                                    <p>For example:</p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                  <br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>Close section</b></a>
                              </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - Running the image on an IBM Container</b><br />
                    The <b>startserver.sh</b> script is used to run the {{ site.data.keys.mf_server }} image on an IBM Container. It also binds your image to the public IP that you configured in the <b>SERVER_IP</b> property. Run:</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology-startserver" role="tablist">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Click for a list of command-line arguments</b></a>
                                </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>Command-line argument</b></td>
                                        <td><b>Description</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>Name of the {{ site.data.keys.mf_server }} image.</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>IP address that the {{ site.data.keys.mf_server }} container should be bound to. (You can provide an available public IP or request one using the <code>cf ic ip request</code> command.)</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-si|--services] SERVICE_INSTANCES	</td>
                                        <td>Comma-separated IBM Cloud service instances that you want to bind to the container.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-h|--http] EXPOSE_HTTP	</td>
                                        <td>Expose HTTP Port. Accepted values are Y (default) or N.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-s|--https] EXPOSE_HTTPS	</td>
                                        <td>Expose HTTPS Port. Accepted values are Y (default) or N.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-m|--memory] SERVER_MEM	</td>
                                        <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-se|--ssh] SSH_ENABLE	</td>
                                        <td>Enable SSH for the container. Accepted values are Y (default) or N.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-sk|--sshkey] SSH_KEY	</td>
                                        <td>The SSH Key to be injected into the container. (Provide the contents of your id_rsa.pub file.)</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-tr|--trace] TRACE_SPEC	</td>
                                        <td>The trace specification to be applied. Default: <code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                        <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                        <td>The maximum size of a log file. The default size is 20 MB.</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-v|--volume] ENABLE_VOLUME	</td>
                                        <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-e|--env] MFPF_PROPERTIES	</td>
                                        <td>Specify {{ site.data.keys.product_adj }} properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>.  <b>Note:</b> If you specify properties using this script, ensure that these same properties have not been set in the configuration files in the usr/config folder.</td>
                                    </tr>
                                </table>

                                <p>For example:</p>
{% highlight bash %}
startserver.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>Close section</b></a>
                            </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - Running the image on an IBM Container group</b><br />
                    The <b>startservergroup.sh</b> script is used to run the {{ site.data.keys.mf_server }} image on an IBM Container group. It also binds your image to the host name that you configured in the <b>SERVER_CONTAINER_GROUP_HOST</b> property.</li>
                    Run:
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology-startservergroup" role="tablist">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Click for a list of command-line arguments</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>Command-line argument</b></td>
                                                <td><b>Description</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>The name of the {{ site.data.keys.mf_server }} container image in the IBM Cloud registry.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>The name of the {{ site.data.keys.mf_server }} container group.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>The host name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>The domain name of the route.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gm|--min] SERVERS_CONTAINER_GROUP_MIN	</td>
                                                <td>The minimum number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gx|--max] SERVER_CONTAINER_GROUP_MAX	</td>
                                                <td>The maximum number of container instances. The default value is 1.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED	</td>
                                                <td>The desired number of container instances. The default value is 2.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-a|--auto] ENABLE_AUTORECOVERY	</td>
                                                <td>Enable the automatic recovery option for the container instances. Accepted values are Y or N (default).</td>
                                            </tr>

                                            <tr>
                                                <td>Optional. [-si|--services] SERVICES	</td>
                                                <td>Comma-separated IBM Cloud service instance names that you want to bind to the container.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-tr|--trace] TRACE_SPEC	</td>
                                                <td>The trace specification to be applied. Default <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>The maximum number of log files to maintain before they are overwritten. The default is 5 files.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>The maximum size of a log file. The default size is 20 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-e|--env] MFPF_PROPERTIES	</td>
                                                <td>Specify {{ site.data.keys.product_adj }} properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>Note:</b> If you specify properties using this script, ensure that the same properties have not been set in the configuration files in the usr/config folder.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-m|--memory] SERVER_MEM	</td>
                                                <td>Assign a memory size limit to the container in megabytes (MB). Accepted values are 1024 MB (default) and 2048 MB.</td>
                                            </tr>
                                            <tr>
                                                <td>Optional. [-v|--volume] ENABLE_VOLUME	</td>
                                                <td>Enable mounting volume for container logs. Accepted values are Y or N (default).</td>
                                            </tr>
                                        </table>

                                        <p>For example:</p>
{% highlight bash %}
startservergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>Close section</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **Note:** Containers must be restarted after any configuration changes have been made (`cf ic restart containerId`). For container groups, you must restart each container instance within the group. For example, if a root certificate changes, each container instance must be restarted after the new certificate has been added.

Launch the {{ site.data.keys.mf_console }} by loading the following URL: http://MF\_CONTAINER\_HOST/mfpconsole (it may take a few moments).  
Add the remote server by following the instructions in the [Using {{ site.data.keys.mf_cli }} to Manage {{ site.data.keys.product_adj }} Artifacts](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) tutorial.  

With {{ site.data.keys.mf_server }} running on IBM Cloud, you can now start your application development. Review the {{ site.data.keys.product }} [tutorials](../../all-tutorials).

#### Port number limitation
{: #port-number-limitation }
There is currently an IBM Containers limitation with the port numbers that are available for public domain. Therefore, the default port numbers given for the {{ site.data.keys.mf_analytics }} container and the {{ site.data.keys.mf_server }} container (9080 for HTTP and 9443 for HTTPS) cannot be altered. Containers in a container group must use HTTP port 9080. Container groups do not support the use of multiple port numbers or HTTPS requests.


## Applying {{ site.data.keys.mf_server }} Fixes
{: #applying-mobilefirst-server-fixes }

Interim fixes for the {{ site.data.keys.mf_server }} on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the the following folders:
* {{ site.data.keys.mf_analytics }}: **package_root/mfpf-analytics/usr**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry Application: **package_root/mfpf-server/usr**
* {{ site.data.keys.mf_app_center_short }}: **package_root/mfp-appcenter/usr**

### Steps to apply the iFix:

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **package_root/mfpf-analytics/usr**, **package_root/mfpf-server/usr** and **package_root/mfp-appcenter/usr** folders, overwriting the newly installed configuration files.
3. Edit **package_root/mfpf-server/usr/env/jvm.options** file in your editor and remove the following line, if it exists:
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    You can now build and deploy the updated server.

    a. Run the `prepareserver.sh` script to rebuild the server image and push it to the IBM Containers service.

    b. Run the `startserver.sh` script to run the server image as a standalone container or `startservergroup.sh` to run the server image as a container group.

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## Removing a Container from IBM Cloud
{: #removing-a-container-from-bluemix }
When you remove a container from IBM Cloud, you must also remove the image name from the registry.  
Run the following commands to remove a container from IBM Cloud:

1. `cf ic ps` (Lists the containers currently running)
2. `cf ic stop container_id` (Stops the container)
3. `cf ic rm container_id` (Removes the container)

Run the following cf ic commands to remove an image name from the IBM Cloud registry:

1. `cf ic images` (Lists the images in the registry)
2. `cf ic rmi image_id` (Removes the image from the registry)

## Removing the database service configuration from IBM Cloud
{: #removing-the-database-service-configuration-from-bluemix }
If you ran the **prepareserverdbs.sh** script during the configuration of the {{ site.data.keys.mf_server }} image, the configurations and database tables required for {{ site.data.keys.mf_server }} are created. This script also creates the database schema for the container.

To remove the database service configuration from IBM Cloud, perform the following procedure using IBM Cloud dashboard.

1. From the IBM Cloud dashboard, select the dashDB service you have used. Choose the dashDB service name that you had provided as parameter while running the **prepareserverdbs.sh** script.
2. Launch the dashDB console to work with the schemas and database objects of the selected dashDB service instance.
3. Select the schemas related to IBM {{ site.data.keys.mf_server }} configuration. The schema names are ones that you have provided as parameters while running the **prepareserverdbs.sh** script.
4. Delete each of the schema after carefully inspecting the schema names and the objects under them. The database configurations are removed from IBM Cloud.

Similarly, if you ran the **prepareappcenterdbs.sh** while configuring {{ site.data.keys.mf_app_center }} then follow the steps above to remove the database service configuration in IBM Cloud.
