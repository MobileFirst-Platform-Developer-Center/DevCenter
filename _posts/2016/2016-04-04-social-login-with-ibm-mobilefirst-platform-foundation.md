---
title: Social Login With IBM MobileFirst Platform Foundation
date: 2016-04-04
tags:
- MobileFirst_Platform
- Authentication
- Adapters
author:
  name: Ishai Borovoy
---

# Social Login Authentication with IBM MobileFirst Platform Foundation

## Introduction

[Social Login](https://www.wikiwand.com/en/Social_login) become very common authentication method in many apps.
Many users can use such method with their favorite social platform like Facebook or Google.
This method makes life easy for the users, and also can gives the app owner ability to leverage the information from the social platform.
This give the app owner the ability to engage more users and to know more about their users.  

The Social Login security check adapter in this blog can be easily reused.  

## Prerequisites
* [Installed Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [Registered Facebook Android App](https://developers.facebook.com/docs/android/getting-started)
* [Registered Google Sign-In App for Android](https://developers.google.com/identity/sign-in/android/start-integrating#get-config)
* [Installed Android Studio](Registered Facebook OAuth 2.0 Android App)
* [Installed Maven](https://maven.apache.org/install.html)

## What user can do from the sample app
* The sample allow user to choose their Authentication method by login to Facebook or Google.
* After successfully logged-in user can call the `/hello` resource which protected with "socialLogin" OAuth scope.
* The user can also choose to call `/hello` resource without login first, then the default social vendor on the server will be used to authenticate the user.

## Running the sample
* Start by cloning the Git repository - [MobileFirst 8.0.0 advanced samples and extension modules](https://github.com/mfpdev/mfp-advanced-adapters-samples)

#### Cloning the Git repository

* Clone the following repository https://github.com/mfpdev/mfp-advanced-adapters-samples`

* From the above repository you will need three folders:

  1. [Social Login security check](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-login) - The social login [security check](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/) adapter.

  2. [HelloSocialUser Adapter](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/HelloSocialUserAdapter) - The JAX-RS resource adapter which protect with the scope `socialLogin`.

  3. [SocialLoginApp](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/SocialLoginApp) - The sample native android application.

#### Configuring the Android app
* `string.xml`
  * Open the android app [SocialLoginApp](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/SocialLoginSample/SocialLoginApp) in Android Studio.
  * Edit the file `string.xml`, there you need supply the following:
    * Facebook App ID from [Facebook Apps Console](https://developers.facebook.com/apps/)

    * ![Facebook APP ID]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/FacebookAppID.png)

    * Google Web Client ID from [Google API Console](https://console.developers.google.com/apis/credentials).

    * ![Google Client ID]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/GoogleClientID.png)

    * For the Google SignIn you also need to get the [google-services.json](https://developers.google.com/identity/sign-in/android/start-integrating#prerequisites) file.
* `mfpclient.properties`
    * Insure that `mfpclient.properties` point to correct server host and port (`10.0.2.2` means localhost)

  ```xml
  <resources>
      ...
      <string name="facebook_app_id">Put your Facebook app id</string>
      <string name="google_server_client_id">Put your Google app id</string>
      ...
  </resources>
  ```

#### Deploying the adapters
  * IBM MobileFirst Platform gives you several options for deploying an [adapters](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/).
  * In this blog I will use the maven option.  Be sure to you can run `mvn -v` from the command line.
  * For each adapter set the configuration in the `pom.xml`, here is example for IBM MobileFirst Foundation Platform server which run on `localhost`:
  ```
  <properties>
		<!-- parameters for deploy mfpf adapter -->
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
  * From the Adapters menu click on `Social Login Adapter`, and move to `Security Checks` tab.  
  * Here you will find place to add your `google client id`.  This id will use the adapter to validate the Google account.    

  * If you need to use the social platform token later on, set the `keep original token` to be `true`.
  ![Adapter Configuration]({{site.baseurl}}/assets/blog/2016-04-04-social-login-with-ibm-mobilefirst-platform-foundation/SocialLoginConfiguration.png)
  * Press the Save button.
  * You are done

#### Register the application on IBM MobileFirst Platform Foundation Server
  * Goto server console [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
  * Under `Applications` press `new` and register your application.

#### Running the application
  * You can back to your Android Studio now and run the application. The final result should be looks like the following short movie:

  <div class="sizer"><div class="embed-responsive embed-responsive-16by9">
   <iframe src="https://www.youtube.com/embed/DGqNbpBZ8sU"></iframe>
  </div>

#### Architecture
* Let's see the big picture

### Code
  * All the code is actually available in the git repository just mentioned.  I want to show some snippet here that you can better understand how things work











## Supported Versions
IBM MobileFirst 8.0 beta or later
