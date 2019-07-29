---
layout: tutorial
title: 在 IBM Cloud Private 中分析 MobileFirst 日志消息
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

在 {{ site.data.keys.prod_icp }} 上的 {{ site.data.keys.prod_adj }} 部署中，当您在控制台中运行带有 JSON 格式日志记录的底层 Liberty 时，可以将日志事件细分为字段并存储在 Elasticsearch 中。您可以使用 Kibana 通过仪表板和搜索来监视多个 Liberty pod，也可以使用查询过滤大量日志记录。

Kubernetes 部署由 pod 组成，而 pod 由容器组成。在 {{ site.data.keys.prod_icp }} 中，每个 pod 的控制台输出将自动转发到内置弹性日志记录堆栈。有关弹性日志记录的更多信息，请参阅 [{{ site.data.keys.prod_icp }} 日志记录](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html)。


## 过程
{: #procedure}

完成以下步骤以浏览 {{ site.data.keys.prod_icp }} 目录并选择用于部署应用程序的相应 Helm 图表。

1.  在您的 Helm 图表中启用 JSON 日志记录。

      a.  从 {{ site.data.keys.prod_icp }} 控制台单击**菜单 > 目录**。<br/>
      b.  在**日志**部分中选择 **ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod** Helm 图表。<br/>
          **注：**如果在访问控制台时您的 Helm 目录未包含此 Helm 图表，请选择**管理 > Helm 存储库**，然后单击此按钮同步存储库以刷新目录。


      c.  将日志记录字段设置为以下缺省值，或者，在部署 {{ site.data.keys.prod_adj }} Helm 图表时从命令行使用 `--set` 标志设置先前的值。<br/>
      <p><b>针对 JSON 日志记录的 Helm 图表字段和值</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>GUI 字段名称</th>
            <th> 命令行字段名称</th>
            <th>字段值</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>控制台日志记录格式</td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>控制台日志记录级别</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>控制台日志记录源</td>
            <td>logs.consoleLogLevel</td>
            <td>message, trace, accessLog, ffdc<br/><br/>受支持的源类型为：messages、traces、accessLog 或 ffdc。<br/>在控制台日志记录源中以逗号分隔的列表形式指定每种源类型。<br/>使用 accessLog 时需要 <code>server.xml</code> 文件中的额外设置。<br/>有关更多信息，请参阅 <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">HTTP 访问日志记录</a>。</td>
          </tr>
        </tbody>
      </table>
2.  部署 Kibana。<br/>
    在启用 JSON 日志记录的情况下部署 Liberty 之后，日志记录将存储在 Elasticsearch 中，您可以使用 Kibana 查看日志记录。<br/>

      a.  要从控制台部署 Kibana，请单击**目录 > Helm 图表**。<br/>
      b.  选择 **ibm-icplogging-kibana** Helm 图表，然后单击目标名称空间中的 **kube-system**。<br/>
      c.  单击**安装**。<br/>

3.  打开 Kibana。<br/>

      a.  从控制台中单击**网络访问 > 服务**。<br/>
      b.  从服务列表中选择 **Kibana**。<br/>
      c.  单击**节点端口**字段中的链接以打开 Kibana。<br/>

4.  在 Kibana 中创建索引模式。<br/>

      a.  从 Kibana 单击**管理 > 索引模式**。针对索引名称或模式，输入 `logstash-*`。<br/>
      b.  选择 **ibm_datetime** 作为*时间过滤器*字段名称。<br/>
      c.  单击**创建**。<br/>

5. 您可以创建自己的查询、可视化或仪表板以分析日志数据。

6. 从[此处](https://github.com/WASdev/sample.dashboards)下载一组样本仪表板。要将仪表板导入 Kibana 中，请选择**管理 > 已保存的对象**，然后单击**导入**。

## 补充阅读
{: #further_reading}

* [{{ site.data.keys.prod_icp }}中的 Liberty 日志记录](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
