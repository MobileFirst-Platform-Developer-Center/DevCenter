---
layout: tutorial
title: 워크스테이션 설치 안내서
breadcrumb_title: Installation guide
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product }}을 사용한 개발을 위해 워크스테이션을 설정하려면 이 설치 안내서를 따르십시오.

## DevKit 설치 프로그램
{: #devkit-installer }
[{{ site.data.keys.mf_dev_kit }} 설치 프로그램]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst)은 사용할 준비가 된 {{ site.data.keys.mf_server }}, 데이터베이스 및 런타임을 개발자 머신에 설치합니다.  

**전제조건:**  
설치 프로그램을 사용하려면 Java가 설치되어 있어야 합니다.

1. [Oracle의 JRE를 설치](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html)하십시오.

2. JRE를 가리키는 `JAVA_HOME` 변수를 추가하십시오.

    *Mac 및 Linux:* **~/.bash_profile**을 편집하십시오.

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows:*  
    [이 안내서를 따르십시오](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html).

### 설치
{: #installation }
[다운로드 페이지]({{site.baseurl}}/downloads/)에서 DevKit 설치 프로그램을 가져온 후 화면 지시사항을 따르십시오.

![devkit 설치 프로그램](devkit-installer.png)

### 서버 시작 및 중지
{: #starting-and-stopping-the-server }
명령행 창을 열고 압축을 푼 폴더 위치로 이동하십시오.

*Mac 및 Linux:*  

* 서버 시작: `./run.sh -bg`
* 서버 중지: `./stop.sh`

*Windows:*  

* 서버 시작: `./run.cmd -bg`
* 서버 중지: `./stop.cmd`

### {{ site.data.keys.mf_console }}에 액세스
{: #accessing-the-mobilefirst-operations-console }
다음과 같은 방법으로 [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/)에 액세스할 수 있습니다.

* 명령행에서 `mfpdev server console` 실행
* 브라우저에서 [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole) 방문

![콘솔]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
[{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts)는 {{ site.data.keys.mf_server }}에서 애플리케이션을 등록하고 {{ site.data.keys.mf_server }}에서 애플리케이션을 풀/푸시하고 Java 및 JavaScript 어댑터를 작성하고 여러 로컬 및 원격 서버를 관리하고 직접 업데이트를 사용하여 활성 애플리케이션을 업데이트하는 등의 작업을 수행할 수 있게 하는 명령행 인터페이스입니다.

**전제조건:**  
1. {{ site.data.keys.mf_cli }}를 설치하려면 NodeJS와 NPM이 필요합니다.  
 [NodeJS v6.11.1](https://nodejs.org/download/release/v6.11.1/)과 NPM v3.10.10을 다운로드하여 설치하십시오.
 MobileFirst CLI 버전 8.0.2018100112 이상은 Node v8.x 또는 v10.x를 사용하십시오. 

 설치를 확인하려면 명령행 창을 열고 `node -v`를 실행하십시오.

2. 어댑터 작성, 빌드 및 배치 등의 일부 CLI 명령에는 Maven이 필요합니다. 다음 절에서 설치 지시사항을 참조하십시오.

### {{ site.data.keys.mf_cli }} 설치
{: #installation-cli }
터미널을 열고 `npm install -g mfpdev-cli`를 실행하십시오.  

*Mac 및 Linux:* `sudo`를 사용하여 명령을 실행해야 할 수 있습니다.  
[NPM 권한 수정](https://docs.npmjs.com/getting-started/fixing-npm-permissions)에 대해 자세히 읽으십시오.

설치를 확인하려면 명령행 창을 열고 `mfpdev -v` 또는 `mfpdev help`를 실행하십시오.

![콘솔](mfpdev-cli.png)

## 어댑터 및 보안 검사
{: #adapters-and-security-checks }
[어댑터]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) 및 [보안 검사]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security)는 인증 및 기타 보안 계층을 애플리케이션에 도입하는 시작점입니다.

**전제조건:**  
어댑터 및 보안 검사를 작성하려면 먼저 Apache Maven을 설정해야 합니다.  

1. [Apache Maven .zip을 다운로드하십시오](https://maven.apache.org/download.cgi).
2. Maven 폴더를 가리키는 `MVN_PATH` 변수를 추가하십시오.

    *Mac 및 Linux:* **~/.bash_profile**을 편집하십시오.

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows:*  
    [이 안내서를 따르십시오](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/).
`mvn -v`를 실행하여 설치를 확인하십시오.

###  사용법
{: #usage }
Apache Maven이 설치되어 있으니 이제 {{ site.data.keys.mf_cli }}를 사용하거나 Maven 명령행 명령을 통해 어댑터를 작성할 수 있습니다.  
자세한 정보는 [어댑터 학습서]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters)를 검토하십시오.
