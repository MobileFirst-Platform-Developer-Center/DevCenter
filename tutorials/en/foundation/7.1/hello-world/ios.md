---
layout: tutorial
title: iOS Quick Start
weight: 1
relevantTo: [ios]
---

## Overview
The purpose of this demonstration is to experience an end-to-end flow by quickly integrating and using the MobileFirst Platform Foundation SDK.
The SDK will be integrated in an Xcode project and make an adapter request to retrieve information from a HTTP backend.

#### Prerequesites:
Make sure that the following software is installed:

* MobileFirst Platform command line tool
* Xcode 6.1 and later

### 1. Create a MobileFirst back-end project and adapter
Create a back-end project in a location of your choice:

{% highlight bash %}
mfp create MyProject
cd MyProject
{% endhighlight %}

Add an HTTP adapter to the project:

{% highlight bash %}
cd MyProject
mfp add adapter MyAdapter -t http
{% endhighlight %}

### 2. Deploy artifacts to the MobileFirst Server**
Start the MobileFirst Server and deploy the adapter.

{% highlight bash %}
mfp start
mfp push
{% endhighlight %}

### 3. Create an Xcode project

#### Add the MobileFirst iOS SDK to the Xcode project

If [CocoaPods](http://guides.cocoapods.org/) is not installed in your development environment, <a href="#cocoapods-instructions" data-toggle="collapse" href="#cocoapods-install" aria-expanded="false" aria-controls="cocoapods-install">click to learn how to install it</a>.

<div id="cocoapods-install" class="collapse" markdown="1">
- Open **Terminal**
- Run the command `sudo gem install cocoapods`
- Run the command `pod setup` – Note that this command might take several minutes to complete
- Change directory to the location of the Xcode project
- Run the command `pod init`. This command creates a `Podfile`
- Open the `Podfile` file, located at the root of the project, with your favorite editor
- Comment out or remove the file contents
</div>

<br>
Add the following lines and save the changes:

{% highlight bash %}
source 'https://github.com/CocoaPods/Specs.git'
pod 'IBMMobileFirstPlatformFoundation'
{% endhighlight %}

<br>
Run the command `pod install`. This command adds the MobileFirst Platform Native SDK, generates the Pod project and integrates it with the Xcode project.

> **Important**: From here on, use the ``[ProjectName]``.**xcworkspace** file to open the project in Xcode. **Do not use** the ``[ProjectName].xcodeproj`` file. A CocoaPods-based project is managed as a workspace that contains the application (the executable) and the library (all project dependencies that are pulled by the CocoaPods manager).

In **Terminal**, navigate to the root of the Xcode project and add the required configuration files by running the command. Then follow the onscreen instructions:
`mfp push`

Open the Xcode project by double-clicking the **.xcworkspace** file.
Right-click the project and select **Add Files To [ProjectName]**
Select the `worklight.plist` file, located in the Xcode project root folder.

<br>

#### Implement MobileFirst adapter invocation
Open the **AppDelegate.h** file and add the header:

{% highlight objective-c %}
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
{% endhighlight %}

<br>
Open the **AppDelegate.m** file and add the following to `didFinishLaunchingWithOptions`:

{% highlight objective-c linenos %}
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSURL* url = [NSURL URLWithString:@"/adapters/MyAdapter/getFeed"];
  WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
  [request setQueryParameterValue:@"['technology']" forName:@"params"];

  [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
      if(error != nil){
           NSLog(@"%@",error.description);
      }
      else{
          NSLog(@"%@",response.responseJSON);
      }
  }];

  return YES;
}
{% endhighlight %}

<br>
**Click Run**
Review the Xcode console for the data retrieved by the adapter request.

![xcode](ios-quick-start-result.png)

> **Note:** When you use Xcode 7 and iOS 9, read the notes about Apple Transport Security (ATS) and bitcode here: [https://ibm.biz/BdXNsT](https://ibm.biz/BdXNsT).
