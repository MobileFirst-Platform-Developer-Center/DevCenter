---
layout: tutorial
title: 문제점 해결
weight: 6
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #troubleshooting }

IBM Digital App Builder를 사용하는 중에 발생할 수 있는 일부 문제점에 대한 답변을 찾으십시오.

* 오류의 경우 다음을 참조하십시오.

    * 각 플랫폼 폴더 경로의 `log.log` 파일:

        * mac OS에서: `~/Library/Logs/IBM Digital App Builder/log.log`.

        * Windows에서: `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`.

    * `<APP LOCATION>/ibm/applog.log`에서 찾을 수 있는 앱 관련 로그 `applog.log`.

* Swagger 파일을 사용하여 마이크로서비스의 데이터 세트 작성 실패

    빌더를 처음으로 사용하는 사용자는 네트워크 대기 시간으로 인해 마이크로서비스 작성에 실패할 수 있습니다.
    이를 처리하려면 다음 단계를 따르십시오.
    1. 명령 프롬프트를 열고 설치된 앱 위치로 이동하십시오.
    2. `cd ibm\adapterGenerator`
    3. 다음 명령을 실행하십시오.
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. 위의 명령이 성공적으로 실행되면 Digital App Builder에서 마이크로서비스(swagger 파일) 사용을 시작할 수 있습니다.

* Windows에서 앱 미리보기 실패

    Digital App Builder에서 **설정 > 프로젝트 복구**로 이동하고 **종속 항목 다시 빌드** 및 **플랫폼 다시 빌드** 단추를 클릭하십시오.

* Android 앱은 앱에 목록 컴포넌트를 추가한 후에 작동하지 않습니다.

    이는 Android WebView 버전이 68.X.XXXX.XX 미만이기 때문입니다. 이를 해결하려면 Android WebView 버전을 68.X.XXXX.XX 이상으로 업그레이드하십시오.

* MacOS에서 앱 충돌로 인해 Android 시뮬레이터의 앱 미리보기가 실패합니다. 오류는 다음과 같습니다.

    `java.lang.RuntimeException: 애플리케이션 com.ibm.MFPApplication을 작성할 수 없음: java.lang.RuntimeException: 클라이언트 구성 파일 mfpclient.properties를 애플리케이션 자산에서 찾을 수 없음. MFP CLI 명령 'mfpdev app register'를 사용하여 파일을 작성하십시오.`

    이를 해결하려면 터미널에서 앱 ionic 디렉토리로 이동하고 다음 명령을 실행하십시오.

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    그런 다음 Digital App Builder에서 다시 미리보기하십시오.

* Swagger json/yaml 파일을 가져올 때 어댑터를 생성할 수 없습니다.

    Swagger json/yaml 파일을 가져올 때 오류가 발생하며 오류는 Maven 종속 항목 때문입니다.

    존재하지 않는 경우 이상적으로 모든 Maven 종속 항목은 자동으로 다운로드되고 설치됩니다. 그러나 시스템에서 다중 Maven 버전으로 인해 Maven이 실패하는 경우도 있습니다. 이 문제를 해결하려면 해당 단계를 따르십시오.

    a. Aa\pp 위치로 이동하고 OS에 따라 execute.sh / execute.bat 파일을 여십시오. (`<APP_LOCATION>\ibm\adapterGenerator`)

    b. `call %MAVEN_HOME% -U clean install`에 대해 모든 `call %MAVEN_HOME% clean install`을 편집하십시오.

        `-U`를 추가하면 POM 파일을 기반으로 업데이트해야 하는 외부 종속 항목을 확인하도록 maven을 강제 실행합니다.

* 설치된 경우에도 Android Studio에 대한 필수 소프트웨어 확인은 실패합니다.

    경로에서 Android 실행 파일(`<path to android sdk>/tools`)이 있는지 확인하고 필수 소프트웨어를 확인하십시오.

* Windows 7에서 앱 작성 및 문제 미리보기

    `C:`가 아닌 다른 디스크 드라이브 위치에서 새 앱을 작성하려고 하면 오류가 발생할 수 있습니다.

    `C://<your folder name/app name>` 드라이브 아래에서 앱 프로젝트를 작성하십시오.

