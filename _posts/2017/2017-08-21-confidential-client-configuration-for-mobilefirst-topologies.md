---
title: 'All about configuring Confidential Clients for IBM MobileFirst Platform'
date: 2017-09-03
tags:
- MobileFirst_Foundation
- Confidential Clients
version:
- 8.0
author: 
    name: Shinoj Zacharias
---

## Confidential Clients

Confidential clients are clients that are capable of maintaining the confidentiality of their authentication credentials. You can use the MobileFirst authorization server to grant confidential clients access to protected resources in accordance with the OAuth specification. This feature allows you to grant access to your resources to non-mobile clients, such as performance-testing applications, and any other kind of back-end that might need to request a protected resource, or use one of the Mobile Foundation REST APIs, such as the REST API for **push notifications**.

### Configure Confidential Clients

For MFP DevKit, there are three predefined confidential clients, namely ***admin, push*** and ***test***, that comes pre-deployed with MFP. The confidential clients with client id ***admin*** and ***push*** is internal to MFP and it's required for notification service to work. If these client ids are not available, then you will not be able to register an app with push service from MobileFirst Operation console and won't be able to send any push notification from Operations Console. Note that with MFP 8.0, when an app is registered with MFP, then the app will be automatically get registered with Push service. If there is some issue with registering confidential clients, ***admin*** and ***push***, then the app won't be getting registered with Push. 

![Predefined Confidential Clients in DevKit]({{site.baseurl}}/assets/blog/2017-08-21-confidential-client-configuration-for-mobilefirst-topologies/ConfidentialClientDevKit.png)

For MFP Production setup, when you use either Server Configuration Tool(SCT) or Ant tasks for creating the profile, you have an option to either install the push service or not.

***Note that only if you select the option to install Push service, the default confidential clients, admin and push, will be available in MobileFirst Server.*** 

When SCT is used to create a profile, you have an option to change the push and authorization url instead of using the default push and authorization server url. There is no option for you to rename the default predefined confidential clients. 

When Intall Ant task is used for creating a profile, you have the option to change the defaut push and authroization serverl url as well as renaming and changing the client name and credential of the predefined confidential clients.

***Note: The confidential clients ids should be unique across Administration Service and Push Service.***

### How does confidential clients get registered with MobileFirst Platform

 If you have installed MFP DevKit or have created a production setup with SCT or Ant tasks, with Push service enabled, then you can find the confidential clients JNDI properties from the server.xml. Note that for Cluster Setup (WAS ND), the confidential client JNDI properties can be found via the WAS console 

```
    <!-- Declare the JNDI properties for the MobileFirst Administration Service. -->
    <jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value='"http://localhost:${default.http.port}/imfpush"'/>
    <jndiEntry jndiName="mfpadmin/mfp.admin.authorization.server.url" value='"http://localhost:${default.http.port}/mfp"'/>
    <jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.id" value='"push"'/>
    <jndiEntry jndiName="mfpadmin/mfp.push.authorization.client.secret" value='"hsup"'/>
    <jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.id" value='"admin"'/>
    <jndiEntry jndiName="mfpadmin/mfp.admin.authorization.client.secret" value='"nimda"'/>

    <!-- Declare the JNDI properties for the MobileFirst Push. -->
    <jndiEntry jndiName="imfpush/mfp.push.authorization.server.url" value='"http://localhost:${default.http.port}/mfp/api"'/>
    <jndiEntry jndiName="imfpush/mfp.push.authorization.client.id" value='"push"'/>
    <jndiEntry jndiName="imfpush/mfp.push.authorization.client.secret" value='"hsup"'/>

```

During startup, MFP reads these JNDI properties and deploys the confidential clients. Subsequent restarts will check if the confidential clients id and passwords are different from that of deployed ones, if yes, then it redeploys the confidential clients with new values. If you want to change the default confidential clients properties after you have setup a production server or MFP Devkit, you can modify above JNDI properties values. If you are changing the confidential client values, make sure that the values for ***mfp.push.authorization.client.id*** and ***mfp.push.authorization.client.secret*** be same for both Adminstration Service and Push Service, otherwise push operations, eg: sending notifications etc, from Mobile Foundation Operations Console will not work. For WAS ND, you need to change the values via WAS console. The changes made will take effect only after the restart of the MFP server.

Apart from the pre-built confidential clients, you can add any number of confidential clients to allow a non-mobile client access the resoruces. 

If you are getting an error similar to the one shown below, then most common reaons for it is that the above JNDI properties are not defined or the values of
the above JNDI properties are incorrect, especially the ***mfp.admin.authorization.server.url*** and ***mfp.push.authorization.server.url*** properties, though the values for them looks same there is a difference in the url value, where ***mfp.push.authorization.server.url*** has an ***api*** at the end.

![Error in Push Setting Page in Operations Console]({{site.baseurl}}/assets/blog/2017-08-21-confidential-client-configuration-for-mobilefirst-topologies/ConfidentialClientError.png)

If you encounter the issue that is shown in the image above, there is a good chance that you can also see an exception similiar to this :

```
[8/16/17 10:00:54:696 IST] 0000023e com.ibm.mfp.admin.util.PushServiceUtil     E Unable to obtain OAuth Token for Push 
java.lang.NullPointerException
at com.ibm.mfp.admin.util.PushServiceUtil.getOAuthToken(PushServiceUtil.java:1396)
at com.ibm.mfp.admin.util.PushServiceUtil.injectOAuthToken(PushServiceUtil.java:1447)
at com.ibm.mfp.admin.util.PushServiceUtil.getPushHealthStatus(PushServiceUtil.java:224)
at com.ibm.mfp.admin.services.v2.DiagnosticService.getDiagnostic(DiagnosticService.java:271)
at sun.reflect.GeneratedMethodAccessor351.invoke(Unknown Source)

```

All these errors and exception indicate that the JNDI properties that are mentioned earlier are not configured properly or confidential clients are not registred with LDAP.

### Configure Confidential Clients to work with LDAP

You can configure MobileFirst administration security to enable connecting out to an external LDAP repository. When the LDAP repository configuration is enabled, you must add the confidential client ids to LDP registery. If the confidential clients are not registred with LDAP, then either you will not see the confidential clients registered with MFP server or you will get the same error that was shown in the previous image. Confidential client ids should be unique and that unique client id should be added to the LDAP registery.




