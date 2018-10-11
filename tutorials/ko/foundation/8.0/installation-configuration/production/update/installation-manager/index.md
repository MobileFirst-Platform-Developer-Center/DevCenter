---
layout: tutorial
title: 업데이트를 위한 IBM Installation Manager 실행
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 그래픽 모드에서 Installation Manager 실행
{: #graphical-mode}

* 초기 설치 시 사용된 사용자 계정에서 Installation Manager를 실행하십시오.
  업데이트를 적용하려면 Installation Manager는 초기 설치 시 사용된 레지스트리 파일의 동일 목록으로 실행해야 합니다. 설치된 소프트웨어 목록과 설치 중에 사용된 옵션은 해당 레지스트리 파일에 저장됩니다. 관리자 모드에서 Installation Manager를 실행하면 레지스트리 파일이 시스템 레벨에 설치됩니다. Unix 또는 Linux의 경우 `/var` 폴더에 있습니다. Windows의 경우 `c:\ProgramData` 폴더에 있습니다. 위치는 Installation Manager를 실행하는 사용자와 독립적입니다(UNIX 또는 Linux에서는 root가 필요함). 그러나 단일 사용자 모드에서 Installation Manager를 실행하는 경우 레지스트리 파일은 기본적으로 사용자의 홈 디렉토리에 저장됩니다.

* **파일 > 환경 설정**을 선택하십시오.
  기존 IBM MobileFirst Platform Foundation V8.0.0(수정팩 또는 임시 수정사항 적용)을 업데이트할 계획인 경우, 제품 저장소가 필요하지 않습니다.

* **확인**을 클릭하여 **환경 설정** 표시장치를 닫으십시오.

* **업데이트**를 클릭하고 업데이트해야 하는 패키지를 선택하십시오. Installation Manager는 패키지 목록을 표시합니다. 기본적으로 업데이트할 패키지는 IBM MobileFirst Platform Server로 이름이 지정됩니다.

* 라이센스 조항에 동의하고 **다음**을 클릭하십시오.

* **감사** 패널에서 **다음**을 클릭하십시오. 요약이 표시됩니다.

* **업데이트**를 클릭하여 업데이트 프로시저를 시작하십시오.

## 명령행 모드에서 Installation Manager 실행
{: #cli-mode}

1. [여기](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip)에서 자동 설치 파일을 다운로드하십시오.

2. 파일의 압축을 풀고 `8.0/upgrade-initially-mfpserver.xml` 파일을 선택하십시오.
  - V6.0.0, V6.1.0 또는 V6.2.0에 제품을 처음 설치한 경우 대신 `8.0/upgrade-initially-worklightv6.xmlfile`을 선택하십시오.
  - V5.x에 제품을 처음 설치한 경우 대신 이 `8.0/upgrade-initially-worklightv5.xml` 파일을 선택하십시오.
  해당 파일에는 제품의 프로파일 ID가 있습니다. 이 ID의 기본값은 제품 릴리스에 따라 변경됩니다. V5.x에서는 Worklight입니다. V6.0.0, V6.1.0 및 V6.2.0에서는 IBM Worklight입니다. V6.3.0, V7.0.0, V7.1.0 및 V8.0.0에서는 IBM MobileFirst Platform Server입니다.

3. 선택한 파일의 사본을 작성하십시오.

4. 텍스트 편집기 또는 XML 편집기를 사용하여 복사된 XML 파일을 여십시오. 다음 요소를 수정하십시오.

   a. 저장소 목록을 정의하는 저장소 요소입니다. 기존 IBM MobileFirst Platform Foundation V8.0.0(수정팩 또는 임시 수정사항 적용)을 업데이트할 계획이므로 제품 저장소가 필요하지 않습니다.

   b. **선택사항:** 데이터베이스 및 애플리케이션 서버의 비밀번호를 업데이트하십시오.
      Application Center가 Installation Manager를 사용하여 처음 설치되고 데이터베이스 또는 애플리케이션 서버의 비밀번호가 변경되면 XML 파일에서 값을 수정할 수 있습니다. 이 비밀번호는 데이터베이스에 올바른 스키마 버전이 있는지 유효성을 검증하고 V8.0.0 이전 버전인 경우 이를 업그레이드하는 데 사용됩니다. 또한 WebSphere Application Server 전체 프로파일에 Application Center의 설치를 위해 **wsadmin**을 실행하는 데 사용됩니다. XML 파일에서 적절한 행을 다음과 같이 주석 해제하십시오.
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. 2015년 9월 15일 이후에 임시 수정사항으로 릴리스된 토큰 라이센싱을 활성화하기 전에 선택하지 않은 경우, `<data key=’user.licensed.by.tokens’ value=’false’/>` 행을 주석 해제하십시오. Rational License Key Server에서 토큰 라이센싱을 사용하는 계약이 있는 경우에는 값을 **true**로 설정하십시오. 그렇지 않으면, 값을 **false**로 설정하십시오.
      토큰 라이센싱을 활성화하는 경우 Rational License Key Server가 구성되어 있는지 확인하고 MobileFirst Server와 해당 서버가 서비스하는 애플리케이션을 실행하는 충분한 토큰을 얻을 수 있습니다. 그렇지 않으면, MobileFirst Server 관리 애플리케이션 및 런타임 환경을 실행할 수 없습니다.
      > **제한사항:** 토큰 라이센싱을 활성화할지 여부를 결정한 후에는 이를 수정할 수 없습니다. **true** 값을 사용하여 업그레이드를 실행하고 이후에 **false** 값을 사용하여 다른 업그레이드를 실행하면 두 번째 업그레이드는 실패합니다.

    d. 프로파일 ID 및 설치 위치를 검토하십시오. 프로파일 ID 및 설치 위치는 다음과 같이 설치된 프로파일 ID 및 위치와 일치해야 합니다.
      * 다음 행: `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * 및 다음 행: `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Installation Manager에 알려진 프로파일 ID와 설치 디렉토리를 검토하려면 다음 명령을 입력할 수 있습니다.
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. 버전 속성을 업데이트해서 임시 수정사항의 버전으로 설정하십시오.
       예를 들어, 임시 수정사항(8.0.0.0-MFPF-IF20171006-1725)을 설치하는 경우, 다음을 대체하십시오.

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      이를 다음으로 대체하십시오.

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager에서는 설치 파일에 나열된 저장소 뿐만 아니라 환경 설정에 설치된 저장소도 사용합니다. 오퍼링 요소에 버전 속성을 지정하는 것은 선택사항입니다. 하지만 이를 지정하여 정의된 임시 수정사항이 설치하려는 버전인지 확인하십시오. 이 지정은 Installation Manager 환경 설정에 나열된 임시 수정사항으로 다른 저장소를 대체합니다.

5. 초기 설치 시 사용된 사용자 계정으로 세션을 실행하십시오.
    업데이트를 적용하려면 Installation Manager는 초기 설치 시 사용된 레지스트리 파일의 동일 목록으로 실행해야 합니다. 설치된 소프트웨어 목록과 설치 중에 사용된 옵션은 해당 레지스트리 파일에 저장됩니다. 관리자 모드에서 Installation Manager를 실행하면 레지스트리 파일이 시스템 레벨에 설치됩니다. Unix 또는 Linux의 경우 `/var` 폴더에 있습니다. Windows의 경우 `c:\ProgramData` 폴더에 있습니다. 위치는 Installation Manager를 실행하는 사용자와는 독립적입니다(UNIX 또는 Linux에서는 루트가 필요함). 그러나 단일 사용자 모드에서 Installation Manager를 실행하는 경우 레지스트리 파일은 기본적으로 사용자의 홈 디렉토리에 저장됩니다.

6. 다음 명령을 실행하십시오.
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   여기서,
   * <responseFile>은 4단계에서 편집한 XML 파일입니다.
   * *-log /tmp/installwl.log*는 선택사항입니다. Installation Manager 출력에 대한 로그 파일을 지정합니다.
   * *-acceptLicense*는 필수입니다. IBM MobileFirst Platform Foundation V8.0.0의 라이센스 조항에 동의함을 의미합니다. 이 옵션이 없으면 Installation Manager가 업데이트를 계속할 수 없습니다.

## 다음 단계
{: #next-steps }

[애플리케이션 서버 업데이트](../appserver-update)
