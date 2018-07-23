---
layout: tutorial
title: 运行 IBM Installation Manager 以进行更新
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 以图形方式运行 Installation Manager
{: #graphical-mode}

* 从初始安装时使用的用户帐户运行 Installation Manager。
  要应用更新，必须使用在初始安装时使用的注册表文件列表来运行 Installation Manager。安装的软件列表和安装期间使用的选项存储在这些注册表文件中。如果以管理员方式运行 Installation Manager，那么会在系统级别安装这些注册表文件。在 UNIX 或 Linux 上，位于 `/var` 文件夹中。在 Windows 上，位于 `c:\ProgramData` 文件夹中。位置与运行 Installation Manager 的用户身份无关（但在 UNIX 和 Linux 上需要使用 root 用户身份）。但是，如果以单一用户方式运行 Installation Manager，那么缺省情况下这些注册表文件存储在用户主目录中。

* 选择**文件 > 首选项**。
  如果您计划更新现有 IBM MobileFirst Platform Foundation V8.0.0（应用修订包或临时修订），那么无需产品存储库。

* 单击**确定**以关闭**首选项**显示屏。

* 单击**更新**并选择要更新的包。Installation Manager 会显示包列表。缺省情况下，要更新的包名为 IBM MobileFirst Platform Server。

* 接受许可条款，然后单击**下一步**。

* 在**感谢**面板中，单击**下一步**。这样会显示摘要信息。

* 单击**更新**以启动更新过程。

## 以命令行方式运行 Installation Manager
{: #cli-mode}

1. 从[此处](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip)下载静默安装文件。

2. 解压此文件，然后选中 `8.0/upgrade-initially-mfpserver.xml` 文件。
  - 如果初始安装的产品为 V6.0.0、V6.1.0 或 V6.2.0，请改为选中 `8.0/upgrade-initially-worklightv6.xmlfile`。
  - 如果初始安装的产品为 V5.x，请改为选中 `8.0/upgrade-initially-worklightv5.xml` 文件。
  此文件包含产品的概要文件身份。此身份的缺省值随产品发行版发生改变。在 V5.x 中，该值为 Worklight。在 V6.0.0、V6.1.0 和 V6.2.0 中，该值为 IBM Worklight。在 V6.3.0、V7.0.0、V7.1.0 和 V8.0.0 中，该值为 IBM MobileFirst Platform Server。

3. 复制所选文件。

4. 使用文本编辑器或 XML 编辑器打开复制的 XML 文件。修改以下元素：

   a. 定义存储库列表的存储库元素。由于您计划更新现有 IBM MobileFirst Platform Foundation V8.0.0（应用修订包或临时修订），因此无需产品存储库。

   b. **可选：**更新数据库和应用程序服务器的密码。
      如果在初始安装时随 Installation Manager 安装了 Application Center，并且数据库或应用程序服务器的密码发生更改，那么您可在 XML 文件中修改该值。这些密码用于验证数据库是否具有适合的模式版本，如果其版本低于 V8.0.0，那么将对其进行升级。这些密码还用于运行 **wsadmin** 以在 WebSphere Application Server Full Profile 上安装 Application Center。取消注释 XML 文件中的相应行：
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. 如果在激活随 2015 年 9 月 15 日的临时修订或更高版本发布的令牌许可之前未选择任何选项，那么请取消注释行 `<data key=’user.licensed.by.tokens’ value=’false’/>`。如果您的某个合同要通过 Rational License Key Server 使用令牌许可，请将该值设置为 **true**。否则，请将此值设置为 **false**。
      如果激活令牌许可，请确保已配置 Rational License Key Server，并且可获取足够数量的令牌以运行 MobileFirst Server 及其服务的应用程序。否则，MobileFirst Server 管理应用程序和运行时环境将无法运行。
      > **限制：**决定是否激活令牌许可后，无法修改此决定。如果使用值 **true** 运行升级，并且稍后使用值 **false** 运行另一次升级，那么第二次升级将失败。

    d. 查看概要文件身份和安装位置。概要文件身份和安装位置必须与安装对象匹配：
      * 查看此行：`<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * 并查看此行：`<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * 要查看 Installation Manager 已知的概要文件身份和安装目录，可以输入以下命令：
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. 将版本属性更新为临时修订的版本，并将该属性设置为此临时修订的版本。
       例如，如果安装临时修订 (8.0.0.0-MFPF-IF20171006-1725)，请将 

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      替换为

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager 不仅使用安装文件中列出的存储库，还使用其首选项中安装的存储库。在产品元素中指定版本属性是可选操作。但是，通过指定该属性，可确保定义的临时修订即您要安装的版本。此规范用 Installation Manager 首选项中列出的临时修订覆盖其他存储库。

5. 使用初始安装时使用的用户帐户打开会话。
    要应用更新，必须使用在初始安装时使用的注册表文件列表来运行 Installation Manager。安装的软件列表和安装期间使用的选项存储在这些注册表文件中。如果以管理员方式运行 Installation Manager，那么会在系统级别安装这些注册表文件。在 UNIX 或 Linux 上，位于 `/var` 文件夹中。在 Windows 上，位于 `c:\ProgramData` 文件夹中。位置与运行 Installation Manager 的用户身份无关（但在 UNIX 和 Linux 上需要使用 root 用户身份）。但是，如果以单一用户方式运行 Installation Manager，那么缺省情况下这些注册表文件存储在用户主目录中。

6. 运行命令
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   其中，
   * <responseFile> 是您在步骤 4 中编辑的 XML 文件。
   * *-log /tmp/installwl.log* 为可选。它指定 Installation Manager 输出的日志文件。
   * *-acceptLicense* 为必需。它表示您接受 IBM MobileFirst Platform Foundation V8.0.0 的许可条款。如果没有该选项，Installation Manager 将无法继续进行更新。

## 后续步骤
{: #next-steps }

[更新应用程序服务器](../appserver-update)
