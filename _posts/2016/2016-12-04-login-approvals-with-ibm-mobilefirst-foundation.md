---
title: Add Login Approvals to Your Digital Channels with IBM MobileFirst Foundation 8.0
date: 2016-12-04
version:
- 8.0
tags:
- MobileFirst_Foundation
- Security
- Push
- Android
- Web_SDK
- nodeJS
author:
  name: Ishai Borovoy
additional_authors:
  - Carmel Schindelhaim
---

## Introduction
Account hijacking can be a major problem. There are many ways hackers can steal passwords to users accounts, like phishing, or hacking into a central database where user credentials are stored. To protect users accounts, many companies add a second layer (or more) of security to user sign-ins & transactions called multi-factor authentication. Multi-factor authentication ensures that even if someone else knows your password, they still can’t access your account. In addition to a password, they also need access to something you own (e.g. your mobile phone), or something like your fingerprint. In the sample below, we will show you how to implement a modern approach for two-factor authentication that Facebook & Google also use in their applications, that adds security while also providing a good user experience.

You may already be familiar with [SMS One-Time passcodes](https://mobilefirstplatform.ibmcloud.com/blog/2016/07/18/sms-otp-with-ibm-mobilefirst-foundation/), which are a popular form of second factor authentication. In many apps, when you try to log into your account with your password, you also get an SMS notification to your phone with a temporary passcode, which you have to enter as well. Since a hacker probably doesn’t have your phone, they can’t access your account.

The flow we present below improves on the user experience of SMS OTPs and works like this: Let’s say someone tries to login to your account from an unrecognized device or browser. You will get notified on your trusted device (e.g. via a push notification to your mobile phone), and be asked to verify the attempted access. If you don’t approve the login for the unidentified browser or device, that login never goes through. Also, with this feature, you can use your trusted device to remote log-out of other devices you used– e.g. if you forgot to logout from your account on a library computer.

While this flow provides a very nice balance between user experience and security, turns out it is quite complex to implement. But, if you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer and you use [IBM MobileFirst Foundation](https://mobilefirstplatform.ibmcloud.com/) components, it is much easier to add something like this to your app. In the sample below, we’ll show you how to leverage several features of MobileFirst Foundation, such as security checks, push notifications, and our web & mobile SDKs to implement a similar flow in your apps without too much work.

## Demo
<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/ajumb5iOblE"></iframe>
  </div>
</div>

<br>

> You can find the app sample which you can work with in the [following link](https://github.com/mfpdev/login-approval-sample).

## High level description of the flow implemented with MobileFirst Foundation
Let’s say you decide that a user can approve logins from unrecognized browsers from their mobile app. You’ve used the MF Foundation SDK in your mobile app, and your app can retrieve the list of all the browsers & devices from which you have tried to log in to your account from the MF Foundation Server.

What happens when you try to log in to your account from an unknown browser? Your web app, which leverages the MF Foundation SDK for web, can post information about the unknown browser (eg. location of the device), plus the credentials of the user to the MF Foundation Server. The MF Server activates two Security Checks (server side Security logic) to accomplish the two-factor authentication. One represents the logic for a username/password based login, and the second looks up in the MF Foundation Server Registration Service what approver devices are listed for the user who just tried to login. Then, using MF Foundation Push Notifications, the MF Server sends that user a push notification to mobile devices listed as ‘approvers’ for that user. The notification asks the user to approve or deny access to the unrecognized browser (with details of the unknown device/browser). If the user approves, the approval gets posted to MF Server, which then refreshes the browser via [socket.io](http://socket.io/), and logs the user into the web app.

## Architecture
![Archticture]({{site.baseurl}}/assets/blog/2016-04-12-login-approvals-with-ibm-mobilefirst-foundation/architecture.png)
