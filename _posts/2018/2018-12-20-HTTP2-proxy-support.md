---
title: HTTP/2 APNs Push Notifications using Apache HTTP Server as Proxy
date: 2018-12-24
version:
- 8.0
tags:
- MobileFirst_Foundation
- Push Notifications
- HTTP/2
- Proxy
author:
  name: Josephine E. Justin
additional_authors: Kapil Powar  
---
**MobileFirst Platform** now supports the HTTP/2 based APNs Push Notifications.

Starting with *iFix 8.0.0.0-MFPF-IF201812191602-CDUpdate-04*, MobileFirst Platform supports HTTP/2 based notifications for Apple devices.

>**Note:** Support for HTTP/2 for Push Notifications would co-exist along with the legacy TCP Socket based notifications.

If you are an on-premise 8.0 customer or Mobile Foundation service customer, then read further to learn about using HTTP/2 based notifications <br/>

## Benefits of HTTP/2 based Notifications

Moving to HTTP/2 based notifications provides various benefits, which includes the following:

* Universal certificate support - Single certificate for development and production.
* Instant Feedback - For any inactive tokens, feedback is provided by APNs immediately.
* Payload size - Notification payload size increases from 2 KB to 4 KB.
* Throughput increase - Compression helps in increasing the throughput for the notifications and reduces the need for simultaneous open connections.

## Enabling HTTP/2 Notifications

HTTP/2 based notifications can be enabled using a JNDI property

 ```xml
    <jndiEntry jndiName="imfpush/mfp.push.apns.http2.enabled" value= '"true"'/>
 ```   

## Apache HTTP Server Setup

### Install the Proxy & related modules

Install the Apache HTTP Server to use as a proxy server.  You can obtain Apache Webserver [here](http://httpd.apache.org/download.cgi).

### Enable proxy modules & configure Forward Proxy

After the related modules are installed and enabled, to load and enable the proxy modules follow the steps below:

1. Navigate to `proxy.load` file under `/etc/apache2/mods-enabled` folder.
2. Edit the `proxy.load` to add the below lines:
```
  LoadModule proxy_connect_module /usr/lib/apache2/modules/mod_proxy_connect.so
  LoadModule proxy_ftp_module /usr/lib/apache2/modules/mod_proxy_ftp.so
  LoadModule proxy_http_module /usr/lib/apache2/modules/mod_proxy_http.so
```
3. To configure the forward proxy, edit the `proxy.conf` file in the folder `/etc/apache2/mods-enabled`.  Edit the Proxy Server section to make sure the proxy section contains the below details:<br/>
  ```xml
    # Proxy Server directives. Uncomment the following lines to enable the proxy server:
    <IfModule mod_proxy.c>
    #Enable the forward proxy server. Note:Do not use the ProxyRequests directive if
    #all you require is reverse proxy.
    ProxyRequests On
    <Proxy *>
        Order deny,allow
        #Deny from all
        Allow from all
    </Proxy>
    </IfModule>
  ```
4. Start or restart the Apache HTTP Server using the command:<br/>
  ```bash
    /etc/init.d/apache2 start
  ```
<br/>

>**Note:** HTTP servers from other vendors might have different configurations. Steps above are specific to Apache HTTP Server.  

## Enable Push Notifications to be routed via the Proxy

In the MobileFirst Platform `server.xml` file, include the below JNDI properties to enable the proxy server routing for Push Notifications.

```xml
  <jndiEntry jndiName="imfpush/mfp.push.apns.http2.enabled" value= '"true"'/>
  <jndiEntry jndiName="imfpush/mfp.push.apns.proxy.enabled" value='"true"'/>
  <jndiEntry jndiName="imfpush/mfp.push.apns.proxy.host" value='"<Host IP Address>"'/>
  <jndiEntry jndiName="imfpush/mfp.push.apns.proxy.port" value='"<port>"'/>
  <jndiEntry jndiName="imfpush/mfp.push.apns.proxy.user" value='"<username>"'/>
  <jndiEntry jndiName="imfpush/mfp.push.apns.proxy.password" value='"<password>"'/>
```

Restart your MobileFirst Platform and send notifications.
