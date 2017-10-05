---
layout: tutorial
title: 创建 Java 和 JavaScript 适配器
breadcrumb_title: Creating Adapters
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可使用 Maven 命令或通过使用 {{ site.data.keys.mf_cli }}（取决于安装和配置的 Maven）来创建适配器。然后可以使用您选择的 IDE（例如 Eclipse 或 IntelliJ）来编辑和构建适配器代码。本教程解释如何使用 Maven 和 {{ site.data.keys.mf_cli }} 来创建、构建以及部署 **Java 或 JavaScript 适配器**。要学习如何使用 Eclipse 或 IntelliJ IDE 来创建和构建适配器，请查看[在 Eclipse 中开发适配器](../developing-adapters)教程。

**先决条件：** 请务必先阅读[适配器概述](../)。

#### 跳转至
{: #jump-to }
* [安装 Maven](#install-maven)
* [使用 {{ site.data.keys.mf_cli }} 创建适配器](#creating-adapters-using-mobilefirst-cli)
* [安装 {{ site.data.keys.mf_cli }}](#install-mobilefirst-cli)
* [创建适配器](#creating-an-adapter)
* [使用 Maven Archetype 创建适配器](#creating-adapters-using-maven-archetype-adapter-maven-archetype)
* [文件结构](#file-structure)
* [构建和部署适配器](#build-and-deploy-adapters)
* [依赖关系](#dependencies)
* [将适配器分组在单个 Maven 项目中](#grouping-adapters-in-a-single-maven-project)
* [使用 {{ site.data.keys.mf_console }} 下载或部署适配器](#downloading-or-deploying-adapters-using-mobilefirst-operations-console)
* [更新适配器 Maven 项目](#updating-the-adapter-maven-project)
* [脱机工作
](#working-offline)
* [后续教程](#tutorials-to-follow-next)

## 安装 Maven
{: #install-maven }
要创建适配器，您首选需要下载并安装 Maven。请转至 [Apache Maven Web 站点](https://maven.apache.org/)，然后遵循指示信息下载并安装 Maven。

## 使用 {{ site.data.keys.mf_cli }} 创建适配器
{: #creating-adapters-using-mobilefirst-cli }

### 安装 {{ site.data.keys.mf_cli }}
{: #install-mobilefirst-cli }
遵循[下载]({{site.baseurl}}/downloads/)页面中的安装指示信息以安装 {{ site.data.keys.mf_cli }}。  
**先决条件：**要使用开发人员 CLI 创建适配器，必须安装 Maven。

### 创建适配器
{: #creating-an-adapter }
要创建 Maven 适配器项目，请使用 `mfpdev adapter create` 命令。
您可以选择以交互式或直接运行该命令。

#### 交互方式
{: #interactive-mode }
1. 打开**命令行**窗口，然后运行：

   ```bash
   mfpdev adapter create
   ```

2. 输入适配器名称。例如：

   ```bash
   ? Enter Adapter Name: SampleAdapter
   ```

3. 使用箭头选择适配器类型，然后输入关键字：

   ```bash
   ? Select Adapter Type:
      HTTP
      SQL
   ❯ Java
   ```
  * 选择 `HTTP` 创建 JavaScript HTTP 适配器
  * 选择 `SQL` 创建 JavaScript SQL 适配器  
  * 选择 `Java` 创建 Java 适配器

4. 输入适配器包（此选项仅对 Java 适配器有效）。例如：

   ```bash
   ? Enter Package: com.mypackage
   ```

5. 输入要构建的 Maven 项目的[组标识](https://maven.apache.org/guides/mini/guide-naming-conventions.html)。例如：

   ```bash
   ? Enter Group ID: com.mycompany
   ```

#### 直接方式
{: #direct-mode }
使用实际值替换占位符，然后运行该命令：

```bash
mfpdev adapter create <adapter_name> -t <adapter_type> -p <adapter_package_name> -g <maven_project_groupid>
```

## 使用 Maven Archetype“adapter-maven-archetype”创建适配器
{: #creating-adapters-using-maven-archetype-adapter-maven-archetype }

“adapter-maven-archetype”是 {{ site.data.keys.product }} 提供的 archetype，其基于 [Maven archetype 工具箱](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html)，由 Maven 用来创建适配器 Maven 项目。

要创建 Maven 适配器项目，请使用 `archetype:generate` Maven 命令。执行该命令之后，Maven 将下载（或使用上面提及的本地存储库）所需的文件以生成适配器 Maven 项目。

您可以选择以交互式或直接运行该命令。

#### 交互方式
{: #interactive-mode-archetype }

1. 从**命令行**窗口，导航至您选择的位置。  
   这也是将生成 Maven 项目的位置。

2. 使用实际值替换 **DarchetypeArtifactId** 占位符，然后运行：

   ```bash
   mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=replace-with-the-adapter-type-artifact-ID
   ```
   
  * `Archetype Group Id` 和 Archetype 版本是标识 archetype 所需的参数。
  * `Archetype Artifact Id` 是标识适配器类型所需的参数：
     * 使用 `adapter-maven-archetype-java` 创建 Java 适配器
     * 使用 `adapter-maven-archetype-http` 创建 JavaScript HTTP 适配器
     * 使用 `adapter-maven-archetype-sql` 创建 JavaScript SQL 适配器  

3. 输入要构建的 Maven 项目的[组标识](https://maven.apache.org/guides/mini/guide-naming-conventions.html)。例如：

   ```bash
   Define value for property 'groupId': : com.mycompany
   ```

4. 输入 Maven 项目的工件标识，**这以后也将用作适配器名称**。例如：

   ```bash
   Define value for property 'artifactId': : SampleAdapter
   ```

5. 输入 Maven 项目版本（缺省值是 `1.0-SNAPSHOT`）。例如：

   ```bash
   Define value for property 'version':  1.0-SNAPSHOT: : 1.0
   ```

6. 输入适配器包名称（缺省值是 `groupId`）。例如：

   ```bash
   Define value for property 'package':  com.mycompany: : com.mypackage
   ```

7. 输入 `y` 以确认：

   ```bash
   Confirm properties configuration:
   groupId: com.mycompany
   artifactId: SampleAdapter
   version: 1.0
   package: com.mypackage
   archetypeVersion: 8.0.0
   Y: : y
   ```

#### 直接方式
{: #direct-mode-archetype }
使用实际值替换占位符，然后运行该命令：

```bash
mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=<adapter type artifact ID> -DgroupId=<maven_project_groupid> -DartifactId=<maven_project_artifactid>  -Dpackage=<adapter_package_name>
```

> 有关 `archetype:generate` 命令的更多信息，请参阅 [Maven 文档](http://maven.apache.org/)。

## 文件结构
{: #file-structure }
在创建适配器之后，将生成包含 **src** 文件夹和 **pom.xml** 文件的 Maven 项目：

![mvn-adapter](adapter-fs.png)

## 构建和部署适配器
{: #build-and-deploy-adapters }

### 构建
{: #build }

* **使用 {{ site.data.keys.mf_cli }}** - 从项目的根文件夹运行 `adapter build` 命令。
    
  ```bash
  mfpdev adapter build
  ```
    
* **使用 Maven** - 每次运行 `install` 命令构建 Maven 项目时，都会构建适配器。

  ```bash
  mvn install
  ```

### 构建所有
{: #build-all }
如果 filesystem 文件夹中有多个适配器并且想要构建所有适配器，请使用：

```bash
mfpdev adapter build all
```

结果会生成 **.adapter** 归档文件，可在每个适配器的 **target** 文件夹中找到此文件：

![java-adapter-result](adapter-result.png)

### 部署
{: #deploy }

1. **pom.xml** 文件包含以下 `properties`：

   ```xml
   <properties>
    	<!-- parameters for deploy mfpf adapter -->
    	<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    	<mfpfUser>admin</mfpfUser>
    	<mfpfPassword>admin</mfpfPassword>
    	<mfpfRuntime>mfp</mfpfRuntime>
   </properties>
   ```
   
   * 使用您的 {{ site.data.keys.mf_server }} IP 地址和端口号替换 **localhost:9080**。
   * **可选**。使用您的 admin 用户名和密码替换 **mfpfUser** 和 **mfpfPassword** 缺省值。
   * **可选**。使用您的运行时名称替换 **mfpfRuntime** 缺省值。
2. 从项目的根文件夹运行部署命令：
 * **使用 {{ site.data.keys.mf_cli }}**：

   ```bash
   mfpdev adapter deploy -x
   ```
   
   `-x` 选项将适配器部署到适配器的 **pom.xml** 文件中指定的 {{ site.data.keys.mf_server }}。  
   如果未使用该选项，那么 CLI 将使用在 CLI 设置中指定的缺省服务器。
    
   > 有关更多的 CLI 部署选项，请运行命令：`mfpdev help adapter deploy`。
   
 * **使用 Maven**：

   ```bash
   mvn adapter:deploy
   ```

### 部署所有
{:# deploy-all }
如果 filesystem 文件夹中有多个适配器并且想要部署所有适配器，请使用：

```bash
mfpdev adapter deploy all
```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您也可以使用单个命令 `mvn install adapter:deploy` 来构建和部署适配器
### 部署到不同的运行时
{: #deploying-to-different-runtimes }
如果您运行多个运行时，请参阅[注册应用程序并将适配器部署到不同的运行时](../../installation-configuration/production/server-configuration/#registering-applications-and-deploying-adapters-to-different-runtimes)。

## 依赖关系
{: #dependencies }
要在适配器中使用外部库，请遵循以下建议的指示信息之一：

#### 添加本地依赖关系
{: #adding-a-local-dependency }

1. 在根 Maven 项目文件夹下添加 **lib** 文件夹，然后将外部库放入其中。
2. 在 Maven 项目的 **pom.xml** 文件中的 `dependencies` 元素下添加库路径。  

例如：

```xml
<dependency>
<groupId>sample</groupId>
<artifactId>com.sample</artifactId>
<version>1.0</version>
<scope>system</scope>
<systemPath>${project.basedir}/lib/</systemPath>
</dependency>
```

#### 添加外部依赖关系
{: #adding-an-external-dependency }

1. 搜索在线存储库（如 [The Central Repository](http://search.maven.org/)）以查找依赖关系。
2. 复制 POM 依赖关系信息，然后将其粘贴到 Maven 项目的 **pom.xml** 文件中的 `dependencies` 元素下。

以下示例使用 `cloudant-client artifactId`：

```xml
<dependency>
  <groupId>com.cloudant</groupId>
  <artifactId>cloudant-client</artifactId>
  <version>1.2.3</version>
</dependency>
```

> 有关依赖关系的更多信息，请参阅 Maven 文档。

## 将适配器分组在单个 Maven 项目中
{: #grouping-adapters-in-a-single-maven-project }

如果您的项目中有多个适配器，那么可能想要将这些适配器安排在单个 Maven 项目下。将适配器分组有利于构建所有、部署所有和共享依赖关系等。您也可以使用 `mfpdev adapter build all` 和 `mfpdev adapter deploy all` CLI 命令构建所有和部署所有适配器，即使没有将它们分组在单个 Maven 项目中。

要分组适配器，您需要：

1. 创建根文件夹并进行命名，例如“GroupAdapters”。
2. 将 Maven 适配器项目放入其中。
3. 创建 **pom.xml** 文件：

   ```xml
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    	<modelVersion>4.0.0</modelVersion>
    	<groupId>com.sample</groupId>
    	<artifactId>GroupAdapters</artifactId>
    	<version>1.0-SNAPSHOT</version>
    	<packaging>pom</packaging>

    	<modules>
				<module>Adapter1</module>
				<module>Adapter2</module>
    	</modules>

    	<properties>
    		<!-- parameters for deploy mfpf adapter -->
    		<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
    		<mfpfUser>admin</mfpfUser>
    		<mfpfPassword>admin</mfpfPassword>
        <mfpfRuntime>mfp</mfpfRuntime>
    	</properties>

   <build>
        <plugins>
			<plugin>
				<groupId>com.ibm.mfp</groupId>
				<artifactId>adapter-maven-plugin</artifactId>
				<extensions>true</extensions>
			</plugin>
		</plugins>
   </build>

   </project>
   ```
   
  1. 定义您选择的 **`groupId`** 元素
  2. 添加 **`artifactId`** 元素 - 根文件夹的名称
  3. 为每个适配器添加 **`module`** 元素
  4. 添加 **`build`** 元素
  5. **可选**。使用特定的 {{ site.data.keys.mf_server }} IP 地址和端口号替换 **localhost:9080**。
  6. **可选**。使用您的 admin 用户名和密码替换 **`mfpfUser`** 和 **`mfpfPassword`** 缺省值。
  7. **可选**。使用您的运行时名称替换 **`mfpfRuntime`** 缺省值。

4. 要[构建或部署](#build-and-deploy-adapters)所有适配器，请从根目录“GroupAdapters”项目运行 Maven 命令。

## 使用 {{ site.data.keys.mf_console }} 下载或部署适配器
{: #downloading-or-deploying-adapters-using-mobilefirst-operations-console}

1. 打开您选择的浏览器，并使用地址 `http://<IP>:<PORT>/mfpconsole/` 来加载 {{ site.data.keys.mf_console }}。  
2. 单击适配器旁边的“新建”按钮。您有两个创建适配器选项：
 * 使用 Maven 或 {{ site.data.keys.mf_cli }}，如上所述。
 * 下载模板适配器项目（步骤 2）。
3. 使用 Maven 或 {{ site.data.keys.mf_cli }} 构建适配器。
4. 选择以下方式之一来上载生成的 **.adapter** 文件，该文件可在适配器项目的目标文件夹中找到：
 * 单击“部署适配器”按钮（步骤 5）。
 * 将文件拖放到“新建”适配器屏幕中。

    ![使用控制台创建适配器](Create_adapter_console.png)

5. 成功部署适配器之后，将会显示包含以下选项卡的详细信息页面：
 * 配置 - 由适配器 XML 文件定义的属性。在这里，您可以更改配置，而无需再次部署。
 * 资源 - 适配器资源列表。
 * 配置文件 - 要用于 DevOps 环境中的适配器配置数据。

## 更新适配器 Maven 项目
{: #updating-the-adapter-maven-project }

要使用最新的发行版更新适配器 Maven 项目，请通过在 [Maven's Central Repository](http://search.maven.org/#search%7Cga%7C1%7Cibmmobilefirstplatformfoundation) 中
搜索“IBM MobileFirst Platform”以查找 API 的**版本号**和插件工件，然后更新适配器 Maven 项目的 **pom.xml** 文件中的以下属性：

1. `adapter-maven-api` 版本：

   ```xml
   <dependency>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-api</artifactId>
      <scope>provided</scope>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
   </dependency>
   ```
   
2. `adapter-maven-plugin` 版本：

   ```xml
   <plugin>
      <groupId>com.ibm.mfp</groupId>
      <artifactId>adapter-maven-plugin</artifactId>
      <version>{{ site.data.keys.prod_maven_adapter_version }}</version>
      <extensions>true</extensions>
   </plugin>
   ```

## 脱机工作
{: #working-offline }

如果没有 Maven Central Repository 的在线访问权，那么您可以共享贵组织内部存储库中的 {{ site.data.keys.product }} Maven 工件。

1. [访问“下载”页面]({{site.baseurl}}/downloads/)，然后下载 {{ site.data.keys.mf_dev_kit_full }} 安装程序。
2. 启动 {{ site.data.keys.mf_server }}，然后在浏览器中从以下 URL 加载 {{ site.data.keys.mf_console }}：`http://<your-server-host:server-port>/mfpconsole`。
3. 单击**下载中心**。在**工具 → 适配器 Archetype** 下，单击**下载**。这样会下载 **mfp-maven-central-artifacts-adapter.zip** 归档。
4. 通过运行适用于 Linux 和 Mac 的 **install.sh** 脚本或适用于 Windows 的 **install.bat** 脚本，将适配器 archetype 和安全性检查添加到内部 Maven 存储库。
5. adapter-maven-api 需要以下 JAR 文件。确保这些文件位于开发人员的本地 **.m2** 文件夹或位于贵组织的 Maven 存储库中。您可以从 The Central Repository 下载这些文件。
    * javax.ws.rs:javax.ws.rs-api:2.0
    * javax:javaee-web-api:6.0
    * org.apache.httpcomponents:httpclient:4.3.4
    * org.apache.httpcomponents:httpcore:4.3.2
    * commons-logging:commons-logging:1.1.3
    * javax.xml:jaxp-api:1.4.2
    * org.mozilla:rhino:1.7.7
    * io.swagger:swagger-annotations:1.5.6
    * com.ibm.websphere.appserver.api:com.ibm.websphere.appserver.api.json:1.0
    * javax.servlet:javax.servlet-api:3.0.1

## 后续教程
{: #tutorials-to-follow-next }

* [了解 Java 适配器](../java-adapters/)
* [了解 JavaScript 适配器](../javascript-adapters/)
* [在 IDE 中开发适配器](../developing-adapters/)
* [测试和调试适配器](../testing-and-debugging-adapters/)
* [查看所有适配器教程](../#tutorials-to-follow-next)
