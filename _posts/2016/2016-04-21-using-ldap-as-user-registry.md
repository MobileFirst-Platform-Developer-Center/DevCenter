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
The ability to connect an application to a user registry is an important ability. You might want your users to be able to connect to your back-end systems with the same credentials that they use to connect to other resources in the enterprise, or you just need to connect the user to the registry. [LDAP](https://www.wikiwand.com/en/Lightweight_Directory_Access_Protocol) is an established protocol for connecting to a user registry.

In this blog post,you will see how to connect a MobileFirst Server to [LDAP](https://www.wikiwand.com/en/Lightweight_Directory_Access_Protocol) and allow the users to authenticate by using [LTPA](https://www.wikiwand.com/en/IBM_Lightweight_Third-Party_Authentication). LTPA is an authentication technology that is used in IBM WebSphere products. When accessing web servers that use the LTPA technology it is possible for a user to re-use their login across physical servers.

You can find the sample application that is demonstrated in this blog post [in this GitHub repository](https://github.com/mfpdev/ldap-and-ltpa-sample).

With this hands-on sample, you can run an iOS application that can do authentication against a remote LDAP server or against a basic user registry (both configured in server.xml).

## The big picture
Here is diagram that shows the flow:  

![LDAP Flow]({{site.baseurl}}/assets/blog/2016-04-21-using-ldap-as-user-registry/LDAP.png)  

1. User clicks the *Invoke LTPA Based Protected Resource* button.   
2. The client SDK sends the resource request to a protected REST Adapter */hello/user*, the adapter is protected with *LTPA* OAuth scope.  
3. Because the adapter is protected the Authorization server API check it for valid OAuth token.  
4. The Authorization server API does not find any valid token with OAuth scope *LTPA*.  
5. The response is then returned to the app with unauthorized status with challenge containing the login URL pointing to the Protected WAR, as configured in the Security Check.  
6. The app is invoking the *LTPAChallengeHandler* challenge handler.  
7. The challenge handler is prompting a login form to the user.  
8. The user submits their credentials and the app sends them to the login URL. In case of successful login, the client receives an LTPA cookie.
9. The client submits the challenge answer.
10. The client SDK calls the authorization end point with the LTPA token (as HTTP cookie).
11. The [ltpa-based-security-check](https://github.com/mfpdev/ldap-and-ltpa-sample/tree/master/ltpa-based-security-check) security check validates that the LTPA token was issued for a valid user.  
12. The OAuth flow continues until the client gets a valid OAuth token.  
13. The client resends the request to the protected REST Adapter */hello/user* with the valid OAuth token.
14. Client gets the user ID and user name, and displays hello {user} dialog :-).

## The LTPA Security Check
[Websphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/) server is working seamlessly with [LTPA](https://www.wikiwand.com/en/IBM_Lightweight_Third-Party_Authentication) and allows access to the authenticated user details in the security check adapter.  The LTPA validation happens in the [LTPABasedSecurityCheck.java](https://github.com/mfpdev/ldap-and-ltpa-sample/tree/master/ltpa-based-security-check/src/main/java/com/github/mfpdev/sample/ltpa/LTPABasedSecurityCheck.java) security check:

```java
 String principal = WSSubject.getCallerPrincipal();
```

This line returns the caller [Principal](https://docs.oracle.com/javase/7/docs/api/java/security/Principal.html) name.

To get the [Subject](https://docs.oracle.com/javase/7/docs/api/javax/security/auth/Subject.html) that provides additional user information, such as the user's OU, Groups, or Privileges, use the following code:

```java
WSSubject.getCallerSubject()
```

> Note: You can add attributes can be added to the AuthenticatedUser by using the `user.getAttributes()` map.

The [ltpa-based-security-check](https://github.com/mfpdev/ldap-and-ltpa-sample/tree/master/ltpa-based-security-check) security check is checking for existing principal (which comes from the LTPA request cookie):

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
