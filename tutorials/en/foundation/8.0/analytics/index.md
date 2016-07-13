---
layout: tutorial
title: MobileFirst Foundation Operational Analytics
breadcrumb_title: Operational Analytics
show_disqus: true
print_pdf: true
relevantTo: [ios,android,windows,javascript]
weight: 8
---
## Overview
IBM MobileFirst Foundation Operational Analytics collects data from app-to-server activities, client logs, client crashes, and server-side logs from the MobileFirst Runtime Server and client devices. Collecting analytics from all these data points populates the Operational Analytics Charts with infrastructure and client-side information.

![architecture diagram](mfp_operational_analytics.jpg)

#### Jump to

* [MobileFirst Operational Analytics Console](#mobilefirst-operational-analytics-console)
* [Elasticsearch](#elasticsearch)
* [Server Control of Client Log Capture](#server-control-of-client-log-capture)
* [Forwarding Server Logs](#forwarding-server-logs)
* [Tutorials to follow next](#tutorials-to-follow-next)

## MobileFirst Operational Analytics Console
You can open the Analytics Console from the MobileFirst Operations Console, by clicking on **Analytics Console**.

![Analytics console button](analytics-console-button.png)

The default URL is for the MobileFirst Analytics Console is `http://localhost:9080/analytics/console`.  
After navigating to the Analytics console, you see a dashboard like the following one (but with empty data).

![Analytics console](analytics-console.png)

From the Analytics Console, you can then:

* [Create custom charts](#custom-charts)
* [Manage alerts](#manage-alerts)
* [Monitor App Crash](#monitor-app-crash)
* [Monitor Network Data](#monitor-network-data)

### Custom Charts
Custom charts allow you to visualize the collected analytics data in your analytics data store as charts that are not available by default in the MobileFirst Operational Analytics Console. This visualization feature is a powerful way to analyze business-critical data.

### Manage Alerts
You can set thresholds in alert definitions to better monitor your activities.

You can configure thresholds which, if exceeded, trigger alerts to notify the MobileFirst Operational Analytics Console monitor. You can visualize the triggered alerts on the console or handle them by using a custom webhook. A custom webhook allows you to control who is notified when an alert is triggered, and how.

### Monitor App Crash
App crashes are visualized on the Analytics Console, where you can quickly view crashes and act on them accordingly. Crash logs are collected on the device by default. When crash logs are sent to the analytics server, they automatically populate the crash charts.

### Monitor Network Data
The MobileFirst Operational Analytics Console monitors network data when it is sent to the analytics server and allows the user to query this information in different ways.

> For more information about the data collected by MobileFirst Analytics, see the user documentation.

## Elasticsearch
Behind the scenes, running search queries and storing data for Operational Analytics is **Elasticsearch 1.5x**.  
Elasticsearch is a real-time distributed search and analytics engine that provides the ability to explore data at speed and at a scale. Elasticsearch is used for full-text search, structured search.

Elasticsearch is used for storing all mobile and server data in JSON format in the MobileFirst Operational Analytics server in Elasticsearch instances.  
The Elasticsearch instances are queried in real-time to populate the MobileFirst Operational Analytics Console.

MobileFirst Operational Analytics does not hide any Elasticsearch functionality. If knowledge about how to take full benefit of Elasticsearch, debug Elasticsearch, or optimize Elasticsearch instances is present, Operational Analytics does not prevent using it.

If you have interest in any Elasticsearch functionality besides what is predefined in MobileFirst Operational Analytics, you can read more about it in the Elasticsearch documentation.

> Read more in the [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).

### Elasticsearch properties
Elasticsearch properties are available through JNDI variables or environment entries.  
One of the more useful JNDI properties to get started with viewing the Elasticsearch data is:

 ```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
 ```

 This JNDI property allows you to view your Operational Analytics raw data in JSON format and to access your Elasticsearch instance through the port that is defined by Elasticsearch. The default port is 9500.

> **Note**: This setting is not secure and should not be enabled on a production environment.

**Viewing data**  
You can view all your data by visiting the tenant's search REST endpoint.  
Being able to access an Elasticsearch instance provides the ability to run custom queries and view more detailed information about the Elasticsearch cluster.

```
http://localhost:9500/*/_search
```

**View cluster health**

```
http://localhost:9500/_cluster/health
```

**View information on current nodes**

```
http://localhost:9500/_nodes
```

**View the current mappings**

```
http://localhost:9500/*/_mapping
```

> Elasticsearch exposes many more REST endpoints. To learn more, visit the Elasticsearch documentation.

## Server Control of Client Log Capture
Administrators can control the MobileFirst client SDK log capture and levels from the **MobileFirst Operations Console → [your application] → Log Filters**.  
Through `Log Filters` you can create a filter level that you can log at.

<img class="gifplayer" alt="Creating a log filter" src="add-log-filter.png"/>

To use the server configuration, the client must use the `updateConfigFromServer` method in the `Logger` API.

#### Android

```java
Logger.updateConfigFromServer();
```

#### iOS

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova

```javascript
WL.Logger.updateConfigFromServer();
```

The `Logger` configuration values that the server returns take precedence over any values that are set on the client side. When the Client Log Profile is removed and the client tries to retrieve the Client Log Profile, the client receives an empty payload. In this case, the `Logger` configuration defaults to what was originally configured on the client.

## Forwarding Server Logs
The MobileFirst Operations Console also gives the server administrator the ability to persist logs and send those logs to the MobileFirst Analytics Console.

To forward server logs, navigate to the Runtime **Settings** screen and specify the logger package under **Additional Packages**.  
The collected logs can then be viewed in the Analytics console. This is useful for a user to take advantage of triaging adapter logs in the Analytics console without having to collect all server logs.

## Tutorials to follow next

* [Analytics API](analytics-api)
* [Analytics REST API](analytics-rest-api)

### Related Blogposts
* [More on Instrumenting Custom Analytics]({{site.baseurl}}/blog/2016/01/22/howto-custom-in-app-behavior-analytics/)
* [More on Instrumenting Webhooks]({{site.baseurl}}/blog/2015/10/19/using-mfp-adapters-endpoint-analytics-alerts-webhooks/)
