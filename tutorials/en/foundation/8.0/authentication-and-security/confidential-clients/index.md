---
title: Confidential Client
---
##Overview

When accessing a resource protected by the MobileFirst Platform framework, the MobileFirst Platform client SDKs (ios, android, cordova, etc) will provide you with the tools to handle the security features.

However, *non-mobile clients* that do not use the MobileFirst Platform client SDK can also request protected resources, by acting as a **confidential client**.

For example, your backend server may need to request a protected resource, or use one of the MobileFirst Platform **REST APIs** such as **Push Notifications**.

Registered confidential clients can obtain a MobileFirst Platform token to be used in all requests.

## Registering the confidential client

In the MobileFirst Operations Console, under **Settings** → **Confidential Clients**, add a new entry.   You will need to provide the following:

- **Display Name**: A friendly display name that describes this client, such as **Backend Node server**.
- **ID**: A unique identifier for your client. Think of it as a username.
- **Secret**: A private passphrase to authorize access from this client. Think of it like an API key.
- **Allowed Scope**: A client using the above ID/Secret combination will automatically be granted the scope that you define here. (Learn more about **scope** in the [authorization concepts](../authorization-concepts/#scope) tutorial).

Some example of scopes are:

- [Protecting external resources](../protecting-external-resources) uses the scope `authorization.introspect`.
- [Sending a Push Notification](../../notifications/sending-push-notifications) via the REST API uses the space-separated scope elements `messages.write` and `push.application.<applicationId>`.
- Your adapters may be protected by some custom scope element, such as `accessRestricted`.
- The scope `**` is a catch-all scope, granting access to any requested scope.

<img class="gifplayer" alt="Configurting a confidential client" src="confidential-client.png"/>

## Predefined confidential client
The MobileFirst Platform server comes with a predefined testing confidential client with:

- **ID**: `test`
- **Secret**: `test`
- **Allowed Scope**: `**`

## Obtaining an access token

A token can be obtained using the MobileFirst Platform **token endpoint**.

- Make a **POST** request to **/mfp/api/az/v1/token**.
- Set the request with a content-type of `application/x-www-form-urlencoded`.  
- Set the following two form parameters:
  - `grant_type`: `client_credentials`
  - `scope`: The **scope** you need access to.
- The request should be authenticated using [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side). Use your confidential client **ID** and **secret**. For example, using the **test** confidential client, you should have the **HTTP header**: `Authorization: Basic dGVzdDp0ZXN0` (`test:test` encoded using **base64**).

This response for this request will contain a JSON object, including the **access token** and its expiration time.

```json
{
  "access_token": "eyXa01tTHZtMD0zNlJHWVZNVVViTzQ2Q3JTwrJPNK",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "**"
}
```

## Using the access token
From now on, you can make requests to the desired resources by adding the **HTTP header**: `Authorization: Bearer eyXa01tTHZtMD0zNlJHWVZNVVViTzQ2Q3JTwrJPNK`, replacing the access token by the one you extracted from the previous JSON object.
