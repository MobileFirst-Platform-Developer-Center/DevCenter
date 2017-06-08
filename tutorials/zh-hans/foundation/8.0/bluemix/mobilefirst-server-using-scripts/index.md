---
layout: tutorial
title: 在 IBM Bluemix 上使用针对 IBM Containers 的脚本设置 MobileFirst Server
breadcrumb_title: IBM Containers
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
遵循以下指示信息在 IBM Bluemix 上配置 {{ site.data.keys.mf_server }} 实例和 {{ site.data.keys.mf_analytics }} 实例。为此您需要完成以下步骤：

* 使用所需工具（Cloud Foundry CLI、Docker 和 IBM Containers Extension (cf ic) 插件）设置主计算机
* 设置 Bluemix 帐户
* 构建 {{ site.data.keys.mf_server }} 映像并将其推送到 Bluemix 存储库。

最后，将在 IBM Containers 上运行映像作为单个容器或者作为一个容器组，注册应用程序和部署适配器。

**注：**  

* 当前不支持在 Windows 操作系统上运行这些脚本。  
* {{ site.data.keys.mf_server }} 配置工具不能用于部署到 IBM Container。

#### 跳转至：
{: #jump-to }
* [在 Bluemix 上注册帐户](#register-an-account-at-bluemix)
* [设置主机](#set-up-your-host-machine)
* [下载 {{ site.data.keys.mf_bm_pkg_name }} 归档](#download-the-ibm-mfpf-container-8000-archive)
* [先决条件](#prerequisites)
* [在 IBM Containers 上设置 {{ site.data.keys.product_adj }} 和分析服务器](#setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers)
* [应用 {{ site.data.keys.mf_server }} 修订](#applying-mobilefirst-server-fixes)
* [从 Bluemix 中除去容器](#removing-a-container-from-bluemix)
* [从 Bluemix 中除去数据库服务配置](#removing-the-database-service-configuration-from-bluemix)

## 在 Bluemix 上注册帐户
{: #register-an-account-at-bluemix }
如果还没有帐户，请访问 [Bluemix Web 站点](https://bluemix.net)，然后单击**免费开始使用**或**注册**。您需要填写注册表单，然后才能进入下一步。

### Bluemix 仪表板
{: #the-bluemix-dashboard }
在登录 Bluemix 后，会显示 Bluemix 仪表板，其中提供了活动的 Bluemix **空间**的概述。缺省情况下，此工作区命名为“dev”。如果需要，您可以创建多个工作区/空间。

## 设置主机
{: #set-up-your-host-machine }
要管理容器和映像，您需要安装以下工具：Docker、Cloud Foundry CLI 和 IBM Containers (cf ic) 插件。

### Docker
{: #docker }
转至左侧菜单上的 [Docker 文档](https://docs.docker.com/)，选择**安装 → Docker Engine**、选择操作系统类型，遵循安装 Docker Toolbox 的指示信息进行操作。

**注：**IBM 不支持 Docker 的 Kitematic。

在 macOS 中提供了两个选项用于运行 Docker 命令：

* 在 macOS Terminal.app 中：无需其他设置。您只能在其中进行操作。
* 在 Docker 快速启动终端中：如下所示进行操作。

* 运行以下命令：

  ```bash
  docker-machine env default
  ```

* 将结果设置为环境变量，例如：

  ```bash
  $ docker-machine env default
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.101:2376"
  export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
  ```

> 有关更多信息，请查询 Docker 文档。

### Cloud Foundry 插件和 IBM Containers 插件
{: #cloud-foundry-plug-in-and-ibm-containers-plug-in}
1. 安装 [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195)。
2. 安装 [IBM Containers Plugin (cf ic)](https://console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html)。

## 下载 {{ site.data.keys.mf_bm_pkg_name }} 归档
{: #download-the-ibm-mfpf-container-8000-archive}
要对 IBM Containers 设置 {{ site.data.keys.product }}，必须首先创建一个映像，稍后将其推送至 Bluemix。  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">遵循本页面上的指示信息</a>下载 IBM Containers 归档的 {{ site.data.keys.mf_server }}（.zip 文件，搜索：*CNBL0EN*）。

此归档文件包含用于构建映像的文件（**dependencies** 和 **mfpf-libs**），用于构建和部署 {{ site.data.keys.mf_analytics }} Container 的文件 (**mfpf-analytics**) 以及用于配置 {{ site.data.keys.mf_server }} Container 的文件 (**mfpf-server**)。

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击以了解有关归档文件内容和可供使用的环境属性的更多信息</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="显示归档文件的文件系统结构的图像" style="float:right;width:570px"/>
                <h4>dependencies 文件夹</h4>
                <p>包含 {{ site.data.keys.product }} 运行时和 IBM Java JRE 8。</p>

                <h4>mfpf-libs 文件夹</h4>
                <p>包含 {{ site.data.keys.product_adj }} 产品组件库和 CLI。</p>

                <h4>mfpf-server 和 mfpf-analytics 文件夹</h4>

                <ul>
                    <li><b>Dockerfile</b>：包含构建映像所需的所有命令的文本文档。</li>
                    <li><b>scripts</b> 文件夹：此文件夹包含 <b>args</b> 文件夹，其中包含一组配置文件。它还包含登录 Bluemix、构建 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 映像和在 Bluemix 上推送与运行此映像时需要运行的脚本。您可以选择以交互方式运行这些脚本，或者通过对配置文件进行预配置的方式来运行脚本（如后文所述）。除可定制的 args/*.properties 文件外，请勿修改该文件夹中的任何元素。要获取脚本用法帮助，请使用 <code>-h</code> 或 <code>--help</code> 命令行参数（例如，<code>scriptname.sh --help</code>）。</li>
                    <li><b>usr</b> 文件夹：
                        <ul>
                            <li><b>bin</b> 文件夹:包含将在容器启动时执行的脚本文件。您可以添加自己的定制代码以执行这些代码。</li>
                            <li><b>config</b> 文件夹：包含 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 所使用的服务器配置片段（密钥库、服务器属性、用户注册表）。</li>
                            <li><b>keystore.xml</b> - 用于 SSL 加密的安全证书存储库的配置。必须在 ./usr/security 文件夹中引用列出的文件。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 的配置属性。请参阅以下文档主题中列出的受支持属性：
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - 用户注册表配置。basicRegistry - 将基于 XML 的基本用户注册表配置作为缺省值提供。可以为 basicRegistry 配置用户名和密码，或者也可以配置 ldapRegistry。</li>
                        </ul>
                    </li>
                    <li><b>env</b> 文件夹：包含用于服务器初始化 (server.env) 和定制 JVM 选项 (jvm.options) 的环境属性。</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="server-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>单击以获取受支持的服务器环境属性的列表</b></a>
                                </h4>
                            </div>

                            <div id="collapse-server-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>属性</b></td>
                                            <td><b>缺省值</b></td>
                                            <td><b>描述</b></td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPPORT</td>
                                            <td>9080*</td>
                                            <td>用于客户机 HTTP 请求的端口。使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT</td>
                                            <td>9443*	</td>
                                            <td>通过 SSL (HTTPS) 保护的客户机 HTTP 请求所使用的端口。使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CLUSTER_MODE	</td>
                                            <td><code>Standalone</code></td>
                                            <td>无需配置。有效值为 <code>Standalone</code> 或 <code>Farm</code>。当容器作为容器组运行时，将自动设置 <code>Farm</code> 值。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_ROOT	</td>
                                            <td>mfpadmin</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services 在其中可用的上下文根。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_CONSOLE_ROOT	</td>
                                            <td>mfpconsole</td>
                                            <td>{{ site.data.keys.mf_console }} 在其中可用的上下文根。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_GROUP</td>
                                            <td>mfpadmingroup</td>
                                            <td>已分配预定义角色 <code>mfpadmin</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_DEPLOYER_GROUP</td>
                                            <td>mfpdeployergroup</td>
                                            <td>已分配预定义角色 <code>mfpdeployer</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>已分配预定义角色 <code>mfpmonitor</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>已分配预定义角色 <code>mfpoperator</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER</td>
                                            <td>WorklightRESTUser</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services 的 Liberty 服务器管理员用户。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD</td>
                                            <td>mfpadmin。确保在部署到生产环境之前将缺省值更改为专用密码。</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services 的 Liberty 服务器管理员用户的密码。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_USER	</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 操作的管理员角色的用户名。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_ADMIN_PASSWORD</td>
                                            <td>admin</td>
                                            <td>{{ site.data.keys.mf_server }} 操作的管理员角色的密码。</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#server-env" data-target="#collapse-server-env" aria-expanded="false" aria-controls="collapse-server-env"><b>关闭此节</b></a>
                                    </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="analytics-env">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#env-properties" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>单击以获取受支持的分析环境属性的列表</b></a>
                                </h4>
                            </div>

                            <div id="collapse-analytics-env" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>属性</b></td>
                                            <td><b>缺省值</b></td>
                                            <td><b>描述</b></td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTP PORT	</td>
                                            <td>9080*</td>
                                            <td>用于客户机 HTTP 请求的端口。使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>用于客户机 HTTP 请求的端口。使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_ADMIN_GROUP</td>
                                            <td>analyticsadmingroup</td>
                                            <td>具有预定义角色 <b>worklightadmin</b> 的用户组的名称。</td>
                                        </tr>
                                    </table>

                    				<br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#analytics-env" data-target="#collapse-analytics-env" aria-expanded="false" aria-controls="collapse-analytics-env"><b>关闭此节</b></a>
                                    </div>
                            </div>
                        </div>
                    </div>


                    </li>
                    <li><b>jre-security</b> 文件夹：您可以通过将 JRE 安全相关文件（信任库、策略 JAR 文件等）放置在本文件夹中来更新这些文件。将此文件夹中的文件复制到容器中的 JAVA_HOME/jre/lib/security/ 文件夹。</li>
                    <li><b>security</b> 文件夹：用于存储密钥存储库、信任库和 LTPA 密钥文件 (ltpa.keys)。</li>
                    <li><b>ssh</b> 文件夹：用于存储 SSH 公用密钥文件 (id_rsa.pub)，此文件用于启用针对容器的 SSH 访问权。</li>
                    <li><b>wxs</b> 文件夹（仅适用于 {{ site.data.keys.mf_server }}）：使用数据高速缓存作为服务器的属性存储时，此文件夹包含数据高速缓存/ 超大规模的客户机库。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>关闭此节</b></a>
                                    </div>
        </div>
    </div>
</div>

## 先决条件
{: #prerequisites }
在下一节中您将运行 IBM Containers 命令，因此以下步骤为强制性步骤。

1. 登录 IBM Bluemix 环境。  

    运行：`cf login`。  
    出现提示时，输入以下信息：
      * Bluemix API 端点
      * 电子邮件
      * 密码
      * 组织（如果拥有多个组织）
      * 空间（如果拥有多个空间）

2. 要运行 IBM Containers 命令，必须首先登录 IBM Container 云服务。
运行：`cf ic login`。

3. 确保已设置容器注册表的 `namespace`。`namespace` 是用于识别 Bluemix 注册表上您的专用存储库的唯一名称。仅限针对每个组织指定一次名称空间，名称空间无法更改。根据以下规则选择名称空间：
     * 只能包含小写字母、数字或下划线。
     * 名称可以为 4 到 30 个字符。如果计划从命令行管理容器，那么您可能倾向于使用能够快速输入的简短名称空间。
     * 必须在 Bluemix 注册表中唯一。

    要设置名称空间，请运行命令：`cf ic namespace set <new_name>`。  
    要获取已设置的名称空间，请运行命令：`cf ic namespace get`。

> 要了解有关 IC 命令的更多信息，请使用 `ic help` 命令。

## 在 IBM Containers 上设置 {{ site.data.keys.product_adj }} 和 Analytics Servers
{: #setting-up-the-mobilefirst-and-analytics-servers-on-ibm-containers }
如上文所述，您可以选择以交互方式运行这些脚本，或者通过使用配置文件来运行脚本：

* 使用配置文件 - 运行脚本并传递相应的配置文件作为自变量。
* 以交互方式 - 运行脚本，不使用任何自变量。

**注：**如果选择以交互方式运行脚本，可以跳过配置，但是强烈建议至少查看并了解一下您将需要提供的自变量。

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
如果您要对 {{ site.data.keys.mf_server }} 使用分析，请从此处开始。

<div class="panel-group accordion" id="scripts" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep1" aria-expanded="false" aria-controls="collapseStep1">使用配置文件</a>
            </h4>
        </div>

        <div id="collapseStep1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <b>args</b> 文件夹包含一组配置文件，其中包含运行脚本所需的自变量。在以下文件中填充自变量值。<br/>
            <b>注：</b>我们仅包含必需的自变量。要了解有关其他自变量的信息，请参阅属性文件内的文档。
              <h4>initenv.properties</h4>
              <ul>
                  <li><b>BLUEMIX_USER - </b>Bluemix 用户名（电子邮件）。</li>
                  <li><b>BLUEMIX_PASSWORD - </b>Bluemix 密码。</li>
                  <li><b>BLUEMIX_ORG - </b>Bluemix 组织名称。</li>
                  <li><b>BLUEMIX_SPACE - </b>Bluemix 空间（如上文所述）。</li>
              </ul>
              <h4>prepareanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>映像标记。应采用以下格式：<em>registry-url/namespace/your-tag</em>。</li>
              </ul>
              <h4>startanalytics.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>与 <em>prepareserver.sh</em> 中相同。</li>
                  <li><b>ANALYTICS_CONTAINER_NAME - </b>Bluemix Container 的名称。</li>
                  <li><b>ANALYTICS_IP - </b>Bluemix Container 要绑定到的 IP 地址。<br/>
                  要分配 IP 地址，请运行：<code>cf ic ip request</code>。<br/>
                  可以在空间中的多个容器内复用 IP 地址。<br/>
                  如果您尚未分配一个 IP 地址，可以运行：<code>cf ic ip list</code>。</li>
              </ul>
              <h4>startanalyticsgroup.properties</h4>
              <ul>
                  <li><b>ANALYTICS_IMAGE_TAG - </b>与 <em>prepareserver.sh</em> 中相同。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_NAME - </b>Bluemix Container 组的名称。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_HOST - </b>主机名。</li>
                  <li><b>ANALYTICS_CONTAINER_GROUP_DOMAIN - </b>域名。缺省值为：<code>mybluemix.net</code>。</li>
              </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts" data-target="#collapseStep2" aria-expanded="false" aria-controls="collapseStep2">运行脚本</a>
            </h4>
        </div>

        <div id="collapseStep2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <p>以下指示信息演示了如何使用配置文件来运行脚本。如果选择不使用交互方式来运行，那么还提供了命令行自变量的列表：</p>
                <ol>
                    <li><b>initenv.sh - 登录 Bluemix </b><br />
                    运行 <b>initenv.sh</b> 脚本以创建环境，用于在 IBM Containers 上构建和运行 {{ site.data.keys.mf_analytics }}：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-initenv">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-initenv">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>命令行参数</b></td>
                                                <td><b>描述</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-u|--user] BLUEMIX_USER</td>
                                                <td>Bluemix 用户标识或电子邮件地址</td>
                                            </tr>
                                            <tr>
                                                <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                                <td>Bluemix 密码</td>
                                            </tr>
                                            <tr>
                                                <td>[-o|--org] BLUEMIX_ORG	</td>
                                                <td>Bluemix 组织名称</td>
                                            </tr>
                                            <tr>
                                                <td>[-s|--space] BLUEMIX_SPACE	</td>
                                                <td>Bluemix 空间名称</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-a|--api] BLUEMIX_API_URL	</td>
                                                <td>Bluemix API 端点。（缺省端点为 https://api.ng.bluemix.net）</td>
                                            </tr>
                                        </table>

                                        <p>例如：</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-initenv" data-target="#collapse-script-analytics-initenv" aria-expanded="false" aria-controls="collapse-script-analytics-initenv"><b>关闭此节</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li><b>prepareanalytics.sh - 准备 {{ site.data.keys.mf_analytics }} 映像</b><br />
                        运行 <b>prepareanalytics.sh</b> 脚本以构建 {{ site.data.keys.mf_analytics }} 映像并将其推送到 Bluemix 存储库。

{% highlight bash %}
./prepareanalytics.sh args/prepareanalytics.properties
{% endhighlight %}

                        要查看 Bluemix 存储库中的所有可用映像，请运行 <code>cf ic images</code><br/>
                        此列表包含映像名称、创建日期和标识。

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-prepareanalytics">
                                    <h4 class="panel-title">
                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-prepareanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-prepareanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                              <td><b>命令行参数</b></td>
                                              <td><b>描述</b></td>
                                            </tr>
                                            <tr>
                                              <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                              <td>要用于定制的分析映像的名称。格式：Bluemix registry URL/private namespace/image name</td>
                                            </tr>      
                                        </table>

                                        <p>例如：</p>
{% highlight bash %}
prepareanalytics.sh --tag registry.ng.bluemix.net/your_private_repository_namespace/mfpfanalytics80
{% endhighlight %}

                                      <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-prepareanalytics" data-target="#collapse-script-analytics-prepareanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-prepareanalytics"><b>关闭此节</b></a>
                                    </div>
                              </div>
                          </div>
                      </div>

                    </li>
                    <li><b>startanalytics.sh - 在 IBM Container 上运行此映像</b><br />
                    <b>startanalytics.sh</b> 脚本用于在 IBM Container 上运行 {{ site.data.keys.mf_analytics }} 映像。它还会将映像绑定到您在 <b>ANALYTICS_IP</b> 属性中配置的公共 IP。</li>

                    运行：
{% highlight bash %}
./startanalytics.sh args/startanalytics.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalytics">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalytics">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>命令行参数</b></td>
                                                <td><b>描述</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>已装入到 IBM Containers 注册表的分析容器映像的名称。格式：BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-n|--name] ANALYTICS_CONTAINER_NAME	</td>
                                                <td>分析容器的名称</td>
                                            </tr>
                                            <tr>
                                                <td>[-i|--ip] ANALYTICS_IP	</td>
                                                <td>容器应绑定到的 IP 地址。（您可以提供可用的公共 IP 或者使用 <code>cf ic ip request</code> 命令请求一个。）</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-h|--http] EXPOSE_HTTP	</td>
                                                <td>公开 HTTP 端口。接受的值为 Y（缺省值）或 N。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-s|--https] EXPOSE_HTTPS	</td>
                                                <td>公开 HTTPS 端口。接受的值为 Y（缺省值）或 N。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-m|--memory] SERVER_MEM	</td>
                                                <td>以兆字节为单位指定容器的内存大小限制 (MB)。接受的值为 1024 MB（缺省值）和 2048 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-se|--ssh] SSH_ENABLE	</td>
                                                <td>针对容器启用 SSH。接受的值为 Y（缺省值）或 N。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-sk|--sshkey] SSH_KEY	</td>
                                                <td>要插入到容器的 SSH 密钥。（提供 id_rsa.pub 文件的内容。）</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>要应用的跟踪规范。缺省值：<code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>在覆盖前要保留的最大日志文件数。缺省值为 5 个文件。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>日志文件的最大大小。缺省大小为 20 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>针对容器日志启用装配卷。接受的值为 Y 或 N（缺省值）。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ev|--enabledatavolume] ENABLE_ANALYTICS_DATA_VOLUME	</td>
                                                <td>针对分析数据启用装配卷。接受的值为 Y 或 N（缺省值）。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>指定要针对分析数据创建和装配的卷的名称。缺省名称为 <b>mfpf_analytics_container_name</b>。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>指定用于存储数据的位置。缺省文件夹名称为 <b>/analyticsData。</b></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>提供 {{ site.data.keys.mf_analytics }} 属性作为逗号分隔的“键/值”对。注：如果使用此脚本指定属性，那么确保未在 usr/config 文件夹的配置文件中设置这些相同的属性。</td>
                                            </tr>
                                        </table>

                                        <p>例如：</p>
                        {% highlight bash %}
                        startanalytics.sh --tag image_tag_name --name container_name --ip container_ip_address
                        {% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalytics" data-target="#collapse-script-analytics-startanalytics" aria-expanded="false" aria-controls="collapse-script-analytics-startanalytics"><b>关闭此节</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    <li><b>startanalyticsgroup.sh - 在 IBM Container 组上运行此映像</b><br />
                        <b>startanalyticsgroup.sh</b> 脚本用于在 IBM Container 组上运行 {{ site.data.keys.mf_analytics }} 映像。它还会将映像绑定到您在 <b>ANALYTICS_CONTAINER_GROUP_HOST</b> 属性中配置的主机名。

                        运行：
{% highlight bash %}
./startanalyticsgroup.sh args/startanalyticsgroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-analytics-startanalyticsgroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-analytics-startanalyticsgroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-analytics-startanalyticsgroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>命令行参数</b></td>
                                                <td><b>描述</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] ANALYTICS_IMAGE_TAG	</td>
                                                <td>已装入到 IBM Containers 注册表的分析容器映像的名称。格式：BluemixRegistry/PrivateNamespace/ImageName:Tag</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] ANALYTICS_CONTAINER_GROUP_NAME	</td>
                                                <td>分析容器组的名称。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] ANALYTICS_CONTAINER_GROUP_HOST	</td>
                                                <td>路径的主机名。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] ANALYTICS_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>路径的域名。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gm|--min] ANALYTICS_CONTAINER_GROUP_MIN</td>
                                                <td>容器实例的最小数量。缺省值为 1。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gx|--max] ANALYTICS_CONTAINER_GROUP_MAX	</td>
                                                <td>容器实例的最大数量。缺省值为 1。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gd|--desired] ANALYTICS_CONTAINER_GROUP_DESIRED	</td>
                                                <td>容器实例的期望数量。缺省值为 2。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>要应用的跟踪规范。缺省值：<code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>在覆盖前要保留的最大日志文件数。缺省值为 5 个文件。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>日志文件的最大大小。缺省大小为 20 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>指定 {{ site.data.keys.product_adj }} 属性作为逗号分隔的“键/值”对。示例：<code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest/v2</code></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-m|--memory] SERVER_MEM	</td>
                                                <td>以兆字节为单位指定容器的内存大小限制 (MB)。接受的值为 1024 MB（缺省值）和 2048 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>针对容器日志启用装配卷。接受的值为 Y 或 N（缺省值）。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-av|--datavolumename] ANALYTICS_DATA_VOLUME_NAME	</td>
                                                <td>指定要针对分析数据创建和装配的卷的名称。缺省值为 <b>mfpf_analytics_ANALYTICS_CONTAINER_GROUP_NAME</b></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ad|--analyticsdatadirectory] ANALYTICS_DATA_DIRECTORY	</td>
                                                <td>指定要用于存储分析数据的目录。<b>/analyticsData</b></td>
                                            </tr>
                                        </table>

                                        <p>例如：</p>
{% highlight bash %}
startanalyticsgroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-analytics-startanalyticsgroup" data-target="#collapse-script-analytics-startanalyticsgroup" aria-expanded="false" aria-controls="collapse-script-analytics-startanalyticsgroup"><b>关闭此节</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>   
                    </li>
                </ol>
                装入以下 URL 以启动 Analytics Console：http://ANALYTICS-CONTAINER-HOST/analytics/console （可能需要一些时间才能完成）  
            </div>
        </div>
    </div>
</div>

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server}
<div class="panel-group accordion" id="scripts2" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">使用配置文件</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <b>args</b> 文件夹包含一组配置文件，其中包含运行脚本所需的自变量。在以下文件中填充自变量值：<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>BLUEMIX_USER - </b>Bluemix 用户名（电子邮件）。</li>
                    <li><b>BLUEMIX_PASSWORD - </b>Bluemix 密码。</li>
                    <li><b>BLUEMIX_ORG - </b>Bluemix 组织名称。</li>
                    <li><b>BLUEMIX_SPACE - </b>Bluemix 空间（如上文所述）。</li>
                </ul>
                <h4>prepareserverdbs.properties</h4>
                {{ site.data.keys.mf_bm_short }} 服务需要外部 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank"><i>dashDB Enterprise Transactional 数据库</i>实例</a>（<i>Enterprise Transactional 2.8.500</i> 或 <i>Enterprise Transactional 12.128.1400</i>）。<br/>
                <b>注：</b>dashDB Enterprise Transactional 套餐的部署可能不会立即完成。在部署服务之前，销售团队可能会联系您。<br/><br/>
                在设置 dashDB 实例后，请提供所需自变量：
		<ul>
                    <li><b>ADMIN_DB_SRV_NAME - </b>用于存储管理数据的 dashDB 服务实例名称。</li>
                    <li><b>ADMIN_SCHEMA_NAME - </b>管理数据的模式名称。缺省名称为 MFPDATA。</li>
                    <li><b>RUNTIME_DB_SRV_NAME - </b>用于存储运行时数据的 dashDB 服务实例名称。缺省名称为管理服务名称。</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>运行时数据的模式名称。缺省名称为 MFPDATA。</li>
                    <b>注：</b>如果许多用户共享 dashDB 服务实例，那么请确保提供唯一的模式名称。
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG - </b>映像标记。应采用以下格式：<em>registry-url/namespace/your-tag</em>。</li>
                </ul>
                <h4>startserver.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>与 <em>prepareserver.sh</em> 中相同。</li>
                    <li><b>SERVER_CONTAINER_NAME - </b>Bluemix Container 的名称。</li>
                    <li><b>SERVER_IP - </b>Bluemix Container 应绑定到的 IP 地址。<br/>
                    要分配 IP 地址，请运行：<code>cf ic ip request</code>。<br/>
                    可以在空间中的多个容器内复用 IP 地址。<br/>
                    如果您尚未分配一个 IP 地址，可以运行：<code>cf ic ip list</code>。</li>
                    <li><b>MFPF_PROPERTIES - </b>{{ site.data.keys.mf_server }} JNDI 属性，以逗号分隔（<b>无空格</b>）。您可在以下位置定义分析相关属性：<code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS-CONTAINER-IP:9080/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS-CONTAINER-IP:9080/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
                <h4>startservergroup.properties</h4>
                <ul>
                    <li><b>SERVER_IMAGE_TAG - </b>与 <em>prepareserver.sh</em> 中相同。</li>
                    <li><b>SERVER_CONTAINER_GROUP_NAME - </b>Bluemix Container 组的名称。</li>
                    <li><b>SERVER_CONTAINER_GROUP_HOST - </b>主机名。</li>
                    <li><b>SERVER_CONTAINER_GROUP_DOMAIN - </b>域名。缺省值为：<code>mybluemix.net</code>。</li>
                    <li><b>MFPF_PROPERTIES - </b>{{ site.data.keys.mf_server }} JNDI 属性，以逗号分隔（<b>无空格</b>）。您可在以下位置定义分析相关属性：<code>MFPF_PROPERTIES=mfp/mfp.analytics.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics-service/rest,mfp/mfp.analytics.console.url:http://ANALYTICS_CONTAINER_GROUP_HOSTNAME:80/analytics/console,mfp/mfp.analytics.username:ANALYTICS_USERNAME,mfp/mfp.analytics.password:ANALYTICS_PASSWORD</code></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-2">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-2" aria-expanded="false" aria-controls="collapse-step-foundation-2">运行脚本</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <p>以下指示信息演示了如何使用配置文件来运行脚本。如果选择不使用交互方式来运行，那么还提供了命令行自变量的列表：</p>

            <ol>
                <li><b>initenv.sh - 登录 Bluemix </b><br />
                    运行 <b>initenv.sh</b> 脚本以创建环境，用于在 IBM Containers 上构建和运行 {{ site.data.keys.product }}：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-initenv">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                            </div>

                            <div id="collapse-script-initenv" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-initenv">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>命令行参数</b></td>
                                            <td><b>描述</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-u|--user] BLUEMIX_USER</td>
                                            <td>Bluemix 用户标识或电子邮件地址</td>
                                        </tr>
                                        <tr>
                                            <td>[-p|--password] BLUEMIX_PASSWORD	</td>
                                            <td>Bluemix 密码</td>
                                        </tr>
                                        <tr>
                                            <td>[-o|--org] BLUEMIX_ORG	</td>
                                            <td>Bluemix 组织名称</td>
                                        </tr>
                                        <tr>
                                            <td>[-s|--space] BLUEMIX_SPACE	</td>
                                            <td>Bluemix 空间名称</td>
                                        </tr>
                                        <tr>
                                            <td>可选。[-a|--api] BLUEMIX_API_URL	</td>
                                            <td>Bluemix API 端点。（缺省端点为 https://api.ng.bluemix.net）</td>
                                        </tr>
                                    </table>

                                    <p>例如：</p>
{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-initenv" data-target="#collapse-script-initenv" aria-expanded="false" aria-controls="collapse-script-initenv"><b>关闭此节</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>prepareserverdbs.sh - 准备 {{ site.data.keys.mf_server }} 数据库</b><br />
                    <b>prepareserverdbs.sh</b> 脚本用于通过 dashDB 数据库服务配置 {{ site.data.keys.mf_server }}。在步骤 1 中登录的组织和空间内应提供了 dashDB 服务的服务实例。请运行：
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserverdbs">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-script-prepareserverdbs"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                            </div>

                            <div id="collapse-script-prepareserverdbs" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserverdbs">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>命令行参数</b></td>
                                            <td><b>描述</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-adl |--admindb ] ADMIN_DB_SRV_NAME	</td>
                                            <td>Bluemix dashDB™ 服务（使用 Enterprise Transactional 的 Bluemix 服务规划）</td>
                                        </tr>
                                        <tr>
                                            <td>可选。[-as |--adminschema ] ADMIN_SCHEMA_NAME	</td>
                                            <td>管理服务的数据库模式名称。缺省为 MFPDATA</td>
                                        </tr>
                                        <tr>
                                            <td>可选。[-rd |--runtimedb ] RUNTIME_DB_SRV_NAME	</td>
                                            <td>用于存储运行时数据的 Bluemix 数据库服务实例名称。缺省为与针对管理数据指定的服务相同。</td>
                                        </tr>
                                        <tr>
                                            <td>可选。[-p |--push ] ENABLE_PUSH	</td>
                                            <td>支持针对推送服务配置数据库。接受的值为 Y（缺省值）或 N。</td>
                                        </tr>
                                        <tr>
                                            <td>[-pd |--pushdb ] PUSH_DB_SRV_NAME	</td>
                                            <td>用于存储推送数据的 Bluemix 数据库服务实例名称。缺省为与针对运行时数据指定的服务相同。</td>
                                        </tr>
                                        <tr>
                                            <td>[-ps |--pushschema ] PUSH_SCHEMA_NAME	</td>
                                            <td>推送服务的数据库模式名称。缺省为运行时模式名称。</td>
                                        </tr>
                                    </table>

                                    <p>例如：</p>
{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserverdbs" data-target="#collapse-script-prepareserverdbs" aria-expanded="false" aria-controls="collapse-server-env"><b>关闭此节</b></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li><b>initenv.sh（可选）- 登录 Bluemix</b><br />
                      仅当在除提供 dashDB 服务实例的组织和空间以外的其他组织和空间内需要创建容器时，才需要执行此步骤。如果情况如此，请使用必须在其中创建和启动新组织和空间的容器来更新 initenv.properties，然后重新运行 <b>initenv.sh</b> 脚本：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - 准备 {{ site.data.keys.mf_server }} 映像</b><br />
                    运行 <b>prepareserver.sh</b> 脚本以构建 {{ site.data.keys.mf_server }} 映像并将其推送到 Bluemix 存储库。要查看 Bluemix 存储库中的所有可用映像，请运行 <code>cf ic images</code><br/>
                    此列表包含映像名称、创建日期和标识。<br/>

{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-prepareserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                            </div>

                            <div id="collapse-script-prepareserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-prepareserver">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <td><b>命令行参数</b></td>
                                            <td><b>描述</b></td>
                                        </tr>
                                        <tr>
                                            <td>[-t|--tag] SERVER_IMAGE_NAME	</td>
                                            <td>要用于定制的 {{ site.data.keys.mf_server }} 映像的名称。格式：registryUrl/namespace/imagename</td>
                                        </tr>
                                    </table>

                                    <p>例如：</p>
{% highlight bash %}
prepareserver.sh --tag SERVER_IMAGE_NAME registryUrl/namespace/imagename
{% endhighlight %}

                                  <br/>
                                  <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-prepareserver" data-target="#collapse-script-prepareserver" aria-expanded="false" aria-controls="collapse-script-prepareserver"><b>关闭此节</b></a>
                                    </div>
                          </div>
                        </div>
                    </div>  
                </li>
                <li><b>startserver.sh - 在 IBM Container 上运行此映像</b><br />
                    <b>startserver.sh</b> 脚本用于在 IBM Container 上运行 {{ site.data.keys.mf_server }} 映像。它还会将映像绑定到您在 <b>SERVER_IP</b> 属性中配置的公共 IP。请运行：</li>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                    <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="script-startserver">
                                <h4 class="panel-title">
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                            </div>
                            <div id="collapse-script-startserver" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startserver">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <tr>
                                        <td><b>命令行参数</b></td>
                                        <td><b>描述</b></td>
                                    </tr>
                                    <tr>
                                        <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                        <td>{{ site.data.keys.mf_server }} 映像的名称。</td>
                                    </tr>
                                    <tr>
                                        <td>[-i|--ip] SERVER_IP	</td>
                                        <td>{{ site.data.keys.mf_server }} 容器应绑定到的 IP 地址。（您可以提供可用的公共 IP 或者使用 <code>cf ic ip request</code> 命令请求一个。）</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-si|--services] SERVICE_INSTANCES	</td>
                                        <td>想要绑定到容器的逗号分隔的 Bluemix 服务实例。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-h|--http] EXPOSE_HTTP	</td>
                                        <td>公开 HTTP 端口。接受的值为 Y（缺省值）或 N。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-s|--https] EXPOSE_HTTPS	</td>
                                        <td>公开 HTTPS 端口。接受的值为 Y（缺省值）或 N。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-m|--memory] SERVER_MEM	</td>
                                        <td>以兆字节为单位指定容器的内存大小限制 (MB)。接受的值为 1024 MB（缺省值）和 2048 MB。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-se|--ssh] SSH_ENABLE	</td>
                                        <td>针对容器启用 SSH。接受的值为 Y（缺省值）或 N。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-sk|--sshkey] SSH_KEY	</td>
                                        <td>要插入到容器的 SSH 密钥。（提供 id_rsa.pub 文件的内容。）</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-tr|--trace] TRACE_SPEC	</td>
                                        <td>要应用的跟踪规范。缺省值：<code>*=info</code></td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                        <td>在覆盖前要保留的最大日志文件数。缺省值为 5 个文件。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                        <td>日志文件的最大大小。缺省大小为 20 MB。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-v|--volume] ENABLE_VOLUME	</td>
                                        <td>针对容器日志启用装配卷。接受的值为 Y 或 N（缺省值）。</td>
                                    </tr>
                                    <tr>
                                        <td>可选。[-e|--env] MFPF_PROPERTIES	</td>
                                        <td>指定 {{ site.data.keys.product_adj }} 属性作为逗号分隔的“键/值”对。示例：<code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest,mfp.analytics.console.url:http://127.0.0.1/analytics/console</code>。<b>注：</b>如果使用此脚本指定属性，那么确保未在 usr/config 文件夹的配置文件中设置这些相同的属性。</td>
                                    </tr>
                                </table>

                                <p>例如：</p>
{% highlight bash %}
startserver.sh --tag image_tag_name --name container_name --ip container_ip_address
{% endhighlight %}

                                <br/>
                                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startserver" data-target="#collapse-script-startserver" aria-expanded="false" aria-controls="collapse-script-startserver"><b>关闭此节</b></a>
                                    </div>
                        </div>
                    </div>
                <li><b>startservergroup.sh - 在 IBM Container 组上运行此映像</b><br />
                    <b>startservergroup.sh</b> 脚本用于在 IBM Container 组上运行 {{ site.data.keys.mf_server }} 映像。它还会将映像绑定到您在 <b>SERVER_CONTAINER_GROUP_HOST</b> 属性中配置的主机名。</li>
                    运行：
{% highlight bash %}
./startservergroup.sh args/startservergroup.properties
{% endhighlight %}

                        <div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="script-startservergroup">
                                    <h4 class="panel-title">
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>单击以获取命令行自变量的列表</b></a>
                                    </h4>
                                </div>

                                <div id="collapse-script-startservergroup" class="panel-collapse collapse" role="tabpanel" aria-labelledby="script-startservergroup">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><b>命令行参数</b></td>
                                                <td><b>描述</b></td>
                                            </tr>
                                            <tr>
                                                <td>[-t|--tag] SERVER_IMAGE_TAG	</td>
                                                <td>Bluemix 注册表中 {{ site.data.keys.mf_server }} 容器映像的名称。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gn|--name] SERVER_CONTAINER_NAME	</td>
                                                <td>{{ site.data.keys.mf_server }} 容器组的名称。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gh|--host] SERVER_CONTAINER_GROUP_HOST	</td>
                                                <td>路径的主机名。</td>
                                            </tr>
                                            <tr>
                                                <td>[-gs|--domain] SERVER_CONTAINER_GROUP_DOMAIN	</td>
                                                <td>路径的域名。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gm|--min] SERVERS_CONTAINER_GROUP_MIN	</td>
                                                <td>容器实例的最小数量。缺省值为 1。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gx|--max] SERVER_CONTAINER_GROUP_MAX	</td>
                                                <td>容器实例的最大数量。缺省值为 1。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-gd|--desired] SERVER_CONTAINER_GROUP_DESIRED	</td>
                                                <td>容器实例的期望数量。缺省值为 2。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-a|--auto] ENABLE_AUTORECOVERY	</td>
                                                <td>针对容器实例启用自动恢复选项。接受的值为 Y 或 N（缺省值）。</td>
                                            </tr>

                                            <tr>
                                                <td>可选。[-si|--services] SERVICES	</td>
                                                <td>想要绑定到容器的逗号分隔的 Bluemix 服务实例名称。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-tr|--trace] TRACE_SPEC	</td>
                                                <td>要应用的跟踪规范。缺省值为 <code>*=info</code></td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ml|--maxlog] MAX_LOG_FILES	</td>
                                                <td>在覆盖前要保留的最大日志文件数。缺省值为 5 个文件。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-ms|--maxlogsize] MAX_LOG_FILE_SIZE	</td>
                                                <td>日志文件的最大大小。缺省大小为 20 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-e|--env] MFPF_PROPERTIES	</td>
                                                <td>指定 {{ site.data.keys.product_adj }} 属性作为逗号分隔的“键/值”对。示例：<code>mfp.analytics.url:http://127.0.0.1/analytics-service/rest</code><br/> <code>mfp.analytics.console.url:http://127.0.0.1/analytics/console</code><br/>
                                                <b>注：</b>如果使用此脚本指定属性，那么确保未在 usr/config 文件夹的配置文件中设置相同的属性。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-m|--memory] SERVER_MEM	</td>
                                                <td>以兆字节为单位指定容器的内存大小限制 (MB)。接受的值为 1024 MB（缺省值）和 2048 MB。</td>
                                            </tr>
                                            <tr>
                                                <td>可选。[-v|--volume] ENABLE_VOLUME	</td>
                                                <td>针对容器日志启用装配卷。接受的值为 Y 或 N（缺省值）。</td>
                                            </tr>
                                        </table>

                                        <p>例如：</p>
{% highlight bash %}
startservergroup.sh --tag image_name --name container_group_name --host container_group_host_name --domain container_group_domain_name
{% endhighlight %}

                                        <br/>
                                        <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#script-startservergroup" data-target="#collapse-script-startservergroup" aria-expanded="false" aria-controls="collapse-script-startservergroup"><b>关闭此节</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ol>
            </div>
        </div>
    </div>
</div>

> **注：**在执行任何配置更改后，必须重新启动容器 (`cf ic restart containerId`)。对于容器组，您必须重新启动组中的每个容器实例。

例如，如果根证书发生更改，那么在添加新证书后必须重新启动每个容器实例。装入以下 URL 以启动 {{ site.data.keys.mf_console }}：http://MF\_CONTAINER\_HOST/mfpconsole（可能需要一些时间才能完成）。  
遵循[使用 {{ site.data.keys.mf_cli }} 来管理 {{ site.data.keys.product_adj }} 工件](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)教程中的指示信息来添加远程服务器。  

通过使用 IBM Bluemixmay 上运行的 {{ site.data.keys.mf_server }}，现在您可以启动自己的应用程序开发。查看 {{ site.data.keys.product }} [教程](../../all-tutorials)。

#### 端口号限制
{: #port-number-limitation }
目前，对于公共域中可用的端口号，存在一个 IBM Containers 限制。因此，无法更改针对 {{ site.data.keys.mf_analytics }} 容器和 {{ site.data.keys.mf_server }} 容器（9080 针对 HTTP，9443 针对 HTTPS）指定的缺省端口号。容器组中的容器必须使用 HTTP 端口 9080。容器组不支持使用多个端口号或 HTTPS 请求。

## 应用 {{ site.data.keys.mf_server }} 修订
{: #applying-mobilefirst-server-fixes }
IBM Containers 上的 {{ site.data.keys.mf_server }} 的临时修订可从 [IBM Fix Central](http://www.ibm.com/support/fixcentral) 获取。  
应用临时修订之前，请备份现有的配置文件。配置文件位于 **package_root/mfpf-analytics/usr** 和 **package_root/mfpf-server/usr** 文件夹中。

1. 下载临时修订归档并将内容解压缩到现有安装文件夹，覆盖现有文件。
2. 将备份配置文件复原到 **/mfpf-analytics/usr** 和 **/mfpf-server/usr** 文件夹，覆盖新安装的配置文件。

现在，您可以构建并部署新的生产级别容器。

## 从 Bluemix 中除去容器
{: #removing-a-container-from-bluemix }
从 Bluemix 中除去容器时，还必须从注册表中除去映像名称。  
运行以下命令以从 Bluemix 中除去容器：

1. `cf ic ps`（列举当前正在运行的容器）
2. `cf ic stop container_id`（停止该容器）
3. `cf ic rm container_id`（除去该容器）

运行以下 cf ic 命令，从 Bluemix 注册表中除去映像名称：

1. `cf ic images`（列举注册表中的映像）
2. `cf ic rmi image_id`（从注册表中除去映像）

## 从 Bluemix 中除去数据库服务配置
{: #removing-the-database-service-configuration-from-bluemix }
如果在配置 {{ site.data.keys.mf_server }} 映像期间运行了 **prepareserverdbs.sh** 脚本，那么将创建 {{ site.data.keys.mf_server }} 所需的配置和数据库表。此脚本还会针对容器创建数据库模式。

要从 Bluemix 中除去数据库服务配置，请使用 Bluemix 仪表板执行以下过程。

1. 从 Bluemix 仪表板，选择使用的 dashDB 服务。选择在运行 **prepareserverdbs.sh** 脚本时作为参数提供的 dashDB 服务名称。
2. 启动 dashDB 控制台以使用选中的 dashDB 服务实例的模式和数据库对象。
3. 选择与 IBM {{ site.data.keys.mf_server }} 配置相关的模式。模式名称是在运行 **prepareserverdbs.sh** 脚本时作为参数提供的名称。
4. 在仔细检查每个模式名称以及其下的对象后，删除模式。这将从 Bluemix 中除去数据库配置。
