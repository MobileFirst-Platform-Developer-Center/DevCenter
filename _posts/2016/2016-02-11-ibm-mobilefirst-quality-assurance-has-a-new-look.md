---
title: 'IBM Mobile Quality Assurance has a new look!'
date: 2016-02-11
tags:
- MobileFirst_Platform
- MobileFirst_Quality_Assurance
author:
  name: Christopher Dawson
---

A new year is a great time for a fresh start and improvement. IBM&reg; Mobile Quality Assurance for Bluemix&reg; has made some changes, including a new look and an improved user interface. The update for February 2016 includes the following changes:

### New interface with improved filtering.
The refreshed interface includes a more modern appearance and additional filtering options to sort your bugs and feedback entries more easily. 

* **Updated app summary page.** The apps summary page quickly summarizes the number of bugs, feedback, and crashes that have been reported for that app and platform. Simply click a number to see the details.

![Image of the updated app summary page.]({{site.baseurl}}/assets/blog/2016-02-11-ibm-mobilefirst-quality-assurance-has-a-new-look/app_health_saas4.gif)

* **New location for the navigation options.** Once you dive into the details, the menu has moved to the left side of the screen and can easily be hidden using the “hamburger” menu. Most of the options are the same, just in a different location.

![Image of navigation screen]({{site.baseurl}}/assets/blog/2016-02-11-ibm-mobilefirst-quality-assurance-has-a-new-look/img_nav.gif)

* **New filtering options for bugs and feedback.** Bugs and feedback have additional filtering options that allow you to find bugs that were submitted during a specific time period or review feedback submitted on a specific version.

### Enhanced features for managing your team of testers to allow groups and provide beta management capabilities.
Instead of just adding a list of testers, you can invite participants to a test or beta program, group participants to easily distribute builds, and limit the number of participants in a test or review cycle. You’ll find the new participant management features under the Participants menu. 
Let’s look at an example of how you can use some of the new features. You have to manage a beta project of 50 people, and all you have are a list of 300 people, an app that is instrumented with MQA, and the MQA service on Bluemix.

* **Allow product testing participants to request registration by selecting a link.** For this example, you need 50 participants from your list of 300 contacts.  You create a link that participants can select to request permission to be added to the beta participant list.  You send the link to all 300 potential participants. Participants who select the link automatically submit a request to be added as participants to the project. You stop when you reach your target of 50 participants.
* **Manage participant lists by using Groups.** When you have identified your 50 participants, you create a group that contains their email addresses. The members of the group have access to the project. The group also provides a convenient mailing list for you to send updated versions of the builds. 
* **Include non-disclosure agreements.** Because your project is in its early testing stages, you attach a non-disclosure agreement (NDA) to the builds that you send to your 50 participants. The participants are required to agree to the terms and virtually sign it before they access the test version of the product.
* **Customize the email that you send to your participants.** You include your company logo and modify the button colors that are used in the communication to make sure that people know that it is from your company.
* **Automatically start a feedback entry after a specific action in your app.** Your development team added a feature to the interface of the product, and you want to know what the beta participants think about it. Your development team adds a trigger to the code of the app that starts the MQA feedback interface when the beta participant activates that button.
* **Collaborate with a feedback submitter through an email-based chat function.** Out of the 50 participants on your project, you receive an unclear feedback submission. MQA makes it easier to learn more detail about it.  Open the bug or feedback entry and begin an email-based chat session with the submitter. All of the content is stored in the bug or feedback entry for convenient retrieval.

### Other major updates improve the information you can gather from the testers and manage that feedback in the development cycle.
With these new features, you can:

* **Capture recorded screen sequences when reporting bugs.** It is sometimes easier to fix a bug when you have more than just a screen shot and a description. You might need to know what the user did on the screen before the current one. A tester can now use the *Add App Screen Recording* feature when submitting a bug report to record small clips of screen sequences. These sequences are attached to the entries and sent to the administrator.
* **Integrate with more bug tracking products.** MQA added support for integrating with Asana, Bugzilla, Rally, and Redmine. You can now export your bugs to these additionally supported bug tracking products to maintain them in that environment.
* **Archive bugs and feedback to manage your bug list.** You can archive duplicate entries, resolved entries, or entries from that one tester with a strange configuration who can never install the builds.

To learn more about these recent updates, visit our [What’s New page](http://www.ibm.com/support/knowledgecenter/SSJML5_6.0.0/com.ibm.mqa.uau.saas.doc/topics/r_whatsnew_saas.html). Make a resolution to [try MQA on Bluemix](http://ibm.biz/MobileFirstQualityAssuranceTrial) and see what it can do to improve your year (or your app).
