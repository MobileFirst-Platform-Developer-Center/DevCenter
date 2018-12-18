---
title: Announcing Beta release of IBM Digital App Builder - The easy way to build smart apps
date: 2018-12-18
version:
- 8.0
tags:
- MobileFirst_Foundation
- Digital_App_Builder
- Mobile_Foundation
- Announcement
author:
  name: Krishnakumar Balachandar
---
![Digital App Builder]({{site.baseurl}}/assets/blog/2018-12-18-announcement-digital-app-builder/banner.png)

The application landscape is changing and with the advent of new technologies, mobile devices have become the preferred gateway for accessing the digital business world. Enterprises want to build multiple apps that support more than one channel, while the cycle time to deliver apps has reduced from months to days. On the other hand, users are expecting enterprises to deliver state of the art experiences, regardless of the digital channel selected as the business touch point.  In order to meet these growing expectations from the market, there is a need to embed advanced AI capabilities such as visual recognition and conversation in apps. These advanced capabilities are becoming a must-have for enterprise apps, in order for businesses to stay competitive and to maintain operational effectiveness. 

To be in the race, app owners need to look beyond the web and mobile technologies and find new ways to keep users engaged, regardless of the specific digital channel they are in. Users today can start a transaction using the web browser and complete the same using a mobile device. The user experience needs to be delivered across multiple channels and to provide this experience the app owner needs to have a unified view across channels to understand the usage patterns and to deliver capabilities based on what users actually do.  

From an architecture perspective, monolithic applications are now moving to microservices based architecture, which provide loosely coupled services that deliver business functionality.  This trend has changed the way developers consume back-end services for building the front-end user interfaces.

To meet these customer & market needs we are introducing a desktop tool called **IBM Digital App Builder**. This  tool will change the way a citizen developer who does not have very strong development skills can build smart web and mobile apps, by providing a drag and drop experience for the user to add building blocks, connect to micro-services and add AI capabilities. This tool produces open source based app source code, which you can version control using GitHub enterprise, GitHub or any other source control tool.

* **A citizen developer can use this no code/low code tool to quickly build digital apps that can run on multiple channels.**<br/>
  Digital App Builder provides the ability to drag and drop components to quickly build an app. <br/>This app can be targeted on multiple channels like apps for iOS (iPhone, iPad), Android (phone, tabs) and Progressive Web Apps (PWA) and web pages. You can switch to code view for performing advanced coding on the app.

* **A citizen developer can easily integrate AI capabilities such as Chatbot or Visual Recognition using out of the box components that leverage IBM Cloud Watson services.**<br/>
  Adding a chatbot or visual recognition capability to the app becomes as easy as adding a control. Developers can also train the AI service by adding a chat intent or image directly from this tool without the need for a data scientist to build a complex machine learning model.

* **An app developer can add data-bound controls for microservice backends.** <br/>
  An Open API specification (Swagger) for a microservice can be imported into Builder using the wizard, which helps to create a dataset for building the front end for the service. The developer can then bind this dataset to a data-bound UI control in the app.

* **An app owner can enable analytics on the app.**<br/>
  The data from the app is sent to the Mobile Foundation server and the analytics console provides Crash data, Page flows, and Operations in the form of dashboards.

 This is a beta release and the following video shows the capabilities of what the tool offers today.

<br/>
<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe width="560" height="315" src="https://www.youtube.com/embed/k1vEUuR_GrY?rel=0&amp;showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
    </div>
</div>


[![Digital App Builder]({{site.baseurl}}/assets/blog/2018-12-18-announcement-digital-app-builder/download.png)](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases)

<!--Start by downloading and building a sample app with the [Getting Started guide](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).-->

We want to hear about your experience! Join our [Slack channel](https://mfpdev.slack.com/messages/CE8MGDD7E) OR post a question on [StackOverflow](https://stackoverflow.com/questions/tagged/ibm-digital-app-builder).

If you have a new feature that you want us to implement [open a Git issue](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/issues) and we will evaluate the feasibility of adding the feature in our roadmap.

Provide your feedback directly [here](https://www.surveygizmo.com/s3/4627635/Digital-App-Builder-Feedback). 
