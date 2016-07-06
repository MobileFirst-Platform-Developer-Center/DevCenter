---
title: 'An IoT Cloud, Bluemix and MobileFirst Sample - What makes you happy?'
date: 2016-02-03
tags:
- MobileFirst_Platform
- Bluemix
- IoT
version:
- 7.1
author:
  name: Thomas Suedbroecker
---
## Introduction
Question: What makes you happy, in the current and future world? IoT, PaaS or Mobile?

Actually a lot of different new topics can be combined more or less in one Buzzword called **[Cloud](https://en.wikipedia.org/wiki/Cloud_Computing)**.

And my answer to that question is: "Only the combination of all these topics are strong enough, to address  the upcoming needs of consumers or business use cases. The Cloud is the clamp for all these topics."

* [Internet of Things](https://en.wikipedia.org/wiki/Internet_of_Things) -  we need to get physical information input from our 3D real world we living in.
* [Platform as a Service](https://en.wikipedia.org/wiki/Platform_as_a_Service) - is our single point of entry to develop and run the business critical systems of tomorrow.
* Using [MobileApps](https://en.wikipedia.org/wiki/Mobile_App) - to interact with the information and data from the real and “virtual” world, to do what we need to do: to be more effective, having more fun, being healthier...

All these topics are very interesting! With this in mind the starting point was born for the decision, to build sample.
Building a sample which takes the advantage of all of that topics and helps getting to know, how all these topics working together in a Cloud environment.

The best place to do that is the "Platform as a Service" called [IBM Bluemix](https://console.ng.bluemix.net/).

> Note: Not only thinking about the benefit of these topics is important, also to understand, how these topics fitting other technically is very important.


Here a sample "business usecase" for the integrated usage of IoT Cloud, Bluemix and MobileFirst.  
This sample is the starting point, to build a whole System which runs inside Bluemix.

Monitor sensible ware (goods, food, electronics, etc.) temperature – ware which is stored in special containers that have sensors for location and temperature control.

### Questions:

1. Is the Temperature in critical condition?
2. How can I notify the closest service operator or the driver in case of emergency?

#### Objective:
Monitor the state of the container and notify on emergency Report a problem if needed with Picture / Comment Get a list of currently available drivers to check the situation.

#### Solution: 
The temperature sensors can be connected and managed over the Bluemix IoT cloud service monitored over a mobile application having the backend running on Bluemix. The mobile application allows feedback (comments and picture) Notifications can be sent via SMS, Twitter, email, voice, etc.

The System we build is called **TempTracker**. :-)

### IoT Cloud, Bluemix and MobileFirstPlatfrom... trying to understand
This playlist does contain three videos, which trying to help you to understand, how the integration technical works.

1. How to get Sensor Data into the [IoT Cloud](http://www-03.ibm.com/software/products/en/internet-of-things-foundation)  and use it in [Bluemix with Node-RED](https://www.ng.bluemix.net/docs/#starters/Node-RED/nodered.html#nodered).
2. Use Node-RED to build your own logic and use a Watson service.
3. Build a Mobile App based on MobileFirstPlatform and connect to the Bluemix Application.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/watch?v=M2cB16U2Z2o&list=PLUte4WEyMEjU83oQIjqOKIPm35q9I1eZd"></iframe>
    </div>
</div>

### Where to get more technical insights?
I hope the playlist helped you to understand the technical background in a very first step.
If you want to dive more deeper in the different technical topics, here so links you can follow.

#### How to connect your Sensor to the IoT Cloud?

* Connect to the IoT Foundation Registered Service using an iOS Device: [https://developer.ibm.com/recipes/tutorials/connect-a-cc2650-sensortag-to-the-iot-foundations-quickstart/](https://developer.ibm.com/recipes/tutorials/connect-a-cc2650-sensortag-to-the-iot-foundations-quickstart/) - more or less the same with android

* Building your own IoT Device using [MQTT](http://www.mqtt.org)!  
If you searching for that, you should take a look here: [http://www.ibm.c​om/developerwor​ks/cloud/librar​y/cl-bluemix-ar​duino-iot1/](http://www.ibm.c​om/developerwor​ks/cloud/librar​y/cl-bluemix-ar​duino-iot1/)

### How to create a Bluemix Application, add services and use Node-RED?

* (Boilerplates) Internet of Things Foundation Starter <a href="https://console.ng.bluemix.net/catalog/">https://console.ng.bluemix.net/catalog/</a>
* Play audio from the <a href="http://www.ibm.com/cognitive/de-de/outthink/index.html?S_TACT=EUCACOGDES1&amp;iio=other&amp;cmp=ibm_ca_outthink_de&amp;ct=EUCACOGDES1&amp;cr=google&amp;cm=k&amp;csot=-&amp;ccy=-&amp;cpb=-&amp;cd=-&amp;ck=+watson_+computer&amp;cs=broadmatch" target="_blank">Watson</a> Text to Speech service
<a href="http://flows.nodered.org/flow/69782a1b2e814ac5e57d">http://flows.nodered.org/flow/69782a1b2e814ac5e57d</a>
* Handle <a href="https://cloudant.com/" target="_blank">Cloudant</a>** data Erase all documents in a Cloudant database <a href="http://flows.nodered.org/flow/7d4b5c1189c8f5df3a1f">http://flows.nodered.org/flow/7d4b5c1189c8f5df3a1f</a>

### How to configure the Cloudant database? Possible Information source:

* Using Search index in Node-RED: <a href="https://developer.ibm.com/answers/questions/208950/node-red-cloudant-search-index-configuration-retur.html#answer-248075">https://developer.ibm.com/answers/questions/208950/node-red-cloudant-search-index-configuration-retur.html#answer-248075</a>

### How to configure the "MobileFirstStarter" container in Bluemix?

* Getting started with the ibm-mobilefirst-starter image for Bluemix <a href="https://www.ng.bluemix.net/docs/images/mobilefirst/index.html">https://www.ng.bluemix.net/docs/images/mobilefirst/index.html</a>
* Take a look here in <a href="http://mfp.help" target="_blank">http://mfp.help</a>

### How to setup a local MobileFirst Server and upload the MobileApp?

* Take a look here in <a href="http://mfp.help" target="_blank">http://mfp.help</a>
* Get the MFP Developer Command line Edition <a href="https://developer.ibm.com/mobilefirstplatform/install/">https://developer.ibm.com/mobilefirstplatform/install/</a>
* Using CLI to create, build, and manage MobileFirst project artifacts <a href="https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-6-3/advanced-client-side-development/using-cli-create-build-manage-project-artifacts">https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-6-3/advanced-client-side-development/using-cli-create-build-manage-project-artifacts</a>
