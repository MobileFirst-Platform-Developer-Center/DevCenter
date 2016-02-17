---
layout: tutorial
title: Mobile Device Analytics
weight: 7
---

Collecting Analytics has become simpler and more customizable since Operational Analytics 7.1. To start collecting analytics in Operational Analytics 8.0 all you have to do is call the initialize method of the analytics API.

### App Sessions
In Operational Analytics 7.1 sessions were a bit confusing and difficult to collect. Sessions were based on either OAuth Token based sessions (Session Independent Mode) or HTTP Sessions (Session Dependent Mode). In Operational Analytics 8.0 we no longer collect sessions based off how the MobileFirst runtime server, sessions are now recorded off foreground background events.

To record a session in Operational Analytics 8.0 it is first needed to make sure that the Analytics API has been initialized. After initializing the Analytics API, open your app, then move it to the background. That process is considered on full session. A session will not be recorded when the app is moved to the foreground, to log a full session the app also needs to be moved to the background.

**Note:** You still will not see sessions in the Operational Analytics Console, to send recorded events you will still need to use the send method.

### Devices
When you first call the Analytics API send method devices will start to populate the Analytics console. Device information is collected out of the box. Information that is recorded is data like Device ID, Operating System, Model, etc.

### Network

### Crashes
App crashes is also collected out of the box. However, app crashes will not be 


### Server logs
To start collecting server logs the server environment variable for `log.forward` has to be set to true on the MobileFirst Runtime console. This will collect server logs at the log level specified in the MobileFirst Runtime Console.

**Note:** Collecting at the level `FINEST` and not setting a time to live value on server logs is going to fill your Analytics server up with a lot of logging information. The more data you have in the Operational Analytics Data Store the slower your console is going to be.
