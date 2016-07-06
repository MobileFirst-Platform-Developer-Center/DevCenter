---
title: 'HowTo: Custom In-App Behavior Analytics'
date: 2016-01-22
tags:
- MobileFirst_Platform
- Analytics
version:
- 7.0
- 7.1
author:
  name: Yoel Nunez
---
## Overview

Starting with MobileFirst Platform Foundation v7.0 you can visualize data collected in the analytics repository, this includes data collected by the analytics framework and custom data that you have instrumented your app to collect.

The ability to create custom charts to visualize user behavior in your app allows you make decisions on how to improve your usability, user experience and conversions.

For more information about custom analytics visit [IBM MobileFirst Platform Foundation Knowledge Center](https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.monitor.doc/monitor/c_op_analytics_customanalytics.html?lang=en)

## Video Demonstration

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/knkNJIKv_Jk"></iframe>
    </div>
</div>

## Code Sample

**GitHub Repository**: [https://github.com/MobileFirst-Platform-Developer-Center/MobileFirstBanking](https://github.com/MobileFirst-Platform-Developer-Center/MobileFirstBanking)

The following code is from the <code>app-analytics.js</code> file:

```javascript
/*
 *  © Copyright 2015 IBM Corp.
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

var AppAnalytics = (function (WL) {
    'use strict';

    //Count number of pages visited in a session
    var pageVisitCount = 0;
    //Start time for when user starts a new session
    var appStartTime = new Date();
    
    //Logs returning users of the application
    function logUserReturning(user) {
        WL.Analytics.log({userReturning: user.userID}, 'UserReturning');
    }
    
    //Logs new users of the application
    function logUserNew(user) {
        WL.Analytics.log({userNew: user.userID}, 'UserNew');
    }

    //Logs sent to analytics
    function logout(page) {
        var sessionTime = ((new Date()).getTime() - appStartTime) / 1000 / 60;

        //Log how long a user spent in a session
		WL.Analytics.log({sessionTime: parseFloat(sessionTime.toFixed(2))}, 'SessionTime');

        //Log how many pages visited in a session
		WL.Analytics.log({numberOfPages: pageVisitCount}, 'NumberOfPages');

        //Log what page the user existed the session on
        WL.Analytics.log({closedOnPage : page}, 'ClosedOnPage');

        setTimeout(function () {
            //Send logs to analytics console
            WL.Analytics.send();
        }, 300);
    }

    //Log how many pages user goes through in a session
    function pageNavigation(sourcePage, destinationPage) {
        WL.Analytics.log({fromPage: sourcePage, toPage: destinationPage}, 'PageTransition');
        pageVisitCount++;
    }
    
    //Log the page name the user visits
    function pageVisit(page) {
        WL.Analytics.log({pageVisit: page}, 'PageVisit');
    }

    //Logs where a user is at in setting up an appointment. This way analytics
    // can show how far users generally make it through the scheduling
    // appointment process.
    function appointmentStep(step) {
        WL.Analytics.log({makeAppointment : step}, 'MakeAppointment');
    }

    //Logs where a user is at in the check deposit process. This way analytics
    // can show how far users generally make it when depositing a check.
    function checkDepositStep(step) {
        WL.Analytics.log({checkDeposit: step}, 'CheckDeposit');
    }
    
    //Logs where a user is at in transferring money process. This way analytics
    // can show how far users generally makes it when transferring money to
    // another user..
    function transferStep(step) {
        WL.Analytics.log({transferFunds : step}, 'TransferFunds');
    }

    //Logs which ATM the user is interested in
    function findATMLocation(locationName) {
        WL.Analytics.log({findATMLocation : locationName}, 'FindATMLocation');
    }

    return {
        logUserReturning: logUserReturning,
        logUserNew: logUserNew,
        logout: logout,
        pageVisit: pageVisit,
        pageNavigation: pageNavigation,
        appointmentStep: appointmentStep,
        checkDepositStep: checkDepositStep,
        transferStep: transferStep,
        findATMLocation: findATMLocation
    };
})(WL);
```