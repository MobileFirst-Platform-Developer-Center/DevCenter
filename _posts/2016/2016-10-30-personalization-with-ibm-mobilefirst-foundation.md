---
title: Mobile App Personalization with IBM MobileFirst Foundation 8.0
date: 2016-10-30
version:
- 8.0
tags:
- MobileFirst_Foundation
- Personalization
- Live_Update
- Analytics
- Weather

author:
  name: Carmel Schindelhaim
additional_authors:
  - Ishai Borovoy
---
## Introduction
Personalization is king. It’s no secret that when companies make us feel special, we are more engaged, satisfied, and likely to buy more from them.  Just think of the last time you browsed Amazon, or your Instagram feed. Therefore it should come at no surprise that when Forrester recently surveyed 115 digital experience technology decision makers, they found that 68% marked bringing personalized experiences to their customers as a top investment priority for 2016. This also indicates that personalization is really only still in its infancy, particularly in digital channels other than websites, like in mobile apps.

When it comes down to designing personalized experiences, there are 3 main components to think about. The first is knowing what your users want. You might already have made some good guesses, but it comes down to data. Good analytics can help you understand your users, uncover blind spots or hidden opportunities, and measure which tailored experiences worked. The second is building user profiles, which is a way of helping to customize experiences based on what a user did in the past, what similar customers liked or did, or based on a user’s context (location, time of day, weather, battery percentage etc.). The third component, especially relevant to mobile apps, is the ability to actually change & customize application content, flows, user experience etc. Which can actually be a lot of heavy lifting, particularly if you want to make changes frequently.

To help your development team with these challenges, we recently released a new feature called [Live Update in IBM MobileFirst Foundation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/live-update/). Live Update makes it very simple for you to define a set of criteria for delivering a customized experience, and select the experience that users with that profile or context will get. You can manage all of the different user groups & app variations very easily in the MobileFirst Foundation Console, and the most powerful part is that you can make changes frequently without republishing your app. And of course, with [MobileFirst Foundation Analytics](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/analytics/), you can learn which custom experiences were effective.

In this blog post, we’ll walk you through a sample so you can learn how easy it is to create custom experiences in your mobile app with [IBM MobileFirst Foundation Live Update](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/live-update/). For this example, we imagined a credit card company app. This credit card company has partnerships with multiple business types – small supermarkets, large supermarkets, pharmacies, and gas stations. And in the app, they want to show offers relevant to the business that a user is currently visiting. They also want to provide special offers depending on the weather, for each type of business.  We’ll show you how we set these customizations up in our app with Live Update, and how easy it is to add new categories & criteria for offers without republishing the app. You’ll also see how we used Foundation analytics to learn which customizations were effective. To make this sample fun, <img alt="long distance-runner" src="{{site.baseurl}}/assets/blog/2016-30-10-personalization-with-ibm-mobilefirst-foundation/tinder.png" style="float:right;margin: 10px"/> we modeled the UX after [Tinder](https://en.wikipedia.org/wiki/Tinder_(app)). Users can swipe right to save offers they like, and swipe left to ignore the ones they don’t.

<br/>
> Source: Digital Experience, Technology And Delivery Priorities, 2016. Forrester, May 2016

## Demo

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/zko9L9hCGZU"></iframe>
  </div>
</div>

<br/>
> You can find the sample app in [this GitHub repository](https://github.com/mfpdev/personalization-with-liveupdate).

## Architecture
![Archticture]({{site.baseurl}}/assets/blog/2016-10-30-personalization-with-ibm-mobilefirst-foundation/architecture.png)
