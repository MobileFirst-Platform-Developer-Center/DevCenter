---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Cloud 上的 IBM Mobile Foundation
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **注：***IBM Bluemix 现在位于 IBM Cloud 上。 要了解更多信息，请参阅[此处](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/)。*

## 概述
{: #overview }
{{ site.data.keys.product_full }} 可在 IBM Cloud 上托管。 以下是有关 IBM Cloud 的一些基本信息。

IBM Cloud 是 IBM 的开放云架构的实现。 它利用 Cloud Foundry 来支持开发人员快速构建、部署和管理其云应用程序，同时利用可用服务和运行时框架的不断增长的生态系统。

> 在[此处](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview)了解有关 IBM Cloud 架构和 IBM Cloud 概念的更多信息。

### 它如何运作？
{: #how-does-it-work }
简而言之，根据许可权利的类型，有两种在 IBM Cloud 上运行 {{ site.data.keys.product }} 的方式。

> **注：***现在不推荐使用 IBM Containers 服务，因此在 IBM Containers 上不支持 Mobile Foundation。 [了解更多信息](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/)。*

* IBM Cloud 预订或 PayGo 许可证：{{ site.data.keys.mf_bm_full }} 服务
* 本地许可证：使用 IBM 提供的脚本在 Kubernetes 集群或 Liberty for Java 运行时上设置 {{ site.data.keys.product_full }} 的实例。

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

要在 IBM Cloud Liberty for Java 运行时上运行 {{ site.data.keys.product}}，需使用以下组件：**Cloudfoundry 应用程序**，其中包含 **WebSphere Liberty 安装**，并部署了一个 **{{ site.data.keys.mf_server }} 实例**。

### IBM Cloud 上的 Kubernetes 集群
Kubernetes 是一种用于在计算机集群上调度应用程序容器的编排工具。 借助 Kubernetes，开发人员能够通过利用容器的功能和灵活性来快速开发高可用性应用程序。
您可以使用 Kubernetes CLI 来创建和管理自己的 Kubernetes 集群。

[了解有关 IBM Cloud 上的 Kubernetes 集群的更多信息](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Liberty for Java 运行时
{: #liberty-for-java-runtime }
Liberty for Java 运行时由 liberty-for-java buildpack 给予支持。 liberty-for-java buildpack 为基于 WebSphere Liberty 概要文件运行应用程序提供了完整的运行时环境。 随后可使用命令行界面在 IBM Cloud 上管理应用程序。

[了解有关 Liberty for Java 的更多信息](https://console.bluemix.net/docs/runtimes/liberty/index.html)。


## 后续教程
{: #tutorials-to-follow-next }

* [使用 IBM 提供的脚本](mobilefirst-server-on-kubernetes-using-scripts/)在 IBM Cloud 中的 Kubernetes 集群上创建 {{ site.data.keys.mf_bm_short }} 实例。
* 使用教程[设置 {{ site.data.keys.mf_bm }} 服务](using-mobile-foundation/)创建 {{ site.data.keys.mf_server }} 实例。
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* [使用 IBM 提供的脚本](mobilefirst-server-using-scripts-lbp/)在 IBM Cloud 上创建 {{ site.data.keys.mf_server }} 实例（使用 Liberty for Java）。
