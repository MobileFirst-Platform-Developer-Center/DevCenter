---
layout: tutorial
title: Implementing the challenge handler in iOS applications
breadcrumb_title: iOS
relevantTo: [ios]
weight: 3
downloads:
  - name: Download Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeSwift/tree/release80
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

Create a Swift class that extends `WLChallengeHandler`:

```swift
class PinCodeChallengeHandler : WLChallengeHandler {

}
```

## Handling the challenge
The minimum requirement from the `WLChallengeHandler` protocol is to implement the `handleChallenge` method, that is responsible for asking the user to provide the credentials. The `handleChallenge` method receives the challenge `JSON` as a `Dictionary`.

> Learn more about the `WLChallengeHandler` protocol in the user documentation.

In this example, an alert is displayed asking to enter the PIN code:

```swift
override func handleChallenge(challenge: [NSObject : AnyObject]!) {
    NSLog("%@",challenge)
    var errorMsg : String
    if challenge["errorMsg"] is NSNull {
        errorMsg = "This data requires a PIN code."
    }
    else{
        errorMsg = challenge["errorMsg"] as! String
    }
    let remainingAttempts = challenge["remainingAttempts"] as! Int

    showPopup(errorMsg,remainingAttempts: remainingAttempts)
}
```

> The implementation of `showPopup` is included in the sample application.

If the credentials are incorrect, you can expect the framework to call `handleChallenge` again.

## Submitting the challenge's answer
Once the credentials have been collected from the UI, use the `WLChallengeHandler`'s `submitChallengeAnswer(answer: [NSObject : AnyObject]!)` method to send an answer back to the security check. In this example `PinCodeAttempts` expects a property called `pin` containing the submitted PIN code:

```swift
self.submitChallengeAnswer(["pin": pinTextField.text!])
```

## Cancelling the challenge
In some cases, such as clicking a "Cancel" button in the UI, you want to tell the framework to discard this challenge completely.

To achieve this, call:

```swift
self.submitFailure(nil)
```

## Handling failures
Some scenarios may trigger a failure (such as maximum attempts reached). To handle these, implement the `WLChallengeHandler`'s `handleFailure` method.
The structure of the `Dictionary` passed as a parameter greatly depends on the nature of the failure.

```swift
override func handleFailure(failure: [NSObject : AnyObject]!) {
    if let errorMsg = failure["failure"] as? String {
        showError(errorMsg)
    }
    else{
        showError("Unknown error")
    }
}
```

> The implementation of `showError` is included in the sample application.

## Handling successes
In general successes are automatically processed by the framework to allow the rest of the application to continue.

Optionally you can also choose to do something before the framework closes the challenge handler flow, by implementing the `WLChallengeHandler`'s `handleSuccess(success: [NSObject : AnyObject]!)` method. Here again, the content and structure of the `success` `Dictionary` depends on what the security check sends.

In the `PinCodeAttemptsSwift` sample application, the success does not contain any additional data and so `handleSuccess` is not implemented.

## Registering the challenge handler

In order for the challenge handler to listen for the right challenges, you must tell the framework to associate the challenge handler with a specific security check name.

This is done by initializing the challenge handler with the security check like this:

```swift
var someChallengeHandler = SomeChallengeHandler(securityCheck: "securityCheckName")
```

You must then **register** the challenge handler instance:

```swift
WLClient.sharedInstance().registerChallengeHandler(someChallengeHandler)
```

In this example, in one line:

```swift
WLClient.sharedInstance().registerChallengeHandler(PinCodeChallengeHandler(securityCheck: "PinCodeAttempts"))
```

## Sample application
The sample **PinCodeSwift** is an iOS Swift application that uses `WLResourceRequest` to get a bank balance.  
The method is protected with a PIN code, with a maximum of 3 attempts.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) the SecurityAdapters Maven project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeSwift/tree/release80) the iOS Swift Native project.

### Sample usage

* Use either Maven or MobileFirst Developer CLI to [build and deploy the available **ResourceAdapter** and **PinCodeAttempts** adapters](../../../creating-adapters/).
* Ensure the sample is registered in the MobileFirst Server by running the command: `mfpdev app register` from a **command-line** window.
* Map the `accessRestricted` scope to the `PinCodeAttempts` security check:
    * In the MobileFirst Operations Console, under **Applications** → **PIN Code** → **Security** → **Map scope elements to security checks.**, add a scope mapping from `accessRestricted` to `PinCodeAttempts`. 
    * Alternatively, from the **Command-line**, navigate to the project's root folder and run the command: `mfpdev app push`.  
        
        > Learn more about the mfpdev app push/push commands in the [Using MobileFirst Developer CLI to manage MobilefFirst artifacts](../../../using-the-mfpf-sdk/using-mobilefirst-developer-cli-to-manage-mobilefirst-artifacts).

![Sample application](sample-application.png)
