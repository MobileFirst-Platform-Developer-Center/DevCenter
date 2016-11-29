---
title: Sessions in MobileFirst Platform Foundation 7.1 Operational Analytics
date: 2016-03-29
tags:
- MobileFirst_Platform
- Analytics
version:
- 7.1
author:
  name: Theodora Cheng
---
When do sessions show up in the MobileFirst Platform Foundation 7.1 Operational Analytics console?

The Analytics server reports sessions on the analytics console as a combined metric of unique HTTP session cookies and tokens issued from the server. So, whenever a **new HTTP session** is created at the MFP server or a **new token** is issued, the value in the "sessions" metric box is incremented.

Starting in MFP 7.0, there is the option to configure an MFP app in session dependent mode or independent mode (default). 
Please see the documentation regarding this configuration <a href="https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/devref/c_overview_session_indep.html">here</a>.

In this blogpost, we will be exploring the various topics:
<ul>
<li><a href="#indepMode">How to Get Sessions in Independent Mode</a></li>
<li><a href="#depMode">How to Get Sessions in Dependent Mode</a></li>
<li><a href="#custAnalytics">How to Get Sessions Using Custom Analytics</a></li>
</ul>

<h2 id="indepMode">How to Get Sessions in Independent Mode</h2>
In the `worklight.properties` file, configure the following attributes:
```javascript
mfp.session.independent=true
mfp.attrStore.type=database
```

Now if you call `WL.Client.connect`, your sessions will not increment by 1. This is because in independent mode, session count increases when a protected resource is invoked and an OAuth token is issued from the server. Please see our "Authentication and security" section in our Getting Started Tutorials to see how to protect your application or adapters.

For example, if you create a java adapter "javaAdapter" with the following code in the `JavaAdapterResource.java` file:

```java
@Path("/users")
public class JavaAdapterResource {
	@GET
	@Path("/getHello")
	public String getHello(){
		return "hello";
	}
		
}
```

Then if you call WLResourceRequest like below, the session count will increase on the first resource request as a new token was issued from the server. 
`var req = new WLResourceRequest("/adapters/javaAdapter/users/getHello", WLResourceRequest.GET).send();`

Session count will not increase again until the token expires, a protected resource is called, and a new token is issued from the server. As you can see in the screenshot below, the session count does not increase with every adapter call.

![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-29-at-11.33.22-AM.png)

<h2 id="depMode">How to Get Sessions in Dependent Mode</h2>
In the `worklight.properties` file, configure the following attributes:
```javascript
mfp.session.independent=false
mfp.attrStore.type=httpSession
```

In session dependent mode, the session count will increase every time the server issues an HTTP cookie or OAuth token.

When you call `WL.Client.connect`, your sessions will increment by 1 like below and a HTTP cookie will be created.

![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-28-at-4.46.46-PM.png)

However, it is also important to note that if you have a javascript or java adapter and call WLResourceRequest before the HTTP cookie expires, the session count will also be incremented in the analytics session box and a token will be issued from the server.

For example, if you create an HTTP adapter "testAdapter" with a procedure "testProcedure" and then do a WLResourceRequest like below, the session count will increase on the first resource request as a new token was issued from the server.
`var req = new WLResourceRequest("/adapters/testAdapter/testProcedure", WLResourceRequest.GET).send();`

![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-28-at-4.52.07-PM.png)

However if you call WLResourceRequest again before the token from the server expires, the session count will not increase.

![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-28-at-4.52.36-PM.png)

<h2 id="custAnalytics">How to Get Sessions Using Custom Analytics</h2>

If your organization has a different definition for what a session is, you can also use custom analytics to count sessions.
For example, your definition of a session could be every time a user logs into your app.

By placing the following code on the event of a successful log in, you could then create a custom "session" event that logs every time a user successfully logs in. *(Following code snippet is for a hybrid app)*
```javascript
WL.Analytics.log({session: "session"}, "successfully logged in");
WL.Analytics.send() //required to send log to the analytics server
```

Then, if you go to the analytics dashboard, you can create different types of custom charts to view number of sessions.

<h3>Total Sessions</h3>
Event Type: Custom Data / Chart Type: Metric Group / Measure: Total / Add Filter Property: Session
![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-29-at-11.58.08-AM.png)

<h3>Session via Timeline</h3>
Event Type: Custom Data / Chart Type: Bar Group / X-Axis: Axis By Timeline / Y-Axis: Total /Add Filter Property: Session
![screen shot]({{site.baseurl}}/assets/blog/2016-03-29-sessions-in-mfp-7-1-analytics/Screen-Shot-2016-03-29-at-11.58.13-AM.png)
