---
layout: tutorial
title: Advanced adapter usage and mashup
relevantTo: [hybrid]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/AdapterMashup
---
# Overview
Now that basic usage of different types of adapters has been covered, it is important to remember that adapters can be combined to make a procedure that uses different adapters to generate one processed result. You can combine several sources (different HTTP servers, SQL, etc).

In theory, from the client side, you could make several requests successively, one depending on the other.
However, writing this logic on the server side could be faster and cleaner.

This tutorial covers the following topics:

* [JavaScript adapter API](#javascript-adapter-api)
* [Java adapter API](#java-adapter-api)
* [Data mashup example](#data-mashup-example)
* [Sample application](#sample-application)

## JavaScript adapter API
### Calling a JavaScript adapter procedure from a JavaScript adapter
When calling a JavaScript adapter procedure from another JavaScript adapter use the `WL.Server.invokeProcedure(invocationData)` API.
This API is almost identical to its client-side counterpart, it enables you to invoke a procedure on any of your adapters.

The `invocationData` parameter has the same format as the client-side API.
{% highlight javascript %}
WL.Server.invokeProcedure({ adapter : "AcmeBank", procedure : " getTransactions", parameters : [accountId, fromDate, toDate], });
{% endhighlight %}

However, while the client-side `invokeProcedure` uses a success handler, the server-side only returns the result object itself.

> Calling a Java adapter from a JavaScript adapter is not supported

## Java adapter API
### Calling a Java adapter from a Java adapter
When calling an adapter procedure from a Java adapter use the `executeAdapterRequest` API.
This call returns an HttpResponse object.
{% highlight java %}
HttpUriRequest req = new HttpGet(MyAdapterProcedureURL);
org.apache.http.HttpResponse response = api.getAdaptersAPI().executeAdapterRequest(req);
JSONObject jsonObj = api.getAdaptersAPI().getResponseAsJSON(response);
{% endhighlight %}

### Calling a JavaScript adapter procedure from a Java adapter
When calling a JavaScript adapter procedure from a Java adapter use both the `executeAdapterRequest` API and the `createJavascriptAdapterRequest` API that creates an HttpUriRequest to pass as a parameter to the `executeAdapterRequest` call.
{% highlight java %}
HttpUriRequest req = api.getAdaptersAPI().createJavascriptAdapterRequest(AdapterName, ProcedureName, [parameters]);
org.apache.http.HttpResponse response = api.getAdaptersAPI().executeAdapterRequest(req);
JSONObject jsonObj = api.getAdaptersAPI().getResponseAsJSON(response);
{% endhighlight %}

## Data mashup example
The following example shows how to mash up data from 2 data sources, a database table and Yahoo! Weather Service, And to return the data stream to the application as a single object.

In this example we will use 2 adapters:

* Cities Adapter:
  * Extract a list of cities from a “weather” database table.
  * The result contains the list of several cities around the world, their Yahoo! Weather identifier and some description.
* Weather Adapter:
  * Connect to the Yahoo! Weather Service.
  * Extract an updated weather forecast for each of the cities that are retrieved via the Cities adapter.

Afterward, the mashed-up data is returned to the application for display.

![Adapter Mashup Diagram](AdapterMashupDiagram.jpg)

The provided sample in this tutorial demonstrates the implementation of this scenario using 3 different mashup types.  
In each one of them the names of the adapters are slightly different.  
Here is a list of the mashup types and the corresponding adapter names:

1. **JavaScript** adapter -> **JavaScript** adapter
  * Cities adapter   = getCitiesListJS
  * Weather adapter  = getCityWeatherJS
2. **Java** adapter -> **JavaScript** adapter
  * Cities adapter   = getCitiesListJavaToJS
  * Weather adapter  = getCityWeatherJS
3. **Java** adapter -> **Java** adapter
  * Cities adapter   = getCitiesListJava
  * Weather adapter  = getCityWeatherJava

> An example of city list in SQL is provided with the attached sample, under `server/mobilefirstTraining.sql`.
Remember that SQL adapters require a JDBC connector driver, which must be downloaded separately by the developer and added to the `server/lib` folder of the project.

## Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/AdapterMashup) the MobileFirst project.

![Adapter Mashup sample](AdaptersMashupSample.png)
