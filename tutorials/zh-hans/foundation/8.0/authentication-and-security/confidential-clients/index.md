---
layout: tutorial
title: 保密客户机
relevantTo: [android,ios,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
移动应用程序可利用 {{ site.data.keys.product_adj }} 客户机 SDK 来请求访问受保护资源。  
非移动应用程序的其他实体也可执行此操作。 此类实体被视为**保密客户机**。

保密客户机是能够保持其认证凭证的保密性的客户机。 您可以根据 OAuth 规范，使用 {{ site.data.keys.product_adj }} 授权服务器来授权保密客户机访问受保护资源。 此功能允许您将资源访问权授予非移动客户机（如性能测试应用程序），以及请求受保护资源或使用 {{ site.data.keys.product }} **REST API** 之一（如用于**推送通知**的 REST API）时可能需要的任何其他种类的后端。

您可以从向 {{ site.data.keys.mf_server }} 注册保密客户机开始。 在注册过程中，您会提供保密客户机的凭证，其中包含一个标识和一个密钥。 此外，您还会设置客户机允许的作用域，用于确定可向此客户机授予的作用域。 当注册的保密客户机从授权服务器请求访问令牌时，服务器会使用注册凭证来认证客户机，并验证请求的作用域是否与客户机允许的作用域匹配。

注册的保密客户机可获取要在针对 {{ site.data.keys.mf_server }} 的所有请求中使用的令牌。 此流程基于 OAuth 规范的[客户机凭证流程](https://tools.ietf.org/html/rfc6749#section-1.3.4)。 请注意，保密客户机的访问令牌有效期为一小时。 如果您正在使用保密客户机执行持续时长超过一小时的任务，请通过发送新的令牌请求每隔一小时更新一次令牌。

## 注册保密客户机
{: #registering-the-confidential-client }
在 {{ site.data.keys.mf_console }} 的导航侧边栏中，单击**运行时设置** → **保密客户机**。 单击**新建**以添加新条目。  
您必须提供以下信息：

- **显示名称**：用来引用保密客户机的可选显示名称。 缺省显示名称为 ID 参数的值。 例如：**后端节点服务器**。
- **标识**：保密客户机的唯一标识（可视为“用户名”）。
  该标识仅包含 ASCII 字符。
- **密钥**：用于授权从保密客户机进行访问的专用口令（可视为 API 密钥）。
  该密钥仅包含 ASCII 字符。
- **允许的作用域**：自动向使用此标识与密钥组合的保密客户机授予此处定义的作用域。 有关作用域的更多信息，请参阅[作用域](../#scopes)。
    - 允许的作用域元素还可以包含特殊星号通配符 (`*`)，用于表示零个或多个字符的任意序列。 例如，如果作用域元素为 `send*`，那么可授权保密客户机访问包含以“send”开头的任何作用域元素（如“sendMessage”）的作用域。 星号通配符可置于作用域元素内的任何位置，也可以多次出现。 
    - 包含单个星号字符 (*) 的允许的作用域参数表示可向保密客户机授予针对任何作用域的令牌。

**作用域示例：**

- [保护外部资源](../protecting-external-resources)使用 `authorization.introspect` 作用域。
- 通过 REST API [发送推送通知](../../notifications/sending-notifications)使用空格分隔的作用域元素 `messages.write` 和 `push.application.<applicationId>`.
- 适配器可由定制作用域元素（如 `accessRestricted`）来保护。
- `*` 作用域是全方位作用域，授权访问任何请求的作用域。

<img class="gifplayer" alt="配置保密客户机" src="push-confidential-client.png"/>

## 预定义的保密客户机
{: #predefined-confidential-clients }
{{ site.data.keys.mf_server }} 随附有一些预定义的保密客户机：

### 测试
{: #test }
`test` 客户机仅在开发方式下可用。 它可帮助您轻松测试资源。

- **标识**：`test`
- **密钥**：`test`
- **允许的作用域**：`*`（任何作用域）

### 管理
{: #admin }
`admin` 客户机由 {{ site.data.keys.product }} 管理服务在内部使用。

### 推送
{: #push }
`push` 客户机由 {{ site.data.keys.product }} 推送服务在内部使用。

## 获取访问令牌
{: #obtaining-an-access-token }
可从 {{ site.data.keys.mf_server }} **令牌端点**获取令牌。  

**出于测试目的**，可如下所述使用 Postman。  
在实际情况下，使用您选择的技术在后端逻辑中实施 Postman。

1.  针对以下项发出 **POST** 请求：**http(s)://[ipaddress-or-hostname]:[port]/[runtime]/api/az/v1/token**。  
    例如：`http://localhost:9080/mfp/api/az/v1/token`
    - 在开发环境中，{{ site.data.keys.mf_server }} 使用预先存在的 `mfp` 运行时。  
    - 在生产环境中，将运行时值替换为运行时名称。

2.  使用 `application/x-www-form-urlencoded` 内容类型设置请求。  
3.  设置以下两个格式参数：
    - `grant_type` - 将值设置为 `client_credentials`。
    - `scope` - 将值设置为资源的保护作用域。 如果没有为资源分配保护作用域，请省略此参数以应用缺省作用域 (`RegisteredClient`)。 有关更多信息，请参阅[作用域](../../authentication-and-security/#scopes)。

       ![Postman 配置的图示](confidential-client-steps-1-3.png)

4.  要认证请求，请使用[基本认证](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side)。 使用保密客户机的**标识**和**密钥**。

    ![Postman 配置的图示](confidential-client-step-4.png)

    在 Postman 以外，如果您使用 **test** 保密客户机，请将 **HTTP 头**设置为 `Authorization: Basic dGVzdDp0ZXN0`（使用 **base64** 编码的 `test:test`）。

此请求的响应将包含 `JSON` 对象，包括**访问令牌**及其到期时间（1 小时）。

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp ...",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "sendMessage accessRestricted"
}
```

![创建保密客户机](confidential-client-access-token.png)

## 使用访问令牌
{: #using-the-access-token }
从这里开始，您可以通过添加 **HTTP 头**：`Authorization: Bearer eyJhbGciOiJSUzI1NiIsImp ...`，对所需的资源发出请求，将访问令牌替换为从先前 JSON 对象提取的令牌。

## 可能的响应
{: #possible-responses }
除资源可能生成的正常响应外，还要留意 {{ site.data.keys.mf_server }} 生成的一些响应。

### 持有者
{: #bearer }
具有 HTTP 头 `WWW-Authenticate : Bearer` 的 HTTP **401** 响应状态，意味着在原始请求的 `Authorization` 头上找不到任何令牌。

### invalid_token
{: #invalid-token }
具有 HTTP 头 `WWW-Authenticate: Bearer error="invalid_token"` 的 HTTP **401** 响应状态，意味着已发送的令牌**无效**或**已到期**。

### insufficient_scope
{: #insufficient-scope }
具有 HTTP 头 `WWW-Authenticate : Bearer error="insufficient_scope", scope="RegisteredClient scopeA scopeB"` 的 HTTP **403** 响应状态，意味着初始请求中的令牌与此资源所需的作用域不匹配。 此头还包含预期的作用域。

在发出请求时，如果不清楚资源需要哪个作用域，可使用 `insufficient_scope` 来确定所需作用域。 例如，在不指定作用域的情况下请求令牌，并对资源发出请求。 然后，可从 403 响应中提取所需作用域，并为此作用域请求新令牌。

