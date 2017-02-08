---
layout: tutorial
title: Migrating Authentication and Security Concepts
breadcrumb_title: Migrating authentication concepts
downloads:
  - name: Download migration sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
weight: 3
---

<!-- ==== Overview ==== -->
## Overview
{: #overview }

The {{ site.data.keys.product_full }} security framework was significantly modified in V8.0 to improve and simplify security development and administration tasks. These changes include the replacement of the V7.1 security building blocks: in V8.0, OAuth security scopes and security checks replace the security tests, realms, and login modules of previous versions.

This tutorial guides you through the required steps for migrating the security code of your application to V8.0. The tutorial outlines the complete process for transforming a sample {{ site.data.keys.product_adj }} V7.1 application into a V8.0 application with the same security protection. Both the sample V7.1 application and the migrated V8.0 application are available for download. See the **Download migration sample** link at the start of this tutorial.

The [first part](#migrating-the-sample-application) of the tutorial explains how to migrate the sample V7.1 application to V8.0. This includes migrating the resource adapter, replacing the form-based and adapter-based authentication realms with security checks, and migrating the client application and its challenge handlers.<br />
The [second part](#migrating-other-types-of-authentication-realms) explains how to migrate to V8.0 other types of V7.1 authentication realms, which are not demonstrated in the sample application.<br />
The [third part](#migrating-other-v71-security-configurations) explains how to migrate to V8.0 additional V7.1 security configurations. This includes configuration of application-level protection, access-token expiration, and user and device identities.
{% comment %} I edited and reordered, including splitting part two into two and three - which matches the header levels in the original doc. I moved the links (which I also edited) to each second-level header ("part").
{% endcomment %}

> **Note:** Before you start the migration, you are advised to read the [V8.0 migration cookbook](../migration-cookbook).<br />
> To learn about the basic concepts of the new security framework, see [Authentication and Security](../../authentication-and-security).

<!-- ==== PART 1: Migrating the sample application ==== -->
## Migrating the sample application
{: #migrating-the-sample-application }

The starting point for this migration procedure is a sample V7.1 hybrid application. The application accesses a Java adapter that is protected with the V7.1 OAuth security model. The adapter has two methods:
*  `getBalance`, which is protected with a form-based authentication realm that implements a user-name and password login.
*  `transferMoney`, which is protected with an adapter-based authentication realm that implements a pin-code based user authorization.

Use the **Download migration sample** link at the start of this tutorial to download the source code of the V7.1 sample application and of its migrated V8.0 equivalent.

Follow these steps to migrate the sample V7.1 application to V8.0:
*  [Migrate the resource adapter](#migrating-the-resource-adapter), including the resource-protection logic.
*  [Migrate the client application](#migrating-the-client-application).
*  [Migrate the authentication realms](#migrating-rm-and-adapter-based-auth-realms) of the sample V7.1 application by replacing them with V8.0 security checks.
*  [Migrate the challenge handlers](#migrating-the-challenge-handlers) on the client side to use the new challenge-handler API.

### Migrating the resource adapter
{: #migrating-the-resource-adapter }
Start by migrating the resource adapter. In {{ site.data.keys.product }} V8.0, adapters are developed as separate Maven projects, unlike in V7.1 where adapters are part of the application project. Thus, you can migrate the resource adapter, and build and deploy the migrated adapter, independently of the client application. The same is true for the V8.0 client application, and the V8.0 security checks (which are implemented within adapters). Therefore, you can migrate these artifacts in the order of your choice. The tutorial begins with instructions for migrating the resource adapter, including an introduction the OAuth security scope elements that are used for the V8.0 resource protection.

> **Note:** 
> *  The following instructions are for the migration of the sample `AccountAdapter` resource adapter. You do not need to migrate the sample `PinCodeAdapter` because the adapter-based authentication that it implements is no longer supported in V8.0. The [Replacing the pin-code adapter-based authentication realm](#replacing-the-pin-code-adapter-based-authentication-realm) step explains how to replace the V7.1 pin-code adapter with a V8.0 security check that offers similar protection.
> *  For instructions on how to migrate adapters to V8.0, see the [V8.0 migration cookbook](../migration-cookbook).

The `AccountAdpter` methods in the V7.1 sample are protected with the `@OAuthSecurity` annotation, which defines the methods' protecting scopes (`UserLoginRealm` and `PinCodeRealm`). The same annotation is used in V8.0, but the scope elements have a different significance: in V7.1, scope elements refer to security realms that are defined in the **authenticationConfig.xml** file. In V8.0, scope elements are mapped to security checks that are defined in an adapter that is deployed to {{ site.data.keys.mf_server }}. You can select to keep the resource-protection code, including the scope-element names, unchanged. However, because the “realm” terminology is no longer used in {{ site.data.keys.product }} V8.0, the scope elements in the V8.0 application are renamed to `UserLogin` and `PinCode`:

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

#### Updating the user-identity retrieval code
{: #updating-the-user-identity-retrieval-code }

The sample resource adapter uses the server-side security API to obtain the identity of the authenticated user. This API changed in V8.0, so you need to modify the adapter code to use the updated API. In the migrated V8.0 application, remove the following V7.1 code:

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

And replace it with the following code, which uses the new V8.0 API:

```java
// Inject the security context
@Context
AdapterSecurityContext securityContext;

 // Get the authenticated user name
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```
After you edit the adapter code, build the adapter and deploy it to the server by using either Maven or the {{ site.data.keys.mf_cli }}. For more information, see [Build and Deploy Adapters](../../adapters/creating-adapters/#build-and-deploy-adapters).

### Migrating the client application
{: #migrating-the-client-application }

Next, migrate the client application. For detailed client-application migration instructions, see the [V8.0 migration cookbook](../migration-cookbook).  This tutorial focuses on the migration of the security code. At this stage, exclude the challenge-handler code by editing the application's main HTML file, **index.html**, to add a comment around the lines that import the challenge-handler code:

```html 
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

The sample application's challenge-handler code is modified later, in the [Migrating the challenge handlers](#migrating-the-challenge-handlers) step.

#### Updating the client-side API calls
{: #updating-the-client-side-api-calls }

As part of the client migration, you need to adapt to V8.0 client-side API changes. For a list of {{ site.data.keys.product }} V8.0 client-API changes, see [Upgrading the WebView](../migrating-client-applications/cordova/#upgrading-the-webview).
The sample application has one client-API change that is related to security, the logout API. The V7.1 `WL.Client.logout` method is not supported in V8.0. Instead, use the V8.0 `WLAuthorizationManager.logout` method, and pass to it the name of the security check that replaces the V7.1 authorization realm. The **Logout** button in the sample application logs the user out of both the `UserLogin` and `PinCode` security checks:

```javascript
function logout() {
    WLAuthorizationManager.logout('UserLogin').then(
        function () {
            WLAuthorizationManager.logout('PinCode').then(function () {
                $("#ResponseDiv").html("Logged out");
            }, function (error) {
                WL.Logger.debug("failure on logout from PinCode check: " +
                    JSON.stringify(error));
            });
      },
      function (error) {
          WL.Logger.debug("failure on logout from UserLogin check: " +
              JSON.stringify(error));
      });
}
```

When you complete the client-application migration steps, build the application, and then register it to your {{ site.data.keys.mf_server }} with the command `mfpdev app register`. After you successfully register your application, you can see it listed in the **Applications** section of the {{ site.data.keys.mf_console }} navigation sidebar.

### Migrating the sample application's authentication realms
{: #migrating-rm-and-adapter-based-auth-realms }

At this stage, you already have a migrated V8.0 client application and a deployed resource adapter. However, your migrated application cannot access the protected adapter resources. The reason is that the resource-adapter methods are protected by `UserLogin` and `PinCode` scope elements that are not yet mapped to any security checks. Therefore, the application cannot acquire the required access token for accessing the protected methods. To resolve this, you need to replace the V7.1 authentication realms with V8.0 security checks that map to the adapter methods' protecting scope elements.

#### Replacing the user-login form-based authentication realm
{: #replacing-the-user-login-form-based-authentication-realm }

To replace the V7.1 `UserLoginRealm` form-based authentication realm, create a V8.0 `UserLogin` security check, which performs the same authentication steps as the V7.1 form-based authenticator and custom login module: the security check should send a challenge to the client, collect the login credentials from the challenge response, validate the credentials, and create a user identity. As demonstrated in the following instructions, creating the security check is not complicated. After you create the security check, you can copy the code for validating the login credentials from the V7.1 custom login module to the new security check.

In V8.0, security checks are implemented as adapters. In {{ site.data.keys.product }} V8.0, a Java adapter can both serve resources and package security tests. However, in this migration procedure you maintain the migrated `AccountAdpter` resource adapter, and you create a separate adapter for packaging your new security check. Therefore, start by creating a new Java adapter named `UserLogin`. For detailed instructions, see [creating a new Java adapter](../../adapters/creating-adapters).

To define a `UserLogin` security check in your new `UserLogin` adapter, add a &lt;securityCheckDefinition&gt; XML element to the adapter's **adapter.xml** file, as demonstrated in the following code:

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* The `name` attribute specifies the name of your security check ("UserLogin").
* The `class` attribute specifies the Java class of the security-check implementation ("com.sample.UserLogin"). This class is created in the [next step](#creating-the-user-login-security-check-java-class).
* The `successStateExpirationSec` property is equivalent to the `expirationInSeconds` property of the V7.1 login modules. It indicates the expiration period for the security-check's successful state (meaning, the interval, in seconds, during which a successful security-check login remains valid). The default value of both of these V7.1 and V8.0 properties is 3600 seconds. If you configured a different expiration period in your V7.1 login module, edit the value of the V8.0 `successStateExpirationSec` property to set the same value.

This tutorial explains how to define only the `successStateExpirationSec` property, but you can do much more with security checks. For example, you can implement advanced features such as blocked state expiration, multiple login attempts, or a “remember me” login. You can change the default values of configuration properties, add custom properties, and modify property values at run time from the {{ site.data.keys.mf_console }} or by using the  {{ site.data.keys.mf_cli }} (**mfpdev**). For more information, see the [V8.0 security-checks documentation](../../authentication-and-security/creating-a-security-check/), and in particular [Configuring security checks](../../authentication-and-security/creating-a-security-check/#security-check-configuration).

##### Creating the user-login security-check Java class
{: #creating-the-user-login-security-check-java-class }

In your `UserLogin` adapter, create a `UserLogin` Java class that extends the {{ site.data.keys.product_adj }} `UserAuthenticationSecurityCheck` abstract base class (which in turn extends the {{ site.data.keys.product_adj }}  `CredentialsValidationSecurityCheck` abstract base class). Next, override the default implementations of the `createChallenge`, `validateCredentials`, and `createUser` base-class methods.

*  The `createChallenge` method creates the challenge object (hash map) to be sent to the client. The implementation of this method can be modified to include a challenge phrase or another type of challenge object to be used for validating the client’s response. However, for the purposes of the sample application, you only need to add to the challenge object the error message to display if an error occurs.
*  The `validateCredentials` method contains the authentication logic. Copy the authentication code that validates the user name and password from your V7.1 login module to this V8.0 method. The sample implements a basic validation logic, which verifies that the password is identical to the user name.
*  The `createUser` method is the equivalent of the `createIdentity` method of the V7.1 login module.

Following is the complete class-implementation code:

```java
public class UserLogin extends UserAuthenticationSecurityCheck {
    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null && credentials.containsKey("username") &&
		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // the authentication logic, copied from the V7.1 login module
            if (!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;

                errorMsg = null;
                return true;
            } else {
                errorMsg = "Wrong Credentials";
            }
        } else {
            errorMsg = "Credentials not set properly";
        }
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg", errorMsg);
        return challenge;
    }

    @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
    }
}
```

For more information about the `UserAuthenticationSecurityCheck` class and its implementation, see [Implementing the UserAuthenticationSecurityCheck Class](../../authentication-and-security/user-authentication/security-check/).


To complete your changes, build the `UserLogin` adapter and deploy it to the server by using either Maven or the {{ site.data.keys.mf_cli }}. For more information, see [Build and Deploy Adapters](../../adapters/creating-adapters/#build-and-deploy-adapters). After you successfully deploy the adapter, you can see it listed in the **Adapters** section of the {{ site.data.keys.mf_console }} navigation sidebar.

#### Replacing the pin-code adapter-based authentication realm
{: #replacing-the-pin-code-adapter-based-authentication-realm }

The V7.1 sample application's `PinCodeRealm` realm is implemented with adapter-based authentication, which is no longer supported in V8.0. In place of this realm, create a new `PinCode` Java adapter, and add to it a `PinCode` Java class that extends the {{ site.data.keys.product_adj }} `CredentialsValidationSecurityCheck` abstract base class.

**Note:**
*  The steps for creating the `PinCode` adapter are similar to the steps for creating the `UserLogin` adapter, as outlined in the [Replacing the user-login form-based authentication realm](#replacing-the-user-login-form-based-authentication-realm) step.
*  The `PinCode` security check only needs to validate the login credentials (the pin code), and does not need to assign a user identity. Therefore, this security-check class extends the `CredentialsValidationSecurityCheck` base class and not the `UserAuthenticationSecurityCheck` class that is used for the `UserLogin` security check.

To create a security check that extends the `CredentialsValidationSecurityCheck` base class, you need to implement the `createChallenge` and `validateCredentials` methods.

*  The `createChallenge` implementation is similar to that of the `UserLogin` security check. The `PinCode` security check does not have any special information to send to the client as part of the challenge. Therefore, you only need to add to the challenge object the error message to display if an error occurs.

   ```java
       @Override
       protected Map<String, Object> createChallenge() {
           Map challenge = new HashMap();
           challenge.put("errorMsg",errorMsg);
           return challenge;
       }
   ```

*  The `validateCredentials` method validates the pin code. In the following example, the validation code consists of a single line, but you can also copy the validation code from the V7.1 authentication adapter into this `validateCredentials` method.

   ```java
   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
       if (credentials!=null && credentials.containsKey("pin")){
           String pinCode = credentials.get("pin").toString();
           if (pinCode.equals("1234")) {
               return true;
           } else {
               errorMsg = "Pin code is not valid.";
           }
       } else {
           errorMsg = "Pin code was not provided";
       }
       return false;
   }
   ```

When you complete the migration of the V7.1 authentication realms to security checks, build the adapter and deploy it to {{ site.data.keys.mf_server }}. For more information, see [Build and Deploy Adapters](../../adapters/creating-adapters/#build-and-deploy-adapters).

### Migrating the challenge handlers
{: #migrating-the-challenge-handlers }

At this stage, you already migrated the sample resource adapter and client application, and replaced the V7.1 authentication realms with V8.0 security checks. All that remains to complete the security migration of the sample application is to migrate the client-application's challenge handlers. The client application uses the challenge handlers to respond to security challenges and send the credentials that are received from the user to the security checks.

When you [migrated the client application](#migrating-the-client-application), you excluded the challenge-handler code by commenting out the relevant lines in the application's main HTML file, **index.html**. Now, add back the application's challenge-handler code, by removing the comment that you previously added around these lines:

```html 
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
```

Then, proceed to migrate the challenge-handler code to V8.0, as outlined in the following instructions. For more information about the V8.0 challenge-handler API, see [Quick Review of Challenge Handlers in {{ site.data.keys.product }} 8.0]({{ site.baseurl }}/blog/2016/06/22/challenge-handlers/) and the `WL.Client` and `WL.Client.AbstractChallengeHandler` documentation in the V8.0 [JavaScript Client-side API Reference](../../api/client-side-api/javascript/client/).

Start with the user-login challenge handler (`userLoginChallengeHandler`), which performs the same functions in V8.0 as it does in V7.1: this challenge handler is responsible for presenting the login form to the user upon arrival of a challenge, and for sending the user name and password to {{ site.data.keys.mf_server }}. However, because the client challenge-handler API in V8.0 is different and simpler than its V7.1 counterpart, you need to make the following changes:

*  Replace the code for creating the challenge handler with the following code, which calls the V8.0 `WL.Client.createSecurityCheckChallengeHandler` method:

   ```javascript
   var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
   ```
   
   `WL.Client.createSecurityCheckChallengeHandler` creates a challenge handler that handles challenges from a {{ site.data.keys.product_adj }} security check. V8.0 also introduces a `WL.Client.createGatewayChallengeHandler` method for handling challenges from a third-party gateway, which are known in V8.0 as gateway challenge handlers. When you migrate a V7.1 application to V8.0, replace calls to the `WL.Client` `createWLChallengeHandler` or `createChallengeHandler` method with calls to the V8.0 `WL.Client` challenge-handler creation method that matches the expected challenge source. For example, if your resource is protected by a DataPower reverse proxy that sends a custom login form to the client, use `createGatewayChallengeHandler` to create a gateway challenge handler to handle the gateway challenges.

*  Remove the call to the challenge-handler `isCustomResponse` method. In V8.0, this method is no longer needed to handle security challenges.
*  Replace the implementation of the `userLoginChallengeHandler.handleChallenge` method with implementations of the V8.0 challenge-handler `handleChallenge`, `handleSuccess`, and `handleFailure` methods. V7.1 has a single challenge-handler method that checks the response to determine whether it contains a challenge or returns success or an error. V8.0 has a separate method for each type of challenge-handler response, and the security framework determines the response type and calls the appropriate method.
*  Remove the call to the `submitSuccess` method. The V8.0 security framework handles the success response implicitly.
*  Replace the call to the `submitFailure` method with a call to the V8.0 `cancel` challenge-handler method.
*  Replace the call to the `submitLoginForm` method with a call to the V8.0 `submitChallengeAnswer` challenge-handler method:

   ```javascript
   userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
   ```
   
The complete code of the challenge handler after you apply these changes is shown here:
   
```javascript
function createUserLoginChallengeHandler() {
    var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    userLoginChallengeHandler.handleChallenge = function(challenge) {
        showLoginDiv();
        var statusMsg = (challenge.errorMsg !== null) ? challenge.errorMsg : "";
        $("#loginErrorMessage").html(statusMsg);
    };

    userLoginChallengeHandler.handleSuccess = function(data) {
        hideLoginDiv();
    };

    userLoginChallengeHandler.handleFailure = function(error) {
        if (error.failure !== null) {
            alert(error.failure);
        } else {
            alert("Failed to login.");
        }
    };

    $('#AuthSubmitButton').bind('click', function () {
        var username = $('#AuthUsername').val();
        var password = $('#AuthPassword').val();
        if (username === "" || password === "") {
            alert("Username and password are required");
            return;
        }

        userLoginChallengeHandler.submitChallengeAnswer(
            {'username':username, 'password':password});});

    $('#AuthCancelButton').bind('click', function () {
        userLoginChallengeHandler.cancel();
        hideLoginDiv();
    });

    return userLoginChallengeHandler;
}
```

The migration of the pin-code challenge handler (`pinCodeChallengeHandler`) is similar to the migration of the user-login challenge handler. Therefore, follow the `userLoginChallengeHandler` migration instructions, and make the necessary adjustments for the pin-code challenge handler. See the full code of the migrated pin-code challenge handler in the sample V8.0 application.

You are now done with the migration of the sample V7.0 application to V8.0. Rebuild the application, deploy it to {{ site.data.keys.mf_server }}, test it, and verify that access to the adapter-method resources is protected as expected.

<!-- ==== PART 3: Migrating other types of authentication realms ==== -->
## Migrating other types of authentication realms
{: #migrating-other-types-of-authentication-realms }

So far, you learned how to migrate the form-base and adapter-based realms, which are part of the sample V7.1 application. However, your V7.1 application might include other types of authentication realms, including realms that are part of the application security test (`mobileSecurityTest`, `webSecurityTest`, or `customSecurityTest`). The following sections outline how to migrate these additional types of authentication realms to V8.0.

*  [Application authenticity](#application-authenticity)
*  [LTPA realm](#ltpa-realm)
*  [Device provisioning](#device-provisioning)
*  [Anti-cross site request forgery (anti-XSRF) realm
](#anti-cross-site-request-forgery-anti-xsrf-realm)
*  [Direct Update realm](#direct-update-realm)
*  [Remote-disable realm](#remote-disable-realm)
*  [Custom authenticators and login modules](#custom-authenticators-and-login-modules)

### Application authenticity
{: #application-authenticity }

In {{ site.data.keys.product }} V8.0, application-authenticity validation is provided as a predefined security check, `appAuthenticity`. By default, this security check is run during the application's runtime registration with {{ site.data.keys.mf_server }}, which occurs the first time an instance of the application attempts to connect to the server. However, as with any {{ site.data.keys.product_adj }} security check, you can also include this predefined check in custom security scopes. For more information, see [Application Authenticity](../../authentication-and-security/application-authenticity/).

### LTPA realm
{: #ltpa-realm }

To replace the V7.1 LTPA realm, use the {{ site.data.keys.product }} V8.0 predefined LTPA-based SSO security check, `LtpaBasedSSO`. For more information about this security check, see [LTPA-based single sign-on (SSO) security check](../../authentication-and-security/ltpa-security-check/).

### Device provisioning
{: #device-provisioning }

The V7.1 device-provisioning realm (`wl_deviceAutoProvisioningRealm`) does not require migration to V8.0. The {{ site.data.keys.product }} V8.0 client-registration process replaces the V7.1 device provisioning. In V8.0, a client (an instance of an application) registers itself with {{ site.data.keys.mf_server }} on the first attempt to access the server. As part of the registration, the client provides a public key that will be used to authenticate its identity. This protection mechanism is always enabled, therefore there is no need for a security check to replace the V7.1 device-provisioning realm.

### Anti-cross site request forgery (anti-XSRF) realm
{: #anti-cross-site-request-forgery-anti-xsrf-realm }

The V7.1 anti-cross site request forgery (anti-XSRF) realm (`wl_antiXSRFRealm`) does not require migration to V8.0. In V7.1.0, the authentication context is stored in the HTTP session and identified by a session cookie, which is sent by the browser in cross-site requests. The anti-XSRF realm in this version is used to protect the cookie transmission against XSRF attacks by using an additional header that is sent from the client to the server. In {{ site.data.keys.product }} V8.0, the security context is no longer associated with an HTTP session and is not identified by a session cookie. Instead, the authorization is done by using an OAuth 2.0 access token that is passed in the Authorization header. Because the Authorization header is not sent by the browser in cross-site requests, there is no need to protect against XSRF attacks.

### Direct Update realm
{: #direct-update-realm }

The V7.1 remote-disable realm (`wl_directUpdateRealm`) does not require migration to V8.0. The {{ site.data.keys.product }} V8.0 implementation of the Direct Update feature does not require a related security check, unlike the realm requirement in V7.1. 

**Note:** The V8.0 steps for delivering updates with Direct Update are different from the V7.1 procedure. For more information, see [Migrating Direct Update](../migrating-client-applications/cordova/#migrating-direct-update).

### Remote-disable realm
{: #remote-disable-realm }

The V7.1 remote-disable realm (`wl_remoteDisableRealm`) does not require migration to V8.0. The {{ site.data.keys.product }} V8.0 implementation of the remote-disable feature does not require a related security check, unlike the realm requirement in V7.1. For information about the remote-disable feature in V8.0, see [Remotely disabling application access to protected resources](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources).

### Custom authenticators and login modules
{: #custom-authenticators-and-login-modules }

To replace the custom V7.1 authenticators and login modules, create a new security check, according to instructions in the [Creating the user-login security-check Java class](#creating-the-user-login-security-check-java-class) sample-application migration step. Your security check can extend either the `UserAuthenticationSecurityCheck` or `CredentialsValidationSecurityCheck` {{ site.data.keys.product }} V8.0 base class. Although you cannot migrate the V7.1 authenticator class or the login module class directly, you can copy relevant code pieces into your security check. This includes code for generating the security challenge, extracting login credentials from the challenge response, or validating the credentials.

<!-- ==== PART 3: Migrating other V7.1 security configurations -->
## Migrating other V7.1 security configurations
{: #migrating-other-v71-security-configurations }

*  [The application security test](#the-application-security-test)
*  [Access-token expiration](#access-token-expiration)
*  [User-identity realm](#user-identity-realm)
*  [Device-identity realm](#device-identity-realm)

### The application security test
{: #the-application-security-test }

In V7.1, the application descriptor (**application-descriptor.xml**) can define an application security test that is applied to the entire application environment, in addition to the protection that is applied to specific application resources. The default V7.1 mobile-application security test, which is applied when the application descriptor does not explicitly define a security test (such as in the sample V7.1 application), is `mobileSecurityTest`. This security test consists of realms that are either not relevant in V8.0 (anti-XSRF) or do not require explicit migration (Direct Update and remote disable). Therefore, no specific migration is required for the sample application's application-environment protection.

If your V7.1 application has an application security test with checks (realms) that you want to keep at the application level after the migration to V8.0, you can configure a mandatory application scope. In V8.0, access to a protected resource requires passing both the security checks that are mapped to the mandatory application scope and the checks that are mapped to the resource’s protecting scope. To define a mandatory application scope, in the V8.0 {{ site.data.keys.mf_console }}, select your application from the **Applications** section of the navigation sidebar, and then select the **Security** tab. Under **Mandatory Application Scope**, select **Add to Scope**. You can include in the application scope any predefined or custom security checks, or mapped scope elements. For more information about configuration of a mandatory application scope in V8.0, see [Mandatory application scope](../..//authentication-and-security/#mandatory-application-scope).

### Access-token expiration
{: #access-token-expiration }

The default value of the maximum access-token expiation period in both V7.1 and V8.0 is 3600 seconds. Therefore, if your V7.1 application relies on this default value, no migration work is required to apply the value also in V8.0. However, if your V7.1 application-descriptor file (**application-descriptor.xml**) sets a different value for the `accessTokenExpiration` property, you can configure the same value for the equivalent V8.0 property (`maxTokenExpiration`). You can do this from the {{ site.data.keys.mf_console }} by going to your application's **Security** tab, and editing the default value of the **Maximum Token-Expiration Period (seconds)** field in the **Token Configuration** section. If you select the application's **Configuration Files** console tab, you can see that the value of the `maxTokenExpiration` property is set to your configured value.

### User-identity realm
{: #user-identity-realm }

In V7.1, authentication realms can be configured as user-identity realms. Applications that use the authentication flow of the {{ site.data.keys.product_adj }} OAuth security model, use the `userIdentityRealms` property in the application-descriptor file to define an ordered list of user-identity realms. In applications that use the authentication flow of the {{ site.data.keys.product_adj }} classic (non-OAuth) security model, the attribute `isInternalUserId` signifies whether the realm is a user-identity realm. In V8.0, these user-identity configurations are no longer needed. In V8.0, the identity of the active user is set by the last security check that called the `setActiveUser` method. If your security check extends the abstract `UserAuthenticationSecurityCheck` base class, such as the sample V8.0 `UserLogin` check, you can rely on the base class to set the identity of the active user.


### Device-identity realm
{: #device-identity-realm }

A V7.1 application must define a device-identity realm. In V8.0, this realm is no longer required. In V8.0, the device identity is not associated with a security check. Instead, the device information is registered as part of the client registration flow, which occurs the first time that the client attempts to access a protected resource.

<!-- ==== What's next -->
## What's next
{: #whats-next }
{% comment %} SLS: I replaced the "Summary" heading because it wasn't really a summary, including in the original version, it's more a "What's Next", and we also don't typically have summaries in our tutorial docs.
{% endcomment %}

This tutorial covers only the basic steps that are required for migrating to V8.0 the security artifacts of an existing application, developed with a previous version of {{ site.data.keys.product }}. To take full advantage of the V8.0 security features, see the [V8.0 security-framework documentation](../../authentication-and-security/).

