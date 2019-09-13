---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 React Native 应用程序
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
在此教程中，了解如何将 {{ site.data.keys.product_adj }} SDK 添加到使用 React Native CLI 创建的新的或现有的 React Native 应用程序。您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序，以及查找有关在项目中更改的 {{ site.data.keys.product_adj }} 配置文件的信息。

{{ site.data.keys.product_adj }} React Native SDK 作为 react native npm 插件提供，并且在 [NPM](https://www.npmjs.com/package/react-native-ibm-mobilefirst) 上注册。  

可用插件包括：

* **react-native-ibm-mobilefirst** - 核心 SDK 插件

#### 跳转至：
{: #jump-to }
- [React Native SDK 组件](#react-native-sdk-components)
- [添加 {{ site.data.keys.product_adj }} React Native SDK](#adding-the-mobilefirst-react-native-sdk)
- [更新 {{ site.data.keys.product_adj }} React Native SDK](#updating-the-mobilefirst-react-native-sdk)
- [已生成 {{ site.data.keys.product_adj }} React Native SDK 工件](#generated-mobilefirst-reactnative-sdk-artifacts)
- [接下来要学习的教程](#tutorials-to-follow-next)


## React Native SDK 组件
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
react-native-ibm-mobilefirst 插件是针对 React Native 的核心 {{ site.data.keys.product_adj }} 插件，且此插件是必需的。如果安装任何其他 {{ site.data.keys.product_adj }} 插件，并且 react-native-ibm-mobilefirst 插件尚未安装，那么也将自动安装此插件。

**先决条件：**

- 安装在开发人员工作站上的 [React Native CLI](https://www.npmjs.com/package/react-native) 和 {{ site.data.keys.mf_cli }}。
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 React Native 开发环境](../../../installation-configuration/development/reactnative)教程。

## 添加 {{ site.data.keys.product }} React Native SDK
{: #adding-the-mobilefirst-react-native-sdk }
遵循下面的指示信息将 {{ site.data.keys.product }} React Native SDK 添加到新的或现有的 React Native 项目，然后在 {{ site.data.keys.mf_server }} 中进行注册。

在您开始之前，确保 {{ site.data.keys.mf_server }} 正在运行。  
如果使用本地安装的服务器：从**命令行**窗口，浏览至服务器的文件夹，然后运行命令：`./run.sh`。

### 添加 SDK
{: #adding-the-sdk }

#### 新建应用程序
{: #new-application }
1. 创建 React Native 项目：`react-native init projectName`。  
   例如：

   ```bash
   react-native init Hello
   ```
     - *Hello* 是文件夹名称和应用程序名称。

    > 模板化的 **index.js** 使您能够使用其他 {{ site.data.keys.product_adj }} 功能，如[多语言应用程序翻译](../../translation)和初始化选项（请参阅用户文档以获取更多信息）。

2. 将目录切换至 React Native 项目的根目录：`cd hello`

3. 使用 NPM CLI 命令添加 MobileFirst 插件：`npm install react-native-plugin-name`
例如：

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > 上述命令会将 MobileFirst 核心 SDK 插件添加到 React native 项目。


4. 通过运行以下命令链接插件库：

   ```bash
   react-native link
   ```

#### 现有应用程序
{: #existing-application }

1. 浏览至现有 React Native 项目的根目录并添加 {{ site.data.keys.product_adj }} 核心 React Native 插件：

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. 通过运行以下命令链接插件库：

   ```bash
   react-native link
   ```

### 注册应用程序
{: #registering-the-application }

1. 打开**命令行**窗口并浏览至项目的特定平台（iOS 或 Android）的根目录。  

2. 向 {{ site.data.keys.mf_server }} 注册此应用程序：

   ```bash
   mfpdev app register
   ```

  * **iOS**：

    如果您的平台是 iOS，那么将请求您提供应用程序的 BundleID。**要点**：BundleID 是**区分大小写的**。

    `mfpdev app register` CLI 命令将先连接到 MobileFirst Server 以注册应用程序，然后在 Xcode 项目的根目录生成 **mfpclient.plist** 文件，并向该文件添加用来标识 MobileFirst Server 的元数据。

  *  **Android**：

      如果您的平台是 Android，那么将请求您提供应用程序的包名称。**要点**：包名称是**区分大小写的**。

       `mfpdev app register` CLI 命令先连接到 MobileFirst Server 以注册应用程序，之后在 Android Studio 项目的 **[project root]/app/src/main/assets/** 文件夹中生成 **mfpclient.properties** 文件，然后向其添加标识 MobileFirst Server 的元数据。


如果使用的是远程服务器，请[使用命令](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) `mfpdev server add` 进行添加。

`mfpdev app register` CLI 命令将先连接到 {{ site.data.keys.mf_server }} 以注册应用程序。会在 {{ site.data.keys.mf_server }} 中将每个平台注册为应用程序。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。  
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  


## 更新 {{ site.data.keys.product_adj }} React Native SDK
{: #updating-the-mobilefirst-react-native-sdk }
要使用最新发行版更新 {{ site.data.keys.product_adj }} React native SDK，请除去 **react-native-ibm-mobilefirst** 插件：运行 `npm uninstall react-native-ibm-mobilefirst` 命令，然后运行 `npm install react-native-ibm-mobilefirst` 命令以重新添加。

可以在 SDK 的 [NPM 存储库](https://www.npmjs.com/package/react-native-ibm-mobilefirst)中找到 SDK 发行版。

## 已生成 {{ site.data.keys.product_adj }} React Native SDK 工件
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Android 环境

#### mfpclient.properties
{: #mfpclient.properties }
此文件位于 Android Studio 项目的 **./app/src/main/assets/** 文件夹中，可定义用于在 {{ site.data.keys.mf_server }} 上注册 Android 应用程序的客户机端属性。

| 属性            | 描述                                                         | 示例值 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | 与
{{ site.data.keys.mf_server }}
的通信协议。             | http 或 https  |
| wlServerHost        | {{ site.data.keys.mf_server }} 的主机名。                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }} 的端口。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上应用程序的上下文根路径。 | /mfp/          |
| languagePreferences | 为客户机 sdk 系统消息设置缺省语言。           | zh             |


### iOS 环境

#### mfpclient.plist
{: #mfpclientplist }
此文件位于项目的根目录中，定义用于在 {{ site.data.keys.mf_server }} 上注册 iOS 应用程序的客户机端属性。

| 属性            | 描述                                                         | 示例值 |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | 与
{{ site.data.keys.mf_server }}
的通信协议。             | http 或 https  |
| host        | {{ site.data.keys.mf_server }} 的主机名。                            | 192.168.1.63   |
| port        | {{ site.data.keys.mf_server }} 的端口。                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上应用程序的上下文根路径。 | /mfp/          |
| languagePreferences | 为客户机 sdk 系统消息设置缺省语言。           | zh             |


## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product_adj }} React Native SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
