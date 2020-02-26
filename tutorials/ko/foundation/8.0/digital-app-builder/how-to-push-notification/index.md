---
layout: tutorial
title: 푸시 알림 추가
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 앱에 푸시 알림 추가
{: #dab-engagement-push }

앱에 푸시 알림을 추가하고 사용자 참여를 늘릴 수 있습니다.

앱에 푸시 알림을 추가하려면 다음을 수행하십시오.

1. **참여**를 선택하십시오. 사용 가능한 서비스의 목록이 표시됩니다.

    ![참여 푸시](dab-push-notification.png)

2. **푸시 알림**을 선택하고 **사용**을 클릭하십시오. 그러면 푸시 알림 구성 페이지가 표시됩니다.

3. **API 비밀 키** 및 **발신인 ID**를 제공하여 Android용 푸시 알림을 구성하고 **구성 저장**을 클릭하십시오.

    ![참여 푸시 알림 Android 구성](dab-push-android-config.png)

4. iOS 탭으로 이동하고 푸시 구성 세부사항을 제공하십시오. **환경**을 선택하고 경로가 있는 .p12 파일을 제공한 후 **비밀번호**를 입력하고 **구성 저장**을 클릭하십시오.

    ![참여 푸시 알림 iOS 구성](dab-push-ios-config.png)

5. iOS의 경우 다음의 추가 단계를 수행하십시오.
    * xcode 프로젝트 `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj`를 열고 푸시 알림 기능을 사용으로 설정하십시오. 세부사항은 [https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1)을 참조하십시오.

6. 서버 측에서 다음을 수행하십시오.
 
    * [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) 를 따라 서버 측에서 푸시 알림을 사용으로 설정하십시오.

    * [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications)를 따라 서버에서 알림을 전송하십시오.

**참고**:
MFP 서버의 푸시 알림은 알림 서비스를 사용으로 설정하는 데 사용됩니다. 그러므로 IBM Cloud 푸시 알림 서비스가 이전에 사용된 경우 링크를 따라 MFP 서버의 알림을 설정하십시오.
[http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications).

