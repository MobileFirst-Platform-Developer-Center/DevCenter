---
layout: tutorial
title: 保护 Cordova 应用程序安全
breadcrumb_title: 保护应用程序安全
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### 加密 Cordova 软件包的 Web 资源
{: #encrypting-the-web-resources-of-your-cordova-packages }
要最大程度降低某人查看和修改 .apk 或 .ipa 软件包中 Web 资源的风险，可使用 {{ site.data.keys.mf_cli }} `mfpdev app webencrypt` 命令或 `mfpwebencrypt` 标记来加密信息。此过程不提供无法攻陷的加密，而是提供基本级别的模糊。

**先决条件：**

* 必须已安装 Cordova 开发工具。此示例使用 Apache Cordova CLI。如果使用其他 Cordova 开发工具，那么一些步骤会有所不同。请参阅 Cordova 工具文档以获取指示信息。
* 必须已安装 {{ site.data.keys.mf_cli }}。

* 必须已安装 { site.data.keys.product_adj }} Cordova 插件。

完成此过程的最佳时间是完成应用程序开发且准备好部署应用程序之后。如果在完成 Web 资源加密过程之后运行以下任何命令，那么加密的内容将变为不加密：

* cordova prepare
* cordova build
* cordova run
* cordova emulate
* mfpdev app webupdate
* mfpdev app preview

如果在加密 Web 资源之后运行以下一个列出的命令，那么必须再次完成此过程以加密 Web 资源。

1. 打开终端窗口并浏览至想要加密的 Cordova 应用程序的根目录。
2. 通过输入以下一个命令准备应用程序：
    - cordova prepare
    - mfpdev app webupdate
3. 完成以下一个过程以加密内容：
    - 输入以下命令：`mfpdev app webencrypt`。**提示：**您可以通过输入 `mfpdev help app webencrypt` 查看有关 `mfpdev app webencrypt` 命令的信息。
    - 在构建软件包时，您还可以通过向 `cordova compile` 或 `cordova build` 命令添加 `mfpwebencrypt` 标记来加密 Cordova 软件包的 Web 资源。
        - `cordova compile -- --mfpwebencrypt` | `cordova build -- --mfpwebencrypt`
    <br/>
    包含加密内容的 **resources.zip** 文件将替换 **www** 文件夹中的操作系统信息。  
    如果应用程序针对于 Android 操作系统并且 **resources.zip** 文件超过 1 MB，那么 **resources.zip** 文件将划分为较小的 768 KB .zip 文件，命名为 **resources.zip.nnn**。变量 nnn 是从 001 到 999 的数字。
4. 使用特定于平台的工具随附的仿真器，通过加密资源测试应用程序。例如，您可以将 Android Studio 中的仿真器用于 Android，或者将 Xcode 用于 iOS。

**注：**请勿在加密后使用以下 Cordova 命令来测试应用程序：

* `cordova run`
* `cordova emulate`

这些命令会刷新在 www 文件夹中加密的内容，并将其重新保存为解密的内容。如果使用这些命令，那么请记住在发布应用程序之前再次完成此过程以进行加密。

### 启用 Web 资源校验和功能
{: #enabling-the-web-resources-checksum-feature }
如果启用，Web 资源校验和功能会在启动时将应用程序的原始 Web 资源与第一次启动应用程序时捕获的已存储基线进行比较。这是识别应用程序中任何差异的较好方法，可能指示已修改应用程序。此过程兼容“直接更新”功能。

**先决条件：**

* 必须已安装 Cordova 开发工具。此示例使用 Apache Cordova CLI。如果使用其他 Cordova 开发工具，那么一些步骤会有所不同。请参阅 Cordova 工具文档以获取指示信息。
* 必须已安装 {{ site.data.keys.mf_cli }}。
 
* 必须已安装 { site.data.keys.product_adj }} 插件。
* 必须先将平台添加到 Cordova 项目，然后才能通过输入 `cordova platform add [android|ios|windows|browser]` 命令针对此操作系统启用 Web 资源校验和功能。

要针对 Cordova 应用程序启用 Web 资源校验和功能，请完成以下步骤：

1. 在终端窗口中，浏览至目标应用程序的根目录。
2. 输入以下命令以针对 Cordova 应用程序的操作系统环境启用 Web 资源校验和功能：

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_test_web_resources_checksum true
   ```

   例如：  
    
   ```bash
   mfpdev app config android_security_test_web_resources_checksum true
   ```

   您可以通过将命令中的 **true** 替换为 **false** 来禁用此功能。
   
   > **提示：**您可以通过输入 `mfpdev help app config` 来查看有关 `mfpdev app config` 命令的信息。
    
3. 输入以下命令以标识想要在校验和测试期间忽略的文件类型：

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_ignore_file_extensions [ file_extension1,file_extension2 ]
   ```
    
   多个扩展名必须用逗号进行分隔，它们之间无空格。例如：
    
   ```bash
   mfpdev app config android_security_ignore_file_extensions jpg,png,pdf
   ```
    
**重要提示：**运行此命令将覆盖设置的值。

Web 资源校验和针对其测试扫描的文件越多，打开应用程序所用的时间越长。您可以指定要跳过的文件类型的扩展名，这可提高应用程序启动速度。

应用程序已启用 Web 资源校验和功能。

1. 运行以下命令将更改集成到应用程序：`cordova prepare`
2. 通过输入以下命令构建应用程序：`cordova build`
3. 通过输入以下命令运行应用程序：`cordova run`
