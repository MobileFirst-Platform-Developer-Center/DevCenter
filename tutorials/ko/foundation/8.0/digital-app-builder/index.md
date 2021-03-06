---
layout: tutorial
title: IBM Digital App Builder
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
**IBM Digital App Builder**는 Watson 서비스로 구동되는 AI 기능을 사용하여 모바일, 웹, PWA(Progressive Web App) 다중 채널 애플리케이션을 빠르게 작성하는 데 도움이 되는 하위 코드 도구입니다. Digital App Builder를 사용하여 작성된 앱은 보안, 백엔드 연결, 분석을 위해 IBM Mobile Foundation V8(온프레미스 또는 클라우드)을 활용합니다.

IBM Digital App Builder의 주요 기능은 다음과 같습니다.

* 이 도구를 사용하여 다중 채널에서 실행될 수 있는 디지털 앱을 빠르게 빌드할 수 있습니다. Digital App Builder는 앱을 빠르게 빌드하기 위해 컴포넌트를 끌어서 놓기할 수 있는 기능을 제공합니다. 이 앱은 iOS(iPhone, iPad), Android(휴대폰, 탭), PWA(Progressive Web App), 웹 페이지용 앱과 같은 다중 채널을 대상으로 할 수 있습니다.

* 챗봇 및 Visual Recognition 등의 Watson AI 기능을 손쉽게 통합합니다. 챗봇 또는 Visual Recognition 기능을 앱에 추가하는 것이 제어를 추가하는 것만큼 쉬워집니다. 또한 질문/답변 세트를 추가하여 AI 서비스를 손쉽게 훈련하고 분류할 이미지 세트를 끌어서 놓습니다. 데이터 과학자가 복잡한 시스템 학습 모델을 빌드할 필요가 없습니다.

* 마이크로서비스 백엔드의 데이터 바운드 제어를 추가합니다. 마법사는 마이크로서비스의 Open API 스펙(Swagger)을 가져오는 데 사용할 수 있습니다. 이는 앱에서 데이터 바운드 UI 제어에 바인드되는 서비스의 프론트 엔드를 빌드하기 위해 데이터 세트를 작성하도록 돕습니다. 앱에서 고급 코딩을 수행하기 위해 코드 보기로 전환하십시오.

* 참여의 일부로 푸시 알림 서비스를 추가합니다.

* 라이브 업데이트를 사용하여 앱이 라이브 상태가 된 이후 앱 기능 켜기/끄기를 동적으로 토글합니다.

* 프로덕션의 실제 마이크로서비스를 모방하기 위한 mock REST API를 배치하여 앱을 코딩합니다.

* 앱 소유자는 앱에 대해 분석을 사용으로 설정할 수 있습니다. 앱은 이제 데이터를 Mobile Foundation 서버로 전송합니다.

작성된 앱은 Cordova, Ionic, Angular와 같은 오픈 소스 기술을 사용합니다. 배치되기 전에 다양한 폼 팩터에 대해 앱을 미리보기할 수 있습니다. 또한 빠른 시작 템플리트를 사용하여 앱을 빌드할 수도 있습니다(예: Watson 챗봇).

## Digital App Builder를 시작하기 위한 샘플
{: #samples-dab}

1. [Digital App Builder를 사용하여 새 샘플 앱을 작성합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/1-getting-started)
2. [새 앱에 Watson Chatbot을 추가합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/2-watson-chatbot)
3. [앱에 일부 애플리케이션 함수 코드를 추가합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/3-toggle-design-code)
4. [일부 모의 백엔드 API를 빌드하여 애플리케이션을 백엔드 코드에 대해 테스트합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/3-toggle-design-code)
5. [앱에서 마이크로서비스 백엔드를 호출합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/5-microservice-invocation)
6. [API 프록시를 사용하여 앱에서 백엔드 마이크로서비스를 호출합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/6-api-proxy)
7. [앱 알림을 전송하는 기능을 추가하여 앱 사용자를 참여시킵니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/7-push-notifications)
8. [앱에서 제공하는 기능을 제어하기 위한 기능 토글 기능을 추가합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/8-liveupdate)
9. [사용자 정의 분석을 추가하여 앱 사용에 대한 인사이트를 얻습니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/9-custom-analytics)
10. [앱 내 피드백을 사용하여 앱에 대한 피드백을 청취합니다.](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/10-inapp-feedback)

>**참고**: [이 Git 저장소](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)의 Readme에 있는 지시사항에 따라 위의 Digital App Builder 샘플을 시작할 수도 있습니다.

### 학습할 튜토리얼
{: #tutorials-to-follow }

제품에 대한 추가 정보는 아래에서 찾으십시오.
