---
title: IBM MobileFirst Foundation 8.0 integration with Weather Service offered on Bluemix in combination with Facebook's ReactJS 
date: 2016-08-08
tags:
- MobileFirst_Foundation
version: 8.0
author:
  name: Chevy Hungerford
---
## Overview
This is a sample app that was created to show off how versatile MobileFirst Foundation 8.0 is with UI Frameworks. In this example I demonstrate the ease of using Facebook's ReactJS with MobileFirst Foundation 8.0. For this purpose a  Cordova app was implemented using ReactJS and the MobileFirst SDK, using the Weather Services API from Bluemix.

![Weather App]({{site.baseurl}}/assets/blog/2016-08-08-mobilefirst-foundation-8.0-reactjs/WeatherApp.png)

## Github Repo
View the app and its adapter [on GitHub.com](https://github.com/cshunger/WeatherProject).

## What you should know
Before starting this app you should have a good understanding of JavaScript using the latest features.

It is important to understand Facebook's ReactJS Framework and how to create classes that render the appropriate objects. You can learn about ReactJS [here](https://facebook.github.io/react/).

Lastly, have an understanding of the MobileFirst Foundation 8.0 JavaScript Framework. You can learn more about building a Cordova App [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/cordova-tutorials/).

## What you need
* MobileFirst Foundation DevKit or an instance of the Mobile Foundation Bluemix service. [Read this tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/)
* An instance of Weather Services from Bluemix with the password and host. [Follow these instructions.](https://console.ng.bluemix.net/docs/services/Weather/index.html).
* Cordova: `npm install -g cordova`
* MobileFirst CLI: `npm install -g mfpdev-cli`
* Webpack: `npm install -g webpack`

## Before you begin 
Start your MobileFirst Server. Navigate to the root directory of your MobileFirst Server and execute the `run` script.

From your Weather Services API, gather the host and password for your adapter. Place those values inside the `weatehrAPIUsername` and `weatherAPIPassword` variables in `JavaHttpResource.java` located `JavaHTTP/src/main/java/com/sample`

## Starting the App
To get the app running on an Android device, navigate to the MFPReactApp root folder and run the following commands:

1.`npm install`
2. `cordova add platform android`
3. `webpack`

Register your application with the MobileFirst Foundation 8.0 server: `mfpdev app register`  
Run your application: `cordova run android`

## Deploying the Adapter
Navigate to the root folder of the adapter JavaHttp.

First build the adpter: `mfpdev adapter build`  
Then, Deploy the adapter: `mfpdev adapter deploy`

## Important Highlights

1. MobileFirst needs to call `wlCommonInit` at the beginning of the application start. To achieve this I created a `wlinit.js` file in my common `www/js` directory and injected the script in my `index.html` with the `<script>` tag. I was not able to include this in my JSX because the babel complining did not externalize this function for MFP to call. 

2. I am working off babel `stage-0` but I am using JavaScript that is highly likely to make it into ES7 or ES8. I used `stage-0` because the ease of binding functions to `this` with the fat arrow syntax (`=>`). 

3. These inscructions are for unix machines, they may differ on a windows machine.
