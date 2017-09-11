---
layout: tutorial
title: 在 IBM Bluemix Kubernetes Cluster 上设置 MobileFirst Server
breadcrumb_title: IBM Bluemix 上的 Kubernetes Cluster
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
遵循以下指示信息在 IBM Bluemix 上配置 {{ site.data.keys.mf_server }} 实例和 {{ site.data.keys.mf_analytics }} 实例。 为此您需要完成以下步骤：

* 创建以下类型的 Kubernetes Cluster：Standard（已付费集群）。
* 使用所需的工具（Docker、Cloud Foundry CLI (cf)、Bluemix CLI (bx)、Container Service Plugin for Bluemix CLI (bx cs)、Container Registry Plugin for Bluemix CLI (bx cr) 或 Kubernetes CLI (kubectl)）来设置主计算机。
* 构建 {{ site.data.keys.mf_server }} Docker 映像并将其推送到 Bluemix 存储库。
* 最后，在 Kubernetes Cluster 上运行 Docker 映像。

>**注：**  
>
* 当前不支持在 Windows 操作系统上运行这些脚本。  
* {{ site.data.keys.mf_server }} 配置工具不能用于部署到 IBM Container。

#### 跳转至：
{: #jump-to }
* [在 Bluemix 上注册帐户](#register-an-account-on-bluemix)
* [设置主机](#set-up-your-host-machine)
* [使用 IBM Bluemix Container Service 创建并设置 Kubernetes Cluster](#setup-kube-cluster)
* [下载 {{ site.data.keys.mf_bm_pkg_name }} 归档](#download-the-ibm-mfpf-container-8000-archive)
* [先决条件](#prerequisites)
* [使用 IBM Containers 在 Kubernetes Cluster 上设置 {{ site.data.keys.product_adj }} 和 Analytics Server](#setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers)
* [应用 {{ site.data.keys.mf_server }} 修订](#applying-mobilefirst-server-fixes)
* [从 Bluemix 中除去容器](#removing-the-container-from-bluemix)
* [从 Bluemix 中除去 Kubernetes 部署](#removing-kube-deployments)
* [从 Bluemix 中除去数据库服务配置](#removing-the-database-service-configuration-from-bluemix)

## 在 Bluemix 上注册帐户
{: #register-an-account-on-bluemix }
如果还没有帐户，请访问 [Bluemix Web 站点](https://bluemix.net)，然后单击**免费开始使用**或**注册**。 您需要填写注册表单，然后才能进入下一步。

### Bluemix 仪表板
{: #the-bluemix-dashboard }
在登录 Bluemix 后，会显示 Bluemix 仪表板，其中提供了活动的 Bluemix **空间**的概述。 缺省情况下，此工作区命名为“dev”。 如果需要，您可以创建多个工作区/空间。

## 设置主机
{: #set-up-your-host-machine }
要管理容器和映像，您需要安装以下工具：
* Docker
* Bluemix CLI (bx)
* Container Service Plugin for Bluemix CLI (bx cs)
* Container Registry Plugin for Bluemix CLI (bx cr)
* Kubernetes CLI (kubectl)

请参阅 Bluemix 文档以了解[设置必备 CLI 的步骤](https://console.bluemix.net/docs/containers/cs_cli_install.html#cs_cli_install_steps)。

## 使用 IBM Bluemix Container Service 创建并设置 Kubernetes Cluster
{: #setup-kube-cluster}
请参阅 Bluemix 文档以[在 Bluemix 上设置 Kubernetes Cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_cli)。

>**注：**部署 {{ site.data.keys.mf_bm_short }} 需要 Kubernetes Cluster 类型：Standard（已付费集群）。

## 下载 {{ site.data.keys.mf_bm_pkg_name }} 归档
{: #download-the-ibm-mfpf-container-8000-archive}
要使用 Bluemix 容器将 {{ site.data.keys.mf_bm_short }} 设置为 Kubernetes Cluster，必须首先创建一个映像，稍后将其推送至 Bluemix。<br/>
IBM Containers 上的 MobileFirst Server 的临时修订可从 [IBM Fix Central](http://www.ibm.com/support/fixcentral) 获取。<br/>
从 Fix central 下载最新临时修订。从 iFix **8.0.0.0-IF201707051849** 起，提供 Kubernetes 支持。

此归档文件包含用于构建映像（**dependencies** 和 **mfpf-libs**）的文件，以及用于在 Kubernetes (bmx-kubenetes) 上构建和部署 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 的文件。

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
                <h4>bmx-kubernetes 文件夹</h4>
                <p>包含使用 IBM Bluemix Container Service 部署到 Kubernetes Cluster 所需的定制文件和脚本。</p>

                <h4>Dockerfile-mfpf-analytics 和 Dockerfile-mfpf-server</h4>

                <ul>
                    <li><b>Dockerfile-mfpf-server</b>：包含构建 {{ site.data.keys.mf_server }} 映像所需的所有命令的文本文档。</li>
                    <li><b>Dockerfile-mfpf-analytics</b>：包含构建 {{ site.data.keys.mf_analytics }} 映像所需的所有命令的文本文档。</li>
                    <li><b>scripts</b> 文件夹：此文件夹包含 <b>args</b> 文件夹，其中包含一组配置文件。 它还包含登录 Bluemix、构建 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 映像和在 Bluemix 上推送与运行此映像时所需的脚本。您可以选择以交互方式运行这些脚本，或者通过对配置文件进行预配置的方式来运行脚本（如后文所述）。除可定制的 args/*.properties 文件外，请勿修改该文件夹中的任何元素。 要获取脚本用法帮助，请使用 <code>-h</code> 或 <code>--help</code> 命令行参数（例如，<code>scriptname.sh --help</code>）。</li>
                    <li><b>usr-mfpf-server</b> 和 <b>usr-mfpf-analytics</b> 文件夹：
                        <ul>
                            <li><b>bin</b> 文件夹：包含将在容器启动时执行的脚本文件 (mfp-init)。您可以添加自己的定制代码以执行这些代码。</li>
                            <li><b>config</b> 文件夹：包含 {{ site.data.keys.mf_server }}/{{ site.data.keys.mf_analytics }} 所使用的服务器配置片段（密钥库、服务器属性、用户注册表）。</li>
                            <li><b>keystore.xml</b> - 用于 SSL 加密的安全证书存储库的配置。 必须在 ./usr/security 文件夹中引用列出的文件。</li>
                            <li><b>ltpa.xml</b> - 定义 LTPA 密钥及其密码的配置文件。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 的配置属性。 请参阅以下文档主题中列出的受支持属性：
                                <ul>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }} 运行时的 JNDI 属性列表</a></li>
                                </ul>
                            </li>
                            <li><b>mfpfsqldb.xml</b> - 用于连接到 DB2 或 dashDB 数据库的 JDBC 数据源定义。</li>
                            <li><b>registry.xml</b> - 用户注册表配置。 basicRegistry - 将基于 XML 的基本用户注册表配置作为缺省值提供。 可以为 basicRegistry 配置用户名和密码，或者也可以配置 ldapRegistry。</li>
                            <li><b>tracespec.xml</b> - 用于启用调试和记录级别的跟踪规范。</li>
                        </ul>
                    </li>
                    <li><b>jre-security</b> 文件夹：您可以通过将 JRE 安全相关文件（信任库、策略 JAR 文件等）放置在本文件夹中来更新这些文件。 将此文件夹中的文件复制到容器中的 <b>JAVA_HOME/jre/lib/security/</b> 文件夹。</li>
                    <li><b>security</b> 文件夹：用于存储密钥存储库、信任库和 LTPA 密钥文件 (ltpa.keys)。</li>
                    <li><b>env</b> 文件夹：包含用于服务器初始化 (server.env) 和定制 JVM 选项 (jvm.options) 的环境属性。</li>

                    <br/>
                    <div class="panel-group accordion" id="terminology" role="tablist">
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
                                            <td>用于客户机 HTTP 请求的端口。 使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_HTTPSPORT	</td>
                                            <td>9443*	</td>
                                            <td>通过 SSL (HTTPS) 保护的客户机 HTTP 请求所使用的端口。 使用 -1 来禁用此端口。</td>
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
                                            <td>MFPF_DEPLOYER_GROUP	</td>
                                            <td>mfpdeployergroup</td>
                                            <td>已分配预定义角色 <code>mfpdeployer</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_MONITOR_GROUP	</td>
                                            <td>mfpmonitorgroup</td>
                                            <td>已分配预定义角色 <code>mfpmonitor</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_OPERATOR_GROUP	</td>
                                            <td>mfpoperatorgroup</td>
                                            <td>已分配预定义角色 <code>mfpoperator</code> 的用户组的名称。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_USER	</td>
                                            <td>WorklightRESTUser</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services 的 Liberty 服务器管理员用户。</td>
                                        </tr>
                                        <tr>
                                            <td>MFPF_SERVER_ADMIN_PASSWORD	</td>
                                            <td>mfpadmin。 确保在部署到生产环境之前将缺省值更改为专用密码。</td>
                                            <td>{{ site.data.keys.mf_server }} Administration Services 的 Liberty 服务器管理员用户的密码。</td>
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
                                            <td>用于客户机 HTTP 请求的端口。 使用 -1 来禁用此端口。</td>
                                        </tr>
                                        <tr>
                                            <td>ANALYTICS_SERVER_HTTPS PORT	</td>
                                            <td>9443*	</td>
                                            <td>用于客户机 HTTP 请求的端口。 使用 -1 来禁用此端口。</td>
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
                    <li><b>dependencies</b> 文件夹：包含 {{ site.data.keys.mf_bm_short }} 运行时和 IBM Java JRE 8。</li>
                    <li><b>mfpf-libs folder</b> 文件夹：包含 {{ site.data.keys.product_adj }} 产品组件库和 CLI。</li>
                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>关闭此节</b></a>
            </div>
        </div>
    </div>
</div>

## 先决条件
{: #prerequisites }

您需要具备 Kubernetes 的应用知识。请参阅 [Kubernetes 文档](https://kubernetes.io/docs/concepts/)，以了解更多信息。


## 使用 IBM Containers 在 Kubernetes Cluster 上设置 {{ site.data.keys.product_adj }} 和 Analytics Server
{: #setting-up-the-mobilefirst-and-analytics-servers-on-kube-with-ibm-containers }
如上文所述，您可以选择以交互方式运行这些脚本，或者通过使用配置文件来运行脚本：

* **使用配置文件** - 运行脚本并传递相应的配置文件作为自变量。
* **以交互方式** - 运行脚本，不使用任何自变量。

>**注：**如果选择以交互方式运行脚本，可以跳过配置，但是强烈建议查看并了解一下您将需要提供的自变量。

以交互方式运行时，在以下目录中会保存所提供自变量的副本：`./recorded-args/`。这样您便可以在首次使用交互方式后复用这些属性文件，作为将来部署的参考。

<div class="panel-group accordion" id="scripts2" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">使用配置文件</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
                <b>args</b> 文件夹包含一组配置文件，其中包含运行脚本所需的自变量。 在以下文件中填充自变量值：<br/>

                <h4>initenv.properties</h4>
                <ul>
                    <li><b>BLUEMIX_API_URL - </b>要执行部署的地理位置或区域。<br>
                      <blockquote>例如：<i>api.ng.bluemix.net</i> 表示美国，<i>api.eu-de.bluemix.net</i> 表示德国，<i>api.au-syd.bluemix.net</i> 表示悉尼</blockquote>
                    </li>
                    <li><b>BLUEMIX_ACCOUNT_ID - </b>您的帐户标识，该标识为字母数字值，例如，<i>a1b1b111d11e1a11d1fa1cc999999999</i><br>	使用 <code>bx target</code> 命令可获取帐户标识。</li>
                    <li><b>BLUEMIX_USER - </b>Bluemix 用户名（电子邮件）。</li>
                    <li><b>BLUEMIX_PASSWORD - </b>Bluemix 密码。</li>
                    <li><b>BLUEMIX_ORG - </b>Bluemix 组织名称。</li>
                    <li><b>BLUEMIX_SPACE - </b>Bluemix 空间（如上文所述）。</li>
                </ul><br/>
                <h4>prepareserverdbs.properties</h4>
                {{ site.data.keys.mf_bm_short }} 服务需要外部 <a href="https://console.bluemix.net/catalog/services/db2-on-cloud/" target="\_blank"><i>DB2 on cloud</i></a> 实例。<br/>
                <blockquote><b>注：</b>您还可以使用自己的 DB2 数据库。Bluemix Kubenetes Cluster 应配置为连接到此数据库。</blockquote>
                在设置 DB2 实例后，请提供所需自变量：
                <ul>
                    <li><b>DB_TYPE</b> - <i>dashDB</i>（使用 DB2 on Cloud 时）或 <i>DB2</i>（使用自己的 DB2 数据库时）。</li>
                    <li>如果您使用自己的 DB2 数据库（即，DB_TYPE=DB2），请提供以下信息。
                      <ul><li><b>DB2_HOST</b> - 您的 DB2 设置的主机名。</li>
                          <li><b>DB2_DATABASE</b> - 数据库的名称。</li>
                          <li><b>DB2_PORT</b> - 将用于连接到数据库的端口。</li>
                          <li><b>DB2_USERNAME</b> - DB2 数据库用户（此用户应具备在提供的模式中创建表的权限，或者如果不存在模式，那么此用户应可创建模式）</li>
                          <li><b>DB2_PASSWORD</b> - DB2 用户密码。</li>
                      </ul>
                    </li>
                    <li>如果使用 DB2 on Cloud（即，DB_TYPE=dashDB），请提供以下信息。
                      <ul><li><b>ADMIN_DB_SRV_NAME</b> - 用于存储管理数据的 dashDB 服务实例名称。</li>
                          <li><b>RUNTIME_DB_SRV_NAME</b> - 用于存储运行时数据的 dashDB 服务实例名称。缺省名称为管理服务名称。</li>
                          <li><b>PUSH_DB_SRV_NAME</b> - 用于存储运行时数据的 dashDB 服务实例名称。缺省名称为管理服务名称。</li>
                      </ul>
                    </li>
                    <li><b>ADMIN_SCHEMA_NAME</b> - 管理数据的模式名称。缺省名称为 <i>MFPDATA</i>。</li>
                    <li><b>RUNTIME_SCHEMA_NAME - </b>运行时数据的模式名称。 缺省名称为 <i>MFPDATA</i>。</li>
                    <li><b>PUSH_SCHEMA_NAME - </b>运行时数据的模式名称。缺省名称为 <i>MFPDATA</i>。</li>
                    <blockquote><b>注：</b>如果许多用户或多个 {{ site.data.keys.mf_bm_short }} 部署共享 DB2 数据库服务实例，请确保提供唯一的模式名称。</blockquote>
                </ul><br/>
                <h4>prepareserver.properties</h4>
                <ul>
                  <li><b>SERVER_IMAGE_TAG</b> - 映像标记。应采用以下格式：<em>registry-url/namespace/image:tag</em>。</li>
                  <li><b>ANALYTICS_IMAGE_TAG</b> - 映像标记。应采用以下格式：<em>registry-url/namespace/image:tag</em>。</li>
                  <blockquote>例如：<em>registry.ng.bluemix.net/myuniquenamespace/mymfpserver:v1</em><br/>如果尚未创建 Docker 注册表名称空间，请使用以下任一命令创建注册表名称空间：<br/>
                  <ul><li><code>bx cr namespace-add <em>myuniquenamespace</em></code></li><li><code>bx cr namespace-list</code></li></ul>
                  </blockquote>
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
            <p>以下指示信息演示了如何使用配置文件来运行脚本。 如果选择以非交互方式来运行，那么还提供了命令行自变量的列表：</p>

            <ol>
                <li><b>initenv.sh - 登录 Bluemix </b><br />
                    运行 <b>initenv.sh</b> 脚本以创建环境，用于在 IBM Containers 上构建和运行 {{ site.data.keys.mf_bm_short }}：
                    <b>交互方式</b>
{% highlight bash %}
./initenv.sh
{% endhighlight %}
                    <b>非交互方式</b>
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}
                </li>
                <li><b>prepareserverdbs.sh - 准备 {{ site.data.keys.mf_server }} 数据库</b><br />
                    <b>prepareserverdbs.sh</b> 脚本用于通过 DB2 数据库服务配置 {{ site.data.keys.mf_server }}。在步骤 1 中登录的组织和空间内应提供了 DB2 服务的服务实例。请运行：
<b>交互方式</b>
{% highlight bash %}
./prepareserverdbs.sh
{% endhighlight %}
                    <b>非交互方式</b>
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}
                </li>
                <li><b>initenv.sh（可选）- 登录 Bluemix</b><br />
                      仅当在除提供 DB2 服务实例的组织和空间以外的其他组织和空间内需要创建容器时，才需要执行此步骤。如果情况如此，请使用必须在其中创建和启动新组织和空间的容器来更新 initenv.properties，然后重新运行 <b>initenv.sh</b> 脚本：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                </li>
                <li><b>prepareserver.sh - 准备 {{ site.data.keys.mf_server }} 映像</b><br />
                    运行 <b>prepareserver.sh</b> 脚本以构建 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 映像并将其推送到 Bluemix 存储库。要查看 Bluemix 存储库中的所有可用映像，请运行：<code>bx cr image-list</code><br/>
                    此列表包含映像名称、创建日期和标识。<br/>
                    <b>交互方式</b>
{% highlight bash %}
./prepareserver.sh
{% endhighlight %}
                    <b>非交互方式</b>
{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}
                </li>
                <li>使用 Bluemix Container Service 在 Kubernetes Cluster 的 Docker 容器上部署 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }}。
                <ol>
                  <li>将终端上下文设置为您的集群<br/><code>bx cs cluster-config <em>my-cluster</em></code><br/>
                  要了解集群名称，请运行以下命令：<br/><code>bx cs clusters</code><br/>
                  在输出中，指向配置文件的路径显示为用于设置环境变量的命令，例如：<br/>
                  <code>export KUBECONFIG=/Users/ibm/.bluemix/plugins/container-service/clusters/<em>my-cluster</em>/kube-config-prod-dal12-my-cluster.yml</code><br/>
                  将 <em>my-cluster</em> 替换为您的集群名称后，复制粘贴以上命令以在您的终端内设置环境变量，然后按 <b>Enter</b> 键。
                  </li>
                  <li><b>[Mandatory for {{ site.data.keys.mf_analytics }}]: </b> 创建<b>持久存储卷申请</b>。这将用于持久存储分析数据。这是一次性步骤。如果先前已创建 <b>PVC</b>，可以进行复用。编辑 <em>yaml</em> 文件 <b>args/mfpf-persistent-volume-claim.yaml</b>，然后运行此命令。
                  在执行以下 <em>kubectl</em> 命令之前，所有变量都必须替换为各自的值。<br/><code>kubectl create -f ./args/mfpf-persistent-volume-claim.yaml</code><br/>
                  记下<b>持久存储卷申请</b>的名称，因为后续步骤中必须提供此名称。
                  </li>
                  <li>要获取<b>入口域</b>，请运行以下命令：<br/>
                   <code>bx cs cluster-get <em>my-cluster</em></code><br/>
                   记下“入口域”。如果需要配置 TLS，请记下<b>入口密钥</b>。</li>
                  <li>创建 Kubernetes 部署<br/>编辑 yaml 文件 <b>args/mfpf-deployment-all.yaml</b>，并填写详细信息。在执行 <em>kubectl</em> 命令之前，所有变量都必须替换为各自的值。<br/>
                  <b>./args/mfpf-deployment-all.yaml</b> 包含以下部署：
                  <ul>
                    <li>{{ site.data.keys.mf_server }} 的 kubernetes 部署，其中包含 3 个实例（副本），内存为 1024MB 且具有单核 CPU。</li>
                    <li>{{ site.data.keys.mf_analytics }} 的 kubernetes 部署，其中包含 2 个实例（副本），内存为 1024MB 且具有单核 CPU。</li>
                    <li>{{ site.data.keys.mf_server }} 的 kubernetes 服务。</li>
                    <li>{{ site.data.keys.mf_analytics }} 的 kubernetes 服务。</li>
                    <li>整个设置的入口，包含 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 的所有 REST 端点。</li>
                    <li>configMap，用于使环境变量在 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }} 实例中可用。</li>
                  </ul>
                  在 YAML 文件中必须编辑以下值：<br/>
                    <ol><li>显示的不同 <em>my-cluster.us-south.containers.mybluemix.net</em>，含<b>入口域</b>的输出（来自上述 <code>bx cs cluster-get</code> 命令的输出）。</li>
                    <li><em>registry.ng.bluemix.net/repository/mfpfanalytics:latest</em> 和 <em>registry.ng.bluemix.net/repository/mfpfserver:latest</em> - 使用您在 prepareserver.sh 中所使用的名称来上载映像。</li>
                    <li><b>claimName</b>：<em>mfppvc</em> - 使用先前已使用的“持久存储卷申请”名称来创建 PVC。<br/></li>
                    </ol>
                    执行以下命令：<br/>
                    <code>kubectl create -f ./args/mfpf-deployment-all.yaml</code>
                    <blockquote><b>注：<br/></b>已提供以下模板 yaml 文件：<br/>
                    <ul><li><b>mfpf-deployment-all.yaml</b>：使用 HTTP 部署 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }}。</li>
                      <li><b>mfpf-deployment-all-tls.yaml</b>：使用 HTTPS 部署 {{ site.data.keys.mf_server }} 和 {{ site.data.keys.mf_analytics }}。</li>
                      <li><b>mfpf-deployment-server.yaml</b>：使用 HTTP 部署 {{ site.data.keys.mf_server }}。</li>
                      <li><b>mfpf-deployment-analytics.yaml</b>：使用 HTTP 部署 {{ site.data.keys.mf_analytics }}。</li></ul></blockquote>
                      创建后，要使用 Kubernetes 仪表板，请执行以下命令：<br/>
                      <code>kubectl proxy</code><br/>在浏览器中打开 <b>localhost:8001/ui</b>。
                  </li>
                </ol>
                </li>
                </ol>
            </div>
        </div>
    </div>
</div>

通过使用 IBM Bluemixmay 上运行的 {{ site.data.keys.mf_server }}，现在您可以启动自己的应用程序开发。 查看 {{ site.data.keys.product }} [教程](../../all-tutorials)。


## 应用 {{ site.data.keys.mf_server }} 修订
{: #applying-mobilefirst-server-fixes }

IBM Containers 上的 {{ site.data.keys.mf_server }} 的临时修订可从 [IBM Fix Central](http://www.ibm.com/support/fixcentral) 获取。  
应用临时修订之前，请备份现有的配置文件。 配置文件位于以下文件夹中：
* {{ site.data.keys.mf_analytics }}：**package_root/bmx-kubernetes/usr-mfpf-analytics**
* {{ site.data.keys.mf_server }} Liberty Cloud Foundry 应用程序：**package_root/bmx-kubernetes/usr-mfpf-server**

### 应用 iFix 的步骤：

1. 下载临时修订归档并将内容解压缩到现有安装文件夹，覆盖现有文件。
2. 将备份配置文件复原到 **package_root/bmx-kubernetes/usr-mfpf-server** 和 **package_root/bmx-kubernetes/usr-mfpf-analytics** 文件夹，覆盖新安装的配置文件。
3. 在编辑器中编辑 **package_root/bmx-kubernetes/usr-mfpf-server/env/jvm.options** 文件并除去以下行（如果存在）：
```
-javaagent:/opt/ibm/wlp/usr/servers/mfp/newrelic/newrelic.jar”
```
    现在，您可以构建并部署更新后的服务器。

    a. 运行 `prepareserver.sh` 脚本以重新构建服务器映像并将其推送到 IBM Containers 服务。

    b. 运行以下命令执行滚动更新：
<code>kubectl rolling-update NAME -f FILE</code>

<!--**Note:** When applying fixes for {{ site.data.keys.mf_app_center }} the folders are `mfp-appcenter-libertyapp/usr` and `mfp-appcenter/usr`.-->

## 从 Bluemix 中除去容器
{: #removing-the-container-from-bluemix }
从 Bluemix 中除去容器时，还必须从注册表中除去映像名称。  
运行以下命令以从 Bluemix 中除去容器：

1. `cf ic ps`（列举当前正在运行的容器）
2. `cf ic stop container_id`（停止该容器）
3. `cf ic rm container_id`（除去该容器）

运行以下 cf ic 命令，从 Bluemix 注册表中除去映像名称：

1. `cf ic images`（列举注册表中的映像）
2. `cf ic rmi image_id`（从注册表中除去映像）

## 从 Bluemix 中除去 Kubernetes 部署
{: #removing-kube-deployments}

运行以下命令以从 Bluemix Kubernetes Cluster 中除去已部署的实例：

`kubectl delete -f mfpf-deployment-all.yaml`（除去 yaml 中定义的所有 kubernetes 类型）

运行以下命令以从 Bluemix 注册表中除去映像名称：
```bash
bx cr image-list（列举注册表中的映像）
bx cr image-rm image-name（从注册表中除去映像）
```

## 从 Bluemix 中除去数据库服务配置
{: #removing-the-database-service-configuration-from-bluemix }
如果在配置 {{ site.data.keys.mf_server }} 映像期间运行了 **prepareserverdbs.sh** 脚本，那么将创建 {{ site.data.keys.mf_server }} 所需的配置和数据库表。 此脚本还会针对容器创建数据库模式。

要从 Bluemix 中除去数据库服务配置，请使用 Bluemix 仪表板执行以下过程。

1. 从 Bluemix 仪表板，选择使用的 DB2 on cloud 服务。选择在运行 **prepareserverdbs.sh** 脚本时作为参数提供的 DB2 服务名称。
2. 启动 DB2 控制台以使用选中的 DB2 服务实例的模式和数据库对象。
3. 选择与 IBM {{ site.data.keys.mf_server }} 配置相关的模式。 模式名称是在运行 **prepareserverdbs.sh** 脚本时作为参数提供的名称。
4. 在仔细检查每个模式名称以及其下的对象后，删除模式。 这将从 Bluemix 中除去数据库配置。
