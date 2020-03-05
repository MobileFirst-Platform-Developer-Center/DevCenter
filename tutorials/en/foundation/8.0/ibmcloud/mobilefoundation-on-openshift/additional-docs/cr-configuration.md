---
layout: tutorial
breadcrumb_title: Mobile Foundation Custom Resource (CR) configuration
title: IBM Mobile Foundation Custom Resource (CR) configuration
weight: 3
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->

### Parameters

| Qualifier | Parameter  | Definition | Allowed Value |
|---|---|---|---|
| global.arch |  amd64    | amd64 worker node scheduler preference in a hybrid cluster | amd64 |
| global.image     | pullPolicy | Image Pull Policy | Always, Never, or IfNotPresent. Default: **IfNotPresent** |
|      |  pullSecret    | Image pull secret | Required only if images are not hosted on OCP image registry. |
| global.ingress | hostname | The external hostname or IP address to be used by external clients | Leave blank to default to the IP address of the cluster proxy node|
|         | secret | TLS secret name| Specifies the name of the secret for the certificate that has to be used in the Ingress definition. The secret has to be pre-created using the relevant certificate and key. Mandatory if SSL/TLS is enabled. Pre-create the secret with Certificate & Key before supplying the name here. Refer [here](#optional-creating-tls-secret-for-ingress-configuration) |
|         | sslPassThrough | Enable SSL passthrough | Specifies is the SSL request should be passed through to the Mobile Foundation service - SSL termination occurs in the Mobile Foundation service.  **false** (default) or true|
| global.dbinit | enabled | Enable initialization of Server, Push and Application Center databases | Initializes databases and create schemas / tables for Server, Push and Application Center deployment.(Not required for Analytics).  **true** (default) or false |
|  | repository | Docker image repository for database initialization | Repository of the Mobile Foundation database docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description |
| mfpserver | enabled          | Flag to enable Server | **true** (default) or false |
| mfpserver.image | repository | Docker image repository | Repository of the Mobile Foundation Server docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Refer [here](#optional-creating-custom-defined-console-login-secrets)
|  mfpserver.db | type | Supported database vendor name. | **DB2** (default) / MySQL / Oracle |
|               | host | IP address or hostname of the database where Mobile Foundation Server tables need to be configured. | |
|                       | port | 	Port where database is setup | |
|                       | secret | A precreated secret which has database credentials| |
|                       | name | Name of the Mobile Foundation Server database | |
|                       | schema | Server db schema to be created. | If the schema already present, it will be used. Otherwise, it will be created. |
|                       | ssl | Database connection type  | Specify if you database connection has to be http or https. Default value is **false** (http). Make sure that the database port is also configured for the same connection mode |
|                       | driverPvc | Persistent Volume Claim to access the JDBC Database Driver| Specify the name of the persistent volume claim that hosts the JDBC database driver. Required if the database type selected is not DB2 |
|                       | adminCredentialsSecret | MFPServer DB Admin Secret | If you have enabled DB initialization ,then provide the secret to create database tables and schemas for Mobile Foundation components. |
| mfpserver | adminClientSecret | Admin client secret | Specify the Client Secret name created. Refer [here](#optional-creating-secrets-for-confidential-clients)  |
|  | pushClientSecret | Push client secret | Specify the Client Secret name created. Refer [here](#optional-creating-secrets-for-confidential-clients) |
|  | liveupdateClientSecret | LiveUpddate client secret | Specify the Client Secret name created. Refer [here](#optional-creating-secrets-for-confidential-clients) |
| mfpserver.replicas |  | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: **3**) |
| mfpserver.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicas field. | **false** (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to **1**) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than min. | Positive integer (default to **10**) |
|           | targetCPUUtilizationPercentage | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to **50**) |
| mfpserver.pdb     | enabled | Specifu whether to enable/disable PDB. | **true** (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
|    mfpserver.customConfiguration |  |  Custom server configuration (Optional)  | Provide server specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration)|
| mfpserver | keystoreSecret | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords.|
| mfpserver.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is **2000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is **1536Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | enabled          | Flag to enable Mobile Foundation Push | **true** (default) or false |
|           | repository   | Docker image repository |Repository of the Mobile Foundation Push docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description |
| mfppush.replicas | | The number of instances (pods) of Mobile Foundation Server that need to be created | Positive integer (Default: **3**) |
| mfppush.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | **false** (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to **1**) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to **10**) |
|           | targetCPUUtilizationPercentage | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to **50**) |
| mfppush.pdb     | enabled | Specifu whether to enable/disable PDB. | **true** (default) or false |
|           | min  | minimum available pods | Positive integer (default to 1) |
| mfppush.customConfiguration |  |  Custom configuration (Optional)  | Provide Push specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration) |
| mfppush | keystoresSecretName | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords.|
| mfppush.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is **750m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is **1024Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpliveupdate | enabled          | Flag to enable Liveupdate | **false** (default) or true |
| mfpliveupdate.image | repository          | Docker image repository | Repository of the Mobile Foundation Live Update  docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description. |
|           | consoleSecret | A pre-created secret for login | Refer [here](#optional-creating-custom-defined-console-login-secrets).|
| mfpliveupdate.db | type          | Supported database vendor name | **DB2** (default) / MySQL / Oracle |
|  | host          | IP address or hostname of the database where Mobile Foundation Server tables need to be configured. |  |
|  | port          | Database Port number. |  |
|  | secret          | A pre-created secret, which has database credentials. |  |
|  | name          | Name of the Mobile Foundation Server database. |  |
|  | schema          | Server db schema to be created. | If the schema is already present, it will be used. Otherwise, it will be created. |
|  | ssl          | Database connection type. | Specify if you database connection has to be http or https. Default value is **false** (http). Make sure that the database port is also configured for the same connection mode. |
|  | driverPvc          | Persistent Volume Claim to access the JDBC Database Driver. | Specify the name of the persistent volume claim that hosts the JDBC database driver. Required, if the database type selected is not DB2. |
|  | adminCredentialsSecret          | MFPServer DB Admin Secret. | If you have enabled DB initialization ,then provide the secret to create database tables and schemas for Mobile Foundation components. |
| mfpliveupdate.replicas |   | The number of instances (pods) of Mobile Foundation Liveupdate that need to be created. | Positive integer (Default: **2**. |
| mfpliveupdate.autoscaling | enabled  | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicas field. | **false** (default) or true. |
|  | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (defaults to **1**). |
|  | max  | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than min. | Positive integer (defaults to **10**). |
|  | targetcpu  | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(defaults to **50**). |
| mfpliveupdate.pdb | enabled  | Specify whether to enable/disable PDB. | **true** (default) or false. |
|  | min  | minimum available pods | Positive integer (defaults to **1**). |
| mfpliveupdate.customConfiguration |   | Custom server configuration (Optional). | Provide server specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration). |
| mfpliveupdate | keystoreSecret          | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords. |  |
| mfpliveupdate.resources | limits.cpu  | Describes the maximum amount of CPU allowed. | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory  | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value. | Default is **750m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory  | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| mfpanalytics | enabled          | Flag to enable analytics | **false** (default) or true |
| mfpanalytics.image | repository          | Docker image repository | Repository of the Mobile Foundation Operational Analytics docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Refer [here](#optional-creating-custom-defined-console-login-secrets)|
| mfpanalytics.replicas |  | The number of instances (pods) of Mobile Foundation Operational Analytics that need to be created | Positive integer (Default: **2**) |
| mfpanalytics.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | **false** (default) or true |
|           | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to **1**) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to **10**) |
|           | targetCPUUtilizationPercentage | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to 50) |
|  mfpanalytics.shards|  | Number of Elasticsearch shards for Mobile Foundation Analytics | default to 2|             
|  mfpanalytics.replicasPerShard|  | Number of Elasticsearch replicas to be maintained per each shard for Mobile Foundation Analytics | default to **2**|
| mfpanalytics.persistence | enabled         | Use a PersistentVolumeClaim to persist data                        | **true** |                                                 |
|            |useDynamicProvisioning      | Specify a storageclass or leave empty  | **false**  |                                                  |
|           |volumeName| Provide an volume name  | **data-stor** (default) |
|           |claimName| Provide an existing PersistentVolumeClaim  | nil |
|           |storageClassName     | Storage class of backing PersistentVolumeClaim | nil |
|           |size             | Size of data volume      | 20Gi |
| mfpanalytics.pdb     | enabled | Specify whether to enable/disable PDB. | **true** (default) or false |
|           | min  | minimum available pods | Positive integer (default to **1**) |
|    mfpanalytics.customConfiguration |  |  Custom configuration (Optional)  | Provide Analytics specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration |
| mfpanalytics | keystoreSecret | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords.|
| mfpanalytics.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is **750m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics_recvr | enabled          | Flag to enable Analytics Receiver | **false** (default) or true |
| mfpanalytics_recvr.image | repository          | Docker image repository | Repository of the Mobile Foundation Live Update  docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description. |
| mfpanalytics_recvr.replicas |   | The number of instances (pods) of Mobile Foundation Analytics Receiver that needs to be created. | Positive integer (Default: **1**. |
| mfpanalytics_recvr.autoscaling | enabled  | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | **false** (default) or true. |
|  | min  | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (defaults to **1**). |
|  | max  | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than min. | Positive integer (defaults to **10**). |
|  | targetcpu  | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(defaults to **50**). |
| mfpanalytics_recvr.pdb | enabled  | Specify whether to enable/disable PDB. | **true** (default) or false. |
|  | min  | minimum available pods | Positive integer (defaults to **1**). |
| mfpanalytics_recvr | analyticsRecvrSecret     | A pre-created secret for receiver. |  |
| mfpanalytics_recvr.customConfiguration | analyticsRecvrSecret     | Custom configuration (Optional). | Provide Analytics specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration). |
| mfpanalytics_recvr | keystoreSecret     | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords. |  |
| mfpanalytics_recvr.resources | limits.cpu  | Describes the maximum amount of CPU allowed. | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | limits.memory  | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
|  | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value. | Default is **750m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu). |
|  | requests.memory  | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is 1024Mi. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory). |
| mfpappcenter | enabled          | Flag to enable Application Center | **false** (default) or true |  
| mfpappcenter.image | repository          | Docker image repository | Repository of the Mobile Foundation Application Center docker image. Make sure the placeholder REPO_URL is replaced with right docker registry url. |
|           | tag          | Docker image tag | See Docker tag description |
|           | consoleSecret | A pre-created secret for login | Refer [here](#optional-creating-custom-defined-console-login-secrets)|
|  mfpappcenter.db | type | Supported database vendor name. | **DB2** (default) / MySQL / Oracle |
|                   | host | IP address or hostname of the database where Appcenter database needs to be configured	| |
|                       | port | 	Port of the database  | |             
|                       | name | Name of the database to be used | The database has to be precreated.|
|                       | secret | A precreated secret which has database credentials| |
|                       | schema | Application Center database schema to be created. | If the schema already exists, it will be used. If not, one will be created. |
|                       | ssl |Database connection type  | Specify if you database connection has to be http or https. Default value is **false** (http). Make sure that the database port is also configured for the same connection mode |
|                       | driverPvc | Persistent Volume Claim to access the JDBC Database Driver| Specify the name of the persistent volume claim that hosts the JDBC database driver. Required if the database type selected is not DB2 |
|                       | adminCredentialsSecret | Application Center DB Admin Secret | If you have enabled DB initialization, then provide the secret to create database tables and schemas for Mobile Foundation components |
| mfpappcenter.autoscaling     | enabled | Specifies whether a horizontal pod autoscaler (HPA) is deployed. Note that enabling this field disables the replicaCount field. | **false** (default) or true |
|           | min | Lower limit for the number of pods that can be set by the autoscaler. | Positive integer (default to **1**) |
|           | max | Upper limit for the number of pods that can be set by the autoscaler. Cannot be lower than minReplicas. | Positive integer (default to **10**) |
|           | targetCPUUtilizationPercentage | Target average CPU utilization (represented as a percentage of requested CPU) over all the pods. | Integer between 1 and 100(default to **50**) |
| mfpappcenter.pdb     | enabled | Specifu whether to enable/disable PDB. | **true** (default) or false |
|           | min  | minimum available pods | Positive integer (default to **1**) |
| mfpappcenter.customConfiguration |  |  Custom configuration (Optional)  | Provide Application Center specific additional configuration reference to a pre-created config map. Refer [here](#optional-custom-server-configuration) |
| mfpappcenter | keystoreSecret | Refer the [configuration section](#optional-creating-custom-keystore-secret-for-the-deployments) to pre-create the secret with keystores and their passwords.|
| mfpappcenter.resources | limits.cpu  | Describes the maximum amount of CPU allowed.  | Default is **1000m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  | limits.memory | Describes the maximum amount of memory allowed. | Default is **2048Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           | requests.cpu  | Describes the minimum amount of CPU required - if not specified will default to limit (if specified) or otherwise implementation-defined value.  | Default is **750m**. See Kubernetes - [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           | requests.memory | Describes the minimum amount of memory required. If not specified, the memory amount will default to the limit (if specified) or the implementation-defined value. | Default is **1024Mi**. See Kubernetes - [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

## [OPTIONAL] Creating Custom Defined Console Login secrets

By default, the console login secrets for all the mobile foundation components are created automatically during the deployment. Optionally one can choose to create **Login Secret** to access Server, Analytics and Application Center console explictly. Following is the example.

For Server,

```bash
kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
```

For Analytics,

```bash
kubectl create secret generic analyticslogin --from-literal=MFPF_ANALYTICS_ADMIN_USER=admin --from-literal=MFPF_ANALYTICS_ADMIN_PASSWORD=admin
```

For Analytics receiver,

```bash
kubectl create secret generic analytics_recvrsecret --from-literal=MFPF_ANALYTICS_RECVR_USER=admin --from-literal=MFPF_ANALYTICS_RECVR_PASSWORD=admin
```

For Application Center,

```bash
kubectl create secret generic appcenterlogin --from-literal=MFPF_APPCNTR_ADMIN_USER=admin --from-literal=MFPF_APPCNTR_ADMIN_PASSWORD=admin
```

> NOTE: If these secrets are not provided, they are created with default username and password of admin/admin during the installation of Mobile Foundation.

## [OPTIONAL] Creating TLS secret for ingress configuration

Mobile Foundation components can be configured with hostname based Ingress for external clients to reach them using hostname. The Ingress can be secured by using a TLS private key and certificate. The TLS private key and certificate must be defined in a secret with key names `tls.key` and `tls.crt`.

The secret **mf-tls-secret** is created in the same namespace as the Ingress resource by using the following command.

```
kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
```

The name of the secret is then provided in the field *global.ingress.secret* in the custom resource configuration yaml.

## [OPTIONAL] Creating custom keyStore secret for the deployments

You can provide your own keystore and truststore to Server, Push, Analytics and Application Center deployment by creating a secret with your own keystore and truststore.

Pre-create a secret with `keystore.jks` and `truststore.jks` along with keystore and trustore password using the literals KEYSTORE_PASSWORD and TRUSTSTORE_PASSWORD  provide the secret name in the field keystoreSecret of respective component.

Below is an example of creating keystore secret for the server deployment using  `keystore.jks`, `truststore.jks` and set their passwords.
```
kubectl create secret generic server-secret --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
```

> NOTE: The names of the files and literals should be the same as mentioned in command above.	Provide this secret name in `keystoresSecretName` input field of respective component to override the default keystores when configuring the helm chart.


## [OPTIONAL] Creating secrets for confidential clients

Mobile Foundation Server is predefined with confidential clients for Admin Service. The credentials for these clients are provided in the `mfpserver.adminClientSecret` and `mfpserver.pushClientSecret` fields.

These secrets can be created as follows:

```
kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin

kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
```

If the values for these fields `mfpserver.pushClientSecret`, `mfpserver.adminClientSecret` and `mfpserver.liveupdateClientSecret` are not provided during helm chart installation, default client secrets are created respectively with below credentials as follows:

* `admin / nimda` for `mfpserver.adminClientSecret`
* `push / hsup` for `mfpserver.pushClientSecret`
* `liveupdate / etadpuevil` for `mfpserver.liveupdateClientSecret`

## [OPTIONAL] Custom Server Configuration

To customise the configuration (example: modifying a log trace setting, adding a new jndi property and so on), you will have to create a configmap with the configuration XML file. This allows you to add a new configuration setting or override the existing configurations of the Mobile Foundation components.

The custom configuration is accessed by the Mobile Foundation components through a configMap (mfpserver-custom-config) which can be created as follows -

```
kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
```

The configmap created using the above command should be provided in the **Custom Server Configuration** in the Helm chart while deploying Mobile Foundation.

Below is an example of setting the trace log specification to warning (The default setting is info) using mfpserver-custom-config configmap.

- Sample config XML (logging.xml)

```
<server>
        <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
        maxFileSize="20" />
</server>
```

- Creating configmap and add the same during the helm chart deployment

```
kubectl create configmap mfpserver-custom-config --from-file=logging.xml
```

- Notice the change in the messages.log (of Mobile Foundation components) - ***Property traceSpecification will be set to com.ibm.mfp.=debug:\*=warning.***

## [OPTIONAL] Using custom generated LTPA keys

By default, the images of Mobile Foundation bundles a set of `ltpa.keys` for each Mobile Foundation component. In production environment, when there is a need to update the out-of-the-box `ltpa.keys` with custom generated ones, you can use custom configuration to add any custom generated `ltpa.keys` along with the config xml.

Following is the config sample `ltpa.xml`.

```xml
<server description="mfpserver">
    <ltpa
        keysFileName="ltpa.keys" />
    <webAppSecurity ssoUseDomainFromURL="true" />
</server>
```

The following command is an example of adding the custom LTPA keys.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys
```

For more details about the LTPA keys generation and other details, refer to the [Liberty documentation](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ltpa.html).

**Note:** Having multiple custom-configmaps is not supported for adding custom configuration, instead it is recommended to create the custom configuration *configmap* as follows.

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys --from-file=moreconfig.xml
```
