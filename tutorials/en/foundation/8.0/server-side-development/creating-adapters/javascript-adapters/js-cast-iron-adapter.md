---
layout: tutorial
title: JavaScript Cast Iron Adapter
relevantTo: [ios,android,windowsphone8,windows8,cordova]
---
### Overview

IBM WebSphere Cast Iron enables companies to integrate applications, whether the applications are located on-premises or in public or private clouds.
WebSphere Cast Iron provides an approach to integrating applications that does not require any programming knowledge.
You can build integration flows in WebSphere Cast Iron Studio, which is a graphical development environment that is installed on a personal computer.
With Cast Iron Studio, you create an integration project that contains one or more orchestrations. Each orchestration is built with a number of activities that define the flow of data.
IBM MobileFirst Platform Foundation provides a **Cast Iron Adapter** type to integrate with WebSphere Cast Iron.
A MobileFirst Cast Iron adapter initiates orchestrations in Cast Iron to retrieve and return data to mobile clients.

**Prerequisite:** Make sure to read the [JavaScript Adapters](../) tutorial first.

![castiron](castiron.jpg)

>For more information about Cast Iron, see:  
[http://www.redbooks.ibm.com/redpapers/pdfs/redp4840.pdf](http://www.redbooks.ibm.com/redpapers/pdfs/redp4840.pdf)  
[http://www.redbooks.ibm.com/abstracts/sg248004.html?Open](http://www.redbooks.ibm.com/abstracts/sg248004.html?Open)

### JavaScript implementation
To invoke a Cast Iron request, use the `WL.Server.invokeCastIron` API method. Provide an input parameters object with the following properties:

* `method`: the HTTP method (`get` or `post`)  
* `appName`: the application name  
* `requestType`: the request type  
* `path`: the service path  
* `returnedContentType`: the returned content type (`XML`, `JSON`, `HTML`, or `plain`)  
* `transformation` (optional): applies transformation filters to the received data

```js
function startOrchestration(orchestrationName) {

  var input = {
    method: 'get',
    appName: 'myApp',
    requestType: 'http',
    path: orchestrationName,
    returnedContentType: 'xml',
    transformation: {
      type: 'xslFile',
      xslFile: 'ci-filtered.xsl'
    }

  };
  return WL.Server.invokeCastIron(input);
}
```

>For a complete list of invocation options, see the MobileFirst user documentation about adapter files.
