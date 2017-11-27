---
layout: tutorial
title: 认证和安全性
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

{{ site.data.keys.product_adj }} 安全框架基于 [OAuth 2.0](http://oauth.net/) 协议。 根据本协议，可通过定义访问资源的必需许可权的**作用域**来保护资源。 要访问受保护资源，客户机必须提供匹配的**访问令牌**，用于封装授予客户机的授权作用域。

OAuth 协议将授权服务器与托管资源的资源服务器的角色相分离。

* 授权服务器管理客户机授权和令牌生成。
* 资源服务器使用授权服务器来验证由客户机提供的访问令牌，并确保它匹配所请求资源的保护作用域。

安全框架围绕实施 OAuth 协议的授权服务器而构建，并公开客户机与之交互以获取访问令牌的 OAuth 端点。 安全框架提供构建块，用于在授权服务器和底层 OAuth 协议上实施定制授权逻辑。
缺省情况下，{{ site.data.keys.mf_server }} 也充当**授权服务器**。 但是，您可以配置 IBM WebSphere DataPower 设备以充当授权服务器并与 {{ site.data.keys.mf_server }} 进行交互。

然后，客户机应用程序可以使用这些令牌来访问**资源服务器**上的资源，这可以是 {{ site.data.keys.mf_server }} 本身或者外部服务器。 资源服务器会检查令牌的有效性，以确保可授权客户机访问所请求的资源。 资源服务器与授权服务器分离使您能够对在 {{ site.data.keys.mf_server }} 之外运行的资源实施安全性。

应用程序开发者通过为每个保护的资源定义所需的作用域，并实施**安全性检查**和**验证问题处理程序**来保护对资源的访问。 服务器端安全框架和客户机端 API 用于处理 OAuth 消息交换以及与授权服务器的透明交互，从而使开发者能够仅专注于授权逻辑。

#### 跳转至：
{: #jump-to }

* [授权实体](#authorization-entities)
* [保护资源](#protecting-resources)
* [授权流](#authorization-flow)
* [后续关注教程](#tutorials-to-follow-next)

## 授权实体
{: #authorization-entities }

### 访问令牌
{: #access-tokens }

{{ site.data.keys.product_adj }} 访问令牌是描述客户机授权许可权的数字签名实体。 在针对特定作用域授予客户机授权请求且认证客户机后，授权服务器的令牌端点会向客户机发送包含所请求的访问令牌的 HTTP 响应。

#### 结构
{: #structure }

{{ site.data.keys.product_adj }} 访问令牌包含以下信息：

* **客户机标识**：客户机的唯一标识。
* **作用域**：授予令牌的作用域（请参阅 OAuth 作用域）。 此作用域不包括[必需的应用程序作用域](#mandatory-application-scope)。
* **令牌到期时间**：令牌无效（到期）的时间（秒）。

#### 令牌到期
{: #token-expiration }

授予的访问令牌将一直保持有效直至到期。 访问令牌的到期时间设置为作用域内所有安全性检查到期时间中最短的到期时间。 但是，如果到最短到期时间的时间段长于应用程序的最长令牌到期时间段，那么令牌的到期时间将设置为当前时间加上最长到期时间段。 缺省最长令牌到期时间段（有效持续时间）为 3600 秒（1 小时），但是可通过设置 `maxTokenExpiration` 属性的值进行配置。 请参阅“配置最长访问令牌到期时间段”。

<div class="panel-group accordion" id="configuration-explanation" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="access-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>配置最长访问令牌到期时间段</b></a>
            </h4>
        </div>

        <div id="collapse-access-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="access-token-expiration">
            <div class="panel-body">
            <p>通过使用以下一种备选方法配置应用程序的最长访问令牌到期时间段：</p>
            <ul>
                <li>使用 {{ site.data.keys.mf_console }}
                    <ul>
                        <li>选择 <b>[您的应用程序] → 安全</b>选项卡。</li>
                        <li>在<b>令牌配置</b>部分中，将<b>最长令牌到期时间段（秒）</b>字段的值设置为您的首选值，然后单击<b>保存</b>。 您可以随时重复此过程以更改最长令牌到期时间段，或者选择<b>复原缺省值</b>以恢复缺省值。</li>
                    </ul>
                </li>
                <li>编辑应用程序的配置文件
                    <ol>
                        <li>从<b>命令行窗口</b>中，导航至项目的根文件夹并运行 <code>mfpdev app pull</code>。</li>
                        <li>打开位于 <b>[project-folder]\mobilefirst</b> 文件夹的配置文件。</li>
                        <li>编辑文件：定义 <code>maxTokenExpiration</code> 属性，并将该值设置为最长的访问令牌到期时间段（秒）：

{% highlight xml %}
{
    ...
    "maxTokenExpiration": 7200
}
{% endhighlight %}</li>
                        <li>通过运行以下命令部署更新的配置 JSON 文件：<code>mfpdev app push</code>。</li>
                    </ol>
                </li>
            </ul>

            <br/>
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

<div class="panel-group accordion" id="response-access-token" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="response-structure">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>访问令牌响应结构</b></a>
            </h4>
        </div>

        <div id="collapse-response-structure" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure">
            <div class="panel-body">
                <p>访问令牌请求的成功 HTTP 响应包含一个 JSON 对象以及访问令牌和其他数据。 以下是来自授权服务器的有效令牌响应的示例：</p>

{% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
    "token_type": "Bearer",
    "expires_in": 3600,
    "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
    "scope": "scopeElement1 scopeElement2"
}
{% endhighlight %}

<p>令牌响应 JSON 对象具有以下属性对象：</p>
<ul>
    <li><b>token_type</b>：根据 <a href="https://tools.ietf.org/html/rfc6750">OAuth 2.0 Bearer Token Usage 规范</a>，令牌类型始终为<i>“Bearer”</i>。</li>
    <li><b>expires_in</b>：访问令牌的到期时间（秒）。</li>
    <li><b>access_token</b>：生成的访问令牌（实际访问令牌长于示例中显示的值）。</li>
    <li><b>scope</b>：请求的作用域。</li>
</ul>

<p>令牌本身 (<b>access_token</b>) 也包含 <b>expires_in</b> 和 <b>scope</b> 信息。</p>

<blockquote><b>注：</b>如果使用低级别 <code>WLAuthorizationManager</code> 类并自行管理客户机与授权和资源服务器之间的 OAuth 交互，或者如果使用保密客户机，那么有效访问令牌响应结构则相关。 如果使用封装 OAuth 流以访问受保护资源的高级别 <code>WLResourceRequest</code> 类，那么安全框架为您执行访问令牌响应的处理工作。 <a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_oauth_client_apis.html?view=kc#c_oauth_client_apis">请参阅客户机安全性 API</a> 和<a href="confidential-clients">保密客户机</a>。</blockquote>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>

### 安全性检查
{: #security-checks }

安全性检查是实施安全逻辑来保护服务器端应用程序资源的服务器端实体。 安全性检查的简单示例是用户登录安全性检查，用于接收用户凭证，并针对用户注册表验证凭证。 另一个示例是预定义的 {{ site.data.keys.product_adj }} 应用程序真实性安全检查，用于验证移动应用程序的真实性，并因而防止非法尝试访问应用程序资源。 也可使用相同的安全性检查来保护多种资源。

安全性检查通常会发出安全验证问题，要求客户机以特定方式进行响应以通过检查。 此握手是作为 OAuth 访问令牌获取流程的一部分发生的。 客户机使用**验证问题处理程序**以处理来自安全性检查的验证问题。

#### 内置安全性检查
{: #built-in-security-checks }

以下预定义安全性检查可用：

- [应用程序真实性](application-authenticity/)
- [基于 LTPA 的单点登录 (SSO)](ltpa-security-check/)
- [直接更新](../application-development/direct-update)

### 验证问题处理程序
{: #challenge-handlers }
在尝试访问受保护资源时，客户机可能面临验证问题。 验证问题是服务器发出的问题、安全测试和提示，用于确定允许客户机访问此资源。 最常见的情况是，该验证问题是对凭证的请求，例如，用户名和密码。

验证问题处理程序是客户机端实体，实施客户机端安全逻辑和相关的用户交互。
**重要信息**：在收到验证问题后，不能将其忽略。 必须回答或者取消。 忽略验证问题可能会导致意外的行为。

> 在[创建安全性检查](creating-a-security-check/)教程中了解有关安全性检查的更多信息，并在[凭证验证](credentials-validation)教程中了解有关验证问题处理程序的更多信息。

### 作用域
{: #scopes }

您可以通过向资源分配**作用域**，保护资源（例如，适配器）免遭未经授权的访问。

将作用域定义为由一个或多个以空格分隔的作用域元素组成的字符串（“scopeElement1 scopeElement2 ...”），或者，如果要应用缺省作用域 (`RegisteredClient`)，那么定义为 null。 要访问任何适配器资源，{{ site.data.keys.product_adj }} 安全框架都要求提供访问令牌，即使没有为资源分配作用域，也是如此；除非您对该资源禁用了资源保护。 请参阅[保护适配器资源](#protecting-adapter-resources )。

#### 作用域元素
{: #scope-elements }

作用域元素可以为以下之一：

* 安全性检查的名称。
* 任意关键字，例如，`access-restricted` 或 `deletePrivilege`，用于定义此资源所需的安全级别。 之后可将此关键字映射到安全性检查。

#### 作用域映射
{: #scope-mapping }

缺省情况下，在**作用域**中编写的**作用域元素**将映射到**具有相同名称的安全性检查**。
例如，如果编写名为 `PinCodeAttempts` 的安全性检查，那么可在作用域中使用具有相同名称的作用域元素。

作用域映射允许将作用域元素映射到安全性检查。 在客户机请求作用域元素时，此配置定义应该应用的安全性检查。   例如，您可以将作用域元素 `access-restricted` 映射到 `PinCodeAttempts` 安全性检查。

如果想要根据尝试访问资源的应用程序以不同方式保护资源，那么作用域映射非常有用。
您还可以将一个作用域映射到包含零项或多项安全性检查的列表。

例如：
scope = `access-restricted deletePrivilege`

* 在应用程序 A 中
  * `access-restricted` 映射到 `PinCodeAttempts`。
  * `deletePrivilege` 映射到空字符串。
* 在应用程序 B 中
  * `access-restricted` 映射到 `PinCodeAttempts`。
  * `deletePrivilege` 映射到 `UserLogin`。

> 要将作用域元素映射到空字符串，请勿在**添加新作用域元素映射**弹出菜单中选择任何安全性检查。

<img class="gifplayer" alt="作用域映射" src="scope_mapping.png"/>

您还可以使用必需的配置来手动编辑应用程序的配置 JSON 文件，并将更改推送回 {{ site.data.keys.mf_server }}。

1. 从**命令行窗口**导航至项目的根文件夹，然后运行 `mfpdev app pull`。
2. 打开位于 **[project-folder]\mobilefirst** 文件夹的配置文件。
3. 编辑文件：定义 `scopeElementMapping` 属性，在此属性中，定义由选中的作用域元素的名称和零项或多项空格分隔的安全性检查（将元素映射到此检查）的字符串组成的数据对。 例如：

    ```xml
    "scopeElementMapping": {
        "UserAuth": "UserAuthentication",
        "SSOUserValidation": "LtpaBasedSSO CredentialsValidation"
    }
    ```
4. 运行以下命令来部署更新的配置 JSON 文件：`mfpdev app push`。

> 您还可以将更新的配置推送到远程服务器。 请查看[使用 {{ site.data.keys.mf_cli }} 来管理 {{ site.data.keys.product_adj }} 工件](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts)教程。

## 保护资源
{: #protecting-resources }

在 OAuth 模型中，受保护资源是需要访问令牌的资源。 您可以使用 {{ site.data.keys.product_adj }} 安全框架来保护在 {{ site.data.keys.mf_server }} 实例上托管的资源以及外部服务器上的资源。 您可以通过为资源分配定义必需的许可权（用于获取资源的访问令牌）的作用域来保护资源。

您可以通过各种方式来保护资源：

### 必需的应用程序作用域
{: #mandatory-application-scope }

可以在应用程序级别定义应用于应用程序所使用的所有资源的作用域。 除了所请求资源作用域的安全性检查，安全框架还运行这些检查（如果存在）。

**注：**
* 在访问[不受保护的资源](#unprotected-resources)时，不会应用必需的应用程序作用域。
* 为资源作用域授予的访问令牌不包含必需的应用程序作用域。

<br/>
在 {{ site.data.keys.mf_console }} 中，从导航侧边栏的**应用程序**部分选择应用程序，然后选择**安全性**选项卡。 在**必需的应用程序作用域**下，选择**添加到作用域**。

<img class="gifplayer" alt="必需的应用程序作用域" src="mandatory-application-scope.png"/>

您还可以使用必需的配置来手动编辑应用程序的配置 JSON 文件，并将更改推送回 {{ site.data.keys.mf_server }}。

1.  从**命令行窗口**导航至项目的根文件夹，然后运行 `mfpdev app pull`。
2.  打开位于 **project-folder\mobilefirst** 文件夹中的配置文件。
3.  通过定义 `mandatoryScope` 属性，并将属性值设置为包含选中作用域元素的空格分隔列表的作用域字符串来编辑文件。 例如：

    ```xml
    "mandatoryScope": "appAuthenticity PincodeValidation"
    ```
4.  运行以下命令来部署更新的配置 JSON 文件：`mfpdev app push`。

> 您还可以将更新的配置推送到远程服务器。 请查看[使用 {{ site.data.keys.mf_cli }} 来管理 {{ site.data.keys.product_adj }} 工件](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts)教程。

### 保护适配器资源
{: #protecting-adapter-resources }

在适配器中，可以对 Java 方法、JavaScript 资源过程或整个 Java 资源类指定保护作用域，如以下 [Java](#protecting-java-adapter-resources) 和 [JavaScript](#protecting-javascript-adapter-resources) 部分中所述。 将作用域定义为由一个或多个以空格分隔的作用域元素组成的字符串（“scopeElement1 scopeElement2 ...”），或者，如果要应用缺省作用域 ，那么定义为 null（请参阅 [作用域](#scopes)）。

缺省 {{ site.data.keys.product_adj }} 作用域为 `RegisteredClient`，需要访问令牌才能访问资源；缺省作用域会验证资源请求是否来自在 {{ site.data.keys.mf_server }} 中注册的应用程序。 将始终应用此保护措施，除非您[禁用资源保护](#disabling-resource-protection)。 因此，即使没有为资源设置作用域，资源仍受保护。

> <b>注：</b>`RegisteredClient` 是保留的 {{ site.data.keys.product_adj }} 关键字。 请勿使用此名称定义定制的作用域元素或安全性检查。

#### 保护 Java 适配器资源
{: #protecting-java-adapter-resources }

要向 JAX-RS 方法或类分配保护作用域，请向方法或类声明添加 `@OAuthSecurity` 注释，并将注释的 `scope` 元素设置为您的首选作用域。 将 `YOUR_SCOPE` 替换为由一个或多个作用域元素组成的字符串（“scopeElement1 scopeElement2 ...”）：
```
@OAuthSecurity(scope = "YOUR_SCOPE")
```

类作用域适用于类中的所有方法，但自身具有 `@OAuthSecurity` 注释的方法除外。

<b>注：</b>将 `@OAuthSecurity` 注释的 `enabled` 元素设置为 `false` 时，将忽略 `scope` 元素。 请参阅[禁用 Java 资源保护](#disabling-java-resource-protection)。

##### 示例
{: #java-adapter-resource-protection-examples }

以下代码使用包含 `UserAuthentication` 和 `Pincode` 作用域元素的作用域来保护 `helloUser` 方法：
```java
@GET
@Path("/{username}")
@OAuthSecurity(scope = "UserAuthentication Pincode")
public String helloUser(@PathParam("username") String name){
    ...
}
```

以下代码使用预定义的 `LtpaBasedSSO` 安全性检查来保护 `WebSphereResources` 类：
```java
@Path("/users")
@OAuthSecurity(scope = "LtpaBasedSSO")
public class WebSphereResources {
    ...
}
```

#### 保护 JavaScript 适配器资源
{: #protecting-javascript-adapter-resources }

要向 JavaScript 过程分配保护作用域，请在 <b>adapter.xml</b> 文件中将 &lt;procedure&gt; 元素的作用域属性设置为您的首选作用域。 将 `PROCEDURE_NANE` 替换为您过程的名称，将 `YOURSCOPE` 替换为由一个或多个作用域元素组成的字符串（“scopeElement1 scopeElement2 ...”）：
```xml
<procedure name="PROCEDURE_NANE" scope="YOUR_SCOPE">
```

<b>注：</b>将 &lt;procedure&gt; 元素的 `secured` 属性设置为 false 时，将忽略 `scope` 属性。 请参阅[禁用 JavaScript 资源保护](#disabling-javascript-resource-protection)。

#### 示例
{: #javascript-adapter-resource-protection-examples }

以下代码使用包含 `UserAuthentication` 和 `Pincode` 作用域元素的作用域来保护 `userName` 过程：
```xml
<procedure name="userName" scope="UserAuthentication Pincode">
```

### 禁用资源保护
{: #disabling-resource-protection }

您可以对特定的 Java 或 JavaScript 适配器资源或者整个 Java 类禁用[缺省的 {{ site.data.keys.product_adj }} 资源保护](#protecting-adapter-resources)，如以下 [Java](#disabling-java-resource-protection) 和 [JavaScript](#disabling-javascript-resource-protection) 部分中所述。 如果禁用资源保护，那么 {{ site.data.keys.product_adj
 }} 安全框架不需要令牌即可访问资源。 请参阅[不受保护的资源](#unprotected-resources)。

#### 禁用 Java 资源保护
{: #disabling-java-resource-protection }

要对 Java 资源方法或类完全禁用 OAuth 保护，请向资源或类声明添加 `@OAuthSecurity` 注释，并将 `enabled` 元素的值设置为 `false`：
```java
@OAuthSecurity(enabled = false)
```
注释的 `enabled` 元素的缺省值为 `true`。 如果将 `enabled` 元素设置为 `false`，那么会忽略 `scope` 元素，因此资源或资源类将[不受保护](#unprotected-resources)。

<b>注：</b>在向不受保护的类的方法分配作用域后，该方法将受到保护，而不论类注释是何内容；除非您将资源注释的 `enabled` 元素设置为 `false`。

##### 示例
{: #disabling-java-resource-protection-examples }

以下代码将对 `helloUser` 方法禁用资源保护：
```java
    @GET
    @Path("/{username}")
    @OAuthSecurity(enabled = "false")
    public String helloUser(@PathParam("username") String name){
        ...
    }
```

以下代码将对 `MyUnprotectedResources` 类禁用资源保护：
```java
    @Path("/users")
    @OAuthSecurity(enabled = "false")
    public class MyUnprotectedResources {
        ...
    }
```

#### 禁用 JavaScript 资源保护
{: #disabling-javascript-resource-protection }

要对 JavaScript 适配器资源（过程）完全禁用 OAuth 保护，请在 <b>adapter.xml</b> 文件中将 &lt;procedure&gt; 元素的 `secured` 属性设置为 `false`：
```xml
<procedure name="procedureName" secured="false">
```

如果将 `secured` 属性设置为 `false`，那么会忽略 `scope` 属性，因此资源将[不受保护](#unprotected-resources)。

##### 示例
{: #disabling-javascript-resource-protection-examples }

以下代码将对 `userName` 过程禁用资源保护：
```xml
<procedure name="userName" secured="false">
```

### 不受保护的资源
{: #unprotected-resources }

不受保护的资源是不需要访问令牌的资源。 {{ site.data.keys.product_adj }} 安全框架不会管理对不受保护资源的访问，并且不会验证或检查访问这些资源的客户机的身份。 因此，对于不受保护的资源，不支持诸如直接更新、阻止设备访问或远程禁用应用程序之类的功能。

### 保护外部资源
{: #protecting-external-resources }

要保护外部资源，可向外部资源服务器添加包含访问令牌验证模块的资源过滤器。 令牌验证模块使用安全框架授权服务器的自省端点来验证 {{ site.data.keys.product_adj }} 访问令牌，然后再授权 OAuth 客户机访问资源。 您可以将 [{{ site.data.keys.product_adj }} REST API 用于 {{ site.data.keys.product_adj }} 运行时](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_runtime_overview.html?view=kc#rest_runtime_api)，以针对任何外部服务器创建自己的访问令牌验证模块。 或者，使用一个提供的 {{ site.data.keys.product_adj }} 扩展来保护外部 Java 资源，如[保护外部资源](protecting-external-resources)教程中所述。

## 授权流
{: #authorization-flow }

授权流具有两个阶段：

1. 客户机获取访问令牌。
2. 客户机使用令牌来访问受保护资源。

### 获取访问令牌
{: #obtaining-an-access-token }

在此阶段中，客户机进行**安全性检查**以接收访问令牌。

在请求访问令牌之前，客户机向 {{ site.data.keys.mf_server }} 注册自身。 在注册过程中，客户机提供将用于认证其身份的公用密钥。 在移动应用程序实例生命周期中，此阶段发生一次。 如果启用了应用程序真实性安全检查，那么在注册期间将验证应用程序的真实性。

![获取令牌](auth-flow-1.jpg)

1.  客户机应用程序发送请求以获取指定作用域的访问令牌。

    > 客户机请求具有特定作用域的访问令牌。 请求的作用域应映射到与客户机想要访问的受保护资源的作用域相同的安全性检查，而且也可以选择映射到其他安全性检查。 如果客户机先前不知道受保护资源的作用域，那么首先可请求具有空作用域的访问令牌，然后尝试使用获取的令牌访问资源。 客户机将收到一个响应，包含 403（禁止）错误以及所请求资源的必需作用域。

2.  客户机应用程序将根据请求的作用域进行安全性检查。

    > {{ site.data.keys.mf_server }} 运行要将客户机请求的作用域映射到的安全性检查。 授权服务器将根据这些检查的结果授权或拒绝客户机请求。 如果定义了必需的应用程序作用域，那么除了请求的作用域检查，还会运行此作用域的安全性检查。

3.  在成功完成验证问题流程后，客户机应用程序会将请求转发给授权服务器。

    > 在成功授权后，客户机将重定向到授权服务器的令牌端点，在此处将使用在客户机注册期间提供的公用密钥对其进行认证。 在成功认证后，授权服务器会向客户机发出数字签名的访问令牌，此令牌封装客户机标识、请求的作用域和令牌的到期时间。

4.  客户机应用程序接收访问令牌。

### 使用令牌来访问受保护资源
{: #using-a-token-to-access-a-protected-resource }

可以针对在 {{ site.data.keys.mf_server }} 上运行的资源（如此图中所示）以及在任何外部资源服务器上运行的资源（如教程[使用 {{ site.data.keys.mf_server }} 来认证外部资源](protecting-external-resources/)中所解释）实施安全性。

在获取访问令牌后，客户机将获取的令牌附加到后续请求以访问受保护资源。 资源服务器使用授权服务器的自省端点来验证令牌。 验证包括使用令牌的数字签名来验证客户机的身份，验证作用域与授权的请求作用域是否匹配以及确保令牌未到期。 在验证令牌后，将授权客户机访问资源。

![保护资源](auth-flow-2.jpg)

1. 客户机应用程序发送包含已收到令牌的请求。
2. 验证模块会验证令牌。
3. {{ site.data.keys.mf_server }} 继续进行适配器调用。

## 后续关注教程
{: #tutorials-to-follow-next }

通过关注侧边栏导航中的教程，继续阅读 {{ site.data.keys.product_adj }} Foundation 中有关认证的信息。
