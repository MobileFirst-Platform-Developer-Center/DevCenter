---
title: Viewing Analytics Dashboard
---
### Viewing the Analytics Dashboard
The ```wl.analytics.url``` property must be set to send data to the Analytics server and the ```wl.analytics.console.url``` must be set to access the Analytics dashboard.


You can set these two properties in the ```server.xml``` file:
```xml
<jndiEntry jndiName="AppName/wl.analytics.url" value="http://localhost:10080/analytics-service/data"/>;
<jndiEntry jndiName="AppName/wl.analytics.console.url" value="http://localhost:10080/analytics/console"/>
```

After the property is set, the **Analytics Dashboard** link appears in the MobileFirst Operations Console.

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/04/71ConsoleAnalytics.png"><img src="{{ site.baseurl }}/assets/backup/71ConsoleAnalytics.png" alt="71ConsoleAnalytics" width="2570" height="484" class="aligncenter size-full wp-image-13930" /></a>

Click the **Analytics Dashboard** link to open up the dashboard in a new window.

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/04/71AnalyticsSession.png"><img src="{{ site.baseurl }}/assets/backup/71AnalyticsSession.png" alt="71AnalyticsSession" width="2758" height="1490" class="aligncenter size-full wp-image-13931" /></a>
