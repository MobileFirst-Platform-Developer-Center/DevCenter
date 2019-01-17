---
title: Intergrating Siri Shorcuts in Mobile Foundation iOS Apps
date: 2019-01-15
tags:
- MobileFirst_Foundation  
- iOS
version: 8.0
author:
  name: Vittal R Pai
---

In Apple's WWDC 2018, Apple introduced a new feature called *Siri Shorcut* for iOS 12 which allows to define and access the frequently used tasks of an application using Siri. 

#### References
See [here](https://support.apple.com/en-us/HT209055), for details on *Siri Shortcuts*.

In this tutorial, we will use [PincodeSwift iOS Application](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/credentials-validation/ios/) and integrate Siri Shorcuts capability with the app.  The shortcut can be invoked using a voice phrase, which will fetch the account balance using a resource adapter. Follow the steps listed in the tutorial to understand how to create a shortcut and how to enable security using the Mobile Foundation server. 

#### Create an Intents Extension

Open `PincodeSwift` in Xcode, Go to **File > New > Target** and Select `Intents Extension` and fill the product name as `BalanceIntent`, click **Finish**.
![Intents Extension]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/intents-extension.png)

This will add a new Intent Extenions target to the iOS Application.

#### Add SiriKit Intent Defnition

- In the `BalanceIntent` folder, right click and select **New File > Add SiriKit Intent Defnition File**. Add it to `BalanceIntent` and `PincodeSwift` targets and save it as `GetBalance`.
![Siri Intents Definition]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/siri-intent-defnition.png)

- Open the the GetBalance Intent Definition file, Press ➕ symbol to add new intent as `GetBalance`. Fill the details as shown in the image below.
![Custom Intent]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/custom-intent.png)

  Here we have selected intent category as `View` since we are viewing the information. We have defined the title & description of the Shorcut. I have defined `bankName` as a parameter, which is required if the developer wishes to create shorcuts to view balance for multiple banks. We have checked background execution with which shorcut can be executed without having to run the actual application.

- Define the responses for the Intent as shown in the image below.
![Custom Intent Respone]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/custom-intent-response.png)

  Here we have defined success and two failure responses where default error response can be used if we don't have error info else custom error response, which can be used if we have the error info.


#### Add Intent Handler

- Add native iOS Mobile Foundation Platform SDK in the `GetBalance` target. This can be done by using cocoapod or manually. You can refer the documentation [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/ios/) for adding Mobile Foundation SDK.

- Create a new swift file with a name `GetBalanceIntentHandler.swift` and replace the content with the following.
	
```swift
	import UIKit
	import IBMMobileFirstPlatformFoundation
	
	public class GetBalanceIntentHandler: NSObject, GetBalanceIntentHandling {
	    var mfpBank = "MobileFirst Bank"
	    
	    public func handle(intent: GetBalanceIntent, completion: @escaping (GetBalanceIntentResponse) -> Void) {
	        if intent.bankname == mfpBank {
	            let request = WLResourceRequest(url: URL(string: "/adapters/ResourceAdapter/balance"), method: WLHttpMethodGet)
	            request?.send { (response, error) -> Void in
	                if(error == nil) {
	                    completion(GetBalanceIntentResponse.success(balance: (response?.responseText)!))
	                }
	                else{
	                    if(response != nil) {
	                        // Custom error message
	                        completion(GetBalanceIntentResponse.bankRetreivefailure(errorInfo: response?.error as? String ?? "" ))
	                    } else {
	                        //Default error message
	                        completion(GetBalanceIntentResponse(code: .failure, userActivity: nil))
	                    }
	                }
	            }
	        } else {
	            // Invalid Bank
	            completion(GetBalanceIntentResponse(code: .invalidBank, userActivity: nil))
	        }
	    }
	}
```
	
  Here we are making a `WLResourceRequest` adapter call to the Mobile Foundation server to retreive balance and for sending success or failure responses to the user.
	
- Modify the `IntentHandler.swift` file with the following.

```swift
	import Intents
	
	class IntentHandler: INExtension {
	    
	    override func handler(for intent: INIntent) -> Any {
	        guard intent is GetBalanceIntent else {
	            fatalError("Unhandled intent type: \(intent)")
	        }
	        return GetBalanceIntentHandler()
	    }
	}
```

#### Donate a Siri Shorcut

- In `PincodeSwift` target, navigate to **Capabilities** and **Enable Siri**, which will enable Siri capability in the application.
![Siri Capability]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/siri-capability.png)

- In the application's `Info.plist`, add the bundle identifier of the Intents Extension under `NSUserActivityTypes` as shown below.
![Info NSUserActivity]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/info-activity.png)

- Replace the content of `ViewController.swift` with the following.

