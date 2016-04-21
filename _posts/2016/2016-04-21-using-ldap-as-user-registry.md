---
title: Working with LDAP and LTPA in IBM MobileFirst Platform Foundation 8.0 Beta
date: 2016-04-21
version:
- 8.0
tags:
- MobileFirst_Platform
- Authentication
- Adapters
- Security
- LDAP
- LTPA
author:
  name: Ishai Borovoy
---
## Introduction
The ability to connect an application to a user registry is an important ability.  You might want your users to be able to connect to your app with the same credentials they use to connect to other resources in the enterprise, or you just need to connect the user to the registry.  [LDAP](https://www.wikiwand.com/en/Lightweight_Directory_Access_Protocol) is an established protocol for connecting to a user registry.  

In this blog, I am presenting how to connect your MobileFirst Server to [LDAP](https://www.wikiwand.com/en/Lightweight_Directory_Access_Protocol) and allow the users to authenticate.

[LTPA](https://www.wikiwand.com/en/IBM_Lightweight_Third-Party_Authentication), is an authentication technology used in IBM WebSphere products. When accessing web servers that use the LTPA technology it is possible for a user to re-use their login across physical servers.

## The hands-on tutorial
Check the hands-on tutorial [in the GitHub repository](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/ltpa-sample).  In this hands-on tutorial, you will able to run an iOS application which can do authentication against remote LDAP server or against basic user registry (both configured in server.xml).

## The big picture
Here is diagram to better understand the flow:  

![LDAP Flow]({{site.baseurl}}/assets/blog/2016-04-21-using-ldap-as-user-registry/LDAP.png)  

1. User clicks on the *Invoke LTPA Based Protected Resource* button.   
2. The client SDK sends the resource request to a protected REST Adapter */hello/user*, the adapter is protected with *LTPA* OAuth scope.  
3. Since the adapter is protected the Authorization server API check it for valid OAuth token.  
4. The Authorization server API does not find any valid token with OAuth scope *LTPA*.  
5. The response is then returned to the app with unauthorized status with challenge containing the login URL pointing to the Protected WAR, as configured in the Security Check.  
6. The app is invoking the *LTPAChallengeHandler* challenge handler.  
7. The challenge handler is prompting a login form to the user.  
8. The user submits his credentials and the app sends them to the login URL. In case of successful login the client will receive an LTPA Cookie.
9. The client submit the challenge answer.
10. The client SDK calls the authorization end point with the LTPA token (As HTTP Cookie).
11. The [ltpa-based](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/ltpa-sample/ltpa-based) security check is validating that the LTPA token was issued for a valid user.  
12. The OAuth flow continues until the client gets valid OAuth token.  
13. The client resends the request to the protected REST Adapter */hello/user* with valid OAuth token.
14. Client gets the user id and user name and displays hello {user} dialog :-).

## The LTPA Security Check
[Websphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/) server is working seamlessly with [LTPA](https://www.wikiwand.com/en/IBM_Lightweight_Third-Party_Authentication) and allows easy access to the authenticated user details in the security check adapter.  The LTPA validation happens in the [LTPABasedSecurityCheck.java](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/ltpa-sample/ltpa-based/src/main/java/net/mfpdev/sample/ltpa/LTPABasedSecurityCheck.java) security check:

```java
 String principal = WSSubject.getCallerPrincipal();
```

This line will return you the caller [Principal](https://docs.oracle.com/javase/7/docs/api/java/security/Principal.html) name.

To get the [Subject](https://docs.oracle.com/javase/7/docs/api/javax/security/auth/Subject.html) that provides additional user information, like user's OU, Groups, Privileges etc use the following code:

```java
WSSubject.getCallerSubject()
```

> NOTE: Attributes can be added to the AuthenticatedUser using the `user.getAttributes()` Map.

The [ltpa-based](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/ltpa-sample/ltpa-based) security check is checking for existing principal (which comes from the LTPA request Cookie):

```java
String principal = WSSubject.getCallerPrincipal();
if (principal != null) {
   // if a caller principal exists - mark as authenticated, and return success
   setState(STATE_AUTHENTICATED);
   AuthenticatedUser user = new AuthenticatedUser(principal, principal, getName());
   authorizationContext.setActiveUser(user);
   registrationContext.setRegisteredUser(user);
   response.addSuccess(scope, getExpiresAt(), getName());
   logger.fine("LTPABased authorization: user authenticated (" + principal + ")");

} else {

   // a caller principal does not exist - drop the state and return challenge
   setState(STATE_EXPIRED);
   Map<String, Object> challenge = new HashMap<>();
   challenge.put("loginURL", getConfiguration().loginURL);
   response.addChallenge(getName(), challenge);
   logger.fine("LTPABased authorization: sending challenge for " + getConfiguration().loginURL);
}
```

## Supported Versions
IBM MobileFirst Platform Foundation 8.0
