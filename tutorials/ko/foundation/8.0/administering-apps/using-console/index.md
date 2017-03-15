---
layout: tutorial
title: MobileFirst Operations Console을 통해 애플리케이션 관리
breadcrumb_title: 콘솔을 사용하여 관리
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.mf_console }}을 통해 앱을 잠그거나, 액세스를 거부하거나, 알림 메시지를 표시하여 {{ site.data.keys.product_adj }} 애플리케이션을 관리할 수 있습니다. 

다음 URL 중 하나를 입력하여 콘솔을 시작할 수 있습니다. 

* 프로덕션 또는 테스트용 보안 모드: `https://hostname:secure_port/mfpconsole`
* 개발: `http://server_name:port/mfpconsole`

{{ site.data.keys.mf_console }}에 액세스할 수 있도록 권한이 부여된 로그인과 비밀번호가 있어야 합니다. 자세한 정보는 [{{ site.data.keys.mf_server }} 관리를 위한 사용자 인증 구성](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration)을 참조하십시오. 

{{ site.data.keys.mf_console }}을 사용하여 애플리케이션을 관리할 수 있습니다. 

{{ site.data.keys.mf_console }}에서 Analytics 콘솔에 액세스하고 Analytics 서버가 분석할 모바일 데이터의 수집을 제어할 수도 있습니다. 자세한 정보는 [{{ site.data.keys.mf_console }}에서 데이터 콜렉션 사용 또는 사용 안함](../../analytics/console/#enabledisable-analytics-support)을 참조하십시오. 

#### 다음으로 이동
{: #jump-to }

* [모바일 애플리케이션 관리](#mobile-application-management)
* [애플리케이션 상태 및 토큰 라이센싱](#application-status-and-token-licensing)
* [런타임 환경에서 조작의 오류 로그](#error-log-of-operations-on-runtime-environments)
* [관리 조작의 감사 로그](#audit-log-of-administration-operations)

## 모바일 애플리케이션 관리
{: #mobile-application-management }
{{ site.data.keys.product_adj }} 모바일 애플리케이션 관리 기능을 통해 {{ site.data.keys.mf_server }} 운영자와 관리자는 해당 애플리케이션에 대한 사용자 액세스 권한과 디바이스 액세스 권한을 세부적으로 제어할 수 있습니다. 

{{ site.data.keys.mf_server }}는 사용자의 모바일 인프라에 대한 모든 액세스 시도를 추적하고 애플리케이션, 사용자, 애플리케이션이 설치된 디바이스에 대한 정보를 저장합니다. 애플리케이션, 사용자, 디바이스 간 맵핑은 서버의 모바일 애플리케이션 관리 기능에 대한 기초를 형성합니다. 

IBM {{ site.data.keys.mf_console }}을 사용하여 사용자 자원에 대한 액세스를 모니터하고 관리하십시오. 

* 이름으로 사용자를 검색한 후 해당 사용자가 자원에 액세스하기 위해 사용 중인 디바이스와 애플리케이션에 대한 정보를 확인합니다. 
* 표시 이름으로 디바이스를 검색한 후 디바이스와 연관된 사용자, 이 디바이스에서 사용되는 등록된 {{ site.data.keys.product_adj }} 애플리케이션을 확인합니다. 
* 특정 디바이스에 있는 애플리케이션의 모든 인스턴스에서 자원에 액세스하는 것을 차단합니다. 이 기능은 디바이스가 손실되거나 디바이스를 도난당한 경우 유용합니다. 
* 특정 디바이스에 있는 특정 애플리케이션만 자원에 액세스하지 못하도록 차단합니다. 예를 들어 직원의 부서가 변경된 경우 이전 부서의 애플리케이션에 대한 직원의 액세스는 차단하지만 동일한 디바이스에 있는 다른 애플리케이션에서 이루어지는 직원 액세스는 허용할 수 있습니다. 
* 디바이스의 등록을 취소하고 디바이스에 대해 수집된 모든 등록 데이터와 모니터링 데이터를 삭제합니다. 

액세스 차단에는 다음과 같은 특성이 있습니다. 

* 차단 조작은 가역적입니다. {{ site.data.keys.mf_console }}에서 디바이스 또는 애플리케이션 상태를 변경하여 차단을 제거할 수 있습니다. 
* 차단은 보호된 자원에만 적용됩니다. 차단된 클라이언트도 여전히 애플리케이션을 사용하여 보호되지 않은 자원에 액세스할 수 있습니다. 보호되지 않은 자원을 참조하십시오. 
* 이 조작을 선택하면 {{ site.data.keys.mf_server }}의 어댑터 자원에 대한 액세스가 즉시 차단됩니다. 하지만 애플리케이션에 아직 만료되지 않은 유효한 액세스 토큰이 있을 수 있으므로 외부 서버에 있는 자원의 경우에는 이 특성이 적용되지 않습니다. 

### 디바이스 상태
{: #device-status }
{{ site.data.keys.mf_server }}는 서버에 액세스하는 모든 디바이스의 상태 정보를 유지보수합니다. 상태 값은 **활성**, **손실**, **도난**, **만료**, **사용 안함** 중 하나입니다.  

기본 디바이스 상태는 **활성**으로 이 디바이스의 액세스가 차단되지 않음을 표시합니다. 상태를 **손실**, **도난** 또는 **사용 안함**으로 변경하여 디바이스에서 애플리케이션 자원에 액세스하지 못하게 차단할 수 있습니다. 언제든지 **활성** 상태를 복원하여 다시 액세스할 수 있도록 허용할 수 있습니다. [{{ site.data.keys.mf_console }}에서 디바이스 액세스 관리](#managing-device-access-in-mobilefirst-operations-console)를 참조하십시오. 

**만료** 상태는 디바이스가 이 서버 인스턴스에 마지막으로 연결된 이후 사전 구성된 비활동 기간이 경과한 경우에 {{ site.data.keys.mf_server }}에서 설정하는 특수한 상태입니다. 이 상태는 라이센스 추적에 사용되며 디바이스의 액세스 권한에는 영향을 미치지 않습니다. **만료** 상태의 디바이스가 서버에 다시 연결되면 디바이스 상태가 **활성**으로 복원되고 서버에 대한 액세스 권한이 디바이스에 부여됩니다. 

### 디바이스 표시 이름
{: #device-display-name }
{{ site.data.keys.mf_server }}는 {{ site.data.keys.product_adj }} 클라이언트 SDK에서 지정하는 고유 디바이스 ID로 디바이스를 식별합니다. 디바이스의 표시 이름을 설정하면 해당 표시 이름으로 디바이스를 검색할 수 있습니다. 애플리케이션 개발자는 `WLClient` 클래스의 `setDeviceDisplayName` 메소드를 사용하여 디바이스 표시 이름을 설정할 수 있습니다. [{{ site.data.keys.product_adj }} 클라이언트 측 API](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_ibm_worklight_client_side_api_.html)의 `WLClient` 문서를 참조하십시오. (JavaScript 클래스는 `WL.Client`입니다.) Java 어댑터 개발자(보안 검사 개발자 포함)는 com.ibm.mfp.server.registration.external.model `MobileDeviceData` 클래스의 `setDeviceDisplayName` 메소드를 사용하여 디바이스 표시 이름을 설정할 수도 있습니다. [MobileDeviceData](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc)를 참조하십시오. 

### {{ site.data.keys.mf_console }}에서 디바이스 액세스 관리
{: #managing-device-access-in-mobilefirst-operations-console }
자원에 대한 디바이스 액세스를 모니터하고 관리하려면 {{ site.data.keys.mf_console }} 대시보드에서 디바이스 탭을 선택하십시오. 

디바이스와 연관된 사용자 ID 또는 디바이스의 표시 이름(설정되어 있는 경우)으로 디바이스를 검색하려면 검색 필드를 사용하십시오. [디바이스 표시 이름](#device-display-name)을 참조하십시오. 사용자 ID 또는 디바이스 표시 이름의 일부(3자 이상)를 검색할 수도 있습니다. 

검색 결과에는 지정된 사용자 ID 또는 디바이스 표시 이름과 일치하는 모든 디바이스가 표시됩니다. 각 디바이스의 디바이스 ID와 표시 이름, 디바이스 모델, 운영 체제, 디바이스와 연관된 사용자 ID 목록을 확인할 수 있습니다. 

디바이스 상태 열에는 디바이스의 상태가 표시됩니다. 디바이스의 상태를 **손실**, **도난** 또는 **사용 안함**으로 변경하여 디바이스에서 보호된 자원에 액세스하지 못하게 차단할 수 있습니다. 상태를 다시 **활성**으로 변경하면 원래 액세스 권한이 복원됩니다. 

**조치** 열에서 **등록 취소**를 선택하여 디바이스의 등록을 취소할 수 있습니다. 디바이스의 등록을 취소하면 디바이스에 설치되어 있는 모든 {{ site.data.keys.product_adj }} 애플리케이션의 등록 데이터가 삭제됩니다. 또한 디바이스 표시 이름, 디바이스와 연관된 사용자 목록, 애플리케이션에서 이 디바이스에 대해 등록한 공용 속성도 삭제됩니다. 

**참고:** **등록 취소** 조치는 되돌릴 수 없습니다. 다음에 디바이스의 {{ site.data.keys.product_adj }} 애플리케이션 중 하나에서 서버에 액세스하려고 하면 해당 디바이스가 새 디바이스 ID로 다시 등록됩니다. 디바이스를 다시 등록하도록 선택하면 디바이스 상태가 **활성**으로 설정되고 해당 디바이스는 이전 차단과 관계 없이 보호된 자원에 액세스할 수 있습니다. 그러므로 디바이스를 차단하려면 해당 디바이스의 등록을 취소하지 마십시오. 대신 디바이스 상태를 **손실**, **도난** 또는 **사용 안함**으로 변경하십시오. 

특정 디바이스에 액세스한 모든 애플리케이션을 보려면 디바이스 테이블의 디바이스 ID 옆에 있는 펼치기 화살표 아이콘을 선택하십시오. 표시되는 애플리케이션 테이블의 각 행에는 애플리케이션의 이름과 애플리케이션의 액세스 상태(이 디바이스에 있는 해당 애플리케이션에서 보호된 자원에 액세스할 수 있는지 여부)가 포함되어 있습니다. 애플리케이션의 상태를 **사용 안함**으로 변경하여 명확히 이 디바이스에 있는 애플리케이션에서 액세스하지 못하게 차단할 수 있습니다. 

#### 다음으로 이동
{: #jump-to-1 }

* [보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정](#remotely-disabling-application-access-to-protected-resources)
* [관리자 메시지 표시](#displaying-an-administrator-message)
* [다중 언어로 관리자 메시지 정의](#defining-administrator-messages-in-multiple-languages)

### 보호된 자원에 대한 애플리케이션 액세스를 사용 안함으로 원격 설정
{: #remotely-disabling-application-access-to-protected-resources }
{{ site.data.keys.mf_console }}(콘솔)을 사용하여 특정 모바일 운영 체제의 특정 애플리케이션 버전에 대한 사용자 액세스를 사용 안함으로 설정하고 사용자에게 사용자 정의 메시지를 제공할 수 있습니다. 

1. 콘솔 탐색 사이드바의 **애플리케이션** 섹션에서 애플리케이션 버전을 선택한 후 애플리케이션 **관리** 탭을 선택하십시오. 
2. 상태를 **액세스 사용 안함**으로 변경하십시오. 
3. **최신 버전의 URL** 필드에서 선택적으로 최신 버전의 애플리케이션에 대한 URL을 제공하십시오(일반적으로 해당 공용 또는 개인용 앱 스토어에 있음). 일부 환경에서는 Application Center에서 애플리케이션 버전의 세부사항 보기에 직접 액세스할 수 있도록 URL을 제공합니다. [애플리케이션 특성](../../appcenter/appcenter-console/#application-properties)을 참조하십시오. 
4. **기본 알림 메시지** 필드에 사용자가 애플리케이션에 액세스하려고 할 때 표시할 사용자 정의 알림 메시지를 추가하십시오. 다음 샘플 메시지는 사용자에게 최신 버전으로 업그레이드하도록 지시합니다. 

   ```bash
   This version is no longer supported. Please upgrade to the latest version.
   ```

5. **지원되는 로케일** 섹션에서 선택적으로 다른 언어로 된 알림 메시지를 제공할 수 있습니다. 
6. 변경사항을 적용하려면 **저장**을 선택하십시오. 

사용자가 사용 안함으로 원격 설정된 애플리케이션을 실행하면 사용자 정의 메시지가 포함된 대화 상자 창이 표시됩니다. 이 메시지는 보호된 자원에 대한 액세스가 필요한 애플리케이션 상호작용이 발생하거나 애플리케이션에서 액세스 토큰을 획득하려고 하는 경우에 표시됩니다. 버전 업그레이드 URL을 제공한 경우에는 대화 상자에 기본 **닫기** 단추 외에 최신 버전으로 업그레이드하는 데 사용할 **새 버전 가져오기** 단추도 포함됩니다. 버전을 업그레이드하지 않고 대화 상자를 닫으면 보호된 자원에 대한 액세스가 필요 없는 애플리케이션 파트 관련 작업을 계속 수행할 수 있습니다. 그러나 보호된 자원에 대한 액세스가 필요한 애플리케이션 상호작용이 발생하는 경우에는 다시 대화 상자 창이 표시되고 애플리케이션에 해당 자원에 대한 액세스 권한이 부여되지 않습니다. 

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### 관리자 메시지 표시
{: #displaying-an-administrator-message }
설명된 프로시저에 따라 알림 메시지를 구성하십시오. 이 메시지를 사용하여 애플리케이션 사용자에게 계획된 서비스 작동 중지 시간과 같은 임시 상황에 대해 알릴 수 있습니다. 

1. {{ site.data.keys.mf_console }} 탐색 사이드바의 **애플리케이션** 섹션에서 애플리케이션 버전을 선택한 후 애플리케이션 관리 탭을 선택하십시오. 
2. 상태를 **활성 및 알림**으로 변경하십시오. 
3. 사용자 정의 시작 메시지를 추가하십시오. 다음 샘플 메시지는 사용자에게 계획된 애플리케이션 유지보수 작업에 대한 정보를 제공합니다. 

   ```bash
   The server will be unavailable on Saturday between 4 AM to 6 PM due to planned maintenance.
   ```

4. 지원되는 로케일 섹션에서 선택적으로 다른 언어로 된 알림 메시지를 제공할 수 있습니다. 

5. 변경사항을 적용하려면 **저장**을 선택하십시오. 

이 메시지는 애플리케이션에서 먼저 {{ site.data.keys.mf_server }}를 사용하여 보호된 자원에 액세스하거나 액세스 토큰을 얻는 경우에 표시됩니다. 애플리케이션이 시작될 때 액세스 토큰을 획득하는 경우 이 단계에서 메시지가 표시됩니다. 그렇지 않으면 애플리케이션에서 처음으로 보호된 자원에 대한 액세스 또는 액세스 토큰 획득을 요청할 때 메시지가 표시됩니다. 이 메시지는 처음 상호작용할 때 한 번만 표시됩니다. 

### 다중 언어로 관리자 메시지 정의
{: #defining-administrator-messages-in-multiple-languages }
<b>참고:</b> Microsoft Internet Explorer(IE)와 Microsoft Edge에서는 구성된 브라우저 또는 운영 체제의 표시 언어 환경 설정이 아니라 운영 체제의 지역 형식 환경 설정에 따라 관리 메시지가 표시됩니다. [IE 및 Edge 웹 애플리케이션 제한사항](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge)을 참조하십시오. 설명된 프로시저를 수행하여 콘솔을 통해 정의한 애플리케이션 관리 메시지를 표시하는 데 사용할 다중 언어를 구성하십시오. 메시지는 디바이스의 로케일을 기반으로 전송되며 모바일 운영 체제에서 로케일을 지정하기 위해 사용하는 표준을 준수해야 합니다. 

1. {{ site.data.keys.mf_console }} 탐색 사이드바의 **애플리케이션** 섹션에서 애플리케이션 버전을 선택한 후 애플리케이션 **관리** 탭을 선택하십시오. 
2. **활성 및 알림** 또는 **액세스 사용 안함** 중에서 상태를 택하십시오. 
3. **로케일 업데이트**를 선택하십시오. 표시된 대화 창의 **파일 업로드** 섹션에서 **업로드**를 선택한 후 로케일을 정의하는 CSV 파일 위치를 찾아보십시오. 

   CSV 파일의 각 행에는 쉼표로 구분된 문자열 쌍이 포함되어 있습니다. 첫 번째 문자열은 로케일 코드(예: 프랑스어(프랑스)의 경우 fr-FR, 영어의 경우 en)이고 두 번째 문자열은 해당 언어로 된 메시지 텍스트입니다. 지정된 로케일 코드는 모바일 운영 체제에서 로케일을 지정하는 데 사용하는 표준(예: ISO 639-1, ISO 3166-2, ISO 15924)을 준수해야 합니다. 
    
   > **참고:** CSV 파일을 작성하려면 메모장과 같이 UTF-8 인코딩을 지원하는 편집기를 사용해야 합니다. 

   다음은 동일한 메시지를 다중 로케일로 정의하는 샘플 CSV 파일입니다. 

   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. **알림 메시지 확인** 섹션에서 CSV 파일의 로케일 코드와 메시지 테이블을 확인할 수 있습니다. 메시지를 확인한 후 **확인**을 선택하십시오.
언제든지 편집을 선택하여 로케일 CSV 파일을 대체할 수 있습니다. 또한 이 옵션을 사용해서 비어 있는 CSV 파일을 업로드하여 모든 로케일을 제거할 수 있습니다. 
5. 변경사항을 적용하려면 **저장**을 선택하십시오. 

디바이스의 로케일에 따라 사용자의 모바일 디바이스에 자국어로 지원된 알림 메시지가 표시됩니다. 디바이스 로케일에 맞게 구성된 메시지가 없는 경우에는 사용자가 제공한 기본 메시지가 표시됩니다. 

## 애플리케이션 상태 및 토큰 라이센싱
{: #application-status-and-token-licensing }
충분하지 않은 토큰으로 인한 Blocked 상태 후 {{ site.data.keys.mf_console }}에서 올바른 애플리케이션 상태를 수동으로 복원해야 합니다. 

토큰 라이센싱을 사용하고 애플리케이션에 사용할 충분한 라이센스 토큰이 더 이상 없는 경우에는 모든 애플리케이션 버전의 애플리케이션 상태가 **Blocked**로 변경됩니다. 애플리케이션 버전의 상태를 더 이상 변경할 수 없습니다. {{ site.data.keys.mf_console }}에 다음 메시지가 표시됩니다. 

```bash
The application got blocked because its license expired
```

나중에 애플리케이션을 실행하는 데 충분한 토큰이 사용 가능해지거나 조직에서 추가 토큰을 구입하는 경우 다음 메시지가 {{ site.data.keys.mf_console }}에 표시됩니다. 

```bash
The application got blocked because its license expired but a license is available now
```

표시 상태는 여전히 **Blocked**입니다. 상태 필드를 편집하여 메모리 또는 사용자 고유 레코드에서 수동으로 올바른 현재 상태를 복원해야 합니다. {{ site.data.keys.product }}은 충분하지 않은 라이센스 토큰으로 인해 차단된 애플리케이션의 {{ site.data.keys.mf_console }}에서 **Blocked** 상태의 표시를 관리하지 않습니다. 사용자가 {{ site.data.keys.mf_console }}을 통해 표시할 수 있는 실제 상태로 차단된 애플리케이션을 복원해야 합니다. 

## 런타임 환경에서 조작의 오류 로그
{: #error-log-of-operations-on-runtime-environments }
오류 로그를 사용하여 선택된 런타임 환경의 명령행 또는 {{ site.data.keys.mf_console }}에서 시작된 실패한 관리 조작에 액세스하고 실패가 서버에 미치는 영향을 확인할 수 있습니다. 

트랜잭션에 실패하면 상태 표시줄에 오류 알림이 표시되고 오류 로그에 대한 링크가 표시됩니다. 오류에 대한 추가 세부사항(예: 특정 오류 메시지가 포함된 각 서버의 상태) 또는 오류의 히스토리를 보려면 오류 로그를 사용하십시오. 오류 로그에는 최근 조작이 먼저 표시됩니다. 

{{ site.data.keys.mf_console }}에서 런타임 환경의 **오류 로그**를 클릭하여 오류 로그에 액세스합니다. 

실패한 조작을 나타내는 행을 펼쳐 각 서버의 현재 상태에 대한 자세한 정보에 액세스할 수 있습니다. 전체 로그에 액세스하려면 **로그 다운로드**를 클릭하여 로그를 다운로드하십시오. 

![콘솔의 오류 로그](error-log.png)

## 관리 조작의 감사 로그
{: #audit-log-of-administration-operations }
{{ site.data.keys.mf_console }}에서 관리 조작의 감사 로그를 참조할 수 있습니다. 

{{ site.data.keys.mf_console }}은 로그인, 로그아웃, 모든 관리 조작(앱 또는 어댑터 배치, 앱 잠금 등)의 감사 로그에 대한 액세스를 제공합니다. {{ site.data.keys.product_adj }} 관리 서비스의 웹 애플리케이션에서 **mfp.admin.audit** JNDI(Java Naming and Directory Interface) 특성을 **false**로 설정하여 감사 로그를 사용 안함으로 설정할 수 있습니다. 

감사 로그에 액세스하려면 헤더 표시줄에서 사용자 이름을 클릭하고 **정보**를 선택한 다음 **추가 지원 정보**를 클릭한 후 **감사 로그 다운로드**를 클릭하십시오. 

| 필드 이름  | 설명        | 
|------------|-------------|
| Timestamp	 | 레코드가 작성된 날짜 및 시간입니다. |
| Type	     | 조작의 유형입니다. 가능한 값은 아래의 조작 유형 목록을 참조하십시오. |
| User	     | 로그인한 사용자의 **사용자 이름**입니다. |
| Outcome	 | 조작의 결과입니다. 가능한 값은 SUCCESS, ERROR, PENDING입니다. |
| ErrorCode	 | 결과가 ERROR인 경우 ErrorCode는 오류 내용을 표시합니다. |
| Runtime	 | 조작과 연관된 {{ site.data.keys.product_adj }} 프로젝트의 이름입니다. |

다음 목록은 조작 유형의 가능한 값을 표시합니다. 

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime


