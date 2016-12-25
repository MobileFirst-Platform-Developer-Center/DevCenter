---
layout: tutorial
title: Managing Alerts
breadcrumb_title: Alerts
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
Alerts provide a proactive means to monitor the health of your mobile apps without having to check the {{ site.data.keys.mf_analytics_console_full }} regularly.  
You can set reactive thresholds in the {{ site.data.keys.mf_analytics_console }} to trigger alerts when a specific criteria is met.

You can set thresholds at a broad level (a specific app) or at a granular level (a specific app instance or device). Alert notifications can be configured to display in the {{ site.data.keys.mf_analytics_console_short }}, and also be sent to a pre-configured REST endpoint or custom webhook.

Once alerts are triggered, the **Alert** icon (in the title bar of the {{ site.data.keys.mf_analytics_console_short }}) displays the alert count in red (<img  alt="alert icon" style="margin:0;display:inline" src="alertIcon.png"/>). Click the **Alert** icon to view the alerts.

Alternate methods are available for distributing the alerts.

**Prerequisite:** Ensure that the {{ site.data.keys.mf_analytics_server }} is started and ready to receive client logs.

## Alert management
### Creating an alert
In the {{ site.data.keys.mf_analytics_console }}:




1. Select the **Dashboard→Alert Management** tab. Click the **Create Alert** button.
![Alert Management Tab](alert_management_tab.png)

1. Provide the following values: Alert Name, Message, Query Frequency, and Event Type. Depending on the Event Type, populate the additional text boxes that appear with the appropriate values.

2. Once all values are entered, click **Next**. The **Distribution Method** tab appears.





### Distribution Method tab
By default, the alert is displayed in the {{ site.data.keys.mf_analytics_console_short }}.

You can also send a POST message with a JSON payload to both the {{ site.data.keys.mf_analytics_console_short}} and to a customized URL by selecting the **Analytics Console and Network Post** option.

The following fields are available if you choose this option:

* Network POST URL (*required*)
* Headers (*optional*)
* Authentication Type (*required*)



## Custom web hook
You can set up a custom distribution method for an alert. For example: define a web hook to which a payload is sent to when an alert threshold is triggered.

Example payload:

```json
{
  "timestamp": 1442848504431,
  "condition": {"value":5.0,"operator":"GTE"},
  "value": "CRASH",
  "offenders": [
    { "XXX 1.0": 5.0 },
    { "XXX 2.0": 1.0 }
  ],
  "property":"closedBy",
  "eventType":"MfpAppSession",
  "title":" Crash Count Alert for Application ABC",
  "message": "The crash count for a application ABC exceeded XYZ.
    View the Crash Summary table in the Crashes tab in the Apps
    section of the MobileFirst Analytics Console
    to see a detailed stacktrace of this crash instance."
}
```

The POST request includes the following attributes:

* **timestamp** - the time at which the alert notification was created.
* **condition** - the threshold that was set by the user (for example, greater than or equals 5).
* **eventType** - the eventType that was queried.
* **property** - the property of the eventType that was queried.
* **value** - the value of the property that was queried.
* **offenders** - a list of apps or devices that triggered the alert.
* **title** - the user-defined title.
* **message** - the user-defined message.

## Viewing alert details
Alert details can be viewed from the **Dashboard→Alert Log** tab in the {{ site.data.keys.mf_analytics_console }}.

![A new alert log](alert-log.png)

Click the **+** icon for any of the available incoming alerts. This action displays the **Alert Definition** and **Alert Instances** sections. The following image shows the Alert Definition and Alert Instances sections:

![Alert definitiosns and instances](alert-definitions-and-instances.png)
