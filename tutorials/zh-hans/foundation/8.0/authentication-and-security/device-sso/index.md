---
layout: tutorial
title: 配置设备单点登录 (SSO)
breadcrumb_title: Device SSO
relevantTo: [android,ios,windows,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 提供单点登录 (SSO) 功能，支持在同一设备上的多个应用程序间共享任何定制安全性检查的状态。 例如，通过使用设备 SSO，用户可成功登录到其设备上的一个应用程序，也可以在使用同一实现的相同设备上的其他应用程序上进行认证。

**先决条件**：确保阅读[认证和安全](../)教程。

## 配置 SSO
{: #configuring-sso }
在 {{ site.data.keys.mf_console }} 中：

1. 导航至**[您的应用程序] →“安全”选项卡 → 安全性检查配置**部分。
2. 单击**新建**按钮以创建新的安全性检查配置，或在安全性检查配置已存在的情况下单击**编辑**图标。
3. 在**配置安全性检查属性**对话框中，将**启用设备 SSO** 设置设定为 **true**，然后按`确定`。

对您想要为其启用设备 SSO 的每个应用程序重复这些步骤。

<img class="gifplayer" alt="在 {{ site.data.keys.mf_console }} 中配置设备 SSO" src="enable-device-sso.png"/>

您还可以使用必需的配置来手动编辑应用程序的配置 JSON 文件，并将更改推送回 {{ site.data.keys.mf_server }}。

1. 从**命令行窗口**导航至项目的根文件夹，然后运行 `mfpdev app pull`。
2. 打开位于 **[project-folder]\mobilefirst** 文件夹的配置文件。
3. 编辑文件，为所选定制安全性检查启用设备 SSO：通过将定制安全性检查的 `enableSSO` 属性设置为 `true` 来启用设备 SSO。 该属性配置包含在 `securityCheckConfigurations` 对象中嵌套的安全性检查对象内。 在应用程序描述符文件中查找这些对象，如果缺失，就创建这些对象。 例如：

   ```xml
   "securityCheckConfigurations": {
        "UserAuthentication": {
            ...
            ...
            "enableSSO": true
        }
   }
   ```
   
4. 运行以下命令来部署更新的配置 JSON 文件：`mfpdev app push`。

## 将设备 SSO 与预先存在的样本一起使用
{: #using-device-sso-with-a-pre-existing-sample }
阅读[凭证验证](../credentials-validation/)教程，因为其样本用于配置设备 SSO。  
对于此演示，将使用 Cordova 样本应用程序，但也可以使用 iOS、Android 和 Windows 样本应用程序完成相同的操作。

1. 遵循[样本使用指示信息](../credentials-validation/javascript/#sample-usage)。
2. 使用不同的样本名称和应用程序标识重复这些步骤。
3. 在相同的设备上运行两个应用程序。 请注意在每个应用程序中是如何提示您输入 PIN 码 ("1234") 的。
4. 如上所指示，在 {{ site.data.keys.mf_console }} 中，针对每个应用程序将`启用设备 SSO` 设置为 `true`。
5. 退出两个应用程序，然后重试。 在打开的第一个应用程序中，会提示您点击**获取余额**按钮来输入 PIN 码一次。 打开第二个应用程序并点击**获取余额**按钮后，无需再次输入 PIN 码来获取余额。
`
请注意，`PinCodeAttempts` 安全性检查有一个 60 秒到期令牌。 因此，在 60 秒过后再次尝试后，第二个应用程序将需要 PIN 码。

![PIN 码 Cordova 样本应用程序](pincode-attempts-cordova.png)
