---
layout: tutorial
title: Administering Applications
weight: 11
show_children: true
---
## Overview
{: #overview }
{{ site.data.keys.product_full }} provides several ways to administer {{ site.data.keys.product_adj }} applications in development or in production. {{ site.data.keys.mf_console }} is the main tool with which you can monitor all deployed {{ site.data.keys.product_adj }} applications from a centralized web-based console.

The main operations that you can perform through {{ site.data.keys.mf_console }} are:

* Registering and configuring mobile applications to {{ site.data.keys.mf_server }}.
* Deploying and configuring adapters to {{ site.data.keys.mf_server }}.
* Manage application versions to deploy new versions or remotely disable old versions.
* Manage mobile devices and users to manage access to a specific device or access for a specific user to an application.
* Display notification messages on application startup.
* Monitor push notification services.
* Collect client-side logs for specific applications installed on a specific device.

## Administration roles
{: #administration-roles }
Not every kind of administration user can perform every administration operation. {{ site.data.keys.mf_console }}, and all administration tools, have four different roles defined for administration of {{ site.data.keys.product_adj }} applications. The following

{{ site.data.keys.product_adj }} administration roles are defined:

**Monitor**  
In this role, a user can monitor deployed {{ site.data.keys.product_adj }} projects and deployed artifacts. This role is read-only.

**Operator**  
An Operator can perform all mobile application management operations, but cannot add or remove application versions or adapters.

**Deployer**  
In this role, a user can perform the same operations as the Operator, but can also deploy applications and adapters.

**Administrator**  
In this role, a user can perform all application administration operations.

> For more information about {{ site.data.keys.product_adj }} administration roles, see [Configuring user authentication for {{ site.data.keys.mf_server }} administration](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

## Administration tools
{: #administration-tools }
{{ site.data.keys.mf_console }} is not the only way to administer {{ site.data.keys.product_adj }} applications. {{ site.data.keys.product }} also provides other tools to incorporate administration operations into your build and deployment process.

A set of REST services is available to perform administration operations. For API reference documentation of these services, see [REST API for the {{ site.data.keys.mf_server }} administration service](../api/rest/admin-apis/).

With this set of REST services, you can perform the same operations that you can do in {{ site.data.keys.mf_console }}. You can manage applications, adapters, and, for example, upload a new version of an application or disable an old version.

{{ site.data.keys.product_adj }} applications can also be administered by using Ant tasks or with the **mfpadm** command line tool. See [Administering {{ site.data.keys.product_adj }} applications through Ant](using-ant) or [Administering {{ site.data.keys.product_adj }} applications through the command line](using-cli).

Similar to the web-based console, the REST services, Ant tasks, and command line tools are secured and require you to provide your administrator credentials.

### Select a topic:
{: #select-a-topic }
