---
title: Take control of your app feature rollout and measure the effectiveness using Bluemix App Launch service
published: false
date: 2017-10-12
tags:
- Announcement
- App_Launch
- Bluemix
version:
- 8.0
author:
  name: Girish Dhanakshirur
---

Have you wondered why rolling out features in your app is so difficult and time-consuming with very little or no feedback on how the newly released feature is performing? I bet you have. Well, you have an answer now – introducing Bluemix **App Launch** Service.

Let’s say you have a popular App in Appstore which lets shoppers buy your merchandise using your popular app. Your buyers are complaining about complicated checkout process since they tend to forget user/password and unable to complete the transactions. While you are exploring various other options to replace user/pass authentication, you decide to conduct a small experiment. You have multiple segments of users – Platinum, Gold, Silver, Regular. You also have app users on iOS, Android. The experiment you want to conduct is to pick Gold users on IOS and offer TouchID based checkout. Further, you also know users complain about your app theme, you decide to try two different colors for the button and measure if there’s any significant change in Touch ID feature usage. Lastly, you know the upcoming Black Friday weekend two months from now is a great opportunity to test this hypothesis so you would want to perform this experiment only during that weekend.

To summarize you would want the following,
1.	Dark launch a new feature in your existing app without exposing it to anyone
2.	Define and implement a new feature and create its variants
3.	Create an audience that includes only Gold iOS users
4.	Select a window range when the experiment is conducted and in a real-time measure the effectiveness of this experiment during that window.

The newly launched Bluemix **App Launch** will help you perform all the above and much more. Let’s see step-by-step how you would accomplish all the above tasks in a simple and intuitive way.

First, visit [bluemix.net](http://www.bluemix.net) and sign up for an account, if you don’t have one. Once logged in, visit the **Catalog** page (link on the top right corner) and jump straight to the bottom where you will find a link to experimental service.
>Note: **App Launch** is currently an experimental service. On the left pane, select **Mobile** as the category and click **App Launch** Service.

Now, you are ready to create your first **App Launch** experiment!

Your mental model for **App Launch** service would look something like below,
1.	Define a new Feature
2.	Build an Audience pool
3.	Create an Engagement and within the engagement,

    a.	Select the feature created earlier

    b.	Define and customize multiple variants for this feature

    c.	Define and select the audience

    d.	Select the date/time when engagement will be active
4.	Download the SDK and Keys and incorporate them within the application
5.	Push the new version of the app at least a month before the Black Friday weekend so enough users would have downloaded the modified (dark-launched) version from the AppStore.
Let us go one step at a time. Once you create an **App Launch** service instance you are landed on the **Getting Started** page. Quickly skim through the sections, but don’t sweat – this blog will walk you through all the steps.

## Features
{: #features}

Select Features & Metrics on the left-side pane. Let’s get familiar with what a Feature is. A Feature in **App Launch** service is a simple grouping of attributes and metrics. Start by creating a Feature by following the below steps,
1.	Create a feature called, *Touch ID Button*
2.	Add a feature attribute, called Button Label and set value to *Touch ID Checkout*
3.	Add another feature attribute, called Button Color and set default value to *#AD343E*
4.	Add a feature attribute, called show_button and set value to *true*
5.	To track metric for this feature, add a metric, called *TouchID Clicked*
In the above step, you accomplished Step 2 of your requirement.

## Audience
{: #audience}

Once Feature creation is done, select Audience on the left-side pane. The Audience in **App Launch** is how you create a segment of users that you’d like to target this feature. Follow the steps below,
1.	New Audience Attribute

    a.	Add a New Audience attribute, called *customer type*

    b.	Set customer to be a *string array*

    c.	In Allowed Value enter, *platinum,gold,silver,regular*

    d.	To track metric for this feature, add a metric, called *TouchID Clicked*
2.	New Audience - Show this feature to only gold and iOS users

    a.	Add a New Audience, called *Gold iOS users*

    b.	Check Platform as iOS

    c.	Under Attributes, Select *customer type*

    d.	Check *gold* in the displayed customer type list

    e.	Select Save
In the above step, you accomplished Step 3 of your requirement.

## Engagements
{: #engagements}

Once a Feature is created and Audience is defined, it’s time to bring all of it together in an Engagement. An Engagement in **App Launch** brings together one or more Features and Audiences together and allows you to experiment by creating multiple variances. Follow the below steps,
1.	Create an Engagement, called *Holiday Button*
2.	Select Experiment Mode as A/B Testing
3.	Select the feature you would like to A/B Test. From drop down select *Touch ID Button*
4.	To A/B Test Button color for feature *Touch ID Button* select,

    a.	Variant 1, set button color as *#AD343E*

    b.	Variant 2, set button color as *#846075*
5.	Select an audience - *Gold iOS Users*
6.	Specify Reach % for each variant, for example, 50% each

    a.	Variant 1, set Reach to be 50%

    b.	Variant 2, set Reach to be 50%
7.	Specify a Start date, if empty engagement starts immediately

    a.	Event type Time, when is Start, specify Date
8.	Select Create

In the above step, you created an engagement along with accomplishing Step 4 of your requirement.
All that’s left now is to download the SDK, Feature Toggle, and Metric keys and start incorporating them within your TouchID logic. Let’s look at few code snippets. The Feature Codes section in Feature Details screen shows the list of codes to copy.
![Feature Codes]({{site.baseurl}}/assets/blog/2017-10-12-mfp-app-launch-announce/feature-codes.png)

Also, ensure the state of the Feature is set appropriately. For example, if the Feature is set to *Under Development* then the Feature will be unavailable to be part of an Engagement. Ensure the Feature is set to Ready to be included in an Engagement.
![Update Status]({{site.baseurl}}/assets/blog/2017-10-12-mfp-app-launch-announce/update-status.png)

**App Launch** SDKs offer a rich set of APIs to check whether a Feature is enabled or not, then get value for Feature keys. The below code snippet shows an Android sample to check for Feature and then get the label text.
![Android Sample code]({{site.baseurl}}/assets/blog/2017-10-12-mfp-app-launch-announce/android-sample-code.png)

A fully working sample can be downloaded from **App Launch** git repo here.
https://github.com/ibm-bluemix-mobile-services/bms-samples-android-helloapplaunch
Once coding is complete, go ahead and post your app to App Store or Play Store. As and when users download and use your new version of the app, your users will be receiving the dark-launched feature hidden in the code. The **App Launch** service SDK will be registering the users as they launch the app, but since the engagement is disabled until the week of Black Friday no users will see the new TouchID Button.
As intended, on Black Friday weekend the Gold iOS users will see a new TouchID-based check out button when they checkout their items in the app. Fifty percent of those users will see one button color and the other fifty the second variant button color. As each user buys merchandise by clicking the TouchID button, **App Launch** service collects such events and displays the effectiveness in real-time. Once the weekend’s sale is over the feature goes to a dormant mode as the engagement goes into disable mode.

## Summary
{: #summary}

In summary, the newly launched **App Launch** service offered you the ability to control feature rollout to a small set of audiences in multiple variants and triggered the feature during a small period. Now you get it – the above is a simple **App Launch** use case, but how the service can be used is up to your imagination.
Check out additional material [here](https://console.ng.bluemix.net/docs/services/app-launch/index.html). Post your queries to Stack over flow with tag *ibm-cloud-applaunch*.

Happy Coding!
