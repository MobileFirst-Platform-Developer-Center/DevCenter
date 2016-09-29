---
title: DefinitelyTyped project for IBM MobileFirst and Hybrid Mobile Apps
date: 2016-01-19
tags:
- MobileFirst_Platform
- DefinitelyTyped
- Cordova
- Hybrid
version:
- 7.1
author:
  name: Raymond Camden
---
I've blogged before about the client-side API for hybrid mobile apps built on [IBM MobileFirst](https://ibm.biz/IBM-MobileFirst). One of the things I've discovered recently is the library of [DefinitlyTyped](http://definitelytyped.org/) definition files for TypeScript developers. These files provide intellisense for a huge set of various frameworks and client-side code written in TypeScript. Turns out though that you can also use them in regular old JavaScript files too. My editor of choice (Visual Studio Code) has [great support](https://code.visualstudio.com/docs/languages/javascript for this. You can simply get the file, drop it into your project, and go to town.

So with that in mind - I started working on a DefinitelyTyped file for MobileFirst. I had to guess a bit at exactly how to do it, and I probably did a few things wrong, but you can get the work in progress here: [https://github.com/cfjedimaster/MobileFirst-Typings](https://github.com/cfjedimaster/MobileFirst-Typings). As you will see in the ReadMe, I've covered a few of the main classes in the WL namespace (this is the core namespace for the API). I'm looking for feedback on how I built it as well as volunteers to help complete the library with a pull request. 

In case your curious as to how well this works, check out the video below:

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/watch?v=wre69RYbDnA"></iframe>
    </div>
</div>

As a side note - you can get definition files for Apache Cordova and Ionic as well!
