---
layout: tutorial
title: Frequently Asked Questions
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

This topic describes the list of commonly asked questions related to {{ site.data.keys.mf_analytics_server }}.

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	How do I set the number of shards and replicas for my analytics cluster?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>In a multi-index elasticsearch cluster, it is important to set the following:
                <ul><li>Minimum number of shards to be set to the number of nodes in the cluster.</li><li>Replicas per shard to be set to a minimum of two.</li></ul><br/>MobileFirst Analytics v8.0 uses multiple indices to store the event data.</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. In MobileFirst Analytics v8.0, the configuration in <code>server.xml</code> has 3 shards set but Analytics Operations console administration page shows more than 15 shards.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>In MobileFirst Analytics v8.0, the data store of Elasticsearch has multiple indices. It is not a single index-based data store. Indices are dynamically created based on the type of events flowing into the analytics. So the end users need not be concerned about the multiple indices. Here every index within the Elasticsearch is split into the number of shards set in the config file.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. Why does my analytics operations console render extremely slow?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p>Ensure that the <a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">hardware sizing calculator</a> is used for checking the right hardware against the data and the customer requirements. Several factors influence the performance of the system including hardware, the type or size of data events that come into the analytics server and  the volume of events.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. Can I recover my purged data?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>No. Once the data is purged, it cannot be recovered.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. Data Purging not happening correctly irrespective of setting TTL values.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>The TTL properties are not applied to the data that exists in the Analytics platform. You must set the TTL properties before you add data.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. Analytics Operations console does not display any data.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>Ensure that the MobileFirst Server JNDI properties are used to configure the right Analytics end points. Ensure that the Date filter is correctly set for the data to be rendered.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. Unable to invoke the Elasticsearch cluster REST APIs.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>To invoke the Elasticsearch REST APIs, it is mandatory that the property <b>analytics/http.enabled</b> has to be set to <b>true</b> in Analytics server's <code>server.xml</code>.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	Can I use Open JDK with IBM WebSphere Application Server ND (or Full Profile) on Analytics?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>No. While using IBM WebSphere Application Server Full Profile or Network Deployment (ND), make sure to use the IBM JDK that is provided out of the box with WebSphere Application Server.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	When does the number of <b>App Sessions</b> start to increment?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>First time when the application is opened the <b>App Sessions</b> is zero. When the end user takes the mobile app to the background and brings it back to the foreground, then this action increments the <b>App Sessions</b> to 1. Further repeating the same action continues to increment the <b>App Sessions</b>.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	Analytics Cluster Health shows YELLOW, what does it mean?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>Cluster health YELLOW might not be an issue. Mostly, when there are unassigned shards the cluster health is shown as yellow. When new nodes are joined to the cluster, Elasticsearch reallocates the unassigned shards to the new nodes, thus making the cluster health GREEN. Sometimes, too much of shard counts also leaves the shards unassigned to any of the nodes and hence the cluster health status shows as yellow. Make sure all the nodes in the cluster are active and are working fine and that the shards are in started/active state.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	What does App Sessions mean for web apps?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>For Web apps, AppSession count is incremented based on the browser session and is based on the connection from the browser (app) to the MFP Server.</p>

                  <p>Let us say if the browser is using the general window/tab and performs a connection to the server then the App Session count is incremented by one. In the same browser, if the user opens the app on another tab and performs the connect, then the session doesn't increment. The session stays inactive for 30 mins. When you try to reconnect again it is incremented by one.</p>

                  <p>If the user clears the browser cache and tries to connect, then the device is considered to be a new one and the device count is incremented. Since browsers don't have a real device ID, an ID is generated for the browser app until the offline files/cache is cleared.</p>

                  <p>This applies to an incognito browser window as well, if you use an incognito browser window and try to connect, an app used to connect from each tab is considered as a new session and the session count is incremented. If the user uses two different browsers and accesses the app to connect to MFP Server, then the device count is incremented by two.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	What does <i>Active Users</i> on Analytics Dashboard refer to?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>Active users</i> is the number of users using the app. Every unique user is counted as a user using the app. By default deviceID is userID. However app developer can use <code>setUserContext(userid)</code> API. This is going to replace the userID to the value the app developer sets.</p>

                  <p>One solution/approach is to generate a uniqueID from the computer when the user is accessing the WebApp and it sends that as a customData. This data can be used to compute the statistics for the actual machines (or computers/browsers) from which user accesses the app and uses the <code>setUserContext</code> to set the userID. This data can also be used to generate the custom charts.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	What does App Sessions mean for native/Cordova apps?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>In Analytics 8.0, calculating an App session is completely different from any of the previous versions of MFP Analytics.</p>

                  <p>An App session count is incremented by one when the app is brought to the foreground from background. To enable this for Cordova Apps, we need to enable the CLIENT APP LIFECYCLE events. Please refer <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">here</a>, for more information.</p>
            </div>
        </div>      
    </div>
</div>       
