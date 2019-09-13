---
layout: tutorial
title: 在 Eclipse 中使用 MobileFirst Server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
可以在 Eclipse IDE 中集成 {{ site.data.keys.mf_server }}。 这有助于提供统一的开发体验。

* 您还可以在 Eclipse 中公开 CLI 功能，请参阅[在 Eclipse 中使用 {{ site.data.keys.mf_server }}](../../../../application-development/using-mobilefirst-cli-in-eclipse) 教程。
* 此外，也可以在 Eclipse 中开发适配器，请参阅[在 Eclipse 中开发适配器](../../../../adapters/developing-adapters)教程。

### 将服务器添加到 Eclipse 中
{: #adding-the-server-to-eclipse }
1. 从 Eclipse 的**服务器**视图中，选择**新建 → 服务器**。
2. 如果不存在 IBM 文件夹选项，请单击“下载其他服务器适配器”。
3. 选择 **WebSphere Application Server Liberty Tools**，并按照屏幕上的指示信息进行操作。
4. 从 Eclipse 的**服务器**视图中，选择**新建 → 服务器**。
5. 选择 **IBM → WebSphere Application Server Liberty**。
6. 提供服务器的**名称**和**主机名**，然后单击**下一步**。
7. 提供到服务器根目录的路径，并选择要使用的 JRE 版本。 使用 {{ site.data.keys.mf_dev_kit }} 时，根目录为 **[installation directory]/mfp-server** 文件夹。
8. 单击**下一步**，然后单击**完成**。

您现在可以从 Eclipse IDE 的“服务器”视图中启动和停止 {{ site.data.keys.mf_server }}。
