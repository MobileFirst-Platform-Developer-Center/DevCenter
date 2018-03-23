---
layout: tutorial
title: REST API for the MobileFirst Server administration service
breadcrumb_title: Administration service
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The REST API provides several services to administer runtime adapters, applications, devices, audit, transactions, security, and push notifications.

The REST service API for adapters and applications for each runtime is in **/management-apis/2.0/runtimes/runtime-name/**, where runtime-name is the name of the runtime that is administered through the REST service. Then, the type of object addressed by the service is identified, together with the appropriate method. For example, **/management-apis/2.0/runtimes/runtime-name/Adapters (POST)** refers to the service for deploying an adapter.

## API Reference
{: #api-reference }
<iframe frameBorder="1" border="1" width="100%" height="500px" src="../../../../../../../../api-ref/rest-admin-api-docs/html/refrest-admin-service-api-docs/html/overview.html"></iframe>
