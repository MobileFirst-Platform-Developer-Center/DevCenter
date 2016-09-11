---
title: Gradually Rollout New Features in your Mobile App with IBM MobileFirst Foundation 8.0
date: 2016-09-11
version:
- 8.0
tags:
- MobileFirst_Foundation
- Live Update
- Analytics
author:
  name: Carmel Schindelhaim
additional_authors:
  - Ishai Borovoy
---
## Introduction

Let’s say you are a marketing director of a global retailer, and you have an amazing idea about how to get more customers into your stores. Your kids have been enthusiastically playing the new Pokemon Go game, running around your neighborhood to collect augmented reality Pokemon, and you are impressed with how addictive the game is. It occurred to you that you could build a game around coupon collection modeled after Pokemon GO, in which customers would use your app to collect AR coupons in their surroundings, that they can then redeem in store. How cool!

<img alt="long distance-runner" src="{{site.baseurl}}/assets/blog/2016-09-11-liveupdate-and-analytics/pokemongo.jpg" style="float:right;margin: 10px"/>

You want to test out your idea while the Pokemon trend is still hot – you don’t want to spend ages developing your idea, only to discover that it’s not all that. You want to get early feedback from real users, and you want to release the new feature to a small group at first, so that if the feature is a flop, you don’t risk huge exposure.  Also, you know that there are many possible ways to design the game – what if you could play around with different options till you figure out what design your users will like most?

Enter the new MobileFirst Live Update feature. With Live Update, you can make different aspects of your app configurable, so that you can turn features on or off, remotely, or dynamically change the values of variables, directly from the MobileFirst Console. And, you can create groups of users (target audiences), so that you can deliver different configurations to different audiences.

This makes it possible to release a minimal viable version of your new AR coupon game feature to a small group of users first, and get feedback from them. And you can make parameters of your game configurable, such as the distance that the user needs to be near an AR coupon to be able to collect it, so that you can tweak the game to make it more fun for your users.

<img alt="long distance-runner" src="{{site.baseurl}}/assets/blog/2016-09-11-liveupdate-and-analytics/ios.png" style="float:right;margin: 10px"/>

And of course, with MobileFirst Foundation Analytics, you’ll be able to measure whether your idea was a good one.

For example, you can measure how many people from the test group used the new feature, and with what frequency, so you know whether they liked the game. And you can look at the average number and types of coupons your users collected, so you know which coupons were appealing.

If you created variations of the game for different audiences, for example for VIP, Premium, or Regular customers, you can use Foundation Analytics to assess whether each audience had a different impression of the game, and then optimize the game for each group independently. Also, you can use Foundation Analytics to help you decide how you might make the game better. For example, if you decided that users can only pick coupons when within close proximity to the coupon, and you discover that many users tried to pick coupons and couldn’t because they were too far away, you can widen the radius within which users can pick a given coupon, and see how your users respond.

In this sample, you’ll see how to use the MobileFirst Foundation Live Update feature to release your new feature to a subset of your users, and how to use Foundation Analytics to understand if your idea was a good one, and help you decide whether and how to continue to evolve it.

<br>
<br>


> You can find the app sample which you can work with in the [following link](https://github.com/mfpdev/mfp71-with-ionic2 ).

<br>

## Demo

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/OsfWxKXv7jo"></iframe>
  </div>
</div>

<br>

## Architecture

![Archticture]({{site.baseurl}}/assets/blog/2016-09-11-liveupdate-and-analytics/architecture.png)

## code

***> Retrieving coupons from the coupons adapter based on segmentation from Live Update (iOS)***

``` swift
LiveUpdateManager.sharedInstance.obtainConfiguration([:]) { (configuration, error) in
    if let coupons_adapter_url = configuration?.getProperty("coupons_adapter_url"), let discountPickableRadius = configuration?.getProperty("discountPickableRadius"), let giftPickableRadius = configuration?.getProperty("giftPickableRadius") {
        self.discountPickableRadius = Int(discountPickableRadius)
        self.giftPickableRadius = Int(giftPickableRadius)
        self.fetchCoupons(coupons_adapter_url)


    }
}
```

***> Sending custom analytics events when a coupon is collected (iOS)***

```swift
if let annotation = self.annotation as? CouponARAnnotation  {

  ...

  WLAnalytics.sharedInstance().log("picked-coupon", withMetadata: annotation.asMetaData());
  WLAnalytics.sharedInstance().send();
}
```

***> Resolve the segment from the user context (Java)***

> To simplify the sample, we resolve segments using the first character of the username.

```java
@POST
@Path("segment")
@Produces("text/plain;charset=UTF-8")
@OAuthSecurity(scope = "configuration-user-login")
public String getSegment(String body) throws Exception {
  ResolverAdapterData data = gson.fromJson(body, ResolverAdapterData.class);
  String segmentName = "";

  // Get the authenticatedUser object
  AuthenticatedUser authenticatedUser = data.getAuthenticatedUser();

  char firstCharacter = authenticatedUser.getDisplayName().charAt(0);

  boolean isPremiumMember = firstCharacter >= 'I' && firstCharacter <= 'Q' || firstCharacter >= 'i' && firstCharacter <= 'q';
  boolean isVIPMember = firstCharacter >= 'R' && firstCharacter <= 'Z' || firstCharacter >= 'r' && firstCharacter <= 'z';

  return isVIPMember ? "vip" : isPremiumMember ? "premium"  : "regular";
}
```
<br>

## Building custom chart in analytics

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/NAbOwwZAUV4"></iframe>
  </div>
</div>  
