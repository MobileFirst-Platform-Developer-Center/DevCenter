---
title: Implementing SMS One-Time-Password Authentication with IBM MobileFirst Foundation 8.0
date: 2016-07-18
tags:
- MobileFirst_Foundation
- Authentication
- Adapters
- OTP
- SMS
version:
- 8.0
author:
  name: Ishai Borovoy
---

## Introduction
[SMS One-Time-Password(OTP)](https://www.wikiwand.com/en/One-time_password) is essential authentication method in every modern mobile application.  SMS authentication and/or number verification gives your app good balance between security and user experience. More and more retails and banking apps use this method as their main authentication method.

In this blog I want to introduce a new [sample](https://github.com/mfpdev/sms-one-time-password-sample) which using the SMS OTP method for device/user authentication.  The sample demonstrates registration of a phone number using the client [registration-data API on the server](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-mfp-server/html/com/ibm/mfp/server/registration/external/model/ClientData.html), and then how to authenticate with an SMS OTP.

As the SMS vendor, the sample uses [Twilio](https://www.twilio.com/).  Twilio provides a free trial for a limited period. The fact that the Security Check Adapter is a [maven project](https://maven.apache.org/) make it easy to add the [Twilio Java SDK](https://www.twilio.com/docs/libraries/java) as dependency in the [pom.xml](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/pom.xml) file.

```xml
...
<dependency>
	<groupId>com.twilio.sdk</groupId>
	<artifactId>twilio-java-sdk</artifactId>
	<version>6.3.0</version>
</dependency>
...
```

This blog post assumes that you have basic knowledge about *IBM MobileFirst Foundation 8.0* authentication and security checks. If it's not the case, refer to [the Authentication and Security tutorial](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/).  
If you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn how to work with the sample.

## Running the sample
To run this sample, review the instructions in the [sample's repository.](https://github.com/mfpdev/sms-one-time-password-sample)

## The big picture
![login flow]({{site.baseurl}}/assets/blog/2016-07-18-sms-otp-with-ibm-mobilefirst-foundation/Architecture.png)

The diagram above illustrates the login flow (here described with Google but also relevant to Facebook or other social providers). The diagram shows that the trigger to call social providers is initiated by the client.

1. On application load it sends request `/phone/isRegistered` to the security check adapter, and toggle buttons in response
2. In case the user is not registered he presses the `Register` button.  
3. Request `/phone/register/{request}` is sent to the security check adapter, and as result the phone is registered on the server registration data.
From that time the security context can access to that number.
4. The user presses on the `Login` button which invoke the `obtainAccessTokenForScope` API and start the OAuth flow with the MobileFirst Foundation server.
5. The `sms-otp` Security Check on the server gets the registered phone number and send SMS with random code.  The code is saved for later validation.  
6. The Authorization API calls the mapped security check social-login to validate the credentials.  
7. The challenge response is sent back to server with the code, and if all correct the token flow is continue until client gets new OAuth token.
The client now can use that token to call to any protected resource which has scope that map to `sms-otp` Security Check.

## Registering the phone number
##### [SMSOTPResource.java](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/src/main/java/com/github/mfpdev/sample/smsOTP/SMSOTPResource.java)

```java
public String registerPhoneNumber(@PathParam("phoneNumber") String phoneNumber) {
    ...

    //Store the phone number in registration service
    clientData.getProtectedAttributes().put(SMSOTPSecurityCheck.PHONE_NUMBER, phoneNumber);
    securityContext.storeClientRegistrationData(clientData);

    ...
}
```

## Sending the SMS code as a challenge
##### [SMSOTPSecurityCheck.java](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/src/main/java/com/github/mfpdev/sample/smsOTP/SMSOTPSecurityCheck.java)
```java
@Override
protected Map<String, Object> createChallenge() {
   final PersistentAttributes registeredProtectedAttributes = registrationContext.getRegisteredProtectedAttributes();

   Map<String, Object> challenge = new HashMap<>();

   int sentSmsCode = sendSMSCode(phoneNumber);
   if (sentSmsCode != SMS_SEND_FAILURE) {
       smsCode = String.valueOf(sentSmsCode);
       challenge.put(CHALLENGE, SMS_CODE);
   }
   return challenge;
}
```

## Validating the SMS code
##### [SMSOTPSecurityCheck.java](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/src/main/java/com/github/mfpdev/sample/smsOTP/SMSOTPSecurityCheck.java)
```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    String receivedSmsCode = (String) credentials.get(CODE_KEY);
    return receivedSmsCode != null && !receivedSmsCode.isEmpty() && receivedSmsCode.equals(smsCode);
}
```

## Configuration
You can configure the sms-otp either by editing the properties in the [adapter.xml](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/src/main/adapter-resources/adapter.xml) file followed by re-building and re-deploying the .adapter file, or by editing the adapter properties directly from MobileFirst Console.  In the [SMSOTPSecurityCheckConfig.java](https://github.com/mfpdev/sms-one-time-password-sample/blob/master/sms-otp/src/main/java/com/github/mfpdev/sample/smsOTP/SMSOTPSecurityCheckConfig.java) you can do the online validation for the Twilio account, and fail the deployment or warn the admin if the account data is incorrect
![SMS OTP configuration]({{site.baseurl}}/assets/blog/2016-07-18-sms-otp-with-ibm-mobilefirst-foundation/Configuration.png)
