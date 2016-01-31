---
layout: tutorial
title: Adapters Overview
relevantTo: [ios,android,windowsphone8,windows8,cordova]
weight: 1
---
## Overview
MobileFirst Adapters are Maven projects that contain server-side code implemented in either Java or JavaScript. Adapters are used to transfer and retrieve information from back-end systems to client applications and cloud services. MobileFirst Server processes the information and handles security. Each adapter has its own isolated sandbox, which runs without knowing about or interrupting other adapter sandboxes. That said, adapters can still communicate with one another by calling API which makes "[adapter mashup](../advanced-adapter-usage-mashup)" possible. 

![adapter_overview](adapter_overview_top.jpg)

### Benefits of using adapters
#### Universality
* Adapters support multiple integration technologies and back-end information systems.

#### Read-only and transactional capabilities
* Adapters support read-only and transactional access modes to back-end systems.

#### Fast development
* Adapters use simple XML syntax and are easily configured with JavaScript API or Java API.

#### Security
* Adapters use flexible authentication facilities to create connections with back-end systems.
* Adapters offer control over the identity of the connected user.

#### Transparency
* Data that is retrieved from back-end applications is exposed in a uniform manner, regardless of the adapter type.  

### Benefits specific to Java adapters
* Ability to fully control the URL structure, the content types, the request and response headers, content and encoding
* Easy and fast development and testing by using the MobileFirst Developer CLI.
* Ability to test the adapter by using a 3rd-party tool such as Postman
* Easy and fast deployment to a running MobileFirst Server instance with no compromise on performance and no downtime
* Security integration with the MobileFirst security model with no additional customization, by using simple annotations in the source code

## JavaScript adapters
JavaScript adapters provide templates for communicating with HTTP and SQL back-ends.  
It provides a set of services, called procedures and mobile apps can call these procedures by issuing AJAX requests.
The procedure retrieves information from the back-end application that returns data in some format:

* If this format is JSON, the MobileFirst Server keeps the data intact.
* Otherwise, the MobileFirst Server automatically converts it to JSON. Alternatively, you can provide an XSL transformation to convert the data to JSON. In this case, the returned content type from the back end must be XML. Then, you can use an XSLT to filter the data.

The JavaScript implementation of the procedure receives the JSON data, performs any additional processing, and returns it to the calling app.

<span style="color:red">UPDATE THE IMAGE</span>
![javascript_adapters](javascript_adapters.jpg)

## Java adapters
Java adapters expose a full REST API to the client and are written in Java. This type of adapter is based on the [JAX-RS 2.0 specification] (https://jax-rs-spec.java.net/nonav/2.0-rev-a/apidocs/index.html).
In Java adapters, it is up to the developer to define the returned content and its format, as well as the URL structure of each resource. The only exception is if the client sending the request supports GZip, then the returned content encoding of the Java adapter is compressed by GZip. All operations on the returned content are done and owned by the developer.

![java-adapter](java-adapter.jpg)

> For more information see the topic about "MobileFirst adapters overview" in the user documentation.

## Tutorials to follow next

* [Learn how to create adapters](../creating-adapters)
* [Learn about Java adapters](../java-adapters)
* [Learn about JavaScript adapters](../javascript-adapters)
* [Develop adapters in IDEs](../developing-adapters/)
* [Testing and debugging adapters](../testing-and-debugging-adapters)
* [Review all Adapters tutorials](../)