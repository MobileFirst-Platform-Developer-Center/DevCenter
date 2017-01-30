---
title: Connecting securely from IBM MobileFirst Platform Foundation on Bluemix to on-premises systems
date: 2016-03-27
tags:
- MobileFirst_Platform
- Bluemix
- IBM_Containers
version:
- 7.1
author:
  name: Ajay Chebbi
---
> **Note:** This blog post refers to MobileFirst server running on IBM Containers. For instructions for MobileFirst server running on Liberty buildpacks and Mobile Foundation Bluemix service (which also runs on Liberty buildpack), pl refer to this [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2016/04/12/mobile-foundation-bluemix-configuration-with-onprem-analytics-server/)
 
You are already aware of the <a href="https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-7-1/bluemix/run-foundation-on-bluemix" target="_blank">IBM MobileFirst™ Platform Foundation</a> on IBM® Containers offering that allows you to take a locally developed MobileFirst project and run it on IBM Bluemix®. This article demonstrates how to securely connect from the IBM MobileFirst Platform Foundation on IBM Containers to an on-premises data center by using the <a href="https://www.ng.bluemix.net/docs/services/vpn/index.html" target="_blank">Virtual Private Network (VPN)</a> Service on IBM Bluemix.

The IBM VPN Service provides a secure communication channel between your data center and the resources that are running in the IBM Containers. You can configure IBM MobileFirst Platform Foundation to access the Systems of Record (SoR) data securely from the on-premises data center via MobileFirst adapters.

<h2>Create a VPN service instance</h2>
<ul>
	<li>Log in to the IBM Bluemix environment and create an instance of the IBM VPN Service. You can create one instance of this service per Bluemix space.</li>
	<li>On the <a href="https://www.ng.bluemix.net/docs/services/vpn/index.html" target="_blank">VPN Service console</a>, select the types of containers that you need to associate the VPN Service with - Single Container or Container Groups.</li>
	<li>Create a VPN Site Connection configuration by specifying the Gateway IP of your data center within the enterprise. You also need to configure the Customer Subnet and a pre-shared secret to establish the connection.</li>
</ul>

Your VPN service instance on Bluemix is now configured.

<h2>Configuration for the on-premises data center</h2>
You must now configure the on-premises data center to work with the IBM VPN Service on Bluemix. You can install any of the standard IPSec clients on the on-premises gateway. Detailed steps of configuration for various clients are provided <a href="https://www.ng.bluemix.net/docs/services/vpn/onpremises_gateway.html">here</a>.

When the on-premises data center and the IBM Bluemix VPN service are configured, a secure connection is established between the two endpoints. You can check the status of the connection either in the Bluemix VPN console or by executing <i>ipsec statusall </i>command on the data center.

<h2>Connecting to on prem systems from IBM MobileFirst Platform Foundation adapters</h2>
You can use the MobileFirst Studio or the MobileFirst Command Line Interface (CLI) to create MobileFirst adapters that can be deployed to the server. The adapters help to connect to the enterprise back-end system, and deliver data to or from the MobileFirst applications. The adapters can be built to connect either to a web-service or to a database available in the enterprise system. For more information, see <a href="https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_DevelopingTheServer-sideOfAnIBMWorklightApplication.html" target="_blank">building adapters, here</a>.

To connect from the adapter to the enterprise system securely through the VPN service, provide the private IP address of the system in the connection information of the adapter. You can now build and deploy the adapter on the container, and perform request invocation from the MobileFirst application. The MobileFirst Platform Foundation Container is now enabled to work with an on-premises system within the enterprise through the VPN service.