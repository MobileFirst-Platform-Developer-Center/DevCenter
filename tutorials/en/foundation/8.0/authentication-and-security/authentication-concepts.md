---
layout: tutorial
title: Authentication Concepts
breadcrumb_title: Authentication concepts
relevantTo: [android,ios,windows,cordova]
weight: 1
---

## Overview

The [OAuth 2.0](http://oauth.net/) protocol is based on the acquisition of an access token, which encapsulates the authorization that is granted to the client. In that context, IBM MobileFirst Platform Server serves as an authorization server and is able to generate such tokens. The client can then use these tokens to access resources on a resource server, which can be either MobileFirst Server itself or an external server. The resource server checks the validity of the token to make sure that the client can be granted access to the requested resource. This separation between resource server and authorization server in the new OAuth-based model allows you to enforce MobileFirst security on resources that are running outside MobileFirst Server.

This tutorial covers the following topics:

*   [Authorization flow](#authorization-flow)
*   [Authorization entities](#authEntities)
  * SecurityCheck
  * SecurityCheckConfiguration
  * Scope
  * Scope Token
  * Security Adapter
* Protecting resources
  * Java adapters
  * JavaScript adapters
  * External resources
* Configuring Authentication from the MobileFirst Console
* Further reading



## Authorization flow

The new MobileFirst end-to-end authorization flow has two phases: the client acquires the token and then uses it to access a protected resource.

### Acquiring a token

In this phase, the client undergoes security checks in order to receive an access token. These security checks use authorization entities, which are described in [the next section](#authEntities).  
![Obtain Token]({{ site.baseurl }}/assets/backup/MFP_Security_obtain_token.jpg)

### Using a token to access a protected resource

It is possible to enforce MobileFirst security both on resources that run on MobileFirst Server, as shown in this diagram, and on resources that run on any external resource server as explained in tutorial [Using MobileFirst Server to authenticate external resources](../../using-mobilefirst-server-authenticate-external-resources/ "Using the MobileFirst Server to authenticate external resources").

![Protect Resources]({{ site.baseurl }}/assets/backup/MFP_Security_protect_MFP_resources.jpg)

## Authorization entities

### SecurityCheck

### SecurityCheckConfiguration

### Scope

### Scope Token

### Security Adapter

## Protecting resources

### Java adapters

### JavaScript adapters

### External resources

## Configuring Authentication from the MobileFirst Console

## Further Reading
