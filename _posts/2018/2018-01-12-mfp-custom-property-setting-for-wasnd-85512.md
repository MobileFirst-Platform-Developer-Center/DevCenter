---
title: Custom property setting needed for MobileFirst Foundation with WebSphere Application Server (WAS) ND version 8.5.5.12 and upwards
date: 2018-01-12
tags:
- MobileFirst_Platform
- Worklight
- WASND
version:
- 8.0
- 7.1
- 7.0
- 6.3
- 6.2
- 6.1
- 6.0
author:
  name: Vasanth Raghavan
---
This post describes an error seen with MobileFirst Foundation installation on WAS ND 8.5.5.12 and upward versions and the workaround to solve this issue. 

### Problem Description

Installation and configuration of MobileFirst foundation including WAS application server and database configurations are successful. Anyone, few or all of the following errors are displayed when logging in to the MobileFirst console after successful installation, configuration and restarting of the servers.

```bash
FWLSE3000E: A server error was detected.
FWLSE3002E: The resource is not found.
FWLSE3030E: The runtime "mfp" does not exist in the MobileFirst administration database. The database may be corrupted 

```

![MobileFirst Console error_1]({{site.baseurl}}/assets/blog/2018-01-12-mfp-custom-property-setting-for-wasnd-85512/mfp8-1.jpg)

![MobileFirst Console error_2]({{site.baseurl}}/assets/blog/2018-01-12-mfp-custom-property-setting-for-wasnd-85512/mfp8-2.jpg)

### Stack exceptions seen in trace

The trace shows the exceptions stack as below :

```bash
1/10/18 14:06:35:124 GMT] 00000070 WASRuntimeMBe 2 com.worklight.common.util.jmx.WASRuntimeMBeanHandler$AdminClientMBeanServerConnection getAttribute THROW
                                 java.lang.reflect.UndeclaredThrowableException
	at com.sun.proxy.$Proxy149.getAttribute(Unknown Source)
	at com.ibm.ws.management.AdminClientImpl.getAttribute(AdminClientImpl.java:153)
	at com.worklight.common.util.jmx.WASRuntimeMBeanHandler$AdminClientMBeanServerConnection.getAttribute(WASRuntimeMBeanHandler.java:499)
	at com.sun.jmx.mbeanserver.MXBeanProxy$GetHandler.invoke(MXBeanProxy.java:134)
	at com.sun.jmx.mbeanserver.MXBeanProxy.invoke(MXBeanProxy.java:179)
	at javax.management.MBeanServerInvocationHandler.invoke(MBeanServerInvocationHandler.java:269)
	at com.sun.proxy.$Proxy162.isReady(Unknown Source)
	
Caused by: [SOAPException: faultCode=SOAP-ENV:ServerException; msg=The Soap RPC call cannot be unmarshalled.]
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.handleAdminFault(SOAPConnectorClient.java:959)
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.invokeTemplateOnce(SOAPConnectorClient.java:924)
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.invokeTemplate(SOAPConnectorClient.java:689)
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.invokeTemplate(SOAPConnectorClient.java:679)
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.getAttribute(SOAPConnectorClient.java:634)
	at com.ibm.ws.management.connector.soap.SOAPConnectorClient.invoke(SOAPConnectorClient.java:490)
	... 56 more

	```

### Root cause and workaround

This problem is due to a WAS ND specific feature change in the fixpacks from version 8.5.5.12 and upwards for handling SOAP connections during communications. 

The following steps fix the issue:

* Navigate to the JVM Custom properties for the WAS ND server under:
**Application servers** -> `<Server name>` -> **Process Definition** -> **Java Virtual Machine** -> **Custom properties**.

* Click on **New** and add the following property with its value set to **true**.
  ```bash
     Name:  com.ibm.ws.management.connector.soap.disableSOAPAuthCheck          
     Value: true  
   ```

![WAS ND Console set custom property]({{site.baseurl}}/assets/blog/2018-01-12-mfp-custom-property-setting-for-wasnd-85512/mfp8-3.jpg)

In case of a WAS ND cluster, the above custom property should be set on the deployment manager and on all node agents. Restart your WAS ND servers, the error messages described above should not appear in the MobileFirst console.

>**Note:** This workaround is applicable for any version of MobileFirst foundation installed and configured with WAS ND version 8.5.5.12 and upwards.

