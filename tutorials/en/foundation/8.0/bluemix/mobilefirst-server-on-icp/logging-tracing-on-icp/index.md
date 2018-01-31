---
layout: tutorial
title: Logging and Tracing in IBM Cloud Private
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
{{ site.data.keys.product_full }} logs errors, warnings and, informational messages into a log file. The underlying mechanism of logging varies depending on the application server. In {{ site.data.keys.prod_icp }}, the only supported application server is Liberty.

The following document explains how to enable trace and collect logs for {{ site.data.keys.mf_server }} running in Kubernetes cluster on {{ site.data.keys.prod_icp }}.


#### Jump to:
{: #jump-to }
* [Prerequisites](#prereqs)
* [Configure logging and monitoring mechanism](#configure-log-monitor)
* [Collecting *kubectl* logs](#collect-kubectl-logs)
* [Collecting logs using IBM provided custom script](#collect-logs-custom-script)


## Prerequisites
{: #prereqs}

Install and configure the following tools required for log collection and troubleshooting:
* Docker (`docker`)
* Kubernetes CLI (`kubectl`)

To configure the `kubectl` client for your cluster running on {{ site.data.keys.prod_icp }}, follow the steps described [here](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html).


## Configure logging and monitoring mechanism
{: #configure-log-monitor}

By default, all {{ site.data.keys.product }} logging goes to the application server log files. The standard tools that are available in Liberty can be used to control the {{ site.data.keys.product }} server logging. Learn more from the documentation on [Configuring Logging and Monitoring Mechanisms](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html).

[Configuring logging and monitoring Mechanisms](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html) provides details on how the `server.xml` can be updated to configure the logging and also provides information on trace enablement. Use the filter `com.ibm.ws.logging.trace.specification` to selectively enable trace, [learn more](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html). This property can be specified via `jvm.option` or in `bootstrap.properties` of the server instance.

For example, adding the following entry in the `jvm.options` will enable tracing for all the methods starting with `com.ibm.mfp` and the trace level will be set to *all*.
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```

## Collecting *kubectl* logs
{: #collect-kubectl-logs}

The `kubectl logs` command can be used to obtain information about the deployed container on Kubernetes Cluster. For example, the following command retrieves the logs for the pod, whose *pod_name* is provided in the command:

```bash
kubectl logs po/<pod_name>
```
For more information on `kubectl logs` command, refer to [Kubernetes documentation](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/).

## Collecting logs using IBM provided custom script
{: #collect-logs-custom-script}

The {{ site.data.keys.mf_server }} logs and container logs can be collected using the script [get-icp-logs.sh](get-icp-logs.sh). It takes *Helm release name* as input and collects the logs from all pods deployed.

The script can be executed as follows:
```bash
get-icp-logs <helm_release_name> [<output_directory>] [<name_space>]
```
The table below describes each of the parameters used by the custom script.

| Option | Description | Remarks |
|--------|-------------|---------|
| helm_release_name | Release name of the respective Helm Chart installation | **Mandatory** |
| output_directory | Output directory where the collected logs to be placed | **Optional**<br/>Default: **mfp-icp-logs** under current working directory. |
| name_space | Namespace where the respective Helm Chart is installed | **Optional**<br/>Default: **default** |
