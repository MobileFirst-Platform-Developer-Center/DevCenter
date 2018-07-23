---
layout: tutorial
title: 用于设置 MobileFirst Analytics 生产集群的最佳实践
breadcrumb_title: Best Practices
relevantTo: [ios,android,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

本主题描述了一系列最佳实践，其中包含在生产环境中设置分析服务器时要遵循的注意事项。


## {{ site.data.keys.mf_analytics_server }} - 配置设置
{: #mfp-analytics-config }

必须强制性地将数据清除应用于生产环境，以便从一开始就不持久存储整个文档集。通过为各种事件文档设置相应的 TTL 值，可以显著减少 Elasticsearch 查询的搜索范围。
以下是要为 MobileFirst Analytics V8.0 服务器设置的 TTL 值：

**Analytics 事件/文档的 TTL 属性**

* TTL_PushNotification
*  TTL_PushSubscriptionSummarizedHourly
*  TTL_ServerLog
*  TTL_AppLog 
* TTL_NetworkTransaction 
* TTL_AppSession
*  TTL_AppSessionSummarizedHourly
*  TTL_NetworkTransactionSummarizedHourly 
* TTL_CustomData
* TTL_AppPushAction
*  TTL_AppPushActionSummarizedHourly
*  TTL_PushSubscription

**用法示例：**
```xml
<jndiEntry jndiName="analytics/TTL_AppLog" value= '"20d"' />
```

> TTL 值应该是字符串字面值，并且应该在单引号内传递。

## {{ site.data.keys.mf_analytics_server }} - 拓扑
{: #mfp-analytics-topology }

多节点分析集群
*	在节点前设置负载均衡器很重要，可确保分析层在各节点之间的负载均衡。
*	在未使用负载均衡器的双节点分析集群中，最好配置或使用未用于接受来自 MobileFirst Server 的数据的节点的 Analytics Console。

**例如：**

请考虑分析服务器有两个节点。
在此情况下，用于分析的 MobileFirst Server 配置建议如下：

**建议：**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node2:9080/analytic/console*

**不建议：**<br/>

>**mfp.analytics.url** -> *http://node1:9080/analytics-service/rest*<br/>
>**mfp.analytics.console.url** -> *http://node1:9080/analytic/console*

在用户查看 Analytics Console 时，使用户能够减少节点上的负载。

## {{ site.data.keys.mf_analytics_server }} - 性能调优
{: #mfp-analytics-perf-tuning }

### 操作系统调优
{: #os-tuning }

* 将允许的打开文件描述符数量增加到 32k 或 64k。
* 增加虚拟内存映射计数。

>**注：**查看操作系统的相应文档。

### 应用程序服务器调整
{: #app-server-tuning }

如果您使用的是 WebSphere Application Server V8.5.5.6 Liberty Profile 或更早版本，请确保显式调整 JVM 线程池大小设置。

此行为会让许多用户将执行程序的 **coreThreads** 值设置为较高数字，以确保执行程序永远不会陷入死锁。但是，在 V8.5.5.6 中，修改了自动调整算法以积极对抗死锁。现在执行程序几乎不可能陷入死锁。因此，如果您过去手动设置 **coreThreads** 以避免执行程序死锁，那么一旦迁移 V8.5.5.6，就可能需要考虑恢复为缺省值。

**示例：**

```xml
<executor name="LargeThreadPool" id="default"  coreThreads="200" maxThreads="400" keepAlive="60s" stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```     

### Analytics 调整
{: #analytics-tuning }

* 必须将 Java **Xms** 和 **Xmx**（最小和最大）设置为相同值。
* 每个 JVM 允许的最大堆大小 <= RAM 大小/2。
* 主 Shard 的数量 = 分析集群的节点数量。
* 每个 shard 的副本数 >= 2。

> **注：**如果只有一个节点，那么不需要副本。

### Elasticsearch 调整
{: #es-tuning }

Elasticsearch 调整可以在单独的 YAML 文件中执行（例如，它可以命名为 `elasticsearchconfig.yml`），可以在分析服务器配置中配置此文件的路径（使用 JNDI 属性）。

**属性名称：***analytics/settingspath*<br/>
**值：** *\<path_to_the_ES_config_yml\>*

通过将值添加到 `.yml` 文件并使用 JNDI 条目访问该文件来应用 Elasticsearch 调整参数。

会考虑将 Elasticsearch 调整参数用于环境的基本调整，并可根据基础结构资源进行进一步调整：

1. 为 **indices.fielddata.cache.size** 设置一个值

   例如：
   ```
   indices.fielddata.cache.size:  35%
   ```  

   >**注：**请谨慎使用 **analytics/indices.fielddata.cache.size**。>请勿将其增加到高值，因为增加此值可能会导致 OutofMemory。分析平台使用的基础技术将多个字段值加载到内存中，以便更快速地访问这些文档。这称为“字段缓存”。缺省情况下，通过字段缓存装入内存的数据量不受限制。如果字段缓存过大，会导致内存不足异常，使分析平台崩溃。

2. 为 **indices.fielddata.breaker.limit** 设置一个值。

   将 **indices.fielddata.breaker.limit** 设置为大于 **indices.fielddata.cache.size** 的值。

   因此，如果缓存大小为 *35%*，请将断路器限制设置为大于缓存大小的值。

3. 为 **indices.fielddata.cache.expire** 设置一个值。

   此值将设置 Elasticsearch 缓存的到期时间，并防止缓存无限增长而填满堆。

   > **indices.fielddata.cache.expire**
   >
   > 基于时间的设置，在一段时间不活动后使字段数据到期。缺省值为 -1。例如，可以设置为 5 m，表示 5 分钟后到期。

4. Analytics 的缺省设置是不清除任何数据。

   适当配置 TTL 以确保清除数据。否则，数据存储可能会以无限方式增长。

## {{ site.data.keys.mf_analytics_server }} - 注意事项
{: #mfp-analytics-dos-donts }

-	在分析节点运行时，避免清除 analyticsData 目录。
-	在多节点集群中，避免将同一节点用于将事件推送到分析集群中和访问控制台。最佳做法是在分析集群前使用负载均衡器。
-	避免对分析集群使用任何其他应用程序服务器集群方法。底层 Elasticsearch 使用其节点发现机制自行创建集群。
-	避免在 IBM WebSphere Application Server Full Profile 或 IBM WebSphere Application Server Network Deployment 中对 Analytics 使用 Open JDK（或 Sun Java）。
-	永远不要将 Analytics 最小/最大堆大小增加到大于节点上 RAM 大小一半的值。例如，如果您有一个 RAM 大小为 16 GB 的节点，那么针对 Analytics，允许的最大堆大小为 8 GB。
- 对于分析集群名称（**analytics/clustername** JNDI 属性），请使用唯一的集群名称。避免使用缺省名称 *worklight*。

## {{ site.data.keys.mf_analytics_server }} - SDK 问题
{: #mfp-analytics-sdk-issues }

### 1. Cordova 应用程序必须在生命周期事件的本机平台上初始化以启用 AppSession 捕获
{: #mfp-cordova-apps-appsession }

在 MobileFirst Platform Foundation V8.0 中，当应用程序从后台切换到前台时，应用程序会话数将递增/记录。  

通过为生命周期事件添加侦听器来启用 AppSession 的捕获。本机 SDK 提供相应的 API 用于添加这些侦听器。但是，在 Cordova 情况下，没有用于添加这些生命周期事件侦听器的 JavaScript API。相反，即使对于 Cordova 应用程序，也必须使用本机平台 API 添加侦听器。

摘录自[文档](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/analytics-api/#client-lifecycle-events)：

<blockquote>在配置 Analytics SDK 之后，将开始在用户设备上记录应用程序会话。将应用程序从前台移至后台时将在 MobileFirst Analytics 中记录会话，这将在 Analytics Console 上创建会话。一旦将设备设置为记录会话并发送数据，就可以看到 Analytics Console 已填充有数据，如下所示。</blockquote>

例如，对于 iOS 平台 (iOS) 上的 Cordova 应用程序，必须在 `AppDelegate.m` 下添加下列内容：
```
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
[[WLAnalytics sharedInstance] send];
```
### 2. 在 Analytics Console 上查看定制数据
{: #view-custom-data-console }

要使用 Analytics Client SDK API 快速找到发送至 Analytics 服务器的定制数据，可以执行以下步骤。

转至 **Analytics Console > 仪表板 > 定制图表 > 创建定制图表**

![创建定制图表]({{ site.baseurl }}/tutorials/en/foundation/8.0/analytics/bestpractices-prod/create_custom_chart.png)

有关更多信息，请参阅[此处](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/console/custom-charts/)的文档。

## {{ site.data.keys.mf_analytics_server }} - 故障诊断步骤
{: #mfp-analytics-troubleshooting }

1.	客户环境版本：<br/>
    收集完整软件堆栈的详细信息，包括 OS、JDK/JRE、AppServer、MobileFirst Platform Foundation 版本和 MobileFirst Platform Foundation 构建版本。
2.	将环境详细信息与 IBM MobileFirst Analytics 软件兼容性矩阵/需求进行比较。
3.	收集使用的 Analytics 拓扑和硬件规范。
4.	检查是否执行了任何性能调整（以防出现性能问题）。
5.	收集 MobileFirst Platform Foundation Server 的 `server.xml` (Liberty) 和 JNDI 环境条目/属性 (WAS Full Profile/ND)，以验证 Analytics 集成配置。
6.	收集 Analytics 管理控制台的截屏。
7.	收集 Analytics `server.xml` (Liberty) 和 JNDI 环境条目/属性 (WAS Full Profile/ND)，以验证 Analytics 集成配置。
8.	收集以下 REST API（列示在**用于对 Analytics 问题进行故障诊断的重要命令和 API** 部分中）的输出。

## 用于故障诊断的实用程序
{: #urilities-for-troubleshooting }

以下是可有效地用于可视化和管理 Elasticsearch 索引、数据/shard 分配等的开放式源代码工具。

-	[Cerebro](https://github.com/lmenezes/cerebro)
-	[Sense (Beta)](https://github.com/cheics/sense)

### 用于对 Analytics 问题进行故障诊断的重要命令和 API
{: #commands-apis}

使用 cURL 运行以下 REST API 以捕获响应，从而识别有关集群/shard/索引的各种信息：
```
http://<es_node>:9500/_cluster/health
http://<es_node>:9500/_cluster/stats
http://<es_node>:9500/_cat/shards
http://<es_node>:9500/_node/status
http://<es_node>:9500/_cat/indices
```

## 参考
{: #references}

*	[MobileFirst Analytics - Quick & Dirty clusters](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/10/mobilefirst-analytics-quick-dirty-clusters/)
*	[MobileFirst Analytics - Planning for Production](https://mobilefirstplatform.ibmcloud.com/blog/2015/10/01/mobilefirst-analytics-planning-for-production/)
*	[MobileFirst Analytics – Installation Guide](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/analytics/installation/)
*	[Setting JNDI property for Mobile Analytics Time To Live(TTL) value as days in Liberty Profile](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/03/liberty-analytics-jndi-ttl-setting/)
