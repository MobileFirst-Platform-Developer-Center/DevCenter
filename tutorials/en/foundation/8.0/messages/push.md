---
layout: tutorial
title: Push Notification Messages
breadcrumb_title: Push Notifications
relevantTo: [ios,android,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Find information about error messages encountered while working with JSONStore in mobile applications.


## List of error codes
{: #list-of-error-codes }
List of common error codes and their description:

|Error Code      | Description |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | Unrecognized error. |
| -75 OS\_SECURITY\_FAILURE | This error code is related to the requireOperatingSystemSecurity flag. It can occur if the destroy API fails to remove security metadata that is protected by operating system security (Touch ID with passcode fallback), or the init or open APIs are unable to locate the security metadata. It can also fail if the device does not support operating system security, but operating system security usage was requested. |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore is closed. Try calling the open method in the JSONStore class class first to enable access to the store. |

