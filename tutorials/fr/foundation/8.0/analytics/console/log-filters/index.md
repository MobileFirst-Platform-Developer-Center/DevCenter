---
layout: tutorial
title: Configuring Log Filters
breadcrumb_title: Log Filters
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

Administrators can control the {{ site.data.keys.product_adj }} client SDK log capture and levels from the **{{ site.data.keys.mf_console }} → [your application] → [version] → Log Filters**.  
Through `Log Filters` you can create a filter level that you can log at. The log level can be set globally (all logger instances) or for a specific package or packages.

<img class="gifplayer"  alt="Creating a log filter" src="add-log-filter.png"/>

For the application to fetch the configuration overrides that are set on the server, the `updateConfigFromServer` method must be called from a place in the code that is regularly run, such as in the app lifecycle callbacks.


#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

The `Logger` configuration values that the server returns take precedence over any values that are set on the client side. When the Client Log Profile is removed and the client tries to retrieve the Client Log Profile, the client receives an empty payload. In this case, the `Logger` configuration defaults to what was originally configured on the client.

## Forwarding server logs
{: #forwarding-server-logs }

The {{ site.data.keys.mf_console }} also gives the server administrator the ability to persist logs and send those logs to the {{ site.data.keys.mf_analytics_console }}.

To forward server logs, navigate to the Runtime **Settings** screen and specify the logger package under **Additional Packages**.  
The collected logs can then be viewed in the {{ site.data.keys.mf_analytics_console_short }}. This is useful for a user to take advantage of triaging adapter logs in the {{ site.data.keys.mf_analytics_console_short }} without having to collect all server logs.
