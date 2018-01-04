---
layout: tutorial
title: 拓扑和网络流
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
此处提供的信息详细介绍 {{ site.data.keys.mf_server }} 组件可能的服务器拓扑以及可用的网络流。  
以下组件根据您使用的服务器拓扑进行部署。 网络流为您说明了组件之间以及组件与最终用户设备之间的通信方式。

#### 跳转至
{: #jump-to }

* [{{ site.data.keys.mf_server }} 组件间的网络流](#network-flows-between-the-mobilefirst-server-components)
* [对 {{ site.data.keys.mf_server }}组件和 {{ site.data.keys.mf_analytics }} 的约束](#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics)
* [多个 {{ site.data.keys.product }} 运行时](#multiple-mobilefirst-foundation-runtimes)
* [同一个服务器或 WebSphere Application Server 单元上的多个 {{ site.data.keys.mf_server }} 实例](#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell)

## {{ site.data.keys.mf_server }} 组件间的网络流
{: #network-flows-between-the-mobilefirst-server-components }
{{ site.data.keys.mf_server }} 组件可通过 JMX 或 HTTP 相互通信。 您需要配置特定的 JNDI 属性以启用通信。  
可通过下图展示组件与设备间的网络流：

![{{ site.data.keys.product }} 组件网络流的图](mfp_components_network_flows.jpg)

以下部分中说明了各种 {{ site.data.keys.mf_server }} 组件、{{ site.data.keys.mf_analytics }}、移动设备以及应用程序服务器间的流程：

1. [{{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_server }} 管理服务](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)
2. [其他服务器中的 {{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.product }} 运行时](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers)
3. [WebSphere Application Server Network Deployment 上的 {{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.product_adj }} 运行时到 Deployment Manager](#mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment)
4. [{{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_analytics }}](#mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics)
5. [{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 实时更新服务](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service)
6. [{{ site.data.keys.mf_console }} 到 {{ site.data.keys.mf_server }} 管理服务](#mobilefirst-operations-console-to-mobilefirst-server-administration-service)
7. [{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 推送服务，再到授权服务器](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)
8. [{{ site.data.keys.mf_server }} 推送服务到外部推送通知服务（出站）](#mobilefirst-server-push-service-to-an-external-push-notification-service-outbound)
9. [移动设备到 {{ site.data.keys.product }} 运行时](#mobile-devices-to-mobilefirst-foundation-runtime)

### {{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_server }} 管理服务
{: #mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service }
运行时和管理服务可通过 JMX 和 HTTP 相互通信。 运行时初始化期间，将进行此通信。 运行时会联系其应用程序服务器的本地管理服务，以获取其需要提供提供的适配器和应用程序的列表。 在从 {{ site.data.keys.mf_console }} 或管理服务运行某些管理操作时，也将进行此通信。 在 WebSphere  Application Server Network Deployment 上，运行时可以联系单元的其他服务器上安装的管理服务。 这将启用非对称性部署（请参阅[对 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)）。 然而，在所有其他应用程序服务器（Apache Tomcat、WebSphere Application Server Liberty 或独立 WebSphere Application Server）上，必须在与运行时相同的服务器上运行管理服务。

针对 JMX 的协议取决于应用程序服务器：

* Apache Tomcat - RMI
* WebSphere Application Server Liberty - HTTPS（使用 REST 接口）
* WebSphere Application Server - SOAP 或 RMI

要通过 JMX 进行通信，这些协议需在应用程序服务器上可用。 有关需求的更多信息，请参阅[应用程序服务器先决条件](../appserver/#application-server-prerequisites)。

运行时和管理服务的 JMX Bean 也将从应用程序服务器获取。 然而，对于 WebSphere Application Server Network Deployment，JMX Bean 将从 Deployment Manager 获取。 Deployment Manager 具有 WebSphere Application Server Network Deployment 上单元的所有 Bean 的视图。 同样，WebSphere Application Server Network Deployment 上不需要某些配置（如场配置），WebSphere Application Server Network Deployment 上也可以进行非对称性部署。 有关更多信息，请参阅[对 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)。

要区分是在同一应用程序服务器，还是在同一 WebSphere Application Server 单元上以不同方式安装 {{ site.data.keys.mf_server }}，可使用环境标识（它是 JNDI 变量）。 缺省情况下，此变量的值为空。 具有指定环境标识的运行时仅与环境标识相同的管理服务通信。 例如，管理服务将环境标识设置为 X，并且运行时具有不同的环境标识（例如，Y），那么这两个组件将彼此不可见。 {{ site.data.keys.mf_console }} 未显示任何可用运行时。

管理服务必须能够与集群的所有 {{ site.data.keys.product }} 运行时组件通信。 运行管理操作（如上载新版本适配器或更改应用程序的活动状态）时，必须向集群的所有运行时组件通知更改情况。 如果应用程序服务器不是 WebSphere Application Server Network Deployment，那么只有在配置了场的情况下才能进行此通信。 有关更多信息，请参阅[对 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)。

运行时还能通过 HTTP 或 HTTPS 与管理服务通信，以下载适配器等大型工件。 管理服务将生成 URL，并将打开运行时并建立出站 HTTP 或 HTTPS 连接以从此 URL 请求工件。 可在管理服务中通过定义 JNDI 属性（mfp.admin.proxy.port、mfp.admin.proxy.protocol 和 mfp.admin.proxy.host）来覆盖缺省 URL 生成过程。 管理服务还可能需要通过 HTTP 或 HTTPS 与运行时通信，以获取用于运行推送操作的 OAuth 令牌。 有关更多信息，请参阅[{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 推送服务，再到授权服务器](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)。

用于运行时与管理服务间的通信的 JNDI 属性如下：

#### {{ site.data.keys.mf_server }} 管理服务
{: #mobilefirst-server-administration-service }

* [管理服务的 JNDI 属性：JMX](../server-configuration/#jndi-properties-for-administration-service-jmx)
* [管理服务的 JNDI 属性：代理](../server-configuration/#jndi-properties-for-administration-service-proxies)
* [管理服务的 JNDI 属性：拓扑](../server-configuration/#jndi-properties-for-administration-service-topologies)

#### {{ site.data.keys.product }} 运行时
{: #mobilefirst-foundation-runtime }

* [{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

### 其他服务器中的 {{ site.data.keys.mf_server }}
管理服务到 {{ site.data.keys.product }} 运行时
{: #mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers }
如 [{{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_server }} 管理服务](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)中所述，管理服务与集群的所有运行时组件间需进行通信。 运行管理操作时，可通知集群的所有运行时组件此修改情况。 通过 JMX 进行通信。

在 WebSphere Application Server Network Deployment 上，此通信可在无任何特定配置的情况下进行。 可从 Deployment Manager 获取与同一环境标识相对应的所有 JMX MBean。

对于独立 WebSphere Application Server、WebSphere Application Server Liberty Profile 或 Apache Tomcat 的集群，只有在配置了场的情况下才能进行此通信。 有关更多信息，请参阅[安装服务器场](../appserver/#installing-a-server-farm)。

### WebSphere Application Server Network Deployment 上的 {{ site.data.keys.mf_server }} 管理服务和 MobileFirst 运行时到 Deployment Manager
{: #mobilefirst-server-administration-service-and-mobilefirst-runtime-to-the-deployment-manager-on-websphere-application-server-network-deployment }
在 WebSphere Application Server Network Deployment 上，运行时和管理服务可通过与 Deployment Manager 进行通信，来获取
[{{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_server }} 管理服务](#mobilefirst-foundation-runtime-to-mobilefirst-server-administration-service)和其他服务器中
[{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.product }} 运行时](#mobilefirst-server-administration-service-to-mobilefirst-foundation-runtime-in-other-servers)中使用的 JMX MBean。 在 [管理服务的 JNDI 属性：JMX](../server-configuration/#jndi-properties-for-administration-service-jmx)中，对应的 JNDI 属性为 **mfp.admin.jmx.dmgr.***。

必须运行 Deployment Manager 以支持需要运行时与管理服务间进行 JMX 通信的操作。 此类操作可以是运行时初始化，或通知通过管理服务执行的修改。

### {{ site.data.keys.mf_server }} 推送服务和 {{ site.data.keys.product }} 运行时到 {{ site.data.keys.mf_analytics }}
{: #mobilefirst-server-push-service-and-mobilefirst-foundation-runtime-to-mobilefirst-analytics }
运行时可通过 HTTP 或 HTTPS 向 {{ site.data.keys.mf_analytics }} 发送数据。 用于定义此通信的运行时的 JNDI 属性为：

* **mfp.analytics.url ** - {{ site.data.keys.mf_analytics }} 服务公开的 URL，用于从运行时接收传入的分析数据。 例如：`http://<hostname>:<port>/analytics-service/rest`

    当安装 {{ site.data.keys.mf_analytics }} 作为集群时，可将数据发送至集群中的任何成员。

* **mfp.analytics.username** - 用于访问 {{ site.data.keys.mf_analytics }} 服务的用户名。 分析服务受安全角色保护。
* **mfp.analytics.password** - 用于访问分析服务的密码。
* **mfp.analytics.console.url** - 传递到 {{ site.data.keys.mf_console }} 以显示指向 {{ site.data.keys.mf_analytics_console }} 的链接的 URL。 例如：`http://<hostname>:<port>/analytics/console`

    用于定义此通信的推送服务的 JNDI 属性为：
* **mfp.push.analytics.endpoint** - {{ site.data.keys.mf_analytics }} 服务公开的 URL，用于从推送服务接收传入的分析数据。 例如：`http://<hostname>:<port>/analytics-service/rest`

    当安装 {{ site.data.keys.mf_analytics }} 作为集群时，可将数据发送至集群中的任何成员。    
* **mfp.push.analytics.username** - 用于访问 {{ site.data.keys.mf_analytics }} 服务的用户名。 分析服务受安全角色保护。
* **mfp.push.analytics.password** - 用于访问分析服务的密码。

### {{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 实时更新服务
{: #mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service }
管理服务可与实时更新服务进行通信，以存储和检索有关 {{ site.data.keys.product }} 工件的配置信息。 通过 HTTP 或 HTTPS 执行通信。

管理服务将自动生成用于联系实时更新服务的 URL。 两项服务都必须在同一应用程序服务器上。 必须按以下方式定义实时更新服务的上下文根：`<adminContextRoot>config`。 例如，如果管理服务的上下文根为 **mfpadmin**，那么实时更新服务的上下文根必须为 **mfpadminconfig**。 可在管理服务中通过定义 JNDI 属性（**mfp.admin.proxy.port**、**mfp.admin.proxy.protocol** 和 **mfp.admin.proxy.host**）来覆盖缺省 URL 生成过程。

用于配置这两项服务间的此通信的 JNDI 属性为：

* **mfp.config.service.user**
* **mfp.config.service.password**
* 以及[管理服务的 JNDI 属性：代理](../server-configuration/#jndi-properties-for-administration-service-proxies)中的属性。

### {{ site.data.keys.mf_console }} 到
{{ site.data.keys.mf_server }} 管理服务
{: #mobilefirst-operations-console-to-mobilefirst-server-administration-service }
{{ site.data.keys.mf_console }} 是一个 Web 用户界面，用作管理服务的前端。 它能通过 HTTP 或 HTTPS 与管理服务的 REST 服务通信。 还必须支持允许使用控制台的用户使用管理服务。 还必须将映射到控制台的某一安全角色的每位用户映射到服务的同一安全角色。 利用此设置，服务因此可接受来自控制台的请求。

用于配置此通信的 JNDI 属性位于 [{{ site.data.keys.mf_console }} 的 JNDI 属性](../server-configuration/#jndi-properties-for-mobilefirst-operations-console)中。

> 注：**mfp.admin.endpoint** 属性支持控制台查找管理服务。 您可以使用星号“*”字符作为通配符，以指定控制台生成的 URL（用于联系管理服务）使用与到控制台的入局 HTTP 请求相同的值。 例如：`*://*:*/mfpadmin` 意味着使用相同的协议、主机和端口作为控制台，但使用 **mfpadmin** 作为上下文根。 为控制台应用程序指定该属性。

### {{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 推送服务，再到授权服务器
{: #mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server }
管理服务可与推送服务通信，以请求各种推送操作。 将通过 OAuth 协议保护此通信的安全。 需注册两项服务作为保密客户端。 可在安装时执行初始注册。 在此过程中，两项服务均需要联系授权服务器。 此授权服务器可以是 {{ site.data.keys.product }} 运行时。

用于配置此通信的管理服务的 JNDI 属性为：

* **mfp.admin.push.url** - 推送服务的 URL。
* **mfp.admin.authorization.server.url** - {{ site.data.keys.product }} 授权服务器的 URL。
* **mfp.admin.authorization.client.id** - 管理服务的客户端标识（作为 OAuth 保密客户端）。
* **mfp.admin.authorization.client.secret** - 用于获取基于 OAuth 的令牌的密码。

> 注：管理服务的 **mfp.push.authorization.client.id** 和 **mfp.push.authorization.client.secret** 属性可用于在启动管理服务时，将推送服务自动注册为保密客户端。 必须使用相同的值配置推送服务。

用于配置此通信的推送服务的 JNDI 属性为：

* **mfp.push.authorization.server.url** - {{ site.data.keys.product }} 授权服务器的 URL。 与 **mfp.admin.authorization.server.url** 属性相同。
* **mfp.push.authorization.client.id** - 用于联系授权服务器的推送服务的客户端标识。
* **mfp.push.authorization.client.secret** - 用于联系授权服务器的密码。

### {{ site.data.keys.mf_server }} 推送服务到外部推送通知服务（出站）
{: #mobilefirst-server-push-service-to-an-external-push-notification-service-outbound }
推送服务会生成到外部通知服务（如 Apple Push Notification Service (APNS) 或 Google Cloud Messaging (GCM)）的出站流量。 还可以通过代理完成此通信。 根据通知服务，必须设置以下 JNDI 属性：

* **push.apns.proxy**
* **push.gcm.proxy**

有关更多信息，请参阅 [{{ site.data.keys.mf_server }} 推送服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)。

### 移动设备到 {{ site.data.keys.product }} 运行时
{: #mobile-devices-to-mobilefirst-foundation-runtime }
移动设备可联系运行时。 此通信的安全性由应用程序以及所请求适配器的配置来决定。 有关更多信息，请参阅 [{{ site.data.keys.product_adj }} 安全框架](../../../authentication-and-security)。

## 对 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束
{: #constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics }
了解对各个 {{ site.data.keys.mf_server }} 组件和 {{ site.data.keys.mf_analytics }} 的约束，然后再决定服务器拓扑。

* [对 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)
* [对 {{ site.data.keys.mf_server }} 推送服务的约束](#constraints-on-mobilefirst-server-push-service)

### 关于 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束
{: #constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime }
了解每个服务器拓扑的管理服务、实时更新服务和运行时的约束和部署方式。

实时更新服务必须始终和管理服务一起安装在同一应用程序服务器上，如 [{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 实时更新服务](#mobilefirst-server-administration-service-to-mobilefirst-server-live-update-service)中所述。 必须按以下方式定义实时更新服务的上下文根：`/<adminContextRoot>config`。 例如，如果管理服务的上下文根为 **/mfpadmin**，那么实时更新服务的上下文根必须为 **/mfpadminconfig**。

您可以使用以下应用程序服务器拓扑：

* 独立服务器：WebSphere Application Server Liberty Pofile、Apache Tomcat 或 WebSphere Application Server Full Profile
* 服务器场：WebSphere Application Server Liberty Pofile、Apache Tomcat 或 WebSphere Application Server Full Profile
* WebSphere Application Server Network Deployment 单元
* Liberty 集合体

#### 部署方式
{: #modes-of-deployment }
根据您使用的应用程序服务器拓扑，您可以选择两种部署方式，在应用程序服务器基础架构中部署管理服务、实时更新服务和运行时。 在非对称部署中，运行时与管理和实时更新服务可以安装在不同的应用程序服务器上。

**对称部署**  
在对称部署中，必须在相同的应用程序服务器上安装 {{ site.data.keys.product }} 管理组件（{{ site.data.keys.mf_console }}、管理服务和实时更新服务应用程序）和运行时。

**非对称部署**  
在非对称部署中，运行时与 {{ site.data.keys.product }} 管理组件可以安装在不同的应用程序服务器上。  
只有 WebSphere Application Server Network Deployment 单元拓扑和 Liberty 集合体拓扑才支持非对称部署。

#### 选择拓扑
{: #select-a-topology }

* [独立服务器拓扑](#stand-alone-server-topology)
* [服务器场拓扑](#server-farm-topology)
* [Liberty 集合体拓扑](#liberty-collective-topology)
* [WebSphere Application Server Network Deployment 拓扑](#websphere-application-server-network-deployment-topologies)
* [在服务器场和 WebSphere Application Server Network Deployment 拓扑中使用逆向代理](#using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies)

### 独立服务器拓扑
{: #stand-alone-server-topology }
您可以为 WebSphere Application Server Full Profile、WebSphere Application Server Liberty Profile 和 Apache Tomcat 配置独立拓扑。
在此拓扑中，所有管理组件和运行时都部署在单个 Java 虚拟机 (JVM) 中。

![独立拓扑](standalone_topology.jpg)

如果只有一个 JVM，那么只能进行对称部署；对称部署具有以下特征：

* 可部署一个或多个管理组件。 每个 {{ site.data.keys.mf_console }}
都与一个管理服务和一个实时更新服务进行通信。
* 可部署一个或多个运行时。
* 一个 {{ site.data.keys.mf_console }} 可以管理多个运行时。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。

#### JNDI 属性配置
{: #configuration-of-jndi-properties }
必须使用某些 JNDI 属性，才能在管理服务与运行时之间启用 Java 管理扩展 (JMX) 通信，以及定义用于管理运行时的管理服务。 有关这些属性的详细信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)和 [{{ site.data.keys.product_adj }}运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)。

**独立 WebSphere Application Server Liberty Profile 服务器**  
以下全局 JNDI 属性是管理服务和运行时所必需的。

| JNDI 属性          | 值 |
|--------------------------|--------|
| mfp.topology.platform	   | Liberty |
| mfp.topology.clustermode | 独立 |
| mfp.admin.jmx.host       | WebSphere Application Server Liberty Profile 服务器的主机名。 |
| mfp.admin.jmx.port       | REST 接口的端口，即 WebSphere Application Server Liberty Profile 服务器的 server.xml 文件中的 `<httpEndpoint>` 元素中声明的 httpsPort 属性的端口。 该属性没有缺省值。 |
| mfp.admin.jmx.user       | WebSphere Application Server Liberty 管理员的用户名，必须与 WebSphere Application Server Liberty Profile 服务器的 server.xml 文件中的 `<administrator-role>` 元素中定义的名称相同。 |
| mfp.admin.jmx.pwd        | WebSphere Application Server Liberty 管理员用户的密码。 |

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。

部署多个管理组件时，必须指定：

* 在每个管理服务上，局部 **mfp.admin.environmentid** JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 **mfp.admin.environmentid** JNDI 属性值。

**独立 Apache Tomcat 服务器**
以下局部 JNDI 属性是管理服务和运行时所必需的。

| JNDI 属性        |	值    |
|------------------------|------------|
| mfp.topology.platform   | Tomcat     |
| mfp.topology.clustermode | 独立 |

还需要使用 JVM 属性来定义 Java 管理扩展 (JMX) 远程方法调用 (RMI)。 有关更多信息，请参阅[配置 Apache Tomcat 的 JMX 连接](../appserver/#apache-tomcat-prerequisites)。

如果 Apache Tomcat 服务器在防火墙背后运行，那么 **mfp.admin.rmi.registryPort** 和 **mfp.admin.rmi.serverPort**
JNDI 属性是管理服务所必需的。 请参阅[配置 Apache Tomcat 的 JMX 连接](../appserver/#apache-tomcat-prerequisites)。

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。  
部署多个管理组件时，必须指定：

* 在每个管理服务上，局部 mfp.admin.environmentid JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 mfp.admin.environmentid JNDI 属性值。

**独立 WebSphere Application Server
**  
以下局部 JNDI 属性是管理服务和运行时所必需的。

| JNDI 属性          | 值                 |
|--------------------------| -----------------------|
| mfp.topology.platform    | WAS                    |
| mfp.topology.clustermode | 独立             |
| mfp.admin.jmx.connector  | JMX 接口类型；该值可以是 SOAP 或 RMI。 |

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。  
部署多个管理组件时，必须指定：

* 在每个管理服务上，**局部 mfp.admin.environmentid** JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 **mfp.admin.environmentid** JNDI 属性值。

### 服务器场拓扑
{: #server-farm-topology }
您可以配置 WebSphere Application Server Full Profile、WebSphere Application Server Liberty Profile 或 Apache Tomcat 应用程序服务器的场。

场是一组部署了相同组件的独立服务器，在这些服务器之间共享相同的管理服务数据库和运行时数据库。 场拓扑支持在多个服务器之间分配 {{ site.data.keys.product }} 应用程序的负载。 场中的每个服务器都必须是同一类应用程序服务器的 Java 虚拟机 (JVM)；这里指的是同类服务器场。 例如，可以将包含多个 Liberty 服务器的集合配置为服务器场。 反过来，不能将 Liberty 服务器、Tomcat 服务器或独立的 WebSphere Application Server 的混用配置为服务器场。

在此拓扑中，所有管理组件（{{ site.data.keys.mf_console }}、管理服务和实时更新服务）和运行时都部署在场中的每个服务器上。

![服务器场拓扑](server_farm_topology.jpg)

此拓扑仅支持对称部署。 运行时和管理组件必须部署在场中的每个服务器上。 采用此拓扑的部署具有以下特征：

* 可部署一个或多个管理组件。 {{ site.data.keys.mf_console }}
的每个实例都与一个管理服务和一个实时更新服务进行通信。
* 管理组件必须部署在场中的所有服务器上。
* 可部署一个或多个运行时。
* 运行时必须部署在场中的所有服务器上。
* 一个 {{ site.data.keys.mf_console }} 可以管理多个运行时。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。 同一管理服务的所有已部署实例都共享相同的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。 同一实时更新服务的所有已部署实例都共享相同的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。 同一运行时的所有已部署实例都共享相同的运行时数据库模式。

#### JNDI 属性配置
{: #configuration-of-jndi-properties-1 }
必须使用某些 JNDI 属性，才能在相同服务器的管理服务与运行时之间启用 JMX 通信以及定义用于管理运行时的管理服务。 方便起见，下表列出了这些属性。 有关如何安装服务器场的指示信息，请参阅[安装服务器场](../appserver/#installing-a-server-farm)。 有关 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)和 [{{ site.data.keys.product_adj }}运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)。

**WebSphere Application Server Liberty Profile 服务器场**  
在场的每个服务器中，管理服务和运行时需要以下全局 JNDI 属性。

<table>
    <tr>
        <th>
            JNDI 属性
        </th>
        <th>
            值
        </th>
    </tr>
    <tr>
        <td>
            mfp.topology.platform
        </td>
        <td>
            Liberty
        </td>
    </tr>
    <tr>
        <td>
            mfp.topology.clustermode
        </td>
        <td>
            场
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.host
        </td>
        <td>
            WebSphere Application Server Liberty Profile 服务器的主机名
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.port
        </td>
        <td>
            REST 接口的端口，必须与 WebSphere Application Server Liberty Profile 服务器的 <b>server.xml</b>文件的 <code>httpEndpoint</code> 元素中声明的 httpsPort 属性值相同。 

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*" />
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.user
        </td>
        <td>
            在 WebSphere Application Server Liberty Profile 服务器的 <b>server.xml</b> 文件的 <code>administrator-role</code> 元素中定义的 WebSphere Application Server Liberty 管理员的用户名。
            
{% highlight xml %}
<administrator-role>
    <user>MfpRESTUser</user>
</administrator-role>
{% endhighlight %}        
        </td>
    </tr>
    <tr>
        <td>
            mfp.admin.jmx.pwd
        </td>
        <td>
            WebSphere Application Server Liberty 管理员用户的密码。
        </td>
    </tr>
</table>

管理服务需要使用 **mfp.admin.serverid** JNDI 属性来管理服务器场配置。 其值是服务器标识，场中的每个服务器的标识必须不同。

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。

部署多个管理组件时，必须指定：

* 在每个管理服务上，局部 mfp.admin.environmentid JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 **mfp.admin.environmentid** JNDI 属性值。

**Apache Tomcat 服务器场**  
在场的每个服务器中，管理服务和运行时需要以下全局 JNDI 属性。

| JNDI 属性          |	值 |
|--------------------------|-----------|
| mfp.topology.platform	   | Tomcat    |
| mfp.topology.clustermode | 场      |

还需要使用 JVM 属性来定义 Java 管理扩展 (JMX) 远程方法调用 (RMI)。 有关更多信息，请参阅[配置 Apache Tomcat 的 JMX 连接](../appserver/#apache-tomcat-prerequisites)。

管理服务需要使用 **mfp.admin.serverid** JNDI 属性来管理服务器场配置。 其值是服务器标识，场中的每个服务器的标识必须不同。

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。

部署多个管理组件时，必须指定：

* 在每个管理服务上，局部 mfp.admin.environmentid JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 **mfp.admin.environmentid** JNDI 属性值。

**WebSphere Application Server Full Profile 服务器场**  
在场中的每个服务器上，管理服务和运行时需要以下全局 JNDI 属性。

| JNDI 属性            | 值 |
|----------------------------|--------|
| mfp.topology.platform	WAS  | WAS    |
| mfp.topology.clustermode   | 场   |
| mfp.admin.jmx.connector    | SOAP   |

管理服务需要使用以下 JNDI 属性来管理服务器场配置。

| JNDI 属性    | 值 |
|--------------------|--------|
| mfp.admin.jmx.user | WebSphere Application Server 的用户名。 必须在 WebSphere Application Server 用户注册表中定义此用户。 |
| mfp.admin.jmx.pwd	 | WebSphere Application Server 用户的密码。 |
| mfp.admin.serverid | 服务器标识，场中的每个服务器的标识必须不同，并且必须与此服务器的服务器场配置文件中使用的该属性值相同。 |

可以部署多个管理组件以支持在用于管理不同运行时的不同管理组件上运行相同的 JVM。

部署多个管理组件时，必须指定以下值：

* 在每个管理服务上，局部 **mfp.admin.environmentid** JNDI 属性的唯一值。
* 在每个运行时上，与针对用于管理运行时的管理服务定义的值相同的局部 **mfp.admin.environmentid** JNDI 属性值。

### Liberty 集合体拓扑
{: #liberty-collective-topology }
您可以在 Liberty 集合体拓扑中部署 {{ site.data.keys.mf_server }} 组件。

在 Liberty 集合体拓扑中，{{ site.data.keys.mf_server }} 管理组件（{{ site.data.keys.mf_console }}、管理服务和实时更新服务）部署在集合体控制器中，而 {{ site.data.keys.product }} 运行时部署在集合体成员中。 该拓扑仅支持非对称部署，运行时不能部署在集合体控制器中。

![Liberty 集合体的拓扑](liberty_collective_topology.jpg)

采用此拓扑的部署具有以下特征：

* 一个或多个管理组件可以部署在一个或多个集合体控制器中。 * * {{ site.data.keys.mf_console }} 的每个实例都与一个管理服务和一个实时更新服务进行通信。
* 一个或多个运行时可以部署在集合体的集群成员中。
* 一个 {{ site.data.keys.mf_console }} 管理集合体集群成员中部署的多个运行时。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。

#### JNDI 属性配置
{: #configuration-of-jndi-properties-2 }
以下各表列出了一些 JNDI 属性，需要这些属性才能在管理服务与运行时之间启用 JMX 通信以及定义用于管理运行时的管理服务。 有关这些属性的更多信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)和 [{{ site.data.keys.product_adj }}运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)。 有关如何手动安装 Liberty 集合体的指示信息，请参阅[手动安装 WebSphere Application Server Liberty 集合体](../appserver/#manual-installation-on-websphere-application-server-liberty-collective)。

管理服务需要以下全局 JNDI 属性：

<table>
    <tr>
        <th>
            JNDI 属性
        </th>
        <th>
            值
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>集群</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>控制器</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>Liberty 控制器的主机名。</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>REST 接口的端口，必须与 Liberty 控制器的 server.xml 文件的 <code>httpEndpoint</code> 元素中声明的 <b>httpsPort</b> 属性值相同。

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>在 Liberty 控制器的 <b>server.xml</b> 文件的 <code>administrator-role</code> 元素中定义的控制器管理员用户名。

{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>Liberty 控制器管理员用户的密码。</td>
    </tr>
</table>

可以部署多个管理组件以支持控制器运行用于管理不同运行时的不同管理组件。

当部署多个管理组件时，必须在每个管理服务上为局部 **mfp.admin.environmentid** JNDI 属性指定唯一值。

运行时需要以下全局 JNDI 属性：

<table>
    <tr>
        <th>
            JNDI 属性
        </th>
        <th>
            值
        </th>
    </tr>
    <tr>
        <td>mfp.topology.platform</td>
        <td>Liberty</td>
    </tr>
    <tr>
        <td>mfp.topology.clustermode</td>
        <td>集群</td>
    </tr>
    <tr>
        <td>mfp.admin.serverid</td>
        <td>用于唯一标识集合体成员的值。 对于集合体中的每个成员，该值必须不同。 不能使用值 <code>controller</code>，因为该值专为集合体控制器保留。</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.host</td>
        <td>Liberty 控制器的主机名。</td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.port</td>
        <td>REST 接口的端口，必须与 Liberty 控制器的 server.xml 文件的 <code>httpEndpoint</code> 元素中声明的 <b>httpsPort</b> 属性值相同。

{% highlight xml %}
<httpEndpoint id="defaultHttpEndpoint" httpPort="9080" httpsPort="9443" host="*"/>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.user</td>
        <td>在 Liberty 控制器的 <b>server.xml</b> 文件的 <code>administrator-role</code> 元素中定义的控制器管理员用户名。

{% highlight xml %}
<administrator-role> <user>MfpRESTUser</user> </administrator-role>
{% endhighlight %}
        </td>
    </tr>
    <tr>
        <td>mfp.admin.jmx.pwd</td>
        <td>Liberty 控制器管理员用户的密码。</td>
    </tr>
</table>

当使用的若干个控制器（副本）使用同一个管理组件时，运行时需要以下 JNDI 属性：

| JNDI 属性 | 值 | 
|-----------------|--------|
| mfp.admin.jmx.replica | 使用以下语法指定不同控制器副本的端点列表：`replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` | 

当在控制器中部署了若干管理组件时，每个运行时的局部 **mfp.admin.environmentid** JNDI 属性值必须与针对用于管理该运行时的管理服务定义的值相同。

### WebSphere Application Server Network Deployment 拓扑
{: #websphere-application-server-network-deployment-topologies }
管理组件和运行时将部署在 WebSphere Application Server Network Deployment 单元的服务器或集群中。

这些拓扑示例支持非对称部署和/或对称部署。 例如，您可以在一个集群中部署管理组件（{{ site.data.keys.mf_console }}、管理服务和实时更新服务），而在另一个集群中部署这些组件所管理的运行时。

#### 在同一个服务器或集群中进行对称部署
{: #symmetric-deployment-in-the-same-server-or-cluster }
下图显示了对称部署，在这种部署中，运行时和管理组件部署在同一个服务器或集群中。

![WAS ND 的拓扑](was_nd_topology_1.jpg)

采用此拓扑的部署具有以下特征：

* 可以在单元的一个或多个服务器或集群中部署一个或多个管理组件。 * {{ site.data.keys.mf_console }} 的每个实例都与一个管理服务和一个实时更新服务进行通信。
* 可以将一个或多个运行时与用于管理这些运行时的管理组件部署在同一个服务器或集群中。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。

#### 非对称部署（运行时和管理服务位于不同的服务器或集群中）
{: #asymmetric-deployment-with-runtimes-and-administration-services-in-different-server-or-cluster }
下图显示了运行时与管理服务部署在不同的服务器或集群中的拓扑。

![WAS ND 的拓扑](was_nd_topology_2.jpg)

采用此拓扑的部署具有以下特征：

* 可以在单元的一个或多个服务器或集群中部署一个或多个管理组件。 * {{ site.data.keys.mf_console }} 的每个实例都与一个管理服务和一个实时更新服务进行通信。
* 可以在单元的其他服务器或集群中部署一个或多个运行时。
* 每个 {{ site.data.keys.mf_console }} 可以管理在单元的其他服务器或集群中部署的多个运行时。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。

此拓扑的优势在于它可以将运行时与管理组件和其他运行时分隔开。 它可用于提供性能隔离，以隔离关键应用程序并实施服务级别协议 (SLA)。

#### 对称部署和非对称部署
{: #symmetric-and-asymmetric-deployment }
下图显示了 Cluster1 中的对称部署示例和 Cluster2 中的非对称部署示例，其中 Runtime2 和 Runtime3 与管理组件部署在不同的集群中。 {{ site.data.keys.mf_console }} 管理 Cluster1 和 Cluster2 中部署的运行时。

![WAS ND 的拓扑](was_nd_topology_3.jpg)

采用此拓扑的部署具有以下特征：

* 可以在单元的一个或多个服务器或集群中部署一个或多个管理组件。 {{ site.data.keys.mf_console }}
的每个实例都与一个管理服务和一个实时更新服务进行通信。
* 可以在单元的一个或多个服务器或集群中部署一个或多个运行时。
* 每个 {{ site.data.keys.mf_console }} 可以管理在单元的相同或其他服务器或集群中部署的多个运行时。
* 每个运行时只能由一个 {{ site.data.keys.mf_console }} 进行管理。
* 每个管理服务都使用自己的管理数据库模式。
* 每个实时更新服务都使用其自己的实时更新数据库模式。
* 每个运行时都使用自己的运行时数据库模式。

#### JNDI 属性配置
{: #configuration-of-jndi-properties-3 }
必须使用某些 JNDI 属性，才能在管理服务与运行时之间启用 JMX 通信以及定义用于管理运行时的管理服务。 有关这些属性的详细信息，请参阅 [{{ site.data.keys.mf_server }}管理服务的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)和 [{{ site.data.keys.product_adj }}运行时的 JNDI 属性列表](../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)。

以下局部 JNDI 属性是管理服务和运行时所必需的：

| JNDI 属性 |	值 |
|-----------------|--------|
| mfp.topology.platform	| WAS |
| mfp.topology.clustermode | 集群 |
| mfp.admin.jmx.connector |	与 Deployment Manager 相连的 JMX 接口类型。 该值可以是 SOAP 或 RMI。 SOAP 是缺省值和首选值。 如果禁用 SOAP 端口，那么必须使用 RMI。 |
| mfp.admin.jmx.dmgr.host |	Deployment Manager 的主机名。 |
| mfp.admin.jmx.dmgr.port |	Deployment Manager 使用的 RMI 或 SOAP 端口（取决于 mfp.admin.jmx.connector 的值）。 |

可以部署多个管理组件，以支持运行相同的服务器或集群，并由单独的管理组件管理各个运行时。

部署多个管理组件时，必须指定：

* 在每个管理服务上，局部 **mfp.admin.environmentid** JNDI 属性的唯一值。
* 在每个运行时上，局部 **mfp.admin.environmentid** 的值与针对用于管该理运行时的管理服务定义的值相同。

如果映射到管理服务应用程序的虚拟主机不是缺省主机，那么必须在管理服务器应用程序上设置以下属性：

* **mfp.admin.jmx.user**：WebSphere Application Server 管理员的用户名
* **mfp.admin.jmx.pwd**：WebSphere Application Server 管理员的密码

### 在服务器场和 WebSphere Application Server Network Deployment 拓扑中使用逆向代理
{: #using-a-reverse-proxy-with-server-farm-and-websphere-application-server-network-deployment-topologies }
可以在分布式拓扑中使用逆向代理。 如果您的拓扑使用逆向代理，请为管理服务配置所需的 JNDI 属性。

可以在服务器场或 WebSphere Application Server Network Deployment 拓扑的前端使用逆向代理（例如，IBM HTTP Server）。 在此情况下，必须适当地配置管理组件。

可以通过以下方式调用逆向代理：

* 在访问 {{ site.data.keys.mf_console }} 时使用浏览器。
* 在调用管理服务时使用运行时。
* 在调用管理服务时使用 {{ site.data.keys.mf_console }} 组件。

如果逆向代理位于 DMZ（用于保护局域网的防火墙配置）中，并且在 DMZ 和内部网络之间使用了防火墙，那么此防火墙必须授权来自应用程序服务器的所有入局请求。

当在应用程序服务器基础结构的前端使用逆向代理时，必须为管理服务定义以下 JNDI 属性。

| JNDI 属性 |	值 |
|-----------------|--------|
| mfp.admin.proxy.protocol | 用于与逆向代理进行通信的协议。 可以为 HTTP 或 HTTPS。 |
| mfp.admin.proxy.host | 逆向代理的主机名。 |
| mfp.admin.proxy.port | 逆向代理的端口号。 |

引用逆向代理 URL 的 **mfp.admin.endpoint** 属性也是 {{ site.data.keys.mf_console }} 所必需的。

### {{ site.data.keys.mf_server }} 推送服务的约束
{: #constraints-on-mobilefirst-server-push-service }
推送服务与管理服务或运行时可位于相同应用程序服务器上，也可位于不同应用程序服务器上。 客户机应用程序用于联系推送服务的 URL 与客户机应用程序用于联系运行时的 URL 相同，只是将运行时的上下文根替换为 imfpush。 如果安装推送服务的服务器与安装运行时的服务器不同，那么 HTTP Server 必须将进入 /imfpush 上下文根的流量定向至运行推送服务的服务器。

有关根据拓扑调整安装所需的 JNDI 属性的更多信息，请参阅 [{{ site.data.keys.mf_server }} 管理服务到 {{ site.data.keys.mf_server }} 推送服务，再到授权服务器](#mobilefirst-server-administration-service-to-mobilefirst-server-push-service-and-to-the-authorization-server)。 必须使用上下文根 **/imfpush** 安装推送服务。

## 多个 {{ site.data.keys.product }} 运行时
{: #multiple-mobilefirst-foundation-runtimes }
可以安装多个运行时。 每个运行时都必须具有其自身的上下文根，并且所有这些运行时均由相同的 {{ site.data.keys.mf_server }} 管理服务和 {{ site.data.keys.mf_console }} 进行管理。

[{{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的约束](#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime)中描述的约束适用。 每个运行时（具有其上下文根）都必须具有其自身的数据库表。

> 有关指示信息，请参阅[配置多个运行时](../server-configuration/#configuring-multiple-runtimes)。

## 同一个服务器或 WebSphere Application Server 单元上的多个 {{ site.data.keys.mf_server }} 实例
{: #multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell }
通过定义公共环境标识，可以在同一个服务器上安装多个 {{ site.data.keys.mf_server }} 实例。

您可以在同一个应用程序服务器或 WebSphere Application Server 单元上安装 {{ site.data.keys.mf_server }} 管理服务、{{ site.data.keys.mf_server }} 实时更新服务和 {{ site.data.keys.product }} 运行时的多个实例。 但是，必须使用 JNDI 变量 **mfp.admin.environmentid** 来区分这些安装，此变量是管理服务和运行时的变量。 管理服务仅管理具有相同环境标识的运行时。 因此，只会将具有相同 **mfp.admin.environmentid** 值的运行时组件和管理服务视为同一个安装的一部分。
