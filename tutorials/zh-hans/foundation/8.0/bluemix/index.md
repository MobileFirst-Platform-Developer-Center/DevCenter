---
layout: tutorial
breadcrumb_title: Foundation on Bluemix
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 可在 Bluemix 上托管。以下是有关 Bluemix 的一些基本信息。

IBM Bluemix 是 IBM 的开放云架构 (Open Cloud Architecture) 的实现。它利用 Cloud Foundry 来支持开发人员快速构建、部署和管理其云应用程序，同时利用可用服务和运行时框架的不断增长的生态系统。

> 通过 [Bluemix Web 站点](https://console.ng.bluemix.net/docs/overview/whatisbluemix.html#bluemixoverview)了解有关 Bluemix 架构和 Bluemix 概念的更多信息。

### 它如何运作？
{: #how-does-it-work }
简而言之，根据许可权利的类型，有两种在 Bluemix 上运行 {{ site.data.keys.product }} 的方式。

* Bluemix 预订或 PayGo 许可证：{{ site.data.keys.mf_bm_full }} 服务
* 本地许可证：使用 IBM 提供的脚本在 IBM Containers 或 Liberty for Java 运行时上设置 {{ site.data.keys.product_full }} 的实例。

要在 Bluemix IBM Containers 上运行 {{ site.data.keys.product }}，多个组件必须彼此进行交互：第一个组件是 **image**，其中包含 **Linux 分发版，此分发版中安装有 WebSphere Liberty**，并部署了一个 **{{ site.data.keys.mf_server }} 实例**。随后，此映像存储于 **IBM Container** 内，此 IBM Containers 由 **Bluemix** 进行管理。

要在 Bluemix Liberty for Java 运行时上运行 {{ site.data.keys.product}}，需使用以下组件：**Cloudfoundry 应用程序**，其中包含 **WebSphere Liberty 安装**，并部署了一个 **{{ site.data.keys.mf_server }} 实例**。

### Bluemix 上的 Kubernetes Cluster
Kubernetes 是一种用于在计算机集群上调度应用程序容器的编排工具。借助 Kubernetes，开发人员能够通过利用容器的功能和灵活性来快速开发高可用性应用程序。
您可以使用 IBM Bluemix Container Service CLI 或 Kubernetes CLI 来创建或管理自己的 Kubernetes 集群。

[了解有关 Bluemix 上的 Kubernetes Cluster 的更多信息](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

### IBM Container
{: #ibm-containers }
IBM Containers 是用于在托管云环境内运行映像的对象。IBM Containers 可保存应用程序运行所需的一切。

IBM Containers 基础结构包含针对映像的专用注册表，以便您可以上载、存储和检索这些映像。您可以使用 Bluemix 来管理这些映像。随后可使用命令行界面在 Bluemix 上管理容器 - 在以下教程中提供了有关于此的更多信息。

[了解有关 IBM Containers 的更多信息](https://www.ng.bluemix.net/docs/containers/container_index.html)。

### Liberty for Java 运行时
{: #liberty-for-java-runtime }
Liberty for Java 运行时由 liberty-for-java buildpack 给予支持。liberty-for-java buildpack 为基于 WebSphere Liberty 概要文件运行应用程序提供了完整的运行时环境。随后可使用命令行界面在 Bluemix 上管理应用程序。

[了解有关 Liberty for Java 的更多信息](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html)。


## 后续教程
{: #tutorials-to-follow-next }

* 在 Bluemix 上创建 {{ site.data.keys.mf_bm_short }} 实例[使用 IBM 提供的脚本](mobilefirst-server-using-kubernetes/)使用 Kubernetes Cluster。
* 创建 {{ site.data.keys.mf_server }} 实例[使用 {{ site.data.keys.mf_bm }} 服务](using-mobile-foundation/)。
* 在 Bluemix 上创建 {{ site.data.keys.mf_server }} 实例[使用 IBM 提供的脚本](mobilefirst-server-using-scripts/)使用 IBM Container。
* 在 Bluemix 上创建 {{ site.data.keys.mf_server }} 实例[使用 IBM 提供的脚本](mobilefirst-server-using-scripts-lbp/)使用 Liberty
