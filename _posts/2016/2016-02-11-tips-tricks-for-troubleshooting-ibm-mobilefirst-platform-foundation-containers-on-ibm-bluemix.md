---
title: 'Tips &amp; Tricks for troubleshooting IBM MobileFirst Platform Foundation Containers on IBM Bluemix'
date: 2016-02-11
tags:
- MobileFirst_Platform
- Bluemix
- IBM_Containers
version:
- 7.1
author:
  name: Krishna C Kumar
---

### MobileFirst Platform Foundation for IBM Bluemix Container - Starter

**1. How do I know if my running mobilefirst container is MobileFirstStarter or production copy ?**  
Only for MobileFirst starter container, by default the welcome page is available. User can reach the welcome page on the port 80. From web browser hit the url - <code>http://public_ip:80</code>. This ensures the running container is the built from the starter image.

**2. Can I add more runtimes to the MobileFirstStarter apart from default project runtime ?**  
No. MobileFirst Starter image comes with a default runtime. The image cannot be customized.

**3. Can I add additional applications and adapters to the running MobileFirst Starter container ?**  
Yes. With the default runtime available with the MobileFirst Container, one can add apps and adapters from the MobileFirst Administration Console.

**4. Is it possible to customize the MobileFirstStarter Image ?**  
No. For customizing capability one has to choose the MobileFirst Production image.

**5. Can I change the default ports (80, 9080, 9443) while creating the MobileFirst Starter container ?**  
No. MobileFirst Starter container supports only the default ports listed while creating the container from the IBM Bluemix Catalog.

**6. Public IP bound successfully to the container, but still the MobileFirst Administration Console is not reachable?**  
Wait for few minutes. Make sure the bound public IP is pingable. If the Administration console is still not reachable, please check the logs from the Logging and Monitoring menu associated with that particular container on the IBM Bluemix console.

**7. How can I debug the MobileFirst Starter container issues ?**  
Either you can download the complete logs from the welcome page and check or using the [Logmet service](https://logmet.ng.bluemix.net) (Kibana Dashboard).

**8. Can I use the CLI to work with the MobileFirst Starter?**  
Yes, one can certainly use the CF CLI commands to interact with the MobileFirst Starter container too.

### MobileFirst Platform Foundation for IBM Bluemix Containers - Production Image

**1. Do I need to install the IBM Container Extensions CLI (ICE) for working with IBM MobileFirst Production image?**  
No. The latest version of the IBM MobileFirst Production image uses the CF CLI and it doesn't require ICE CLIs.

**2. Why <code>CF IC </code>commands against the Bluemix Containers fail irrespective of my clean installation of the CLI tools?**  
Make sure you have the docker installed and then run from the terminal with the docker environment variables set.

**3. Can I add more runtimes to the MobileFirst Containers production image?**  
Yes. Any number of runtimes can be added to the production image.

**4. Pushing the customized MobileFirst Image for Production from my local workstation IBM Bluemix registry takes long time, Why?**  
Speed of push depends on the network between your local workstation and the bluemix registry.

**5. Why the added project runtimes are not being listed on the MFP Admin Console?**  
Following are to be ensured to make sure things are right in place


* Make sure the project runtimes are added to the **mfpf-server/usr/projects** folder and the <code>prepareserverdbs</code> script is ran before performing the push of the customized image.
* Check the generated runtime XMLs after running the <code>prepareserverdb</code> scripts - make sure the db credentials are correct and the host is reachable.


**6. When the runtime database is&nbsp; cloudantNOSQLDB, after running the <code>prepareserverdb</code> script the tables are not seen in the cloudantDB**  
This is an expected behavior. The database entries will be created only during the creation of the container when cloudant is used. &nbsp;

**6. Why did my MobileFirst container suddenly crash ?**  
Make sure the container size (memory) is set appropriately. By default 1024M is recommended, but depends on your usage it has to be increased. If memory is not the constraint, check the container logs and reach out to the Support team. Prior to that make sure the health of the containers are checked from the [IBM Bluemix status notifications page](http://status.ng.bluemix.net/.

**7. Even after 10 minutes of creation the MobileFirst Container is not moving to RUNNING state ?**  
Stages of the container are transitioned from <code>queued, building, running, networking</code> (private-ip), <code>running, networking</code>  (public-ip) and <code>running</code>. Make sure the health of the containers are checked from the [IBM Bluemix status notifications page](http://status.ng.bluemix.net/). If the problem persists send the output of the following commands to the support team.  

```bash
cf ic info  
cf ic ps -a  
cf ic inspect the-container-id
```

Also send the command used to create the mobile first container.

**8. How do I interactively get into the shell of the running container ?**  
<code>cf ic exec -it the-container-id "bash"</code>

**9. How can I view the logs of my MobileFirst Container ?**  
Following are the various ways

* [IBM Bluemix Logmet service](https://logmet.ng.bluemix.net) (Kibana dashboard)
* Getting into the container shell interactively from terminal and viewing the logs.

```bash
cf ic exec -it the-container-id "bash"
```

#### References:
 
 * [Access the containers from commandline](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/t_cli_for_container_logs.html?lang=en)
 * [SSH into the running container](http://www-01.ibm.com/support/knowledgecenter/api/content/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/t_ssh_for_container_logs.html?locale=en)
 * [Logging and Monitoring the MobileFirst Containers](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/r_log_monitor_containers.html?lang=en)

**10. Why is the logmet service not showing the MobileFirst specific logs?**  
Probably the logs volume is not mounted. When you create the container using the <code>startserver.sh</code> (or <code>startservergroup.sh</code>) script make sure the VOLUMES are enabled.

**For Additional Topics:**

Refer the IBM Knowledge center  [Troubleshooting](http://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/r_ts_containers.html?lang=en) of IBM MobileFirst Containers
