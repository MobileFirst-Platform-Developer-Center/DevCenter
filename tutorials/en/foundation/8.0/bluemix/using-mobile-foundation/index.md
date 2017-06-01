---
layout: tutorial
title: Using the Mobile Foundation on Bluemix service
breadcrumb_title: Mobile Foundation service
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
This tutorial provides step-by-step instructions to set up a {{ site.data.keys.mf_server }} instance on Bluemix by using the {{ site.data.keys.mf_bm_full }} (**{{ site.data.keys.mf_bm_short }}**) service.  
{{ site.data.keys.mf_bm_short }} is a Bluemix service that enables quick and easy stand-up of scalable Developer or Production environments of MobileFirst Foundation v8.0 on **Liberty for Java runtime**.

The {{ site.data.keys.mf_bm_short }} service offers the following plan options:

1. **Developer**: This plan provisions a {{ site.data.keys.mf_server }} as a Cloud Foundry app on a Liberty for Java runtime. The plan does not support the use of external databases or define multiple nodes *and is restricted to development and testing only*. The server instance allows you to register any number of Mobile application for development and testing.

    > **Note:** the Developer plan does not offer a persistent database, as such be sure to backup your configuration as explained [in the Troubleshooting section](#troubleshooting).

2. **Developer Pro**: This plan provisions a {{ site.data.keys.mf_server }} as a Cloud Foundry app on a Liberty for Java runtime, and allows users to develop and test any number of mobile applications. The plan requires you to have a **dashDB OLTP service** in place. The dashDB service is created and billed separately. Optionally, you can add a {{ site.data.keys.mf_analytics_server }}, deployed on IBM Containers. The Container charges are billed separately. This plan is limited in size and is intended to be used for team-based development and testing activities, not production. Charges depend on the total size of your environment.

3. **Professional Per Capacity:** This plan allows users to build, test and run any number of mobile applications in production, regardless of the number of mobile users or devices. It supports large deployments and High Availability. The plan requires you to have a **dashDB OLTP service** in place. The dashDB service is created and billed separately. Optionally, you can add a {{ site.data.keys.mf_analytics_server }}, deployed on IBM Containers. The Container charges are billed separately. Charges depend on the total size of your environment.

4. **Professional 1 Application**: This plan provisions a {{ site.data.keys.mf_server }} in a scalable Cloud Foundry app on a Liberty for Java runtime. The plan also requires a dashDB database service, which is created and billed separately. The plan allows users to build and manage a single mobile application. A single mobile application can consist of multiple flavors, such as iOS, Android, Windows, and Mobile Web.

> [See the service page on Bluemix.net](https://console.ng.bluemix.net/catalog/services/mobile-foundation/) for more information about the available plans and their billing.

#### Jump to:
{: #jump-to}
* [Setting up the {{ site.data.keys.mf_bm_short }} service](#setting-up-the-mobile-foundation-service)
* [Using the {{ site.data.keys.mf_bm_short }} service](#using-the-mobile-foundation-service)
* [Server configuration](#server-configuration)
* [Advanced server configuration](#advanced-server-configuration)
* [Adding Analytics support](#adding-analytics-support)
* [Removing Analytics support](#removing-analytics-support)
* [Switching from Analytics deployed with IBM Containers to Analytics service](#switching-from-analytics-container-to-analytics-service)
* [Applying {{ site.data.keys.mf_server }} fixes](#applying-mobilefirst-server-fixes)
* [Accessing server logs](#accessing-server-logs)
* [Troubleshooting](#troubleshooting)
* [Further reading](#further-reading)

## Setting up the {{ site.data.keys.mf_bm_short }} service
{: #setting-up-the-mobile-foundation-service }
To set up the available plans, first follow these steps:

1. Load [bluemix.net](http://bluemix.net), login, and click on **Catalog**.
2. Search for **Mobile Foundation** and click on the resulting tile option.
3. *Optional*. Enter a custom name for the service instance, or use the default provided name.
4. Select the desired pricing plan, then click **Create**.

    <img class="gifplayer" alt="Creating a {{ site.data.keys.mf_bm_short }} service instance" src="service-creation.png"/>

### Setting up the *developer* plan
{: #setting-up-the-developer-plan }
1. Start the {{ site.data.keys.mf_server }}.
    - You can either keep the server configuration at its basic level and click on **Start Basic Server**, or
    - Update the server configuration in the [Settings tab](#advanced-server-configuration), and click on **Start advanced server**.

    During this step a Cloud Foundry app is generated for the {{ site.data.keys.mf_bm_short }} service, and the MobileFirst Foundation environment is being initialized. This step can take between 5 to 10 minutes.

2. With the instance ready, you can now [use the service](#using-the-mobile-foundation-service).

    ![Image of {{ site.data.keys.mf_bm_short }} setup](overview-page.png)

### Setting up the *Developer Pro*, *Professional Per Capacity* and *Professional 1 Application* plans
{: #setting-up-the-developer-pro-professional-percapacity-and-professional-1-application-plans }
1. These plans require an external [dashDB transactional database instance](https://console.ng.bluemix.net/catalog/services/dashdb/).

    > Learn more about [setting up a dashDB database instance]({{site.baseurl}}/blog/2016/11/02/using-dashdb-service-with-mobile-foundation/).

    If you have an existing dashDB service instance (DashDB Enterprise Transactional 2.8.500 or Enterprise Transactional 12.128.1400), select the **Use Existing Service** option, and provide your credentials:

    ![Image of {{ site.data.keys.mf_bm_short }} setup](create-dashdb-instance-existing.png)

    1.b. If you do not currently have a dashDB service instance, select the **Create New Service** option and follow the on-screen instructions:

    ![Image of {{ site.data.keys.mf_bm_short }} setup](create-dashdb-instance-new.png)

2. Start the {{ site.data.keys.mf_server }}.
    - You can either keep the server configuration at its basic level and click on **Start Basic Server**, or
    - Update the server configuration in the [Settings tab](#advanced-server-configuration), and click on **Start advanced server**.

    During this step a Cloud Foundry app is generated for the {{ site.data.keys.mf_bm_short }} service, and the MobileFirst Foundation environment is being initialized. This step can take between 5 to 10 minutes.

3. With the instance ready, you can now [use the service](#using-the-mobile-foundation-service).

    ![Image of {{ site.data.keys.mf_bm_short }} setup](overview-page.png)

## Using the {{ site.data.keys.mf_bm_short }} service
{: #using-the-mobile-foundation-service }

With the {{ site.data.keys.mf_server }} now running, you are presented with the following Dashboard:

![Image of {{ site.data.keys.mf_bm_short }} setup](service-dashboard.png)

Click on **Add Analytics** to add {{ site.data.keys.mf_analytics }} support to your server instance.
Learn more in the [Adding Analytics support](#adding-analytics-support) section.

Click on **Launch Console** to open the {{ site.data.keys.mf_console }}. The default user name is "admin" and the password can be revealed by clicking on the "eye" icon.

![Image of {{ site.data.keys.mf_bm_short }} setup](dashboard.png)

### Server configuration
{: #server-configuration }
The basic server instance consists of:

* A single node (server size: "small")
* 1GB memory
* 2GB storage capacity

### Advanced server configuration
{: #advanced-server-configuration }
Through the **Settings** tab, you can further customize the server instance with

* Varying node, memory, and storage combinations
* {{ site.data.keys.mf_console }} admin password
* LTPA keys
* JNDI configuration
* User registry
* TrustStore
* {{ site.data.keys.mf_analytics }} configuration
* DashDB Enterprise Transactional 2.8.500 or Enterprise Transactional 12.128.1400 database selection (available in the *Professional 1 Application* plan)
* VPN

![Image of {{ site.data.keys.mf_bm_short }} setup](advanced-server-configuration.png)

## Adding {{ site.data.keys.mf_analytics_short }} support
{: #adding-analytics-support }
You can add {{ site.data.keys.mf_analytics }} support to your {{ site.data.keys.mf_bm_short }} service instance by clicking on **Add Analytics** from the service's Dashboard page. This action provisions a {{ site.data.keys.mf_analytics }} service instance.

<!--* When using the **Developer** plan this action will also automatically hook the {{ site.data.keys.mf_analytics_short }} service instance to your {{ site.data.keys.mf_server }} instance.  
* When using the **Developer Pro**, **Professional Per Capacity** or **Proffessional 1 Application** plans, this action will require additional input from you to select: amount of available Nodes, available Memory and a storage volume. -->

Once the operation finishes, reload the {{ site.data.keys.mf_console }} page in your browser to access the {{ site.data.keys.mf_analytics_console_short }}.  

> Learn more about {{ site.data.keys.mf_analytics }} in the [{{ site.data.keys.mf_analytics }} category](../../analytics).

##  Removing {{ site.data.keys.mf_analytics_short }} support
{: #removing-analytics-support}

You can remove the {{ site.data.keys.mf_analytics }} support for your {{ site.data.keys.mf_bm_short }} service instance by clicking on **Delete Analytics**  from the service’s Dashboard page. This action deletes the {{ site.data.keys.mf_analytics }} service instance.

Once the operation finishes, reload the {{ site.data.keys.mf_console }} page in your browser.

##  Switching from Analytics deployed with IBM Containers to Analytics service
{: #switching-from-analytics-container-to-analytics-service}

>**Note**: Deleting {{ site.data.keys.mf_analytics_short }} will remove all available analytics data in the container. This data will not be available in the new {{ site.data.keys.mf_analytics_short }} instance.

User can delete current container by clicking on **Delete Analytics** button from service dashboard. This will remove the analytics container and enable the **Add Analytics** button, which the user can click to add a new {{ site.data.keys.mf_analytics_short }} service instance.

## Applying {{ site.data.keys.mf_server }} fixes
{: #applying-mobilefirst-server-fixes }
Updates to the {{ site.data.keys.mf_bm }} services are applied automatically without a need for human intervention, other than agreeing to perform the update. When an update is available, a banner is displayed in the service's Dashboard page with instructions and action buttons.

## Accessing server logs
{: #accessing-server-logs }
To access server logs, open the sidebar navigation and click on **Apps → Cloud Foundary Apps**. Select your service and click on **Runtime**. Then click the **Files** tab.

You can find the **messages.log** and **trace.log** files in the **logs** folder.

#### Tracing
{: #tracing }
To enable tracing, in order to view DEBUG-level messages in the **trace.log** file:

1. In **Runtime → Memory and Instances**, select your service instance (instance IDs start with **0**).
2. Click the **Trace** action option.
3. Input the following trace statement: `com.worklight.*=debug=enabled` and click **Submit trace**.

The **trace.log** file is now available in the above specified location.

<img class="gifplayer" alt="Server logs for the {{ site.data.keys.mf_bm_short }} service" src="server-logs.png"/>

## Troubleshooting
{: #troubleshooting }
The Developer plan does not offer a persistent database, which could cause at times loss of data. To quickly onboard in such cases, be sure to follow these best practices:

* Every time you make any of the following server-side actions:
    * Deploy an adapter or update any adapter configuration or property value
    * Perform any security configuration such scope-mapping and alike

    Run the following from the command-line to download your configuration to a .zip file:

  ```bash
  $curl -X GET -u admin:admin -o export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/export/all
  ```

* In case you recreate your server or lose your configuration, run the following from the command-line to import the configuration to the server:

  ```bash
  $curl -X POST -u admin:admin -F file=@./export.zip http://<App Name>.mybluemix.net/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi
  ```

## Further reading
{: #further-reading }
Now that the {{ site.data.keys.mf_server }} instance is up and running,

* Familiarize yourself with the [{{ site.data.keys.mf_console }}](../../product-overview/components/console).
* Experience MobileFirst Foundation with these [Quick Start tutorials](../../quick-start).
* Read through all [available tutorials](../../all-tutorials/).
