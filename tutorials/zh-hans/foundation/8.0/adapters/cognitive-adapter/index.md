---
layout: tutorial
title: 针对 Watson 认知服务的适配器
breadcrumb_title: Adapters for Watson services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

Watson on IBM Cloud 使您能够访问现今可用的最广泛范围的认知技术，以便快速安全地构建智慧的应用程序。分析图和视频以了解情绪以及从文本中抽取关键字和实体是 Watson 服务启用的部分功能。

Watson 在认知计算方面提供更多功能。 自然语言理解、视觉识别和发现可揭示非结构化数据中的洞察，能够改革运营和实现行业转型。 在[此处](https://www.ibm.com/watson/developercloud/)了解有关 IBM Cloud 上 Watson 认知服务的更多信息。

{{ site.data.keys.product }} 适配器用于执行任何必要的服务器端逻辑，并从后端系统检索信息并将信息传输到客户机应用程序和云服务。 {{ site.data.keys.product }} 现在为一些 Watson 认知服务提供适配器。

##  针对 Watson 服务的适配器
{: #watson-adapter}

{{ site.data.keys.product_full }} 自 [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) 起，为一些 Watson 认知服务提供开箱即用的适配器，如[对话](https://www.ibm.com/watson/developercloud/conversation.html)、[发现](https://www.ibm.com/watson/developercloud/discovery.html)和[自然语言理解](https://www.ibm.com/watson/developercloud/natural-language-understanding.html)。 可在 Mobile Foundation Console 中从**下载中心**下载这些适配器。

要使您的应用程序能够连接到 Watson 认知服务，请下载认知服务适配器并将其部署到 {{ site.data.keys.product_adj }} 服务器。 应用程序现在可以调用适配器 API 以调用 Watson 服务。

在部署适配器之后，对其进行配置以连接到 Watson 服务。 为此，请转至**适配器配置**页面，并在**适配器配置**页面内的_**用户名**_和_**密码**_字段中提供来自 Watson **服务凭证**的*用户名*和*密码*。

如果需要修改适配器，请从 github 存储库下载适配器源代码：<br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU（自然语言理解）**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
