---
layout: tutorial
title: 더 이상 사용되지 않는 중단된 기능 및 API
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
제거된 기능 및 API 요소가 {{ site.data.keys.product_full }} 환경에 영향을 미치는 방식을 주의해서 고려하십시오.

#### 다음으로 이동
{: #jump-to }
* [v8.0에 포함되지 않는 중단된 기능](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [서버 측 API 변경](#server-side-api-changes)
* [클라이언트 측 API 변경](#client-side-api-changes)

## v8.0에 포함되지 않는 중단된 기능
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }} v8.0은 이전 버전과 매우 단순하게 비교됩니다. 이 간소화의 결과로 v7.1에서 사용할 수 있는 일부 기능이 v8.0에서는 더 이상 사용되지 않습니다. 대부분의 경우 기능을 구현하는 대체 방법이 제안됩니다. 이러한 기능은 사용되지 않음으로 표시됩니다. V7.1에 존재하는 일부 기타 기능은 v8.0의 새 디자인의 결과로서가 아닌 v8.0에 있지 않습니다. v8.0에서 중단된 기능과 제외된 기능을 구별하려면 v8.0에 없는 것으로 표시됩니다.

<table class="table table-striped">
    <tr>
        <td>기능</td>
        <td>상태 및 대체 경로</td>
    </tr>
    <tr>
        <td><p>MobileFirst Studio는 Eclipse용 {{ site.data.keys.mf_studio }} 플러그인으로 대체됩니다.</p></td>
        <td><p>Eclipse용 {{ site.data.keys.mf_studio }} 플러그인으로 대체되고 표준 및 커뮤니티 기반 Eclipse 플러그인에 의해 제공됩니다. Visual Studio Code, Eclipse, IntelliJ 등과 같이 Apache Cordova CLI 또는 Cordova 사용 IDE로 직접 하이브리드 애플리케이션을 개발할 수 있습니다. Cordova 사용 IDE로 Eclipse를 사용하는 데 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">Eclipse에서 Cordova 프로젝트를 관리하기 위한 IBM {{ site.data.keys.mf_studio }} 플러그인</a>을 참조하십시오.</p>

        <p>Apache Maven 또는 maven 사용 IDE(예: Eclipse, IntelliJ 및 기타)로 어댑터를 개발할 수 있습니다. 어댑터 개발에 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">어댑터 카테고리</a>를 참조하십시오. Maven 사용 IDE로서 Eclipse 사용에 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">Eclipse에서 어댑터 개발 튜토리얼</a>을 읽어보십시오.</p>

        <p>{{ site.data.keys.mf_server }}로 어댑터 및 애플리케이션을 테스트하기 위해 {{ site.data.keys.mf_dev_kit_full }}를 설치하십시오. 또한 인터넷 기반 저장소(예: NPM, Maven, Cocoapod 또는 NuGet)에서 다운로드하지 않으려면 {{ site.data.keys.product_adj }} 개발 도구 및 SDK에 액세스할 수 있습니다. {{ site.data.keys.mf_dev_kit }}에 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>의 내용을 참조하십시오.</p>
        </td>
    </tr>
    <tr>
        <td><p>스킨, 쉘, 설정 페이지, 최소화 및 JavaScript UI 요소는 하이브리드 애플리케이션에서 더 이상 사용되지 않습니다.</p></td>
        <td><p>더 이상 사용되지 않습니다. 하이브리드 애플리케이션은 Apache Cordova를 사용하여 개발되었습니다. 스킨 교체, 쉘, 설정 페이지 및 최소화에 대한 자세한 정보는 제거된 컴포넌트 및 v8.0 대 v7.1 이하로 개발된 Cordova 앱의 비교를 참조하십시오.</p>
        </td>
    </tr>
    <tr>
        <td><p>Sencha Touch는 더 이상 하이브리드 애플리케이션을 위한 {{ site.data.keys.product_adj }} 프로젝트로 가져올 수 없습니다.</p></td>
        <td><p>더 이상 사용되지 않습니다. {{ site.data.keys.product_adj }} 하이브리드 애플리케이션은 Apache Cordova를 사용하여 개발되었고 {{ site.data.keys.product_adj }} 기능은 Cordova 플러그인으로 제공되었습니다. Sencha Touch 문서를 참조하여 Sencha Touch 및 Cordova를 통합하십시오.</p>
        </td>
    </tr>
    <tr>
        <td><p>암호화된 캐시는 더 이상 사용되지 않습니다.</p></td>
        <td><p>더 이상 사용되지 않습니다. 암호화된 데이터를 로컬로 저장하려면 JSONStore를 사용하십시오. JSONStore에 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">JSONStore 튜토리얼</a>을 참조하십시오.</p>
        </td>
    </tr>
    <tr>        
        <td><p>Direct Update On-Demand 트리거는 v8.0에 없습니다. 클라이언트 애플리케이션은 세션에 대한 OAuth 토큰을 얻을 때 직접 업데이트를 확인합니다. v8.0에서 다른 시점에 직접 업데이트를 검사하기 위해 클라이언트 애플리케이션을 프로그래밍할 수 없습니다.</p></td>
        <td><p>v8.0에 없습니다.</p></td>
    </tr>
    <tr>
        <td><p>세션 종속성 구성의 어댑터. V7.1.0의 경우 {{ site.data.keys.mf_server }}가 세션 비종속 모드(기본값) 또는 세션 종속 모드에서 작동하도록 구성할 수 있었습니다. v8.0부터는 세션 종속 모드가 더 이상 지원되지 않습니다. 서버는 기본적으로 HTTP 세션에 대해 비종속적이며 관련 구성이 필요하지 않습니다.</p></td>
        <td><p>더 이상 사용되지 않습니다.</p></td>
    </tr>
    <tr>
        <td><p>IBM WebSphere eXtreme Scale에 대한 속성 저장소는 v8.0에서 지원되지 않습니다.</p></td>
        <td><p>v8.0에 없습니다.</p></td>
    </tr>
    <tr>
        <td><p>IBM Business Process Manager(IBM BPM) 프로세스 애플리케이션에 대한 서비스 발견 및 어댑터 생성, Microsoft Azure Marketplace DataMarket, OData RESTful API, RESTful 리소스, SAP Netweaver Gateway에서 노출된 서비스 및 웹 서비스는 v8.0에 없습니다.</p></td>
        <td><p>v8.0에 없습니다.</p></td>
    </tr>
    <tr>
        <td>JMS JavaScript 어댑터는 v8.0에 없습니다.</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>SAP Gateway JavaScript 어댑터는 v8.0에 없습니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>SAP JCo JavaScript 어댑터는 v8.0에 없습니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>Cast Iron JavaScript 어댑터는 v8.0에 없습니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>OData 및 Microsoft Azure OData JavaScript 어댑터는 v8.0에 없습니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>USSD에 대한 푸시 알림 지원은 v8.0에서 지원되지 않습니다.	</td>
        <td>더 이상 사용되지 않습니다.</td>
    </tr>
    <tr>
        <td>이벤트 기반 푸시 알림은 v8.0에서 지원되지 않습니다.	</td>
        <td>더 이상 사용되지 않습니다. 푸시 알림 서비스를 사용하십시오. 푸시 알림 서비스로 마이그레이션하는 데 대한 자세한 정보는 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션 주제를 참조하십시오.</td>
    </tr>
    <tr>
      <td>
        보안: anti-XSRF(Anti-cross site request forgery) 영역(<code>wl_antiXSRFRealm</code>)은 V8.0에 필요하지 않습니다.
      </td>
      <td>
        V7.1.0에서는 인증 컨텍스트가 HTTP 세션에 저장되고 세션 쿠키에 의해 식별되며, 이는 교차 사이트 요청에서 브라우저에 의해 전송됩니다. 이 버전의 anti-XSRF 영역은 클라이언트에서 서버로 보내지는 추가 헤더를 사용하여 XSRF 공격에 대해 쿠키 전송을 보호하는 데 사용됩니다.
        <br />
        V8.0.0에서 보안 컨텍스트는 더 이상 HTTP 세션과 연관되지 않으며 세션 쿠키에 의해 식별되지 않습니다.
        대신 권한 부여는 권한 부여 헤더에서 전달된 OAuth 2.0 액세스 토큰을 사용하여 수행됩니다.
        권한 부여 헤더가 교차 사이트 요청에서 브라우저에 의해 보내지지 않으므로 XSRF 공격에 대해 보호할 필요가 없습니다.
      </td>
    </tr>
    <tr>
        <td>보안: 사용자 인증서 인증. v8.0에는 X.509 클라이언트 측 인증서로 사용자를 인증하기 위해 사전 정의된 보안 검사가 포함되지 않습니다.</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>보안: IBM Trusteer와 통합. v8.0에는 IBM Trusteer 위험 요인을 테스트하기 위해 사전 정의된 보안 검사 또는 인증 확인이 포함되지 않습니다.</td>
        <td>v8.0에 없습니다. IBM Trusteer Mobile SDK를 사용하십시오.</td>
    </tr>
    <tr>
        <td>보안: 디바이스 프로비저닝 및 디바이스 자동 프로비저닝.	</td>
        <td><p>더 이상 사용되지 않습니다.</p><p>참고: 디바이스 프로비저닝은 정상 권한 플로우에서 처리됩니다. 보안 플로우의 등록 프로세스 중에 디바이스 데이터를 자동으로 수집합니다. 보안 플로우에 대한 자세한 정보는 엔드 투 엔드 권한 플로우를 참조하십시오.</p>
        </td>
    </tr>
    <tr>
        <td>보안: Android 코드를 ProGuard로 난독 처리하기 위한 구성 파일. v8.0에는 MobileFirst Android 애플리케이션으로 Android ProGuard 혼동에 대해 사전 정의된 proguard-project.txt 구성 파일이 포함되지 않습니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>보안: 어댑터 기반 인증이 대체됩니다. 인증은 OAuth 프로토콜을 사용하고 보안 검사를 통해 구현됩니다.</td>
        <td>보안 검사 기반 구현에 의해 대체되었습니다.</td>
    </tr>
    <tr>
        <td><p>보안: LDAP 로그인. v8.0에는 LDAP 서버로 사용자를 인증하기 위해 사전 정의된 보안 검사가 포함되지 않습니다.</p>
        <p>대신 WebSphere Application Server 또는 WebSphere Application Server Liberty의 경우 LDAP 등의 Identity Provider를 LTPA에 맵핑하기 위해 애플리케이션 서버 또는 게이트웨이를 사용하고 LTPA 보안 검사를 사용하여 사용자에 대한 OAuth 토큰을 생성하십시오.</p></td>
        <td>v8.0에 없습니다. WebSphere Application Server 또는 WebSphere Application Server Liberty에 대한 LTPA 보안 검사에 의해 대체됩니다.</td>
    </tr>
    <tr>
        <td>
        HTTP 어댑터의 인증 구성입니다. 사전 정의된 HTTP 어댑터는 사용자의 원격 서버에 대한 연결을 지원하지 않습니다.</td>
        <td><p>v8.0에 없습니다.</p><p>HTTP 어댑터의 소스 코드를 편집하고 인증 코드를 추가하십시오. <code>MFP.Server.invokeHttp</code>를 사용하여 ID 토큰을 HTTP 요청의 헤더에 추가하십시오.</p></td>
    </tr>
    <tr>
        <td>
        MobileFirst 분석 콘솔로 MobileFirst 보안 프레임워크의 이벤트를 모니터하는 기능인 보안 분석은 v8.0에 없습니다.</td>
        <td>v.8.0에 없음</td>
    </tr>
    <tr>
        <td>푸시 알림에 대한 이벤트 소스 기반 모델이 더 이상 사용되지 않고 태그 기반 푸시 서비스 모델로 대체되었습니다.</td>
        <td>더 이상 사용되지 않고 태그 기반 푸시 서비스 모델로 대체되었습니다.</td>
    </tr>
    <tr>
        <td>USSD(Unstructured Supplementary Service Data) 지원은 v8.0에 없습니다.</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>Cloudant는 v8.0에서 지원되지 않는 것으로 {{ site.data.keys.mf_server }}에 대한 데이터베이스로 사용됩니다.	</td>
        <td>v8.0에 없습니다.</td>
    </tr>
    <tr>
        <td>위치정보: {{ site.data.keys.product }} v8.0에서는 위치정보 지원이 중단되었습니다. 비컨 및 중개자에 대한 REST API가 중단되었습니다. 클라이언트 측 및 서버 측 API WL.Geo와 WL.Device는 중단되었습니다.	</td>
        <td>더 이상 사용되지 않습니다. 위치 정보에 네이티브 디바이스 API 또는 서드파티 Cordova 플러그인을 사용하십시오.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.product_adj }} Data Proxy 기능이 중단되었습니다. Cloudant IMFData 및 CloudantToolkit API 또한 사용되지 않습니다.	</td>
        <td>더 이상 사용되지 않습니다. 사용자 앱에서 IMFData 및 CloudantToolkit API를 대체하는 데 대한 자세한 정보는 IMFData 또는 Cloudant SDK로 Cloudant에 모바일 데이터를 저장하는 앱 마이그레이션을 참조하십시오.</td>
    </tr>
    <tr>
        <td>IBM Tealeaf SDK는 더 이상 {{ site.data.keys.product }}으로 번들되지 않습니다.	</td>
        <td>더 이상 사용되지 않습니다. IBM Tealeaf SDK를 사용하십시오. 자세한 정보는 IBM Tealeaf Customer Experience 문서의 <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Android 애플리케이션의 Tealeaf 설치 및 구현</a> 및 <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS 로깅 프레임워크 설치 및 구현</a>의 내용을 참조하십시오.</td>
    </tr>
    <tr>
        <td>{{ site.data.keys.mf_test_workbench_full }}가 {{ site.data.keys.product }}으로 번들화되지 않았습니다.</td>
        <td>더 이상 사용되지 않습니다.</td>
    </tr>
    <tr>
        <td>BlackBerry, Adobe AIR, Windows Silverlight는 {{ site.data.keys.product }} v8.0에서 지원되지 않습니다. 해당 플랫폼에 대한 SDK가 제공되지 않습니다.	</td>
        <td>더 이상 사용되지 않습니다.</td>
    </tr>
