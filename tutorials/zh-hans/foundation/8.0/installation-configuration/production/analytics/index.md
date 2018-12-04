---
layout: tutorial
title: 安装和配置 MobileFirst Analytics Server
breadcrumb_title: Installing MobileFirst Analytics Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.mf_analytics_server }} 会以两个单独的 WAR 文件形式进行交付。 为便于在 WebSphere Application Server 或 WebSphere Application Server Liberty 上进行部署，{{ site.data.keys.mf_analytics_server }} 也以包含两个 WAR 文件的 EAR 文件形式交付。

> **注：**请勿在单个主机上安装多个 {{ site.data.keys.mf_analytics_server }} 实例。 有关管理集群的更多信息，请参阅 Elasticsearch 文档。

MobileFirst Server 安装中随附了分析 WAR 和 EAR 文件。 有关更多信息，请参阅 MobileFirst Server 的分布结构。 部署 WAR 文件时，可通过 `http://<hostname>:<port>/analytics/console`（例如，`http://localhost:9080/analytics/console`）访问 MobileFirst Analytics Console。

* 有关如何安装 {{ site.data.keys.mf_analytics_server }} 的更多信息，请参阅《[{{ site.data.keys.mf_analytics_server }} 安装指南](installation)》。
* 有关如何配置 IBM MobileFirst Analytics 的更多信息，请参阅《[配置指南](configuration)》。
