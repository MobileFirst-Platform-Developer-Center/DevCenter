---
title: MobileFirst Platform Quality Assurance 7.0 is now available!
date: 2016-06-03
tags:
- MobileFirst_Platform
- Announcement
- MQA
- Quality_Assurance
author:
  name: Christopher Dawson
---

IBM MobileFirst Platform Quality Assurance 7.0 is now available on IBM Passport Advantage and Fix Central! The new version includes a new look and an improved user interface, as well as new features to help you better manage your testers and bug reports.

**New interface** The refreshed interface includes a more modern appearance and new menu options. The menu has moved to the left side of the screen and can easily be hidden using the “hamburger” menu. Most of the options are the same, just in a different location.

![Feedback preview image]({{site.baseurl}}/assets/blog/2016-06-03-mobilefirst_quality_assurance_7_is_now_available/feedback_page.jpg)

**Enhanced features for managing your team** of testers to allow groups and provide beta management capabilities. Instead of just adding a list of testers, you can invite participants to a test or beta program, group participants to easily distribute builds, and limit the number of participants in a test or review cycle. You’ll find the new participant management features under the Participants menu.
 
![Group management preview image]({{site.baseurl}}/assets/blog/2016-06-03-mobilefirst_quality_assurance_7_is_now_available/group_management_page.jpg)

Let’s look at an example of how you can use some of the new features. You have to manage a beta project of 50 people, and all you have are a list of 300 people and an app that is instrumented with MQA. 
  
* __Allow product testing participants to request registration by selecting a link.__ For this example, you need to narrow your list of 300 participants to 50.  There is no limitation of the tool to how many you can enroll.  You create a link that participants can select to request permission to be added to the beta participant list.  Select whether you want to approve the participants manually or have them automatically approved.  We will assume that you set up automatic enrollment, since you already have too much work.  You send the link to all 300 potential participants. Participants who select the link that you provide are automatically added as participants to the project. You can turn off the automatic addition after you reach your target of 50 participants.
* __Manage participant lists by using Groups.__ When you have identified your 50 participants, you create a group that contains their email addresses. The members of the group have access to the project. The group also provides a convenient mailing list for you to send updated versions of the builds. 
* __Include non-disclosure agreements.__ Because your project is in its early testing stages, you don't want your competitors to know anything about your app. To help ensure confidentiality, you attach a non-disclosure agreement (NDA) to the builds that you send to your 50 participants. The participants are required to agree to the terms and virtually sign it before they access the test version of the product.
* __Customize the email that you send to your participants.__  You include your company logo and modify the button colors that are used in the communication to make sure people know that it is from your company. 
* __Automatically start a feedback entry after a specific action in your app.__ Your development team added a great button that automatically converts time to the user's time zone. You want to know what the beta participants think about the button. Your development team adds a trigger to the code of the app that starts the feedback interface when the beta participant activates that button. You know you should get more feedback about the button if the participants are specifically asked for it.
* __Collaborate with a feedback submitter through an email-based chat function.__ Out of your 50 participants on your project, you finally receive what you knew would come in: the frustrating feedback that says, “I don’t like it.” Rather than being limited to throwing that one out, MQA makes it easier to learn more detail about it.  You can open the bug or feedback entry and begin an email-based chat session with the submitter. All of the content is stored in the bug or feedback entry for convenient retrieval.  Of course, you could still disregard those entries.

**Other major updates** improve the information you can gather from the testers and manage that feedback in the development cycle. With these new features, you can: 

* __Capture recorded screen sequences when reporting bugs and feedback.__ It is sometimes easier to fix a bug when you have more than just a screen shot and a description. You might need to know what the user did on the screen before the current one. A tester can now use the Add App Screen Recording feature when submitting a bug or feedback report to record small clips of screen sequences. These sequences are attached to the entries and sent to the administrator. 
* __Integrate with bug tracking products.__ MQA added support for integrating Jira, HP Quality Center, Asana, Bugzilla, Rally, and Redmine. You can now export your bugs to these supported bug tracking products to maintain them in that environment.
* __Archive bugs and feedback to manage your bug list.__ You can archive duplicate entries, resolved entries, or entries from that one tester with a strange configuration who can never install the builds. 

To learn more about these recent updates, visit our [What’s New page](http://www.ibm.com/support/knowledgecenter/SSFRDS_7.0.0/com.ibm.mqa.uau.doc/topics/r_whatsnew.html).  You’ll Visit the IBM Knowledge Center to find complete documentation for [MobileFirst Platform Quality Assurance 7.0](http://www.ibm.com/support/knowledgecenter/SSFRDS_7.0.0/com.ibm.mqa.uau.doc/mqa700_welcome.html)!