---
layout: tutorial
title: Setting Up MobileFirst Server on IBM Bluemix using Scripts for IBM Containers
breadcrumb_title: IBM Containers
relevantTo: [ios,android,windows,javascript]
weight: 2
---

## Overview
Follow the instructions below to configure a MobileFirst Server instance as well as MobileFirst Analytics instance on IBM Bluemix. To achieve this you will go through the following steps: 

* Setup your host computer with the required tools (Cloud Foundry CLI, Docker, and IBM Containers Extension (cf ic) Plug-in)
* Setup your Bluemix account
* Build a MobileFirst Server image and push it to the Bluemix repository.

Finally, you will run the image on IBM Containers as a single Container or a Container group, and register your applications as well as deploy your adapters.

**Notes:**  

* Windows OS is currently not supported for running these scripts.  
* The MobileFirst Server Configuration tools cannot be used for deployments to IBM Containers.

#### Jump to:

* [Register an account at Bluemix](#register-an-account-at-bluemix)
* [Set up your host machine](#set-up-your-host-machine)
* [Download the ibm-mfpf-container-8.0.0.0 archive](#download-the-ibm-mfpf-container-8-0-0-0-archive)
* [Prerequisites](#prerequisites)
* [Setting Up the MobileFirst and Analytics Servers on IBM Containers](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [Applying MobileFirst Server Fixes](#applying-mobilefirst-server-fixes)
* [Removing a Container from Bluemix](#removing-a-container-from-bluemix)
* [Removing the database service configuration from Bluemix](#removing-the-database-service-configuration-from-bluemix)

## Register an account at Bluemix
If you do not have an account yet, visit the [Bluemix website](https://bluemix.net) and click **Get Started Free** or **Sign Up**. You need to fill up a registration form before you can move on to the next step.

### The Bluemix Dashboard
After signing in to Bluemix, you are presented with the Bluemix Dashboard, which provides an overview of the active Bluemix **space**. By default, this work area receives the name "dev". You can create multiple work areas/spaces if needed.

## Set up your host machine
To manage containers and images, you need to install the following tools: Docker, Cloud Foundry CLI, and IBM Containers (cf ic) Plug-in.

### Docker
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

1. Install the [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195).
2. Install the [IBM Containers Plugin (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html).

## Download the ibm-mfpf-container-8.0.0.0 archive
To set up IBM MobileFirst Foundation on IBM Containers, you must first create an image that will later be pushed to Bluemix.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Follow the instructions in this page</a> to download the IBM MobileFirst Server 8.0 for IBM Containers archive (.zip file, search for: *CNBL0EN*).

The archive file contains the files for building an image (**dependencies** and **mfpf-libs**), the files for building and deploying a MobileFirst Operational Analytics Container (**mfpf-analytics**) and files for configuring a MobileFirst Server Container (**mfpf-server**).

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
                <h4>dependencies folder</h4>
                <p>Contains the IBM MobileFirst Foundation runtime and IBM Java JRE 8.</p>
                
                <h4>mfpf-libs folder</h4>
                <p>Contains MobileFirst product component libraries and CLI.</p>
                
                <h4>mfpf-server and mfpf-analytics folders</h4>
                
                <ul>
                    <li><b>Dockerfile</b>: Text document that contains all the commands that are necessary to build an image.</li>
                    <li><b>scripts</b> folder: This folder contains the <b>args</b> folder, which contains a set of configuration files. It also contains scripts to run for logging into Bluemix, building a MobileFirst Foundation Server/MobileFirst Foundation Operational Analytics image and for pushing and running the image on Bluemix. You can choose to run the scripts interactively or by preconfiguring the configuration files as is further explained later. Other than the customizable args/*.properties files, do not modify any elements in this folder. For script usage help, use the <code>-h</code> or <code>--help</code> command-line arguments (for example, <code>scriptname.sh --help</code>).</li>
                    <li><b>usr</b> folder:
                        <ul>
                            <li><b>bin</b> folder: Contains the script file that gets executed when the container starts. You can add your own custom code to be executed.</li>
                            <li><b>config</b> folder: ￼Contains the server configuration fragments (keystore, server properties, user registry) used by MobileFirst Server/MobileFirst Operational Analytics.</li>
                            <li><b>keystore.xml</b> - the configuration of the repository of security certificates used for SSL encryption. The files listed must be referenced in the ./usr/security folder.</li>
                            <li><b>mfpfproperties.xml</b> - configuration properties for MobileFirst Server and MobileFirst Analytics. See the supported properties listed in these documentation topics:
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">List of JNDI properties for MobileFirst Server administration service</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">List of JNDI properties for MobileFirst runtime</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - user registry configuration. The basicRegistry (a basic XML-based user-registry configuration is provided as the default. User names and passwords can be configured for basicRegistry or you can configure ldapRegistry.</li>
                        </ul>
                    </li>
                    <li><b>env</b> folder: Contains the environment properties used for server initialization (server.env) and custom JVM options (jvm.options).</li>
                    
                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>The context root at which the MobileFirst Server Administration Services are made available.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>The context root at which the MobileFirst Operations Console is made available.</td>
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
                                            <td>The Liberty server administrator user for MobileFirst Server Administration Services.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin. Ensure that you change the default value to a private password before deploying to a production environment.</td>
                                            <td>The password of the Liberty server administrator user for MobileFirst Server Administration Services.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>The user name for the administrator role for MobileFirst Server operations.</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD	</td>
                                            <td>admin</td>
                                            <td>The password for the administrator role for MobileFirst Server operations.</td>
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
                    <li><b>wxs</b> folder (only for MobileFirst Server): Contains the data cache / extreme-scale client library when Data Cache is used as an attribute store for the server.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Close section</b></a>
            </div>
        </div>
    </div>
</div>

## Prerequisites
The below steps are mandatory as you will be running IBM Containers commands during the following section.

1. Login to the IBM Bluemix environment.  

    Run: `cf login`.  
    When prompted, enter the following information:
      * Bluemix API endpoint
      * Email
      * Password
      * Organization, if you have more than one
      * Space, if you have more than one

2. To run IBM Containers commands, you must first log in to the IBM Container Cloud Service.  
Run: `cf ic login`.

3. Make sure that the `namespace` for container registry is set. The `namespace` is a unique name to identify your private repository on the Bluemix registry. The namespace is assigned once for an organization and cannot be changed. Choose a namespace according to following rules:
     * It can contain only lowercase letters, numbers, or underscores.
     * It can be 4 - 30 characters. If you plan to manage containers from the command line, you might prefer to have a short namespace that can be typed quickly.
     * It must be unique in the Bluemix registry.

    To set a namespace, run the command: `cf ic namespace set <new_name>`.  
    To get the namespace that you have set, run the command: `cf ic namespace get`.

> To learn more about IC commands, use the `ic help` command.

## Setting Up the MobileFirst and Analytics Servers on IBM Containers
As explained above, you can choose to run the scripts interactively or by using the configuration files:

* Using the configuration files - run the scripts and pass the respective configuration file as an argument.
* Interactively - run the scripts without any arguments.

**Note:** If you choose to run the scripts interactively, you can skip the configuration but it is strongly suggested to at least read and understand the arguments that you will need to provide.
### MobileFirst Foundation Operational Analytics
If you intend to use analytics with your MobileFirst Server start here.

<div class="panel-group accordion" id="scripts" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            The <strong>args</strong> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files.<br/>
            <b>Note:</b> We only include the required arguments. To learn about the additional arguments, see the documentation inside the properties files.
              <h4>initenv.properties</h4>
              <ul>
                  <li><strong>BLUEMIX_USER - </strong>Your Bluemix username (email).</li>
                  <li><strong>BLUEMIX_PASSWORD - </strong>Your Bluemix password.</li>
                  <li><strong>BLUEMIX_ORG - </strong>Your Bluemix organization name.</li>
                  <li><strong>BLUEMIX_SPACE - </strong>Your Bluemix space (as explained previously).</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><strong>ANALYTICS_IMAGE_TAG - </strong>A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><strong>ANALYTICS_IMAGE_TAG - </strong>Same as in <em>prepareserver.sh</em>.</li>
                  <li><strong>ANALYTICS_CONTAINER_NAME - </strong>A name for your Bluemix Container.</li>
                  <li><strong>ANALYTICS_IP - </strong>An IP address that the Bluemix Container should be bound to.<br/>
                  To assign an IP address, run: <code>cf ic ip request</code>.<br/>
                  IP addresses can be reused in multiple containers in a space.<br/>
                  If you've already assigned one, you can run: <code>cf ic ip list</code>.</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><strong>ANALYTICS_IMAGE_TAG - </strong>Same as in <em>prepareserver.sh</em>.</li>
                  <li><strong>ANALYTICS_CONTAINER_GROUP_NAME - </strong>A name for your Bluemix Container group.</li>
                  <li><strong>ANALYTICS_CONTAINER_GROUP_HOST - </strong>Your host name.</li>
                  <li><strong>ANALYTICS_CONTAINER_GROUP_DOMAIN - </strong>Your domain name. The default is: <code>mybluemix.net</code>.</li>
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

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
              <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to run without in interactive mode:</p>
              <ol>
                  <li><strong>initenv.sh – Logging in to Bluemix </strong><br />
                      Run the <strong>initenv.sh</strong> script to create an environment for building and running IBM MobileFirst Foundation Operational Analytics on the IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  
                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>[-u|--user] BLUEMIX_USER</td>
                                            <td>Bluemix user ID or email address</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                            <td>Bluemix password</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] BLUEMIX_ORG	</td>
                                            <td>Bluemix organization name</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] BLUEMIX_SPACE	</td>
                                            <td>Bluemix space name</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-a|--api] BLUEMIX_API_URL	</td>
                                            <td>Bluemix API endpoint. (Defaults to https://api.ng.bluemix.net)</td>
                                        </tr>
                                    </table>
                                    
                                    <p>For example:</p>
                    {% highlight bash %}
                    initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
                    {% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                  
                  </li>
                  <li><strong>prepareanalytics.sh - Prepare a MobileFirst Foundation Operational Analytics image</strong><br />
                      Run the <strong>prepareanalytics.sh</strong> script to build a MobileFirst Foundation Operational Analytics image and push it to your Bluemix repository:

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                  To view all available images in your Bluemix repository run: <code>cf ic images</code><br/>
                  The list contains the image name, date of creation, and ID.
                  
                  <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                          <td>Name to be used for the customized analytics image. Format: Bluemix registry URL/private namespace/image name</td>
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
                  <li><strong>startanalytics.sh - Running the image on an IBM Container</strong><br />
                  The <strong>startanalytics.sh</strong> script is used to run the MobileFirst Foundation Operational Analytics image on an IBM Container. It also binds your image to the public IP that you configured in the <strong>ANALYTICS_IP</strong> property.</li>

                  Run:
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>Name of the analytics container image that has been loaded into the IBM Containers registry. Format: BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
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
                                            <td>Provide MobileFirst Analytics properties as comma-separated key:value pairs. Note: If you specify properties using this script, ensure that these same properties have not been set in the configuration files in the usr/config folder.</td>
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

                  </li>
                  <li><strong>startanalyticsgroup.sh - Running the image on an IBM Container group</strong><br />
                  The <strong>startanalyticsgroup.sh</strong> script is used to run the MobileFirst Foundation Operational Analytics image on an IBM Container group. It also binds your image to the host name that you configured in the <strong>ANALYTICS_CONTAINER_GROUP_HOST</strong> property.</p>

                  Run:
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}
                  
                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>Name of the analytics container image that has been loaded into the IBM Containers registry. Format: BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
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
                                            <td>Specify MobileFirst properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
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

### MobileFirst Foundation Server
<div class="panel-group accordion" id="scripts2" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">Using the configuration files</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            The <strong>args</strong> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files:<br/>
            
              <h4>initenv.properties</h4>
              <ul>
                  <li><strong>BLUEMIX_USER - </strong>Your Bluemix username (email).</li>
                  <li><strong>BLUEMIX_PASSWORD - </strong>Your Bluemix password.</li>
                  <li><strong>BLUEMIX_ORG - </strong>Your Bluemix organization name.</li>
                  <li><strong>BLUEMIX_SPACE - </strong>Your Bluemix space (as explained previously).</li>
              </ul>
              <h4>prepareserverdbs.properties</h4>
              The Mobile Foundation service requires an external <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>dashDB Enterprise Transactional database</i> instance</a> (<i>Enterprise Transactional 2.8.500</i> or <i>Enterprise Transactional 12.128.1400</i>).<br/>
              <b>Note:</b> The deployment of the dashDB Enterprise Transactional plans may not be immediate. You might be contacted by the Sales team before the deployment of the service.<br/><br/>
              After you have set up your dashDB instance, provide the required arguments:
              <ul>
                  <li><strong>ADMIN_DB_SRV_NAME - </strong>Your dashDB service instance name for storing admin data.</li>
                  <li><strong>ADMIN_SCHEMA_NAME - </strong>Your schema name for admin data. The default is MFPDATA.</li>
                  <li><strong>RUNTIME_DB_SRV_NAME - </strong>Your dashDB service instance name for storing runtime data. The default is the admin service name.</li>
                  <li><strong>RUNTIME_SCHEMA_NAME - </strong>Your schema name for runtime data. The default is MFPDATA.</li>
                  <b>Note:</b> If your dashDB service instance is being shared by many users, make sure that you provide unique schema names.
              </ul><br/>
              <h4>prepareserver.properties</h4>
              <ul>
                  <li><strong>SERVER_IMAGE_TAG - </strong>A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.</li>
              </ul>
              <h4>startserver.properties</h4>
              <ul>
                  <li><strong>SERVER_IMAGE_TAG - </strong>Same as in <em>prepareserver.sh</em>.</li>
                  <li><strong>SERVER_CONTAINER_NAME - </strong>A name for your Bluemix Container.</li>
                  <li><strong>SERVER_IP - </strong>An IP address that the Bluemix Container should be bound to.<br/>
                  To assign an IP address, run: <code>cf ic ip request</code>.<br/>
                  IP addresses can be reused in multiple containers in a space.<br/>
                  If you've already assigned one, you can run: <code>cf ic ip list</code>.</li>
                  <li><strong>MFPF_PROPERTIES - </strong>MobileFirst server JNDI properties separated by comma (<strong>without spaces</strong>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
              </ul>
              <h4>startservergroup.properties</h4>
              <ul>
                  <li><strong>SERVER_IMAGE_TAG - </strong>Same as in <em>prepareserver.sh</em>.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_NAME - </strong>A name for your Bluemix Container group.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_HOST - </strong>Your host name.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_DOMAIN - </strong>Your domain name. The default is: <code>mybluemix.net</code>.</li>
                  <li><strong>MFPF_PROPERTIES - </strong>MobileFirst Server JNDI properties, separated by commas (<strong>without spaces</strong>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
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
              <p>The following instructions demonstrate how to run the scripts by using the configuration files. A list of command-line arguments is also available should you choose to run without in interactive mode:</p>
              <ol>
                  <li><strong>initenv.sh – Logging in to Bluemix </strong><br />
                      Run the <strong>initenv.sh</strong> script to create an environment for building and running IBM MobileFirst Foundation on IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>[-u|--user] BLUEMIX_USER</td>
                                            <td>Bluemix user ID or email address</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                            <td>Bluemix password</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] BLUEMIX_ORG	</td>
                                            <td>Bluemix organization name</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] BLUEMIX_SPACE	</td>
                                            <td>Bluemix space name</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-a|--api] BLUEMIX_API_URL	</td>
                                            <td>Bluemix API endpoint. (Defaults to https://api.ng.bluemix.net)</td>
                                        </tr>
                                    </table>
                                    
                                    <p>For example:</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}
                    
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>Close section</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                  </li>
                  <li><strong>prepareserverdbs.sh - Prepare the MobileFirst Server database</strong><br />
                  The <strong>prepareserverdbs.sh</strong> script is used to configure your MobileFirst server with the dashDB database service. The service instance of the dashDB service should be available in the Organization and Space that you logged in to in step 1. Run the following:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                            <td>Bluemix  dashDB™ service (with Bluemix service plan of Enterprise Transactional)</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>Database schema name for administration service. Defaults to MFPDATA</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>Bluemix database service instance name for storing runtime data. Defaults to the same service as given for admin data.</td>
                                        </tr>
                                        <tr>
                                            <td>Optional. [-p |--push ] ENABLE_PUSH	</td>
                                            <td>Enable configuring database for push service. Accepted values are Y (default) or N.</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>Bluemix database service instance name for storing push data. Defaults to the same service as given for runtime data.</td>
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
                  <li><strong>initenv.sh(Optional) – Logging in to Bluemix </strong><br />
                      This step is required only if you need to create your containers in a different Organization and Space than where the dashDB service instance is available. If yes, then update the initenv.properties with the new Organization and Space where the containers have to be created (and started), and rerun the <strong>initenv.sh</strong> script:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><strong>prepareserver.sh - Prepare a Mobilefirst Platform Foundation Server image</strong><br />
                  Run the <strong>prepareserver.sh</strong> script in order to build a MobileFirst Platform Foundation Server image and push it to your Bluemix repository. To view all available images in your Bluemix repository, run: <code>cf ic images</code><br/>
                  The list contains the image name, date of creation, and ID.<br/>
                  
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                  <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                          <td>Name to be used for the customized MobileFirst Server image. Format: registryUrl/namespace/imagename
</td>
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
                  <li><strong>startserver.sh - Running the image on an IBM Container</strong><br />
                  The <strong>startserver.sh</strong> script is used to run the Mobilefirst Server image on an IBM Container. It also binds your image to the public IP that you configured in the <strong>SERVER_IP</strong> property. Run:</li> 
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                        <td>Name of the MobileFirst Server image.</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>IP address that the MobileFirst Server container should be bound to. (You can provide an available public IP or request one using the <code>cf ic ip request</code> command.)</td>
                                    </tr>
                                    <tr>
                                        <td>Optional. [-si|--services] SERVICE_INSTANCES	</td>
                                        <td>Comma-separated Bluemix service instances that you want to bind to the container.</td>
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
                                        <td>Specify MobileFirst properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>.  <b>Note:</b> If you specify properties using this script, ensure that these same properties have not been set in the configuration files in the usr/config folder.</td>
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
                    
                  
                  
                  <li><strong>startservergroup.sh - Running the image on an IBM Container group</strong><br />
                  The <strong>startservergroup.sh</strong> script is used to run the Mobilefirst Server image on an IBM Container group. It also binds your image to the host name that you configured in the <strong>SERVER_CONTAINER_GROUP_HOST</strong> property.</li>
                  Run:
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
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
                                                <td>The name of the MobileFirst Server container image in the Bluemix registry.</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>The name of the MobileFirst Server container group.</td>
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
                                                <td>Comma-separated Bluemix service instance names that you want to bind to the container.</td>
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
                                                <td>Specify MobileFirst properties as comma-separated key:value pairs. Example: <code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
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
                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>

> **Note:** Containers must be restarted after any configuration changes have been made (`cf ic restart containerId`). For container groups, you must restart each container instance within the group. For example, if a root certificate changes, each container instance must be restarted after the new certificate has been added.

Launch the MobileFirst Console by loading the following URL: http://MF\_CONTAINER\_HOST/mfpconsole (it may take a few moments).  
Add the remote server by following the instructions in the [Using MobileFirst CLI to Manage MobileFirst Artifacts](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) tutorial.  

With MobileFirst Server running on IBM Bluemix, you can now start your application development. Review the MobileFirst Foundation [tutorials](../../all-tutorials).

#### Port number limitation
There is currently an IBM Containers limitation with the port numbers that are available for public domain. Therefore, the default port numbers given for the MobileFirst Analytics container and the MobileFirst Server container (9080 for HTTP and 9443 for HTTPS) cannot be altered. Containers in a container group must use HTTP port 9080. Container groups do not support the use of multiple port numbers or HTTPS requests.

## Applying MobileFirst Server Fixes
Interim fixes for the MobileFirst Server on IBM Containers can be obtained from [IBM Fix Central](http://www.ibm.com/support/fixcentral).  
Before you apply an interim fix, back up your existing configuration files. The configuration files are located in the **package_root/mfpf-analytics/usr** and **package_root/mfpf-server/usr** folders.

1. Download the interim fix archive and extract the contents to your existing installation folder, overwriting the existing files.
2. Restore your backed-up configuration files into the **/mfpf-analytics/usr** and **/mfpf-server/usr** folders, overwriting the newly installed configuration files.

You can now build and deploy new production-level containers.

##  Removing a Container from Bluemix
When you remove a container from Bluemix, you must also remove the image name from the registry.  
Run the following commands to remove a container from Bluemix:

1. `cf ic ps` (Lists the containers currently running)
2. `cf ic stop container_id` (Stops the container)
3. `cf ic rm container_id` (Removes the container)

Run the following cf ic commands to remove an image name from the Bluemix registry:

1. `cf ic images` (Lists the images in the registry)
2. `cf ic rmi image_id` (Removes the image from the registry)

## Removing the database service configuration from Bluemix	
If you ran the **prepareserverdbs.sh** script during the configuration of the MobileFirst Server image, the configurations and database tables required for MobileFirst Server are created. This script also creates the database schema for the container.

To remove the database service configuration from Bluemix, perform the following procedure using Bluemix dashboard.

1. From the Bluemix dashboard, select the dashDB service you have used. Choose the dashDB service name that you had provided as parameter while running the **prepareserverdbs.sh** script.
2. Launch the dashDB console to work with the schemas and database objects of the selected dashDB service instance.
3. Select the schemas related to IBM MobileFirst Server configuration. The schema names are ones that you have provided as parameters while running the **prepareserverdbs.sh** script.
4. Delete each of the schema after carefully inspecting the schema names and the objects under them. The database configurations are removed from Bluemix.
