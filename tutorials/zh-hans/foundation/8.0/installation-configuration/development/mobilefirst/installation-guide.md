---
layout: tutorial
title: 工作站安装指南
breadcrumb_title: Installation guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
请遵循本安装指南，使用 {{ site.data.keys.product }} 设置开发工作站。

## DevKit Installer
{: #devkit-installer }
[{{ site.data.keys.mf_dev_kit }} Installer]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) 将在开发人员计算机上安装现成的 {{ site.data.keys.mf_server }}、数据库和运行时。  

**先决条件：**  
该安装程序要求安装 Java。

1. [安装 Oracle 的 JRE](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html)。

2. 添加 `JAVA_HOME` 变量并使其指向 JRE

    *Mac 和 Linux：*编辑 **~/.bash_profile**：

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows：*  
    [遵循本指南](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html)。

### 安装
{: #installation }
从[下载]({{site.baseurl}}/downloads/)页面中获取 DevKit Installer，并按照屏幕上的指示信息进行操作。

![DevKit Installer](devkit-installer.png)

### 启动和停止服务器
{: #starting-and-stopping-the-server }
打开命令行窗口，并浏览至已抽取的文件夹位置。

*Mac 和 Linux：*  

* 要启动服务器：`./run.sh -bg`
* 要停止服务器：`./stop.sh`

*Windows：*  

* 要启动服务器：`./run.cmd -bg`
* 要停止服务器：`./stop.cmd`

### 访问 {{ site.data.keys.mf_console }}
{: #accessing-the-mobilefirst-operations-console }
您可以使用以下方式来访问 [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) ：

* 从命令行中，执行以下命令：`mfpdev server console`
* 从浏览器中，访问以下 URL：[http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![控制台]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
[{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) 是一个命令行界面，可用于在 {{ site.data.keys.mf_server }} 中注册应用程序、在 {{ site.data.keys.mf_server }} 中提取/推送应用程序、创建 Java 和 JavaScript 适配器、管理多个本地和远程服务器，以及使用“直接更新”更新实时应用程序等。

**先决条件：**  
1. 要安装 {{ site.data.keys.mf_cli }}，需要 NodeJS 和 NPM。  
 下载并安装 [NodeJS V6.11.1](https://nodejs.org/download/release/v6.11.1/) 和 NPM V3.10.10。对于 MobileFirst CLI V8.0.2018100112 或更高版本，您可以使用 Node V8.x 或 V10.x。 

 要验证安装，请打开命令行窗口并执行以下命令：`node -v`。

2. 某些 CLI 命令（如创建、构建和部署适配器）需要 Maven。 请参阅下一部分，以获取安装指示信息。

### 安装 {{ site.data.keys.mf_cli }}
{: #installation-cli }
打开终端并执行以下命令：`npm install -g mfpdev-cli`。  

*Mac 和 Linux：*请注意，您可能需要使用 `sudo` 来运行此命令。  
请阅读有关[修订 NPM 许可权](https://docs.npmjs.com/getting-started/fixing-npm-permissions)的更多信息。

要验证安装，请打开命令行窗口并执行以下命令：`mfpdev -v` 或 `mfpdev help`。

![控制台](mfpdev-cli.png)

## 适配器和安全性检查
{: #adapters-and-security-checks }
[适配器]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters)和[安全性检查]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security)是向应用程序引入认证及其他安全层的途径。

**先决条件：**  
要创建适配器和安全性检查，需要设置 Apache Maven。  

1. [下载 Apache Maven .zip](https://maven.apache.org/download.cgi)
2. 添加 `MVN_PATH` 变量并使其指向 Maven 文件夹

    *Mac 和 Linux：*编辑 **~/.bash_profile**：

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows：*  
    [遵循本指南](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/)。
要验证安装，请执行以下命令：`mvn -v`。

### 用法
{: #usage }
安装 Apache Maven 后，您便可以通过 Maven 命令行命令或使用 {{ site.data.keys.mf_cli }} 来创建适配器。  
有关更多信息，请查看[适配器教程]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters)。
