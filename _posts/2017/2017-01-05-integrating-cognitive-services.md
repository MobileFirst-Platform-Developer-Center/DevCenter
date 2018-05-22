---
title: 'New Lab: Using Cloudant, The Weather Company, and Watson Speech to Text to build a Cognitive MobileFirst App'
date: 2017-01-05
tags:
- MobileFirst_Foundation
- Mobile_Foundation_Service
- Bluemix
- Lab
- Watson
version: 8.0
author:
    name: Mike Billau
---
## Integrating Watson Cognitive Services with Foundation Lab
Using IBM's Watson cognitive services with Bluemix makes it easier than ever to consume Watson services with your Mobile Foundation application. We have created a new lab that shows the process of creating a hybrid Mobile Foundation application that utilizes the Watson Speech to Text service. In this lab, we also show how to integrate with the new Weather Company Data service to get localized weather updates.

![Phone screens]({{site.baseurl}}/assets/blog/2017-01-05-integrating-cognitive-services/screenstory.png)

## Scenario
In this lab, we will be taking on the role of a Utilities Company that sends out field engineers to inspect and repair utility equipment, such as power lines or backflow preventers. We want to build a mobile application that will allow the field engineers to quickly find their next scheduled work item, warn them if there is inclement weather at the location, and allow them to easily fill in the report form using voice services. The application needs to work for both iOS and Android.

We will be utilizing the Bluemix services:
 - [MobileFirst Foundation](https://console.bluemix.net/catalog/services/mobile-foundation)
 - Cloudant - to store work items
 - Weather Company Data - to check the weather at work locations
 - Watson Speech to Text - to securely transcribe an audio file with Watson services


## Check It Out
Head over to [the Lab page](https://mobilefirstplatform.ibmcloud.com/labs/developers/8.0/advancedutilityservice/) and let us know if you have any questions!
