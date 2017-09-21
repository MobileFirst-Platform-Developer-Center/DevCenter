---
layout: tutorial
title: 기존 iOS 애플리케이션 마이그레이션
breadcrumb_title: iOS
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM MobileFirst™ Platform Foundation 버전 6.2.0 이상으로 작성된 기존의 고유 iOS 프로젝트를 마이그레이션하려면 현재 버전에서 SDK를 사용하도록 프로젝트를 수정해야 합니다. 그런 다음 V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 마이그레이션 지원 도구는 코드를 스캔하고 대체할 API의 보고서를 생성할 수 있습니다. 

#### 다음으로 이동
{: #jump-to }
* [버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 고유 iOS 앱 스캔](#scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade)
* [기존 iOS 프로젝트를 수동으로 마이그레이션](#migrating-an-existing-ios-project-manually)
* [CocoaPods를 사용하여 기존 원시 iOS 프로젝트를 마이그레이션](#migrating-an-existing-native-ios-project-with-cocoapods)
* [iOS에서 암호화 마이그레이션](#migrating-encryption-in-ios)
* [iOS 코드 업데이트](#updating-the-ios-code)

## 버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 고유 iOS 앱 스캔
{: #scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade }
마이그레이션 지원 도구는 Swift 또는 Objective-C를 사용하여 개발된 고유 iOS 앱의 소스를 스캔하고 V8.0에서 더 이상 사용되지 않거나 중단된 API의 보고서를 생성하여 마이그레이션을 위해 IBM MobileFirst™ Platform Foundation의 이전 버전으로 작성된 앱을 준비하도록 도와줍니다. 

마이그레이션 지원 도구를 사용하기 전에 다음 정보를 파악하는 것이 중요합니다. 

* 기존 IBM MobileFirst Platform Foundation 고유 iOS 애플리케이션이 있어야 합니다. 
* 인터넷에 액세스할 수 있어야 합니다. 
* node.js 버전 4.0.0 이상이 설치되어 있어야 합니다. 
* 마이그레이션 프로세스의 제한사항을 검토하고 숙지하십시오. 자세한 정보는 [이전 릴리스에서 앱 마이그레이션](../)을 참조하십시오. 

IBM MobileFirst Platform Foundation의 이전 버전으로 작성된 앱은 몇 가지를 변경하지 않으면 {{ site.data.keys.product }} 8.0에서 지원되지 않습니다. 마이그레이션 지원 도구는 기존 버전 앱에서 소스 파일을 스캔하여 프로세스를 단순화하고, V8.0에서 더 이상 사용되지 않거나 더 이상 지원되지 않거나 수정된 API를 식별합니다. 

마이그레이션 지원 도구는 앱의 주석 또는 개발자 코드를 수정하거나 이동하지 않습니다. 

1. 다음 방법 중 하나를 사용하여 마이그레이션 지원 도구를 다운로드하십시오. 
    * [Git 저장소](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)에서 .tgz 파일을 다운로드하십시오. 
    * {{ site.data.keys.mf_console }}에서 마이그레이션 지원 도구를 포함하는 {{ site.data.keys.mf_dev_kit }}을 **mfpmigrate-cli.tgz**라는 파일로 다운로드하십시오. 
2. 마이그레이션 지원 도구를 설치하십시오. 
    * 도구를 다운로드한 디렉토리로 변경하십시오. 
    * 다음 명령을 입력하여 NPM을 사용하여 도구를 설치하십시오. 

   ```bash
   npm install -g
   ```

3. 다음 명령을 입력하여 IBM MobileFirst Platform Foundation 앱을 스캔하십시오. 

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type ios
   ```

    **source_directory**  
    버전 프로젝트의 현재 위치입니다. 

    **destination_directory**  
   보고서가 작성된 디렉토리입니다.   
    <br/>
   스캔 명령과 함께 사용될 때 마이그레이션 지원 도구는 V8.0에서 제거되었거나 더 이상 사용되지 않거나 변경된 API를 기존 IBM MobileFirst Platform Foundation 앱에서 식별하여 식별된 대상 디렉토리에 저장합니다. 

## 기존 iOS 프로젝트를 수동으로 마이그레이션
{: #migrating-an-existing-ios-project-manually }
Xcode 프로젝트 내에서 수동으로 기존 원시 iOS 프로젝트를 마이그레이션하고 {{ site.data.keys.product }} V8.0으로 계속 개발하십시오. 

시작하기 전에 다음 조건을 충족해야 합니다. 

* Xcode 7.0(iOS 9) 이상에서 작업 중이어야 합니다. 
* IBM MobileFirst Platform Foundation 6.2.0 이상으로 작성된 기존의 고유 iOS 프로젝트가 있어야 합니다. 
* V8.0.0 {{ site.data.keys.product_adj }} iOS SDK 파일의 사본에 대한 액세스 권한이 있어야 합니다. 

1. **빌드 단계** 섹션의 **라이브러리가 포함된 2진 링크** 탭에서 정적 라이브러리 **libWorklightStaticLibProjectNative.a**에 대한 모든 참조를 삭제하십시오. 
2. **WorklightAPI** 폴더에서 Headers 폴더를 삭제하십시오. 
3. **빌드 단계** 섹션의 **라이브러리가 포함된 2진 링크** 탭에서 기본 필수 프레임워크 **IBMMobileFirstPlatformFoundation.framework** 파일에 링크하십시오. 

    이 프레임워크에서는 코어 {{ site.data.keys.product_adj }} 기능이 제공됩니다. 마찬가지로, [선택적 기능을 위한 기타 프레임워크](../../../application-development/sdk/ios/#manually-adding-the-mobilefirst-native-sdk)를 추가할 수 있습니다. 

4. 이전 단계와 마찬가지로 **빌드 단계** 탭의 **라이브러리가 포함된 2진 링크** 섹션에서 프로젝트에 다음 자원을 링크하십시오. 
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * Security.framework
    * 참고: 일부 프레임워크는 이미 링크되었을 수 있습니다. 
        * libstdc++.6.tbd
        * libz.tbd
        * libc++.tbd
5. 헤더 검색 경로에서 **$(SRCROOT)/WorklightAPI/include**를 제거하십시오. 
6. 헤더의 모든 기존 {{ site.data.keys.product_adj }} 가져오기를 다음 새 우산형 헤더의 단일 항목으로 바꾸십시오. 
    * Objective-C:

      ```objc
      #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
      ```
    * Swift:

      ```swift
      import IBMMobileFirstPlatformFoundation
      ```

애플리케이션은 이제 {{ site.data.keys.product }}, V8.0 iOS SDK에 대해 작동하도록 업그레이드됩니다. 

#### 다음에 수행할 작업
{: #what-to-do-next }
V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 

## CocoaPods를 사용하여 기존 원시 iOS 프로젝트를 마이그레이션
{: #migrating-an-existing-native-ios-project-with-cocoapods }
CocoaPods를 사용하고 프로젝트 구성을 변경하여 {{ site.data.keys.product }} iOS SDK를 가져옴으로써 V8.0에 대해 작동하도록 기존 고유 iOS 프로젝트를 마이그레이션하십시오. 

> **참고:** {{ site.data.keys.product_adj }} 개발은 iOS 8.0 이상을 사용하여 버전 7.1의 Xcode에서 지원됩니다. 

다음이 있어야 합니다. 

* 개발 환경에 설치된 CocoaPods
* 개발 환경에 대한 iOS 8.0 이상이 포함된 Xcode 7.1
* MobileFirst 6.2 이상과 통합된 앱

SDK에는 필수 및 선택적 SDK가 포함됩니다. 각 필수 또는 선택적 SDK에는 고유 POD가 있습니다.   
필수 IBMMobileFirstPlatformFoundation POD는 시스템의 코어입니다. 이는 클라이언트-서버 연결을 구현하고 보안, 분석 및 애플리케이션 관리를 처리합니다. 

다음 선택적 POD에서는 추가 기능을 제공합니다. 

| POD| 기능|
|-----|---------|
|                                                     IBMMobileFirstPlatformFoundationPush| 푸시를 사용하는 데 필요한 IBMMobileFirstPlatformFoundationPush 프레임워크를 추가합니다. |
|                                                     IBMMobileFirstPlatformFoundationJSONStore| JSONStore 기능을 구현합니다. 앱에서 JSONStore 기능을 사용하려면 Podfile에 이 POD를 포함시키십시오. |
| IBMMobileFirstPlatformFoundationOpenSSLUtils| {{ site.data.keys.product_adj }} 임베디드 OpenSSL 기능을 포함하고 openssl 프레임워크를 자동으로 로드합니다. {{ site.data.keys.product_adj }}에서 제공되는 OpenSSL을 사용하려면 Podfile에 이 POD를 포함시키십시오. |

1. Xcode에서 프로젝트를 여십시오. 
2. Xcode 프로젝트에서 **WorklightAPI** 폴더를 삭제(휴지통으로 이동)하십시오. 
3. 다음 방법으로 기존 코드를 수정하십시오. 
    * 헤더 검색 경로에서 **$(SRCROOT)/WorklightAPI/include**를 제거하십시오. 
    * 프레임워크 검색 경로에서 **$(PROJECTDIR)/WorklightAPI/frameworks**를 제거하십시오. 
    * 정적 **librarylibWorklightStaticLibProjectNative.a**에 대한 참조를 제거하십시오. 
4. **빌드 단계** 탭에서 다음 프레임워크 및 라이브러리에 대한 링크를 제거하십시오(해당 항목은 CocoaPods에서 자동으로 다시 추가됨). 
    * libWorklightStaticLibProjectNative.a
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * CoreData.framework
    * CoreLocation.framework
    * Security.framework
    * sqlcipher.framework
    * libstdc++.6.dylib
    * libz.dylib
5. Xcode를 닫으십시오. 
6. CocoaPods에서 {{ site.data.keys.product_adj }} iOS SDK를 가져오십시오. SDK를 가져오려면 다음 단계를 완료하십시오. 
    * 새 Xcode 프로젝트의 위치에서 **터미널**을 여십시오. 
    * `pod init ` 명령을 실행하여 **Podfile** 파일을 작성하십시오. 
    * 텍스트 편집기로 프로젝트의 루트에 있는 Podfile 파일을 여십시오. 
    * 기존 컨텐츠를 주석 처리하거나 제거하십시오. 
    * 다음 행을 추가하고 iOS 버전을 포함하여 변경사항을 저장하십시오. 

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      ```

    * 앱에서 해당 POD가 제공하는 추가 기능을 사용해야 하는 경우 위 목록에서 파일에 추가 POD를 지정하십시오. 예를 들어, 앱에서 OpenSSL을 사용하는 경우 **Podfile**은 다음과 같습니다. 

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationOpenSSLUtils'
      ```

      > **참고:** 위의 구문은 **IBMMobileFirstPlatformFoundation** POD의 최신 버전을 가져옵니다. 최신 버전의 {{ site.data.keys.product_adj }}를 사용 중이 아닌 경우, 주 버전 번호, 부 버전 번호 및 패치 번호를 포함하여 전체 버전 번호를 추가해야 합니다. 패치 번호의 형식은 YYYYMMDDHH입니다. 예를 들어, **IBMMobileFirstPlatformFoundation** POD의 특정 패치 버전 8.0.2016021411을 가져오기 위한 행은 다음과 같습니다.

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '8.0.2016021411'
      ```

      또는 부 버전 번호의 마지막 패치를 가져오는 경우 구문은 다음과 같습니다. 

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '~>8.0.0'
      ```

    * Xcode 프로젝트의 처리가 완료되었는지 확인하십시오. 
    * `pod install` 명령을 실행하십시오. 

    이 명령은 {{ site.data.keys.product_adj }} SDK **IBMMobileFirstPlatformFoundation.framework** 및 Podfile 및 해당 종속 항목에서 지정되는 기타 프레임워크를 설치합니다. 그런 다음 pods 프로젝트를 생성하고 클라이언트 프로젝트를 {{ site.data.keys.product_adj }} SDK와 통합합니다.
7. 명령행에서 open **ProjectName.xcworkspace**를 입력하여 Xcode에서 **ProjectName.xcworkspace** 파일을 여십시오. 이 파일은 **ProjectName.xcodeproj** 파일과 동일한 디렉토리에 있습니다. 
8. 헤더의 모든 기존 {{ site.data.keys.product_adj }} 가져오기를 다음 새 우산형 헤더의 단일 항목으로 바꾸십시오. 

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundation
   ```

   Push 또는 JSONStore를 사용하는 경우 독립적 가져오기를 포함해야 합니다. 

   #### Push
   {: #push }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationPush/IBMMobileFirstPlatformFoundationPush.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationPush
   ```

   ##### JSONStore
   {: #jsonstore }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationJSONStore
   ```

9. **빌드 설정** 탭의 **기타 링커 플래그** 아래에서 `-ObjC` 플래그의 시작 부분에 `$(inherited)`를 추가하십시오. 예: 

    ![Xcode 빌드 설정에서 ObjC 플래그에 $(inherited) 추가](add_inherited_to_ObjC.jpg)

10. Xcode 7부터는 TLS가 적용됩니다. iOS 앱에서 TLS 보안 연결 적용을 참조하십시오.   

<br/>
애플리케이션은 이제 {{ site.data.keys.product }}, V8.0 iOS SDK에 대해 작동하도록 업그레이드됩니다.

#### 다음에 수행할 작업
{: #what-next }
V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 

## iOS에서 암호화 마이그레이션
{: #migrating-encryption-in-ios }
iOS 애플리케이션이 OpenSSL 암호화를 사용한 경우, 앱을 새 V8.0 고유 암호화로 마이그레이션할 수 있습니다. 또한 OpenSSL을 계속 사용하려면 일부 추가적인 프레임워크를 설치해야 합니다. 

마이그레이션을 위한 iOS 암호화 옵션에 대한 자세한 정보는 [iOS에 대해 OpenSSL 사용](../../../application-development/sdk/ios/additional-information/#enabling-openssl-for-ios)을 참조하십시오. 

## iOS 코드 업데이트
{: #updating-the-ios-code }
iOS 프레임워크를 업데이트하고 필요한 구성 변경사항을 작성한 후 여러 문제가 특정 애플리케이션 코드와 관련될 수 있습니다.   
iOS API 변경사항을 아래 표에 나열했습니다. 

| API 요소| 마이그레이션 경로|
|-------------|----------------|
| {::nomarkdown}<ul><li><code>[WLClient getWLDevice][WLClient transmitEvent:]</code></li><li><code>[WLClient setEventTransmissionPolicy]</code></li><li><code>[WLClient purgeEventTransmissionBuffer]</code></li></ul>{:/} | 위치정보가 제거되었습니다. 위치정보에 대한 기본 iOS 또는 써드파티 패키지를 사용하십시오. |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | 대체 없음. |
| `WL.Client.deleteUserPref(key, options)` | 대체 없음. 어댑터와 [`MFP.Server.getAuthenticatedUser`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser:) API를 사용하여 사용자 환경 설정을 관리할 수 있습니다. |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)를 사용하십시오. |
| `[WLClient login:withDelegate:]` | [`WLAuthorizationManager login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/login:withCredentials:withCompletionHandler:)을 사용하십시오. |
| `[WLClient logout:withDelegate:]` | [`WLAuthorizationManager logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/logout:withCompletionHandler:)을 사용하십시오. |
| {::nomarkdown}<ul><li><code>[WLClient lastAccessToken]</code></li><li><code>[WLClient lastAccessTokenForScope:]</code></li></ul>{:/} | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)를 사용하십시오. |
| {::nomarkdown}<ul><li><code>[WLClient obtainAccessTokenForScope:withDelegate:]</code></li><li><code>[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]</code></li></ul>{:/} | [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:)를 사용하십시오. |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | IBMMobileFirstPlatformFoundationPush 프레임워크에서 [Objective-C client-side push API for iOS apps](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps)를 사용하십시오. |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | IBMMobileFirstPlatformFoundationPush 프레임워크에서 [Objective-C client-side push API for iOS apps](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps)를 사용하십시오. |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | 더 이상 사용하지 않습니다. 대신 [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:)를 사용하십시오. |
| `[WLClient sendUrlRequest:delegate:]` | 대신 [`[WLResourceRequest sendWithDelegate:delegate]`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:)를 사용하십시오.|
| `[WLClient (void) logActivity:(NSString *) activityType]`	| 제거되었습니다. Objective C 로거를 사용하십시오. |
| {::nomarkdown}<ul><li><code>[WLSimpleDataSharing setSharedToken: myName value: myValue]</code></li><li><code>[WLSimpleDataSharing getSharedToken: myName]]</code></li><li><code>[WLSimpleDataSharing clearSharedToken: myName]</code></li></ul>{:/} | 애플리케이션 사이에서 토큰을 공유하려면 OS API를 사용하십시오. |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/BaseChallengeHandler.html?view=kc)을 사용하십시오. |
| `BaseProvisioningChallengeHandler` | 대체 없음. 디바이스 프로비저닝은 이제 보안 프레임워크에서 자동으로 처리됩니다. |
| `ChallengeHandler` | 사용자 정의 게이트웨이 인증 확인의 경우 [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. |
| `WLChallengeHandler` | [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. |
| `ChallengeHandler.isCustomResponse()` | [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc)를 사용하십시오. |
| `ChallengeHandler.submitAdapterAuthentication` | 인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc)를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc)를 사용하십시오. |
