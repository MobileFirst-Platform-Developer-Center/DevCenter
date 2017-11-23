---
layout: tutorial
title: MobileFirst CLI를 사용하여 MobileFirst 아티팩트 관리
breadcrumb_title: MobileFirst CLI 사용
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## 개요
{: #overview }
{{ site.data.keys.product_full }}은 CLI(Command Line Interface) 도구인 **mfpdev**를 제공하여 개발자가 클라이언트 및 서버 아티팩트를 쉽게 관리하도록 합니다.   
이 CLI를 사용하여 {{ site.data.keys.product_adj }} Cordova 플러그인을 사용하는 Cordova 기반 애플리케이션 및 {{ site.data.keys.product_adj }} 고유 SDK를 사용하는 고유 애플리케이션을 관리할 수 있습니다. 

또한 로컬 또는 원격 {{ site.data.keys.mf_server }} 인스턴스에서 어댑터를 작성, 등록 및 관리하고 명령행이나 REST 서비스를 통해, 또는 {{ site.data.keys.mf_console }}에서 프로젝트를 관리할 수 있습니다. 

**mfpdev** 명령에는 대화식 모드 및 직접 모드의 두 가지 모드가 있습니다. 대화식 모드에서는 옵션 없이 명령을 입력하며 응답에 대한 프롬프트가 표시됩니다. 직접 모드에서는 옵션을 포함하여 전체 명령을 입력하며 프롬프트가 제공되지 않습니다. 해당되는 경우 프롬프트는 명령을 실행하는 디렉토리에 의해 판별된 대로 앱의 대상 플랫폼에 따라 컨텍스트에 맞게 표시됩니다. 키보드의 위로 화살표 및 아래로 화살표 키를 사용하여 선택사항 간에 이동한 다음 원하는 선택사항이 강조표시되고 앞에 ">" 문자가 표시되면 Enter 키를 누르십시오. 

이 학습서에서는 `mfpdev` CLI(Command Line Interface)를 설치하는 방법 및 이를 사용하여 {{ site.data.keys.mf_server }} 인스턴스, 애플리케이션 및 어댑터를 관리하는 방법에 대해 학습합니다. 

> Cordova 및 고유 애플리케이션의 SDK 통합과 관련된 자세한 정보는 [{{ site.data.keys.product }} SDK 추가](../../application-development/sdk/) 카테고리의 학습서를 참조하십시오.



#### 다음으로 이동
{: #jump-to }
* [전제조건](#prerequisites)
* [{{ site.data.keys.mf_cli }} 설치](#installing-the-mobilefirst-cli)
* [CLI 명령 목록](#list-of-cli-commands)
* [대화식 모드 및 직접 모드](#interactive-and-direct-modes)
* [{{ site.data.keys.mf_server }} 인스턴스 관리](#managing-mobilefirst-server-instances)
* [애플리케이션 관리](#managing-applications)
* [어댑터 관리 및 테스트](#managing-and-testing-adapters)
* [유용한 명령](#helpful-commands)
* [명령행 인터페이스 업데이트 및 설치 제거](#update-and-uninstall-the-command-line-interface)

## 전제조건
{: #prerequisites }
{{ site.data.keys.mf_cli }}는 [NPM 레지스트리](https://www.npmjs.com/)에서 NPM 패키지로 사용 가능합니다.   

NPM 패키지를 설치하려면 개발 환경에 **node.js** 및 **npm**이 설치되어 있는지 확인하십시오.  
[nodejs.org](https://nodejs.org)의 설치 지시사항에 따라 node.js를 설치하십시오. 

node.js가 올바르게 설치되었는지 확인하려면 `node -v` 명령을 실행하십시오. 

```bash
node -v
v6.11.1
```

> **참고:** 지원되는 최소 **node.js** 버전은 **4.2.3**입니다. 또한 **node**와 **npm** 패키지가 빠르게 전개되므로 MobileFirst CLI가 최신 버전을 포함하여 사용 가능한 모든 버전의 **node** 및 **npm**에서 완벽하게 작동하지 않을 수도 있습니다. CLI가 제대로 작동하려면 **node**의 버전이 **6.11.1**이고 **npm**의 버전이 **3.10.10**인지 확인하십시오.

## {{ site.data.keys.mf_cli }} 설치
{: #installing-the-mobilefirst-cli }
명령행 인터페이스를 설치하려면 다음 명령을 실행하십시오. 

```bash
npm install -g mfpdev-cli
```

{{ site.data.keys.mf_console }}의 다운로드 센터에서 CLI .zip 파일을 다운로드한 경우 다음 명령을 사용하십시오. 

```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- 선택적 종속 항목 없이 CLI를 설치하려면 `--no-optional` 플래그를 다음과 같이 추가하십시오. `npm install -g --no-optional path-to-mfpdev-cli.tgz`

인수 없이 `mfpdev` 명령을 실행하여 설치를 확인하면 다음 도움말 텍스트가 인쇄됩니다. 

```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## CLI 명령 목록
{: #list-of-cli-commands }

| 명령 접두부| 명령 조치| 설명|
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
| `mfpdev app`	                                                | register                                     | {{ site.data.keys.mf_server }}에 앱을 등록합니다.|
|                                                               | config                                       | 앱에 사용할 백엔드 서버 및 런타임을 지정할 수 있습니다. 또한 Cordova 앱의 경우 여러 가지 추가 측면(예: 시스템 메시지의 기본 언어 및 체크섬 보안 검사 수행 여부)을 구성할 수 있습니다. 그 외 Cordova 앱에 대한 다른 구성 매개변수가 포함되어 있습니다.|
|                                                               | pull                                         | 서버에서 기존 앱 구성을 검색합니다.|
|                                                               | push                                         | 앱 구성을 서버로 전송합니다.|
|                                                               | preview                                      | 대상 플랫폼 유형의 실제 디바이스가 없어도 Cordova 앱을 미리 볼 수 있습니다. {{ site.data.keys.mf_mbs }} 또는 웹 브라우저에서 미리보기가 가능합니다.|
|                                                               | webupdate                                    | www 디렉토리에 있는 애플리케이션 자원을 직접 업데이트 프로세스에 사용할 수 있는 .zip 파일로 패키지합니다.|
| mfpdev server	                                                | info                                         | {{ site.data.keys.mf_server }}에 대한 정보를 표시합니다.|
|                                                               | add                                          | 환경에 새 서버 정의를 추가합니다.|
|                                                               | edit                                         | 서버 정의를 편집할 수 있습니다.|
|                                                               | remove                                       | 환경에서 서버 정의를 제거합니다.|
|                                                               | console                                      | {{ site.data.keys.mf_console }}을 엽니다.|
|                                                               | clean                                        | 앱을 등록 취소하고 {{ site.data.keys.mf_server }}에서 어댑터를 제거합니다.|
| mfpdev adapter                                                | create                                       | 어댑터를 작성합니다.|
|                                                               | build                                        | 어댑터를 빌드합니다.|
|                                                               | build all                                    | 현재 디렉토리와 해당 서브디렉토리에서 모든 어댑터를 찾고 빌드합니다.|
|                                                               | deploy                                       | 어댑터를 {{ site.data.keys.mf_server }}에 배치합니다.|
|                                                               | deploy all                                   | 현재 디렉토리와 해당 서브디렉토리에서 모든 어댑터를 찾고 {{ site.data.keys.mf_server }}에 배치합니다.|
|                                                               | call                                         | {{ site.data.keys.mf_server }}에서 어댑터의 프로시저를 호출합니다.|
|                                                               | pull                                         | 서버에서 기존 어댑터 구성을 검색합니다.|
|                                                               | push                                         | 어댑터 구성을 서버에 전송합니다.|
| mfpdev                                                        | config                                       | mfpdev 명령행 인터페이스의 미리보기 브라우저 유형, 미리보기 제한시간 값 및 서버 제한시간 값에 대한 구성 환경 설정을 설정합니다.|
|                                                               | info                                         | 운영 체제, 메모리 이용, 노드 버전 및 명령행 인터페이스 버전을 포함하여 환경에 대한 정보를 표시합니다. 현재 디렉토리가 Cordova 애플리케이션인 경우 Cordova cordova info 명령으로 제공되는 정보도 표시됩니다.|
|                                                               | -v                                           | 현재 사용 중인 {{ site.data.keys.mf_cli }} 버전 번호를 표시합니다.|
|                                                               | -d, --debug                                  | 디버그 모드: 디버그 출력을 생성합니다.|
|                                                               | -dd, --ddebug                                | 상세 디버그 모드: 상세 디버그 출력을 생성합니다.|
|                                                               | -no-color                                    | 명령 출력에 색상을 사용하지 않습니다.|
| mfpdev help                                                   | name of command                              | {{ site.data.keys.mf_cli }}(mfpdev) 명령에 대한 도움말을 표시합니다. 인수를 사용하여 각 명령 유형 또는 명령에 대한 자세한 도움말 텍스트를 표시합니다. 예: "mfpdev help server add"|

## 대화식 모드 및 직접 모드
{: #interactive-and-direct-modes }
모든 명령은 **대화식** 또는 **직접 모드**로 실행할 수 있습니다. 대화식 모드에서는 명령에 필요한 매개변수가 프롬프트로 표시되고 일부 기본값이 사용됩니다. 직접 모드에서는 실행되는 명령에 매개변수를 제공해야 합니다. 

예제:

대화식 모드의 `mfpdev server add`

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
직접 모드에서 동일한 명령은 다음과 같습니다.

```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

직접 모드에서 명령에 대한 올바른 구문을 찾으려면 `mfpdev help <command>`를 사용하십시오. 


## {{ site.data.keys.mf_server }} 인스턴스 관리
{: #managing-mobilefirst-server-instances }
`mfpdev server <option>` 명령을 사용하여 사용 중인 {{ site.data.keys.mf_server }}의 인스턴스를 관리할 수 있습니다. 하나 이상의 서버 인스턴스가 기본 인스턴스로 항상 나열되어야 합니다. 다른 서버가 지정되지 않은 경우 기본 서버가 항상 사용됩니다. 

### 서버 인스턴스 나열
{: #list-server-instances }
사용 가능한 모든 {{ site.data.keys.mf_server }} 인스턴스를 나열하려면 다음 명령을 실행하십시오. 

```bash
mfpdev server info
```

기본적으로 로컬 서버 프로파일은 자동으로 작성되고 CLI에 의해 현재 기본값으로 사용됩니다. 

### 새 서버 인스턴스 추가
{: #add-a-new-server-instance }
다른 로컬 또는 원격 {{ site.data.keys.mf_server }} 인스턴스를 사용 중인 경우 다음 명령을 사용하여 사용 가능한 인스턴스 목록에 추가할 수 있습니다. 

```bash
mfpdev server add
```

대화식 프롬프트에 따라 서버의 이름, 서버 URL 및 사용자 이름/비밀번호 신임 정보를 제공하십시오.   
예를 들어 Mobile Foundation Bluemix 서비스에서 실행 중인 {{ site.data.keys.mf_server }}를 추가하려면 다음을 수행합니다. 

```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully. 
```

- "이 서버의 완전한 URL"을 고유 항목으로 대체하십시오. 

### 서버 인스턴스 편집
{: #edit-server-instances }
등록된 서버 인스턴스의 세부사항을 편집하려면 다음 명령을 실행하고 대화식 프롬프트에 따라 편집할 서버를 선택한 다음 업데이트할 정보를 제공하십시오. 

```bash
mfpdev server edit
```

서버를 기본 서버로 설정하려면 다음 명령을 사용하십시오. 

```bash
mfpdev server edit <server_name> --setdefault
```

### 서버 인스턴스 제거
{: #remove-server-instances }
등록된 서버 목록에서 서버 인스턴스를 제거하려면 다음 명령을 실행하십시오. 

```bash
mfpdev server remove
```

그런 다음 대화식 목록에서 서버를 선택하십시오. 

### {{ site.data.keys.mf_console }} 열기
{: #open-mobilefirst-operations-console }
등록된 기본 서버의 콘솔을 열려면 다음 명령을 실행하십시오. 

```bash
mfpdev server console
```

다른 서버의 콘솔을 열려면 서버 이름을 명령의 매개변수로 제공하십시오. 

```bash
mfpdev server console <server_name>
```

### 서버에서 앱과 어댑터 제거
{: #remove-apps-and-adapters-from-a-server }
서버에 등록된 앱과 어댑터를 모두 제거하려면 다음 명령을 실행하십시오. 

```bash
mfpdev server clean
```

그런 다음 대화식 프롬프트에서 정리할 서버를 선택하십시오.   
이렇게 하면 서버 인스턴스가 앱 또는 어댑터가 배치되지 않은 정리된 상태가 됩니다. 

## 애플리케이션 관리
{: #managing-applications }
`mfpdev app <option>` 명령을 사용하여 {{ site.data.keys.product }} SDK로 작성된 애플리케이션을 관리할 수 있습니다. 

### 서버 인스턴스에 애플리케이션 등록
{: #register-an-application-in-a-server-instance }
애플리케이션을 실행할 준비가 된 경우 {{ site.data.keys.mf_server }}에 등록해야 합니다.   
앱을 등록하려면 앱 프로젝트의 루트 폴더에서 다음 명령을 실행하십시오. 

```bash
mfpdev app register
```

Cordova, Android, iOS 또는 Windows 애플리케이션에서 이 명령을 실행할 수 있습니다.   
이는 기본 서버 및 런타임을 사용하여 다음 태스크를 실행합니다. 

* 서버에 애플리케이션을 등록합니다. 
* 애플리케이션의 기본 클라이언트 특성 파일을 생성합니다. 
* 클라이언트 특성 파일에 서버 정보를 저장합니다. 

Cordova 애플리케이션의 경우 이 명령은 config.xml 파일을 업데이트합니다.   
iOS 애플리케이션의 경우 이 명령은 mfpclient.plist 파일을 업데이트합니다.   
Android 또는 Windows 애플리케이션의 경우 이 명령은 mfpclient.properties 파일을 업데이트합니다. 

기본값이 아닌 서버 및 런타임에 앱을 등록하려면 다음 구문을 사용하십시오. 

```
mfpdev app register <server> <runtime>
```

Cordova Windows 플랫폼의 경우 명령에 `-w <platform>` 인수를 추가해야 합니다. `<platform>` 인수는 등록되는 Windows 플랫폼의 쉼표로 구분된 목록입니다. 올바른 값은 `windows`,`windows8` 및 `windowsphone8`입니다. 

```
mfpdev app register -w windows8
```

### 애플리케이션 구성
{: #configure-an-application }
애플리케이션이 등록되면 해당 구성 파일에 서버 관련 속성이 추가됩니다.   
이러한 속성의 값을 변경하려면 다음 명령을 실행하십시오. 

```bash
mfpdev app config
```

이 명령은 변경될 수 있는 속성 목록을 대화식으로 표시하고 새 속성 값에 대한 프롬프트를 표시합니다.   
사용 가능한 속성은 각 플랫폼(iOS, Android, Windows)에 대해 다릅니다. 

사용 가능한 구성은 다음과 같습니다. 

* 애플리케이션이 등록되는 서버 주소 및 런타임

    > **예제 유스 케이스:** 특정 주소를 사용하는 {{ site.data.keys.mf_server }}에 애플리케이션을 등록하지만 다른 서버 주소(예: DataPower 어플라이언스)에도 애플리케이션을 연결하려는 경우 다음을 수행하십시오.

    >
    > 1. `mfpdev app register`를 실행하여 예상 {{ site.data.keys.mf_server }} 주소에 애플리케이션을 등록하십시오. 
    > 2. `mfpdev app config`를 실행하고 DataPower 어플라이언스의 주소와 일치하도록 **서버** 특성 값을 변경하십시오. 또한 **직접 모드**에서 다음 명령을 실행할 수도 있습니다. `mfpdev app config server http(s)://server-ip-or-host:port`



* 직접 업데이트 인증 기능에 사용할 공개 키 설정
* 애플리케이션 기본 언어 설정(기본값: 영어(en))
* 웹 자원 체크섬 테스트의 사용 여부
* 웹 자원 체크섬 테스트 중에 무시할 파일 확장자

<div class="panel-group accordion" id="app-config" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>웹 자원 체크섬 설정에 대한 추가 정보</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>웹 자원 체크섬 설정의 경우 가능한 각 대상 플랫폼(Android, iOS, Windows 8, Windows Phone 8 및 Windows 10 UWP)에는 <b>mfpdev</b> 직접 모드에서 사용할 플랫폼 특정 키가 있습니다. 이러한 키는 플랫폼 이름을 나타내는 문자열로 시작합니다. 예를 들어 <code>windows10_security_test_web_resources_checksum</code>은 Windows10 UWP에 웹 자원 체크섬 테스트를 사용할지 여부를 지정하는 true 또는 false 설정입니다. </p>

                <table class="table table-striped">
                    <tr>
                        <td><b>설정</b></td>
                        <td><b>설명</b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>직접 업데이트 인증에 사용되는 공개 키를 지정합니다. 키는 Base64 형식이어야 합니다. </td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td><code>true</code>로 설정되면 iOS Cordova 앱의 웹 자원 체크섬에 대한 테스트를 사용으로 설정합니다. 기본값은 <code>false</code>입니다. </td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td><code>true</code>로 설정되면 Android Cordova 앱의 웹 자원 체크섬에 대한 테스트를 사용으로 설정합니다. 기본값은 <code>false</code>입니다. </td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td><code>true</code>로 설정되면 Windows 10 UWP Cordova 앱의 웹 자원 체크섬에 대한 테스트를 사용으로 설정합니다. 기본값은 <code>false</code>입니다. </td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td><code>true</code>로 설정되면 Windows 8.1 Cordova 앱의 웹 자원 체크섬에 대한 테스트를 사용으로 설정합니다. 기본값은 <code>false</code>입니다. </td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td><code>true</code>로 설정되면 Windows Phone 8.1 Cordova 앱의 웹 자원 체크섬에 대한 테스트를 사용으로 설정합니다. 기본값은 <code>false</code>입니다. </td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>iOS Cordova 앱의 웹 자원 체크섬 테스트 중에 무시할 파일 확장자를 지정합니다. 확장자가 여러 개인 경우 쉼표로 구분하십시오. 예: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>Android Cordova 앱의 웹 자원 체크섬 테스트 중에 무시할 파일 확장자를 지정합니다. 확장자가 여러 개인 경우 쉼표로 구분하십시오. 예: jpg, gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>Windows 10 UWP Cordova 앱의 웹 자원 체크섬 테스트 중에 무시할 파일 확장자를 지정합니다. 확장자가 여러 개인 경우 쉼표로 구분하십시오. 예: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>Windows 8.1 Cordova 앱의 웹 자원 체크섬 테스트 중에 무시할 파일 확장자를 지정합니다. 확장자가 여러 개인 경우 쉼표로 구분하십시오. 예: jpg,gif,pdf</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>Windows Phone 8.1 Cordova 앱의 웹 자원 체크섬 테스트 중에 무시할 파일 확장자를 지정합니다. 확장자가 여러 개인 경우 쉼표로 구분하십시오. 예: jpg,gif,pdf</td>
                    </tr>
                </table>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>


### Cordova 애플리케이션 미리보기
{: #preview-a-cordova-application }
브라우저를 사용하여 Cordova 애플리케이션의 웹 자원을 미리 볼 수 있습니다. 애플리케이션 미리보기를 통해 고유 플랫폼 특정 에뮬레이터 및 시뮬레이터를 사용할 필요 없이 신속하게 개발할 수 있습니다. 

미리보기 명령을 실행하기 전에 `wlInitOptions` 변수를 추가하여 프로젝트를 준비해야 합니다. 다음 단계를 완료하십시오. 

1. 기본 JavaScript 파일(표준 Cordova 앱의 **index.js**)에 *wlInitOptions* 변수를 추가하십시오. 

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" is the default context root of {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Replace with your own value.
   };
   ```

2. 다음 명령을 사용하여 앱을 다시 등록하십시오. 

   ```bash
   mfpdev app register
   ```

 3. 다음 명령을 실행하십시오. 

    ```bash
    cordova prepare
    ```

 4. Cordova 애플리케이션 루트 폴더에서 다음 명령을 실행하여 Cordova 애플리케이션을 미리 보십시오. 

    ```bash
    mfpdev app preview
    ```

미리 볼 플랫폼 및 사용할 미리보기 유형을 선택하라는 프롬프트가 표시됩니다.
미리보기의 두 가지 옵션은 MBS 및 브라우저입니다. 

* MBS - {{ site.data.keys.mf_mbs }}입니다. 이 메소드는 브라우저에서 모바일 디바이스를 시뮬레이션하고 카메라, 파일 업로드, 위치 정보 등과 같은 기본적인 Cordova API 시뮬레이션을 제공합니다. 참고: Cordova 브라우저를 MBS 옵션과 함께 사용할 수 없습니다. 
* 브라우저 - Simple Browser 렌더링입니다. 이 메소드는 Cordova 애플리케이션의 www 자원을 일반 브라우저 웹 페이지로 표시합니다. 

> 미리보기 옵션에 대한 세부사항은 [Cordova 개발 학습서](../cordova-apps)를 참조하십시오. 

### 직접 업데이트의 웹 자원 업데이트
{: #update-web-resources-for-direct-update }
모바일 디바이스에서 앱을 재설치할 필요 없이 **www** 폴더 내에 있는 Cordova 앱의 웹 자원(예: .html, .css 및 .js 파일)을 업데이트할 수 있습니다. 이는 {{ site.data.keys.product }}에서 제공하는 직접 업데이트 기능을 사용하여 수행 가능합니다. 

> 직접 업데이트의 작업 방식에 대한 세부사항은 [Cordova 애플리케이션에서 직접 업데이트 사용](../direct-update)을 참조하십시오.



Cordova 애플리케이션에서 업데이트할 새 웹 자원 세트를 전송하려면 다음 명령을 실행하십시오. 

```bash
mfpdev app webupdate
```

이 명령은 업데이트된 웹 자원을 .zip 파일로 패키지하고 등록된 기본 {{ site.data.keys.mf_server }}에 업로드합니다. 패키지된 웹 자원은 **[cordova-project-root-folder]/mobilefirst/** 폴더에 있습니다. 

다른 서버 인스턴스에 웹 자원을 업로드하려면 서버 이름 및 런타임을 명령의 일부로 제공하십시오. 

```bash
mfpdev app webupdate <server_name> <runtime>
```

--build 매개변수를 사용하여 서버에 업로드하지 않고 패키지된 웹 자원이 포함된 .zip 파일을 생성할 수 있습니다. 

```bash
mfpdev app webupdate --build
```

이전에 빌드된 패키지를 업로드하려면 --file 매개변수를 사용하십시오. 

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

--encrypt 매개변수를 사용하여 패키지의 컨텐츠를 암호화하는 옵션도 있습니다. 

```bash
mfpdev app webupdate --encrypt
```

### {{ site.data.keys.product_adj }} 애플리케이션 구성 가져오기 및 푸시
{: #pull-and-push-the-mobilefirst-application-configuration }
{{ site.data.keys.mf_server }}에 {{ site.data.keys.product_adj }} 애플리케이션이 등록되면 {{ site.data.keys.mf_server }} 콘솔을 사용하여 애플리케이션 구성 중 일부를 변경한 후에 다음 명령을 사용하여 서버에서 애플리케이션으로 해당 구성을 가져올 수 있습니다. 

```bash
mfpdev app pull
```

또한 애플리케이션 구성을 로컬로 변경하고 다음 명령을 사용하여 {{ site.data.keys.mf_server }}에 변경사항을 푸시할 수 있습니다. 

```bash
mfpdev app push
```

**예제:** {{ site.data.keys.mf_console }}에서 보안 검사에 대한 범위 맵핑을 수행한 후에 위 명령을 사용하여 서버에서 가져올 수 있습니다. 다운로드된 .zip 파일을 프로젝트의 **[루트 디렉토리]/mobilefirst** 폴더에 저장한 후 나중에 `mfpdev app push`와 함께 사용하여 다른 {{ site.data.keys.mf_server }}에 업로드하면 사전정의된 구성을 재사용하여 구성 및 설정을 신속하게 수행할 수 있습니다. 

## 어댑터 관리 및 테스트
{: #managing-and-testing-adapters }
`mfpdev adapter <option>` 명령을 사용하여 어댑터를 관리할 수 있습니다.

> 어댑터에 대해 자세히 알아보려면 [어댑터](../../adapters/) 카테고리의 학습서를 참조하십시오. 


### 어댑터 작성
{: #create-an-adapter }
새 어댑터를 작성하려면 다음 명령을 사용하십시오. 

```bash
mfpdev adapter create
```

그런 다음 프롬프트에서 어댑터의 이름, 유형 및 그룹 ID를 입력하십시오. 

### 어댑터 빌드
{: #build-an-adpater }
어댑터를 빌드하려면 어댑터의 루트 폴더에서 다음 명령을 실행하십시오. 

```bash
mfpdev adapter build
```

이렇게 하면 **<AdapterName>/target** 폴더에 .adapter 파일이 생성됩니다. 

### 어댑터 배치
{: #deploy-an-adapter}
다음 명령은 기본 서버에 어댑터를 배치합니다. 

```bash
mfpdev adapter deploy
```

다른 서버에 배치하려면 다음 명령을 사용하십시오. 

```bash
mfpdev adapter deploy <server_name>
```

### 명령행에서 어댑터 호출
{: #call-an-adapter-from-the-command-line }
어댑터가 배치되면 명령행에서 다음 명령으로 어댑터를 호출하여 동작을 테스트할 수 있습니다. 

```bash
mfpdev adapter call
```

사용할 어댑터, 프로시저 및 매개변수를 제공하라는 프롬프트가 표시됩니다. 명령의 출력은 어댑터 프로시저의 응답입니다. 

> [어댑터 테스트 및 디버깅](../../adapters/testing-and-debugging-adapters/) 학습서에서 자세히 알아보십시오. 

## 유용한 명령
{: #helpful-commands }
mfpdev CLI의 환경 설정(예: 기본 브라우저 및 기본 미리보기 모드)을 설정하려면 다음 명령을 사용하십시오. 

```bash
mfpdev config
```

모든 mfpdev 명령에 대해 설명하는 도움말 컨텐츠를 보려면 다음 명령을 사용하십시오. 

```bash
mfpdev help
```

다음 명령은 환경에 대한 정보가 포함된 목록을 생성합니다. 

```bash
mfpdev info
```

mfpdev CLI 버전을 인쇄하려면 다음 명령을 사용하십시오. 

```bash
mfpdev -v
```

## 명령행 인터페이스 업데이트 및 설치 제거
{: #update-and-uninstall-the-command-line-interface }
명령행 인터페이스를 업데이트하려면 다음 명령을 실행하십시오. 

```bash
npm update -g mfpdev-cli
```

명령행 인터페이스를 설치 제거하려면 다음 명령을 실행하십시오. 

```bash
npm uninstall -g mfpdev-cli
```
