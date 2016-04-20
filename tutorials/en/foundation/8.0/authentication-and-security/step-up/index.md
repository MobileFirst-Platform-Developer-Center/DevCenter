---
layout: tutorial
title: Step Up Authentication
breadcrumb_title: Step Up Authentication
relevantTo: [android,ios,windows,cordova]
weight: 5
---
## Overview

Resources can be protected by several security checks. In this case the MobileFirst server will send to the client the all the relevant challenges simultaneously.  

Sometimes a security check may be dependent on another and you want to control when the challenges will be sent.  
For example in this tutorial, we'll describe an application that has some resources protected by a username and password, while some resources require an additional PIN code.

> Prerequisites: credentials-validation and user-authentication

## Referencing a security check

Create two security checks: `StepUpPinCode` and `StepUpUserLogin`. Their initial implementation is the same as described in the [credentials validation](../credentials-validation/security-check/) and [user authentication](../user-authentication/security-check/) tutorials.

In our example, `StepUpPinCode` **depends on** `StepUpUserLogin`. The user should only be asked to enter a PIN code if he successfully logged in to `StepUpUserLogin`.

To do so, `StepUpPinCode` needs to be able to **reference** the `StepUpUserLogin` class.  

The MobileFirst framework provides an annotation to inject a reference. In your `StepUpPinCode` class, at the class-level, add:

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Important:** Both security check's implementations need to be bundled inside the same adapter.

To resolve this reference the framework looks up for a security check with appropriate class, and injects its reference into the dependent security check.  
If there are more than one security checks of the same class, the annotation has an optional `name` parameter that can be used to specify the unique name of the referred check.

## State machine

All classes that extend `CredentialsValidationSecurityCheck` (which includes both `StepUpPinCode` and `StepUpUserLogin`) inherit a simple state machine. At any given moment, the security check can be in one of these states:

- `STATE_ATTEMPTING`: A challenge has been sent and the security check awaits to the client response. The attempt count is maintained during this state.
- `STATE_SUCCESS`: The credentials have been successfully validated.
- `STATE_BLOCKED`: The maximum number of attempts has been reached and the check is in locked state.

The current state can be obtained using the inherited `getState()` method.

In `StepUpUserLogin`, add a convenience method to check if the user is currently logged in:

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## The authorize method

The `SecurityCheck` interface defines a method called `authorize`. This method is responsible for implementing the main logic of the security check, such as sending a challenge or validating the request.  
The class `CredentialsValidationSecurityCheck`, which `StepUpPinCode` extends, already includes an implementation for this method. However in our case we want to check the state of `StepUpUserLogin` before starting the default behavior of the `authorize` method.

To do so, **override** the `authorize` method:

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

This implementation checks the current state of the `StepUpUserLogin` reference. If the state is `STATE_SUCCESS` (meaning the user is logged in), then we continue the normal flow of the security check. If `StepUpUserLogin` is in any other state, nothing is done (no challenge will be sent, no success nor failure).

- Assuming the resource is protected by **both** `StepUpPinCode` and `StepUpUserLogin`, this flow makes sure that the user is logged in before we ask for the secondary credential (PIN code). The client will never receive both challenges at the same time, even though both security checks are activated.
- Alternatively, if the resource is protected **only** by `StepUpPinCode` (meaning the framework will only activate this security check), you can change the `authorize` implementation to trigger `StepUpUserLogin` manually:

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        //If StepUpUserLogin is successful, continue the normal processing of StepUpPinCode
        super.authorize(scope, credentials, request, response);
    } else {
        //In any other case, process StepUpUserLogin instead.
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## Retrieve current user
In `StepUpPinCode`, we are interested in knowing the current user's ID so we can lookup this user's PIN code in some database.

In `StepUpUserLogin`, add the following method to obtain the current user from the **authorization context**:

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

In `StepUpPinCode` you can then use `userLogin.getUser()` to get the current user from the `StepUpUserLogin` security check, and check the valid PIN code for this specific user:

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    //Get the correct PIN code from the database
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## Challenge handlers
In the client-side, there are no special APIs of challenge handler to handle steps. Rather, each challenge handler should handle its own challenge. In this example you need to register two separate challenge handlers: One to handle challenges from `StepUpUserLogin` and one to handle challenges from `StepUpUserLogin`.

## Sample

[Download](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) the Security Checks Maven project.

- deploy resource adapter
- deploy StepUp
- register one of the client samples
- map `accessRestricted` to `StepUpUserLogin`
- map `transferPrivilege` to both `StepUpUserLogin` and `StepUpPinCode`

Users: See the `UserManager.java` file for a list of valid users.
