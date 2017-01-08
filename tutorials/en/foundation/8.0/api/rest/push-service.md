---
layout: tutorial
title: REST API for the MobileFirst Server push service
breadcrumb_title: Push service
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
The REST API for Push in the {{ site.data.keys.product_adj }} runtime environment enables back-end server applications that were deployed outside of the {{ site.data.keys.mf_server }} to access Push functions from a REST API endpoint.

The Push service on the {{ site.data.keys.mf_server }} is exposed over a REST API endpoint that can be directly accessed by non-mobile clients. You can use the REST API runtime services for Push for registrations, subscriptions, messages, and retrieving tags. Paging and filtering is supported for database persistence in both Cloudant® and SQL.

This REST API endpoint is protected by OAuth which requires the clients to be confidential clients and also possess the required access scopes in their OAuth access tokens that is passed by a designated HTTP header.