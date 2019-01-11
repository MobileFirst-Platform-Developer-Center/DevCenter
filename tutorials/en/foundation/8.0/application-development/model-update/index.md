---
layout: tutorial
title: Using Model Update in iOS applications
breadcrumb_title: Model Update
relevantTo: [iOS]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
With the introduction of on-device machine learning (ML) models such as CoreML and TensorFlow Lite, mobile apps can now perform ML operations such as image recognition, speech to text etc., on the device even when the device is offline. An important characteristic of a machine learning model is that they continuously evolve. Updating these models with their newer versions, on a device, becomes extremely critical to the success of a mobile app.

To assist with this requirement, IBM Mobile Foundation introduces the Model Update feature. Mobile Foundation applications can now embed ML models, which can be updated "over-the-air" with newer versions. Organizations are thus able to ensure that end-users always use the updated AI models.

Compress the latest model(s) into a zip format, in order to send the model version to an application. This `.zip` needs to be uploaded under the **Machine Learning** tab of the MobileFirst Operations console. Model Update is then activated whenever the application invokes `downloadModelUpdate` API.

>**Supported platforms:**  Currently, Model Update is supported only for iOS.  

### Points to note
{: #notes }
* Model Update updates only the Artificial Intelligence models like Apple's CoreML Model or Google's TensorFlow Model.

#### Jump to:
{: #jump-to}

- [How Model Update works](#how-model-update-works)
- [Creating and deploying model packages](#creating-and-deploying-model-packages)
- [Invoking an update](#invoking-an-update)

## How Model Update works
{: #how-model-update-works }
The models are initially packaged with the application to ensure first offline availability. Later, the application checks for updates with the {{ site.data.keys.mf_server }} whenever the `downloadModelUpdate` API is invoked.

After a Model Update, `downloadModelUpdate` API returns the location of the downloaded model and this location gets updated whenever an update is performed.

### Versioning
{: #versioning }
A Model Update applies only to a specific application version. In other words, updates generated for an application versioned 2.0 cannot be applied to a different version of the same application.

## Creating and deploying model packages
{: #creating-and-deploying-model-packages }
When a newer or updated version of the model is available, follow the steps below to upload the model file to the {{ site.data.keys.mf_server }}.

### Steps:

 1. Create an `.zip` archive of one or more machine learning model files (e.g. `.mlmodel` ).
 2. Open the {{ site.data.keys.mf_console }} and click the application entry in the left panel.
 3. Navigate to **Machine Learning** tab and click  **Upload model archive** to upload the packaged models.

## Invoking an update
{: #invoking-an-update }
Model update in the application can be checked by invoking the following API.

### iOS

```
 WLClient.sharedInstance().downloadModelUpdate(completionHandler: CompletionHandler, hideProgressBar: Boolean);
```

Typically, application developers should call this API during the startup of the application.

The `downloadModelUpdate` API returns one of the following status codes and a link to the downloaded package, if the download is successful, or the path to the previously downloaded package is returned.

The final status will be one of the following codes:

| Status code | Description |
|-------------|-------------|
| `SUCCESS` | Model update finished with no errors. |
| `CANCELED` | Model update was canceled. |
| `FAILURE_NETWORK_PROBLEM` | There was a problem with a network connection during the update. |
| `FAILURE_DOWNLOADING` | The file was not downloaded completely. |
| `FAILURE_NOT_ENOUGH_SPACE` | There is not enough space on the device to download and unpack the update file. |
| `FAILURE_UNZIPPING` | There was a problem unpacking the update file. |
| `FAILURE_ALREADY_IN_PROGRESS` | An update was requested when one was already in progress. |
| `FAILURE_INTEGRITY` | Authenticity of update file cannot be verified. |
| `FAILURE_UNKNOWN` | Unexpected internal error. |


## Secure Model Update
{: #secure-model-update }
Disabled by default, Secure Model Update prevents a third-party attacker from altering the models that are transferred from the {{ site.data.keys.mf_server }} (or from a Content Delivery Network (CDN)) to the client application.

### To enable Model Update authenticity
Using a preferred tool, extract the public key from the {{ site.data.keys.mf_server }} keystore and convert it to base64.  
The produced value should then be used as below:

1. In the client application, open the mobilefirst configuration file (i.e `mfpclient.plist` for iOS and `mfpclient.properties` for Android).
2. Add the new key value called `wlSecureModelUpdatePublicKey`.
3. Provide the public key for the corresponding key value and save.

Any future Model Update deliveries to client applications will be protected by Model Update authenticity.

> To configure the application server with the updated keystore file, see [Implementing secure Model Update](secure-model-update/)

### Model Update in development, testing, and production
For development and testing purposes, developers typically use Model Update by simply uploading an archive to the development server. While this process is easy to implement, it is not very secure as models can be tampered either during transit or after being downloaded on the device.

For the production or even pre-production testing phase, it is strongly recommended to implement secure Model Update before you publish your application to the app store. Secure Model Update requires an RSA key pair that is extracted from a CA signed server certificate.

>**Note:** Take care that you do not modify the keystore configuration after the application was published, updates that are downloaded can no longer be authenticated without reconfiguring the application with a new public key and republishing the application. Without performing these steps, Model Update fails on the client.

> Learn more in [Secure Model Update](secure-model-update/).

### Model Update data transfer rates
At optimal conditions, a single {{ site.data.keys.mf_server }} can push data to clients at the rate of 250 MB per second. If higher rates are required, consider a cluster or a CDN service.
