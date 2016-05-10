---
title: Using MFP Adapters as an endpoint for Analytics Alerts webhooks
date: 2015-10-19
tags:
- MobileFirst_Platform
- Analytics
version:
- 7.0
- 7.1
author:
  name: Harrison Wright
---
Alerting in MFP Analytics now allows users to set alerts around their analytics data that will notify them when a threshold has been reached. Currently, these notifications are sent through the analytics console or a configurable webhook. 

Using MFP's adapters, it is extremely simple to create an endpoint to use as a webhook. Creating a <a href="https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-7-1/foundation/server-side-development-category/java-adapter/java-http-adapter/">Java HTTP Adapter</a> makes a callable endpoint at <code>http(s)://{host}:{port}/{ProjectName}/adapters/{AdapterName}/{procedurePath}</code>. When you are creating an alert definition, set the Network Post URL to this using your host, project and adapter information.

Writing your own adapter as a webhook enables you to do whatever you want with the alerting data, such as emailing system administrators, issuing push notifications, or just storing the data in an SQL database.

When an alert is triggered, it will then post the following payload to your adapter:

```xml
{
    'timestamp': 0000000000000,
    'title': 'Title of Alert',
    'message': 'Alert Message', 
    'eventType': 'EventType', 
    'property': 'Property', 
    'condition': {
        'operator': 'Operator',
        'value': 0
    },
    'offenders': {
        'MyApplication 1.0': 0,
        ...
    }
}
```

- **timestamp**: time the notification was issued - 13 digit epoch timestamp in milliseconds
- **title**: title of the alert
- **message**: alert's message
- **eventType**: event type chosen for the alert
- **property**: property chosen for the eventType
- **condition**: condition which must be met for the alert to be triggered
    - condition has two values: operator and value
    - operator will be GT, GTE, LT, LTE, or EQ representing &gt;, &gt;=, &lt;, &lt;=, and == respectively
    - value will be a numeric value to check the operator against
- **offenders**: a map of the offenders which have reached the above condition
    - the key of the map is the offender - depending on the alert that is defined: an application, device or URL may be an offender
    - the value of the map is the actual value which has met the above condition

This is an easy way to setup your Java adapter to receive the POST:

```java
@POST
@Path("/myWebhook")
@Consumes("application/json")
public Response myWebhook(String data) {
    JSONObject json = JSONObject.parse(data);
    ...
}
```

From there it is up to you what you do with this data. Below are examples for how to send this alert as an email or a push notification.

### Email

```java
@POST
@Path("/sendEmail")
@Consumes("application/json")
public Response sendEmail(String data) {
    try {
        JSONObject json = JSONObject.parse(data);

        String from = "adapteremail@domain.com";
        String to = "someone@domain.com";
        String host = "localhost"; // this should be your mail server
    
        // here you will need to extract data from json and construct the desired message subject and body
        String subject = "New Alert: " + json.get("title");
        String body = "";

        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        Session session = Session.getDefaultInstance(properties);

        MimeMessage msg = new MimeMessage(session);
        
        msg.setFrom(new InternetAddress(from));
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(body);
        
        Transport.send(message);

        return Response.ok().build();
    } catch (Exception e) {
        // TODO: log failure
        return Response.status(Status.INTERNAL_SERVER_ERROR)
                .entity("Error sending email.")
                .build();
    }    
}
```

### Push Notification

```java
@POST
@Path("pushNotification")
@Consumes("application/json")
public Response pushNotification(String data) {
    try {
        JSONObject json = JSONObject.parse(data);
        // here you will need to extract data from json and construct the desired alert text
        String alertText = "";

        PushAPI pushApi = ai.getPushAPI();
        INotification noti = pushApi.buildNotification();
        n.getMessage().setAlert(alertText);
        pushApi.sendMessage(noti, "MyApplication");

        return Response.ok().build();
    } catch (Exception e) {
        // TODO: log failure
        return Response.status(Status.INTERNAL_SERVER_ERROR)
                .entity("Error sending push notification.")
                .build();
    }
}
```