---
layout: tutorial
title: 기존 Windows 애플리케이션 마이그레이션
breadcrumb_title: Windows
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM MobileFirst™ Platform Foundation 버전 6.2.0 이상으로 작성된 기존의 네이티브 Windows 프로젝트를 마이그레이션하려면 현재 버전에서 SDK를 사용하도록 프로젝트를 수정해야 합니다. 그런 다음 V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오. 마이그레이션 지원 도구는 코드를 스캔하고 대체할 API의 보고서를 생성할 수 있습니다.

#### 다음으로 이동
{: #jump-to }
* [버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 네이티브 Windows 앱 스캔](#scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade)
* [Windows 프로젝트 마이그레이션](#migrating-a-windows-project)
* [Windows 코드 업데이트](#updating-the-windows-code)

## 버전 업그레이드 준비를 위해 기존 {{ site.data.keys.product_adj }} 네이티브 Windows 앱 스캔
{: #scanning-existing-mobilefirst-native-windows-apps-to-prepare-for-a-version-upgrade }
마이그레이션 지원 도구는 네이티브 Windows 앱의 소스를 스캔하고 V8.0에서 더 이상 사용되지 않거나 중단된 API의 보고서를 생성하여 마이그레이션을 위해 IBM MobileFirst™ Platform Foundation의 이전 버전으로 작성된 앱을 준비하도록 도와줍니다.

마이그레이션 지원 도구를 사용하기 전에 다음 정보를 파악하는 것이 중요합니다.

* 기존 IBM MobileFirst Platform Foundation 네이티브 Windows 애플리케이션이 있어야 합니다.
* 인터넷에 액세스할 수 있어야 합니다.
* node.js 버전 4.0.0 이상이 설치되어 있어야 합니다.
* 마이그레이션 프로세스의 제한사항을 검토하고 숙지하십시오. 자세한 정보는 [이전 릴리스에서 앱 마이그레이션](../)을 참조하십시오.

IBM MobileFirst Platform Foundation의 이전 버전으로 작성된 앱은 몇 가지를 변경하지 않으면 V8.0에서 지원되지 않습니다. 마이그레이션 지원 도구는 기존 Windows 앱에서 소스 파일을 스캔하여 프로세스를 단순화하고, V8.0에서 더 이상 사용되지 않거나 더 이상 지원되지 않거나 수정된 API를 식별합니다.

마이그레이션 지원 도구는 앱의 주석 또는 개발자 코드를 수정하거나 이동하지 않습니다.

1. 다음 방법 중 하나를 사용하여 마이그레이션 지원 도구를 다운로드하십시오.
    * [Git 저장소](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli)에서 .tgz 파일을 다운로드하십시오.
    * {{ site.data.keys.mf_console }}에서 마이그레이션 지원 도구를 포함하는 {{ site.data.keys.mf_dev_kit }}을 mfpmigrate-cli.tgz라는 파일로 다운로드하십시오.
2. 마이그레이션 지원 도구를 설치하십시오.
    * 도구를 다운로드한 디렉토리로 변경하십시오.
    * 다음 명령을 입력하여 NPM을 사용하여 도구를 설치하십시오.

   ```bash
   npm install -g
   ```

3. 다음 명령을 입력하여 IBM MobileFirst Platform Foundation 앱을 스캔하십시오.

   ```bash
   mfpmigrate scan --in source_directory --out destination_directory --type windows
   ```

   **source_directory**  
   프로젝트의 현재 위치입니다.

   **destination_directory**  
   보고서가 작성된 디렉토리입니다.

   스캔 명령과 함께 사용될 때 마이그레이션 지원 도구는 V8.0에서 제거되었거나 더 이상 사용되지 않거나 변경된 API를 기존 IBM MobileFirst Platform Foundation 앱에서 식별하여 식별된 대상 디렉토리에 저장합니다.

## Windows 프로젝트 마이그레이션
{: #migrating-a-windows-project }
IBM MobileFirst™ Platform Foundation V6.2.0 이상으로 작성된 기존 네이티브 Windows 프로젝트에 대해 작업하려면 프로젝트를 수정해야 합니다.

MobileFirst V8.0은 Windows Universal 환경, 즉 Windows 10 Universal Windows Platform(UWP) 및 Windows 8 Universal(Desktop 및 Phone)만 지원합니다. Windows Phone 8 Silverlight는 지원되지 않습니다.

Visual Studio 프로젝트를 수동으로 V8.0으로 업그레이드할 수 있습니다. {{ site.data.keys.product_adj }} V8.0은 이전 버전에서 개발된 앱을 변경해야 하는 많은 Visual Studio SDK 변경사항을 소개합니다. 변경된 API에 대한 정보는 [Windows 코드 업데이트](#updating-the-windows-code)를 참조하십시오.

1. {{ site.data.keys.product_adj }} SDK를 V8.0으로 업데이트하십시오.
    * MobileFirst SDK 패키지를 수동으로 제거하십시오. 여기에는 다음 참조 외에도 **wlclient.properties** 파일이 포함됩니다.
        * Newtonsoft.Json
        * SharpCompress
        * worklight-windows8

        > **참고:** 앱이 애플리케이션 인증 또는 확장된 인증 기능을 사용하는 경우, Microsoft Visual C++ 2013 Runtime Package for Windows 또는 Microsoft Visual C++ 2013 Runtime Package for Windows Phone을 앱에 대한 참조로 추가해야 합니다. 이를 수행하려면 Visual Studio에서 네이티브 프로젝트의 참조를 마우스 오른쪽 단추로 클릭한 후 네이티브 API 앱에 추가한 환경에 따라 다음 선택사항 중 하나를 완료하십시오.

        * Windows 데스크탑 또는 태블릿의 경우: **참조 → 참조 추가 → Windows 8.1 → 확장기능 → Microsoft Visual C++ 2013 Runtime Package for Windows → 확인**을 마우스 오른쪽 단추로 클릭하십시오.
        * Windows Phone 8 Universal의 경우: **참조 → 참조 추가 → Windows 8.1 → 확장기능 → Microsoft Visual C++ 2013 Runtime Package for Windows Phone → 확인**을 마우스 오른쪽 단추로 클릭하십시오.
        * Windows 10 Universal Windows Platform(UWP)의 경우: **참조 → 참조 추가 → Windows 8.1 → 확장기능 → Microsoft Visual C++ 2013 Runtime Package for Windows Universal → 확인**을 마우스 오른쪽 단추로 클릭하십시오.
    * NuGet을 통해 {{ site.data.keys.product_adj }} V8.0.0 SDK 패키지를 추가하십시오. [NuGet을 사용하여 {{ site.data.keys.product_adj }} SDK 추가](../../../application-development/sdk/windows-8-10)를 참조하십시오.
2. {{ site.data.keys.product_adj }} V8.0.0 API를 사용하도록 애플리케이션 코드 업데이트
    * 이전 릴리스의 경우 Windows API는 **IBM.Worklight.namespace**에 포함되어 있었습니다. 이러한 API는 이제 사용되지 않고 동등한 **WorklightNamespace** API로 대체되었습니다. 앱을 수정하여 **IBM.Worklight.namespace**에 대한 모든 참조를 **WorklightNamespace**의 동등한 해당 사항으로 대체해야 합니다.

   예를 들어, 다음과 같은 스니펫을 사용할 수 있습니다.

   ```csharp
   WLResourceRequest request = new WLResourceRequest
                            (new Uri(uriBuilder.ToString()), "GET", "accessRestricted");
                            request.send(listener);
   ```

   이 스니펫을 새 API로 업데이트하면 다음과 같습니다.

   ```csharp
   WorklightResourceRequest request = newClient.ResourceRequest
                            (new Uri(uriBuilder.ToString(), UriKind.Relative), "GET", "accessRestricted");
                            WorklightResponse response = await request.Send();
   ```

    * 비동기 조작을 수행한 모든 메소드에서는 이전에 응답 리스너 콜백 모델을 사용했습니다. 이는 **await/async** 모델로 대체되었습니다.

이제 {{ site.data.keys.product_adj }} SDK를 사용하여 네이티브 Windows 애플리케이션 개발을 시작할 수 있습니다. {{ site.data.keys.product_adj }} V8.0.0 API에 대한 변경사항을 반영하도록 코드를 업데이트해야 할 수도 있습니다.

#### 다음에 수행할 작업
{: #what-to-do-next }
V8.0에서 중단되거나 중단되지 않은 클라이언트 측 API를 대체하십시오.

## Windows 코드 업데이트
{: #updating-the-windows-code }
{{ site.data.keys.product }} V8.0은 이전 버전에서 개발된 앱을 변경해야 하는 많은 Windows SDK 변경사항을 소개합니다.

#### 더 이상 사용되지 않는 Windows C# API 클래스
{: #deprecated-windows-c-api-classes }

|카테고리 |설명 |권장 조치 |
|----------|-------------|--------------------|
|`ChallengeHandler`  |사용자 정의 게이트웨이 인증 확인의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler`, `isCustomResponse()`  |`GatewayChallengeHandler.canHandleResponse().`를 사용하십시오. |
|`ChallengeHandler.submitAdapterAuthentication` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler.submitFailure(WLResponse wlResponse)` 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler.Shouldcancel()`을 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 `SecurityCheckChallengeHandler.ShouldCancel()`을 사용하십시오. |
|`WLAuthorizationManager` |대신 `WorklightClient.WorklightAuthorizationManager`를 사용하십시오. |
|`WLChallengeHandler` |`SecurityCheckChallengeHandler`를 사용하십시오.  |
|`WLChallengeHandler.submitFailure(WLResponse wlResponse)`  | 	`SecurityCheckChallengeHandler.ShouldCancel()`을 사용하십시오. |
|`WLClient` | 	대신 `WorklightClient`를 사용하십시오. |
|`WLErrorCode` | 	지원되지 않음. |
|`WLFailResponse` | 	대신 `WorklightResponse`를 사용하십시오. |
|`WLResponse` |대신 `WorklightResponse`를 사용하십시오. |
|`WLProcedureInvocationData` |대신 `WorklightProcedureInvocationData`를 사용하십시오. |
|`WLProcedureInvocationFailResponse` | 	지원되지 않음. |
|`WLProcedureInvocationResult` | 	지원되지 않음. |
|`WLRequestOptions` | 	지원되지 않음. |
|`WLResourceRequest` | 	대신 `WorklightResourceRequest`를 사용하십시오. |

#### 더 이상 사용되지 않는 Windows C# API 인터페이스
{: #deprecated-windows-c-api-interfaces }

|카테고리 |설명 |권장 조치 |
|----------|-------------|--------------------|
|`WLHttpResponseListener` |지원되지 않음. |
|`WLResponseListener` |응답은 `WorklightResponse` 오브젝트로 사용 가능합니다. |
|`WLAuthorizationPersistencePolicy` |지원되지 않음. |
