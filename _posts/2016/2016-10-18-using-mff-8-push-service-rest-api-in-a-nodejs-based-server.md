---
title: Using MobileFirst Foundation 8.0's Push Service REST API in a Node.js-based server
date: 2016-10-18
version:
- 8.0
tags:
- MobileFirst_Foundation
- Push_Notifications
- Nodejs
- Bluemix
- Mobile_Foundation
author:
  name: Thomas Südbröcker
---
## Overview
It is nice and easy to send simple push notifications in MobileFirst Foundation 8.0 (from the MobileFirst Operations Console or via REST API), but how do you send push notifications which provides more complex data such as when temperature is low, when you're driving too fast and so on. 

To that end, I've implemented a mobile application that integrates several Bluemix services related to IoT, Watson services and so on.

Getting the Authorization key with Postman is not flexible enough, so instead I wrote a self-Authorization node.js module. This module enables me to easily creat different instances on one or more Node.js servers.

To get started, lets watch a video.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/VbSQpY5hOzU"></iframe>
    </div>
</div>

## Sample project
The Nodejs module I have created is available for download [from this GitHub.com repository](https://github.com/thomassuedbroecker/MobileFirstPushV8OnNodeJS).  

Please note tha this is only the Nodejs server. I expect you to have an already functioning application with push notifications capability. To quickly setup such an app, you can use the sample application provided [in the MobileFirst Foundation Developer Center](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsCordova/tree/release80).

For setup instructions, refer to the GitHub repository.