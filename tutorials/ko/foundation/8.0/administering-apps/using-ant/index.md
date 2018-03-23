---
layout: tutorial
title: Ant를 통한 애플리케이션 관리
breadcrumb_title: Administrating using Ant
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
**mfpadm** Ant 태스크를 통해 {{ site.data.keys.product_adj }} 애플리케이션을 관리할 수 있습니다.

#### 다음으로 이동
{: #jump-to }

* [다른 기능과 비교](#comparison-with-other-facilities)
* [전제조건](#prerequisites)

## 다른 기능과 비교
{: #comparison-with-other-facilities }
다음과 같은 방법으로 {{ site.data.keys.product_full }}을 사용해 관리 조작을 실행할 수 있습니다.

* 대화식 {{ site.data.keys.mf_console }}
* **mfpadm** Ant 태스크
* **mfpadm** 프로그램
* {{ site.data.keys.product_adj }} 관리 REST 서비스

**mfpadm** Ant 태스크, **mfpadm** 프로그램, REST 서비스는 조작을 자동으로 실행하거나 무인 실행하는 경우 유용합니다. 예를 들면 다음과 같습니다.

* 반복 조작에서 운영자 오류를 제거하는 경우 또는
* 운영자의 정상 근무 시간 외에 조작하는 경우 또는
* 테스트 또는 사전 프로덕션 서버와 동일한 설정을 사용하여 프로덕션 서버를 구성하는 경우

**mfpadm** Ant 태스크와 **mfpadm** 프로그램은 REST 서비스보다 사용이 간편하고 오류 보고 측면에서 우수합니다. mfpadm 프로그램에 비해 **mfpadm** Ant 태스크의 장점은 플랫폼이 독립적이고 Ant와의 통합을 이미 사용할 수 있는 경우 통합이 보다 쉽다는 점입니다.

## 전제조건
{: #prerequisites }
**mfpadm** 도구는 {{ site.data.keys.mf_server }} 설치 프로그램을 사용해 설치됩니다. 이 페이지의 나머지 부분에서 **product\_install\_dir**은 {{ site.data.keys.mf_server }} 설치 프로그램의 설치 디렉토리를 표시합니다.

**mfpadm** 태스크를 실행하려면 Apache Ant가 필요합니다. Ant의 최소 지원 버전에 대한 정보는 시스템 요구사항을 참조하십시오.

편의를 위해 Apache Ant 1.9.4가 {{ site.data.keys.mf_server }}에 포함되어 있습니다. **product\_install\_dir/shortcuts/** 디렉토리에서 다음 스크립트가 제공됩니다.

* UNIX/Linux의 경우 ant
* Windows의 경우 ant.bat

이러한 스크립트는 실행 준비가 되어 있으며 이는 특정 환경 변수가 필요하지 않음을 의미합니다. 환경 변수 JAVA_HOME이 설정된 경우 스크립트에서 이를 승인합니다.

{{ site.data.keys.mf_server }}가 설치된 컴퓨터가 아닌 다른 컴퓨터에서 **mfpadm** Ant 태스크를 사용할 수 있습니다.

* **product\_install\_dir/MobileFirstServer/mfp-ant-deployer.jar** 파일을 컴퓨터에 복사하십시오.
* 지원되는 버전의 Apache Ant와 JRE(Java Runtime Environment)가 컴퓨터에 설치되어 있는지 확인하십시오.

**mfpadm** Ant 태스크를 사용하려면 다음 초기화 명령을 Ant 스크립트에 추가하십시오.

```xml
<taskdef resource="com/ibm/mfp/ant/deployers/antlib.xml">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

**defaults.properties**를 통한 초기화는 antlib.xml을 통해서도 내재적으로 수행되므로 동일한 **mfp-ant-deployer.jar** 파일을 참조하는 기타 초기화 명령은 중복됩니다. 다음은 중복되는 초기화 명령의 예 중 하나입니다.

```xml
<taskdef resource="com/ibm/mfp/ant/defaults.properties">
  <classpath>
    <pathelement location="product_install_dir/MobileFirstServer/mfp-ant-deployer.jar"/>
  </classpath>
</taskdef>
```

{{ site.data.keys.mf_server }} 설치 프로그램 실행에 대한 자세한 정보는 [IBM Installation Manager 실행](../../installation-configuration/production/installation-manager/)을 참조하십시오.

#### 다음으로 이동
{: #jump-to-1 }

* [**mfpadm** Ant 태스크 호출](#calling-the-mfpadm-ant-task)
* [일반 구성에 대한 명령](#commands-for-general-configuration)
* [어댑터에 대한 명령](#commands-for-adapters)
* [앱에 대한 명령](#commands-for-apps)
* [디바이스에 대한 명령](#commands-for-devices)
* [문제점 해결에 대한 명령](#commands-for-troubleshooting)

### mfpadm Ant 태스크 호출
{: #calling-the-mfpadm-ant-task }
**mfpadm** Ant 태스크와 연관 명령을 사용해 {{ site.data.keys.product_adj }} 애플리케이션을 관리할 수 있습니다.
다음과 같이 **mfpadm** Ant 태스크를 호출하십시오.

```xml
<mfpadm url=... user=... password=...|passwordfile=... [secure=...]>
    some commands
</mfpadm>
```

#### 속성
{: #attributes }
**mfpadm** Ant 태스크의 속성은 다음과 같습니다.

| 속성      | 설명 | 필수 여부 | 기본값 | 
|----------------|-------------|----------|---------|
| url	         | 관리 서비스에 사용되는 {{ site.data.keys.product_adj }} 웹 애플리케이션의 기본 URL | 예	 | |
| secure	     | 보안 위험이 있는 조작을 수행하지 않을지 여부 | 아니오 | true |
| user	         | {{ site.data.keys.product_adj }} 관리 서비스에 액세스하는 데 사용되는 사용자 이름 | 예 | |
| password	     | 사용자의 비밀번호 | 하나는 필수임 | |
| passwordfile   |	사용자의 비밀번호가 있는 파일 | 하나는 필수임 | |	 
| timeout	     | 전체 REST 서비스 액세스의 제한시간(초) | 아니오 | |
| connectTimeout |	네트워크 연결 설정의 제한시간(초) | 아니오 | |	 
| socketTimeout  |	네트워크 연결 끊어짐을 발견할 제한시간(초) | 아니오 | |
| connectionRequestTimeout |	연결 요청 풀에서 항목을 얻을 제한시간(초) | 아니오 | |
| lockTimeout    |	잠금 획득 제한시간 | 아니오 | |

**url**<br/>
기본 URL에서는 우선적으로 HTTPS 프로토콜을 사용합니다. 예를 들어, 기본 포트와 컨텍스트 루트를 사용하는 경우 다음 URL을 사용하십시오.

* WebSphere Application Server의 경우: [https://server:9443/worklightadmin](https://server:9443/worklightadmin)
* Tomcat의 경우: [https://server:8443/worklightadmin](https://server:8443/worklightadmin)

**secure**<br/>
기본값은 **true**입니다. **secure="false"**를 설정하면 다음과 같은 영향을 미칩니다.

* 암호화되지 않은 HTTP를 통해서도 사용자와 비밀번호가 안전하지 않은 방법으로 전송될 수 있습니다.
* 서버의 SSL 인증서가 자체 서명되었거나 지정된 서버의 호스트 이름과 다른 호스트 이름에 대해 작성된 경우에도 해당 인증서가 허용됩니다.

**비밀번호**<br/>
**password** 속성을 통해 Ant 스크립트에서 또는 **passwordfile** 속성을 통해 전달하는 별도의 파일에서 비밀번호를 지정합니다. 비밀번호는 민감한 정보이므로 보호되어야 합니다. 동일한 컴퓨터의 다른 사용자가 이 비밀번호를 알지 못하게 해야 합니다. 비밀번호에 대한 보안을 설정하려면 파일에 비밀번호를 입력하기 전에 자신이 아닌 다른 사용자의 파일 읽기 권한을 제거하십시오. 예를 들어, 다음 명령 중 하나를 사용할 수 있습니다.

* UNIX의 경우: `chmod 600 adminpassword.txt`
* Windows의 경우: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

또한 비밀번호를 잠시라도 보이지 않도록 숨기기 위해 난독화할 수 있습니다. 이를 수행하려면 **mfpadm** config password 명령을 사용하여 구성 파일에 난독화된 비밀번호를 저장하십시오. 그런 다음 난독화된 비밀번호를 Ant 스크립트 또는 비밀번호 파일에 복사하여 붙여넣을 수 있습니다.

**mfpadm** 호출에는 내부 요소에서 인코딩되는 명령이 포함되어 있습니다. 이러한 명령은 나열되는 순서대로 실행됩니다. 명령 중 하나가 실패하면 나머지 명령이 실행되지 않으며 **mfpadm** 호출에 실패합니다.

#### 요소
{: #elements }
**mfpadm** 호출에서 다음 요소를 사용할 수 있습니다.

| 요소                       | 설명 | 개수 |
|-------------------------------|-------------|-------|
| show-info	                    | 사용자 정보와 구성 정보 표시 | 0..∞ | 
| show-global-config	        | 글로벌 구성 정보 표시 | 0..∞ | 
| show-diagnostics              | 진단 정보 표시 | 0..∞ | 
| show-versions	                | 버전 정보 표시 | 0..∞ | 
| unlock	                    | 일반용 잠금 해제 | 0..∞ | 
| list-runtimes	                | 런타임 나열 | 0..∞ | 
| show-runtime      	        | 런타임에 대한 정보 표시 | 0..∞ | 
| delete-runtime	            | 런타임 삭제 | 0..∞ | 
| show-user-config	            | 런타임의 사용자 구성 표시 | 0..∞ | 
| set-user-config	            | 런타임의 사용자 구성 지정 | 0..∞ | 
| show-confidential-clients	    | 런타임의 기밀 클라이언트 구성 표시 | 0..∞ | 
| set-confidential-clients	    | 런타임의 기밀 클라이언트 구성 지정 | 0..∞ | 
| set-confidential-clients-rule	| 런타임의 기밀 클라이언트 구성에 대한 규칙 지정 | 0..∞ | 
| list-adapters	                | 어댑터 나열 | 0..∞ | 
| deploy-adapter	            | 어댑터 배치 | 0..∞ | 
| show-adapter	                | 어댑터에 대한 정보 표시 | 0..∞ | 
| delete-adapter	            | 어댑터 삭제 | 0..∞ | 
| adapter	                    | 어댑터의 기타 조작 | 0..∞ | 
| list-apps	                    | 앱 나열 | 0..∞ | 
| deploy-app	                | 앱 배치 | 0..∞ | 
| show-app	                    | 앱에 대한 정보 표시 | 0..∞ | 
| delete-app	                | 앱 삭제 | 0..∞ | 
| show-app-version              | 앱 버전에 대한 정보 표시 | 0..∞ | 
| delete-app-version            | 앱의 버전 삭제 | 0..∞ | 
| app	                        | 앱의 기타 조작 | 0..∞ | 
| app-version	                | 앱 버전의 기타 조작 | 0..∞ | 
| list-devices	                | 디바이스 나열 | 0..∞ | 
| remove-device	                | 디바이스 제거 | 0..∞ | 
| device	                    | 디바이스에 대한 기타 조작 | 0..∞ | 
| list-farm-members	            | 서버 팜 멤버 나열 | 0..∞ | 
| remove-farm-member	        | 서버 팜 멤버 제거 | 0..∞ | 

#### XML 형식
{: #xml-format }
대부분 명령의 출력은 XML 형식이고 특정 명령에 대한 입력(예: `<set-accessrule>`)도 XML 형식입니다. **product\_install\_dir/MobileFirstServer/mfpadm-schemas/** 디렉토리에 이러한 XML 형식의 XML 스키마가 있습니다. 서버에서 XML 응답을 받는 명령은 이 응답이 특정 스키마를 준수하는지 확인합니다. **xmlvalidation="none"** 속성을 지정하여 이 검사를 사용 안함으로 설정할 수 있습니다. 

#### 출력 문자 세트
{: #output-character-set }
mfpadm Ant 태스크의 일반 출력은 현재 로케일의 인코딩 형식으로 인코딩됩니다. Windows에서는 이 인코딩 형식을 "ANSI 코드 페이지"라고 합니다. 영향은 다음과 같습니다.

* 이 문자 세트 외부의 문자는 출력 시 물음표로 변환됩니다.
* 출력이 Windows 명령 프롬프트 창(cmd.exe)으로 이동하는 경우 해당 창에서는 문자가 "OEM 코드 페이지"에서 인코딩된다고 가정하므로 비ASCII 문자가 올바르지 않게 표시됩니다.

이 제한사항의 임시 해결책은 다음과 같습니다.

* Windows 이외의 운영 체제에서 인코딩이 UTF-8인 로케일을 사용하십시오. 이 로케일은 Red Hat Linux와 macOS의 기본 로케일입니다. 기타 여러 운영 체제에는 en_US.UTF-8 로케일이 있습니다.
* 또는 **output="some file name"** 속성을 사용하여 mfpadm 명령의 출력 경로를 파일로 재지정하십시오.

### 일반 구성에 대한 명령
{: #commands-for-general-configuration }
**mfpadm** Ant 태스크를 호출할 때 IBM {{ site.data.keys.mf_server }} 또는 런타임의 글로벌 구성에 액세스하는 여러 명령을 포함할 수 있습니다.

#### `show-global-config` 명령
{: #the-show-global-config-command }
`show-global-config` 명령은 글로벌 구성을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output	     | 출력 파일의 이름입니다.  |	아니오	   | 적용할 수 없음 |
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 |

**예제**  

```xml
<show-global-config/>
```

이 명령은 [Global Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-user-config` 명령
{: #the-show-user-config-command }
`<adapter>` 요소와 `<app-version>` 요소 외부의 `show-user-config` 명령은 런타임의 사용자 구성을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime	     | 런타임의 이름입니다.      | 예     |	사용할 수 없음 |
| format	     | 출력 형식을 지정합니다. json 또는 xml입니다. | 예 | 사용할 수 없음       | 
| output	     | 출력을 저장할 파일 이름입니다.   | 아니오  | 적용할 수 없음      | 
| outputproperty | 출력을 저장할 Ant 특성의 이름입니다.  | 아니오 | 적용할 수 없음 |

**예제**  

```xml
<show-user-config runtime="mfp" format="xml"/>
```

이 명령은 [Runtime Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-user-config` 명령
{: #the-set-user-config-command }
`<adapter>` 요소와 `<app-version>` 요소 외부의 `show-user-config` 명령은 런타임의 사용자 구성을 지정합니다. 이 명령에는 전체 구성 설정에 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime        | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| file	         | 새 구성이 포함된 JSON 또는 XML 파일의 이름입니다. | 예 | 사용할 수 없음 | 

`set-user-config` 명령에는 구성에서 단일 특성을 설정하는 데 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime	     | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| property	     | JSON 특성의 이름입니다. 중첩된 특성의 경우 구문 prop1.prop2.....propN을 사용하십시오. JSON 배열 요소의 경우 특성 이름 대신 색인을 사용하십시오. | 예 | 사용할 수 없음 | 
| value	         | 특성의 값입니다. | 예 | 사용할 수 없음 |

**예제**  

```xml
<set-user-config runtime="mfp" file="myconfig.json"/>
```

```xml
<set-user-config runtime="mfp" property="timeout" value="240"/>
```

이 명령은 [Runtime configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-confidential-clients` 명령
{: #the-show-confidential-clients-command }
`show-confidential-clients` 명령은 런타임에 액세스할 수 있는 기밀 클라이언트의 구성을 표시합니다. 기밀 클라이언트에 대한 자세한 정보는 [기밀 클라이언트](../../authentication-and-security/confidential-clients)를 참조하십시오. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime        | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| format         | 출력 형식을 지정합니다. json 또는 xml입니다. | 예 | 사용할 수 없음 | 
| output         | 출력을 저장할 파일 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력을 저장할 Ant 특성의 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-confidential-clients runtime="mfp" format="xml" output="clients.xml"/>
```

이 명령은 [Confidential Clients (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `set-confidential-clients` 명령
{: #the-set-confidential-clients-command }
`set-confidential-clients` 명령은 런타임에 액세스할 수 있는 기밀 클라이언트의 구성을 지정합니다. 기밀 클라이언트에 대한 자세한 정보는 [기밀 클라이언트](../../authentication-and-security/confidential-clients)를 참조하십시오. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime        | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| file	         | 새 구성이 포함된 JSON 또는 XML 파일의 이름입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<set-confidential-clients runtime="mfp" file="clients.xml"/>
```

이 명령은 [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-confidential-clients-rule` 명령
{: #the-set-confidential-clients-rule-command }
`set-confidential-clients-rule` 명령은 런타임에 액세스할 수 있는 기밀 클라이언트의 구성에 규칙을 지정합니다. 기밀 클라이언트에 대한 자세한 정보는 [기밀 클라이언트](../../authentication-and-security/confidential-clients)를 참조하십시오. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime        | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| id             | 규칙 ID입니다. | 예 | 사용할 수 없음 | 
| displayName    | 규칙의 표시 이름입니다. | 예 | 사용할 수 없음 | 
| secret         | 규칙의 시크릿입니다. | 예 | 사용할 수 없음 | 
| allowedScope   | 규칙의 범위입니다. 공백으로 구분된 토큰 목록입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<set-confidential-clients-rule runtime="mfp" id="push" displayName="Push" secret="lOa74Wxs" allowedScope="**"/>
```

이 명령은 [Confidential Clients (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST 서비스를 기반으로 합니다.

### 어댑터에 대한 명령
{: #commands-for-adapters }
**mfpadm** Ant 태스크를 호출할 때 어댑터에 대한 여러 명령을 포함할 수 있습니다.

#### `list-adapters` 명령
{: #the-list-adapters-command }
`list-adapters` 명령은 지정된 런타임 동안 배치된 어댑터 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime        | 런타임의 이름입니다. | 	예 | 사용할 수 없음 | 
| output	     | 출력 파일의 이름입니다. | 	아니오  | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<list-adapters runtime="mfp"/>
```

이 명령은 [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `deploy-adapter` 명령
{: #the-deploy-adapter-command }
`deploy-adapter` 명령은 런타임에 어댑터를 배치합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime	     | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 파일           | 2진 어댑터 파일입니다(.adapter). | 예 | 사용할 수 없음 |

**예제**  

```xml
<deploy-adapter runtime="mfp" file="MyAdapter.adapter"/>
```

이 명령은 [Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-adapter` 명령
{: #the-show-adapter-command }
`show-adapter` 명령은 어댑터에 대한 세부사항을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름 | 어댑터의 이름입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-adapter runtime="mfp" name="MyAdapter"/>
```

이 명령은 [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-adapter` 명령
{: #the-delete-adapter-command }
`delete-adapter` 명령은 런타임에서 어댑터를 제거(배치 취소)합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름    | 어댑터의 이름입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<delete-adapter runtime="mfp" name="MyAdapter"/>
```

이 명령은 [Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `adapter` 명령 그룹
{: #the-adapter-command-group }
`adapter` 명령 그룹의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름 | 어댑터의 이름입니다. | 예 | 사용할 수 없음 | 

`adapter` 명령은 다음 요소를 지원합니다.

| 요소          | 설명 |	개수    | 
|------------------|-------------|-------------|
| get-binary	   | 2진 데이터를 가져옵니다. | 0..∞ | 
| show-user-config | 사용자 구성을 표시합니다. | 0..∞ | 
| set-user-config  | 사용자 구성을 지정합니다. | 0..∞ | 

<br/>
#### `get-binary` 명령
{: #the-get-binary-command }
`<adapter>` 요소 내부의 `get-binary` 명령은 2진 어댑터 파일을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| tofile	     | 출력 파일의 이름입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <get-binary tofile="/tmp/MyAdapter.adapter"/>
</adapter>
```

이 명령은 [Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-user-config` 명령
{: #the-show-user-config-command-1 }
`<adapter>` 요소 내부의 `show-user-config` 명령은 어댑터의 사용자 구성을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| format	     | 출력 형식을 지정합니다. json 또는 xml입니다. | 예 | 사용할 수 없음       | 
| output	     | 출력을 저장할 파일 이름입니다.   | 아니오  | 적용할 수 없음      | 
| outputproperty | 출력을 저장할 Ant 특성의 이름입니다.  | 아니오 | 적용할 수 없음 |

**예제**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <show-user-config format="xml"/>
</adapter>
```

이 명령은 [Adapter Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-user-config` 명령
{: #the-set-user-config-command-1 }
`<adapter>` 요소 내부의 `show-user-config` 명령은 어댑터의 사용자 구성을 지정합니다. 이 명령에는 전체 구성 설정에 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| 새 구성이 포함된 JSON 또는 XML 파일의 파일 이름입니다. | 예 | 사용할 수 없음 | 

명령에는 구성에서 단일 특성을 설정하는 데 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| property | JSON 특성의 이름입니다. 중첩된 특성의 경우 구문 prop1.prop2.....propN을 사용하십시오. JSON 배열 요소의 경우 특성 이름 대신 색인을 사용하십시오. | 예 | 사용할 수 없음 | 
| value | 특성의 값입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config file="myconfig.json"/>
</adapter>
```

```xml
<adapter runtime="mfp" name="MyAdapter">
  <set-user-config property="timeout" value="240"/>
</adapter>
```

이 명령은 [Application Configuration (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST 서비스를 기반으로 합니다.

### 앱에 대한 명령
{: #commands-for-apps }
**mfpadm** Ant 태스크를 호출할 때 앱에 대한 여러 명령을 포함할 수 있습니다.

#### `list-apps` 명령
{: #the-list-apps-command }
`list-apps` 명령은 런타임에 배치되는 앱의 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<list-apps runtime="mfp"/>
```

이 명령은 [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `deploy-app` 명령
{: #the-deploy-app-command }
`deploy-app` 명령은 런타임에 앱 버전을 배치합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 파일 | 애플리케이션 디스크립터입니다(JSON 파일). | 예 | 사용할 수 없음 | 

**예제**  

```xml
<deploy-app runtime="mfp" file="MyApp/application-descriptor.json"/>
```

이 명령은 [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-app` 명령
{: #the-show-app-command }
`show-app` 명령은 런타임에 배치되는 앱 버전 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름 | 앱의 이름입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-app runtime="mfp" name="MyApp"/>
```

이 명령은 [Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-app` 명령
{: #the-delete-app-command }
`delete-app` 명령은 런타임에서 애플리케이션이 배치된 모든 환경의 앱(모든 해당 앱 버전 포함)을 제거(배치 취소)합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름 | 앱의 이름입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<delete-app runtime="mfp" name="MyApp"/>
```

이 명령은 [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-app-version` 명령
{: #the-show-app-version-command }
`show-app-version` 명령은 런타임에 앱 버전에 대한 세부사항을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| name	앱의 이름입니다. | 예 | 사용할 수 없음 | 
| environment	모바일 플랫폼입니다. | 예 | 사용할 수 없음 | 
| version	앱의 버전 번호입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<show-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

이 명령은 [Application Version (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-app-version` 명령
{: #the-delete-app-version-command }
`delete-app-version` 명령은 런타임에서 애플리케이션 버전을 제거(배치 취소)합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| name	앱의 이름입니다. | 예 | 사용할 수 없음 | 
| environment	모바일 플랫폼입니다. | 예 | 사용할 수 없음 | 
| version	앱의 버전 번호입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<delete-app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1"/>
```

이 명령은 [Application Version (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST 서비스를 기반으로 합니다.

<br/>
#### `app` 명령 그룹
{: #the-app-command-group }
`app` 명령 그룹의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| name	앱의 이름입니다. | 예 | 사용할 수 없음 | 

app 명령 그룹은 다음 요소를 지원합니다.

| 요소 | 설명 | 개수 | 
|---------|-------------|-------|
| show-license-config | 토큰 라이센스 구성을 표시합니다. | 0.. | 
| set-license-config | 토큰 라이센스 구성을 지정합니다. | 0.. | 
| delete-license-config | 토큰 라이센스 구성을 제거합니다. | 0.. | 

<br/>
#### `show-license-config` 명령
{: #the-show-license-config-command }
`show-license-config` 명령은 앱의 토큰 라이센스 구성을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output         |	출력을 저장할 파일의 이름입니다. | 예 | 사용할 수 없음 |
| outputproperty | 	출력을 저장할 Ant 특성의 이름입니다. | 예	| 사용할 수 없음 |

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-license-config output="/tmp/MyApp-license.xml"/>
</app-version>
```

이 명령은 [Application license configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `set-license-config` 명령
{: #the-set-license-config-command }
`set-license-config` 명령은 앱의 토큰 라이센스 구성을 지정합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| appType | 앱의 유형입니다(B2C 또는 B2E). | 예 | 사용할 수 없음 | 
| licenseType | 애플리케이션의 유형입니다(APPLICATION, ADDITIONAL_BRAND_DEPLOYMENT 또는 NON_PRODUCTION). | 예 | 사용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-license-config appType="B2E" licenseType="APPLICATION"/>
</app-version>
```

이 명령은 [Application License Configuration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-license-config` 명령
{: #the-delete-license-config-command }
`delete-license-config` 명령은 앱의 토큰 라이센스 구성을 재설정하여 초기 상태로 되돌립니다.

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-license-config/>
</app-version>
```

이 명령은 [License configuration (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST 서비스를 기반으로 합니다.

<br/>
#### `app-version` 명령 그룹
{: #the-app-version-command-group }
`app-version` 명령 그룹의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| 이름 | 앱의 이름입니다. | 예 | 사용할 수 없음 | 
| environment | 모바일 플랫폼입니다. | 예 | 사용할 수 없음 | 
| version | 앱의 버전입니다. | 예 | 사용할 수 없음 | 

`app-version` 명령 그룹은 다음 요소를 지원합니다.

| 요소 | 설명 | 개수 | 
|---------|-------------|-------|
| get-descriptor | 디스크립터를 가져옵니다. | 0.. | 
| get-web-resources | 웹 자원을 가져옵니다. | 0.. | 
| set-web-resources | 웹 자원을 지정합니다. | 0.. | 
| get-authenticity-data | 인증 데이터를 가져옵니다. | 0.. | 
| set-authenticity-data | 인증 데이터를 지정합니다. | 0.. | 
| delete-authenticity-data | 인증 데이터를 삭제합니다. | 0.. | 
| show-user-config | 사용자 구성을 표시합니다. | 0.. | 
| set-user-config | 사용자 구성을 지정합니다. | 0.. | 

<br/>
#### `get-descriptor` 명령
{: #the-get-descriptor-command }
`<app-version>` 요소 내부의 `get-descriptor` 명령은 앱 버전의 애플리케이션 디스크립터를 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output | 출력을 저장할 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력을 저장할 Ant 특성의 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-descriptor output="/tmp/MyApp-application-descriptor.json"/>
</app-version>
```

이 명령은 [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) 서비스를 기반으로 합니다.

<br/>
#### `get-web-resources` 명령
{: #the-get-web-resources-command }
`<app-version>` 요소 내부의 `get-web-resources` 명령은 앱 버전의 웹 자원을 .zip 파일로 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| tofile | 	출력 파일의 이름입니다. | 예 |사용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-web-resources tofile="/tmp/MyApp-web.zip"/>
</app-version>
```

이 명령은 [Retrieve Web Resource (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-web-resources` 명령
{: #the-set-web-resources-command }
`<app-version>` 요소 내부의 `set-web-resources` 명령은 앱 버전에 대한 웹 자원을 지정합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| 파일 | 입력 파일의 이름입니다(.zip 파일이어야 함). | 예 |사용할 수 없음 |

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-web-resources file="/tmp/MyApp-web.zip"/>
</app-version>
```

이 명령은 [Deploy a web resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST 서비스를 기반으로 합니다.

<br/>
#### `get-authenticity-data` 명령
{: #the-get-authenticity-data-command }
`<app-version>` 요소 내부의 `get-authenticity-data` 명령은 앱 버전의 인증 데이터를 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output | 	출력을 저장할 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력을 저장할 Ant 특성의 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <get-authenticity-data output="/tmp/MyApp.authenticity_data"/>
</app-version>
```

이 명령은 [Export runtime resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `set-authenticity-data` 명령
{: #the-set-authenticity-data-command }
`<app-version>` 요소 내부의 `set-authenticity-data` 명령은 앱 버전에 대한 인증 데이터를 지정합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| 파일 | 입력 파일의 이름입니다.<ul><li>authenticity_data 파일</li><li>또는 디바이스 파일(.ipa, .apk 또는 .appx 파일)이며 여기에서 인증 데이터를 추출합니다.</li></ul> |  예 | 사용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="/tmp/MyApp.authenticity_data"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-authenticity-data file="MyApp.ipa"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="android" version="1.1">
  <set-authenticity-data file="MyApp.apk"/>
</app-version>
```

이 명령은 [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-authenticity-data` 명령
{: #the-delete-authenticity-data-command }
`<app-version>` 요소 내부의 `delete-authenticity-data` 명령은 앱 버전의 인증 데이터를 삭제합니다. 이 명령에는 속성이 없습니다.

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <delete-authenticity-data/>
</app-version>
```

이 명령은 [Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST 서비스를 기반으로 합니다.

<br/>
#### `show-user-config` 명령
{: #the-show-user-config-command-2 }
`<app-version>` 요소 내부의 `show-user-config` 명령은 앱 버전의 사용자 구성을 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| format | 출력 형식을 지정합니다. json 또는 xml입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다.	아니오 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="json" output="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <show-user-config format="xml" output="/tmp/MyApp-config.xml"/>
</app-version>
```

이 명령은 [Application Configuration (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-user-config` 명령
{: #the-set-user-config-command-2 }
`<app-version>` 요소 내부의 `set-user-config` 명령은 앱 버전에 대한 사용자 구성을 지정합니다. 이 명령에는 전체 구성 설정에 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| 파일 | 새 구성이 포함된 JSON 또는 XML 파일의 이름입니다. | 예 | 사용할 수 없음 | 

`set-user-config` 명령에는 구성에서 단일 특성을 설정하는 데 필요한 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| property | JSON 특성의 이름입니다. 중첩된 특성의 경우 구문 prop1.prop2.....propN을 사용하십시오. JSON 배열 요소의 경우 특성 이름 대신 색인을 사용하십시오. | 예 | 사용할 수 없음 | 
| value	| 특성의 값입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config file="/tmp/MyApp-config.json"/>
</app-version>
```

```xml
<app-version runtime="mfp" name="MyApp" environment="iphone" version="1.1">
  <set-user-config property="timeout" value="240"/>
</app-version>
```

### 디바이스에 대한 명령
{: #commands-for-devices }
**mfpadm** Ant 태스크를 호출할 때 디바이스에 대한 여러 명령을 포함할 수 있습니다.

#### `list-devices` 명령
{: #the-list-devices-command }
`list-devices` 명령은 런타임의 앱에 접속한 디바이스의 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| query	 | 검색할 친숙한 이름 또는 사용자 ID입니다. 이 매개변수는 검색할 문자열을 지정합니다. 이 문자열(대소문자 구분 없이 일치)을 포함하는 친숙한 이름 | 또는 사용자 ID를 사용하는 모든 디바이스가 리턴됩니다. | 아니오 | 적용할 수 없음 | 
| output | 	출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 	출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<list-devices runtime="mfp"/>
```

```xml
<list-devices runtime="mfp" query="john"/>
```

이 명령은 [Devices (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `remove-device` 명령
{: #the-remove-device-command }
`remove-device` 명령은 런타임의 앱에 접속한 디바이스에 대한 레코드를 지웁니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| id | 고유 디바이스 ID입니다. | 예 | 사용할 수 없음 | 

**예제**  

```xml
<remove-device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6"/>
```

이 명령은 [Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST 서비스를 기반으로 합니다.

<br/>
#### `device` 명령 그룹
{: #the-device-command-group }
`device` 명령 그룹의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| id | 고유 디바이스 ID입니다. | 예 | 사용할 수 없음 | 

`device` 명령은 다음 요소를 지원합니다.

| 요소        | 설명 |       개수 |
|----------------|-------------|-------------|
| set-status | 상태를 변경합니다. | 0..∞ | 
| set-appstatus | 앱의 상태를 변경합니다. | 0..∞ | 

<br/>
#### `set-status` 명령
{: #the-set-status-command }
`set-status` 명령은 런타임의 범위에서 디바이스의 상태를 변경합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| status | 새 상태입니다. | 예 | 사용할 수 없음 | 

상태의 값은 다음 중 하나입니다.

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**예제**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-status status="EXPIRED"/>
</device>
```

이 명령은 [Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST 서비스를 기반으로 합니다.

<br/>
#### `set-appstatus` 명령
{: #the-set-appstatus-command }
`set-appstatus` 명령은 런타임에 애플리케이션과 관련하여 디바이스의 상태를 변경합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| app	| 앱의 이름입니다. | 예 | 사용할 수 없음 | 
| status | 	새 상태입니다. | 예 | 사용할 수 없음 | 

상태의 값은 다음 중 하나입니다.

* ENABLED
* DISABLED

**예제**  

```xml
<device runtime="mfp" id="496E974CCEDE86791CF9A8EF2E5145B6">
  <set-appstatus app="MyApp" status="DISABLED"/>
</device>
```

이 명령은 [Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST 서비스를 기반으로 합니다.

### 문제점 해결에 대한 명령
{: #commands-for-troubleshooting }
Ant 태스크 명령을 사용하여 {{ site.data.keys.mf_server }} 웹 애플리케이션 관련 문제점을 조사할 수 있습니다.

#### `show-info` 명령
{: #the-show-info-command }
`show-info` 명령은 런타임 또는 데이터베이스에 액세스하지 않고 리턴할 수 있는 {{ site.data.keys.product_adj }} 관리 서비스에 대한 기본 정보를 표시합니다. 이 명령을 사용하여 {{ site.data.keys.product_adj }} 관리 서비스가 실행 중인지 여부를 테스트합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output | 	출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 	출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-info/>
```

<br/>
#### `show-versions` 명령
{: #the-show-versions-command }
`show-versions` 명령은 여러 컴포넌트의 {{ site.data.keys.product_adj }} 버전을 표시합니다.

* **mfpadmVersion**: **mfp-ant-deployer.jar** 파일을 가져온 정확한 {{ site.data.keys.mf_server }} 버전 번호
* **productVersion**: **mfp-admin-service.war** 파일을 가져온 정확한 {{ site.data.keys.mf_server }} 버전 번호입니다.
* **mfpAdminVersion**: **mfp-admin-service.war**의 정확한 빌드 버전 번호입니다.

명령의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output | 	출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 	출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-versions/>
```

<br/>
#### `show-diagnostics` 명령
{: #the-show-diagnostics-command }
`show-diagnostics` 명령은 {{ site.data.keys.product_adj }} 관리 서비스의 올바른 조작에 필요한 여러 컴포넌트의 상태를 표시합니다(예: 데이터베이스와 보조 서비스의 사용 가능성). 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| output | 	출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 	출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<show-diagnostics/>
```

<br/>
#### `unlock` 명령
{: #the-unlock-command }
`unlock` 명령은 일반 용도의 잠금을 해제합니다. 일부 안전하지 않은 조작에서는 동일한 구성 데이터가 동시에 수정되지 않도록 하기 위해 이 잠금을 사용합니다. 드물게 해당 조작이 인터럽트되는 경우 안전하지 않은 조작을 더 이상 수행할 수 없도록 잠금이 잠금 상태로 유지됩니다. 이런 경우 unlock 명령을 사용하여 잠금을 해제하십시오. 이 명령에는 속성이 없습니다.

**예제**  

```xml
<unlock/>
```

<br/>
#### `list-runtimes` 명령
{: #the-list-runtimes-command }
`list-runtimes` 명령은 배치된 런타임 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**  

```xml
<list-runtimes/>
```

```xml
<list-runtimes inDatabase="true"/>
```

이 명령은 [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `show-runtime` 명령
{: #the-show-runtime-command }
`show-runtime` 명령은 주어진 배치된 런타임에 대한 정보를 표시합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**

```xml
<show-runtime runtime="mfp"/>
```

이 명령은 [Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `delete-runtime` 명령
{: #the-delete-runtime-command }
`delete-runtime` 명령은 데이터베이스에서 해당 앱과 어댑터를 비롯한 런타임을 삭제합니다. 해당 웹 애플리케이션이 중지된 경우에만 런타임을 삭제할 수 있습니다. 명령의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime |  런타임의 이름입니다. | 예 | 사용할 수 없음 |
| condition | 삭제 조건입니다(비어 있음 또는 항상). **주의:** 항상 옵션은 위험합니다. | 아니오 | 적용할 수 없음 |

**예제**

```xml
<delete-runtime runtime="mfp" condition="empty"/>
```

이 명령은 [Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST 서비스를 기반으로 합니다.

<br/>
#### `list-farm-members` 명령
{: #the-list-farm-members-command }
`list-farm-members` 명령은 주어진 런타임이 배치되는 팜 멤버 서버의 목록을 리턴합니다. 이 명령에는 다음과 같은 속성이 있습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| output | 출력 파일의 이름입니다. | 아니오 | 적용할 수 없음 | 
| outputproperty | 출력의 Ant 특성 이름입니다. | 아니오 | 적용할 수 없음 | 

**예제**

```xml
<list-farm-members runtime="mfp"/>
```

이 명령은 [Farm topology members (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST 서비스를 기반으로 합니다.

<br/>
#### `remove-farm-member` 명령
{: #the-remove-farm-member-command }
`remove-farm-member` 명령은 주어진 런타임이 배치된 팜 멤버의 목록에서 서버를 제거합니다. 서버를 사용할 수 없거나 연결이 끊어진 경우 이 명령을 사용하십시오. 명령의 속성은 다음과 같습니다.

| 속성      | 설명 |	필수 여부 | 기본값 |
|----------------|-------------|-------------|---------|
| runtime | 런타임의 이름입니다. | 예 | 사용할 수 없음 | 
| serverId | 서버의 ID입니다.	 | 예 | 적용할 수 없음 | 
| force | 사용 가능하거나 연결되어 있는 경우에도 팜 멤버의 제거를 강제 실행합니다. | 아니오 | false | 

**예제**

```xml
<remove-farm-member runtime="mfp" serverId="srvlx15"/>
```

이 명령은 [Farm topology members (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST 서비스를 기반으로 합니다.
