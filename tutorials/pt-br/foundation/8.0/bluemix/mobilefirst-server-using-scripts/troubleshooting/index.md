---
layout: tutorial
title: Troubleshooting
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Resolving problems with {{ site.data.keys.product_full }} on IBM Containers	
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
When you are unable to resolve a problem encountered while working with {{ site.data.keys.product_full }} on IBM Containers, be sure to gather this key information before contacting IBM Support.

To help expedite the troubleshooting process, gather the following information:

* The version of {{ site.data.keys.product }} that you are using (must be V8.0.0 or later) and any interim fixes that were applied.
* The container size selected. For example, Medium 2GB.
* The Bluemix  dashDB database plan type. For example, EnterpriseTransactional 2.8.50.
* The container ID
* The public IP address (if assigned)
* Versions of docker and cloud foundry: `cf -v` and `docker version`
* The information returned from running the following Cloud Foundry CLI plug-in for IBM Containers (cf ic) commands from the organization and space where your {{ site.data.keys.product }} container is deployed:
 - `cf ic info`
 - `cf ic ps -a` (If more than one container instance is listed, make sure to indicate the one with the problem.)
* If Secure Shell (SSH) and volumes were enabled during container creation (while running the **startserver.sh** script), collect all files in the following folders: /opt/ibm/wlp/usr/servers/mfp/logs and /var/log/rsyslog/syslog
* If only volume was enabled and SSH was not, collect the available log information using the Bluemix dashboard. After you click on the container instance in the Bluemix dashboard, click the Monitoring and Logs link in the sidebar. Go to the Logging tab and then click ADVANCED VIEW. The Kibana dashboard opens separately. Using the search toolbar, search for the exception stack trace and then collect the complete details of the exception, @time-stamp, _id.

### Docker-related error while running script	
{: #docker-related-error-while-running-script }
If you encounter Docker-related errors after executing the initenv.sh or prepareserver.sh scripts, try restarting the Docker service.

**Example message** 

> Pulling repository docker.io/library/ubuntu  
> Error while pulling image: Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS message ID mismatch

**Explanation**  
The error could occur when the internet connection has changed (such as connecting to or disconnecting from a VPN or network configuration changes) and the Docker runtime environment has not yet restarted. In this scenario, errors would occur when any Docker command is issued.

**How to resolve**  
Restart the Docker service. If the error persists, reboot the computer and then restart the Docker service.

### Bluemix registry error	
{: #bluemix-registry-error }
If you encounter a registry-related error after executing the prepareserver.sh or prepareanalytics.sh scripts, try running the initenv.sh script first.

**Explanation**  
In general, any network problems that occur while the prepareserver.sh or prepareanalytics.sh scripts are running could cause processing to hang and then fail.

**How to resolve**  
First, run the initenv.sh script again to log in to the container registry on Bluemix . Then, rerun the script that previously failed.

### Unable to create the mfpfsqldb.xml file
{: #unable-to-create-the-mfpfsqldbxml-file }
An error occurs at the end of running the **prepareserverdbs.sh** script:

> Error : unable to create mfpfsqldb.xml

**How to resolve**  
The problem might be an intermittent database connectivity issue. Try to run the script again.

### Taking a long time to push image	
{: #taking-a-long-time-to-push-image }
When running the prepareserver.sh script, it takes more than 20 minutes to push an image to the IBM Containers registry.

**Explanation**  
The **prepareserver.sh** script pushes the entire {{ site.data.keys.product }} stack, which can take from 20 to 60 minutes.

**How to resolve**  
If the script has not completed after a 60-minute time period has elapsed, the process might be hung because of a connectivity issue. After a stable connection is reestablished, restart the script.

### Binding is incomplete error	
{: #binding-is-incomplete-error }
When running a script to start a container (such as **startserver.sh** or **startanalytics.sh**) you are prompted to manually bind an IP address because of an error that the binding is incomplete.

**Explanation**  
The script is designed to exit after a certain time duration has passed.

**How to resolve**  
Manually bind the IP address by running the related cf ic command. For example, cf ic ip bind.

If binding the IP address manually is not successful, ensure that the status of the container is running and then try binding again.  
**Note:** Containers must be in a running state to be bound successfully.

### Script fails and returns message about tokens	
{: #script-fails-and-returns-message-about-tokens }
Running a script is not successful and returns a message similar to Refreshing cf tokens or Failed to refresh token.

**Explanation**  
The Bluemix session might have timed-out. The user must be logged in to Bluemix before running the container scripts.

**How to resolve**
Run the initenv.sh script again to log in to Bluemix and then run the failed script again.

### Administration DB, Live Update and Push Service show up as inactive	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
Administration DB, Live Update and Push Service show up as inactive or no runtimes are listed in the {{ site.data.keys.mf_console }} even though the **prepareserver.sh** script completed successfully.

**Explanation**  
It is possible that a either a connection to the database service did not get established or that a formatting problem occurred in the server.env file when additional values were appended during deployment.

If additional values were added to the server.env file without new line characters, the properties would not resolve. You can validate this potential problem by checking the log files for errors caused by unresolved properties that look similar to this error:

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**How to resolve**  
Manually restart the containers. If the problem still exists, check to see if the number of connections to the database service exceeds the number of connections provisioned by your database plan. If so, make any needed adjustments before proceeding.

If the problem was caused by unresolved properties, ensure that your editor adds the linefeed (LF) character to demarcate the end of a line when editing any of the provided files. For example, the TextEdit app on macOS might use the CR character to mark the end of line instead of LF, which would cause the issue.

### prepareserver.sh script fails	
{: #prepareserversh-script-fails }
The **prepareserver.sh** script fails and returns the error 405 Method Not Allowed.

**Explanation**  
The following error occurs when running the **prepareserver.sh** script to push the image to the IBM Containers registry.

> Pushing the {{ site.data.keys.mf_server }} image to the IBM Containers registry..  
> Error response from daemon:  
> 405 Method Not Allowed  
> Method Not Allowed  
> The method is not allowed for the requested URL.

This error typically occurs if the Docker variables have been modified on the host environment. After executing the initenv.sh script, the tooling provides an option to override the local docker environment to connect to IBM Containers using native docker commands.

**How to resolve**  
Do not modify the Docker variables (such as DOCKER\_HOST and DOCKER\_CERT\_PATH) to point to the IBM Containers registry environment. For the **prepareserver.sh** script to work correctly, the Docker variables must point to the local Docker environment.
