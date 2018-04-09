---
layout: tutorial
title: 用于上载或删除应用程序的命令行工具
breadcrumb_title: Uploading or deleting an app
relevantTo: [ios,android,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
要通过构建过程将应用程序部署至 Application Center，请使用命令行工具。

您可以使用 Application Center 控制台的 Web 界面将应用程序上载至 Application Center。 您还可以使用命令行工具来上载新应用程序。

如果您希望将应用程序部署到 Application Center 的过程整合到构建过程中，这尤其有用。 该工具位于：**installDir/ApplicationCenter/tools/applicationcenterdeploytool.jar**。

该工具可用于具有 APK 或 IPA 扩展名的应用程序文件。 它可以单独使用或者作为一项 ant 任务来使用。

tools 目录包含支持使用该工具所需的所有文件。

* **applicationcenterdeploytool.jar**：上载工具。
* **json4j.jar**：上载工具所需的 JSON 格式的库。
* **build.xml**：样本 ant 脚本，可供您用于将单个文件或者一系列文件上载至 Application
Center。
* **acdeploytool.sh** 和 **acdeploytool.bat**：用于通过 **applicationcenterdeploytool.jar** 调用 java 的简单脚本。

#### 跳至：
{: #jump-to }
* [使用独立工具上载应用程序](#using-the-stand-alone-tool-to-upload-an-application)
* [使用独立工具来删除应用程序](#using-the-stand-alone-tool-to-delete-an-application)
* [使用独立工具来清除 LDAP 缓存](#using-the-stand-alone-tool-to-clear-the-ldap-cache)
* [用于上载或删除应用程序的 Ant 任务](#ant-task-for-uploading-or-deleting-an-application)

### 使用独立工具上载应用程序
{: #using-the-stand-alone-tool-to-upload-an-application }
要上载应用程序，请从命令行调用独立工具。  
遵循以下步骤来使用独立工具。

1. 将 **applicationcenterdeploytool.jar** 和 **json4j.jar** 添加到 java classpath 环境变量。
2. 从命令行调用上载工具：

   ```bash
   java com.ibm.appcenter.Upload [options] [files]
   ```

您可以在命令行中传递任何可用选项。

| 选项 | 指示的内容 | 描述 |
|--------|----------------------|-------------|
| -s | serverpath | Application Center 服务器的路径。 |
| -c | context | Application Center Web 应用程序的上下文。 |
| -u | user | 用于访问 Application Center 的用户凭证。 |
| -p | password | 用户的密码。 |
| -d | description | 要上载的应用程序的描述。 |
| -l | label | 回退标签。 通常，此标签取自要上载的文件中存储的应用程序描述符。 如果应用程序描述符不包含标签，那么会使用回退标签。 |
| -isActive | true 或 false | 该应用程序在 Application Center 中存储为活动或不活动的应用程序。 |
| -isInstaller | true 或 false | 该应用程序存储在 Application Center 中，并设置有相应的“安装程序”标志。 |
| -isReadyForProduction | true 或 false | 该应用程序存储在 Application Center 中，并设置有相应的“准备生产”标志。 |
| -isRecommended | true 或 false | 该应用程序存储在 Application Center 中，并设置有相应的“推荐”标志。 |
| -e	  |  | 在失败时显示完整的异常堆栈跟踪。 |
| -f	  |  | 强制上载应用程序，即使这些应用程序已存在。 |
| -y	  |  | 禁用 SSL 安全检查，这将允许在受保护的主机上发布，而无需验证 SSL 证书。 |  此标志的使用会带来安全性风险，但可能适合以临时自签名的 SSL 证书测试本地主机。 |

files 参数可以指定 Android 应用程序包 (.apk) 文件或 iOS 应用程序 (.ipa) 文件类型的文件。  
在此示例中，用户 demo 的密码为 demopassword。 使用以下命令行。

```bash
java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demopassword -f app1.ipa app2.ipa
```

### 使用独立工具来删除应用程序
{: #using-the-stand-alone-tool-to-delete-an-application }
要从 Application Center 中删除应用程序，请从命令行调用独立工具。  
遵循以下步骤来使用独立工具。

1. 将 **applicationcenterdeploytool.jar** 和 **json4j.jar** 添加到 java classpath 环境变量。
2. 从命令行调用上载工具：

   ```bash
   java com.ibm.appcenter.Upload -delete [options] [files or applications]
   ```

您可以在命令行中传递任何可用选项。

| 选项 | 指示的内容	| 描述 |
|--------|----------------------|-------------|
| -s |serverpath | Application Center 服务器的路径。 |
| -c | context | Application Center Web 应用程序的上下文。 |
| -u | user | 用于访问 Application Center 的用户凭证。 |
| -p | password | 用户的密码。 |
| -y | | 禁用 SSL 安全检查，这将允许在受保护的主机上发布，而无需验证 SSL 证书。 此标志的使用会带来安全性风险，但可能适合以临时自签名的 SSL 证书测试本地主机。 |

您可以指定文件或应用程序包、操作系统和版本。 如果指定了文件，将从文件确定包、操作系统和版本，并从 Application Center 删除对应的应用程序。 如果指定了应用程序，那么这些应用程序必须具有以下某种格式：

* `package@os@version`：将从 Application Center 删除此确切版本。 版本部分必须指定应用程序的“内部版本”，而不是“商业版本”。
* `package@os`：将从 Application Center 删除此应用程序的所有版本。
* `package`：将从 Application Center 删除此应用程序的所有操作系统的所有版本。

#### 示例
{: #example-delete }
在此示例中，用户 demo 的密码为 demopassword。 使用此命令行可删除内部版本为 3.0 的 iOS 应用程序 demo.HelloWorld。

```bash
java com.ibm.appcenter.Upload -delete -s http://localhost:9080 -c applicationcenter -u demo -p demopassword demo.HelloWorld@iOS@3.0
```

### 使用独立工具来清除 LDAP 缓存
{: #using-the-stand-alone-tool-to-clear-the-ldap-cache }
使用独立工具来清除 LDAP 缓存并立即在 Application
Center 中更改 LDAP 用户和组为可见。

使用 LDAP 配置 Application Center 时，请将 LDAP 服务器上的用户和组更改为在延迟之后对 Application
Center 可见。 Application Center 将维护 LDAP 数据的缓存，仅在缓存到期后更改内容才可见。 缺省情况下，延迟时间为 24 小时。 如果对用户和组做出更改之后不想等待延迟到期，您可从命令行调用独立工具来清除 LDAP 数据的缓存。 使用独立工具来清除缓存之后，更改将立即可见。

遵循以下步骤来使用独立工具。

1. 将 applicationcenterdeploytool.jar 和 json4j.jar 添加到 java classpath 环境变量。
2. 从命令行调用上载工具：

   ```bash
   java com.ibm.appcenter.Upload -clearLdapCache [options]
   ```

您可以在命令行中传递任何可用选项。

| 选项 | 指示的内容 | 描述 |
|--------|----------------------|-------------|
| -s | serverpath | Application Center 服务器的路径。|
| -c | context | Application Center Web 应用程序的上下文。|
| -u | user | 用于访问 Application Center 的用户凭证。|
| -p | password | 用户的密码。|
| -y | | 禁用 SSL 安全检查，这将允许在受保护的主机上发布，而无需验证 SSL 证书。 此标志的使用会带来安全性风险，但可能适合以临时自签名的 SSL 证书测试本地主机。|

#### 示例
{: #example-cache }
在此示例中，用户 demo 的密码为 demopassword。

```bash
java com.ibm.appcenter.Upload -clearLdapCache -s http://localhost:9080 -c applicationcenter -u demo -p demopassword
```

### 用于上载或删除应用程序的 Ant 任务
{: #ant-task-for-uploading-or-deleting-an-application}
您可以使用上载和删除工具作为 Ant 任务，并在您自己的 Ant 脚本中使用此 Ant 任务。  
运行这些任务需要 Apache Ant。 [系统需求](../../product-overview/requirements)中列出了 Apache Ant 的最低受支持版本。

为方便起见，{{ site.data.keys.mf_server }} 中包含了 Apache Ant 1.8.4。 在 product_install_dir/shortcuts/ 目录中，提供了以下脚本：

* ant（针对 UNIX / Linux）
* ant.bat（针对 Windows）

这些脚本能够运行，这意味着不需要特定的环境变量。 如果设置了环境变量 JAVA_HOME，那么脚本将接受该环境变量。

使用上载工具作为 Ant 任务时，“上载”Ant 任务的 classname 值为 **com.ibm.appcenter.ant.UploadApps**。 “删除”Ant 任务的 classname 值为 **com.ibm.appcenter.ant.DeleteApps**。

| Ant 任务的参数 | 描述 |
|------------------------|-------------|
| serverPath | 用于连接到 Application Center。 缺省值为 http://localhost:9080。 |
| context | Application Center 的上下文。 缺省值为 /applicationcenter。 |
| loginUser | 有权上载应用程序的用户名。 |
| loginPass | 有权上载应用程序的用户的密码。 |
| forceOverwrite | 如果此参数设置为 true，那么 Ant 任务在上载已存在的应用程序时，会尝试覆盖 Application Center 中的应用程序。 该参数仅在“上载”Ant 任务中可用。
| file | 要上载到 Application Center 或者要从 Application Center 中删除的 .apk 或 .ipa 文件。 该参数没有缺省值。 |
| fileset | 用于上载或删除多个文件。 |
| application | 应用程序的包名；该参数仅在“删除”Ant 任务中可用。 |
| os | 应用程序的操作系统。 （例如，Android 或 iOS。） 该参数仅在“删除”Ant 任务中可用。 |
| version | 应用程序的内部版本；该参数仅在“删除”Ant 任务中可用。 请勿在此处使用商业版本，因为商业版本不适合准确识别版本。 |

#### 示例
{: #example-ant }
您可以在 **ApplicationCenter/tools/build.xml** 目录中查找扩展示例。  
以下示例显示如何在您自己的 Ant 脚本中使用 Ant 任务。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="PureMeapAntDeployTask" basedir="." default="upload.AllApps">

  <property name="install.dir" value="../../" />
  <property name="workspace.root" value="../../" />

<!-- Server Properties -->
  <property name="server.path" value="http://localhost:9080/" />
  <property name="context.path" value="applicationcenter" />
  <property name="upload.file" value="" />
  <property name="force" value="true" />

  <!--  Authentication Properties -->
  <property name="login.user" value="appcenteradmin" />
  <property name="login.pass" value="admin" />
  <path id="classpath.run">
    <fileset dir="${install.dir}/ApplicationCenter/tools/">
      <include name="applicationcenterdeploytool.jar" />
      <include name="json4j.jar"/>
    </fileset>
  </path>
  <target name="upload.init">
    <taskdef name="uploadapps" classname="com.ibm.appcenter.ant.UploadApps">
      <classpath refid="classpath.run" />
    </taskdef>
  </target>
  <target name="upload.App" description="Uploads a single application" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      context="${context.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
      file="${upload.file}" />
    </target>
    <target name="upload.AllApps" description="Uploads all found APK and IPA files" depends="upload.init">
    <uploadapps serverPath="${server.path}"
      loginUser="${login.user}"
      loginPass="${login.pass}"
      forceOverwrite="${force}"
       context="${context.path}" >
      <fileset dir="${workspace.root}">
        <include name="**/*.ipa" />
      </fileset>
    </uploadapps>
  </target>
</project>
```

此样本 Ant 脚本位于 **tools** 目录中。 您可以使用它来将单个应用程序上载到 Application Center。

```bash
ant upload.App -Dupload.file=sample.ipa
```

您还可以使用它来上载目录层次结构中找到的所有应用程序。

```bash
ant upload.AllApps -Dworkspace.root=myDirectory
```

#### 样本 Ant 脚本的属性
{: #properties-of-the-sample-ant-script }
| 属性 | 注释 |
|----------|---------|
| install.dir | 缺省值为 ../../ |
| server.path | 缺省值为 http://localhost:9080。 |
| context.path | 缺省值为 applicationcenter。 |
| upload.file | 该属性没有缺省值。 它必须包含准确的文件路径。 |
| workspace.root | 缺省值为 ../../ |
| login.user | 缺省值为 appcenteradmin。 |
| login.pass | 缺省值为 admin。 |
| force	缺省值为 true。 |

要在调用 Ant 时通过命令行指定这些参数，请在属性名称前添加 -D。 例如：

```xml
-Dserver.path=http://localhost:8888/
```
