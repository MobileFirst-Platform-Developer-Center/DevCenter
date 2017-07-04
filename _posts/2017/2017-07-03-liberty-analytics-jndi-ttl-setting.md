---
title: 'Setting JNDI property for Mobile Analytics Time To Live(TTL) value as days in Liberty Profile'
date: 2017-07-03
tags:
- MobileFirst_Foundation
- Analytics
version:
- 7.1
author:
  name: Mohanraj Loganathan
---
## Problem Description
Error seen when the time-to-live value (TTL) for MobileFirst Analytics documents is set with the unit of "days".
For example, when we set 90d for 90days in the JNDI value, it fails.

> i.e setting TTL for MfpAppLogs in MobileFirst Analytics Server as below <br>
```
<jndiEntry jndiName="analytics/TTL_MfpAppLogs" value="90d" />
```
<br>
throws following error: <br>
```
ibm.mobile.analytics.server.node.elasticsearch.IndexManager E MSAN219E: Setting for TTL: MfpAppLogs has been set to an invalid TTL string.
org.elasticsearch.ElasticsearchParseException: Failed to parse [90.0]
```

>**Version Affected:** IBM MobileFirst Analytics Server 7.1

## Cause :
As per the details provided in [Liberty documentation](https://www.ibm.com/support/knowledgecenter/en/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dep_jndi.html), **jndiEntry** for string literals is expected to be enclosed with single quotes. Without a single quote the value passed as a numeral followed by 'd' (eg: 90d) is assumed as double-precision floating point (i.e 90.0) by the Liberty Server.

## Resolution :
* **jndiEntry** for TTL values are expected to be String literals.
* As per [Liberty documentation](https://www.ibm.com/support/knowledgecenter/en/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_dep_jndi.html) TTL value should be passed with in single quotes.
* For example, setting TTL for MfpAppLogs in MobileFirst Analytics Server, it should look as follows (note the additional single quotes):

>```<jndiEntry jndiName="analytics/TTL_MfpAppLogs" value='"90d"' />```
