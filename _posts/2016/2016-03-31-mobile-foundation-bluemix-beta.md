---
title: Mobile Foundation Bluemix Service - Beta
date: 2016-03-31
tags:
- MobileFirst_Platform
- Bluemix
- Mobile_Foundation
version:
- 8.0
author:
  name: Ajay Chebbi
---
Last year IBM brought the IBM MobileFirst Platform server to Bluemix on docker containers. Today IBM introduce the next evolution in the journey - 
the beta release of a Bluemix Service called [“Mobile Foundation”](https://console.ng.bluemix.net/catalog/?search=mobile%20foundation) . Mobile Foundation will 
provision the next generation of the IBM MobileFirst Platform server V8.0 beta on a container group.

The Mobile Foundation Service asks a few basic questions and creates an evaluation server in an IBM Container Group in your Bluemix Org and Space. 
This server contains the following components:

1.	The MobileFirst Operations Console
2.	The MobileFirst Server
3.	Embedded Derby DB

You can start using the Mobile Foundation service in 2 modes:

1.	Quick start – gives you a default configuration with a 1G container plan
2.	Advanced Configuration – lets you pick your configuration from the get go

After you have instantiated the server by using either of the options, you can always go and make changes to the configuration and re-spin the container.

> Note: The Beta plan is free. After you have consumed the free allowance for Containers, you will be charged for the Container compute service. You can look up the pricing on the [Bluemix Pricing page](https://console.ng.bluemix.net/pricing/)

You can instantiate as many Mobile Foundation service instances as you choose. Each service instance is linked to a container group. You are limited only by the Container quota that you have in your Bluemix account. At the time of writing this blog – you get a default 2 GB container quota. 
If you need more Container space – you can request [more](mailto:id@bluemix.net).

## Mobile app capabilities 
The MobileFirst Server acts as a gateway for your mobile apps. You can have traffic to your business logic from your iOS, Android, or Windows mobile apps route through the MobileFirst Server to get several mobile specific capabilities. The MobileFirst Server by virtue of being the gateway to your business logic, and sometimes gateway to your enterprise becomes a central enforcement point. This is achieved by adding the MobileFirst SDK in your mobile app. The SDKs can be added by using Gradle for Android, CocoaPods for iOS nugget for Windows, and npm for Cordova WinJS apps. The Xamarin SDK is not available at the time of writing this post. You can learn more about the MobileFirst Platform Foundation Server [here](https://mobilefirstplatform.ibmcloud.com).

### App lifecycle management
Capabilities like sending a service message to the device or disabling an older version of the app can be achieved with no extra code on the app development side. By virtue of embedding the MobileFirst SDK, this capability is available. 

### App security
Application authentication is an important capability that prevents tampered apps connecting to the server. 

### Device and app Authentication
OAuth, cert-based auth etc.

### Secure storage
Quite sometimes there is a need for storing data on the phone, typically in offline use cases. This data needs to be stored securely to deal with cases when the device is stolen or compromised. MobileFirst SDK provides a capability called JSONStore. This store also has the capability of data synchronization. You can also use the Cloudant data synch SDK for the platforms it is available on.

### Unified Push notifications
Using push notifications needs a server that can store device registrations because you cannot send push messages to the phone. You send it to GCM for Android, APNS for iOS, and WNS for Windows. They in turn send it to the devices that you specify. Mobile Foundation provides easy configuration on the app side to register for the notifications and a unified API on the server to send notifications to all kinds of devices. 

## Business logic Integration use cases
IBM MobileFirst Platform Server on Bluemix enables a new dimension of use cases. This is sometimes referred to as back-end development, server-side development or enterprise integration. By making your business logic available only through the MobileFirst Server, you are enabling a single point of controlled access versus securing every back-end endpoint individually.  At the core of server-side development is a capability called “adapters”. Adapters are modules that are written in Java™ or JavaScript™ that run inside the MobileFirst Server. The REST endpoints exposed by these adapters can be called from the mobile app via the MobileFirst SDK added to the app.

```java 
WLResourceRequest wlResourceRequest = new WLResourceRequest(URI.create("/adapters/SocialWatsonAdapter/analyze"), WLResourceRequest.GET, socialLoginChallengeHandler.getSecurityCheck());
```
There are basically three ways of back-end business logic development enabled by Mobile Foundation. In your use case, you can use any or a mix of the following use cases. Subsequent blogs will do a deep dive with code examples into each of these use cases, and link them from here.

### Bluemix services
You can implement your entire backend by using Bluemix services. Bluemix provides a rich range of services such as Watson Cognitive, Strong loop, data storage, message bus, cloud foundry build packs like the .NET buildback, Node.js apps, docker containers, Java EE runtimes, and more. The business logic that you build on Bluemix can be not just for the mobile app, but a full blown cloud native business. The mobile app for this business can talk to this backend by using MobileFirst adapters. You will see some blog posts demonstrating this usecase(check back for links).

![Bluemix services]({{site.baseurl}}/assets/blog/2016-03-31-mobile-foundation-bluemix-beta/bluemix.png)

### Enterprise backend
You could have a system of records that exists inside the firewall of your enterprise. For this scenario, you would need to add an optional Bluemix service called VPN. VPN is a chargeable service. This service allows you to configure a secure tunnel from the MobileFirst containers to your enterprise. The adapter can access IP addresses inside your enterprise firewall through a gateway that is installed in your enterprise DMZ. This could be a custom backend or a database. MobileFirst Platform Foundation also provides readymade adapters to connect to popular systems like SAP or Siebel. You can read more about configuring VPN in this [blog post]({{site.baseurl}}/blog/2016/03/27/connecting-securely-from-ibm-mobilefirst-platform-foundation-on-bluemix-to-on-premises-systems/)

![enterprise backend services]({{site.baseurl}}/assets/blog/2016-03-31-mobile-foundation-bluemix-beta/enterprise.png)
    
### In-Adapter
This configurations is the simplest one. The entire business logic can reside inside the adapter code. This code can be algorithmic calculations or processing that does not need any persistence or call out to a specialized backend. Alternately, this code can also be leveraging other internet visible services that might be off the shelf like a stock ticker RSS feed or a custom service that you might already have on another cloud provider.  

![logic in adapter]({{site.baseurl}}/assets/blog/2016-03-31-mobile-foundation-bluemix-beta/inadapter.png)
    
The following video shows how to get a IBM MobileFirst Platform Server by using the Mobile Foundation service. You can then use the self-paced programming tutorials to explore the capabilities in detail.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/E85hZZTnW2w"></iframe>
    </div>
</div>