---
layout: tutorial
title: Enrollment
breadcrumb_title: Enrollment
relevantTo: [android,ios,windows,javascript]
weight: 10
---
## Overview
This sample demonstrates custom enrollment process and step-up authorization. There is a one time enrollment process during which the user is required to enter his username and password and define a PIN code.  

**Prerequisites:**

#### Jump to:

## Application Flow

* When the application starts for the first time (before enrollment) it shows the UI with two buttons: "Get public data" and "Enroll".
* When the user starts enrollment (taps on the "Enroll" button) he is prompted with login form and then he is requested to set a PIN code.
* After successfully enrolled, the UI includes four buttons: "Get public data", "Get balance", "Get transactions" and "Logout".  
The user can access all four buttons without entering the PIN code.
* When the application is started for the second time (after enrollment) the UI includes all four buttons but accessing the "Get transactions" button requires the PIN code.
There are three attempts for entering the PIN code, after that the user is prompted to authenticate with the username and password and re-setting a PIN code.

## Storing Data in Persistent Attributes
You can choose to save protected data in the `PersistentAttributes` object, a container for custom attributes of a registered client. It can be accessed from a security check class and from an adapter resource class.

In our sample we use the `PersistentAttributes` object in the adapter resource class to store the PIN code:

* The **isEnrolled** resource returns `true` if the **pinCode** attribute exist and `false` otherwise:

    ```java
    @GET
    @Path("/isEnrolled")
    public boolean isEnrolled(){
      PersistentAttributes protectedAttributes = adapterSecurityContext.getClientRegistrationData().getProtectedAttributes();
      return (protectedAttributes.get("pinCode") != null);
    }
    ```
* The **setPinCode** resource adds the **pinCode** attribute and calls the `AdapterSecurityContext.storeClientRegistrationData()` method to store the changes.

    ```java
    @POST
    @OAuthSecurity(scope = "setPinCode")
    @Path("/setPinCode/{pinCode}")
    public Response setPinCode(@PathParam("pinCode") String pinCode){
      ClientData clientData = adapterSecurityContext.getClientRegistrationData();
      clientData.getProtectedAttributes().put("pinCode", pinCode);
      adapterSecurityContext.storeClientRegistrationData(clientData);
      return Response.ok().build();
    }
    ```
* The **deletePinCode** resource delete the **pinCode** attribute and calls the `AdapterSecurityContext.storeClientRegistrationData()` method to store the changes.

    ```java
    @DELETE
    @Path("/deletePinCode")
    public Response deletePinCode(){
      ClientData clientData = adapterSecurityContext.getClientRegistrationData();
      if (clientData.getProtectedAttributes().get("pinCode") != null){
        clientData.getProtectedAttributes().delete("pinCode");
        adapterSecurityContext.storeClientRegistrationData(clientData);
      }
      return Response.ok().build();
    }
    ```

## Security Checks
The Enrollment sample contains three security checks:

### EnrollmentUserLogin
The `EnrollmentUserLogin` should expire quickly, it should hold only for the duration of "first time experience".
It is identical to the `UserLogin` security check explained in the [Implementing the UserAuthenticationSecurityCheck](../user-authentication/security-check) tutorial except for an extra `isLoggedIn` method.

The `isLoggedIn` method returns `true` if the security check state equals SUCCESS and `false` otherwise:

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```

### EnrollmentPinCode
The `EnrollmentPinCode` security check is protecting the **Get transactions** resource and is similar to the `PinCodeAttempts` security check explained in the [Implementing the CredentialsValidationSecurityCheck](../credentials-validation/security-check) tutorial except for a few changes.

* In this tutorial's example, `EnrollmentPinCode` **depends on** `EnrollmentUserLogin`. The user should only be asked to enter a PIN code if a successful login to `EnrollmentUserLogin` previously happened.

    ```java
    @SecurityCheckReference
    private transient EnrollmentUserLogin userLogin;
    ```
* When the application starts **for the first time** and the user is successfully enrolled, we want him to be able to access the **Get transactions** resource without having to enter the PIN code he just set. To do so, in our `authorize` method, we use the `EnrollmentUserLogin.isLoggedIn` method to check if the user is logged in. This means that as long as `EnrollmentUserLogin` is not expired the user can access **Get transactions**.

    ```java
    @Override
    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
        PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
        if (userLogin.isLoggedIn()){
            setState(STATE_SUCCESS);
            response.addSuccess(scope, userLogin.getExpiresAt(), getName());
        }
    }
    ```
When the user fails to enter the PIN code after three attempts, we want to delete the pinCode attribute before he is prompted to authenticate with the username and password and re-setting a PIN code.

    ```java
    @Override
    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
        PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
        if (userLogin.isLoggedIn()){
            setState(STATE_SUCCESS);
            response.addSuccess(scope, userLogin.getExpiresAt(), getName());
        } else {
            super.authorize(scope, credentials, request, response);
            if (getState().equals(STATE_BLOCKED)){
                attributes.delete("pinCode");
            }
        }
    }
    ```
* The `validateCredentials` method is the same as in `PinCodeAttempts` security check except that in here we compare the credentials to the stored pinCode attribute.

    ```java
    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
        if(credentials!=null && credentials.containsKey("pin")){
            String pinCode = credentials.get("pin").toString();

            if(pinCode.equals(attributes.get("pinCode"))){
                errorMsg = null;
                return true;
            }
            else {
                errorMsg = "Pin code is not valid. Hint: " + attributes.get("pinCode");
            }
        }
        else{
            errorMsg = "Pin code was not provided";
        }
        //In any other case, credentials are not valid
        return false;
    }
    ```

### IsEnrolled
## Creating the Security Check
[Create a Java adapter](../../../adapters/creating-adapters) and add a Java class named `IsEnrolled` that extends `ExternalizableSecurityCheck`.

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

* In case the "pinCode" attribute exist:

 * Set the state to SUCCESS by using the `setState` method.
 * Add success to the response object by using the `addSuccess` method.

* In case the "pinCode" attribute doesn't exist:

 * Set the state to EXPIRED by using the `setState` method.
 * Add failure to the response object by using the `addFailure` method.
