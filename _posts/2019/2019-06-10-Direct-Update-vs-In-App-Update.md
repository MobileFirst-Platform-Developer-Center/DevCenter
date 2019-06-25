---
title: Should I use App Update or Direct Update?
date: 2019-06-10
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- Direct Update
- App Update
version:
- 8.0
author:
  name: Srihari Kulkarni
---

Google I/O 2019 brought in a flurry of new feature announcements. One of the less publicised feature was that of [in-app updates for Android apps](https://developer.android.com/guide/app-bundle/in-app-updates). While the Google Play Store continues to be the channel for delivering app updates, in-app updates allow developers to prompt users to consume an app update from the Play Store without leaving their app.

MobileFirst has had the ability to update app content from within the app for a long time now through [Direct Update](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/).

So,
* How is Android in-app udpate different from Direct Update?
* Is one better than the other?
* Which is the best way to update my app?

In this post, I'll attempt to answer these questions and more.

One of the first obvious difference you'd note is that the Android in-app update is delivered through the Play Store while MobileFirst Direct Update is delivered through the MobileFirst server or a [CDN](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/direct-update/cdn-support/). This implies that your update still has to go through the Play Store review process and the associated delay.

Another important difference is that Android app update is available to apps on, well, Android only. Direct update, on the other hand can be used on both Android and iOS platforms making it much more versatile.

The limitation of Direct Update comes into play in the type of content it can update. Direct Update can only udpate web resources of Cordova-based apps, whereas the Android app update can update native content too and is perhaps suited to native apps.

Apart from the major comparisons highlighted above, the following table gives you a more detailed comparison to help you judge better.


<table class="table table-striped">
<thead>
<tr>
<th>Update</th>
<th>Mobile First Direct Update</th>
<th>Android in-app</th>
</tr>
</thead>
<tbody>
<tr>
<td>Platform Support</td>
<td><span style="color:green"><b>Android, iOS</b></span></td>
<td>Android only</td>
</tr>
<tr>
<td>Availability of update to users</td>
<td><span style="color:green"><b>Immediately after upload</b></span></td>
<td>Subject to Play Store review timelines</td>
</tr>
<tr>
<td>Content that can be updated</td>
<td>Web resources only (Cordova and Ionic apps)</td>
<td><span style="color:green"><b>Native code (Native Android apps)</b></span></td>
</tr>
<tr>
<td>Cusomtizability</td>
<td><span style="color:green"><b>Fully customizable by overriding the Direct Update Challenge handler</b></span></td>
<td><span style="color:green">Partly customizable. Two modes available - flexible and immediate</span></td>
</tr>
<tr>
<td>Custom UX for downloading</td>
<td><span style="color:green"><b>Fully customizable</b></span></td>
<td>No customization - Play Store UI is shown to the user</td>
</tr>
<tr>
<td>Additional coding required</td>
<td><span style="color:green"><b>None. Available out of the box</b></span></td>
<td>App must be coded & prepared ahead of time</td>
</tr>
<tr>
<td>Resumable updates</td>
<td><span style="color:green"><b>Yes</b></span></td>
<td>No</td>
</tr>
<tr>
<td>Update download size</td>
<td><span style="color:green"><b>Small. Only delta can be downloaded</b></span></td>
<td>Full update is downloaded</td>
</tr>
<tr>
<td>Option of rejecting an update for users</td>
<td><span style="color:green"><b>Yes</b></span></td>
<td>Yes - only in a flexible update</td>
</tr>
<tr>
<td>Silent update</td>
<td><span style="color:green"><b>Yes</b></span></td>
<td>No</td>
</tr>
<tr>
<td>Other Limitations</td>
<td>Installed app and update must be from the same version</td>
<td><span style="color:green"><b>Update must be of a higher version than the installed version</b></span></td>
</tr>
<tr>
<td>Secure updates</td>
<td><span style="color:green"><b>Yes</b></span> </td>
<td><span style="color:green"><b>Yes</b></span> (delivered through Play Store)</td>
</tr>
</tbody>
</table>


### Conclusion

If you're a native Android app developer, the in-app udpate is a new capability that fills the gap of providing an update without the user having to launch the Play Store. Exploiting this requires some amount of forethought and code from the developer even before you deliver any updates. Additionally, you're still constrained by the restrictions of in-app updates and Play Store mentioned in the table above.

Direct Update, on the other hand is available to only Cordova and Ionic apps, but is far more versatile and powerful in creating a compelling user experience.