</table>

## 서버 측 API 변경
{: #server-side-api-changes }
서버 측 {{ site.data.keys.product_adj }} 애플리케이션을 마이그레이션하려면 API 변경사항을 고려하십시오.  
다음 테이블에는 v8.0에서 중단된 서버 측 API 요소, v8.0에서 더 이상 사용되지 않는 서버 측 API 요소 및 제안된 마이그레이션 경로가 나열됩니다. 애플리케이션의 서버 측 마이그레이션에 대한 자세한 정보는 다음을 참조하십시오.

### v8.0에서 중단된 JavaScript API 요소
{: #javascript-api-elements-discontinued-v-v-80 }
#### 보안
{: #security }

|API 요소                         |대체 경로                               |
|------------------------------------|------------------------------------------------|
|`WL.Server.getActiveUser`, `WL.Server.getCurrentUserIdentity`,  `WL.Server.getCurrentDeviceIdentity`, `WL.Server.setActiveUser`, `WL.Server.getClientId`, `WL.Server.getClientDeviceContext`, `WL.Server.setApplicationContext` |대신 `MFP.Server.getAuthenticatedUser`를 사용하십시오. |

#### 이벤트 소스
{: #event-source }

|API 요소                         |대체 경로                               |
|------------------------------------|------------------------------------------------|
|`WL.Server.createEventSource`	     |대신 `MFP.Server.getAuthenticatedUser`를 사용하십시오. |
|`WL.Server.setEventHandlers`         |이벤트 소스 기반 알림에서 태그 기반 알림으로 마이그레이션하려면 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션을 참조하십시오.                                                     |
|`WL.Server.createEventHandler`       |                                                |
|`WL.Server.createSMSEventHandler`	 |SMS 메시지를 보내려면 푸시 서비스 REST API를 사용하십시오. 자세한 정보는 [알림 보내기](../../../notifications/sending-notifications)를 참조하십시오.                         |
|`WL.Server.createUSSDEventHandler`	 |서드파티 서비스를 사용하여 USSD을 통합하십시오.  |

#### 푸시
{: #push }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Server.getUserNotificationSubscription`, `WL.Server.notifyAllDevices`, `WL.Server.sendMessage`, `WL.Server.notifyDevice`, `WL.Server.notifyDeviceSubscription`, `WL.Server.notifyAll`, `WL.Server.createDefaultNotification`, `WL.Server.submitNotification` 	|이벤트 소스 기반 알림에서 태그 기반 알림으로 마이그레이션하려면 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션을 참조하십시오. |
|`WL.Server.subscribeSMS`	                |REST API Push Device Registration(POST)을 사용하여 디바이스를 등록하십시오. SMS 알림을 보내고 받으려면 API를 호출하는 중에 페이로드에서 phoneNumber를 제공하십시오.                               |
|`WL.Server.unsubscribeSMS`	                |REST API Push Device Registration(DELETE)을 사용하여 디바이스를 등록 취소하십시오. |
|`WL.Server.getSMSSubscription`	            |REST API Push Device Registration(GET)을 사용하여 디바이스 등록을 가져오십시오. |

#### 위치 서비스
{: #location-services }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Geo.*`	                                |서드파티 서비스를 사용하여 위치 정보 서비스를 통합하십시오. |

#### WS-Security
{: #ws-security }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`WL.Server.signSoapMessage`	                |WebSphere Application Server의 WS-Security 기능을 사용하십시오. |

### v8.0에서 연결이 끊긴 Java API 요소
{: #java-api-elements-discontinued-in-v-80 }
#### 보안
{: #security-java }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`SecurityAPI.getSecurityContext`	        |대신 AdapterSecurityContext를 사용하십시오.            |

#### 푸시
{: #push-java }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`PushAPI.sendMessage(INotification notification, String applicationId)`	|이벤트 소스 기반 알림에서 태그 기반 알림으로 마이그레이션하려면 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션을 참조하십시오. |
|`INotification PushAPI.buildNotification();` |이벤트 소스 기반 알림에서 태그 기반 알림으로 마이그레이션하려면 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션을 참조하십시오. |
|`UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` |이벤트 소스 기반 알림에서 태그 기반 알림으로 마이그레이션하려면 이벤트 소스 기반 알림에서 푸시 알림으로 마이그레이션을 참조하십시오. |

#### 어댑터
{: #adapters-java }

|API 요소                                |대체 경로                               |
|-------------------------------------------|------------------------------------------------|
|`com.worklight.adapters.rest.api` 패키지의 `AdaptersAPI` 인터페이스 |대신 `com.ibm.mfp.adapter.api` 패키지에서 `AdaptersAPI` 인터페이스를 사용하십시오. |
|`com.worklight.adapters.rest.api` 패키지의 `AnalyticsAPI` 인터페이스 |대신 `com.ibm.mfp.adapter.api` 패키지에서 `AnalyticsAPI` 인터페이스를 사용하십시오. |
|`com.worklight.adapters.rest.api` 패키지의 `ConfigurationAPI` 인터페이스 |대신 `com.ibm.mfp.adapter.api` 패키지에서 `ConfigurationAPI` 인터페이스를 사용하십시오. |
|`com.worklight.core.auth` 패키지의 `OAuthSecurity` 어노테이션 |대신 `com.ibm.mfp.adapter.api` 패키지에서 `OAuthSecurity` 어노테이션을 사용하십시오. |
|`com.worklight.wink.extensions` 패키지의 `MFPJAXRSApplication` 클래스 |대신 `com.ibm.mfp.adapter.api` 패키지에서 `MFPJAXRSApplication` 클래스를 사용하십시오. |
|`com.worklight.adapters.rest.api` 패키지의 `WLServerAPI` 인터페이스 |JAX-RS `Context` 어노테이션을 사용하여 {{ site.data.keys.product_adj }} API 인터페이스에 직접 액세스하십시오. |
|`com.worklight.adapters.rest.api` 패키지의 `WLServerAPIProvider` 클래스 |JAX-RS `Context` 어노테이션을 사용하여 {{ site.data.keys.product_adj }} API 인터페이스에 직접 액세스하십시오. |

## 클라이언트 측 API 변경
{: #client-side-api-changes }
다음 API의 변경사항은 {{ site.data.keys.product_adj }} 클라이언트 애플리케이션의 마이그레이션과 관련되어 있습니다.  
다음 테이블에는 V8.0.0에서 중단된 클라이언트 측 API 요소 및 제안된 마이그레이션 경로가 나열됩니다.

### JavaScript API
{: #javascript-apis }
사용자 인터페이스에 영향을 미치는 다음 JavaScript API는 v8.0에서 더 이상 지원되지 않습니다. 사용 가능한 서드파티 Cordova 플러그인으로 대체하거나 사용자 정의 Cordova 플러그인을 작성할 수 있습니다.

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WL.BusyIndicator`, `WL.OptionsMenu`, `WL.TabBar`, `WL.TabBarItem` |Cordova 플러그인 또는 HTML 5 요소를 사용하십시오. |
|`WL.App.close` |{{ site.data.keys.product_adj }} 외부에서 이 이벤트를 처리하십시오. |
|`WL.App.copyToClipboard()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. |
|`WL.App.openUrl(url, target, options)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 Cordova **InAppBrowser** 플러그인이 이 기능을 제공합니다. |
|`WL.App.overrideBackButton(callback)`, `WL.App.resetBackButton()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 Cordova **backbutton** 플러그인이 이 기능을 제공합니다. |
|`WL.App.getDeviceLanguage()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 Cordova **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.App.getDeviceLocale()` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 Cordova **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.App.BackgroundHandler` |사용자 정의 핸들러 함수를 실행하려면 표준 Cordova 일시정지 이벤트 리스너를 사용하십시오. 개인정보 보호를 제공하는 Cordova 플러그인을 사용하여 iOS 및 Android 시스템과 사용자의 스냅샷 또는 화면 캡처를 찍지 않게 하십시오. 자세한 정보는 **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**의 설명을 참조하십시오. |
|`WL.Client.close`, `WL.Client.restore`, `WL.Client.minimize` |{{ site.data.keys.product }} V8.0.0에서 지원되지 않는 Adobe AIR 플랫폼을 지원하기 위해 기능이 제공되었습니다. |
|`WL.Toast.show(string)` |Toast에 대한 Cordova 플러그인을 사용하십시오. |

이 API 세트는 v8.0에서 더 이상 지원되지 않습니다.

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WL.Client.checkForDirectUpdate(options)` |대체 없음. **참고:** 사용 가능한 업데이트가 있는 경우 직접 업데이트를 트리거하기 위해 `WLAuthorizationManager.obtainAccessToken`을 호출할 수 있습니다. 서버에서 직접 업데이트가 있는 경우 보안 토큰에 액세스하여 직접 업데이트를 트리거합니다. 그러나 직접 업데이트는 On-Demand로 트리거할 수 없습니다. |
|`WL.Client.setSharedToken({key: myName, value: myValue})`, `WL.Client.getSharedToken({key: myName})`, `WL.Client.clearSharedToken({key: myName})` |대체 없음. |
|`WL.Client.isConnected()`, `connectOnStartup` init option |`WLAuthorizationManager.obtainAccessToken`을 사용하여 서버에 대한 연결성을 검사하고 애플리케이션 관리 규칙을 적용하십시오. |
|`WL.Client.setUserPref(key,value, options)`, `WL.Client.setUserPrefs(userPrefsHash, options)`, `WL.Client.deleteUserPrefs(key, options)` |대체 없음. 어댑터 및 `MFP.Server.getAuthenticatedUser` API를 사용하여 사용자 환경 설정을 관리할 수 있습니다. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |대체 없음. |
|`WL.Client.logActivity(activityType)` |`WL.Logger`를 사용하십시오. |
|`WL.Client.login(realm, options)` |`WLAuthorizationManager.login`을 사용하십시오. 인증 및 보안을 시작하려면 인증 및 보안 튜토리얼을 참조하십시오. |
|`WL.Client.logout(realm, options)` |`WLAuthorizationManager.logout`을 사용하십시오. |
|`WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` |`WLAuthorizationManager.obtainAccessToken`을 사용하십시오. |
|`WL.Client.transmitEvent(event, immediate)`, `WL.Client.purgeEventTransmissionBuffer()`, `WL.Client.setEventTransmissionPolicy(policy)` |이러한 이벤트의 알림을 수신할 사용자 정의 어댑터를 작성하십시오. |
|`WL.Device.getContext()`, `WL.Device.startAcquisition(policy, triggers, onFailure)`, `WL.Device.stopAcquisition()`, `WL.Device.Wifi`, `WL.Device.Geo.Profiles`, `WL.Geo` |위치정보에 대한 네이티브 API 또는 서드파티 Cordova 플러그인을 사용하십시오. |
|`WL.Client.makeRequest (url, options)` |동일한 기능을 제공하는 사용자 정의 어댑터를 작성하십시오. |
|`WLDevice.getID(options)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 **cordova-plugin-device** 플러그인의 `device.uuid`가 이 기능을 제공합니다. |
|`WL.Device.getFriendlyName()` |`WL.Client.getDeviceDisplayName`을 사용하십시오. |
|`WL.Device.setFriendlyName()` |`WL.Client.setDeviceDisplayName`을 사용하십시오. |
|`WL.Device.getNetworkInfo(callback)` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 **cordova-plugin-network-information** 플러그인이 이 기능을 제공합니다. |
|`WLUtils.wlCheckReachability()` |사용자 정의 어댑터를 작성하여 서버 사용 가능성을 확인하십시오. |
|`WL.EncryptedCache` |JSONStore를 사용하여 암호화된 데이터를 로컬에 저장하십시오. JSONStore는 **cordova-plugin-mfp-jsonstore** 플러그인에 있습니다. 자세한 정보는 [JSONStore](../../../application-development/jsonstore)를 참조하십시오. |
|`WL.SecurityUtils.remoteRandomString(bytes)` |동일한 기능을 제공하는 사용자 정의 어댑터를 작성하십시오. |
|`WL.Client.getAppProperty(property)` |**cordova-plugin-appversion** 플러그인을 사용하여 앱 버전 특성을 검색할 수 있습니다. 리턴되는 버전은 네이티브 앱 버전입니다(Android 및 iOS만 해당). |
|`WL.Client.Push.*` |**cordova-plugin-mfp-push** 플러그인에서 JavaScript 클라이언트 측 푸시 API를 사용하십시오. |
|`WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` |푸시 및 SMS에 대한 디바이스를 등록하려면 `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`를 사용하십시오. |
|`WLAuthorizationManager.obtainAuthorizationHeader(scope)` |필요한 범위에 대한 토큰을 얻으려면 `WLAuthorizationManager.obtainAccessToken`을 사용하십시오. |
|`WLClient.getLastAccessToken(scope)` |Use `WLAuthorizationManager.obtainAccessToken` |
|`WLClient.getLoginName()`, `WL.Client.getUserName(realm)` |대체 없음. |
|`WL.Client.getRequiredAccessTokenScope(status, header)` |`WLAuthorizationManager.isAuthorizationRequired` 및 `WLAuthorizationManager.getResourceScope`를 사용하십시오. |
|`WL.Client.isUserAuthenticated(realm)` |대체 없음. |
|`WLUserAuth.deleteCertificate(provisioningEntity)` |대체 없음. |
|`WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` |대체 없음. |
|`WL.Client.createChallengeHandler(realmName)` |사용자 정의 게이트웨이 인증 확인을 처리하기 위해 인증 확인 핸들러를 작성하려면 `WL.Client.createGatewayChallengeHandler(gatewayName)`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 처리를 위해 인증 확인 핸들러를 작성하려면 `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`를 사용하십시오. |
|`WL.Client.createWLChallengeHandler(realmName)` |`WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`을 사용하십시오. |
|`challengeHandler.isCustomResponse()` 여기서 challengeHandler는 `WL.Client.createChallengeHandler()`에서 리턴된 인증 확인 핸들러 오브젝트입니다. |`gatewayChallengeHandler.canHandleResponse()`를 사용하십시오. 여기서 `gatewayChallengeHandler`는 `WL.Client.createGatewayChallengeHandler()`에서 리턴되는 인증확인 핸들러 오브젝트입니다. |
|`wlChallengeHandler.processSucccess()` 여기서 `wlChallengeHandler`는 `WL.Client.createWLChallengeHandler()`에서 리턴한 인증 확인 핸들러 오브젝트입니다. |`securityCheckChallengeHandler.handleSuccess()`를 사용하십시오. 여기서 `securityCheckChallengeHandler`는 `WL.Client.createSecurityCheckChallengeHandler()`에서 리턴되는 인증 확인 핸들러 오브젝트입니다. |
|`WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우, `WL.Client.createGatewayChallengeHandler()`에서 리턴되는 인증 확인 핸들러 오브젝트를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우, `WL.Client.createSecurityCheckChallengeHandler()`에서 리턴되는 인증 확인 핸들러 오브젝트를 사용하십시오. |
|`WL.Client.createProvisioningChallengeHandler()` |대체 없음. 디바이스 프로비저닝은 이제 보안 프레임워크에서 자동으로 처리됩니다. |

#### 더 이상 사용되지 않는 JavaScript API
{: #deprecated-javascript-apis }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`, `WL.Client.invokeProcedure(invocationData, options)`, `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`, `WLProcedureInvocationResult` |대신 `WLResourceRequest`를 사용하십시오. **참고:** `invokeProcedure`의 구현은 `WLResourceRequest`를 사용합니다. |
|`WLClient.getEnvironment` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 **device.platform** 플러그인이 이 기능을 제공합니다. |
|`WLClient.getLanguage` |이 기능을 제공하는 Cordova 플러그인을 사용하십시오. **참고:** 정보용으로 **cordova-plugin-globalization** 플러그인이 이 기능을 제공합니다. |
|`WL.Client.connect(options)` |`WLAuthorizationManager.obtainAccessToken`을 사용하여 서버에 대한 연결성을 검사하고 애플리케이션 관리 규칙을 적용하십시오. |

### Android API
{: #android-apis}
####  중단된 Android API 요소
{: #discontinued-android-api-elements }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WLConfig WLClient.getConfig()` |대체 없음. |
|`WLDevice WLClient.getWLDevice()`, `WLClient.transmitEvent(org.json.JSONObject event)`, `WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`, `WLClient.purgeEventTransmissionBuffer()` |위치정보에 대한 Android API 또는 서드파티 패키지를 사용하십시오. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |대체 없음. |
|`WL.Client.getUserInfo(realm, key`, `WL.Client.updateUserInfo(options)` |대체 없음. |
|`WLClient.checkForNotifications()` |`WLAuthorizationManager.obtainAccessToken("", listener)`을 사용하여 서버에 대한 연결성을 검사하고 애플리케이션 관리 규칙을 적용하십시오. |
|`WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.login(java.lang.String realmName, WLRequestListener listener)` |`AuthorizationManager.login()`을 사용하십시오. |
|`WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.logout(java.lang.String realmName, WLRequestListener listener)` |`AuthorizationManager.logout()`을 사용하십시오. |
|`WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` |`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`을 사용하여 서버에 대한 연결성을 확인하고 애플리케이션 관리 규칙을 적용하십시오. |
|`WLClient.getLastAccessToken()`, `WLClient.getLastAccessToken(java.lang.String scope)` |`AuthorizationManager`를 사용하십시오. |
|`WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` |`AuthorizationManager`를 사용하십시오. |
|`WLClient.logActivity(java.lang.String activityType)` |`com.worklight.common.Logger`를 사용하십시오. 자세한 정보는 로거 SDK를 참조하십시오. |
|`WLAuthorizationPersistencePolicy` |대체 없음. 권한 지속성을 구현하려면 애플리케이션 코드에 인증 토큰을 저장하고 사용자 정의 HTTP 요청을 작성하십시오. |
|`WLSimpleSharedData.setSharedToken(myName, myValue)`, `WLSimpleSharedData.getSharedToken(myName)`, `WLSimpleSharedData.clearSharedToken(myName)` |애플리케이션에서 토큰을 공유하는 Android API를 사용하십시오. |
|`WLUserCertificateManager.deleteCertificate(android.content.Context context)` |대체 없음. |
|`BaseChallengeHandler.submitFailure(WLResponse wlResponse)` |`BaseChallengeHandler.cancel()`을 사용하십시오. |
|`ChallengeHandler` |사용자 정의 게이트웨이 인증 확인의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`WLChallengeHandler` |`SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler.isCustomResponse()` |`GatewayChallengeHandler.canHandleResponse()`를 사용하십시오. |
|`ChallengeHandler.submitAdapterAuthentication` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler`를 사용하십시오. |

#### 더 이상 사용되지 않는 Android API
{: #deprecated-android-apis }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` |더 이상 사용되지 않습니다. `WLResourceRequest`를 사용하십시오. **참고:** `invokeProcedure`의 구현은 `WLResourceRequest`를 사용합니다. |
|`WLClient.connect(WLResponseListener responseListener)`, `WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` |`WLAuthorizationManager.obtainAccessToken("", listener)`을 사용하여 서버에 대한 연결성을 검사하고 애플리케이션 관리 규칙을 적용하십시오. |

#### 레거시 org.apach.http API에 따른 Android API는 더 이상 지원되지 않음
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`org.apache.http.Header[]`는 이제 더 이상 사용되지 않습니다. 따라서 다음 메소드가 제거됩니다.||
|`org.apache.http.Header[] WLResourceRequest.getAllHeaders()` |대신 새 `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API를 사용하십시오. |
|`WLResourceRequest.addHeader(org.apache.http.Header header)` |대신 새 `WLResourceRequest.addHeader(String name, String value)` API를 사용하십시오. |
|`org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` |대신 새 `List<String> WLResourceRequest.getHeaders(String headerName)` API를 사용하십시오. |
|`org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` |대신 새 `WLResourceRequest.getHeaders(String headerName)` API를 사용하십시오. |
|`WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` |대신 새 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API를 사용하십시오. |
|`WLResourceRequest.setHeader(org.apache.http.Header header)` |대신 새 `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)` API를 사용하십시오. |
|`org.apache.http.client.CookieStore WLClient.getCookieStore()` |`ClearableCookieJar WLClient.getPersistentCookies()`로 대체되었습니다. |
|`WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` |대체 없음. MFP 클라이언트를 사용하면 순환하여 경로를 재지정할 수 있습니다. |
|`WLHttpResponseListener`, `WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`, `WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`, `WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`, `WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`, `WLResourceRequest.send(WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` |더 이상 사용되지 않는 Apache HTTP 클라이언트 종속성으로 인해 제거되었습니다. 요청 및 응답을 완전히 제어하려면 자체 요청을 작성하십시오. |

#### `com.worklight.androidgap.api` 패키지는 Cordova 앱에 대한 Android 플랫폼 기능을 제공합니다. {{ site.data.keys.product }}에서는 Cordova 통합을 수용하도록 여러 변경사항이 작성되었습니다.
{: #comworklightandroidgapapi }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|Android 활동은 Android 컨텍스트로 대체되었습니다. | |
|`static WL.createInstance(android.app.Activity activity)` |`static WL.createInstance(android.content.Context context)`는 공유 인스턴스를 작성합니다. |
|`static WL.getInstance()` |`static WL.getInstance()`는 WL 클래스의 인스턴스를 가져옵니다. `WL.createInstance(Context)` 이전에 이 메소드를 호출할 수 없습니다. |

### Objective-C API
{: #objective-c-apis }
#### 중단된 iOS Objective C API
{: #discontinued-ios-objective-c-apis }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`[WLClient getWLDevice][WLClient transmitEvent:]`, `[WLClient setEventTransmissionPolicy]`, `[WLClient purgeEventTransmissionBuffer]` |위치정보가 제거되었습니다. 위치정보에 대한 네이티브 iOS 또는 서드파티 패키지를 사용하십시오. |
|`WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` |대체 없음. |
|`WL.Client.deleteUserPref(key, options)` |대체 없음. 어댑터 및 `MFP.Server.getAuthenticatedUser` API를 사용하여 사용자 환경 설정을 관리할 수 있습니다. |
|`[WLClient getRequiredAccessTokenScopeFromStatus]` |`WLAuthorizationManager obtainAccessTokenForScope`를 사용하십시오. |
|`[WLClient login:withDelegate:]` |`WLAuthorizationManager login`을 사용하십시오. |
|`[WLClient logout:withDelegate:]` |`WLAuthorizationManager logout`을 사용하십시오. |
|`[WLClient lastAccessToken]`, `[WLClient lastAccessTokenForScope:]` |`WLAuthorizationManager obtainAccessTokenForScope`를 사용하십시오. |
|`[WLClient obtainAccessTokenForScope:withDelegate:]`, `[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` |`WLAuthorizationManager obtainAccessTokenForScope`를 사용하십시오. |
|`[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` |IBMMobileFirstPlatformFoundationPush 프레임워크에서 iOS 앱용 Objective-C 클라이언트 측 푸시 API를 사용하십시오. |
|`[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` |IBMMobileFirstPlatformFoundationPush 프레임워크에서 iOS 앱용 Objective-C 클라이언트 측 푸시 API를 사용하십시오. |
|`[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` |더 이상 사용되지 않습니다. 대신 `WLResourceRequest`를 사용하십시오. |
|`WLClient sendUrlRequest:delegate:]` |대신 `[WLResourceRequest sendWithDelegate:delegate]`를 사용하십시오. |
|`[WLClient (void) logActivity:(NSString *) activityType]` |제거되었습니다. Objective C 로거를 사용하십시오. |
|`[WLSimpleDataSharing setSharedToken: myName value: myValue]`, `[WLSimpleDataSharing getSharedToken: myName]]`, `[WLSimpleDataSharing clearSharedToken: myName]` |애플리케이션 사이에서 토큰을 공유하려면 OS API를 사용하십시오. |
|`BaseChallengeHandler.submitFailure(WLResponse *)challenge` |`BaseChallengeHandler.cancel()`을 사용하십시오. |
|`BaseProvisioningChallengeHandler` |대체 없음. 디바이스 프로비저닝은 이제 보안 프레임워크에서 자동으로 처리됩니다. |
|`ChallengeHandler` |사용자 정의 게이트웨이 인증 확인의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`WLChallengeHandler` |`SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler.isCustomResponse()` |`GatewayChallengeHandler.canHandleResponse()`를 사용하십시오. |
|`ChallengeHandler.submitAdapterAuthentication` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |

### Windows C# API
{: #windows-c-apis }
#### 더 이상 사용되지 않는 Windows C# API 요소 - 클래스
{: #deprecated-windows-c-api-elements-classes }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`ChallengeHandler` |사용자 정의 게이트웨이 인증 확인의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler. isCustomResponse()` |`GatewayChallengeHandler.canHandleResponse()`를 사용하십시오. |
|`ChallengeHandler.submitAdapterAuthentication` |인증 확인 핸들러에서 유사한 로직을 구현하십시오. 사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler`를 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 `SecurityCheckChallengeHandler`를 사용하십시오. |
|`ChallengeHandler.submitFailure(WLResponse wlResponse)` |사용자 정의 게이트웨이 인증 확인 핸들러의 경우 `GatewayChallengeHandler.Shouldcancel()`을 사용하십시오. {{ site.data.keys.product_adj }} 보안 검사 인증 확인 핸들러의 경우 `SecurityCheckChallengeHandler.ShouldCancel()`을 사용하십시오. |
|`WLAuthorizationManager` |대신 `WorklightClient.WorklightAuthorizationManager`를 사용하십시오. |
|`WLChallengeHandler` |`SecurityCheckChallengeHandler`를 사용하십시오. |
|`WLChallengeHandler.submitFailure(WLResponse wlResponse)` |`SecurityCheckChallengeHandler.ShouldCancel()`을 사용하십시오. |
|`WLClient` |대신 `WorklightClient`를 사용하십시오. |
|`WLErrorCode` |지원되지 않습니다. |
|`WLFailResponse` |대신 `WorklightResponse`를 사용하십시오. |
|`WLResponse` |대신 `WorklightResponse`를 사용하십시오. |
|`WLProcedureInvocationData` |대신 `WorklightProcedureInvocationData`를 사용하십시오. |
|`WLProcedureInvocationFailResponse` |지원되지 않습니다. |
|`WLProcedureInvocationResult` |지원되지 않습니다. |
|`WLRequestOptions` |지원되지 않습니다. |
|`WLResourceRequest` |지원되지 않습니다. |

#### 더 이상 사용되지 않는 Windows C# API 요소 - 인터페이스
{: #deprecated-windows-c-api-elements-interfaces }

|API 요소           |마이그레이션 경로                           |
|-----------------------|------------------------------------------|
|`WLHttpResponseListener` |지원되지 않습니다. |
|`WLResponseListener` |응답은 `WorklightResponse` 오브젝트로 사용 가능합니다. |
|`WLAuthorizationPersistencePolicy` |지원되지 않습니다. |
