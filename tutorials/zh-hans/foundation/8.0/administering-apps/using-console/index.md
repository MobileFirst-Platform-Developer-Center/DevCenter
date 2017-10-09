---
layout: tutorial
title: 通过 MobileFirst Operations Console 管理应用程序
breadcrumb_title: 使用控制台管理
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
您可以通过锁定应用程序或拒绝访问或者显示通知消息，通过 {{ site.data.keys.mf_console }} 来管理 {{ site.data.keys.product_adj }} 应用程序。

您可以通过输入以下任一 URL 启动控制台：

* 用于生产或测试的安全方式：`https://hostname:secure_port/mfpconsole`
* 开发：`http://server_name:port/mfpconsole`

您必须具有授权您访问
{{ site.data.keys.mf_console }} 的登录名和密码。有关更多信息，请参阅[配置 {{ site.data.keys.mf_server }} 管理的用户认证](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)。

可以使用 {{ site.data.keys.mf_console }} 管理应用程序。

从 {{ site.data.keys.mf_console }}中，您也可以访问分析控制台，并控制移动数据的收集，供分析服务器分析。有关更多信息，请参阅[从 {{ site.data.keys.mf_console }} 启用或禁用数据收集](../../analytics/console/#enabledisable-analytics-support)。

#### 跳转至
{: #jump-to }

* [移动应用程序管理](#mobile-application-management)
* [应用程序状态和令牌许可](#application-status-and-token-licensing)
* [运行时环境上操作的错误日志](#error-log-of-operations-on-runtime-environments)
* [管理操作的审计日志](#audit-log-of-administration-operations)

## 移动应用程序管理
{: #mobile-application-management }
{{ site.data.keys.product_adj }} 移动应用程序管理功能为 {{ site.data.keys.mf_server }} 操作员和管理员提供针对用户和设备访问其应用程序的精细控制能力。

{{ site.data.keys.mf_server }} 可跟踪所有对移动基础架构的访问尝试过程，并可存储有关应用程序、用户以及安装应用程序的设备的信息。应用程序、用户与设备间的映射构成服务器的移动应用程序管理功能的基础。

使用 {{ site.data.keys.mf_console }} 来监控和管理资源访问：

* 按名称搜索用户，并查看有关用于访问资源的设备和应用程序的信息。
* 按显示名称搜索设备，并查看与设备关联的用户以及该设备上使用的已注册 {{ site.data.keys.product_adj }} 应用程序。
* 阻止从特定设备上的所有应用程序实例访问资源。当设备丢失或失窃时，这将非常有用。
* 仅阻止访问特定设备上的特定应用程序的资源。例如，如果员工更换了部门，那么可以阻止员工访问先前部门的应用程序，但允许员工从同一设备上的其他应用程序进行访问。
* 注销设备并删除为设备收集的所有注册和监控数据。

阻止访问功能具有以下特征：

* 阻止操作是可逆的。可通过在 {{ site.data.keys.mf_console }} 中更改设备或应用程序状态来除去阻止功能。
* 阻止功能仅适用于受保护资源。被阻止客户端仍可以使用应用程序来访问不受保护的资源。请参阅“不受保护的资源”。
* 选择此操作时，将立即阻止访问 {{ site.data.keys.mf_server }} 上的适配器资源。但是，对于外部服务器上的资源可能不会如此，因为应用程序仍可能具有未到期的有效访问令牌。

### 设备状态
{: #device-status }
{{ site.data.keys.mf_server }} 保留了可访问服务器的每台设备的状态信息。可能的状态值有**活动**、**丢失**、**失窃**、**到期**和**禁用**。

缺省设备状态为**活动**，它指示未阻止从该设备访问。可以将状态更改为**丢失**、**失窃**或**禁用**，以阻止从设备访问应用程序资源。可以始终恢复**活动**状态以允许重新访问。请参阅[在 {{ site.data.keys.mf_console }} 中管理设备访问](#managing-device-access-in-mobilefirst-operations-console)。

自上一次设备连接到该服务器实例起经过预配置非活动时段后，**到期**状态为 {{ site.data.keys.mf_server }} 设置的特殊状态。此状态用于跟踪许可证，并且不会影响设备访问权。当状态为**到期**的设备重新连接到服务器时，其状态会恢复为**活动**，并将授权设备访问服务器。

### 设备显示名称
{: #device-display-name }
{{ site.data.keys.mf_server }} 可按 {{ site.data.keys.product_adj }} 客户机 SDK 分配的唯一设备标识来识别设备。设置设备的显示名称允许您按其显示名称搜索设备。应用程序开发者可使用 `WLClient` 类的 `setDeviceDisplayName` 方法来设置设备显示名称。请参阅 [{{ site.data.keys.product_adj }}客户端 API](../../api/client-side-api/javascript/client/) 中的 `WLClient` 文档。（JavaScript 类为 `WL.Client`。）Java 适配器开发者（包含安全检查开发者）还可以使用 com.ibm.mfp.server.registration.external.model `MobileDeviceData` 类的 `setDeviceDisplayName` 方法来设置设备显示名称。请参阅 [MobileDeviceData](../../api/client-side-api/objc/client/)。

### 在 {{ site.data.keys.mf_console }} 中管理设备访问
{: #managing-device-access-in-mobilefirst-operations-console }
要监控和管理设备对资源的访问，请选择 {{ site.data.keys.mf_console }} 仪表板中的“设备”选项卡。

使用搜索字段来按与设备关联的用户标识或按设备的显示名称（如果已设置）搜索设备。请参阅[设备显示名称](#device-display-name)。还可以搜索用户标识或设备显示名称的某一部分（至少有三个字符）。

搜索结果会显示与指定用户标识或设备显示名称相匹配的所有设备。对于每台设备，您都可以看到设备标识和显示名称、设备型号、操作系统以及与设备关联的用户标识列表。

“设备状态”列显示设备的状态。可以将设备状态更改为**丢失**、**失窃**或**禁用**，以阻止从该设备访问受保护资源。将状态更改回**活动**，将恢复原始访问权。

可选择**操作**列中的**注销**来注销设备。
注销设备会删除设备上安装的所有 {{ site.data.keys.product_adj }} 应用程序的注册数据。此外，还会删除设备显示名称、与设备关联的用户列表以及应用程序为该设备注册的公共属性。

**注：****注销**操作是不可逆的。下一次设备上的其中一个 {{ site.data.keys.product_adj }} 应用程序尝试访问服务器时，将使用新的设备标识重新注册。选择重新注册设备时，设备状态将设置为**活动**，并且无论先前阻止情况如何，设备都有权访问受保护资源。因此，如果要阻止设备，请不要注销。相反，应将设备状态更改为**丢失**、**失窃**或**禁用**。

要查看特定设备上访问的所有应用程序，请选择设备表中的设备标识旁的展开箭头图标。所显示的应用程序表中的每一行均包含应用程序名称以及应用程序的访问状态（无论是否为该设备上的该应用程序启用受保护资源访问功能）。可以将应用程序状态更改为**禁用**，以专门阻止从该设备上的应用程序进行访问。

#### 跳转至
{: #jump-to-1 }

* [远程禁用应用程序对受保护资源的访问权](#remotely-disabling-application-access-to-protected-resources)
* [显示管理员消息](#displaying-an-administrator-message)
* [定义多种语言的管理员消息](#defining-administrator-messages-in-multiple-languages)

### 远程禁用应用程序对受保护资源的访问权
{: #remotely-disabling-application-access-to-protected-resources }
使用 {{ site.data.keys.mf_console }}（控制台）可禁止用户访问特定移动操作系统上应用程序的特定版本，并向用户提供定制消息。

1. 从控制台的导航侧边栏的**应用程序**部分中选择应用程序版本，然后选择应用程序**管理**选项卡。
2. 将状态更改为**已禁用访问**。
3. 在**最新版本的 URL** 字段中，可选择为更新版本的应用程序提供 URL（通常在相应的公共或专用应用程序商店中）。对于某些环境，Application Center 提供一个 URL，用于直接访问应用程序版本的“详细信息”视图。
请参阅[应用程序属性](../../appcenter/appcenter-console/#application-properties)。
4. 在**缺省通知消息**字段中，添加当用户尝试访问应用程序时要显示的定制通知消息。以下样本消息会指导用户升级至最新版本：


   ```bash
不再支持此版本。请升级至最新版本。
```

5. 在**受支持的语言环境**部分中，可选择以其他语言提供通知消息。
6. 选择**保存**以应用您的更改。

当用户运行远程禁用的应用程序时，将显示一个包含定制消息的对话框窗口。需要访问受保护资源的任何应用程序交互或应用程序尝试获取访问令牌时，都将显示此消息。如果提供了版本升级 URL，那么除缺省**关闭**按钮外，此对话框还有一个**获取新版本**按钮，用于升级至更新版本。如果用户在不升级版本的情况下关闭对话框窗口，那么他可以继续处理应用程序的某些部分，无需访问受保护资源。但是，需要访问受保护资源的任何应用的交互过程都会导致再次显示对话框窗口，并且也未授权应用程序访问资源。

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### 显示管理员消息
{: #displaying-an-administrator-message }
请遵循所述过程来配置通知消息。可使用此消息向应用程序用户通知临时情况（如计划的服务停机时间）。

1. 从 {{ site.data.keys.mf_console }} 导航侧边栏的**应用程序**部分中选择应用程序版本，然后选择应用程序“管理”选项卡。
2. 将状态更改为**激活并通知**。
3. 添加定制启动消息。以下样本消息将通知用户对应用程序进行计划的维护工作：


   ```bash
   The server will be unavailable on Saturday between 4 AM to 6 PM due to planned maintenance.
   ```

4. 在受支持的语言环境部分中，可选择以其他语言提供通知消息。

5. 选择**保存**以应用您的更改。

应用程序初次使用 {{ site.data.keys.mf_server }} 访问受保护资源或获取访问令牌时，将显示此消息。如果应用程序在启动时获取访问令牌，那么将在此阶段显示此消息。否则，应用程序发出要访问受保护资源或获取访问令牌的第一条请求时，将显示此消息。初次交互时，消息仅显示一次。

### 定义多种语言的管理员消息
{: #defining-administrator-messages-in-multiple-languages }
<b>注：</b>在 Microsoft Internet Explorer (IE) 和 Microsoft Edge 中，将根据操作系统的区域格式首选项而不根据配置的浏览器或操作系统显示语言首选项来显示管理消息。请参阅 [IE 和 Edge Web 应用程序限制](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge)。请遵循所述过程配置多种语言，以显示您通过控制台定义的应用程序管理消息。这些消息将基于设备的语言环境发送，并且必须符合移动操作系统用于指定语言环境的标准。

1. 从 {{ site.data.keys.mf_console }} 导航侧边栏的**应用程序**部分中选择应用程序版本，然后选择应用程序**管理**选项卡。
2. 选择**激活并通知**或**已禁用访问**状态。
3. 选择**更新语言环境**。在所显示的对话框窗口的**上载文件**部分中，选择**上载**，然后浏览至定义语言环境的 CSV 文件的位置。


   CSV 文件中的每一行均包含一对逗号分隔字符串。第一个字符串为语言环境代码（如 fr-FR 表示法语（法国），en 表示英语），第二个字符串为对应的语言形式的消息文本。指定的语言环境代码必须符合移动操作系统用于指定语言环境的标准，如 ISO 639-1、ISO 3166-2 和 ISO 15924。

   > **注：**要创建 CSV 文件，必须使用支持 UTF-8 编码的编辑器（如记事本）。

   以下是为多个语言环境定义相同消息的样本 CSV 文件：


   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. 在**验证通知消息**部分中，可从 CSV 文件查看语言环境代码和消息的表格。验证消息，然后选择**确定**。可以随时选择“编辑”以替换语言环境 CSV 文件。还可以使用该选项来上载空的 CSV 文件以除去所有语言环境。
5. 选择**保存**以应用您的更改。

根据设备语言环境，用户的移动设备上会显示本地化通知消息。如未对设备语言环境配置消息，那么将显示您提供的缺省消息。

## 应用程序状态和令牌许可
{: #application-status-and-token-licensing }
在因缺少足够令牌而导致“已阻止”状态后，您必须在 {{ site.data.keys.mf_console }} 中手动恢复正确的应用程序状态。

如果您采用的是令牌许可，但是不再有足够的许可证令牌用于应用程序，那么该应用程序的所有版本的应用程序状态都将更改为**已阻止**。您将无法再更改该应用程序任何版本的该状态。
{{ site.data.keys.mf_console }}中显示以下消息：

```bash
The application got blocked because its license expired
```

如果之后有足够的令牌可用于运行该应用程序，或者贵组织购买了更多令牌，那么将会在 {{ site.data.keys.mf_console }}中显示以下消息：

```bash
The application got blocked because its license expired but a license is available now
```

显示状态仍然为**已阻止**。您必须通过编辑“状态”字段，手动从存储空间或您自己的记录中恢复正确的当前状态。{{ site.data.keys.product }} 不管理因许可证令牌不足而被阻止的应用程序在 {{ site.data.keys.mf_console }}中显示的**已阻止**状态。
您应当自行将此类已阻止应用程序恢复为可通过 {{ site.data.keys.mf_console }}显示的实际状态。

## 运行时环境上操作的错误日志
{: #error-log-of-operations-on-runtime-environments }
使用错误日志可访问在选择的运行时环境中从 {{ site.data.keys.mf_console }} 或命令行启动的失败管理操作以及查看失败对服务器产生的影响。

事务失败时，状态栏中会显示错误通知和一个到错误日志的链接。
使用错误日志获取有关该错误的更多详细信息（例如，具有特定错误消息的每台服务器的状态），或者获取错误的历史记录。
在错误日志中，最新的操作显示在前面。

通过单击 {{ site.data.keys.mf_console }} 中运行时环境的**错误日志**来访问错误日志。

展开涉及失败操作的行，以访问有关每个服务器当前状态的更多信息。要访问完整的日志，请单击**下载日志** 以下载日志。

![控制台中的错误日志](error-log.png)

## 管理操作的审计日志
{: #audit-log-of-administration-operations }
在 {{ site.data.keys.mf_console }} 中，您可以参考管理操作的审计日志。

{{ site.data.keys.mf_console }} 允许您访问针对登录、注销和所有管理操作（如部署应用程序或适配器或者锁定应用程序）的审计日志。可通过在 {{ site.data.keys.product_adj }} 管理服务的 Web 应用程序上将 **mfp.admin.audit** Java 命名和目录接口 (JNDI) 属性设置为 **false** 来禁用审计日志。

要访问审计日志，请单击标题栏中的用户名，选择**关于**，单击**其他支持信息**，然后选择**下载审计日志**。

| 字段名称| 描述|
|------------|-------------|
| Timestamp	 | 记录的创建日期和时间。|
| Type	     | 操作的类型。请参阅下面的操作类型列表以获取可能值。|
| User	     | 已登录用户的**用户名**。|
| Outcome	 | 操作的结果；可能值为 SUCCESS、ERROR 以及 PENDING。|
| ErrorCode	 | 如果结果为 ERROR，那么 ErrorCode 指示是什么错误。|
| Runtime	 | 与操作相关联的 {{ site.data.keys.product_adj }} 项目的名称。|

以下列表显示了操作类型的可能值。

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime
