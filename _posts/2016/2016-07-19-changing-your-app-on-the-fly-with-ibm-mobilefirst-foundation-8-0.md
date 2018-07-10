---
title: Changing your app on the fly with IBM MobileFirst Foundation 8.0 Live Update
date: 2016-07-19
tags:
- Live_Update
- MobileFirst_Foundation
- Adapters
- Development
version:
- 8.0
author:
  name: Carmel Schindelhaim
---

## Introduction
If you have developed an Enterprise app before, you’ll know that it’s really hard to satisfy everyone. You’ll want to make your app dynamic & responsive for your users, so they enjoy engaging with your brand. You’ll want your app to provide the right experience to different types of users. And of course, you’ll want to get your code out faster for testing & feedback. And you may even want to let your product manager, designer, or business leader tweak the experience of the app without your help after you launch.

The MobileFirst Foundation Live Update feature makes all of this simple. If you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn how to use MobileFirst Foundation Live Update. With Live Update, you can make new features or properties in your app configurable, and associate each configuration with a segment. Then, during runtime, the app can fetch the configuration from the server that fits the segment the user belongs to. So your business leader can turn features on or off after launch, or make your app behave differently for different users. This makes it easy to run A/B tests and gradually rollout new features to your users. Or dark launch a new feature before it is ready, so you can test it with internal users, and publish it to your users faster once it is ready.

Let’s see how MobileFirst Foundation Live Update feature helps you accomplish all of this:

## Tailor the App Experience for the Users   

Every app user is different. And to keep your app users engaged, or fit multiple business needs, you may want to customize your app for your users. Or maybe this is what your marketing lead or product manager wants to do, and you want to enable them to try out different app customizations without your help.

Let’s say, for instance, you are developing a banking app for a multinational bank. Each country has different security requirements, or accepted login methods. You need to get your users in France authenticated with a username & password, but in Estonia, you have to use a Government login method.  You want your app to use the right authentication method depending on the country the user is from.

Or maybe you simply want to customize the app logo for each country, or your marketer wants try to display a special home-screen for your high-value customers.

With Live Update, you can create groups of users, and set values or features to be configured remotely.  For authentication methods, you can map user groups to different security requirements, by country, and the app will launch the matching login flow for the user.  Or, for app customization, your marketing lead or product manager can change which values different users get, or what features they see, from the Foundation Operations Console.

The next time your users fire up their app, they will see the changes delivered specifically to their user group.

Sometimes there are even stringent business requirements that are easier to fulfill with the Live Update feature. For instance, there are some countries with data residency laws that require that customer data to be stored in country. With Live Update, you can configure your app to call the appropriate backend, depending on the country the user is in.

## Test out Major Decisions   

The user segmentation & feature toggling features of Live Update are useful for more than just customizing your app for different users. You can take advantage of these capabilities to A/B test app flows, or gradually roll out new features to your users, so you can be more sure they will have a positive impact.

Let’s say you have a Retail app, and your business lead wants you to add a quick checkout flow. She thinks this might improve conversions. But you want to make sure the new flow is actually more convenient for users, and won’t cause them to abandon their carts, or purchase fewer items. If your app uses Live Update, you can set up a test on a small group of users, and measure the impact with MobileFirst Foundation Analytics. If you find that the overall economic impact was a positive one, you can then use Live Update to roll out the new checkout to more and more users. And if the impact is negative, you can pull the quick-checkout flow, and revert to the old one, without republishing your app.

Similarly, if you’ve released new code into the world, and you find that in production it causes issues with system performance, your ops admin can kill the feature from the admin console.

## Get new features out faster

Live Update also helps you get new features or flows out to your users faster.

Let’s say you’ve developed a new version of your insurance app that you think your employees will really like, and you can’t wait to get it out to them. But one of the forms your app uses is still waiting for approval from the business. If your app uses Live Update, you can ship the new form as hidden code, and once you get that approval, you can toggle the form on, so it is instantly accessible to your app users. You don’t have to send them to the app store to download a new version of your app. And you’ve saved yourself cycles of testing & deploying an additional version of your app just to add a new form.

Or, let's say you are preparing for a marketing event like Black Friday, and your development team is working hard to enhance your app in time for the event. They finished developing the client side of the app, but their server side code isn't ready yet. You want to make sure that your users will have enough time to upgrade to the new version of your app prior to the event. If your app uses Live Update, you can publish your app ahead of time in the app store, with the new Black Friday features disabled. While your users download the new version of your app, your developers can finish working on the server side code. Then, when your Marketing lead wants to launch the Black Friday campaign, they can turn on the Black Friday features from the the Foundation Operations Console, and make them available instantly to your users. And, with MobileFirst Foundation Analytics, you can measure the performance of the new features, and decide if & when you want to turn them off.

## Are you Using Live Update Yet?

To get started using the Live Update feature, see the [Live Update tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/live-update/).

![LiveUpdate]({{site.baseurl}}/assets/blog/2016-07-19-changing-your-app-on-the-fly-with-ibm-mobilefirst-foundation-8-0/LiveUpdate.png)
