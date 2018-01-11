---
layout: tutorial
title: 故障诊断
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### 解决 Liberty for Java 运行时上 {{ site.data.keys.product_full }} 的问题	
{: resolving-problems-with-ibm-mobilefirst-foundation-on-liberty-for-java-runtime }
当无法解决使用 Liberty for Java 运行时上的 IBM MobileFirst Foundation 所遇到的问题时，请在联系 IBM 支持前确保收集以下关键信息。

为帮助加速故障诊断过程，请收集以下信息：

* 使用的 IBM MobileFirst Foundation 的版本（必须为 V8.0.0 或更高版本）和应用的任何临时修订。
* 所选 Liberty for Java 运行时的大小。 例如，2GB。
* Bluemix dashDB 数据库规划类型。 例如，EnterpriseTransactional 2.8.500。
* mfpconsole 路径
* Cloud Foundry 的版本：`cf -v` 
* 通过运行以下 Cloud Foundry CLI 命令从组织和空间（在其中部署 MobileFirst Foundation 服务器）返回的信息：
 - `cf app APP_NAME`

### 无法创建 mfpfsqldb.xml 文件
{: #unable-to-create-the-mfpfsqldbxml-file }
在 **prepareserverdbs.sh** 脚本运行结束时出现错误：

> Error : unable to create mfpfsqldb.xml

**解决方法**  
问题可能是间歇性数据库连接问题。 请尝试重新运行该脚本。

### 脚本失败并返回有关令牌的消息	
{: #script-fails-and-returns-message-about-tokens }
脚本运行失败，并返回类似 Refreshing cf tokens 或 Failed to refresh token 的消息。

**说明**  
Bluemix 会话可能已超时。 用户必须登录到 Bluemix，然后才能运行脚本。

**解决方法**
再次运行 initenv.sh 脚本以登录到 Bluemix，然后再次运行失败的脚本。

### 管理数据库、实时更新和推送服务显示为不活动	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
“管理数据库”、“实时更新”和“推送服务”显示为不活动或者 MobileFirst Foundation Operations Console 中未列出任何运行时，即使 **prepareserver.sh** 脚本成功完成也如此。

**说明**  
可能是因为未建立到数据库服务的连接，或者在部署期间附加其他值时，server.env 文件中出现了格式化问题。

如果向 server.env 文件添加了其他值，但却未使用换行符，那么将不会解析属性。 可通过检查日志文件，查找由于未解析的属性导致的类似如下的错误，证实这一潜在问题：

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**解决方法**  
手动重新启动 Liberty 应用程序。 如果问题仍然存在，请检查数据库服务的连接数是否超过了数据库计划规定的连接数。 如果是，请进行任何必要的调整，然后继续。

如果问题由未解析的属性导致，请确保您的编辑器在编辑任何提供的文件时都添加了换行 (LF) 符来区分行末。 例如，macOS 上的 TextEdit 应用程序使用 CR 字符而不是 LF 标记行末，这可能会导致问题。

