---
title: Using MobileFirst Foundation 8.0's Push REST API on a Node.js Server
date: 2016-09-30
tags:
- MobileFirst_Foundation
- Push_Notifications
- REST
- Nodejs
version:
- 8.0
author:
  name: Thomas Südbröcker
---
It is nice to send a push from the MobileFirstServer, but how to send Push from a Server which provide information like the temperature is low, you driving to fast and so on?

I did a more complex MobileApp with integration to several Bluemix Services on several NodeJS server related to IoT, Watson Services and so on, I want so send several different push messages in different situations.

Getting the Authorization key with postman is not a very good way to be flexible in this case. I must write a self-Authorization nodejs push module to be not depended.

Based on this situation I build a Module for reuse, which enables me to create easy different pushes instances on one or more NodeJS server.

Maybe it helps you to get a fast start on the the MobileFirstFoundation Push REST API in your own applications.