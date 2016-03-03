---
layout: tutorial
title: JavaScript Adapters
show_children: true
relevantTo: [ios,android,windowsphone8,windows8,cordova]
weight: 3
---
## Overview
JavaScript adapters provide templates for connection to HTTP and SQL back-ends. It provides a set of services, called procedures and mobile apps can call these procedures by issuing AJAX requests.


**Prerequisite:** Make sure to read the [Creating Java and JavaScript Adapters](../creating-adapters) tutorial first.

## File structure

![mvn-adapter](js-adapter-fs.png)

### The adapter-resources folder  
The `adapter-resources` folder contains an XML configuration file. This configuration file describes the connectivity options and lists the procedures that are exposed to the application or other adapters.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mfp:adapter name="JavaScriptAdapter">

  <displayName>JavaScriptAdapter</displayName>
	<description>JavaScriptAdapter</description>
  <connectivity>
    <connectionPolicy>
    ...

    </connectionPolicy>
  </connectivity>

  <procedure name="procedure1"></procedure>
  <procedure name="procedure2"></procedure>

  <property name="name" displayName="username" defaultValue="John"  />
</mfp:adapter>
```
* `name`: Mandatory. The name of the adapter
* `displayName`: Optional. The name that is displayed in the MobileFirst Console
* `description`: Optional. Additional information that is displayed in the MobileFirst Console
* `connectivity`:
 * Defines the connection properties and load constraints of the back-end system.
 * When the back-end system requires user authentication, defines how user credentials are obtained.
* `procedure`: Declares a service for accessing a back-end application. One entry for each adapter procedure.
* `property`: The **adapter.xml** file can also contain custom properties. The configuration properties elements must always be located *below* the `procedure` elements.

**Note:** The connection properties as well as the custom properties can be overridden in the **MobileFirst Operations Console → Configurations tab** without having to deploy again.

![Console properties](console-properties.png)

**Pull and Push Configurations**

You can pull and push the adapter configurations file found in the **Configuration files tab**. Replace the **DmfpfConfigFile** placeholder with the actual value and run one of the following commands from the root adapter Maven project:

* To **pull** the configurations - `mvn adapter:configpull -DmfpfConfigFile=<path to a file that will store the configuration>`.
* To **push** the configurations - `mvn adapter:configpush -DmfpfConfigFile=<path to a file that the configuration will be taken from>`.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Note:** The file can be of any file extension and if the file does not exist, it will be created.

### The js folder
This folder contains all JavaScript files, which contains the implementation of procedures that are declared in the XML file. It also contains zero, one, or more XSL files, which contain a transformation scheme for retrieved raw XML data.  
Data that is retrieved by an adapter can be returned raw or preprocessed by the adapter itself. In either case, it is presented to the application as a **JSON object**.

## JavaScript adapter procedures
Procedures are declared in XML and are implemented with server-side JavaScript, for the following purposes:

* To provide adapter functions to the application
* To call back-end services to retrieve data or to perform actions

Each procedure that is declared in the adapter XML file must have a corresponding function in the JavaScript file.  
The `WL.Server` API defines a procedure logic in JavaScript.

```javascript
function procedure1(param) {
  return WL.Server.invokeSQLStatement({
    preparedStatement: procedure1Statement,
    parameters: [param]
  });
}
```

By using server-side JavaScript, a procedure can process the data before or after it calls the service. You can apply more filtering to retrieved data by using simple XSLT code.  
JavaScript adapter procedures are implemented in JavaScript. However, because an adapter is a server-side entity, it is possible to [use Java in the adapter](../javascript-adapters/using-java-adapters) code.

### Using global variables
The MobileFirst server does not rely on HTTP sessions and each request may reach a different node. You should not rely on global variables to keep data from one request to the next.

## For examples of JavaScript adapters communicating with an HTTP or SQL back end, see:
