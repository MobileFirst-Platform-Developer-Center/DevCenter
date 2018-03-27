---
layout: redirect
new_url: /404/
#layout: tutorial
#title: Log and trace collection
#relevantTo: [ios,android,windows,javascript]
#weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
IBM Containers for IBM Cloud provides some built-in logging and monitoring capabilites around container CPU, memory, and networking. You can optionally change the log levels for your {{ site.data.keys.product_adj }} containers.

The option to create log files for the {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} and {{ site.data.keys.mf_app_center }} containers is enabled by default (using level `*=info`). You can change the log levels by either adding a code override manually or by injecting code using a given script file. Both container logs and server or runtime logs can be viewed from a IBM Cloud logmet console by means of the Kibana visualization tool. Monitoring can be done from a IBM Cloud logmet console by means of Grafana, an open source metrics dashboard and graph editor.

When your {{ site.data.keys.product_adj }} container is created with a Secure Shell (SSH) key and bound to a public IP address, a suitable private key can be used to securely view the logs for the container instance.

### Logging overrides
{: #logging-overrides }
You can change the log levels by either adding a code override manually or by injecting code using a given script file. Adding a code override manually to change the log level must be done when you are first preparing the image. You must add the new logging configuration to the **package\_root/mfpf-[analytics|server]/usr/config** folder and to **package_root/mfp-appcenter/usr/config** folder as a separate configuration snippet, which gets copied to the configDropins/overrides folder on the Liberty server.

Injecting code using a given script file to change the log level can be accomplished by using certain command-line arguments when running any of the start\*.sh script files provided in the V8.0.0 package (**startserver.sh**, **startanalytics.sh**, **startservergroup.sh**, **startanalyticsgroup.sh**, **startappcenter.sh**, **startappcentergroup.sh**). The following optional command-line arguments are applicable:

* `[-tr|--trace]` trace_specification
* `[-ml|--maxlog]` maximum\_number\_of\_log\_files
* `[-ms|--maxlogsize]` maximum\_size\_of\_log\_files

## Container log files
{: #container-log-files }
Log files are generated for {{ site.data.keys.mf_server }} and Liberty Profile runtime activities for each container instance and can be found in the following locations:

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

Log files are generated for {{ site.data.keys.mf_app_center }} Server and Liberty Profile runtime activities for each container instance and can be found in the following locations:

* /opt/ibm/wlp/usr/servers/appcenter/logs/messages.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/console.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/trace.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/ffdc/*

You can log in to the container by following the steps in Accessing log files and access the log files.

To persist log files, even after a container no longer exists, enable a volume. (Volume is not enabled by default.) Having volume enabled can also allow you to view the logs from IBM Cloud using the logmet interface (such as https://logmet.ng.bluemix.net/kibana).

**Enabling volume**
Volume allows for containers to persist log files. The volume for {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analyics }} container logs is not enabled by default.

You can enable volume when running the **start*.sh** scripts by setting `ENABLE_VOLUME [-v | --volume]` to `Y`. This is also configurable in the **args/startserver.properties** and **args/startanalytics.properties** files for interactive execution of the scripts.

The persisted log files are saved in the **/var/log/rsyslog** and **/opt/ibm/wlp/usr/servers/mfp/logs** folders in the container.  
The logs can be accessed by issuing an SSH request to the container.

## Accessing log files
{: #accessing-log-files }
Logs are created for each container instance. You can access log files using the IBM Container Cloud Service REST API, by using `cf ic` commands, or by using the IBM Cloud logmet console.

### IBM Container Cloud Service REST API
{: #ibm-container-cloud-service-rest-api }
For any container instance, the **docker.log** and **/var/log/rsyslog/syslog** can be viewed using the [IBM Cloud logmet service](https://logmet.ng.bluemix.net/kibana/). The log activities can be seen using the Kibana dashboard of the same.

IBM Containers CLI commands (`cf ic exec`) can be used to gain access to running container instances. Alternatively, you can obtain container log files through Secure Shell (SSH).

### Enabling SSH
{: #enabling-ssh}
To enable SSH, copy the SSH public key to the **package_root/[mfpf-server or mfpf-analytics]/usr/ssh** folder before you run the **prepareserver.sh** or the **prepareanalytics.sh** scripts. This builds the image with SSH enabled. Any container created from that particular image will have the SSH enabled.

If SSH is not enabled as part of the image customization, you can enable it for the container using the SSH\_ENABLE and SSH\_KEY arguments when executing the **startserver.sh** or **startanalytics.sh** scripts. You can optionally customize the related script .properties files to include the key content.

The container logs endpoint gets stdout logs with the given ID of the container instance.

Example: `GET /containers/{container_id}/logs`

#### Accessing containers from the command line
{: #accessing-containers-from-the-command-line }
You can access running {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} container instances from the command line to obtain logs and traces.

1. Create an interactive terminal within the container instance by running the following command: `cf ic exec -it container_instance_id "bash"`.
2. To locate the log files or traces, use the following command example:

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
   container_instance@root# vi messages.log
   ```

3. To copy the logs to your local workstation, use the following command example:

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### Accessing containers using SSH
{: #accessing-containers-using-ssh }
You can get the syslogs and Liberty logs by using Secure Shell (SSH) to access your {{ site.data.keys.mf_server }} and {{ site.data.keys.mf_analytics }} containers.

If you are running a container group, you can bind a public IP address to each instance and view the logs securely using SSH. To enable SSH, make sure to copy the SSH public key to the **mfp-server\server\ssh** folder before you run the **startservergroup.sh** script.

1. Make an SSH request to the container. Example: `mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. Archive the log file location. Example:

```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

Download the log archive to your local workstation. Example:

```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
