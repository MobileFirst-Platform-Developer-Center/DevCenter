---
layout: tutorial
title: Setting Up the MobileFirst Server on IBM Containers using Scripts
relevantTo: [ios,android,windows,javascript]
weight: 2
---

## Overview
Follow the instructions below to configure a MobileFirst Server instance as well as MobileFirst Analytics instance on IBM Bluemix. To achieve this you will go through the following steps: 

* Setup your host computer with the required tools (Cloud Foundry CLI, Docker, and IBM Containers Extension (cf ic) Plug-in)
* Setup your Bluemix environment
* Build a MobileFirst Server image and push it to the Bluemix repository.

Finally, you will run the image on IBM Containers as a single Container or a Container group, and register your applications as well as deploy your adapters.

> **Notes:**  
>
> * Windows OS is currently not supported.  
> * The MobileFirst Server Configuration tools cannot be used for deployments to IBM Containers.

#### Jump to:

* [Register an account at Bluemix](#register-an-account-at-bluemix)
* [Set up your host machine](#set-up-your-host-machine)
* [Download the ibm-mfpf-container-8.0.0.0 zip](#download-the-ibm-mfpf-container-8-0-0-0-zip)
* [Prerequisites](#prerequisites)
* [Setting Up the MobileFirst and Analytics Servers on IBM Containers](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)

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
2. Install the [IBM Containers Plugin (cf ic)](https://www.ng.bluemix.net/docs/containers/container_cli_ov.html#container_cli_cfic).

## Download the ibm-mfpf-container-8.0.0.0 archive
To set up IBM MobileFirst Foundation on IBM Containers, you must first create an image that will later be pushed to Bluemix.  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">Follow the instructions in this page</a> to download the IBM MobileFirst Server for IBM Container v8.0 .zip file (search for: CNBL0EN).

The extracted ZIP file contains the files for building an image (**dependencies** and **mfpf-libs**), the files for building and deploying an IBM MobileFirst Foundation Operational Analytics Container (**mfpf-analytics**) and files for configuring an IBM MobileFirst Foundation Server Container (**mfpf-server**).

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>Click for .zip file folders and sub-folders decriptions</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
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
                            <li><b>mfpfproperties.xml</b> - configuration properties for the MobileFirst Server. See the supported properties listed in these documentation topics:
                                <ul>
                                    <li><a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/install_config/r_wladmin_jndi_property_list.html?view=kc">List of JNDI properties for MobileFirst Server administration service</a></li>
                                    <li><a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_JNDI_entries_for_production.html?view=kc">List of JNDI properties for MobileFirst runtime</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - user registry configuration. The basicRegistry (a basic XML-based user-registry configuration is provided as the default. User names and passwords can be configured for basicRegistry or you can configure ldapRegistry.</li>
                        </ul>
                    </li>
                    <li><b>env</b> folder: Contains the environment properties used for server initialization (server.env) and custom JVM options (jvm.options).</li>
                    <li><b>jre-security</b> folder: You can update the JRE security-related files (truststore, policy JAR files, and so on) by placing them in this folder. The files in this folder get copied to the JAVA_HOME/jre/lib/security/ folder in the container.</li>
                    <li><b>security</b> folder: used to store the key store, trust store, and the LTPA keys files (ltpa.keys).</li>
                    <li><b>ssh</b> folder: used to store the SSH public key file (id_rsa.pub), which is used to enable SSH access to the container.</li>
                    <li><b>wxs</b> folder (only for MobileFirst Server): Contains the data cache / extreme-scale client library when Data Cache is used as an attribute store for the server.</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>Close section</b></a>.
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
            <strong>Note:</strong> We only include the required arguments. To learn about the additional arguments, see the documentation inside the properties files.
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
              The following instructions demonstrate how to run the scripts by using the configuration files:
              <ol>
                  <li><strong>initenv.sh – Logging in to Bluemix </strong><br />
                      Run the <strong>initenv.sh</strong> script to create an environment for building and running IBM MobileFirst Foundation Operational Analytics on the IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><strong>prepareanalytics.sh - Prepare a MobileFirst Foundation Operational Analytics image</strong><br />
                      Run the <strong>prepareanalytics.sh</strong> script to build a MobileFirst Foundation Operational Analytics image and push it to your Bluemix repository:

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                  To view all available images in your Bluemix repository run: <code>cf ic images</code><br/>
                  The list contains the image name, date of creation, and ID.
                  </li>
                  <li><strong>startanalytics.sh - Running the image on an IBM Container</strong><br />
                  The <strong>startanalytics.sh</strong> script is used to run the MobileFirst Foundation Operational Analytics image on an IBM Container. It also binds your image to the public IP that you configured in the <strong>ANALYTICS_IP</strong> property.</p>

                  Run:
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}
                  </li>
                  <li><strong>startanalyticsgroup.sh - Running the image on an IBM Container group</strong><br />
                  The <strong>startanalyticsgroup.sh</strong> script is used to run the MobileFirst Foundation Operational Analytics image on an IBM Container group. It also binds your image to the host name that you configured in the <strong>ANALYTICS_CONTAINER_GROUP_HOST</strong> property.</p>

                  Run:
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}
                  </li>
              </ol>
              Launch the Analytics Console by loading the following URL: http://&#60ANALYTICS_CONTAINER_HOST&#62/analytics/console (it may take a few moments).  
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
            The <strong>args</strong> folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the argument values in the following files:
              <h4>initenv.properties</h4>
              <ul>
                  <li><strong>BLUEMIX_USER - </strong>Your Bluemix username (email).</li>
                  <li><strong>BLUEMIX_PASSWORD - </strong>Your Bluemix password.</li>
                  <li><strong>BLUEMIX_ORG - </strong>Your Bluemix organization name.</li>
                  <li><strong>BLUEMIX_SPACE - </strong>Your Bluemix space (as explained previously).</li>
              </ul>
              <h4>prepareserverdbs.properties</h4>
              The Mobile Foundation requires an external <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB *Transactional database* instance </a>. After you have set up your dashDB instance, provide the required arguments:
              <ul>
                  <li><strong>ADMIN_DB_SRV_NAME - </strong>Your dashDB service instance name for storing admin data.</li>
                  <li><strong>ADMIN_SCHEMA_NAME - </strong>Your schema name for admin data. The default is MFPDATA.</li>
                  <li><strong>RUNTIME_DB_SRV_NAME - </strong>Your dashDB service instance name for storing runtime data. The default is the admin service name.</li>
                  <li><strong>RUNTIME_SCHEMA_NAME - </strong>Your schema name for runtime data. The default is MFPDATA.</li>
              </ul>
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
                  <li><strong>MFPF_PROPERTIES - </strong>MobileFirst server JNDI properties separated by comma (<strong>without spaces</strong>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://&#60ANALYTICS_CONTAINER_IP&#62:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://&#60ANALYTICS_CONTAINER_IP&#62:9080/analytics/console,mfp/mfp.analytics.username:&#60ANALYTICS_USERNAME&#62,mfp/mfp.analytics.password:&#60ANALYTICS_PASSWORD&#62</code></li>
              </ul>
              <h4>startservergroup.properties</h4>
              <ul>
                  <li><strong>SERVER_IMAGE_TAG - </strong>Same as in <em>prepareserver.sh</em>.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_NAME - </strong>A name for your Bluemix Container group.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_HOST - </strong>Your host name.</li>
                  <li><strong>SERVER_CONTAINER_GROUP_DOMAIN - </strong>Your domain name. The default is: <code>mybluemix.net</code>.</li>
                  <li><strong>MFPF_PROPERTIES - </strong>MobileFirst Server JNDI properties, separated by commas (<strong>without spaces</strong>). Here is where you define the analytics-related properties: <code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://&#60ANALYTICS_CONTAINER_GROUP_HOSTNAME&#62:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://&#60ANALYTICS_CONTAINER_GROUP_HOSTNAME&#62:80/analytics/console,mfp/mfp.analytics.username:&#60ANALYTICS_USERNAME&#62,mfp/mfp.analytics.password:&#60ANALYTICS_PASSWORD&#62</code></li>
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
              The following instructions demonstrate how to run the scripts by using the configuration files:
              <ol>
                  <li><strong>initenv.sh – Logging in to Bluemix </strong><br />
                      Run the <strong>initenv.sh</strong> script to create an environment for building and running IBM MobileFirst Platform Foundation on the IBM Containers:
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                  </li>
                  <li><strong>prepareserverdbs.sh - Prepare the MobileFirst Server database</strong><br />
                  The <strong>prepareserverdbs.sh</strong> script is used to configure Run:
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                  </li>
                  <li><strong>prepareserver.sh - Prepare a Mobilefirst Platform Foundation Server image</strong><br />
                  Run the <strong>prepareserver.sh</strong> script in order to build a MobileFirst Platform Foundation Server image and push it to your Bluemix repository:
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                  To view all available images in your Bluemix repository, run: <code>cf ic images</code><br/>
                  The list contains the image name, date of creation, and ID.
                  </li>
                  <li><strong>startserver.sh - Running the image on an IBM Container</strong><br />
                  The <strong>startserver.sh</strong> script is used to run the Mobilefirst Server image on an IBM Container. It also binds your image to the public IP that you configured in the <strong>SERVER_IP</strong> property.</p>
                  Run:
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}
                  </li>
                  </li>
                  <li><strong>startservergroup.sh - Running the image on an IBM Container group</strong><br />
                  The <strong>startservergroup.sh</strong> script is used to run the Mobilefirst Server image on an IBM Container group. It also binds your image to the host name that you configured in the <strong>SERVER_CONTAINER_GROUP_HOST</strong> property.</p>
                  Run:
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}
                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>

Launch the MobileFirst Console by loading the following URL: http://MF_CONTAINER_HOST/mfpconsole (it may take a few moments).  
Add the remote server by following the instructions in the [Using MobileFirst CLI to Manage MobileFirst Artifacts](../../using-the-mfpf-sdk/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) tutorial.  

With MobileFirst Server running on IBM Bluemix, you can now start your application development. Review the MobileFirst Foundation [tutorials](../../all-tutorials).
