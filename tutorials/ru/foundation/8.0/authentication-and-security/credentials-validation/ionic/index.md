---
layout: tutorial
title: Implementing the challenge handler in Ionic applications
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
downloads:
  - name: Download Ionic project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PincodeIonic
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
When trying to access a protected resource, the server (the security check) sends to the client a list containing one or more **challenges** for the client to handle.  
This list is received as a `JSON object`, listing the security check name with an optional `JSON` containing additional data:

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

The client is then expected to register a **challenge handler** for each security check.  
The challenge handler defines the client-side behaviour that is specific to the security check.

## Creating the challenge handler
{: creating-the-challenge-handler }
A challenge handler handles challenges sent by the {{ site.data.keys.mf_server }}, such as displaying a login screen, collecting credentials, and submitting them back to the security check.

In this example, the security check is `PinCodeAttempts` which was defined in [Implementing the CredentialsValidationSecurityCheck](../security-check). The challenge sent by this security check contains the number of remaining attempts to log in (`remainingAttempts`) and an optional `errorMsg`.


Use the `WL.Client.createSecurityCheckChallengeHandler()` API method to create and register a challenge Handler:

```javascript
PincodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## Handling the challenge
{: #handling-the-challenge }
The minimum requirement from the `createSecurityCheckChallengeHandler` protocol is to implement the `handleChallenge()` method, which is responsible for asking the user to provide the credentials. The `handleChallenge` method receives the challenge as a `JSON` Object.

In this example, an alert prompts the user to enter the PIN code:

```javascript
 registerChallengeHandler() {
    this.PincodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
    this.PincodeChallengeHandler.handleChallenge = ((challenge: any) => {
      console.log('--> PincodeChallengeHandler.handleChallenge called');
      this.displayLoginChallenge(challenge);
    });
  }

  displayLoginChallenge(response) {
    if (response.errorMsg) {
      var msg = response.errorMsg + ' <br> Remaining attempts: ' + response.remainingAttempts;
      console.log('--> displayLoginChallenge ERROR: ' + msg);
    }
    let prompt = this.alertCtrl.create({
      title: 'MFP Gateway',
      message: msg,
      inputs: [
        {
          name: 'pin',
          placeholder: 'please enter the pincode',
          type: 'password'
        }
      ],
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
          handler: () => {
            console.log('PincodeChallengeHandler: Cancel clicked');
            this.PincodeChallengeHandler.Cancel();
            prompt.dismiss();
            return false
          }
        },
        {
          text: 'Ok',
          handler: data => {
            console.log('PincodeChallengeHandler', data.username);
            this.PincodeChallengeHandler.submitChallengeAnswer(data);
          }
        }
      ]
    });
    prompt.present();
}
```

If the credentials are incorrect, you can expect the framework to call `handleChallenge` again.

## Submitting the challenge's answer
{: #submitting-the-challenges-answer }
After the credentials have been collected from the UI, use `createSecurityCheckChallengeHandler`'s `submitChallengeAnswer()` to send an answer back to the security check. In this example, `PinCodeAttempts` expects a property called `pin` containing the submitted PIN code:

```javascript
PincodeChallengeHandler.submitChallengeAnswer(data);
```

## Cancelling the challenge
{: #cancelling-the-challenge }
In some cases, such as clicking a **Cancel** button in the UI, you want to tell the framework to discard this challenge completely.  
To achieve this, call:

```javascript
PincodeChallengeHandler.cancel();
```

## Handling failures
{: #handling-failures }
Some scenarios might trigger a failure (such as maximum attempts reached). To handle these, implement `createSecurityCheckChallengeHandler`'s `handleFailure()`.  
The structure of the JSON object passed as a parameter greatly depends on the nature of the failure.

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure && error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
        alert("Error! " + JSON.stringify(error));
    }
};
```

## Handling successes
{: #handling-successes }
In general, successes are automatically processed by the framework to allow the rest of the application to continue.

Optionally, you can also choose to do something before the framework closes the challenge handler flow, by implementing `createSecurityCheckChallengeHandler`'s `handleSuccess()`. Here again, the content and structure of the `success` JSON object depends on what the security check sends.

In the `PinCodeAttemptsIonic` sample application, the success does not contain any additional data.

## Registering the challenge handler
{: #registering-the-challenge-handler }
For the challenge handler to listen for the right challenges, you must tell the framework to associate the challenge handler with a specific security check name.  
To do so, create the challenge handler with the security check as follows:

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## Sample applications
{: #sample-applications }
The **PinCodeIonic**  project uses `WLResourceRequest` to get a bank balance.  
The method is protected by a PIN code, with a maximum of 3 attempts.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/PincodeIonic) the Ionic project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) the SecurityAdapters Maven project.  

### Sample usage
{: #sample-usage }
Follow the sample's README.md file for instructions.

![Sample application](pincode-attempts-cordova.png)
