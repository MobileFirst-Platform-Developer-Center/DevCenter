---
title: Implementing Social Login Authentication with IBM MobileFirst Platform Foundation 8.0
date: 2016-04-06
tags:
- MobileFirst_Platform
- Authentication
- Adapters
- Security_Checks
version:
- 8.0
author:
  name: Ishai Borovoy
---

## Introduction
[Social Login](https://www.wikiwand.com/en/Social_login) has become a common authentication method in many mobile apps.  App owners and users understand the big value it gives them. Users can now sign in to apps from their favorite social platform, such as Facebook or Google.  This method makes life easier for the users, and also can give the app owner the ability to leverage the information from the social platform (for example, profile picture, users friends, feed, etc). App owners can maximize the user engagements with such capabilities.  

This blog post assumes that you have basic knowledge about *IBM MobileFirst Platform Foundation 8.0* authentication and security checks. If it's not the case, refer to [the Authentication and Security tutorial](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/).  

You can easily reuse the [Social Login security check](https://github.com/mfpdev/social-login-sample/tree/master/social-login-security-check) in this blog for your own needs. The sample includes social providers as [Facebook](https://developers.facebook.com/docs/facebook-login) and [Google](https://developers.google.com/identity/), which you can easily extend by adding more social providers, like Twitter.

## See in action
Here is a short YouTube demo movie which shows an app that's using the [Social Login security check](https://github.com/mfpdev/social-login-sample/tree/master/social-login-security-check).

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/DGqNbpBZ8sU"></iframe>
  </div>
</div>

## Running the sample
To run this sample, review the instructions in the [sample's repository.](https://github.com/mfpdev/social-login-sample)

## The big picture
![login flow]({{site.baseurl}}/assets/blog/2016-04-06-social-login-with-ibm-mobilefirst-platform-foundation/login-flow.png)

The diagram above illustrates the login flow (here described with Google but also relevant to Facebook or other social providers). The diagram shows that the trigger to call social providers is initiated by the client.

1. The user presses Google Sign In button.  
2. The Google Android SDK calls the Google Sign-In REST service.  
3. The access token from Google is received and the App calls the login API, with scope social-login and credentials (vendor + token).  
4. The MFP SDK sends the credentials and scope to the Authorization Server API.  
5. The Authorization API calls the mapped security check social-login to validate the credentials.  
6. The social-login security check validates the Google token with its web client identifier from the security check configuration.  
7. The social-login returns the authenticated user to the Authorization Server API.  
8. The Authorization Server API returns the authenticated user data to the MFP SDK.  
9. The MFPSDK calls the handleSuccess method in the challenge handler with the authenticated user data.  
10. The MFP SDK calls login success callback on the app.  

## Diving into some code  

### The Social Login Security Check Project  

This project is a [Java adapter maven project](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/devref/c_maven_adapters.html?lang=en) which contains the code to validate the social platform credentials back from the client.
From the the file structure of the project, we can see that it is extendable, so that you can add more social providers or vendors to it.  

```xml
├── src
│   └── main
│       ├── adapter-resources
│       │   └── adapter.xml
│       └── java
│           └── com
│               └── github
│                   └── mfpdev
│                       └── sample
│                           └── socialogin
│                               ├── FacebookSupport.java
│                               ├── GoogleSupport.java
│                               ├── LoginVendor.java
│                               ├── SocialLoginConfiguration.java
│                               └── SocialLoginSecurityCheck.java
```

***SocialLoginSecurityCheck.java***  

The social login security check is responsible for validating the challenge that was sent from the client with the social platform token.  
The security check expects to get the JSON response from the app as described:

```json
{
  "vendor" : "...",
  "token"  : "..."
}
```  

The **SocialLoginSecurityCheck** extends from **UserAuthenticationSecurityCheck.java** which is part of the [security-check base classes](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/c_security_checks_impl.html?lang=en) of the platform.  
Credentials are validated by the **validateCredentials** function:

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

***LoginVendor.java*** **GoogleSupport.java** **FacebookSupport.java**  

[*GoogleSupport.java*](https://github.com/mfpdev/social-login-sample/blob/master/social-login-security-check/src/main/java/com/github/mfpdev/sample/socialogin/GoogleSupport.java) and [*FacebookSupport.java*](https://github.com/mfpdev/social-login-sample/blob/master/social-login-security-check/src/main/java/com/github/mfpdev/sample/socialogin/FacebookSupport.java) implements the [*LoginVendor.java*](https://github.com/mfpdev/social-login-sample/blob/master/social-login-security-check/src/main/java/com/github/mfpdev/sample/socialogin/LoginVendor.java) interface. Each login vendor class is responsible for validating the specific social login user and for creating authenticated users by implementing the *validateTokenAndCreateUser* method. You can add more vendors by implementing *LoginVendor.java* (for example, In orVendor.java).  

***SocialLoginConfiguration.java***  
  The configuration class contains the configurations and vendors.
  Each deployment or configuration change creates a new instance of this class.
  Upon class creation, the `keepOriginalToken` property is set to a new value (if changed) and the `setConfiguration` method for each vendor is called to set a specific configuration for a vendor (for example, google.clientId for GoogleSupport).


### The HelloSocialUser Project
This is the [Java adapter maven project](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/devref/c_maven_adapters.html?lang=en) that is protected by the social login security check.

***HelloSocialUserResource.java***

To protect a Java resource adapter, you add `@OAuthSecurity` with the name of the security check or OAuth scope.  
In the following case, the `/hello` resource is protected with OAuth scope name `socialLogin`. The `@Context` block adds a security context. From  the security context, the authenticated user and his attributes are retrieved.  

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

To take benefit of the social login, you can retrieve some user attributes that the security check added, such as the *social vendor name* or the *original social vendor token*:  

```java
//Getting the social vendor
String socialLoginVendor = userAttributes.get("socialLoginVendor");
//Getting the original social vendor token
String socialLoginVendor = userAttributes.get("originalToken");
```


### The SocialLoginSample app
***SocialLoginChallengeHandler.java***

In most cases, to call protected resources with custom OAuth scope, you need a custom [challenge handler]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/user-authentication/android/). Here is the challenge handler code that triggers the social login flow and sends the challenge response that contains the vendor and the social platform token.

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

The main and only activity class in the app. In this activity, the user can choose his favorite social platform for login, or he can directly fetch the protected resource without explicit login. Calling preemptive login means that the app asks the server to log on to the current user with a particular security check name: *socialLogin*. After successful login, the current user is logged in to the server.  This sample uses login to let the user decide which social platform to log in to.

Here is a code snippet from the sample app which calls preemptive login with a security check named *socialLogin*:

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

You can also call a protected resource directly without calling preemptive login, which means that you don't need to call preemptive login if you don't really need it in your app business logic.  Here is a code snippet from the sample app which calls the protected resource */hello*

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
