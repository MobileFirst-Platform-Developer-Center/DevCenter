---
layout: tutorial
title: OpenWhisk 适配器
breadcrumb_title: OpenWhisk 适配器
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

OpenWhisk 是功能即服务 (FaaS) 平台，允许在无服务器且可扩展的环境中执行代码。OpenWhisk 平台的一个用例是开发和运行无服务器的移动后端代码。在[此处](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south)了解有关 Bluemix 上 OpenWhisk 平台的更多信息。

{{ site.data.keys.product }} 适配器用于执行任何必要的服务器端逻辑，并从后端系统检索信息并将信息传输到客户机应用程序和云服务。{{ site.data.keys.product }} 现在为 OpenWhisk 功能提供一个适配器。

##  OpenWhisk 适配器
{: #openwhisk-adapter}

{{ site.data.keys.product_full }} 从 [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) 开始提供 OpenWhisk 适配器。可在 Mobile Foundation Console 中从**下载中心**下载和部署该适配器。

在下载和部署适配器之后，您应将其配置为连接到 OpenWhisk。

### 将适配器配置为连接到 OpenWhisk
{: configure-adapter-connect-openwhisk}

要将适配器配置连接到 OpenWhisk，请转至**适配器配置**页面并提供来自 OpenWhisk 授权密钥的_**用户名**_和_**密码**_。可以通过运行以下 OpenWhisk CLI 命令来获取 OpenWhisk 的_**用户名**_和_**密码**_：

```bash
./wsk property get --auth KEY
```

上面的命令将返回冒号分隔的授权密钥，冒号左侧是_**用户名**_，冒号右侧是_**密码**_。

_**用户名:密码**_

应在 OpenWhisk 适配器配置页面中提供上面获取的_**用户名**_和_**密码**_，并且应保存配置。客户机应用程序现在可以调用适配器 API 以调用 OpenWhisk 后端代码。

>要修改 OpenWhisk 适配器，可以从此 [Github Repo](https://github.com/mfpdev/mfp-extension-adapters) 中下载适配器源代码。
