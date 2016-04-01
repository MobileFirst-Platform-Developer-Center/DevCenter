---
layout: tutorial
title: iOS end-to-end demonstration
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
## Overview
The purpose of this demonstration is to experience an end-to-end flow:

1. A scaffold application - an application that is pre-bundled with the MobileFirst client SDK, is registered and downloaded from the MobileFirst Operations Console.
2. An new or provided adapter is deployed to the MobileFirst Operations Console.  
3. The application logic is changed to make a resource request.

**End result**:

* Successfully pinging the MobileFirst Server.
* Successfully retrieving data using a MobileFirst Adapter.

#### Prerequisites:

* Xcode
* *Optional*. MobileFirst CLI ([download]({{site.baseurl}}/downloads))
* *Optional*. Stand-alone MobileFirst Server ([download]({{site.baseurl}}/downloads))

### 1. Starting the MobileFirst Server

> If a remote server was already set-up, skip this step.

From a **Command-line** window, navigate to the server's folder and run the command: `./run.sh`.

### 2. Creating an application

In a browser window, open the MobileFirst Operations Console by loading the URL: `http://your-server-host:server-port/mfpconsole`. If running locally, use: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). The username/password are *admin/admin*.
 
1. Click the **New** button next to **Applications**
    * Select the **iOS** platform
    * Enter **com.ibm.mfpstarteriosobjectivec** or **com.ibm.mfpstarteriosswift** as the **application identifier** (depending on the application scaffold you will download in the next step)
    * Enter **1.0** as the **version** value
    * Click on **Register application**
    
    <img class="gifplayer" alt="Register an application" src="register-an-application-ios.png"/>
 
2. Click on the **Get Starter Code** tile and select to download the iOS Objective-C or iOS Swift application scaffold.

    <img class="gifplayer" alt="Download sample application" src="download-starter-code-ios.png"/>
    
### 3. Editing application logic

1. Open the Xcode project project by double-clicking the **.xcworkspace** file.

2. Select the **[project-root]/ViewController.m/swift** file and paste the following code snippet, replacing the existing `getAccessToken()` function:
 
    In Objective-C:

    ```objc
    - (void)testServerConnection {
        _connectionStatusText.text = @"Connecting to Server...";
        [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope: @"" withCompletionHandler:^(AccessToken *accessToken, NSError *error) {        
            if (error != nil){            
                NSLog(@"Failure: %@",error.description);
                _connectionStatusText.text = @"Client Failed to connect to Server";
            }
            else if (accessToken != nil){            
                NSLog(@"Success: %@",accessToken.value);
                _connectionStatusText.text = @"Client has connected to Server";
                NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/users/world"];
                WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
                [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                    if (error != nil){
                        NSLog(@"Failure: %@",error.description);
                    }
                    else if (response != nil){
                       // Will print "Hello world" in the Xcode Console.
                       NSLog(@"Success: %@",response.responseText);
                    }
                }];
            }        
        }];    
    }
    ```
    
    In Swift:
    
    ```swift
    @IBAction func getAccessToken(sender: AnyObject) {
        connectionStatusWindow.text = "Connecting to Server...";
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in
            if (error != nil) {
               self.connectionStatusWindow.text = "Client Failed to connect to Server"
               print("Did not Recieved an Access Token from Server: " + error.description)
            } else {
                self.connectionStatusWindow.text = "Client has connected to Server"
                print("Recieved the Following Access Token value: " + token.value)
                let url = NSURL(string: "/adapters/javaAdapter/users/world")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)
               
                request.sendWithCompletionHandler { (WLResponse response, NSError error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }
        }
    }
    ```

### 4. Deploy an adapter
Download [this prepared .adapter artifact](../javaAdapter.adapter) and deploy it from the MobileFirst Operations Console using the **Actions → Deploy adapter** action.

<!-- Alternatively, click the **New** button next to **Adapters**.  
        
1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and MobileFirst CLI are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the MobileFirst Operations Console using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder. 

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="iosQuickStart.png" alt="sample app" style="float:right"/>
### 5. Testing the application

1. In Xcode, select the **mfpclient.plist** file and edit the **host** property with the IP address of the MobileFirst Server.

    Alternatively, if you have installed the MobileFirst Develper CLI then navigate to the project root folder and run the command `mfpdev app register`.  If a remote server is used instead of a local server, first use the command `mfpdev server add` to add it.

2. Press the **Play** button.

<br clear="all"/>
### Results
* Clicking the **Ping MobileFirst Server** button will display **Connected to MobileFirst Server**.
* If the application was able to connect to the MobileFirst Server, a resource request call using the deployed Java adapter will take place.

The adapter response is then printed in the Xcode Console.

![Image of application that successfully called a resource from the MobileFirst Server ](success_response.png)

## Next steps
Learn more on using adapters in applications, and how to integrate additional services such as Push Notifications, using the MobileFirst security framework and more:

- Review the [Using the MobileFirst Platform Foundation](../../using-the-mfpf-sdk/) tutorials
- Review the [Adapters development](../../adapters/) tutorials
- Review the [Authentication and security tutorials](../../authentication-and-security/)
- Review the [Notifications tutorials](../../notifications/)
- Review [All Tutorials](../../all-tutorials)
