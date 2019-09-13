---
layout: tutorial
title: Using Analytics REST API
breadcrumb_title: Analytics REST API
relevantTo: [ios,android,cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

{{ site.data.keys.mf_analytics_full }} provides REST APIs to help developers with importing (POST) and exporting (GET) analytics data.

## Jump to:
{: #jump-to }

* [Analytics REST API](#analytics-rest-api)
* [Try It Out on Swagger Docs](#try-it-out-on-swagger-docs)

## Analytics REST API
{: #analytics-rest-api }

To use the analytics REST API:

**Base URL**

`/analytics-service/rest`

**Example**

`https://example.com:9080/analytics-service/v3/applogs`


REST API Method | Endpoint | Description
--- | --- | ---
Application Logs (POST) | /v3/applogs | Creates a new application log.
Application Session (POST) | /v3/appsession | Creates an application session or updates an existing one when reporting with the same appSessionID.
Bulk (POST) | /v3/bulk | Reports events in bulk.
Custom Chart (GET)| /v3/customchart | Exports all custom chart definitions.
Custom Chart (POST) | /v3/customchart/import | Imports a list of custom charts.
Custom Data (POST) | /v3/customdata | Creates new custom data.
Device (POST) | /v3/device | Creates or updates a device.
Export Data (GET) | /v3/export | Exports data to the specified data format.
Network Transaction (POST) | /v3/networktransaction |  Creates a new network transaction.
Server Log (POST) | /v3/serverlog | Creates a new server log.
User (POST) | /v3/user | Creates a new user.

## Try it out on Swagger docs
{: #try-it-out-on-swagger-docs }

Try out the analytics REST API on Swagger Docs.  
In a {{ site.data.keys.mf_server }} configuration with Analytics enabled, visit: `<ipaddress>:<port>/analytics-service`.

![{{ site.data.keys.mf_analytics }} Swagger Docs UI](analytics-swagger.png)

By clicking on **Expand Operations**, you can see the implementation notes, parameters, and response messages for each method.

> Warning: Any data that you send by using **Try it out!** might interfere with data already in the data store. If you are not specifically trying to send data to your production environment, use a test name for the `x-mfp-analytics-api-key`.

![Test Swagger Docs](test-swagger.png)
