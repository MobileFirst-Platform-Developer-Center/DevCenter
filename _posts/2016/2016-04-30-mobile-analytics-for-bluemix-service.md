---
title: Announcing IBM Mobile Analytics for Bluemix experimental service
date: 2016-04-30
tags:
- MobileFirst_Platform
- Bluemix
- Analytics
version:
- 7.1
- 8.0
author:
  name: Mike Darden
---

> As originally posted [in the Bluemix Developer Center](https://developer.ibm.com/bluemix/2016/04/29/mobile-analytics-for-bluemix-service/).

IBM Mobile Analytics for Bluemix is now available as an experimental service. By using this service, developers, app owners, product managers, or anyone else in your organization can gain valuable insight into how your app is performing and how it is being used. This kind of information is the key to building better apps that are hyper-relevant to users and that stand out in the veritable sea of mobile apps that are available in the marketplace or within your organization.

With the IBM Mobile Analytics for Bluemix service you can:

* Combine immediate and historical insight – Watch real-time updates to performance metrics, active users, and session data and compare to previous time periods to see if your app changes and marketing efforts are working.
* Save valuable development time – Create a service instance on Bluemix, add the SDK to your project, paste two lines of code into your app and in just minutes, you are ready to collect dozens of pre-defined metrics.
* Collect any data you want – Move beyond pre-defined metrics and instrument apps with custom events to discover how users are interacting with your app, to track purchases, or to monitor app activity.
* See metrics for all of your apps at-a-glance – View business-friendly, ready-made, and custom charts in the Mobile Analytics console without engaging a data analyst or writing queries.
* Focus on what is important to you – Filter metrics by date range, app, app version, OS, OS version, or device model.
* Rapidly discover issues – Monitor and compare crash status across all of your apps. Set alert triggers on critical metrics and route alerts to send messages to kick off automated processes.
* Troubleshoot to root cause – Use client-side logging in your app, and then automatically upload the logs and search them from the console. Drill down on crash events to see stack traces.

The experimental version of Mobile Analytics provides client SDKs for iOS 8+ (Swift only) and Android 4+.

![mobile-analytics-screenshot1]({{site.baseurl}}/assets/blog/2016-04-30-mobile-analytics-for-bluemix-service/mobile-analytics-screenshot1.png)

**[Try IBM Mobile Analytics For Bluemix](https://console.ng.bluemix.net/catalog/services/mobile-analytics/?cm_sp=bluemixblog-_-content-_-cta)**

## What Kind of Mobile Data is Collected?
Mobile Analytics collects metrics in three categories: pre-defined metrics, custom events, and client-side developer logs.

### Pre-defined metrics
Pre-defined metrics include generic usage and device information that applies to all apps. Within this category is device metadata (such as operating system and device model) as well as usage data (such as active users and app sessions). Pre-defined data is collected automatically after you add a few lines of code to initialize the Mobile Analytics SDK within your app.

With pre-defined metrics you can answer questions like:

* How many new users do I have?
* How many people are actively using my app?
* How frequently are people using my app?
* What time of day are people using my app?
* What device models do my users prefer?
* When can I deprecate support for legacy operating systems?
* Which apps have performance issues?
* Why is my app crashing?

### Custom Events
Custom events include data items that you define and that are specific to your app. Usually these items represent events that occur within your app such as page views, button taps, or in-app purchases. In addition to initializing the Mobile Analytics SDK in your app, you must add a line of code for each custom event that you want to track.

By adding your own custom events, you can answer questions like:

* What features are used most and least?
* Where are users entering and leaving my app?
* What activities are users viewing most?
* Are users completing workflows in the app? (for example, conversion funnels)

### Client-side Developer Logs
Client-side developer logs enable the developer to add lines of code throughout the app that log custom messages to assist in development and debugging. The developer assigns a severity/verbosity level to each log message and can subsequently filter messages by assigned level or preserve storage space by configuring the app to ignore messages below a given level. Client-side logs can be uploaded to the Mobile Analytics console where they can be searched or offloaded for further analysis. To collect client log data, you must initialize the Mobile Analytics SDK within your app, as well as add a line of code for each log message.

With client-side developer logs, you can answer questions like:

* Is my app healthy?
* What parts of my app are consistently generating errors and warnings?
* What events led up to a crash?

## What’s Next?
IBM Mobile Analytics for Bluemix is an experimental service right now, and we plan to continue adding new features over the coming months. In the mean time, I encourage you to try it out and let us know what you think!

**[Try IBM Mobile Analytics For Bluemix](https://console.ng.bluemix.net/catalog/services/mobile-analytics/?cm_sp=bluemixblog-_-content-_-cta)**