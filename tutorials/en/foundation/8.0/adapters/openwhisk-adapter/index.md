---
layout: tutorial
title: Cloud Functions adapter
breadcrumb_title: Cloud Functions adapter
relevantTo: [ios,android,cordova]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

> OpenWhisk is now called Cloud Functions.

IBM Cloud Functions is a Function-as-a-Service (FaaS) platform that allows the execution of code in a serverless and scalable environment. One of the usecases of the Cloud Functions platform is in the developing and running of serverless Mobile backend code. Learn more about Cloud Functions platform on Bluemix [here](https://console.bluemix.net/openwhisk/?env_id=ibm:yp:us-south).

{{ site.data.keys.product }} adapters are used perform any necessary server-side logic, and to transfer and retrieve information from back-end systems to client applications and cloud services. {{ site.data.keys.product }} now provides an adapter for Cloud Functions.

##  Cloud Functions adapter
{: #cloud-functions-adapter}

{{ site.data.keys.product_full }} starting with [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) provides an Cloud Functions adapter. This adapter is available to be downloaded and deployed from the **Download Center** in the Mobile Foundation Console.

After you download and deploy the adapter, you should configure it to connect to Cloud Functions.

### Configure adapter to connect to Cloud Functions
{: configure-adapter-connect-cloud-functions}

To configure the adapter to connect to Cloud Functions, go to the **Adapter Configuration** page and provide the _**username**_ and _**password**_ from the authorization key of Cloud Functions. The _**username**_ and _**password**_ for Cloud Functions can be obtained by running the following CLI command:

```bash
./wsk property get --auth KEY
```

The above command returns the authorization key separated by a colon, to the left of the colon is the _**username**_ and to the right of the colon is the _**password**_.

_**username:password**_

The _**username**_ and _**password**_ obtained as above should be provided in the Cloud Functions adapter configuration page, and the configuration should be saved. The client apps can now call the adapter API to invoke the Cloud Functions back-end code.

>To modify the Cloud Functions adapter the adapter source code can be downloaded from this [Github Repo](https://github.com/mfpdev/mfp-extension-adapters).
