---
layout: tutorial
title: 日志和跟踪收集
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
IBM Containers for Bluemix 围绕着容器 CPU、内存和网络提供一些内置日志记录和监控功能。 您可以选择更改 {{ site.data.keys.product_adj }} 容器的日志级别。

缺省情况下，已启用为 {{ site.data.keys.mf_server }}、{{ site.data.keys.mf_analytics }} 和 {{ site.data.keys.mf_app_center }} 容器创建日志文件的选项（使用级别 `*=info`）。您可通过手动添加代码覆盖或使用给定的脚本文件插入代码，对日志级别进行更改。 可通过 Kibana 可视化工具从 Bluemix logmet 控制台查看容器日志和服务器或运行时日志。 可通过 Grafana（开放式源代码度量仪表板和图形编辑器）从 Bluemix logmet 控制台进行监控。

在使用 Secure Shell (SSH) 密钥创建 {{ site.data.keys.product_adj }} 容器并绑定到公共 IP 地址时，可使用适合的专用密钥以安全地查看容器实例的日志。

### 日志记录覆盖
{: #logging-overrides }
您可通过手动添加代码覆盖或使用给定的脚本文件插入代码，对日志级别进行更改。 通过手动添加代码覆盖更改日志级别，必须在您首次准备映像时完成。 您必须将新的日志记录配置作为独立的配置片段添加到 **package\_root/mfpf-[analytics|server]/usr/config** 文件夹和 **package_root/mfp-appcenter/usr/config** 文件夹，这会复制到 Liberty 服务器上的 configDropins/overrides 文件夹中。

使用给定脚本文件插入代码来更改日志级别，可以在运行 V8.0.0 程序包中提供的任何 start\*.sh 脚本文件（**startserver.sh**、**startanalytics.sh**、**startservergroup.sh**、**startanalyticsgroup.sh**、**startappcenter.sh** 或 **startappcentergroup.sh**）时通过特定命令行参数来完成。以下可选命令行参数适用：

* `[-tr|--trace]` trace_specification
* `[-ml|--maxlog]` maximum\_number\_of\_log\_files
* `[-ms|--maxlogsize]` maximum\_size\_of\_log\_files

## 容器日志文件
{: #container-log-files }
针对 {{ site.data.keys.mf_server }} 和 Liberty Profile 运行时活动为每个容器实例生成日志文件，日志文件可位于以下位置：

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

针对 {{ site.data.keys.mf_app_center }} Server 和 Liberty Profile 运行时活动为每个容器实例生成日志文件，日志文件可位于以下位置：

* /opt/ibm/wlp/usr/servers/appcenter/logs/messages.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/console.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/trace.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/ffdc/*

您可以通过遵循访问日志文件中的步骤登录到容器并访问日志文件。

要持久存储日志文件，甚至在容器不再存在后仍然保留日志文件，请启用卷。 （缺省情况下，未启用卷。） 启用卷也可允许您使用 logmet 界面（例如，https://logmet.ng.bluemix.net/kibana）查看 Bluemix 的日志。

**启用卷**
卷支持容器持久存储日志文件。 缺省情况下，针对 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analyics }} 容器日志未启用卷。

在运行 **start*.sh** 脚本时，可通过将 `ENABLE_VOLUME [-v | --volume]` 设置为 `Y` 启用卷。也可在 **args/startserver.properties** 和 **args/startanalytics.properties** 文件中针对脚本的交互式执行进行配置。

持久存储的日志文件保存在容器的 **/var/log/rsyslog** 和 **/opt/ibm/wlp/usr/servers/mfp/logs** 文件夹中。  
可通过向容器发出 SSH 请求来访问日志。

## 访问日志文件
{: #accessing-log-files }
针对每个容器实例都会创建日志。 您可以通过 `cf ic` 命令或者使用 Bluemix logmet 控制台，使用 IBM Container 云服务 REST API 来访问日志文件。

### IBM Container 云服务 REST API
{: #ibm-container-cloud-service-rest-api }
对于任何容器实例，可使用 [Bluemix logmet 服务](https://logmet.ng.bluemix.net/kibana/)查看 **docker.log** 和 **/var/log/rsyslog/syslog**。 可使用相同的 Kibana 仪表板查看日志活动。

IBM Containers CLI 命令 (`cf ic exec`) 可用于获取正在运行的容器实例的访问权。 此外，您可以通过 Secure Shell (SSH) 获取容器日志文件。

### 启用 SSH
{: #enabling-ssh}
要启用 SSH，请先将 SSH 公用密钥复制到 **package_root/[mfpf-server 或 mfpf-analytics]/usr/ssh** 文件夹，然后再运行 **prepareserver.sh** 或 **prepareanalytics.sh** 脚本。 这将构建启用 SSH 的映像。 从此特定映像创建的任何容器将已启用 SSH。

如果未作为映像定制的一部分启用 SSH，那么在执行 **startserver.sh** 或 **startanalytics.sh** 脚本时可使用 SSH\_ENABLE 和 SSH\_KEY 参数针对容器启用 SSH。 您可以选择定制相关脚本 .properties 文件以包含关键内容。

容器日志端点获取具有指定的容器实例标识的 stdout 日志。

示例：`GET /containers/{container_id}/logs`

#### 从命令行访问容器
{: #accessing-containers-from-the-command-line }
您可以从命令行访问正在运行的 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 容器实例以获取日志和跟踪。

1. 通过运行以下命令在容器实例中创建交互式终端：`cf ic exec -it container_instance_id "bash"`。
2. 要查找日志文件或跟踪，请使用以下命令示例：

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
   container_instance@root# vi messages.log
   ```

3. 要将日志复制到本地工作站，请使用以下命令示例：

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### 使用 SSH 访问容器
{: #accessing-containers-using-ssh }
您可以使用 Secure Shell (SSH) 来访问 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 容器以获取系统日志和 Liberty 日志。

如果正在运行容器组，那么可以将公共 IP 地址绑定到每个实例并使用 SSH 安全地查看日志。 要启用 SSH，确保先将 SSH 公用密钥复制到 **mfp-server\server\ssh** 文件夹，然后再运行 **startservergroup.sh** 脚本。

1. 向容器发出 SSH 请求。 示例：`mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. 归档日志文件位置。 示例：

```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

将日志归档下载到本地工作站。 示例：

```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
