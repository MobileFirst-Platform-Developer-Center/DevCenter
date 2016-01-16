---
layout: tutorial
title: Run IBM MobileFirst Platform Foundation on IBM Containers
breadcrumb_title: Prepare and run on IBM Containers
relevantTo: [ios,android,windows,cordova]
---
## Overview
This tutorial demonstrates how to take a locally developed IBM MobileFirst Platform Foundation project and run it on Bluemix. To achieve this result, you go through the following steps: set up your host computer with the required tools (MobileFirst Developer CLI, Docker, and IBM Containers Extension (ICE) CLI), set up your Bluemix environment, build a MobileFirst Platform Foundation Server image, deploy your project runtime and push it to the Bluemix repository. Finally, you run the image on an IBM Container and update it with the MobileFirst project application and adapter.

**Note:** Windows OS is currently not supported.<  
**Note:** The MobileFirst Server Configuration Tools cannot be used for deployments to IBM Containers.

**Prerequisite:** Make sure to read the [Introduction to IBM MobileFirst Platform Foundation on IBM Containers]("../") tutorial.

### Topics

* [Register an account at Bluemix](#register-an-account-at-bluemix)
* [Set up your host machine](#set-up-your-host-machine)
* [Run IBM MobileFirst Platform Foundation on IBM Containers](#run-ibm-mobilefirst-platform-foundation-on-ibm-containers)

## Register an account at Bluemix
If you do not yet have an account, visit the [Bluemix website]("http://www.bluemix.net" target="_blank") and click **Get Started Free** or **Sign Up**. You'll need to fill up a registration form before you can move on to the next step.

#### The Bluemix Dashboard
After signing in to Bluemix, you are presented with the Bluemix Dashboard, which provides an overview of the active Bluemix **space**. By default, this work area  receives the name "dev". You can create multiple work areas/spaces if needed.

## Set up your host machine
To manage containers and images, you need to install the following tools: IBM MobileFirst Platform Foundation CLI, Docker, and IBM Containers Extension (ICE) CLI.

### MobileFirst Platform Foundation CLI
Follow the [Using MobileFirst Developer CLI to create, build, and manage artifacts](../../client-side-development/using-mobilefirst-developer-cli-to-create-manage-artifacts/) tutorial to install the MobileFirst Command Line Interface.

### Docker
Go to the [Docker Documentation](https://docs.docker.com/) -> left side menu, and select **Install > Docker Engine**, select your OS type and follow the instructions to install the Docker Toolbox.

**Note:** IBM does not support Docker's Kitematic software.

In OS X there are two options to run Docker commands:

* From the OS X Terminal
* From the Docker Quickstart Terminal

If you choose to work from the Docker Quickstart Terminal no further setup is needed. You must work only from it.  
If you choose to work from the OS X Terminal, do the following:

* Run the command: `docker-machine env default`
* Set the result as environment variables, for example:

```bash
$ docker-machine env default
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.101:2376"
export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
```

> For further information consult the Docker documentation.

### IBM Containers Extension (ICE)
**Prerequisites:** Before you install the ICE CLI tool, you must first install Python, Python Setuptools, Python Pip, and Cloud Foundry CLI.

#### Installing Python, Python Pip, and Python Setuptools

* Install Python, Python Pip, and Python Setuptools:   
 * [Linux](http://docs.python-guide.org/en/latest/starting/install/linux/
 * [Mac OS X](http://docs.python-guide.org/en/latest/starting/install/osx/)
 * [Windows](http://docs.python-guide.org/en/latest/starting/install/win/)
* Install the Cloud Foundry CLI [from the Cloud Foundry CLI GitHub repository](https://github.com/cloudfoundry/cli/releases).

#### Installing ICE

* Install the IBM Containers Extension by running:
```bash
$ pip install https://static-ice.ng.bluemix.net/icecli-3.0.zip
```

Note: You may need to use `sudo`
    
## Run IBM MobileFirst Platform Foundation on IBM Containers
To run IBM MobileFirst Platform Foundation on IBM Containers, you must first create an image that will later be pushed to Bluemix.

If you have not downloaded the IBM MobileFirst Platform Foundation V7.1 .zip file yet, click the button below, follow the instructions and download it (search for IBM MobileFirst Platform Server on IBM Containers).

<a class="custombtn btn-lg btn-default" style="width:700px; font-size: 100%" href="http://g01zciwas018.ahe.pok.ibm.com/support/dcf/preview.wss?host=g01zcidbs003.ahe.pok.ibm.com&db=support/swg/swgdnld.nsf&unid=C6A4E3413AB5317785257E68003CD0AE&taxOC=SSCQTTD&MD=2015/10/21%2018:10:51&sid=" target="blank">Follow the instructions and download the IBM MobileFirst Platform Foundation v7.1 customization .zip</a>

### Structure of the ibm-mfpf-container-7.1.0.0-eval.zip archive

<img alt="Image of the customization .zip file" src="{{ site.baseurl }}/assets/backup/cutomizationZip.png" style="float:right"/>

The extracted ZIP file contains the files for building an image (`dependencies` and `mfpf-libs`), the files for building and deploying an IBM MobileFirst Platform Foundation Operational Analytics Container (`mfpf-analytics`), and files for configuring an IBM MobileFirst Platform Server Container `(mfpf-server`). This tutorial does not cover the analytics part.

#### The mfpf-server folder

* `Dockerfile`: text document that contains all the commands in order to build an image.
* `usr` folder:
 * `config` folder: ￼Contains server key store configuration, User registry configuration, MobileFirst Platform Foundation Server properties (includes runtime configuration – analytics, attribute store etc).
 * `env` folder: Contains server environment configuration (ports, application root names etc).
 * `projects` folder: The location of your MobileFirst Platform project runtime (`.war` file).
 * `security` folder: The key store, trust store and the LTPA keys files (ltpa.keys) should be placed here.
 * `ssh` folder: Contains the id_rsa.pub file - the ssh public key file to enable ssh on the container.
 * `wxs` folder: Contains the data cache / extreme scale client library when Data Cache is used as attribute store for the server.

> This tutorial refers only to the `projects` folder.

* `server` folder: Contains elements that are required for the IBM MobileFirst Platform Foundation Operational Server deployment.
* `scripts` folder: This folder contains the `args` folder, which contains a set of configuration files. It also contains scripts to run for logging in to Bluemix, building a Mobilefirst Platform Foundation Server image, deploying your project runtime, and for pushing and running the image on Bluemix.

You can choose to run the scripts interactively or by pre-configuring the configuration files as will be further explained.

### Step 1: Create an IBM MobileFirst Platform Foundation project
Create a new MobileFirst project or use an existing one. You can find tutorials on how to create a new project, and their associated sample projects, in the [Getting Started with Foundation]("../../" target="_blank") page.

### Step 2: Prerequisites

* **ice login**: To run ICE commands, you must first log in into the IBM Container Cloud Service. This step is mandatory because you will be running ICE commands during the following step.

Run:
```bash
ice login
```

When prompted, enter the following information:    

 - Email
 - Password
 - Organization
        
    
* Make sure that the `namespace` for container registry is set. The `namespace` is a unique name to identify your private repository on the Bluemix registry. The namespace is assigned once for an organization and cannot be changed.

 Choose a namespace according to following rules:
 
 - It can contain only lowercase letters, numbers, or underscores (_).
 - It can be 4 - 30 characters. If you plan to manage containers from the command line, you might prefer to have a short namespace that can be typed quickly.
 - It must be unique in the Bluemix registry.

 To set a namespace, run the command:
 
 ```bash
 $ ice namespace set <new_name>
 ```

 To get the namespace that you have set, run the command:

 ```bash
 $ ice namespace get
 ```

> To learn more about ICE commands, use the `ice help` command.

### Step 3: Using the configuration files
**Note:** If you choose to run the scripts interactively, you can skip the configuration but it is strongly suggested to at least read and understand the arguments you will need to provide.  

The `args` folder contains a set of configuration files which contain the arguments that are required to run the scripts. Fill in the arguments' values in the following files:

<a role="button" data-toggle="collapse" href="#collapseInitEnv" aria-expanded="false" aria-controls="collapseInitEnv">
  initenv.properties
</a>

<div class="collapse" id="collapseInitEnv">
    <div class="well">  
        * <strong>BLUEMIX_API_URL</strong> - Bluemix API endpoint. The default is <em>https://api.ng.bluemix.net</em>.
        * <strong>BLUEMIX_REGISTRY</strong> - The IBM Containers registry domain. The default is <em>registry.ng.bluemix.net</em>.
        * <strong>BLUEMIX_CCS_HOST</strong> - The IBM Container Cloud Service Host. The default is <em>https://containers-api.ng.bluemix.net/v3/containers</em>.
        * <strong>BLUEMIX_USER</strong> - Your Bluemix username (email).
        * <strong>BLUEMIX_PASSWORD</strong> - Your Bluemix password.
        * <strong>BLUEMIX_ORG</strong> - Your Bluemix organization name.
        * <strong>BLUEMIX_SPACE</strong> - Your Bluemix space (as explained previously).
    </div>
</div>

<a role="button" data-toggle="collapse" href="#collapsePrepareServerDBs" aria-expanded="false" aria-controls="collapsePrepareServerDBs">
  prepareserverdbs.properties
</a>

<div class="collapse" id="collapsePrepareServerDBs">
    <div class="well">
        * <strong>DB_TYPE</strong> - Bluemix DB service type (sqldb, cloudantNoSQLDB).
        * <strong>DB_SRV_NAME</strong> - Your Bluemix DB service instance name.
        * <strong>DB_SRV_PLAN</strong> - Bluemix database service plan.<br />
        For SQL DB, the accepted values are sqldb_free or sqldb_premium.<br />
        For Cloudant DB, the accepted value is <em>Shared</em>.
        
        * <strong>APP_NAME</strong> - Your Bluemix DB application name.<br />
        <strong>Note:</strong> Choose a unique name.
        * <strong>RUNTIME_NAME</strong> - The MobileFirst project runtime name. Required for configuring runtime databases only, as explained in the next step.
        * <strong>SCHEMA_NAME</strong> - Your database schema name. The default names are:
                * For the admin database: WLDAMIN
                * For the MobileFirst project runtime database: the value of RUNTIME_NAME
    </div>
</div>
<br clear="all"/>
<a role="button" data-toggle="collapse" href="#collapsePrepareServer" aria-expanded="false" aria-controls="collapsePrepareServer">
  prepareserver.properties
</a>

<div class="collapse" id="collapsePrepareServer">
    <div class="well">
        
            * <strong>SERVER_IMAGE_TAG</strong> - A tag for the image. Should be of the form: <em>registry-url/namespace/your-tag</em>.
            * <strong>PROJECT_LOC</strong> - A path to the root directory of your MobileFirst project. Multiple project locations can be delimited by a comma.
        
    </div>
</div>
<br clear="all"/>
<a role="button" data-toggle="collapse" href="#collapseStartServer" aria-expanded="false" aria-controls="collapseStartServer">
  startserver.properties
</a>

<div class="collapse" id="collapseStartServer">
    <div class="well">
        <ul>
            <li><strong>SERVER_IMAGE_TAG</strong> - Same as in <em>prepareserver.sh</em>.</li>
            <li><strong>SERVER_CONTAINER_NAME</strong> - A name for your Bluemix Container.</li>
            <li><strong>SERVER_IP</strong> - An IP address that the Bluemix Container should be bound to. To assign an IP address, run:</li>
{% highlight bash %}
$ ice ip request
{% endhighlight %}

            IP addresses can be reused in multiple containers in a space. If you've already assigned one, you can run:

{% highlight bash %}
$ ice ip list
{% endhighlight %}
        </ul>
    </div>
</div>

### Step 4: Running the scripts
As explained above you can choose to run the scripts interactively or by using the configuration files:

* Using the configuration files - run the scripts and pass the respective configuration file as an argument
* Interactively - run the scripts without any arguments

The following demonstrate the first option.

1. **installcontainercli.sh - Adding Container Extension to the MobileFirst Developer CLI**

In order to use the Container Extension you must first add it to the MobileFirst Developer CLI.  
Run:

{% highlight bash %}
$ ./installcontainercli.sh
{% endhighlight %}

Note: You may need to use `sudo`
    
2. **initenv.sh - Logging in to Bluemix**
Run the `initenv.sh` script in order to create an environment for building and running IBM MobileFirst Platform Foundation on the IBM Containers:

{% highlight bash %}
$ ./initenv.sh args/initenv.properties
{% endhighlight %}
    
3. **prepareserverdbs.sh - Prepare the MobileFirst Server database**
The `prepareserverdbs.sh` script is used to configure your MobileFirst project database. You will need to run it separately, once for the admin database and once for every MobileFirst project runtime database.
        
* For the admin database make sure to comment out the `RUNTIME_NAME` argument and run:

    {% highlight bash %}
    $ ./prepareserverdbs.sh args/prepareserverdbs.properties
    {% endhighlight %}
            
* For each MobileFirst project runtime database - first uncomment the project `RUNTIME_NAME` argument, change it value to match the specific project war file and run:
{% highlight bash %}
$ ./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
            
**Note:** If you are getting an error: "Application not configured correctly" - try to run the script (with the same properties) again.
    
4. **prepareserver.sh - Prepare a Mobilefirst Platform Foundation Server image**
    Uncomment the `PROJECT_LOC` argument and run the `prepareserver.sh` script in order to build a MobileFirst Platform Foundation Server image, deploy your project runtime and push it to to your Bluemix repository:

{% highlight bash %}
$ ./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

    To view all available images in your Bluemix repository run:

{% highlight bash %}
$ ice images
{% endhighlight %}

    The list contains the image name, date of creation and ID.
    
5. **startserver.sh - Running the image on an IBM Container**
The `startserver.sh` script is used to run the Mobilefirst Server image on an IBM Container. It also Binds your image to the public IP you configured in the `SERVER_IP` property.
        
* Run:

{% highlight bash %}
$ ./startserver.sh args/startserver.properties
{% endhighlight %}
            
*  Launch the MobileFirst Console by loading the following URL: http://<server_ip>:9080/mfpconsole (it may take a few moments).
* Upload the `.wlapp` and `.adapter` files.
* Update the application's `worklight.plist` (for iOS) and/or `wlclient.properties` (for Android, Windows Universal, Windows Phone) with the protocol, host and port values of the IBM Container.
* You can now run your application to verify that it successfully connects to the MobileFirst Server, running on IBM Containers.
        
[missing alt text]({{ site.baseurl }}/assets/backup/Screen-Shot-2015-06-22-at-15.47.14-1024x493.png)
    