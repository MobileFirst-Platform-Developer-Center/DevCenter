---
layout: tutorial
title: プッシュ通知の追加
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## アプリケーションへのプッシュ通知の追加
{: #dab-engagement-push }

プッシュ通知をアプリケーションに追加し、ユーザー・エンゲージメントを増やすことができます。

プッシュ通知をアプリケーションに追加するには、以下のようにします。

1. **「エンゲージメント (Engagement)」**を選択します。 これにより、使用可能なサービスのリストが表示されます。

    ![エンゲージメントのプッシュ](dab-push-notification.png)

2. **「プッシュ通知」**を選択し、**「有効にする (Enable)」**をクリックします。 これにより、「プッシュ通知の構成 (Push Notifications configuration)」ページが表示されます。

3. **「API 秘密鍵 (API Secret Key)」**および**「送信者 ID (Sender ID)」**を指定して Android のプッシュ通知を構成し、**「構成の保存 (Save configuration)」**をクリックします。

    ![エンゲージメントのプッシュ通知の Android 構成](dab-push-android-config.png)

4. iOS タブにナビゲートし、プッシュ構成詳細を指定します。**「環境 (Environment)」**を選択し、.p12 ファイルをパスとともに指定し、**「パスワード」**を入力し、**「構成の保存 (Save configuration)」**をクリックします。

    ![エンゲージメントのプッシュ通知の iOS 構成](dab-push-ios-config.png)

5. iOS の場合、以下の追加ステップを実行します。
    * xcode プロジェクト `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj` を開き、プッシュ通知機能を有効にします。 詳しくは、[https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1) を参照してください。

6. サーバー・サイドで以下を行います。
 
    * [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) に従って、サーバー・サイドでプッシュ通知を有効にします。

    * [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications) に従って、サーバーから通知を送信します。

**注**:
MFP サーバーからのプッシュ通知は、通知サービスを有効にするために使用されます。 したがって、IBM Cloud プッシュ通知サービスが以前に使用されていた場合は、リンク [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) に従って MFP サーバーに通知を設定します。

