---
layout: tutorial
title: IBM Cloud Private 中的日志记录和跟踪
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 将错误、警告和参考消息记录到日志文件中。 日志记录的底层机制因应用程序服务器而异。 在 {{ site.data.keys.prod_icp }} 中，唯一支持的应用程序服务器为 Liberty。

以下文档阐述如何为在 {{ site.data.keys.prod_icp }} 上的 Kubernetes 集群中运行的 {{ site.data.keys.mf_server }} 启用跟踪和收集日志。


#### 跳转至：
{: #jump-to }
* [先决条件](#prereqs)
* [配置日志记录和监视机制](#configure-log-monitor)
* [收集 *kubectl* 日志](#collect-kubectl-logs)
* [使用 IBM 提供的定制脚本收集日志](#collect-logs-custom-script)


## 先决条件
{: #prereqs}

安装并配置日志收集和故障诊断所需的以下工具：
* Docker (`docker`)
* Kubernetes CLI (`kubectl`)

要为在 {{ site.data.keys.prod_icp }} 上运行的集群配置 `kubectl` 客户机，请遵循[此处](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html)描述的步骤。


## 配置日志记录和监视机制
{: #configure-log-monitor}

缺省情况下，所有的 {{ site.data.keys.product }} 日志记录都将记入应用程序服务器日志文件。 Liberty 中提供的标准工具可用于控制 {{ site.data.keys.product }} 服务器日志记录。 从[配置日志记录和监视机制](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)上的文档了解更多信息。

[配置日志记录和监视机制](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html)提供有关如何更新 `server.xml` 以配置日志记录的详细信息，并提供有关启用跟踪的信息。 使用过滤器 `com.ibm.ws.logging.trace.specification` 来选择性启用跟踪，[了解更多信息](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html)。 可通过 `jvm.option` 或在服务器实例的 `bootstrap.properties` 中指定此属性。

例如，在 `jvm.options` 中添加以下条目，将为以 `com.ibm.mfp` 开头的所有方法启用跟踪，并且跟踪级别将设置为 *all*。
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```
 您可以使用 JNDI 配置来设置此条目。 有关更多信息，请参阅[此处]({{ site.baseurl }}/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server)。


## 收集 *kubectl* 日志
{: #collect-kubectl-logs}

`kubectl logs` 命令可用于获取有关 Kubernetes 集群上已部署容器的信息。 例如，以下命令检索在命令中提供其 *pod_name* 的 pod 的日志：

```bash
kubectl logs po/<pod_name>
```
有关 `kubectl logs` 命令的更多信息，请参阅 [Kubernetes 文档](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/)。

## 使用 IBM 提供的定制脚本来收集日志
{: #collect-logs-custom-script}

可以使用脚本 [get-icp-logs.sh](get-icp-logs.sh) 来收集 {{ site.data.keys.mf_server }} 日志和容器日志。 它将 *Helm 发行版名称*作为输入，并从部署的所有 pod 收集日志。

可如下所示执行脚本：
```bash
get-icp-logs <helm_release_name> [<output_directory>] [<name_space>]
```
下表描述定制脚本使用的每个参数。

| 选项 | 描述 | 备注 |
|--------|-------------|---------|
| helm_release_name | 各个 Helm Chart 安装的发行版名称 | **必需** |
| output_directory | 放置所收集日志的输出目录 | **可选**<br/>缺省值：当前工作目录下的 **mfp-icp-logs**。 |
| name_space | 安装各个 Helm Chart 的名称空间 | **可选**<br/>缺省值：**default** |
