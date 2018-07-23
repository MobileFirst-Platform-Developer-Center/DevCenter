---
layout: tutorial
title: 在 IBM Cloud Private 上设置 MobileFirst Server
breadcrumb_title: Mobile Foundation on IBM Cloud Private
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
遵循以下指示信息以在 {{ site.data.keys.prod_icp }} 上配置 {{ site.data.keys.mf_server }} 实例和 {{ site.data.keys.mf_analytics }} 实例：

* 设置 IBM Cloud Private Kubernetes 集群。
* 使用所需工具（Docker、IBM Cloud CLI (bx)、{{ site.data.keys.prod_icp }} (icp) Plugin for IBM Cloud CLI (bx pr)、Kubernetes CLI (kubectl) 和 Helm CLI (helm)）来设置主计算机。
* 下载用于 {{ site.data.keys.prod_icp }} 的 {{ site.data.keys.product_full }} Passport Advantage 归档（PPA 归档）。
* 在 {{ site.data.keys.prod_icp }} 集群中装入 PPA 归档。
* 最后，您将配置和安装 {{ site.data.keys.mf_analytics }}（可选）和 {{ site.data.keys.mf_server }}。

#### 跳转至：
{: #jump-to }
* [先决条件](#prereqs)
* [下载 IBM Mobile Foundation Passport Advantage 归档](#download-the-ibm-mfpf-ppa-archive)
* [装入 IBM Mobile Foundation Passport Advantage 归档](#load-the-ibm-mfpf-ppa-archive)
* [安装和配置 IBM {{site.data.keys.product }} Helm Chart](#configure-install-mf-helmcharts)
* [验证安装](#verify-install)
* [样本应用程序](#sample-app)
* [升级 {{ site.data.keys.prod_adj }} Helm Chart 和发行版](#upgrading-mf-helm-charts)
* [卸载](#uninstall)

## 先决条件
{: #prereqs}

您应该具有 {{ site.data.keys.prod_icp }} 帐户，并且必须遵循 [{{ site.data.keys.prod_icp }} 集群安装](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/installing.html)中的文档设置 Kubernetes 集群。

要管理容器和映像，需要在
{{site.data.keys.prod_icp }} 设置期间在主机上安装以下工具：

* Docker
* IBM Cloud CLI (`bx`)
* {{ site.data.keys.prod_icp }} (ICP) plugin for IBM Cloud CLI (`bx pr`)
* Kubernetes CLI (`kubectl`)
* Helm (`helm`)

要使用 CLI 访问 {{ site.data.keys.prod_icp }} 集群，应配置 *kubectl* 客户机。 [了解更多信息](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html)。

## 下载 IBM Mobile Foundation Passport Advantage 归档
{: #download-the-ibm-mfpf-ppa-archive}
[此处](https://www-01.ibm.com/software/passportadvantage/pao_customer.html)提供 {{ site.data.keys.product_full }} 的 Passport Advantage (PPA) 归档。 {{ site.data.keys.product }} 的 PPA 归档将包含以下 {{ site.data.keys.product }} 组件的 Docker 映像和 Helm Chart：
* {{ site.data.keys.product_adj }} Server
* {{ site.data.keys.product_adj }} Analytics
* {{ site.data.keys.product_adj }} Application Center

## 装入 IBM Mobile Foundation Passport Advantage 归档
{: #load-the-ibm-mfpf-ppa-archive}
在装入 {{ site.data.keys.product }} 的 PPA 归档之前，必须设置 Docker。 请参阅[此处](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_images/using_docker_cli.html)的指示信息。

遵循以下指定的步骤以将 PPA 归档装入到 {{ site.data.keys.prod_icp }} 集群：

  1. 使用 IBM Cloud ICP 插件 (`bx pr`) 登录到集群。
      >请参阅 {{ site.data.keys.prod_icp }} 文档中的 [CLI 命令参考](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/cli_commands.html)。

      例如，
      ```bash
      bx pr login -a https://ip:port
      ```
      （可选）如果您打算跳过 SSL 验证，请在上述命令中使用标记 `--skip-ssl-validation`。 使用此选项将提示输入集群端点的 `username` 和 `password`。 在成功登录后，继续以下步骤。

  2. 使用以下命令装入 {{ site.data.keys.product }} 的 PPA 归档：
      ```
      bx pr load-ppa-archive --archive <archive_name> [--clustername <cluster_name>] [--namespace <namespace>]
      ```
      {{ site.data.keys.product }} 的 *archive_name* 是从 IBM Passport Advantage 下载的 PPA 归档的名称。

      如果已执行先前步骤并将集群端点设置为 `bx pr` 的缺省值，那么可忽略 `--clustername`。

  3. 在装入 PPA 归档后，同步存储库，确保在**目录**中列出 Helm Chart。 您可以在 {{site.data.keys.prod_icp }} 管理控制台中执行此操作。
      * 选择**管理 > 存储库**。
      * 单击**同步存储库**。

  4.  在 {{ site.data.keys.prod_icp }} 管理控制台中查看 Docker 映像和 Helm Chart。
      要查看 Docker 映像，请执行以下操作：
      * 选择**平台 > 映像**。
      * 在**目录**中显示 Helm Chart。

  在完成上述步骤后，您将看到在 ICP 目录中显示已上载版本的 {{site.data.keys.prod_adj }} Helm Chart。 {{ site.data.keys.mf_server }} 作为 **ibm-mfpf-server-prod** 列出，并且 {{ site.data.keys.mf_analytics }} 作为 **ibm-mfpf-analytics-prod** 列出。

## 安装和配置 IBM {{site.data.keys.product }} Helm Chart
{: #configure-install-mf-helmcharts}

在安装和配置 {{site.data.keys.mf_server }} 之前，您应具有以下内容：

* [**必需**] 已配置且可供使用的 DB2 数据库。
  您将需要数据库信息以[配置 {{ site.data.keys.mf_server }} helm](#install-hmc-icp)。 {{ site.data.keys.mf_server }} 需要将在此数据库中创建（如果不存在）的模式和表。

* [**可选**] 使用密钥库和信任库的密钥。
  您可以通过使用自己的密钥库和信任库来创建密钥，从而为部署提供自己的密钥库和信任库。

  在安装之前，请执行以下步骤：

  * 使用 `keystore.jks`、`keystore-password.txt`、`truststore.jks` 和 `truststore-password.txt` 创建密钥，并在字段 *keystores.keystoresSecretName* 中提供密钥名称。

  * 将文件 `keystore.jks` 及其密码保留在名为 `keystore-password.txt` 的文件中，并将 `truststore.jks` 及其密码保留在名为 `truststore-password.jks` 的文件中。

  * 转至命令行并执行：
    ```bash
    kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
    ```
    >**注：**文件名应与提及的名称相同，例如，`keystore.jks`、`keystore-password.txt`、`truststore.jks` 和 `truststore-password.txt`。

  * 在 *keystoresSecretName* 中提供密钥名称以覆盖缺省密钥库。

  有关更多信息，请参阅[配置 MobileFirst Server 密钥库]({{ site.baseurl }}/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/)。  

### {{ site.data.keys.mf_analytics }} 的环境变量
{: #env-mf-analytics }
下表提供在 {{ site.data.keys.prod_icp }} 上的 {{ site.data.keys.mf_analytics }} 中使用的环境变量。

| 限定符 | 参数 | 定义 | 允许值 |
|-----------|-----------|------------|---------------|
| arch |  | 工作程序节点架构 | 应将此图表部署至的工作程序节点架构。<br/>当前仅支持 **AMD64** 平台。 |
| image | pullPolicy | 映像拉取策略 | 缺省值为 **IfNotPresent**。 |
|  | tag | Docker 映像标记 | 请参阅 [Docker 标记描述](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Docker 映像名称 | {{ site.data.keys.prod_adj }} Operational Analytics Docker 映像的名称。 |
| scaling | replicaCount | 需要创建的 {{ site.data.keys.prod_adj }} Operational Analytics 实例 (pod) 数量 | 正整数<br/>缺省值为 **2** |
| mobileFirstAnalyticsConsole | user | {{ site.data.keys.prod_adj }} Operational Analytics 的用户名 | 缺省值为 **admin**。 |
|  | password | {{ site.data.keys.prod_adj }} Operational Analytics 的密码 | 缺省值为 **admin**。 |
| analyticsConfiguration | clusterName | {{ site.data.keys.prod_adj }} Analytics 集群的名称 | 缺省值为 **mobilefirst** |
|  | analyticsDataDirectory | 存储分析数据的路径。 *它还将与在容器内安装持久卷声明的路径相同*。 | 缺省为 `/analyticsData` |
|  | numberOfShards | {{ site.data.keys.prod_adj }} Analytics 的 Elasticsearch 分片数量 | 正整数<br/>缺省值为 **2** |
|  | replicasPerShard | 针对 {{ site.data.keys.prod_adj }} Analytics 每个分片要维护的 Elasticsearch 副本数量 | 正整数<br/>缺省值为 **2** |
| keystores | keystoresSecretName | 请参阅[安装和配置 IBM {{site.data.keys.product }} Helm Chart](#configure-install-mf-helmcharts)，其中描述使用密钥库及其密码创建密钥的步骤。 |  |
| jndiConfigurations | mfpfProperties | {{ site.data.keys.prod_adj }} JNDI 属性，为定制 Operational Analytics 而指定 | 提供逗号分隔的名称值对。 |
| resources | limits.cpu | 描述允许的最大 CPU 量 | 缺省值为 **2000m**<br/>请阅读 [CPU 的含义](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)。 |
|  | limits.memory | 描述允许的最大内存量 | 缺省值为 **4096Mi**<br/>请阅读[内存的含义](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)。 |
|  | requests.cpu | 描述所需的最小 CPU 量。 如果未指定，那么缺省为 *limits*（如果已指定）或实现定义的值 | 缺省值为 **1000m**。 |
|  | requests.memory | 描述所需的最小内存量。 如果未指定，那么内存量缺省为 *limits*（如果已指定）或实现定义的值 | 缺省值为 **2048Mi**。 |
| persistence | existingClaimName | 现有持久卷声明 (PVC) 的名称 |  |


### {{ site.data.keys.mf_server }} 的环境变量
{: #env-mf-server }
下表提供在 {{ site.data.keys.prod_icp }} 上的 {{ site.data.keys.mf_server }} 中使用的环境变量。

| 限定符 | 参数 | 定义 | 允许值 |
|-----------|-----------|------------|---------------|
| arch |  | 工作程序节点架构 | 应将此图表部署至的工作程序节点架构。<br/>当前仅支持 **AMD64** 平台。 |
| image | pullPolicy | 映像拉取策略 | 缺省为 **IfNotPresent**。 |
|  | tag | Docker 映像标记 | 请参阅 [Docker 标记描述](https://docs.docker.com/engine/reference/commandline/image_tag/) |
|  | name | Docker 映像名称 | {{ site.data.keys.prod_adj }} Server Docker 映像的名称。 |
| scaling | replicaCount | 需要创建的 {{ site.data.keys.prod_adj }} Server 实例 (pod) 数量 | 正整数<br/>缺省值为 **3** |
| mobileFirstOperationsConsole | user | {{ site.data.keys.prod_adj }} Server 的用户名 | 缺省值为 **admin**。 |
|  | password | {{ site.data.keys.prod_adj }} Server 用户的密码 | 缺省值为 **admin**。 |
| existingDB2Details | db2Host | 需要配置 {{ site.data.keys.prod_adj }} Server 表的 DB2 数据库的 IP 地址或主机 | 当前仅支持 DB2。 |
|  | db2Port | 设置 DB2 数据库的端口 |  |
|  | db2Database | 在 BD2 中预先配置以供使用的数据库名称 |  |
|  | db2Username | 用于访问 BD2 数据库的 DB2 用户名 | 用户应有权创建表和创建模式（如果尚不存在）。 |
|  | db2Password | 提供的数据库的 DB2 密码  |  |
|  | db2Schema | 要创建的服务器 DB2 模式 |  |
|  | db2ConnectionIsSSL | DB2 连接类型 | 指定数据库连接必须为 **http** 还是 **https**。 缺省值为 **false** (http)。<br/>确保还为相同连接方式配置 DB2 端口。 |
| existingMobileFirstAnalytics | analyticsEndPoint | 分析服务器的 URL | 例如：`http://9.9.9.9:30400`。<br/> 请勿指定控制台路径，将在部署期间添加此路径。
 |
|  | analyticsAdminUser | 分析管理员用户的用户名 |  |
|  | analyticsAdminPassword | 分析管理员用户的密码 |  |
| keystores | keystoresSecretName | 请参阅[安装和配置 IBM {{site.data.keys.product }} Helm Chart](#configure-install-mf-helmcharts)，其中描述使用密钥库及其密码创建密钥的步骤。 |  |
| jndiConfigurations | mfpfProperties | 用于定制部署的 {{ site.data.keys.prod_adj }} Server JNDI 属性 | 逗号分隔的名称值对。 |
| resources | limits.cpu | 描述允许的最大 CPU 量 | 缺省值为 **2000m**<br/>请阅读 [CPU 的含义](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu)。 |
|  | limits.memory | 描述允许的最大内存量 | 缺省值为 **4096Mi**<br/>请阅读[内存的含义](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)。 |
|  | requests.cpu | 描述所需的最小 CPU 量。 如果未指定，那么缺省为 *limits*（如果已指定）或实现定义的值。 | 缺省值为 **1000m**。 |
|  | requests.memory | 描述所需的最小内存量。 如果未指定，那么缺省为 *limits*（如果已指定）或者实现定义的值 | 缺省值为 **2048Mi**。 |

### 从 ICP 目录安装 {{ site.data.keys.prod_adj }} Helm Chart
{: #install-hmc-icp}

#### 安装 {{ site.data.keys.mf_analytics }}
{: #install-mf-analytics}

{{ site.data.keys.mf_analytics }} 的安装为可选。 如果想要在 {{ site.data.keys.mf_server }} 中启用分析，那么应首先配置并安装 {{ site.data.keys.mf_analytics }}，然后再安装 {{ site.data.keys.mf_server }}。

在开始安装 {{ site.data.keys.mf_analytics }} Chart 之前，配置**持久卷**。 提供**持久卷**以配置 {{ site.data.keys.mf_analytics }}。 遵循 [{{ site.data.keys.prod_icp }} 文档](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/create_volume.html)中详述的步骤以创建**持久卷**。

遵循以下步骤以从 {{ site.data.keys.prod_icp }} 管理控制台安装和配置 IBM {{ site.data.keys.mf_analytics }}。

1. 转至管理控制台中的**目录**。
2. 选择 **ibm-mfpf-analytics-prod** helm chart。
3. 单击**配置**。
4. 提供环境变量。 请参阅 [{{ site.data.keys.mf_analytics }} 的环境变量](#env-mf-analytics)以获取更多信息。
5. 接受**许可证协议**。
6. 单击**安装**。

#### 安装 {{ site.data.keys.mf_server }}
{: #install-mf-server}

在开始安装 {{site.data.keys.mf_server }} 之前，确保您已预先配置 DB2 数据库。


遵循以下步骤以从 {{ site.data.keys.prod_icp }} 管理控制台安装和配置 IBM {{ site.data.keys.mf_server }}。

1. 转至管理控制台中的**目录**。
2. 选择 **ibm-mfpf-server-prod** helm chart。
3. 单击**配置**。
4. 提供环境变量。 请参阅 [{{ site.data.keys.mf_server }} 的环境变量](#env-mf-server)以获取更多信息。
5. 接受**许可证协议**。
6. 单击**安装**。

## 验证安装
{: #verify-install}

在安装和配置 {{ site.data.keys.mf_analytics }}（可选）和 {{ site.data.keys.mf_server }} 后，您可以通过执行以下步骤来验证已部署的 pod 的安装和状态：

在 {{site.data.keys.prod_icp }} 管理控制台中， 选择**工作负载 > Helm 发行版**。 单击您的安装的*发行版名称*。


## 访问 {{site.data.keys.prod_adj }} 控制台
{: #access-mf-console}

在成功安装后，您可以使用以下方式访问 IBM {{ site.data.keys.prod_adj }} 操作控制台：`<protocol>://<ip_address>:<port>/mfpconsole`。
可使用以下方式访问 IBM {{ site.data.keys.mf_analytics }} 控制台：`<protocol>://<ip_address>:<port>/analytics/console`。

协议可以为 `http` 或 `https`。 另请注意，在 **NodePort** 部署中，端口将为 **NodePort**。 要获取已安装的 {{ site.data.keys.prod_adj }} Charts 的 ip_address 和 **NodePort**，请执行以下步骤：

1. 在 {{ site.data.keys.prod_icp }} 管理控制台中，选择**工作负载 > Helm 发行版**。
2. 单击 helm chart 安装的*发行版名称*。
3. 请参阅**注释**部分。

>**注：**端口 9600 在 Kubernetes 服务中内部公开，且供
{{ site.data.keys.prod_adj }} Analytics 实例用作传输端口。


## 示例应用程序
{: #sample-app}
请参阅 [{{ site.data.keys.prod_adj }} 教程](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/all-tutorials/)以部署样本适配器和在 {{ site.data.keys.prod_icp }} 中运行的 {{ site.data.keys.mf_server }} 上运行样本应用程序。

## 升级 {{ site.data.keys.prod_adj }} Helm Chart 和发行版
{: #upgrading-mf-helm-charts}

请参阅[升级捆绑产品](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/installing/upgrade_helm.html)以获取有关如何升级 helm chart/发行版的指示信息。

### Helm 发行版升级的样本场景

1. 要使用 `values.yaml` 的值更改升级 helm 发行版，请使用 `helm upgrade` 命令以及 **--set** 标志。 您可以多次指定 **--set** 标志。 优先级将赋予命令行中指定的最右侧设置。
  ```bash
  helm upgrade --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

2. 要通过在文件中提供值来升级 helm 发行版，请使用 `helm upgrade` 命令以及 **-f** 标志。 您可以多次使用 **--values** 或 **-f** 标志。 优先级将赋予命令行中指定的最右侧文件。 在以下示例中，如果 `myvalues.yaml` 和 `override.yaml` 都包含名为 *Test* 的键，那么 `override.yaml` 中设置的值优先。
  ```bash
  helm upgrade -f myvalues.yaml -f override.yaml <existing-helm-release-name> <path of new helm chart>
  ```

3. 要通过复用最后一个发行版中的值并覆盖其中部分值来升级 helm 发行版，可以使用如下命令：
  ```bash
  helm upgrade --reuse-values --set <name>=<value> --set <name>=<value> <existing-helm-release-name> <path of new helm chart>
  ```

## 卸载
{: #uninstall}
要卸载 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }}，请使用 [Helm CLI](https://docs.helm.sh/using_helm/#installing-helm)。
使用以下命令来完全删除已安装的图表和关联的部署：
```bash
helm delete --purge <release_name>
```
*release_name* 是已部署的 Helm Chart 的发行版名称。
