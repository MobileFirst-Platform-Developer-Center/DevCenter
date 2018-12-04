---
title: Best practices for performance and scalability of Mobile Foundation v8.0
date: 2018-11-29
tags:
- MobileFirst_Foundation
- Mobile_Foundation
- Security
- MFP
- Performance
- Scalability
version:
- 8.0
author:
  name: Vivin Krishnan
additional_authors:
- Kavitha Varadarajan
---

Here are some of the best practices, which are good to be considered for achieving performance and scalability of MobileFirst Platform Foundation (MFP) v8.0. Many of these recommendations apply to cloud and on-premise alike:

### Do's and dont's for securitycheck adapters

MFP runtime maintains the state of the security check (authentication context of clients) in the runtime database. Any changes made to the state is written to the DB. As such, for best performance the runtime table holding the state is expected to only have the authentication context of clients and devices. 

To ensure this:

1. Do not mix Resource access with Security check validation.

	*Security Check* should perform exactly that - verify and validate credentials. Resist the temptation to do large data loads in your security checks and send this data back to the client. By doing so, data also becomes part of the security check state and makes its way into the runtime 	DB. Later, when introspecting an incoming request's authentication context, this extra data will also be read.
   Defer that to the resource adapters.
   
2. Mark your security check class variables *transient*.

	If variables are not marked transient, they are serialized as part of the state and make their way to the DB. This is not a good practice. Also, if the variables hold data that change its value, errors such as :
	```
	000009b7 p.server.security.internal.context.ClientSecurityContextImpl E FWLSE4052E: Failed reading externalized security checks. Context initialized clean for client: <client-id>
	```
	is thrown in the logs, each time the securitycheck state is accessed. If the context is reloaded, you may see a challenge again - when you are not expecting one. 
	Any variable that is used temporarily to hold values should be marked transient. This includes HttpClient objects. 
  

### WLAuthorizationManager.login(Securitycheck) API call does not provide a token 

`WLAuthorizationManager.login(Securitycheck)`  API logs into the specified security check. While it creates an associated user identity, it does not create and return an OAuth token. As such, it may prove costly firing multiple adapter calls immediately after `login()`. In the absence of OAuth token, all the adapter calls will trigger OAuth negotiation and cycle through all the steps. This results in too many network calls.

For example, OAuth negotiation takes 3 steps (network calls). When 4 adapter calls are fired parallely immediately after login, instead of 3, there will be 4 * 3 = 12 network calls. 

To optimize this, after login these options can be adopted:

1. Use `WLAuthorizationManager.obtainAccessToken(scope)`, to obtain a token for the specific scope and then make the rest of the adapter calls ( parallely or sequentially), after the token is successfully obtained.

2. Use `WLResourceRequest` API to request access to a protected resource. This automatically triggers the OAuth cycle. Make the rest of the adapter calls (sequentially or parallely) once this adapter calls returns successfully.
 
Alternatively, the login can be triggered by invoking a protected adapter resource instead of  `WLAuthorizationManager.login(Securitycheck)`. This will prompt a login form (requesting for credentials) and will end with a token, an identity in the security check and a response to the original ResourceRequest call.

### Pass the required scope explicitly in ResourceRequest

Passing the required scope explicitly in `WLResourceRequest` will reduce the number of network calls required to obtain an OAuth token and successfully access the resource. If scope is not passed, MFP client SDK assumes the resource is protected with a default scope and requests for an OAuth token. With a token only with the default scope in it, the original adapter request is made again. This time server responds that more scopes are required to access the resource( with a 403 HTTP status code). This results in another token negotiation, this time for the rest of the scopes. Once a token with all the scopes have been obtained, the original adapter request is made again, this time with the new token. By then many network calls will have been fired.

Ref : WLResourceRequest( resource url, method, options) ;

```
  var options = {
  	 timeout : 20000,
  	 scope : 'accessRestricted'
  };
  
  WLResourceRequest request = new WLResourceRequest("/adapters/JavaAdapter/users",WLResourceRequest.GET, options);  
```

For details refer the [WLResourceRequest API](
https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WLResourceRequest.html#constructor).

### Avoid excessive or constant use of `WL.App.setServerUrl()` API

While this is a very useful client API that allows switching the MFP server url, it should be used judiciously.
As part of the URL switch, the API clears all client contexts. This forces the SDK to begin by registering itself with the server (even if the server url is the same) all over again. 
Avoid firing this API everytime the application connects to the server.

See [setServerUrl API](
https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.App.html#setServerUrl).

### Prune the runtime tables 

1. Prune the contents of *MFP\_TRANSIENT\_DATA* table periodically. This will improve DB performance and lookup times. 

2. Prune the *MFP\_PERSISTENT_DATA* table periodically. Care must be taken to ensure that only older records (that haven't accessed the server in a while) are removed.

### Practise version control

Older application registrations that are no longer in use should be removed.

### Dedicated Push cluster 

Dedicate a JVM or cluster for Push notifications. This will relieve the MFP runtime cluster / JVM of the additional processing, when dispatching notifications. 

### Keep the server and client udpated

Update your client and server to the latest iFix levels. Security improvements and performance optimisations are released via iFixes.

Details of the iFix releases can be found [here](
https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).


