---
layout: tutorial
title: 在 Bluemix 上使用针对 Liberty for Java 的脚本设置 MobileFirst Server
breadcrumb_title: Liberty for Java
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
遵循以下指示信息在 Bluemix 上的 Liberty for Java 运行时上配置 {{ site.data.keys.mf_server }} 实例。（{{ site.data.keys.mf_analytics }} 实例只能在 IBM Containers 上运行。）为此您需要完成以下步骤：

* 使用所需工具 (Cloud Foundry CLI) 设置主计算机
* 设置 Bluemix 帐户
* 构建 {{ site.data.keys.mf_server }} 并将其推送到 Bluemix 作为 Cloud Foundry 应用程序。

最后，注册移动应用程序并部署适配器。

**注：**  

* 当前不支持在 Windows 操作系统上运行这些脚本。  
* {{ site.data.keys.mf_server }} 配置工具不能用于部署到 Bluemix。

#### 跳转至：
{: #jump-to }

* [在 Bluemix 上注册帐户](#register-an-account-at-bluemix)
* [设置主机](#set-up-your-host-machine)
* [下载 {{ site.data.keys.mf_bm_pkg_name }} 归档](#download-the-ibm-mfpf-container-8000-archive)
* [添加分析服务器信息](#adding-analytics-server-configuration-to-mobilefirst-server)
* [应用 {{ site.data.keys.mf_server }} 修订](#applying-mobilefirst-server-fixes)
* [从 Bluemix 中除去数据库服务配置](#removing-the-database-service-configuration-from-bluemix)

## 在 Bluemix 上注册帐户
{: #register-an-account-at-bluemix }
如果还没有帐户，请访问 [Bluemix Web 站点](https://bluemix.net)，然后单击**免费开始使用**或**注册**。您需要填写注册表单，然后才能进入下一步。

### Bluemix 仪表板
{: #the-bluemix-dashboard }
在登录 Bluemix 后，会显示 Bluemix 仪表板，其中提供了活动的 Bluemix **空间**的概述。缺省情况下，此工作区命名为“dev”。如果需要，您可以创建多个工作区/空间。

## 设置主机
{: #set-up-your-host-machine }
要管理 Bluemix Cloud Foundry 应用程序，需要安装 Cloud Foundry CLI。  
您可以使用 macOS Terminal.app 或 Linux bash shell 来运行脚本。

安装 [Cloud Foundry CLI](https://github.com/cloudfoundry/cli/releases?cm_mc_uid=85906649576514533887001&cm_mc_sid_50200000=1454307195)。

## 下载 {{ site.data.keys.mf_bm_pkg_name }} 归档
{: #download-the-ibm-mfpf-container-8000-archive}
要在 Liberty on Java 上设置 {{ site.data.keys.product }}，必须首先创建一个文件布局，此文件布局稍后将推送至 Bluemix。  
<a href="http://www-01.ibm.com/support/docview.wss?uid=swg2C7000005" target="blank">遵循本页面上的指示信息</a>下载 IBM Containers 归档的 {{ site.data.keys.mf_server }} 8.0（.zip 文件，搜索：*CNBL0EN*）。

此归档文件包含用于构建文件布局的文件（**dependencies** 和 **mfpf-libs**），用于构建和部署 {{ site.data.keys.mf_analytics }} Container 的文件 (**mfpf-analytics**) 以及用于配置 {{ site.data.keys.mf_server }} Cloud Foundry 应用程序的文件 (**mfpf-server-libertyapp**)。

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="zip-file">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>单击以了解有关归档文件内容的更多信息</b></a>
            </h4>
        </div>

        <div id="collapse-zip-file" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
            <div class="panel-body">
                <img src="zip.png" alt="显示归档文件的文件系统结构的图像" style="float:right;width:570px"/>
                <h4>dependencies 文件夹</h4>
                <p>包含 {{ site.data.keys.product }} 运行时和 IBM Java JRE 8。</p>

                <h4>mfpf-libs 文件夹</h4>
                <p>包含 {{ site.data.keys.product_adj }} 产品组件库和 CLI。
</p>

                <h4>mfpf-server-libertyapp 文件夹</h4>

                <ul>

                    <li><b>scripts</b> 文件夹：此文件夹包含 <b>args</b> 文件夹，其中包含一组配置文件。它还包含登录 Bluemix、构建 {{ site.data.keys.product }} 应用程序以推送至 BLuemix 和在 Bluemix 上运行服务器时需要运行的脚本。您可以选择以交互方式运行这些脚本，或者通过对配置文件进行预配置的方式来运行脚本（如后文所述）。除可定制的 args/*.properties 文件外，请勿修改该文件夹中的任何元素。要获取脚本用法帮助，请使用 <code>-h</code> 或 <code>--help</code> 命令行参数（例如，<code>scriptname.sh --help</code>）。</li>
                    <li><b>usr</b> 文件夹：
                        <ul>
                            <li><b>config</b> 文件夹：包含 {{ site.data.keys.mf_server }} 所使用的服务器配置片段（密钥库、服务器属性、用户注册表）。</li>
                            <li><b>keystore.xml</b> - 用于 SSL 加密的安全证书存储库的配置。必须在 ./usr/security 文件夹中引用列出的文件。</li>
                            <li><b>mfpfproperties.xml</b> - {{ site.data.keys.mf_server }} 的配置属性。请参阅以下文档主题中列出的受支持属性：
                                <ul>
                                <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">{{ site.data.keys.mf_server }} 管理服务的 JNDI 属性列表</a></li>
                                    <li><a href="../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">{{ site.data.keys.product_adj }}运行时的 JNDI 属性的列表</a></li>
                                </ul>
                            </li>
                            <li><b>registry.xml</b> - 用户注册表配置。basicRegistry - 将基于 XML 的基本用户注册表配置作为缺省值提供。可以为 basicRegistry 配置用户名和密码，或者也可以配置 ldapRegistry。</li>
                        </ul>
                    </li>
                    <li><b>env</b> 文件夹：包含用于服务器初始化 (server.env) 和定制 JVM 选项 (jvm.options) 的环境属性。<br/>
                    </li>

                    <li><b>security</b> 文件夹：用于存储密钥存储库、信任库和 LTPA 密钥文件 (ltpa.keys)。</li>

                </ul>
				<br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#zip-file" data-target="#collapse-zip-file" aria-expanded="false" aria-controls="collapse-zip-file"><b>关闭此节</b></a>
                                    </div>
        </div>
    </div>
</div>


## 设置 {{ site.data.keys.mf_server }}
{: #setting-up-the-mobilefirst-server }
您可以选择以交互方式运行这些脚本，或者通过使用配置文件来运行脚本：最好以交互方式运行一次脚本，这也将记录自变量 (**recorded-args**)。稍后，您可以使用自变量文件以非交互方式运行脚本。

> **注：**不记录密码，您将需要在自变量文件中手动添加密码。

* 使用配置文件 - 运行脚本并传递相应的配置文件作为自变量。
* 以交互方式 - 运行脚本，不使用任何自变量。

如果选择以交互方式运行脚本，可以跳过配置，但是强烈建议至少查看并了解一下您将需要提供的自变量。

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
<div class="panel-group accordion" id="scripts2" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="step-foundation-1">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#scripts2" data-target="#collapse-step-foundation-1" aria-expanded="false" aria-controls="collapse-step-foundation-1">使用配置文件</a>
            </h4>
        </div>

        <div id="collapse-step-foundation-1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="setupCordova">
            <div class="panel-body">
            <b>args</b> 文件夹包含一组配置文件，其中包含运行脚本所需的自变量。您可以在 <b>args</b> 文件夹中找到空的模板文件和自变量说明，或者之后可在 <b>recorded-args</b> 文件夹中以交互方式运行脚本。文件如下：<br/>

              <h4>initenv.properties</h4>
              此文件包含用于运行环境初始化的属性。
              <h4>prepareserverdbs.properties</h4>
              {{ site.data.keys.mf_bm_short }} 服务需要外部 <a href="https://console.ng.bluemix.net/catalog/services/dashdb/" target="\_blank">dashDB Enterprise Transactional 数据库实例</a>（标记为 OLTP 或 Transactional 的所有套餐）。<br/>
              <b>注：</b>dashDB Enterprise Transactional 套餐的部署针对标记为“按使用量收费”的套餐立即生效。请确保选择合适的套餐之一，如 <i>Enterprise for Transactions High Availability 2.8.500 (Pay per use)</i> <br/><br/>
              在设置 dashDB 实例后，请提供所需自变量。

              <h4>prepareserver.properties</h4>
              此文件用于 prepareserver.sh 脚本。这可为服务器文件布局做好准备，并将其推送至 Bluemix 作为 Cloud Foundry 应用程序。
              <h4>startserver.properties</h4>
              此文件用于配置服务器的运行时属性并启动服务器。强烈建议您使用至少1024 MB (<b>SERVER_MEM=1024</b>) 和 3 个节点用于实现高可用性 (<b>INSTANCES=3</b>)

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
                      运行 <b>initenv.sh</b> 脚本以登录 Bluemix。针对 dashDB 服务绑定的组织和空间运行以下脚本：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

                        您还可以在命令行上传递参数

{% highlight bash %}
initenv.sh --user Bluemix_user_ID --password Bluemix_password --org Bluemix_organization_name --space Bluemix_space_name
{% endhighlight %}

                        要了解受支持的所有参数及其文档，请运行帮助选项

{% highlight bash %}
./initenv.sh --help
{% endhighlight %}
                  </li>
                  <li><b>prepareserverdbs.sh - 准备 {{ site.data.keys.mf_server }} 数据库</b><br />
                  <b>prepareserverdbs.sh</b> 脚本用于通过 dashDB 数据库服务或可访问的 DB2 数据库服务器配置 {{ site.data.keys.mf_server }}。在本地安装 DB2 服务器的数据中心内运行 Bluemix 时，DB2 选项非常实用。如果使用 dashDB 服务，在步骤 1 中登录的组织和空间内应提供了 dashDB 服务的服务实例。请运行：
{% highlight bash %}
./prepareserverdbs.sh args/prepareserverdbs.properties
{% endhighlight %}

                        您还可以在命令行上传递参数

{% highlight bash %}
prepareserverdbs.sh --admindb MFPDashDBService
{% endhighlight %}

                        要了解受支持的所有参数及其文档，请运行帮助选项

{% highlight bash %}
./prepareserverdbs.sh --help
{% endhighlight %}
</li>
                  <li><b>initenv.sh（可选）- 登录 Bluemix</b><br />
                      仅当在除提供 dashDB 服务实例的组织和空间以外的其他组织和空间内需要创建服务器时，才需要执行此步骤。如果情况如此，请使用必须在其中创建和启动新组织和空间的容器来更新 initenv.properties，然后重新运行 <b>initenv.sh</b> 脚本：
{% highlight bash %}
./initenv.sh args/initenv.properties
{% endhighlight %}

</li>
                  <li><b>prepareserver.sh - 准备 {{ site.data.keys.mf_server }}</b><br />
                    运行 <b>prepareserver.sh</b> 脚本以构建 {{ site.data.keys.mf_server }} 并将其推送到 Bluemix 作为 Cloud Foundry 应用程序。要查看已登录的组织和空间内的所有 Cloud Foundry 应用程序及其 URL，请运行：<code>cf apps</code>
<br/>


{% highlight bash %}
./prepareserver.sh args/prepareserver.properties
{% endhighlight %}

                        您还可以在命令行上传递参数

{% highlight bash %}
prepareserver.sh --name APP_NAME
{% endhighlight %}

                        要了解受支持的所有参数及其文档，请运行帮助选项

{% highlight bash %}
./prepareserver.sh --help
{% endhighlight %}                  
</li>
                  <li><b>startserver.sh - 启动服务器</b><br />
                  <b>startserver.sh</b> 脚本用于在 Liberty for Java Cloud Foundry 应用程序上启动 {{ site.data.keys.mf_server }}。请运行：<p/>
{% highlight bash %}
./startserver.sh args/startserver.properties
{% endhighlight %}

                        您还可以在命令行上传递参数

{% highlight bash %}
./startserver.sh --name APP_NAME 
{% endhighlight %}

                        要了解受支持的所有参数及其文档，请运行帮助选项

{% highlight bash %}
./startserver.sh --help
{% endhighlight %}   

                  </li>
              </ol>
            </div>
        </div>
    </div>
</div>


装入以下 URL 以启动 {{ site.data.keys.mf_console }}：`http://APP_HOST.mybluemix.net/mfpconsole`（可能需要一些时间才能完成）  
遵循[使用 {{ site.data.keys.mf_cli }} 来管理 {{ site.data.keys.product_adj }} 工件](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)教程中的指示信息来添加远程服务器。  

通过使用 IBM Bluemixmay 上运行的 {{ site.data.keys.mf_server }}，现在您可以启动自己的应用程序开发。

#### 应用更改
{: #applying-changes }
您可能需要在部署服务器后对服务器布局应用更改，例如：要在 **/usr/config/mfpfproperties.xml** 中更新分析 URL。请完成更改，然后使用相同的自变量集重新运行以下脚本。

1. ./prepareserver.sh
2. ./startserver.sh

### 将分析服务器配置添加到 {{ site.data.keys.mf_server }}
{: #adding-analytics-server-configuration-to-mobilefirst-server }
如果已设置分析服务器并且想要将其连接到此 {{ site.data.keys.mf_server }}，那么请按以下指定的方式编辑文件夹 **package_root/mfpf-server-libertyapp/usr/config** 中的 **mfpfproperties.xml** 文件。将以 `<>` 标记的令牌替换为来自部署的正确值。

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value='"https://<AnalyticsContainerPublicRoute>:443/analytics/console"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.username" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.password" value='"<AnalyticsPassword>"'/>


<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.endpoint" value='"https://<AnalyticsContainerGroupRoute>:443/analytics-service/rest"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.services.ext.analytics" value="com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin"/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.user" value='"<AnalyticsUserName>"'/>
<jndiEntry jndiName="${env.MFPF_PUSH_ROOT}/mfp.push.analytics.password" value='"<AnalyticsPassword>"'/>
```

## 应用 {{ site.data.keys.mf_server }} 修订
{: #applying-mobilefirst-server-fixes }
Bluemix上的 {{ site.data.keys.mf_server }} 的临时修订可从 [IBM Fix Central](http://www.ibm.com/support/fixcentral) 获取。  
应用临时修订之前，请备份现有的配置文件。配置文件位于 **package_root/mfpf-server-libertyapp/usr** 文件夹中。

1. 下载临时修订归档并将内容解压缩到现有安装文件夹，覆盖现有文件。
2. 将备份配置文件复原至 **/mfpf-server-libertyapp/usr** 文件夹，覆盖新安装的配置文件。

现在，您可以构建并部署更新后的服务器。

## 从 Bluemix 中除去数据库服务配置
{: #removing-the-database-service-configuration-from-bluemix }
如果在配置 {{ site.data.keys.mf_server }} 映像期间运行了 **prepareserverdbs.sh** 脚本，那么将创建 {{ site.data.keys.mf_server }} 所需的配置和数据库表。此脚本还会针对 {{ site.data.keys.mf_server }} 创建数据库模式。

要从 Bluemix 中除去数据库服务配置，请使用 Bluemix 仪表板执行以下过程。

1. 从 Bluemix 仪表板，选择使用的 dashDB 服务。选择在运行 **prepareserverdbs.sh** 脚本时作为参数提供的 dashDB 服务名称。
2. 启动 dashDB 控制台以使用选中的 dashDB 服务实例的模式和数据库对象。
3. 选择与 IBM {{ site.data.keys.mf_server }} 配置相关的模式。模式名称是在运行 **prepareserverdbs.sh** 脚本时作为参数提供的名称。
4. 在仔细检查每个模式名称以及其下的对象后，删除模式。这将从 Bluemix 中除去数据库配置。
