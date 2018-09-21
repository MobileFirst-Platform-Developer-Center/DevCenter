---
title: Building a React Native Application With IBM MobileFirst Foundation 8.0
date: 2016-09-28
version:
- 8.0
tags:
- MobileFirst_Foundation
- React_Native
author:
  name: Ishai Borovoy
additional_authors:
  - Carmel Schindelhaim
---
> This blog post is obsolete. You can now use the MobileFirst SDK for React Native apps to connect your React Native with IBM MobileFirst Foundation. [Learn more](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/).


## Introduction
Mobile native development can be challenging for many organizations. You need developers with special, and often 'expensive' skills. And it's likely harder to find developers with these skills, since according to [Github](http://githut.info/) and [stackOverflow](http://stackoverflow.com/research/developer-survey-2016#technology), JavaScript is by far the most popular programming language today.

So what do you do when the majority of your development team are JavaScript developers? The team already has experience developing several hybrid apps serving your organization's internal needs. But now product management is demanding a new 'high end' B2C app, and you want it to be native.

Fortunately, there are several technologies that allow you produce native apps while coding in JavaScript. Such as [NativeScript](https://www.nativescript.org/) and [tabrisjs](https://tabrisjs.com/).

One framework that is gaining a lot of buzz among front-end developers is [React Native](https://facebook.github.io/react-native/), developed by Facebook. It was released a year and a half ago, and nowadays it's' looking a lot more mature. React Native is designed for building native iOS & Android applications, and is not meant to be a cross platform write once, run anywhere tool. Rather it's moto is "learn once, write anywhere."

<img alt="React" src="{{site.baseurl}}/assets/blog/2016-09-28-running-mobilefirst-foundation-and-react-native-application/react.png" style="float:right;margin: 10px"/>

So what's so great about React Native? The main advantage is that it allows you to develop applications with a highly responsive UI, overcoming the compromises typically associated with html5 UI. With React Native, you write your application logic in JavaScript, whereas your application UI is fully native.

If you use any of these JavaScript based frameworks, you'll still need some developers with native programming skills on your team. Like when you want to add a new native capability, or call a custom native API. But you can probably achieve a balance that is heavily skewed towards JavaScript - maybe 90% of your team.

f you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, read this post as in this blog we'll walk through some key points about React Native development, and how to call [MobileFirst Foundation](https://mobilefirstplatform.ibmcloud.com/) native APIs in iOS or Android if you are using React Native.

## Demo

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/VUQEgpdkHwA"></iframe>
  </div>
</div>

</br>

> You can find the app sample which you can work with in the [following link](https://github.com/mfpdev/mf-foundation-and-react-native).


## React - "A JavaScript library for building user interfaces"
React is mainly used as a view / UI layer, as stated on the React [main site](https://facebook.github.io/react/)  - *"A JAVASCRIPT LIBRARY FOR BUILDING USER
INTERFACES"*.  React uses the [declarative](http://stackoverflow.com/questions/33655534/difference-between-declarative-and-imperative-in-react-js) approach.  [JSX](https://facebook.github.io/react/docs/jsx-in-depth.html) can be used for the view layer - this is recommended by Facebook.

Here is code snippet from the sample ([BlogEntries.js](https://github.com/mfpdev/mf-foundation-and-react-native/blob/master/BlogEntries.js)) that renders the blog entries list:

```javascript
class BlogEntries extends Component {
  constructor(props) {
      super(props);
      var dataSource = new ListView.DataSource(
          { rowHasChanged: (r1, r2) => r1.title !== r2.title });
      // State
      this.state = {
          dataSource: dataSource.cloneWithRows(this.props.entries)
      };
  }
  // Render function called each time after state changes via setState
  render() {
       return (
           //View - JSX code
           <ListView
               dataSource={this.state.dataSource}
               renderRow={this.renderRow.bind(this)}/>
       );
   }
   ...
}
```

The UI is declared with JSX inside each component, and when the state of a component changes (`setState`), the render function is called.

One of the main advantages of the React Native is the performance gained by using the [React virtual DOM mechanism](https://facebook.github.io/react/docs/glossary.html). Instead of refreshing the whole view when a state changes, there is special mechanism in React called [reconciliation](https://facebook.github.io/react/docs/reconciliation.html) which compares the current UI to the UI intended to replace it, and identifies the delta. This allow React to write the minimum changes to the native view or to the DOM (in case of ReactJS).

Each component (used to represent a view) in React contains the view, the style, and the state.


## Native Modules - exposing custom native code / API

React Native exposes tons of UI components, but what happens if you need to call an SDK or you want expose an SDK to React Native?  React lets you do this, but it requires some native skills. Still you can complete most of your app development in JavaScipt.

In the [sample code](https://github.com/mfpdev/mf-foundation-and-react-native) I exposed few APIs from IBM MobileFirst native SDKs. The APIs exposed in the sample let you call an adapter, register and handle a security challenge handler.

Let's see as example how `WLResourceRequest` and one of its method is exposed in objective-c (iOS) and java (Android):

> Exposing new native abilities can also be done in Swift, but requires few more steps. See: [link](https://facebook.github.io/react-native/docs/native-modules-ios.html#exporting-swift)

- [WLResourceRequestRN.m](https://github.com/mfpdev/mf-foundation-and-react-native/blob/master/ios/MobileFirstAndReactNative/WLResourceRequestRN.m) - exposing WLResourceRequest in Android with Promise approach

``` objective-c
RCT_EXPORT_METHOD(asyncRequestWithURL:(NSString *)urlString method:(NSString *)method resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  NSURL *url = [NSURL URLWithString:urlString];
  WLResourceRequest* resourceRequest = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
  [resourceRequest sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
    NSString* resultText;
    if(error != nil){
      resultText = @"Invocation failure.";
      reject(@"Invocation failure.", resultText, error);
    }
    else{
      resolve(response.responseText);
    }
  }];
}
```   

- [WLResourceRequestRN.java](https://github.com/mfpdev/mf-foundation-and-react-native/blob/master/android/app/src/main/java/com/github/mfpdev/sample/MobileFirstAndReactNative/wlrnapi/WLResourceRequestRN.java) - exposing WLResourceRequest in Android with Promise approach


``` java
@ReactMethod
public void asyncRequestWithURL(
        String url,
        String method,
        final Promise promise) {
    try {
        WLResourceRequest request = new WLResourceRequest(URI.create(url),method);
        request.send(new WLResponseListener(){
            public void onSuccess(WLResponse response) {
                promise.resolve(response.getResponseText());
                Log.d("Success", response.getResponseText());
            }
            public void onFailure(WLFailResponse response) {
                promise.reject(response.getErrorStatusCode(), response.getErrorMsg());
                Log.d("Failure", response.getErrorMsg());
            }
        });
    } catch (IllegalViewOperationException e) {
        promise.reject("failure" ,e.getMessage(), e);
    }
}
```

- ([Main.js](https://github.com/mfpdev/mf-foundation-and-react-native/blob/master/Main.js)) - In JavaScript we can call and even use same code for Android and iOS

``` javascript
async getMFBlogEnriesAsPromise() {
    SecurityCheckChallengeHandlerRN.cancel("UserLogin");
    var error = "";
    this.setState({ isLoading: true, message: '' });
    try {
        var result
        result = await WLResourceRequestRN.asyncRequestWithURL("/adapters/MFBlogAdapter/getFeed", WLResourceRequestRN.GET);
        this.handleResponse(JSON.parse(result))
    } catch (e) {
        error = e;
    }
    this.setState({ isLoading: false, message: error ? "Failed to retrieve blog entries - " + error.message : ""});
}
```

The JavaScript above is the using the new ES6 async/await approach. In React Native you can choose to implement a call to async API either with this approach, or with a callback. The [sample](https://github.com/mfpdev/mf-foundation-and-react-native) will show you both ways to do it.

That way the native experts in your team can go and expose as many API they needs or even build special native components.

For more information about NativeModules and Native UI Components see the following links:

- [iOS NativeModules](https://facebook.github.io/react-native/docs/native-modules-ios.html)

- [Android NativeModules](https://facebook.github.io/react-native/docs/native-modules-android.html)

- [iOS Native UI Components](https://facebook.github.io/react-native/docs/native-components-ios.html)

- [Android Native UI Components](https://facebook.github.io/react-native/docs/native-components-android.html)

As you saw here, exposing native code in React Native is not hard, and IBM MobileFirst Foundation is open to it, but requires some native skills.

## Bridging

The first time you run the ReactNative application in development, you will see the packager start in terminal window. This is actually the local server that packages and serves the JS file for your app. To view the served file for each platform, you can browse the following URLs:

- iOS *->* [http://localhost:8081/index.ios.bundle](http://localhost:8081/index.ios.bundle)
- Android *->* [http://localhost:8081/index.android.bundle](http://localhost:8081/index.android.bundle)

> The default port is 8081 but it can be changed. You will find it in the packager window

Those files are loaded when application starts in development for the first time, and they indicate how the application UI should be rendered during runtime.

The mechanism that React uses to build the native application from the javascript file is called bridging. For further reading follow this [link](https://facebook.github.io/react-native/docs/communication-ios.html). The javascript that you write in development is added to one file that is loaded during runtime. The file can load from remote or local. If you look into the [AppDelegate.m](https://github.com/mfpdev/mf-foundation-and-react-native/blob/master/ios/MobileFirstAndReactNative/AppDelegate.m) file in Xcode you will be able to see where this happens:

```objective-c
jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
```

The ability to load code remotely can be big advantage in development. This enables you to share code with other team members, or even share it with other groups like QA. And each group can work with a different URL, meaning they can work with different version of the application, which can speed up development.

> Note that calling the bridging mechanism too often can lead to degradation in UI performance.  For more information about performance in React Native follow this [link](https://facebook.github.io/react-native/docs/performance.html)

## Inspect & Debug

React Native lets you easily debug and inspect your application with a built in tool, which you can access via In-App Developer Menu. All the javascript code can be debugged with chrome developer tools, or with your other favorite javascript debugger. For more info on debugging your code, follow this [link](https://facebook.github.io/react-native/docs/debugging.html).

Here is short demo which show you a debug session for the sample app:

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/j5TEePSQVxI"></iframe>
  </div>
</div>


## React Native Playground

"...The Playground is a place to easily test and share React Native applications. React Native hosts an in-browser code editor, an iOS simulator, and React Native packager instances to quickly test changes to your apps..." - [https://rnplay.org/about](https://rnplay.org/about)

To access the playground follow this [link](https://rnplay.org/)
