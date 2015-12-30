---
layout: tutorial
title: JavaScript Adapters
show_children: true
relevantTo: [ios,android,windowsphone8,windows8,cordova]
---
## Overview
JavaScript adapters provide templates for connection to HTTP and SQL back-ends. It provides a set of services, called procedures and mobile apps can call these procedures by issuing AJAX requests.


**Prerequisite:** Make sure to read the [Creating Java and JavaScript Adapters](../) tutorial first.

## File structure

<span style="color:red">Image</span>

### The `XML` File
JavaScript adapters have an XML configuration file which describes the connectivity options and lists the procedures that are exposed to the application or other adapters.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<wl:adapter name="HelloWorld">
  <displayName />
  <description />
  <connectivity>
    <connectionPolicy>
    ...

    <loadConstraints>
    ...
  </connectivity>
  <procedure name="procedure1"></procedure>
  <procedure name="procedure2"></procedure>
</wl:adapter>
```
* `name`: Mandatory. The name of the adapter
* `displayName`: Optional. The name that is displayed in the MobileFirst Console
* `description`: Optional. Additional information that is displayed in the MobileFirst Console
* `connectivity`:
 * Defines the connection properties and load constraints of the back-end system.
 * When the back-end system requires user authentication, defines how user credentials are obtained.
* `procedure`: Declares a service for accessing a back-end application. One entry for each adapter procedure.

### The `js` folder
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




<span style="color:red"> ### Using global variables </span>  
Depending on your infrastructure and configuration, your MobileFirst server may be running with `SessionIndependent` set to true, where each request may reach a different node and HTTP sessions are not used. In such cases you should not rely on global variables to keep data from one request to the next.

## For examples of JavaScript adapters communicating with an HTTP or SQL back end, see:
