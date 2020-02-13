---
title: Apple deprecates legacy binary protocol based notifications
date: 2020-01-03
tags:
- MobileFirst_Platform
- MobileFirst_Foundation_push
- iOS
version:
- 8.0
author:
  name: Kapil Powar
additional_authors:
  - Vivin Krishnan
---
<style>
.audio-background {
  background-image: linear-gradient(to right, rgba(255,255,255,0), #ffff99);
;
}
</style>
<script>
$('#audioMFWebView').on('ended', function() {
        manageImageObjectsLevel();
}).get(0).play();
</script>

<div class="container audio-background">
  <h3>Listen to the post excerpt</h3>
  <audio id="audioMFWebView" controls>
  <source src="{{site.baseurl}}/assets/blog/2020-01-03-http2-cert-based-notifications/http2-cert-based-notifications.mp3" type="audio/mpeg">
  Your browser does not support the audio tag.
  </audio>

</div>
<br/>
[Apple Push Notification Service Update](https://developer.apple.com/news/?id=11042019a) announced the following.

>If you send push notifications with the legacy binary protocol, we recommend updating to the HTTP/2-based APNs provider API as soon as possible. You will be able to take advantage of great modern features such as authentication with a JSON Web Token, improved error messaging, and per-notification feedback.
>
>The Apple Push Notification service (APNs) will no longer support the legacy binary protocol as of November 2020.

Starting with *iFix 8.0.0.0-MFPF-IF201812191602-CDUpdate-04*, MobileFirst Platform v8.0 supports HTTP/2 based notifications for Apple devices.

### Benefits of HTTP/2 based notifications

Moving to HTTP/2 based notifications provides various benefits, which includes the following.

* Universal certificate support - Single certificate for development and production.
* Instant Feedback - For any inactive tokens, feedback is provided by APNs immediately.
* Payload size - Notification payload size increases from 2 KB to 4 KB.
* Throughput increase - Compression helps in increasing the throughput for the notifications and reduces the need for simultaneous open connections.

### Enabling HTTP/2 notifications

HTTP/2 based notifications can be enabled using a JNDI property,

 ```xml
    <jndiEntry jndiName="imfpush/mfp.push.apns.http2.enabled" value= '"true"'/>
 ```   

For more information on proxy setup, please refer [HTTP/2 APNs Push Notifications using Apache HTTP Server as Proxy]({{ site.baseurl }}/blog/2018/12/24/HTTP2-proxy-support/).
