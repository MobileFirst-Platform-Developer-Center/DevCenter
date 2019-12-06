---
layout: tutorial
title: 앱 개발
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #developing-an-app }

앱 개발에는 다음 단계가 포함됩니다.

1. 앱을 작성하십시오. [앱 작성](../getting-started/) 섹션을 참조하십시오.
2. 필요한 제어를 추가하여 앱을 디자인하십시오. 자세한 정보는 [Digital App Builder 인터페이스](../dab-interface/)를 참조하십시오.
3. 앱에서 필요한 서비스(Watson Chat, Watson Visual Recognition, 푸시 알림, 데이터 세트, 라이브 업데이트)를 추가하십시오.
4. 필요한 경우 플랫폼을 추가하거나 수정하십시오. [설정 > 앱 세부사항](../settings/) 섹션을 참조하십시오.
5. 앱을 미리보기하십시오. [시뮬레이터를 사용하여 앱 미리보기](#preview-the-app-using-the-simulator)를 참조하십시오.
6. 애플리케이션을 미리보기한 후 빌드가 준비되면 오류를 수정한 후 애플리케이션을 빌드하기 위한 다음 단계를 수행하십시오.

    * **Android 앱의 경우:**

        a. 앱 작성 시 사용자가 지정한 디렉토리로 이동하십시오.

        b. ionic 폴더로 이동하십시오.

        c. **플랫폼 > Android**로 이동하십시오.

        d. Android Studio를 연 후 **파일 > 프로젝트 열기** >로 이동하고 c단계에서 언급된 Android 폴더를 선택하십시오.

        e. 프로젝트를 빌드하십시오. 

        >**참고**: 공개 및 빌드를 위해 튜토리얼 [https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/)의 단계를 따르십시오.

    * **iOS 앱의 경우**:
 
        a. 앱 작성 시 사용자가 지정한 디렉토리로 이동하십시오.

        b. ionic 폴더로 이동하십시오.

        c. 플랫폼 > iOS로 이동하십시오.

        d. **Xcode**를 연 후 프로젝트를 빌드하십시오. 

        >**참고**: 공개 및 빌드를 위해 튜토리얼 [https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/)의 단계를 따르십시오.


### 앱 미리보기
{: #preview-the-app }

선택된 채널에 시뮬레이션을 연결하여 개발된 앱을 미리보기할 수 있습니다.

* iOS에서 앱을 미리보기하려면 Apple 앱스토어에서 **XCode**를 다운로드 및 설치하십시오.
* Android에서 앱을 미리보기하려면 다음을 수행하십시오. 
    * Android Studio를 설치하고 지시사항을 따르십시오. [https://developer.android.com/studio/](https://developer.android.com/studio/)
    * Android 가상 머신을 구성하십시오. [여기](https://developer.android.com/studio/releases/emulator)의 지시사항을 따르십시오.

>**참고**: 앱을 빠르게 미리보려면 앱 미리보기 옵션을 선택하십시오. 그러면 실행 중인 앱의 새 창이 열립니다. 이를 다른 플랫폼 모델로 설정하고 방향을 변경할 수도 있습니다. 앱에서 작성된 변경사항은 이 미리보기 창에서 즉시 반영됩니다.

>**참고**: 파일 > 코드로 내보내기는 프로젝트를 코드 모드로 내보냅니다. (앱 코드가 새 폴더에 저장되므로 디자인 모드에는 지장이 없습니다.) 코드 모드로 내보낸 후에는 디자인 모드에서 내보낸 프로젝트를 열 수 없습니다.
