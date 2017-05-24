---
title: 'Power your Progressive Web Apps with Mobile Foundation and Node.js Runtime on Bluemix'
date: 2017-05-23
tags:
- MobileFirst_Foundation
- Bluemix
- Progressive Web Apps
- Node.js
version:
- 8.0
author:
  name: Srihari Kulkarni
---

### Introduction

Progressive web apps - this is a term that we hear more often in recent times. So, what is a Progressive Web Apps or PWA for short ? 

* Is it a new type of mobile apps ? No 
* Is it an app or website built using a new framework ? No 
* Is it a new industry standard or technology ? No

Progressive Web Apps is a new approach of developing web apps using existing technologies. Making use of existing standards of HTML5 and browser capabilities to make web apps more user friendly in a multi-channel (desktop, tablet, mobile) world. More specifically, progressive web apps are required to be 

1. Responsive - adapt the UI to different form factors - desktop, tablet, mobile 
2. Fast - load faster than a normal web app by loading cached web resources
3. Network resilient - PWAs should load atleast the home page when the device is offline and be resilient to network conditions by caching data when it is available. 

The above list provides a picture of how PWAs are different from a traditional web app. The list is by no means a comprehensive one, however, you can see the [complete checklist for PWAs here](https://developers.google.com/web/progressive-web-apps/checklist).

### Your own PWA with IBM Bluemix and Mobile Foundation
In the following video, you will see how to host a mobile web app using the [SDK for Node.js on IBM Bluemix](https://console.ng.bluemix.net/catalog/starters/sdk-for-nodejs?env_id=ibm:yp:us-south&taxonomyNavigation=apps). The Node.js app itself will host the web content and will integrate with a [Mobile Foundation service](https://console.ng.bluemix.net/catalog/services/mobile-foundation?env_id=ibm:yp:us-south&taxonomyNavigation=apps) for security, backend connectivity and user management. 

At the heart of a PWA is the concept of a service worker. In this video, you'll also see how to add a service worker to your web app and how the service worker will equip your web app with offline capabilities. 

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/OUNp2RF9cvQ"></iframe>
  </div>
</div>

You can use this video as a starting point and build your web application to include more progressive web app features. [Download the complete source code of the project demonstrated here](https://ibm.box.com/v/PWAwithMFP).