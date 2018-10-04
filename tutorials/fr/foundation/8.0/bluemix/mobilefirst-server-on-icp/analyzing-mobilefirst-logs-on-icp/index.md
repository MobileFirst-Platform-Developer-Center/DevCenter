---
layout: tutorial
title: Analyzing MobileFirst log messages in IBM Cloud Private
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

In {{ site.data.keys.prod_adj }} deployments on {{ site.data.keys.prod_icp }}, when you run the underlying Liberty with JSON format logging in the console, log events can be broken down into fields and stored in Elasticsearch. You can use Kibana to monitor multiple Liberty pods with dashboards and search or you can filter large number of log records with queries.

A Kubernetes deployment is composed of pods, which are composed of containers. In {{ site.data.keys.prod_icp }}, the console output of each pod is forwarded to the built-in elastic logging stack automatically. For more information about elastic logging, see [{{ site.data.keys.prod_icp }} logging](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html).


## Procedure
{: #procedure}

Complete the steps to browse the {{ site.data.keys.prod_icp }} catalog and select the appropriate Helm chart, which you use to deploy applications.

1.  Enable JSON logging in your Helm chart.

      a.  From the {{ site.data.keys.prod_icp }} console, click **Menu > Catalog**.<br/>
      b.  Select **ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod** Helm chart, in the **Logs** section.<br/>
          **Note:**  If your Helm catalog does not contain this Helm chart when you access the console, select **Manage > Helm Repositories**, and click the button to sync repositories to refresh the catalog.


      c.  Set the Logging fields to the following default values, alternatively, you can set the previous values when you deploy the {{ site.data.keys.prod_adj }} Helm chart from the command line by using the `--set` flag.<br/>
      <p><b>Helm chart fields and values for JSON logging</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>GUI Field Name</th>
            <th> Command-Line Field Name</th>
            <th>Field Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Console logging format </td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>Console logging level</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>Console logging source</td>
            <td>logs.consoleLogLevel</td>
            <td>message, trace, accessLog, ffdc<br/><br/>The source types supported are: messages, traces, accessLog or ffdc.  <br/>Specify each source type in a comma-separated list in the console logging source. <br/>Using accessLog requires additional settings in <code>server.xml</code> file. <br/>For more information, see <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">HTTP access logging</a>.</td>
          </tr>
        </tbody>
      </table>
2.  Deploy Kibana.<br/>
    After you deploy Liberty with JSON logging enabled, log records are stored in Elasticsearch, and you can view the log records with Kibana.<br/>

      a.  To deploy Kibana, from the console, click **Catalog > Helm Charts**.<br/>
      b.  Select the **ibm-icplogging-kibana** Helm chart, and click **kube-system** in the target namespace.<br/>
      c.  Click **Install**.<br/>

3.  Open Kibana.<br/>

      a.  Click **Network Access > Services** from the console.<br/>
      b.  Select **Kibana** from the list of services.<br/>
      c.  Click the link in the **Node port** field to open Kibana.<br/>

4.  Create an index pattern in Kibana.<br/>

      a.  From Kibana, click **Management > Index Patterns**. Type `logstash-*` for the Index name or Pattern.<br/>
      b.  Select **ibm_datetime** as the *Time Filter* field name.<br/>
      c.  Click **Create**.<br/>

5. You can create your own queries, visualizations, or dashboards to analyze the log data.

6. Download a set of sample dashboards from [here](https://github.com/WASdev/sample.dashboards). To import dashboards into Kibana, select **Management > Saved Objects**, click **Import**.

## Further reading
{: #further_reading}

* [Liberty logging in {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
