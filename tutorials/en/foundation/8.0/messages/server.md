---
layout: tutorial
title: Mobile Foundation Server Messages
breadcrumb_title: Foundation Server
relevantTo: [ios,android,cordova]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Find information to help resolve issues that you might encounter when you use the JSONStore API.



## List of error codes
{: #list-of-error-codes }
List of common error codes and their description:

| **Error Code** | **Description** |
|----------------|-----------------|
| **FWLSE3030E** | *The runtime "mfp" does not exist in the MobileFirst administration database. The database may be corrupted.* |
| **FWLSE3030E** | *The runtime "mfp" does not exist in the MobileFirst administration database. The database may be corrupted.*
{::nomarkdown}Inside nomarkdown.{:/} |

| **FWLSE4224E** | {::nomarkdown}<ul><li>Optional for perpetual licenses</li><li>Mandatory for token licenses</li></ul>{:/}*Failed to process registration request. 400; headers=[]; body={ errorCode=APPLICATION_DOES_NOT_EXIST errorMsg=Application doesn't exist}*

The application probably exists, but server startup was likely not successful due to another problem.  Look earlier in the logs for concurrency, connectivity, etc. issues that could impede the server startup process to not complete successfully. |
