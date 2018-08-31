---
layout: tutorial
title: MobileFirst Analytics Server 配置指南
breadcrumb_title: Configuration Guide
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
需要对 {{ site.data.keys.mf_analytics_server }} 进行一些配置。 如文中所示，某些配置参数适用于单个节点，某些则适用于整个集群。

#### 跳转至
{: #jump-to }

* [配置属性](#configuration-properties)
* [备份分析数据](#backing-up-analytics-data)
* [集群管理和 Elasticsearch](#cluster-management-and-elasticsearch)

### 属性
{: #properties }
要获取配置属性的完整列表并了解如何在应用程序服务器中设置这些属性，请参阅[配置属性](#configuration-properties)。

* **discovery.zen.minimum\_master\_nodes** 属性必须设置为 **ceil
((集群中的主合格节点数 / 2) + 1)**，以避免网络分区症状。
    * 符合主节点条件的集群中的弹性搜索节点必须建立定额，以确定哪个符合主节点条件的节点是主节点。
    * 如果将符合主节点条件的节点添加到集群中，那么符合主节点条件的节点数会有所变化，因此必须更改设置。 如果要向集群引入新的符合主节点条件的节点，那么必须修改设置。 有关如何管理集群的更多信息，请参阅[集群管理和 Elasticsearch](#cluster-management-and-elasticsearch)。
* 通过在所有节点中设置 **clustername** 属性来为集群命名。
    * 命名集群，以防止开发人员的 Elasticsearch 实例意外连接使用缺省名称的集群。
* 通过在每个节点中设置 **nodename** 属性来为每个节点命名。
    * 缺省情况下，Elasticsearch 以随机 Marvel 字符对每个节点命名，每次重新启动每个节点时，节点名都会改变。
* 通过在每个节点中设置 **datapath** 属性来显式声明到数据目录的文件系统路径。
* 通过在每个节点中设置 **masternodes** 属性来显式声明专用主节点。

### 集群恢复设置
{: #cluster-recovery-settings }
向外扩展到多节点集群后，您可能会发现偶尔需要重新启动整个集群。 需要重新启动整个集群时，必须考虑恢复设置。 如果集群中有 10 个节点，当生成集群（一次一个节点）时，主节点会假定在每个节点到达集群时均需立即开始平衡数据。 如果允许主节点的此行为，将需要大量不必要的再平衡过程。 必须配置集群设置以等待最小数目的节点连接到集群，以防止允许主节点开始命令节点进行再平衡。 这可将集群重新启动时间从几小时降至几分钟。

* 必须将 **gateway.recover\_after\_nodes** 属性设置为您的首选项，以防止 Elasticsearch 在集群中指定数量的节点启动并连接之前开始重新均衡。 如果集群具有 10 个节点，那么 **gateway.recover\_after\_nodes** 属性值为 8 可能是合理设置。
* 必须将 **gateway.expected\_nodes** 属性设置为您预期集群中存在的节点数。 在此示例中，**gateway.expected_nodes** 属性的值为 10。
* 必须设置 **gateway.recover\_after\_time** 属性以指示主节点在发送重新均衡指令前应等待的时间（从主节点启动开始）。

上述设置的组合意味着 Elasticsearch 将等待至 **gateway.recover\_after\_nodes** 所表示的节点数量存在。 然后，在 **gateway.recover\_after\_time** 所表示的分钟数或者在 **gateway.expected\_nodes** 所表示的节点数连接到集群（以先到为准）后再开始恢复。

### 请勿执行以下操作
{: #what-not-to-do }
* 请勿忽略生产集群。
    * 集群需要监控和培养。 针对此任务有许多有效的专属 Elasticsearch 监控工具。
* 请勿对 **datapath** 设置使用网络连接存储器 (NAS)。 NAS 造成更长时间的延迟，并且会产生单一故障点。 始终使用本地主机磁盘。
* 避免集群跨多个数据中心，务必避免集群的地域距离跨度过大。 节点之间的延迟是严重的性能瓶颈。
* 实施您自己的集群配置管理解决方案。 有许多有效的配置管理解决方案可用，例如，Puppet、Chef 和 Ansible。

## 配置属性
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }} 无需额外配置即可成功启动。

在 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics_server }} 上通过 JNDI 属性完成配置。 此外，{{ site.data.keys.mf_analytics_server }} 支持使用环境变量来控制配置。 环境变量优先于 JNDI 属性。

必须重新启动 Analytics 运行时 Web 应用程序，以使这些属性中的所有更改生效。 不必重新启动整个应用程序服务器。

要在 WebSphere Application Server Liberty 上设置 JNDI 属性，请在 **server.xml** 文件中添加如下标签。

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

要在 Tomcat 上设置 JNDI 属性，请在 context.xml 文件中添加如下标签。

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

WebSphere Application Server 上的 JNDI 属性可用作环境变量。

* 在 WebSphere Application Server 控制台中，选择**应用程序 → 应用程序类型 → WebSphere Enterprise 应用程序**。
* 选择 **{{ site.data.keys.product_adj }} Administration Service** 应用程序。
* 在 **Web 模块属性**中，单击 **Web 模块的环境条目**以显示 JNDI 属性。

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
下表显示了可在 {{ site.data.keys.mf_server }} 中设置的属性。

| 属性                           | 描述                                           | 缺省值 |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | 将该属性设置为 {{ site.data.keys.mf_analytics_console }} 的 URL。 例如，http://hostname:port/analytics/console。 设置该属性会在 {{ site.data.keys.mf_console }} 上启用分析图标。 | 无 |
| mfp.analytics.logs.forward         | 如果该属性设置为 true，那么将会在 {{ site.data.keys.mf_analytics }} 中捕获 {{ site.data.keys.mf_server }} 上记录的服务器日志。 | true |
| mfp.analytics.url                  |必需。 由 {{ site.data.keys.mf_analytics_server }} 公开的用于接收入局分析数据的 URL。 例如，http://hostname:port/analytics-service/rest/v2。 | 无 |
| analyticsconsole/mfp.analytics.url |	可选。 分析 REST 服务的完整 URI。 在有防火墙或安全逆向代理的情况下，该 URI 必须为外部 URI，不能为本地 LAN 中的内部 URI。 该值可用 * 代替 URI 协议、主机名或端口，以表示入局 URL 的对应部分。	*://*:*/analytics-service，动态确定协议、主机名和端口 |
| mfp.analytics.username             | 通过基本认证保护数据入口点时使用的用户名。 | 无 |
| mfp.analytics.password             | 通过基本认证保护数据入口点时使用的密码。 | 无 |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
下表显示了可在 {{ site.data.keys.mf_analytics_server }} 中设置的属性。

| 属性                           | 描述                                           | 缺省值 |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | 定义 Elasticsearch 节点类型。 有效值为 master 和 data。 如果未设置该属性，那么该节点将充当主合格节点和数据节点。 | 	无 |
| analytics/shards | 每个索引的分片数量。 该值只能通过集群中启动的第一个节点进行设置，并且不能更改。 | 1 |
| analytics/replicas_per_shard | 集群中每个分片的副本数量。 此值可在运行的集群中动态更改。 | 0 |
| analytics/masternodes | 逗号分隔的字符串，其中包含主合格节点的主机名和端口。 | 无 |
| analytics/clustername | 集群的名称。 如果计划让多个集群在同一个子集中运行并且需要唯一标识这些集群，请设置该值。 | worklight |
| analytics/nodename | 集群中节点的名称。 | 随机生成的字符串
| analytics/datapath | 分析数据在文件系统上的保存路径。 | ./analyticsData |
| analytics/settingspath | 到 Elasticsearch 设置文件的路径。 有关更多信息，请参阅 Elasticsearch。 | 无 |
| analytics/transportport | 用于节点到节点通信的端口。 | 9600 |
| analytics/httpport | 用于到 Elasticsearch 的 HTTP 通信的端口。 | 9500 |
| analytics/http.enabled | 启用或禁用到 Elasticsearch 的 HTTP 通信。 | false |
| analytics/serviceProxyURL | 可将分析 UI WAR 文件和分析服务 WAR 文件安装到不同的应用程序服务器。 如果您选择这样做，必须了解在浏览器中阻止跨站点脚本编制可能阻止 UI WAR 文件中的 JavaScript 运行时。 为绕过此阻止，UI WAR 文件包含 Java 代理代码，以便 JavaScript 运行时从源服务器检索 REST API 响应。 但代理配置为将 REST API 请求转发至分析服务 WAR 文件。 如果已将 WAR 文件安装至独立应用程序服务器，请配置该属性。 | 无 |
| analytics/bootstrap.mlockall | 此属性可防止将任何 Elasticsearch 内存交换至磁盘。 | true |
| analytics/multicast | 启用或禁用多点广播节点发现。 | false |
| analytics/warmupFrequencyInSeconds | 热启动查询运行频率。 热启动查询在后台运行，以强制将查询结果保存到内存中，从而提高 Web 控制台性能。 负值会禁用热启动查询。 | 600 |
| analytics/tenant | 主 Elasticsearch 索引的名称。	worklight |

在密钥不包含句点（例如 **httpport** 而不是 **http.enabled**）的所有情况下，可通过变量名带有 **ANALYTICS_** 前缀的系统环境变量来控制设置。 同时设置 JNDI 属性和系统环境变量时，系统环境变量优先。 例如，如果已设置 **analytics/httpport** JNDI 属性和 **ANALTYICS_httpport** 系统环境变量，那么将使用 **ANALYTICS_httpport** 的值。

> **要点**：目前，MobileFirst Analytics V8.0 不支持多租户。 缺省情况下，会将事件从 MobileFirst Server 发送至单租户体系结构。

#### 文档生存时间 (TTL)
{: #document-time-to-live-ttl }
TTL 能有效帮助您建立和维护数据保留时间策略。 您的决定对您的系统资源需求影响巨大。 您保留数据时间越长，所需 RAM、磁盘越多，扩展性越高。

每个文档类型都有其自己的 TTL。 设置文档 TTL 支持在文档存储达到指定时长之后自动删除文档。

每个 TTL JNDI 属性均命名为 **analytics/TTL_[document-type]**。 例如，**NetworkTransaction** 的 TTL 设置命名为 **analytics/TTL_NetworkTransaction**。

可通过使用如下基本时间单位来设置这些值。

* 1Y = 1 年
* 1M = 1 个月
* 1w = 1 周
* 1d = 1 天
* 1h = 1 小时
* 1m = 1 分钟
* 1s = 1 秒
* 1ms = 1 毫秒

受支持的文档类型的列表如下所示：

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **注意：**如果要从先前版本的 {{ site.data.keys.mf_analytics_server }} 迁移并且先前已配置任何 TTL JNDI 属性，请参阅[迁移先前版本的 {{ site.data.keys.mf_analytics_server }} 使用的服务器属性](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server)。

#### Elasticsearch
{: #elasticsearch }
为 {{ site.data.keys.mf_analytics_console }} 服务的底层存储和集群技术即 Elasticsearch。  
Elasticsearch 提供许多可调属性，大部分用于性能调整。 许多 JNDI 属性都是对 Elasticsearch 所提供属性的抽象。

还可通过使用 JNDI 属性并在属性名称前追加 **analytics/** 来设置 Elasticsearch 提供的所有属性。 例如，**threadpool.search.queue_size** 是 Elasticsearch 提供的属性。 可使用以下 JNDI 属性来设置。

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

通常，这些属性在定制设置文件中进行设置。 如果您对 Elasticsearch 及其属性文件的格式很熟悉，那么可以使用 **settingspath** JNDI 属性按如下方式指定该设置文件的路径。

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

除非您是专家级别的 Elasticsearch IT 经理并且具有特定需求或者受到您的服务或支持团队的指示，否则请勿尝试这些设置。

## 备份分析数据
{: #backing-up-analytics-data }
了解如何备份您的 {{ site.data.keys.mf_analytics }} 数据。

{{ site.data.keys.mf_analytics }} 的数据作为文件集存储在 {{ site.data.keys.mf_analytics_server }} 文件系统上。 通过 {{ site.data.keys.mf_analytics_server }} 配置中的 datapath JNDI 属性来指定此文件夹的位置。 有关 JNDI 属性的更多信息，请参阅[配置属性](#configuration-properties)。

{{ site.data.keys.mf_analytics_server }} 配置也将存储在文件系统上，名为 server.xml。

您可以使用可能已到位的任何现有服务器备份过程来备份这些文件。 在备份这些文件时，没有需要使用的特别过程，只需确保停止 {{ site.data.keys.mf_analytics_server }}。 否则，在进行备份时数据可能会更改，并且可能不会将存储在内存中的数据写入文件系统。 为避免出现不一致的数据，请在开始备份之前停止 {{ site.data.keys.mf_analytics_server }}。

## 集群管理和 Elasticsearch
{: #cluster-management-and-elasticsearch }
管理集群和添加节点以缓解内存和容量压力。

### 向集群添加节点
{: #add-a-node-to-the-cluster }
您可以通过安装 {{ site.data.keys.mf_analytics_server }} 或通过运行独立的 Elasticsearch 实例来向集群添加新节点。

如果选择独立 Elasticsearch 实例，那么可以缓解某些集群在内存和容量需求方面的压力，但是不能缓解数据并入的压力。 数据报告必须始终经过 {{ site.data.keys.mf_analytics_server }} 以在进入持久存储之前保留数据完整性和数据优化。

您可以混用这两种方法。

底层的 Elasticsearch 数据存储期望节点为同构节点，因此请勿将强大的 8 核 64 GB RAM 机架系统与集群中多余的笔记本混用。 请在节点之中使用相似硬件。

#### 将 {{ site.data.keys.mf_analytics_server }} 添加到集群
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
了解如何将 {{ site.data.keys.mf_analytics_server }} 添加到集群。

由于 Elasticsearch 嵌入 {{ site.data.keys.mf_analytics_server }}，因此请使用 Elasticsearch 设置来定义集群行为。 例如，请勿创建 WebSphere Application Server Liberty 阵列或使用其他应用程序服务器设置。

在以下样本指示信息中，请勿将节点配置为主节点或数据节点。 而改为将节点配置为“搜索负载均衡器”，以便能够暂时运行，从而公开 Elasticsearch
REST API 用于进行监控和动态配置。

**注：**

* 请记得根据[系统需求](../installation/#system-requirements)来配置此节点的硬件和操作系统。
* 端口 9600 是 Elasticsearch 使用的传输端口。 因此，必须通过集群节点之间的任何防火墙打开端口 9600。

1. 在新分配的系统上将分析服务 WAR 文件和分析 UI WAR 文件（如果需要 UI）安装到应用程序服务器中。 将 {{ site.data.keys.mf_analytics_server }} 的此实例安装到任何受支持的应用程序服务器。
    * [在 WebSphere Application Server Liberty 上安装 {{ site.data.keys.mf_analytics }}](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [在 Tomcat 上安装 {{ site.data.keys.mf_analytics }}](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [在 WebSphere Application Server 上安装 {{ site.data.keys.mf_analytics }}](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. 为 JNDI 属性编辑应用程序服务器配置文件（或使用系统环境变量）以配置以下至少一个标记。

    | 标记 | 值（示例） | 缺省值 | 注释 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	您希望此节点加入的集群。 |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	设置为 false 以避免意外加入集群。 |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	无 | 	现有集群中主节点的列表。 如果已在主节点上指定传输端口设置，请更改缺省值 9600。 |
    | node.master | 	false | 	true | 	不允许此节点成为主节点。 |
    | node.data|	false | 	true | 	不允许此节点存储数据。 |
    | http.enabled | 	true	 | true | 	为 Elasticsearch REST API 打开不受保护的 HTTP 端口 9200。 |

3. 在生产方案中考虑所有配置标记。 您可能希望 Elasticsearch 将插件与数据保留在不同文件系统目录中，因此必须设置 **path.plugins** 标记。
4. 根据需要运行应用程序服务器并启动 WAR 应用程序。
5. 通过观察此新节点上的控制台输出，或者通过观察 {{ site.data.keys.mf_analytics_console }} 中**管理**页面的**集群和节点**部分中的节点计数来确认此新节点是否已加入集群。

#### 向集群添加独立 Elasticsearch 节点
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
了解如何向集群添加独立 Elasticsearch 节点。

只需几个简单的步骤即可将独立 Elasticsearch 节点添加到现有 {{ site.data.keys.mf_analytics }} 集群中。 但是，必须确定此节点的角色。 此节点是否将成为主合格节点？ 如果是，那么请记得避免网络分区问题。 此节点是否将成为数据节点？ 此节点是否将成为仅限客户机的节点？ 可能您需要一个仅限客户机的节点，这样就能暂时启动节点，直接公开 Elasticsearch 的 REST API，以影响对运行中集群的动态配置更改。

在以下样本指示信息中，请勿将节点配置为主节点或数据节点。 而改为将节点配置为“搜索负载均衡器”，以便能够暂时运行，从而公开 Elasticsearch
REST API 用于进行监控和动态配置。

**注：**

* 请记得根据[系统需求](../installation/#system-requirements)来配置此节点的硬件和操作系统。
* 端口 9600 是 Elasticsearch 使用的传输端口。 因此，必须通过集群节点之间的任何防火墙打开端口 9600。

1. 从 [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz) 下载 Elasticsearch。
2. 解压缩此文件。
3. 编辑 **config/elasticsearch.yml** 文件，并配置以下至少一个标记。

    | 标记 | 值（示例） | 缺省值 | 注释 |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	您希望此节点加入的集群。 |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	设置为 false 以避免意外加入集群。 |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	无 | 	现有集群中主节点的列表。 如果已在主节点上指定传输端口设置，请更改缺省值 9600。 |
    | node.master | 	false | 	true | 	不允许此节点成为主节点。 |
    | node.data|	false | 	true | 	不允许此节点存储数据。 |
    | http.enabled | 	true	 | true | 	为 Elasticsearch REST API 打开不受保护的 HTTP 端口 9200。 |


4. 在生产方案中考虑所有配置标记。 您可能希望 Elasticsearch 将插件与数据保留在不同文件系统目录中，因此必须设置 path.plugins 标记。
5. 运行 `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` 以安装 ICU 插件。
6. 运行 `./bin/elasticsearch`。
7. 通过观察此新节点上的控制台输出，或者通过观察 {{ site.data.keys.mf_analytics_console }} 中**管理**页面的**集群和节点**部分中的节点计数来确认此新节点是否已加入集群。

#### 断路器
{: #circuit-breakers }
了解有关 Elasticsearch 断路器的信息。

Elasticsearch 包含多个断路器，用于防止操作导致 **OutOfMemoryError**。 例如，如果将数据提供给 {{ site.data.keys.mf_console }} 的查询导致使用 40% 的 JVM 堆，那么会触发断路器、发出异常并且控制台会收到空数据。

Elasticsearch 还针对填满磁盘提供保护。 如果 Elasticsearch 数据存储配置为写入数据的磁盘填充至 90% 的容量，那么 Elasticsearch 节点会通知集群中的主节点。 随后，主节点会将新文档写入从几乎已满的节点重定向至别处。 如果集群中只有一个节点，那么没有辅助节点可用于写入数据。 因此，将不会写入任何数据，数据将丢失。
