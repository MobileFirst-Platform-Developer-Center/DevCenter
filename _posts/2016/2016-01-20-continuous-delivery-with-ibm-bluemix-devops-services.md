---
title: Continuous Delivery with IBM Bluemix DevOps Services
date: 2016-01-20
tags:
- MobileFirst_Platform
- IBM_Containers
- Bluemix
- DevOps
version:
- 7.1
author:
  name: Srinivasan Nanduri
---

IBM MobileFirst Platform Foundation (rel. 7.1 – hereafter referred to as MFPF), is now available on Bluemix. The main components of the platform – the server and the analytics can be run as containers on the IBM Bluemix Container Service. This blog discusses a step-by-step approach for building and deploying the server and analytics containers using the IBM Bluemix DevOps Services.

The steps involved are as follows:

* Creating a project from IBM Bluemix DevOps Services to manage, build, share and organize the MFPF container code. More info [here](https://hub.jazz.net/docs/startproject)
**Note:** In this blog, we store our code in a [Git repository hosted by IBM Bluemix](https://hub.jazz.net/docs/git/). A similar approach can be followed for other repository types.
* Customizing / configuring the MFPF container
* Creating a new deployment pipeline
* Deploying the container

## Before you begin

* Sign up for a [Bluemix account](https://hub.jazz.net/)
* Download the [IBM MobileFirst Platform Foundation Evaluation on Containers v7.1 zip](http://www14.software.ibm.com/cgi-bin/weblap/lap.pl?popup=Y&li_formnum=L-BVID-9XEQG7&accepted_url=http://public.dhe.ibm.com/ibmdl/export/pub/software/products/en/MobileFirstPlatform/mfpfcontainers/ibm-mfpf-container-7.1.0.0-eval.zip ) to your machine
* Install [git](http://git-scm.com/downloads) to configure, change, sync and test locally

## The MobileFirst Platform Foundation Server Container
This section discusses the steps involved in organizing, building, deploying and managing a MobileFirst Platform Foundation Server container.

**Note:** The MobileFirst Platform Foundation Server Container uses a Cloudant database. Hence, a [Cloudant](https://cloudant.com/) account is required. Alternatively, you could also use the [Cloudant service on Bluemix](https://www.ng.bluemix.net/docs/#services/Cloudant/index.html#Cloudant)

### Unpack the IBM MobileFirst Platform Foundation Containers Archive
* Unpack the IBM MobileFirst Platform Foundation Containers zip file that is downloaded above into a directory of your choice. Hereafter, we refer to this directory with name: *{ibm-mfpf-containers-7.1.0.0-eval}*


### Creating a DevOps Services project
* Login to IBM DevOps Services at [https://hub.jazz.net/](https://hub.jazz.net/)
* Select **Create Project**, and specify the project name as *mfpf-server*
* Select **Create a new repository**, and select the option **Create a Git repo on Bluemix**
* Check the **Private Project** and leave all the remaining options unchecked
* Select **Create**

### Set up local repository
To configure or add projects to the MFPF container, you need to check out the git repository created above. More info [here](https://hub.jazz.net/docs/git/#set_up_a_local_git_repository)

* Determine which directory to store your local repo in. If necessary, you can create a directory. Change (or) move to the directory
* Clone the git repository you just created using:

`git clone --no-checkout GIT_URL`

The GIT_URL will be of the form: https://hub.jazz.net/git//mfpf-server. The git repository will be cloned into a sub directory with name *mfpf-server* (hereafter, referred to as local repository)


### Creating, configuring and updating / syncing the project

* Copy the following folders from the folder *{ibm-mfpf-containers-7.1.0.0-eval}* to the local repository

    - dependencies
    - licenses
    - mfpf-libs

* Copy all the content within the following folder to the local repository

    - mfpf-server

* Optionally, you can remove the following from the local repository.

    - mfpf-libs\apache-ant-1.9.4
    - mfpf-libs\db2jcc4.jar
    - mfpf-libs\httpclient.jar
    - mfpf-libs\httpcore.jar
    - mfpf-libs\json4j.jar
    - mfpf-libs\mfpf-analytics.tgz
    - mfpf-libs\mfpf-container-deployer.jar
    - mfpf-libs\worklight-ant-deployer.jar
    - scripts

* Copy your MobileFirst projects (WAR files) under the **usr/projects** directory of your local repository

**Configuring the MobileFirst Server Databases**

* Configuring the MobileFirst Administration Database

Create a file named *wladmin.xml* with the following content (Fill the values with valid Cloudant database details) in the ***usr/config*** directory of your local repository

```xml
<?xml version="1.0" encoding="UTF-8"?>
<server description="new server">
<jndiEntry jndiName="${env.MFPF_ADMIN_ROOT}/mfp.db.cloudant.username" value=""/>
<jndiEntry jndiName="${env.MFPF_ADMIN_ROOT}/mfp.db.cloudant.password" value=""/>
<jndiEntry jndiName="${env.MFPF_ADMIN_ROOT}/mfp.db.cloudant.url" value=""/>
</server>
```

**Configuring the MobileFirst Runtime Databases**  
For each of the runtimes (WARs) added, create an XML file with the name, {runtime name}.xml with the following content (Fill the values with valid Cloudant database details) in the **usr/config** directory of your local repository.

**Note:** Update the *{runtime name}** in the xml content with the name of the project.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<server description="new server">
<jndiEntry jndiName="{runtime name}/mfp.db.cloudant.username" value=""/>
<jndiEntry jndiName="{runtime name}/mfp.db.cloudant.password" value=""/>
<jndiEntry jndiName="{runtime name}/mfp.db.cloudant.url" value=""/>
<application id="{runtime name}" location="{runtime name}.war" name="{runtime name}" type="war">
<classloader delegation="parentLast">
<privateLibrary id="worklightlib_{runtime name}">
<fileset dir="${shared.resource.dir}/lib" includes="worklight-jee-library.jar"/>
<fileset dir="${wlp.install.dir}/lib" includes="com.ibm.ws.crypto.passwordutil*.jar"/>
</privateLibrary>
</classloader>
</application>
</server>
```

**Customize the server container.**  
Refer [here](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/c_customize_server_container.html). Note that if you want to configure analytics instance to this server, the analytics server has to be configured here. Refer to the **The MobileFirst Platform Foundation Analytics Container** section on how to create &amp; deploy an analytics container.

* Update the remote DevOps Service project with the local repository using the following commands from within the local repository directory

- `git add *`
- `git commit –m "Initial check-in"`
- `git push origin master`

### Creating a deployment pipeline
The pipeline automates the continuous deployment of MobileFirst Platform Foundation Server container. Follow the steps below to create the deployment pipeline.

* Go to [IBM Bluemix DevOps Services](https://git.ng.bluemix.net)
* Under **Your Projects** click the project that you created above: **mfpf-server**
* Click **BUILD &amp; DEPLOY**
* Create a Build Stage

* Click on **ADD STAGE**
* Specify a name for the stage. For example, Build
* In the **INPUT** tab, leave all the fields set to default values. This will also ensure that the stage is run automatically whenever a change is pushed to the project

* Click on **JOBS**
* Click on **ADD JOB** and choose *Build* as the job type
* Set the following values to the respective fields:

* Builder Type – IBM Container Service
* Provide the Target, Organization and Space of your Bluemix account to which the container has to be deployed
* Provide the name of the image
* Click on **SAVE**

**Create a Deploy / Run stage**

* Click on **ADD STAGE**
* Specify a name for the stage. For example, Deploy
* In the **INPUT** tab, leave all the fields set to default values. This will also ensure that the stage is run automatically whenever a change is pushed to the project
* Click on **JOBS**
* Click on **ADD JOB** and choose *Deploy* as the job type
* Set the following values to the respective fields:

* Deployer Type – IBM Containers on Bluemix
* Provide the Target, Organization and Space of your Bluemix account to which the container has to be deployed
* Choose the deployment strategy (‘red_black’ if you want to re-route the IP address or route to the new container on successful deployment. ‘clean’ if you want to remove the older container before deploying the new container)
* Provide the name of the container
* Provide the port numbers:
    - Provide 9080,9443 in the PORT field if you are deploying a stand alone container
    - Provide 9080 in the PORT field if you are deploying a scalable container group
* Optional deploy arguments:
    - Mandatory for scalable container groups: Add the entry *--env MFPF\_CLUSTER\_MODE=Farm* in the Optional deploy arguments field
* Deployer script
    - If you want the container to be run as a stand alone container, there are no changes required to the script
    - If you want the container to be run as a scalable group, comment out the line ‘/bin/bash deployscripts/deploycontainer.sh’ and uncomment the line ‘/bin/bash deployscripts/deploygroup.sh’
* Set the environment properties by clicking on the **ENVIRONMENT PROPERTIES** (when no such properties are set, the default values for the properties are considered)
* Refer within the comments section within the Deployer script for the properties applicable for stand alone container / scalable container group
* Click on **SAVE**

### Deployment
Once the pipeline is created as above, the deployment is automatic when ever a change is pushed to the remote project from the local repository (or) the Build stage can be run manually by clicking on the Run button on the Build stage.

## The MobileFirst Platform Foundation Analytics Container
The instructions to build and run analytics container are same as discussed above for the Server container above. Note that adding the WARs / database configurations are not needed for analytics container. Additionally, choose the right values in all the steps. For example, name for the analytics project (For example, mfpf-analytics) etc.  
