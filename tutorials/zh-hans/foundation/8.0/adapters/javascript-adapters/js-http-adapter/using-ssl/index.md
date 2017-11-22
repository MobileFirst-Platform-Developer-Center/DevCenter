---
layout: tutorial
title: 在 JavaScript HTTP 适配器中使用 SSL
breadcrumb_title: 使用 SSL
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
您可以在 HTTP 适配器中使用 SSL，以通过使用简单认证和相互认证来连接到后端服务。  
SSL 表示传输级别安全性，独立于基本认证。 能够通过 HTTP 或 HTTPS 实现基本认证。

1. 在 adapter.xml 文件中，将 HTTP 适配器的 URL 协议设置为 <b>https</b>。
2. 将 SSL 证书存储到 {{ site.data.keys.mf_server }} 密钥库中。 [请参阅“配置 {{ site.data.keys.mf_server }} 密钥库”](../../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)。

### 使用相互认证的 SSL
{:# ssl-with-mutual-authentication }

如果使用“使用相互认证的 SSL”，那么您还必须执行以下步骤：

1. 为 HTTP 适配器生成自己的专用密钥，或使用可信的证书颁发中心提供的密钥。
2. 如果您生成自己的专用密钥，请导出所生成专用密钥的公用证书，然后将其导入后端信任库。
3. 在 **adapter.xml** 文件的 `connectionPolicy` 元素中为专用密钥定义别名和密码。 
