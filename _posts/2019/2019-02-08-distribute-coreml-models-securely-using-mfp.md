---
title: Distribute CoreML models securely using Mobile Foundation server
date: 2019-02-08
tags:
- Mobile_Foundation
- CoreML
version:
- 8.0
author:
  name: Krishnakumar Bala
---
CoreML is a framework by Apple which helps to integrate machine learning models into your IOS apps. The model can execute on the device and is optimized for performance, minimizes memory footprint and reduces power consumption. Adding ML to mobile apps opens up new capabilities for client side mobile applications.

## Models on the device

Traditionally most visual recognition applications rely on API calls made over HTTP to the server. With the advent of CoreML this capability can move to the device as models can be executed locally.  The trained model deployed on the device can be built using Watson Studio.

## Managing distribution of CoreML models

In Mobile Foundation we are introducing the feature to manage the distribution of models.  The capabilities in the feature are:
* Distribute models securely from server to client.
* Supports update of model from a CDN [ Content Delivery Network ]. CDN removes network overhead from  the Mobile server and offers higher transfer rates.
* The admin interface is provided by Mobile Foundation admin console.
* Update the model on the server to push the latest model to client devices

## Example from Insurance

Let’s look at an example use case from an insurance company, which uses a mobile app to assess vehicle damage.  The advisors of the company primarily use this app when they meet customers.  The app can work offline as some locations do not have network connectivity.  Using the app an advisor can take images of the vehicle and assess the damage. The backend server receives the data from the mobile app to process claims.   

The ML capability is provided by a Watson Visual recognition model which is available on the device. This model can identify damages like flat tire, broken windshield, scratches on the car body and dents.  The app uses the model to assess the damage and sends a report to the server.  Whenever there is a new version of the model the administrator uploads the same to the server and it gets published to the client devices.

You can easily add ML capabilities to your apps and ensure security and management is provided by Mobile Foundation server.

>Try out this feature
This feature is available as part of the [iFix IF201902040810](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).  Login to the admin console to upload a model for distribution to client devices.
