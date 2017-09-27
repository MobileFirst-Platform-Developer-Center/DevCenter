---
layout: tutorial
title: 새로운 기능
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0에서는 {{ site.data.keys.product_adj }} 애플리케이션 개발, 배치 및 관리 환경을 현대화하는 중요한 변경사항을 가져옵니다.

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">앱 빌드의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} SDK 및 명령행 인터페이스는 앱 개발 시에 보다 나은 유연성과 효율성을 제공하기 위해 다시 디자인되었습니다. 또한 이제 교차 플랫폼 앱을 개발할 경우 선호하는 Cordova 도구를 사용할 수 있습니다. </p>

                <p>앱 개발을 위한 새로운 기능에 대해 알아보려면 다음 절을 검토하십시오.</p>

                <h3>새 개발 및 배치 프로세스</h3>
                <p>애플리케이션 서버에 설치되어야 하는 프로젝트 WAR 파일을 더 이상 작성하지 않습니다. 대신 {{ site.data.keys.mf_server }}는 한 번 설치되며, 사용자 앱, 자원 보안 또는 푸시 서비스의 서버 측 구성을 서버에 업로드합니다. {{ site.data.keys.mf_console }}을 사용하여 앱 구성을 수정할 수 있습니다. </p>

                <p>{{ site.data.keys.product_adj }} 프로젝트는 더 이상 존재하지 않습니다. 대신 사용자가 선택한 개발 환경으로 모바일 앱을 개발합니다. <br/>
                {{ site.data.keys.mf_server }}를 중지하지 않고도 앱 및 어댑터의 서버 측 구성을 수정할 수 있습니다..</p>

                <ul>
                    <li>새 개발 프로세스에 대한 자세한 정보는 <a href="../../../application-development/">개발 개념 및 개요</a>를 참조하십시오.</li>
                    <li>기존 애플리케이션의 마이그레이션에 대한 자세한 정보는 <a href="../../../upgrading/migration-cookbook">Migrating Cookbook</a>을 참조하십시오.</li>
                    <li>{{ site.data.keys.product_adj }} 애플리케이션 관리에 대한 자세한 정보는 {{ site.data.keys.product_adj }} 애플리케이션 관리를 참조하십시오. </li>
                </ul>

                <h3>웹 애플리케이션</h3>
                <p>이제 선호하는 도구 및 IDE로 웹 애플리케이션을 개발하기 위해 {{ site.data.keys.product_adj }} 클라이언트 측 JavaScript API를 사용할 수 있습니다. 보안 기능을 애플리케이션에 추가하기 위해 웹 애플리케이션을 {{ site.data.keys.mf_server }}에 등록할 수 있습니다.</p>

                <p>또한 새 웹 SDK의 일부로 제공되는 새 클라이언트 측 JavaScript 웹 분석 API를 사용하여 {{ site.data.keys.mf_analytics }} 기능을 웹 애플리케이션에 추가할 수 있습니다.</p>

                <h3>선호하는 Cordova 도구로 교차 플랫폼 앱 개발</h3>
                <p>이제 선호하는 Cordova 도구(예: Apache Cordova CLI 또는 Ionic Framework)를 사용하여 교차 플랫폼 하이브리드 앱을 개발할 수 있습니다. {{ site.data.keys.product }}의 이러한 도구를 독립적으로 획득한 후 {{ site.data.keys.product_adj }} 백엔드 기능을 제공하기 위한 {{ site.data.keys.product_adj }} 플러그인을 추가합니다.</p>

                <p>Eclipse 개발 환경에서 {{ site.data.keys.product }}로 사용으로 설정된 교차 플랫폼 Cordova 앱을 관리하기 위해 {{ site.data.keys.product }} Studio Eclipse 플러그인을 설치할 수 있습니다. {{ site.data.keys.product }} Studio 플러그인은 Eclipse 환경 내에서 실행할 수 있는 추가 {{ site.data.keys.mf_cli }} 명령을 제공합니다. </p>

                <h3>SDK 컴포넌트화</h3>
                <p>이전에 {{ site.data.keys.product_adj }} 클라이언트 SDK는 단일 프레임워크나 JAR로 전달되었습니다. 이제 특정 기능을 포함하거나 제외하도록 선택할 수 있습니다. 코어 SDK 외에도 각 {{ site.data.keys.product_adj }} API에는 선택적 자체 컴포넌트 세트가 포함되어 있습니다. </p>

                <h3>향상된 새 개발 명령행 인터페이스(CLI)</h3>
                <p>{{ site.data.keys.mf_cli }}는 자동화된 스크립트에서의 사용을 포함하여 더 큰 개발 효율성을 위해 다시 디자인되었습니다. 명령은 이제 접두부 mfpdev로 시작합니다. CLI가 {{ site.data.keys.mf_dev_kit_full }}에 포함되거나 사용자가 npm으로부터 CLI의 최신 버전을 신속하게 다운로드할 수 있습니다. </p>

                <h3>마이그레이션 지원 도구</h3>
                <p>마이그레이션 지원 도구는 기존 앱을 {{ site.data.keys.product }} 버전 8.0으로 마이그레이션하는 프로시저를 단순화합니다. 이 도구는 기존 {{ site.data.keys.product_adj }} 앱을 스캔하고 버전 8.0에서 제거되거나 더 이상 사용되지 않거나 대체되는 파일에서 사용된 API 목록을 작성합니다. {{ site.data.keys.product }}와 함께 작성된 Apache Cordova 애플리케이션에서 마이그레이션 지원 도구를 실행할 경우, 버전 8.0과 호환되는 앱에 대해 새 Cordova 구조를 작성합니다. 마이그레이션 지원 도구에 대한 자세한 정보는 다음을 참조하십시오.</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>Cordova 4.0부터는 연결 가능한 WebView를 통해 기본 웹 런타임이 대체되도록 허용합니다. 이제 Crosswalk가 {{ site.data.keys.product }}를 통해 Cordova 애플리케이션에서 지원됩니다. Android용 Crosswalk WebView의 사용은 폭넓은 모바일 디바이스에서 높은 성능과 일관성 있는 사용자 환경을 허용합니다. Crosswalk 기능을 활용하려면 Cordova Crosswalk 플러그인을 적용하십시오. </p>

                <h3>NuGet을 사용하여 Windows 8 및 Windows 10 Universal 앱용 {{ site.data.keys.product_adj }} SDK 분배 </h3>
                <p>Windows 8 및 Windows 10 Universal 앱용 {{ site.data.keys.product_adj }} SDK는 NuGet(<a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>)에서 사용 가능합니다. 시작하려면 다음을 수행하십시오. </p>

                <h3>org.apache.http가 okHttp로 대체됨</h3>
                <p><code>org.apache.http</code>는 Android SDK에서 제거되었습니다. okHttp는 http 종속성으로 사용됩니다. </p>

                <h3>iOS 하이브리드 Cordova 앱에 대한 WKWebView 지원</h3>
                <p>이제 Cordova 앱의 기본 UIWebView를 WKWebView로 대체할 수 있습니다.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">MobileFirst API의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>모바일 애플리케이션 개발에 사용할 수 있는 API가 새 기능을 통해 향상되고 확장되었습니다. {{ site.data.keys.product }}의 새 기능 또는 향상되거나 변경된 기능을 이용하려면 최신 API를 사용하십시오.</p>

                <h3>업데이트된 JavaScript 서버 측 API</h3>
                <p>백엔드 호출 기능은 지원되는 어댑터 유형용으로만 지원됩니다. 현재 HTTP 및 SQL 어댑터만 지원되므로 백엔드 호출자 <code>WL.Server.invokeHttp</code> 및 <code>WL.Server.invokeSQL</code>도 지원됩니다.</p>

                <h3>새 Java 서버 측 API</h3>
                <p>{{ site.data.keys.mf_server }}를 확장하는 데 사용할 수 있는 새 Java 서버 측 API가 제공됩니다.</p>

                <h4>보안을 위한 새 Java 서버 측 API</h4>
                <p>새로운 보안 API 패키지(<code>com.ibm.mfp.server.security.external</code>) 및 포함된 패키지에는 보안 검사를 개발하기 위해 필요한 인터페이스와 보안 검사 컨텍스트를 사용하는 어댑터가 포함되어 있습니다. </p>

                <h4>클라이언트 등록 데이터용 새 Java 서버 측 API</h4>
                <p>새로운 클라이언트 등록 데이터 API 패키지(<code>com.ibm.mfp.server.registration.external</code>) 및 포함된 패키지에는 지속적 {{ site.data.keys.product_adj }} 클라이언트 등록 데이터에 대한 액세스를 제공하기 위한 인터페이스가 포함되어 있습니다. </p>

                <h4>Application getJaxRsApplication()</h4>
                <p>이 새 API를 사용하면 어댑터에 대해 JAX-RS 애플리케이션을 리턴할 수 있습니다.</p>

                <h4>String getPropertyValue(String propertyName)</h4>
                <p>이 새 API를 사용하면 어댑터 구성(또는 기본값)에서 값을 가져올 수 있습니다.</p>

                <h3>업데이트된 Java 서버 측 API</h3>
                <p>{{ site.data.keys.mf_server }}를 확장하는 데 사용할 수 있는 업데이트된 Java 서버 측 API가 제공됩니다.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>이 새 API의 서명은 이 버전에서 변경되지 않았습니다. 그러나 이제 해당 동작은 <code>String getPropertyValue (String propertyName)</code>의 해당 항목과 동일하며, 이는 새 Java 서버 측 API에 설명되어 있습니다.</p>

                <h4>WLServerAPIProvider</h4>
                <p>V7.0.0 및 V7.1.0의 경우, WLServerAPIProvider 인터페이스를 통해 Java API에 액세스할 수 있습니다. 예를 들면 <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> 및 <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code>입니다.</p>

                <p>이러한 정적 인터페이스는 이전 버전의 제품에서 개발된 어댑터가 컴파일 및 배치될 수 있도록 허용하기 위해 계속 지원됩니다. 푸시 알림 또는 이전 보안 API를 사용하지 않는 이전 어댑터는 계속해서 새 버전에서 작동합니다. 푸시 알림 또는 이전 보안 API를 사용하는 어댑터는 작동이 중단됩니다.</p>

                <h3>웹 애플리케이션용 JavaScript 클라이언트 측 API</h3>
                <p>크로스 플랫폼 Cordova 애플리케이션의 개발에 사용되는 JavaScript 클라이언트 측 API는 초기화 방법에서 약간의 차이가 있는 웹 애플리케이션의 개발에 사용 가능합니다. JavaScript API의 일부 기능은 웹 애플리케이션에 적용할 수 없습니다. </p>

                <p>또한 새 JavaScript 클라이언트 측 웹 분석 API는 웹 애플리케이션에 {{ site.data.keys.mf_analytics }} 기능을 추가하기 위해 제공됩니다. </p>

                <h3>Windows 8 Universal 및 Windows Phone 8 Universal용으로 업데이트된 C# 클라이언트 측 API  </h3>
                <p>Windows 8 Universal 및 Windows Phone 8 Universal용 C# 클라이언트 측 API가 변경되었습니다. </p>

                <h3>Android용 새 Java 클라이언트 측 API </h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>이 새로운 메소드를 사용하여 {{ site.data.keys.mf_server }} 등록 데이터에서 디바이스의 표시 이름을 가져올 수 있습니다.</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>이 새로운 메소드를 사용하여 {{ site.data.keys.mf_server }} 등록 데이터에 디바이스의 표시 이름을 설정할 수 있습니다.</p>

                <h3>새로운 iOS용 Objective-C 클라이언트 측 API</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>이 새로운 메소드를 사용하여 {{ site.data.keys.mf_server }} 등록 데이터에서 디바이스의 표시 이름을 가져올 수 있습니다.</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>이 새로운 메소드를 사용하여 {{ site.data.keys.mf_server }} 등록 데이터에 디바이스의 표시 이름을 설정할 수 있습니다.</p>

                <h3>업데이트된 관리 서비스용 REST API</h3>
                <p>관리 서비스용 REST API가 부분적으로 리팩토링되었습니다. 특히 비컨 및 중개자용 API가 제거되었으며 푸시 알림에 대한 대부분의 REST 서비스는 이제 푸시 서비스용 REST API의 파트가 되었습니다. </p>

                <h3>업데이트된 런타임용 REST API</h3>
                <p>이제 {{ site.data.keys.product_adj }} 런타임용 REST API에서 모바일 클라이언트 및 기밀 클라이언트를 위한 어댑터를 호출하고, 액세스 토큰을 획득하고, 직접 업데이트 컨텐츠를 가져오는 등의 몇 가지 서비스를 제공합니다. 대부분의 REST API 엔드포인트는 OAuth로 보호됩니다. 개발 서버의 <code>http(s)://server_ip:server_port/context_root/doc</code>에서 런타임 API에 대한 Swagger 문서를 볼 수 있습니다.</p>

                <h3>다중 인증서 고정 지원</h3>
                <p>{{ site.data.keys.mf_bm_short }}은 iFix 8.0.0.0-IF201706240159부터 다중 인증서의 고정을 지원합니다. 이를 통해 사용자는 다중 호스트에 대한 보안 액세스 권한을 갖게 됩니다. 이 iFix 이전에 {{ site.data.keys.mf_bm_short }}은 단일 인증서의 고정을 지원했습니다. {{ site.data.keys.mf_bm_short }}은 사용자가 다중 X509 인증서(인증 기관에서 구입)의 공개 키를 클라이언트 애플리케이션에 고정할 수 있도록 하는 새 API를 도입했습니다. 모든 인증서의 사본은 클라이언트 애플리케이션에 배치되어야 합니다. SSL 핸드쉐이크 중에 {{ site.data.keys.product_full }} 클라이언트 SDK는 서버 인증서의 공개 키가 앱에 저장된 인증서 중 하나와 일치하는지 확인합니다. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">MobileFirst 보안의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>{{ site.data.keys.product }}의 보안 프레임워크가 전체적으로 다시 디자인되었습니다. 새 보안 기능이 도입되었으며 기존 기능의 일부가 수정되었습니다.</p>

                <h3>보안 프레임워크 정비</h3>
                <p>보안 배치 및 관리 태스크를 향상시키고 단순화하기 위해 {{ site.data.keys.product_adj }} 보안 프레임워크를 다시 디자인하고 다시 구현했습니다. 이제 이 프레임워크는 기본적으로 OAuth 모델을 기반으로 하며, 구현은 세션에 비종속적입니다. {{ site.data.keys.product_adj }} 보안 프레임워크의 개요를 확인하십시오.</p>

                <p>서버 측에서는 프레임워크의 여러 빌딩 블록이 보안 검사(어댑터로 구현됨)로 대체되어 새 API를 사용한 단순화된 개발이 가능합니다. 샘플 구현 및 사전 정의된 보안 검사가 제공됩니다. 보안 검사를 참조하십시오. 보안 검사는 어댑터 디스크립터에 구성할 수 있으며, 어댑터를 다시 배치하거나 플로우를 중단하지 않고 런타임 어댑터 또는 애플리케이션 구성 변경사항을 작성하여 사용자 정의할 수 있습니다. 이 구성은 다시 디자인된 {{ site.data.keys.mf_console }} 보안 인터페이스에서 수행할 수 있습니다. 또한 구성 파일을 수동으로 편집하거나 {{ site.data.keys.mf_cli }} 또는 mfpadm 도구를 사용할 수 있습니다.</p>

                <h3>애플리케이션 인증 보안 검사</h3>
                <p>{{ site.data.keys.product_adj }} 애플리케이션 인증 유효성 검증은 이제 이전의 "확장된 애플리케이션 인증 검사"를 대체하는 사전정의된 보안 검사로 구현됩니다. {{ site.data.keys.mf_console }} 또는 mfpadm을 사용하여 애플리케이션 인증 유효성 검증을 동적으로 사용 및 사용 안함으로 설정하고 구성할 수 있습니다. 애플리케이션 인증 파일을 생성하기 위해 독립형 {{ site.data.keys.product_adj }} 애플리케이션 인증 Java 도구(mfp-app-authenticity-tool.jar)가 제공됩니다.</p>

                <h3>기밀 클라이언트</h3>
                <p>새로운 OAuth 보안 프레임워크를 사용하여 기밀 클라이언트에 대한 지원을 다시 디자인하고 다시 구현했습니다. </p>

                <h3>웹 애플리케이션 보안</h3>
                <p>수정된 OAuth 기반 보안 프레임워크가 웹 애플리케이션을 지원합니다. 이제 {{ site.data.keys.mf_server }}에 웹 애플리케이션을 등록하여 애플리케이션에 보안 기능을 추가하고 웹 자원에 대한 액세스를 보호할 수 있습니다. {{ site.data.keys.product_adj }} 웹 애플리케이션에 대한 자세한 정보는 웹 애플리케이션 개발을 참조하십시오. 애플리케이션 인증 보안 검사가 웹 애플리케이션에 지원되지 않습니다.</p>

                <h3>크로스 플랫폼 애플리케이션(Cordova 앱), 새로운 보안 기능 및 변경된 보안 기능</h3>
                <p>추가 보안 기능은 Cordova 앱 보호를 지원하기 위해 사용 가능합니다. 이러한 기능에는 다음이 포함됩니다. </p>

                <ul>
                    <li>웹 자원 암호화: Cordova 패키지의 웹 자원을 암호화하여 패키지를 수정하지 못하도록 하려면 이 기능을 사용하십시오. </li>
                    <li>웹 자원 체크섬: 앱의 웹 자원에 대한 현재 통계와 앱이 처음 열렸을 때 설정된 기준선 통계를 비교하는 체크섬 테스트를 실행하려면 이 기능을 시용하십시오. 이 검사를 사용하면 앱이 설치되고 열린 후 앱이 수정되지 않도록 할 수 있습니다. </li>
                    <li>인증서 핀: 앱의 인증서와 호스트 서버의 인증서를 연관시키려면 이 기능을 사용하십시오. 이 기능을 사용하면 앱과 서버 사이에서 전달되는 정보가 표시되거나 수정되지 않습니다. </li>
                    <li>FIPS(Federal Information Processing Standard) 140-2에 대한 지원: 전송되는 데이터가 FIPS 140-2 암호화 표준을 준수하는지 확인하려면 이 기능을 사용하십시오. </li>
                    <li>OpenSSL: iOS 플랫폼에 대한 Cordova 앱과 함께 OpenSSL 데이터 암호화 및 복호화를 사용하기 위해 cordova-plugin-mfp-encrypt-utils Cordova 플러그인을 사용할 수 있습니다.</li>
                </ul>

                <h3>디바이스 싱글 사인온</h3>
                <p>이제 새로 사전 정의된 <code>enableSSO</code> 보안 검사 애플리케이션 디스크립터 구성 특성을 통해 디바이스 싱글 사인온이 지원됩니다. </p>

                <h3>직접 업데이트</h3>
                <p>{{ site.data.keys.product_adj }}의 이전 버전과 달리 V8.0으로 시작</p>

                <ul>
                    <li>클라이언트 애플리케이션이 보호되지 않은 자원에 액세스하는 경우 {{ site.data.keys.mf_server }}에 사용 가능한 업데이트가 있더라도 애플리케이션에서 업데이트를 수신하지 않습니다. </li>
                    <li>활성화된 후 직접 업데이트가 보호된 자원에 대한 모든 요청에 적용됩니다.</li>
                </ul>

                <h3>외부 자원 보호</h3>
                <p>외부 서버에서 자원을 보호하기 위해 지원되는 메소드 및 제공되는 아티팩트가 수정되었습니다.</p>

                <ul>
                    <li>{{ site.data.keys.product_adj }} 보안 프레임워크를 사용하여 외부 Java 서버의 자원을 보호하기 위해 구성 가능한 새로운 {{ site.data.keys.product_adj }} Java Token Validator 액세스 토큰 유효성 검증 모듈이 제공됩니다. 모듈은 Java 라이브러리(mfp-java-token-validator-8.0.0.jar)로 제공되며, 폐기된 {{ site.data.keys.mf_server }} 토큰 유효성 검증 엔드포인트의 사용을 대체하여 사용자 정의 Java 유효성 검증 모듈을 작성합니다.</li>
                    <li>외부 WebSphere Application Server 또는 WebSphere Application Server Liberty 서버에서 Java 자원을 보호하기 위한 {{ site.data.keys.product_adj }} OAuth Trust Association Interceptor(TAI) 필터는 이제 Java 라이브러리로 제공됩니다(com.ibm.imf.oauth.common_8.0.0.jar). 이 라이브러리는 새로운 Java Token Validator 유효성 검증 모듈 및 제공된 TAI의 변경된 구성을 사용합니다. </li>
                    <li>서버 측 {{ site.data.keys.product_adj }} OAuth TAI API는 더 이상 필요하지 않으며 제거되었습니다.</li>
                    <li>외부 Node.js 서버에 있는 Java 자원을 보호하기 위해 passport-mfp-token-validation {{ site.data.keys.product_adj }} Node.js 프레임워크가 새 보안 프레임워크를 지원하도록 수정되었습니다. </li>
                    <li>모든 유형의 자원 서버에 대해 새로운 권한 부여 서버의 검사 엔드포인트를 사용하는 사용자 정의 필터 및 유효성 검증 모듈을 작성할 수도 있습니다. </li>
                </ul>

                <h3>WebSphere DataPower를 권한 부여 서버로 통합</h3>
                <p>이제 기본 {{ site.data.keys.mf_server }} 권한 부여 서버 대신 OAuth 권한 부여 서버로 WebSphere DataPower를 사용하도록 선택할 수 있습니다. DataPower를 {{ site.data.keys.product_adj }} 보안 프레임워크에 통합되도록 구성햘 수 있습니다.</p>

                <h3>LTPA 기반 싱글 사인온(SSO) 보안 검사</h3>
                <p>이제 새로 사전 정의된 LTPA 기반 싱글 사인온(SSO) 보안 검사를 통해 WebSphere LTPA(light-weight third-party authentication)를 사용한 서버 간 사용자 인증 공유가 지원됩니다. 이 검사는 더 이상 사용되지 않는 {{ site.data.keys.product_adj }} LTPA 영역을 대체하며 이전 필수 구성을 제거합니다. </p>

                <h3>{{ site.data.keys.mf_console }}에서 모바일 애플리케이션 관리</h3>
                <p>{{ site.data.keys.mf_console }}에서 모바일 애플리케이션, 사용자 및 디바이스를 추적하고 관리하는 작업에 대한 지원이 일부 변경되었습니다. 디바이스 또는 애플리케이션 액세스 차단은 보호된 자원에 대한 액세스 시도에만 적용됩니다. </p>

                <h3>{{ site.data.keys.mf_server }} 키 저장소</h3>
                <p>단일 {{ site.data.keys.mf_server }} 키 저장소는 OAuth 토큰 및 직접 업데이트 패키지 서명과 상호 HTTPS(SSL) 인증에 사용됩니다. {{ site.data.keys.mf_console }} 또는 mfpadm을 사용하여 이 키 저장소를 동적으로 구성할 수 있습니다.</p>

                <h3>iOS용 고유 암호화 및 복호화</h3>
                <p>OpenSSL이 iOS용 기본 프레임워크에서 제거되었으며 고유 암호화/복호화로 대체되었습니다. OpenSSL을 별도의 프레임워크로 추가할 수 있습니다. iOS용 OpenSSL 사용을 참조하십시오. iOS Cordova JavaScript의 경우 여전히 기본 프레임워크에 OpenSSL이 임베드되어 있습니다. API 둘 다에 대해 고유 및 OpenSSL 암호화를 모두 사용할 수 있습니다.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">운영 체제 지원의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }}는 이제 Windows 10 Universal 앱, bitcode 빌드 및 Apple watchOS 2를 지원합니다.</p>

                <h3>Windows 10 고유 유니버셜 애플리케이션에 대한 지원</h3>
                <p>{{ site.data.keys.product }}을 사용하여 이제 앱 내부에서 {{ site.data.keys.product_adj }} SDK를 사용하도록 고유 C# 유니버셜 앱 플랫폼 애플리케이션을 작성할 수 있습니다.</p>

                <h3>Windows 하이브리드 환경에 대한 지원</h3>
                <p>Windows 하이브리드 환경에 대한 Windows 10 Universal Windows Platform(UWP) 지원이 제공됩니다. 시작 방법에 대한 자세한 정보는 다음을 참조하십시오.</p>

                <h3>BlackBerry 지원 종료</h3>
                <p>BlackBerry 환경은 더 이상 {{ site.data.keys.product }}에서 지원되지 않습니다.</p>

                <h3>비트코드</h3>
                <p>이제 비트코드 빌드가 iOS 프로젝트에 대해 지원됩니다. 그러나 비트코드로 빌드된 앱에 대해서는 {{ site.data.keys.product_adj }} 애플리케이션 인증 보안 검사가 지원되지 않습니다. </p>

                <h3>Apple watchOS 2</h3>
                <p>이제 Apple watchOS 2가 지원되며 이를 사용하려면 비트코드 빌드가 필요합니다. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">앱 개발 및 관리의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>앱 배치 및 관리를 지원하기 위해 새 {{ site.data.keys.product }} 기능이 도입되었습니다. 이제 {{ site.data.keys.mf_server }}를 다시 시작하지 않고도 앱 및 어댑터를 업데이트할 수 있습니다.</p>

                <h3>향상된 DevOps 지원</h3>
                <p>DevOps 환경을 더욱 효과적으로 지원하기 위해 {{ site.data.keys.mf_server }}가 다시 디자인되었습니다. {{ site.data.keys.mf_server }}가 애플리케이션 서버 환경에 설치되면 애플리케이션을 업로드하거나 {{ site.data.keys.mf_server }} 구성을 변경할 때 애플리케이션 서버 구성을 변경할 필요가 없습니다.</p>

                <p>앱 또는 앱이 종속되어 있는 어댑터를 업데이트할 때 {{ site.data.keys.mf_server }}를 다시 시작할 필요가 없습니다. 서버가 계속 트래픽을 처리 중인 동안 새 애플리케이션을 등록하거나 어댑터의 새 버전을 업로드하거나 구성 조작을 수행할 수 있습니다.</p>

                <p>구성 변경사항 및 개발 조작은 보안 규칙에 의해 보호됩니다. </p>

                <p>다양한 방법으로 개발 아티팩트를 서버에 업로드하여 더 유연하게 운영할 수 있습니다.</p>

                <ul>
                    <li>{{ site.data.keys.mf_console }}이 개선되었습니다. 특히, 이를 사용하여 애플리케이션 또는 새 버전의 애플리케이션을 등록하고 앱 보안 매개변수를 관리하고 인증서를 배치하고 푸시 알림 태그를 작성하고 푸시 알림을 전송할 수 있습니다. 또한 이제 콘솔에 컨텍스트 도움말 안내서도 포함되어 있습니다. </li>
                    <li>명령행 도구</li>
                </ul>

                <p>서버에 업로드하는 개발 아티팩트에는 어댑터 및 해당 구성, 앱에 대한 보안 구성, 푸시 알림 인증서 및 로그 필터가 포함됩니다.</p>

                <h3>{{ site.data.keys.product }}의 IBM Bluemix에서 작성된 애플리케이션 실행</h3>
                <p>개발자는 {{ site.data.keys.product }}에서 실행되도록 IBM Bluemix 애플리케이션을 마이그레이션할 수 있습니다. 마이그레이션하여 {{ site.data.keys.product }} API에 맞도록 클라이언트 애플리케이션에 대한 구성을 변경해야 합니다.</p>

                <h3>IBM Bluemix에 대한 서비스로서의 {{site.data.keys.product }}</h3>
                <p>이제 엔터프라이즈 모바일 앱을 작성 및 실행하기 위해 IBM Bluemix에서 {{ site.data.keys.mf_bm_full }} 서비스를 사용할 수 있습니다. </p>

                <h3>.wlapp 파일 없음</h3>
                <p>이전 버전에서 <b>.wlapp</b> 파일을 업로드하여 애플리케이션을 {{ site.data.keys.mf_server }}에 배치했습니다. 파일에 애플리케이션 및 필수 웹 자원(하이브리드 애플리케이션의 경우)을 설명하는 데이터가 포함되었습니다. V8.0.0에서 <b>.wlapp</b> 파일 대신 다음을 수행하십시오.</p>

                <ul>
                    <li>애플리케이션 디스크립터 JSON 파일을 배치하여 {{ site.data.keys.mf_server }}에서 앱을 등록하십시오. </li>
                    <li>직접 업데이트를 사용하여 Cordova 애플리케이션을 업데이트하려면 수정된 웹 자원의 아카이브(.zip 파일)를 서버에 업로드하십시오. 아카이브 파일에 이전 버전의 {{ site.data.keys.product }}에서 사용 가능한 웹 미리보기 파일 또는 스킨이 더 이상 포함되지 않습니다. 이는 더 이상 사용되지 않습니다. 아카이브에는 클라이언트로 전송된 웹 자원 및 직접 업데이트 유효성 검증을 위한 체크섬만 포함됩니다. </li>
                </ul>

                <p>일반 사용자 디바이스에 설치된 클라이언트 Cordova 앱의 직접 업데이트를 사용으로 설정하려면 수정된 웹 자원을 아카이브(.zip 파일)로 서버에 배치해야 합니다. 안전한 직접 업데이트를 사용으로 설정하려면 사용자 정의 키 저장소 파일을 {{ site.data.keys.mf_server }}에 배치하고 일치하는 공개 키 사본이 배치된 클라이언트 애플리케이션에 포함되어야 합니다.</p>

                <h3>어댑터 </h3>
                <h4>어댑터는 Apache Maven 프로젝트입니다.</h4>
                <p>어댑터는 이제 Maven 프로젝트로 처리됩니다. 표준 명령행 Maven 명령 또는 Maven을 지원하는 임의의 IDE(예: Eclipse 및 IntelliJ)를 사용하여 어댑터를 작성하고 빌드하고 배치할 수 있습니다. </p>

                <h4>DevOps 환경의 어댑터 구성 및 배치</h4>
                <ul>
                    <li>{{ site.data.keys.mf_server }} 관리자는 이제 배치된 어댑터의 동작을 수정하기 위해 {{ site.data.keys.mf_console }}을 사용할 수 있습니다. 재구성 후에는 어댑터를 재배치하거나 서버를 다시 시작할 필요 없이 변경사항이 즉시 서버에 적용됩니다. </li>
                    <li>이제 {{ site.data.keys.mf_server }}가 여전히 트래픽을 제공하는 한편 런타임 시에 이를 배치, 배치 취소 및 재배치를 의미하는 어댑터에 대한 "핫 배치"를 수행할 수 있습니다.</li>
                </ul>

                <h4>어댑터 디스크립터 파일의 변경사항</h4>
                <p><b>adapter.xml</b> 디스크립터 파일이 약간 변경되었습니다. 어댑터의 어댑터 디스크립터 파일 구조에 대한 자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">어댑터 학습서</a>를 참조하십시오.</p>

                <h4>Swagger UI와 통합</h4>
                <p>{{ site.data.keys.mf_server }}는 이제 Swagger UI와 통합됩니다. 임의의 어댑터에 대해 {{ site.data.keys.mf_console }}의 자원 탭에 있는 Swagger 문서 보기를 클릭하여 연관된 API를 확인할 수 있습니다. 이 기능은 개발 환경에서만 사용할 수 있습니다.</p>

                <h4>JavaScript 어댑터에 대한 지원</h4>
                <p>JavaScript 어댑터는 HTTP 및 SQL 연결성 유형으로만 지원됩니다.</p>

                <h4>JAX-RS 2.0에 대한 지원</h4>
                <p>JAX-RS 2.0에 새로운 서버 측 기능(서버 측 비동기 HTTP, 필터 및 인터셉터)이 도입되었습니다. 어댑터는 이제 이러한 새 기능을 이용할 수 있습니다.</p>

                <h3>IBM Containers의 {{ site.data.keys.product }} </h3>
                <p>V8.0.0용으로 릴리스된 IBM Containers의 {{ site.data.keys.product }}는 <a href="http://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage 사이트</a>에서 사용 가능합니다. IBM Containers에서 이 버전의 {{ site.data.keys.product }}는 생산 준비가 되었으며 엔터프라이즈 dashDB™ 트랜잭션 데이터베이스를 지원합니다.</p>

                <p><b>참고:</b> IBM Containers에 {{ site.data.keys.product }}를 배치하기 위한 전제조건을 참조하십시오. </p>

                <h3>IBM PureApplication System에 {{ site.data.keys.mf_server }} 배치</h3>
                <p>이제 IBM PureApplication System에서 지원되는 {{ site.data.keys.product }} 시스템 패턴에 대해 {{ site.data.keys.mf_server }}를 배치하고 구성할 수 있습니다. </p>

                <p>지원되는 모든 {{ site.data.keys.product }} 시스템 패턴에는 이제 기존 IBM DB2 데이터베이스에 대한 지원이 포함됩니다. {{ site.data.keys.mf_app_center_full }}가 가상 시스템 패턴에서 지원됩니다.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">{{ site.data.keys.mf_server }}</a>의 새로운 기능
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }}가 앱을 배치하고 업데이트하는 데 소요되는 시간과 비용을 줄이도록 다시 디자인되었습니다. {{ site.data.keys.mf_server }}를 다시 디자인할 뿐 아니라 {{ site.data.keys.product }}에서는 사용 가능한 설치 방법 수가 늘었습니다. </p>

                <p>새 {{ site.data.keys.mf_server }} 디자인에서는 두 가지 새 컴포넌트 즉, {{ site.data.keys.mf_server }} 라이브 업데이트 서비스와 {{ site.data.keys.mf_server }} 아티팩트를 도입합니다. </p>

                <p>{{ site.data.keys.mf_server }} 라이브 업데이트 서비스는 앱에 대한 증분적 업데이트의 시간과 비용 절감에 도움이 되도록 디자인되었습니다. 이는 앱과 어댑터의 서버 측 구성 데이터를 관리하고 저장합니다. 앱을 다시 빌드하거나 다시 배치하여 앱의 다양한 부분을 변경 또는 업데이트할 수 있습니다.</p>

                <ul>
                    <li>정의하는 사용자 세그먼트를 기반으로 앱 동작을 동적으로 변경하거나 업데이트합니다.</li>
                    <li>서버 측 비즈니스 로직을 동적으로 변경하거나 업데이트합니다. </li>
                    <li>앱 보안을 동적으로 변경하거나 업데이트합니다.</li>
                    <li>앱 구성을 구체화하고 동적으로 변경합니다. </li>
                </ul>

                <p>{{ site.data.keys.mf_server }} 아티팩트는 {{ site.data.keys.mf_console }}의 자원을 제공합니다. </p>

                <p>{{ site.data.keys.mf_server }}를 다시 디자인할 뿐 아니라 추가 설치 옵션을 제공합니다. 수동 설치뿐 아니라 {{ site.data.keys.product }}는 서버 팜에 {{ site.data.keys.mf_server }}를 설치하기 위한 두 가지 옵션을 제공합니다. 또한 Liberty Collective에 {{ site.data.keys.mf_server }}를 설치할 수도 있습니다.</p>

                <p>이제 Ant 태스크를 사용하거나 Server Configuration Tool을 사용하여 서버 팜에서 {{ site.data.keys.mf_server }} 컴포넌트를 설치할 수 있습니다. 자세한 정보는 다음 주제를 참조하십시오. </p>

                <ul>
                    <li>서버 팜 설치</li>
                    <li>{{ site.data.keys.mf_server }} 설치에 대한 학습서</li>
                </ul>

                <p>{{ site.data.keys.mf_server }}는 또한 Liberty Collective도 지원합니다. 서버 토폴로지 및 다양한 설치 방법에 대한 자세한 정보는 다음 주제를 참조하십시오. </p>

                <ul>
                    <li>Liberty Collective 토폴로지</li>
                    <li>Server Configuration Tool 실행</li>
                    <li>Ant 태스크를 사용하여 설치</li>
                    <li>WebSphere Application Server Liberty Collective의 수동 설치 </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">{{ site.data.keys.mf_analytics }}의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }}에는 정보 제공 기능이 향상되고 역할 기반 액세스 제어가 있는 다시 디자인된 콘솔이 도입되었습니다. 또한 이 콘솔은 이제 여러 언어로 사용 가능합니다.</p>

                <p>{{ site.data.keys.mf_analytics_console }}가 직관적이고 좀 더 의미있는 양식으로 정보를 제공하도록 다시 디자인되었으며 일부 이벤트 유형에 대해서는 요약된 데이터를 사용합니다.</p>

                <p>이제 기어 아이콘을 클릭하여 {{ site.data.keys.mf_analytics_console }}에서 로그아웃할 수 있습니다.</p>

                <p>이제 {{ site.data.keys.mf_analytics_console }}을 다음 언어로 사용할 수 있습니다.</p>
                <ul>
                    <li>독일어 </li>
                    <li>스페인어</li>
                    <li>프랑스어 </li>
                    <li>아탈리아어</li>
                    <li>일본어 </li>
                    <li>한국어 </li>
                    <li>포르투갈어(브라질)</li>
                    <li>러시아어 </li>
                    <li>중국어</li>
                    <li>대만어 </li>
                </ul>

                <p>{{ site.data.keys.mf_analytics_console }}은 이제 로그인한 사용자의 보안 역할을 기반으로 다른 컨텐츠를 표시합니다. <br/>
