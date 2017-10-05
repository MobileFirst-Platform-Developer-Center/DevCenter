---
layout: tutorial
title: 临时修订中的新增内容
breadcrumb_title: 临时修订
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
临时修订中提供一些修补程序和更新，用于纠正问题并且使 {{ site.data.keys.product_full }} 针对新的移动操作系统发行版来说始终为最新状态。

临时修订是累积式的。 下载最新的 V8.0 临时修订，即表示您已获得较早临时修订中的所有修订。

下载并安装最新临时修订，以获得以下部分中描述的所有修订。 如果安装较早的修订，那么可能无法获得此处描述的所有修订。

> 要获取 {{ site.data.keys.product }} 8.0 的临时修订发行版的列表，[请参阅此处的博客帖子]({{site.baseurl}}/blog/tag/iFix_8.0/)。

如果列示了 APAR 编号，那么可以通过在临时修订 README 文件中搜索该 APAR 编号来确认该临时修订中是否具有此功能。

### 许可
{: #licensing }
#### PVU 许可
{: #pvu-licensing }
可通过处理器价值单元 (PVU) 许可获取新产品：{{ site.data.keys.product }} Extension V8.0.0。 有关 {{ site.data.keys.product }} Extension 的 PVU 许可的更多信息，请参阅[许可 {{ site.data.keys.product_adj }}](../../licensing)。

### Web 应用程序
{: #web-applications }
#### 从 {{ site.data.keys.mf_cli }} 注册 Web 应用程序 (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
现在，您可以通过使用 {{ site.data.keys.mf_cli }} (mfpdev) 作为从 {{ site.data.keys.mf_console }} 注册的替代方法来向 {{ site.data.keys.mf_server }} 注册客户机 Web 应用程序。 有关更多信息，请参阅从 {{ site.data.keys.mf_cli }} 注册 Web 应用程序。

### Cordova 应用程序
{: #cordova-applications }
#### 从具有 Studio 插件的 Eclipse 打开 Cordova 项目的本机 IDE。
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
通过在 Eclipse IDE 中安装 Studio 插件，可以在 Android Studio 或 Xcode 中从 Eclipse 接口打开现有 Cordova 项目，以构建和运行此项目。

#### 使用“迁移辅助 (Migration Assistance)”工具时，添加了 *projectName* 目录作为选项
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
使用迁移辅助工具迁移项目时，可以为 Cordova 项目目录指定名称。 如果不提供名称，那么缺省名称为 *app_name-app_id-version*。

#### 针对“迁移辅助”工具的易用性改进
{: #usability-improvements-to-the-migration-assistance-tool }
通过进行如下更改，改进了“迁移辅助”工具的易用性：

* “迁移辅助”工具会扫描 HTML 文件和 JavaScript 文件。
* 扫描完成后，会在缺省浏览器中自动打开扫描报告。
* *--out* 标记为可选。 如果未指定此标记，将使用工作目录。
* 指定 *--out* 标记并且此目录不存在时，将创建此目录。

### 适配器
{: #adapters }
#### 为 Java 和 JavaScript 适配器配置添加了 `mfpdev push` 和 `pull` 命令
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
可以使用 {{ site.data.keys.mf_cli }} 来将 Java 和 JavaScript 适配器配置推送到 {{ site.data.keys.mf_server }}，并从 {{ site.data.keys.mf_server }} 中提取适配器配置。

### Application Center
{: #application-center}

基于 Cordova 的应用程序中心客户端现在可用于 iOS 和 Android。
