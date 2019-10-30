---
layout: tutorial
title: Connect to Microservices using the API Proxy
weight: 15
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## API Proxy
{: #dab-api-proxy }

When connecting to the enterprise backend, it is possible to leverage the security and analytics of MobileFirst platform using the API Proxy. As the name suggests, it is a proxy that can be used to proxy over the requests to the actual backend.

### Some of the Advantages of using the API Proxy

* The actual backend host is not exposed to the mobile app and stays secure in MobileFirst server.
* Get the analytics of the requests that are made to the backend

### How to use the API Proxy?

1. Download the Mobile API Proxy adapter from the Mobile Foundation Console.

    ![API Proxy](dab-api-proxy.png)

2. Deploy the API Proxy adapter to Mobile Foundation server.

3. Configure the backend URI in the API Proxy adapter configuration. The URI should be of the format `protocol:host:port/context`. For example, `http://secure-backend/basecontext/`.
4. Make the requests to the backend using the `WLResourceRequest API`. Use the API call code snippet from the **MOBILE CORE** section. Alter the options object to set `useAPIProxy` key to true.

    Example:
    ```
    var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
    );
    resourceRequest.send().then(
        function(response) {
            alert("Success: " + response.responseText);
        },
        function(response) {
            alert("Failure: " + JSON.stringify(response));
        }
    );
    ```
