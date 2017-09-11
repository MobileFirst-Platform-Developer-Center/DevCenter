---
layout: tutorial
title: Java 适配器
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

Java 适配器基于 JAX-RS 2.0 规范。换句话说，Java 适配器是 JAX-RS 2.0 服务，可被轻松部署到 {{ site.data.keys.mf_server }} 实例，且具有对 {{ site.data.keys.mf_server }} API 和其他第三方 API 的访问权。

**先决条件：**请务必先阅读[创建 Java 和 JavaScript 适配器](../creating-adapters)教程。

#### 跳转至
{: #jump-to }

* [文件结构](#file-structure)
* [JAX-RS 2.0 应用程序类](#jax-rs-20-application-class)
* [实施 JAX-RS 2.0 资源](#implementing-a-jax-rs-20-resource)
* [HTTP 会话
](#http-session)
* [服务器端 API](#server-side-apis)

## 文件结构
{: #file-structure }

![mvn-adapter](java-adapter-fs.png)

### adapter-resources 文件夹  
{: #the-adapter-resources-folder }

**adapter-resources** 文件夹包含 XML 配置文件 (**adapter.xml**)。在此配置文件中，您为此适配器配置 JAX-RS 2.0 应用程序的类名。例如：`com.sample.JavaAdapterApplication`。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaAdapter"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaAdapter</displayName>
	<description>JavaAdapter</description>

	<JAXRSApplicationClass>com.sample.JavaAdapterApplication</JAXRSApplicationClass>
	
	<property name="DB_url" displayName="Database URL" defaultValue="jdbc:mysql://127.0.0.1:3306/mobilefirst_training"  />
	<property name="DB_username" displayName="Database username" defaultValue="mobilefirst"  />
	<property name="DB_password" displayName="Database password" defaultValue="mobilefirst"  />
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    	<property name="maxAttempts" defaultValue="3"/>
	</securityCheckDefinition>
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击获取 adapter.xml 属性和子元素</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>name</b>：<i>必填。</i> 适配器的名称。
该名称在 {{ site.data.keys.mf_server }} 内必须是唯一的。
它可以包含字母数据字符和下划线，且必须以字母开头。在定义和部署适配器之后，您无法修改其名称。</li>
					<li><b>displayName</b>：<i>可选。</i> 显示在 {{ site.data.keys.mf_console }} 中的适配器名称。如果未指定此元素，那么将使用 name 属性的值来替代。</li>
					<li><b>description</b>：<i>可选。</i> 适配器的其他信息。显示在 {{ site.data.keys.mf_console }} 中。</li>
					<li><b>JAXRSApplicationClass</b>：<i>对于公开 /adapter 端点是必需的。</i> 定义该适配器的 JAX-RS 应用程序的类名。在此示例中，是 <b>com.sample.JavaAdapterApplication</b>。</li>
					<li><b>securityCheckDefinition</b>：<i>可选。</i> 定义安全性检查对象。在<a href="../../authentication-and-security/creating-a-security-check">创建安全性检查</a>教程中了解有关安全性检查的更多信息。</li>
					<li><b>property</b>：<i>可选。</i> 声明用户定义的属性。在下面的定制属性主题中了解更多信息。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>结束部分</b></a>。
            </div>
        </div>
    </div>
</div>

#### 定制属性
{: #custom-properties }

**adapter.xml** 文件也可包含用户定义的定制属性。可在 **{{ site.data.keys.mf_console }} → [您的适配器] → 配置选项卡**中覆盖在适配器创建期间开发人员指定给这些属性的值，无需重新部署适配器。可使用 [ConfigurationAPI 界面](#configuration-api)读取用户定义的属性，然后在运行时进一步定制。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注：**配置属性元素必须位于 `JAXRSApplicationClass` 元素**下**。  
在上面的示例中，我们定义了连接设置，并赋予它们缺省值，因此稍后可以在 AdapterApplication 类中使用这些设置。
`<property>` 元素采用以下属性：

- **name**：属性的名称，如配置类中所定义。
- **defaultValue**：覆盖配置类中定义的缺省值。
- **displayName**：*可选*，要显示在控制台中的友好名称。
- **description**：*可选*，要显示在控制台中的描述。
- **type**：*可选*，确保该属性是一个特定类型，例如 `integer`、`string`、`boolean` 或有效值列表（例如 `type="['1','2','3']"`）。

![控制台属性](console-properties.png)

#### 拉取和推送配置
{: #pull-and-push-configurations }

可使用**配置文件选项卡**中的适配器配置文件来共享定制的适配器属性。  
要执行此操作，请通过 Maven 或 {{ site.data.keys.mf_cli }} 使用下面描述的 `pull` 和 `push` 命令。对于要共享的属性，您需要*更改提供给属性的缺省值*。

从适配器 Maven 项目的根文件夹运行命令：

**Maven**  

* 要**拉取**配置文件  
  ```bash
  mvn adapter:configpull -DmfpfConfigFile=config.json
  ```

* 要**推送**配置文件
  ```bash
  mvn adapter:configpush -DmfpfConfigFile=config.json
  ```

**{{ site.data.keys.mf_cli }}**  

* 要**拉取**配置文件
  ```bash
  mfpdev adapter pull
  ```

* 要**推送**配置文件
  ```bash
  mfpdev adapter push
  ```

#### 将配置推送到多个服务器
{: #pushing-configurations-to-multiple-servers }

**pull** 和 **push** 命令能够帮助创建各种 DevOps 流，根据您所处环境（DEV、QA、UAT 或 PRODUCTION），适配器中需要不同的值。

**Maven**  
注意上述部分，如何在缺省情况下指定 **config.json** 文件。创建不同名称的文件以寻址不同的目标。

**{{ site.data.keys.mf_cli }}**  
使用 **--configFile** 或 **-c** 标记指定与缺省配置文件不同的配置文件：

```bash
mfpdev adapter pull -c [adapterProject]/alternate_config.json
```

> 使用 `mfpdev help adapter pull/push` 了解更多信息。

### java 文件夹
{: #the-java-folder }

JAX-RS 2.0 服务的 Java 源放置在此文件夹中。JAX-RS 2.0 服务由应用程序类（其扩展 `com.ibm.mfp.adapter.api.MFPJAXRSApplication`）和资源类组成。

JAX-RS 2.0 应用程序和资源类定义 Java 方法及其到 URL 的映射。  
`com.sample.JavaAdapterApplication` 是 JAX-RS 2.0 应用程序类，`com.sample.JavaAdapterResource` 是包含在应用程序中的 JAX-RS 2.0 资源。

## JAX-RS 2.0 应用程序类
{: #jax-rs-20-application-class }

JAX-RS 2.0 应用程序类告诉 JAX-RS 2.0 框架哪些资源包含在应用程序中。

```java
package com.sample.adapter;

import java.util.logging.Logger;
import com.ibm.mfp.adapter.api.MFPJAXRSApplication;

public class JavaAdapterApplication extends MFPJAXRSApplication{

    static Logger logger = Logger.getLogger(JavaAdapterApplication.class.getName());

    @Override
    protected void init() throws Exception {
        logger.info("Adapter initialized!");
    }

    @Override
    protected String getPackageToScan() {
        //The package of this class will be scanned (recursively) to find JAX-RS 2.0 resources.
        return getClass().getPackage().getName();
    }
}
```

`MFPJAXRSApplication` 类扫描软件包中的 JAX-RS 2.0 资源并自动创建一个列表。另外，只要部署了适配器（在其开始提供服务之前）且 {{ site.data.keys.product }} 运行时启动，{{ site.data.keys.mf_server }} 将会调用其 `init` 方法。

## 实施 JAX-RS 2.0 资源
{: #implementing-a-jax-rs-20-resource }

JAX-RS 2.0 资源是映射到根 URL 的 POJO（普通旧 Java 对象），并且具有向此根 URL 及其子 URL 提供请求的 Java 方法。任何资源都可以有一组独立的 URL。

```java
package com.sample.adapter;

import java.util.logging.Logger;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/")
public class JavaAdapterResource {

    //Define logger (Standard java.util.Logger)
    static Logger logger = Logger.getLogger(JavaAdapterResource.class.getName());

    //Path for method: "<server address>/Adapters/adapters/JavaAdapter/{username}"
    @GET
    @Path("/{username}")
    public String helloUser(@PathParam("username") String name){
        return "Hello " + name;
    }
}
```

* 类定义之前的 `@Path("/")` 确定该资源的根路径。如果有多个资源类，那么应该为每个资源设置不同的路径。  

	例如，如果使用具有 `@Path("/users")` 的 `UserResource` 来管理博客用户，那么该资源可通过 `http(s)://host:port/ProjectName/adapters/AdapterName/users/` 访问。

	同一适配器可能包含用于管理博客帖子的另一个资源 `PostResource`，其包含 `@Path("/posts")`。可通过 `http(s)://host:port/ProjectName/adapters/AdapterName/posts/` URL 来进行访问。  

	在上述示例中，因为其只有一个资源类，所以将其设置为 `@Path("/")`，以便可通过 `http(s)://host:port/Adapters/adapters/JavaAdapter/` 访问。  

* 每一个方法前面都有一个或多个 JAX-RS 2.0 注释，例如类型为“HTTP 请求”（如 `@GET`、`@PUT`、`@POST`、`@DELETE` 或 `@HEAD`）的注释。此类注释定义如何访问该方法。  

* 另一个示例是 `@Path("/{username}")`，用于定义访问此过程的路径（除资源级路径外）。正如您所见，此路径可包含一个可变部分。之后将该变量用作方法的参数，如定义的 `@PathParam("username") String name` 那样。  

> 您可以使用许多其他注释。请参阅此处的 **Annotation Types Summary**：
[https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html](https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/javax/ws/rs/package-summary.html)

>**要点：**如果在适配器实现中使用对 `javax.ws.rs.*` 或 `javax.servlet.*` 中的类的静态引用，那么应确保使用以下选项之一来配置 **RuntimeDelegate**：
*	在 Liberty `jvm.options` 中设置 `-Djavax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl`，或者
*	设置系统属性或 JVM 定制属性 `javax.ws.rs.ext.RuntimeDelegate=org.apache.cxf.jaxrs.impl.RuntimeDelegateImpl`


## HTTP 会话

{: #http-session }

{{ site.data.keys.mf_server }} 不依赖于 HTTP 会话，且每个请求都可到达不同的节点。不应依赖于 HTTP 会话来传输请求的数据。

## 服务器端 API
{: #server-side-apis}

Java 适配器可以使用服务器端 Java API 执行与 {{ site.data.keys.mf_server }} 相关的操作，例如调用其他适配器，记录到服务器日志，获取配置属性的值，向分析报告活动以及获取请求发出者的身份。  

### 配置 API
{: #configuration-api }

`ConfigurationAPI` 类提供用于检索 **adapter.xml** 或 {{ site.data.keys.mf_console }} 中定义的属性的 API。

在您的 Java 类中，在类级别添加以下内容：

```java
@Context
	ConfigurationAPI configurationAPI;

	```

然后，您可以使用 `configurationAPI` 实例获取属性：

```java
configurationAPI.getPropertyValue("DB_url");
```

在从 {{ site.data.keys.mf_console }} 修改适配器配置时，会重新装入 JAX-RS 应用程序类，并再次调用它的 `init` 方法。

`getServerJNDIProperty` 方法也可用于从服务器配置检索 JNDI 属性。

您可以参考 [Java SQL 适配器教程](java-sql-adapter)上的用法示例。

### 适配器 API
{: #adapters-api }

`AdaptersAPI` 类提供用于检索有关当前适配器的信息并将 REST 请求发送到其他适配器的 API。

在您的 Java 类中，在类级别添加以下内容：

```java
@Context
AdaptersAPI adaptersAPI;
```

您可以参考[高级适配器用法聚合教程](../advanced-adapter-usage-mashup)上的用法示例。

### 分析 API
{: #analytics-api }

`AnalyticsAPI` 类提供用于向分析报告信息的 API。

在您的 Java 类中，在类级别添加以下内容：

```java
@Context
AnalyticsAPI analyticsAPI;
```

您可以参考[分析 API 教程](../../analytics/analytics-api)上的用法示例。

### 安全性 API
{: #security-api }

`AdapterSecurityContext` 类提供适配器 RSET 调用的安全上下文。

在您的 Java 类中，在类级别添加以下内容：

```java
@Context
AdapterSecurityContext securityContext;
```

例如，您可以使用以下代码获取当前 `AuthenticatedUser`：

```java
AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
```

## Java 适配器示例
{: #java-adapter-examples }

有关 Java 适配器与 HTTP 或 SQL 后端通信的示例，请参阅：
