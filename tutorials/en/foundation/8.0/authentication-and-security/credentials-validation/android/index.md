---
layout: tutorial
title: Implementing the challenge handler in Android applications
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
## Overview
When trying to access a protected resource, the server (the security check) sends back to the client a list containing one or more **challenges** for the client to handle.  
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

The client must then register a **challenge handler** for each security check.  
The challenge handler defines the client-side behavior that is specific to the security check.

## Creating the challenge handler
A challenge handler is a class that handles challenges sent by the MobileFirst server, such as displaying a login screen, collecting credentials, and submitting them back to the security check.

In this example, the security check is `PinCodeAttempts` which was defined in [Implementing the CredentialsValidationSecurityCheck](../security-check). The challenge sent by this security check contains the number of remaining attempts to login (`remainingAttempts`) and an optional `errorMsg`.

Create a Java class that extends `SecurityCheckChallengeHandler`:

```java
public class PinCodeChallengeHandler extends SecurityCheckChallengeHandler {

}
```

## Handling the challenge
The minimum requirement from the `SecurityCheckChallengeHandler` protocol is to implement a constructor and a `handleChallenge` method, which prompts the user to provide the credentials. The `handleChallenge` method receives the challenge as a `JSONObject`.

Add a constructor method:

```java
public PinCodeChallengeHandler(String securityCheck) {
    super(securityCheck);
}
```

In this `handleChallenge` example, an alert prompts the user to enter the PIN code:

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
Once the credentials have been collected from the UI, use the `SecurityCheckChallengeHandler`'s `submitChallengeAnswer(JSONObject answer)` method to send an answer back to the security check. In this example, `PinCodeAttempts` expects a property called `pin` containing the submitted PIN code:

```java
submitChallengeAnswer(new JSONObject().put("pin", pinCodeTxt.getText()));
```

## Cancelling the challenge
In some cases, such as clicking a **Cancel** button in the UI, you want to tell the framework to discard this challenge completely.

To achieve this, use the `SecurityCheckChallengeHandler`'s `cancel()` method.

## Handling failures
Some scenarios may trigger a failure (such as maximum attempts reached). To handle these, implement the `SecurityCheckChallengeHandler`'s `handleFailure` method.  
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
In general, successes are automatically processed by the framework to allow the rest of the application to continue.

Optionally, you can also choose to do something before the framework closes the challenge handler flow, by implementing the `SecurityCheckChallengeHandler`'s `handleSuccess` method. Here again, the content and structure of the `JSONObject` passed as a parameter depends on what the security check sends.

In the `PinCodeAttempts` sample application, the `JSONObject` does not contain any additional data and so `handleSuccess` is not implemented.

## Registering the challenge handler

For the challenge handler to listen for the right challenges, you must tell the framework to associate the challenge handler with a specific security check name.

To do so, initialize the challenge handler with the security check as follows:

```java
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts", this);
```

You must then **register** the challenge handler instance:

```java
WLClient client = WLClient.createInstance(this);
client.registerChallengeHandler(pinCodeChallengeHandler);
```

**Note:** Creating a `WLClient` instance and registering the challenge handler should happen only once in the entire application lifecycle. It is recommended to use the Android Application class to do it.

## Sample application
The sample **PinCodeAndroid** is an Android application that uses `WLResourceRequest` to get a bank balance.  
The method is protected with a PIN code, with a maximum of 3 attempts.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) the SecurityAdapters Maven project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80) the Android project.

### Sample usage
Follow the sample's README.md file for instructions.

![Sample application](sample-application-android.png)