자세한 정보는 <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">역할 기반 액세스 제어</a>를 참조하십시오.</p>

                <p>{{ site.data.keys.mf_analytics_server }}는 Elasticsearch V1.7.5를 사용합니다.</p>

                <p>웹 애플리케이션에 대한 {{ site.data.keys.mf_analytics_short }} 지원이 새 웹 분석 클라이언트 측 API와 함께 지원되었습니다.</p>

                <p>일부 이벤트 유형은 {{ site.data.keys.mf_analytics_server }}의 이전 버전과 V8.0 간에 변경되었습니다. 이 변경으로 인해 서버 구성 파일에서 이전에 구성된 JNDI 특성을 모두 새 이벤트 유형으로 변환해야 합니다. </p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">{{ site.data.keys.product_adj }} 푸시 알림의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>푸시 알림 서비스는 이제 별도의 웹 애플리케이션에서 호스팅된 독립형 서비스로 제공됩니다.</p>

                <p>이전 버전의 {{ site.data.keys.product }}가 푸시 알림 서비스를 애플리케이션 런타임의 일부로 임베드했습니다.</p>

                <h3>프로그래밍 모델</h3>
                <p>프로그래밍 모델의 범위는 서버에서 클라이언트까지 걸쳐 있으며 푸시 알림 서비스가 클라이언트 애플리케이션에서 작동하도록 애플리케이션을 설정해야 합니다. 두 가지 유형의 클라이언트가 푸시 알림 서비스와 상호작용합니다.</p>

                <ul>
                    <li>모바일 클라이언트 애플리케이션</li>
                    <li>백엔드 서버 애플리케이션</li>
                </ul>

                <h3>푸시 알림 서비스에 대한 보안</h3>
                <p>{{ site.data.keys.product }} 권한 서버는 OAuth 프로토콜을 적용하여 푸시 알림 서비스에 보안을 설정합니다.</p>

                <h3>푸시 알림 서비스 모델</h3>
                <p>이벤트 소스 기반 모델은 지원되지 않습니다. 푸시 서비스 모델을 통해 {{ site.data.keys.product }}에서 푸시 알림 기능을 사용할 수 있습니다.</p>

                <h3>푸시 REST API</h3>
                <p>{{ site.data.keys.product }} 런타임에서 푸시에 REST API를 사용하여 {{ site.data.keys.mf_server }} 외부에 배치된 백엔드 서버 애플리케이션이 푸시 알림 기능에 액세스하도록 할 수 있습니다. </p>

                <h3>기존 이벤트 소스 기반 알림 모델에서 업그레이드</h3>
                <p>이벤트 소스 기반 모델은 지원되지 않습니다. 푸시 서비스 모델을 통해 푸시 알림 기능을 완전히 사용할 수 있습니다. 기존의 모든 이벤트 소스 기반 애플리케이션을 새 푸시 서비스 모델로 마이그레이션해야 합니다. </p>

                <h3>푸시 알림 보내기</h3>
                <p>서버에서 이벤트 소스 기반, 태그 기반 또는 브로드캐스트 사용 푸시 알림을 전송하도록 선택할 수 있습니다.</p>

                <p>다음 방법을 사용하여 푸시 알림을 전송할 수 있습니다.</p>
                <ul>
                    <li>{{ site.data.keys.mf_console }}을 사용하여 두 가지 유형의 알림(태그 및 브로드캐스트)을 전송할 수 있습니다. {{ site.data.keys.mf_console }}로 푸시 알림 전송을 참조하십시오.</li>
                    <li>푸시 메시지(POST) REST API를 사용하여 모든 양식의 알림(태그, 브로드캐스트 및 인증됨)을 전송할 수 있습니다.</li>
                    <li>{{ site.data.keys.mf_server }} 관리 서비스에 대한 REST API를 사용하여 모든 양식의 알림(태그, 브로드캐스트 및 인증됨)을 전송할 수 있습니다. </li>
                </ul>

                <h3>SMS 알림 보내기</h3>
                <p>사용자 디바이스에 SMS(short message service) 알림을 보내도록 푸시 서비스를 구성할 수 있습니다. </p>

                <h3>푸시 알림 서비스의 설치</h3>
                <p>푸시 알림 서비스가 {{ site.data.keys.mf_server }} 컴포넌트({{ site.data.keys.mf_server }} 푸시 서비스)로 패키지화됩니다. </p>

                <h3>푸시 서비스 모델은 Windows Universal Platform 앱에서 지원됩니다. </h3>
                <p>푸시 서비스 모델을 사용하여 푸시 알림을 보내도록 고유 UWP(Windows Universal Platform) 애플리케이션을 마이그레이션할 수 있습니다. </p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">{{ site.data.keys.mf_app_center }}의 새로운 기능</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_app_center }}는 이제 BYOL 스크립트를 통해 Bluemix (컨테이너 기반)에서 지원됩니다. </p>
            </div>
        </div>
    </div>
</div>
