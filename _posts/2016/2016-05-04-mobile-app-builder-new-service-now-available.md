---
title: Mobile App Builder – new service now available
date: 2016-05-04
tags:
- MobileFirst_Platform
- Bluemix
- Mobile_App_Builder
version:
- 7.1
author:
  name: Sachi Pradhan
---

> As originally posted [in the Bluemix Developer Center](https://developer.ibm.com/bluemix/2016/05/03/mobile-app-builder-now-available/).

**Update:** Mobile App Builder functionality has now been rolled into the Bluemix Mobile dashboard. The standalone Mobile App Builder service will be removed from the experimental catalog on August 11. <a href="https://new-console.ng.bluemix.net/mobile/projects?cm_sp=bluemixblog-_-content-_-cta">Try the Mobile Dashboard</a>.

Want to take a mobile app from an idea to a working prototype in a few minutes all without writing a single line of code? Try Mobile App Builder, a new experimental service on Bluemix.

**[Try Mobile App Builder](https://console.ng.bluemix.net/catalog/services/mobile-app-builder/?cm_sp=bluemixblog-_-content-_-cta)**

## Get Started
Here’s how to get started building an app using the Mobile App Builder service.

1. Select a Template

    Select from a pre-defined set of app templates to get started. These templates cover a range of use cases that can be customized as the app is designed.

    ![select a template]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/select-a-template.png)

2. Design the App

    Design your app by adding new screens. Use visual tools to select screen and layout types. Customize the app by adding you own colors and images.
    
    ![design the app]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/design-the-app.png)
    
3. Add Services

    As part of the app design process, you can add new data sources based on IBM Cloudant NoSQL DB, Online Spreadsheets (Excel Online and Google Sheets), and Google Drive. You can also create your own tables in the cloud or locally stored on the device.

    Add push notifications to the app using the IBM Push Notifications service.

    Optionally, integrate with IBM MobileFirst Platform Foundation (MFPF), if you are a current MFPF customer and want to manage this app using MFPF.
    
    ![add services]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/add-services.png)
    
4. Build and Generate App

    Once design is done, just select the platform (Android or iOS) and get the app. On successful app creation, you can now download the generated source code or the app binary. For iOS, the source code generated is based on Objective-C (support for Swift is next).
    
    ![build app]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/build-app.png)
    
    ![generate app]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/generate-app.png)
    
5. Install App

    Once the app is built, you have the option to install the app directly on the device via a QR code. Just scan the QR code and follow the steps to install the app. For iOS, you need to have the certificate details plugged in to generate an ipa file.
    
    ![generate app]({{site.baseurl}}/assets/blog/2016-05-04-mobile-app-builder-new-service-now-available/install-app.png)
    
## What’s Next?

Mobile App Builder for Bluemix is an experimental service right now, and we plan on adding new features over the coming months. In the meantime, I encourage you to try out this service for your next mobile project.

Happy App Building!

> **Note**: The Mobile App Builder does not support MobileFirst Platform Foundation 8.0 beta