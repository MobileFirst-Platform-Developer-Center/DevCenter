---
layout: tutorial
title: React Native 개발 환경 설정
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
React Native는 HTML, CSS, Javascript와 같은 웹 기술을 사용하여 네이티브 모바일 애플리케이션을 빠르게 빌드하는 데 도움이 되는 [React](https://reactjs.org/)를 사용하여 네이티브 iOS 및 Android 애플리케이션을 빌드하기 위한 프레임워크입니다.

모바일 또는 웹 앱을 개발하는 프레임워크로 React Native를 선택한 개발자라면 다음 절은 React Native 앱에서 [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) SDK를 시작하는 데 도움이 됩니다.

애플리케이션을 작성하는 데 선호하는 코드 편집기(예: Atom.io, Visual Studio Code, Eclipse, IntelliJ 등)를 사용할 수 있습니다.

**전제조건:** React Native 개발 환경을 설정할 때는 [MobileFirst 개발 환경 설정](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) 학습서도 읽어야 합니다.

## React Native CLI 설치
{: #installing_cli }
React Native 개발을 시작하려면 필요한 첫 번째 단계는 [React Native CLI](https://facebook.github.io/react-native/docs/getting-started.html)를 설치하는 것입니다.

**React Native CLI를 설치하려면 다음을 수행하십시오.**

* [NodeJS](https://nodejs.org/en/)를 다운로드하여 설치하십시오.
* 명령행 창에서 다음 명령을 실행하십시오.
```bash
npm install -g react-native-cli
```

## React Native 앱에 Mobile Foundation SDK 추가
{: #adding_mfp_reactnative_sdk }
React Native 애플리케이션에서 MobileFirst 개발을 계속하려면 React Native 애플리케이션에 MobileFirst React Native SDK 또는 플러그인을 추가해야 합니다.

React Native 애플리케이션에 MobileFirst SDK를 추가하는 방법을 학습하십시오.
애플리케이션 개발의 경우 [React Native 애플리케이션에 Mobile Foundation SDK 추가]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/reactnative) 학습서를 참조하십시오.
