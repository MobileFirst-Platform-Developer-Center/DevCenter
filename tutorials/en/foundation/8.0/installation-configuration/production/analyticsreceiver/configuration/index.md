---
layout: tutorial
title: MobileFirst Analytics Receiver Server Configuration Guide
breadcrumb_title: Configuration Guide
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Configuration for the {{ site.data.keys.mf_analytics_receiver_server }}.

#### Jump to
{: #jump-to }

* [Configuration Properties](#configuration-properties)

### Properties
{: #properties }
For a complete list of configuration properties and how to set them in your application server, see the section [Configuration Properties](#configuration-properties).

## Configuration Properties
{: #configuration-properties }
The {{ site.data.keys.mf_analytics_receiver_server }} can start successfully with following additional configuration.

The configuration is done through JNDI properties on both the {{ site.data.keys.mf_server }} and the {{ site.data.keys.mf_analytics_receiver_server }}. Additionally, the {{ site.data.keys.mf_analytics_receiver_server }} supports the use of environment variables to control configuration. Environment variables take precedence over JNDI properties.

The Analytics Receiver runtime web application must be restarted for any changes in these properties to take effect. It is not necessary to restart the entire application server.

To set a JNDI property on WebSphere  Application Server Liberty, add a tag to the `server.xml` file as follows.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

To set a JNDI property on Tomcat, add a tag to the `context.xml` file as follows.

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

The JNDI properties on WebSphere Application Server are available as environment variables.

* In the WebSphere Application Server console, select **Applications → Application Types → WebSphere Enterprise applications**.
* Select the **{{ site.data.keys.product_adj }} Administration Service** application.
* In **Web Module Properties**, click **Environment entries for Web Modules** to display the JNDI properties.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
The following table shows the properties that can be set in the {{ site.data.keys.mf_analytics_receiver_server }}.

| Property                           | Description                                           | Default Value |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | Set this property to the URL of your {{ site.data.keys.mf_analytics_console }}. For example, `http://hostname:port/analytics/console`. Setting this property enables the analytics icon on the {{ site.data.keys.mf_console }}. | None |
| receiver.analytics.url                  |Required. The URL that is exposed by the {{ site.data.keys.mf_analytics_server }} that receives incoming analytics data. For example, `http://hostname:port/analytics-service/rest`. | None |
| receiver.analytics.username             | The user name that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.password             | The password that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.event.qsize          | Size of analytic event queue size. It should be added with caution by providing ample JVM heap size. Default queue size 10000  | None |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
The following table shows the properties that can be set in the {{ site.data.keys.mf_server }}.

| Property                           | Description                                           | Default Value |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | Set this property to the URL of your {{ site.data.keys.mf_analytics_console }}. For example, `http://hostname:port/analytics/console`. Setting this property enables the analytics icon on the {{ site.data.keys.mf_console }}. | None |
| receiver.analytics.url                  |Required. The URL that is exposed by the {{ site.data.keys.mf_analytics_server }} that receives incoming analytics data. For example, `http://hostname:port/analytics-service/rest`. | None |
| receiver.analytics.username             | The user name that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.password             | The password that is used if the data entry point is protected with basic authentication. | None |
| receiver.analytics.event.qsize          | Size of analytic event queue size. It should be added with caution by providing ample JVM heap size. Default queue size 10000  | None |
