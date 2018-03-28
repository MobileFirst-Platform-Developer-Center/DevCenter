---
layout: tutorial
title: Adapters for Watson cognitive services
breadcrumb_title: Adapters for Watson services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

Watson on IBM Cloud, provides you with access to the widest range of cognitive technologies available today to quickly and securely build smart applications. Analyzing images and video to understand sentiment, extracting keywords and entities from text are some of the capabilities enabled by Watson services.

Watson offers much more when it comes to cognitive computing. Natural Language Understanding, Visual Recognition, and Discovery reveal insights from unstructured data capable of reinventing operations and transforming industries. Learn more about Watson cognitive services on IBM Cloud [here](https://www.ibm.com/watson/developercloud/).

{{ site.data.keys.product }} adapters are used perform any necessary server-side logic, and to transfer and retrieve information from back-end systems to client applications and cloud services. {{ site.data.keys.product }} now provides adapters for some of the Watson cognitive services.

##  Adapters for Watson services
{: #watson-adapter}

{{ site.data.keys.product_full }} starting with [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) provides out of the box adapters for some of the Watson cognitive services such as [Conversation](https://www.ibm.com/watson/developercloud/conversation.html), [Discovery](https://www.ibm.com/watson/developercloud/discovery.html) and [Natural Language Understanding](https://www.ibm.com/watson/developercloud/natural-language-understanding.html). These adapters are available for download from the **Download Center** in the Mobile Foundation Console.

For your application to be able to connect to the Watson cognitive service, download the cognitive service adapter and deploy the adapter to {{ site.data.keys.product_adj }} server. Application can now call the Adapter API to invoke the Watson service.

After the adapter is deployed, configure it to connect to the Watson service. To do this, go to the **Adapter Configuration** page and provide the *username* and *password*, from the Watson **Service Credentials**, in the _**username**_ and _**password**_ field in the **Adapter Configuration** page and save the configuration.

If you need to modify the adapter, download the adapter source code from the github repository:<br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU (Natural Language Understanding)**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
