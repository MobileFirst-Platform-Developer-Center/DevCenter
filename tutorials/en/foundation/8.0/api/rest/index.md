---
layout: tutorial
title: REST API Reference
breadcrumb_title: REST API
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
The REST API provides several services to administer runtime adapters, applications, devices, audit, transactions, security, and push notifications.

The REST service API for adapters and applications for each runtime is in **/management-apis/2.0/runtimes/runtime-name/**, where runtime-name is the name of the runtime that is administered through the REST service. Then, the type of object addressed by the service is identified, together with the appropriate method. For example, **/management-apis/2.0/runtimes/runtime-name/Adapters (POST)** refers to the service for deploying an adapter.

