---
layout: tutorial
title: Troubleshooting
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Resolving problems with IBM MobileFirst Foundation on Liberty for Java runtime	
When you are unable to resolve a problem encountered while working with IBM MobileFirst Foundation on Liberty for Java runtime, be sure to gather this key information before contacting IBM Support.

To help expedite the troubleshooting process, gather the following information:

* The version of IBM MobileFirst Foundation that you are using (must be V8.0.0 or later) and any interim fixes that were applied.
* The Liberty for Java runtime size selected. For example, 2GB.
* The Bluemix  dashDB database plan type. For example, EnterpriseTransactional 2.8.500.
* The mfpconsole route
* Versions of cloud foundry: `cf -v` 
* The information returned from running the following Cloud Foundry CLI commands from the organization and space where your MobileFirst  Foundation server is deployed:
 - `cf app APP_NAME`

### Unable to create the mfpfsqldb.xml file
An error occurs at the end of running the **prepareserverdbs.sh** script:

> Error : unable to create mfpfsqldb.xml

**How to resolve**  
The problem might be an intermittent database connectivity issue. Try to run the script again.

### Script fails and returns message about tokens	
Running a script is not successful and returns a message similar to Refreshing cf tokens or Failed to refresh token.

**Explanation**  
The Bluemix session might have timed-out. The user must be logged in to Bluemix before running the scripts.

**How to resolve**
Run the initenv.sh script again to log in to Bluemix and then run the failed script again.

### Administration DB, Live Update and Push Service show up as inactive	
Administration DB, Live Update and Push Service show up as inactive or no runtimes are listed in the MobileFirst Foundation Operations Console even though the **prepareserver.sh** script completed successfully.

**Explanation**  
It is possible that a either a connection to the database service did not get established or that a formatting problem occurred in the server.env file when additional values were appended during deployment.

If additional values were added to the server.env file without new line characters, the properties would not resolve. You can validate this potential problem by checking the log files for errors caused by unresolved properties that look similar to this error:

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**How to resolve**  
Manually restart the Liberty app. If the problem still exists, check to see if the number of connections to the database service exceeds the number of connections provisioned by your database plan. If so, make any needed adjustments before proceeding.

If the problem was caused by unresolved properties, ensure that your editor adds the linefeed (LF) character to demarcate the end of a line when editing any of the provided files. For example, the TextEdit app on macOS might use the CR character to mark the end of line instead of LF, which would cause the issue.

