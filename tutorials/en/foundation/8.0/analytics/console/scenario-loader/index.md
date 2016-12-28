---
layout: tutorial
title: Scenario Loader
breadcrumb_title: Scenario Loader
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview

> **Note:** The Scenario Loader is *experimental* in nature, and is therefore not fully supported. Use accordingly.
>
> * Some charts do not get populated.

The Scenario Loader populates various {{ site.data.keys.mf_analytics_console_full }} charts and reports with dummy data. The data is stored in the Elasticsearch data store, safely segregated from your existing test or production data.

The loaded data is synthetic in nature, injected directly into the data store. It is not the result of any actual analytics data created by the client or server. The purpose of the data is to enable the user to better view the nature of various reports and charts as displayed in the UI. Therefore the data should **not** be used for testing purposes.

#### Jump to
* [Before you start](#before-you-start)
* [Connecting to the Scenario Loader](#connecting-to-the-scenario-loader)
* [Configuring the data loading](#configuring-the-data-loading)
* [Loading and deleting the data](#loading-and-deleting-the-data)
* [Viewing the populated charts and tables](#viewing-the-populated-charts-and-tables)
* [Disabling the debug mode](#disabling-the-debug-mode)

## Before you start
The Scenario Loader is packaged together with the {{ site.data.keys.mf_analytics_console }}. Make sure your {{ site.data.keys.mf_analytics_console_short }} is running and accessible before connecting to the Scenario Loader.

## Connecting to the Scenario Loader

1. To enable the Scenario Loader, set either the JVM argument `-DwlDevEnv=true`, or the environment variable `ANALYTICS_DEBUG=true`.

2. Access the Scenario Loader in  your browser using the console URL: `http://<console-path>/scenarioLoader` where `<console-path>` is the JNDI property value defined in the `mfp-server/usr/servers/mfp/server.xml` file, for example:

    `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

3. The Scenario Loader page, along with the {{ site.data.keys.mf_analytics_console_short }} navigation bar, are displayed. The Scenario Loader remains inaccessible from the navigation bar.

## Configuring the data loading

1. In the **Testing Configuration** section various settings are available to control the nature (**Basic** tab) and volume (**Capacity Planning** tab) of the generated data.
    Make sure the **Days of history** setting is set to at least 30 days, in order to load sufficient data.

    All available information about these settings is provided in the  **Testing Configuration** section.


1. Click on the **Administration** icon <img  alt="wrench icon" style="margin:0;display:inline" src="wrench.png"/> and select the **Settings** tab. In the **Advanced** section make sure that the **Default tenant** value is set to `dummy_data_for_demo_purposes_only`.


## Loading and deleting the data

To load the data, click the **Start Scenario Loading** button in the **Scenario Operations** section.

To delete the data, click the **Delete Now** button in the **Testing Configuration** section.

**NB:** Read the disclaimer about data creation and deletion in the **Scenario Operations** section.

## Viewing the populated charts and tables

Once the data is loaded, many, but not all, of the charts and tables available in the Analytics Console are populated.

From the {{ site.data.keys.mf_analytics_console_short }} navigation bar, check the various pages and tabs to view the populated charts and tables.

## Disabling the debug mode

In order to work with real data after working in debug mode and synthetic data:

1. Delete the  data by clicking the **Delete Now** button in the **Testing Configuration** section.
2. In **Settings** → **Advanced** section make sure that the **Default tenant** value is set to `worklight`.
3. For the variable that was set to true, set to false (the JVM argument `-DwlDevEnv=false`, or  the environment variable `ANALYTICS_DEBUG=false`).
4. Restart the {{ site.data.keys.mf_analytics_server }}.
