---
layout: tutorial
title: React Native 애플리케이션에 MobileFirst Foundation SDK 추가
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
이 학습서에서는 React Native CLI를 사용하여 작성한 신규 또는 기존 React Native 애플리케이션에 {{ site.data.keys.product_adj }} SDK를 추가하는 방법에 대해 학습합니다. 또한 애플리케이션을 인식하도록 {{ site.data.keys.mf_server }}를 구성하는 방법 및 프로젝트에서 변경된 {{ site.data.keys.product_adj }} 구성 파일에 대한 정보를 찾는 방법에 대해서도 학습합니다.

{{ site.data.keys.product_adj }} React Native SDK는 react native npm 플러그인으로 제공되며 [NPM](https://www.npmjs.com/package/react-native-ibm-mobilefirst)에 등록됩니다.  

사용 가능한 플러그인은 다음과 같습니다.

* **react-native-ibm-mobilefirst** - 핵심 SDK 플러그인

#### 다음으로 이동:
{: #jump-to }
- [React Native SDK 컴포넌트](#react-native-sdk-components)
- [{{ site.data.keys.product_adj }} React Native SDK 추가](#adding-the-mobilefirst-react-native-sdk)
- [{{ site.data.keys.product_adj }} React Native SDK 업데이트](#updating-the-mobilefirst-react-native-sdk)
- [생성되는 {{ site.data.keys.product_adj }} React Native SDK 아티팩트](#generated-mobilefirst-reactnative-sdk-artifacts)
- [다음 학습서](#tutorials-to-follow-next)


## React Native SDK 컴포넌트
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
react-native-ibm-mobilefirst 플러그인은 React Native의 핵심 {{ site.data.keys.product_adj }} 플러그인이며 필수입니다. 아직 설치되지 않은 경우 다른 {{ site.data.keys.product_adj }} 플러그인을 설치하면 react-native-ibm-mobilefirst 플러그인도 자동으로 설치됩니다.

**전제조건:**

- 개발자 워크스테이션에 [React Native CLI](https://www.npmjs.com/package/react-native) 및 {{ site.data.keys.mf_cli }}가 설치되어 있습니다.
- {{ site.data.keys.mf_server }}의 로컬 또는 원격 인스턴스가 실행 중입니다.
- [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/development/mobilefirst) 및 [React Native 개발 환경 설정](../../../installation-configuration/development/reactnative) 학습서를 읽으십시오.

## {{ site.data.keys.product }} React Native SDK 추가
{: #adding-the-mobilefirst-react-native-sdk }
아래 지시사항에 따라 신규 또는 기존 React Native 프로젝트에 {{ site.data.keys.product }} React Native SDK를 추가하고 {{ site.data.keys.mf_server }}에 등록하십시오.

시작하기 전에 {{ site.data.keys.mf_server }}가 실행 중인지 확인하십시오.  
로컬로 설치된 서버를 사용하는 경우: **명령행** 창에서 서버의 폴더로 이동하고 `./run.sh` 명령을 실행하십시오.

### SDK 추가
{: #adding-the-sdk }

#### 새 애플리케이션
{: #new-application }
1. `react-native init projectName` 명령을 사용하여 React Native 프로젝트를 작성하십시오.  
예:

   ```bash
   react-native init Hello
   ```
     - *Hello*는 폴더 이름이자, 애플리케이션 이름입니다.

    > 템플리트된 **index.js**를 통해 추가 {{ site.data.keys.product_adj }} 기능(예: [다국어 애플리케이션 변환](../../translation) 및 초기화 옵션)을 사용할 수 있습니다(자세한 정보는 사용자 문서 참조).

2. `cd hello` 명령을 사용하여 React Native 프로젝트의 루트로 디렉토리를 변경하십시오.

3. NPM CLI 명령 `npm install react-native-plugin-name`을 사용하여 MobileFirst 플러그인을 추가하십시오.
예:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > 위 명령은 React Native 프로젝트에 MobileFirst Core SDK 플러그인을 추가합니다.


4. 다음 명령을 실행하여 플러그인 라이브러리를 링크하십시오.

   ```bash
   react-native link
   ```

#### 기존 애플리케이션
{: #existing-application }

1. 기존 React Native 프로젝트의 루트로 이동하고 {{ site.data.keys.product_adj }} 핵심 React Native 플러그인을 추가하십시오.

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. 다음 명령을 실행하여 플러그인 라이브러리를 링크하십시오.

   ```bash
   react-native link
   ```

### 애플리케이션 등록
{: #registering-the-application }

1. **명령행** 창을 열고 프로젝트의 특정 플랫폼(iOS 또는 Android)의 루트로 이동하십시오.  

2. {{ site.data.keys.mf_server }}에 애플리케이션을 등록하십시오.

   ```bash
   mfpdev app register
   ```

  * **iOS** :

    플랫폼이 iOS인 경우 애플리케이션의 BundleID를 제공하도록 요청됩니다. **중요**: 번들 ID는 **대소문자를 구분**합니다.

    `mfpdev app register` CLI 명령은 먼저 MobileFirst Server에 연결하여 애플리케이션을 등록한 후에 Xcode 프로젝트의 루트에서 **mfpclient.plist** 파일을 생성하고 MobileFirst Server를 식별하는 메타데이터에 추가합니다.

  *  **Android** :

      플랫폼이 Android인 경우 애플리케이션의 패키지 이름을 제공하도록 요청됩니다. **중요**: 패키지 이름은 **대소문자를 구분**합니다.

       `mfpdev app register` CLI 명령은 먼저 MobileFirst Server에 연결하여 애플리케이션을 등록한 후에 Android Studio 프로젝트의 **[project root]/app/src/main/assets/** 폴더에 **mfpclient.properties** 파일을 생성하고 MobileFirst Server를 식별하는 메타데이터에 추가합니다.


원격 서버를 사용하는 경우 `mfpdev server add` [명령을 사용](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)하여 이를 추가하십시오.

`mfpdev app register` CLI 명령은 먼저 {{ site.data.keys.mf_server }}에 연결하여 애플리케이션을 등록합니다. 	각 플랫폼은 {{ site.data.keys.mf_server }}에 애플리케이션으로 등록됩니다.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** {{ site.data.keys.mf_console }}에서 애플리케이션을 등록할 수도 있습니다.    
>
> 1. {{ site.data.keys.mf_console }}을 로드하십시오.  
> 2. **애플리케이션** 옆에 있는 **새로 작성** 단추를 클릭하여 새 애플리케이션을 등록하고 화면의 지시사항에 따르십시오.  


## {{ site.data.keys.product_adj }} React Native SDK 업데이트
{: #updating-the-mobilefirst-react-native-sdk }
최신 릴리스로 {{ site.data.keys.product_adj }} React Native SDK를 업데이트하려면 `npm uninstall react-native-ibm-mobilefirst` 명령을 실행하여 **react-native-ibm-mobilefirst** 플러그인을 제거한 후에 `npm install react-native-ibm-mobilefirst` 명령을 실행하여 이를 다시 추가하십시오.

SDK 릴리스는 SDK의 [NPM 저장소](https://www.npmjs.com/package/react-native-ibm-mobilefirst)에 있습니다.

## 생성되는 {{ site.data.keys.product_adj }} React Native SDK 아티팩트
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Android 환경

#### mfpclient.properties
{: #mfpclient.properties }
이 파일은 Android Studio 프로젝트의 **./app/src/main/assets/** 폴더에 있으며, {{ site.data.keys.mf_server }}에서 Android 앱을 등록하는 데 사용되는 클라이언트 측 특성을 정의합니다.

| 특성            | 설명                                                         | 예제 값 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | {{ site.data.keys.mf_server }}에 사용되는 통신 프로토콜입니다.             | HTTP 또는 HTTPS  |
| wlServerHost        | {{ site.data.keys.mf_server }}의 호스트 이름입니다.                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }}의 포트입니다.                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }}에서 애플리케이션의 컨텍스트 루트 경로입니다. | /mfp/          |
| languagePreferences | 클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다.           | en             |


### iOS 환경

#### mfpclient.plist
{: #mfpclientplist }
이 파일은 프로젝트의 루트에 있으며 {{ site.data.keys.mf_server }}에서 iOS 앱을 등록하는 데 사용되는 클라이언트 측 특성을 정의합니다.

| 특성            | 설명                                                         | 예제 값 |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | {{ site.data.keys.mf_server }}에 사용되는 통신 프로토콜입니다.             | HTTP 또는 HTTPS  |
| host        | {{ site.data.keys.mf_server }}의 호스트 이름입니다.                            | 192.168.1.63   |
| port        | {{ site.data.keys.mf_server }}의 포트입니다.                                 | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }}에서 애플리케이션의 컨텍스트 루트 경로입니다. | /mfp/          |
| languagePreferences | 클라이언트 SDK 시스템 메시지의 기본 언어를 설정합니다.           | en             |


## 다음 학습서
{: #tutorials-to-follow-next }
이제 {{ site.data.keys.product_adj }} React Native SDK가 통합되었으므로 다음을 수행할 수 있습니다.

- [{{ site.data.keys.product }} SDK 사용 학습서](../) 검토
- [어댑터 개발 학습서](../../../adapters/) 검토
- [인증 및 보안 학습서](../../../authentication-and-security/) 검토
- [알림 학습서](../../../notifications/) 검토
- [모든 학습서](../../../all-tutorials) 검토
