---
title: Implementing social Login Authentication with IBM MobileFirst Platform Foundation 8.0 Beta
date: 2016-04-06
tags:
- MobileFirst_Platform
- Authentication
- Adapters
author:
  name: Ishai Borovoy
---

## Introduction
[Social Login](https://www.wikiwand.com/en/Social_login) has become a common authentication method in many mobile apps.  The app owners and the users understand the big value it gives them.  Users can now sign in to apps with their favorite social platform like Facebook or Google.  This method makes life easier for the users, and also can give the app owner ability to leverage the information from the social platform (e.g. profile picture, users friends, feed etc). App owners can maximize the user engagements with such capabilities.  

This blog post is taking into a consideration that you have basic knowledge about *IBM MobileFirst Platform Foundation 8.0 Beta* authentication and security checks, if not please refer to [the Authentication and Security tutorial](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/).  

The [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login) in this blog can be easily reused for your own needs. The sample includes social providers as [Facebook](https://developers.facebook.com/docs/facebook-login) and [Google](https://developers.google.com/identity/), which can be easily extended by adding more social providers like Twitter.

## See in action
Here is short YouTube demo movie which shows an app using the [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login).

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/DGqNbpBZ8sU"></iframe>
  </div>
</div>

## Running the demo
In order to run this demo, review the instructions in the [sample's repository.](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample)

## Let's see the big picture
![login flow]({{site.baseurl}}/assets/blog/2016-04-06-social-login-with-ibm-mobilefirst-platform-foundation/login-flow.png)

The diagram above shows the login flow (described with Google, and relevant to Facebook or other social providers as well), meaning that the trigger to call the social providers is initiated by client.

1. The User presses Google Sign In button.  
2. The Google Android SDK is calling to Google Sign-In REST Service.  
3. The access token from Google received and the App is calling to login API with scope social-login and credentials (vendor + token).  
4. The MFPF's SDK send the credentials and scope to the Authorization Server API.  
5. The Authorization API called the mapped security check social-login to validate the credentials.  
6. The social-login security check is validating the Google token with it's web client id from the security check configuration.  
7. The social-login return to the authenticated user to the Authorization Server API.  
8. The Authorization Server API return the authenticated user data to the MFPF's SDK.  
9. The MFPF's SDK is calling to the handleSuccess method in the challenge handler with the authenticated used data.  
10. The MFPF's SDK is calling to login success callback on the app.  

## Diving into some code  

### The Social Login Security Check Project  

This project is a [Java adapter maven project](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/devref/c_maven_adapters.html?lang=en) which contains the code that is able to validate the social platform credentials back from the client.
From the the file structure of the project we can learn that it is extendable, so you can add more social provide / vendor into it.  

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

The social login security check is  responsible for validating the challenge which was sent from client with the social platform token.  
The security check expects to get the JSON response from the app as described:

```json
{
  "vendor" : "...",
  "token"  : "..."
}
```  

The **SocialLoginSecurityCheck** extends from **UserAuthenticationSecurityCheck.java** which is part of the [security-check base classes](http://www.ibm.com/support/knowledgecenter/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/c_security_checks_impl.html?lang=en) of the platform.  
The validation of the credentials happens in **validateCredentials** function:

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

[*GoogleSupport.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/GoogleSupport.java) and [*FacebookSupport.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/FacebookSupport.java) implements the [*LoginVendor.java*](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/social-login/src/main/java/net/mfpdev/sample/socialogin/LoginVendor.java) interface. Each login vendor class responsible to validate the specific social login user and creating the authenticated user by implementing the method *validateTokenAndCreateUser*.  You can add additional vendor by implementing *LoginVendor.java* (e.g. In orVendor.java).  

***SocialLoginConfiguration.java***  
  The configuration class contains the configurations, as well the vendors.
  Each deployment or configuration change will create new instance of this class.
  Upon class creation The `keepOriginalToken` property will be set to a new value (if changed) and the `setConfiguration` method for each vendor will be called to set specific configuration for vendor (e.g. google.clientId for GoogleSupport).


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

The main and the only activity class in the app. In this activity the user can choose his favorite social platform for login, or he can directly call fetch the protected resource without do explicit login.  The meaning of calling preemptive login is that the app is asks the server to log on the current user with particular security check name - *socialLogin*.  Once login is successfully done, the current user will be logged in on the server.  This sample using login in order to let the user decide which social platform to logged-in with.

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

Calling to protected resource directly without call to preemptive login can be done as well, which means you don't need to call to preemptive login if you don't really need it in your app business logic.  Here is a code snippet from the sample app that call to the protected resource */hello*

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
IBM MobileFirst Platform Foundation 8.0 beta
