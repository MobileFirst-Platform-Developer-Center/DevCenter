---
title: Elasticsearch
---

Behind the scenes running search queries and storing data for Operational Analytics is Elasticsearch 1.5x. Elasticsearch is a real-time distributed search and analytics engine. Elasticsearch allows you to explore your data at a speed and at a scale never before possible. Elasticsearch is used for full-text search, structured search. You can read more about Elasticsearch and look through the documentation [here](https://www.elastic.co/guide/en/elasticsearch/reference/1.5/index.html).

What we use Elasticsearch for is to store all your mobile and server data in JSON format on your Analytics server in an Elasticsearch instances. We then query this data in real-time in order to build the analytics console you see today.

We do not hide any Elasticsearch functionality from the user. If you know how to fully utilize Elasticsearch, debug Elasticsearch, or optimize Elasticsearch instances we let you. You can access all the Elasticsearch properties through JNDI variables or environment entries.

One of the more useful JNDI properties to get started viewing your Elasticsearch data is:

 ```xml
<jndiEntry jndiName="analytics/http.enabled" value="true"/>
 ```   
 This JNDI property will allow you to view your Operational Analytics raw data in JSON format and allow you to access your Elasticsearch instance through port 9500. Being able to access your Elasticsearch instance gives you the ability to run custom queries and view more detailed information about your Elasticsearch instance, if you know how. If you are interested in learning more about querying or learning more about your Elasticsearch instance please reference the Elasticsearch documentation.

 **Note**: We do not support running queries on your data. Do this at your own risk.
