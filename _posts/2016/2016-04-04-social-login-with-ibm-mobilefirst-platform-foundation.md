---
title: Social Login Authentication with IBM MobileFirst Platform Foundation
date: 2016-04-04
tags:
- MobileFirst_Platform
- Authentication
- Adapters
author:
  name: Ishai Borovoy
---

## Introduction

[Social Login](https://www.wikiwand.com/en/Social_login) become very common authentication method in many apps.  The app owners and the users understand the big value it gives them, and it become very common authentication method.
Users can now login to apps with their favorite social platform like Facebook or Google.
This method makes life easy for the users, and also can gives the app owner ability to leverage the information from the social platform like profile picture, users friends feed. App owner can maximize the user engagements with such abilities.  Now in IBM MobileFirst Platform adding such method become easy with version 8.0.

The [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login) in this blog can be easily reused. The sample support [Facebook](https://developers.facebook.com/docs/facebook-login) and [Google](https://developers.google.com/identity/) log-in, though you can be extends it easily and add more social vendors like twitter. After deploy it into your server and configure it you will be able protect any resource adapter with it.  

It is recommended to have some basic knowledge about [Adapters](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/) and [Security Checks](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/).  

## Watch App demo
Here is short YouTube demo movie which show a very simple app using the [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login).

<div class="sizer"><div class="embed-responsive embed-responsive-16by9">
 <iframe src="https://www.youtube.com/embed/DGqNbpBZ8sU"></iframe>
</div>

## Running the demo
For running the demo on your environment following instructions[mfpdev github repository](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample)

## Let's see the big picture

## Dive into some code

### The Social Login Security Check Project

This project is [Java adapter maven project](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/devref/c_maven_adapters.html?lang=en) which contains the code which able to validate the social platform credentials back from the client.
From the the file structure of the project we can learn that it is extendable, so you can add more social vendors into it.

```xml
├── src
│   └── main
│       ├── adapter-resources
│       │   └── adapter.xml
│       └── java
│           └── net
│               └── mfpdev
│                   └── sample
│                       └── socialogin
│                           ├── FacebookSupport.java
│                           ├── GoogleSupport.java
│                           ├── LoginVendor.java
│                           ├── SocialLoginConfiguration.java
│                           └── SocialLoginSecurityCheck.java
```

***SocialLoginSecurityCheck.java***

The social login security check is the core file that mainly responsible for validating the challenge which sent from client with the social platform token.  The **SocialLoginSecurityCheck** extends from **UserAuthenticationSecurityCheck.java** which is part of the [security-check base classes](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/c_security_checks_impl.html?lang=en) of the platform. In the same package of this class you will find classes like [*GoogleSupport.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/GoogleSupport.java) and [*FacebookSupport.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/FacebookSupport.java), those class implements the [*LoginVendor.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/LoginVendor.java) interface.  That means that actually you can extends this security checks with more vendors as you like.  

Here is the **validateCredentials** function:

```java
 @Override
 protected boolean validateCredentials(Map<String, Object> credentials) {
     vendorName = (String) credentials.get(VENDOR_KEY);
     String token = (String) credentials.get(TOKEN_KEY);
     if (vendorName != null && token != null) {
         LoginVendor vendor = getConfiguration().getEnabledVendors().get(vendorName);
         if (vendor != null) {
             AuthenticatedUser user = vendor.validateTokenAndCreateUser(token, getName());
             if (user != null) {
                 Map<String, Object> attributes = new HashMap<>(user.getAttributes());
                 attributes.put(VENDOR_ATTRIBUTE, vendorName);
                 if (getConfiguration().isKeepOriginalToken())
                     attributes.put(ORIGINAL_TOKEN_ATTRIBUTE, token);
                 this.user = new AuthenticatedUser(user.getId(), user.getDisplayName(), getName(), attributes);
                 return true;
             }
         }
     }
     return false;
 }
```

### The HelloSocialUser Project
This is the [Java adapter maven project](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/devref/c_maven_adapters.html?lang=en) which protected by the social login security check.

***HelloSocialUserResource.java***

Protecting a Java resource adapter done by adding `@OAuthSecurity` with the name of the security check / OAuth scope.  
In the following case we protect the `/hello` resource with OAuth scope name `socialLogin`.  Protected resource has a securityContext which can be achieved by simple inject it with `@Context`.  From securityContext we can get the authenticated user and his attributes.  

```java
@Context
private AdapterSecurityContext securityContext;

@OAuthSecurity(scope = "socialLogin")
public Map<String,Object> hello() {
  AuthenticatedUser user = securityContext.getAuthenticatedUser();
	Map<String, Object> userAttributes = new HashMap<String, Object>();
	userAttributes.put("displayName", user.getDisplayName());
	userAttributes.putAll(user.getAttributes());
	return userAttributes;
}
```

To leverage the social login and get more value from it , we can get some userAttributes that the social login security check added, like the social *social vendor name* or the *original social vendor token*:  

```java
//Getting the social vendor
String socialLoginVendor = userAttributes.get("socialLoginVendor");
//Getting the original social vendor token
String socialLoginVendor = userAttributes.get("originalToken");
```

### The SocialLoginSample app

***SocialLoginChallengeHandler.java***

Calling to protected resource with custom OAuth scope in most cases need a custom [challenge handler](http://localhost:4000/tutorials/en/foundation/8.0/authentication-and-security/user-authentication/android/).  Here is the challenge handler code which trigger the social login flow, and send challenge response which contains the vendor and the social platform token.

```java
@Override
public void handleChallenge(JSONObject jsonObject) {
    mainActivity.runOnUiThread(new Runnable() {
        @Override
        public void run() {
          mainActivity.isSignInFromChallenge = true;
          if (mainActivity.currentVendor == SocialMainActivity.Vendor.GOOGLE) {
              mainActivity.signInWithGoogle();
          } else {
              mainActivity.signInWithFacebook();
          }
        }
    });
}
```

***SocialMainActivity.java***

The main and the only activity class in the app. In this activity the user can choose his favorite social platform for login, or he can directly call fetch the protected resource without do explicit login.  
What it is mean to call to preemptive login?  By calling to preemptive login the app tells the server just to logged-in the current user with particular security check name - *socialLogin*.  Once login is successfully done, the current user will be logged in on the server.

Here is a code snippet from sample app that call to preemptive login with security check named "socialLogin":

```java
WLAuthorizationManager.getInstance().login("socialLogin", credentials, new WLLoginResponseListener() {
    @Override
    public void onSuccess() {
        final String msg = String.format("Logged in successfully with %s", vendor);
        updateStatus(msg);
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        String msg = String.format("Logged in failed with %s", vendor);
        updateStatus(msg);
    }
});
```

Though Calling to protected resource directly without call to preemptive login can be done either, that mean you don't need to call to preemptive login if you don't really need it in your app business logic. The choice to call to preemptive login sometime good in case you need just to give log-in screen and on success move to next screen.  In most cases where you know you are going to call to specific resource it better to protect it and directly call it.  If you know the scope the resource is protected with, you can explicitly add it like the bellow code.  

Here is a code snippet from the sample app that call to the protected resource */hello*

```java
private void callProtectedAdapter() {
    WLResourceRequest wlResourceRequest = new WLResourceRequest(URI.create("/adapters/HelloSocialUser/hello"), WLResourceRequest.GET, socialLoginChallengeHandler.getSecurityCheck());
    wlResourceRequest.send(new WLResponseListener() {
        @Override
        public void onSuccess(WLResponse wlResponse) {
            ...
        }

        @Override
        public void onFailure(WLFailResponse wlFailResponse) {
            ...
        }
  });
}
```

## Supported Versions
IBM MobileFirst 8.0 beta or later
