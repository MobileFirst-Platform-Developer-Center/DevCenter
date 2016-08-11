---
title: Limit the Number of Devices per Authenticated User with IBM MobileFirst Foundation 8.0
date: 2016-08-07
version:
- 8.0
tags:
- MobileFirst_Foundation
- Authentication
- Adapters
author:
  name: Ishai Borovoy
additional_authors:
- Carmel Schindelhaim
---
## Introduction

Imagine you are a CIO of a big airline company. Your company just decided to invest in a shiny new in-flight entertainment system. The system will allow passengers to bring their own devices and connect them to the In-flight entertainment system. To help grow the company revenue, you decide to let the passengers buy a premium entertainment package, so they will be able to watch the latest movies and series on their devices.

<img alt="In-flight Entertainment system in planes" src="{{site.baseurl}}/assets/blog/2016-08-07-limit-the-number-of-devices-per-authenticated-user/cabin.jpg" style="float:right;margin: 10px"/>

A few months after launch, you realize that the revenue from the premium program is not as you expected. Since you let users watch premium programs from the same account on multiple devices, users have been sharing their credentials with others. But you are not a low cost company. You give your passengers a great deal of value, and you expect to get value in return.

During your next board meeting, you raise the issue, and the board decides to try to raise revenue by controlling the number of devices that can connect to the In-flight entertainment system from the same account.

This move turns out to be successful, as your company starts seeing positive revenue growth from the in flight entertainment investment.

With IBM MobileFirst Foundation 8.0 it is easy to enforce such policy, and you can even make aspects of the policy configurable, such as how many devices you allow one account to use, so you can adjust them dynamically, without having to publish a new version of the app. You can also decide what action to take if a user has reached the limit. Either block access on the current device, or force log-out from other devices.
Using embedded MobileFirst Foundation components such the Authorization Server, Security Framework, and Registration service will simplify your development process, and shorten the amount of code you need to write yourself.

## Running the sample
To run the sample application [see the sample's README.md](https://github.com/mfpdev/user-login-with-max-devices-sample).

## Short Demo Of The Sample
<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/Hh11_AVWTVo"></iframe>
  </div>
</div>   
<br>

## Technical overview

### Configuration
This sample uses a UserLoginWithMaxDevices Security Check that extends the [UserLogin Security Check](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/user-authentication/security-check/) Security Check, adding two new configurable attributes:

- The maximum devices per authenticated user - `maxDevices`
- The policy which defines what action to take if the number of devices per authenticated user reaches the allowed limit - `autoLogout`

You can configure the values of those attributes either before deploying the adapter, in the [adapter.xml file](https://github.com/mfpdev/user-login-with-max-devices-sample/blob/master/UserLoginWithMaxDevicesSecurityCheck/src/main/adapter-resources/adapter.xml) Or after deploying the adapter, from the MobileFirst Operations Console:

![login flow]({{site.baseurl}}/assets/blog/2016-08-07-limit-the-number-of-devices-per-authenticated-user/console.png)

### Implementation
Each call to `validateCredentials` checks how many devices the user is currently logged-in on by looking this up in the MobileFirst Foundation registration service.

#### [UserLoginWithMaxDevices.java](https://github.com/mfpdev/user-login-with-max-devices-sample/blob/master/UserLoginWithMaxDevicesSecurityCheck/src/main/java/com/github/mfpdev/sample/UserLoginWithMaxDevices.java)

```java
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey(USERNAME) && credentials.containsKey(PASSWORD)){
        ...
        ...
        // Check if the user is allowed to continue with login process
        if (!isCurrentDeviceAllowedToLogin(username)) {
            errorMsg = "you've reached the maximum of allowed devices";
            return false;
        }
        ...
        ...
    }
}
```

If the maximum allowed devices has reached the defined limit, the Security Check persists this in the registration context public attributes, so it will be available for lookup later on using the `introspect` method. Depending on the `autoLogout` configuration, the Security Check either blocks the login process on the current device, or enforces a logout on another device to allow the user to login on the current device.

```java
private boolean isCurrentDeviceAllowedToLogin(String userName) {
    boolean isAllowedToContinueWithLogin;
    ...
    ...
    if (loggedInDevices.size() < userLoginWithMaxDevicesConfig.getNumOfAllowedDevices()) {
        // There are no other logged in devices, so it's ok to continue with login process
        isAllowedToContinueWithLogin = true;
    } else {
        // Check if need to logout other devices or block the current login
        if (userLoginWithMaxDevicesConfig.isAutoLogout()) {
            loggedInDevices.get(0).getPublicAttributes().put(ENFORCE_LOGOUT_ATTRIBUTE, true);
            isAllowedToContinueWithLogin = true;
        } else {
            isAllowedToContinueWithLogin = false;
        }
    }
    ...
    ...
    return isAllowedToContinueWithLogin;
}
```

Forcing logout in another device is done in the `introspect` method of the Security Check. The method is called by any resource request that is protected with this Security Check.

```java
@Override
public void introspect(Set<String> scope, IntrospectionResponse response) {
    Boolean enforceLogout = registrationContext.getRegisteredPublicAttributes().get(ENFORCE_LOGOUT_ATTRIBUTE);
    if (enforceLogout != null && enforceLogout) {
        setState(STATE_EXPIRED);
        cleanRegistrationAttributes();
    } else {
        super.introspect(scope, response);
    }
}
```
