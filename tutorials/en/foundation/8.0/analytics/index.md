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
{: #overview }

To keep your user engagement relevant and effective you must obtain insights into how your application is performing with users. {{ site.data.keys.mf_analytics_full }} provides this capability with in-built visualizations (charts and tables). With very minimal instrumentation of your application, you can readily visualize, on the Mobile Foundation Analytics console the following actionable insight: -

* **User Onboarding & Retention Patterns:** Do you have new users onboarding? Do you have existing users who return to your application?
* **Usage Patterns:** At what times is your application most and least used, is it meeting its business relevance in this regard?
* **Device & OS Distribution:** What is the distribution of your app across Mobile Device models and Operating Systems
* **Backend Performance:** What are the most used functions of your backend systems and what is their response time and stability, is there a need to rebalance your backend?
* **Application Stability:** How stable is your application over time and if there were crashes what are the causes (crash logs). Does your application design / implementation need fixing?
* **Troubleshooting Leads:** What is your application flow trace / trail before it headed into a crash ?
* **In-App User Experience:** What is the actual interactive experience your users are undergoing while they use the app and how do they feel, do you need to revisit your user-study?
* **Custom Trails:** Custom charts, which are defined and plotted around custom data that is logged as part of application-specific trails and flows, also provides the flexibility to extend and define your own insights that can help your business decisions too.

{{ site.data.keys.mf_analytics_full }} collects data from app-to-server activities, client logs, client crashes, in-app user feedback, and server-side logs from the {{ site.data.keys.mf_server }} and client devices. The collected data then provides a rich view into both the mobile landscape and server infrastructure. 

{{ site.data.keys.mf_server }} comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems. In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client-side and on the {{ site.data.keys.mf_analytics_server }}. You choose the verbosity and data retention policy of the reported events, set conditional alerts, build custom charts and engage with new data.

#### Platform support
{: #platform-support }

{{ site.data.keys.mf_analytics }} supports:

* Native iOS and Android clients
* Cordova applications (iOS, Android)
* Web applications
* Support is **not available** for Windows 8.1 Universal or Windows 10 UWP

IBM {{ site.data.keys.mf_server }} comes pre-instrumented with network infrastructure reporting. When both the client and server are reporting their network usage, the data is aggregated so you can attribute poor performance to the network, the server, or the back-end systems.

## Client development
{: #client-development }

Two client classes work together to send raw data to the server: the Logger and Analytics classes.

### The Analytics API
{: #the-analytics-api }

The Analytics client API collects data on a wide range of events and sends them to the {{ site.data.keys.mf_analytics_server }}.
> Learn more in the [Analytics Client Development](analytics-api) tutorial.

### The Logger API
{: #the-logger-api }

The Logger functions as a standard logger. From the client you can also send logger data to the {{ site.data.keys.mf_analytics_server }} at any logging level. However, the server configuration controls what level of logging requests are allowed. Requests sent below this threshold are ignored.

Logging levels need to be controlled to balance two needs: the need to collect information and the need to limit the quantity of data to fit limited storage ability.

> Learn more in the [Client Logging](../application-development/client-side-log-collection/) tutorial.

In addition, you can control which logger data is accessed and used by analytics by defining filters both on the client side and on the {{ site.data.keys.mf_analytics_server }}.

## The Analytics and Operations Consoles
{: #the-analytics-and-operations-consoles }

{{ site.data.keys.product_full }} provides the Analytics and Operations consoles. The {{ site.data.keys.mf_console_full }} configures how the Analytics Server works with the client applications. The {{ site.data.keys.mf_analytics_console_full }} configures and displays the various Analytics reports.

> Learn more in the [Operations Console](console) tutorial.

> Learn more about creating custom charts with the Analytics console in the [Custom Charts](console/custom-charts) tutorial.

## The Analytics Server
{: #the-analytics-server }

The Analytics Server is available in both the development and production environments.

For development, the Analytics Server is installed together with the {{ site.data.keys.mf_dev_kit }}.  For more information, see [Setting up the {{ site.data.keys.product_adj }} development environment](../installation-configuration/development/mobilefirst/). Once the kit is installed, the {{ site.data.keys.mf_analytics_console_short }} is available for your development needs.

For production, there are different installation and configuration options available, according to your available infrastructure, business needs, system design, etc. For more information, see [Setting up the {{ site.data.keys.product_adj }} development environment](../installation-configuration/production/analytics/).

{{ site.data.keys.mf_analytics }} uses Elasticsearch. [Learn how to use Elasticsearch](elasticsearch) in {{ site.data.keys.product }}.

## Troubleshooting
{: #troubleshotting }

For information on troubleshooting {{ site.data.keys.mf_analytics }}, see [Analytics Troubleshooting](../troubleshooting/analytics/).

## What to read next
{: #what-to-read-next }
