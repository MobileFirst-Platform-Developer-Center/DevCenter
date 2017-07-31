---
layout: tutorial
title: OpenWhisk adapter
breadcrumb_title: OpenWhisk adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

OpenWhisk is a Function-as-a-Service (FaaS) platform that allows the execution of code in a serverless and scalable environment. One of the usecases of the OpenWhisk platform is in the developing and running of serverless Mobile backend code. Learn more about OpenWhisk platform on Bluemix [here](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south).

{{ site.data.keys.product }} adapters are used perform any necessary server-side logic, and to transfer and retrieve information from back-end systems to client applications and cloud services. {{ site.data.keys.product }} now provides an adapter for OpenWhisk functions.

##  OpenWhisk adapter
{: #openwhisk-adapter}

{{ site.data.keys.product_full }} starting with [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) provides an OpenWhisk adapter. This adapter is available to be downloaded and deployed from the **Download Center** in the Mobile Foundation Console.

After you download and deploy the adapter, you should configure it to connect to OpenWhisk.

### Configure adapter to connect to OpenWhisk
{: configure-adapter-connect-openwhisk}

To configure the adapter to connect to OpenWhisk, go to the **Adapter Configuration** page and provide the _**username**_ and _**password**_ from the authorization key of OpenWhisk. The _**username**_ and _**password**_ for OpenWhisk can be obtained by running the following OpenWhisk CLI command:

```bash
./wsk property get --auth KEY
```

The above command returns the authorization key separated by a colon, to the left of the colon is the _**username**_ and to the right of the colon is the _**password**_.

_**username:password**_

The _**username**_ and _**password**_ obtained as above should be provided in the OpenWhisk adapter configuration page, and the configuration should be saved. The client apps can now call the adapter API to invoke the OpenWhisk back-end code.

>To modify the OpenWhisk adapter the adapter source code can be downloaded from this [Github Repo](https://github.com/mfpdev/mfp-extension-adapters).
