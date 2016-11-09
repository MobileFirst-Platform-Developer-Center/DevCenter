---
title: 'HowTo: Use a CDN with an Express web application'
date: 2016-03-21
tags:
- MobileFirst_Platform
- Bluemix
author:
  name: Yoel Nunez
---

## Overview
In this tutorial we are learning what is a Content Delivery Network (CDN), what are the benefits, and how to instrument your Express JS application to indicate the CDN to cache the responses.

* [What is a Content Delivery Network (CDN)?](#what-is-a-content-delivery-network-cdn)
* [How does a CDN work?](#how-does-a-cdn-work)
  * [Typical CDN Request Flow](#typical-cdn-request-flow)
  * [CDN for Mobile Applications](#cdn-for-mobile-applications)
* [Instrumenting an Express Application](#instrumenting-an-express-application)
  * [Creating Cache Middleware](#creating-cache-middleware)
* [Using IBM CDN in Bluemix](#using-ibm-cdn-in-bluemix)
* [Final Thoughts](#final-thoughts)

## What is a Content Delivery Network (CDN)?
A Content Delivery Network (CDN) is a distributed series of proxy servers deployed across multiple data centers over the internet. The objective of a CDN is to provide high availability and performance to end-users by using techniques such as web caching, load balancing, and request routing.

## How does a CDN work?
A CDN works by caching files (objects) and serving them directly instead of going to the origin server for every request. Because a CND takes into account the visitor's geolocation, the files are served by the closest server to the user to reduce latency.

### Typical CDN Request Flow

![CDN Request Flow]({{site.baseurl}}/assets/blog/2016-03-30-howto-use-a-cdn-with-an-express-web-application/cdn-illustration.png)

1. Client makes a request to `http://assets.domain.com/image.jpg`
2. A DNS server forwards the request to the CDN server
3. If `image.jpg` is not cached in the CDN or has expired, then CDN makes a request to the origin server that contains the resources
4. Origin (resource) responds and CDN caches the `image.jpg`
5. CDN responds with `image.jpg`

### CDN for Mobile Applications

With the surge of mobile apps, the necessity to improve performance and offer better user experience is a must. Optimizing mobile applications is a challenging task because multiple of factors need to be taken into account. Having a CDN in your topology can improve the mobile experience of your users by utilizing the techniques mentioned above such as web caching, load balancing, and request routing.

> **Note:** A CDN is not a magic bullet, mobile optimization requires additional work not mentioned in this post.</blockquote>

## Instrumenting an Express application

A `Cache-Control` header indicates to the CDN how long the object/file needs to be cached; the `max-age` directive marks the time to live (TTL) for the cached response.

### Creating cache middleware

To make my caching mechanism more modular, I've created a node module and called it `cache-middleware.js`. The middleware function gets passed in an options object which contains an array of routes with a specific TTL associated to it. The middleware function checks if the request matches the route in my cache options and then injects the `Cache-Control` header to indicate the CDN to cache the response.

**cache-middleware.js**

```javascript
module.exports = function (options) {
    return function (req, res, next) {
        if (typeof options === 'object' && typeof options.cache === 'object') {
            options.cache.forEach(function (route) {

                if (req.path.match(new RegExp(route.path, 'g'))) {
                    res.set('Cache-Control', 'max-age=' + route.ttl);
                }
            });
        }

        next();
    };
};
```

The `options` object looks as follow:

**cache.json**

```javascript
{
  "cache": [
    {
      "path": "^/api/(.*)",
      "ttl": 300
    },
    {
      "path": "(.*).(jpg|png)$",
      "ttl": 3600
    }
  ]
}
```

In the snippet above, I'm caching all the `jpg` and `png` images for 1 hour. On the other hand, the requests made to to the `/api` endpoint are only cached for 5 minutes.

For the middleware to work for all routes and static files, I bind the middleware to the application object.


**app.js**

```javascript
var express = require('express');
var env = require('cfenv');

var cache = require('./cache-middleware');
var cacheConfig = require('./cache.json');

var app = express();

app.use(cache(cacheConfig), express.static(__dirname + '/public'));

app.get('/api/user', function(req, res){
  res.json([
    {
      "name" : "John Doe",
      "created": new Date()
    },
    {
      "name" : "Richard Smith",
      "created": new Date()
    }
  ]);
});

var appEnv = env.getAppEnv();

app.listen(appEnv.port, function () {
  console.log('Example app listening on port 3000!');
});
```


## Using IB CDN in Bluemix

Take a look at the [Getting started with IBM CDN](https://console.ng.bluemix.net/docs/services/cdn/index.html) to setup your CDN.

![IBM CDN in Bluemix]({{site.baseurl}}/assets/blog/2016-03-30-howto-use-a-cdn-with-an-express-web-application/ibm-cdn-service.png)

Once the CDN service is setup and your application is returning the appropriate `Cache-Control` headers then the caching will kick in.

Below you can see the request and response headers the first time it is made.

**Request**

```
GET /images/image.jpg HTTP/1.1
Host: app.yoelnunez.com
Accept: application/json
Cache-Control: no-cache
```

**Response Headers**

```
Accept-Ranges: bytes
Age: 0
Cache-Control: max-age=3600
Connection: Keep-Alive
Content-Length: 146285
Content-Type: image/jpeg
Date: Mon, 30 Mar 2016 22:03:13 GMT
Etag: W/"23b6d-1539a8765b0"
Last-Modified: Mon, 30 Mar 2016 18:54:38 GMT
Via: 1.1 varnish
X-Backside-Transport: OK OK
X-Cache: MISS
X-Cache-Hits: 0
X-Cf-Requestid: 2696d244-6bc8-4422-57bf-99f6f92d61a1
X-Client-IP: 199.27.76.21
X-Global-Transaction-ID: 2528543619
X-Powered-By: Express
X-Served-By: cache-jfk1043-JFK
X-Timer: S1458597793.473932,VS0,VE101
```

The `X-Cache` header indicate that the cache was not used at all. The second time a request comes in through the CDN the cache will be used for that particular response since `max-age=3600`

```
Accept-Ranges: bytes
Age: 430
Cache-Control: max-age=3600
Connection: Keep-Alive
Content-Length: 146285
Content-Type: image/jpeg
Date: Mon, 30 Mar 2016 22:10:23 GMT
Etag: W/"23b6d-1539a8765b0"
Last-Modified: Mon, 30 Mar 2016 18:54:38 GMT
Via: 1.1 varnish
X-Backside-Transport: OK OK
X-Cache: HIT
X-Cache-Hits: 3
X-Cf-Requestid: 2696d244-6bc8-4422-57bf-99f6f92d61a1
X-Client-IP: 199.27.76.21
X-Global-Transaction-ID: 2528543619
X-Powered-By: Express
X-Served-By: cache-jfk1022-JFK
X-Timer: S1458598223.125599,VS0,VE0
```

The `X-Cache` header now indicates that the cache was used and the `X-Cache-Hits` shows the number of times the cache was used since this particular document was cached.


## Final Thoughts

Having a CDN offers in your application stack can bring a number of benefits in terms of performance and server loads. A CDN allows you to cache specific files/documents that don't change very often and even files that change every once in while. This will reduce the IO operations that you application server has to handle as well as reduce the bandwidth used. For your users that translates to better performance.
