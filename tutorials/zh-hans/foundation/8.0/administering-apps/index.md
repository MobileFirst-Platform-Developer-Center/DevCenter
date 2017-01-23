---
layout: tutorial
title: 管理应用程序
weight: 10
show_children: true
---
## 概述
{: #overview }
{{ site.data.keys.product_full }}    提供了多种方式，用于在开发或生产中管理 {{ site.data.keys.product_adj }}    应用程序。{{ site.data.keys.mf_console }}    是主要工具，可从基于 Web 的集中控制台中监控所有已部署的 {{ site.data.keys.product_adj }}    应用程序。

可通过 {{ site.data.keys.mf_console }}    执行的主要操作为：

* 配置移动应用程序并注册到 {{ site.data.keys.mf_server }}   。
* 配置适配器并部署到 {{ site.data.keys.mf_server }}   。
* 管理应用程序版本，以部署新版本或远程禁用旧版本。
* 管理移动设备和用户，以管理对特定设备的访问或特定用户对应用程序的访问。
* 在应用程序启动时显示通知消息。
* 监控推送通知服务。
* 收集特定设备上安装的特定应用程序的客户端日志。

## 管理角色
{: #administration-roles }
并非每种类型的管理用户都可以执行每种管理操作。{{ site.data.keys.mf_console }}    和所有管理工具，针对 {{ site.data.keys.product_adj }}    应用程序的管理定义了四种不同的角色。 

定义了以下 {{ site.data.keys.product_adj }}    管理角色：

**监控者**  
使用此角色，用户可以监控已部署的 {{ site.data.keys.product_adj }}    项目和已部署的工件。此角色为只读。

**操作员**  
操作员可以执行所有移动应用程序管理操作，但无法添加或除去应用程序版本或适配器。

**部署者** 
使用此角色，用户可以执行与操作员相同的操作，另外还可以部署应用程序和适配器。

**管理员**  
使用此角色，用户可以执行所有应用程序管理操作。

> 有关 {{ site.data.keys.product_adj }}  管理角色的更多信息，请参阅[配置 {{ site.data.keys.mf_server }}    管理的用户认证](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)。

## 管理工具
{: #administration-tools }
{{ site.data.keys.mf_console }}    并非管理 {{ site.data.keys.product_adj }}  应用程序的唯一方式。{{ site.data.keys.product }}   还提供了其他工具，可用于将管理操作合并到构建和部署过程。

有一套 REST 服务可用于执行管理操作。有关这些服务的 API 参考文档，请参阅 [{{ site.data.keys.mf_server }}  管理服务的 REST API](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html#restservicesapi)。

使用这套 REST 服务，可以执行与在 {{ site.data.keys.mf_console }}  中相同的操作。可以管理应用程序和适配器，以及上载应用程序的新版本或禁用旧版本，等等。

{{ site.data.keys.product_adj }}  应用程序也可以通过使用 Ant 任务或 **mfpadm** 命令行工具进行管理。请参阅[通过 Ant 管理 {{ site.data.keys.product_adj }}    应用程序](using-ant)或[通过命令行管理 {{ site.data.keys.product_adj }}    应用程序](using-cli)。

与基于 Web 的控制台相似，REST 服务、Ant 任务和命令行工具都是受保护的，需要您提供管理员凭证。

### 选择主题：
{: #select-a-topic }

