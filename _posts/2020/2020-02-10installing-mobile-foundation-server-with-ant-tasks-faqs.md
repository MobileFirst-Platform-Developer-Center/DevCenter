---
title: Installing Mobile Foundation Server with Ant tasks - FAQs
date: 2020-02-12
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- MobileFirst_Installation
- On_Premise
version:
- 8.0
author:
  name: Soumya Y Shanthimohan
---

> This blog will provide you quick and handy information on installing Mobile Foundation (MF) server components using ANT Tasks. 

> As a pre-requisite, you must have [installed the MF server](https://mobilefirstplatform.ibmcloud.com/blog/2020/01/21/ibm-mobile-foundation-server-installation-and-configuration/#mf-server-installation-using-installation-manager) using IBM Installation (IM) manager


### Why should I use the ANT tasks

- The MF Server installation using IM will only copy the MF components on to the user’s machine. 

- The ANT tasks will help you to create the required data structure on your database to store the MF related data.

- The ANT tasks will help you to apply the MF components on to your Application Server.

- Configuring the database and deploying the MF components can be done either by using the Server Configuration Tool (SCT) or the ANT tasks.


### When to use ANT tasks

- The SCT is a eclipse based product and has a Graphical User Interface (GUI). You can use the ANT tasks if your operating system does not have a GUI by default.

- The SCT is supported only on the Operating Systems(OS) listed [here](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/appserver/#supported-operating-systems). You may use the ANT tasks if your OS does not support SCT.

- You may use ANT tasks when the configurations has to be done with no user interaction (Eg. Automating the tasks).

- Use ANT tasks if you are configuring MF server on multiple machines at once and you want the same configuration settings.


### Where can I find the ANT tasks

- You can find the ANT tasks under MF server installation directory.

- You don’t have to explicitly download and install ANT. The tool is deployed as a part of MF installer and can be found at /MobileFirst_Platform_Server_install_directory/tools/apache-ant-<version-num>.

- You can perform install, update and uninstall of MF server using the same ANT tasks.

- ANT tasks w.r.t MF server components can be found at - /MobileFirst_Platform_Server_install_directory/MobileFirstServer/configuration-samples.

- ANT tasks w.r.t MF Analytics can be found at - /MobileFirst_Platform_Server_install_directory/Analytics/configuration-samples.

- ANT tasks w.r.t MF Application Center can be found at - /MobileFirst_Platform_Server_install_directory/ApplicationCenter/configuration-samples.

- You can also create a configuration with the Server Configuration Tool and export the Ant files by using **File → Export Configuration as Ant Files….** 


### How to use them

- ANT tasks are written in xml format and their structure varies. There are templates for configuring MF components on a specific setup.

- ANT task templates specific to a Database and Application server are provided. Pick a ANT task specific to your environment. 

- Review the in-line comments in the ANT tasks before entering all the required properties.

- Run the command to configure the databases : **/MobileFirst_Platform_Server_install_directory/shortcuts/ant -f your_ant_file databases** .

- Run the command to install the MF components on to the Application Server : **/MobileFirst_Platform_Server_install_directory/shortcuts/ant -f your_ant_file install** . 

- Run the command to update the MF components on to the Application Server : **/MobileFirst_Platform_Server_install_directory/shortcuts/ant -f your_ant_file update** . 

- After the installation, make a copy of the Ant file so that you can reuse it to apply a fix pack.


### References 

- You may refer the edited ANT tasks for reference [here](https://github.com/soshanth/SampleANT)

- You may also specify [extra JNDI properties](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/appserver/#specify-extra-jndi-properties)

- Refer [here](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/prod-env/appserver/#installing-with-ant-tasks) for detailed information on Installing using ANT tasks




