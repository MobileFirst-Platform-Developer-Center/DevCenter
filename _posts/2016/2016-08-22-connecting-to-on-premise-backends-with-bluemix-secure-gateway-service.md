---
title: Connecting Securely from MobileFirst Foundation on Bluemix to on-premises systems using the Secure Gateway service
date: 2016-08-22
tags:
- Bluemix
- Mobile_Foundation
- Mobile_Foundation_Service
- MobileFirst_Foundation
- Secure_Gateway
version:
- 8.0
author:
  name: Aparna Seshadri
---
## Introduction
You can setup MobileFirst Foundation on Bluemix in two ways:

1.	[Using the Mobile Foundation service on Bluemix](https://console.bluemix.net/catalog/services/mobile-foundation)
2.	[Using IBM-provided scripts downloaded from IBM passport advantage using your on-premise License entitlement](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts/)

When you build enterprise mobile apps, you often want to integrate your apps with existing systems of record. If you are building your mobile app on Bluemix, using the MobileFirst Foundation Service running on a Liberty for Java runtime, and you want to leverage data stored in your on-premise data center, you can use the Secure Gateway service to establish a secure connection between the two. The Secure Gateway service provides secure connectivity, and establishes a tunnel between your Bluemix organization, and the remote location that you want to connect to.

This blog explains how to access endpoints in your on-premise data center from MobileFirst Foundation Adapters running on Bluemix, using the Secure Gateway service.

  ![Architecture Diagram]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/architecture_diagram.png)

### Prerequisties
Let us assume that you already have a HTTP endpoint in the on-premises environment within the enterprise firewall that exposes the Systems of Record data. We will cover on how to configure the Mobile Foundation service to access this data via a MobileFirst HTTP adapter running on Bluemix.

## Configuring  Secure Gateway service instance
[Secure Gateway service](https://console.ng.bluemix.net/docs/services/SecureGateway/secure_gateway.html) provides secure connectivity from Bluemix to other applications and data sources running in on-premise environment.

- Log into Bluemix environment and create an instance of the [Secure Gateway service](https://new-console.ng.bluemix.net/catalog/services/secure-gateway/) instance. You can create one instance of the service per Bluemix space.

  ![Secure Gateway service image]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/secure_gateway_service.png)

- In the Secure Gateway service console, click on “**Add Gateway**” option to create a new gateway by providing any gateway name.

  ![Add Gateway]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/addgateway.png)

- Select the "MyCompanyGateway" that you just created & Click on “**Add Destination**” to configure the on-premise endpoint.

    The Secure Gateway service allows you to either connect to an on-premises endpoint from Bluemix environment or from an on-premises environment to a Cloud resource. For this scenario, select On-premises as the resource location and provide host name / IP and port of the on-premises resource. Also, provide any destination name of your choice.

  ![Destination Configuration]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/destination_configuration.png)

- The Secure Gateway service is now configured.

## Configuring the Secure Gateway Client in On-premises environment
For the Secure Gateway service on Bluemix to talk to your on-premise network, a Gateway client has to be installed in your on-premises network. There are three different options to run the Secure Gateway client – either via an installer, a container running on Docker runtime or on IBM Datapower.

![Secure Gateway Client]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/secure_gateway_client.png)

- You can use any of the client of your choice and run the Secure Gateway client on your on-premises environment. The steps to setup the secure gateway client is available in the Secure gateway console.

- For this blog, we will use the Docker container option to run the Secure Gateway client. Follow the below steps :

  - Install Docker on your on-premise machine.
  - Launch a terminal and run the Secure Gateway client on a container using the command shown in the service console.

        `docker run –it ibmcom/secure-gateway-client <gatewayId>`

        gatewayId can be obtained from the console as shown above.

- Once the client is setup, the Secure Gateway console will reflect the connection status.

  ![Secure Gateway Client connected]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/gateway_client_connected.png)

- To enable the request to be forwarded from the Secure Gateway client to the resource endpoint, you would need to add the resource to the access list.

    Run the following command on the terminal of the Secure Gateway client (running as container on Docker runtime, in this scenario) to add the resource to access list.

        `acl allow <resourceHost>:<resourcePort>`

    resourceHost and resourcePort refers to the details of the on-premise resource endpoint.

- The destination is now configured. Secure Gateway service will populate Cloud host and port details which can be used to access the on-premises resource from the cloud environment.

  ![Cloud host configuration]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/cloud_host_configuration.png)

- Make a note of the Cloud host and port details to use it in the MobileFirst adapter in the next step.

## Configuring Mobile Foundation service and MobileFirst Adapter
For this blog post, we will use Mobile Foundation service on Bluemix to configure the MobileFirst server. The [Mobile Foundation service](https://new-console.ng.bluemix.net/catalog/services/mobile-foundation) on Bluemix helps to provision the IBM MobileFirst server on a Liberty runtime as a Cloudfoundry application. The Mobile foundation service allows you to take any MobileFirst project developed on a local environment and run it on IBM Bluemix.

- Create an instance of the [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) from the Bluemix console.

- From the Mobile Foundation service console, [create the MobileFirst](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/using-mobile-foundation/) server.

- You can use the MobileFirst command line interface to create the MobileFirst adapters that can be deployed to the server. The adapters help to connect to the enterprise back-end system, and deliver data to the mobile apps.

- For this scenario, we will connect to the secure gateway endpoint using a HTTP Adapter. For more information, see [building adapters here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/).

- Deploy the HTTP adapter onto the MobileFirst server created on Bluemix using the Operations console.

- Provide the Cloud host and port details from the previous section as the resource endpoint in the HTTP Adapter.

  ![Adapter configuration]({{site.baseurl}}/assets/blog/2016-08-22-connecting-to-on-premise-backends-with-bluemix-secure-gateway-service/adapter_configuration.png)

- The MobileFirst adapter is now configured and the Mobile Foundation service is now enabled to work with an on-premises system within the enterprise through the Secure Gateway service.

- You can connect to multiple on-premises endpoints by configuring multiple destinations on the Secure Gateway service and deploying MobileFirst adapters to connect to the respective cloud host of the endpoint.
  You can also configure the Secure Gateway service with additional security to ensure communication to the endpoint happen over HTTPS and application-side security. You can find [more details here](https://new-console.ng.bluemix.net/docs/services/SecureGateway/sg_overview.html#sg_overview).
