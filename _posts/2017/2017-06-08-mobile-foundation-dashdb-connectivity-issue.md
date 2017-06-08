---
title: 'Database Connectivity issues on IBM MobileFoundation because of a security update to dashDB for Transactions service'
date: 2017-06-08
tags:
- MobileFirst_Foundation
- Bluemix
- dashDB
version:
- 8.0
author:
  name: Prashanth Bhat
---
## Overview:

**IBM MobileFirst Foundation**  requires **dashDB for Transactions** service as the database.  
The **dashDB for Transactions** service is rolling out a security update, which can cause connectivity issues on IBM Mobile Foundation. 

## Symptoms:

If your **Mobile Foundation**, on Bluemix, setup has been working all along, and if you all of a sudden start seeing the errors as described below, then the possible reason could be that the **dashDB for Transactions** service has been updated with the security update. 

Look for the following symptoms:   

*  Mobile devices may face issues connecting to the Mobile Foundation server  
*  If you navigate to the Mobile Foundation Operations Console ( `https://<hostname>/mfpconsole` ) , then you may see the _*Monitoring*_ section as _*Inactive*_ and the following messages:  
   `FWLSE3000E: A server error was detected.`  
   `Unable to open database.`  
* If you retrieve the _*messages.log*_ file from your existing Mobile Foundation Cloud Foundry (CF) application instance, you may see errors such as below:  

    ```xml
    Error location: T4Agent.sendRequest() - flush (-1). Message:    
    Received fatal alert: handshake_failure. ERRORCODE=-4499, SQLSTATE=08001 DSRA0010E: SQL State = 08001, Error Code = -4,499    
    [err] java.sql.SQLNonTransientException: [jcc][t4][2030][11211][4.13.80] A communication error occurred during operations on the connectionís underlying socket, socket input stream,    
    [err] javax.net.ssl.SSLHandshakeException: Received fatal alert: handshake_failure    
     ```  

*If you see the above symptoms, your dashDB instance may have been updated recently. To fix the problem, you have to update your Mobile Foundation setup on Bluemix*

## Update your Mobile Foundation instances:

### If you are using Mobile Foundation Bluemix service instances  

If you are using [Mobile Foundation service] (https://new-console.ng.bluemix.net/catalog/services/mobile-foundation/), then follow these steps to update the service instance:  

1. Navigate to the Bluemix console on your browser, and login to the Organization and Space where you have created the Mobile Foundation Service.
2. Click the **Mobile Foundation service** from the **Services** section, as shown in the image:! 
  [bluemix-homepage]({{site.baseurl}}/assets/blog/2017-06-08-mobile-foundation-dashdb-connectivity-issue/MobileFoundationService.png)  
3. You should see an *Info Notification* indicating an update. Click on *Recreate* button to get the latest changes on your Mobile Foundation instance.  
  ![mobile-foundation-recreate]({{site.baseurl}}/assets/blog/2017-06-08-mobile-foundation-dashdb-connectivity-issue/MobileFoundationRecreate.png)  


### If you have created Mobile Foundation instance on Bluemix using IBM-provided scripts  

If you have deployed Mobile Foundation on Bluemix using IBM-provided scripts that come with your on-Prem License entitlement, you have to apply the latest Mobile Foundation iFix. You can download the latest  from  [Fix Central](https://www-945.ibm.com/support/fixcentral)  

>**Note:** Downloading the iFix requires entitlement.  

**If you are on Mobile Foundation V8.0:**  
The latest iFix available at the time of publishing this document is `8.0.0.0-MFPF-IF201706052216`  

Follow the instructions available in this [document](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts-lbp/#applying-mobilefirst-server-fixes) to apply Mobile Foundation server iFixes.

** If you are on Mobile Foundation V7.1:**  
The latest iFix available at the time of publishing this document is `7.1.0.0-MFPF-IF201706081107`  

Follow the instructions available in this [document](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/t_apply_interim_fix.html) to apply Mobile Foundation server iFixes.

## Cause

There has been a recent security update in the IBM dashDB for Transactions Bluemix service. 
Details of the dashDB update is [available here](http://www-01.ibm.com/support/docview.wss?uid=swg22001150)  
Existing applications which connect to dashDB may get `ssh handshake` errors because of the update.
The latest Mobile Foundation service update as well as the latest iFix on Mobile Foundation modify the driver used to the latest driver to fix the issue.
