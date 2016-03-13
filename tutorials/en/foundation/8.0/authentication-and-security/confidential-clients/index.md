---
layout: tutorial
title: Confidential Clients
relevantTo: [android,ios,windows,cordova]
weight: 5
---
## Overview
When accessing a resource protected by the MobileFirst Platform framework, the MobileFirst Platform Foundation client SDK (for Cordova, iOS,  Android and Windows) provide the tools to handle the security features.

Non-mobile clients that do not use the MobileFirst client SDK can also request protected resources, by acting as a **confidential client**.

For example, your backend server may need to request a protected resource, or use one of the MobileFirst Platform **REST APIs** such as **Push Notifications**.

Registered confidential clients can obtain a token to be used in all requests to the MobileFirst Server.

## Registering the confidential client
In the MobileFirst Operations Console, under **Settings** → **Confidential Clients**, click on **Create New** to add a new entry.  You will need to provide the following:

- **Display Name**: A friendly display name that describes the confidential client, such as **Backend Node server**.
- **ID**: A unique identifier for the confidential client (can be considered as a "username"). 
- **Secret**: A private passphrase to authorize access from confidential client (can be considered as an API key).
- **Allowed Scope**: A confidential client using the above ID and Secret combination will automatically be granted the scope that is defined here (learn more about **Scopes** in the [Authorization Concepts](../authorization-concepts/#scope) tutorial).

**Examples of scopes:**

- [Protecting external resources](../protecting-external-resources) uses the scope `authorization.introspect`.
- [Sending a Push Notification](../../notifications/sending-push-notifications) via the REST API uses the space-separated scope elements `messages.write` and `push.application.<applicationId>`.
- Adapters may be protected by a custom scope element, such as `accessRestricted`.
- The scope `**` is a catch-all scope, granting access to any requested scope.

<img class="gifplayer" alt="Configurting a confidential client" src="confidential-client.png"/>

## Predefined confidential client
The MobileFirst Server comes with a predefined testing confidential client:

- **ID**: `test`
- **Secret**: `test`
- **Allowed Scope**: `**`

## Obtaining an access token
A token can be obtained using the MobileFirst Server's **token endpoint**.

1. Make a **POST** request to **http(s)://[ipaddress-or-hostname]:[port]/[runtime]/api/az/v1/token**.  
    For example: `http://myserver:9080/mfp/api/az/v1/token`
    - In a development environment, the MobileFirst Server uses a pre-existing "mfp" runtime.  
    - In a production environment, replace this value with your runtime name.

2. Set the request with a content-type of `application/x-www-form-urlencoded`.  
3. Set the following two form parameters:
  - `grant_type`: `client_credentials`
  - `scope`: The **scope** you need access to.
4. The request should be authenticated using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side). Use your confidential client's **ID** and **secret**.

    For example, using the **test** confidential client, you should have the **HTTP header**: `Authorization: Basic dGVzdDp0ZXN0` (`test:test` encoded using **base64**).

    The response for this request will contain a JSON object, including the **access token** and its expiration time.

    ```json
    {
      "access_token": "eyXa01tTHZtMD0zNlJHWVZNVVViTzQ2Q3JTwrJPNK",
      "token_type": "Bearer",
      "expires_in": 3599,
      "scope": "**"
    }
    ```

## Using the access token
From here on, requests can be made to the desired resources by adding the **HTTP header**: `Authorization: Bearer eyXa01tTHZtMD0zNlJHWVZNVVViTzQ2Q3JTwrJPNK`, replacing the access token by the one you extracted from the previous JSON object.
