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

[Social Login](https://www.wikiwand.com/en/Social_login) become very common authentication method in many apps.
Many users can use such method with their favorite social platform like Facebook or Google.
This method makes life easy for the users, and also can gives the app owner ability to leverage the information from the social platform.
This give the app owner the ability to engage more users and to know more about their users.  More then that the app owner can use the user token to get information from the user profile, picture, friends and feed.  

The Social Login security check adapter in this blog can be easily reused.  

## Prerequisites
* [Installed Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [Registered Facebook Android App](https://developers.facebook.com/docs/android/getting-started)
* [Registered Google Sign-In App for Android](https://developers.google.com/identity/sign-in/android/start-integrating#get-config)
* [Installed Android Studio](Registered Facebook OAuth 2.0 Android App)
* [Installed Maven](https://maven.apache.org/install.html)

## What user can do from the sample app
* The sample allow user to choose their Authentication method by login to Facebook or Google.
* After successfully logged-in user can call the */hello* resource which protected with "socialLogin" OAuth scope.
* The user can also choose to call */hello* resource without login first, then the default social vendor on the server will be used to authenticate the user.

## Running the sample
* Start by cloning the Git repository - [MobileFirst 8.0.0 advanced samples and extension modules](https://github.com/mfpdev/mfp-advanced-adapters-samples)

#### Cloning the Git repository

* Clone the following repository https://github.com/mfpdev/mfp-advanced-adapters-samples

* From the above repository you will need three folders:

  1. [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login) - The social login [security check](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/) adapter.

  2. [HelloSocialUser Adapter](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/HelloSocialUserAdapter) - The JAX-RS resource adapter which protect with the scope *socialLogin*.

  3. [SocialLoginApp](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/SocialLoginApp) - The sample native android application.

#### Configuring the Android app
* *string.xml*

```xml
<resources>
    ...
    <string name="facebook_app_id">Put your Facebook app id here</string>
    <string name="google_server_client_id">Put your Google web client id here</string>
    ...
</resources>
```

  * Open the android app [SocialLoginApp](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/SocialLoginApp) in Android Studio.
  * Edit the file *string.xml*, there you need supply the following:
    * Facebook App ID from [Facebook Apps Console](https://developers.facebook.com/apps/)

    * ![Facebook APP ID]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/FacebookAppID.png)

    * Google Web Client ID from [Google API Console](https://console.developers.google.com/apis/credentials).

    * ![Google Client ID]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/GoogleClientID.png)

    * For the Google SignIn you also need to get the [google-services.json](https://developers.google.com/identity/sign-in/android/start-integrating#prerequisites) file.


* *mfpclient.properties*
    * Insure that *mfpclient.properties* point to correct server host and port (*10.0.2.2* means localhost)

#### Deploying the adapters
  * IBM MobileFirst Platform gives you several options for deploying an [adapters](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/).
  * In this blog I will use the maven option.  Be sure to you can run `mvn -v` from the command line.
  * For each adapter set the configuration in the *pom.xml*, here is example for IBM MobileFirst Foundation Platform server which run on *localhost*:

```xml
<properties>
	<mfpfUrl>http://localhost:9080/mfpadmin</mfpfUrl>
	<mfpfUser>admin</mfpfUser>
	<mfpfPassword>admin</mfpfPassword>
	<mfpfRuntime>mfp</mfpfRuntime>
</properties>
```
  * From each of the 2 adapters above run the following command from root folder:
  `mvn clean install adapter:deploy`


#### Configuring the adapters

  * Goto server console [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
  * From the Adapters menu click on *Social Login Adapter*, and move to *Security Checks* tab.  
  * Here you will find place to add your *google client id*.  This id will use the adapter to validate the Google account.    
  * If you need to use the social platform token later on, set the *keep original token* to be *true*.
  * ![Adapter Configuration]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/SocialLoginConfiguration.png)

#### Register the application on IBM MobileFirst Platform Foundation Server
  * Goto server console [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
  * Under *Applications* press *new* and register your application.

#### Running the application
  * You can back to your Android Studio now and run the application. The final result should be looks like the following short movie:

  <div class="sizer"><div class="embed-responsive embed-responsive-16by9">
   <iframe src="https://www.youtube.com/embed/DGqNbpBZ8sU"></iframe>
  </div>

### Architecture
* Let's see the big picture

### Code Snippets
***HelloSocialUserResource.java*** (Part of the HelloSocialUserResource project)

Protect the resource adapter with *socialLogin* scope

```java
@OAuthSecurity(scope = "socialLogin")
public Map<String,Object> hello() {
  AuthenticatedUser user = securityContext.getAuthenticatedUser();
	Map<String, Object> userAttributes = new HashMap<String, Object>();
	userAttributes.put("displayName", user.getDisplayName());
	userAttributes.putAll(user.getAttributes());
	return userAttributes;
}
```

Getting the original token and the social platform vendor

```java
//Getting the social vendor
String socialLoginVendor = userAttributes.get("socialLoginVendor");
//Getting the original social vendor token
String socialLoginVendor = userAttributes.get("originalToken");
```

***SocialLoginSecurityCheck.java*** - (Part of the social-login project)

This class belong to the security check and is responsible for validating the challenge sent from client with the social platform token. It extends *UserAuthenticationSecurityCheck.java*. In the same package of this class you will find classes like *GoogleSupport.java* and *FacebookSupport.java*, those class implements the *LoginVendor.java* interface.  That means that actually you can add more vendors as you like like *TwitterSupport.java*.  here is the *validateCredentials* function:

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

***SocialLoginChallengeHandler.java*** - (Part of the Android app)

Handling the challenge response, this method trigger the social login in the app

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

***SocialMainActivity.java*** - (Part of the Android app)

Calling protected resource adapter

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
