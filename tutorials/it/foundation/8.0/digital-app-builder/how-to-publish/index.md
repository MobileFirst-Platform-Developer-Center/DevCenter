---
layout: tutorial
title: Publishing an app to IBM App Center
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Publishing an app to App Center
{: #dab-app-publish }

IBM MobileFirst Foundation Application Center is a repository of mobile applications similar to public app stores but focused on the needs of an organization or a team. It is a private app store. For more information about App Center, refer [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/).

You can add your app to the repository on the server by using the **Publish** function in the Digital App Builder.

>**Note**: Make sure your app is built without any error before publishing to app center.

1. From your app project, click **Publish**. This will open up a popup with the platforms selected.

    ![Publish](dab-publish.png)

2. Click **Publish to App Center**.

    ![Publish to App Center](dab-publish-app-center.png)

3. Select an existing App Center or click **Connect New**. Click **Connect**.
4. This will build the package for the selected platform.
5. *For iOS only*: Edit the *app-build.json* file and update the `developmentTeam` field with your Apple Developer Team ID. To find out the Team ID, login to [Apple Developer Account](https://developer.apple.com/account/#/membership). 

    ![Publish iOS](dab-publish-ios.png)

6. Click **Publish** once the packages are ready.
7. On successful publishing, QR code is generated.

    ![Publish to App Center QR code](dab-publish-code-scan.png)

8. You can verify the app is available in the App Center by logging into **App Center** > **Application Management**.

>**Note**: You can reselect the platform required and build and publish the app to **App Center**.

