---
title: Using the Auto-Scaling Service with the MobileFirst Foundation tile on Bluemix
date: 2016-08-14
tags:
- MobileFirst_Foundation
- Mobile_Foundation_Service
- Bluemix
- Mobile_Foundation
version:
- 8.0
author:
  name: Vasanth Raghavan
---
## Overview
MobileFirst Foundation can be setup on Bluemix in two ways:

1.	[Using the Mobile Foundation Bluemix service](https://console.bluemix.net/catalog/services/mobile-foundation)
2.	[Using IBM-provided scripts that come with your License entitlement](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts/)

> Note: with the scripts path you can setup MobileFirst Foundation either in **IBM Containers** or in a **Liberty for Java** runtime.

This blog post explains the process of auto scaling your MobileFirst Foundation tile running on Liberty for Java runtime on Bluemix. Auto scaling can be achieved using the [Auto-Scaling service](https://console.bluemix.net/catalog/services/auto-scaling/) also available on Bluemix. The Auto-Scaling service enables you to automatically increase or decrease the available compute capacity. The number of application instances (nodes) are adjusted dynamically based on various operational parameters that you define in the auto-scaling policy.

## Setup
For the purposes of this blog post, we will provision a single node with 1GB memory.  
Ensure that you connect to a DashDB enterprise service plan on Bluemix (for the Mobile Foundation service. it is important to note that auto-scaling works only for the Professional plan).

You can associate the Auto-Scaling service with the Liberty for Java Cloudfoundry app that is running the MobileFirst Server. Search for the **Auto-Scaling** service under **DevOps** services in catalog. Select the same **Space** and **Application** (The MobileFirst Foundation tile service application) and click **Create**.

![autoscaling-create]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-create.png)
![autoscaling-mainpage]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-mainpage.png)

## Configuration
The Auto-scaling service allows you to configure a policy based on which application server nodes are increased (scale out) or decreased (scale in). The “Policy Configuration” tab allows you to set the rules.

For the purpose of this blog post – the Mobile Foundation server was subject to a load using an [automation test harness]({{site.baseurl}}/blog/2016/08/09/performance-testing-for-mobilefirst-foundation-8-0/).

In the production case, you will base this on the load subjected by mobile devices connected to the server. The “Metric Statistics” tab in the “Auto-Scaling” service gives you an overview of the various performance metrics. It provides a visual representation of different metric values. A meter shows the current specific metric value and a historical graph for the specific metric.

![autoscaling-throughput]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-throughput.png)

In the above example, we see the current “throughput” at 158 requests/second. The history graph on the right indicates the average throughput across nodes over approximately a one-and-a-half-hour time period. The “rules” specified are also displayed as the upper and the lower thresholds.

Each rule allows you to specify a minimum and maximum default instance count and is based on 4 metric types:

•	JVM Heap size
•	Memory size
•	Throughput (number of client requests/second)
•	Server response time

You can select a specific metric type and then specify conditions for a “Scale Out“ and “Scale In”. “Scale Out“ allows you to increase the number of application nodes (till the maximum default instance count) based on whether a specific metric exceeds a user defined value for a specified time limit. “Scale In” allows you to decrease the number of application nodes (till the minimum instance count) based on whether a specific metric falls below the user defined value for a specified time limit.

![autoscaling-rule1]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-rule1.png)

You can specify different rules for different metrics.  
In advanced configuration you can specify time buffers for various criteria. The “Statistic Window” enables you to specify the time period in seconds when the metrics are measured. The “Breach Duration” allows you to specify the time period after which the scaling action is triggered if the measured metric values always fall above or below the upper and the lower threshold specified by the user respectively. The “Cool down periods for scaling in and out” allows you to specify a time period after a scaling activity ends and before the next scaling activity starts.

## Auto-Scaling example with throughput
In our example we will configure an autoScaling policy based on throughput. In the example below, at a steady state load it seems like 225 requests/second seems to be around about the throughput that can be achieved with 1 node.

![autoscaling-throughput2]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-throughput2.png)

At this time the memory graph looked like this:

![autoscaling-memory]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-memory.png)

![autoscaling-jvm]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-jvm.png)

![autoscaling-throughput3]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-throughput3.png)

In the ”Policy Configuration” tab, we will specify the minimum and maximum instance count as 1 and 2 respectively.  We will choose “Metric Type” as “Throughput” and set our rule as follows:

![autoscaling-rule2]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-rule2.png)

The rule is fairly self-explanatory. It specifies that if the average throughput across instances exceeds 200 requests/second for a time period of 300 seconds (the “Breach Duration”) then the number of liberty nodes will be increased by 1. If the average throughput falls below 100 requests/second, for a time period of 300 seconds (the “Breach Duration”) then the number of liberty nodes will be decreased by 1. Average throughput here is calculated taking into account the throughput across all current active nodes. Do not set this window to be too close as this may cause unwanted cycling of nodes.As we see the throughput load increasing and crossing the 200 requests/second mark specified in our rule, we see a new node being created after 300 seconds, when we navigate to the “Runtime” tab section, in “Instances”,after selecting our MobileFirst Foundation tile application under “Cloud Foundry Applications“.


![autoscaling-app]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-app.png)

To recap, if the average throughput exceeds 200 requests/second for a period of 300 seconds (5 minutes -the specified “Breach Duration”), another instance is added.

![autoscaling-scaleout]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-scaleout.png)

![autoscaling-scaleout2]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-scaleout2.png)

As the average throughput drops to below 100 requests/second (achieved by merely stopping our jmeter client scripts), the new instance is removed and only 1 instance remains.

![autoscaling-scalein]({{site.baseurl}}/assets/blog/2016-08-14-auto-scaling-service-with-mobilefirst-foundation-tile-on-bluemix/autoscaling-scalein.png)
