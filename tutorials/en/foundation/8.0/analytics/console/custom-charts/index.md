---
layout: tutorial
title: Creating Custom Charts
breadcrumb_title: Custom Charts
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
Custom charts allow you to visualize the collected analytics data in your analytics data store as charts that are not available by default in the {{ site.data.keys.mf_analytics_console }}. This visualization feature is a powerful way to analyze business-critical data.

Available custom chart types: **App Session**, **Network Transactions**, **Push Notifications**, **Client Logs**, **Server Logs**, **Custom Data**.

#### Jump to
* [Creating a custom chart](#creating-a-custom-chart)
* [Chart types](#chart-types)
* [Creating custom charts for client logs](#creating-custom-charts-for-client-logs)
* [Exporting custom chart data](#exporting-custom-chart-data)
* [Exporting and importing custom chart definitions](#exporting-and-importing-custom-chart-definitions)

## Creating a custom chart
In the {{ site.data.keys.mf_analytics_console }}, from the **Dashboard** panel, the custom charts creation builder takes you through four main stages:

### 1. General settings
Click the **Create Chart** button in the **Custom Charts** tab.  

In the **General Settings** tab, select Chart Title, Event Type and the Chart Type.  
After selecting the Event Type and Chart Type, the **Chart Definition** tab appears.

### 2. The Chart Definition tab
Use the **Chart Definition** tab to define the chart for the specified chart type that you previously selected. After you define the chart, you can set the chart filters and chart properties.

### 3. The Chart Filters tab
**Chart Filters** are used to fine-tune the custom chart. Multiple filters can be defined for any chart.  
For example, if you are interested in seeing the average app session duration for a particular app, you can specify the following options:

1. Select **Application Name** for **Property**.
2. Select **Equals** for **Operator**.
3. Select the name of your app for **Value**.
4. Click **Add Filter**.

The app name filter is added to the table of filters for your chart.

### 4. Chart properties
Chart properties are available for the **Table**, **Bar Graph**, and **Line Graph** chart types. The goal of chart properties is to enhance how the data is presented so that the visualization is more effective.

If you created a **Table chart**, the chart properties can be set to define the table page size, the field on which to sort, and the sort order of the field.

If you created a **Bar Graph** or **Line Graph** chart, the chart properties can be set to label threshold lines to add a frame of reference for anyone who is monitoring the chart.

<img class="gifplayer"  alt="Creating a custom chart" src="creating-custom-charts.png"/>

## Chart types

### Bar graph
The bar graph allows for visualization of numeric data over an X-axis. When you define a bar graph, you must choose the value for X-Axis first. You can choose from the following possible values.

* **Timeline** - choose Timeline for X-Axis if you want to see your data as a trend (for example, average app session duration over time).
* **Property** - choose Property if you want to see a count breakdown for the specific property. If you choose Property for X-Axis, then Total is implicitly chosen for Y-Axis. For example, choose Property for X-Axis and Application Name for Property to see a count for a specified event type, which is broken down by app name.

After you define a value for X-Axis, you can define a value for Y-Axis. If you choose Timeline for X-Axis, you can choose the following possible values for Y-Axis.

* **Average** - averages a numeric property in the supplied event type.
* **Total** - a total count of a property in the supplied event type.
* **Unique** - a unique count of a property in the supplied event type.

After you define the chart axes, you must choose a value for Property.

### Line graph
The line graph allows for the visualization of some metric over time. This type of chart is valuable when you want to visualize data in terms of a trend over time. The first value to define when you create a line graph is Measure, which has the following possible values.

* **Average** - averages a numeric property in the supplied event type.
* **Total** - a total count of a property in the supplied event type.
* **Unique** - a unique count of a property in the supplied event type.

After you define the measurement, you must choose a value for Property.

### Flow chart
The flow chart allows for the visualization of flow breakdown of one property to another. For a flow chart, the following properties must be set.

* **Source** - the value of a source node in the diagram.
* **Destination** - the value of the destination node in the diagram.
* **Property** - a property value from either the source node or the destination node.

With the flow chart, you can see the density breakdown of various sources that flow to a destination, or vice versa. For example, if you want to see the breakdown of log severities for an app, you can define the following values.

* Select Application Name for Source.
* Select Log Level for Destination.
* Select the name of your app for Property.

### Metric group
The metric group can be used to visualize a single metric that is measured as either an average value, a total count, or a unique count. To define a metric group, you must define one of the following possible values for Measure.

* **Average** - averages a numeric property in the supplied event type.
* **Total** - a total count of a property in the supplied event type.
* **Unique** - a unique count of a property in the supplied event type.

After you define the measurement, you must choose a value for Property. This metric is displayed in the metric group.

### Pie chart
The pie chart can be used to visualize the count breakdown of values for a particular property. For example, if you want to see a crash breakdown, define the following values.

* Select App Session for Event Type.
* Select Pie Chart for Chart Type.
* Select Closed By for Property.

The resulting pie chart shows the breakdown of app sessions that were closed by the user as opposed to app sessions that were closed by a crash.

### Table
The table is useful when you want to see the raw data. Building a table is as simple as adding columns for the raw data that you want to see.  
Because not all properties are required for specific event types, null values can appear in your table. If you want to prevent these rows from appearing in your table, add an Exists filter for a specific property in the Chart Filters tab.

## Creating custom charts for client logs
You can create a custom chart for client logs that contain log information that is sent with the platform's Logger API.  
The log information also includes contextual information about the device, including environment, app name, and app version.

> **Note:** You must log custom events to populate custom charts. For information on sending custom events from the client app, see [Capturing custom data](../../analytics-api/#custom-events).

1. From the client app, populate the data by sending captured logs to the server. See [Sending captured logs](../../analytics-api/#sending-analytics-data).
2. In the {{ site.data.keys.mf_analytics_console }}, click the **Custom Charts** tab and continue to a create a chart:
    * **Chart Title**: Application and Log Levels
    * **Event Type**: Client Logs
    * **Chart Type**: Flow Chart

3. Click the **Chart Definition** tab and provide the following values:
    * **Source**: Application Name
    * **Destination**: Log Level
    * **Property**: your app name

4. Click the **Save** button.

## Exporting custom chart data
You can download the data that is shown for any custom chart.  

![Export custom chart data using these icons](export-data.png)

* **Export with URL** - looks like a chain link
* **Download Chart** - looks like a down arrow
* **Edit Chart** - looks like a pencil
* **Delete Chart** - looks like a trashcan

Click the **Download Chart** icon to download a file in JSON format from the {{ site.data.keys.mf_analytics_console_short }}.  
Click the **Export with URL** icon to generate an export link from the {{ site.data.keys.mf_analytics_console_short }} to call from an HTTP client. This option is useful if you want to write a script to automate the export processes on a specified time interval.

## Exporting and importing custom chart definitions
You can export and import custom chart definitions in the {{ site.data.keys.mf_analytics_console_short }}. If you are moving from a test environment to a production deployment, you can save time by exporting your custom chart definitions instead of re-creating your custom charts on your new cluster.

1. Click the **Custom Charts** tab in the {{ site.data.keys.mf_analytics_console_short }} dashboard.
2. Click **Export Charts** to download a JSON file with your chart definition.
3. Choose a location to save the JSON file.
4. Click **Import Charts** to import your JSON file. If you import a custom chart definition that exists, you end up with duplicate definitions, which also means that the {{ site.data.keys.mf_analytics_console_short }} shows duplicate custom charts.
