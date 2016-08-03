---
title: Implementing License Agreement Signature using MobileFirst Foundation V8
date: 2016-07-24
tags:
- MobileFirst_Foundation
- Security_Checks
- License_Agreement
- Terms_and_Conditions
version: 8.0
author:
  name: Uri Segev
---

## Introduction
Many mobile applications require users to sign a license agreement before they can use the application. They have to first accept the terms &amp; conditions, and then they can proceed. In case  the license agreement changes, they are required to sign it again.

With MobileFirst Foundation it is fairly straight forward to develop this functionality and make sure it is enforced. The security framework provides the infrastructure to orchestrate sending the license agreement only to users who haven't signed it, and resend when it changes. You can also update the terms &amp; conditions remotely from the Foundation console, and make sure your users sign the new version, without any downtime or code changes.

This post shows how I implemented this function using the MobileFirst Foundation security infrastructure.

The idea behind this security check is to store the state of the signature in the Registration Service, i.e., whether it was signed or not and which version of the agreement was signed. Each time the security check is invoked it checks if the correct version of the license was signed. If the correct version was signed, the security check indicates that all is good. If not, the security check will send a challenge to the user asking to sign the correct version of the agreement.

To implement the License Agreement functionality, I have created two artifacts:

- The LicenseAgreementSecuirtyCheck which gets deployed on the server
- The LicenseAgreementChallengeHandler which is used on the client to interact with the security check and the user. It is presented in a sample hybrid application.

Source code for this security check and sample application can be found  [here](https://github.com/mfpdev/license-agreement-sample)

## The License Agreement Security Check

The security check is a component that runs on the server and plays a major role in the OAuth implementation. Some security checks are provided as part of the product while other security checks can be implemented by customers to provide additional authentication and authorization methods which are tailored to their needs. Security checks are used in the following two OAuth flows:

- Authorization flow: This flow happens when a client needs to obtain an OAuth access token that contains a specific scope. In order to obtain the token, the server may need to authenticate or authorize the user based on the configuration. If the server determines that it needs to use a specific security check in order to authorize the user, it will invoke it’s authorize() method. The method may be called multiple times during the flow. The role of this method is to check the state of the security check. If needed the security check needs to create a challenge request, send it to the client, and when the client response is received, verify that the correct credentials were provided. When everything is satisfied, the security check lets the security framework know that from its point of view, the scope can be granted to the client.

- Resource Invocation flow: This flow happens when the client tries to invoke a resource. The server in this case verifies that the client has an OAuth access token, that the token is valid, has not expired and that it contains the correct scope which is defined for the resources being invoked. If a specific security check was involved in granting that scope, the security check’s `introspect()` method is invoked to make sure that it is still valid. If it is not for some reason, the server will respond with a 401 error code and the client will need to start the authorization flow.

Usually custom security checks will be derived from one of the provided security check base classes (`ExternizableSecurityCheck`, `CredentialsValidationSecurityCheck` or `UserAuthenticationSecurityCheck`). The base classes hide much of the complexity of managing the state, handling time outs, understanding the different flows, retries, etc. In this case however, I have decided to implement the `SecurityCheck` interface directly as the functionality is very simple and most of the things done by the base classes are not required here. For instance, this security check doesn't need to store state between invocations, it doesn’t need to count retries, etc.

The `authorize()` method, which is invoked during the authorization flow, starts by checking if the user has already signed the latest license agreement. If it did, it indicates to the framework (by calling the addSuccess() method on the response object) that no further action is needed and the scope can be granted.

```java
// Get the signature status from the Registration service
PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
Long signDate = attributes.get(SIGN_DATE_ATTR);
Integer signedVersion = attributes.get(SIGN_VER_ATTR);

// Get current license agreement version from configuration
int currentVersion = config.licenseVersion;

if (signDate != null && signedVersion == currentVersion) {
    // Signed the latest license, all done
    response.addSuccess(scope, getExpiresAt(), _checkName);
}
```

If the license needs to be signed again, the method creates the appropriate challenge request that will be sent to the user (by calling the `addChallenge()` method on the response object).

```java
// Need to sign the License Agreement, either because it was never signed or because there is a new version

if (credentials == null) {
    // No Credentials -> Create a challenge request
    response.addChallenge(_checkName, createChallenge(signDate != null));
}
```

Once a challenge response is received, the method verifies the response received from the user. If all is good, the method updates the Registration Service to indicate that the latest license agreement was signed. If it wasn’t the latest version, a new challenge is sent to the user.

```java
// Extract the response
signedVersion = (Integer) credentials.get(PROT_VER_ATTR);

if (signedVersion == currentVersion) {
    // Signed the latest version, update signature state in registartion service
    attributes.put(SIGN_DATE_ATTR, System.currentTimeMillis());
    attributes.put(SIGN_VER_ATTR, currentVersion);
    response.addSuccess(scope, 0, _checkName);
} else {
    // Signed an older version (probably version changed while reading the agreement), ask to
    // sign it again
    response.addChallenge(_checkName, createChallenge(true));
}
```

This method relies on the state saved in the Registration Service and the credentials parameter to determine its state and the next steps. It does not need to store any state between invocations.

The `introspect()` method, which is called during the resource invocation flow, verifies that the version of the license agreement that was signed is still valid. If it is, it calls the `addIntrospectionData()` method on the response object.

```java
// Get current signature status from Registration database
PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
Long signDate = attributes.get(SIGN_DATE_ATTR);
Integer signVersion = attributes.get(SIGN_VER_ATTR);

// Get the version of the current license agreement
int currentVersion = config.licenseVersion;

if (signDate != null && signVersion == currentVersion) {
    response.addIntrospectionData(_checkName, scope, System.currentTimeMillis() + 3600 * 1000, null );
}
```

## The License Agreement Challenge Handler
The Challenge Handler is invoked by the MobileFirst SDK when the security check needs to get information from the user/client. In this case, the challenge handler receives from the server the license agreement URL, the version of the license agreement and a message code. The challenge handler should send back to the server, upon the user agreeing to the agreement, the same version number received from the server.

The handleChallenge method is invoked by the SDK. It receives a single parameter which is the challenge sent from the server. The challenge handler extract from the challenge the license agreement URL, the version number and a message code. It then loads the license agreement file and once it is loaded, presents the information to the user. This is the place where you should change the application to present the information in the way that fits your design.

When the user agrees to the terms, the code calls `submitChallengeAnswer()` Which sends the challenge response back to the server. In this case, it needs to send the version of the agreement which was signed: {"version":version}. If the user declines, the handler calls `cancel()` which cancels the processing.

## Configuring the Security Check
The security check takes two configuration parameters: The license agreement URL, which the client should use to download the file, and the version of the file. Whenever the content of the URL changes, the version number must be changed so that the users will be asked to sign the agreement again.

The following image shows the configuration for the security check:

![Configuring the security check]({{site.baseurl}}/assets/blog/2016-07-24-implementing-license-agreement-signature-using-mobilefirst-foundation-v8/configuring.png)


## Using the Security Check
In order to use the LicenseAgreement security check you need to assign it to one of the scopes that protects a resource that your application calls.

The following image shows that the scope myCustomScope was mapped to the LicenseAgreement security check. Whenever the application will try to access a resource which is protected with the scope myCustomScope, the LicenseAgreement security check will be invoked.

![Using the security check]({{site.baseurl}}/assets/blog/2016-07-24-implementing-license-agreement-signature-using-mobilefirst-foundation-v8/using.png)

## Resources
Authentication and security tutorial can be found
[in this GitHub repository](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/).
