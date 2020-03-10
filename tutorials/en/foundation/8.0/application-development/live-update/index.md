---
layout: tutorial
title: Live Update service
relevantTo: [ios,android,cordova]
weight: 11
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80
  - name: Download Live Update adapter
    url: https://github.com/mfpdev/resources/blob/master/liveUpdateAdapter.adapter?raw=true
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

The Live Update feature in {{ site.data.keys.product }} provides a simple way to define and serve different configurations for users of an application. It includes a component in the {{ site.data.keys.mf_console }} for defining the structure of the configuration as well as the values of the configuration. A client SDK (available for Android and iOS **native** and for Cordova applications) is provided for consuming the configuration.

#### Common Use Cases
{: #common-use-cases }
Live Update supports defining and consuming configurations, making it easy to make customizations to the application. An example of a common use cases is:

* Release trains and feature flipping

Following usecases will be supported in future releases.

* A/B testing
* Context-based customization of the application (e.g., geographic segmentation)

<!--
#### Demonstration
{: #demonstration }
The following video provides a demonstration of the Live Update feature.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe title="Demonstration" src="https://www.youtube.com/embed/TjbC9thSfmM"></iframe>
    </div>
</div>
-->

#### Jump to:
{: #jump-to }
* [Live Update Architecture](#live-update-architecture)
* [Adding Live Update to {{ site.data.keys.mf_server }}](#adding-live-update-to-mobilefirst-server)
* [Configuring Application Security](#configuring-application-security)
* [Schema](#schema)
* [Adding Live Update SDK to Applications](#adding-live-update-sdk-to-applications)
* [Using the Live Update SDK](#using-the-live-update-sdk)
* [Advanced Topics](#advanced-topics)
* [Sample Application](#sample-application)


## Live Update Architecture
{: #live-update-architecture }
The following system components function together in order to provide the Live Update functionality.

![Architecture overview](LU-arch.png)

* **Live Update service:** an independent service which provides:
 - Application schema management
 - Serving configurations to applications
* **Client-side SDK:** the Live Update SDK is used to retrieve and access configuration elements such as features and properties from the {{ site.data.keys.mf_server }}.
* **{{ site.data.keys.mf_console }}:** used for configuring the Live Update adapter and settings.

## Adding Live Update to {{ site.data.keys.mf_server }}
{: #adding-live-update-to-mobilefirst-server }
By default, Live Update service is bundled in the {{site.data.keywords.mf_dev_kit}}.

> For OpenShift Container Platform (OCP) installation follow the documentation [here](../../ibmcloud/mobilefoundation-on-openshift/).  

Once the Live Update service is up, the **Live Update Settings** page is then shown for each registered application.

## Configuring Application Security
{: #configuring-application-security }
In order to allow integration with Live Update, a scope element is required. Without the scope element, the service will reject requests from the client applications.  

1. Load the {{ site.data.keys.mf_console }}.
2. Click **[your application] → Security tab → Scope-Elements Mapping**.
3. Click **New** and enter the scope element `configuration-user-login`.
4. Click **Add**.

You can also map the scope element to a security check in case you're using one in your application.

> [Learn more about the {{ site.data.keys.product_adj }} security framework](../../authentication-and-security/)

<img class="gifplayer" alt="Add a scope mapping" src="scope-mapping.png"/>

## Schema
{: #schema }

#### What is Schema
{: #what-is-schema }
A schema is where features and properties are defined.  

* Using **features** you can define configurable application features and set their default values.  
* Using **properties** you can define configurable application properties and set their default values.

### Adding Schema
{: #adding-schema }
Before adding a schema for an application, the developer or product management team needs decide upon about the following.

* The set of **features** to utilize Live Update for, as well as their default state.
* The set of configurable string **properties** and their default value.

Once the parameters are decided upon, Schema features &amp; properties can be added.  
To add, click **New** and provide the requested values.

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="schema">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSchema" aria-expanded="false" aria-controls="collapseSchema">Click to review schema terminology</a>
            </h4>
        </div>

        <div id="collapseSchema" class="panel-collapse collapse" role="tabpanel" aria-labelledby="schema">
            <div class="panel-body">
                <ul>
                    <li><b>Feature:</b> A feature determines if some part of the application functionality is enabled or disabled. When defining a feature in the schema of an application the following elements should be provided:
                        <ul>
                            <li><i>id</i> – A unique feature identifier. String, Non-editable.</li>
                            <li><i>name</i> - A descriptive name of the feature. String, Editable.</li>
                            <li><i>description</i> – A short description of the feature. String, Editable.</li>
                            <li><i>defaultValue</i> – The default value of the feature that will be served unless it was overridden inside the segment (see Segment below). Boolean, Editable.</li>
                        </ul>
                    </li>
                    <li><b>Property:</b> A property is a key:value entity that can be used to customize applications. When defining a property in the schema of an application the following elements should be provided:
                        <ul>
                            <li><i>id</i> – A unique property identifier. String, Non-editable.</li>
                            <li><i>name</i> - A descriptive name of a property. String, Editable.</li>
                            <li><i>description</i> – A short description of the property. String, Editable.</li>
                            <li><i>defaultValue</i> - The default value of the property that will be served unless it was overridden inside the segment (see Segment below). String, Editable.</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

#### Define Schema features and properties with default values
{: #define-schema-features-and-properties-with-default-values }
<img class="gifplayer" alt="Add schema feature and property" src="add-feature-property.png"/>

#### Override default values of features and properties
{: #override-default-values-of-features-and-properties }
Enable a feature and change its default state.
<img class="gifplayer" alt="Enable a feature" src="feature-enabling.png"/>

Override the default value of a property.
<img class="gifplayer" alt="Override a property" src="property-override.png"/>

## Adding Live Update SDK to applications
{: #adding-live-update-sdk-to-applications}
The Live Update SDK provides developers with API to query runtime configuration features and properties that were previously defined in the Live Update Settings screen of the registered application in the {{ site.data.keys.mf_console }}.

* [Cordova plugin documentation](https://github.com/mfpdev/mfp-live-update-cordova-plugin)
* [iOS Swift SDK documentation](https://github.com/mfpdev/mfp-live-update-ios-sdk)
* [Android SDK documentation](https://github.com/mfpdev/mfp-live-update-android-sdk)

### Adding the Cordova plugin
{: #adding-the-cordova-plugin }

In your Cordova application folder run the following command.

```bash
cordova plugin add cordova-plugin-mfp-liveupdate
```

### Adding the iOS SDK
{: #adding-the-ios-sdk }
1. Edit your application's podfile by adding the `IBMMobileFirstPlatformFoundationLiveUpdate` pod.  
 For example:

   ```xml
   use_frameworks!

   target 'your-Xcode-project-target' do
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationLiveUpdate'
   end
   ```

2. From a **command-line** window, navigate to the Xcode project's root folder and run the following commmand.
  ```bash
  pod install
  ```

### Adding the Android SDK
{: #adding-the-android-sdk }
1. In Android Studio, select **Android → Gradle Scripts**, then select the **build.gradle (Module: app)** file.
2. Add `ibmmobilefirstplatformfoundationliveupdate` inside `dependencies`:

   ```xml
   dependencies {
        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundation',
        version: '8.0.+',
        ext: 'aar',
        transitive: true

        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundationliveupdate',
        version: '8.0.0',
        ext: 'aar',
        transitive: true
   }   
   ```

## Using the Live Update SDK
{: #using-the-live-update-sdk }
There are several approaches to using the Live Update SDK.

### Pre-determined Segment
{: #pre-determined-segment }
Implement logic to retrieve a configuration for a relevant segment.  
Replace "property-name" and "feature-name" with your own.

#### Cordova
{: #cordova }
```javascript
    var input = { };
    LiveUpdateManager.obtainConfiguration({useClientCache :false },function(configuration) {
        // do something with configration (JSON) object, for example,
        // if you defined in the server a feature named 'feature-name':
        // if (configuration.features.feature-name) {
        //   console.log(configuration.properties.property-name);
	// }
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });

```

#### iOS
{: #ios }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})

```

#### Android
{: #android }
```java
LiveUpdateManager.getInstance().obtainConfiguration(new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});

```

With the Live Update configuration retrieved, the applicative logic and the application flow can be based on the state of features and properties. For example, if today is a national holiday, introduce a new marketing promotion in the application.

## Advanced Topics
{: #advanced-topics }
### Import/Export
{: #importexport }
Once a schema has been defined, the system administrator can export and import them to other server instances.

#### Export schema
{: #export-schema }
```bash
curl --user admin:admin http://localhost:9080/mfpliveupdate/v1/com.sample.HelloLiveUpdate/schema > schema.txt
```

#### Import schema
{: #import-schema }
```bash
curl -X PUT -d @schema.txt --user admin:admin -H "Content-Type:application/json" http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/schema
```

* Replace `admin:admin` with your own (default is `admin`)
* Replace `localhost` and the port number with your own if needed
* Replace the application identifier `com.sample.HelloLiveUpdate` with your own application's.

### Caching
{: #caching }
Caching is enabled by default in order to avoid network latency. This means that updates may not take place immediately.  
Caching can be disabled if more frequent updates are required.

#### Cordova
{: #cordova-caching }
Controlling client side cache by using an optional _useClientCache_ boolean flag:

```javascript
var input = {useClientCache : false };
      LiveUpdateManager.getConfiguration(input,function(configuration) {
              // do something with resulting configuration, for example:
              // console.log(configuration.data.properties.property-name);  
              // console.log(configuration.data.features.feature-name);
      } ,
      function(err) {
              if (err) {
                 alert('liveupdate error:'+err);
              }
});

```

#### iOS
{: #ios-caching }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(useCache: false, completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})

```

#### Android
{: #android-caching }
```java
LiveUpdateManager.getInstance().obtainConfiguration(false, new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
      Log.i("LiveUpdateSample", configuration.getProperty("property-name"));
      Log.i("LiveUpdateSample", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateSample", wlFailResponse.getErrorMsg());
    }
});

```

### Cache expiration
{: #cache-expiration }
The `expirationPeriod` value is 30 minutes, which is the length of time until the caching expires.

<img alt="Image of the sample application" src="live-update-app.png" style="margin-left: 10px;float:right"/>

## Sample application
{: #sample-application }
In the sample application you select a country flag and using Live Update the app then outputs text in language that corresponds to the selected country. If enabling the map feature and providing the map, a map of the corresponding country will be displayed.

[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80) the Xcode project.  
[Click to download](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80) the Android Studio project.

### Sample usage
{: #sample-usage }
Follow the sample's README.md file for instructions.

#### Changing Live Update Settings
{: #changing-live-update-settings }
Each segment gets the default value from the schema. Change each one according to the language. For example, for French add: **helloText** - **Bonjour le monde**.

In **{{ site.data.keys.mf_console }} → [your application] → Live Update Settings → Segments tab**, click on the **Properties** link that belongs, for example, **FR**.

* Click the **Edit** icon and provide a link to an image that representes for example the France geography map.
* To see the map while using the app, you need to enable to `includeMap` feature.
