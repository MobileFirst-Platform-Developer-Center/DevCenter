---
layout: tutorial
title: 更新 MobileFirst Server
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
IBM MobileFirst Platform Foundation 提供了多种组件，您可能已安装这些组件。

以下是有关这些组件的依赖关系的描述，用于对其进行更新：

### MobileFirst Server 管理服务、MobileFirst Operations Console 和 MobileFirst 运行时环境
{: #server-console }

这三个组件组成 MobileFirst Server。 这些组件必须一起更新。

### Application
Center
{: #appenter}

该组件的安装为可选操作。 该组件独立于其他组件。 如果需要，该组件可在不同于其他组件的临时修订级别运行。

### MobileFirst Operational Analytics
{: #analytics}

该组件的安装为可选操作。 MobileFirst 组件通过 REST API 向 MobileFirst Operational Analytics 发送数据。 最好将 MobileFirst Operational Analytics 与处于相同临时修订级别的其他 MobileFirst Server 组件一起运行。


## 更新 MobileFirst Server 管理服务、MobileFirst Operations Console 和 MobileFirst 运行时环境
{: #updating-server}

可通过两种方式更新这些组件：
* 通过 Server Configuration Tool
* 通过 Ant 任务

更新过程取决于您在初始安装时使用的方法。

> **注：**Installation Manager(IM) 不支持回滚更新/临时修订。 但是，如果您拥有旧的 WAR 文件，那么可以通过使用 Ant 或 Server Configuration Tool 来进行回滚。

### 通过使用 Server Configuration Tool 应用修订包
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
如果已使用该配置工具安装 {{ site.data.keys.mf_server }} 并且保留了配置文件，那么可以复用该配置文件来应用修订包或临时修订。

1. 启动 Server Configuration Tool。
    * 在 Linux，通过应用程序快捷方式**应用程序 → IBM MobileFirst Platform Server → Server Configuration Tool**。
    * 在 Windows 上，单击**开始 → 程序 → IBM MobileFirst Platform Server → Server Configuration Tool**。
    * 在 macOS 上，打开 shell 控制台。 转至 **mfp\_server\_install_dir/shortcuts**，然后输入 **./configuration-tool.sh**。
    * **mfp\_server\_install\_dir** 是 {{ site.data.keys.mf_server }} 的安装目录。

2. 单击**配置 → 替换已部署的 WAR 文件**，然后选择现有配置来应用修订包或临时修订。


### 使用 Ant 文件应用修订包
{: #applying-a-fix-pack-by-using-the-ant-files }

#### 使用样本 Ant 文件更新
{: #updating-with-the-sample-ant-file }
如果使用 **mfp\_install\_dir/MobileFirstServer/configuration-samples** 目录中提供的样本 Ant 文件安装 {{ site.data.keys.mf_server }}，那么可以复用此 Ant 文件副本来应用修订包。 对于密码值，可以输入运行 Ant 文件时交互提示的 12 个星号 (\*)，而非实际值。

1. 验证 Ant 文件中 **mfp.server.install.dir** 属性的值。 它必须指向包含应用修订包的产品的目录。 将使用此值提取更新的 {{ site.data.keys.mf_server }} WAR 文件。
2. 运行命令： `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### 使用自己的 Ant 文件更新
{: #updating-with-own-ant-file }
如果使用您自己的 Ant 文件，请确保对于每项安装任务（**installmobilefirstadmin**、**installmobilefirstruntime** 和 **installmobilefirstpush**），您都在具有相同参数的 Ant 文件中拥有相应的更新任务。 相应的更新任务有 **updatemobilefirstadmin**、**updatemobilefirstruntime** 和 **updatemobilefirstpush**。

1. 验证 **mfp-ant-deployer.jar** 文件的 **taskdef** 元素的类路径。 它必须指向应用修订包的 {{ site.data.keys.mf_server }} 安装中的 **mfp-ant-deployer.jar** 文件。 缺省情况下，将从 **mfp-ant-deployer.jar** 位置提取更新的 {{ site.data.keys.mf_server }} WAR 文件。
2. 运行 Ant 文件的更新任务（**updatemobilefirstadmin**、**updatemobilefirstruntime** 和 **updatemobilefirstpush**）。
