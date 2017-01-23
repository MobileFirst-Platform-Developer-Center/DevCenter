---
layout: tutorial
title: 故障诊断
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### 解决使用 IBM Containers 上的 {{ site.data.keys.product_full }} 时遇到的问题	
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
当无法解决使用 IBM Containers 上的 {{ site.data.keys.product_full }} 所遇到的问题时，请在联系 IBM 支持前确保收集以下关键信息。

为帮助加速故障诊断过程，请收集以下信息：

* 使用的 {{ site.data.keys.product }} 的版本（必须为 V8.0.0 或更高版本）和应用的任何临时修订。
* 所选容器大小。例如，Medium 2GB。
* Bluemix dashDB 数据库规划类型。例如，EnterpriseTransactional 2.8.50。
* 容器标识
* 公共 IP 地址（如果指定）
* Docker 和 Cloud Foundry 的版本：`cf -v` 和 `docker version`
* 通过运行以下 IBM Containers (cf ic) 的 Cloud Foundry CLI 插件 (cf
ic) 命令从组织和空间（在其中部署 {{ site.data.keys.product }} 容器）返回的信息：
 - `cf ic info`
 - `cf ic ps -a`（如果列出多个容器实例，那么确保指示具有问题的实例。）
* 如果在容器创建（在运行 **startserver.sh** 脚本时）期间启用了 Secure Shell (SSH) 和卷，那么收集以下文件夹中的所有文件：/opt/ibm/wlp/usr/servers/mfp/logs and /var/log/rsyslog/syslog
* 如果仅启用卷而不启用 SSH，那么使用 Bluemix 仪表板收集可用日志信息。在单击 Bluemix 仪表板中的容器实例后，单击侧边栏中的监控和日志链接。转至“日志记录”选项卡，然后单击“高级视图”。Kibana 仪表板将单独打开。使用搜索工具栏，搜索异常堆栈跟踪，然后收集异常 @time-stamp,
_id 的完整详细信息。

### 运行脚本期间出现的 Docker 相关错误	
{: #docker-related-error-while-running-script }
如果在执行 initenv.sh 或  prepareserver.sh 脚本后遇到 Docker 相关错误，请尝试重新启动 Docker 服务。

**示例消息** 

> Pulling repository docker.io/library/ubuntu  
> Error while pulling image: Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS message ID mismatch

**说明**  
在因特网连接发生更改（例如，连接到 VPN 或与 VPN 断开连接，或者网络配置发生更改）且 Docker 运行时环境尚未重新启动时，可能发生错误。在此场景中，在发出任何 Docker 命令时可能发生错误。

**解决方法**  
重新启动 Docker 服务。如果错误仍存在，请重新引导计算机，然后重新启动 Docker 服务。

### Bluemix 注册表错误	
{: #bluemix-registry-error }
如果在执行 prepareserver.sh 或  prepareanalytics.sh 脚本之后遇到注册表相关错误，那么首先尝试运行 initenv.sh 脚本。

**说明**  
通常，在 prepareserver.sh 或  prepareanalytics.sh 脚本运行期间发生的任何网络问题可能导致处理挂起，然后失败。

**解决方法**  
首先，再次运行 initenv.sh 脚本以登录到 Bluemix 上的容器注册表。然后，重新运行之前失败的脚本。

### 无法创建 mfpfsqldb.xml 文件
{: #unable-to-create-the-mfpfsqldbxml-file }
在 **prepareserverdbs.sh** 脚本运行结束时出现错误：

> Error : unable to create mfpfsqldb.xml

**解决方法**  
问题可能是间歇性数据库连接问题。请尝试重新运行该脚本。


### 推送映像耗时过长	
{: #taking-a-long-time-to-push-image }
运行 prepareserver.sh 脚本时，将映像推送到 IBM Containers 注册表花费了 20 多分钟。

**说明**  
**prepareserver.sh** 脚本会推送整个 {{ site.data.keys.product }} 堆栈，这需要 20 到 60 分钟的时间。

**解决方法**  
如果 60 分钟过后脚本仍未完成，该进程可能因连接问题而挂起。
在重新建立稳定的连接后，重新启动该脚本。

### “绑定未完成”错误	
{: #binding-is-incomplete-error }
在运行脚本以启动容器（例如，**startserver.sh** 或 **startanalytics.sh**）时，由于“绑定未完成”错误，系统会提示您手动绑定 IP 地址。

**说明**  
脚本被设计为在特定持续时间过后退出。

**解决方法**  
通过运行相关的 cf ic 命令来手动绑定 IP 地址。例如，cf ic ip bind。

如果手动绑定 IP 地址失败，请确保容器的状态为正在运行，然后尝试再次绑定。  
**注：**容器必须为正在运行状态才能够成功绑定。

### 脚本失败并返回有关令牌的消息	
{: #script-fails-and-returns-message-about-tokens }
脚本运行失败，并返回类似 Refreshing cf tokens 或 Failed to refresh token 的消息。

**说明**  
Bluemix 会话可能已超时。用户必须登录到 Bluemix，然后才能运行容器脚本。

**解决方法**
再次运行 initenv.sh 脚本以登录到 Bluemix，然后再次运行失败的脚本。

### 管理数据库、实时更新和推送服务显示为不活动	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
“管理数据库”、“实时更新”和“推送服务”显示为不活动或者 {{ site.data.keys.mf_console }} 中未列出任何运行时，即使 **prepareserver.sh** 脚本成功完成也如此。

**说明**  
可能是因为未建立到数据库服务的连接，或者在部署期间附加其他值时，server.env 文件中出现了格式化问题。


如果向 server.env 文件添加了其他值，但却未使用换行符，那么将不会解析属性。
可通过检查日志文件，查找由于未解析的属性导致的类似如下的错误，证实这一潜在问题：


> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**解决方法**  
手动重新启动容器。如果问题仍然存在，请检查数据库服务的连接数是否超过了数据库计划规定的连接数。如果是，请进行任何必要的调整，然后继续。


如果问题由未解析的属性导致，请确保您的编辑器在编辑任何提供的文件时都添加了换行 (LF) 符来区分行末。例如，macOS 上的 TextEdit 应用程序使用 CR 字符而不是 LF 标记行末，这可能会导致问题。

### prepareserver.sh 脚本失败	
{: #prepareserversh-script-fails }
**prepareserver.sh** 脚本失败并返回错误 405 Method Not Allowed。

**说明**  
在运行 **prepareserver.sh** 脚本以将映像推送到 IBM Containers 注册表时发生以下错误。

> Pushing the {{ site.data.keys.mf_server }} image to the IBM Containers registry..  
> Error response from daemon:  
> 405 Method Not Allowed  
> Method Not Allowed  
> The method is not allowed for the requested URL.

如果修改了主机环境上的 Docker 变量，那么通常会发生此错误。在执行 initenv.sh 脚本后，工具提供选项来覆盖本地 Docker 环境从而使用本机 Docker 命令连接到 IBM Containers。

**解决方法**  
请勿修改 Docker 变量（例如，DOCKER\_HOST 和 DOCKER\_CERT\_PATH）以指向 IBM Containers 注册表环境。要使 **prepareserver.sh** 脚本正确工作，Docker 变量必须指向本地 Docker 环境。
