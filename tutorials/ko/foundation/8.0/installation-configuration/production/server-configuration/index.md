---
layout: tutorial
title: MobileFirst Server 구성
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
백업 및 복구 정책을 고려하여 {{ site.data.keys.mf_server }} Server 구성을 최적화하고 액세스 제한사항 및 보안 옵션을 적용합니다.

#### 다음으로 이동
{: #jump-to }

* [{{ site.data.keys.mf_server }} 프로덕션 서버의 엔드포인트](#endpoints-of-the-mobilefirst-server-production-server)
* [TLS V1.2를 사용할 수 있도록 {{ site.data.keys.mf_server }} 구성](#configuring-mobilefirst-server-to-enable-tls-v12)
* [{{ site.data.keys.mf_server }} 관리용 사용자 인증 구성](#configuring-user-authentication-for-mobilefirst-server-administration)
* [{{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성 목록](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [데이터 소스 구성](#configuring-data-sources)
* [로깅 및 모니터링 메커니즘 구성](#configuring-logging-and-monitoring-mechanisms)
* [복수 런타임 구성](#configuring-multiple-runtimes)
* [라이센스 추적 구성](#configuring-license-tracking)
* [WebSphere Application Server SSL 구성 및 HTTP 어댑터](#websphere-application-server-ssl-configuration-and-http-adapters)

## {{ site.data.keys.mf_server }} 프로덕션 서버의 엔드포인트
{: #endpoints-of-the-mobilefirst-server-production-server }
IBM {{ site.data.keys.mf_server }}의 엔드포인트에 대해 화이트리스트 및 블랙리스트를 작성할 수 있습니다.

> **참고:** {{ site.data.keys.product }}에서 공개하는 URL 관련 정보는 가이드라인으로서 제공됩니다. 조직에서는 화이트리스트 및 블랙리스트에 포함된 항목을 기반으로 URL이 엔터프라이즈 인프라에서 테스트되었는지 확인해야 합니다.

|`<runtime context root>/api/` 아래의 API URL |설명                               |화이트리스트에 대해 제안? |
|---------------------------------------------|-------------------------------------------|--------------------------|
|/adapterdoc/*	                              |이름 지정된 어댑터에 대한 어댑터의 Swagger 문서 리턴 |아니오. 관리자 및 개발자가 내부에서만 사용합니다. |
|/adapters/*  |어댑터에서 서비스 제공 |예 |
|/az/v1/authorization/* |클라이언트에 특정 범위에 액세스할 수 있는 권한 부여 |예 |
|/az/v1/introspection |클라이언트의 액세스 토큰 인트로스펙트 |아니오. 이 API는 기밀 클라이언트 전용입니다. |
|/az/v1/token |클라이언트의 액세스 토큰 생성 |예 |
|/clientLogProfile/* |클라이언트 로그 프로파일 가져오기 |예 |
|/directupdate/* |직접 업데이트 .Zip 파일 가져오기 |예. 직접 업데이트를 사용할 계획인 경우 |
|/loguploader |서버에 클라이언트 로그 업로드 |예 |
|/preauth/v1/heartbeat |클라이언트로부터의 하트비트 승인 및 마지막 활동 시간 기록 |예 |
|/preauth/v1/logout |보안 검사에서 로그아웃 |예 |
|/preauth/v1/preauthorize |특정 범위에 대한 보안 검사 맵핑 및 실행 |예 |
|/reach |서버에 도달 가능 |아니오. 내부적으로만 사용됩니다. |
|/registration/v1/clients/* |등록-서비스 클라이언트 API |아니오. 이 API는 기밀 클라이언트 전용입니다. |
|/registration/v1/self/* |등록-서비스 클라이언트 자체-등록 API |예 |

## TLS V1.2를 사용할 수 있도록 {{ site.data.keys.mf_server }} 구성
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
{{ site.data.keys.mf_server }}가 SSL 프로토콜 중에서 Transport Layer Security v1.2(TLS V1.2)만 지원하는 디바이스와 통신하도록 하려면 다음 지시사항을 완료해야 합니다.

Transport Layer Security(TLS) V1.2를 사용할 수 있도록 {{ site.data.keys.mf_server }}를 구성하는 단계는 {{ site.data.keys.mf_server }}가 디바이스에 연결하는 방법에 따라 다릅니다.

* 디바이스의 SSL 인코딩된 패킷을 복호화한 후 애플리케이션 서버에 패킷을 전달하는 리버스 프록시 뒤에 {{ site.data.keys.mf_server }}가 있는 경우, 리버스 프록시에서 TLS V1.2 지원을 사용 가능하게 설정해야 합니다. IBM  HTTP Server를 리버스 프록시로 사용하는 경우 지시사항은 [IBM HTTP Server 보안](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc)을 참조하십시오.
* {{ site.data.keys.mf_server }}가 디바이스와 직접 통신하는 경우, TLS V1.2를 사용 가능하게 설정하는 단계는 사용하는 애플리케이션 서버가 Apache Tomcat인지, WebSphere  Application Server Liberty 프로파일인지 또는 WebSphere Application Server 전체 프로파일인지에 따라 다릅니다.

### Apache Tomcat
{: #apache-tomcat }
1. JRE(Java Runtime Environment)에서 TLS V1.2를 지원하는지 확인하십시오.
    다음 JRE 버전 중 하나가 있는지 확인하십시오.
    * Oracle JRE 1.7.0_75 이상
    * Oracle JRE 1.8.0_31 이상
2. **conf/server.xml** 파일을 편집하고 HTTPS 포트를 선언하는 `Connector` 요소를 수정하여 **sslEnabledProtocols** 속성이 다음 값을 갖도록 하십시오.`sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`.

### WebSphere Application Server Liberty 프로파일
{: #websphere-application-server-liberty-profile }
1. JRE(Java Runtime Environment)에서 TLS V1.2를 지원하는지 확인하십시오.
    * IBM Java SDK를 사용하는 경우, IBM Java SDK에 POODLE 취약성에 대한 패치가 적용되었는지 확인하십시오. 사용하는 WebSphere Application Server 버전에 대한 패치가 포함된 최소 IBM Java SDK 버전은 [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173)에서 찾을 수 있습니다.

        > **참고:** 이 보안 게시판에 나열된 버전 또는 이후 버전을 사용할 수 있습니다.
    * Oracle Java SDK를 사용하는 경우 다음 버전 중 하나가 있는지 확인하십시오.
        * Oracle JRE 1.7.0_75 이상
        * Oracle JRE 1.8.0_31 이상
2. IBM Java SDK를 사용하는 경우 **server.xml** 파일을 편집하십시오.
    * 다음 행을 추가하십시오. `<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * `sslProtocol="SSL_TLSv2"` 속성을 기존의 모든 `<ssl>` 요소에 추가하십시오.

### WebSphere Application Server 전체 프로파일
{: #websphere-application-server-full-profile }
1. JRE(Java Runtime Environment)에서 TLS V1.2를 지원하는지 확인하십시오.

    IBM Java SDK에 POODLE 취약성에 대한 패치가 적용되었는지 확인하십시오. 사용하는 WebSphere Application Server 버전에 대한 패치가 포함된 최소 IBM Java SDK 버전은 [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173)에서 찾을 수 있습니다.
    > **참고:** 이 보안 게시판에 나열된 버전 또는 이후 버전을 사용할 수 있습니다.
2. WebSphere Application Server 관리 콘솔에 로그인하여 **보안 → SSL 인증서 및 키 관리 → SSL 구성**을 클릭하십시오.
3. 나열된 SSL 구성마다 TLS V1.2를 사용할 수 있도록 구성을 수정하십시오.
    * SSL 구성을 선택한 후, **추가 특성** 아래에서 **QoP(Quality of Protection) 설정**을 클릭하십시오.
    * **프로토콜** 목록에서 **SSL_TLSv2**를 선택하십시오.
    * **적용**을 클릭하여 변경사항을 저장하십시오.

## {{ site.data.keys.mf_server }} 관리용 사용자 인증 구성
{: #configuring-user-authentication-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} 관리에는 사용자 인증이 필요합니다. 사용자 인증을 구성하고 인증 방법을 선택할 수 있습니다. 구성 프로시저는 사용하는 웹 애플리케이션 서버에 따라 다릅니다.

> **중요:** 독립형 WebSphere  Application Server 전체 프로파일을 사용하는 경우, 글로벌 보안의 단순한 WebSphere 인증 방법(SWAM)이 아닌 다른 인증 방법을 사용하십시오. LTPA(Lightweight Third-Party Authentication)를 사용할 수 있습니다. SWAM을 사용하는 경우 예상치 못한 인증 실패가 발생할 수 있습니다.

설치 프로그램이 웹 애플리케이션 서버에서 {{ site.data.keys.mf_server }} 관리 웹 애플리케이션을 배치한 후에 인증을 구성해야 합니다.

{{ site.data.keys.mf_server }} 관리에는 다음과 같은 Java Platform, Enterprise Edition(Java EE) 보안 역할이 정의되어 있습니다.

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

역할을 해당 사용자 세트에 맵핑해야 합니다. **mfpmonitor** 역할은 데이터를 볼 수 있지만 변경할 수는 없습니다. 다음 표는 프로덕션 서버의 MobileFirst 역할 및 기능을 나열합니다.

#### 배치
{: #deployment }

|                        |관리자 |배치자    |운영자    |모니터    |
|------------------------|---------------|-------------|-------------|------------|
|Java EE 보안 역할 |mfpadmin      |mfpdeployer |mfpoperator |mfpmonitor |
|애플리케이션 배치 |예           |예         |아니오          |아니오         |
|어댑터 배치     |예           |예         |아니오          |아니오         |

#### {{ site.data.keys.mf_server }} 관리
{: #mobilefirst-server-management }

|                            |관리자 |배치자    |운영자    |모니터    |
|----------------------------|---------------|-------------|-------------|------------|
|Java EE 보안 역할     |mfpadmin      |mfpdeployer |mfpoperator |mfpmonitor |
|런타임 설정 구성|예           |예         |아니오          |아니오         |

#### 애플리케이션 관리
{: #application-management }

|                                     |관리자 |배치자    |운영자    |모니터    |
|-------------------------------------|---------------|-------------|-------------|------------|
|Java EE 보안 역할              |mfpadmin      |mfpdeployer |mfpoperator |mfpmonitor |
|새 {{ site.data.keys.product_adj }} 애플리케이션 업로드 |예           |예         |아니오          |아니오         |
|{{ site.data.keys.product_adj }} 애플리케이션 제거	  |예           |예         |아니오          |아니오         |
|새 어댑터 업로드     |예           |예         |아니오          |아니오         |
|어댑터 제거         |예           |예         |아니오          |아니오         |
|애플리케이션에 대한 애플리케이션 인증 테스트 켜기 또는 끄기 |예 |예 |아니오 |아니오    |
|{{ site.data.keys.product_adj }} 애플리케이션 상태에 대한 특성 변경: 활성, 활성 알림, 사용 안함 |예 |예 |예 |아니오 |

기본적으로 모든 역할이 GET 요청을 실행할 수 있고, **mfpadmin**, **mfpdeployer** 및 **mfpmonitor** 역할은 POST 및 PUT 요청도 실행할 수 있으며, **mfpadmin** 및 **mfpdeployer** 역할은 DELETE 요청도 실행할 수 있습니다.

#### 푸시 알림과 관련된 요청
{: #requests-related-to-push-notifications }

|                        |관리자 |배치자    |운영자    |모니터    |
|------------------------|---------------|-------------|-------------|------------|
|Java EE 보안 역할 |mfpadmin      |mfpdeployer |mfpoperator |mfpmonitor |
|GET 요청 {::nomarkdown}<ul><li>애플리케이션에 대해 푸시 알림을 사용하는 모든 디바이스 목록 가져오기</li><li>특정 디바이스의 세부사항 가져오기</li><li>등록 목록 가져오기</li><li>등록 ID와 연관된 등록 정보 가져오기</li><li>GCM 구성의 세부사항 가져오기</li><li>APNS 구성의 세부사항 가져오기</li><li>애플리케이션에 대해 정의된 태그 목록 가져오기</li><li>특정 태그의 세부사항 가져오기</li></ul>{:/}|예           |예         |예         |예        |
|POST 및 PUT 요청 {::nomarkdown}<ul><li>푸시 알림에 앱 등록</li><li>푸시 디바이스 등록 업데이트</li><li>등록 작성</li><li>GCM 구성 추가 또는 업데이트</li><li>APNS 구성 추가 또는 업데이트</li><li>디바이스에 알림 제출</li><li>업데이트 작성 또는 업데이트</li></ul>{:/} |예           |예         |예         |아니오         |
|DELETE 요청 {::nomarkdown}<ul><li>푸시 알림에 대한 디바이스 등록 삭제</li><li>등록 삭제</li><li>태그에서 디바이스 등록 취소</li><li>GCM 구성 삭제</li><li>APNS 구성 삭제</li><li>태그 삭제</li></ul>{:/} |예           |예         |아니오          |아니오         |

#### 사용 안함
{: #disabling }

|                        |관리자 |배치자    |운영자    |모니터    |
|------------------------|---------------|-------------|-------------|------------|
|Java EE 보안 역할 |mfpadmin      |mfpdeployer |mfpoperator |mfpmonitor |
|특정 디바이스를 사용 불가능하게 설정하고 해당 상태를 유실됨 또는 도난됨으로 표시하여 해당 디바이스에 있는 애플리케이션으로부터의 액세스가 차단되도록 합니다.       |예           |예         |예          |아니오        |
|특정 애플리케이션을 사용 불가능하게 설정하고 해당 상태를 사용 안함으로 표시하여 디바이스에 있는 해당 특정 애플리케이션으로부터의 액세스가 차단되도록 합니다.              |예           |예         |예         |아니오         |

LDAP와 같은 사용자 저장소를 통한 인증 방법을 사용하도록 선택하는 경우, 사용자 저장소와 함께 사용자 및 그룹을 사용하여 {{ site.data.keys.mf_server }} 관리의 ACL(Access Control List)을 정의할 수 있도록 {{ site.data.keys.mf_server }} 관리를 구성할 수 있습니다. 이 프로시저는 사용하는 웹 애플리케이션 서버의 유형 및 버전에 따라 다릅니다.

### {{ site.data.keys.mf_server }} 관리용 WebSphere Application Server 전체 프로파일 구성
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
{{ site.data.keys.mf_server }} 관리 Java EE 역할을 두 웹 애플리케이션의 사용자 세트에 맵핑하여 보안을 구성합니다.

WebSphere Application Server 콘솔에서 사용자 구성의 기본을 정의합니다. 일반적으로 다음 주소를 사용하여 콘솔에 액세스합니다. `https://localhost:9043/ibm/console/`

1. **보안 → 글로벌 보안**을 선택하십시오.
2. **보안 구성 마법사**를 선택하여 사용자를 구성하십시오.
    **사용자 및 그룹 → 사용자 관리**를 선택하여 개별 사용자 계정을 관리할 수 있습니다.
3. **mfpadmin**, **mfpdeployer**, **mfpmonitor** 및 **mfpoperator** 역할을 사용자 세트에 맵핑하십시오.
    * **서버 → 서버 유형 → WebSphere Application Server**를 선택하십시오.
    * 서버를 선택하십시오.
    * **구성** 탭에서 **애플리케이션 → 엔터프라이즈 애플리케이션**을 선택하십시오.
    * **MobileFirst_Administration_Service**를 선택하십시오.
    * **구성** 탭에서 **세부사항 → 사용자/그룹으로의 보안 역할 맵핑**을 선택하십시오.
    * 필요한 사용자 정의를 수행하십시오.
    * **확인**을 클릭하십시오.
    * 단계를 반복하여 콘솔 웹 애플리케이션의 역할을 맵핑하십시오. 이번에는 **MobileFirst_Administration_Console**을 선택하십시오.
    * **저장**을 클릭하여 변경사항을 저장하십시오.

### {{ site.data.keys.mf_server }} 관리용 WebSphere Application Server Liberty 프로파일 구성
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
WebSphere  Application Server Liberty 프로파일에서는 서버의 **server.xml** 구성 파일에 **mfpadmin**, **mfpdeployer**, **mfpmonitor** 및 **mfpoperator**의 역할을 구성합니다.

보안 역할을 구성하려면 **server.xml** 파일을 편집해야 합니다. 각 `<application>` 요소의 `<application-bnd>` 요소에서 `<security-role>` 요소를 작성하십시오. 각 `<security-role>` 요소는 **mfpadmin**, mfpdeployer, mfpmonitor 및 mfpoperator 역할 각각에 대한 것입니다. 이러한 역할을 적절한 사용자 그룹 이름(이 예에서는 **mfpadmingroup**, **mfpdeployergroup**, **mfpmonitorgroup** 또는 **mfpoperatorgroup**)에 맵핑하십시오. 이러한 그룹은 `<basicRegistry>` 요소를 통해 정의됩니다. 이 요소를 사용자 정의하거나 전체를 `<ldapRegistry>` 요소 또는 `<safRegistry>` 요소로 대체할 수 있습니다.

그런 다음, 다수의 애플리케이션(예를 들어, 80개의 애플리케이션)이 설치된 상태에서 양호한 응답 시간을 유지하기 위해 관리 데이터베이스에 대한 연결 풀을 구성해야 합니다.

1. **server.xml** 파일을 편집하십시오. 예를 들어, 다음과 같습니다.

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. **AppCenterPool** 크기를 정의하십시오.

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. `<dataSource>` 요소에서 연결 관리자에 대한 참조를 정의하십시오.

   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### {{ site.data.keys.mf_server }} 관리용 Apache Tomcat 구성
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
Apache Tomcat 웹 애플리케이션 서버에서 {{ site.data.keys.mf_server }} 관리용 Java EE 보안 역할을 구성해야 합니다.

1. {{ site.data.keys.mf_server }} 관리를 수동으로 설치한 경우, **conf/tomcat-users.xml** 파일에 다음 역할을 선언하십시오.

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. 선택된 사용자에 역할을 추가하십시오. 예를 들면, 다음과 같습니다.

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. Apache Tomcat 문서, [영역 구성 방법](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html)에 설명된 대로 사용자 세트를 정의할 수 있습니다.

## {{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성 목록
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
애플리케이션 서버에 배치되는 {{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성을 구성합니다.

* [{{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성 설정](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [{{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [{{ site.data.keys.mf_server }} 라이브 업데이트 서비스의 JNDI 특성 목록](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](#list-of-jndi-properties-for-mobilefirst-runtime)
* [{{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### {{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성 설정
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
애플리케이션 서버에 배치되는 {{ site.data.keys.mf_server }} 웹 애플리케이션을 구성하기 위해 JNDI 특성을 구성합니다.  
다음 방법 중 하나로 JNDI 환경 항목을 설정하십시오.

* 서버 환경 항목을 구성하십시오. 서버 환경 항목을 구성하는 단계는 사용하는 애플리케이션 서버에 따라 다릅니다.

    * **WebSphere  Application Server:**
        1. WebSphere Application Server 관리 콘솔에서 **애플리케이션 → 애플리케이션 유형 → WebSphere 엔터프라이즈 애플리케이션 → application_name → 웹 모듈의 환경 항목**으로 이동하십시오.
        2. 값 필드에 서버 환경에 적절한 값을 입력하십시오.

        ![WebSphere의 JNDI 환경 항목](jndi_was.jpg)
    * WebSphere Application Server Liberty:

      **liberty\_install\_dir/usr/servers/serverName**에서 **server.xml** 파일을 편집하여 JNDI 특성을 다음과 같이 선언하십시오.

      ```xml
      <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
      ```

      컨텍스트 루트(앞의 예에서 **app\_context\_root**)는 JNDI 항목과 특정 {{ site.data.keys.product_adj }} 애플리케이션을 연결합니다. 동일한 서버에 다수의 {{ site.data.keys.product_adj }} 애플리케이션이 있는 경우, 컨텍스트 경로 접두부를 사용하여 각 애플리케이션에 고유한 JNDI 항목을 정의할 수 있습니다.

      > **참고:** 일부 특성은 WebSphere Application Server Liberty에서 글로벌로 정의되고 특성 이름 앞에 컨텍스트 루트가 접두부로 추가되지 않습니다. 이러한 특성의 목록은 [글로벌 JNDI 항목](../prod-env/appserver/#global-jndi-entries)을 참조하십시오.

      다른 모든 JNDI 특성의 경우 이름 앞에 애플리케이션의 컨텍스트 루트가 접두부로 추가되어야 합니다.

       * 라이브 업데이트 서비스의 경우 컨텍스트 루트는 **/[adminContextRoot]config**여야 합니다. 예를 들어, 관리 서비스의 컨텍스트 루트가 **/mfpadmin**이면 라이브 업데이트 서비스의 컨텍스트 루트는 **/mfpadminconfig**여야 합니다.
       * 푸시 서비스의 경우 컨텍스트 루트를 **/imfpush**로 정의해야 합니다. 그렇지 않으면 컨텍스트 루트가 SDK에서 하드코딩되므로 클라이언트 디바이스가 여기에 연결될 수 없습니다.
       * {{ site.data.keys.product_adj }} Administration Service 애플리케이션, {{ site.data.keys.mf_console }} 및 {{ site.data.keys.product_adj }} 런타임의 경우, 원하는 대로 컨텍스트 루트를 정의할 수 있습니다. 그러나 기본적으로 컨텍스트 루트는 {{ site.data.keys.product_adj }} Administration Service의 경우 **/mfpadmin**이고, {{ site.data.keys.mf_console }}의 경우 **/mfpconsole**이며, {{ site.data.keys.product_adj }} 런타임의 경우 **/mfp**입니다.

      예를 들어, 다음과 같습니다.

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat:

      **tomcat\_install\_dir/conf**에서 **server.xml** 파일을 편집하여 JNDI 특성을 다음과 같이 선언하십시오.

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
      </Context>
      ```

        * JNDI 항목이 애플리케이션의 `<Context>` 요소 내부에 정의되므로 컨텍스트 경로 접두부가 필요하지 않습니다.
        * `override="false"`는 필수입니다.
        * `type` 속성은 해당 특성에 대해 다르게 지정하지 않는 한 항상 `java.lang.String`입니다.

      예를 들어, 다음과 같습니다.

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* Ant 태스크를 사용하여 설치하는 경우, 설치 시 JNDI 특성 값을 설정할 수도 있습니다.

  **mfp_install_dir/MobileFirstServer/configuration-samples**에서 Ant 태스크용 구성 XML 파일을 편집하고 다음 태그 내부에 있는 특성 요소를 사용하여 JNDI 특성의 값을 선언하십시오.

  * `<installmobilefirstadmin>`({{ site.data.keys.mf_server }} 관리, {{ site.data.keys.mf_console }} 및 라이브 업데이트 서비스용). 자세한 정보는 [{{ site.data.keys.mf_console }}, {{ site.data.keys.mf_server }} 아티팩트, {{ site.data.keys.mf_server }} 관리 및 라이브 업데이트 서비스의 설치를 위한 Ant 태스크](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)를 참조하십시오.
  * `<installmobilefirstruntime>`({{ site.data.keys.product_adj }} 런타임 구성 특성용). 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임 환경의 설치를 위한 Ant 태스크](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)를 참조하십시오.
  * `<installmobilefirstpush>`(푸시 서비스 구성용). 자세한 정보는 [{{ site.data.keys.mf_server }} 푸시 서비스의 설치를 위한 Ant 태스크](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)를 참조하십시오.

  예를 들어, 다음과 같습니다.

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### {{ site.data.keys.mf_server }} 관리 서비스의 JNDI 특성 목록
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
사용하는 애플리케이션 서버에 적합하게 {{ site.data.keys.mf_server }} 관리 서비스 및 {{ site.data.keys.mf_console }}을 구성하는 경우, 특히 JMX(Java Management Extensions)에 대해, 선택적 또는 필수 JNDI 특성을 설정합니다.

관리 서비스 웹 애플리케이션 mfp-admin-service.war에서는 다음 특성을 설정할 수 있습니다.

#### 관리 서비스의 JNDI 특성: JMX
{: #jndi-properties-for-administration-service-jmx }

|특성                 |선택사항 또는 필수 |설명 |제한사항 |
|--------------------------|-----------------------|-------------|--------------|
|mfp.admin.jmx.connector  |선택사항	           |JMX(Java Management Extensions) 커넥터 유형입니다.<br/>가능한 값은 `SOAP` 및 `RMI`입니다. 기본값은 SOAP입니다. |WebSphere  Application Server 전용. |
|            mfp.admin.jmx.host       |선택사항	           |JMX REST 연결을 위한 호스트 이름입니다. |Liberty 프로파일 전용. |
|mfp.admin.jmx.port	   |선택사항	           |JMX REST 연결을 위한 포트입니다. |Liberty 프로파일 전용. |
|            mfp.admin.jmx.user       |Liberty 프로파일 및 WebSphere Application Server 팜의 경우 필수, 그 외의 경우 선택사항 |JMX REST 연결을 위한 사용자 이름입니다. |WebSphere Application Server Liberty 프로파일: JMX REST 연결을 위한 사용자 이름입니다.<br/><br/>WebSphere Application Server 팜: SOAP 연결을 위한 사용자 이름입니다.<br/><br/>WebSphere Application Server Network Deployment: {{ site.data.keys.mf_server }} 관리 애플리케이션에 맵핑되는 가상 호스트가 기본 호스트가 아닌 경우, WebSphere 관리자의 사용자 이름입니다.<br/><br/>Liberty Collective: Liberty 제어기의 server.xml 파일에서 `<administrator-role>` 요소에 정의된 제어기 관리자의 사용자 이름입니다. |
|mfp.admin.jmx.pwd	|Liberty 프로파일 및 WebSphere Application Server 팜의 경우 필수, 그 외의 경우 선택사항 |JMX REST 연결을 위한 사용자 비밀번호입니다. |WebSphere Application Server Liberty 프로파일: JMX REST 연결을 위한 사용자 비밀번호입니다.<br/><br/>WebSphere Application Server 팜: SOAP 연결을 위한 사용자 비밀번호입니다.<br/><br/>WebSphere Application Server Network Deployment: {{ site.data.keys.mf_server }} 관리 애플리케이션에 맵핑되는 가상 호스트가 기본 호스트가 아닌 경우, WebSphere 관리자의 사용자 비밀번호입니다.<br/><br/>Liberty Collective: Liberty 제어기의 server.xml 파일에서 `<administrator-role>` 요소에 정의된 제어기 관리자의 비밀번호입니다. |
|mfp.admin.rmi.registryPort |선택사항 |방화벽을 통한 JMX 연결에 사용되는 RMI 레지스트리 포트입니다. |Tomcat 전용. |
|mfp.admin.rmi.serverPort |선택사항 |방화벽을 통한 JMX 연결에 사용되는 RMI 서버 포트입니다. |Tomcat 전용. |
|mfp.admin.jmx.dmgr.host |필수 |배치 관리자 호스트 이름입니다. |WebSphere Application Server Network Deployment 전용. |
|mfp.admin.jmx.dmgr.port |필수 |배치 관리자 RMI 또는 SOAP 포트입니다. |WebSphere Application Server Network Deployment 전용. |

#### 관리 서비스의 JNDI 특성: 제한시간
{: #jndi-properties-for-administration-service-timeout }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.actions.prepareTimeout |선택사항 |배치 트랜잭션 중 관리 서비스의 데이터를 런타임에 전송할 때의 제한시간(밀리초 단위)입니다. 이 시간 내에 런타임에 도달할 수 없는 경우, 오류가 발생하고 배치 트랜잭션이 종료됩니다.<br/><br/>기본값: 1800000ms(30분) |
|mfp.admin.actions.commitRejectTimeout |선택사항 |런타임에 접속하는 경우, 배치 트랜잭션을 커미트하거나 거부할 때의 제한시간(밀리초 단위)입니다. 이 시간 내에 런타임에 도달할 수 없는 경우, 오류가 발생하고 배치 트랜잭션이 종료됩니다.<br/><br/>기본값: 120000ms(2분) |
|mfp.admin.lockTimeoutInMillis |선택사항 |트랜잭션 잠금을 가져올 때의 제한시간(밀리초 단위)입니다. 배치 트랜잭션은 순차적으로 실행되므로 잠금을 사용합니다. 따라서 트랜잭션은 이전 트랜잭션이 완료될 때까지 대기해야 합니다. 이 제한시간은 트랜잭션이 대기하는 최대 시간입니다.<br/><br/>기본값: 1200000ms(20분) |
|mfp.admin.maxLockTimeInMillis |선택사항 |프로세스가 트랜잭션 잠금을 걸 수 있는 최대 시간입니다. 배치 트랜잭션은 순차적으로 실행되므로 잠금을 사용합니다. 잠금이 걸린 중에 애플리케이션 서버가 실패하는 경우, 다음에 애플리케이션 서버가 다시 시작될 때 잠금이 해제되지 않는 상황이 아주 드물지만 발생할 수 있습니다. 이러한 경우에는 서버가 영구 차단되지 않도록 최대 잠금 시간 이후에 잠금이 자동으로 해제됩니다. 일반적인 트랜잭션보다 긴 시간을 설정하십시오.<br/><br/>기본값: 1800000(30분) |

#### 관리 서비스의 JNDI 특성: 로깅
{: #jndi-properties-for-administration-service-logging }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.logging.formatjson |선택사항 |응답 및 로그 메시지에서 JSON 오브젝트의 Pretty 형식화를 사용하려면 이 특성을 true로 설정하십시오. 이 특성을 설정하면 서버를 디버그할 때 도움이 됩니다. 기본값: false. |
|mfp.admin.logging.tosystemerror |선택사항 |모든 로깅 메시지가 System.Error로도 경로 지정되는지 여부를 지정합니다. 이 특성을 설정하면 서버를 디버그할 때 도움이 됩니다. |

#### 관리 서비스의 JNDI 특성: 프록시
{: #jndi-properties-for-administration-service-proxies }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.proxy.port |선택사항 |{{ site.data.keys.product_adj }} 관리 서버가 방화벽 또는 리버스 프록시 뒤에 있는 경우, 이 특성은 호스트의 주소를 지정합니다. 방화벽 외부에 있는 사용자가 {{ site.data.keys.product_adj }} 관리 서버에 도달할 수 있도록 하려면 이 특성을 설정하십시오. 일반적으로 이 특성은 프록시의 포트입니다(예: 443). 외부 및 내부 URI의 프로토콜이 서로 다른 경우에만 필요합니다. |
|mfp.admin.proxy.protocol |선택사항 |{{ site.data.keys.product_adj }} 관리 서버가 방화벽 또는 리버스 프록시 뒤에 있는 경우, 이 특성은 프로토콜(HTTP 또는 HTTPS)을 지정합니다. 방화벽 외부에 있는 사용자가 {{ site.data.keys.product_adj }} 관리 서버에 도달할 수 있도록 하려면 이 특성을 설정하십시오. 일반적으로 이 특성은 프록시의 프로토콜로 설정됩니다. 예를 들면, wl.net입니다. 이 특성은 외부 및 내부 URI의 프로토콜이 서로 다른 경우에만 필요합니다. |
|mfp.admin.proxy.scheme |선택사항 |이 특성은 당지 mfp.admin.proxy.protocol의 대체 이름입니다. |
|mfp.admin.proxy.host |선택사항 |{{ site.data.keys.product_adj }} 관리 서버가 방화벽 또는 리버스 프록시 뒤에 있는 경우, 이 특성은 호스트의 주소를 지정합니다. 방화벽 외부에 있는 사용자가 {{ site.data.keys.product_adj }} 관리 서버에 도달할 수 있도록 하려면 이 특성을 설정하십시오. 일반적으로 이 특성은 프록시의 주소입니다. |

#### 관리 서비스의 JNDI 특성: 토폴로지
{: #jndi-properties-for-administration-service-topologies }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.audit |선택사항. |{{ site.data.keys.mf_console }}의 감사 기능을 사용하지 않으려면 이 특성을 false로 설정하십시오. 기본값은 true입니다. |
|mfp.admin.environmentid |선택사항. |MBean의 등록을 위한 환경 ID입니다. {{ site.data.keys.mf_server }}의 서로 다른 인스턴스가 동일한 애플리케이션 서버에 설치되는 경우 이 ID를 사용하십시오. 이 ID는 동일한 설치에 속하는 관리 서비스, 콘솔 및 런타임을 판별합니다. 관리 서비스는 환경 ID가 동일한 런타임만 관리합니다. |
|mfp.admin.serverid |서버 팜 및 Liberty Collective의 경우 필수, 그 외의 경우 선택사항 |서버 팜: 서버 ID입니다. 팜의 서버마다 달라야 합니다.<br/><br/> Liberty Collective: 값은 controller여야 합니다. |
|mfp.admin.hsts |선택사항. |RFC 6797에 따라 HTTP Strict Transport Security를 사용 가능하게 설정하려면 'true'로 설정하십시오. |
|            mfp.topology.platform |선택사항 |서버 유형입니다. 올바른 값은 다음과 같습니다.{::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}값을 설정하지 않으면 애플리케이션에서 서버 유형을 추측합니다. |
|            mfp.topology.clustermode |선택사항 |서버 유형에 더하여, 여기에 서버 토폴로지를 지정하십시오. 올바른 값은 다음과 같습니다. {::nomarkdown}<ul><li>Standalone</li><li>Cluster</li><li>Farm</li></ul>{:/}기본값은 Standalone입니다. |
|mfp.admin.farm.heartbeat |선택사항 |이 특성을 사용하면 서버 팜 토폴로지에서 사용되는 하트비트 비율을 분 단위로 설정할 수 있습니다. 기본값은 2분입니다.<br/><br/>하나의 서버 팜 내에 있는 모든 멤버는 동일한 하트비트 비율을 사용해야 합니다. 팜에 있는 하나의 서버에서 이 JNDI 값을 설정하거나 변경하는 경우, 팜의 다른 모든 서버에서도 동일한 값을 설정해야 합니다. 자세한 정보는 [서버 팜 노드의 라이프사이클](../prod-env/appserver/#lifecycle-of-a-server-farm-node)을 참조하십시오. |
|mfp.admin.farm.missed.heartbeats.timeout |선택사항 |이 특성을 사용하면 팜 멤버의 상태가 실패 또는 작동 중지로 간주되는 팜 멤버 누락 하트비트 수를 설정할 수 있습니다. 기본값은 2입니다.<br/><br/>하나의 서버 팜 내에 있는 모든 멤버는 동일한 누락 하트비트 값을 사용해야 합니다. 팜에 있는 하나의 서버에서 이 JNDI 값을 설정하거나 변경하는 경우, 팜의 다른 모든 서버에서도 동일한 값을 설정해야 합니다. 자세한 정보는 [서버 팜 노드의 라이프사이클](../prod-env/appserver/#lifecycle-of-a-server-farm-node)을 참조하십시오. |
|mfp.admin.farm.reinitialize |선택사항 |팜 멤버를 다시 등록하거나 다시 초기화하기 위한 부울 값(true 또는 false)입니다. |
|mfp.server.swagger.ui.url |선택사항 |이 특성은 관리 콘솔에 표시될 Swagger 사용자 인터페이스의 URL을 정의합니다. |

#### 관리 서비스의 JNDI 특성: 관계형 데이터베이스
{: #jndi-properties-for-administration-service-relational-database }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.db.jndi.name |선택사항 |데이터베이스의 JNDI 이름입니다. 이 매개변수는 데이터베이스를 지정하기 위한 일반 메커니즘입니다. 기본값은 **java:comp/env/jdbc/mfpAdminDS**입니다. |
|mfp.admin.db.openjpa.ConnectionDriverName |선택사항/조건부 필수 |데이터베이스 연결 드라이버 클래스의 완전한 이름입니다. **mfp.admin.db.jndi.name** 특성에 지정된 데이터 소스가 애플리케이션 서버 구성에 정의되어 있지 않는 경우에만 필수입니다. |
|mfp.admin.db.openjpa.ConnectionURL |선택사항/조건부 필수 |데이터베이스 연결의 URL입니다. **mfp.admin.db.jndi.name** 특성에 지정된 데이터 소스가 애플리케이션 서버 구성에 정의되어 있지 않는 경우에만 필수입니다. |
|mfp.admin.db.openjpa.ConnectionUserName |선택사항/조건부 필수 |데이터베이스 연결을 위한 사용자 이름입니다. **mfp.admin.db.jndi.name** 특성에 지정된 데이터 소스가 애플리케이션 서버 구성에 정의되어 있지 않는 경우에만 필수입니다. |
|mfp.admin.db.openjpa.ConnectionPassword |선택사항/조건부 필수 |데이터베이스 연결을 위한 비밀번호입니다. **mfp.admin.db.jndi.name** 특성에 지정된 데이터 소스가 애플리케이션 서버 구성에 정의되어 있지 않는 경우에만 필수입니다. |
|mfp.admin.db.openjpa.Log |선택사항 |이 특성은 OpenJPA에 전달되며 JPA 로깅을 사용으로 설정합니다. 자세한 정보는 [Apache OpenJPA 사용자 안내서](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html)를 참조하십시오. |
|mfp.admin.db.type |선택사항 |이 특성은 데이터베이스 유형을 정의합니다. 기본값은 연결 URL에서 추론됩니다. |

#### 관리 서비스의 JNDI 특성: 라이센싱
{: #jndi-properties-for-administration-service-licensing }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.license.key.server.host	| {::nomarkdown}<ul><li>영구적 라이센스의 경우 선택사항</li><li>토큰 라이센스의 경우 필수</li></ul>{:/} |Rational  License Key Server의 호스트 이름입니다. |
|mfp.admin.license.key.server.port	| {::nomarkdown}<ul><li>영구적 라이센스의 경우 선택사항</li><li>토큰 라이센스의 경우 필수</li></ul>{:/} |Rational License Key Server의 포트 번호입니다. |

#### 관리 서비스의 JNDI 특성: JNDI 구성
{: #jndi-properties-for-administration-service-jndi-configurations }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.jndi.configuration |선택사항 |WAR 파일에 삽입된 특성 파일에서 JNDI 특성(이 특성 제외)을 읽어야 하는 경우 JNDI 구성의 이름입니다. 이 특성을 설정하지 않는 경우 JNDI 특성은 특성 파일에서 읽히지 않습니다. |
|mfp.jndi.file |선택사항 |웹 서버에 설치된 파일에서 JNDI 특성(이 특성 제외)을 읽어야 하는 경우 JNDI 구성이 포함된 파일의 이름입니다. 이 특성을 설정하지 않는 경우 JNDI 특성은 특성 파일에서 읽히지 않습니다. |

관리 서비스는 라이브 업데이트 서비스를 보조 기능으로 사용하여 다양한 구성을 저장합니다. 이러한 특성을 사용하여 라이브 업데이트 서비스에 도달하는 방법을 구성하십시오.

#### 관리 서비스의 JNDI 특성: 라이브 업데이트 서비스
{: #jndi-properties-for-administration-service-live-update-service }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.config.service.url |선택사항. 라이브 업데이트 서비스의 URL입니다. 기본 URL은 관리 서비스의 컨텍스트 루트에 config를 추가함으로써 관리 서비스의 URL에서 파생됩니다. |
|mfp.config.service.user |필수 |라이브 업데이트 서비스에 액세스하는 데 사용되는 사용자 이름입니다. 서버 팜 토폴로지에서는 팜에 있는 모든 멤버의 사용자 이름이 동일해야 합니다. |
|mfp.config.service.password |필수 |라이브 업데이트 서비스에 액세스하는 데 사용되는 비밀번호입니다. 서버 팜 토폴로지에서는 팜에 있는 모든 멤버의 비밀번호가 동일해야 합니다. |
|mfp.config.service.schema |선택사항 |라이브 업데이트 서비스에서 사용되는 스키마의 이름입니다. |

관리 서비스는 푸시 서비스를 보조 기능으로 사용하여 다양한 푸시 설정을 저장합니다. 이러한 특성을 사용하여 푸시 서비스에 도달하는 방법을 구성하십시오. 푸시 서비스는 OAuth 보안 모델에 의해 보호되므로 OAuth에서 기밀 클라이언트를 사용하려면 다양한 특성을 설정해야 합니다.

#### 관리 서비스의 JNDI 특성: 푸시 서비스
{: #jndi-properties-for-administration-service-push-service }

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.push.url |선택사항 |푸시 서비스의 URL입니다. 이 특성이 지정되어 있지 않으면 푸시 서비스가 사용되지 않는 것으로 간주됩니다. 이 특성을 적절히 설정하지 않으면 관리 서비스는 푸시 서비스에 접속할 수 없으며 {{ site.data.keys.mf_console }}에서의 푸시 서비스 관리가 작동하지 않습니다. |
|mfp.admin.authorization.server.url |선택사항 |푸시 서비스에서 사용하는 OAuth 권한 부여 서버의 URL입니다. 기본 URL은 컨텍스트 루트를 첫 번째로 설치된 런타임의 컨텍스트 루트로 변경함으로써 관리 서비스의 URL에서 파생됩니다. 여러 런타임을 설치하는 경우 이 특성을 설정하는 것이 가장 좋습니다. 이 특성을 적절히 설정하지 않으면 관리 서비스는 푸시 서비스에 접속할 수 없으며 {{ site.data.keys.mf_console }}에서의 푸시 서비스 관리가 작동하지 않습니다. |
|mfp.push.authorization.client.id |선택사항/조건부 필수 |푸시 서비스에 대한 OAuth 권한 부여를 처리하는 기밀 클라이언트의 ID입니다. **mfp.admin.push.url** 특성이 지정된 경우에만 필수입니다. |
|mfp.push.authorization.client.secret |선택사항/조건부 필수 |푸시 서비스에 대한 OAuth 권한 부여를 처리하는 기밀 클라이언트의 시크릿입니다. **mfp.admin.push.url** 특성이 지정된 경우에만 필수입니다. |
|mfp.admin.authorization.client.id |선택사항/조건부 필수 |관리 서비스에 대한 OAuth 권한 부여를 처리하는 기밀 클라이언트의 ID입니다. **mfp.admin.push.url** 특성이 지정된 경우에만 필수입니다. |
|mfp.admin.authorization.client.secret |선택사항/조건부 필수 |관리 서비스에 대한 OAuth 권한 부여를 처리하는 기밀 클라이언트의 시크릿입니다. **mfp.admin.push.url** 특성이 지정된 경우에만 필수입니다. |

### {{ site.data.keys.mf_console }}의 JNDI 특성
{: #jndi-properties-for-mobilefirst-operations-console }
{{ site.data.keys.mf_console }}의 웹 애플리케이션(mfp-admin-ui.war)에서 다음 특성을 설정할 수 있습니다.

|특성                 |선택사항 또는 필수 |설명  |
|--------------------------|-----------------------|--------------|
|mfp.admin.endpoint |선택사항 |{{ site.data.keys.mf_console }}에서 {{ site.data.keys.mf_server }} 관리 REST 서비스를 찾을 수 있도록 합니다. **mfp-admin-service.war** 웹 애플리케이션의 외부 주소 및 컨텍스트 루트를 지정하십시오. 방화벽 또는 안전한 리버스 프록시가 있는 시나리오에서는 이 URI가 로컬 LAN 내의 내부 URI가 아닌 외부 URI여야 합니다. 예: https://wl.net:443/mfpadmin. |
|mfp.admin.global.logout |선택사항 |콘솔 로그아웃 중 WebSphere 사용자 인증 캐시를 지웁니다. 이 특성은 WebSphere Application Server V7에만 유용합니다. 기본값은 false입니다. |
|mfp.admin.hsts |선택사항 |RFC 6797에 따라 HTTP [Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security)를 사용 가능하게 설정하려면 이 특성을 true로 설정하십시오. 자세한 정보는 W3C Strict Transport Security 페이지를 참조하십시오. 기본값은 false입니다. |
|mfp.admin.ui.cors |선택사항 |기본값은 true입니다. 자세한 정보는 [W3C Cross-Origin Resource Sharing 페이지](http://www.w3.org/TR/cors/)를 참조하십시오. |
|mfp.admin.ui.cors.strictssl |선택사항 |{{ site.data.keys.mf_console }}은 SSL(HTTPS 프로토콜)로 보호되지만 {{ site.data.keys.mf_server }} 관리 서비스는 보호되지 않는 CORS 상황이나 이와 반대되는 CORS 상황을 허용하려면 false로 설정하십시오. 이 특성은 **mfp.admin.ui.cors** 특성이 사용되는 경우에만 적용됩니다. |

### {{ site.data.keys.mf_server }} 라이브 업데이트 서비스의 JNDI 특성 목록
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
사용하는 애플리케이션 서버에 적합하게 {{ site.data.keys.mf_server }} 라이브 업데이트 서비스를 구성하는 경우 다음 JNDI 특성을 설정할 수 있습니다. 다음 표에서는 IBM  관계형 데이터베이스 라이브 업데이트 서비스의 JNDI 특성을 나열합니다.

|특성 |선택사항 또는 필수 |설명 |
|----------|-----------------------|-------------|
|mfp.db.relational.queryTimeout |선택사항 |RDBMS에서 조회를 실행할 때의 제한시간(초 단위)입니다. 0의 값은 제한시간이 무한임을 의미합니다. 음수 값은 기본값(대체하지 않음)을 의미합니다.<br/><br/>값이 구성되어 있지 않는 경우 기본값이 사용됩니다. 자세한 정보는 [setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int)을 참조하십시오. |

이러한 특성의 설정 방법에 대해서는 [{{ site.data.keys.mf_server }} 웹 애플리케이션의 JNDI 특성 설정](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)을 참조하십시오.

### {{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록
{: #list-of-jndi-properties-for-mobilefirst-runtime }
사용하는 애플리케이션 서버에 적합하게 {{ site.data.keys.mf_server }} 런타임을 구성하는 경우 선택적 또는 필수 JNDI 특성을 설정해야 합니다.  
다음 표에는 JNDI 항목으로 항상 사용할 수 있는 {{ site.data.keys.product_adj }} 특성을 나열합니다.

|특성 |설명 |
|----------|-------------|
|mfp.admin.jmx.dmgr.host |필수. 배치 관리자의 호스트 이름입니다. WebSphere Application Server Network Deployment 전용. |
|mfp.admin.jmx.dmgr.port |필수. 배치 관리자의 RMI 또는 SOAP 포트입니다. WebSphere Application Server Network Deployment 전용. |
|            mfp.admin.jmx.host |Liberty 전용. JMX REST 연결을 위한 호스트 이름입니다. Liberty Collective의 경우, 제어기의 호스트 이름을 사용하십시오. |
|            mfp.admin.jmx.port |Liberty 전용. JMX REST 연결을 위한 포트 번호입니다. Liberty Collective의 경우, REST 커넥터의 포트는 `<httpEndpoint>` 요소에 선언된 httpsPort 속성의 값과 동일해야 합니다. 이 요소는 Liberty 제어기의 server.xml 파일에서 선언됩니다. |
|            mfp.admin.jmx.user |선택사항. WebSphere Application Server 팜: SOAP 연결의 사용자 이름입니다.<br/><br/>Liberty Collective: Liberty 제어기의 server.xml 파일에서 `<administrator-role>` 요소에 정의된 제어기 관리자의 사용자 이름입니다. |
|            mfp.admin.jmx.pwd |선택사항. WebSphere Application Server 팜: SOAP 연결의 사용자 비밀번호입니다.<br/><br/>Liberty Collective: Liberty 제어기의 server.xml 파일에서 `<administrator-role>` 요소에 정의된 제어기 관리자의 비밀번호입니다. |
|mfp.admin.serverid |서버 팜 및 Liberty Collective의 경우 필수, 그 외의 경우 선택사항<br/><br/>서버 팜: 서버 ID입니다. 팜의 서버마다 달라야 합니다.<br/><br/>Liberty Collective: 멤버 ID입니다. ID는 집합의 멤버마다 달라야 합니다. controller 값은 집합 제어기용으로 예약되어 있으므로 사용할 수 없습니다. |
|            mfp.topology.platform |선택사항. 서버 유형입니다. 올바른 값은 다음과 같습니다.<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>값을 설정하지 않으면 애플리케이션에서 서버 유형을 추측합니다. |
|            mfp.topology.clustermode |선택사항. 서버 유형에 더하여, 여기에 서버 토폴로지를 지정하십시오. 올바른 값은 다음과 같습니다.<ul><li>Standalone<li>Cluster</li><li>Farm</li></ul>기본값은 Standalone입니다. |
|mfp.admin.jmx.replica |선택사항. Liberty Collective 전용.<br/><br/>이 런타임을 관리하는 관리 컴포넌트가 서로 다른 Liberty 제어기(복제본)에 배치된 경우에만 이 특성을 설정하십시오.<br/><br/>서로 다른 제어기 복제본의 엔드포인트 목록(`replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` 구문을 사용함) |
|mfp.analytics.console.url |선택사항. Analytics 콘솔에 링크하는 URL입니다. 이 URL은 IBM {{ site.data.keys.mf_analytics }}에 의해 공개됩니다. {{ site.data.keys.mf_console }}에서 Analytics 콘솔에 액세스하려는 경우 이 특성을 설정하십시오. 예를 들어, `http://<hostname>:<port>/analytics/console`입니다. |
|mfp.analytics.password |IBM {{ site.data.keys.mf_analytics }}의 데이터 시작점이 기본 인증으로 보호되는 경우에 사용되는 비밀번호입니다. |
|mfp.analytics.url |수신 분석 데이터를 받는 URL입니다. 이 URL은 IBM {{ site.data.keys.mf_analytics }}에 의해 공개됩니다. 예를 들어, `http://<hostname>:<port>/analytics-service/rest`입니다. |
|mfp.analytics.username |IBM {{ site.data.keys.mf_analytics }}의 데이터 시작점이 기본 인증으로 보호되는 경우에 사용되는 사용자 이름입니다.|
|mfp.device.decommissionProcessingInterval |해제 태스크가 실행되는 빈도(초)를 정의합니다. 기본값: 86400(1일). |
|mfp.device.decommission.when |클라이언트 디바이스가 디바이스 해제 태스크에 의해 해제될 때까지의 비활성 일 수입니다. 기본값: 90일. |
|mfp.device.archiveDecommissioned.when |해제된 클라이언트 디바이스가 아카이브될 때까지의 비활성 일 수입니다.<br/><br/>이 태스크는 해제된 클라이언트 디바이스를 아카이브 파일에 기록합니다. 아카이브된 클라이언트 디바이스는 {{ site.data.keys.mf_server }} **home\devices_archive** 디렉토리에 있는 파일에 기록됩니다. 이 파일의 이름에는 아카이브 파일 작성 시의 시간소인이 포함됩니다. 기본값: 90일. |
|mfp.licenseTracking.enabled |{{ site.data.keys.product }}에서 디바이스 추적을 사용 가능 또는 사용 불가능하게 설정하는 데 사용되는 값입니다.<br/><br/>성능상의 이유로, {{ site.data.keys.product }}이 B2C(Business-to-Consumer) 앱만 실행하는 경우 디바이스 추적을 사용 불가능하게 설정할 수 있습니다. 디바이스 추적이 사용되지 않는 경우, 라이센스 보고서도 사용되지 않고 라이센스 메트릭이 생성되지 않습니다.<br/><br/>가능한 값은 true(기본값) 및 false입니다. |
|mfp.runtime.temp.folder |런타임 임시 파일 폴더를 정의합니다. 설정되지 않은 경우, 웹 컨테이너의 기본 임시 폴더 위치를 사용합니다. |
|mfp.adapter.invocation.url |REST 엔드포인트를 사용하여 호출되는 JavaScript 어댑터 또는 Java 어댑터 내부에서 어댑터 프로시저를 호출하는 데 사용되는 URL입니다. 이 특성을 설정하지 않으면 현재 실행 중인 요청의 URL이 사용됩니다(이 동작이 기본 동작입니다). 이 값은 컨텍스트 루트를 비롯하여 전체 URL을 포함해야 합니다. |
|mfp.authorization.server |권한 부여 서버 모드입니다. 다음 모드 중 하나일 수 있습니다.{::nomarkdown}<ul><li>embedded: {{ site.data.keys.product_adj }} 권한 부여 서버를 사용합니다.</li><li>external: 외부 권한 부여 서버를 사용합니다.</li></ul>{:/}. 이 값을 설정하는 경우, 사용하는 외부 서버의 **mfp.external.authorization.server.secret** 및 **mfp.external.authorization.server.introspection.url** 특성도 설정해야 합니다. |
|mfp.external.authorization.server.secret |외부 권한 부여 서버의 시크릿입니다. 이 특성은 외부 권한 부여 서버를 사용하는 경우, 즉 **mfp.authorization.server**가 external로 설정된 경우 필수이며, 그렇지 않은 경우에는 무시됩니다. |
|mfp.external.authorization.server.introspection.url |외부 권한 부여 서버의 인트로스펙션 엔드포인트의 URL입니다. 이 특성은 외부 권한 부여 서버를 사용하는 경우, 즉 **mfp.authorization.server**가 **external**로 설정된 경우 필수이며, 그렇지 않은 경우에는 무시됩니다. |
|ssl.websphere.config |HTTP 어댑터에 대한 키 저장소를 구성하는 데 사용됩니다. false(기본값)로 설정된 경우, {{ site.data.keys.product_adj }} 런타임에 {{ site.data.keys.product_adj }} 키 저장소를 사용하도록 지시합니다. true로 설정된 경우, {{ site.data.keys.product_adj }} 런타임에 WebSphere SSL 구성을 사용하도록 지시합니다. 자세한 정보는 [WebSphere Application Server SSL 구성 및 HTTP 어댑터](#websphere-application-server-ssl-configuration-and-http-adapters)를 참조하십시오. |

### {{ site.data.keys.mf_server }} 푸시 서비스의 JNDI 특성 목록
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

|특성 |선택사항 또는 필수 |설명 |
|----------|-----------------------|-------------|
|mfp.push.db.type |선택사항 |데이터베이스 유형입니다. 가능한 값: DB, CLOUDANT. 기본값: DB |
|mfp.push.db.queue.connections |선택사항 |데이터베이스 조작을 수행하는 스레드 풀의 스레드 수입니다. 기본값: 3 |
|mfp.push.db.cloudant.url |선택사항 |Cloudant  계정 URL입니다. 이 특성이 정의된 경우, Cloudant DB는 이 URL로 경로 지정됩니다. |
|mfp.push.db.cloudant.dbName |선택사항 |Cloudant 계정의 데이터베이스 이름입니다. 소문자로 시작해야 하며 소문자와 숫자, 그리고 문자 _, $ 및 -로만 구성되어야 합니다. 기본값: mfp\_push\_db |
|mfp.push.db.cloudant.username |선택사항 |데이터베이스를 저장하는 데 사용되는 Cloudant 계정의 사용자 이름입니다. 이 특성이 정의되어 있지 않는 경우에는 관계형 데이터베이스가 사용됩니다. |
|mfp.push.db.cloudant.password |선택사항 |데이터베이스를 저장하는 데 사용되는 Cloudant 계정의 비밀번호입니다. mfp.db.cloudant.username이 설정된 경우 이 특성을 설정해야 합니다. |
|mfp.push.db.cloudant.doc.version |선택사항 |Cloudant 문서 버전입니다. |
|mfp.push.db.cloudant.socketTimeout |선택사항	|Cloudant의 네트워크 연결 유실을 발견할 때의 제한시간(밀리초)입니다. 0의 값은 제한시간이 무한임을 의미합니다. 음수 값은 기본값(대체하지 않음)을 의미합니다. 기본값. [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)을 참조하십시오. |
|mfp.push.db.cloudant.connectionTimeout |선택사항	|Cloudant의 네트워크 연결을 설정할 때의 제한시간(밀리초)입니다. 0의 값은 제한시간이 무한임을 의미합니다. 음수 값은 기본값(대체하지 않음)을 의미합니다. 기본값. [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)을 참조하십시오. |
|mfp.push.db.cloudant.maxConnections |선택사항 |Cloudant 커넥터의 최대 연결 수입니다. 기본값. [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)을 참조하십시오. |
|mfp.push.db.cloudant.ssl.authentication |선택사항 |Cloudant 데이터베이스로의 HTTPS 연결에 대해 SSL 인증서 체인 유효성 검증 및 호스트 이름 유효성 검증이 사용되는지 여부를 지정하는 부울 값(true 또는 false)입니다. 기본값: True |
|mfp.push.db.cloudant.ssl.configuration |선택사항	|(WAS 전체 프로파일 전용) Cloudant 데이터베이스로의 HTTPS 연결의 경우: 호스트 및 포트에 대한 구성이 지정되어 있지 않는 경우에 사용할 WebSphere  Application Server 구성 내 SSL 구성의 이름입니다. |
|mfp.push.db.cloudant.proxyHost |선택사항	|Cloudant 커넥터의 프록시 호스트입니다. 기본값: [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)을 참조하십시오. |
|mfp.push.db.cloudant.proxyPort |선택사항	|Cloudant 커넥터의 프록시 포트입니다. 기본값: [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration)을 참조하십시오. |
|mfp.push.services.ext.security |선택사항	|보안 확장 플러그인입니다. |
|mfp.push.security.endpoint |선택사항	|권한 부여 서버의 엔드포인트 URL입니다. |
|mfp.push.security.user |선택사항	|권한 부여 서버에 액세스하기 위한 사용자 이름입니다. |
|mfp.push.security.password |선택사항	|권한 부여 서버에 액세스하기 위한 비밀번호입니다. |
|mfp.push.services.ext.analytics |선택사항 |분석 확장 플러그인입니다. |
|mfp.push.analytics.endpoint |선택사항 |분석 서버의 엔드포인트 URL입니다. |
|mfp.push.analytics.user |선택사항 |분석 서버에 액세스하기 위한 사용자 이름입니다. |
|mfp.push.analytics.password |선택사항 |분석 서버에 액세스하기 위한 비밀번호입니다. |
|mfp.push.analytics.events.notificationDispatch |선택사항	|알림이 디스패치되려 할 때의 분석 이벤트입니다. 기본값: true |
|mfp.push.internalQueue.maxLength |선택사항 |디스패치 전에 알림 태스크를 보유하는 큐의 길이입니다. 기본값: 200000 |
|mfp.push.gcm.proxy.enabled |선택사항	|프록시를 통해 Google GCM에 액세스해야 하는지 여부를 표시합니다. 기본값: false |
|mfp.push.gcm.proxy.protocol |선택사항 |HTTP 또는 HTTPS일 수 있습니다. |
|mfp.push.gcm.proxy.host |선택사항 |GCM 프록시 호스트입니다. 음수 값은 기본 포트를 의미합니다. |
|mfp.push.gcm.proxy.port |선택사항 |GCM 프록시 포트입니다. 기본값: -1 |
|mfp.push.gcm.proxy.user |선택사항 |프록시에서 인증이 필요한 경우, 프록시 사용자 이름입니다. 사용자 이름이 비어 있으면 인증이 없음을 의미합니다. |
|mfp.push.gcm.proxy.password |선택사항 |프록시에서 인증이 필요한 경우, 프록시 비밀번호입니다. |
|mfp.push.gcm.connections |선택사항 |푸시 GCM 최대 연결 수입니다. 기본값: 10 |
|mfp.push.apns.proxy.enabled |선택사항 |프록시를 통해 APN에 액세스해야 하는지 여부를 표시합니다. 기본값: false |
|mfp.push.apns.proxy.type |선택사항 |APN 프록시 유형입니다. |
|mfp.push.apns.proxy.host |선택사항 |APN 프록시 호스트입니다. |
|mfp.push.apns.proxy.port |선택사항 |APN 프록시 포트입니다. 기본값: -1 |
|mfp.push.apns.proxy.user |선택사항 |프록시에서 인증이 필요한 경우, 프록시 사용자 이름입니다. 사용자 이름이 비어 있으면 인증이 없음을 의미합니다. |
|mfp.push.apns.proxy.password |선택사항 |프록시에서 인증이 필요한 경우, 프록시 비밀번호입니다. |
|mfp.push.apns.connections |선택사항 |푸시 APN 최대 연결 수입니다. 기본값: 3 |
|mfp.push.apns.connectionIdleTimeout |선택사항 |APN 유휴 연결 제한시간입니다. 기본값: 0 |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## 데이터 소스 구성
{: #configuring-data-sources }
지원되는 데이터베이스와 관련된 일부 데이터 소스 구성 세부사항에 대해 설명합니다.

* [DB2 트랜잭션 로그 크기 관리](#managing-the-db2-transaction-log-size)
* [{{ site.data.keys.mf_server }} 및 Application Center 데이터 소스에 대한 DB2 HADR 심리스(seamless) 장애 복구 구성](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [시간이 경과된(stale) 연결 처리](#handling-stale-connections)
* [{{ site.data.keys.mf_console }}에서 앱 작성 또는 삭제 후 시간이 경과된(stale) 데이터](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### DB2 트랜잭션 로그 크기 관리
{: #managing-the-db2-transaction-log-size }
IBM {{ site.data.keys.mf_console }}에서 40MB 이상의 애플리케이션을 배치하면 트랜잭션 로그 가득 참 오류를 수신할 수 있습니다.

다음 시스템 출력은 트랜잭션 로그 가득 참 오류 코드의 예입니다.

```bash
DB2 SQL Error: SQLCODE=-964, SQLSTATE=57011
```

각 애플리케이션의 컨텐츠는 {{ site.data.keys.product_adj }} 관리 데이터베이스에 저장됩니다.

활성 로그 파일의 수는 **LOGPRIMARY** 및 **LOGSECOND** 데이터베이스 구성 매개변수로 정의되고, 크기는 **LOGFILSIZ** 데이터베이스 구성 매개변수로 정의됩니다. 단일 트랜잭션은 **LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096KB보다 많은 로그 공간을 사용할 수 없습니다.

`DB2 GET DATABASE CONFIGURATION` 명령에는 로그 파일 크기와 1차 및 2차 로그 파일의 수에 대한 정보가 포함되어 있습니다.

배치되는 {{ site.data.keys.product_adj }} 애플리케이션의 최대 크기에 따라 DB2  로그 공간을 증가시켜야 할 수도 있습니다.

`DB2 update db cfg` 명령을 사용하여 **LOGSECOND** 매개변수를 늘리십시오. 데이터베이스가 활성화된 경우 공간이 할당되지 않습니다. 대신 필요한 경우에만 공간이 할당됩니다.

### {{ site.data.keys.mf_server }} 및 Application Center 데이터 소스에 대한 DB2 HADR 심리스(seamless) 장애 복구 구성
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
WebSphere  Application Server Liberty 프로파일 및 WebSphere Application Server에서 심리스(seamless) 장애 복구 기능을 사용 가능하게 설정해야 합니다. 이 기능을 사용하면 데이터베이스가 장애 복구되고 DB2  JDBC 드라이버에 의해 경로 재지정되는 경우 예외를 관리할 수 있습니다.

> **참고:** Apache Tomcat에 대해서는 DB2 HADR 장애 복구가 지원되지 않습니다.

DB2 HADR을 사용하는 경우, 기본적으로 DB2 JDBC 드라이버는 기존 연결을 다시 사용하기 위한 첫 번째 시도 중 데이터베이스가 장애 복구되었음을 발견한 후 클라이언트 경로 재지정을 수행할 때 **ERRORCODE=-4498** 및 **SQLSTATE=08506**과 함께 **com.ibm.db2.jcc.am.ClientRerouteException**을 트리거합니다. WebSphere Application Server는 이 예외를, 애플리케이션이 수신하기 전에, **com.ibm.websphere.ce.cm.StaleConnectionException**에 맵핑합니다.

이 경우, 애플리케이션은 이 예외를 발견하여 트랜잭션을 다시 실행해야 합니다. {{ site.data.keys.product_adj }} 및 Application Center 런타임 환경에서는 이 예외를 관리하지는 않지만 심리스(seamless) 장애 복구라는 기능을 활용합니다. 이 기능을 사용하려면 **enableSeamlessFailover** JDBC 특성을 "1"로 설정해야 합니다.

#### WebSphere Application Server Liberty 프로파일 구성
{: #websphere-application-server-liberty-profile-configuration }
**server.xml** 파일을 편집하고 {{ site.data.keys.product_adj }} 및 Application Center 데이터 소스의 **properties.db2.jcc** 요소에 **enableSeamlessFailover** 특성을 추가해야 합니다. 예를 들어, 다음과 같습니다.

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### WebSphere Application Server 구성
{: #websphere-application-server-configuration }
각 {{ site.data.keys.product_adj }} 및 Application Center 데이터 소스의 WebSphere Application Server 관리 콘솔에서 다음을 수행하십시오.

1. **자원 → JDBC → 데이터 소스 → 데이터 소스 이름**으로 이동하십시오.
2. **새로 작성**을 선택하여 다음 사용자 정의 특성을 추가하거나, 이 특성이 이미 있는 경우 값을 업데이트하십시오. `enableSeamlessFailover : 1`
3. **적용**을 클릭하십시오.
4. 구성을 저장합니다.

HADR 사용 DB2 데이터베이스로의 연결을 구성하는 방법에 대한 자세한 정보는
[HADR 사용 DB2 데이터베이스로의 연결 설정](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=en)을 참조하십시오.

### 시간이 경과된(stale) 연결 처리
{: #handling-stale-connections }
데이터베이스 제한시간 초과 문제가 발생하지 않도록 애플리케이션 서버를 구성합니다.

**StaleConnectionException**은 JDBC 드라이버가 연결 요청 또는 조작에서 복구 불가능한 오류를 리턴할 때 Java 애플리케이션 서버 프로파일 데이터베이스 연결 코드에 의해 생성되는 예외입니다. 데이터베이스 공급업체가 현재 연결 풀에 있는 연결이 더 이상 유효하지 않음을 나타내는 예외를 발행하면 **StaleConnectionException**이 발생합니다. 이 예외는 여러 가지 이유로 발생할 수 있습니다. **StaleConnectionException**의 가장 일반적인 원인은 데이터베이스 연결 풀에서 연결을 검색한 결과 오랜 시간 동안 사용하지 않아 연결이 제한시간을 초과했거나 삭제된 것으로 판명되었기 때문입니다.

이 예외가 발생하지 않도록 애플리케이션 서버를 구성할 수 있습니다.

#### Apache Tomcat 구성
{: #apache-tomcat-configuration }
**MySQL**  
MySQL 데이터베이스는 연결이 일정 기간 비활성 상태이면 해당 연결을 닫습니다. 이러한 제한시간은 **wait_timeout**이라는 시스템 변수에 의해 정의됩니다. 기본값은 28000초(8시간)입니다.

MySQL이 연결을 닫은 후 애플리케이션에서 데이터베이스에 연결하려고 시도하는 경우 다음 예외가 생성됩니다.

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

**server.xml** 및 **context.xml** 파일을 편집하고 각 `<Resource>` 요소에 다음 특성을 추가하십시오.

* **testOnBorrow="true"**
* **validationQuery="select 1"**

예를 들어, 다음과 같습니다.

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### WebSphere Application Server Liberty 프로파일 구성
{: #websphere-application-server-liberty-profile-configuration-1 }
**server.xml** 파일을 편집하고 각 `<dataSource>` 요소(런타임 및 Application Center 데이터베이스)에 agedTimeout 특성이 지정된 `<connectionManager>` 요소를 추가하십시오.

```xml
<connectionManager agedTimeout="timeout_value"/>
```

제한시간 값은 주로 동시에 열려 있는 연결 수에 따라 달라지지만 풀에 있는 최소 및 최대 연결 수에 따라서도 달라집니다. 따라서 다양한 **connectionManager** 속성을 조정하여 가장 적합한 값을 식별해야 합니다. **connectionManager** 요소에 대한 자세한 정보는 [Liberty: **server.xml** 파일의 구성 요소](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html)를 참조하십시오.

> **참고:** MySQL과 WebSphere Application Server Liberty 프로파일 또는 WebSphere Application Server 전체 프로파일의 조합은 지원되는 구성으로 분류되지 않습니다. 자세한 정보는 [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)를 참조하십시오. IBM  DB2 를 사용하거나 WebSphere Application Server에서 지원하는 다른 데이터베이스를 사용하여 IBM 지원 센터에서 완전하게 지원하는 구성의 이점을 활용할 수 있습니다.

### {{ site.data.keys.mf_console }}에서 앱 작성 또는 삭제 후 시간이 경과된(stale) 데이터
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
Tomcat 8 애플리케이션 서버에서 MySQL 데이터베이스를 사용하는 경우, {{ site.data.keys.mf_console }}에서 서비스를 호출할 때 일부 호출에서 404 오류를 리턴합니다.

Tomcat 8 애플리케이션 서버에서 MySQL 데이터베이스를 사용하여 작업하는 경우, {{ site.data.keys.mf_console }}을 사용하여 앱을 삭제하거나 새 앱을 추가하고 콘솔을 여러 번 새로 고칠 때 시간이 경과된(stale) 데이터가 표시될 수 있습니다. 예를 들어, 이미 삭제된 앱이 목록에 표시될 수 있습니다.

이러한 문제점이 발생하지 않도록 하려면, 데이터 소스 또는 데이터베이스 관리 시스템에서 격리 레벨을 **READ_COMMITTED**로 변경하십시오.

**READ_COMMITTED**의 의미에 대해서는 [http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html)에 있는 [MySQL 문서](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc)를 참조하십시오.

* 데이터 소스에서 격리 레벨을 **READ_COMMITTED**로 변경하려면 **server.xml** Tomcat 구성 파일을 다음과 같이 수정하십시오. **<Resource name="jdbc/mfpAdminDS" .../>** 섹션에서 **defaultTransactionIsolation="READ_COMMITTED"** 속성을 추가하십시오.
* 데이터베이스 관리 시스템에서 글로벌로 격리 레벨을 **READ_COMMITTED**로 변경하려면 [http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html)에 있는 MySQL 문서의 [SET TRANSACTION 구문 페이지](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html)를 참조하십시오.

#### WebSphere Application Server 전체 프로파일 구성
{: #websphere-application-server-full-profile-configuration }
**DB2 또는 Oracle**  
시간이 경과된(stale) 연결 문제를 최소화하려면 WebSphere Application Server 관리 콘솔에서 각 데이터 소스의 연결 풀 구성을 검사하십시오.

1. WebSphere Application Server 관리 콘솔에 로그인하십시오.
2. **자원 → JDBC 제공자 → database_jdbc_provider → 데이터 소스 → your_data_source → 연결 풀 특성**을 선택하십시오.
3. **최소 연결 수** 값을 0으로 설정하십시오.
4. **립(Reap) 시간** 값을 **미사용 제한시간** 값 미만으로 설정하십시오.
5. **영구 제거 정책** 특성이 **EntirePool(기본값)**로 설정되어 있는지 확인하십시오.

자세한 정보는 [연결 풀 설정](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html)을 참조하십시오.

**MySQL**  

1. WebSphere Application Server 관리 콘솔에 로그인하십시오.
2. **자원 → JDBC → 데이터 소스**를 선택하십시오.
3. 각 MySQL 데이터 소스에 대해 다음을 수행하십시오.
    * 데이터 소스를 클릭하십시오.
    * **추가 특성** 아래의 **연결 풀 특성**을 선택하십시오.
    * **경과된 제한시간** 특성의 값을 수정하십시오. MySQL이 연결을 닫기 전에 이러한 연결이 제거되도록 하려면 이 값이 MySQL **wait_timeout** 시스템 변수보다 낮아야 합니다.
    * **확인**을 클릭하십시오.

> **참고:** MySQL과 WebSphere Application Server Liberty 프로파일 또는 WebSphere Application Server 전체 프로파일의 조합은 지원되는 구성으로 분류되지 않습니다. 자세한 정보는 [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311)를 참조하십시오. IBM  DB2 를 사용하거나 WebSphere Application Server에서 지원하는 다른 데이터베이스를 사용하여 IBM 지원 센터에서 완전하게 지원하는 구성의 이점을 활용할 수 있습니다.

## 로깅 및 모니터링 메커니즘 구성
{: #configuring-logging-and-monitoring-mechanisms }
{{ site.data.keys.product }}은 오류, 경고 및 정보 메시지를 로그 파일에 기록합니다. 기본 로깅 메커니즘은 애플리케이션에 따라 다릅니다.

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.product }}(줄여서 {{ site.data.keys.mf_server }})는 표준 java.util.logging 패키지를 사용합니다. 기본적으로 모든 {{ site.data.keys.product_adj }} 로깅은 애플리케이션 서버 로그 파일로 이동합니다. 각 애플리케이션 서버에서 사용 가능한 표준 도구를 사용하여 {{ site.data.keys.mf_server }} 로깅을 제어할 수 있습니다. 예를 들어, WebSphere  Application Server Liberty에서 추적 로깅을 활성화하려는 경우 server.xml 파일에 추적 요소를 추가하십시오. WebSphere Application Server에서 추적 로깅을 활성화하려면 콘솔의 로깅 화면을 사용하여 {{ site.data.keys.product_adj }} 로그의 추적을 사용 가능하게 설정하십시오.

{{ site.data.keys.product_adj }} 로그는 모두 **com.ibm.mfp**로 시작합니다.  
Application Center 로그는 **com.ibm.puremeap**로 시작합니다.

로그 파일의 위치를 포함하여 각 애플리케이션 서버의 로깅 모델에 대한 자세한 정보는 다음 표에 표시된 관련 애플리케이션 서버에 대한 문서를 참조하십시오.

|Application server |문서의 위치 |
| -------------------|---------------------------|
|Apache Tomcat	     |[http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
|WebSphere Application Server 버전 8.5 전체 프로파일 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
|WebSphere Application Server 버전 8.5 Liberty 프로파일 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### 로그 레벨 맵핑
{: #log-level-mappings }
{{ site.data.keys.mf_server }}에서는 **java.util.logging** API를 사용합니다. 로깅 레벨은 다음 레벨에 맵핑됩니다.

* WL.Logger.debug: FINE
* WL.Logger.info: INFO
* WL.Logger.warn: WARNING
* WL.Logger.error: SEVERE

### 로그 모니터링 도구
{: #log-monitoring-tools }
Apache Tomcat의 경우, [IBM  Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) 또는 다른 업계 표준 로그 파일 모니터링 도구를 사용하여 로그를 모니터하고 오류 및 경고를 강조표시할 수 있습니다.

WebSphere Application Server의 경우, IBM Knowledge Center에 설명된 로그 보기 기능을 사용하십시오. URL은 이 페이지의 {{ site.data.keys.mf_server }} 절에 있는 표에 나열되어 있습니다.

### 백엔드 연결
{: #back-end-connectivity }
백엔드 연결을 모니터하기 위해 추적을 사용하려면 이 페이지의 {{ site.data.keys.mf_server }} 절에 있는 표에서 특정 애플리케이션 서버 플랫폼에 대한 문서를 참조하십시오. **com.ibm.mfp.server.js.adapter** 패키지를 사용하고 로그 레벨을 **FINEST**로 설정하십시오.

### 관리 조작의 감사 로그
{: #audit-log-for-administration-operations }
{{ site.data.keys.mf_console }}은 로그인, 로그아웃 및 모든 관리 조작(앱 또는 어댑터 배치, 앱 잠금 등)에 대한 감사 로그를 저장합니다. 감사 로그는 {{ site.data.keys.product_adj }} 관리 서비스의 웹 애플리케이션(**mfp-admin-service.war**)에서 JNDI 특성 **mfp.admin.audit**를 false로 설정하여 사용 불가능하게 설정할 수 있습니다.

감사 로그가 사용되는 경우, 페이지 푸터에서 **감사 로그** 링크를 클릭하여 {{ site.data.keys.mf_console }}에서 감사 로그를 다운로드할 수 있습니다.

### 로그인 및 인증 문제
{: #login-and-authentication-issues }
로그인 및 인증 문제를 진단하려면 **com.ibm.mfp.server.security** 패키지에서 추적을 사용 가능하게 설정하고 로그 레벨을 **FINEST**로 설정하십시오.

## 복수 런타임 구성
{: #configuring-multiple-runtimes }
복수의 런타임을 포함하도록 {{ site.data.keys.mf_server }}를 구성하고 {{ site.data.keys.mf_console }} 콘솔에서 애플리케이션 "유형" 간에 시각적 차이를 둘 수 있습니다.

> **참고:** Mobile Foundation IBM Cloud 서비스에 의해 작성된 Mobile Foundation 서버 인스턴스에서는 복수 런타임이 지원되지 않습니다. IBM Cloud 서비스에서는 대신 복수 서비스 인스턴스를 작성해야 합니다.

#### 다음으로 이동
{: #jump-to-1 }
* [WebSphere Liberty 프로파일에서 복수 런타임 구성](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [애플리케이션 등록 및 서로 다른 런타임에 어댑터 배치](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [런타임 구성 내보내기 및 가져오기](#exporting-and-importing-runtime-configurations)

### WebSphere Liberty 프로파일에서 복수 런타임 구성
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. 애플리케이션 서버의 **server.xml** 파일을 여십시오. 일반적으로 **[application-server]/usr/servers/server-name/** 폴더에 있습니다. 예를 들어, {{ site.data.keys.mf_dev_kit }}에서는 **[installation-folder]/mfp-server/usrs/servers/mfp/server.xml**에서 이 파일을 찾을 수 있습니다.

2. 두 번째 `application` 요소를 추가하십시오.

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. 두 번째 JNDI 항목 세트를 추가하십시오.

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. 두 번째 `dataSource` 요소를 추가하십시오.

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **참고:**
    >
    > * `dataSource`가 다른 데이터베이스 스키마를 가리키는지 확인하십시오.
    > * 새 런타임을 위한 [다른 데이터베이스 인스턴스](../prod-env/databases)를 작성했는지 확인하십시오.
    > * 개발 환경에서 `properties.derby.embedded` 하위 요소에 `createDatabase="create"`를 추가하십시오.

5. 애플리케이션 서버를 다시 시작하십시오.

### 애플리케이션 등록 및 서로 다른 런타임에 어댑터 배치
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
{{ site.data.keys.mf_server }}가 복수 런타임을 포함하도록 구성된 경우 애플리케이션 등록과 어댑터 배치가 약간 다릅니다.

* [{{ site.data.keys.mf_console }}에서 등록 및 배치](#registering-and-deploying-from-the-mobilefirst-operations-console)
* [명령행에서 등록 및 배치](#registering-and-deploying-from-the-command-line)

#### {{ site.data.keys.mf_console }}에서 등록 및 배치
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
{{ site.data.keys.mf_console }}에서 이러한 조치를 수행하는 경우 등록 또는 배치할 런타임을 선택해야 합니다.

<img class="gifplayer" alt="{{ site.data.keys.mf_console }}의 복수 런타임" src="register-and-deploy-to-multiple-runtimes.png"/>

#### 명령행에서 등록 및 배치
{: #registering-and-deploying-from-the-command-line }
**mfpdev** 명령행 도구를 사용하여 이러한 조치를 수행하는 경우 등록 또는 배치할 런타임 이름을 추가해야 합니다.

애플리케이션을 등록하는 경우: `mfpdev app register <server-name> <runtime-name>`.  

```bash
mfpdev app register local second-runtime
```

어댑터를 배치하는 경우: `mfpdev adapter deploy <server-name> <runtime-name>`.  

```bash
mfpdev adapter deploy local second-runtime
```

* **local**은 {{ site.data.keys.mf_cli }}에서 기본 서버 정의의 이름입니다. *local*을 등록 또는 배치해야 할 서버 정의 이름으로 대체하십시오.
* **runtime-name**은 등록 또는 배치할 런타임의 이름입니다.

> 자세한 정보를 보려면 다음 CLI help 명령을 사용하십시오.
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## 런타임 구성 내보내기 및 가져오기
{: #exporting-and-importing-runtime-configurations }
{{ site.data.keys.mf_server }} **관리 서비스**의 REST API를 사용하여 런타임 구성을 내보내고 다른 {{ site.data.keys.mf_server }}로 가져올 수 있습니다.

예를 들어, 개발 환경에서 런타임 구성을 설정하여 해당 구성을 내보낸 후, 빠른 설정을 위한 테스트 환경으로 가져와 테스트 환경의 특정 요구에 따라 추가 구성을 수행할 수 있습니다.

> [API 참조서](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html)에서 사용 가능한 모든 REST API를 찾으십시오.

## 라이센스 추적 구성
{: #configuring-license-tracking }
라이센스 추적은 기본적으로 사용 가능합니다. 라이센스 추적을 구성할 수 있는 방법을 알아보려면 다음 주제를 읽으십시오. 라이센스 추적에 대한 자세한 정보는 [라이센스 추적](../../../administering-apps/license-tracking)을 참조하십시오.

* [클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적 구성](#configuring-license-tracking-for-client-device-and-addressable-device)
* [IBM License Metric Tool 로그 파일 구성](#configuring-ibm-license-metric-tool-log-files)

### 클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적 구성
{: #configuring-license-tracking-for-client-device-and-addressable-device }
클라이언트 디바이스 및 주소 지정 가능한 디바이스에 대한 라이센스 추적은 기본적으로 사용 가능합니다. 라이센스 보고서는 {{ site.data.keys.mf_console }}에서 사용 가능합니다. 다음 JNDI 특성을 지정하여 라이센스 추적에 대한 기본 설정을 변경할 수 있습니다.

> **참고:** 토큰 라이센싱 사용을 정의하는 계약이 있는 경우에는 [토큰 라이센싱을 위한 설치 및 구성](../token-licensing)도 참조하십시오.

다음 JNDI 특성을 지정하여 라이센스 추적에 대한 기본 설정을 변경할 수 있습니다.

**mfp.device.decommission.when**  
디바이스 해제 태스크에 의해 디바이스가 해제될 때까지의 비활성 일 수입니다. 라이센스 보고서는 해제된 디바이스를 활성 디바이스로 간주하지 않습니다. 특성의 기본값은 90일입니다. 클라이언트 디바이스나 주소 지정 가능한 디바이스에 의해 라이센스가 부여된 소프트웨어를 사용하는 경우에는 30일 미만의 값을 설정하지 마십시오. 30일 미만의 값을 설정하면 라이센스 보고서가 규제 준수를 증명하기에 충분하지 않을 수 있습니다.

**mfp.device.archiveDecommissioned.when**  
해제 태스크가 실행될 때 해제된 디바이스가 아카이브 파일에 저장되는 시기를 정의하는 값(일)입니다. 아카이브된 디바이스는 IBM {{ site.data.keys.mf_server }} **home\devices_archive** 디렉토리에 있는 파일에 기록됩니다. 이 파일의 이름에는 아카이브 파일 작성 시의 시간소인이 포함됩니다. 기본값은 90일입니다.

**mfp.device.decommissionProcessingInterval**  
해제 태스크가 실행되는 빈도(초)를 정의합니다. 기본값: 86400(1일). 해제 태스크는 다음 조치를 수행합니다.

* **mfp.device.decommission.when** 설정에 따라 비활성 디바이스를 해제합니다.
* 선택적으로, **mfp.device.archiveDecommissioned.when** 설정에 따라 해제된 디바이스 중 오래된 것을 아카이브합니다.
* 라이센스 추적 보고서를 생성합니다.

**mfp.licenseTracking.enabled**  
{{ site.data.keys.product }}에서 라이센스 추적을 사용 가능 또는 사용 불가능하게 설정하는 데 사용되는 값입니다. 기본적으로 라이센스 추적은 사용 가능합니다. 성능상의 이유로, 클라이언트 디바이스 또는 주소 지정 가능한 디바이스에 의해 {{ site.data.keys.product }}에 라이센스가 부여되지 않은 경우 이 플래그를 사용 불가능하게 설정할 수 있습니다. 디바이스 추적이 사용되지 않는 경우, 라이센스 보고서도 사용되지 않고 라이센스 메트릭이 생성되지 않습니다. 이 경우, 애플리케이션 수에 대한 IBM  License Metric Tool 레코드만 생성됩니다.

JNDI 특성 지정에 대한 자세한 정보는 [{{ site.data.keys.product_adj }} 런타임의 JNDI 특성 목록](#list-of-jndi-properties-for-mobilefirst-runtime)을 참조하십시오.

### IBM License Metric Tool 로그 파일 구성
{: #configuring-ibm-license-metric-tool-log-files }
{{ site.data.keys.product }}은 IBM  Software License Metric Tag(SLMT) 파일을 생성합니다. IBM Software License Metric Tag를 지원하는 IBM License Metric Tool 버전은 라이센스 이용 보고서를 생성할 수 있습니다. 여기서는 생성되는 파일의 위치 및 최대 크기를 구성하는 방법에 대해 설명합니다.

기본적으로 IBM Software License Metric Tag 파일은 다음 디렉토리에 있습니다.

* Windows의 경우: **%ProgramFiles%\ibm\common\slm**
* UNIX 및 UNIX 유사 운영 체제의 경우: **/var/ibm/common/slm**

디렉토리가 쓰기 불가능한 경우, {{ site.data.keys.product_adj }} 런타임 환경을 실행하는 애플리케이션 서버의 로그 디렉토리에 파일이 작성됩니다.

다음 특성을 사용하여 이러한 파일의 위치 및 관리를 구성할 수 있습니다.

* **license.metric.logger.output.dir**: IBM Software License Metric Tag 파일의 위치
* **license.metric.logger.file.size**: 순환이 수행되기 전 SLMT 파일의 최대 크기. 기본 크기는 1MB입니다.
* **license.metric.logger.file.number**: 순환 시 보관할 최대 SLMT 아카이브 파일 수. 기본 수는 10입니다.

기본값을 변경하려면 **key=value** 형식으로 Java 특성 파일을 작성하고 **license_metric_logger_configuration** JVM 특성을 통해 특성 파일에 대한 경로를 제공해야 합니다.

IBM License Metric Tool 보고서에 대한 자세한 정보는 [IBM License Metric Tool과의 통합](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool)을 참조하십시오.

## WebSphere Application Server SSL 구성 및 HTTP 어댑터
{: #websphere-application-server-ssl-configuration-and-http-adapters }
특성을 설정하면 HTTP 어댑터에서 WebSphere  SSL 구성을 활용할 수 있습니다.

기본적으로 HTTP 어댑터는 JRE(Java Runtime Environment) 신뢰 저장소와 {{ site.data.keys.mf_server }} 키 저장소를 연결하여([{{ site.data.keys.mf_server }} 키 저장소 구성](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore) 참조) WebSphere SSL을 사용하지 않습니다. [자체 서명 인증서를 사용하여 어댑터와 백엔드 서버 간의 SSL 구성](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)도 참조하십시오.

HTTP 어댑터에서 WebSphere SSL 구성을 사용하도록 하려면 **ssl.websphere.config** JNDI 특성을 true로 설정하십시오. 설정은 우선 순위에 다음과 같은 영향을 미칩니다.

1. WebSphere에서 실행 중인 어댑터는 {{ site.data.keys.mf_server }} 키 저장소가 아니라 WebSphere 키 저장소를 사용합니다.
2. **ssl.websphere.alias** 특성이 설정된 경우, 어댑터는 이 특성에 설정된 별명과 연관된 SSL 구성을 사용합니다.
