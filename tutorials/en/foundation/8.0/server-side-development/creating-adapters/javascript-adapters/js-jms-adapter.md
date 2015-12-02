---
layout: tutorial
title: JavaScript JMS Adapter
relevantTo: [ios,android,windowsphone8,windows8,cordova]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JavaScriptAdapters
---

### Overview
Java Message Service (JMS) is the standard messaging Java API.  
With a JMS adapter, you can read and write messages from any messaging provider that supports the API.

>WebSphere Application Server Liberty profile included with IBM MobileFirst™ Platform Foundation does not contain the built-in Liberty JMS features. JMS is supported by the WebSphere Application Server Liberty profile V8.5 ND (Network Deployment) server. Look for "Enabling JMS" in the documentation for WebSphere Application Server.

### Enable JMS in Server.xml

Enable JMS on your Liberty profile ND server:
```xml
<!-- Enable features -->
<featureManager>
  <feature>jsp-2.2</feature>
  <feature>wasJmsServer-1.0</feature>
  <feature>wasJmsClient-1.1</feature>
  <feature>jndi-1.0</feature>
</featureManager>
```
### Connection properties
Connection properties are configured in the adapter XML file.

* `namingConnection` – Necessary only if you are using an external JNDI (Java™ Naming and Directory Interface) repository.
 * `url` - The URL to the JNDI repository.
 * `initialContextFactory` - The `classname` for the factory that is used for the configuration of JNDI properties.
 * `user, password` - The credentials as set up by the JNDI administrator.
* `jmsConnection`
 * `connectionFactory` - The `classname` for the JMS connection factory that contains JMS configuration properties.
 * `user, password` - The credentials as set up by the JNDI administrator.

<span style="color:red"> highlight=7,8,9,10,11,12,13,14,15,16,17,18 </span>

```xml
<wl:adapter name="JMSAdapter" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wl="http://www.ibm.com/mfp/integration" xmlns:jms="http://www.ibm.com/mfp/integration/jms">

  <displayName>JMSAdapter</displayName>
  <description>JMSAdapter</description>
  <connectivity>
    <connectionPolicy xsi:type="jms:JMSConnectionPolicyType">
      <namingConnection
        url="tcp://9.148.225.169:61616"
        initialContextFactory="org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        user="admin"
        password="admin"
        />

      <jmsConnection
        connectionFactory="ConnectionFactory"
        user="admin"
        password="admin"
        />
    </connectionPolicy>
  </connectivity>

  <procedure name="writeMessage" />
  <procedure name="readMessage" />
  <procedure name="readAllMessages" />
</wl:adapter>
```
Copy the relevant external libraries to the project for it to use JMS classes.  
If you use **Apache ActiveMQ**, copy the `activemq-all-activemq_version_number.jar` file to the `server\lib` directory.

### JMS API
* `WL.Server.readSingleJMSMessage` - Reads a single message from the given destination.
* `WL.Server.readAllJMSMessages` - Reads all messages from the given destination.
* `WL.Server.writeJMSMessage` - Writes a single JMSText message to the given destination.
* `WL.Server.requestReplyJMSMessage` - Writes a single JMSText message to the given destination and waits for the response.

#### readMessage
This method gets the next message from the destination.  
It waits for timeout in milliseconds and returns a JMS message that contains the `body` and all available properties.

```js
function readMessage() {
    var result = WL.Server.readSingleJMSMessage({
      destination: "dynamicQueues/MobileFirst",
      timeout: 60
    });

    return result;  
}
```

Result:  
![jms_readmessage_result](jms_readmessage_result.png)

#### readAllJMSMessages
This method takes the same parameters as the `readSingleJMSMessage` method.  
It returns a list of JMS messages in the same format as the `readSingleJMSMessage` method. The result is contained in a `messages` object.

To use this method, use an external server.

Result:  
![jms_readalljmsmessages_result](jms_readalljmsmessages_result.png)

#### writeMessage
This method writes a JMSText message to the destination. It features user properties that can be set. The `destination` parameter is the target for messages that are produced by the client, and the source for the messages that are used by the client.  
It returns the `JMSMessageID` of the sent message.

```js
function writeMessage(messagebody) {

  var inputData = {
    destination: "dynamicQueues/MobileFirst",
    message:{      
      body: messagebody,
      properties:{
        MY_USER_PROPERTY:123456
      }
    }
  };

  return WL.Server.writeJMSMessage(inputData);
}
```

Result:

![jms_writemessage_result](jms_writemessage_result.png)

#### requestReplyJMSMessage
This method:

* Accepts the same parameters as the `writeJMSMessage` method.
* Writes a JMSText message to the destination.
* Waits for a response on a dynamic destination.
* Is designed for services that use the `replyTo` destination from the originating message.
* Returns a JMS message in the same format as the `readSingleJMSMessage` method.

### Configurations for external JMS providers
By using IBM MobileFirst Platform, you can configure access to several JMS providers. Configurations might vary depending on the selected provider.

When you work with an external JMS provider, check its documentation to learn how to implement it.  
Usually, such implementation requires that you copy JAR files to the `server\lib` directory of your MobileFirst project. Validate the URL and port.

### Sample application
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/JavaScriptAdapters) the MobileFirst project.  

By using the attached sample, you can send and read messages to a JMS queue called `MobileFirst`. To run the sample, you need an external JMS library.
