---
title: Refresh Token
date: 2018-11-29
tags:
- MobileFirst_Foundation
version:
- 8.0
author: 
    name: Amit Mane
---

## Introduction
The MobileFirst security framework is based on the OAuth 2.0 protocol. According to this protocol, a resource can be protected by a scope that defines the required permissions for 
accessing the resource. To access a protected resource, the client must provide a matching access token, which encapsulates the scope of the authorization that is granted to the 
client. A MobileFirst access token is a digitally signed entity that describes the authorization permissions of a client. After the client’s authorization request for a specific 
scope is granted, and the client is authenticated, the authorization server’s token endpoint sends the client an HTTP response that contains the requested access token.
Refresh token is a special type of token with longer expiry period compared to access token. The sole purpose of refresh token is to obtain new access token when existing access 
token expires. Unlike access token, refresh token never gets shared with resource server. To obtain a new access token, a valid refresh token can be presented to Authorization 
Server. 
MobileFirst refresh token is single usage token with fixed expiry period of thirty days. When a valid refresh token is used to obtain new access token, MobileFirst authorization 
server issues new access token as well as new refresh token to MobileFirst SDK. The expiry period of new refresh token shall be reset to 30 days from the point MobileFirst 
authorization server issues it. Thus each time client obtains new access token by presenting valid refresh token, MobileFirst server issues new token pair of access token and 
refresh token. With each new refresh token the expiry window shall extend to 30 days from the time of issuing the token pair. This gives experience of never expiring token.

## Usage
Following diagram illustrates high level flow steps between MFP client and server

![Flow]({{site.baseurl}}/assets/blog/2018-11-29-IBM-MobileFirst-Refresh-Token/flow.png)

1.	Initially client sends a request to obtain an access token
2.	Server authenticates and issues token pair of access token and refresh token
3.	Client calls restricted resource using access token obtained in step 2. This continues until access token expires
4.	Client requests resource using expired access token
5.	Server replies to indicate that access token has been expired
6.	Client requests for new access token using refresh token
7.	Server issues new token pair of access token and refresh token
8.	Client continues requesting resource using access token

For more details refere to [Refresh Token](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens)

Refresh token must be used with caution by an application because they can allow user to remain authenticated forever. Social media applications, e-commerce applications, product catalog browsing and similar utility applications, where the application provider does not authenticate users regularly can use refresh tokens. Applications that mandate user authentication frequently must avoid using refresh tokens.
MobileFirst server does not support revocation feature of access token or refresh token. In case of suspicious activities, cleanup of database table MFP_TRANSIENT_DATA shall invalidate all the tokens and force all the users for reauthentication. Simple delete query as below can be used to clear all the data from MFP_TRANSIENT_DATA table which is part of MFP database. Note that this step will force all the users to re authenticate by invalidating their existing issued tokens.

```SQL
delete from <db_schema_name>.MFP_TRANSIENT_DATA
```
