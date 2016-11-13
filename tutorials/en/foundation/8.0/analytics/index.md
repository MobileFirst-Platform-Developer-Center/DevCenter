---
layout: tutorial
title: MobileFirst Foundation Operational Analytics
breadcrumb_title: Operational Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 8
---
## Overview
IBM MobileFirst Foundation Operational Analytics collects data from app-to-server activities, client logs, client crashes, and server-side logs from the MobileFirst Runtime Server and client devices. The collected data then provides a rich view into both the mobile landscape and server infrastructure. Included are: default reports of user retention, crash reports, device type and operating system breakdowns, custom data and custom charts, network usage, push notification results, in-app behavior, debug log collection, and more.

MobileFirst Server comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems. In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client-side and on the MobileFirst Analytics Server. You choose the verbosity and data retention policy of the reported events, set conditional alerts, build custom charts and engage with new data.

#### Platform support
MobileFirst Operational Analytics supports:

* Native iOS and Android clients
* Cordova applications (iOS, Android)
* Web applications
* Support is **not available** for the Windows 8.1 Universal or Windows 10 UWP

IBM MobileFirst Foundation Server comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting their network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems.

## Client development
Two client classes work together to send raw data to the server: the Logger and Analytics classes.

### The Analytics API
The Analytics client API collects data on a wide range of events and sends them to the MobileFirst Analytics Server.
> Learn more in the [Analytics Client Development](analytics-api) tutorial.

### The Logger API
The Logger functions as a standard logger. From the client you can also send logger data to the MobileFirst Analytics Server at any logging level. However, the server configuration controls what level of logging requests are allowed. Requests sent below this threshold are ignored.

Logging levels need to be controlled to balance two needs: the need to collect information and the need to limit the quantity of data to fit limited storage ability.

> Learn more in the [Client Logging](../application-development/client-side-log-collection/) tutorial.

In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client side and on the MobileFirst Analytics Server.


## The Analytics and Operations Consoles
IBM MobileFirst Foundation provides the Analytics and Operations consoles. The MobileFirst Operations Console configures how the Analytics Server works with the client applications. The Analytics Console configures and displays the various Analytics reports.

> Learn more in the [Operations Console](console) tutorial.

> Learn more about creating custom charts with the Analytics console in the [Custom Charts](console/custom-charts) tutorial.


## The Analytics Server
The Analytics Server is available in both the development and production environments.

For development, the Analytics Server is installed together with the MobileFirst Foundation Development Kit.  For more information, see [Setting up the MobileFirst development environment](../installation-configuration/development/mobilefirst/). Once the kit is installed, the Analytics Console is available for your development needs.

For production, there are different installation and configuration options available, according to your available infrastructure, business needs, system design, etc. For more information, see [Setting up the MobileFirst development environment](../installation-configuration/production/analytics/).

MobileFirst Foundation Operational Analytics uses Elasticsearch. [Learn how to use Elasticsearch](elasticsearch) in MobileFirst Foundation.

## Troubleshooting
For information on troubleshooting IBM MobileFirst Analytics, see [Analytics Troubleshooting](../troubleshooting/analytics/).

## What to read next
