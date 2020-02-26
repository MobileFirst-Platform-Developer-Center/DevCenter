---
layout: tutorial
title: CD 업데이트의 새로운 기능
breadcrumb_title: CD Updates
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
임시 수정사항 및 CD 업데이트는 문제점 정정을 위한 패치 및 업데이트를 제공하고 모바일 운영 체제의 새 릴리스에 대해 현재 {{ site.data.keys.product_full }}을 유지합니다. CD 업데이트는 새 기능을 도입하여 제품의 기능을 개선합니다.

임시 수정사항 및 CD 업데이트는 누적됩니다. 최신 v8.0 임시 수정사항 또는 CD 업데이트를 다운로드할 경우, 이전 임시 수정사항에서 모든 수정사항을 얻습니다.

다음 섹션에 설명된 모든 수정사항을 획득하기 위해 최신 CD 업데이트를 다운로드하고 설치하십시오.

> {{ site.data.keys.product }} 8.0의 iFix 릴리스 목록에 대해서는 [여기를 참조하십시오]({{site.baseurl}}/blog/tag/iFix_8.0/).

### CD 업데이트 6에 포함된 기능(8.0.0.0-MFPF-IF201911050809-CDUpdate-06)

#### <span style="color:Black">서버</span>
##### <span style="color:NAVY">**성능 개선사항**</span>

Mobile Foundation 데이터베이스 오퍼레이션이 최적화되고 레코드 데이터베이스의 자동 제거가 도입되었습니다.

##### <span style="color:NAVY">**이제 DevKit에서 사용 가능한 Application Center**</span>

Application Center는 이제 [DevKit]({{site.baseurl}}/downloads/)에서 패키지로 사용할 수 있습니다. 이를 사용하면 개발자가 앱을 빌드하고 이를 DevKit의 일부로 사용 가능한 개인 저장소에 공개할 수 있습니다.

##### <span style="color:NAVY">**벤더 소프트웨어에 대한 스택 지원**</span>

Mobile Foundation에서는 이제 Windows Server 2016 SE 및 Oracle 18c를 지원합니다.

##### <span style="color:NAVY">**애플리케이션 개발 프레임워크를 위한 지원**</span>

Mobile Foundation은 [iOS 13]({{site.baseurl}}/blog/2019/09/19/IBM-MobileFoundation-iOS13/), iPadOS 및 [Android 10]({{site.baseurl}}/blog/2019/09/04/mobilefirst-android-Q/)에 대한 지원과 함께 Apple 및 Google에서 릴리스하는 최신 프레임워크를 지원합니다. 플랫폼에서도 Swift 5용 SDK를 제공됩니다.

##### <span style="color:NAVY">**API Proxy를 사용하여 백엔드 앱에 안전하게 연결**</span>

엔터프라이즈 백엔드에 연결하는 경우 API Proxy를 사용하여 Mobile Foundation 플랫폼의 보안 및 분석을 활용할 수 있습니다. API Proxy는 실제 백엔드에 대한 요청을 대신합니다. [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/digital-app-builder/api-proxy/).

#### <span style="color:Black">분석</span>
##### <span style="color:NAVY">**앱 내 피드백**</span>

앱 내 피드백 기능은 이전에 IBM Cloud의 Mobile Foundation 서비스에서 사용할 수 있었지만 이제는 Mobile Foundation의 온프레미스 및 컨테이너 배포로 이동되었습니다. 이 기능을 사용하면 사용자가 스크린샷, 어노테이션 및 텍스트 양식으로 앱의 피드백을 공유할 수 있습니다. 관리자는 분석 콘솔에 로그인하여 수신한 피드백을 보고 필요한 조치를 취할 수 있습니다.



#### <span style="color:Black">OpenShift 패키지</span>
##### <span style="color:NAVY">**IBM Cloud Pak for Applications v3의 일부인 Mobile Foundation**</span>

Mobile Foundation은 이제 [IBM Cloud Pak for Apps]({{site.baseurl}}/blog/2019/09/13/announcing-support-for-mf-on-rhocp/)의 일부이며 Red Hat Open Shift 3.11 및 Red Hat Open Shift 4.2를 지원합니다. 현재 사용 가능한 서비스는 모바일 코어, 분석, 푸시 알림 및 앱 센터입니다. 이 기능을 사용하면 개발자가 백엔드 마이크로서비스 및 모바일 서비스를 사용하여 클라우드 기반 애플리케이션을 빌드할 수 있습니다.


### CD 업데이트 5에 포함된 기능(8.0.0.0-MFPF-IF201903190949-CDUpdate-05)

##### <span style="color:NAVY">**CoreML 업데이트**</span>

