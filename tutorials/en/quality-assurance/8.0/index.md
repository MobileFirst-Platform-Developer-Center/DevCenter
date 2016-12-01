---
layout: tutorial
title: MobileFirst Quality Assurance for MobileFirst Platform Foundation 8.0
breadcrumb_title: 8.0
use_dropdown: true
weight: 1
show_disqus: true
print_pdf: true
relevantTo: [ios,android,cordova]
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
IBM MobileFirst Quality Assurance enables mobile app testing, user validation, and streamlined quality feedback with sentiment analysis, over-the-air build distribution, automated crash reporting, in-app bug reporting and user feedback. To get started with MobileFirst Quality Assurance, go through the following steps.

## Registration and common setup

* Register for a [Bluemix ID](https://console.ng.bluemix.net/registration/).
* After logging in to [Bluemix](https://console.stage1.ng.bluemix.net/home/), add a service instance of MQA by selecting it from the **Services** > **Mobile** section of the Bluemix catalog. Name the service so that you can identify it next to other services on the Bluemix dashboard.
* Select a service plan, read and accept the license information, and select **Create**.
* Add a mobile app to the Mobile Quality Assurance service by clicking **New MQA App** and providing a name for the app.
* Start preparing the app for reporting by clicking **Add Platforms**. Select a platform on which your new mobile app runs. Click **Submit**. Repeat this step for additional platforms.


## Installing required libraries and using the SDKs
The next step is to download and install the required libraries for the selected platforms in order to prepare your app to collect and report data. These procedures varies depending on the platform. Select the appropriate application type below to continue:

* [Cordova](cordova/)
* [iOS](ios/)
* [Android](android/)

> To learn more about MobileFirst Quality Assurance, read the Quality Assurance topics in the user documentation.

