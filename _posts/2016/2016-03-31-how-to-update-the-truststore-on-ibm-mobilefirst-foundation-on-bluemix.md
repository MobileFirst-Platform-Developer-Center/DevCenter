---
title: How to update the truststore in the Mobile Foundation service on Bluemix
date: 2016-03-31
tags:
- MobileFirst_Platform
- Bluemix
- Mobile_Foundation
version:
- 8.0
author:
  name: Sachin Nayak
---

**Note:** This procedure is no longer valid. Use the trust store capability in the MFP console for adding certificates for adapters to connect to backends.


If you've created a new truststore and use it while deploying the Mobile Foundation service on Bluemix, MobileFirst Server may fail to load the runtime.   
This is due to the missing default certificates in the truststore. You can avoid this by updating the existing truststore with additional certificates instead of overwriting it with a new one.

This blog post provides the steps to follow if you are trying to update the truststore in the IBM MobileFirst Platform Foundation on Bluemix, with additional certificates:

1. Install the Cloudfoundry command line tool (cf) and the "cf ic" plugin.
2. Login to the IBM container service using cf login and cf ic init commands.
3. Connect to the container using the command: `cf ic exec -it <container_id> bash`. You can find the container id using the `cf ic ps` command.
4. Copy the truststore.jks file to your system using the command: 

    ```bash
    cf ic exec -i <container_id> bash -c 'cat < /opt/ibm/wlp/usr/servers/mfp/resources/security/truststore.jks' > ./truststore.jks
    ```
    
5. Use the keytool command to import additional certificates into the truststore. The default password for this truststore is "worklight".

    You might want to backup the existing truststore.jks file before updating.

6. Redeploy the MobileFoundation instance from Bluemix UI using the updated truststore file in "Advanced Settings"
7. If mfp doesn’t restart or the runtimes don’t comeup after the update, connect to the container using the command: `cf ic exec -i <ContainerID> bash` and check the log files at: "/opt/ibm/wlp/usr/servers/mfp/logs/"
