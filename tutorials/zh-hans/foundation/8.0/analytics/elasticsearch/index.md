---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.mf_analytics_full }} 使用 **Elasticsearch 1.5x** 来存储数据和运行搜索查询。  

Elasticsearch 是实时的分布式搜索和分析引擎，可提高数据存储和探究的速度和扩展率。Elasticsearch 将用于全文搜索和结构化搜索。

Elasticsearch 用于将所有移动和服务器数据以 JSON 格式存储在 {{ site.data.keys.mf_analytics_server }} 上的 Elasticsearch 实例中。

将实时查询 Elasticsearch 实例以填充 {{ site.data.keys.mf_analytics_console_full }}。

{{ site.data.keys.mf_analytics }} 将公开所有 Elasticsearch 功能。用户能够充分利用 Elasticsearch 查询、调试和优化。

有关 Elasticsearch 功能（除了此处描述的功能之外）的更多信息，请参阅 [Elasticsearch 文档](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)。

## 在 {{ site.data.keys.mf_analytics_server }} 上管理 Elasticsearch
{: #managing-elasticsearch-on-the-mobilefirst-analytics-server }

Elasticsearch 嵌入在 {{ site.data.keys.mf_analytics_server }} 中，将参与节点和集群行为。

> 有关在分析服务器上配置 Elasticsearch 的更多信息，请参阅 [{{ site.data.keys.mf_analytics_server }}配置指南](../../installation-configuration/production/analytics/configuration)主题中的[集群管理和 Elasticsearch](../../installation-configuration/production/analytics/configuration#cluster-management-and-elasticsearch)。

### Elasticsearch 属性
{: #elasticsearch properties }

Elasticsearch 属性通过 JNDI 变量或环境条目可用。  
用于开始查看 Elasticsearch 数据的更有用的 JNDI 属性之一为：

```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
```

此 JNDI 属性允许您查看 JSON 格式的 {{ site.data.keys.mf_analytics_short }} 原始数据，并且允许您通过 Elasticsearch 定义的端口来访问您的 Elasticsearch 实例。缺省端口为 9500。

> **注**：此设置不安全，并且不应该在生产环境中启用。

## Elasticsearch REST API
{: #elasticsearch-rest-api }

能够访问 Elasticsearch 实例也就能够运行定制查询，查看有关 Elasticsearch 集群的更多详细信息。

**搜索和查看数据**  
您可以通过访问租户的 `_search` REST 端点来查看所有数据。  

```
http://localhost:9500/*/_search
```

**查看集群运行状况**  

```
http://localhost:9500/_cluster/health
```

**查看当前节点上的信息**  

```
http://localhost:9500/_nodes
```

**查看当前映射**  

```
http://localhost:9500/*/_mapping
```

> Elasticsearch 公开了更多 REST 端点。要了解更多信息，请访问 [Elasticsearch 文档](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html)。

