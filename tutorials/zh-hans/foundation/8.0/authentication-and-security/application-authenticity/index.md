---
layout: tutorial
title: 应用程序真实性
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

为了正确保护应用程序，请启用预定义的{{ site.data.keys.product_adj }}应用程序真实性[安全检查](../#security-checks) (`appAuthenticity`)。 在启用后，在向应用程序提供任何服务之前，此检查会先验证该应用程序的真实性。 生产环境中的应用程序应启用此功能。

要启用应用程序真实性，可遵循 **{{ site.data.keys.mf_console }}** → **[您的应用程序]** → **真实性**中的屏幕说明，或查看以下信息。

#### 可用性
{: #availability }
* 应用程序真实性在 Cordova 和本机应用程序中的所有受支持平台（iOS、Android、Windows 8.1 Universal、Windows 10 UWP）上均可用。

#### 限制
{: #limitations }
* 应用程序真实性在 iOS 中不支持**位码**。 因此，在使用应用程序真实性之前，请在 Xcode 项目属性中禁用位码。

#### 跳转至：
{: #jump-to }
- [应用程序真实性流程](#application-authenticity-flow)
- [启用应用程序真实性](#enabling-application-authenticity)
- [配置应用程序真实性](#configuring-application-authenticity)
- [构建时密钥 (BTS)](#bts)
- [故障诊断](#troubleshooting)
  - [重置](#reset)
  - [验证类型](#validation)
  - [支持 SDK V8.0.0.0-MFPF-IF201701250919 或更早版本](#legacy)

## 应用程序真实性流程
{: #application-authenticity-flow }
在应用程序注册到 {{ site.data.keys.mf_server }} 期间会执行应用程序真实性安全检查，这在应用程序的实例首次尝试连接到服务器时发生。 缺省情况下，不会再次运行真实性检查。

在启用应用程序真实性后，如果客户需要在其应用程序中引入任何更改，那么必须升级应用程序版本。

请参阅[配置应用程序真实性](#configuring-application-authenticity)，了解如何定制此行为。

## 启用应用程序真实性
{: #enabling-application-authenticity }
要在应用程序中启用应用程序真实性：

1. 在您最喜爱的浏览器中打开 {{ site.data.keys.mf_console }}。
2. 从导航侧边栏中选择应用程序，然后单击**真实性**菜单项。
3. 切换**状态**框中的**开启/关闭**按钮。

![启用应用程序真实性](enable_application_authenticity.png)

MobileFirst Server 在首次尝试连接到服务器时验证应用程序的真实性。要将此验证同样应用于受保护资源，请将 `appAuthenticity` 安全性检查添加到保护范围。

### 禁用应用程序真实性
{: #disabling-application-authenticity }
在开发期间对应用程序的一些更改可能会导致真实性验证失败。 因此，建议在开发过程中禁用应用程序真实性。 生产环境中的应用程序应启用此功能。

要禁用应用程序真实性，请在**状态**框中将**开启/关闭**按钮切换回“关闭”。

## 配置应用程序真实性
{: #configuring-application-authenticity }
缺省情况下，仅在客户机注册期间检查应用程序真实性。 但是，正如其他任何安全性检查一样，您可以遵循[保护资源](../#protecting-resources)中的指示信息，通过从控制台执行 `appAuthenticity` 安全性检查来保护应用程序或资源。

您可以使用以下属性配置预定义的应用程序真实性安全检查：

- `expirationSec`：缺省为 3600 秒/1 小时。 定义真实性令牌到期前的持续时间。

完成真实性检查后，直到令牌到期（根据设定值）才会重新进行。

#### 要配置 `expirationSec` 属性，请执行以下操作：
{: #to-configure-the-expirationsec property }
1. 装入 {{ site.data.keys.mf_console }}，导航至 **[您的应用程序] ** → **安全性** → **安全性-检查配置**，然后单击**新建**。

2. 搜索 `appAuthenticity` 作用域元素。

3. 设置新值（秒）。

![在控制台中配置 expirationSec 属性](configuring_expirationSec.png)

## 构建时密钥 (BTS)
{: #bts }
构建时密钥 (BTS) 是**用于增强真实性验证的可选工具**（仅适用于 iOS 应用程序）。 该工具在应用程序中插入在构建时确定的密钥，稍后用于真实性验证过程。

可以从 **{{ site.data.keys.mf_console }}** → **下载中心**下载 BTS 工具。

要在 Xcode 中使用 BTS 工具：
1. 在**构建阶段**选项卡中单击 **+** 按钮并创建新的**运行脚本阶段**。
2. 复制 BTS 工具的路径并将其粘贴到新建的“运行脚本阶段”中。
3. 将运行脚本阶段拖至**编译源代码**阶段上方。

应在构建应用程序的生产版本时使用该工具。

## 故障诊断
{: #troubleshooting }

### 重置
{: #reset }
应用程序真实性算法在验证过程中会使用应用程序数据和元数据。 在启用应用程序真实性之后连接到服务器的第一个设备将提供应用程序的“指纹”，其中包含该数据的部分内容。

可以通过为算法提供新数据来重置该指纹。 在开发期间（例如，在 Xcode 中更改应用程序之后）这可能会很有用。 要重置指纹，请从 [**mfpadm** CLI](../../administering-apps/using-cli/) 运行 **reset** 命令。

在重置指纹之后，appAuthenticity 安全性检查将继续按照以前的方式执行（这对用户而言是透明的）。

### 验证类型
{: #validation }

Mobile First Platform Foundation 为应用程序提供静态和动态应用程序真实性。这些验证类型在用于生成应用程序真实性种子值的算法和属性方面有所不同。缺省情况下，启用应用程序真实性之后，将使用**动态**验证算法。两种验证类型都可确保应用程序的安全性。动态应用程序真实性使用严格的验证并检查应用程序的真实性。对于静态应用程序真实性，我们使用略微宽松的算法，该算法不会使用动态应用程序真实性中所使用的所有验证检查。

可通过 MobileFirst Console 配置动态应用程序真实性。内部算法负责根据在控制台中选择的选项生成应用程序真实性数据。
对于静态应用程序真实性，需要使用 [**mfpadm** CLI](../../administering-apps/using-cli/)。

要启用静态应用程序真实性以及在验证类型之间切换，请使用 [**mfpadm** CLI](../../administering-apps/using-cli/)：

```bash
mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```
`TYPE` 可以是 `dynamic` 或 `static`。

### 支持 SDK V8.0.0.0-MFPF-IF201701250919 或更早版本
{: #legacy }
**2017 年 2 月或更高版本**中发布的客户机 SDK 仅支持动态和静态验证类型。 对于 SDK V**8.0.0.0-MFPF-IF201701250919 或更早版本**，请使用旧应用程序真实性工具：

必须使用 mfp-app-authenticity 工具签署应用程序二进制文件。 合格的二进制文件有：`ipa`（针对 iOS）、`apk`（针对 Android）和 `appx`（针对 Windows 8.1 Universal 和 Windows 10 UWP）。

1. 通过 **{{ site.data.keys.mf_console }} → 下载中心**来下载 mfp-app-authenticity 工具。
2. 打开**命令行**窗口并运行以下命令：`java -jar path-to-mfp-app-authenticity.jar path-to-binary-file`

   例如：

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   此命令可在 `MyBankApp.ipa` 文件旁生成一个名为 `MyBankApp.authenticity_data` 的 `.authenticity_data` 文件。
3. 使用 [**mfpadm** CLI](../../administering-apps/using-cli/) 上载 `.authenticity_data` 文件：
  ```bash
  app version [RUNTIME-NAME] APP-NAME ENVIRONMENT VERSION set authenticity-data FILE
  ```
