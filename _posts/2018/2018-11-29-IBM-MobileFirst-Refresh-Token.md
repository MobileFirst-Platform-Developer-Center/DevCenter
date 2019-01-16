---
title: Refresh Token
date: 2018-11-29
tags:
- MobileFirst_Foundation
- Mobile_Foundation
version:
- 8.0
author:
    name: Amit Mane
---

The MobileFirst security framework is based on the OAuth 2.0 protocol. According to this protocol, a resource can be protected by a scope that defines the required permissions for accessing the resource. To access a protected resource, the client must provide a matching access token, which encapsulates the scope of the authorization that is granted to the client. A MobileFirst access token is a digitally signed entity that describes the authorization permissions of a client. After the client’s authorization request for a specific scope is granted, and the client is authenticated, the authorization server’s token endpoint sends the client an HTTP response that contains the requested access token.

Refresh token is a special type of token with longer expiry period compared to the access token. The sole purpose of refresh token is to obtain a new access token when the existing access token expires. Unlike access token, refresh token never gets shared with resource server. To obtain a new access token, a valid refresh token can be presented to Authorization
Server.

The MobileFirst refresh token is a single usage token with a fixed expiry period of thirty days. When a valid refresh token is used to obtain a new access token, MobileFirst authorization server issues a new access token as well as a new refresh token to MobileFirst SDK. The expiry period of the new refresh token shall be reset to 30 days from the point in time the MobileFirst authorization server issues it. Thus each time the client obtains a new access token by presenting a valid refresh token, MobileFirst server issues a new token pair of the access token and refresh token. With each new refresh token, the expiry window shall extend to 30 days from the time of issuing the token pair. This gives the experience of a never expiring token.

## Usage
The following diagram illustrates the high level steps of the flow between the MobileFirst Pltaform client and server.

![Flow]({{site.baseurl}}/assets/blog/2018-11-29-IBM-MobileFirst-Refresh-Token/flow.png)

1.	Initially, the client sends a request to obtain an access token.
2.	Server authenticates and issues a token pair containing an access token and a refresh token.
3.	The client calls the restricted resource using the access token obtained in step 2. This continues until the access token expires.
4.	The client requests resource using expired access token.
5.	The server responds to indicate that the access token has been expired.
6.	The client requests for a new access token using the refresh token.
7.	The server issues a new token pair of access token and refresh token.
8.	The client continues requesting resource using the access token.

For more details refer to the topic [Refresh Token](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

Refresh token must be used with caution by an application because they can allow a user to remain authenticated forever. Social media applications, e-commerce applications, product catalog browsing, and similar utility applications, where the application provider does not authenticate users regularly can use refresh tokens. Applications that mandate user authentication frequently must avoid using refresh tokens.
MobileFirst server does not support revocation feature of the access token or the refresh token. In case of suspicious activities, cleanup of database table *MFP_TRANSIENT_DATA* shall invalidate all the tokens and force all the users for reauthentication. Delete query as below can be used to clear all the data from the *MFP_TRANSIENT_DATA* table, which is part of the MobileFirst Platform database. Note that this step will force all the users to re-authenticate by invalidating their existing issued tokens.

```SQL
delete from <db_schema_name>.MFP_TRANSIENT_DATA
```
