---
title: Steps to configure Mobile Foundation Service to connect to on-premises Analytics server
date: 2016-04-12
tags:
- MobileFirst_Platform
- Mobile_Foundation
- Mobile_Foundation_Service
- Bluemix
- IBM_Containers
version:
- 8.0
author:
  name: Sumant Kulkarni
---
> **Note:** This blog post refers to MobileFirst server running on IBM Containers. For instructions for MobileFirst server running on Liberty buildpacks and Mobile Foundation Bluemix service (which also runs on Liberty buildpack), pl refer to this [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/22/connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/)

This blog talks about configuring MobileFirst Server running in Bluemix to connect to an analytics server running on-premises.

The [Mobile Foundation service on Bluemix](https://console.bluemix.net/catalog/services/mobile-foundation) allows you to deploy and run your MobileFirst-based applications on the Bluemix environment. It is a common scenario that the MobileFirst projects would need to access the resources that are running in the enterprise system within your corporate network. In this case, MobileFirst Analytics server is residing in the enterprise system to which the MobileFirst Server on the Bluemix should be configured to report the analytics data.

To establish the connectivity between the MobileFirst Server on Bluemix and the enterprise system,  you will configure the IBM Virtual Private Network (VPN) service to setup a virtual network. The VPN service on Bluemix is built on IPSec security standards and provides a secure communication channel between your data center and the resources running in the IBM Containers. In other words VPN is used as gateway between MFP Server and the analytics server which is sitting behind the enterprise firewall.

Below is the architecture of a typical setup :

![MFP Bluemix with on-premises analytics server ]({{site.baseurl}}/assets/blog/2016-04-12-mobile-foundation-bluemix-configuration-with-onprem-analytics-server/MFPwithAnalytics.png)

The following steps are to be performed in order to configure your analytics server which is on-premises with the Mobilefirst Server on Bluemix.

1.  Create an instance of analytics server on on-premises machine.

2. Create an instance of the VPN service and configure the VPN service using the service console. Note: Atleast one container needs to be running in the Bluemix space to configure the VPN gateway. Create a simple IBM container using ibmliberty image, if there are no containers in your space.

3. Install a suitable IPSec compliant VPN client on your on-premises gateway machine. You would then need to configure the VPN client on the on-premises gateway to connect with the VPN service on Bluemix. Make sure that the data center running the analytics service is reachable from the VPN gateway machine using the private network. It should be in the same subnet as gateway machine.

4. Create an instance of MobileFirst Server on Bluemix using Mobile Foundation
 service offering and configure the details of the analytics server.

## Configuring the VPN service

1. Create an instance of the VPN service. You can create the service instance by selecting the VPN service option under the Network category of the Bluemix catalog.

2. Open the VPN service console to configure the service. Firstly, create a VPN Gateway. Once the VPN Gateway is created, you can configure the VPN service to allow enterprise access for either Single Containers or Container Groups or both in the space.

3. Make a note of the IBM Gateway IP that will be created. This will be used in the later steps.

4. Next, create a VPN Site Connection. You should populate the following properties:
    1. Name: A name for the site connection
    2. Description: (Optional) A description of the site connection
       Preshared Key String: A secret key that will be used for authentication during connection setup.
    3. Customer Subnet: The subnet address of the enterprise network to  which the VPN service enables access to. The value should be in the CIDR format.
    4. Customer Gateway IP: The IP Address of the Gateway machine in your enterprise. This will be the machine where the VPN client will be installed in the next steps.

## Configuring the on-premises Gateway machine

Install a IPSec compliant VPN client on your enterprise gateway. The steps to configure the gateway client is explained here based on the VPN client you choose. Once the setup is completed, you can verify the connection status from the VPN service console.

Ensure that the IBM container on which your MFP server is residing can access the gateway machine using its private IP. You can verify this by logging into the container using the cf ic exec command and pinging the gateway machine. If the connectivity fails, the VPN service needs to be configured properly.

Once the VPN has been configured by following the above steps, the traffic coming from IBM container should be directed to the to the analytics server machine via the VPN gateway machine. This can be done by the running the following commands on the analytics server machine

ip route add 172.30.0.0/16 via <VPN Gateway machine ip>

In order to setup request forwarding from gateway machine to containers and on-premise machines we have to execute following command in the VPN gateway machine

 sysctl -a | grep ip_forward, if the result is zero,then execute the following command.
sysctl -w net.ipv4.ip_forward=1

If the result is 1, then port forwarding is already configured

After performing the above steps, the analytics server in the enterprise network is accessible from the IBM container.


## Creating an instance of the Mobile Foundation service on Bluemix

1.  Login to the Bluemix console and create an instance of the Mobile Foundation service from the Catalog.

2.  Open the Mobile Foundation service dashboard, choose “Start server with Advance Configuration”.
![MFP Bluemix start server with advance settings ]({{site.baseurl}}/assets/blog/2016-04-12-mobile-foundation-bluemix-configuration-with-onprem-analytics-server/StartServer.png)

3. Go to the server configuration tab ,where you can find the JNDI Configuration options
![MFP Bluemix JNDI properties ]({{site.baseurl}}/assets/blog/2016-04-12-mobile-foundation-bluemix-configuration-with-onprem-analytics-server/Jndiproperties.png)

4.  Click on the “Copy from Sample” button which would give you a sample JNDI properties.

5. Add the following properties with suitable values which corresponds to the analytics server.

    ```
    <jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value="http://10.162.22.162:9080/analytics-service/rest/data"/>
    <jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value="http://10.162.22.162:9080/analytics/console"/>
    <jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.username" value="admin"/>
    <jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.password" value="admin"/>

    ```

6. Click on “Start Advanced Server” option to create a MobileFirst Server.

This should be create you a MobileFirst Server instance with analytics server configured.  
You can login to the Operations console and ensure that it is accessible.

The configuration of on-premises analytics server to the MobileFirst Server on Bluemix can be verified by adding sample adapter or by registering app on MFP server and checking the analytics data on the analytics server.
