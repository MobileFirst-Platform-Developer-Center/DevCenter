---
title: Quick Review of Challenge Handlers in MobileFirst Foundation 8.0
date: 2016-06-22
tags:
- MobileFirst_Platform
- Security
version:
- 8.0
author:
  name: Nathan Hazout
---

Challenge handlers have changed between 8.0 beta and 8.0 GA. If you have used challenge handlers in previous versions of MobileFirst Foundation (previously Worklight/MobileFirst Platform Foundation), it is worth going over this quick review of challenge handlers, to understand the new APIs and the different types of challenge handlers.
If you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn about challenge handlers in Mobile Foundation.

## What is a challenge handler
When trying to access a protected resource, the client may be faced with a *challenge*. A challenge is a question, a security test, a prompt by the server to make sure you are allowed to access this resource.  
Most commonly, this challenge is a request for credentials, such as a username and password.

In your client code, this challenge must be *handled* by an object called a *challenge handler*. It is important to note that once a challenge is received, it cannot be ignored. You must answer it, or cancel it. Ignoring a challenge may lead to unexpected behavior.

There are two types of challenge handlers: `SecurityCheckChallengeHandler` and `GatewayChallengeHandler`.

## SecurityCheckChallengeHandler
In most cases, the challenge will be sent by a [Security Check]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/creating-a-security-check/). Whenever a challenge is sent by a security check, it must be handled by a `SecurityCheckChallengeHandler`.  

> `SecurityCheckChallengeHandler` used to be called a `WLChallengeHandler` prior to 8.0 GA.

The incoming challenge is matched to your challenge handler using the security check name. It is important to register your challenge handler with the correct security check name.  If the framework does not find any matching challenge handler, an error will be thrown and your application may not work as expected.  

When the framework finds the matching challenge handler, it will call its `handleChallenge` method.  
This needs to end either with a `submitChallengeAnswer` or a `cancel` call, in order to tell the framework that you are done with this challenge.

> In 8.0 GA, the `submitFailure` API was renamed to `cancel`.

Read more about `SecurityCheckChallengeHandler` on the [credentials validation tutorials]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/credentials-validation/).

## GatewayChallengeHandler
In some cases, the challenge may be sent by a third party gateway. For example if your resource is protected by a reverse proxy such as DataPower, which sends a custom login form to the client.  Whenever a challenge is sent by a gateway, it must be handled by a `GatewayChallengeHandler`.

> `GatewayChallengeHandler` used to be called a `ChallengeHandler` prior to 8.0 GA.

A gateway challenge does not follow the protocol defined by MobileFirst Foundation, as it is generated outside of it. While registering a `GatewayChallengeHandler` requires a name (just like `SecurityCheckChallengeHandler`), this name is not used to match the challenge to a challenge handler. Because of this, is it your responsibility to determine whether the incoming response is a challenge and to match it to the correct challenge handler.

This is done by implementing the `canHandleResponse` method of `GatewayChallengeHandler`. The framework will call this method for almost every incoming response the client receives. Whenever `canHandleResponse` returns `true`, the framework will call `handleChallenge` and wait for you to finish handling this challenge.  

> `canHandleResponse` used to be named `isCustomResponse` prior to 8.0 GA.

Because the challenge is custom, the framework has no way to automatically know that you finished handling the challenge. You must tell the framework by calling either `submitSuccess` or `cancel`.

> Look for `GatewayChallengeHandler` in the API documentation.

> For an example using DataPower, see [DataPower Integration]({{site.baseurl}}/blog/2016/06/17/datapower-integration/).
