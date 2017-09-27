---
layout: tutorial
title: JavaScript 适配器
show_children: true
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

JavaScript 适配器提供用于连接到 HTTP 和 SQL 后端的模板。此模板提供一组称为过程的服务，移动应用程序可以通过发出 AJAX 请求来调用这些过程。

**先决条件：**请务必先阅读[创建 Java 和 JavaScript 适配器](../creating-adapters)教程。

## 文件结构
{: #file-structure }

![mvn-adapter](js-adapter-fs.png)

### adapter-resources 文件夹
{: #the-adapter-resources-folder }

**adapter-resources** 文件夹包含 XML 配置文件。该配置文件描述连接选项并列示向应用程序或其他适配器公开的过程。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">
    <displayName>JavaScriptAdapter</displayName>
    <description>JavaScriptAdapter</description>
    
    <connectivity>
        <connectionPolicy>
        ...
        </connectionPolicy>
    </connectivity>

    <procedure name="procedure1"></procedure>
    <procedure name="procedure2"></procedure>

    <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a name="click-for-adapter-xml-attributes-and-subelements" class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击获取 adapter.xml 属性和子元素</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><code>name</code>：<i>必填。</i> 适配器的名称。
该名称在 {{ site.data.keys.mf_server }} 内必须是唯一的。
它可以包含字母数据字符和下划线，且必须以字母开头。在定义和部署适配器之后，您无法修改其名称。</li>
					<li><b>&lt;displayName&gt;</b>：<i>可选。</i> 显示在 {{ site.data.keys.mf_console }} 中的适配器名称。如果未指定此元素，那么将使用 name 属性的值来替代。</li>
					<li><b>&lt;description&gt;</b>：<i>可选。</i> 适配器的其他信息。显示在 {{ site.data.keys.mf_console }} 中。</li>
					<li><b>&lt;connectivity&gt;</b>：<i>必填。</i> 定义适配器连接到后端应用程序时使用的机制。它包含 &lt;connectionPolicy&gt; 子元素。<ul>
                            <li><b>&lt;connectionPolicy&gt;</b>：<i>必填。</i>定义连接属性。此子元素的结构取决于后端应用程序的集成技术。有关 &lt;connectionPolicy&gt; 的更多信息，请参阅 <a href="js-http-adapter">HTTP 适配器 &lt;connectionPolicy&gt; 元素</a>和 <a href="js-sql-adapter">SQL 适配器 &lt;connectionPolicy&gt; 元素</a>。</li>
                        </ul>
                    </li>
                    <li><b>&lt;procedure&gt;</b>：<i>必填。</i>定义用于访问后端应用程序公开的服务的过程。
<ul>
                            <li><code>name</code>：<i>必填。</i> 过程的名称。该名称在适配器内必须是唯一的。它可以包含字母数据字符和下划线，且必须以字母开头。</li>
                            <li><code>audit</code>：<i>可选。</i>用于定义过程调用是否会记录在审计日志中。以下值有效：<ul>
                                    <li><code>true</code>：对过程的调用会记录在审计日志中。</li>
                                    <li><code>false</code>：缺省值。对过程的调用不会记录在审计日志中。</li>
                                </ul>
                            </li>
                            <li><code>scope</code>：<i>可选。</i>用于保护适配器资源过程的安全性作用域。作用域可以是由一个或多个以空格分隔的作用域元素组成的字符串，或者，如果要应用缺省作用域，那么为 null。作用域元素可以是映射到安全性检查的关键字，或者安全性检查的名称。缺省作用域为 <code>RegisteredClient</code>，这是保留的 {{ site.data.keys.product_adj }} 关键字。缺省保护要求使用访问令牌才能访问资源。<br/>
								有关 {{ site.data.keys.product_adj }} OAuth 资源保护以及如何为 JavaScript 适配器资源配置资源保护的更多信息，请参阅<a href="../../authentication-and-security/#protecting-adapter-resources">保护适配器资源</a>。<br/>
								当 <code>secured</code> 属性的值为 <code>false</code> 时，将忽略 <code>scope</code> 属性。</li>
                            <li><code>secured</code>：<i>可选。</i>定义适配器过程是否受 {{ site.data.keys.product_adj }} 安全框架的保护。以下值有效：<ul>
                                    <li><code>true</code>：缺省值。过程受保护。对过程的调用需要有效的访问令牌。</li>
                                    <li><code>false</code>。过程不受保护。对过程的调用不需要访问令牌。请参阅<a href="../../authentication-and-security/#unprotected-resources">不受保护的资源</a>。设置该值时将忽略 <code>scope</code> 属性。</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><b>&lt;securityCheckDefinition&gt;</b>：<i>可选。</i>定义安全性检查对象。在<a href="../../authentication-and-security/creating-a-security-check">创建安全性检查</a>教程中了解有关安全性检查的更多信息。</li>
        			<li><code>property</code>：<i>可选。</i> 声明用户定义的属性。可在本教程的<a href="#custom-properties">定制属性</a>部分中了解更多信息。</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

#### 定制属性
{: #custom-properties }

**adapter.xml** 文件也可包含用户定义的定制属性。可在 **{{ site.data.keys.mf_console }} → [您的适配器] → 配置选项卡**中覆盖在适配器创建期间开发人员指定给这些属性的值，无需重新部署适配器。可使用 [getPropertyValue API](#getpropertyvalue) 读取用户定义的属性，然后在运行时进一步定制。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **注：**配置属性元素必须始终位于 &lt;procedure&gt; 元素*下*。在上述示例中，我们定义了一个具有缺省值的 &lt;displayName&gt; 属性，供稍后使用。

&lt;property&gt; 元素采用以下属性：

- `name`：属性的名称，如配置类中所定义。
- `defaultValue`：覆盖配置类中定义的缺省值。
- `displayName`：*可选*，要显示在控制台中的友好名称。
- `description`：*可选*，要显示在控制台中的描述。
- `type`：*可选*，确保该属性是一个特定类型，例如 `integer`、`string`、`boolean` 或有效值列表（例如 `type="['1','2','3']"`）。

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

### js 文件夹
{: #the-js-folder }

该文件夹包含 **adapter.xml** 文件中声明的过程的所有 JavaScript 实施文件。还包含零个、一个或多个 XSL 文件，此类文件中包含用于检索到的原始 XML 数据的转换方案。适配器检索到的数据可以按原始格式返回或由适配器本身进行预处理。
不论哪种，都会作为 **JSON 对象**提供给应用程序。

## JavaScript 适配器过程
{: #javascript-adapter-procedures }

出于以下目的，已在 XML 中声明并通过服务器端 JavaScript 实施这些过程：

* 向应用程序提供适配器功能
* 调用后端服务以检索数据或执行操作

在 **adapter.xml** 文件中声明的每个过程都必须在 JavaScript 文件中具有相应的函数。

通过使用服务器端 JavaScript，过程可以在其调用服务之前或之后处理数据。通过使用简单的 XSLT 代码，您可以针对检索到的数据应用更多过滤。  
JavaScript 适配器过程是在 JavaScript 中实施的。但是，由于适配器是服务器端实体，因此可以[在适配器代码中使用 Java](../javascript-adapters/using-java-in-javascript-adapters)。

### 使用全局变量
{: #using-global-variables }

{{ site.data.keys.mf_server }} 不依赖于 HTTP 会话，且每个请求都可到达不同的节点。不应依赖于全局变量来传输请求的数据。

### 适配器响应阈值
{: #adapter-response-threshold }

适配器调用不是为了返回巨大的数据块，因为适配器响应作为字符串存储在 {{ site.data.keys.mf_server }} 内存中。因此，超出可用内存量的数据可能会导致内存不足异常，适配器调用将失败。为防止此类调用失败，您可以配置一个阈值，使 {{ site.data.keys.mf_server }} 根据此阈值返回 gzip 压缩的 HTTP 响应。HTTP 协议具有支持 gzip 压缩的标准头。客户机应用程序也必须支持 HTTP 方式的 gzip 内容。

#### 服务器端
{: #server-side }

在 {{ site.data.keys.mf_console }} 中，在**运行时 > 设置 > 适配器响应的 GZIP 压缩阈值**下，设置期望的阈值。缺省值为 20 KB。  
**注：**在 {{ site.data.keys.mf_console }} 中保存更改后，更改将在运行时中立即生效。

#### 客户机端
{: #client-side }

通过将每个客户机请求中的 `Accept-Encoding` 头的值设置为 `gzip`，可确保客户机能够解析 gzip 响应。
将 `addHeader` 方法与请求变量结合使用，例如：`request.addHeader("Accept-Encoding","gzip");`

## 服务器端 API
{: #server-side-apis }

JavaScript 适配器可以使用服务器端 API 执行与 {{ site.data.keys.mf_server }} 相关的操作，如调用其他 JavaScript 适配器、记录到服务器日志、获取配置属性的值、向 Analytics 报告活动以及获取请求发出者的身份。  

### getPropertyValue
{: #getpropertyvalue }

`MFP.Server.getPropertyValue(propertyName)` API 用于检索在 **adapter.xml** 或 {{ site.data.keys.mf_console }} 中定义的属性：

```js
MFP.Server.getPropertyValue("name");
```

### getTokenIntrospectionData
{: #gettokenintrospectiondata }

使用 `MFP.Server.getTokenIntrospectionData()` API

要获取当前的用户标识，使用：

```js
function getAuthUserId(){
   var securityContext = MFP.Server.getTokenIntrospectionData();
   var user = securityContext.getAuthenticatedUser();

   return "User ID: " + user.getId;
}
```

### getAdapterName
{: #getadaptername }

`getAdapterName()` API 用于检索适配器名称。

### invokeHttp
{: #invokehttp }

在 HTTP 适配器中使用 `MFP.Server.invokeHttp(options)` API。  
您可以参考 [JavaScript HTTP 适配器](js-http-adapter)教程中的用法示例。

### invokeSQL
{: #invokesql }

在 SQL 适配器中使用 `MFP.Server.invokeSQLStatement(options)` 和 `MFP.Server.invokeSQLStoredProcedure(options)` API。  
您可以参考 [JavaScript SQL 适配器](js-sql-adapter)教程中的用法示例。

### addResponseHeader
{: #addresponseheader }

`MFP.Server.addResponseHeader(name,value)` API 用于为响应添加新的头：

```js
MFP.Server.addResponseHeader("Expires","Sun, 5 October 2014 18:00:00 GMT");
```
### getClientRequest
{: #getclientrequest }

`MFP.Server.getClientRequest()` API 用于获取对 Java HttpServletRequest 对象的引用，该对象用于调用适配器过程：

```js
var request = MFP.Server.getClientRequest();
var userAgent = request.getHeader("User-Agent");
```

### invokeProcedure
{: #invokeprocedure }

`MFP.Server.invokeProcedure(invocationData)` 用于调用其他 JavaScript 适配器。  
您可以参考[高级适配器用法和聚合](../advanced-adapter-usage-mashup)教程中的用法示例。

### 记录日志
{: #logging }

JavaScript API 通过 MFP.Logger 类提供日志记录功能。它包含对应于四个标准日志记录级别的四个函数。  
您可以参考[服务器端日志集合](../server-side-log-collection)教程，以了解更多信息。

## JavaScript 适配器示例
{:# javascript-adapter-examples }
