---
layout: tutorial
title: MobileFirst Analytics Receiver
weight: 22
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

The {{ site.data.keys.mf_analytics_receiver_short }} is an optional service that can be setup to receives event logs from mobile applications and forward them to {{ site.data.keys.mf_analytics_short }} in a phassed manner using in-memory event queue. {{ site.data.keys.mf_analytics_receiver_short }} maintains in-memory event queue to store the logs before sending them to {{ site.data.keys.mf_analytics_short }}. 

The default setup and configuration for Mobile Analytics is for the {{ site.data.keys.mf_server }} to receive all mobile client event logs and forward them to the {{ site.data.keys.mf_analytics_short }}.  When there are a large number of devices, high usage of the mobile client applications and substantical analytics data logged and sent from client applications the performance of {{ site.data.keys.mf_server }} could be impacted.  Enabling the {{ site.data.keys.mf_analytics_receiver_short }} will offload analytics events processing away from {{ site.data.keys.mf_server }} thereby allowing it's resources to be fully utilized for runtime functions.

The {{ site.data.keys.mf_analytics_receiver_short }} can be setup and configured anytime.  Mobile client applications will only need to be updated with the latest Mobile Foundation client SDKs with no changes to the application code. The {{ site.data.keys.mf_server }} JNDI properties should be updated for the {{ site.data.keys.mf_analytics_receiver_short }} configurations so that the {{ site.data.keys.mf_analytics_receiver_short }} enpoint is communicated to client applications for sending analytics events.

![Analytics Receiver Topology](AnalyticsTopology.png)

## {{ site.data.keys.mf_analytics_receiver_short }} configuration
{: #analytics-receiver-configuration }

The analytics receiver WAR file is included with the MobileFirst Server installation. For more information, see Distribution structure of MobileFirst Server.

* Information about how to install {{ site.data.keys.mf_analytics_receiver_server }}, see [{{ site.data.keys.mf_analytics_receiver_server }} installation guide](../installation-configuration/production/analyticsreceiver/installation).
* For more information about how to configure IBM MobileFirst Analytics Receiver, see [Configuration guide](../installation-configuration/production/analyticsreceiver/configuration).

* As a quick configuration after installing {{ site.data.keys.mf_analytics_receiver_short }} make sure following JNDI properties are pointing to {{ site.data.keys.mf_analytics }} . 

| Property                           | Description                                           | Default Value |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.url                  |Required. The URL that is exposed by the {{ site.data.keys.mf_analytics_server }} that receives incoming analytics data. For example, http://hostname:port/analytics-service/rest. | None |
| receiver.analytics.username             | The user name that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.password             | The password that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.event.qsize          | Optional. Size of analytic event queue size. It should be added with caution by providing ample JVM heap size. Default queue size 10000  | None |

* Inorder to enable receiver to be used as loguploader make sure following JNDI properties are set in {{ site.data.keys.mf_server }}. These JNDI properties should be pointed to {{ site.data.keys.mf_analytics_receiver_server }}. 

| Property                           | Description                                           | Default Value |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  |Required. The URL that is exposed by the {{ site.data.keys.mf_analytics_receiver_server }} that receives incoming analytics data. For example, http://hostname:port/analytics-receiver/rest. | None |
| mfp.analytics.receiver.username             | The user name that is used if the data entry point is protected with basic authentication. | None |
| mfp.analytics.receiver.password             | The password that is used if the data entry point is protected with basic authentication. | None |

* Make sure {{ site.data.keys.mf_analytics_short }} setup is not disturbed in {{ site.data.keys.mf_server }} since serverlogs are still transmitted directly from {{ site.data.keys.mf_server }} to {{ site.data.keys.mf_analytics_server }} .

## Troubleshooting
{: #troubleshotting }

For information on troubleshooting {{ site.data.keys.mf_analytics_receiver }}, see [Analytics Receiver Troubleshooting](../troubleshooting/analyticsreceiver/).
