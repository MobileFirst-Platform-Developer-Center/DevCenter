---
title: Sample implementation for the SimpleCaptcha Security Check
date: 2016-04-04
tags:
- MobileFirst_Platform
- iOS
- SimpleCaptcha
- Security_Checks
version:
- 8.0
author:
  name: Ore Poran
---

## Overview
In this blog post I will demonstrate an Objective-C implementation for the "SimpleCaptcha" security check.  
The security check can be downloaded from the MobileFirst Platform 8.0 Beta Operations Console → Get Starter Code screen.    

The end result will be: the SimpleCaptcha security check deployed on your server, and an application which is able to request an access token with the `SimpleCaptcha` scope, handle the challenge, delegate it to the user, and eventually obtain the token.

***
## Download the sample
[Get the full sample on my github page](https://github.com/oreporan/iOS_SimpleCaptcha)
***


##### Prerequisites
* Understanding of [Adapters in v8.0](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/)
* Understanding of [Security Checks in v8.0](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/)
* Have [Maven installed](https://maven.apache.org/install.html)


## SimpleCaptcha SecurityCheck
From the javadoc:

> This security check implements an example of a captcha by calculating the sum of two operands that are sent as a challenge. The challenge created is a JSON in the format of {"captcha" : "x + y"}
>
> The challenge answer should bea  JSON in the format of {"answer" : "z"}
>
> If z = x + y then the credentials are valid and the security check goes in to "success" state (this is implemented in the base class CredentialsValidationSecurityCheck)

I'll break this up to Server-side work, and Client-side Work.

### Server-side
In our sample, we want to have the SimpleCaptcha security check deployed on the MobileFirst server.  
This is done via adapters, which are deployable artifacts, Java or Javascript, which contain their own custom logic. [Read more about adapters](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/).

Luckily, this security check can be downloaded directly from the MobileFirst console.

#### Downloading the SimpleCaptcha sample
The first thing we want to do is to download the SimpleCaptcha SecurityCheck, which is encapsulated in a Adapter.  
Under the `Actions` drop down menu in the top right of the MobileFirst Operations Console, Pick `Download Sample`.  
From the 3 Tabs, choose `Adapters`. There you'll find `SecurityCheck - Simple Captcha`

#### Build/Deploy the Adapter
Before we deploy the adapter to our server, we need to build it. Adapters are Maven artifacts, which means they can be built using the command `mvn clean install`. If you're using the MobileFirst CLI, use `mfpdev adapter build` followed by `mfpdev adapter deploy`.

Before we build the adapter, lets take a look at some of the source code. Open the adapter in your favorite IDE and make your way to `SimpleCaptchaSecurityCheck.java`.  
This is the method that does all the logic:

*SimpleCaptchaSecurityCheck.java*

```java
/**
 * Creates a challenge to be sent to the request
 * @return the challenge object
 */
@Override
protected Map<String, Object> createChallenge() {
    if(rand == null) rand = new Random();

    // The max number to generate a random number from, as configured in the SimpleCaptchaConfig file
    int max = getConfiguration().maxOperator;

    int operandA = rand.nextInt(max); // Random number 0-max
    int operandB = rand.nextInt(max); // Random number 0-max
    expectedResult = operandA + operandB;

    Map<String, Object> challenge = new HashMap();
    challenge.put("captcha", buildCaptchaMessage(operandA, operandB));
    challenge.put("message", errorMsg);
    return challenge;
}

private String buildCaptchaMessage(int operandA, int operandB) {
    return Integer.toString(operandA) + " + " + Integer.toString(operandB);
}
```

Note that the security check generates 2 random numbers, and sends a `JSON` in this format:  
`{"captcha" : "X + Y" , "message" : errorMsg}`

This is the challenge that will be sent to our client-side for handling.

Ok, now that we understand how the `handleChallenge()` method will send us the challenge, we can build/deploy the adapter, and begin working on our challenge handler.  
Read the readme.md found in the SimpleCaptcha zip you've just downloded for more information about the security check and how to build and deploy the adapter.

That's it for the Server-side work, there isn't much simply because the SecurityCheck is already provided for us out of the box.

### Client-side

MobileFirst Platform Foundation 8.0 Beta provides a SecurityCheck sample, but not client-side implementation which is exactly what I will show now using the MobileFirstPlatformFoundation iOS SDK.

As we saw, the SecurityCheck sends a challenge in the format of `{"captcha" : "X + Y" , "message" : errorMsg}`.  
This means we need to create a challenge Handler in our client, register that client, and create some UI for our User to answer the captcha challenge.

Create a new Xcode project and [add the MobileFirst Platform Foundation SDK]({{site.baseurl}}/tutorials/en/foundation/8.0/app-dev/sdk/ios).

#### Create the SecurityCheckChallengeHandler
In our XCode app, lets create a new Cocoa class called "SimpleCaptchaChallengeHandler".          

*SimpleCaptchaChallengeHandler.h*

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SimpleCaptchaChallengeHandler : SecurityCheckChallengeHandler
@property ViewController* vc;

-(id)initWithViewController: (ViewController*) vc;

@end
```

* Our class implements SecurityCheckChallengeHandler, so we need to import the MobileFirst sdk.
* We create another init method that can accept a viewController, and the reason is that we are going to push some UI from our Challenge Handler's handleChallenge method.

*SimpleCaptchaChallengeHandler.m*

```objc
@implementation SimpleCaptchaChallengeHandler

-(id)initWithViewController: (ViewController*) vc {
    self = [super initWithSecurityCheck:@"SimpleCaptcha"];
    self.vc = vc;
    return self;
}
```

Every SecurityCheckChallengeHandler has to call `initWithSecurityCheck`, we put the SecurityCheck name so the MobileFirstPlatformFoundation framework knows which ChallengeHandler handles each SecurityCheck's challenge.

```objc
-(void) handleSuccess: (NSDictionary *)success {
    NSLog(@"Challenge success");
    [self.vc.navigationController popViewControllerAnimated:YES];
}

-(void) handleFailure: (NSDictionary *)failure {
    NSLog(@"Challenge failed");
    [self.vc.navigationController popViewControllerAnimated:YES];
}

-(void) handleChallenge: (NSDictionary *)challenge {
    // Extract operands
    NSString *captcha = [challenge objectForKey:@"captcha"];

    UIViewController *vc = self.vc.navigationController.visibleViewController;
    BOOL isCaptchaViewController = [vc isKindOfClass:[CaptchaViewController class]];
    if(isCaptchaViewController){
        CaptchaViewController *captchaViewController = (CaptchaViewController *)vc;
        [captchaViewController displayError];
        [captchaViewController displayCaptcha:captcha];
        if(!captchaViewController.challengeHandler)
            captchaViewController.challengeHandler = self;
    } else {
        // If the current view is not CaptchaViewController - push it
        CaptchaViewController*  captchaViewController = [self.vc.navigationController.storyboard instantiateViewControllerWithIdentifier:@"captchaViewController"];
        captchaViewController.challengeHandler = self;
        [captchaViewController displayCaptcha:captcha];
        [self.vc.navigationController pushViewController:captchaViewController animated:YES];
    }
}
```  

* Our handleChallenge method, which gets called by the framework, pops up our CaptchaViewController. Since there can be multiple attempts, we make sure this view controller isn't the current visible viewController before pushing it.
* Before pushing the viewController, we set self as the current challenge handler.
This is done so that the viewController can send the challengeAnswer after the user submits the answer.
* The challenge from the SimpleCaptcha SecurityCheck is sent to the method as the `challenge` argument. We want to present this to the user, so we set it in the CaptchaViewController's displayCaptcha method.

#### Create the CaptchaViewController

Now that we've set up the SecurityCheckChallengeHandler, we need to do some UI.  
Create a new Cocoa class called "CaptchaViewController" which implements UIViewController.

*CaptchaViewController.h*

```objc
@interface CaptchaViewController : UIViewController
@property SecurityCheckChallengeHandler* challengeHandler;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;

-(void) displayError;
-(void) displayCaptcha:(NSString *)message;
@end
```

*CaptchaViewController.m*

```objc
@implementation CaptchaViewController

NSString *captchaMessage;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self.equationLabel setText:captchaMessage];
}

