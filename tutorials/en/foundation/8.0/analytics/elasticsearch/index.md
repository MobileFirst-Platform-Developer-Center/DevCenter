---
layout: tutorial
title: Elasticsearch
breadcrumb_title: Elasticsearch
relevantTo: [ios,android,javascript]
weight: 3
---

## Overview
MobileFirst Operational Analytics uses  **Elasticsearch 1.5x** for storing data and running search queries.  

Elasticsearch is a real-time distributed search and analytics engine that increases the speed and scale rates for data storage and exploration. Elasticsearch is used for full-text search, structured search.

Elasticsearch is used for storing all mobile and server data in JSON format in the MobileFirst Operational Analytics server in Elasticsearch instances.

The Elasticsearch instances are queried in real-time to populate the MobileFirst Operational Analytics Console.

MobileFirst Operational Analytics exposes all Elasticsearch functionality. The user is able to take full advantage of Elasticsearch queries, debugging, and optimization.

For more information about Elasticsearch functionality, beyond the functionality described here, see the  [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).


## Managing Elasticsearch on the MobileFirst Analytics Server

Elasticsearch is embedded in the MobileFirst Analytics Server and participates in the node and cluster behavior.

> For more information on configuring Elasticsearch on the Analytics Server, see [Cluster management and Elasticsearch](../../installation-configuration/production/analytics/configuration/#cluster-management-and-elasticsearch).


## Elasticsearch properties
Elasticsearch properties are available through JNDI variables or environment entries.  
One of the more useful JNDI properties to get started with viewing the Elasticsearch data is:

 ```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
 ```

 This JNDI property allows you to view your Operational Analytics raw data in JSON format and to access your Elasticsearch instance through the port that is defined by Elasticsearch. The default port is 9500.

> **Note**: This setting is not secure and should not be enabled on a production environment.

### Elasticsearch REST API
Being able to access an Elasticsearch instance provides the ability to run custom queries, and view more detailed information about the Elasticsearch cluster.

**Search and view data**

You can view all your data by visiting the tenant's `_search` REST endpoint.  


```
http://localhost:9500/*/_search
```

**View cluster health**

```
http://localhost:9500/_cluster/health
```

**View information on current nodes**

```
http://localhost:9500/_nodes
```

**View the current mappings**

```
http://localhost:9500/*/_mapping
```

> Elasticsearch exposes many more REST endpoints. To learn more, visit the [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).
