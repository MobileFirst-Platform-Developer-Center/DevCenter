---
layout: tutorial
title: 为来自 CDN 的“直接更新”请求提供服务
breadcrumb_title: CDN Support
relevantTo: [cordova]
weight: 1
---
## 概述
{: #overview }
您可以配置从 CDN（内容交付网络）处理直接更新请求，而不是通过 {{ site.data.keys.mf_server }} 来处理。

#### 使用 CDN 的优势
{: #advantages-of-using-a-cdn }
使用 CDN 代替 {{ site.data.keys.mf_server }} 处理直接更新请求具有以下优势：

* 避免了 {{ site.data.keys.mf_server }} 的网络开销。
* 从 {{ site.data.keys.mf_server }} 处理请求时，传输速率超出了 250 MB/秒的限制。
* 确保针对所有用户提供更统一的直接更新体验，而无论地理位置如何。

#### 常规需求
{: #general-requirements }
要从 CDN 处理直接更新请求，请确保配置符合以下条件：

* CDN 必须为位于 {{ site.data.keys.mf_server }} 之前（或者根据需要，位于其他逆向代理之前）的逆向代理。
* 在从开发环境构建应用程序时，将目标服务器设置为 CDN 主机和端口，以代替 {{ site.data.keys.mf_server }} 的主机和端口。 例如，在运行 {{ site.data.keys.mf_cli }} 命令 mfpdev server add 时，提供 CDN 主机和端口。
* 在 CDN 管理面板中，需要标记以下直接更新 URL 以用于高速缓存，从而确保 CDN 将所有请求传递到 {{ site.data.keys.mf_server }}，直接更新请求除外。 对于直接更新请求，CDN 确定其是否获取了此内容。 如果已获取，那么将返回内容，而不会转至 {{ site.data.keys.mf_server }}；如果没有，将转至 {{ site.data.keys.mf_server }}，获取直接更新归档（.zip 文件），并进行存储以用于此特定 URL 的后续请求。 对于使用 {{ site.data.keys.product_full }} V8.0 构建的应用程序，直接更新 URL 为：`PROTOCOL://DOMAIN:PORT/CONTEXT_PATH/api/directupdate/VERSION/CHECKSUM/TYPE`。
`PROTOCOL://DOMAIN:PORT/CONTEXT_PATH` 前缀对于所有运行时请求不变： 例如：http://my.cdn.com:9080/mfp/api/directupdate/0.0.1/742914155/full?appId=com.ibm.DirectUpdateTestApp&clientPlatform=android

在此示例中，存在同样属于请求的其他请求参数。

* CDN 必须允许请求参数的高速缓存。 两个不同的直接更新归档可能仅在请求参数方面不同。
* CDN 必须支持直接更新响应上的 TTL。 需要此支持以针对相同版本支持多个直接更新。
* CDN 不得更改或除去在服务器/客户端协议中使用的 HTTP 头。

## 示例配置
{: #example-configuration }
此示例基于 Akamai CDN 配置的使用，该配置可对直接更新归档进行高速缓存。 网络管理员、{{ site.data.keys.product_adj }} 管理员和 Akamai 管理员完成以下任务：

#### 网络管理员
{: #network-administrator }
在 DNS 中为您的 {{ site.data.keys.mf_server }} 创建另一个域。 例如，如果服务器域是 yourcompany.com，那么需要创建另一个域，例如，`cdn.yourcompany.com`。
在新 `cdn.yourcompany.com` 域的 DNS 中，将 `CNAME` 设置为 Akamai 提供的域名。 例如，`yourcompany.com.akamai.net`。

#### {{ site.data.keys.product_adj }} 管理员
{: #mobilefirst-administrator }
将新的 cdn.yourcompany.com 域设置为 {{ site.data.keys.product_adj }} 应用程序的 {{ site.data.keys.mf_server }} URL。 例如，对于 Ant 构建器任务，属性为：`<property name="wl.server" value="http://cdn.yourcompany.com/${contextPath}/"/>`。

#### Akamai 管理员
{: #akamai-administrator }
1. 打开 Akamai 属性管理器并将属性**主机名**设置为新域的值。

    ![将属性主机名设置为新域的值](direct_update_cdn_3.jpg)
    
2. 在“缺省规则”选项卡上，配置原始 {{ site.data.keys.mf_server }} 主机和端口，并将**定制转发主机头**值设置为新创建的域。

    ![将“定制转发主机头”值设置为新创建的域](direct_update_cdn_4.jpg)
    
3. 从**高速缓存选项**列表中，选择**不存储**。

    ![在“高速缓存选项”列表中，选择“不存储”。](direct_update_cdn_5.jpg)

4. 从**静态内容配置**选项卡，根据应用程序的直接更新 URL 配置匹配条件。 例如，创建声明 `IfPath matches one of direct_update_URL` 的条件。

    ![根据应用程序的直接更新 URL 配置匹配条件](direct_update_cdn_6.jpg)
    
5. 设置与以下类似的值以配置高速缓存行为，从而高速缓存直接更新 URL 并设置 TTL。

    | 字段 | 值 |
    |-------|-------|
    | 高速缓存选项 | 高速缓存 |
    | 旧文件对象的强制重新评估 | 如果无法验证，那么提供旧文件 |
    | Max-Age | 3 分钟 |

    ![设置值以配置高速缓存行为](direct_update_cdn_7.jpg)

6. 配置高速缓存密钥行为以使用高速缓存密钥中的所有请求参数（必须执行此操作以针对不同的应用程序或版本高速缓存不同的直接更新归档）。 例如，从**行为**列表，选择 `Include all parameters (preserve order from request)`。

    ![配置高速缓存密钥行为以使用高速缓存密钥中的所有请求参数](direct_update_cdn_8.jpg)


