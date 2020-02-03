---
title: IBM Mobile Foundation Server Silent Installation FAQs
date: 2020-01-17
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

This blog gives you quick and handy information on the FAQs related to Silent Installation of Mobile Foundation (MF) Server.

### What is Silent Installation 

You can install the MF server using the IBM Installation Manager (IM) either through wizard mode or though a XML file called response file.

The response file provides the input for silent installation.

Silent installation is very useful when :

- The operating system does not have a Graphical User Interface (GUI) by default.

- When the installation has to be done with no user interaction (Eg. Automating the task).

- If you are installing MF on multiple machines at once and you want the same installation settings.


### What is a Response file

A response file is a XML file that contains data required to complete the MF server installation operations silently. You can use a response file either to install, update, or uninstall the MF server.

Below are the different ways of getting a response file -

1.> **Download and use** the pre-recorded sample response files.
2.> **Record** a response file using the IM in wizard mode. You may record it on a different machine.

### How to use the Sample response files

- Download and use the pre-recorded sample response files here(http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip).

- The sample response files provide templates for installing the MF Server on a specific setup.

- Pick up the response file that corresponds to the version of the MF Server that you are using.

- Task specific response files are made available for you.

- If you choose to install the Application Center, then pick a sample response file that matches your Application Server and Database.

- If you are not installing the Application Center, then choose the response file named **install-no-appcenter.xml**.

- Select the appropriate response file and edit the details as required. Review the in-line comments in the response file before you adding the required data.

- You can optionally install [Application Center](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/) while installing MF server.

- Refer the [documentation here](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html) to install, update or uninstall using a response file.

- More details on working with sample response files can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/installation-manager/#working-with-sample-response-files-for-ibm-installation-manager).

### How to record a response file

- Using IM you can generate a response file based on the actions you take in the IM GUI.

- When you record a response file, all of the selections that you make in the IM are stored in an XML file. 

- During silent installation IM uses the data in the XML response file to perform the installation.

- The preferences that you set in the IM, including the repository settings are not stored while recording. Hence pre-set the MF repository location before recording the install or update scenario.

- Follow the steps [here](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_create_response_files_IM.html) to record a response file .

- Once completed, close the Installation Manager GUI and the response file will be created.

- Review the response file that was recorded. Note that you will have to change the machine details like architecture, install location, repository location when you are using the response file on a different machine.

- Also review if the iFix version in the recorded response file matches with the one that you want to install.

- Refer the [documentation here](https://www.ibm.com/support/knowledgecenter/SSDV2W_1.7.0/com.ibm.silentinstall12.doc/topics/t_silent_response_file_install.html) to install, update or uninstall using a response file.

- More details on working with recorded response files can be found [here](https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/installation-configuration/production/installation-manager/#working-with-a-response-file-recorded-on-a-different-machine).

### What to do next

- [MF Server installation](https://mobilefirstplatform.ibmcloud.com/blog/2020/01/21/ibm-mobile-foundation-server-installation-and-configuration/) is now complete.

- Install the MF server to an [Application Server](http://mobilefirstplatform.ibmcloud.com/tutorials/it/foundation/8.0/installation-configuration/production/prod-env/appserver/).

