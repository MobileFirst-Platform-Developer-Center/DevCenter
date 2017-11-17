---
layout: tutorial
title: 迁移现有的 Cordova 和混合应用程序
breadcrumb_title: Cordova 和混合
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要迁移使用 IBM MobileFirst Foundation V6.2.0 或更高版本创建的现有 Cordova 或混合应用程序，必须创建 Cordova 项目以使用当前版本中的插件。 然后，替换 V8.0 中停用或不包含的客户端 API。 迁移辅助工具可帮助您执行此任务。

#### 跳至：
{: #jump-to }
* [使用 V8.0 开发的 Cordova 应用程序与使用 V7.1 及更低版本开发的 Cordova 应用程序的比较](#comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before)
* [将现有混合或跨平台应用程序迁移到 {{ site.data.keys.product_full }} 8.0 支持的 Cordova 应用程序](#migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80)
* [为 iOS Cordova 迁移加密](#migrating-encryption-for-ios-cordova)
* [迁移“直接更新”](#migrating-direct-update)
* [升级 WebView](#upgrading-the-webview)
* [已移除的组件](#removed-components)

## 使用 V8.0 开发的 Cordova 应用程序与使用 V7.1 及更低版本开发的 Cordova 应用程序的比较
{: #comparison-of-cordova-apps-developed-with-v-80-versus-v-71-and-before }
将使用 {{ site.data.keys.product_adj }} V8.0 开发的 Cordova 应用程序与使用 IBM MobileFirst Platform Foundation V7.1 开发的 Cordova 和混合应用程序进行比较。

| 功能 | 使用 IBM <br/>{{ site.data.keys.product }} v8.0 开发的 Cordova 应用程序 |	使用 IBM<br/>MobileFirst Platform Foundation V7.1 开发的 Cordova 应用程序 | 使用 IBM<br/>MobileFirst Platform Foundation V7.1 开发的混合应用程序 |
|---------|-------|---------|-------|------|
| **IDE Eclipse Studio** | | | |  	 	 
| Eclipse 插件和集成 | 是 | 不支持 | 是（专用） |
| 应用程序组件 | 是 (Cordova)<br/><br/>注：创建您自己的 Cordova 插件以管理贵组织中的应用程序组件。 | 是 (Cordova)<br/><br/>注：创建您自己的 Cordova 插件以管理贵组织中的应用程序组件。 | 是（专用） |
| 项目模板 | 是 (Cordova)<br/><br/>注：使用 Apache Cordova `cordova create --template` 命令。 | 是 (Cordova)<br/><br/>注：使用 `mfp cordova create --template` 或 Apache Cordova 命令 `cordova create --copy-from` | 是（专用） |
| Dojo 和 jQuery IDE 检测 | 是<br/><br/>注：可在 Cordova 应用程序中使用的 JavaScript 框架包括 Dojo 和 jQuery Mobile。 | 是<br/><br/>注：可在 Cordova 应用程序中使用的 JavaScript 框架包括 Dojo 和 jQuery Mobile。 | 是 |
| 移动 UI 模式 | 不支持 | 不支持 | 不推荐 |
| **应用程序子类型** | | |
| shell 组件 | 不支持<br/><br/>注：如果先前混合应用程序使用 shell 和内部应用程序，那么建议采用 Cordova 设计模式，并将 shell 组件作为可以跨应用程序共享的 Cordova 插件进行实施。 | 不支持 | 是 |
| 内部混合应用程序 | 不支持<br/><br/>注：如果先前混合应用程序使用 shell 和内部应用程序，那么建议采用 Cordova 设计模式，并将 shell 组件作为可以跨应用程序共享的 Cordova 插件进行实施。 | 不支持 | 是 |
| **应用程序功能部件** | | | 	 	 	 
| 移动操作系统	| iOS 8 或更高版本、Android 4.1 或更高版本、Windows Phone 8.1 和 Windows Phone 10。 | iOS 7 或更高版本、Android 4 或更高版本。 | iOS、Android 和 Windows Phone 8 |
| Web 应用程序 | 是，用作未使用 Apache Cordova 开发的 JavaScript 应用程序。 | 不支持 | 是，用作 desktopbrowser 或 mobilewebapp 环境。 |
| 直接更新 | 是。 | 是 | 是 |
| {{ site.data.keys.product_adj }}安全框架 | 是 | 是 | 是 |
| 应用程序真实性 | 是 | 是 | 是 |
| 证书锁定 | 是 | 否 | 是 |
| JSONStore | 是。 | 使用 cordova-plugin-mfp-jsonstore 插件。 | 是 |
| FIPS 140-2 | 是。 使用 cordova-plugin-mfp-fips 插件。<br/><br/>限制：Android 和 iOS 都支持 FIPS。 Windows 不支持 FIPS。 | 否 | 是 |
| 加密与应用程序二进制文件中应用程序关联的 Web 资源 | 是 |	否 | 是 |
| 每次应用程序开始运行时，使用校验和验证 Web 资源的完整性 | 是 | 不支持 | 是 |
| 为可寻址设备许可证跟踪指定应用程序目标类别（B2E 或 B2C） | 是 | 否 | 是 |
| 简单数据共享 | 否 | 是 | 是 |
| 单点登录 | 是<br/><br/>注：现在，可通过新的预定义 enableSSO 安全性检查应用程序描述符配置属性来支持设备单点登录 (SSO) | 是 | 是 |
| {{ site.data.keys.product_adj }}应用程序外观 | 否<br/><br/>注：要检测并处理不同的设备屏幕大小，请使用标准的 Web 开发做法，如响应式 Web 设计 | 否<br/><br/>注：要检测并处理不同的设备屏幕大小，请使用标准的 Web 开发做法，如响应式 Web 设计。 | 是 |
| 环境优化 | 是 (Cordova)。 |  使用 merges 目录定义特定于平台的 Web 资源。 | 是 (Cordova)。 使用 merges 目录定义特定于平台的 Web 资源。 有关更多信息，请参阅 Apache Cordova 文档中的“使用 merges 定制每个平台”。 |
| 推送通知 | 是。 使用 cordova-plugin-mfp-push 插件。<br/><br/>限制：您只可以将预定义的 {{ site.data.keys.product_adj }} 安全性检查映射到 push.mobileclient 作用域。 不支持定制安全性检查，因为未调用 JavaScript 验证问题处理程序。 | 是<br/><br/>注：对于 Android，您必须添加 cordova-plugin-mfp-push 插件。 您不需要对 iOS 使用此插件，因为针对 iOS 的推送客户端支持已包含在核心 mfp 插件中。 | 是 |
| Cordova 插件管理 | 是 | 是 | 否 |
| 消息 (i18n) | 是 | 是 | 是 |
| 令牌许可 | 是 | 是 | 是 |
| **应用程序优化** | | |
| 缩小 | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是（专用） |
| 并置 JS 和 CSS | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是（专用） |
| 模糊化 | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是 (Cordova)<br/><br/>注：使用常用的开放式源代码工具。 | 是（专用） |
| Android Pro Guard | 是<br/><br/>注：{{ site.data.keys.product }} V8.0.0 不包含预定义的 proguard-project.txt 配置文件，该配置文件用于对 {{ site.data.keys.product_adj }} Android 应用程序进行 Android ProGuard 模糊处理。 | 是<br/><br/>注：请参阅 Android 文档以启用 Pro Guard。 | 是 |

## 将现有混合或跨平台应用程序迁移到 {{ site.data.keys.product }} 8.0 支持的 Cordova 应用程序
{: #migrating-existing-hybrid-or-cross-platform-apps-to-cordova-apps-supported-by-mobilefirst-foundation-80 }
您可以将使用 IBM MobileFirst Platform Foundation V6.2 或更高版本开发的现有混合或跨平台 (Cordova) 应用程序迁移到 {{ site.data.keys.product }} V8.0 支持的 Cordova 应用程序。

#### 跳转到相关部分
{: #jump-to-section }
* [使用迁移辅助工具启动 Cordova 应用程序迁移](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)
* [完成 {{ site.data.keys.product_adj }} 混合应用程序的迁移](#completing-migration-of-a-mobilefirst-hybrid-app)
* [完成 {{ site.data.keys.product_adj }} Cordova 应用程序的迁移](#completing-migration-of-a-mobilefirst-cordova-app)

### 使用迁移辅助工具启动 Cordova 应用程序迁移
{: #starting-the-cordova-app-migration-with-the-migration-assistance-tool }
迁移辅助工具可帮助您准备通过 {{ site.data.keys.product_adj }} 的更低版本创建的跨平台应用程序进行迁移，方法是识别不再有效的 API 并将项目复制到 V8.0 支持的 Cordova 应用程序。

使用迁移辅助工具之前，务必了解以下信息：

* 您必须拥有现有的 IBM MobileFirst Platform Foundation 混合应用程序或者使用 `mfp cordova create` 命令创建的 Cordova 应用程序。
* 您必须具有因特网访问权。
* 您必须已安装 node.js V4.0.0 或更高版本。
* 您必须已安装 Cordova 命令行界面 (CLI)，并且安装对目标平台使用 Cordova CLI 所需的任何必备软件。 有关更多信息，请参阅 Apache Cordova Web 站点中的 [The Command-Line Interface](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)。
* 查看并了解迁移过程的限制。 有关更多信息，请参阅[从较早发行版迁移应用程序](../)。

针对使用较早版本的 IBM MobileFirst Platform Foundation 命令创建的跨平台应用程序或使用 IBM MobileFirst Platform Foundation 命令创建的 Cordova 应用程序，在未进行一些更改的情况下在 V8.0 中不受支持。 迁移辅助工具可通过以下功能简化此过程：

* 扫描现有混合应用程序或使用 IBM MobileFirst Platform Foundation 应用程序开发的 Cordova 应用程序中的 JavaScript 和 HTML 文件，识别 V8.0 中不推荐使用、不再支持或修改的 API。
* 将初始混合应用程序或使用 IBM MobileFirst Platform Foundation 应用程序开发的 Cordova 应用程序的结构、脚本和配置文件复制到 V8.0 中支持的 Cordova 结构。

迁移辅助工具不会修改或移动应用程序的任何开发人员代码或注释。 您必须在运行此工具之后通过[完成 MobileFirst 混合应用程序的迁移](#completing-migration-of-a-mobilefirst-hybrid-app)或[完成 MobileFirst Cordova 应用程序的迁移](#completing-migration-of-a-mobilefirst-cordova-app)来继续迁移过程。

<!--1. Download the migration assistance tool by using one of the following methods:
    * Download the .tgz file from the [Git repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli).
    * Download the {{ site.data.keys.mf_dev_kit }}, which contains the migration assistance tool as a file named mfpmigrate-cli.tgz, from the MobileFirst Operations Console.
    * Download the tool by using the instructions that are provided. -->
1. 安装迁移辅助工具。
    * 切换至下载 .tgz 文件的目录。
    * 通过输入以下命令，使用 NPM 安装该工具：

   ```bash
   npm install -g tgz_filename
   ```
      有关 **mfpmigrate-cli** npm 包的详细信息，请单击[此处](https://www.npmjs.com/package/mfpmigrate-cli)。
2. 通过输入以下命令来扫描和复制 IBM MobileFirst Platform Foundation 应用程序：

   ```bash
   mfpmigrate client --in source_directory --out destination_directory --projectName new-project-directory
   ```

   * **source_directory**  
   您正在迁移的项目的当前位置。 在混合应用程序中，这应当指向应用程序的 **application** 文件夹。
   * **destination_directory**    
   与 V8.0 兼容的新 Cordova 结构所输出的目录的可选名称。 此目录是 **new-project-directory** 文件夹的父目录。 如果未指定，那么将在运行命令的目录中创建此文件夹。
   * **new-project-directory**
   项目新内容所在的文件夹的可选名称。
   此文件夹位于 *destination_directory* 文件夹中，包含 Cordova 应用程序的所有信息。如果未指定此选项，那么缺省名称为 `app_name-app_id-version`。
   <br/>
   与 client 命令一起使用时，迁移辅助工具会完成以下操作：  
        * 识别现有 IBM MobileFirst Platform Foundation 应用程序中在 V8.0 中已移除、不推荐使用或更改的 API。
        * 根据初始应用程序的结构创建 Cordova 结构。
        * 视情况复制或添加以下项：
            * Android 操作系统
            * iPhone 和 iPad 操作系统
            * Windows 操作系统
            * Cordova-mfp-plugin
            * Cordova-plugin-mfp-jsonstore 插件（如果在旧项目上安装了 JSONStore 功能部件）。
            * Cordova-plugin-mfp-fips 插件（如果在旧项目上安装了 FIPS 功能部件）。
            * Cordova-plugin-mfp-push 插件（如果在旧项目上安装了推送通知功能部件）。
            * 混合证书（如果在旧项目上启用了证书锁定）。
            * 应用程序、脚本和 XML 文件
		* 完成该命令后，在缺省浏览器中打开生成的信息文件。

        > **要点：**迁移辅助工具不会将开发人员代码或注释文本复制到新结构。
3. 在新 Cordova 应用程序中解决 API 问题。
    * 查看 **api-report.html** 文件，该文件在 **destination_directory** 目录中创建，并且在完成该命令时将在缺省浏览器中打开。 此文件中每个表行标识应用程序中使用的、与 V8.0 不兼容的一个不推荐使用、更改或移除的 API。 此文件还指定已移除 API 的替换项（如果可用）。

    | 文件路径 | 行号 | API | 行内容 | API 更改的类别 | 描述和操作项 |
    |-----------|-------------|-----|--------------|------------|-----------|
    | c:\local\Cordova\www\js\index.js |	15 | `WL.Client.getAppProperty` | {::nomarkdown}<ul><li><code>document.getElementById('app_version')</code></li><li><code>textContent = WL.Client.getAppProperty("APP_VERSION");</code></li></ul>{:/} | 不受支持 | 已从 8.0 移除。 使用 Cordova 插件以获取应用程序版本。 无替换 API。 |

    * 解决 **api-report.html** 文件中确定的 API 问题。
4. 将开发人员代码从初始应用程序结构手动复制到新 Cordova 结构中的正确位置。 根据源 IBM MobileFirst Platform Foundation 应用程序的类型，复制以下目录中的内容：
    * **IBM MobileFirst Platform Foundation 混合应用**  
    将源应用程序的 **common** 目录内容复制到新 Cordova 应用程序中的 **www** 目录。
    * **使用 IBM MobileFirst Platform Foundation 应用程序开发的 Cordova 应用程序**
    将源应用程序的 **www** 目录内容复制到新 Cordova 应用程序中的 **www** 目录。
5. 针对新应用程序使用 scan 命令运行迁移辅助工具，以确认 API 更改是否完成。
    * 输入以下命令以运行扫描：

      ```bash
      mfpmigrate scan --in source_directory --out destination_directory --type hybrid
      ```
        * **source_directory**  
        要扫描的文件的当前位置。 在 IBM MobileFirst Platform Foundation 混合应用程序中，此位置为应用程序的 **common** 目录。在 {{ site.data.keys.product }} V8.0 Cordova 跨平台应用程序中，此位置为 **www** 目录。
        * **destination_directory**  
        扫描结果的输出目录。
		* **scan_type**  
        要扫描的项目的类型。
    * 解决 **api-report.html** 文件中确定的任何剩余 API 问题。
6. 重复步骤 6 以针对新的 Cordova 应用程序运行扫描工具，直到解决所有问题。

### 完成 {{ site.data.keys.product_adj }} 混合应用程序的迁移
{: #completing-migration-of-a-mobilefirst-hybrid-app }
使用迁移辅助工具后，必须手动修改代码的某些部分以完成迁移过程。

* 必须已对现有混合应用程序运行 mfpmigrate 迁移辅助工具。 有关更多信息，请参阅[使用迁移辅助工具启动 Cordova 应用程序迁移](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)。
* 您必须已安装 Cordova 命令行界面 (CLI)，并且安装对目标平台使用 Cordova CLI 所需的任何必备软件（如果需要安装任何其他 Cordova 插件）。 （请参阅步骤 6）。 有关更多信息，请参阅 Apache Cordova Web 站点上的[命令行界面](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)。
* 如果需要下载 JQuery 的新版本（步骤 1c），或者如果需要安装任何其他 Cordova 插件（步骤 6），那么必须具有因特网访问权。
* 如果需要安装其他 Cordova 插件（步骤 6），那么必须已安装 node.js V4.0.0 或更高版本。

完成本任务中的步骤，以完成将 MobileFirst 混合应用程序从 IBM MobileFirst Platform Foundation 7.1 迁移到包含 {{ site.data.keys.product }} 8.0 支持的 Cordova 应用程序。

完成迁移后，应用程序可以使用独立于 IBM MobileFirst Platform Foundation 获取的 Cordova 平台和插件，并使用首选 Cordova 开发工具继续开发应用程序。

1. 更新 **www/index.html** 文件。
    * 将以下 CSS 代码添加到 index.html 文件头中已有的 CSS 代码之前。

      ```html
      <link rel="stylesheet" href="worklight/worklight.css">
      <link rel="stylesheet" href="css/main.css">
      ```

      > **注：****worklight.css** 文件将 body 属性设置为 relative。 如果这影响应用程序的样式，请在您自己的 CSS 代码中为 position 声明其他值。 例如：

      ```css
      body {
            position: absolute;
      }
      ```

    * 将 Cordova JavaScript 添加到文件头中的 CSS 定义之后。

      ```html
      <script type="text/javascript" src="cordova.js"></script>
      ```    

    * 移除以下代码行（如果存在）。

      ```html
      <script>window.$ = window.jQuery = WLJQ;</script>
      ```

      您可以下载自己的 JQuery 版本，并按以下代码行中所示将其装入。

      ```html
      <script src="lib/jquery.min.js"></script>
      ```

      不必将可选的 jQuery 新增项移至 **lib** 文件夹。 可以将此新增项移至所需的任何位置，但必须在 **index.html** 文件中正确引用此项。

2. 将 **www/js/InitOptions.js** 文件更新为自动调用 `WL.Client.init`。
    * 从 **InitOptions.js** 中移除以下代码

      函数 `WL.Client.init` 使用全局变量 **wlInitOptions** 自动进行调用。

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

3. 可选：将 **www/InitOptions.js** 更新为手动调用 `WL.Client.init`。
    * 编辑 **config.xml** 文件并将 `<mfp:clientCustomInit>` 元素的 enabled 属性设置为 true。
    * 如果使用的是 MobileFirst 混合缺省模板，请将以下代码：

      ```javascript
      if (window.addEventListener) {
            window.addEventListener('load', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            window.attachEvent('onload',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

      替换为以下代码：

      ```javascript
      if (document.addEventListener) {
            document.addEventListener('mfpready', function() { WL.Client.init(wlInitOptions); }, false);
      } else if (window.attachEvent) {
            document.attachEvent('mfpready',  function() { WL.Client.init(wlInitOptions); });
      }
      ```

4. 可选：如果您具有特定于混合环境的逻辑（例如在 **app/iphone/js/main.js** 中），请复制函数 `wlEnvInit()` 并将其附加在 **www/main.js** 的结尾。

   ```javascript
   // This wlEnvInit method is invoked automatically by MobileFirst runtime after successful initialization.
   function wlEnvInit() {
        wlCommonInit();
        if (cordova.platformId === "ios") {
            // Environment initialization code goes here for ios
        } else if (cordova.platformId === "android") {
            // Environment initialization code goes here for android
        }
   }
   ```

5. 可选：如果原始应用程序使用 FIPS 功能部件，请将 JQuery 事件侦听器更改为侦听 WL/FIPS/READY 事件的 JavaScript 事件侦听器。 有关 FIPS 的更多信息，请参阅 [FIPS 140-2 支持](../../../administering-apps/federal/#fips-140-2-support)。
6. 可选：如果原始应用程序使用迁移辅助工具没有替换或提供的任何第三方 Cordova 插件，请使用 `cordova plugin add` 命令将这些插件手动添加到 Cordova 应用程序。 有关此工具替换了哪些插件的信息，请参阅[使用迁移辅助工具启动 Cordova 应用程序迁移](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)。

### 完成 {{ site.data.keys.product_adj }} Cordova 应用程序的迁移
{: #completing-migration-of-a-mobilefirst-cordova-app }
使用迁移辅助工具后，必须手动修改代码的某些部分以完成迁移过程。

* 必须已对现有 Cordova 应用程序运行 **mfpmigrate** 迁移辅助工具。 有关更多信息，请参阅[使用迁移辅助工具启动 Cordova 应用程序迁移](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)。
* 您必须已安装 Cordova 命令行界面 (CLI)，并且安装对目标平台使用 Cordova CLI 所需的任何必备软件。 有
关更多信息，请参阅 Apache Cordova Web 站点上的[命令行界面](http://cordova.apache.org/docs/en/5.1.1/guide/cli/index.html)。
* 您必须具有因特网访问权。
* 您必须已安装 node.js V4.0.0 或更高版本。

通过 **mfp cordova create** 创建的 Cordova 应用程序使用 IBM MobileFirst Platform Foundation 先前版本随附的 Cordova 平台和插件版本。 完成迁移后，已迁移的应用程序可以使用独立于 {{ site.data.keys.product }} 获取的 Cordova 平台和插件。 这是 IBM MobileFirs Foundation V8.0 提供的唯一一种 Cordova 应用程序支持。

要进行迁移，请运行迁移辅助工具，然后对应用程序进行其他修改。

1. 通过所选的 Cordova 开发工具，添加除用于启用原始应用程序中包含的 {{ site.data.keys.product_adj }} 功能部件的 Cordova 插件以外的任何 Cordova 插件。 例如，通过 Cordova CLI，要添加插件 **cordova-plugin-file** 和 **cordova-plugin-file-transfer**，请输入：

   ```bash
   cordova plugin add cordova-plugin-file cordova-plugin-file-transfer
   ```

   > **注：****mfpmigrate** 迁移辅助工具已针对 {{ site.data.keys.product_adj }} 功能部件添加 Cordova 插件，因此您不必添加这些插件。 有关这些插件的更多信息，请参阅 [{{ site.data.keys.product_adj }} 的 Cordova 插件](../../../application-development/sdk/cordova)。

2. 可选：如果原始应用程序使用 FIPS 功能部件，请将 JQuery 事件侦听器更改为侦听 WL/FIPS/READY 事件的 JavaScript 事件侦听器。 有关 FIPS 的更多信息，请参阅 [FIPS 140-2 支持](../../../administering-apps/federal/#fips-140-2-support)。
3. 可选：如果原始应用程序使用迁移辅助工具没有替换或提供的任何第三方 Cordova 插件，请使用 **cordova plugin add** 命令将这些插件手动添加到 Cordova 应用程序。 有关此工具替换了哪些插件的信息，请参阅[使用迁移辅助工具启动 Cordova 应用程序迁移](#starting-the-cordova-app-migration-with-the-migration-assistance-tool)。
4. 可选：（仅适用于包含 iOS 平台且使用 OpenSSL 的应用程序。） 将 **cordova-plugin-mfp-encrypt-utils** 插件添加到应用程序。**cordova-plugin-mfp-encrypt-utils** 插件为使用 iOS 平台的 Cordova 应用程序提供用于加密的 iOS OpenSSL 框架。

您现在具有可以通过首选 Cordova 工具继续开发的 Cordova 应用程序，但其中还包含 {{ site.data.keys.product_adj }} 功能。

## 为 iOS Cordova 迁移加密
{: #migrating-encryption-for-ios-cordova }
如果 iOS 混合应用程序或 Cordova 应用程序已使用 OpenSSL 加密，那么可能需要将应用程序迁移到新的 V8.0.0 本机加密。 如果要继续使用 OpenSSL，那么必须添加额外的 Cordova 插件。

有关用于迁移的 iOS Cordova 加密选项的更多信息，请参阅[在 Cordova 应用程序中启用 OpenSSL](../../../application-development/sdk/cordova/additional-information/#enabling-openssl-in-cordova-applications) 主题中的[迁移选项](../../../application-development/sdk/cordova/additional-information/#migration-options)部分。

## 迁移“直接更新”
{: #migrating-direct-update }
首次访问受保护资源后会触发“直接更新”。 在 V8.0 中，已更改了用于部署新 Web 资源的过程。

与先前版本不同，在 V8.0 中，如果应用程序不访问安全的 {{ site.data.keys.product_adj }} 资源，那么客户机应用程序不会接收更新，即使在服务器上有可用更新也如此。 资源可能不受保护，例如，因为 OAuth 已由注释 `@OAuth(security=false)` 或由配置禁用。 您可以通过以下其中一种方式绕过此风险：

* 显式获取访问令牌。 请参阅 [`WLAuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc) 类中的 `obtainAccessToken` API。
* 调用其他受保护资源。 请参阅 [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html?view=kc) 类。

要使用“直接更新”：从 V8.0 开始，不再将 **.wlapp** 文件上载到 {{ site.data.keys.mf_server }}。 而是上载较小的 Web 资源归档（.zip 文件）。 该归档文件不再包含在先前版本中广泛使用的 Web 预览文件或外表。 已停用这些功能。 该归档仅包含发送到客户机的 Web 资源以及“直接更新”验证的校验和。

> 有关更多信息，请参阅[“直接更新”文档](../../../application-development/direct-update)。

## 升级 WebView
{: #upgrading-the-webview }
IBM MobileFirs Foundation V8.0 Cordova SDK (JavaScript) 引入了许多需要调整代码的更改。

手动迁移过程涉及几个阶段：

* 创建新的 Cordova 项目
* 将必需的 Web 资源元素替换为先前版本中的代码
* 对 JavaScript 代码进行必需的更改以符合 SDK 更改

在 V8.0 中移除了许多 {{ site.data.keys.product_adj }} API 元素。 在支持 JavaScript 自动更正的 IDE 中，已移除的元素明确标记为不存在。

下表列出了需要移除的 API 元素，并附带有关如何替换功能的建议。 许多已移除的元素是可以替换为 Cordova 插件或 HTML 5 元素的 UI 元素。 某些方法已更改。

#### 停用的 JavaScript UI 元素
{: #discontinued-javascript-ui-elements }

| API 元素 | 迁移路径 |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>WL.BusyIndicator</code></li><li><code>WL.OptionsMenu</code></li><li><code>WL.TabBar</code></li><li><code>WL.TabBarItem</code></li></ul>{:/} | 使用 Cordova 插件或 HTML 5 元素。 |
| `WL.App.close()` | 在 {{ site.data.keys.product_adj }} 外处理此事件。 |
| `WL.App.copyToClipboard()` | 使用提供此功能的 Cordova 插件。 |
| `WL.App.openUrl(url, target, options)` | 使用提供此功能的 Cordova 插件。<br/><br/>注：为供参考，Cordova InAppBrowser 插件提供此功能。 |
| {::nomarkdown}<ul><li><code>WL.App.overrideBackButton(callback)</code></li><li><code>WL.App.resetBackButton()</code></li></ul> | 使用提供此功能的 Cordova 插件。<br/><br/>注：为供参考，Cordova backbutton 插件提供此功能。 |
| `WL.App.getDeviceLanguage()` | 使用提供此功能的 Cordova 插件。<br/><br/>注：为供参考，**cordova-plugin-globalization** 插件提供此功能。 |
| `WL.App.getDeviceLocale()` | 使用提供此功能的 Cordova 插件。<br/><br/> 注：为供参考，**cordova-plugin-globalization** 插件提供此功能。 |
| `WL.App.BackgroundHandler` | 要运行定制处理程序函数，请使用标准 Cordova 暂停事件侦听器。 使用可提供隐私并防止 iOS 和 Android 系统与用户拍摄快照或截屏的 Cordova 插件。 有关更多信息，请参阅 [https://github.com/devgeeks/PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin) 处的 PrivacyScreenPlugin 描述。 |
| {::nomarkdown}<ul><li><code>WL.Client.close()</code></li><li><code>WL.Client.restore()</code></li><li><code>WL.Client.minimize()</code></li></ul>{:/}| 提供了这些功能以支持 {{ site.data.keys.product }} V8.0 不支持的 Adobe AIR 平台 |
| `WL.Toast.show(string)` | 将 Cordova 插件用于 Toast。 |

#### 其他停用的 JavaScript 元素
{: #other-discontinued-javascript-elements }

| API | 迁移路径 |
|-----|----------------|
| `WL.Client.checkForDirectUpdate(options)` | 无替换。<br/><br/>注：您可以调用 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) 以触发直接更新（如果可用）。 访问安全性令牌会触发服务器上可用的“直接更新”。 但无法根据需要触发“直接更新”。 |
| {::nomarkdown}<ul><li><code>WL.Client.setSharedToken({key: myName, value: myValue})</code></li><li><code>WL.Client.getSharedToken({key: myName})</code></li><li><code>WL.Client.clearSharedToken({key: myName})</code></li></ul>{:/} | 无替换。 |
| {::nomarkdown}<ul><li><code>WL.Client.isConnected()</code></li><li><code>connectOnStartup</code> init 选项</li></ul> | 使用 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) 检查服务器连接并实施应用程序管理规则。 |
| {::nomarkdown}<ul><li><code>WL.Client.setUserPref(key,value, options)</code></li><li><code>WL.Client.setUserPrefs(userPrefsHash, options)</code></li><li><code>WL.Client.deleteUserPrefs(key,
options)</code></li></ul>{:/} | 无替换。 您可以使用适配器和 [MFP.Server.getAuthenticatedUser](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser) API 管理用户首选项。 |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 无替换。 |
| `WL.Client.logActivity(activityType)` | 使用 [`WL.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Logger.html?view=kc) |
| `WL.Client.login(realm, options)` | 使用 [`WLAuthorizationManager.login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#login)。 |
| `WL.Client.logout(realm, options)` | 使用 [`WLAuthorizationManager.logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#logout)。 |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | 使用 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken)。 |
| {::nomarkdown}<ul><li><code>WL.Client.transmitEvent(event, immediate)</code></li><li><code>WL.Client.purgeEventTransmissionBuffer()</code></li><li><code>WL.Client.setEventTransmissionPolicy(policy)</code></li></ul>{:/} | 为接收这些事件的通知创建定制适配器。 |
| {::nomarkdown}<ul><li><code>WL.Device.getContext()</code></li><li><code>WL.Device.startAcquisition(policy, triggers, onFailure)</code></li><li><code>WL.Device.stopAcquisition()</code></li><li><code>WL.Device.Wifi</code></li><li><code>WL.Device.Geo.Profiles</code></li><li><code>WL.Geo</code></li></ul>{:/} | 使用本机 API 或第三方 Cordova 插件进行地理定位。 |
| `WL.Client.makeRequest (url, options)` | 创建提供同一功能的定制适配器。 |
| `WL.Device.getID(options)` | 使用提供此功能的 Cordova 插件。<br/><br/>注：为供参考，来自 **cordova-plugin-device** 插件的 **device.uuid** 提供此功能。 |
| `WL.Device.getFriendlyName()` | 使用 `WL.Client.getDeviceDisplayName` |
| `WL.Device.setFriendlyName()` | 使用 `WL.Client.setDeviceDisplayName` |
| `WL.Device.getNetworkInfo(callback)` | 使用提供此功能的 Cordova 插件。<br/><br/>注：为供参考，**cordova-plugin-network-information** 插件提供此功能。 |
| `WLUtils.wlCheckReachability()` | 创建用于检查服务器可用性的定制适配器。 |
| `WL.EncryptedCache` | 使用 JSONStore 以在本地存储加密数据。 JSONStore 位于 **cordova-plugin-mfp-jsonstore** 中 |
| `WL.SecurityUtils.remoteRandomString(bytes)` | 创建提供同一功能的定制适配器。 |
| `WL.Client.getAppProperty(property)` | 可以使用 cordova plugin add **cordova-plugin-appversion** 插件来检索应用程序版本属性。 所返回的版本是本机应用程序版本（仅限 Android 和 iOS）。 |
| `WL.Client.Push.*` | 使用 **cordova-plugin-mfp-push** 插件中的 [JavaScript 客户端推送 API](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_js_client_push_api.html?view=kc#r_client_push_api)。 有关更多信息，请参阅[从基于事件源的通知迁移到推送通知](../../migrating-push-notifications)。 |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | 使用 [`MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-mfp-push-hybrid/html/MFPPush.html?view=kc#registerDevice) 以针对推送和 SMS 注册设备。 |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | 使用 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) 以获取所需作用域的令牌。 |
| `WLClient.getLastAccessToken(scope)` | 使用 [`WLAuthorizationManager.obtainAccessToken`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#obtainAccessToken) |
| {::nomarkdown}<ul><li><code>WLClient.getLoginName()</code></li><li><code>WL.Client.getUserName(realm)</code></li></ul>{:/} | 无替换 |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | 使用 [`WLAuthorizationManager.isAuthorizationRequired`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#isAuthorizationRequired)和 [`WLAuthorizationManager.getResourceScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLAuthorizationManager.html?view=kc#getResourceScope)。 |
| `WL.Client.isUserAuthenticated(realm)` | 无替换 |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | 无替换 |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | 无替换 |
| `WL.Client.createChallengeHandler(realmName)` | 要创建验证问题处理程序来处理定制网关验证问题，请使用 [`WL.Client.createGatewayChallengeHandler(gatewayName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler)。 要创建验证问题处理程序来处理 {{ site.data.keys.product_adj }} 安全性检查验证问题，请使用 [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)。 |
| `WL.Client.createWLChallengeHandler(realmName)` | 使用 [`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler)。 |
| `challengeHandler.isCustomResponse()`，其中 `challengeHandler` 是 `WL.Client.createChallengeHandler()` 返回的验证问题处理程序对象 | 使用 `gatewayChallengeHandler.canHandleResponse()`，其中 `gatewayChallengeHandler` 是 [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) 返回的验证问题处理程序对象。 |
| `wlChallengeHandler.processSucccess()`，其中 `wlChallengeHandler` 是 `WL.Client.createWLChallengeHandler()` 返回的验证问题处理程序对象 | 使用 `securityCheckChallengeHandler.handleSuccess()`，其中 `securityCheckChallengeHandler` 是 [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) 返回的验证问题处理程序对象。 |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | 在验证问题处理程序中实施类似逻辑。 对于定制网关验证问题处理程序，请使用 [`WL.Client.createGatewayChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createGatewayChallengeHandler) 返回的验证问题处理程序对象。 对于 {{ site.data.keys.product_adj }} 安全性检查验证问题处理程序，请使用 [`WL.Client.createSecurityCheckChallengeHandler()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html?view=kc#createSecurityCheckChallengeHandler) 返回的验证问题处理程序对象。 |
| `WL.Client.AbstractChallengeHandler.submitFailure(err)` | 使用 [`WL.Client.AbstractChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.AbstractChallengeHandler.html?view=kc#cancel)。 |
| `WL.Client.createProvisioningChallengeHandler()` | 无替换。 设备供应现在由安全框架自动处理。 |

#### 不推荐使用的 JavaScript API
{: #deprecated-javascript-apis }

| API | 迁移路径 |
|-----|----------------|
| {::nomarkdown}<ul><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)</code></li><li><code>WL.Client.invokeProcedure(invocationData, options)</code></li><li><code>WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener
responseListener, WLRequestOptions requestOptions)</code></li><li><code>WLProcedureInvocationResult</code></li></ul>{:/} | 改用 `WLResourceRequest`。 注：invokeProcedure 的实现使用了 WLResourceRequest。 |
| `WLClient.getEnvironment` | 使用提供此功能的 Cordova 插件。 注：为供参考，device.platform 插件提供此功能。 |
| `WL.Client.getLanguage` | 使用提供此功能的 Cordova 插件。 注：为供参考，**cordova-plugin-globalization** 插件提供此功能。 |
| `WL.Client.connect(options)` | 使用 `WLAuthorizationManager.obtainAccessToken` 检查服务器连接并实施应用程序管理规则。 |

## 已移除的组件
{: #removed-components }
MobileFirst Platform Foundation Studio 7.1 创建的 Cordova 项目包含许多支持格局功能的资源。 但是，在 V8.0 中仅支持纯 Cordova，并且 {{ site.data.keys.product_adj }} API 不再支持这些功能。

### 外表
{: #skins }
MobileFirst 应用程序外表提供了用于优化 UI 以适应不同设备和格式的方法，并且在 V8.0 中不再受支持。  
要替换此类型的功能，建议采用由 Cordova 和 HTML 5 提供的响应式 Web 设计方法。

### Shell
{: #shells }
**Shell** 允许开发供应用程序使用并在其之间共享的功能集。 通过此方式，具有更多本机环境经验的开发人员可以提供核心功能集。 这些 shell 捆绑到**内部应用程序**中，并且供涉及业务逻辑或 UI 开发的开发人员使用。

如果先前混合应用程序使用 shell 和内部应用程序，那么建议采用 Cordova 设计模式，并将 shell 组件作为可以跨应用程序共享的 Cordova 插件进行实施。 开发人员可能会找到方法来复用部分 shell 代码并将其迁移到 Cordova 插件。

例如，如果客户具有跨所有应用程序通用的一组 Web 资源（JavaScript、css 文件、图形、html），那么可以创建用于将这些资源复制到应用程序的 www 文件夹中的 Cordova 插件。

假设这些资源位于 src/www/acme/ 文件夹中：

* src/www/acme/js/acme.js
* src/www/acme/css/acme.css
* src/www/acme/img/acme-logo.png
* src/www/acme/html/banner.html
* src/www/acme/html/footer.html
* plugin.xml

**plugin.xml** 文件包含 `<asset>` 标记，此标记包含用于复制资源的源和目标：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plugin
     xmlns="http://apache.org/cordova/ns/plugins/1.0"     
     xmlns:rim="http://www.blackberry.com/ns/widgets"
     xmlns:android="http://schemas.android.com/apk/res/android"
     id="cordova-plugin-acme"
     version="1.0.1">
<name>ACME Company Shell Component</name>
<description>ACME Company Shell Component</description>
<license>MIT</license>
<keywords>cordova,acme,shell,components</keywords>
<issue>https://www.acme.com/support</issue>
<asset src="src/www/acme" target="www/acme"/>
</plugin>
```

将 **plugin.xml** 添加到 Cordova **config.xml** 文件后，asset src 中所列的资源在编译期间会复制到 asset 目标中。  
然后，在其 **index.html** 文件中或其应用程序内的任何位置，可以复用这些资源。

```html
<link rel="stylesheet" type="text/css" href="acme/css/acme.css">
<script type="text/javascript" src="acme/js/acme.js"></script>
<div id="banner"></div>
<div id="app"></div>
<div id="footer"></div>
<script type="text/javascript">
    $("#banner").load("acme/html/banner.html");
    $("#footer").load("acme/html/footer.html");
</script>
```

### “设置”页面
{: #settings-page }
**设置页面**是 MobileFirst 混合应用程序中提供的 UI，开发人员可以通过该页面在运行时更改服务器 URL 以进行测试。 开发人员现在可以使用现有 {{ site.data.keys.product_adj }} 客户机 API 在运行时更改服务器 URL。 有关更多信息，请参阅 [WL.App.setServerUrl](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html?cp=SSHS8R_8.0.0#setServerUrl)。

### 缩小
{: #minification }
MobileFirst Studio 7.1 提供了 OOTB 方法，通过在编译前移除所有不必要的字符来减少 JavaScript 代码量。 可以通过向项目中添加 Cordova 挂钩来替换这一已移除的功能。

许多挂钩可用于缩小 JavaScript 和 CSS 文件。 这些挂钩可放在应用程序的 **config.xml** 文件的 `before_prepare` 事件中。

以下是一些建议挂钩：

* [https://www.npmjs.com/package/uglify-js](https://www.npmjs.com/package/uglify-js)
* [https://www.npmjs.com/package/clean-css](https://www.npmjs.com/package/clean-css)

通过使用 `<hook>` 元素，这些挂钩在插件文件中或在应用程序的 **config.xml** 文件中定义。  
在此示例中，通过使用 `before_prepare` 挂钩事件，在 Cordova prepares 将文件复制到各平台的 **www/** 文件夹之前运行脚本以执行缩小代码操作：

```html
<hook type="before_prepare" src="scripts/uglify.js" />
```
