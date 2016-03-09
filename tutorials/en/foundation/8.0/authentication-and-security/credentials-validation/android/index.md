---
layout: tutorial
title: Implementing the challenge handler in Android applications
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
## Overview
When trying to access a protected resource, the server (the security check) will send back to the client a list containing one or more **challenges** for the client to handle.  
This list is received as a `JSON` object, listing the security check name with an optional `JSON` of additional data:

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

The client should then register a **challenge handler** for each security check.  
The challenge handler defines the client-side behavior that is specific to the security check.

## Creating the challenge handler
A challenge handler is a class responsible for handling challenges sent by the MobileFirst server, such as displaying a login screen, collecting credentials and submitting them back to the security check.

In this example, the security check is `PinCodeAttempts` which was defined in [Implementing the CredentialsValidationSecurityCheck](../security-check). The challenge sent by this security check contains the number of remaining attempts to login (`remainingAttempts`), and an optional `errorMsg`.

Create a Java class that extends `WLChallengeHandler`:

```java
public class PinCodeChallengeHandler extends WLChallengeHandler {

}
```

## Handling the challenge
The minimum requirement from the `WLChallengeHandler` protocol is to implement a constructor and a `handleChallenge` method, that is responsible for asking the user to provide the credentials. The `handleChallenge` method receives the challenge as a `JSONObject`.

> Learn more about the `WLChallengeHandler` protocol in the user documentation.

Add a constructor method:

```java
public PinCodeChallengeHandler(String securityCheck) {
    super(securityCheck);
}
```

In this `handleChallenge` example, an alert is displayed asking to enter the PIN code:

```java
@Override
public void handleChallenge(JSONObject jsonObject) {
    Log.d("Handle Challenge", jsonObject.toString());
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_MSG);
    try{
        if (jsonObject.isNull("errorMsg")){
            intent.putExtra("msg", "This data requires a PIN code.\n Remaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("msg", jsonObject.getString("errorMsg") + "\nRemaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}

```

> The implementation of `alertMsg` is included in the sample application.

If the credentials are incorrect, you can expect the framework to call `handleChallenge` again.

## Submitting the challenge's answer
Once the credentials have been collected from the UI, use the `WLChallengeHandler`'s `submitChallengeAnswer(JSONObject answer)` method to send an answer back to the security check. In this example `PinCodeAttempts` expects a property called `pin` containing the submitted PIN code:

```java
submitChallengeAnswer(new JSONObject().put("pin", pinCodeTxt.getText()));
```

## Cancelling the challenge
In some cases, such as clicking a "Cancel" button in the UI, you want to tell the framework to discard this challenge completely.

To achieve this, call:

```java
submitFailure(null);
```

## Handling failures
Some scenarios may trigger a failure (such as maximum attempts reached). To handle these, implement the `WLChallengeHandler`'s `handleFailure` method.  
The structure of the `JSONObject` passed as a parameter greatly depends on the nature of the failure.

```java
@Override
public void handleFailure(JSONObject jsonObject) {
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_ERROR);
    try {
        if (!jsonObject.isNull("failure")) {
            intent.putExtra("errorMsg", jsonObject.getString("failure"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("errorMsg", "Unknown error");
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

> The implementation of `alertError` is included in the sample application.

## Handling successes
In general successes are automatically processed by the framework to allow the rest of the application to continue.

Optionally you can also choose to do something before the framework closes the challenge handler flow, by implementing the `WLChallengeHandler`'s `handleSuccess` method. Here again, the content and structure of the `JSONObject` passed as a parameter depends on what the security check sends.

In the `PinCodeAttempts` sample application, the `JSONObject` does not contain any additional data and so `handleSuccess` is not implemented.

## Registering the challenge handler

In order for the challenge handler to listen for the right challenges, you must tell the framework to associate the challenge handler with a specific security check name.

This is done by initializing the challenge handler with the security check like this:

```java
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts", this);
```

You must then **register** the challenge handler instance:

```java
WLClient client = WLClient.createInstance(this);
client.registerChallengeHandler(pinCodeChallengeHandler);
```

## Sample application
The sample **PinCodeAndroid** is an Android application that uses `WLResourceRequest` to get a bank balance.  
The method is protected with a PIN code, with a maximum of 3 attempts.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) the SecurityAdapters Maven project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80) the Android project.

### Sample usage

* Use either Maven or MobileFirst Developer CLI to [build and deploy the available **ResourceAdapter** and **PinCodeAttempts** adapters](../../creating-adapters/).
* Ensure the sample is registered in the MobileFirst Server by running the command: `mfpdev app register` from a **command-line** window.
* Map the `accessRestricted` scope to the `PinCodeAttempts` security check:
    * In the MobileFirst Operations Console, under **Applications** → **PIN Code** → **Security** → **Map scope elements to security checks.**, add a mapping from `accessRestricted` to `PinCodeAttempts`.
    * Alternatively, from the **Command-line**, navigate to the project's root folder and run the command: `mfpdev app push`.  

        > Learn more about the mfpdev app push/push commands in the [Using MobileFirst Developer CLI to manage MobilefFirst artifacts](../../../using-the-mfpf-sdk/using-mobilefirst-developer-cli-to-manage-mobilefirst-artifacts).

![Sample application](sample-application-android.png)
