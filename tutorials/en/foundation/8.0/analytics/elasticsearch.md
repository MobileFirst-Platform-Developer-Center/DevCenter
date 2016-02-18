---
layout: tutorial
title: Elastic search
weight: 6
---
## Overview
Behind the scenes running search queries and storing data for Operational Analytics is **Elasticsearch 1.5x**.  
Elasticsearch is a real-time distributed search and analytics engine. Elasticsearch allows you to explore your data at a speed and at a scale never before possible. Elasticsearch is used for full-text search, structured search. You can read more about Elasticsearch and look through the documentation [here](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).

Elasticsearch is used for storing all mobile and server data in JSON format on the Analytics server in Elasticsearch instances. When the instances are queried, in real-time in order to populate the analytics console.

Operational Analytics does not hide any Elasticsearch functionality from the user. If the user knows how to fully utilize Elasticsearch, debug Elasticsearch, or optimize Elasticsearch instances Operational Analytics lets the user do so. The user can also access all the Elasticsearch properties through JNDI variables or environment entries.

One of the more useful JNDI properties to get started viewing the Elasticsearch data is:

 ```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
 ```

>**Note**: This is not secure and should not be enabled on a production environment.

 This JNDI property will allow you to view your Operational Analytics raw data in JSON format and allow you to access your Elasticsearch instance through the port defined by Elasticsearch (default port 9500).

You can view all your data by visiting the tenant's search REST endpoint. An example below:

```
http://localhost:9500/*/_search
```

 Being able to access your Elasticsearch instance gives you the ability to run custom queries and view more detailed information about the Elasticsearch cluster.

 View your cluster health:

 ```
http://localhost:9500/_cluster/health
```

View information on your current nodes:

```
http://localhost:9500/_nodes
```

View the current mappings in analytics:

```
http://localhost:9500/*/_mapping
```

Elasticsearch exposes many more REST endpoints. To continue learning more about querying or learning more about  Elasticsearch please reference the Elasticsearch documentation.

 > **Note**: We do not support running queries on your data. Do this at your own risk.