기계 학습(ML) 모델은 Apple의 CoreML 프레임워크를 사용하여 iOS 모바일 디바이스에서 로컬로 실행할 수 있습니다.
Mobile Foundation은 디바이스에 대해 안전한 모델 분배를 관리하기 위한 기능을 제공합니다. [자세히 보기](https://mobilefirstplatform.ibmcloud.com/blog/2019/02/08/distribute-coreml-models-securely-using-mfp/).

##### <span style="color:NAVY">**watchOS를 위한 앱 인증**</span>

앱 인증은 액세스를 제공하기 전에 애플리케이션의 인증을 유효성 검증하는 보안 기능입니다. 이 기능은 모바일 앱에 사용 가능했습니다. 기능은 이제 Apple WatchOS 앱으로 확장되었습니다. [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/watchos/).

##### <span style="color:NAVY">**푸시 알림 - FCM의 추가 메시지 기능 및 속성**</span>

푸시 알림은 이제 다음 추가 메시지 속성을 지원합니다.
1. 표시등
2. 스타일(받은 편지함, BigText, PictureNotifications)


### CD 업데이트 4에 포함된 기능 (8.0.0.0-MFPF-IF201812191602-CDUpdate-04)

##### <span style="color:NAVY">**APNs 푸시 알림을 위한 HTTP/2 지원**</span>

MobileFirst의 푸시 알림이 이제 기존의 TCP 소켓 기반 알림과 함께 HTTP/2 기반 APNs 푸시 알림을 지원합니다. [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/sending-notifications/#http2-support-for-apns-push-notifications).

##### <span style="color:NAVY">**React Native Push SDK 릴리스**</span>

React Native SDK for Push(*react-native-ibm-mobilefirst-push 1.0.0*)가 이번 CD 업데이트에서 릴리스되었습니다.


### CD 업데이트 3(8.0.0.0-MFPF-IF201811050432-CDUpdate-03)에서 도입된 기능

##### <span style="color:NAVY">**iOS에서 새로 고치기 토큰 지원**</span>

Mobile Foundation은 이 CD 업데이트부터 iOS에서 새로 고치기 토큰 기능을 도입합니다. [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Mobile Foundation 콘솔에서 관리 CLI(*mfpadm*) 다운로드**</span>

이제 Mobile Foundation 콘솔의 *Download Center*에서 Mobile Foundation 관리 CLI(*mfpadm*)를 다운로드할 수 있습니다.

##### <span style="color:NAVY">**MobileFirst CLI를 위한 Node v8.x 지원**</span>

이 iFix(*8.0.0.0-MFPF-IF201810040631*)부터 Mobile Foundation은 MobileFirst CLI를 위해 Node v8.x에 대한 지원을 추가합니다.

##### <span style="color:NAVY">**Cordova 프로젝트에 대해 *libstdc++*에 대한 종속성 제거**</span>

이 iFix(*8.0.0.0-MFPF-IF201809041150*)부터 Cordova 프로젝트에 대해 종속 항목으로서 *libstdc++*를 제거하기 위한 변경이 도입되었습니다. 이는 iOS 12에서 실행 중인 새 앱에 필요합니다. 임시 해결책과 같은 추가 세부사항은 [이 블로그 게시물](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/)을 참조하십시오.

### CD 업데이트 2(8.0.0.0-MFPF-IF201807180449-CDUpdate-02)에서 도입된 기능

##### <span style="color:NAVY">**React Native 개발 지원**</span>

CD 업데이트(*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*)부터 Mobile Foundation은 React Native 앱용 IBM Mobile Foundation SDK의 가용성과 함께 React Native 개발을 위한 지원을 [발표합니다]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/). [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).

##### <span style="color:NAVY">**iOS 및 Cordova SDK 사용 시 JSONStore 콜렉션과 CouchDB 데이터베이스의 자동화된 동기화**</span>

CD 업데이트(*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*) 부터 MobileFirst iOS SDK 및 Cordova SDK를 사용하여 [Cloudant](https://www.ibm.com/in-en/marketplace/database-management)를 포함한 모든 종류의 CouchDB 데이터베이스와 디바이스의 JSONStore 콜렉션 사이에서 데이터 동기화를 자동화할 수 있습니다. 이 기능에 대한 자세한 정보는 이 [블로그 게시물]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/)을 참조하십시오.

##### <span style="color:NAVY">**새로 고치기 토큰 도입**</span>

CD 업데이트(*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*)부터 Mobile Foundation은 이제 새 액세스 토큰을 요청하는 데 사용할 수 있는 새로 고치기 토큰이라는 특별한 종류의 토큰을 도입합니다.  [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Cordova v8 및 Cordova Android v7의 지원**</span>

이 iFix(*8.0.0.0-MFPF-IF201804051553*)부터 Cordova v8 및 Cordova Android v7용 MobileFirst Cordova 플러그인이 지원됩니다. 언급된 버전의 Cordova를 사용하려면 최신 MobileFirst 플러그인을 확보하여 최신 CLI(mfpdev-cli) 버전으로 업그레이드해야 합니다. 지원되는 개별 플랫폼 버전에 대한 세부사항은 [Cordova 애플리케이션에 MobileFirst Foundation SDK 추가]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels)를 참조하십시오.

##### <span style="color:NAVY">**JSONStore 콜렉션과 CouchDB 데이터베이스의 자동화된 동기화**</span>

이 iFix(*8.0.0.0-MFPF-IF201802201451*)부터 MobileFirst Android SDK를 사용하여 [Cloudant](https://www.ibm.com/in-en/marketplace/database-management)를 포함한 모든 종류의 CouchDB 데이터베이스와 디바이스의 JSONStore 콜렉션 사이에서 데이터 동기화를 자동화할 수 있습니다. 이 기능에 대한 자세한 정보는 이 [블로그 게시물]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/)을 참조하십시오.

### CD 업데이트 1(8.0.0.0-MFPF-IF201711230641-CDUpdate-01)에서 도입된 기능

##### <span style="color:NAVY">**Eclipse UI 편집기 지원**</span>

CD 업데이트 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*부터 MobileFirst Studio의 Eclipse에서 이제 WYSIWYG 편집기가 제공됩니다. 개발자는 이 UI 편집기를 사용하여 Cordova 애플리케이션용 UI를 디자인하고 구현할 수 있습니다. [자세히 보기](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**코그너티브 앱을 빌드하기 위한 새로운 어댑터**</span>

CD 업데이트 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*부터 Mobile Foundation은 [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) 및 [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator) 서비스를 위한 사전 빌드되는 2개의 새 코그너티브 서비스 어댑터를 도입했습니다. 이 어댑터는 Mobile Foundation 콘솔의 *Download Center*에서 다운로드하여 배치할 수 있습니다.

##### <span style="color:NAVY">**동적 앱 인증**</span>

iFix *8.0.0.0-MFPF-IF20170220-1900*부터 새로운 *애플리케이션 인증* 구현이 제공됩니다. 이 구현에는 *.authenticity_data* 파일 생성을 위한 오프라인 *mfp-app-authenticity* 도구가 필요하지 않습니다. 대신 MobileFirst 콘솔에서 *애플리케이션 인증*을 사용 또는 사용 안함으로 설정할 수 있습니다. 자세한 정보는 [애플리케이션 인증 구성](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity)을 참조하십시오.

##### <span style="color:NAVY">**Appcenter(클라이언트 및 서버)의 Windows 10 지원**</span>

iFix *8.0.0.0-MFPF-IF20170327-1055*부터 IBM Application Center에서 Windows 10 UWP 앱이 지원됩니다. 사용자는 이제 Windows 10 UWP 앱을 업로드하고 사용하는 디바이스에 동일한 앱을 설치할 수 있습니다. UWP 앱을 설치하기 위한 Windows 10 UWP 클라이언트 프로젝트가 이제 Application Center와 함께 제공됩니다. Visual Studio에서 프로젝트를 열어 배포할 2진(예: *.appx*)을 작성할 수 있습니다. Application Center는 모바일 클라이언트 배포를 위한 사전 정의된 방법을 제공하지 않습니다. 자세한 정보는 [Microsoft Windows 10 Universal (Native) IBM AppCenter 클라이언트](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client)를 참조하십시오.

##### <span style="color:NAVY">**MobileFirst Eclipse 플러그인의 Eclipse Neon 지원**</span>

iFix *8.0.0.0-MFPF-IF20170426-1210*부터 MobileFirst Eclipse 플러그인이 Eclipse Neon을 지원하도록 업데이트됩니다.

##### <span style="color:NAVY">**Android SDK가 새 OkHttp 버전(버전 3.4.1)을 사용하도록 수정되었음**</span>

iFix *8.0.0.0-MFPF-IF20170605-2216*부터 Android SDK가 이전에 Android용 MobileFirst SDK와 번들된 이전 버전 대신 새 버전의 *OkHttp(버전 3.4.1)*를 사용하도록 수정되었습니다. OkHttp가 SDK와 번들되지 않고 종속 항목으로 추가됩니다. 이로써 개발자가 OkHttp 라이브러리를 사용할 때 자유롭게 선택할 수 있으며 여러 OkHttp 버전과의 충돌을 방지할 수 있습니다.

##### <span style="color:NAVY">**Cordova v7 지원**</span>

iFix *8.0.0.0-MFPF-IF20170608-0406*부터 Cordova v7이 지원됩니다. 지원되는 개별 플랫폼 버전에 대한 세부사항은 [Cordova 애플리케이션에 MobileFirst Foundation SDK 추가](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/)를 참조하십시오.

##### <span style="color:NAVY">**다중 인증서 고정 지원**</span>

iFix(*8.0.0.0-MFPF-IF20170624-0159*)부터 Mobile Foundation은 다중 인증서 고정을 지원합니다. 이 iFix 이전에는 Mobile Foundation에서 단일 인증서 고정을 지원했습니다. Mobile Foundation은 사용자가 다중 X509 인증서의 공개 키를 클라이언트 애플리케이션에 고정할 수 있게 허용함으로써 다중 호스트에 연결할 수 있도록 하는 새 API를 도입했습니다. 이 기능은 네이티브 Android 및 iOS 앱에 대해서만 지원됩니다. *MobileFirst API의 새로운 기능* 절 아래의 [새로운 기능](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/)에서 *다중 인증서 고정 지원*에 대해 자세히 알아보십시오.

##### <span style="color:NAVY">**코그너티브 앱을 빌드하기 위한 어댑터**</span>

iFix(*8.0.0.0-MFPF-IF20170710-1834*)부터 Mobile Foundation은 [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter) 및 [*WatsonNLU(Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)와 같은 Watson 코그너티브 서비스를 위한 사전 빌드된 어댑터를 도입했습니다. 이 어댑터는 Mobile Foundation 콘솔의 *Download Center*에서 다운로드하여 배치할 수 있습니다.

##### <span style="color:NAVY">**서버리스 앱을 빌드하기 위한 Cloud Functions 어댑터**</span>

iFix(*8.0.0.0-MFPF-IF20170710-1834*)부터 Mobile Foundation은 [Cloud Functions 플랫폼](https://console.bluemix.net/openwhisk/)을 위한 [*Cloud Functions 어댑터*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter)라는 사전 빌드된 어댑터를 도입했습니다. 이 어댑터는 Mobile Foundation 콘솔의 *Download Center*에서 다운로드하여 배치할 수 있습니다.

##### <span style="color:NAVY">**Cordova SDK에서 다중 인증서 고정 지원**</span>

iFix(*8.0.0.0-MFPF-IF20170803-1112*)부터 Cordova SDK에서 다중 인증서 고정이 지원됩니다. *MobileFirst API의 새로운 기능* 절 아래의 [새로운 기능](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/)에서 *다중 인증서 고정 지원*에 대해 자세히 알아보십시오.

##### <span style="color:NAVY">**Cordova 브라우저 플랫폼 지원**</span>

iFix(*8.0.0.0-MFPF-IF20170823-1236*)부터 {{ site.data.keys.product }}에서는 지원되는 이전의 Cordova Windows, Cordova Android 및 Cordova iOS 플랫폼과 함께 Cordova 브라우저 플랫폼을 지원합니다. [자세히 보기](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**해당 OpenAPI 스펙에서 어댑터 생성**</span>

iFix(*8.0.0.0-MFPF-IF20170901-1903*)부터 {{ site.data.keys.product }}에서는 해당 OpenAPI 스펙에서 어댑터를 자동으로 생성하는 기능을 도입했습니다. {{ site.data.keys.product }} 사용자는 이제 원하는 백엔드 서비스에 애플리케이션을 연결하는 {{ site.data.keys.product }} 어댑터를 작성하는 대신 애플리케이션 로직에 집중할 수 있습니다. [자세히 보기]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**iOS 11 및 iPhone X 지원**</span>

CD 업데이트 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*부터 Mobile Foundation은 Mobile Foundation v8.0에서의 iOS 11 및 iPhone X 지원을 발표했습니다. 자세한 내용은 블로그 게시물 [IBM MobileFirst Platform Foundation iOS 11 및 iPhone X 지원](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/)을 참조하십시오.

##### **<span style="color:NAVY">Android Oreo 지원</span>**

CD 업데이트 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*부터 Mobile Foundation은 이 [블로그 게시물](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/)을 통해 Android Oreo에 대한 지원을 발표했습니다. 이전 버전의 Android에 빌드된 네이티브 Android 앱 및 하이브리드/Cordova 앱은 Android Oreo가 OTA를 통해 업그레이드되는 경우 모두 해당 디바이스에서 예상대로 작동합니다.

##### <span style="color:NAVY">**이제 Mobile Foundation을 Kubernetes 클러스터에 배치할 수 있음**</span>

CD 업데이트 *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*부터 Mobile Foundation 사용자는 이제 Mobile Foundation(Mobile Foundation 서버, Mobile Analytics 서버 및 Application Center 포함)을 Kubernetes 클러스터에 배치할 수 있습니다. 배치 패키지가 Kubernetes 배치를 지원하도록 업데이트되었습니다. [공지사항](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/)을 읽으십시오.