-(void) displayError {
    self.answerTextField.backgroundColor = [UIColor colorWithRed:0.93 green:0.31 blue:0.20 alpha:1.0];
}

-(void) displayCaptcha:(NSString *)message {
    captchaMessage = message;
    [self.equationLabel setText:captchaMessage];
}

- (IBAction)submit:(id)sender {
    NSString * textResult = _answerTextField.text;
    NSMutableDictionary * challengeAnswer = [[NSMutableDictionary alloc] init];
    [challengeAnswer setObject:textResult forKey:@"answer"];
    if(self.challengeHandler) {
        [self.challengeHandler submitChallengeAnswer:challengeAnswer];
    }
}
...
...
@end
```

* we display our equationLabel in `viewWillAppear` as well as in the `displayCaptcha`, Since in some occasions the view will already be visible when we receive the challenge.
* for the `displayError` we change the background color to indicate a wrong answer.
* In the `submit` IBAction, we take the answer from the answerTextField, append it to our answer dictionary, and call the challenge handler's `submitChallengeAnswer` method.

## Register the ChallengeHandler and call ObtainAccessToken
Go to the main ViewController.m class and register the challenge handler:

*ViewController.m*

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[WLClient sharedInstance] registerChallengeHandler:[[SimpleCaptchaChallengeHandler alloc] initWithViewController:self]];    
}
```

Next we want to obtain a token for the scope @"SimpleCaptcha".  
In MobileFirst Platform Foundation 8.0 beta, we can obtain an access token for a scope, but a securityCheck itself can also be a scope, so its perfectly fine to obtain a token for a specific security check.

Make a button that executes this method:

*ViewController.m*

```objc
- (IBAction)obtainToken:(id)sender {
    NSString * scope = @"SimpleCaptcha";
    [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:scope withCompletionHandler:^(AccessToken *accessToken, NSError *error) {
        if(error){
            NSLog(@"Obtain auth header failure. Error: %@", error);
        }
        else{
          NSLog(@"Obtain auth header success. token: %@", accessToken.value);
        }
    }];
}
```

## Summary
That should be it, when we start our app, presuming the MobileFirst Server is up and running, we should receive the challenge after pressing the obtain button.  
The challenge should pop up our view controller, and we should eventually see the obtained token from the server.    

![SimpleCaptcha_GIF]({{site.baseurl}}/assets/blog/2016-04-04-simplecaptcha-ios-implementation/demo.gif)

Add an extra test - obtain the token again, you shouldn't see the challenge at all.

You can post comments below.  
Thanks!
