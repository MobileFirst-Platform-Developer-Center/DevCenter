---
layout: tutorial
title: Administering Applications
weight: 11
show_children: true
---
## Overview
IBM MobileFirst Foundation provides several ways to administer MobileFirst applications in development or in production. MobileFirst Operations Console is the main tool with which you can monitor all deployed MobileFirst applications from a centralized web-based console.

The main operations that you can perform through MobileFirst Operations Console are:

* Registering and configuring mobile applications to MobileFirst Server.
* Deploying and configuring adapters to MobileFirst Server.
* Manage application versions to deploy new versions or remotely disable old versions.
* Manage mobile devices and users to manage access to a specific device or access for a specific user to an application.
* Display notification messages on application startup.
* Monitor push notification services.
* Collect client-side logs for specific applications installed on a specific device.

## Administration roles
Not every kind of administration user can perform every administration operation. MobileFirst Operations Console, and all administration tools, have four different roles defined for administration of MobileFirst applications. The following 

MobileFirst administration roles are defined:

**Monitor**  
In this role, a user can monitor deployed MobileFirst projects and deployed artifacts. This role is read-only.

**Operator**  
An Operator can perform all mobile application management operations, but cannot add or remove application versions or adapters.

**Deployer**  
In this role, a user can perform the same operations as the Operator, but can also deploy applications and adapters.

**Administrator**  
In this role, a user can perform all application administration operations.

> For more information about MobileFirst administration roles, see [Configuring user authentication for MobileFirst Server administration](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

## Administration tools
MobileFirst Operations Console is not the only way to administer MobileFirst applications. IBM MobileFirst Foundation also provides other tools to incorporate administration operations into your build and deployment process.

A set of REST services is available to perform administration operations. For API reference documentation of these services, see [REST API for the MobileFirst Server administration service](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html#restservicesapi).

With this set of REST services, you can perform the same operations that you can do in MobileFirst Operations Console. You can manage applications, adapters, and, for example, upload a new version of an application or disable an old version.

MobileFirst applications can also be administered by using Ant tasks or with the **mfpadm** command line tool. See [Administering MobileFirst applications through Ant](using-ant) or [Administering MobileFirst applications through the command line](using-cli).

Similar to the web-based console, the REST services, Ant tasks, and command line tools are secured and require you to provide your administrator credentials.

### Select a topic:

