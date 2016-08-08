---
title: IBM MobileFirst Platform's Foundation 8.0 integration with Weather Service offered on Bluemix in combination with Facebook's ReactJS 
date: 2016-08-04 22:11:23.000000000 +02:00
tags:
- MobileFirst_Foundation
version: 8.0
author:
  name: Chevy Hungerford
---

# Weather Project
A MobileFirst Platform Foundation 8.0 project using ReactJS and Weather Services API from Bluemix.

## Overview

This is a sample project that was created to show off how versatile MobileFirst Platform Foundation 8.0 is with UI Frameworks. In this example I demonstrate the ease of using Facebook's ReactJS with MobileFirst Platform Foundation 8.0.

This app is going to display weather data for four areas; Austin, Ann Arbor, New York, and San Francisco. As you press the buttons at the top of the screen the weather will update to the most recent weather report and include a picture of the current weather.

![Weather App]({{site.baseurl}}/assets/blog/2016-08-04-MFP-React-Weather/WeatherApp.png)

---
title: IBM MobileFirst Platform's Foundation 8.0 integration with Weather Service offered on Bluemix in combination with Facebook's ReactJS 
date: 2016-08-04 22:11:23.000000000 +02:00
tags:
- MobileFirst_Foundation
version: 8.0
author:
  name: Chevy Hungerford
---

# Weather Project
A MobileFirst Platform Foundation 8.0 project using ReactJS and Weather Services API from Bluemix.

## Github Project
View the project on [github](https://github.com/cshunger/WeatherProject).

## Overview

This is a sample project that was created to show off how versatile MobileFirst Platform Foundation 8.0 is with UI Frameworks. In this example I demonstrate the ease of using Facebook's ReactJS with MobileFirst Platform Foundation 8.0.

This app is going to display weather data for four areas; Austin, Ann Arbor, New York, and San Francisco. As you press the buttons at the top of the screen the weather will update to the most recent weather report and include a picture of the current weather.

![Weather App]({{site.baseurl}}/assets/blog/2016-08-04-MFP-React-Weather/WeatherApp.png)

## What you should know

Before starting this project you should have a good understanding of JavaScript using the latest features.

It is important to understand Facebook's ReactJS Framework and how to create classes that render the appropriate objects. You can learn about ReactJS [here](https://facebook.github.io/react/).

Lastly, have and understanding of the MobileFirst Platform Foundation 8.0 JavaScript Framework. You can learn more about building a Cordova Project [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/cordova-tutorials/).

## What you need

MobileFirst Platform Foundation DevKit, read getting started for MobileFirst Platform Foundation:

https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/setting-up-your-development-environment/mobilefirst-development-environment/

An instance of Weather Services from Bluemix with the password and host, read getting started for weather services, [here](https://console.ng.bluemix.net/docs/services/Weather/index.html).

Cordova: `npm install -g cordova`

MFP CLI: `npm install -g mfpdev-cli`

Webpack: `npm install -g webpack`

## Before you begin 

Start your MobileFirst Platform Foundation 8.0 server. Navigate to the root directory of your MobileFirst Server and execute the `run` script.

From your Weather Services API, gather the host and password for your adapter. Place those values inside the `weatehrAPIUsername` and `weatherAPIPassword` variables in `JavaHttpResource.java` located `JavaHTTP/src/main/java/com/sample`

## Starting the App

To get the App running on an android device navigate to the MFPReactApp project root and run the following commands:

`npm install`

`cordova add platform android`

`webpack`

Register your application with the MobileFirst Platform Foundation 8.0 server:

`mfpdev app register`

Run your application:

`cordova run android`

## Deploying the Adapter

Navigate to the root folder of the adapter JavaHttp.

First build the adpter:

`mfpdev adapter build`

Then, Deploy the adapter:

`mfpdev adapter deploy`

## Important Highlights

1. MobileFirst needs to call `wlCommonInit` at the beginning of the application start. To achieve this I created a `wlinit.js` file in my common `www/js` directory and injected the script in my `index.html` with the `<script>` tag. I was not able to include this in my JSX because the babel complining did not externalize this function for MFP to call. 

2. I am working off babel `stage-0` but I am using JavaScript that is highly likely to make it into ES7 or ES8. I used `stage-0` because the ease of binding functions to `this` with the fat arrow syntax (`=>`). 

3. These inscructions are for unix machines, they may differ on a windows machine.

## What you should know

Before starting this project you should have a good understanding of JavaScript using the latest features.

It is important to understand Facebook's ReactJS Framework and how to create classes that render the appropriate objects. You can learn about ReactJS [here](https://facebook.github.io/react/).

Lastly, have and understanding of the MobileFirst Platform Foundation 8.0 JavaScript Framework. You can learn more about building a Cordova Project [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/cordova-tutorials/).

## What you need

MobileFirst Platform Foundation DevKit, read getting started for MobileFirst Platform Foundation:

https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/setting-up-your-development-environment/mobilefirst-development-environment/

An instance of Weather Services from Bluemix with the password and host, read getting started for weather services, [here](https://console.ng.bluemix.net/docs/services/Weather/index.html).

Cordova: `npm install -g cordova`

MFP CLI: `npm install -g mfpdev-cli`

Webpack: `npm install -g webpack`

## Before you begin 

Start your MobileFirst Platform Foundation 8.0 server. Navigate to the root directory of your MobileFirst Server and execute the `run` script.

From your Weather Services API, gather the host and password for your adapter. Place those values inside the `weatehrAPIUsername` and `weatherAPIPassword` variables in `JavaHttpResource.java` located `JavaHTTP/src/main/java/com/sample`

## Starting the App

To get the App running on an android device navigate to the MFPReactApp project root and run the following commands:

`npm install`

`cordova add platform android`

`webpack`

Register your application with the MobileFirst Platform Foundation 8.0 server:

`mfpdev app register`

Run your application:

`cordova run android`

## Deploying the Adapter

Navigate to the root folder of the adapter JavaHttp.

First build the adpter:

`mfpdev adapter build`

Then, Deploy the adapter:

`mfpdev adapter deploy`

## Important Highlights

1. MobileFirst needs to call `wlCommonInit` at the beginning of the application start. To achieve this I created a `wlinit.js` file in my common `www/js` directory and injected the script in my `index.html` with the `<script>` tag. I was not able to include this in my JSX because the babel complining did not externalize this function for MFP to call. 

2. I am working off babel `stage-0` but I am using JavaScript that is highly likely to make it into ES7 or ES8. I used `stage-0` because the ease of binding functions to `this` with the fat arrow syntax (`=>`). 

3. These inscructions are for unix machines, they may differ on a windows machine.
