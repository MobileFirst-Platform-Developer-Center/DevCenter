---
title: Mobile Foundation rollout to all Bluemix regions complete
date: 2016-08-07
tags:
- MobileFirst_Foundation
- Bluemix
- Mobile_Foundation
version:
- 8.0
author:
  name: Ajay Chebbi
---

In Q1 2016 we announced the [beta](https://mobilefirstplatform.ibmcloud.com/blog/2016/03/31/mobile-foundation-bluemix-beta/) of the [Mobile Foundation Bluemix service](https://mobilefirstplatform.ibmcloud.com/blog/2016/03/31/mobile-foundation-bluemix-beta/) . After a successful conclusion of the beta that saw several customers try the service, we rolled in the feedback and released the GA version of the service in the public Bluemix US-SOUTH and UNITED KINGDOM regions. Thank you if you participated in the beta and gave us your feedback! Now we go down under to public Bluemix SYDNEY region. Ow ya goin mate! This completes the rollout to all the public Bluemix regions that are active at the moment.
![regions]({{site.baseurl}}/assets/blog/2016-08-08-mobilefoundation-rollout-complete/regions.png)

At the time of the launch, the Mobile Foundation service is rolled out with 2 plans. 

1.	Developer Plan – This is a plan intended for development work – low cost, create many of these and test your Mobile app. You can deploy as many apps and adapters in it. This comes with a non-persistent DB – and only a single node topology. This means if you make any changes to the settings and re-create the server – you have to re-deploy your apps and adapters. So certainly not suitable for production usage. 
2.	Professional 1 app plan – This plan comes with an ability to connect to a dashDB Transactional database service. You will have to go buy the service from the bluemix catalog, and make sure you pick one of the “Transactional” plans. Here you can deploy 1 mobile app and unlimited number of adapters. This is ideally suited for production workloads as the apps and adapters and other settings are persisted in the dashDB and re-creating the server will load all your settings back. 

> Note: The plan details and number of plans are subject to change in the future.

## Deployment topology
In production, we strongly recommend you deploy at least 3 nodes. 
![3 Nodes]({{site.baseurl}}/assets/blog/2016-08-08-mobilefoundation-rollout-complete/3nodes.png)
This way the server group is resilient to any underlying fabric changes. If one node is affected, the other 2 continue to serve the requests.
The Mobile Foundation Service asks a few basic questions and creates a server in a Liberty for Java runtime build pack Cloud Foundry application (or Liberty for Java for short) in your Bluemix Org and Space. 
![LBP]({{site.baseurl}}/assets/blog/2016-08-08-mobilefoundation-rollout-complete/lbp.png)
This is a change from the beta and the GA version up until now. The service used to create a IBM Container before – but now it uses Liberty for Java runtme. However as a cloud service user you should not be worried about the underlying deployment architectures. The one difference you will notice is how much it costs you for the compute. At the time of publishing this blog post the Liberty for Java runtime is at $0.07 USD / GB-Hour and Containers is at $0.0288 USD / GB-Hour. You can see the pricing at the Bluemix [pricing calculator](https://new-console.ng.bluemix.net/pricing/) 

This Mobile Foundation server contains following components

1.	The MobileFirst admin Console
2.	The MobileFirst runtime server

You can start using the Mobile Foundation service in 2 modes

1.	Quick start – gives you a default configuration with a 1G plan
2.	Advanced Configuration – lets you pick your configuration from the get go

After you have instantiated the server using either of the options, you can always go and make changes to the configuration and re-start the server.
Note: After you have consumed the free allowance for Liberty for Java, you will be charged for the compute service. You can look up the pricing on the [pricing calculator](https://console.ng.bluemix.net/pricing/)
You can instantiate as many Mobile Foundation service instances as you choose. Each service instance is linked to a Liberty for Java runtime instance. You are limited only by the Cloud Foundry quota for your Bluemix account. At the time of writing this blog – you get a default 2 GB Cloud Foundry app quota. If you need more Container space – you can [request more](mailto:support@bluemix.net).

## Database for production
When using a Provessional 1 app plan, you will be prompted to specify a dash DB service to use. 
![DB Selection]({{site.baseurl}}/assets/blog/2016-08-08-mobilefoundation-rollout-complete/dbselection.png)
You will need a [dashDB Bluemix service](https://new-console.ng.bluemix.net/catalog/services/dashdb/) you have to purchase for setting up a production ready system. Mobile Foundation needs one of the OLTP plans labelled as “Enterprise for Transactions”. We recommend that you go with one of the High availability plans in production. 
Just to note – you can use the same dashDB instance for setting up a development / test system on the Professional plan. But you have to be mindful of what kind of a load are the other instances putting on the DB and will it affect the production workload. Should you need a separate DB instance that your developers may want to share – you can use the non HA dashDB Transactional plan and share it among the dev and QA teams. This is very much the case when enterprise security policies dictate that the production workload systems be segregated from regular development and test usage. 

## Applying server upgrades
Whenever an update is available to the MF server, you will see a notification in the dashboard that an update is available.  You can choose to apply the update whenever your production workloads allow since there will be a couple of minutes of disruption to the server while the update is applied. This being a service, you do not have the ability to apply your own test fix jar files. If you are an on-prem software person, this was a common thing. Now we don’t want you to worry what release software or the components are running under the hood. 
![Update notification]({{site.baseurl}}/assets/blog/2016-08-08-mobilefoundation-rollout-complete/update.png)
