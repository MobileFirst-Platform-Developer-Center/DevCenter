---
layout: tutorial
title: Enrollment
breadcrumb_title: Enrollment
relevantTo: [android,ios,windows,javascript]
weight: 10
---
## Overview
This sample demonstrates custom enrollment process and step-up authorization. There is a one time enrollment process during which the user is required to enter his username and password and define a pin code.  

**Prerequisites:**

#### Jump to:

## Application Flow

* When the application starts for the first time (before enrollment) it shows the UI with two buttons: "Get public data" and "Enroll".
* When the user starts enrollment (taps on the "Enroll" button) he is prompted with login form and then he is requested to set a pin code.
* After successfully enrolled, the UI includes four buttons: "Get public data", "Get balance", "Get transactions" and "Logout".  
The user can access all four buttons without entering the pin code.
* When the application is started for the second time (after enrollment) the UI includes all four buttons but accessing the "Get transactions" button requires the pin code.
There are three attempts for entering the pin code, after that the user is prompted to authenticate with the username and password and re-setting a pin code.

## Persistent Attributes

## Security Checks
### EnrollmentPinCode

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

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
### EnrollmentUserLogin
The `EnrollmentUserLogin` is identical to the `UserLogin` security check explained in the [Implementing the UserAuthenticationSecurityCheck](../user-authentication/security-check) tutorial except for an extra `isLoggedIn` method.

The `isLoggedIn` method returns `true` if the security check state equals SUCCESS and `false` otherwise:

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```
### IsEnrolled


## Adapter Resources
The resources and their required scopes are defined as follows:

1. `getPublicData` - always granted.

    ```java
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @Path("/publicData")
    public String getPublicData(){
      return "Lorem ipsum dolor sit amet, modo oratio cu nam, mei graece dicunt tamquam ne.";
    }
    ```
2. `getBalance` - protected by the "accessRestricted" scope that is mapped to isEnrolled security check.

    ```java
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @OAuthSecurity(scope = "accessRestricted")
    @Path("/balance")
    public String getBalance(){
      return "19938.80";
    }
    ```
3. `getTransactions` - protected by the "transactionsPrivilege" scope that is mapped to IsEnrolled and EnrollmentPinCode security checks.

    ```java
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @OAuthSecurity(scope = "transactionsPrivilege")
    @Path("/transactions")
    public String getTransactions(){
      return "{'date':'12/01/2016', 'amount':'19938.80'}";
    }
    ```
4. `isEnrolled` - always granted.

    ```java
    @GET
    @Path("/isEnrolled")
    public boolean isEnrolled(){
      PersistentAttributes protectedAttributes = adapterSecurityContext.getClientRegistrationData().getProtectedAttributes();
      return (protectedAttributes.get("pinCode") != null);
    }
    ```
5. `setPinCode` - protected by the "setPinCode" scope that is mapped to EnrollmentUserLogin security check.

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
6. `deletePinCode` - protected by the "deletePinCode" scope that is mapped to IsEnrolled security check.

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
