---
title: Different ways of exporting and importing Mobile Foundation server artifacts
date: 2016-07-25
tags:
- MobileFirst_Foundation
- Mobile Foundation
version:
- 8.0
author:
  name: Rahul Raghuvanshi
additional_authors:
  - Vinod Appajanna
  - Shinoj Zacharias
---
## Overview
In this article we explain how to replicate an existing Mobile Foundation server to a new Mobile Foundation Server. Traditional approach is to run some scripts (.sh/.bat) that will migrate the artifacts from source to destination (db/application). In [Mobile Foundation Service](https://console.bluemix.net/catalog/services/mobile-foundation/) and in [IBM Mobile Foundation 8.0 On-prem](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/) admins/operators can export the artifacts in the form of JSON's and zip and then import it to the fresh Mobile Foundation server. The export or import operations can be done using console or direct REST calls. The various approaches are detailed below.


* [Using Mobile Foundation Operations Console](#using-mobilefirst-console)
* [Using resourceInfos query parameter in REST API](#using-resourceinfos-query-parameter-in-rest-api)
* [Using direct REST end points](#using-direct-rest-end-points)

## Using Mobile Foundation Operations Console
Through Mobile Foundation Opeations Console, only two types of artifacts can be exported. Currently Mobile Foundation Operations Console support, export at application version level and at adapter level.

![export-application]({{site.baseurl}}/assets/blog/2016-07-25-how-to-replicate-mobilefirst-environment/export_application.jpg "Export application version")
<p style="text-align: right;">Export Application Version</p>

---

![export_adapter]({{site.baseurl}}/assets/blog/2016-07-25-how-to-replicate-mobilefirst-environment/export_adapter.jpg "Export adapter")
<p style="text-align: right;">Export Adapter</p>

## Using resourceInfos query parameter in REST API
There is one more way you can export required artifacts, but for that user has to know about the resource-name and resource-types of each artifact.

Use following GET REST endpoint to export artifacts as a compressed file, based on the resource selected in query parameters.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export?resourceInfos={resource-name||resource-type}
```

**Example**

```
curl -X GET -u username:password -o exported.zip “http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export?resourceInfos=com.mfp.test1%24android%241.0%7C%7CAPP_DESCRIPTOR&resourceInfos=sampleAdapter%7C%7CADAPTER_CONTENT”
```

Here url is encoded, so there are two artifacts that will be downloaded in exported.zip file. if you want to use in postman tool, you can use the following decoded url.

```
http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export?resourceInfos=com.mfp.test$android$1.0||APP_DESCRIPTOR&resourceInfos=sampleAdapter||ADAPTER_CONTENT
```

## Using direct REST end points
There are many export REST endpoints are provided in new version, where user can use required endpoint to export set of artifacts
You can use following curl command to export all artifacts:

**Example**

```
curl -X GET -u username:password -o exported.zip "http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/all"
```

Here are the list of available REST endpoints, with GET method:

  Returns a compressed file that contains all or selected deployable binary files for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/all?include={resource-type}
```
  Returns a compressed file that contains all or selected adapter binary files for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/adapters?include={resource-type}
```

  Returns a compressed file that contains all or selected binary files for a specific adapter for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/adapters/{adapter-name}?include={resource-type}
```

Returns a compressed file that contains all or selected application deployable binary files for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/applications?include={resource-type}
```

Returns a compressed file that contains all or selected deployable binary files for a specific application for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/applications/{application-name}?include={resource-type}
```

Returns a compressed file that contains all or selected deployable binary files for a specific application environment for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/applications/{application-name}/{application-env}?include={resource-type}
```
Returns a compressed file that contain all or selected resources for a specific version of an application environment for this runtime.

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/export/applications/{application-name}/{application-env}/{application-version}?include={resource-type}
```

**Note**: Here query parameter *include* is optional, which is used when you want to have more filtering.

## Importing artifacts to new Mobile Foundation Server
Once you have zipped file containing artifacts ready, you can import this zip file to a new Mobile Foundation Server, to have exact replica of the old server. There are two ways to importing artifacts, one is through console, and the other one is through REST API.

* [Importing artifacts from Mobile Foundation Operations Console](#importing-artifacts-from-mobilefirst-console)
* [Importing artifacts using REST API](#importing-artifacts-using-rest-api)
* [Sample for Import](#sample-for-import)


## Importing artifacts from Mobile Foundation Operations console
Currently there are only two options are available i.e. application and adapter.

![import_application_adapter]({{site.baseurl}}/assets/blog/2016-07-25-how-to-replicate-mobilefirst-environment/import_application_adapter.jpg "Import application and adapter")
<p style="text-align: right;">Import application and adapter</p>

## Importing artifacts using REST API
You can use following POST REST endpoint to upload artifacts on your new server:

```
http://{host}:{port}/{context}/management-apis/2.0/runtimes/{runtime-name}/deploy/multi
```

**Curl command**

  ```
curl -X POST -u admin:admin -F file=@/testuser/export_applications_adf_ios_2.zip "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
   ```

## Sample for Import
[Download sample for import](https://github.com/rahulraghuvanshi/Import-Sample)

## Reference
[IBM Mobile Foundation Service](https://console.bluemix.net/catalog/services/mobile-foundation/)

[IBM Mobile Foundation On-prem](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/)

[MobileFirst REST API Overview](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html).