```Swift
	import UIKit
	import IBMMobileFirstPlatformFoundation
	import Intents
	import IntentsUI
	
	class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
	    @IBOutlet weak var balanceLabel: UILabel!
	    static var balanceIntent = GetBalanceIntent()
	    
	    override func viewDidLoad() {
	        super.viewDidLoad()
	        donateInteraction()
	        // Do any additional setup after loading the view, typically from a nib.
	    }
	    
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	        // Dispose of any resources that can be recreated.
	    }
	    
	    @IBAction func getBalance(_ sender: UIButton) {
	        let request = WLResourceRequest(url: URL(string: "/adapters/ResourceAdapter/balance"), method: WLHttpMethodGet)
	        request?.send { (response, error) -> Void in
	            if(error == nil){
	                NSLog((response?.responseText)!)
	                self.balanceLabel.text = "Balance = " + (response?.responseText)!
	                
	            }
	            else{
	                NSLog(error.debugDescription)
	                self.balanceLabel.text = "Failed to get balance"
	            }
	        }
	        
	    }
	    
	    @IBAction func addShorcut(_ sender: UIButton) {
	        if let shortcut = INShortcut(intent: ViewController.balanceIntent) {
	            let addVoiceShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
	            addVoiceShortcutVC.delegate = self
	            present(addVoiceShortcutVC, animated: true, completion: nil)
	        }
	    }
	    
	    func donateInteraction() {
	        ViewController.balanceIntent.bankname = "MobileFirst Bank"
	        ViewController.balanceIntent.suggestedInvocationPhrase = "Show account balance of Savings Account"
	        let interaction = INInteraction(intent: ViewController.balanceIntent, response: nil)
	        
	        interaction.donate { (error) in
	            if error != nil {
	                if let error = error as NSError? {
	                    print("Interaction donation failed: %@", error)
	                } else {
	                    print("Successfully donated interaction")
	                }
	            }
	        }
	    }
	    
	    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
	                                        didFinishWith voiceShortcut: INVoiceShortcut?,
	                                        error: Error?) {
	        if let error = error as NSError? {
	            print("error adding voice shortcut: %@", error)
	            return
	        }
	        self.balanceLabel.text = "Successfully added to Siri"
	        dismiss(animated: true, completion: nil)
	    }
	    
	    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
	        self.balanceLabel.text = "Failed to add shorcut to Siri"
	        dismiss(animated: true, completion: nil)
	    }
	    
	    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
	                                         didUpdate voiceShortcut: INVoiceShortcut?,
	                                         error: Error?) {
	        if let error = error as NSError? {
	            print("error adding voice shortcut: %@", error)
	            return
	        }
	        dismiss(animated: true, completion: nil)
	    }
	    
	    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
	                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
	        dismiss(animated: true, completion: nil)
	    }
	    
	    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
	         self.balanceLabel.text = "Failed to add shorcut to Siri"
	        dismiss(animated: true, completion: nil)
	    }
	}
```
where `donateInteraction` method donates the View Balance shorcut to Siri when the app is installed on the device, which makes the shorcut available to the user under **Siri Suggested Shorcuts** tab.
	
However, you can explicitly ask users to add the shorcuts in the application. For this you need to add the button in the UIView and call the `addShorcut` method, which does the job.
	
- Register the seperate iOS application in Mobile Foundation Operations console for Siri Intents Extension with bundle ID as `com.mfp.pincodeswift.balanceintent` and update Mobile Foundation server info in the MFP Configuration file of `BalanceIntent` Target.

- Map the `accessRestricted` with empty value in Mobile Foundation Operations console for Siri Intents Extension App.
![Scope Mapping]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/scope-mapping.png)

	
That's all, You are now done with adding Siri Shorcut capbility to PincodeSwift application.

![Add to Siri]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/add-to-siri.png "Add to Siri") 

![Balance Siri]({{site.baseurl}}/assets/blog/2019-01-15-intergrating-siri-shorcuts-in-ios-apps/balance-siri.png "Balance Siri")


### Authentication Concept

In case of a Banking shortcut, security is one of the major concerns and this section details how you can enable security in the shortcuts. Shortcuts are not designed to accept any user inputs. However, there are multiple ways to handle the security in shorcuts. I will not go into the details considering the scope of this article, but here is one possible way to add security in shorcut:

Application and the intent extension can share a `NSUserDefaults` object. When the user logs in successfully in the main application, you can generate in the server a custom token and store it in `NSUserDefaults`. The shorcut can use this token to handle a challenge. If the token does not exist or is invalid, the shorcut could open the main application (using openURL) and prompt the user to login.

### Source Code
The source code of the application is uploaded in [GitHub repository](https://github.com/MobileFirst-Platform-Developer-Center/PincodeSwiftSiriShorcut).

	
### Conclusion

*Siri Shorcut* is a very nice feature with great user experience. Shorcuts are meant to improve the user experience, bringing useful data to the user for a quick glance and this is used generally for actions, which are used repeatedly. For example, use an application to check balance or get loyalty points. Such repetitive user actions can be exposed as a shortcut, which helps improve the user experience of an application.
