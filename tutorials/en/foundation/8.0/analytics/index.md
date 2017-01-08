---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{{ site.data.keys.mf_analytics_full }} collects data from app-to-server activities, client logs, client crashes, and server-side logs from the {{ site.data.keys.mf_server }} and client devices. The collected data then provides a rich view into both the mobile landscape and server infrastructure. Included are: default reports of user retention, crash reports, device type and operating system breakdowns, custom data and custom charts, network usage, push notification results, in-app behavior, debug log collection, and more.

{{ site.data.keys.mf_server }} comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems. In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client-side and on the {{ site.data.keys.mf_analytics_server }}. You choose the verbosity and data retention policy of the reported events, set conditional alerts, build custom charts and engage with new data.

#### Platform support
{{ site.data.keys.mf_analytics }} supports:

* Native iOS and Android clients
* Cordova applications (iOS, Android)
* Web applications
* Support is **not available** for Windows 8.1 Universal or Windows 10 UWP

IBM {{ site.data.keys.mf_server }} comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting their network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems.

## Client development
Two client classes work together to send raw data to the server: the Logger and Analytics classes.

### The Analytics API
The Analytics client API collects data on a wide range of events and sends them to the {{ site.data.keys.mf_analytics_server }}.
> Learn more in the [Analytics Client Development](analytics-api) tutorial.

### The Logger API
The Logger functions as a standard logger. From the client you can also send logger data to the {{ site.data.keys.mf_analytics_server }} at any logging level. However, the server configuration controls what level of logging requests are allowed. Requests sent below this threshold are ignored.

Logging levels need to be controlled to balance two needs: the need to collect information and the need to limit the quantity of data to fit limited storage ability.

> Learn more in the [Client Logging](../application-development/client-side-log-collection/) tutorial.

In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client side and on the {{ site.data.keys.mf_analytics_server }}.


## The Analytics and Operations Consoles
{{ site.data.keys.product_full }} provides the Analytics and Operations consoles. The {{ site.data.keys.mf_console_full }} configures how the Analytics Server works with the client applications. The {{ site.data.keys.mf_analytics_console_full }} configures and displays the various Analytics reports.

> Learn more in the [Operations Console](console) tutorial.

> Learn more about creating custom charts with the Analytics console in the [Custom Charts](console/custom-charts) tutorial.


## The Analytics Server
The Analytics Server is available in both the development and production environments.

For development, the Analytics Server is installed together with the {{ site.data.keys.mf_dev_kit }}.  For more information, see [Setting up the {{ site.data.keys.product_adj }} development environment](../installation-configuration/development/mobilefirst/). Once the kit is installed, the {{ site.data.keys.mf_analytics_console_short }} is available for your development needs.

For production, there are different installation and configuration options available, according to your available infrastructure, business needs, system design, etc. For more information, see [Setting up the {{ site.data.keys.product_adj }} development environment](../installation-configuration/production/analytics/).

{{ site.data.keys.mf_analytics }} uses Elasticsearch. [Learn how to use Elasticsearch](elasticsearch) in {{ site.data.keys.product }}.

## Troubleshooting
For information on troubleshooting {{ site.data.keys.mf_analytics }}, see [Analytics Troubleshooting](../troubleshooting/analytics/).

## What to read next
