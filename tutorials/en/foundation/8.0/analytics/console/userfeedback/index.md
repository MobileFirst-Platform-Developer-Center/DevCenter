---
layout: tutorial
title: In-app User Feedback
breadcrumb_title: User Feedback
relevantTo: [ios,android,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }

Using the In-App User Feedback feature users of your applications can take screenshots of the the application, annotate them with markers and comments that describe their feedback and opinion about the application.   

First and foremost ensure that your mobile application is enabled to capture and send In-app User Feedback.  Refer to [Capture & Send In-App User Feedback](../../analytics-api#sending-userfeedback-data)

User feedback capture and sent from mobile devices is aggregated by the Mobile Foundation Analytics Service and presented on the Analytics Console for Application Owners and Developers to review, gather insights and take actions if necessary.  

## Viewing In-App User Feedback List
In the Mobile Foundation Analytics Console select the option **Dashboard** from the left navigation panel.   Then from the panel on the right, go over the menu options on the top and select **User Feedback**    

On selection you should now see the right panel of the Analytics Console displaying a table that lists User Feedback that have been received from your applications' users.   You can filter the contents of the table by time period, application, device OS and version.  You may also filter feedback by the action resolution taken.

![User Feedback Summary](userFeedbackSummary.png)

## Viewing In-App User Feedback Detail
To view the detailed feedback click on the feedback which needs to be looked into in detail.   This will open up a modal view that will contain the following: -
* A carousel of screenshots of the mobile application with user annotations on it.    
* For each screenshot there is a listing of the textual comments that have annotated by the user.
* For the entire feedback (containing the screenshots) the application owner or the reviewer can mark an action taken such as feedback accepted fully or partially, feedback rejected etc.  There is also a text area where any review comments by the application owner or the reviewer of the feedback can be filled in.   

There is also available the option of downloading the feedback and all of it's details - screenshots with annotations.   For example the application owner could download the feedback details and upload/attach it to a GiT or JIRA issue.  

![User Feedback Details](userFeedbackDetail.png)

> **Note** The action setting for a feedback is at the moment only a marker that helps marking the feedback's review status.  There is no built in cascading actions such as the creation of a JIRA or a GiT issue with all Feedback information copied into it.    

