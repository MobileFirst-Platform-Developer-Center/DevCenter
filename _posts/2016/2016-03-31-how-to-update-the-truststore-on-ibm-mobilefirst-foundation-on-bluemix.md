---
title: How to update the truststore in the Mobile Foundation service on Bluemix
date: 2016-03-31
tags:
- MobileFirst_Platform
- Bluemix
- Mobile_Foundation
author:
  name: Idan Adar
---

If you've created a new truststore and use it while deploying the Mobile Foundation service on Bluemix, MobileFirst Server may fail to load the runtime.   
This is due to the missing default certificates in the truststore. You can avoid this by updating the existing truststore with additional certificates instead of overwriting it with a new one.

This blog post provides the steps to follow if you are trying to update the truststore in the IBM MobileFirst Platform Foundation on Bluemix, with additional certificates:

* Install the Cloudfoundry command line tool (cf) and the "cf ic" plugin.
* Login to the IBM container service using cf login and cf ic init commands.
* Connect to the container using the command: `cf ic exec -it <container_id> bash.`

    You can find the container id using the cf ic ps command.

* Copy the truststore.jks file to your system using the command: 

    ```bash
    cf ic exec -i <container_id> bash -c 'cat < /opt/ibm/wlp/usr/servers/mfp/resources/security/truststore.jks' > ./truststore.jks
    ```
* Use the keytool command to import additional certificates into the truststore. The default password for this truststore is "worklight".

    You might want to backup the existing truststore.jks file before updating.

* Redeploy the MobileFoundation instance from Bluemix UI using the updated truststore file in "Advanced Settings"
* If mfp doesn’t restart or the runtimes don’t comeup after the update, connect to the container using the command: `cf ic exec -i <ContainerID> bash` and check the log files at: "/opt/ibm/wlp/usr/servers/mfp/logs/"
