---
layout: tutorial
title: 테스트 환경과 프로덕션 환경에 애플리케이션 배치
breadcrumb_title: 환경에 앱 배치
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
애플리케이션의 개발 주기를 완료한 경우 애플리케이션을 테스트 환경에 배치한 후 프로덕션 환경에 배치하십시오. 

### 다음으로 이동
{: #jump-to }

* [프로덕션 환경에 어댑터 배치 또는 업데이트](#deploying-or-updating-an-adapter-to-a-production-environment)
* [자체 서명 인증서를 사용하여 어댑터와 백엔드 서버 간 SSL 구성](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)
* [프로덕션 환경에 애플리케이션 등록](#registering-an-application-to-a-production-environment)
* [테스트 또는 프로덕션 서버에 서버 측 아티팩트 전송](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [프로덕션에서 {{ site.data.keys.product_adj }} 앱 업데이트](#updating-mobilefirst-apps-in-production)

## 프로덕션 환경에 어댑터 배치 또는 업데이트
{: #deploying-or-updating-an-adapter-to-a-production-environment }
어댑터에는 {{ site.data.keys.product }}에서 배치하고 제공하는 애플리케이션의 서버 측 코드가 포함되어 있습니다. 프로덕션 환경에 어댑터를 배치하거나 업데이트하기 전에 이 체크리스트를 읽으십시오. 어댑터 작성과 빌드에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 애플리케이션의 서버 측 개발](../../adapters)을 참조하십시오. 

프로덕션 서버가 실행 중인 동안 어댑터를 업로드하거나, 업데이트하거나, 구성할 수 있습니다. 서버 팜의 모든 노드가 새 어댑터 또는 구성을 수신한 후 어댑터에 대한 모든 수신 요청에서 새 설정을 사용합니다. 

1. 프로덕션 환경에서 기존 어댑터를 업데이트하는 경우 이 어댑터가 서버에 등록된 기존 애플리케이션과 호환되지 않거나 회귀되지 않도록 하십시오. 

    스토어에 이미 공개되고 사용되는 동일한 애플리케이션의 여러 버전 또는 여러 애플리케이션에서 동일한 어댑터를 사용할 수 있습니다. 프로덕션 환경에서 어댑터를 업데이트하기 전에 테스트 서버용으로 빌드된 앱의 사본과 새 어댑터에 대해 테스트 서버에서 비회귀 테스트를 실행하십시오. 

2. Java 어댑터의 경우 어댑터에서 HTTPS를 통한 Java URLConnection을 사용하는 경우 {{ site.data.keys.mf_server }} 키 저장소에 백엔드 인증서가 있는지 확인하십시오. 
        
    자세한 정보는 [HTTP 어댑터에서 SSL 사용](../../adapters/javascript-adapters/js-http-adapter/using-ssl/)을 참조하십시오. 자체 서명 인증서 사용에 대한 자세한 정보는 [자체 서명 인증서를 사용하여 어댑터와 백엔드 서버 간 SSL 구성](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)을 참조하십시오. 

    > **참고:** 애플리케이션 서버가 WebSphere  Application Server Liberty인 경우에는 인증서가 Liberty 신뢰 저장소에도 있어야 합니다.



3. 어댑터의 서버 측 구성을 확인하십시오. 
4. `mfpadm deploy adapter` 명령과 `mfpadm adapter set user-config` 명령을 사용하여 어댑터와 해당 구성을 업로드하십시오. 

    어댑터의 **mfpadm**에 대한 자세한 정보는 [어댑터 관련 명령](../using-cli/#commands-for-adapters)을 참조하십시오. 
        
## 자체 서명 인증서를 사용하여 어댑터와 백엔드 서버 간 SSL 구성
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
{{ site.data.keys.product_adj }} 키 저장소에 서버 자체 서명 SSL 인증서를 가져와 어댑터와 백엔드 서버 간 SSL을 구성할 수 있습니다. 

1. 백엔드 서버 키 저장소에서 서버 공용 인증서를 내보내십시오. 

    > **참고:** keytool 또는 openssl lib를 사용하여 백엔드 키 저장소에서 백엔드 공용 인증서를 내보내십시오. 웹 브라우저에서 내보내기 기능을 사용하지 마십시오.

2. 백엔드 서버 인증서를 {{ site.data.keys.product_adj }} 키 저장소에 가져오십시오. 
3. 새 {{ site.data.keys.product_adj }} 키 저장소를 배치하십시오. 자세한 정보는 [{{ site.data.keys.mf_server }} 키 저장소 구성](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오. 

### 예제
{: #example }
백엔드 인증서의 **CN** 이름은 어댑터 디스크립터 **adapter.xml** 파일에서 구성된 이름과 일치해야 합니다. 예를 들어, 다음과 같이 구성된 **adapter.xml** 파일을 고려하십시오. 

```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

**CN=mybackend.com**을 사용하여 백엔드 인증서를 생성해야 합니다. 

다른 예로 다음 어댑터 구성을 고려하십시오. 

```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

**CN=123.124.125.126**을 사용하여 백엔드 인증서를 생성해야 합니다. 

다음 예에서는 Keytool 프로그램을 사용하여 구성을 완료하는 방법을 표시합니다. 

1. 유효 기간이 365일인 개인용 인증서를 사용하여 백엔드 서버 키 저장소를 작성하십시오. 
        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **참고:** **이름과 성** 필드는 **adapter.xml** 구성 파일에서 사용되는 서버 URL을 포함합니다(예: **mydomain.com** 또는 **localhost**).

2. 키 저장소에 대해 작업하도록 백엔드 서버를 구성하십시오. 예를 들어, Apache Tomcat에서는 다음과 같이 **server.xml** 파일을 변경합니다. 

   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. **adapter.xml** 파일에서 다음과 같이 연결 구성을 확인하십시오. 

   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- The following properties are used by adapter's key manager for choosing a specific certificate from the key store
        <sslCertificateAlias></sslCertificateAlias> 
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. 작성된 백엔드 서버 키 저장소에서 공용 인증서를 내보내십시오. 

   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. 내보낸 인증서를 {{ site.data.keys.mf_server }} 키 저장소로 가져오십시오. 

   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. 인증서를 키 저장소에 올바르게 가져왔는지 확인하십시오. 

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. 새 {{ site.data.keys.mf_server }} 키 저장소를 배치하십시오. 

## 테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드
{: #building-an-application-for-a-test-or-production-environment }
테스트 또는 프로덕션 환경에서 사용할 애플리케이션을 빌드하려면 애플리케이션을 해당 대상 서버에 적합하게 구성해야 합니다. 프로덕션 환경에서 사용할 애플리케이션을 빌드하려면 추가 단계가 적용됩니다. 

1. 대상 서버 키 저장소가 구성되어 있는지 확인하십시오.
자세한 정보는 [{{ site.data.keys.mf_server }} 키 저장소 구성](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오. 

2. 앱 설치 가능 아티팩트를 배포하려면 앱 버전을 높이십시오. 
3. 앱을 빌드하기 전에 대상 서버에 적합하게 구성하십시오. 

    클라이언트 특성 파일에서 대상 서버의 URL과 런타임 이름을 정의합니다. {{ site.data.keys.mf_cli }}를 사용하여 대상 서버를 변경할 수도 있습니다. 실행 중인 서버에 앱을 등록하지 않고 대상 서버에 적합하게 앱을 구성하기 위해 `mfpdev app config server <server URL>` 명령과 `mfpdev app config runtime <runtime_name>` 명령을 사용할 수 있습니다. 또는 `mfpdev app register` 명령을 실행하여 실행 중인 서버에 앱을 등록할 수 있습니다. 서버의 공용 URL을 사용하십시오. 모바일 앱에서 이 URL을 사용하여 {{ site.data.keys.mf_server }}에 연결합니다. 
    
    예를 들어, 기본 이름이 mfp인 런타임으로 대상 서버 mfp.mycompany.com에 적합한 앱을 구성하려면
    `mfpdev app config server https://mfp.mycompany.com`과 `mfpdev app config runtime mfp`를 실행하십시오. 
    
4. 애플리케이션의 비밀 키와 권한 부여된 서버를 구성하십시오. 
    * 앱에서 인증서 고정을 구현하는 경우 대상 서버의 인증서를 사용하십시오. 인증서 고정에 대한 자세한 정보는 [인증서 고정](../../authentication-and-security/certificate-pinning)을 참조하십시오. 
    * iOS 앱에서 ATS(App Transport Security)를 사용하는 경우 대상 서버의 ATS를 구성하십시오. 
    * Apache Cordova 애플리케이션의 보안 직접 업데이트를 구성하려면 [클라이언트 측에서 보안 직접 업데이트 구현](../../application-development/direct-update)을 참조하십시오. 
    * Apache Cordova를 사용하여 앱을 개발하는 경우 Cordova CSP(Content Security Policy)를 구성하십시오.     

5. Apache Cordova를 사용하여 개발되는 애플리케이션에 직접 업데이트를 사용하려는 경우 앱을 빌드하는 데 사용한 Cordova 플러그인 버전을 아카이브하십시오. 

    직접 업데이트를 사용하여 네이티브 코드를 업데이트할 수 없습니다. Cordova 프로젝트에서 기본 라이브러리 또는 빌드 도구 중 하나를 변경하고 해당 파일을 {{ site.data.keys.mf_server }}에 업로드한 경우 서버에서 차이점을 발견하고 클라이언트 애플리케이션의 업데이트를 전송하지 않습니다. 기본 라이브러리의 변경사항에는 다른 Cordova 버전, 최신 Cordova iOS 플러그인 또는 원래 애플리케이션을 빌드하는 데 사용된 것보다 최신인 mfpdev 플러그인 수정팩이 포함될 수 있습니다. 
    
6. 프로덕션용으로 앱을 구성하십시오. 
    * 디바이스 로그에 인쇄하지 않도록 설정하십시오.
    * {{ site.data.keys.mf_analytics }}를 사용하려는 경우 앱에서 {{ site.data.keys.mf_server }}에 수집된 데이터를 전송하는지 확인하십시오. 
    * 여러 테스트 서버에서 사용할 단일 빌드를 작성하려는 경우가 아니면 `setServerURL` API를 호출하는 앱의 기능을 사용 안함으로 설정하십시오. 

7. 프로덕션 서버용으로 빌드하고 설치 가능한 아티팩트를 배포하려는 경우 테스트 서버에서 이 앱에 대해 비회귀 테스트를 실행할 수 있도록 앱 소스 코드를 아카이브하십시오. 

    예를 들어, 나중에 어댑터를 업데이트하는 경우 이미 배포되고 이 어댑터를 사용하는 앱에 대해 비회귀 테스트를 실행할 수 있습니다. 자세한 정보는 [프로덕션 환경에 어댑터 배치 또는 업데이트](#deploying-or-updating-an-adapter-to-a-production-environment)를 참조하십시오. 
    
8. 선택사항: 애플리케이션에 적합한 애플리케이션 인증 파일을 작성하십시오. 

    애플리케이션 인증 보안 검사를 사용하기 위해 서버에 애플리케이션을 등록한 후 애플리케이션 인증 파일을 사용할 수 있습니다. 
    * 자세한 정보는 [애플리케이션 인증 보안 검사 사용](../../authentication-and-security/application-authenticity)을 참조하십시오.
    * 프로덕션 서버에 애플리케이션을 등록하는 작업에 대한 자세한 정보는 [프로덕션 환경에 애플리케이션 등록](#registering-an-application-to-a-production-environment)을 참조하십시오. 

## 프로덕션 환경에 애플리케이션 등록
{: #registering-an-application-to-a-production-environment }
프로덕션 서버에 애플리케이션을 등록하는 경우 애플리케이션 디스크립터를 업로드하고 라이센스 유형을 정의하며 선택적으로 애플리케이션 인증을 활성화합니다. 

#### 시작하기 전에
{: #before-you-begin }
* {{ site.data.keys.mf_server }} 키 저장소가 구성되어 있으며 기본 키 저장소가 아닌지 확인하십시오. 프로덕션의 서버를 기본 키 저장소와 함께 사용하지 마십시오. {{ site.data.keys.mf_server }} 키 저장소는 {{ site.data.keys.mf_server }} 인스턴스의 ID를 정의하며 OAuth 토큰과 직접 업데이트 패키지에 디지털 방식으로 서명하는 데 사용됩니다. 비밀 키를 사용하여 서버의 키 저장소를 구성해야 프로덕션에서 키 저장소를 사용할 수 있습니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 키 저장소 구성](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)을 참조하십시오. 
* 앱에서 사용한 어댑터를 배치하십시오. 자세한 정보는 [프로덕션 환경에 어댑터 배치 또는 업데이트](#deploying-or-updating-an-adapter-to-a-production-environment)를 참조하십시오. 
* 대상 서버에서 사용할 애플리케이션을 빌드하십시오. 자세한 정보는 [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)를 참조하십시오. 

프로덕션 서버에 애플리케이션을 등록하는 경우 애플리케이션 디스크립터를 업로드하고 라이센스 유형을 정의하며 선택적으로 애플리케이션 인증을 활성화합니다. 이전 버전의 앱이 이미 배치되어 있는 경우에는 업데이트 전략을 정의할 수도 있습니다. 중요한 단계와 **mfpadm** 프로그램을 사용하여 해당 단계를 자동화하는 방법에 대해 자세히 알아보려면 다음 프로시저를 읽으십시오. 

1. {{ site.data.keys.mf_server }}가 토큰 라이센싱이 가능하도록 구성된 경우 License Key Server에서 사용할 수 있는 토큰이 충분한지 확인하십시오. 자세한 정보는 [토큰 라이센스 유효성 검증](../license-tracking/#token-license-validation)과 [토큰 라이센싱 사용 계획](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing)을 참조하십시오. 

   > **팁:** 앱의 첫 번째 버전을 등록하기 전에 앱의 토큰 라이센스 유형을 설정할 수 있습니다. 자세한 정보는 [애플리케이션 라이센스 정보 설정](../license-tracking/#setting-the-application-license-information)을 참조하십시오.

2. 테스트 서버의 애플리케이션 디스크립터를 프로덕션 서버로 전송하십시오. 

   이 조작은 애플리케이션을 프로덕션 서버에 등록하고 해당 구성을 업로드합니다. 애플리케이션 디스크립터 전송에 대한 자세한 정보는 [테스트 또는 프로덕션 서버에 서버 측 아티팩트 전송](#transferring-server-side-artifacts-to-a-test-or-production-server)을 참조하십시오. 

3. 애플리케이션 라이센스 정보를 설정하십시오. 자세한 정보는 [애플리케이션 라이센스 정보 설정](../license-tracking/#setting-the-application-license-information)을 참조하십시오. 
4. 애플리케이션 인증 보안 검사를 구성하십시오. 애플리케이션 인증 보안 검사 구성에 대한 자세한 정보는 [애플리케이션 인증 보안 검사 구성](../../authentication-and-security/application-authenticity/#configuring-application-authenticity)을 참조하십시오. 

   > **참고:** 애플리케이션 인증 파일을 작성하려면 애플리케이션 2진 파일이 필요합니다. 자세한 정보는 [애플리케이션 인증 보안 검사 사용](../../authentication-and-security/application-authenticity/#enabling-application-authenticity)을 참조하십시오.

5. 애플리케이션에서 푸시 알림을 사용하는 경우 푸시 알림 인증서를 서버에 업로드하십시오. {{ site.data.keys.mf_console }}을 사용하여 애플리케이션의 푸시 인증서를 업로드할 수 있습니다. 인증서는 애플리케이션의 모든 버전에 공통입니다. 

   > **참고:** 앱이 스토어에 공개되기 전에는 프로덕션 인증서로 앱의 푸시 알림을 테스트할 수 없습니다.

6. 애플리케이션을 스토어에 공개하기 전에 다음 항목을 확인하십시오. 
    * 사용할 모든 모바일 애플리케이션 관리 기능(예: 원격 애플리케이션 사용 안함 또는 관리자 메시지 표시)을 테스트하십시오. 자세한 정보는 [모바일 애플리케이션 관리](../using-console/#mobile-application-management)를 참조하십시오. 
    * 업데이트하는 경우 업데이트 전략을 정의하십시오. 자세한 정보는 [프로덕션에서 {{ site.data.keys.product_adj }} 앱 업데이트](#updating-mobilefirst-apps-in-production)를 참조하십시오. 

## 테스트 또는 프로덕션 서버에 서버 측 아티팩트 전송
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
명령행 도구 또는 REST API를 사용하여 한 서버에서 다른 서버로 애플리케이션 구성을 전송할 수 있습니다. 

애플리케이션 디스크립터 파일은 애플리케이션에 대한 설명과 구성이 포함된 JSON 파일입니다. {{ site.data.keys.mf_server }} 인스턴스에 연결하는 앱을 실행하는 경우 앱을 해당 서버에 등록하고 구성해야 합니다. 앱의 구성을 정의한 후 애플리케이션 디스크립터를 다른 서버(예: 테스트 서버 또는 프로덕션 서버)로 전송할 수 있습니다. 애플리케이션 디스크립터를 새 서버로 전송하면 앱이 새 서버에 등록됩니다. 모바일 애플리케이션을 개발하고 코드에 대한 액세스 권한이 있는지 여부 또는 서버를 관리하고 모바일 앱의 코드에 대한 액세스 권한이 없는지 여부에 따라 다른 프로시저를 사용할 수 있습니다. 

> **중요:** 인증 데이터를 포함하는 애플리케이션을 가져온 경우와 인증 데이터가 생성된 이후 애플리케이션 자체가 재컴파일된 경우에는 인증 데이터를 새로 고쳐야합니다. 자세한 정보는 [애플리케이션 인증 보안 검사 구성](../../authentication-and-security/application-authenticity/#configuring-application-authenticity)을 참조하십시오.

* 모바일 앱 코드에 대한 액세스 권한이 있는 경우 `mfpdev app pull` 명령과 `mfpdev app push` 명령을 사용하십시오. 
* 모바일 앱 코드에 대한 액세스 권한이 없는 경우에는 관리 서비스를 사용하십시오. 

#### 다음으로 이동
{: #jump-to-1 }

* [mfpdev를 사용하여 애플리케이션 구성 전송](#transferring-an-application-configuration-by-using-mfpdev)
* [관리 서비스를 사용하여 애플리케이션 구성 전송](#transferring-an-application-configuration-with-the-administration-service)
* [REST API를 사용하여 서버 측 아티팩트 전송](#transferring-server-side-artifacts-by-using-the-rest-api)
* [MobileFirst Operations Console에서 애플리케이션과 어댑터 내보내기 및 가져오기](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### mfpdev를 사용하여 애플리케이션 구성 전송
{: #transferring-an-application-configuration-by-using-mfpdev }
애플리케이션을 개발한 후 개발 환경에서 테스트 또는 프로덕션 환경으로 애플리케이션을 전송할 수 있습니다. 

* 로컬 컴퓨터에 기존 {{ site.data.keys.product_adj }} 앱이 있어야 합니다. {{ site.data.keys.mf_server }}에 앱을 등록해야 합니다. 서버 프로파일 작성에 대한 정보는 **mfpdev app register**를 실행하거나 이 문서의 애플리케이션 개발 절에서 앱 유형 등록에 대한 주제를 참조하십시오. 
* 로컬 컴퓨터가 앱이 현재 등록된 서버와 앱을 전송하려는 서버에 연결되어 있어야 합니다. 
* 로컬 컴퓨터에 원래 {{ site.data.keys.mf_server }}와 앱을 전송하려는 서버에 대한 서버 프로파일이 있어야 합니다. 서버 프로파일 작성에 대한 정보는 **mfpdev server add**를 실행하십시오. 
* {{ site.data.keys.mf_cli }}가 설치되어 있어야 합니다. 

**mfpdev app pull** 명령을 사용하여 앱의 서버 측 구성 파일 사본을 로컬 컴퓨터에 전송합니다. 그런 다음 **mfpdev app push** 명령을 사용하여 사본을 다른 {{ site.data.keys.mf_server }}에 전송합니다. **mfpdev app push** 명령은 지정된 서버에 앱을 등록하기도 합니다. 

이러한 명령을 사용하여 한 서버에서 다른 서버로 런타임 구성을 전송할 수도 있습니다. 

구성 정보는 서버에 대한 앱과 앱에 특정한 기타 정보를 식별하는 애플리케이션 디스크립터의 컨텐츠를 포함합니다. .zip 파일은 **appName/mobilefirst** 디렉토리에 저장되고 다음과 같이 이름이 지정됩니다. 

```bash
appID-platform-version-artifacts.zip
```

여기서 **appID**는 애플리케이션 이름이고 **platform**은 **android**, **ios** 또는 **windows** 중 하나이며 version은 앱의 버전 레벨입니다. Cordova 앱의 경우 대상 플랫폼마다 별도의 .zip 파일이 작성됩니다. 

**mfpdev app push** 명령을 사용하는 경우 새 {{ site.data.keys.mf_server }}의 프로파일 이름과 URL을 반영하도록 애플리케이션의 클라이언트 특성 파일이 수정됩니다. 

1. 개발 컴퓨터에서 앱의 루트 디렉토리 또는 해당 서브디렉토리 중 하나인 디렉토리로 이동하십시오. 
2. **mfpdev app pull** 명령을 실행하십시오. 매개변수를 사용하지 않고 명령을 지정하면 기본 {{ site.data.keys.mf_server }}에서 앱을 가져옵니다. 또한 특정 서버와 해당 관리자 비밀번호를 지정할 수 있습니다. 예를 들어, 이름이 **myapp1**인 Android 애플리케이션의 경우 다음과 같습니다. 

   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   이 명령은 서버 프로파일 이름이 Server10인 {{ site.data.keys.mf_server }}에서 현재 애플리케이션의 구성 파일을 찾습니다. 그런 다음 해당 구성 파일이 포함된 압축 파일 **myapp1-android-1.0.0-artifacts.zip**을 로컬 컴퓨터에 전송하고 **myapp1/mobilefirst** 디렉토리에 저장합니다. 
    
3. **mfpdev app push** 명령을 실행하십시오. 매개변수를 사용하지 않고 명령을 지정하면 기본 {{ site.data.keys.mf_server }}에 앱을 푸시합니다. 또한 특정 서버와 해당 관리자 비밀번호를 지정할 수 있습니다. 예를 들어, 이전 단계에서 푸시된 동일한 애플리케이션의 경우 다음과 같습니다. `mfpdev app push Server12 -password secretPass234!`.
    
   이 명령은 **myapp1-android-1.0.0-artifacts.zip** 파일을 서버 프로파일 이름이 Server12이고 관리자 비밀번호가 **secretPass234!**인 {{ site.data.keys.mf_server }}에 전송합니다. 클라이언트 특성 파일 **myapp1/app/src/main/assets/mfpclient.properties**는 서버의 URL을 사용하여 앱이 등록된 서버가 Server12임을 반영하도록 수정됩니다. 

앱의 서버 측 구성 파일은 mfpdev app push 명령에서 지정한 {{ site.data.keys.mf_server }}에 있습니다. 이 새 서버에 앱이 등록됩니다. 

### 관리 서비스를 사용하여 애플리케이션 구성 전송
{: #transferring-an-application-configuration-with-the-administration-service }
관리자는 {{ site.data.keys.mf_server }}의 관리 서비스를 사용하여 한 서버에서 다른 서버로 애플리케이션 구성을 전송할 수 있습니다. 애플리케이션 코드에 액세스할 필요는 없지만 대상 서버에서 사용할 클라이언트 앱을 빌드해야 합니다. 

#### 시작하기 전에
{: #before-you-begin-1 }
대상 서버의 클라이언트 앱을 빌드하십시오. 자세한 정보는 [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)를 참조하십시오. 

애플리케이션이 구성되어 있는 서버에서 애플리케이션 디스크립터를 다운로드하여 새 서버에 배치합니다. {{ site.data.keys.mf_console }}에서 애플리케이션 디스크립터를 볼 수 있습니다. 

1. 선택사항: 애플리케이션 서버가 구성되어 있는 서버에서 애플리케이션 디스크립터를 검토하십시오.
    해당 서버의 {{ site.data.keys.mf_console }}을 열고 애플리케이션 버전을 선택한 후 **구성 파일** 탭으로 이동하십시오. 

2. 애플리케이션이 구성되어 있는 서버에서 애플리케이션 디스크립터를 다운로드하십시오. REST API 또는 **mfpadm**을 사용하여 다운로드할 수 있습니다. 

   > **참고:** {{ site.data.keys.mf_console }}에서 애플리케이션 또는 애플리케이션 버전을 내보낼 수도 있습니다. [{{ site.data.keys.mf_console }}에서 애플리케이션과 어댑터 내보내기 및 가져오기](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)를 참조하십시오.
    * REST API를 사용하여 애플리케이션 디스크립터를 다운로드하려면 [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST API를 사용하십시오. 

    다음 URL에서는 앱 ID가 **my.test.application**이고 플랫폼이 **ios**이며 버전 **0.0.1**인 애플리케이션의 애플리케이션 디스크립터를 리턴합니다. 호출은 {{ site.data.keys.mf_server }}에 대해 이루어집니다. `http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor`
    
    예를 들면, curl과 같은 도구를 통해 이러한 URL을 사용할 수 있습니다. `curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`.
    
    <br/>
    서버 구성에 따라 다음 URL 요소를 변경하십시오.
     * **9080**은 개발 중에 {{ site.data.keys.mf_server }}의 기본 HTTP 포트입니다. 
     * **mfpadmin**은 관리 서비스의 기본 컨텍스트 루트입니다.  

    REST API에 대한 정보는 {{ site.data.keys.mf_server }} 관리 서비스의 REST API를 참조하십시오. 
     * **mfpadm**을 사용하여 애플리케이션 디스크립터를 다운로드하십시오. 

       **mfpadm** 프로그램은 {{ site.data.keys.mf_server }} 설치 프로그램을 실행할 때 설치됩니다. **product\_install\_dir/shortcuts/** 디렉토리에서 프로그램을 시작합니다. 여기서 **product\_install\_dir**은 {{ site.data.keys.mf_server }}의 설치 디렉토리를 표시합니다. 
    
       다음 예제에서는 **mfpadm** 명령에 필요한 비밀번호 파일을 작성한 후 앱 ID가 **my.test.application**이고 플랫폼이 **ios**이며 버전이 **0.0.1**인 애플리케이션의 애플리케이션 디스크립터를 다운로드합니다. 제공된 URL은 개발 중에 {{ site.data.keys.mf_server }}의 HTTPS URL입니다. 
    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       서버 구성에 따라 다음 명령행 요소를 변경하십시오. 
        * **9443**은 개발 중에 {{ site.data.keys.mf_server }}의 기본 HTTPS 포트입니다. 
        * **mfpadmin**은 관리 서비스의 기본 컨텍스트 루트입니다.  
        * --secure false는 서버의 SSL 인증서가 자체 서명되었거나 URL에 사용된 서버의 호스트 이름과 다른 호스트 이름에 대해 작성된 경우에도 해당 인증서가 허용됨을 표시합니다. 

       **mfpadm** 프로그램에 대한 자세한 정보는 [명령행을 통해 {{ site.data.keys.product_adj }} 애플리케이션 관리](../using-cli)를 참조하십시오. 
    
3. 새 서버에 애플리케이션 디스크립터를 업로드하여 앱을 등록하거나 해당 구성을 업데이트하십시오.
REST API 또는 **mfpadm**을 사용하여 업로드할 수 있습니다.
   * REST API를 사용하여 애플리케이션 디스크립터를 업로드하려면 [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST API를 사용하십시오. 
    
     다음 URL은 mfp 런타임에 애플리케이션 디스크립터를 업로드합니다. POST 요청을 전송하면 페이로드가 JSON 애플리케이션 디스크립터가 됩니다. 이 예제의 경우 로컬 컴퓨터에서 실행되고 HTTP 포트를 9081로 설정하도록 구성된 서버에 대해 호출이 이루어집니다. 
    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     예를 들면, curl과 같은 도구를 통해 이러한 URL을 사용할 수 있습니다. 
    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * mfpadm을 사용하여 애플리케이션 디스크립터를 업로드하십시오. 

     다음 예제에서는 mfpadm 명령에 필요한 비밀번호 파일을 작성한 후 앱 ID가 my.test.application이고 플랫폼이 ios 이며 버전이 0.0.1인 애플리케이션의 애플리케이션 디스크립터를 업로드합니다. 제공된 URL은 로컬 컴퓨터에서 실행되는 서버의 HTTPS URL이지만 HTTPS 포트가 9444로 설정되고 이름이 mfp인 런타임에 적합하도록 구성됩니다. 

     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### REST API를 사용하여 서버 측 아티팩트 전송
{: #transferring-server-side-artifacts-by-using-the-rest-api }
사용자 역할에 상관 없이 {{ site.data.keys.mf_server }} 관리 서비스를 사용하여 백업 또는 재사용 용도로 애플리케이션, 어댑터, 자원을 내보낼 수 있습니다. 관리자 또는 배치자는 내보내기 아카이브를 다른 서버에 배치할 수도 있습니다. 애플리케이션 코드에 액세스할 필요는 없지만 대상 서버에서 사용할 클라이언트 앱을 빌드해야 합니다. 

#### 시작하기 전에
{: #before-you-begin-2 }
대상 서버의 클라이언트 앱을 빌드하십시오. 자세한 정보는 [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)를 참조하십시오. 

내보내기 API는 런타임의 선택된 아티팩트를 .zip 아카이브로 검색합니다. 아카이브된 컨텐츠를 재사용하려면 배치 API를 사용하십시오. 

> **중요:** 주의깊게 유스 케이스를 고려하십시오.   
>  
> * 내보내기 파일은 애플리케이션 인증 데이터를 포함합니다. 해당 데이터는 모바일 앱의 빌드에 고유합니다. 모바일 앱은 서버의 URL과 해당 런타임 이름을 포함합니다. 그러므로 다른 서버 또는 다른 런타임을 사용하려면 앱을 다시 빌드해야 합니다. 내보낸 앱 파일만 전송하는 동작은 작동하지 않습니다.
> * 일부 아티팩트는 서버마다 다릅니다. 개발 환경에서 작업하는지 또는 프로덕션 환경에서 작업하는지 여부에 따라 푸시 신임 정보가 다릅니다.
> * 애플리케이션 런타임 구성(활성/사용 안함 상태와 로그 프로파일을 포함함)을 전송할 수 있는 경우가 있지만 항상 전송할 수 있는 것은 아닙니다.
> * 새 서버를 사용하기 위해 앱을 다시 빌드하는 경우와 같이 웹 자원 전송이 적합하지 않은 경우가 있습니다. 

* 하나의 어댑터나 모든 어댑터의 모든 자원 또는 자원의 선택된 서브세트를 내보내려면 [어댑터 자원 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) 또는 [어댑터 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc) API를 사용하십시오. 
* 특정 애플리케이션 환경(예: Android 또는 iOS)에 있는 모든 자원 즉, 해당 환경에 사용되는 버전의 모든 자원과 모든 버전을 내보내려면 [애플리케이션 환경 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc) API를 사용하십시오. 
* 애플리케이션의 특정 버전(예: 버전 1.0 또는 2.0의 Android 애플리케이션)에 사용되는 모든 자원을 내보내려면 [애플리케이션 환경 자원 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc) API를 사용하십시오. 
* 런타임의 특정 애플리케이션 또는 모든 애플리케이션을 내보내려면 [애플리케이션 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) 또는 [애플리케이션 자원 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc) API를 사용하십시오. **참고:** 애플리케이션 자원 중에 푸시 알림의 신임 정보는 내보내기되지 않습니다. 
* 어댑터 컨텐츠, 디스크립터, 라이센스 구성, 컨텐츠, 사용자 구성, 키 저장소, 애플리케이션의 웹 자원을 내보내려면 [자원 내보내기(GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-) API를 사용하십시오. 
* 런타임의 모든 또는 선택된 자원을 내보내려면 [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) API를 사용하십시오. 예를 들면, 다음 일반 curl 명령을 사용해 모든 자원을 .zip 파일로 검색할 수 있습니다. 

  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* 웹 애플리케이션 자원을 포함하는 아카이브를 어댑터, 애플리케이션, 라이센스 구성, 키 저장소, 웹 자원으로 배치하려면 [배치(POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc) API를 사용하십시오. 예를 들면, 다음 curl 명령을 사용해 아티팩트를 포함하는 기존 .zip 파일을 배치할 수 있습니다. 

  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* 애플리케이션 인증 데이터를 배치하려면 [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) API를 사용하십시오. 
* 애플리케이션의 웹 자원을 배치하려면 [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc) API를 사용하십시오. 

동일한 런타임에 내보내기 아카이브를 배치하는 경우 애플리케이션 또는 버전이 반드시 내보낸 상태와 동일하게 복원되지는 않습니다. 즉, 재배치하는 경우 후속 수정사항이 제거되지 않습니다. 일부 애플리케이션 자원을 내보낸 후 재배치하기 전에 수정하면 내보낸 아카이브에 포함된 자원만 원래 상태로 재배치됩니다. 예를 들어, 인증 데이터가 없는 애플리케이션을 내보내고 인증 데이터를 업로드한 후 초기 아카이브를 가져오는 경우 인증 데이터가 지워지지 않습니다. 

### {{ site.data.keys.mf_console }}에서 애플리케이션과 어댑터 내보내기 및 가져오기
{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
특정 조건에서는 콘솔에서 애플리케이션 또는 애플리케이션 버전 중 하나를 내보내고 나중에 동일한 서버 또는 다른 서버에 있는 다른 런타임에 가져올 수 있습니다. 어댑터를 내보내고 다시 가져올 수도 있습니다. 이 기능을 재사용 또는 백업 용도로 사용하십시오. 

**mfpadmin** 관리자 역할과 **mfpdeployer** 배치자 역할이 부여된 경우 애플리케이션의 한 버전 또는 모든 버전을 내보낼 수 있습니다. 애플리케이션 또는 버전은 애플리케이션 ID, 디스크립터, 인증 데이터, 웹 자원을 저장하는 .zip 압축 파일로 내보내기됩니다. 나중에 아카이브를 가져와 동일한 서버 또는 다른 서버에 있는 다른 런타임에 애플리케이션 또는 버전을 재배치할 수 있습니다. 

> **중요:** 주의깊게 유스 케이스를 고려하십시오.   
> 
> * 내보내기 파일은 애플리케이션 인증 데이터를 포함합니다. 해당 데이터는 모바일 앱의 빌드에 고유합니다. 모바일 앱은 서버의 URL과 해당 런타임 이름을 포함합니다. 그러므로 다른 서버 또는 다른 런타임을 사용하려면 앱을 다시 빌드해야 합니다. 내보낸 앱 파일만 전송하는 동작은 작동하지 않습니다.
> * 일부 아티팩트는 서버마다 다릅니다. 개발 환경에서 작업하는지 또는 프로덕션 환경에서 작업하는지 여부에 따라 푸시 신임 정보가 다릅니다.
> * 애플리케이션 런타임 구성(활성/사용 안함 상태와 로그 프로파일을 포함함)을 전송할 수 있는 경우가 있지만 항상 전송할 수 있는 것은 아닙니다.
> * 새 서버를 사용하기 위해 앱을 다시 빌드하는 경우와 같이 웹 자원 전송이 적합하지 않은 경우가 있습니다. 

REST API 또는 mfpadm 도구를 사용해 애플리케이션 디스크립터를 전송할 수도 있습니다. 자세한 정보는 [관리 서비스를 사용하여 애플리케이션 구성 전송](#transferring-an-application-configuration-with-the-administration-service)을 참조하십시오. 

1. 탐색 사이드바에서 애플리케이션이나 애플리케이션 버전 또는 어댑터를 선택하십시오. 
2. **조치 → 애플리케이션 내보내기**, **버전 내보내기** 또는 **어댑터 내보내기**를 선택하십시오. 

    내보낸 자원을 캡슐화하는 .zip 아카이브 파일을 저장할 것인지 확인하는 프롬프트가 표시됩니다. 대화 상자의 모양은 브라우저에 따라 다르고 대상 폴더는 브라우저 설정에 따라 다릅니다. 

3. 아카이브 파일을 저장하십시오. 

    아카이브 파일 이름에는 애플리케이션 또는 어댑터의 이름과 버전이 포함됩니다(예: **export_applications_com.sample.zip**). 

4. 기존 내보내기 아카이브를 재사용하려면 **조치 → 애플리케이션 가져오기** 또는 **버전 가져오기**를 선택하고 아카이브를 찾아본 후 **배치**를 클릭하십시오. 

기본 콘솔 프레임에 가져온 애플리케이션 또는 어댑터의 세부사항이 표시됩니다. 

동일한 런타임으로 가져오는 경우 애플리케이션 또는 버전이 반드시 내보낸 상태와 동일하게 복원되지는 않습니다. 즉, 가져오기 시 재배치하는 경우 후속 수정사항이 제거되지 않습니다. 일부 애플리케이션 자원을 내보낸 후 가져오기 시 재배치하기 전에 수정하면 내보낸 아카이브에 포함된 자원만 원래 상태로 재배치됩니다. 예를 들어, 인증 데이터가 없는 애플리케이션을 내보내고 인증 데이터를 업로드한 후 초기 아카이브를 가져오는 경우 인증 데이터가 지워지지 않습니다. 

## 프로덕션에서 {{ site.data.keys.product_adj }} 앱 업데이트
{: #updating-mobilefirst-apps-in-production }
{{ site.data.keys.product_adj }} 앱이 이미 프로덕션에 있는 경우 Application Center 또는 앱 스토어에서 해당 앱을 업그레이드하는 일반 가이드라인이 있습니다. 

앱을 업그레이드할 때 새 앱을 배치하고 이전 버전이 작동하도록 두거나 새 앱 버전을 배치하고 이전 버전을 차단할 수 있습니다. Apache Cordova를 사용하여 앱을 개발한 경우 웹 자원만 업데이트할 수도 있습니다. 

### 새 앱 버전 배치 및 작동 중인 이전 버전 유지
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
새 기능을 도입하거나 네이티브 코드를 수정할 때 사용되는 가장 일반적인 업그레이드 경로는 앱의 새 버전을 릴리스하는 것입니다. 다음 단계를 수행하십시오. 

1. 앱 버전 번호를 높이십시오. 
2. 애플리케이션을 빌드하고 테스트하십시오. 자세한 정보는 [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)를 참조하십시오. 
3. {{ site.data.keys.mf_server }}에 앱을 등록하고 구성하십시오. 
4. 새 .apk, .ipa, .appx 또는 .xap 파일을 각 앱 스토어에 제출하십시오. 
5. 검토와 승인을 거쳐 앱을 사용할 수 있을 때까지 대기하십시오. 
6. 선택사항 - 이전 버전 사용자에게 새 버전을 알리는 알림 메시지를 보내십시오. [관리자 메시지 표시](../using-console/#displaying-an-administrator-message)와 [다중 언어로 관리자 메시지 정의](../using-console/#defining-administrator-messages-in-multiple-languages)를 참조하십시오. 


### 새 앱 버전 배치 및 이전 버전 차단
{: #deploying-a-new-app-version-and-blocking-the-old-version }
이 업그레이드 경로는 강제로 사용자가 새 버전으로 업그레이드하도록 하고 이전 버전에 대핸 액세스를 차단하려는 경우에 사용됩니다. 다음 단계를 수행하십시오. 

1. 선택사항 - 이전 버전 사용자에게 며칠 내에 필수 업데이트가 있음을 알리는 알림 메시지를 보내십시오. [관리자 메시지 표시](../using-console/#displaying-an-administrator-message)와 [다중 언어로 관리자 메시지 정의](../using-console/#defining-administrator-messages-in-multiple-languages)를 참조하십시오. 
2. 앱 버전 번호를 높이십시오. 
3. 애플리케이션을 빌드하고 테스트하십시오. 자세한 정보는 [테스트 또는 프로덕션 환경에서 사용할 애플리케이션 빌드](#building-an-application-for-a-test-or-production-environment)를 참조하십시오. 
4. {{ site.data.keys.mf_server }}에 앱을 등록하고 구성하십시오. 
5. 새 .apk, .ipa, .appx 또는 .xap 파일을 각 앱 스토어에 제출하십시오. 
6. 검토와 승인을 거쳐 앱을 사용할 수 있을 때까지 대기하십시오. 
7. 새 앱 버전의 링크를 복사하십시오. 
8. {{ site.data.keys.mf_console }}에서 이전 버전의 앱을 차단하고 메시지와 새 버전의 링크를 제공하십시오. [보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정](../using-console/#remotely-disabling-application-access-to-protected-resources)을 참조하십시오. 

> **참고:** 이전 앱을 사용 안함으로 설정하면 더 이상 {{ site.data.keys.mf_server }}와 통신할 수 없습니다. 앱 시작 시 서버 연결을 강제 실행하지 않는 한 사용자가 여전히 앱을 시작하고 오프라인으로 앱에서 작업할 수 있습니다.

### 직접 업데이트(네이티브 코드 변경사항 없음)
{: #direct-update-no-native-code-changes }
직접 업데이트는 프로덕션 앱에 수정사항을 빨리 배치하는 데 사용되는 필수 업그레이드 메커니즘입니다. 앱의 버전을 변경하지 않고 {{ site.data.keys.mf_server }}에 앱을 재배치하면 사용자가 서버에 연결할 때 {{ site.data.keys.mf_server }}가 업데이트된 웹 자원을 직접 디바이스에 푸시합니다. 업데이트된 네이티브 코드는 푸시하지 않습니다. 직접 업데이트를 하려는 경우 다음 사항을 유념해야 합니다. 

1. 직접 업데이트에서는 앱 버전을 업데이트하지 않습니다. 앱의 버전은 동일하게 유지되지만 다른 웹 자원 세트가 사용됩니다. 버전 번호가 변경되지 않으므로 잘못된 용도로 사용되면 혼란이 발생할 수 있습니다. 
2. 직접 업데이트는 기술적으로 새 릴리스가 아니므로 앱 스토어 검토 프로세스가 수행되지 않습니다. 공급업체는 공급업체의 검토를 거치지 않은 앱의 전체 새 버전 배치를 선호하지 않으므로 이 방법을 남용하지 않아야 합니다. 각 스토어의 사용 계약을 읽고 준수하는 것은 사용자의 책임입니다. 직접 업데이트는 며칠 동안 대기할 수 없는 긴급한 문제를 수정하는 데 사용하는 것이 가장 좋습니다. 
3. 직접 업데이트는 보안 메커니즘으로 간주되므로 선택사항이 아니라 필수입니다. 직접 업데이트를 시작할 때 모든 사용자가 앱을 업데이트하여 직접 업데이트를 사용할 수 있도록 해야 합니다. 
4. 애플리케이션이 초기 배치에 사용된 버전이 아닌 다른 {{ site.data.keys.product }} 버전으로 컴파일(빌드)되는 경우에는 직접 업데이트가 작동하지 않습니다. 

> **참고:** iOS 앱의 스토어 제출/유효성 검증을 위해 Test Flight 또는 iTunes Connect를 사용하여 아카이브/IPA 파일을 생성하면 런타임 충돌/실패가 발생할 수 있습니다. 자세히 알아보려면 블로그 [Preparing iOS apps for App Store submission in {{ site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/)의 내용을 읽으십시오.
